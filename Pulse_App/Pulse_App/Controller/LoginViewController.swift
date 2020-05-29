//
//  LoginViewController.swift
//  Pulse_Project
//
//  Created by RAM on 09/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginViewController: UIViewController,UITextFieldDelegate
{
    
    @IBOutlet weak var emailIDTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var bottomView: UIView!
    
    
    var loader:UIActivityIndicatorView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loader = UIActivityIndicatorView(frame: view.frame)
        loader.style = .large
        loader.backgroundColor = .lightText
        loader.color = .red
        view.addSubview(loader)
        
        emailIDTF.setBorder()
        emailIDTF.setIcon(image: UIImage(systemName: "envelope.fill")!)
        passwordTF.setBorder()
        passwordTF.setIcon(image: UIImage(systemName: "lock.fill")!)
        
        emailIDTF.delegate = self
        passwordTF.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnTap(_ sender: Any)
    {
        if emailIDTF.text?.isEmpty != true && passwordTF.text?.isEmpty != true
        {
            loader.startAnimating()
            dataShared.getData(serviceURL: loginURL, params: ["email" : "\(emailIDTF.text!)","password":"\(passwordTF.text!)","type":loginTypeValue])
            
            DispatchQueue.main.asyncAfter(deadline: .now()+5.0)
            {
                
                if dataShared.loginStatus == true
                {
                    self.view.makeToast("Logged in Sucess")
                    
                    dataShared.getData(serviceURL: attSummURL, params: ["stdid":"\(dataShared.userData["studentid"]as! String)","type":attSummTypeValue])
                    
                    UserDefaults.standard.set(self.emailIDTF.text!, forKey: "email")
                    UserDefaults.standard.set(self.passwordTF.text!, forKey: "password")
                    UserDefaults.standard.set(dataShared.userData["studentid"]as! String, forKey: "studentid")
                    
                    
                     dataShared.getData(serviceURL: attDetURL, params: ["stdid":"\(dataShared.userData["studentid"]as! String)","type":attDetTypeValue])
                    
                    dataShared.getData(serviceURL: taskURL, params: ["stdid":"\(dataShared.userData["studentid"]as! String)","type":taskTypeValue])
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0)
                    {
                        self.loader.stopAnimating()
                        let tabbar = self.storyboard!.instantiateViewController(withIdentifier: "TabBar") as? UITabBarController
                        tabbar?.modalPresentationStyle = .fullScreen
                        self.present(tabbar!, animated: true, completion: nil)
                    }
                }
                else
                {
                    self.view.makeToast("Not Logedin try again")

                }
            }


        }
        else
        {
            self.view.makeToast("Email id and Password Mandatory")
        }
    }
    
    
    
    @IBAction func forGotPasswordBtnTap(_ sender: Any)
    {
        self.view.makeToast("Under Construction")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        var returnValue:Bool = false
        if textField == emailIDTF
        {
            returnValue = true
        }
        else if textField == passwordTF
        {
            if emailIDTF.text!.count > 2
            {
                returnValue = true
            }
            else
            {
                self.view.makeToast("Email id Must have atleast 2 Letters")
                returnValue = false
            }
        }
        return returnValue
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var returnValue:Bool = false
        
        if string == ""
        {
            return true
        }
        
        if textField == emailIDTF
        {
            let emailSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.@_-")
            if string.rangeOfCharacter(from: emailSet) != nil
            {
                returnValue = true
            }
            else
            {
                returnValue = false
            }
        }
        else if textField ==  passwordTF
        {
            returnValue = true
        }
        
        return returnValue
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        var returnValue:Bool = false
        
        if textField == emailIDTF
        {
            if validateEmail(email: emailIDTF.text!)
            {
                returnValue = true
            }
            else
            {
                self.view.makeToast("Please enter a valid email id")
                returnValue = false
            }
        }
        else if textField == passwordTF
        {
            returnValue = true
        }
        
        return returnValue
    }
    
    //Email Regular Expression
    func validateEmail(email:String)->Bool
    {
        let emailRegExp = "[a-z0-9A-Z.%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegExp)

        return emailPredicate.evaluate(with: email)
    }
    

}
