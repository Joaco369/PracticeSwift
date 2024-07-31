//
//  ViewController.swift
//  FirebaseUIKit
//
//  Created by Joaquin Villarreal on 23/04/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if(UserDefaults.standard.object(forKey: "sesion") != nil){
            self.next(identifier: "login")
        }
    }

    @IBAction func login(_ sender: UIButton) {
        guard let emailtxt = email.text else { return }
        guard let passtxt = pass.text else { return }
        FirebaseViewModel.shared.login(email: emailtxt, password: passtxt) { done in
            if done{
                UserDefaults.standard.set(true, forKey: "sesion")
                self.next(identifier: "login")
            }
        }
    }
    
    @IBAction func register(_ sender: UIButton) {
        guard let emailtxt = email.text else { return }
        guard let passtxt = pass.text else { return }
        FirebaseViewModel.shared.createUser(email: emailtxt, password: passtxt) { done in
            UserDefaults.standard.set(true, forKey: "sesion")
            self.next(identifier: "login")
        }
    }
    
    func next(identifier: String){
        performSegue(withIdentifier: identifier, sender: self)
    }
}

