//
//  Image.swift
//  NovedadesiOS15
//
//  Created by Joaquin Villarreal on 06/05/2024.
//

import SwiftUI

struct Image: View {
    var body: some View {
        ZStack{
            AsyncImage(url: URL(string: "https://www.apple.com/la/iphone/home/images/overview/consider_modals/innovation/dd_innovation_iphone__5qtjkfdtj36u_large.jpg")){ image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            Text("Name of the image")
                .font(.title)
                .padding()
                .background(.ultraThinMaterial)
        }
    }
}
