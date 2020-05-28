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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
     let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let windows:UIWindow = UIWindow(frame: UIScreen.main.bounds)
    var returnVal:Bool = false
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
       
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
        
        if UserDefaults.standard.value(forKey: "email") != nil && UserDefaults.standard.value(forKey: "password") != nil && UserDefaults.standard.value(forKey: "studentid") != nil
        {
           DataManager.shared.getData(serviceURL: loginURL, params: ["email" : "\(UserDefaults.standard.value(forKey: "email")as! String)","password":"\(UserDefaults.standard.value(forKey: "password")as! String)","type":loginTypeValue])
            
                DataManager.shared.getData(serviceURL: attSummURL, params: ["stdid":"\(UserDefaults.standard.value(forKey: "studentid")as! String)","type":attSummTypeValue])
            
            
            let login:UIViewController = self.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC")as! UIViewController
            
            
            
            self.windows.rootViewController = login
            self.windows.makeKeyAndVisible()
            
            
            
            
            
                   
        }
      

        
     return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

