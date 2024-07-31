//
//  Model1.swift
//  JSON
//
//  Created by Joaquin Villarreal on 12/04/2024.
//

import Foundation

struct Model1: Decodable {
    var id: Int
    var name: String
    var email: String
    var address: Address
}

struct Address: Decodable {
    var street: String
    var geo: Geo
}

struct Geo: Decodable {
    var lat: String
}
