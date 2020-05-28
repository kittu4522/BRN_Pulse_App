//
//  PersonalDetailsViewController.swift
//  Pulse_Project
//
//  Created by RAM on 09/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class PersonalDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var profilePicImgView: UIImageView!
    
    @IBOutlet weak var detailsTV: UITableView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var personalDetailsSC: UISegmentedControl!
    
    var sideView:UIViewController!
    var rightSwipeGesture:UISwipeGestureRecognizer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        detailsTV.separatorStyle = .none
        detailsTV.delegate = self
        detailsTV.dataSource = self
        
        let nib = UINib(nibName: "PersonalDetailsTableViewCell", bundle: nil)
        detailsTV.register(nib, forCellReuseIdentifier: "PersonalDetailsCell")
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
        
        
        
        let imageURl = "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSLaq41SiPy9LpvPlntG-lLjGOlh2gdo4mjlotcTgWnjBGOXfT7&usqp=CAU"
        profilePicImgView.addImage(url: imageURl)
        profilePicImgView.imageCircle()
        
       
        dataShared.userDataKeys = dataShared.userDataKeys.filter {$0 != "loggedin"}
        dataShared.userDataKeys = dataShared.userDataKeys.filter {$0 != "picpath"}
        dataShared.userDataKeys.sort()
        
        dataShared.attSummaryKeys.sort()
        
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if personalDetailsSC.selectedSegmentIndex == 0
        {
            return dataShared.userDataKeys.count
        }
        else
        {
            return dataShared.attSummaryKeys.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalDetailsCell")as! PersonalDetailsTableViewCell
        if personalDetailsSC.selectedSegmentIndex == 0
        {
            cell.titleLBL.text = "\(dataShared.userDataKeys[indexPath.row].uppercased())"
            cell.valueLBL.text = "\(dataShared.userData["\(dataShared.userDataKeys[indexPath.row])"] as! String)"
        }
        else
        {
            cell.titleLBL.text = "\(dataShared.attSummaryKeys[indexPath.row].uppercased())"
            cell.valueLBL.text = "\(dataShared.attSummary["\(dataShared.attSummaryKeys[indexPath.row])"] as! String)"
        }
        
        
        return cell
    }

    @IBAction func segmentTap(_ sender: Any)
    {
        if personalDetailsSC.selectedSegmentIndex == 0
        {
            personalDetailsSC.setEnabled(true, forSegmentAt: 0)
        }
        else
        {
            personalDetailsSC.setEnabled(true, forSegmentAt: 1)
            
        }
        detailsTV.reloadData()
    }
}
