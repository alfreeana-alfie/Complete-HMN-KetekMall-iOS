

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
    
    let ReceivedGradient = CAGradientLayer()
    let CancelledGradient = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        ReceivedGradient.frame = ButtonView.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.locations = [0.0, 1.0]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 7
        ButtonView.layer.insertSublayer(ReceivedGradient, at: 0)
        
        
        let color3 = UIColor(hexString: "#FC4A1A").cgColor
        let color4 = UIColor(hexString: "#F7B733").cgColor
        
        CancelledGradient.frame = ButtonReject.bounds
        CancelledGradient.colors = [color3, color4]
        CancelledGradient.locations = [0.0, 1.0]
        CancelledGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelledGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelledGradient.cornerRadius = 7
        ButtonReject.layer.insertSublayer(CancelledGradient, at: 0)
    }
    
    @IBAction func Reject(sender: Any){
        self.delegate?.btnREJECT(cell: self)
    }
    
    @IBAction func View(sender: Any){
        self.delegate?.btnVIEW(cell: self)
    }
    
}
