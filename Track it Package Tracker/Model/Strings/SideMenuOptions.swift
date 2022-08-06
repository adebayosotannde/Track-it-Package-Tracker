//
//  SideMenuOptions.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/6/22.
//

import Foundation


var options: [option] = [option(title: "Home", segue: "HomeSegue"),
                         option(title: "Settings",segue: "SettingsSegue"),
                         option(title: "Profile",segue: "ProfileSegue"),
                         option(title: "Terms and Conditions",segue: "TermsSegue"),
                         option(title: "Privacy Policy", segue: "PrivacySegue")]

struct option {
    var title = String()
    var segue = String()
}
