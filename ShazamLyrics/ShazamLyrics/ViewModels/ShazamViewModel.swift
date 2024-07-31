//
//  ShazamViewModel.swift
//  ShazamLyrics
//
//  Created by Joaquin Villarreal on 17/05/2024.
//
import ShazamKit
import AVKit
import SwiftUI

class ShazamViewModel: NSObject, ObservableObject{
    
    @Published var shazamModel = ShazamModel(title: "press", artist: "listen", album: URL(string: "https://google.com"))
    @Published var recording = false
    
    private var audioEngine = AVAudioEngine()
    private var session = SHSession()
    private var signatureGenerator = SHSignatureGenerator()
    
    
    override init() {
        super.init()
        session.delegate = self
        print("ShazamViewModel initialized")
    }
    
    func startListening(){
        guard !audioEngine.isRunning else {
            print("Audio engine already running, stopping it")
            audioEngine.stop()
            DispatchQueue.main.async {
                self.recording = true
            }
            return
        }
        let audioSession = AVAudioSession.sharedInstance()
        AVAudioApplication.requestRecordPermission { granted in
            guard granted else { return }
            print("Permission to record not granted")
            
            do{
                try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                let inputNode = self.audioEngine.inputNode
                let recordingFormat = inputNode.outputFormat(forBus: 0)
                
                inputNode.removeTap(onBus: .zero)
                inputNode.installTap(onBus: .zero, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                    self.session.matchStreamingBuffer(buffer, at: nil)
                    
                }
                self.audioEngine.prepare()
                try self.audioEngine.start()
                
                
                DispatchQueue.main.async {
                    self.recording = true
                    print("Recoding success")
                }
                
            } catch let error as NSError{
                print("Error activating audio session or starting audio engine: \(error.localizedDescription)")
            }
        }
    }
    
    func stop(){
        if audioEngine.isRunning {
            audioEngine.stop()
            DispatchQueue.main.async {
                self.recording = false
            }
        }
    }
}

extension ShazamViewModel: SHSessionDelegate{
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        let mediaItems = match.mediaItems
        if let item = mediaItems.first{
            DispatchQueue.main.async {
                self.shazamModel = ShazamModel(title: item.title, artist: item.artist, album: item.artworkURL)
                print("Match found: \(item.title ?? "Unknown") by \(item.artist ?? "Unknown")")
                if ((self.shazamModel.album?.isFileURL) != nil) {
                    self.stop()
                }
            }
        }
    }
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
            if let error = error {
                print("No match found: \(error.localizedDescription)")
            } else {
                print("No match found")
            }
        }
}
