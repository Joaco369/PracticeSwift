//
//  LocationManager.swift
//  NovedadesIOS15Part2
//
//  Created by Joaquin Villarreal on 13/05/2024.
//

import Foundation
import CoreLocation
import CoreLocationUI
import SwiftUI
import MapKit


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = .init()
    @Published var places: [Places] = []
    @Published var place = ""
    
    override init(){
        super.init()
        manager.delegate = self
    }
    
    func requestLocation(){
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error", error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else { return }
        
        region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        Task.init{
            await searchLocations()
        }
    }
    func searchLocations() async {
        do {
            let request = MKLocalSearch.Request()
            request.region = region
            request.naturalLanguageQuery = self.place
            let query = MKLocalSearch(request: request)
            let response = try await query.start()
            
            await MainActor.run {
                self.places = response.mapItems.compactMap({ item in
                    return Places(mapItem: item)
                })
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

struct Places: Identifiable {
    var id = UUID().uuidString
    var mapItem: MKMapItem
}
