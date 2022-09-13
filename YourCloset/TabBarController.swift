//
//  TabBarController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        setupTabBarAppearence()
    }
    
    func configureTabBarController() {
        let firstVC = MainViewController()
        firstVC.tabBarItem.image = UIImage(systemName: "house.circle")
        let firstNav = UINavigationController(rootViewController: firstVC)
        
        let secondVC = ListToBuyViewController()
        secondVC.tabBarItem.image = UIImage(systemName: "dollarsign.circle")
        
        let thirdVC = SettingViewController()
        thirdVC.tabBarItem.image = UIImage(systemName: "gearshape.circle")
        
        setViewControllers([firstNav, secondVC, thirdVC], animated: true)
    }
    
    func setupTabBarAppearence() {
        let appearence = UITabBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.backgroundColor = .orange
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = .black
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
}
