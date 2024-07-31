//
//  ModalViewController.swift
//  VentanaModal
//
//  Created by Joaquin Villarreal on 07/05/2024.
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let presentation = presentationController as? UISheetPresentationController {
            presentation.detents = [
                .medium(),
                .large()
            ]
            
            presentation.prefersGrabberVisible = true
        }
    }
}
