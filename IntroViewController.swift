//
//  IntroViewController.swift
//  Medi Ready
//
//  Created by Kevin Terwelp on 12/11/18.
//  Copyright © 2018 Kevin Terwelp. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let timer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "ShowMedList", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Navigation
   
    
    
   


}

