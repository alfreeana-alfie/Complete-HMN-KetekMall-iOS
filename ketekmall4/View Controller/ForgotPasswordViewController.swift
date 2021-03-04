

import UIKit
import Alamofire
import JGProgressHUD

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    let URL_SEND_EMAIL = "https://ketekmall.com/ketekmall/sendEmail_getPassword.php";
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var EmailImage: UIImageView!
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Border: UIView!
    @IBOutlet weak var ButtonSend: UIButton!
    
    @IBAction func sendEmail(_ sender: Any) {
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "email":Email.text!,
        ]
        Alamofire.request(URL_SEND_EMAIL, method: .post, parameters: parameters).responseJSON
        {
            response in
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                print(jsonData.value(forKey: "message")!)
                self.spinner.dismiss(afterDelay: 3.0)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Email.delegate = self
        
        Border.layer.cornerRadius = 2
        ButtonSend.layer.cornerRadius = 20
        
        EmailView.layer.cornerRadius = 5
        EmailImage.layer.cornerRadius = 5
        
        EmailImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);

    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func ColorFunc(){
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let l = CAGradientLayer()
        l.frame = ButtonSend.bounds
        l.colors = [color1, color2]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 16
        ButtonSend.layer.insertSublayer(l, at: 0)
    }
}
