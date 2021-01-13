

import UIKit

protocol MySellingDelegate: class{
    func btnREJECT(cell: MySellingCollectionViewCell)
    func btnVIEW(cell: MySellingCollectionViewCell)
}

class MySellingCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MySellingDelegate?
    
    @IBOutlet weak var OrderID: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var AdDetail: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    @IBOutlet weak var DateOrder: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var ShipPlace: UILabel!
    @IBOutlet weak var ButtonReject: UIButton!
    @IBOutlet weak var ButtonView: UIButton!
    
    @IBAction func Reject(sender: Any){
        self.delegate?.btnREJECT(cell: self)
    }
    
    @IBAction func View(sender: Any){
        self.delegate?.btnVIEW(cell: self)
    }
    
}
