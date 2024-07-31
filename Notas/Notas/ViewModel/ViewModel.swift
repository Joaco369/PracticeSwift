//
//  ViewModel.swift
//  Notas
//
//  Created by Joaquin Villarreal on 08/04/2024.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject{
    
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem: Notas!
    
    //CoreData
    func saveData(context: NSManagedObjectContext) {
        
        let newNote = Notas(context: context)
        newNote.nota = nota
        newNote.fecha = fecha

        do {
            try context.save()
            print("Guardo")
            show.toggle()
        } catch let error as NSError {
            print("No guardo", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notas, context: NSManagedObjectContext){
        
        context.delete(item)
    //try! context.save()
        do {
            try context.save()
            print("Se borro")
        } catch let error as NSError {
            print("No se borro", error.localizedDescription)
        }
    }
    
    func sendData(item: Notas){
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    func editData(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("Edito")
            show.toggle()
        } catch let error as NSError {
            print("No edito", error.localizedDescription)
        }
    }
}
