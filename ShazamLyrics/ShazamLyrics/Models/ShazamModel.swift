//
//  ShazamModel.swift
//  ShazamLyrics
//
//  Created by Joaquin Villarreal on 17/05/2024.
//

import Foundation

struct ShazamModel: Decodable {
    
    let title: String?
    let artist: String?
    let album : URL?
}
