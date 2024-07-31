//
//  ContentView.swift
//  NovedadesIOS15Part2
//
//  Created by Joaquin Villarreal on 07/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showModal = false
    
    var body: some View {
        NavigationView{
            Button("Open Windows"){
                showModal.toggle()
            }.navigationTitle("Window Modal")
                .mediumModal(showModal: $showModal) {
                    Text("Hii Window Modal")
                        .bold()
            }
        }
        .padding()
    }
}

extension View{
    func mediumModal<ModalView: View>(showModal: Binding<Bool>, @ViewBuilder modalView: @escaping () -> ModalView)-> some View{
        return self
            .background(
            
                mediumModalHelper(modalView: modalView(), showModal: showModal)
            )
    }
}

struct mediumModalHelper<ModalView: View>: UIViewControllerRepresentable{
    var modalView: ModalView
    @Binding var showModal: Bool
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> UIViewController {
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showModal{
            let modalController = CustomHostingController(rootView: modalView)
            uiViewController.present(modalController, animated: true) {
                DispatchQueue.main.async {
                    self.showModal.toggle()
                }
            }
        }
    }
}

class CustomHostingController<content: View> : UIHostingController<content>{
    
    override func viewDidLoad() {
        
        if let presentation = presentationController as? UISheetPresentationController {
            presentation.detents = [
                .medium()
            ]
            presentation.prefersGrabberVisible = true
        }
    }
}
