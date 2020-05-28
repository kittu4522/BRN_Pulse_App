//
//  TaskStatusViewController.swift
//  Pulse_Project
//
//  Created by RAM on 09/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class TaskStatusViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var taskStatusTV: UITableView!
    
    @IBOutlet weak var taskStatusSC: UISegmentedControl!
    
    
    var sideView:UIViewController!
    var rightSwipeGesture:UISwipeGestureRecognizer!
    
    var selectedIndexPath:IndexPath = IndexPath()
    var deSelectedIndexPath:IndexPath = IndexPath()
    
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
        
        taskStatusTV.separatorStyle = .none
        taskStatusTV.delegate = self
        taskStatusTV.dataSource = self
        
        taskStatusTV.register(UINib(nibName: "TaskStatusTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskStatusCell")
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
            return 300.0
        }
        else
        {
            return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataShared.taskData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskStatusCell")as! TaskStatusTableViewCell
        
        cell.snoLBL.text = dataShared.taskData[indexPath.row].sno
        cell.titleLBL.text = dataShared.taskData[indexPath.row].title
        
        cell.taskIDLBL.text = "ID : "+dataShared.taskData[indexPath.row].id
        cell.taskTypeLBL.text = dataShared.taskData[indexPath.row].type
        cell.requirementsTxtView.text = "Requirements :- "+dataShared.taskData[indexPath.row].requirements
        cell.issueLBL.text = "Issues : "+dataShared.taskData[indexPath.row].issues
        cell.buildToStoreLBL.text = "Build To Store : "+dataShared.taskData[indexPath.row].buildtostore
        cell.deadLineLBL.text = "Dead Line : "+dataShared.taskData[indexPath.row].deadline
        cell.fileSizeLBL.text = "File Size Max (MB) : "+dataShared.taskData[indexPath.row].filesize
        cell.pointsEarnedLBL.text = "POINTS EARNED : "+dataShared.taskData[indexPath.row].taskpointsearned
        
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
    
    @IBAction func taskDetailsSegmentTap(_ sender: Any)
    {
        if taskStatusSC.selectedSegmentIndex == 0
        {
            dataShared.taskData = []
            for i in 0..<dataShared.tasks.count
            {
                let dict = dataShared.tasks[i]as! [String:String]
                dataShared.taskData.append(TaskStatusData(sno: dict["sno"], uid: dict["uid"], id: dict["id"], type: dict["type"], title: dict["title"], requirements: dict["requirements"], issues: dict["issues"], buildtostore: dict["buildtostore"], deadline: dict["deadline"], filesize: dict["filesize"], status: dict["status"], taskpointsearned: dict["taskpointsearned"]))
            }
        }
        else if taskStatusSC.selectedSegmentIndex == 1
        {
            dataShared.taskData = []
            for i in 0..<dataShared.tasks.count
            {
                let dict = dataShared.tasks[i]as! [String:String]
                
                if dict["uid"]!.contains("BTT")
                {
                    dataShared.taskData.append(TaskStatusData(sno: dict["sno"], uid: dict["uid"], id: dict["id"], type: dict["type"], title: dict["title"], requirements: dict["requirements"], issues: dict["issues"], buildtostore: dict["buildtostore"], deadline: dict["deadline"], filesize: dict["filesize"], status: dict["status"], taskpointsearned: dict["taskpointsearned"]))
                }
                
            }
        }
        else if taskStatusSC.selectedSegmentIndex == 2
        {
            dataShared.taskData = []
            for i in 0..<dataShared.tasks.count
            {
                let dict = dataShared.tasks[i]as! [String:String]
                
                if dict["uid"]!.contains("BPT")
                {
                    dataShared.taskData.append(TaskStatusData(sno: dict["sno"], uid: dict["uid"], id: dict["id"], type: dict["type"], title: dict["title"], requirements: dict["requirements"], issues: dict["issues"], buildtostore: dict["buildtostore"], deadline: dict["deadline"], filesize: dict["filesize"], status: dict["status"], taskpointsearned: dict["taskpointsearned"]))
                }
                
            }
        }
        else if taskStatusSC.selectedSegmentIndex == 3
        {
            dataShared.taskData = []
            for i in 0..<dataShared.tasks.count
            {
                let dict = dataShared.tasks[i]as! [String:String]
                
                if dict["status"] == "Review Pending"
                {
                    dataShared.taskData.append(TaskStatusData(sno: dict["sno"], uid: dict["uid"], id: dict["id"], type: dict["type"], title: dict["title"], requirements: dict["requirements"], issues: dict["issues"], buildtostore: dict["buildtostore"], deadline: dict["deadline"], filesize: dict["filesize"], status: dict["status"], taskpointsearned: dict["taskpointsearned"]))
                }
                
            }
        }
        else if taskStatusSC.selectedSegmentIndex == 4
        {
            dataShared.taskData = []
            for i in 0..<dataShared.tasks.count
            {
                let dict = dataShared.tasks[i]as! [String:String]
                if dict["status"] == "Time Up"
                {
                    dataShared.taskData.append(TaskStatusData(sno: dict["sno"], uid: dict["uid"], id: dict["id"], type: dict["type"], title: dict["title"], requirements: dict["requirements"], issues: dict["issues"], buildtostore: dict["buildtostore"], deadline: dict["deadline"], filesize: dict["filesize"], status: dict["status"], taskpointsearned: dict["taskpointsearned"]))
                }
            }
            
        }
        taskStatusTV.reloadData()
        //reload
    }
    
}
