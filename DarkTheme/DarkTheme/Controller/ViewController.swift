//
//  ViewController.swift
//  DarkTheme
//
//  Created by SACHIN on 17/03/20.
//  Copyright © 2020 sachinmann67. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var SecondaryView: UIView!
    @IBOutlet weak var lightIconButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowSetup()
        if UserDefaults.standard.object(forKey: "isDark") != nil{}else{
            UserDefaults.standard.set(self.traitCollection.userInterfaceStyle == .dark ? true : false, forKey: "isDark")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.traitCollection.userInterfaceStyle == .dark && !(UserDefaults.standard.value(forKey: "isDark") as! Bool){
                changeIcon("darkmodeIcon")
                UserDefaults.standard.set(true, forKey: "isDark")
            }else if (UserDefaults.standard.value(forKey: "isDark") as! Bool) && self.traitCollection.userInterfaceStyle == .light{
                changeIcon("lightmodeIcon")
                UserDefaults.standard.set(false, forKey: "isDark")
            }
        }
    }
    
    @IBAction func lightIconAction(_ sender: Any) {
        changeIcon("lightmodeIcon")
    }
    @IBAction func DarkIconButton(_ sender: Any) {
        changeIcon("darkmodeIcon")
    }
}
//MARK: functions Extension
extension ViewController{
    func shadowSetup(){
        SecondaryView.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        SecondaryView.layer.shadowOffset = CGSize(width: 0, height: 0)
        SecondaryView.layer.shadowOpacity = 0.25
        SecondaryView.layer.shadowRadius = 2
    }
}

/// To set alternate icon on the basis of icon name as per given by user
///
/// - parameter iconName: alternate icon name
func changeIcon(_ iconName: String) {
    guard UIApplication.shared.supportsAlternateIcons else {
        return
    }
    UIApplication.shared.setAlternateIconName(iconName == "" ? nil : iconName, completionHandler: { (error) in
        if let error = error {
          print("App icon failed to change due to \(error.localizedDescription)")
        } else {
          print("App icon changed successfully")
        }
    })
}
