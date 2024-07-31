//
//  AddGoalView.swift
//  CoreDataTwo
//
//  Created by Joaquin Villarreal on 30/04/2024.
//

import SwiftUI

struct AddGoalView: View {
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var model = GoalsViewModel()
    
    var body: some View {
        VStack{
            TextField("Title", text: $model.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Desc", text: $model.desc)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                model.saveData(context: context)
            }){
                Text("Save")
            }
            Spacer()
        }.padding()
    }
}
