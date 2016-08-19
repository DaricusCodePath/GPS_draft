//
//  ViewController2.swift
//  GPS_draft
//
//  Created by DrDunkan on 8/18/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var Addr: UILabel!
    
    @IBOutlet weak var First: UILabel!
    
    @IBOutlet weak var Last: UILabel!
    
    @IBOutlet weak var Email: UILabel!
    
    @IBOutlet weak var Phone: UILabel!
    
    @IBOutlet weak var Home: UILabel!
    
    @IBOutlet weak var Height: UILabel!
    
    var Data = String()
    var Data1 = String()
    var Data2 = String()
    var Data3 = String()
    var Data4 = String()
    var Data5 = String()
    var Data6 = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Addr.text = Data
        First.text = Data1
        Last.text = Data2
        Email.text = Data3
        Phone.text = Data4
        Home.text = Data5
        Height.text = Data6
        
        
        
       // let OutAddr =
       // Addr.text = "hey"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
