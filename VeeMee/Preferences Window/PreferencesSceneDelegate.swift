//
//  PreferencesSceneDelegate.swift
//  CatalystPrefsWindow
//
//  Created by Steven Troughton-Smith on 05/06/2021.
//

import UIKit
import SwiftUI

class PreferencesSceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		
		
		// Use a UIHostingController as window root view controller.
		if let windowScene = scene as? UIWindowScene {
			
			if let delegate = UIApplication.shared.delegate as? AppDelegate {
				delegate.preferencesSceneSession = session
			}
			
			let window = UIWindow(windowScene: windowScene)

			window.backgroundColor = .secondarySystemBackground
			
			let fixedSize = CGSize(width: UIFloat(640), height: UIFloat(640))
			window.windowScene?.sizeRestrictions?.minimumSize = fixedSize
			window.windowScene?.sizeRestrictions?.maximumSize = fixedSize
						
			self.window = window
			
			buildMacToolbar()
			
			doTab1(self)
			
			#if targetEnvironment(macCatalyst)
			AppDelegate.appKitController?.perform(NSSelectorFromString("configurePreferencesWindowForSceneIdentifier:"), with: windowScene.session.persistentIdentifier)
			#endif

			window.makeKeyAndVisible()
		}
	}
	
	func buildMacToolbar() {
		#if targetEnvironment(macCatalyst)
		guard let scene = window?.windowScene else {
			return
		}
		
		if let titleBar = scene.titlebar {
			let toolbar = NSToolbar(identifier: "Preferences")
			toolbar.delegate = self
			
			toolbar.selectedItemIdentifier = ToolbarIdentifiers.tab1
			
			titleBar.toolbarStyle = .preference
			titleBar.toolbar = toolbar
		}
		#endif
	}
	
	// MARK: - Tabs
	
	
	@objc func doTab1(_ sender:Any) {
		guard let scene = window?.windowScene else {
			return
		}
		
		scene.title = "Microphone"
		
		let contentView = MicPreferences()

		let hostingController = UIHostingController(rootView: contentView)
		hostingController.view.backgroundColor = .clear
		hostingController.view.isOpaque = false
		
		window?.rootViewController = hostingController
	}
	
	@objc func doTab2(_ sender:Any) {
		guard let scene = window?.windowScene else {
			return
		}
		
		scene.title = "Idle"
		
		let contentView = IdlePreferences()

		let hostingController = UIHostingController(rootView: contentView)
		hostingController.view.backgroundColor = .clear
		hostingController.view.isOpaque = false
		
		window?.rootViewController = hostingController
	}
    
    @objc func doTab3(_ sender:Any) {
        guard let scene = window?.windowScene else {
            return
        }
        
        scene.title = "Talking"
        
        let contentView = TalkingPreferences()

        let hostingController = UIHostingController(rootView: contentView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.isOpaque = false
        
        window?.rootViewController = hostingController
    }
    
    @objc func doTab4(_ sender:Any) {
        guard let scene = window?.windowScene else {
            return
        }
        
        scene.title = "Loud Talking"
        
        let contentView = LoudTalkingPreferences()

        let hostingController = UIHostingController(rootView: contentView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.isOpaque = false
        
        window?.rootViewController = hostingController
    }
}

// MARK: - NSToolbar

#if targetEnvironment(macCatalyst)
extension PreferencesSceneDelegate: NSToolbarDelegate {
	
	enum ToolbarIdentifiers {
		static let tab1 = NSToolbarItem.Identifier("com.example.tab1")
		static let tab2 = NSToolbarItem.Identifier("com.example.tab2")
        static let tab3 = NSToolbarItem.Identifier("com.example.tab3")
        static let tab4 = NSToolbarItem.Identifier("com.example.tab4")
	}
	
	func toolbarIdentifiers() -> [NSToolbarItem.Identifier] {
        return [ToolbarIdentifiers.tab1, ToolbarIdentifiers.tab2, ToolbarIdentifiers.tab3, ToolbarIdentifiers.tab4]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarIdentifiers()
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarIdentifiers()
	}
	
	func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarIdentifiers()
	}
	
	func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		let item = NSToolbarItem(itemIdentifier: itemIdentifier)
		item.target = self
		item.isBordered = false
		
		if itemIdentifier == ToolbarIdentifiers.tab1 {
			
			item.image = UIImage(systemName: "mic")
			item.action = #selector(doTab1(_:))
			item.label = "Microphone"
			return item
		}
		else if itemIdentifier == ToolbarIdentifiers.tab2 {
			item.image = UIImage(systemName: "speaker.zzz")
			item.action = #selector(doTab2(_:))
			item.label = "Idle"
			return item
		}
        else if itemIdentifier == ToolbarIdentifiers.tab3 {
            item.image = UIImage(systemName: "speaker.wave.1")
            item.action = #selector(doTab3(_:))
            item.label = "Talking"
            return item
        }
        else if itemIdentifier == ToolbarIdentifiers.tab4 {
            item.image = UIImage(systemName: "speaker.wave.2")
            item.action = #selector(doTab4(_:))
            item.label = "Loud Talking"
            return item
        }
		else {
			return NSToolbarItem(itemIdentifier: itemIdentifier)
		}
	}

}
#endif
