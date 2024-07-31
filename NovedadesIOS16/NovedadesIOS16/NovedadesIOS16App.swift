//
//  NovedadesIOS16App.swift
//  NovedadesIOS16
//
//  Created by Joaquin Villarreal on 26/06/2024.
//

import SwiftUI

@main
struct NovedadesIOS16App: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            Modales()
//            ShareLinkView()
//            GridView()
            Navegacion().environmentObject(returnRoot())
        }
    }
}
