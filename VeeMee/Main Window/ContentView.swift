//
//  ContentView.swift
//  CatalystPrefsWindow
//
//  Created by Angelo Chaves on 2021-11-15.
//  Built with the help of: https://medium.com/swlh/swiftui-create-a-sound-visualizer-cadee0b6ad37

import SwiftUI

struct ContentView: View {
    @ObservedObject private var mic = MicMonitor()
    
    @State private var threshold: CGFloat = 400.0
    @State private var avatar = "zero1"
    
    private func normalizeSoundLevel(_ level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (800 / 25)) // scaled to max at 800 (our height of our bar)
    }
    
    private func selectAvatar(fromThreshold1 threshold1: CGFloat, threshold2: CGFloat) -> String {
        if normalizeSoundLevel(mic.level) <= threshold1 {
            return "zero1"
        } else if normalizeSoundLevel(mic.level) > threshold1 && normalizeSoundLevel(mic.level) <= threshold2 {
            return "zero2"
        } else if normalizeSoundLevel(mic.level) > threshold2 {
            return "zero3"
        } else {
            return "zero1"
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
                Image(selectAvatar(fromThreshold1: threshold, threshold2: 600))
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
