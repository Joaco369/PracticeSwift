//
//  Mapa.swift
//  NovedadesIOS15Part2
//
//  Created by Joaquin Villarreal on 07/05/2024.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

struct Mapa: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            
            Map( coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: locationManager.places, annotationContent: { place in
                MapMarker(coordinate: place.mapItem.placemark.coordinate, tint: .purple)
            })
                //.mapStyle(.standard(elevation: .realistic))
                .ignoresSafeArea()
            
            HStack{
                TextField("Search", text: $locationManager.place)
                    .textFieldStyle(.roundedBorder)
                LocationButton{
                    locationManager.requestLocation()
                }
                .labelStyle(.iconOnly)
                .symbolVariant(.fill)
                .foregroundColor(.white)
                .tint(.green)
                .clipShape(Circle())
                .padding()
                
            }.padding(.all)
        }
    }
}
