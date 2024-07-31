//
//  TaskView.swift
//  CoreDataTwo
//
//  Created by Joaquin Villarreal on 30/04/2024.
//

import SwiftUI

struct TaskView: View {
    
    @Environment(\.managedObjectContext) var context
    //@FetchRequest(entity: Tasks.entity(), sortDescriptors: []) var tasks: FetchedResults<Tasks>
    
    var goal: Goals
    var tasks : FetchRequest<Tasks>
    
    init(goal: Goals) {
        self.goal = goal
        tasks = FetchRequest<Tasks>(entity: Tasks.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idGoal == %@", goal.id!))
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(tasks.wrappedValue){ task in
                    NavigationLink(destination: PhotoView(task: task)){
                        VStack(alignment: .leading){
                            Text(task.task ?? "").font(.title)
                        }
                    }
                }
            }
            NavigationLink(destination: AddTaskView(goal: goal)) {
                Image(systemName: "plus")
            }
        }.navigationBarTitle(goal.title ?? "")
    }
}
