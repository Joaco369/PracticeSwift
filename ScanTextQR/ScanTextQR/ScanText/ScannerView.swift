//
//  ScannerView.swift
//  ScanTextQR
//
//  Created by Joaquin Villarreal on 13/06/2024.
//

import SwiftUI

struct ScannerView: View {
    
    @State private var showScan = false
    @State private var texts : [ScanData] = []
    
    func makeScanner() -> Scanner {
        Scanner(completionHandler: { textPage in
            if let outputText = textPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                texts.append(newScanData)
            }
            showScan = false
        })
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                if texts.count > 0{
                    List{
                        ForEach(texts) { text in
                            NavigationLink(destination: ScrollView{
                                Text(text.content)
                                    .multilineTextAlignment(.leading)
                                    .padding()
                            }) {
                                Text(text.content).lineLimit(1)
                            }
                        }
                    }
                } else {
                    Text("There is nothing scanned")
                }
            }.navigationTitle("Scan Document")
                .toolbar{
                    Button{
                        showScan = true
                    } label: {
                        Image(systemName: "doc.text.viewfinder")
                    }.sheet(isPresented: $showScan, content: {
                        makeScanner()
                    })
                }
        }
    }
}

#Preview {
    ScannerView()
}
