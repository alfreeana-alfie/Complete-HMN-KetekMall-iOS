//
//  DetailViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 24/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, PaymentResultDelegate, WKNavigationDelegate{
    func paymentSuccess(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withAuthCode authCode: String!) {
//        let accountsettings = self.storyboard!.instantiateViewController(identifier: "AfterPlaceOrderViewController") as! AfterPlaceOrderViewController
//        if let navigator = self.navigationController {
//            navigator.pushViewController(accountsettings, animated: true)
//        }
    }
    
    func paymentFailed(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withErrDesc errDesc: String!) {
//        let accountsettings = self.storyboard!.instantiateViewController(identifier: "CheckoutViewController") as! CheckoutViewController
//        if let navigator = self.navigationController {
//            navigator.pushViewController(accountsettings, animated: true)
//        }
    }
    
    func paymentCancelled(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withErrDesc errDesc: String!) {
//        let accountsettings = self.storyboard!.instantiateViewController(identifier: "CheckoutViewController") as! CheckoutViewController
//        if let navigator = self.navigationController {
//            navigator.pushViewController(accountsettings, animated: true)
//        }
    }
    
    func requerySuccess(_ refNo: String!, withMerchantCode merchantCode: String!, withAmount amount: String!, withResult result: String!) {
        print("SUCCESS")
    }
    
    func requeryFailed(_ refNo: String!, withMerchantCode merchantCode: String!, withAmount amount: String!, withErrDesc errDesc: String!) {
        print("FAILED")
    }
    
    

    var paymentSDK: Ipay?
    var requeryPayment: IpayPayment?
    var paymentView: UIView?
    var webView: WKWebView?
    
    //FROM THIS VIEW CONTROLLER
    var MerchantKey: String = ""
    var MerchantCode: String = ""
    var RefNo: String = ""
    var ProdDesc: String = ""
    var Remarks: String = ""
    var BackendURL: String = ""
    
    //GET FROM OTHER VIEW CONTROLLER
    var UserName: String = ""
    var UserEmail: String = ""
    var UserContact: String = ""
    var Amount: String = ""

    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        RefNo = String.random()
        MerchantKey = "8bgBOjTkij"
        MerchantCode = "M29640"
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
        requeryPayment?.userName = "Nana"
        requeryPayment?.userEmail = "nana@gmail.com"
        requeryPayment?.userContact = "1232142341"
        requeryPayment?.remark = Remarks
        requeryPayment?.lang = "ISO-8859-1"
        requeryPayment?.country = "MY"
        requeryPayment?.backendPostURL = BackendURL
        
        webView = paymentSDK!.checkout(requeryPayment) as? WKWebView
        self.view.addSubview(webView!)
    }
}
