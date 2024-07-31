//
//  DetailViewController.swift
//  Tables
//
//  Created by Joaquin Villarreal on 07/04/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var datosList: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = datosList?.nombre
        email.text = datosList?.email
    }
}
