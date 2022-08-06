//
//  SideMenuViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/6/22.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
   
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        sideMenuTableView.backgroundColor = .clear
    }
  
    
}

extension SideMenuViewController
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return options.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
            cell.backgroundColor = .clear
            
            cell.menuItem.setTitle(options[indexPath.row].title, for: .normal)
            cell.menuItem.setTitleColor(.white, for: .normal)
            return cell
            
        }
        
}


class tableViewCell: UITableViewCell
{

    @IBOutlet weak var menuItem: UIButton!
    

}
