//
//  PhotoView.swift
//  CoreDataTwo
//
//  Created by Joaquin Villarreal on 06/05/2024.
//

import SwiftUI


struct PhotoView: View {
    
    @Environment(\.managedObjectContext) var context
    
    var task: Tasks
    var photos: FetchRequest<Photos>
    
    init(task: Tasks) {
        self.task = task
        photos = FetchRequest<Photos>(entity: Photos.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idTask == %@", task.id!))
    }
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    let gridItem : [GridItem] = Array(repeating: .init(.flexible(maximum: 100)), count: 3)
    
    func save(image: Data){
        let newPhoto = Photos(context: context)
        newPhoto.photo = image
        newPhoto.idTask = task.id
        task.mutableSetValue(forKey: "relationToPhoto").add(newPhoto)
        
        do {
            try context.save()
            print("Saved")
        } catch let error as NSError {
            print("Dont Saved", error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: ImagePicker(show: self.$imagePicker, image: self.$imageData, source: self.source), isActive: self.$imagePicker) {
                    Text("")
                }.navigationBarTitle("")
                    .navigationBarHidden(true)
                
                ScrollView(){
                    LazyVGrid(columns: gridItem, spacing: 10){
                        ForEach(photos.wrappedValue){ photo in
                            Image(uiImage: UIImage(data: photo.photo ?? Data())!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                
                HStack(alignment: .center, spacing: 60){
                    Button(action:{
                        self.mostrarMenu.toggle()
                    }){
                        Image(systemName: "camera")
                    }.actionSheet(isPresented: self.$mostrarMenu) {
                        ActionSheet(title: Text("Menu"), message: Text("selected an option"), buttons: [
                            .default(Text("Camera"), action: {
                                self.source = .camera
                                self.imagePicker.toggle()
                            }),
                            .default(Text("Librery"), action: {
                                self.source = .photoLibrary
                                self.imagePicker.toggle()
                            }),
                            .default(Text("Cancel"))
                        ])
                    }
                    
                    Button(action: {
                        save(image: imageData)
                    }){
                        Text("Save image")
                    }
                }
            }
        }
    }
}

