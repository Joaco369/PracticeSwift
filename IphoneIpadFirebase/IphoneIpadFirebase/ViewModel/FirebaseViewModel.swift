//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Joaquin Villarreal on 15/04/2024.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseViewModel: ObservableObject {
    
    @Published var show = false
    @Published var data = [FireBaseModel]()
    @Published var itemUpdate: FireBaseModel!
    @Published var showEdit = false
    
    func sendData(item: FireBaseModel){
        itemUpdate = item
        showEdit.toggle()
    }
    
    func login(email: String, password: String, completion: @escaping (_ done: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            
            if user != nil {
                print("Entered")
                completion(true)
            }else {
                if let error = error?.localizedDescription {
                    print("Error of FireBase", error)
                } else{
                    print("Error of App")
                }
            }
        }
    }
    
    func createUser(email: String, password: String, completion: @escaping (_ done: Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if user != nil {
                print("Entered and registered")
                completion(true)
            } else if let error = error?.localizedDescription {
                print("Error in FireBase of register", error)
            } else{
                print("Error in the App")
            }
        }
    }
    
    //BASE DE DATOS
    
    //Save
    
    func Save(title: String, desc: String, plataform: String, image: Data, completion: @escaping (_ done: Bool) -> Void){
        
        let storage = Storage.storage().reference()
        let nameImage = UUID()
        let directory = storage.child("imagenes/\(nameImage)")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        directory.putData(image, metadata: metaData) {data, error in
            if error == nil {
                print("Saved image")
                //Save Text
                let db = Firestore.firestore()
                let id = UUID().uuidString
                guard let idUser = Auth.auth().currentUser?.uid else { return }
                guard let email = Auth.auth().currentUser?.email else { return }
                let campos: [String: Any] = ["title":title, "desc":desc, "email":email, "idUser":idUser, "image":String(describing: directory)]
                db.collection(plataform).document(id).setData(campos) {error in
                    if let error = error?.localizedDescription{
                        print("Error to save in Firebase", error)
                    } else {
                        print("saved all")
                        completion(true)
                    }
                }
                
                //End of save Text
            } else {
                if let error = error?.localizedDescription {
                    print("Fail upload Image", error)
                } else{
                    print("Fail the App")
                }
            }
        }
    }
    
    func getData(plataform: String) {
        let db = Firestore.firestore()
        db.collection(plataform).addSnapshotListener { (querySnapshot,error) in
            if let error = error?.localizedDescription {
                print("Error displaying")
            } else{
                self.data.removeAll()
                for document in querySnapshot!.documents {
                    let valor = document.data()
                    let id = document.documentID
                    let title = valor["title"] as? String ?? "No Title"
                    let desc = valor["desc"] as? String ?? "No Description"
                    let image = valor["image"] as? String ?? "No Image"
                    
                    DispatchQueue.main.async {
                        let registros = FireBaseModel(id: id, title: title, desc: desc, image: image)
                        self.data.append(registros)
                    }
                }
            }
        }
    }
    
    func delete(index: FireBaseModel, plataform: String){
        //Delete in Firestore
        let id = index.id
        let db = Firestore.firestore()
        db.collection(plataform).document(id).delete()
        //Delete Storage
        let imagen = index.image
        let deleteImage = Storage.storage().reference(forURL: imagen)
        deleteImage.delete(completion: nil)
    }
    
    func edit(title: String, desc: String, plataform: String, id: String, completion: @escaping (_ done: Bool) -> Void){
        let db = Firestore.firestore()
        let campos: [String: Any] = ["title": title, "desc": desc]
        db.collection(plataform).document(id).updateData(campos) {error in
            if let error = error?.localizedDescription{
                print("Editing Error", error)
            } else {
                print("Edited")
                completion(true)
            }
        }
    }
    //Editar con imagen
    func editWithImage(title: String, desc: String, plataform: String, id: String, index: FireBaseModel, image: Data, completion: @escaping (_ done: Bool) -> Void){
        // Delete Image
        let imagen = index.image
        let deleteImage = Storage.storage().reference(forURL: imagen)
        deleteImage.delete(completion: nil)
        
        //Upload new Image
        let storage = Storage.storage().reference()
        let nameImage = UUID()
        let directory = storage.child("imagenes/\(nameImage)")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        directory.putData(image, metadata: metaData) {data, error in
            if error == nil {
                print("Saved new image")
                //Editing Text
                let db = Firestore.firestore()
                let campos: [String: Any] = ["title": title, "desc": desc, "image": String(describing: directory)]
                db.collection(plataform).document(id).updateData(campos) {error in
                    if let error = error?.localizedDescription{
                        print("Editing Error", error)
                    } else {
                        print("Edited")
                        completion(true)
                    }
                }
                //End of save Text
            } else {
                if let error = error?.localizedDescription {
                    print("Fail upload Image", error)
                } else{
                    print("Fail the App")
                }
            }
        }
    }
}
