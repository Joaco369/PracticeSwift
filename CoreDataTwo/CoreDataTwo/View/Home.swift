//
//  Home.swift
//  CoreDataTwo
//
//  Created by Joaquin Villarreal on 30/04/2024.
//

import SwiftUI
import CoreData

struct Home: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Goals.entity(), sortDescriptors: []) var goals: FetchedResults<Goals>
    @ObservedObject var model = GoalsViewModel()
    @State private var search = ""
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $search)
                List{
                    ForEach(goals.filter {
                        search.isEmpty ? true : $0.title!.lowercased().contains(search.lowercased())
                    }){ goal in
                        NavigationLink(destination: TaskView(goal: goal)) {
                        VStack(alignment: .leading){
                                Text(goal.title ?? "").font(.title)
                                Text(goal.desc ?? "").font(.headline)
                            }
                        }
                    }.onDelete(perform: { indexSet in
                        let deleteGoal = goals[indexSet.first!]
                        model.delete(item: deleteGoal, context: context)
                    })
                }
                NavigationLink(destination: AddGoalView()) {
                    Image(systemName: "note")
                }
            }.navigationBarTitle("Goals")
        }
    }
}

