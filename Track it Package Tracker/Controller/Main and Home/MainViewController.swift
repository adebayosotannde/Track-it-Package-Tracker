//
//  MainViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/2/22.
//

import UIKit

class MainViewController:UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Step 1: Decide which View Controller to display next
       launchNextViewController()
        
        
        
    }
    
    func launchNextViewController()
    {
        
        var userIsLoggedIn = false
        
        if userIsLoggedIn
        {
            
        }
        else
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
}
    
}
