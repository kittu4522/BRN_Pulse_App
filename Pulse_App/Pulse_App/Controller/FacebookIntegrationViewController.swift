//
//  FacebookIntegrationViewController.swift
//  Pulse_Project
//
//  Created by RAM on 28/05/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit
import Toast_Swift
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookIntegrationViewController: UIViewController,LoginButtonDelegate
{

    @IBOutlet weak var nameLbl: UILabel!
 
    @IBOutlet weak var loginBtn: FBLoginButton!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    var isLoggedIn:Bool = false
    var userData:NSDictionary = [:]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loginBtn.permissions = ["public_profile", "email"]
        loginBtn.delegate = self
        
        
        if(AccessToken.current == nil)
        {
            print("not logged in")
        }
        else
        {
            print("logged in already")
            checkLoggedInStatus()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?)
    {
        checkLoggedInStatus()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton)
    {
        profilePic.image = #imageLiteral(resourceName: "placeholderImage")
        nameLbl.text = ""
    }
    
    func checkLoggedInStatus()
    {
        let graph = GraphRequest.init(graphPath: "me", parameters: ["fields":"first_name,last_name,email,mobile, picture.type(medium)"], tokenString: nil, version: nil, httpMethod: HTTPMethod(rawValue: "GET"))
        graph.start { (connection, responce, err) in
            if err == nil
            {
                self.userData = responce as! NSDictionary
                self.nameLbl.text = "\(self.userData["first_name"]as! String) \(self.userData["last_name"]as! String)"
                
                let imagePath:String = (((self.userData["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String)!
                self.profilePic.addImage(url: imagePath)
            }
            else
            {
                print(err?.localizedDescription)
            }
        }
    }
    
    @IBAction func registerWithFB(_ sender: Any)
    {
        if isLoggedIn == false
        {
            self.view.makeToast("Please Login with facebook")
        }
        else
        {
            self.view.makeToast("Sucessfully Logged in ")
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
