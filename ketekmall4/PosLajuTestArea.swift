//
//  PosLajuTestArea.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 20/12/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import PDFKit

class PosLajuTestArea: UIViewController {
    
    let pageWidth = 420;
    let pageHeight = 595;
    
    //INFORMATION
    var DATE: String = "";
    var WEIGHT: String = "";
    var ORDERID: String = "";
    var SELLERNAME: String = "";
    var SELLERPHONE: String = "";
    var SELLERADDRESS: String = "";
    var POSTCODE: String = "";
    var RECEIVERNAME: String = "";
    var RECEIVERPHONE: String = "";
    var ACCOUNTNO: String = "";
    var RECEIVERADDRESS: String = "";
    var RECEIVERADDRESS01: String = "";
    var RECEIVERADDRESS02: String = "";
    var RECEIVERCITY: String = "";
    var RECEIVERPROVINCE: String = "";
    var RECEIVEREMAIL: String = "";
    var RECEIVERPOSTCODE: String = "";
    var ROUTINGCODE: String = "";
    var CONNOTENO: String = "";

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (documentsDirectory as NSString).appendingPathComponent("PosLaju\(DATE).pdf") as String

        let pdfMetadata = [
            // The name of the application creating the PDF.
            kCGPDFContextCreator: "KetekMall",

            // The name of the PDF's author.
            kCGPDFContextAuthor: "HMNNadhir",

            // The title of the PDF.
            kCGPDFContextTitle: "Pos Laje Consignment Note PDF",

            // Encrypts the document with the value as the owner password. Used to enable/disable different permissions.
            kCGPDFContextOwnerPassword: "HMNNADHIR123"
        ]

        // Creates a new PDF file at the specified path.
        UIGraphicsBeginPDFContextToFile(filePath, CGRect.zero, pdfMetadata)

