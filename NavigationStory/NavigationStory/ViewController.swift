//
//  ViewController.swift
//  NavigationStory
//
//  Created by Joaquin Villarreal on 05/04/2024.
//

import UIKit

class ViewController: UIViewController {
    
    let hi = "Hi how are you?"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "send" {
            let destino = segue.destination as? SecondViewController
            destino?.saludo = hi
        }
    }

    @IBAction func backToMenu(segue: UIStoryboardSegue){
        print("Regreso al inicio")
    }
}

