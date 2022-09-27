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
        firstVC.tabBarItem = UITabBarItem(title: "메인화면", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let secondVC = ListToBuyViewController()
        secondVC.tabBarItem = UITabBarItem(title: "구매 예정 목록", image: UIImage(systemName: "dollarsign.square"), selectedImage: UIImage(systemName: "dollarsign.square.fill"))
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        let thirdVC = SettingViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape.circle"), selectedImage: UIImage(systemName: "gearshape.circle.fill"))
        
        setViewControllers([firstVC, secondNav, thirdVC], animated: true)
    }
    
    func setupTabBarAppearence() {
        let appearence = UITabBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.backgroundColor = UIColor.projectColor(.backgroundColor)
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
