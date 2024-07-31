//
//  SearchViewController.swift
//  Maps
//
//  Created by Joaquin Villarreal on 29/04/2024.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        search.delegate = self
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Error", message: "Location not found", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search.resignFirstResponder()
        guard let searched = search.text else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searched) { (places: [CLPlacemark]?, error) in
            
            if error == nil{
                let place = places?.first
                let anotation = MKPointAnnotation()
                anotation.coordinate = (place?.location?.coordinate)!
                anotation.title = searched
                
                let region = MKCoordinateRegion(center: anotation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
                self.map.setRegion(region, animated: true)
                self.map.addAnnotation(anotation)
                self.map.selectAnnotation(anotation, animated: true)
                
            } else {
                self.showAlert()
            }
        }
    }
}
