//
//  AppDelegate.swift
//  Pulse_Project
//
//  Created by RAM on 07/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//
import Foundation
import UIKit
import IQKeyboardManagerSwift
import Toast_Swift
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{


   

  func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool
  {
          
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
    
        IQKeyboardManager.shared.enable = true
        
        ToastManager.shared.duration = 2.0
        ToastManager.shared.isQueueEnabled = false
        ToastManager.shared.position = .top
        var tStyle = ToastStyle()
        tStyle.imageSize = CGSize(width: 30, height: 30)
        tStyle.messageColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        tStyle.messageFont = UIFont(name: "Courier", size: 18.0)!
        tStyle.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tStyle.messageNumberOfLines = 2
        ToastManager.shared.style = tStyle
        return true
    }
          
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool
    {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

    }
    
}

