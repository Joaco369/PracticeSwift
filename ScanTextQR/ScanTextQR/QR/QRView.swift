//
//  QRView.swift
//  ScanTextQR
//
//  Created by Joaquin Villarreal on 13/06/2024.
//

import SwiftUI
import CodeScanner

struct QRView: View {
    
    @State private var showScan = false
    @State private var qrText = "Scan QR"
    
    func scan(result: Result<ScanResult, ScanError>){
        showScan = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "")
            qrText = details[0]
        case .failure(let error):
            print("Fail the Scanning",error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Button{
                    showScan = true
                } label: {
                    Text("Scan")
                }.sheet(isPresented: $showScan) {
                    CodeScannerView(codeTypes: [.qr], completion: scan)
                }
                Text(qrText)
                
            }.navigationTitle("Scan QR")
        }
    }
}
#Preview {
    QRView()
}
