//
//  CollectionViewController.swift
//  Tables
//
//  Created by Joaquin Villarreal on 07/04/2024.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var list = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self

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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellCollectionView
        let list = list[indexPath.row]
        cell.name.text = list.nombre
        cell.image.image = UIImage(systemName: "person.crop.circle.fill")
        return cell
    }
}

