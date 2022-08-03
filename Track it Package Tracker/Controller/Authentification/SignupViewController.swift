//
//  SignupViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/3/22.
//

import UIKit

//MARK: - Life Cycle
extension SignupViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func exitButtonPressedn(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
}
class SignupViewController: UIViewController
{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
}
