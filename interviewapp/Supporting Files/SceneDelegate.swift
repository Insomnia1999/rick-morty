//
//  SceneDelegate.swift
//  rickandmorty
//
//  Created by Iván Fernández Arenas on 14/7/23.
//

import AlamofireNetworkActivityLogger
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var scene: UIScene?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.scene = scene
        self.initialize()
    }
}

extension SceneDelegate {
    private func initialize() {
        initInterface()
        initNetworkLogger()
    }

    
    func initInterface() {
        
        if let windowScene = scene as? UIWindowScene {
            var window = UIWindow(windowScene: windowScene)
            window.rootViewController = HostingController(rootView: ViewManager())
            self.window = window
            window.makeKeyAndVisible()
            
            window = UIWindow(frame: UIScreen.main.bounds)
        }

    }
    
    func initNetworkLogger() {
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
    }
}
