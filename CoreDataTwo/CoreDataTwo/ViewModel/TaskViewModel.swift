//
//  TaskViewModel.swift
//  CoreDataTwo
//
//  Created by Joaquin Villarreal on 30/04/2024.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject{
    
    @Published var task = ""
    
    func saveData(context: NSManagedObjectContext, goal: Goals){
        let newTask = Tasks(context: context)
        newTask.task = task
        newTask.id = UUID().uuidString
        newTask.idGoal = goal.id
        
        goal.mutableSetValue(forKey: "relationToTask").add(newTask)
        
        do {
            try context.save()
            print("Saved")
        } catch let error as NSError {
            print("Dont saved", error.localizedDescription)
        }
    }
}
