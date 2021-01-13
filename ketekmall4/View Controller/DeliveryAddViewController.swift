

import UIKit
import Alamofire
import JGProgressHUD

class DeliveryAddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Days: UITextField!
    @IBOutlet weak var ButtonAdd: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    private let spinner = JGProgressHUD(style: .dark)
    
    var USERID: String = ""
    var ITEMID: String = ""
    var ADDETAIL: String = ""
    var DIVISION: String = ""
    var DAYS: String = ""
    var PRICE: String = ""
    
    let URL_ADD = "https://ketekmall.com/ketekmall/add_delivery_partone.php"
    let URL_EDIT_DEL_STATUS = "https://ketekmall.com/ketekmall/edit_delivery_status.php"
    let division = ["Kuching", "Kota Samarahan", "Serian", "Sri Aman", "Betong", "Sarikei", "Sibu", "Mukah", "Bintulu", "Kapit", "Miri", "Limbang"]
    
    var DivisionPicker = UIPickerView()
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        Division.text! = DIVISION
        Days.text! = DAYS
        Price.text! = PRICE
        
        Division.inputView = DivisionPicker
        DivisionPicker.dataSource = self
        DivisionPicker.delegate = self
        
        ButtonAdd.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
    }
    
    func ColorFunc(){

        
        //Button ADD
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = ButtonAdd.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 5
        
        ButtonAdd.layer.insertSublayer(ReceivedGradient, at: 0)
        ButtonCancel.layer.insertSublayer(ReceivedGradient, at: 0)
    }
    
    @IBAction func Add(_ sender: Any) {
        spinner.show(in: self.view)
            let parameters: Parameters=[
                "user_id": USERID,
                "division": Division.text!,
                "price": Price.text!,
                "days": Days.text!,
                "item_id": ITEMID
                
            ]
            
            Alamofire.request(URL_ADD, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    if let result = response.result.value{
                        
                        self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                         if(self.lang == "ms"){
                             self.spinner.textLabel.text = "Successfully Added".localized(lang: "ms")
                             
                         }else{
                             self.spinner.textLabel.text = "Successfully Added".localized(lang: "en")
                            
                         }
                         self.spinner.show(in: self.view)
                         self.spinner.dismiss(afterDelay: 3.0)
                        
                        self.Division.text = ""
                        self.Price.text = ""
                        self.Days.text = ""
                        
                        let parameters: Parameters=[
                            "id": self.ITEMID
                        ]
                        
                        Alamofire.request(self.URL_EDIT_DEL_STATUS, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value{
                                    _ = result as! NSDictionary
                                    
                                     print("SUCCESS EDIT STATUS")
                                }else{
                                    print("FAILED")
                                }
                        }
                    }else{
                        print("FAILED")
                        self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                        if(self.lang == "ms"){
                            self.spinner.textLabel.text = "Failed to Save".localized(lang: "ms")
                            
                        }else{
                            self.spinner.textLabel.text = "Failed to Save".localized(lang: "en")
                           
                        }
                        self.spinner.show(in: self.view)
                        self.spinner.dismiss(afterDelay: 3.0)
                    }
                    
            }
        }
    
    func changeLanguage(str: String){
        ButtonAdd.setTitle("ACCEPT".localized(lang: str), for: .normal)
        
        ButtonCancel.setTitle("Cancel".localized(lang: str), for: .normal)
        
    }
        
        @IBAction func Cancel(_ sender: Any) {
             _ = navigationController?.popViewController(animated: true)
        }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return division.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return division[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Division.text = division[row]
}

}
