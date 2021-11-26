//
//  ContentView.swift
//  CatalystPrefsWindow
//
//  Created by Angelo Chaves on 2021-11-15.
//  Built with the help of: https://medium.com/swlh/swiftui-create-a-sound-visualizer-cadee0b6ad37

import SwiftUI

struct ContentView: View {
    @ObservedObject private var mic = MicMonitor()
    
    @State private var avatar = "zero1"
    
    @AppStorage("idleImage1") private var idleImage1 = ""
    @AppStorage("talkingImage1") private var talkingImage1 = ""
    @AppStorage("loudImage1") private var loudImage1 = ""
    @AppStorage("talkingThreshold") var talkingThreshold = -160.0
    @AppStorage("loudTalkingThreshold") var loudTalkingThreshold = 0.0
    
    private func normalizeSoundLevel(_ level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (800 / 25)) // scaled to max at 800 (our height of our bar)
    }
    
    private func selectAvatar(fromThreshold1 threshold1: Double, threshold2: Double) -> String {
        let micLevel = Double(mic.level)
        if micLevel <= threshold1 {
            return idleImage1
        } else if micLevel > threshold1 && micLevel <= threshold2 {
            return talkingImage1
        } else if micLevel > threshold2 {
            return loudImage1
        } else {
            return idleImage1
        }
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("Mic level")
                    .padding()
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.green)
                        .frame(maxWidth: 10, maxHeight: normalizeSoundLevel(mic.level))
                    Rectangle()
                        .opacity(0)
                        .border(Color.black)
                    .frame(maxWidth: 10, maxHeight: 800.0)
                }
            }
            ZStack {
                Image(uiImage: UIImage(contentsOfFile: selectAvatar(fromThreshold1: talkingThreshold, threshold2: loudTalkingThreshold)) ?? UIImage(systemName: "questionmark.folder.fill")!)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