        // Creates a new page in the current PDF context.
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), nil);
        
        // Let's draw the title of the PDF on top of the page.
        let font = UIFont.preferredFont(forTextStyle: .body).withSize(10)
        
        let ArialParaBody = UIFont(name: "Arial", size: 10)
        let ArialParaBodyBOLD = UIFont(name: "Arial Bold", size: 10)
        let ArialParaBodyLARGER = UIFont(name: "Arial", size: 22)
        let ArialParaBodyBOLDLARGER = UIFont(name: "Arial Bold", size: 26)
        let ArialParaBodyBOLDLARGER02 = UIFont(name: "Arial Bold", size: 16)
        
        let paraStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paraStyle.alignment = .left
        paraStyle.lineBreakMode = .byWordWrapping
        
        let paraStyle2 = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paraStyle2.alignment = .center
        paraStyle2.lineBreakMode = .byWordWrapping
        
        let paraStyle3 = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paraStyle3.alignment = .left
        paraStyle3.lineBreakMode = .byWordWrapping
        
        let ParaNormal = [NSAttributedString.Key.font: ArialParaBody,
                          NSAttributedString.Key.paragraphStyle: paraStyle] as [NSAttributedString.Key : Any]
        let ParaBold = [NSAttributedString.Key.font: ArialParaBodyBOLD,
                        NSAttributedString.Key.paragraphStyle: paraStyle] as [NSAttributedString.Key : Any]
        let ParaLarge = [NSAttributedString.Key.font: ArialParaBodyLARGER,
                         NSAttributedString.Key.paragraphStyle: paraStyle2] as [NSAttributedString.Key : Any]
        let ParaBoldLarge = [NSAttributedString.Key.font: ArialParaBodyBOLDLARGER,
                         NSAttributedString.Key.paragraphStyle: paraStyle2] as [NSAttributedString.Key : Any]
        let ParaBoldLarge02 = [NSAttributedString.Key.font: ArialParaBodyBOLDLARGER02,
                         NSAttributedString.Key.paragraphStyle: paraStyle3] as [NSAttributedString.Key : Any]
        
        let context = UIGraphicsGetCurrentContext()
        
        // Design - Outer Border
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setLineWidth(2)
        let rect = CGRect(x: 5, y: 5, width: pageWidth - 5, height: pageHeight - 5)
        context!.stroke(rect)
        
        // Logo & Barcode
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setLineWidth(1)
        let logoBorder = CGRect(x: 12, y: 9, width: 400, height: 75)
        context!.stroke(logoBorder)
        
        // Order Details - 01
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setLineWidth(1)
        let OrderDetail = CGRect(x: 12, y: 90, width: 251, height: 99)
        context!.stroke(OrderDetail)
        
        context!.setFillColor(UIColor.gray.cgColor)
        let OrderDetailTitle = CGRect(x: 12, y: 90, width: 251, height: 15)
        context!.fill(OrderDetailTitle)
        
        let barcodeABOVE = generateBarcode(from: CONNOTENO)
        let BarCodeABOVERECT = CGRect(x: 245, y: 15, width: 150, height: 55)
        barcodeABOVE?.draw(in: BarCodeABOVERECT)
        
        let BarCodeTEXTABOVE = NSAttributedString(string: CONNOTENO, attributes: ParaBold)
        let BarCodeTEXTABOVERECT = CGRect(x: 280, y: 65, width: 100, height: 170)
        BarCodeTEXTABOVE.draw(in: BarCodeTEXTABOVERECT)

        let PosLajuImage = UIImage(named: "PosLaju-black")
        let PosLajuImageRECT = CGRect(x: 14, y: 18, width: 100, height: 60)
        PosLajuImage?.draw(in: PosLajuImageRECT)
        
        let KetekMallImage = UIImage(named: "KetekMallx512_black")
        let KetekMallImageRECT = CGRect(x: 115, y: 18, width: 60, height: 60)
        KetekMallImage?.draw(in: KetekMallImageRECT)
        
        // LEFT
        let OrderTitle = UILabel()
        OrderTitle.text = "Order Details"
        OrderTitle.textColor = UIColor.white
        OrderTitle.font = UIFont(name: "Arial Bold", size: 12)
        OrderTitle.adjustsFontSizeToFitWidth = true
        let OrderTitleRECT = CGRect(x: 14, y: 90, width: 251, height: 15)
        OrderTitle.drawText(in: OrderTitleRECT)
        
        let ShipDateLeft = NSAttributedString(string: "Ship By Date:", attributes: ParaNormal)
        let ShipDateLeftRECT = CGRect(x: 14, y: 105, width: 251, height: 15)
        ShipDateLeft.draw(in: ShipDateLeftRECT)
        
        let WeightLeft = NSAttributedString(string: "Weight (kg):", attributes: ParaNormal)
        let WeightLeftRECT = CGRect(x: 14, y: 117, width: 251, height: 15)
        WeightLeft.draw(in: WeightLeftRECT)
        
        let OrderIDLeft = NSAttributedString(string: "Order ID:", attributes: ParaNormal)
        let OrderIDLeftRECT = CGRect(x: 14, y: 129, width: 251, height: 15)
        OrderIDLeft.draw(in: OrderIDLeftRECT)
        
        // RIGHT
        let ShipDateRight = NSAttributedString(string: DATE, attributes: ParaNormal)
        let ShipDateRightRECT = CGRect(x: 85, y: 105, width: 251, height: 15)
        ShipDateRight.draw(in: ShipDateRightRECT)
        
        let WeightRight = NSAttributedString(string: WEIGHT, attributes: ParaNormal )
        let WeightRightRECT = CGRect(x: 85, y: 117, width: 251, height: 15)
        WeightRight.draw(in: WeightRightRECT)
        
        let OrderIDRight = NSAttributedString(string: ORDERID, attributes: ParaBold)

        let OrderIDRightRECT = CGRect(x: 85, y: 129, width: 251, height: 15)
        OrderIDRight.draw(in: OrderIDRightRECT)
        
        // Order Details - 02
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setLineWidth(1)
        let OrderDetailCourier = CGRect(x: 268, y: 90, width: 143, height: 99)
        context!.stroke(OrderDetailCourier)
        
        context!.setFillColor(UIColor.gray.cgColor)
        let OrderDetailTitle02 = CGRect(x: 268, y: 90, width: 143, height: 15)
        context!.fill(OrderDetailTitle02)
        
        let OrderTitle02 = UILabel()
        OrderTitle02.text = "Order Details (Courier)"
        OrderTitle02.textColor = UIColor.white
        OrderTitle02.font = UIFont(name: "Arial Bold", size: 12)
        let OrderTitle02RECT = CGRect(x: 270, y: 90, width: 143, height: 15)
        OrderTitle02.drawText(in: OrderTitle02RECT)
        
        let AccountNo = NSAttributedString(string: "Account Number:", attributes: ParaBoldLarge02)
        let AccountNoRECT = CGRect(x: 273, y: 110, width: 143, height: 45)
        AccountNo.draw(in: AccountNoRECT)
        
        let Number = NSAttributedString(string: ACCOUNTNO, attributes: ParaBoldLarge02)
        let NumberRECT = CGRect(x: 273, y: 125, width: 143, height: 45)
        Number.draw(in: NumberRECT)
        
        let Product = NSAttributedString(string: "Product: Courier Charges Domestic", attributes: ParaNormal)
        let ProductRECT = CGRect(x: 273, y: 145, width: 143, height: 45)
        Product.draw(in: ProductRECT)
        
        let Type = NSAttributedString(string: "Type: Document", attributes: ParaNormal)
        let TypeRECT = CGRect(x: 273, y: 170, width: 143, height: 45)
        Type.draw(in: TypeRECT)
        // Sender, Receiver, POD
        /// Sender Details
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setLineWidth(1)
        let SenderBorder = CGRect(x: 12, y: 197, width: 251, height: 150)
        context!.stroke(SenderBorder)
        
        context!.setFillColor(UIColor.gray.cgColor)
        let SenderTitle = CGRect(x: 12, y: 197, width: 251, height: 15)
        context!.fill(SenderTitle)
        
        let Sender = UILabel()
        Sender.text = "Sender Details (Pengirim)"
        Sender.textColor = UIColor.white
        Sender.font = UIFont(name: "Arial Bold", size: 12)
        let SenderRECT = CGRect(x: 14, y: 197, width: 251, height: 15)
        Sender.drawText(in: SenderRECT)
                
        let SenderNameLeft = NSAttributedString(string: "Name:", attributes: ParaNormal)
        let SenderNameLeftRECT = CGRect(x: 14, y: 212, width: 251, height: 15)
        SenderNameLeft.draw(in: SenderNameLeftRECT)
        
        let SenderPhoneLeft = NSAttributedString(string: "Phone:", attributes: ParaNormal)
        let SenderPhoneLeftRECT = CGRect(x: 14, y: 248, width: 251, height: 15)
        SenderPhoneLeft.draw(in: SenderPhoneLeftRECT)
        
        let SenderAddressLeft = NSAttributedString(string: "Address:", attributes: ParaNormal)
        let SenderAddressLeftRECT = CGRect(x: 14, y: 260, width: 251, height: 15)
        SenderAddressLeft.draw(in: SenderAddressLeftRECT)
        
        let SenderPostcodeLeft = NSAttributedString(string: "Postcode:", attributes: ParaNormal)
        let SenderPostcodeLeftRECT = CGRect(x: 14, y: 333, width: 251, height: 15)
        SenderPostcodeLeft.draw(in: SenderPostcodeLeftRECT)
        
        // RIGHT
        let SenderNameRight = NSAttributedString(string: SELLERNAME, attributes: ParaNormal)
        let SenderNameRightRECT = CGRect(x: 85, y: 212, width: 130, height: 150)
        SenderNameRight.draw(in: SenderNameRightRECT)
        
        let SenderPhoneRight = NSAttributedString(string: SELLERPHONE, attributes: ParaNormal)
        let SenderPhoneRightRECT = CGRect(x: 85, y: 248, width: 251, height: 15)
        SenderPhoneRight.draw(in: SenderPhoneRightRECT)
        
        let SenderAddressRight = NSAttributedString(string: SELLERADDRESS, attributes: ParaNormal)
        let SenderAddressRightRECT = CGRect(x: 85, y: 260, width: 130, height: 150)
        SenderAddressRight.draw(in: SenderAddressRightRECT)
        
        let SenderPostcodeRight = NSAttributedString(string: POSTCODE, attributes: ParaNormal)
        let SenderPostcodeRightRECT = CGRect(x: 85, y: 333, width: 251, height: 15)
        SenderPostcodeRight.draw(in: SenderPostcodeRightRECT)
        
        /// Receiver Details
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setLineWidth(1)
        let ReceiverBorder = CGRect(x: 12, y: 348, width: 251, height: 150)
        context!.stroke(ReceiverBorder)
        
        context!.setFillColor(UIColor.gray.cgColor)
        let ReceiverTitle = CGRect(x: 12, y: 348, width: 251, height: 15)
        context!.fill(ReceiverTitle)
        
        let Receiver = UILabel()
        Receiver.text = "Recipient Details (Penerima)"
        Receiver.textColor = UIColor.white
        Receiver.font = UIFont(name: "Arial Bold", size: 12)
        let ReceiverRECT = CGRect(x: 14, y: 348, width: 251, height: 15)
        Receiver.drawText(in: ReceiverRECT)
        
        // LEFT
        let ReceiverNameLeft = NSAttributedString(string: "Name:", attributes: ParaNormal)
        let ReceiverNameLeftRECT = CGRect(x: 14, y: 363, width: 251, height: 15)
        ReceiverNameLeft.draw(in: ReceiverNameLeftRECT)
        
        let ReceiverPhoneLeft = NSAttributedString(string: "Phone:", attributes: ParaNormal)
        let ReceiverPhoneLeftRECT = CGRect(x: 14, y: 411, width: 251, height: 15)
        ReceiverPhoneLeft.draw(in: ReceiverPhoneLeftRECT)
        
        let ReceiverAddressLeft = NSAttributedString(string: "Address:", attributes: ParaNormal)
        let ReceiverAddressLeftRECT = CGRect(x: 14, y: 426, width: 251, height: 15)
        ReceiverAddressLeft.draw(in: ReceiverAddressLeftRECT)
        
        let ReceiverPostcodeLeft = NSAttributedString(string: "Postcode:", attributes: ParaNormal)
        let ReceiverPostcodeLeftRECT = CGRect(x: 14, y: 484, width: 251, height: 15)
        ReceiverPostcodeLeft.draw(in: ReceiverPostcodeLeftRECT)
        
        // RIGHT
        let ReceiverNameRight = NSAttributedString(string: RECEIVERNAME, attributes: ParaNormal)
        let ReceiverNameRightRECT = CGRect(x: 85, y: 363, width: 130, height: 150)
        ReceiverNameRight.draw(in: ReceiverNameRightRECT)
        
        let ReceiverPhoneRight = NSAttributedString(string: RECEIVERPHONE, attributes: ParaNormal)
        let ReceiverPhoneRightRECT = CGRect(x: 85, y: 411, width: 251, height: 15)
        ReceiverPhoneRight.draw(in: ReceiverPhoneRightRECT)
        
        let ReceiverAddressRight = NSAttributedString(string: RECEIVERADDRESS, attributes: ParaNormal)
        let ReceiverAddressRightRECT = CGRect(x: 85, y: 426, width: 130, height: 150)
        ReceiverAddressRight.draw(in: ReceiverAddressRightRECT)
        
        let ReceiverPostcodeRight = NSAttributedString(string: RECEIVERPOSTCODE, attributes: ParaNormal)
        let ReceiverPostcodeRightRECT = CGRect(x: 85, y: 484, width: 251, height: 15)
        ReceiverPostcodeRight.draw(in: ReceiverPostcodeRightRECT)
        
        /// POD
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setLineWidth(1)
        let PODBorder = CGRect(x: 12, y: 499, width: 251, height: 80)
        context!.stroke(PODBorder)
        
        context!.setFillColor(UIColor.gray.cgColor)
        let PODTitle = CGRect(x: 12, y: 499, width: 251, height: 15)
        context!.fill(PODTitle)
        
        let POD = UILabel()
        POD.text = "POD"
        POD.textColor = UIColor.white
        POD.font = UIFont(name: "Arial Bold", size: 12)
        let PODRECT = CGRect(x: 14, y: 499, width: 251, height: 15)
        POD.drawText(in: PODRECT)

        // LEFT
        let PODLeft = NSAttributedString(string: "Name:", attributes: [NSAttributedString.Key.font: font])
        let PODLeftRECT = CGRect(x: 14, y: 514, width: 251, height: 15)
        PODLeft.draw(in: PODLeftRECT)
        
        let PODICLeft = NSAttributedString(string: "I.C.:", attributes: [NSAttributedString.Key.font: font])
        let PODICLeftRECT = CGRect(x: 14, y: 529, width: 251, height: 15)
        PODICLeft.draw(in: PODICLeftRECT)
        
        let PODSignatureLeft = NSAttributedString(string: "Signature:", attributes: [NSAttributedString.Key.font: font])
        let PODSignatureLeftRECT = CGRect(x: 14, y: 544, width: 251, height: 15)
        PODSignatureLeft.draw(in: PODSignatureLeftRECT)

        // QR CODE
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setLineWidth(1)
        let QRBorder = CGRect(x: 268, y: 197, width: 143, height: 382)
        context!.stroke(QRBorder)
        
        context!.setStrokeColor(UIColor.black.cgColor)
        context!.setLineWidth(1)
        let QRBorder1 = CGRect(x: 268, y: 227, width: 143, height: 70)
        context!.stroke(QRBorder1)
        
        let RoutingCode = NSAttributedString(string: ROUTINGCODE, attributes: ParaLarge)
        let RoutingCodeRECT = CGRect(x: 290, y: 237, width: 100, height: 170)
        RoutingCode.draw(in: RoutingCodeRECT)
        
        let POSTCODE = NSAttributedString(string: RECEIVERPOSTCODE, attributes: ParaBoldLarge)
        let POSTCODERECT = CGRect(x: 290, y: 317, width: 100, height: 170)
        POSTCODE.draw(in: POSTCODERECT)
        
        let barcode = generateBarcode(from: CONNOTENO)
        let BarCodeRECT = CGRect(x: 278, y: 500, width: 125, height: 60)
        barcode?.draw(in: BarCodeRECT)
        
        let BarCodeTEXTBELOW = NSAttributedString(string: CONNOTENO, attributes: ParaNormal)
        let BarCodeTEXTBELOWRECT = CGRect(x: 300, y: 555, width: 100, height: 170)
        BarCodeTEXTBELOW.draw(in: BarCodeTEXTBELOWRECT)
        
        let image = generateQRCode(from: "A2^\(CONNOTENO)^\(DATE)^MY^\(ORDERID)^\(SELLERNAME)^\(SELLERPHONE)^\(SELLERPHONE)^^\(POSTCODE)^\(ACCOUNTNO)\(RECEIVERNAME)^^\(RECEIVERADDRESS01)^\(RECEIVERADDRESS02)^\(RECEIVERPOSTCODE)^\(RECEIVERCITY)^\(RECEIVERPROVINCE)^\(RECEIVERPHONE)^\(RECEIVEREMAIL)^\(WEIGHT)^^^^^^\("Document")^")
        let QRCODERECT = CGRect(x: 320, y: 400, width: 51, height: 51)
        image?.draw(in: QRCODERECT)
        
        // Creates a new page in the current PDF context.
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), nil);
        
        UIGraphicsEndPDFContext()

        let pdfView = PDFView(frame: view.bounds)
        pdfView.autoScales = true
        view.addSubview(pdfView)

        // Create a `PDFDocument` object and set it as `PDFView`'s document to load the document in that view.
        let pdfDocument = PDFDocument(url: URL(fileURLWithPath: filePath))!
        pdfView.document = pdfDocument
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}
