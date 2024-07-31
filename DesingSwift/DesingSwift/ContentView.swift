//
//  ContentView.swift
//  DesingSwift
//
//  Created by Joaquin Villarreal on 04/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact{
            compactDesign()
        } else {
            regularDesign()
        }
    }
    
}

struct compactDesign: View {
    
    let numero = "1000000000"
    let message = "hi, how are you?"
    
    func sendMessage() {
        let sms = "sms: \(numero)&body=\(message)"
        guard let stringSMS = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        UIApplication.shared.open(URL.init(string: stringSMS)!)
    }
    
    func sendCall() {
        guard let number = URL(string: "Cel: //\(numero)") else { return }
        UIApplication.shared.open(number)
    }
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            VStack() {
                Image.init(systemName: "person.crop.circle").resizable().frame(width: 130, height: 130, alignment: .center).clipShape(Circle())
                Text("Joaquin Villarreal")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                Text("Aristobulo Del Valle 734")
                    .font(.subheadline).italic()
                    .foregroundStyle(.white)
                HStack {
                    Button(action: {
                        sendCall()
                    }, label: {
                        Image.init(systemName: "phone.fill")
                            .modifier(button(color: .blue))
                    })
                    Button(action: {
                        sendMessage()
                    }, label: {
                        Image.init(systemName: "message.fill")
                            .modifier(button(color: .red))
                    })
                }
            }
        }
    }
}

struct button : ViewModifier {
    
    var color: Color
    
    func body(content: Content) -> some View {
        
        content
            .padding()
            .background(color)
            .clipShape(Circle())
            .foregroundColor(.white)
            .font(.title)
    }
    
    
}

struct regularDesign: View {
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            HStack() {
                Image("fitness").resizable().frame(width: 130, height: 130, alignment: .center).clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Joaquin Villarreal")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    Text("Aristobulo Del Valle 734")
                        .font(.subheadline).italic()
                        .foregroundStyle(.white)
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
