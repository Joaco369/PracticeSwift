//
//  GoalsViewModel.swift
//  CoreDataTwo
//
//  Created by Joaquin Villarreal on 30/04/2024.
//

import Foundation
import CoreData

class GoalsViewModel: ObservableObject{
    
    @Published var title = ""
    @Published var desc = ""
    
    func saveData(context: NSManagedObjectContext){
        let newGoal = Goals(context: context)
        newGoal.title = title
        newGoal.desc = desc
        newGoal.id = UUID().uuidString
        
        do {
            try context.save()
            print("Saved")
        } catch let error as NSError {
            print("Dont saved", error.localizedDescription)
        }
    }
    
    func delete(item: Goals, context: NSManagedObjectContext){
        context.delete(item)
        
        do {
            try context.save()
            print("Delete")
        } catch let error as NSError {
            print("Dont Delete", error.localizedDescription)
        }
    }
}

