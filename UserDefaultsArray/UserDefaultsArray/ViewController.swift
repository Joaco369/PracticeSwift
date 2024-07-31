//
//  ViewController.swift
//  UserDefaultsArray
//
//  Created by Joaquin Villarreal on 08/04/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    
    var array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myArray = UserDefaults.standard.stringArray(forKey: "array"){
            text1.text = myArray[0]
            text2.text = myArray[1]
            text3.text = myArray[2]
        }
    }

    @IBAction func saveAction(_ sender: Any) {
        if text1.text == ""{
            alert(titulo: "Error", message: "Completa todos los campos")
        } else {
            array.append(text1.text ?? "")
            array.append(text2.text ?? "")
            array.append(text3.text ?? "")
            UserDefaults.standard.setValue(array, forKey: "array")
            print("Saved")
        }
    }
    
    func alert(titulo: String, message: String){
        
        let alert = UIAlertController(title: titulo, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}

