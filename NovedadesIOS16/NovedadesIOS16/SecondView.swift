//
//  SecondView.swift
//  NovedadesIOS16
//
//  Created by Joaquin Villarreal on 01/07/2024.
//

import SwiftUI

struct SecondView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .navigationTitle("Second View")
        NavigationLink("Tercer vista", value: 1234)
            .navigationDestination(for: Int.self) { val in
                TercerView(text: val)
            }
    }
}
