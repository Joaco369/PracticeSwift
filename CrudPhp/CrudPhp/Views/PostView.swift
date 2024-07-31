//
//  PostView.swift
//  CrudPhp
//
//  Created by Joaquin Villarreal on 23/05/2024.
//

import SwiftUI

struct PostView: View {
    
    @StateObject var crud = Crud()
    @State private var title = ""
    @State private var content = ""
    
    @State private var showImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    var body: some View {
        Form{
            TextField("Title", text: $title)
            TextEditor(text: $content)
            Button {
                crud.save(title: title, content: content, id: "", edit: false)
                title = ""
                content = ""
            } label: {
                Text("Save Post")
            }
            .alert(crud.message, isPresented: $crud.show) {
                Button("accept", role: .none) {}
            }
            image?
                .resizable()
                .scaledToFit()
            
        }.navigationTitle("High Post")
                .toolbar {
                    Button {
                        showImagePicker = true
                    } label: {
                        Image(systemName: "camera")
                    }
                }
                .onChange(of: inputImage) { _ in
                    loadImage()
                }.sheet(isPresented: $showImagePicker){
                    ImagePicker(image: $inputImage)
                }
        
    }
}
