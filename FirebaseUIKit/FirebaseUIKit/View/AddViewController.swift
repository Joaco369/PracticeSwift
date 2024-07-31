//
//  AddViewController.swift
//  FirebaseUIKit
//
//  Created by Joaquin Villarreal on 23/04/2024.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var plataform: UIPickerView!
    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    var imagen = UIImage()
    
    var datos : FirebaseModel?
    
    let plat = ["playstation", "xbox", "nintendo"]
    var consol = "playstation"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.isHidden = true
        
        plataform.delegate = self
        plataform.dataSource = self
        
        if datos == nil{
            self.title = "Add Game"
        } else {
            self.title = "Edit Game"
        }
        
        titulo.text = datos?.titulo
        desc.text = datos?.desc
        consol = datos?.plataforma ?? "playstation"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plat.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plat[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        consol = plat[row]
        print(consol)
    }
    
    @IBAction func updateImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenTomada = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imagen = imagenTomada!
        portada.image = imagen
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        progress.isHidden = false
        progress.startAnimating()
        guard let title = titulo.text else { return }
        guard let descrip = desc.text else { return }
     
        if datos == nil{
            FirebaseViewModel.shared.save(titulo: title, desc: descrip, plataforma: consol, portada: imagen) { done in
                if done{
                    self.titulo.text = ""
                    self.desc.text = ""
                    self.portada.image = UIImage(systemName: "photo")
                    self.progress.isHidden = true
                    self.progress.stopAnimating()
                }
            }
        } else {
            if portada.image == UIImage(systemName: "photo"){
                FirebaseViewModel.shared.edit(titulo: title, desc: descrip, plataforma: consol, id: datos!.id) { done in
                    if done{
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                FirebaseViewModel.shared.editWithImage(titulo: title, desc: descrip, plataforma: consol, id: datos!.id, index: datos!, portada: imagen) { done in
                    if done{
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
