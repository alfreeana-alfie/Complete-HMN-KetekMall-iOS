//
//  DetailViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 24/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, PaymentResultDelegate {
    func paymentSuccess(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withAuthCode authCode: String!) {
        print("SUCCESS")
    }
    
    func paymentFailed(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withErrDesc errDesc: String!) {
        print("FAILED")
    }
    
    func paymentCancelled(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withErrDesc errDesc: String!) {
        print("CANCEL")
    }
    
    func requerySuccess(_ refNo: String!, withMerchantCode merchantCode: String!, withAmount amount: String!, withResult result: String!) {
        print("REQUERY SUCCESS")
    }
    
    func requeryFailed(_ refNo: String!, withMerchantCode merchantCode: String!, withAmount amount: String!, withErrDesc errDesc: String!) {
        print("REQUERY FAILED")
    }
    

    var paymentSDK: Ipay?
    var requeryPayment: IpayPayment?
    var paymentView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        paymentSDK?.delegate = self
        paymentSDK = Ipay()
        
        requeryPayment = IpayPayment()
        requeryPayment?.paymentId = ""
        requeryPayment?.merchantKey = "apple88KEY"
        requeryPayment?.merchantCode = "M09999"
        requeryPayment?.refNo = "ORD1188"
        requeryPayment?.amount = "1.00"
        requeryPayment?.currency = "MYR"
        requeryPayment?.prodDesc = "Payment"
        requeryPayment?.userName = "Nana"
        requeryPayment?.userEmail = "nana@gmail.com"
        requeryPayment?.userContact = "1232142341"
        requeryPayment?.remark = "ORD1188"
        requeryPayment?.lang = "ISO-8859-1"
        requeryPayment?.country = "MY"
        requeryPayment?.backendPostURL = "https://ketekmall.com/ketekmall/backendURL.php"

        paymentView = paymentSDK?.checkout(requeryPayment)
//        customView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 200)
//        paymentView.backgroundColor = UIColor.black     //give color to the view
//        paymentView.center = self.view.center
        
        self.view.addSubview(paymentView!)
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
