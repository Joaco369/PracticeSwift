//
//  EditView.swift
//  IphoneIpadFirebase
//
//  Created by Joaquin Villarreal on 22/04/2024.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct EditView: View {
    
    @State private var title = ""
    @State private var desc = ""
    var plataform : String
    var datos: FireBaseModel
    @StateObject var save = FirebaseViewModel()
    
    @State var imageData : Data = .init(capacity: 0)
    @State var mostrarMenu = false
    @State var imagePicker = false
    @State var source: UIImagePickerController.SourceType = .camera
    
    @State var progress = false
    @Environment(\.presentationMode) var presentationMode
    
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
                        .onAppear{
                            title = datos.title
                        }
                    TextEditor(text: $desc)
                        .frame(height: 200)
                        .onAppear{
                            desc = datos.desc
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
                    }
                    Button(action: {
                        save.edit(title: title, desc: desc, plataform: plataform, id: datos.id) { done in
                            if done{
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                progress = true
                                save.editWithImage(title: title, desc: desc, plataform: plataform, id: datos.id, index: datos, image: imageData) { done in
                                    if done{
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                        }
                    }){
                        Text("Edit")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }
                    if progress{
                        Text("Waiting please...").foregroundColor(.white)
                        ProgressView()
                    }
                    
                    Spacer()
                }.padding(.all)
            }.navigationViewStyle(StackNavigationViewStyle())
                .onAppear{
                    print(datos)
                }
        }
    }
}
