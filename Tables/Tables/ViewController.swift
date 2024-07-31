//
//  ViewController.swift
//  Tables
//
//  Created by Joaquin Villarreal on 07/04/2024.
//

import UIKit

struct List {
    
    let nombre: String
    let email: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var list = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        table.delegate = self
        table.dataSource = self
        
        let list1 = List(nombre: "Joaquin", email: "Joako@hotmail.com")
        let list2 = List(nombre: "Julian", email: "Joako@hotmail.com")
        let list3 = List(nombre: "Tomas", email: "Joako@hotmail.com")
        let list4 = List(nombre: "Fabio", email: "Joako@hotmail.com")
        let list5 = List(nombre: "Sandra", email: "Joako@hotmail.com")
        list.append(list1)
        list.append(list2)
        list.append(list3)
        list.append(list4)
        list.append(list5)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let list = list[indexPath.row]
        cell.textLabel?.text = list.nombre
        cell.detailTextLabel?.text = list.email
        cell.imageView?.image = UIImage(systemName: "person.crop.circle.fill")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "send", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        if segue.identifier == "send" {
            if let id = table.indexPathForSelectedRow {
                let fila = list [id.row]
                let destino = segue.destination as? DetailViewController
                destino?.datosList = fila
            }
        }
    }
    
}

