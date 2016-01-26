//
//  ViewController.swift
//  JsonDemos
//
//  Created by Ratnakala53 on 1/12/16.
//  Copyright © 2016 ratnakala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btn_CallWS(gem:AnyObject)
    {
        let url = "http://192.168.2.254/health_care_webservice/doctor/management/getSpecializations.php"
        let requet = NSMutableURLRequest(URL: NSURL(string: url)!)
        requet.HTTPMethod = "POST"
        let body = "id=12"
        requet.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(requet) { (data,
            response, error) -> Void in
            if(error == nil)
            {
                do{
                let ws_data:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    
                    print(ws_data)
                }catch{
                
                    let response_Str = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(response_Str)
                }
            }
        }
        task.resume()
    }

}

