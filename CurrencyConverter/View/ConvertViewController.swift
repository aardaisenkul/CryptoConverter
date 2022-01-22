//
//  ConvertViewController.swift
//  CurrencyConverter
//
//  Created by Ali Arda İsenkul on 22.01.2022.
//

import UIKit

class ConvertViewController: UIViewController {

    

    @IBOutlet weak var sourceNum: UITextField!
    @IBOutlet weak var sourceType: UITextField!
    //   @IBOutlet weak var sourceType: UIPickerView!
    
    @IBOutlet weak var convertImage: UIImageView!
    @IBOutlet weak var targetNum: UITextField!
    @IBOutlet weak var targetType: UITextField!
    var picker1 = UIPickerView()
    var picker2 = UIPickerView()
    var cryptoList:[Crypto] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        convertImage.isUserInteractionEnabled = true
        convertImage.addGestureRecognizer(tapGestureRecognizer)
        picker1.delegate = self
        picker2.delegate = self
        sourceNum.delegate = self
        targetNum.delegate = self
        self.cryptoList = CryptoListViewModel.cryptoStaticList
        sourceType.inputView = picker1
        targetType.inputView = picker2
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        sourceNum.text = ""
        sourceType.text = ""
        targetType.text = ""
        targetNum.text = ""
    }
    @objc func imageTapped()
    {
        let obj:Conversion = Conversion(sourceN: Int(sourceNum.text!) ?? 0, SourceT: sourceType.text!, targetT: targetType.text!)
       
        ApiService().convertionProcess(parameter: obj){ (result) in
            
            if let result = result {
                DispatchQueue.main.async {
                    self.targetNum.text = "\(result)"
                }
            }
        }
        // Your action
    }
    @IBAction func asd(_ sender: Any) {
       

    }
    
}
    extension ConvertViewController: UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate  {
        func numberOfComponents(in picker: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return cryptoList.count
        }
        func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return cryptoList[row].name
        }
        func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if picker == picker1{
                sourceType.text = cryptoList[row].name
                sourceType.resignFirstResponder()
            }else{
                targetType.text = cryptoList[row].name
                targetType.resignFirstResponder()
            }
           
        }
        
        //MARK: - to make sure they are consist of numbers
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
                    return string.rangeOfCharacter(from: invalidCharacters) == nil
          }
        
    }
   


