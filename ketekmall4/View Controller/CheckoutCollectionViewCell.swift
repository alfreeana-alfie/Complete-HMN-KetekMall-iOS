

import UIKit

protocol CheckoutDelegate: class{
    func onSelfClick(cell: CheckoutCollectionViewCell)
}

class CheckoutCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CheckoutDelegate?
    
    @IBOutlet weak var OrderID: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var Division: UILabel!
    @IBOutlet weak var DeliveryPrice: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    @IBOutlet weak var ButtonSelfPickUp: UIButton!
    
    @IBAction func onSelfPickup(_ sender: Any) {
        self.delegate?.onSelfClick(cell: self)
    }
}


