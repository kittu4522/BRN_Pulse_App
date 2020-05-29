//
//  GmailIntegrationViewController.swift
//  Pulse_App
//
//  Created by RAM on 29/05/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit
import GoogleSignIn
class GmailIntegrationViewController: UIViewController,GIDSignInDelegate
{
   
    @IBOutlet weak var signInBtn: GIDSignInButton!
    
    
    @IBOutlet weak var profilePic: ImageViewCustomClass!
    
    @IBOutlet weak var userName: UILabel!
    
    var isLoggedIn:Bool = false
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {
        if error == nil
        {
            isLoggedIn = true
            self.view.makeToast("Sucessfully Logged in by \(user.profile.email!)")
            let imageURL:URL = user.profile.imageURL(withDimension: 200)!
            
            userName.text = user.profile.name!
            profilePic.addImage(url: imageURL.absoluteString)
            dataShared.gmailData["email"] = user.profile.email!
            dataShared.gmailData["fname"] = user.profile.givenName!
            dataShared.gmailData["lname"] = user.profile.familyName!
            dataShared.gmailData["picPath"] = imageURL.absoluteString
            
            print(dataShared.gmailData)
        }
        else
        {
            isLoggedIn = false
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func registerWithGmail(_ sender: Any)
    {
        if isLoggedIn == false
        {
            self.view.makeToast("Please Login")
        }
        else
        {
            let continueWithGmail = storyboard?.instantiateViewController(identifier: "RegistrationVC")as! RegistrationViewController
            continueWithGmail.modalPresentationStyle = .overFullScreen
            present(continueWithGmail, animated: true) {
                continueWithGmail.firstNameTF.text = dataShared.gmailData["fname"]!
                continueWithGmail.lastNameTF.text = dataShared.gmailData["lname"]!
                continueWithGmail.emailIDTF.text = dataShared.gmailData["email"]!
                continueWithGmail.profilePicImgView.addImage(url: dataShared.gmailData["picPath"]!)
                GIDSignIn.sharedInstance()?.signOut()
            }
        }
    }
}
