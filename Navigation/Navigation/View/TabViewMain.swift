//
//  TabViewMain.swift
//  Navigation
//
//  Created by Joaquin Villarreal on 05/04/2024.
//

import SwiftUI

struct TabViewMain: View {
    var body: some View {
        TabView{
            ContentView().tabItem { Label("Home", systemImage: "house.fill") }
            View2().tabItem { Label("View2", systemImage: "plus") }
            TercerView().tabItem { Label("Camera", systemImage: "camera") }
        }
    }
}
