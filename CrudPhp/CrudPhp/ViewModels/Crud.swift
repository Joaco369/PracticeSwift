//
//  Crud.swift
//  CrudPhp
//
//  Created by Joaquin Villarreal on 23/05/2024.
//

import Foundation
import Alamofire
import UIKit

class Crud: ObservableObject {
    
    @Published var message = ""
    @Published var show = false
    @Published var posts = [Posts]()
    var urlString = ""
    
    func save(title: String, content: String, id: String, edit: Bool){
        
        let parameters: Parameters = [
        
            "title": title,
            "content": content,
            "id": id
        ]
        
        if edit {
            urlString = "http://localhost/project/crud/edit.php"
        } else {
            urlString = "http://localhost/project/crud/save.php"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.main.async { 
            AF.request(url, method: .post, parameters: parameters).responseData { response in
                switch response.result{
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data)
                        let resultJson = json as! NSDictionary
                        guard let res = resultJson.value(forKey: "respuesta") else { return }
                        if res as! String == "success"{
                            self.message = "Post saved with success"
                            self.show = true
                        }else{
                            self.message = "Post dont saved"
                            self.show = true
                        }
                    } catch let error as NSError{
                        print("Error in the JSON", error.localizedDescription)
                        self.message = "Post dont saved"
                        self.show = true
                    }
                    
                case .failure(let error):
                    print(error)
                    self.message = "Post dont saved"
                    self.show = true
                }
            }
        }
    }
    
    func save2(title: String, content: String, image: UIImage){
        let parameters: Parameters = [
            "title": title,
            "content": content
        ]
        
        guard let url = URL(string: "http://localhost/project/crud/save.php") else { return }

        guard let imgData = image.jpegData(compressionQuality: 1.0) else { return }
        let nameImage = UUID().uuidString
        
        
        DispatchQueue.main.async {
            AF.upload(multipartFormData: { MultipartFormData in
                
                MultipartFormData.append(imgData, withName: "image", fileName: "\(nameImage).png", mimeType: "image/png")
                
                for (key, val) in parameters{
                    MultipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
            }, to: url, method: .post).uploadProgress { Progress in
                print(Progress.fractionCompleted * 100)
                
            }.response { response in
                self.message = "Post saved with success"
                self.show = true
            }
        }
    }
    
    func getData(){
        AF.request("http://localhost/project/crud/select.php")
            .responseData { response in
                switch response.result{
                    
                case .success(let data):
                    do {
                        let json = try JSONDecoder().decode([Posts].self, from: data)
                        DispatchQueue.main.async {
                            print(json)
                            self.posts = json
                        }
                    } catch let error as NSError {
                        print("Error to show Json", error.localizedDescription)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func delete(id: String, nameImage: String){
        
        let parameters: Parameters = [

            "id": id,
            "nameImage": nameImage
        ]
        
        guard let url = URL(string: "http://localhost/project/crud/delete.php") else { return }
        
        DispatchQueue.main.async {
            AF.request(url, method: .post, parameters: parameters).responseData { response in
                switch response.result{
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data)
                        let resultJson = json as! NSDictionary
                        guard let res = resultJson.value(forKey: "respuesta") else { return }
                        if res as! String == "success"{
                            self.message = "Post deleted with success"
                            self.show = true
                        }else{
                            self.message = "Post dont delete"
                            self.show = true
                        }
                    } catch let error as NSError{
                        print("Error in the JSON", error.localizedDescription)
                        self.message = "Post dont delete"
                        self.show = true
                    }
                    
                case .failure(let error):
                    print(error)
                    self.message = "Post dont delete"
                    self.show = true
                }
            }
        }
    }
}
