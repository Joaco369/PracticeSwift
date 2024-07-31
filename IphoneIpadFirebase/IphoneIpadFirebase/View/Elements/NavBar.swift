//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by Joaquin Villarreal on 14/04/2024.
//

import SwiftUI
import Firebase

struct NavBar: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index: String
    @Binding var menu: Bool
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    var body: some View {
        HStack{
            Text("My Games")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
            if device == .pad {
                HStack(spacing: 25){
                    ButtonView(index: $index, menu: $menu, title: "Playstation")
                    ButtonView(index: $index, menu: $menu, title: "Xbox")
                    ButtonView(index: $index, menu: $menu, title: "Nintendo")
                    ButtonView(index: $index, menu: $menu, title: "Add")
                    Button(action: {
                        try! Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "sesion")
                        loginShow.show = false
                    }){
                        Text("Exit")
                            .font(.title)
                            .frame(width: 200)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                    }.background(
                        Capsule()
                            .stroke(Color.white)
                    )
                }
            } else {
                //Menu iPhone
                Button(action: {
                  index = "Add"
                }){
                    Image(systemName: "plus")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
                Button(action: {
                    withAnimation{
                        menu.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
            }
        }.padding(.top, 30)
        .padding()
            .background(Color.purple)
    }
}
