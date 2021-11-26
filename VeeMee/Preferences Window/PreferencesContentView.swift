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
    
    @State var talkingThreshold = -160.0
    @State var loudTalkingThreshold = 0.0
    
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

struct PreferencesContentView2: View {
	
	@State var homepage = "https://www.apple.com"
	
	var newTabOptions = ["Empty Page", "Home Page"]
	@State private var selectedNewTabOption = "Empty Page"
	
	var spacer: some View {
		Spacer(minLength: 0)
			.frame(height:UIFloat(32))
	}
	
	var body: some View {
		VStack {
			GroupBox {
				VStack {
					HStack {
						Text("Homepage:")
							.frame(width:UIFloat(200), alignment: .trailing)
						
						TextField("", text: $homepage)
							.textFieldStyle(RoundedBorderTextFieldStyle())
					}
					.frame(maxWidth:UIFloat(500))
					
					HStack {
						Spacer(minLength: 0)
							.frame(width:UIFloat(200), alignment: .trailing)
						
						Button("Set to Current Page") {
							
						}
						.padding(.horizontal, UIFloat(12))
						Spacer(minLength: 0)
					}
					.frame(maxWidth:UIFloat(500))
					
					spacer
					
					HStack {
						Text("New tabs open with:")
							.frame(width:UIFloat(200), alignment: .trailing)
						
						Picker(selection: $selectedNewTabOption, label:Group{}) {
							ForEach(newTabOptions, id: \.self) {
								Text($0)
							}
						}
					}
					.frame(maxWidth:UIFloat(500))
					
					Spacer(minLength: 0)
					
					Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
						.font(.caption)
					
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.padding()
			}
			.padding()
		}
	}
}

struct PreferencesContentView: View {
	
	@State var first = false
	@State var second = true
	
	var mailboxes = ["Trash", "Junk"]
	@State private var selectedMailbox = "Trash"
	
	var colors = ["Red", "Blue", "Green"]
	@State private var selectedColor = "Red"
	
	var spacer: some View {
		Spacer(minLength: 0)
			.frame(height:UIFloat(32))
	}
	
	var body: some View {
		
		VStack {
			GroupBox {
				VStack(alignment: .leading) {
					Toggle(isOn: $first) {
						Text("Enable junk mail filtering")
						Spacer(minLength: 0)
					}
					
					spacer
					
					Group {
						
						Text("The following types of mail are exempt from junk mail filtering:")
						
						Toggle(isOn: $second) {
							Text("Sender of message is in Contacts")
							Spacer(minLength: 0)
						}
						
						Toggle(isOn: $second) {
							Text("Message is addressed using my full name")
							Spacer(minLength: 0)
						}
					}
					
					spacer
					
					HStack {
						Text("Move currently selected messages into:")
							.frame(minWidth:UIFloat(320), alignment: .leading)
						
						Picker("", selection: $selectedMailbox) {
							ForEach(mailboxes, id: \.self) {
								Text($0)
							}
						}
					}
					
					spacer
					
					Group {
						Text("Please choose a color")
						Picker(selection: $selectedColor, label:Group{}) {
							ForEach(colors, id: \.self) {
								Text($0)
							}
						}
						.pickerStyle(InlinePickerStyle())
					}
					
					spacer
					
					Button("Advanced") {
						
					}
					
					Spacer(minLength: 0)
				}
				.padding()
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
			
			
		}
		.padding()
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
