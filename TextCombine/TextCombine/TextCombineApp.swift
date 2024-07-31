//
//  TextCombineApp.swift
//  TextCombine
//
//  Created by Joaquin Villarreal on 08/04/2024.
//

import SwiftUI

@main
struct TextCombineApp: App {
    
    var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
