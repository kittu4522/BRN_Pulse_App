//
//  AttendanceDetailsViewController.swift
//  Pulse_Project
//
//  Created by RAM on 12/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class AttendanceDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
        
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var attendanceDetailsTV: UITableView!
    @IBOutlet weak var attendanceDetailsSC: UISegmentedControl!
    
    var sideView:UIViewController!
    var rightSwipeGesture:UISwipeGestureRecognizer!
    
    var attendanceDetailsDict:NSDictionary = [:]
    var selectedIndexPath:IndexPath = IndexPath()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        createUI()
        
    }
    
    
    func  createUI()
    {
        attendanceDetailsTV.separatorStyle = .none
        
        attendanceDetailsTV.delegate = self
        attendanceDetailsTV.dataSource = self
        
        attendanceDetailsTV.register(UINib(nibName: "AttendanceDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "AttDetCell")
        rightSwipeGesture = UISwipeGestureRecognizer()
        rightSwipeGesture.direction = .right
        rightSwipeGesture.addTarget(self, action: #selector(rightSwipe))
        bottomView.addGestureRecognizer(rightSwipeGesture)
        
        
        sideView = storyboard?.instantiateViewController(identifier: "SideBarVC")as! SideBarViewController
        bottomView.addSubview(sideView.view!)

        
        
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
        if indexPath == selectedIndexPath
        {
            return 175.0
        }
        else
        {
            return 45.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataShared.attendanceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttDetCell")as! AttendanceDetailsTableViewCell
       
       
        cell.dateLBL.text = "DATE : \(dataShared.attendanceData[indexPath.row].date!)"
        cell.dayLBL.text = "DAY : \(dataShared.attendanceData[indexPath.row].day!)"
        cell.checkInLBL.text = "CHECK-IN : \(dataShared.attendanceData[indexPath.row].checkIn!)"
        cell.checkOutLBL.text = "CHECK-OUT : \(dataShared.attendanceData[indexPath.row].checkOut!)"
        cell.timeSpentLBL.text = "TIME-SPENT : \(dataShared.attendanceData[indexPath.row].timeSpent!)"
        cell.spentSummaryLBL.text = "SUMMARY : \(dataShared.attendanceData[indexPath.row].spentSummary!)"
        cell.pointsEarnedLBL.text = "POINTS-EARNED : \(dataShared.attendanceData[indexPath.row].pointsEarned!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if selectedIndexPath != indexPath
        {
            selectedIndexPath = indexPath
        }
        else
        {
            selectedIndexPath = IndexPath()
        }
         tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    @IBAction func attendanceDetailsControlTap(_ sender: Any)
    {
        if attendanceDetailsSC.selectedSegmentIndex == 0
        {
            dataShared.attendanceData = []
            for i in 0..<dataShared.attDetails.count
            {
                let dict = dataShared.attDetails[i]as! [String:String]
                dataShared.attendanceData.append(AttendanceDetailsData(date: dict["date"], day: dict["day"], checkIn: dict["checkin"], checkOut: dict["checkout"], timeSpent: dict["timespent"], spentSummary: dict["spentsummary"], pointsEarned: dict["pointsearned"]))
            }
        }
        else if attendanceDetailsSC.selectedSegmentIndex == 1
        {
            dataShared.attendanceData = []
            for i in 0..<dataShared.attDetails.count
            {
                let dict = dataShared.attDetails[i]as! [String:String]
                if dict["checkin"] == "Absent"
                {
                    dataShared.attendanceData.append(AttendanceDetailsData(date: dict["date"], day: dict["day"], checkIn: dict["checkin"], checkOut: dict["checkout"], timeSpent: dict["timespent"], spentSummary: dict["spentsummary"], pointsEarned: dict["pointsearned"]))
                }
            }
        }
        else if attendanceDetailsSC.selectedSegmentIndex == 2
        {
            dataShared.attendanceData = []
            for i in 0..<dataShared.attDetails.count
            {
                let dict = dataShared.attDetails[i]as! [String:String]
                if dict["checkout"] == "Missed"
                {
                    dataShared.attendanceData.append(AttendanceDetailsData(date: dict["date"], day: dict["day"], checkIn: dict["checkin"], checkOut: dict["checkout"], timeSpent: dict["timespent"], spentSummary: dict["spentsummary"], pointsEarned: dict["pointsearned"]))
                }
            }
        }
        attendanceDetailsTV.reloadData()
    }
    
    
}
