//
//  Model2.swift
//  JSON
//
//  Created by Joaquin Villarreal on 12/04/2024.
//

import Foundation

struct Model2: Decodable {
    var data : [UserList]
}

struct User: Decodable {
    var data: UserList
}

struct UserList: Decodable {
    var id: Int
    var first_name: String
    var email: String
    var avatar: String
}
