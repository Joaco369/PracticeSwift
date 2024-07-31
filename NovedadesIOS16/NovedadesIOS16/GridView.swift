//
//  GridView.swift
//  NovedadesIOS16
//
//  Created by Joaquin Villarreal on 01/07/2024.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        Grid {
            GridRow{
                Color.red
                Color.green
                Color.blue
            }
            GridRow{
                Color.red
                Color.green
                Color.blue
            }
        }
    }
}
