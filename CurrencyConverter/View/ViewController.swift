//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ali Arda İsenkul on 21.01.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel : CryptoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        getData()
       
    }
    func getData(){
        ApiService().downloadCurrencies(){ (cryptos) in
           
            if let cryptos = cryptos {
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                CryptoListViewModel.cryptoStaticList = cryptos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell",for: indexPath) as! CryptoTableViewCell
        
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(index: indexPath.row)
        
        cell.priceText.text = cryptoViewModel.price
        cell.currencyText.text = cryptoViewModel.name
        return cell
    }


}
extension UIView {
    
    func addGradient(colors: [UIColor] = [.blue, .white], locations: [NSNumber] = [0, 2], startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0), type: CAGradientLayerType = .axial){
        
        let gradient = CAGradientLayer()
        
        gradient.frame.size = self.frame.size
        gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)

        // Iterates through the colors array and casts the individual elements to cgColor
        // Alternatively, one could use a CGColor Array in the first place or do this cast in a for-loop
        gradient.colors = colors.map{ $0.cgColor }
        
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        
        // Insert the new layer at the bottom-most position
        // This way we won't cover any other elements
        self.layer.insertSublayer(gradient, at: 0)
    }
}
