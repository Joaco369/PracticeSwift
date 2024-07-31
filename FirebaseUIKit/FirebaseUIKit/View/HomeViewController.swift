//
//  HomeViewController.swift
//  FirebaseUIKit
//
//  Created by Joaquin Villarreal on 23/04/2024.
//

import UIKit
import Firebase
import FirebaseStorage

class Celda: UITableViewCell {
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var plataforma: UILabel!
    @IBOutlet weak var desc: UITextView!
    
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabla: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabla.delegate = self
        tabla.dataSource = self
        
        FirebaseViewModel.shared.getData { done in
            if done{
                self.tabla.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseViewModel.shared.datos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! Celda
        let juego = FirebaseViewModel.shared.datos[indexPath.row]
        cell.titulo.text = juego.titulo
        cell.desc.text = juego.desc
        cell.plataforma.text = juego.plataforma
        
        Storage.storage().reference(forURL: juego.portada).getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error?.localizedDescription{
                print("Error upload image", error)
            }else{
                DispatchQueue.main.async {
                    cell.portada.image = UIImage(data: data!)
                    self.tabla.reloadData()
                }
            }
        }
        return cell
    }
    
    //Edit
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "send", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "send"{
            if let id = tabla.indexPathForSelectedRow{
                let fila = FirebaseViewModel.shared.datos[id.row]
                let destino = segue.destination as! AddViewController
                destino.datos = fila
            }
        }
    }
    
    //Delete
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            let juego = FirebaseViewModel.shared.datos[indexPath.row]
            FirebaseViewModel.shared.delete(index: juego)
        }
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    @IBAction func exit(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "sesion")
        dismiss(animated: true)
    }
}
