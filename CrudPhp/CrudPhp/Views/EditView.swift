//
//  EditView.swift
//  CrudPhp
//
//  Created by Joaquin Villarreal on 23/05/2024.
//

import SwiftUI

struct EditView: View {
 
    var crudItem: Posts
    @StateObject var crud = Crud()
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        Form{
            TextField("Title", text: $title)
                .onAppear{
                    title = crudItem.title
                }
            TextEditor(text: $content)
                .onAppear{
                    content = crudItem.content
                }
            Button{
                crud.save(title: title, content: content, id: crudItem.id, edit: true)
            } label: {
                Text("Edit Post")
            }
        }
    }
}
