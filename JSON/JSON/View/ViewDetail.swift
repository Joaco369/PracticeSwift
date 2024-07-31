//
//  ViewDetail.swift
//  JSON
//
//  Created by Joaquin Villarreal on 12/04/2024.
//

import SwiftUI

struct ViewDetail: View {
    
    var id: Int
    
    @StateObject var user = ViewDetailModel()
    
    var body: some View {
        VStack{
            if user.avatar.isEmpty {
                ProgressView()
            } else {
                Image(systemName: "person.fill")
                    .data(url: URL(string: user.avatar)!)
                    .frame(width: 130, height: 130)
                    .clipped()
                    .clipShape(Circle())
                Text(user.first_name).font(.largeTitle)
                Text(user.email).font(.title)
            }
            }.onAppear{
                user.fecth(id: id)
            }
        }
    }

