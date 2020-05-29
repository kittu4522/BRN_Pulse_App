//
//  DataManager.swift
//  Pulse_Project
//
//  Created by RAM on 10/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class DataManager: NSObject
{
    var urlReqObj:URLRequest!
    var dataTask:URLSessionDataTask!
    static var shared = DataManager()
    
    var loginStatus:Bool!
    var userData:NSDictionary!
    var userDataKeys:[String] = []
    
    var attSummary:NSDictionary!
    var attSummaryKeys:[String] = []
    
    var attDetails:NSMutableArray = []
    var attendanceData:[AttendanceDetailsData] = []
    
    var tasks:NSMutableArray = []
    var taskData:[TaskStatusData] = []
    
    var recievedData:NSArray!
    
    
    var faceBookData:[String:String] = [:]
    var gmailData:[String:String] = [:]
    

    override init()
    {
        super.init()
    }

    func getData(serviceURL:String,params:[String:String])
    {
        urlReqObj = URLRequest(url: URL(string: serviceURL)!)
        
        urlReqObj.httpMethod = "POST"
        
        var dataSend = ""
        for (key,value) in params
        {
            dataSend.append(contentsOf: "\(key)=\(value)")
            dataSend.append(contentsOf: "&")
        }
        dataSend.removeLast()
        
        
        urlReqObj.httpBody = dataSend.data(using: String.Encoding.utf8)
        
        dataTask = URLSession.shared.dataTask(with: urlReqObj, completionHandler: { (recData, response, err) in
            if recData != nil
            {
                print("Data Recieved")
                DispatchQueue.main.async
                    {
                        do
                        {
                            
                            self.recievedData = try (JSONSerialization.jsonObject(with: recData!, options: JSONSerialization.ReadingOptions.allowFragments)as! NSArray)
                            
                            switch serviceURL
                            {
                            case loginURL:
                                self.loginStatus = true
                                self.userData = (self.recievedData[0] as! NSDictionary)
                                self.userDataKeys = (self.recievedData[0] as! NSDictionary).allKeys as! [String]
                            case attDetURL:
                                for i in stride(from: 0, to: self.recievedData.count, by: 2)
                                {
                                    self.attDetails.add(self.recievedData[i])
                                    let dict = self.recievedData[i]as! [String:String]
                                    self.attendanceData.append(AttendanceDetailsData(date: dict["date"], day: dict["day"], checkIn: dict["checkin"], checkOut: dict["checkout"], timeSpent: dict["timespent"], spentSummary: dict["spentsummary"], pointsEarned: dict["pointsearned"]))
                                }
                            case attSummURL:
                                self.attSummary = (self.recievedData[0] as! NSDictionary)
                                self.attSummaryKeys = (self.recievedData[0] as! NSDictionary).allKeys as! [String]
                            case taskURL:
                                for i in stride(from: 0, to: self.recievedData.count, by: 2)
                                {
                                    self.tasks.add(self.recievedData[i]as! NSDictionary)
                                    let dict = self.recievedData[i]as! [String:String]
                                    self.taskData.append(TaskStatusData(sno: dict["sno"], uid: dict["uid"], id: dict["id"], type: dict["type"], title: dict["title"], requirements: dict["requirements"], issues: dict["issues"], buildtostore: dict["buildtostore"], deadline: dict["deadline"], filesize: dict["filesize"], status: dict["status"], taskpointsearned: dict["taskpointsearned"]))
                                }
                            default:
                                print("")
                            }
                            
                        }
                        catch
                        {
                            self.loginStatus = false
                            print("Unable to serialize Data ")
                        }
                }
            }
            else
            {
                print("Data not Recieved")
            }
        })
        
        dataTask.resume()
    }
}
