//
//  RegistrationViewController.swift
//  Pulse_Project
//
//  Created by RAM on 09/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate
{
    @IBOutlet weak var profilePicImgView: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var qualificationTF: UITextField!
    
    @IBOutlet weak var mobileNumberTF: UITextField!
    
    @IBOutlet weak var emailIDTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var imagePickerView:UIImagePickerController!
    var qualificationPicker:UIPickerView!
    var qualificationTitle:[String] = ["B.Tech","B.S.c","M.B.A","M.S.C","P.H.D","Diploma"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        createUI()
        // Do any additional setup after loading the view.
    }
    
    func createUI()
    {
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        qualificationTF.delegate = self
        mobileNumberTF.delegate = self
        emailIDTF.delegate = self
        passwordTF.delegate = self
        
        firstNameTF.setIcon(image: UIImage(systemName: "person.crop.circle.fill")!)
        lastNameTF.setIcon(image: UIImage(systemName: "person.crop.circle.fill")!)
        qualificationTF.setIcon(image: UIImage(systemName: "book.fill")!)
        mobileNumberTF.setIcon(image: UIImage(systemName: "phone.fill")!)
        emailIDTF.setIcon(image: UIImage(systemName: "envelope.fill")!)
        passwordTF.setIcon(image: UIImage(systemName: "lock.fill")!)
        
        
        imagePickerView = UIImagePickerController()
        imagePickerView.sourceType = .photoLibrary
        imagePickerView.allowsEditing = true
        imagePickerView.delegate = self
        
        qualificationPicker = UIPickerView()
        qualificationPicker.delegate = self
        qualificationPicker.dataSource = self
        qualificationTF.inputView = qualificationPicker
        
        profilePicImgView.imageCircle()
    }
    
    @IBAction func imagePickerBtnTap(_ sender: Any)
    {
        present(imagePickerView, animated: true, completion: nil)
    }
    
    @IBAction func registerBtnTap(_ sender: Any)
    {
        if firstNameTF.text!.isEmpty == true || lastNameTF.text!.isEmpty == true || qualificationTF.text?.isEmpty == true && mobileNumberTF.text!.isEmpty == true || emailIDTF.text!.isEmpty == true || passwordTF.text!.isEmpty == true || profilePicImgView.image == #imageLiteral(resourceName: "placeholderImage")
        {
            self.view.makeToast("Empty TextFields Can't accept")
            clearData()
        }
        else
        {
           self.view.makeToast("Data Sucessfully Saved To Database")
            clearData()
        }
    }
    
    @IBAction func clearBtnTap(_ sender: Any)
    {
        clearData()
    }
    
    //Clear all Data in form
    func clearData()
    {
        firstNameTF.text = ""
        lastNameTF.text = ""
        qualificationTF.text = ""
        mobileNumberTF.text = ""
        emailIDTF.text = ""
        passwordTF.text = ""
        profilePicImgView.image = #imageLiteral(resourceName: "placeholderImage")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return qualificationTitle.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return qualificationTitle[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        qualificationTF.text = qualificationTitle[row]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        profilePicImgView.image = (info[UIImagePickerController.InfoKey.editedImage]as! UIImage)
        imagePickerView.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        var returnVal:Bool = false
        if textField ==  firstNameTF
        {
            returnVal = true
        }
        else if textField == lastNameTF
        {
            if firstNameTF.text!.count > 2
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("First Name Should be Minimum Two Characters")
                returnVal = false
            }
        }
        else if textField == qualificationTF
        {
            if firstNameTF.text!.count > 2 && lastNameTF.text!.count > 2
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Last Name Should be Minimum Two Characters")
                returnVal = false
            }
        }
        else if textField == mobileNumberTF
        {
            if firstNameTF.text!.count > 2 && lastNameTF.text!.count > 2 && qualificationTF.text?.isEmpty != true
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Please Select Qualification From PickerView")
                returnVal = false
            }
        }
        else if textField == emailIDTF
        {
            if firstNameTF.text!.count > 2 && lastNameTF.text!.count > 2 && qualificationTF.text?.isEmpty != true && mobileNumberTF.text!.count >= 9
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Mobile Number Should be 10 Digits")
                returnVal = false
            }
        }
        else if textField == passwordTF
        {
            if firstNameTF.text!.count > 2 && lastNameTF.text!.count > 2 && qualificationTF.text?.isEmpty != true && mobileNumberTF.text!.count >= 9 && emailIDTF.text!.count > 5
                {
                    returnVal = true
                }
                else
                {
                    self.view.makeToast("Email id Should be Minimum 5 Characters")
                    returnVal = false
                }
        }
        return returnVal
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var returnVal:Bool = false
        let emailSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.@_-")
        let nameSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.@_-")
        let mobileSet = CharacterSet(charactersIn: "0123456789")
        if string == ""
        {
            returnVal = true
        }
        
        if textField ==  firstNameTF
        {
            if string.rangeOfCharacter(from: nameSet) != nil
            {
                returnVal = true
            }
            else
            {
                returnVal =  false
            }
        }
        else if textField == lastNameTF
        {
            if string.rangeOfCharacter(from: nameSet) != nil
            {
                returnVal = true
            }
            else
            {
                returnVal =  false
            }
        }
        else if textField == qualificationTF
        {
            returnVal = true
        }
        else if textField == mobileNumberTF
        {
            if string.rangeOfCharacter(from: mobileSet) != nil
            {
                returnVal = true
            }
            else
            {
                returnVal =  false
            }
        }
        else if textField == emailIDTF
        {
            if string.rangeOfCharacter(from: emailSet) != nil
            {
                returnVal =  true
            }
            else
            {
                returnVal =  false
            }
        }
        else if textField == passwordTF
        {
          returnVal = true
        }
        return returnVal
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        var returnVal:Bool = false
        if textField ==  firstNameTF
        {
            returnVal = true
        }
        else if textField == lastNameTF
        {
            returnVal = true
        }
        else if textField == qualificationTF
        {
           returnVal = true
        }
        else if textField == mobileNumberTF
        {
            if validateMobile(mobile: mobileNumberTF.text!)
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Please Enter a Valid Mobile Number")
                returnVal = false
            }
        }
        else if textField == emailIDTF
        {
            if validateEmail(email: emailIDTF.text!)
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Please Enter a Valid Email-id")
                returnVal = false
            }
        }
        else if textField == passwordTF
        {
            if validatePassword(password: passwordTF.text!)
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Password Must have 1 Uppercase Letter, 1 Lowercase Letter, 1 Number an 1 Special Character")
                returnVal = false
            }
        }
        return returnVal
    }
    
    
    //Email Regular Expression
    func validateEmail(email:String)->Bool
    {
        let emailRegExp = "[a-zA-z_.0-9]+@[a-zA-z0-9.-]+.[a-zA-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegExp)

        return emailPredicate.evaluate(with: email)
    }
    
    //Mobile Regular Expression
    func validateMobile(mobile:String)->Bool
    {
        let mobileRegExp = "[0-9]{10}"
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@", mobileRegExp)

        return mobilePredicate.evaluate(with: mobile)
    }
    
    //Password Regular Expression
    func validatePassword(password:String)->Bool
    {
        let passwordRegExp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegExp)

        return passwordPredicate.evaluate(with: password)
    }

}
