//
//  CartCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import SimpleCheckbox
protocol CartDelegate: class {
    func OnAddClick(cell: CartCollectionViewCell)
    func onDeleteClick(cell: CartCollectionViewCell)
}

class CartCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CartDelegate?
    var callback: ((String) -> Void)?
    
    @IBOutlet weak var AdDetail: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var CheckBOx: Checkbox!
    @IBOutlet weak var Quantity: UILabel!
    @IBOutlet weak var Stepper: UIStepper!
    @IBOutlet weak var SubTotal: UILabel!
    @IBOutlet weak var ButtonDelete: UIButton!
    
    @IBOutlet weak var SubLabel: UILabel!
    @IBOutlet weak var QuantityLabel: UILabel!
    
    @IBAction func Delete(_ sender: Any) {
        self.delegate?.onDeleteClick(cell: self)
    }
    
    @IBAction func AddClick(sender: UIStepper){
        self.delegate?.OnAddClick(cell: self)
        callback?(String(Int(sender.value)))
        Quantity.text! = String(Int(sender.value))
    }
}
