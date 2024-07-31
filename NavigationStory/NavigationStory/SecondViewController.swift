//
//  SecondViewController.swift
//  NavigationStory
//
//  Created by Joaquin Villarreal on 05/04/2024.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    
    var saludo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        result.text = saludo
    }

    @IBAction func backAction(_ sender: Any) {
        //dismiss(animated: true)
        
        navigationController?.popViewController(animated: true)
    }
}
