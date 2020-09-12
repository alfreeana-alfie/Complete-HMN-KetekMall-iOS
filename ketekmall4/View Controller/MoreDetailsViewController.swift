//
//  MoreDetailsViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 01/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class MoreDetailsViewController: UIViewController, UITabBarDelegate {

    var BRAND: String = ""
    var INNER: String = ""
    var STOCK: String = ""
    var DESC: String = ""
    var DIVISION: String = ""
    var DISTRICT: String = ""
    
    @IBOutlet weak var BrandMaterial: UILabel!
    @IBOutlet weak var InnerMaterial: UILabel!
    @IBOutlet weak var Stock: UILabel!
    @IBOutlet weak var ShipsFrom: UILabel!
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var Tabbar: UITabBar!
    
    @IBOutlet weak var BrandLabel: UILabel!
    @IBOutlet weak var InnerLabel: UILabel!
    @IBOutlet weak var StockLabel: UILabel!
    @IBOutlet weak var ShipFromLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    let sharedPref = UserDefaults.standard
    var lang: String = ""

    var viewController1: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        Tabbar.delegate = self
        
        BrandMaterial.text! = BRAND
        InnerMaterial.text! = INNER
        Stock.text! = STOCK
        ShipsFrom.text! = DIVISION + "," + DISTRICT
        Description.text! = DESC
    }
    
    func changeLanguage(str: String){
        BrandLabel.text = "BRAND MATERIAL".localized(lang: str)
        InnerLabel.text = "INNER MATERIAL".localized(lang: str)

        StockLabel.text = "STOCK".localized(lang: str)
        
        ShipFromLabel.text = "SHIPS FROM".localized(lang: str)
        DescriptionLabel.text = "DESCRIPTION".localized(lang: str)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            presentMethod(storyBoardName: "Main", storyBoardID: "HomeViewController")
            break
            
        case 2:
            presentMethod(storyBoardName: "Main", storyBoardID: "NotificationViewController")
            break
            
        case 3:
            presentMethod(storyBoardName: "Main", storyBoardID: "ViewController")
            break
            
        default:
            break
        }
    }
    
    func presentMethod(storyBoardName: String, storyBoardID: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.definesPresentationContext = true
        self.present(newViewController, animated: true, completion: nil)
    }
}
