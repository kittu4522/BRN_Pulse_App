//
//  ImageViewExtensions.swift
//  MovieDetails using TableView
//
//  Created by PALACHARLA VEERA GOPI KRISHNA on 3/5/20.
//  Copyright © 2020 PALACHARLA VEERA GOPI KRISHNA. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView
{
    func addImage(url:String)
    {
        self.image = UIImage(named: "placeholderImage")
        let imageDataTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, connDetails, err) in
           
            if data != nil
            {
                DispatchQueue.main.async
               {
                    self.image = UIImage(data: data!)
                }
            }
        }
      imageDataTask.resume()
    }
    
    func imageCircle()
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        self.layer.borderWidth = 2
        
    }
}
