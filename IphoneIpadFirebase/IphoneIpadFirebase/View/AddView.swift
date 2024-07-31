//
//  AddView.swift
//  IphoneIpadFirebase
//
//  Created by Joaquin Villarreal on 16/04/2024.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct AddView: View {
    
    @State private var title = ""
    @State private var desc = ""
    var consoles = ["playstation", "xbox", "nintendo"]
    @State private var plataform = "playstation"
    @StateObject var save = FirebaseViewModel()
    
    @State var imageData : Data = .init(capacity: 0)
    @State var mostrarMenu = false
    @State var imagePicker = false
    @State var source: UIImagePickerController.SourceType = .camera
    
    @State var progress = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.orange.edgesIgnoringSafeArea(.all)
                VStack{
                    NavigationLink(destination: ImagePicker(show: $imagePicker, image: $imageData, source: source), isActive: $imagePicker){
                        EmptyView()
                    }.navigationBarHidden(true)
                    
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextEditor(text: $desc)
                        .frame(height: 200)
                    Picker("Consoles", selection: $plataform) {
                        ForEach(consoles, id:\.self) { item in
                            Text(item)
                        }
                        .pickerStyle(DefaultPickerStyle())
                            .foregroundColor(.black)
                            .font(.title)
                    }
                    Button(action: {
                        mostrarMenu.toggle()
                    }){
                        Text("Upload Image")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .bold()
                    }.actionSheet(isPresented: $mostrarMenu, content: {
                        ActionSheet(title: Text("Menu"), message: Text("Select an option"), buttons: [
                            .default(Text("Camera"), action: {
                                source = .camera
                                imagePicker.toggle()
                            }),
                            .default(Text("Galery"), action: {
                                source = .photoLibrary
                                imagePicker.toggle()
                            }),
                            .default(Text("Cancel"))
                        ])
                    })
                    
                    if imageData.count != 0{
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .frame(width: 250, height: 250)
                            .cornerRadius(15)
                        
                        Button(action: {
                            progress = true
                            save.Save(title: title, desc: desc, plataform: plataform, image: imageData) { done in
                                if done {
                                    title = ""
                                    desc = ""
                                    imageData = .init(capacity: 0)
                                    progress = false
                                }
                            }
                        }){
                            Text("Save")
                                .foregroundColor(.black)
                                .bold()
                                .font(.largeTitle)
                        }
                        if progress{
                            Text("Waiting please...").foregroundColor(.white)
                            ProgressView()
                        }
                    }
                    Spacer()
                    
                }.padding(.all)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
