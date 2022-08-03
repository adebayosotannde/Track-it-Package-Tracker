//
//  LoginViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/2/22.
//

import UIKit

class LoginViewController:UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        //Hides the back button
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
