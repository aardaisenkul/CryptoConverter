//
//  ApiService.swift
//  CurrencyConverter
//
//  Created by Ali Arda İsenkul on 21.01.2022.
//

import Foundation

class ApiService {
    let url  = "https://freecurrencyapi.net/api/v2/latest?apikey=f895d8f0-7b0e-11ec-a54b-6b4a7dc9fc83"
    
    func downloadCurrencies(completion: @escaping([Crypto]?) -> ()) {
        var cryptoArray = [Crypto]()
        let _url = URL(string: url)
        URLSession.shared.dataTask(with: _url!) { (data, response, error) in
         
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data {
              
              let cryptoList = try?  JSONDecoder().decode(CryptoCurrency.self, from:data)
                if let cryptoList = cryptoList {
                    for (key, val) in cryptoList.data {
                           let dataType  = Crypto(name: key, value: val )
                        cryptoArray.append(dataType)
                       }
                    completion(cryptoArray)
                }
            }
        }.resume()
    }
    
    func convertionProcess(parameter:Conversion, completion: @escaping (Double?) -> ()){
        let _url = URL(string: url + "&base_currency=\(parameter.SourceT)")
        URLSession.shared.dataTask(with: _url!) { (data, response, error) in
         
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data {
              
              let cryptoList = try?  JSONDecoder().decode(CryptoCurrency.self, from:data)
                if let cryptoList = cryptoList {
                    for (key, val) in cryptoList.data {
                        if(key == parameter.targetT){
                            completion(Double(parameter.sourceN) * val)
                        }
                       }
                  
                }
            }
        }.resume()
    }
}
