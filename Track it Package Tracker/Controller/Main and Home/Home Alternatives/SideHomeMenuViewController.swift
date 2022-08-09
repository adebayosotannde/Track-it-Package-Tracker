//
//  SideMenuViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/6/22.
//

import UIKit

extension HomeMenuViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.backgroundColor = .clear
        
        home = self.containerView.transform
    
    }
}



class HomeMenuViewController: UIViewController
{
    @IBOutlet var containerView: UIView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var menuTableView: UITableView!
    
    //Variable used for the Side Menu
    let screen = UIScreen.main.bounds
    var menu = false
    var home = CGAffineTransform()
    
    

    @IBOutlet weak var hamburgerMenuItem: UIBarButtonItem!
    
    @IBAction func showHamburgerMenu(_ sender: UIBarButtonItem)
    {
       
        showMenu()
       
    }
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        
        print("menu interaction")
        
        print(swipeGesture.direction)
        print(menu)
        if menu == false && swipeGesture.direction == .right
        {
        showMenu()
        }
        
    }
    
    
    @IBAction func hideMenu(_ sender: Any)
    {
        
        if menu == true
        {
        hideMenu()
        }
        
        
    }
}


extension HomeMenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch tableView
        {
        case menuTableView:
            return options.count
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        switch tableView
        {
        case menuTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! SideMenuTableViewCell
            cell.descriptionLabel.text = options[indexPath.row].title
            cell.descriptionLabel.textColor = .black
            return cell
        default:
            fatalError()
        }
        
        
        
        
    }
    
    
}




extension HomeMenuViewController
{
    
    func showMenu()
    {
        self.containerView.layer.cornerRadius = 40

        let x = screen.width * 0.8
        let originalTransform = self.containerView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
            UIView.animate(withDuration: 0.7, animations: {
                self.containerView.transform = scaledAndTranslatedTransform
                
            })
        
        menu = true
        
        //DIABLES THE HAMBURGERMENU
        hamburgerMenuItem.isEnabled = false
        
        
    }
    
    func hideMenu()
    {
        
            UIView.animate(withDuration: 0.7, animations:
                            {
                
                self.containerView.transform = self.home
                self.containerView.layer.cornerRadius = 0
              
                
            })
        
        menu = false
        //RE-ENABLES THE HAMBURGERMENU
        hamburgerMenuItem.isEnabled = true
        
    }
    
    
}
