//
//  DeliveryCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 03/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

protocol DeliveryDelegate: class {
    func onEditClick(cell: DeliveryCollectionViewCell)
    func onDeleteClick(cell: DeliveryCollectionViewCell)
}

class DeliveryCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DeliveryDelegate?
    
    @IBOutlet weak var Division: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Days: UILabel!
    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var DeleteButton: UIButton!
    
    @IBAction func EditClick(_ sender: Any) {
        self.delegate?.onEditClick(cell: self)
    }
    
    @IBAction func DeleteClick(_ sender: Any) {
        self.delegate?.onDeleteClick(cell: self)
    }
    
}
