//
//  Home.swift
//  IphoneIpadFirebase
//
//  Created by Joaquin Villarreal on 14/04/2024.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @State private var index = "Playstation"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    var body: some View {
        ZStack{
            VStack{
                NavBar(index: $index, menu: $menu)
                ZStack{
                    if index == "Playstation"{
                        ListView(plataform: "playstation")
                    }else if index == "Xbox"{
                        ListView(plataform: "xbox")
                    } else if index == "Nintendo"{
                        ListView(plataform: "nintendo")
                    } else {
                        AddView()
                    }
                }
            }
            //Termina NavBar iPad
            if menu {
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {
                                withAnimation{
                                    menu.toggle()
                                }
                            }){
                                Image(systemName: "xmark")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }.padding()
                            .padding(.top, 50)
                        VStack(alignment: .trailing) {
                            ButtonView(index: $index, menu: $menu, title: "Playstation")
                            ButtonView(index: $index, menu: $menu, title: "Xbox")
                            ButtonView(index: $index, menu: $menu, title: "Nintendo")
                            Button(action: {
                                try! Auth.auth().signOut()
                                UserDefaults.standard.removeObject(forKey: "sesion")
                                loginShow.show = false
                            }){
                                Text("Exit")
                                    .padding(.top, 2)
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title2)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: widthMenu - 200)
                    .background(Color.purple)
                }
            }
        }.background(Color("Background"))
    }
}
