//
//  Books.swift
//  BookStore
//
//  Created by Joaquin Villarreal on 14/05/2024.
//

import Foundation
import StoreKit

struct Books: Hashable{
    let id: String
    let title: String
    let description: String
    var lock: Bool
    var price: String?
    let locale: Locale
    
    lazy var formatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.locale = locale
        return nf
    }()
    
    
    init(product: SKProduct, lock: Bool = true) {
        self.id = product.productIdentifier
        self.title = product.localizedTitle
        self.description = product.localizedDescription
        self.lock = lock
        self.locale = product.priceLocale
        
        if lock{
            self.price = formatter.string(from: product.price)
        }
    }
}
