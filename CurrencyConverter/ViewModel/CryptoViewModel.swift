//
//  CryptoViewModel.swift
//  CurrencyConverter
//
//  Created by Ali Arda İsenkul on 22.01.2022.
//

import Foundation

struct CryptoListViewModel {
    let cryptoCurrencyList : [Crypto]
    
    static var cryptoStaticList: [Crypto] = []
    
    func numberOfRowsInSection() -> Int {
        return self.cryptoCurrencyList.count
    }
    
    func cryptoAtIndex(index:Int) -> CryptoViewModel {
        let crypto = self.cryptoCurrencyList[index]
        return CryptoViewModel(cryptoCurrency: crypto)
    }
}

struct CryptoViewModel {
    let cryptoCurrency : Crypto
    
    var name : String {
        return self.cryptoCurrency.name
    }
    var price : String{
        return String(self.cryptoCurrency.value)
    }
}
