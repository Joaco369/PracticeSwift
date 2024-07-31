//
//  ShazamView.swift
//  ShazamLyrics
//
//  Created by Joaquin Villarreal on 17/05/2024.
//

import SwiftUI

struct ShazamView: View {
    
    @StateObject private var shazam = ShazamViewModel()
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Spacer()
                if shazam.recording {
                    ProgressView()
                }
                
                AsyncImage(url: shazam.shazamModel.album) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                } placeholder: {
                    EmptyView()
                }
                
                Text(shazam.shazamModel.title ?? "Don`t Title")
                    .font(.title)
                    .bold()
                Text(shazam.shazamModel.artist ?? "Don`t Artist")
                    .font(.subheadline)
                    .bold()
                Spacer()
                HStack{
                    Button(action: {
                        shazam.startListening()
                    }){
                        Text(shazam.recording ? "Listening" : "Listen")
                    }.buttonStyle(.bordered)
                        .controlSize(.large)
                        .shadow(radius: 4)
                        .tint(.orange)
                }
                Spacer()
                
            }.padding(.all)
                .navigationTitle("Shazam Lyrics")
        }
    }
}
