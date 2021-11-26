//
//  ContentView.swift
//  VeeMee
//
//  Based on ContentView.swift by Steven Troughton-Smith on 05/06/2021.
//  Built with help of: https://stackoverflow.com/questions/56645819/how-to-open-file-dialog-with-swiftui-on-platform-uikit-for-mac

import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct MicPreferences: View {
    
    @AppStorage("talkingThreshold") var talkingThreshold = -160.0
    @AppStorage("loudTalkingThreshold") var loudTalkingThreshold = 0.0
    
    var spacer: some View {
        Spacer(minLength: 0)
            .frame(height:UIFloat(32))
    }
    
    var body: some View {
        VStack {
            GroupBox {
                VStack {
                    HStack {
                        Text("Talking threshold:")
                            .frame(width:UIFloat(200), alignment: .trailing)
                        
                        Slider(
                            value: $talkingThreshold,
                            in: -160.0...0,
                            step: 0.5
                        )
                        
                        Text("\(String(talkingThreshold)) dB")
                    }
                    .frame(maxWidth:UIFloat(500))
                    
                    HStack {
                        Text("Loud talking threshold:")
                            .frame(width:UIFloat(200), alignment: .trailing)
                        
                        Slider(
                            value: $loudTalkingThreshold,
                            in: -160.0...0,
                            step: 0.5
                        )
                        
                        Text("\(String(loudTalkingThreshold)) dB")
                    }
                    .frame(maxWidth:UIFloat(500))
                }
                .padding()
            }
        }
    }
}

struct IdlePreferences: View {
    
    @State private var importDialogOpen = false
    @AppStorage("idleImage1") private var idleImage1 = ""
    @AppStorage("idleImage1Bookmark") private var idleImage1Bookmark: Data?
    
    var spacer: some View {
        Spacer(minLength: 0)
            .frame(height:UIFloat(32))
    }
    
    var body: some View {
        VStack {
            GroupBox {
                VStack {
                    HStack {
                        Text("Idle image 1:")
                            .frame(width:UIFloat(200), alignment: .trailing)
                        Button("Select") {
                            importDialogOpen.toggle()
                        }
                        .padding(.horizontal, UIFloat(12))
                        if let idleImage1 = idleImage1 {
                            Image(uiImage: (UIImage(contentsOfFile: idleImage1) ?? UIImage(systemName: "questionmark.folder.fill"))!)
                                .scaledToFit()
                                .frame(width: 100, height: 100, alignment: .center)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .frame(maxWidth:UIFloat(500))
                    .fileImporter(isPresented: $importDialogOpen, allowedContentTypes: [UTType.image], onCompletion: { result in
                        switch result {
                        case .success(let url):
                            idleImage1Bookmark = try? url.bookmarkData(options: .securityScopeAllowOnlyReadAccess)
                            idleImage1 = url.path
                        case .failure(let error):
                            // TODO: handle error
                            print("error: \(error.localizedDescription)")
                        }
                        
                    })
                }
                .padding()
            }
        }
    }
}

struct TalkingPreferences: View {
    
    @State private var importDialogOpen = false
    @AppStorage("talkingImage1") private var talkingImage1 = ""
    @AppStorage("talkingImage1Bookmark") private var talkingImage1Bookmark: Data?
    
    var spacer: some View {
        Spacer(minLength: 0)
            .frame(height:UIFloat(32))
    }
    
    var body: some View {
        VStack {
            GroupBox {
                VStack {
                    HStack {
                        Text("Talking image 1:")
                            .frame(width:UIFloat(200), alignment: .trailing)
                        Button("Select") {
                            importDialogOpen.toggle()
                        }
                        .padding(.horizontal, UIFloat(12))
                        if let talkingImage1 = talkingImage1 {
                            Image(uiImage: (UIImage(contentsOfFile: talkingImage1) ?? UIImage(systemName: "questionmark.folder.fill"))!)
                                .scaledToFit()
                                .frame(width: 100, height: 100, alignment: .center)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .frame(maxWidth:UIFloat(500))
                    .fileImporter(isPresented: $importDialogOpen, allowedContentTypes: [UTType.image], onCompletion: { result in
                        switch result {
                        case .success(let url):
                            talkingImage1Bookmark = try? url.bookmarkData(options: .securityScopeAllowOnlyReadAccess)
                            talkingImage1 = url.path
                        case .failure(let error):
                            // TODO: handle error
                            print("error: \(error.localizedDescription)")
                        }
                        
                    })
                }
                .padding()
            }
        }
    }
}

struct LoudTalkingPreferences: View {
    
    @State private var importDialogOpen = false
    @AppStorage("loudImage1") private var loudImage1 = ""
    @AppStorage("loudImage1Bookmark") private var loudImage1Bookmark: Data?
    
    var spacer: some View {
        Spacer(minLength: 0)
            .frame(height:UIFloat(32))
    }
    
    var body: some View {
        VStack {
            GroupBox {
                VStack {
                    HStack {
                        Text("Loud Talking image 1:")
                            .frame(width:UIFloat(200), alignment: .trailing)
                        Button("Select") {
                            importDialogOpen.toggle()
                        }
                        .padding(.horizontal, UIFloat(12))
                        if let loudImage1 = loudImage1 {
                            Image(uiImage: (UIImage(contentsOfFile: loudImage1) ?? UIImage(systemName: "questionmark.folder.fill"))!)
                                .scaledToFit()
                                .frame(width: 100, height: 100, alignment: .center)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .frame(maxWidth:UIFloat(500))
                    .fileImporter(isPresented: $importDialogOpen, allowedContentTypes: [UTType.image], onCompletion: { result in
                        switch result {
                        case .success(let url):
                            loudImage1Bookmark = try? url.bookmarkData(options: .securityScopeAllowOnlyReadAccess)
                            loudImage1 = url.path
                        case .failure(let error):
                            // TODO: handle error
                            print("error: \(error.localizedDescription)")
                        }
                        
                    })
                }
                .padding()
            }
        }
    }
}

struct PreferencesContentView_Previews: PreviewProvider {
	static var previews: some View {
		MicPreferences()
			.previewLayout(.fixed(width: UIFloat(600), height: UIFloat(480)))
        IdlePreferences()
            .previewLayout(.fixed(width: UIFloat(600), height: UIFloat(480)))
        TalkingPreferences()
            .previewLayout(.fixed(width: UIFloat(600), height: UIFloat(480)))
        LoudTalkingPreferences()
            .previewLayout(.fixed(width: UIFloat(600), height: UIFloat(480)))
	}
}
