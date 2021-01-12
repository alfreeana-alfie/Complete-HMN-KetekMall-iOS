//
//  MyBuyingCollectionViewCell.swift
//  ketekmall4
//
//  Created by HMN Nadhir on 30/08/2020.
//  Copyright © 2020 HMN Nadhir. All rights reserved.
//

import UIKit

protocol MyBuyingDelegate: class {
 func btnREJECT(cell: MyBuyingCollectionViewCell)
 func btnVIEW(cell: MyBuyingCollectionViewCell)
}

class MyBuyingCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MyBuyingDelegate?
    
    @IBOutlet weak var OrderID: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var AdDetail: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    @IBOutlet weak var OrderPlaced: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var ShipPlaced: UILabel!
    @IBOutlet weak var ButtonReject: UIButton!
    @IBOutlet weak var ButtonView: UIButton!
    
    @IBAction func Reject(sender: Any){
        self.delegate?.btnREJECT(cell: self)
    }
    
    @IBAction func View(sender: Any){
        self.delegate?.btnVIEW(cell: self)
    }
}
