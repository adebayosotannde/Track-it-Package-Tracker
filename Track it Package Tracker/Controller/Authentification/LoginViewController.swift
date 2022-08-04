//
//  LoginViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/2/22.
//

import UIKit
import Firebase
import GoogleSignIn
import AuthenticationServices
import CryptoKit




//MARK: - LifeCycle Functions
extension LoginViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTextFieldDelgate()
        setupSignInWithAppleButton()
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
    var currentNonce:String?
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var appleSignon: UIStackView!
    
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

//MARK: - Apple Sign On
extension LoginViewController
{
    private func setupSignInWithAppleButton()
    {
        let signInWithAppleButton = ASAuthorizationAppleIDButton()
        appleSignon.addArrangedSubview(signInWithAppleButton)
        signInWithAppleButton.addTarget(self, action: #selector(initiateAppleSignOn), for: .touchUpInside)
    }
    
    @objc private func initiateAppleSignOn()
    {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        // Generate nonce for validation after authentication successful
        self.currentNonce = randomNonceString()
        // Set the SHA256 hashed nonce to ASAuthorizationAppleIDRequest
        request.nonce = sha256(currentNonce!)

        // Present Apple authorization form
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
    //Reqired for Apple Sign On
    private func randomNonceString(length: Int = 32) -> String
    {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    //Reqired for Apple Sign On
    private func sha256(_ input: String) -> String
    {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

//MARK: - Sign on with Apple Extension Functions
extension LoginViewController: ASAuthorizationControllerDelegate,  ASAuthorizationControllerPresentationContextProviding
{

    //MARK: - ASAuthorizationControllerDelegate
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        {
            
            // Save authorised user ID for future reference
            UserDefaults.standard.set(appleIDCredential.user, forKey: "appleAuthorizedUserIdKey")
            
            // Retrieve the secure nonce generated during Apple sign in
            guard let nonce = self.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }

            // Retrieve Apple identity token
            guard let appleIDToken = appleIDCredential.identityToken else
            {
                print("Failed to fetch identity token")
                return
            }

            // Convert Apple identity token to string
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else
            {
                print("Failed to decode identity token")
                return
            }

            // Initialize a Firebase credential using secure nonce and Apple identity token
            let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                              idToken: idTokenString,
                                                              rawNonce: nonce)
                
            // Sign in with Firebase
            Auth.auth().signIn(with: firebaseCredential)
            { (authResult, error) in
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(newViewController, animated: true)
               
                }
 
    
        }
    }
    
    //MARK: - ASAuthorizationControllerPresentationContextProviding
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor
    {
        return self.view.window!
    }
}
