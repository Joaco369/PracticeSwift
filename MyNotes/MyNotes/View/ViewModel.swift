//
//  ViewModel.swift
//  MyNotes
//
//  Created by Joaquin Villarreal on 09/04/2024.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    
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
            print("Se guardo")
            show.toggle()
        } catch let error as NSError {
            print("No se guardo", error.localizedDescription)
        }
    }
    
    func deleteData(item:Notas ,context: NSManagedObjectContext){
        context.delete(item)
        
        do {
            try context.save()
            print("Se elimino")
        } catch let error as NSError {
            print("no se borro", error.localizedDescription)
        }
    }
    
    func sendData(item: Notas){
        updateItem = item
        fecha = item.fecha ?? Date()
        nota = item.nota ?? ""
        show.toggle()
    }
    
    func editData(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
                            
        do {
            try context.save()
            print("Se edito")
            show.toggle()
        } catch let error as NSError {
            print("No se edito")
        }
    }
}

