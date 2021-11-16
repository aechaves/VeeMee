//
//  MicMonitor.swift
//  CatalystPrefsWindow
//
//  Created by Angelo Chaves on 2021-11-15.
//

import Foundation
import AVFoundation

class MicMonitor: ObservableObject {
    
    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?
    private var slowTimer: Timer?

    
    @Published public var level: Float = 0.0
    @Published public var peak: Float = 0.0
    
    deinit {
        audioRecorder.stop()
    }
    
    init() {
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    // TODO: react to this
                }
            }
        }
        
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recorderSettings: [String:Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            
            monitor()
        } catch {
            // TODO handle properly?
            fatalError(error.localizedDescription)
        }

    }
    
    fileprivate func monitor() {
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] (timer) in
            self?.audioRecorder.updateMeters()
            self?.level = self?.audioRecorder.averagePower(forChannel: 0) ?? 0.0
            self?.peak = self?.audioRecorder.peakPower(forChannel: 0) ?? 0.0
        })
        
        slowTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
            self?.audioRecorder.updateMeters()
            self?.peak = self?.audioRecorder.peakPower(forChannel: 0) ?? 0.0
        })
    }
}
