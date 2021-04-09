
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
    
    let NoDeliveryGradient = CAGradientLayer()
    let ReceivedGradient = CAGradientLayer()
    let CancelGradient = CAGradientLayer()
    let BoostGradient = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Button Accept
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor

        ReceivedGradient.frame = Btn_Edit.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.locations = [0.0, 1.0]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 5
        Btn_Edit.layer.insertSublayer(ReceivedGradient, at: 0)
        
        //Button Cancel
        let color3 = UIColor(hexString: "#FC4A1A").cgColor
        let color4 = UIColor(hexString: "#F7B733").cgColor
        
        CancelGradient.frame = Btn_Cancel.bounds
        CancelGradient.colors = [color3, color4]
        CancelGradient.locations = [0.0, 1.0]
        CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelGradient.cornerRadius = 5
        Btn_Cancel.layer.insertSublayer(CancelGradient, at: 0)
        
        //Button Accept
        let color5 = UIColor(hexString: "#FC4A1A").cgColor
        let color6 = UIColor(hexString: "#F7B733").cgColor
        
        BoostGradient.frame = Btn_Boost.bounds
        BoostGradient.colors = [color5, color6]
        BoostGradient.locations = [0.0, 1.0]
        BoostGradient.startPoint = CGPoint(x: 0, y: 0.5)
        BoostGradient.endPoint = CGPoint(x: 1, y: 0.5)
        BoostGradient.cornerRadius = 5
        Btn_Boost.layer.insertSublayer(BoostGradient, at: 0)
        
        
        //Button Cancel
        let color7 = UIColor(hexString: "#ED213A").cgColor
        let color8 = UIColor(hexString: "#93291E").cgColor
        
        NoDeliveryGradient.frame = NoDeliveryLabel.bounds
        NoDeliveryGradient.colors = [color7, color8]
        NoDeliveryGradient.locations = [0.0, 1.0]
        NoDeliveryGradient.startPoint = CGPoint(x: 0, y: 0.5)
        NoDeliveryGradient.endPoint = CGPoint(x: 1, y: 0.5)
        NoDeliveryGradient.cornerRadius = 5
        NoDeliveryLabel.layer.insertSublayer(NoDeliveryGradient, at: 0)
    }
    
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
