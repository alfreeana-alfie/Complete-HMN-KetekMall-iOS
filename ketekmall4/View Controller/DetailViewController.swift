

import UIKit
import WebKit

class DetailViewController: UIViewController, PaymentResultDelegate, WKNavigationDelegate{
    func paymentSuccess(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withAuthCode authCode: String!) {
//        if #available(iOS 13.0, *) {
//            let accountsettings = self.storyboard!.instantiateViewController(identifier: "AfterPlaceOrderViewController") as! AfterPlaceOrderViewController
//            if let navigator = self.navigationController {
//                navigator.pushViewController(accountsettings, animated: true)
//            }
//        } else {
//            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "AfterPlaceOrderViewController") as! AfterPlaceOrderViewController
//            if let navigator = self.navigationController {
//                navigator.pushViewController(addProduct, animated: true)
//            }
//        }
        
    }
    
    func paymentFailed(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withErrDesc errDesc: String!) {
//        if #available(iOS 13.0, *) {
//            let accountsettings = self.storyboard!.instantiateViewController(identifier: "CheckoutViewController") as! CheckoutViewController
//            if let navigator = self.navigationController {
//                navigator.pushViewController(accountsettings, animated: true)
//            }
//        } else {
//            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
//            if let navigator = self.navigationController {
//                navigator.pushViewController(addProduct, animated: true)
//            }
//        }
        
    }
    
    func paymentCancelled(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withErrDesc errDesc: String!) {
//        if #available(iOS 13.0, *) {
//            let accountsettings = self.storyboard!.instantiateViewController(identifier: "CheckoutViewController") as! CheckoutViewController
//            if let navigator = self.navigationController {
//                navigator.pushViewController(accountsettings, animated: true)
//            }
//        } else {
//            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
//            if let navigator = self.navigationController {
//                navigator.pushViewController(addProduct, animated: true)
//            }
//        }
//
    }
    
    func requerySuccess(_ refNo: String!, withMerchantCode merchantCode: String!, withAmount amount: String!, withResult result: String!) {
    }
    
    func requeryFailed(_ refNo: String!, withMerchantCode merchantCode: String!, withAmount amount: String!, withErrDesc errDesc: String!) {
    }
    
    var paymentSDK: Ipay?
    var requeryPayment: IpayPayment?
    var paymentView: UIView?
    var webView: WKWebView?
    
    //FROM THIS VIEW CONTROLLER
    var MerchantKey: String = ""
    var MerchantCode: String = ""
    
    var ProdDesc: String = ""
    var Remarks: String = ""
    var BackendURL: String = ""
    
    //GET FROM OTHER VIEW CONTROLLER
    var UserName: String = ""
    var UserEmail: String = ""
    var UserContact: String = ""
    var Amount: String = ""
    var RefNo: String = ""

    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MerchantKey = "8bgBOjTkij"
        MerchantCode = "M29640"
        
        UserName = "Sell"
        UserEmail = "sell@ketekmall.com"
        UserContact = "0138940023"
        Amount = "24.00"
        RefNo = "BtVbTSjuELw9g3Lbqk8v"
        
        ProdDesc = "KetekMall"
        Remarks = "KetekMall"
        BackendURL = "https://ketekmall.com/ketekmall/backendURL.php"

        paymentSDK?.delegate = self
        paymentSDK = Ipay()
        
        requeryPayment = IpayPayment()
        requeryPayment?.paymentId = ""
        requeryPayment?.merchantKey = MerchantKey
        requeryPayment?.merchantCode = MerchantCode
        requeryPayment?.refNo = RefNo
        requeryPayment?.amount = Amount
        requeryPayment?.currency = "MYR"
        requeryPayment?.prodDesc = ProdDesc
        requeryPayment?.userName = UserName
        requeryPayment?.userEmail = UserEmail
        requeryPayment?.userContact = UserContact
        requeryPayment?.remark = Remarks
        requeryPayment?.lang = "ISO-8859-1"
        requeryPayment?.country = "MY"
        requeryPayment?.backendPostURL = BackendURL
        
        webView = paymentSDK!.checkout(requeryPayment) as? WKWebView
        self.view.addSubview(webView!)
    }
}
