//
//  Scanner.swift
//  ScanTextQR
//
//  Created by Joaquin Villarreal on 13/06/2024.
//

import Foundation
import SwiftUI
import VisionKit

struct Scanner: UIViewControllerRepresentable {
    typealias UIViewControllerType = VNDocumentCameraViewController
    
    let completionHandler: ([String]?) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completionHandler: completionHandler)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    init(completionHandler: @escaping ([String]?) -> Void) {
        self.completionHandler = completionHandler
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate{
        let completionHandler: ([String]?) -> Void
        
        init(completionHandler: @escaping ([String]?) -> Void) {
            self.completionHandler = completionHandler
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizerText(completionHandler: completionHandler)
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: any Error) {
            completionHandler(nil)
        }
    }
}
