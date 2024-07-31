//
//  ScreenShotView.swift
//  TransferPDF
//
//  Created by Joaquin Villarreal on 31/07/2024.
//

import SwiftUI

struct ScreenShotView: View {
    var body: some View {
        VStack{
            Text("Transfer")
                .font(.title)
                .bold()
                Text("1,200.00")
                    .bold()
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(70)
                    .background(Color.green)
                    .clipShape(Circle())
            Grid(alignment: .leading, horizontalSpacing: 40, verticalSpacing: 10){
                GridRow{
                    Text("Name:").bold()
                    Text("Joaquin Villarreal")
                }
                GridRow{
                    Text("Account:").bold()
                    Text("32132132132")
                }
                GridRow{
                    Text("invoice:").bold()
                    Text("1234")
                }
            }
            .padding(.top, 10)
            Spacer()
        }.padding(.all)
    }
}

#Preview {
    ScreenShotView()
}
