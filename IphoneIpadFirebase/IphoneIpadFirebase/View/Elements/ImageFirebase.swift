//
//  ImageFirebase.swift
//  IphoneIpadFirebase
//
//  Created by Joaquin Villarreal on 17/04/2024.
//

import SwiftUI

struct ImageFirebase: View {
    
    //Añadiendo imagen y llamandola
    
    let imageAlternative = UIImage(systemName: "photo")
    @ObservedObject var imageLoader: ImageViewModel
    
    init(imageUrl: String){
        imageLoader = ImageViewModel(imageUrl: imageUrl)
    }
    
    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: (image ?? imageAlternative)!)
            .resizable()
            .cornerRadius(20)
            .shadow(radius: 5)
            .aspectRatio(contentMode: .fit)
    }
}
