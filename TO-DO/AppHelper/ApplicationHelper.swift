//
//  ApplicationHelper.swift
//  TO-DO
//
//  Created by Ravi on 29/08/17.
//  Copyright © 2017 UMAI. All rights reserved.
//

import UIKit


class ApplicationHelper: NSObject {
    

    // MARK: For valid Fields
   static func isEmptyOrWhitespace(string:String) -> Bool {
        if (string.isEmpty) {
            return true
        }
    
        return (string.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty)
    }
    
    // MARK: For alert
    static func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert);
        let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okBtn)
        vc.present(alert, animated: true, completion: nil)
    }
    
    

  
}
