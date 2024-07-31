//
//  AddView.swift
//  Notas2
//
//  Created by Joaquin Villarreal on 09/04/2024.
//

import UIKit

class AddView: UIViewController {
    
    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var nota: UITextView!
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var boton: UIButton!
    
    var notas: Notas?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = notas != nil ? "Editar nota" : "Crear nota"
        titulo.text = notas?.titulo
        nota.text = notas?.nota
        fecha.date = notas?.fecha ?? Date()
        if nota == nil {
            validarText()
        } else{
            boton.backgroundColor = .systemTeal
            validarText2()
        }
    }
    @IBAction func botonAction(_ sender: Any) {
        if notas != nil {
            Model.shared.editData(titulo: titulo.text ?? "", nota: nota.text, fecha: fecha.date, notas: notas!)
            navigationController?.popViewController(animated: true)
        } else {
            Model.shared.saveData(titulo: titulo.text ?? "", nota: nota.text, fecha: fecha.date)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func validarText(){
        boton.isEnabled = false
        boton.backgroundColor = .systemGray
        titulo.addTarget(self, action: #selector(validarTextField), for: .editingChanged)
    }
    func validarText2(){
        titulo.addTarget(self, action: #selector(validarTextField), for: .editingChanged)
    }
    
    @objc func validarTextField(sender: UITextField){
        guard let titulo2 = titulo.text, !titulo2.isEmpty else {
            boton.isEnabled = false
            boton.backgroundColor = .systemGray
            return
        }
        boton.isEnabled = true
        boton.backgroundColor = .systemTeal
    }
}
