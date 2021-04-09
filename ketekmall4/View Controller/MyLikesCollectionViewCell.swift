

import UIKit
import AARatingBar

protocol MyLikesDelegate: class {
    func btnRemove(cell: MyLikesCollectionViewCell)
    func btnVIEW(cell: MyLikesCollectionViewCell)
   }

class MyLikesCollectionViewCell: UICollectionViewCell {
    
    
    weak var delegate: MyLikesDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemLocation: UILabel!
    @IBOutlet weak var BtnRemove: UIButton!
    @IBOutlet weak var BtnView: UIButton!
    @IBOutlet weak var RatingBar: AARatingBar!
    
    let ViewGradient = CAGradientLayer()
    let RejectGradient = CAGradientLayer()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
        
        ViewGradient.frame = BtnView.bounds
        ViewGradient.colors = [colorViewOne, colorViewTwo]
        ViewGradient.locations = [0.0, 1.0]
        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ViewGradient.cornerRadius = 5
        BtnView.layer.insertSublayer(ViewGradient, at: 0)
        
        let colorReject1 = UIColor(hexString: "#FC4A1A").cgColor
        let colorReject2 = UIColor(hexString: "#F7B733").cgColor
        
        RejectGradient.frame = BtnRemove.bounds
        RejectGradient.colors = [colorReject1, colorReject2]
        RejectGradient.locations = [0.0, 1.0]
        RejectGradient.startPoint = CGPoint(x: 0, y: 0.5)
        RejectGradient.endPoint = CGPoint(x: 1, y: 0.5)
        RejectGradient.cornerRadius = 5
        BtnRemove.layer.insertSublayer(RejectGradient, at: 0)
    }
    
    @IBAction func someButton(sender: Any){
        self.delegate?.btnRemove(cell: self)
    }
    
    @IBAction func buttonView(sender: Any){
        self.delegate?.btnVIEW(cell: self)
    }
}
