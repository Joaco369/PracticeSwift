//
//  ShareLinkView.swift
//  NovedadesIOS16
//
//  Created by Joaquin Villarreal on 26/06/2024.
//

import SwiftUI

struct ShareLinkView: View {
    
    let image = Images(image: Image("appstore"))
    
    var body: some View {
        
        ShareLink("Compartir", item: "Un Texto")
        ShareLink("Compartir con Imagen", item: image, preview: SharePreview("Imagen", image: image.image))
        
    }
}

struct Images: Transferable {
    
    var image: Image
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
}
