//
//  DailyStatusViewController.swift
//  Pulse_Project
//
//  Created by RAM on 09/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class DailyStatusViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var firstHourTF: UITextField!
    @IBOutlet weak var secondHourTF: UITextField!
    @IBOutlet weak var thirdHourTF: UITextField!
    @IBOutlet weak var fourthHourTF: UITextField!
    @IBOutlet weak var fifthHourTF: UITextField!
    @IBOutlet weak var sixthHourTF: UITextField!
    @IBOutlet weak var seventhHourTF: UITextField!
    @IBOutlet weak var eightHourTF: UITextField!
    @IBOutlet weak var ninthHourTF: UITextField!
    @IBOutlet weak var leavingHourTF: UITextField!
    
    @IBOutlet weak var bottomView: UIView!
    
    var sideView:UIViewController!
    var rightSwipeGesture:UISwipeGestureRecognizer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        createUI()

        // Do any additional setup after loading the view.
    }
    
    func createUI()
    {
        rightSwipeGesture = UISwipeGestureRecognizer()
        rightSwipeGesture.direction = .right
        rightSwipeGesture.addTarget(self, action: #selector(rightSwipe))
        bottomView.addGestureRecognizer(rightSwipeGesture)
        
        
        sideView = storyboard?.instantiateViewController(identifier: "SideBarVC")as! SideBarViewController
        bottomView.addSubview(sideView.view!)
        
        firstHourTF.delegate = self
        secondHourTF.delegate = self
        thirdHourTF.delegate = self
        fourthHourTF.delegate = self
        fifthHourTF.delegate = self
        sixthHourTF.delegate = self
        seventhHourTF.delegate = self
        eightHourTF.delegate = self
        ninthHourTF.delegate = self
        leavingHourTF.delegate = self
    }
    
    @IBAction func sideMenuBtnTapped(_ sender: Any)
    {
        if sideView.view.frame.origin.x == 0
        {
            UIView.animate(withDuration: 0.03, delay: 0.0, options: .transitionFlipFromLeft, animations: {
                self.sideView.view.transform = CGAffineTransform(translationX: -self.sideView.view.frame.width, y: 0)
            }, completion: nil)
        }
        else
        {
            UIView.animate(withDuration: 0.03, delay: 0.0, options: .transitionFlipFromLeft, animations: {
                self.sideView.view.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }

    }
    
    @objc func rightSwipe()
    {
        UIView.animate(withDuration: 0.03, delay: 0.0, options: .transitionFlipFromLeft, animations: {
            self.sideView.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        var returnVal:Bool = false
        if textField == firstHourTF
        {
            returnVal = true
        }
        else if textField == secondHourTF
        {
            if firstHourTF.text!.count > 5
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("First Hour Update contains a valid content")
                returnVal = false
            }
        }
        else if textField == thirdHourTF
        {
            if firstHourTF.text!.count > 5 && secondHourTF.text!.count > 5
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Second Hour Update contains a valid content")
                returnVal = false
            }
        }
        else if textField == fourthHourTF
        {
            if firstHourTF.text!.count > 5 && secondHourTF.text!.count > 5 && thirdHourTF.text!.count > 5
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Third Hour Update contains a valid content")
                returnVal = false
            }
        }
        else if textField == fifthHourTF
        {
            if firstHourTF.text!.count > 5 && secondHourTF.text!.count > 5 && thirdHourTF.text!.count > 5 && fourthHourTF.text!.count > 5
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Fourth Hour Update contains a valid content")
                returnVal = false
            }
        }
        else if textField == sixthHourTF
        {
            if firstHourTF.text!.count > 5 && secondHourTF.text!.count > 5 && thirdHourTF.text!.count > 5 && fourthHourTF.text!.count > 5 && fifthHourTF.text!.count > 5
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Fifth Hour Update contains a valid content")
                returnVal = false
            }
        }
        else if textField == seventhHourTF
        {
            if firstHourTF.text!.count > 5 && secondHourTF.text!.count > 5 && thirdHourTF.text!.count > 5 && fourthHourTF.text!.count > 5 && fifthHourTF.text!.count > 5 && sixthHourTF.text!.count > 5
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Sixth Hour Update contains a valid content")
                returnVal = false
            }
        }
        else if textField == eightHourTF
        {
            if firstHourTF.text!.count > 5 && secondHourTF.text!.count > 5 && thirdHourTF.text!.count > 5 && fourthHourTF.text!.count > 5 && fifthHourTF.text!.count > 5 && sixthHourTF.text!.count > 5 && seventhHourTF.text!.count > 5
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Seventh Hour Update contains a valid content")
                returnVal = false
            }
        }
        else if textField == ninthHourTF
        {
            if firstHourTF.text!.count > 5 && secondHourTF.text!.count > 5 && thirdHourTF.text!.count > 5 && fourthHourTF.text!.count > 5 && fifthHourTF.text!.count > 5 && sixthHourTF.text!.count > 5 && seventhHourTF.text!.count > 5 && eightHourTF.text!.count > 5
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Eight Hour Update contains a valid content")
                returnVal = false
            }

        }
        else if textField == leavingHourTF
        {
            if firstHourTF.text!.count > 5 && secondHourTF.text!.count > 5 && thirdHourTF.text!.count > 5 && fourthHourTF.text!.count > 5 && fifthHourTF.text!.count > 5 && sixthHourTF.text!.count > 5 && seventhHourTF.text!.count > 5 && eightHourTF.text!.count > 5 && ninthHourTF.text!.count > 5
            {
                returnVal = true
            }
            else
            {
                self.view.makeToast("Ninth Hour Update contains a valid content")
                returnVal = false
            }
        }
        return returnVal
    }
    
    
    
    
    @IBAction func updateBtnTap(_ sender: Any)
    {
        if firstHourTF.text!.isEmpty == true || secondHourTF.text!.isEmpty == true || thirdHourTF.text!.isEmpty == true || fourthHourTF.text!.isEmpty == true || fifthHourTF.text!.isEmpty == true || sixthHourTF.text!.isEmpty == true || seventhHourTF.text!.isEmpty == true || eightHourTF.text!.isEmpty == true || ninthHourTF.text!.isEmpty == true
        {
            self.view.makeToast("Hourly update not empty")
            
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
    
    func clearData()
    {
        firstHourTF.text = ""
        secondHourTF.text = ""
        thirdHourTF.text = ""
        fourthHourTF.text = ""
        fifthHourTF.text = ""
        sixthHourTF.text = ""
        seventhHourTF.text = ""
        eightHourTF.text = ""
        ninthHourTF.text = ""
        leavingHourTF.text = ""
    }
    

}
