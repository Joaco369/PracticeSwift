//
//  ContentView.swift
//  ScanTextQR
//
//  Created by Joaquin Villarreal on 13/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            ScannerView().tabItem {
                Label("Scan Text", systemImage: "doc.text.viewfinder")
            }
            QRView().tabItem {
                Label("QR Code", systemImage: "qrcode.viewfinder")
            }
        }
    }
}

#Preview {
    ContentView()
}
