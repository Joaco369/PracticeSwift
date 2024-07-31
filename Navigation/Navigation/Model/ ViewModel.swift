//
//   ViewModel.swift
//  Navigation
//
//  Created by Joaquin Villarreal on 04/04/2024.
//

import SwiftUI

struct _ViewModel: View {
    
    @Environment (\.presentationMode) var back
    var texto: String
    
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack{
                Text(texto)
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                Button("Close") {
                    back.wrappedValue.dismiss()
                }
            }
        }
    }
}
