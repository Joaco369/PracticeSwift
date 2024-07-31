//
//  ViewController.swift
//  JSONUIKit
//
//  Created by Joaquin Villarreal on 12/04/2024.
//

import UIKit

class celda: UITableViewCell {
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        ModelViewModel.shared.fetch{ done in
            if done {
                self.table.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelViewModel.shared.datosModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! celda
        let user = ModelViewModel.shared.datosModel.data[indexPath.row]
        cell.name.text = user.first_name
        cell.email.text = user.email
        
        guard let imageURL = URL(string: user.avatar) else { fatalError("Sin imagen") }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                cell.imagen.image = image
            }
        }
        return cell
    }

}

