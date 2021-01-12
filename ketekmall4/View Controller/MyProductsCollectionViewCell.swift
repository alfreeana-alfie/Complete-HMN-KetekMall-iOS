//
//  MyProductsCollectionViewCell.swift
//  ketekmall4
//
//  Created by HMN Nadhir on 29/08/2020.
//  Copyright © 2020 HMN Nadhir. All rights reserved.
//

import UIKit
import AARatingBar

protocol MyProductDelegate: class {
    func btnRemove(cell: MyProductsCollectionViewCell)
    func btnEdit(cell: MyProductsCollectionViewCell)
    func btnBoost(cell: MyProductsCollectionViewCell)
}

class MyProductsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MyProductDelegate?
    
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemLocation: UILabel!
    @IBOutlet weak var Rating: AARatingBar!
    
    @IBOutlet weak var Btn_Edit: UIButton!
    @IBOutlet weak var Btn_Cancel: UIButton!
    @IBOutlet weak var Btn_Boost: UIButton!
    @IBOutlet weak var NoDeliveryLabel: UIButton!
    
    @IBOutlet weak var PendingHeight: NSLayoutConstraint!
    @IBOutlet weak var Btn_BoostHeight: NSLayoutConstraint!
    
    @IBAction func Edit(sender: Any){
        self.delegate?.btnEdit(cell: self)
    }
    
    @IBAction func Remove(sender:Any){
        self.delegate?.btnRemove(cell: self)
    }
    
    @IBAction func Boost(_ sender: Any) {
        self.delegate?.btnBoost(cell: self)
    }
}
