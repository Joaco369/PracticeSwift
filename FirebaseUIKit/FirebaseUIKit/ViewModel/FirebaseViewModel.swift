//
//  FirebaseViewModel.swift
//  FirebaseUIKit
//
//  Created by Joaquin Villarreal on 23/04/2024.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseViewModel{
    
    var datos = [FirebaseModel]()
    
    public static let shared = FirebaseViewModel()
    
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
    func save(titulo:String, desc:String, plataforma:String, portada:UIImage, completion: @escaping (_ done: Bool) -> Void ){
        
        let storage = Storage.storage().reference()
        let nombrePortada = UUID()
        let directorio = storage.child("imagenes/\(nombrePortada)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directorio.putData(portada.pngData()!, metadata: metadata){data,error in
            if error == nil {
                print("guardo la imagen")
                // GUARDAR TEXTO
                let db = Firestore.firestore()
                let id = UUID().uuidString
                guard let idUser = Auth.auth().currentUser?.uid else { return  }
                guard let email = Auth.auth().currentUser?.email else { return  }
                let campos : [String:Any] = ["titulo":titulo,"desc":desc,"portada":String(describing: directorio),"idUser":idUser,"email":email, "plataforma":plataforma]
                db.collection("juegos").document(id).setData(campos) {error in
                    if let error = error?.localizedDescription{
                        print("error al guardar en firestore", error)
                    }else{
                        print("guardo todo")
                        completion(true)
                    }
                }
                
                // TERMINO DE GUARDAR TEXTO
            }else{
                if let error = error?.localizedDescription {
                    print("fallo al subir la imagen en storage", error)
                }else{
                    print("fallo la app")
                }
            }
        }
    }
    // Show Data
    func getData(completion: @escaping (_ done: Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("juegos").addSnapshotListener { (querySnapshot, error) in
            if let error = error?.localizedDescription {
                print("Error displaying")
            } else{
                self.datos.removeAll()
                for document in querySnapshot!.documents {
                    let valor = document.data()
                    let id = document.documentID
                    let titulo = valor["titulo"] as? String ?? "No Title"
                    let desc = valor["desc"] as? String ?? "No Description"
                    let portada = valor["portada"] as? String ?? "No Image"
                    let plataforma = valor["plataforma"] as? String ?? "No exist"
                    DispatchQueue.main.async {
                        let registros = FirebaseModel(id: id, titulo: titulo, desc: desc, portada: portada, plataforma: plataforma)
                        self.datos.append(registros)
                        completion(true)
                    }
                }
            }
        }
    }
    
    //Delete
    
    func delete(index: FirebaseModel){
        //Delete in Firestore
        let id = index.id
        let db = Firestore.firestore()
        db.collection("juegos").document(id).delete()
        //Delete Storage
        let imagen = index.portada
        let deleteImage = Storage.storage().reference(forURL: imagen)
        deleteImage.delete(completion: nil)
    }
    
    // Edit
    
    func edit(titulo: String, desc: String, plataforma: String, id: String, completion: @escaping (_ done: Bool) -> Void){
        let db = Firestore.firestore()
        let campos: [String: Any] = ["titulo": titulo, "desc": desc, "plataforma": plataforma]
        db.collection("juegos").document(id).updateData(campos) {error in
            if let error = error?.localizedDescription{
                print("Editing Error", error)
            } else {
                print("Edited")
                completion(true)
            }
        }
    }
    //Editar con imagen
    func editWithImage(titulo: String, desc: String, plataforma: String, id: String, index: FirebaseModel, portada: UIImage, completion: @escaping (_ done: Bool) -> Void){
        // Delete Image
        let imagen = index.portada
        let deleteImage = Storage.storage().reference(forURL: imagen)
        deleteImage.delete(completion: nil)
        
        //Upload new Image
        let storage = Storage.storage().reference()
        let nameImage = UUID()
        let directory = storage.child("imagenes/\(nameImage)")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
    
        directory.putData(portada.pngData()!, metadata: metaData) {data, error in
            if error == nil {
                print("Saved new image")
                //Editing Text
                let db = Firestore.firestore()
                let campos: [String: Any] = ["titulo": titulo, "desc": desc, "portada": String(describing: directory), "plataforma":plataforma]
                db.collection("juegos").document(id).updateData(campos) {error in
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
