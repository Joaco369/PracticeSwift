//
//  AddView.swift
//  MyNotes
//
//  Created by Joaquin Villarreal on 09/04/2024.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var model: ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(model.updateItem != nil ? "Edit note" : "Add note")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $model.nota)
            Divider()
            DatePicker("Seleccioanar Fecha", selection: $model.fecha)
            Spacer()
            Button(action: {
                if model.updateItem != nil{
                    model.editData(context: context)
                } else{
                    model.saveData(context: context)
                }
            }){
                Label(
                    title: { Text("Save").foregroundColor(.white).bold() },
                    icon: { Image(systemName: "plus").foregroundColor(.white) }
                )
            }.padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(model.nota == "" ? Color.gray : Color.blue)
                .cornerRadius(8)
                .disabled(model.nota == "" ? true : false)
            
            
        }.padding()
    }
}
