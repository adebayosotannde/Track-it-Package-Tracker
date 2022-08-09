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
    
    
  
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        
        print("menu interaction")
        
        print(swipeGesture.direction)
        print(menu)
        if menu == false && swipeGesture.direction == .right
        {
            
            print("user is showing menu")
            
            showMenu()
            
            menu = true
            
        }
        
    }
    
    
    @IBAction func hideMenu(_ sender: Any)
    {
        
        if menu == true
        {
            
            print("user is hiding menu")
            
            hideMenu()
            
            menu = false
            
        }
        
        
    }
}


extension HomeMenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! SideMenuTableViewCell
        cell.descriptionLabel.text = options[indexPath.row].title
        cell.descriptionLabel.textColor = .black
        return cell
    }
    
    
}




extension HomeMenuViewController
{
    
    func showMenu() {
        
        self.containerView.layer.cornerRadius = 40
        
        let x = screen.width * 0.8
        let originalTransform = self.containerView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
            UIView.animate(withDuration: 0.7, animations: {
                self.containerView.transform = scaledAndTranslatedTransform
                
            })
        
    }
    
    func hideMenu() {
        
            UIView.animate(withDuration: 0.7, animations:
                            {
                
                self.containerView.transform = self.home
                self.containerView.layer.cornerRadius = 0
              
                
            })
        
    }
    
    
}
