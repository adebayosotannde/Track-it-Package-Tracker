//
//  LoginViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/2/22.
//

import UIKit
import Firebase
import GoogleSignIn

//MARK: - LifeCycle Functions
extension LoginViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTextFieldDelgate()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //Hides the back button before the view appears.
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}



class LoginViewController:UIViewController
{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signInButtonPressed(_ sender: UIButton)
    {
        LoginUser()
    }
    
    @IBAction func signInGoogle(_ sender: UIButton)
    {
        initiateGoogleSignOn()
    }
    
    
}

//MARK: - Sign up
extension LoginViewController
{
    func LoginUser()
    {
        UserDefaults.standard.set(true, forKey: "hasAlreadyLaunched")
        
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error
                {
                    print(e)
                    //AlertBox
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler:
                    { UIAlertAction in
                        
                    }))
                    self.present(alert, animated: true, completion: nil)//Displays the Alert Box
                }
                else
                {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                            
                
            }
        }
    }
}

//MARK: - UITextField
extension LoginViewController: UITextFieldDelegate
{
    func setupTextFieldDelgate()
    {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        switch textField
        {
           case self.emailTextField:
               self.passwordTextField.becomeFirstResponder()
           default:
            self.view.endEditing(true)
            LoginUser()
            
           }
            return false
        }
}

//MARK: - Google Sign
extension LoginViewController
{
    func initiateGoogleSignOn()
    {
        
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

            // Create Google Sign In configuration object.
            let config = GIDConfiguration(clientID: clientID)

            // Start the sign in flow!
            GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

              if let error = error {
                // ...
                  
                return
              }

              guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)

                Auth.auth().signIn(with: credential)
                {
                    authResult,error in
                   
                    if (error != nil)
                    {
                        
                    }else
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                }
                
            }
            
        
    }
}
