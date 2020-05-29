//
//  SideBarViewController.swift
//  Pulse_Project
//
//  Created by RAM on 10/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class SideBarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var leftSwipeGesture:UISwipeGestureRecognizer!
    var alert:UIAlertController!
    
    var sideMenuTV:UITableView!
    
    var sideMenuTitles:[String] = ["Personal Details","Dailsy Status Update","Attendance Details","Tasks Status","Logout"]
    var icons:[String] = ["house.fill","pencil.and.ellipsis.rectangle","list.number","desktopcomputer","arrow.right.square.fill"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        sideMenu()
        // Do any additional setup after loading the view.
    }
    
    func sideMenu()
    {
        leftSwipeGesture = UISwipeGestureRecognizer()
        leftSwipeGesture.direction = .left
        leftSwipeGesture.addTarget(self, action: #selector(leftSwipe))
        view.addGestureRecognizer(leftSwipeGesture)
        
        alert = UIAlertController(title: "WARNING", message: "Are you sure you want to logout!", preferredStyle: UIAlertController.Style.alert)
        
        
        view.transform = CGAffineTransform(translationX: -self.view.frame.width*3, y: 0)
        
        
        sideMenuTV = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width/1.5, height: view.frame.height), style: UITableView.Style.plain)
        sideMenuTV.showsVerticalScrollIndicator = false
        sideMenuTV.backgroundColor = #colorLiteral(red: 0.7842528224, green: 0.7843479514, blue: 0.7842206359, alpha: 1)
        sideMenuTV.isScrollEnabled = false
        sideMenuTV.separatorStyle = .none
        sideMenuTV.delegate = self
        sideMenuTV.dataSource = self
        view.addSubview(sideMenuTV)

        
        sideMenuTV.register(UINib(nibName: "SideMenuCellTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
       {
        return 50.0
       }
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
       {
           var menuHeaderView:UIView!
        menuHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: sideMenuTV.frame.width, height: 120))
               let headerImageView = UIImageView(frame: CGRect(x: 20, y: 15, width: 70, height: 70))
                let imageURl = "http://swift4u.c1.biz\(dataShared.userData["picpath"]as! String)"
               headerImageView.addImage(url: imageURl)
            headerImageView.imageCircle()
               
               let emailLBL: UILabel = UILabel.init(frame: CGRect(x: 105, y: 15, width: 200, height: 40))
            emailLBL.font = UIFont(name: "Arial", size: 16.0)
            emailLBL.numberOfLines = 2
            emailLBL.text = "\(dataShared.userData["fname"]as! String) \(dataShared.userData["lname"]as! String)"
               
               let mobileLBL: UILabel = UILabel.init(frame: CGRect(x: 105, y: 60, width: 276, height: 20))
               mobileLBL.text = "\(dataShared.userData["mobile"]as! String)"
               
               menuHeaderView.addSubview(headerImageView)
               menuHeaderView.addSubview(emailLBL)
               menuHeaderView.addSubview(mobileLBL)
               sideMenuTV.tableHeaderView = menuHeaderView
           
           return menuHeaderView
       }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
       {
           return sideMenuTitles.count
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
       {
        return 70.0
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell")as! SideMenuCellTableViewCell
            cell.icon.image = UIImage(systemName: icons[indexPath.row])
               cell.title.text = sideMenuTitles[indexPath.row]
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let tabbar = self.storyboard!.instantiateViewController(withIdentifier: "TabBar") as! TabBarDataViewController
        tabbar.modalPresentationStyle = .overFullScreen
        if indexPath.row == 0
        {
            tabbar.selectedIndex = 0
            present(tabbar, animated: true, completion: nil)
        }
        else if indexPath.row == 1
        {
            tabbar.selectedIndex = 1
            present(tabbar, animated: true, completion: nil)
        }
        else if indexPath.row == 2
        {
            tabbar.selectedIndex = 2
            present(tabbar, animated: true, completion: nil)
        }
        else if indexPath.row == 3
        {
          tabbar.selectedIndex = 3
           present(tabbar, animated: true, completion: nil)
        }
        else if indexPath.row == 4
        {
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                
                let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC")as! ViewController
                
                self.present(homeVC, animated: true, completion:
                {
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.removeObject(forKey: "password")
                    UserDefaults.standard.removeObject(forKey: "studentid")
                })
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil))
           present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func leftSwipe()
    {
        UIView.animate(withDuration: 0.03, delay: 0.0, options: .transitionFlipFromLeft, animations: {
            self.view.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        }, completion: nil)
    }
    

}
