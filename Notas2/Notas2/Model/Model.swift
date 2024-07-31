//
//  Model.swift
//  Notas2
//
//  Created by Joaquin Villarreal on 09/04/2024.
//

import Foundation
import CoreData
import UIKit

class Model {
    
    public static let shared = Model()
    
    func context() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    func saveData(titulo: String, nota: String, fecha: Date){
        
        let context = context()
        let entityNotes = NSEntityDescription.insertNewObject(forEntityName: "Notas", into: context) as! Notas
        entityNotes.titulo = titulo
        entityNotes.nota = nota
        entityNotes.fecha = fecha
        
        do {
            try context.save()
            print("guardo")
        } catch let error as NSError {
            print("No guardo", error.localizedDescription)
        }
    }
    func editData(titulo: String, nota: String, fecha: Date, notas: Notas){
        
        let context = context()
        notas.setValue(titulo, forKey: "titulo")
        notas.setValue(nota, forKey: "nota")
        notas.setValue(fecha, forKey: "fecha")
        
        do {
            try context.save()
            print("Edito")
        } catch let error as NSError {
            print("No Edito", error.localizedDescription)
        }
    }
}
