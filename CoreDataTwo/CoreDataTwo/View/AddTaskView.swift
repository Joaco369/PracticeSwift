//
//  AddTaskView.swift
//  CoreDataTwo
//
//  Created by Joaquin Villarreal on 30/04/2024.
//

import SwiftUI

struct AddTaskView: View {
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var model = TaskViewModel()
    
    var goal: Goals
    
    var body: some View {
        VStack{
            TextField("Task", text: $model.task)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                model.saveData(context: context, goal: goal)
            }){
                Text("Save")
            }
        }
    }
}
