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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (documentsDirectory as NSString).appendingPathComponent("foo.pdf") as String

        let pdfTitle = "Swift-Generated PDF"
        let pdfMetadata = [
            // The name of the application creating the PDF.
            kCGPDFContextCreator: "Your iOS App",

            // The name of the PDF's author.
            kCGPDFContextAuthor: "Foo Bar",

            // The title of the PDF.
            kCGPDFContextTitle: "Lorem Ipsum",

            // Encrypts the document with the value as the owner password. Used to enable/disable different permissions.
            kCGPDFContextOwnerPassword: "myPassword123"
        ]

        // Creates a new PDF file at the specified path.
        UIGraphicsBeginPDFContextToFile(filePath, CGRect.zero, pdfMetadata)

        // Creates a new page in the current PDF context.
        UIGraphicsBeginPDFPage()

        // Default size of the page is 612x72.
        let pageSize = UIGraphicsGetPDFContextBounds().size
        let font = UIFont.preferredFont(forTextStyle: .largeTitle)

        // Let's draw the title of the PDF on top of the page.
        let attributedPDFTitle = NSAttributedString(string: pdfTitle, attributes: [NSAttributedString.Key.font: font])
        let stringSize = attributedPDFTitle.size()
        let stringRect = CGRect(x: (pageSize.width / 2 - stringSize.width / 2), y: 20, width: stringSize.width, height: stringSize.height)
        attributedPDFTitle.draw(in: stringRect)

        // Closes the current PDF context and ends writing to the file.
        UIGraphicsEndPDFContext()

        let pdfView = PDFView(frame: view.bounds)
        pdfView.autoScales = true
        view.addSubview(pdfView)

        // Create a `PDFDocument` object and set it as `PDFView`'s document to load the document in that view.
        let pdfDocument = PDFDocument(url: URL(fileURLWithPath: filePath))!
        pdfView.document = pdfDocument
    }
}
