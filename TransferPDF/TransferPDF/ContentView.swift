//
//  ContentView.swift
//  TransferPDF
//
//  Created by Joaquin Villarreal on 31/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var renderImage: Image?
    @State private var renderPDF: URL?
    
    @MainActor func render(){
        let renderer = ImageRenderer(content: ScreenShotView())
        if let image = renderer.uiImage {
            renderImage = Image(uiImage: image)
        }
        
        //pdf
        let temprUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let renderUrl = temprUrl.appending(path: "\(UUID().uuidString).pdf")
        
        if let consumer = CGDataConsumer(url: renderUrl as CFURL), let context = CGContext(consumer: consumer, mediaBox: nil, nil) {
            renderer.render { size, renderer in
                var mediaBox = CGRect(origin: .zero, size: size)
                context.beginPage(mediaBox: &mediaBox)
                renderer(context)
                context.endPDFPage()
                context.closePDF()
                
                renderPDF = renderUrl
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                ScreenShotView()
            }.toolbar{
                HStack {
                    if let renderImage{
                        ShareLink(item: renderImage, preview: SharePreview("Transfer")) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    if let renderPDF{
                        ShareLink(item: renderPDF, preview: SharePreview("Transfer")) {
                            Image(systemName: "arrow.up.doc")
                        }
                    }

                }
            }
        }.onAppear{
            DispatchQueue.main.async {
                render()
            }
        }
    }
}

#Preview {
    ContentView()
}
