

import UIKit

class EditProductAdDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var AdDetailLabel: UILabel!
    @IBOutlet weak var BrandLabel: UILabel!
//    @IBOutlet weak var InnerLabel: UILabel!
    @IBOutlet weak var StockLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var AdDetail: UITextField!
    @IBOutlet weak var BrandMaterial: UITextField!
//    @IBOutlet weak var InnerMaterial: UITextField!
    @IBOutlet weak var Stock: UITextField!
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var ButtonAccept: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    var MAINCATE: String = ""
    var SUBCATE: String = ""
    var BRAND: String = ""
    var INNER: String = ""
    var STOCK: String = ""
    var DESC: String = ""
    var MAXORDER: String = ""
    var DIVISION: String = ""
    var ITEMID: String = ""
    var ADDETAIL: String = ""
    var PRICE: String = ""
    var PHOTO: String = ""
    var PHOTO02: String = ""
    var PHOTO03: String = ""
    var PHOTO04: String = ""
    var PHOTO05: String = ""
    var DISTRICT: String = ""
    var USERID: String = ""
    var POSTCODE: String = ""
    var WEIGHT: String = ""
    var CheckView: Bool = false
    
    var PhotoId: [String] = []
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdDetail.delegate = self
        BrandMaterial.delegate = self
//        InnerMaterial.delegate = self
        Stock.delegate = self
        Description.delegate = self
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        self.AdDetail.text! = ADDETAIL
        self.BrandMaterial.text! = BRAND
//        self.InnerMaterial.text! = INNER
        self.Stock.text! = STOCK
        self.Description.text! = DESC
        
        
        ButtonAccept.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
  
    }
    
    @objc override func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
        }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func ColorFunc(){
        //Button Accept
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = ButtonAccept.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 5
            ButtonAccept.layer.insertSublayer(ReceivedGradient, at: 0)
        
        //Button Cancel
        let color3 = UIColor(hexString: "#FC4A1A").cgColor
        let color4 = UIColor(hexString: "#F7B733").cgColor
        
        let CancelGradient = CAGradientLayer()
        CancelGradient.frame = ButtonCancel.bounds
        CancelGradient.colors = [color3, color4]
        CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelGradient.cornerRadius = 5
        ButtonCancel.layer.insertSublayer(CancelGradient, at: 0)
    }
    
    func changeLanguage(str: String){
        AdDetailLabel.text = "Ad Detail".localized(lang: str)
        BrandLabel.text = "Brand Material".localized(lang: str)
//        InnerLabel.text = "Inner Material".localized(lang: str)
        StockLabel.text = "Stock".localized(lang: str)
        DescriptionLabel.text = "Description".localized(lang: str)
        
        AdDetail.placeholder = "Ad Detail".localized(lang: str)
        BrandMaterial.placeholder = "Brand Material".localized(lang: str)
//        InnerMaterial.placeholder = "Inner Material".localized(lang: str)
        Stock.placeholder = "Stock".localized(lang: str)
        
        ButtonAccept.titleLabel?.text = "ACCEPT".localized(lang: str)
        ButtonCancel.titleLabel?.text = "CANCEL".localized(lang: str)
    }
    
    @IBAction func Accept(_ sender: Any) {
        if(CheckView == true){
            let ADDETAIL = self.storyboard!.instantiateViewController(withIdentifier: "AddNewProductViewController") as! AddNewProductViewController
            ADDETAIL.userID = USERID
            ADDETAIL.Addetail = self.AdDetail.text!
            ADDETAIL.CategoryText = MAINCATE
            ADDETAIL.CategorySubText = SUBCATE
//            ADDETAIL.Price.text! = PRICE
            ADDETAIL.BrandMaterial = self.BrandMaterial.text!
            ADDETAIL.InnerMaterial = self.BrandMaterial.text!
            ADDETAIL.Stock = self.Stock.text!
            ADDETAIL.Description = self.Description.text!
            ADDETAIL.DivisionText = DIVISION
            ADDETAIL.DistrictText = DISTRICT
            ADDETAIL.photoTempId = self.PhotoId
//            ADDETAIL.MaxOrder.text! = MAXORDER
//            ADDETAIL.PostCode.text! = POSTCODE
//            ADDETAIL.Weight.text! = WEIGHT
            if let navigator = self.navigationController {
                navigator.pushViewController(ADDETAIL, animated: true)
            }
        }else{
            let AdDetail = self.storyboard!.instantiateViewController(withIdentifier: "EditProductViewController") as! EditProductViewController
            AdDetail.USERID = USERID
            AdDetail.ITEMID = ITEMID
            AdDetail.ADDETAIL = self.AdDetail.text!
            AdDetail.MAINCATE = MAINCATE
            AdDetail.SUBCATE = SUBCATE
            AdDetail.PRICE = PRICE
            AdDetail.BRAND = self.BrandMaterial.text!
            AdDetail.INNER = self.BrandMaterial.text!
            AdDetail.STOCK = self.Stock.text!
            AdDetail.DESC = self.Description.text!
            AdDetail.DIVISION = DIVISION
            AdDetail.DISTRICT = DISTRICT
            AdDetail.PHOTO = PHOTO
            AdDetail.PHOTO02 = PHOTO02
            AdDetail.PHOTO03 = PHOTO03
            AdDetail.PHOTO04 = PHOTO04
            AdDetail.PHOTO05 = PHOTO05
//            AdDetail.PhotoTempId = self.PhotoId
            AdDetail.MAXORDER = MAXORDER
            AdDetail.POSTCODE = POSTCODE
            AdDetail.WEIGHT = WEIGHT
            if let navigator = self.navigationController {
                navigator.pushViewController(AdDetail, animated: true)
            }
        }
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
         _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
}
