//
//  ViewController.swift
//  SqlitDemo
//
//  Created by Ratnakala53 on 1/21/16.
//  Copyright © 2016 ratnakala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let db =  GLobal.CreatConnection()
        if db.open()
        {
            print("Done")
        }else
        {
            print("Done---")
        }
        
        GLobal.insert("nn", address: "asas", city: "asaaa")
        GLobal.selectAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

