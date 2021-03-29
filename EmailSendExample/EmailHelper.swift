//
//  EmailHelper.swift
//  EmailSendExample
//
//  Created by Russell Gordon on 2021-03-29.
//
//  Original source for code: https://levelupprogramming.net/how-to-send-email-in-swiftui-5a9047e3442f
//

import Foundation
import MessageUI

enum EmailSendError: Error {
  case noMailClientConfigured
}

class EmailHelper: NSObject, MFMailComposeViewControllerDelegate {
    
    public static let shared = EmailHelper()
    
    private override init() {
        //
    }
    
    func sendEmail(subject:String, body:String, to:String, isHTML: Bool = false) throws {
        
        if !MFMailComposeViewController.canSendMail() {
            
            print("No mail account found")
            throw EmailSendError.noMailClientConfigured
            
        }
        
        let picker = MFMailComposeViewController()
        
        picker.setSubject(subject)
        picker.setMessageBody(body, isHTML: isHTML)
        picker.setToRecipients([to])
        picker.mailComposeDelegate = self
        
        EmailHelper.getRootViewController()?.present(picker, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        EmailHelper.getRootViewController()?.dismiss(animated: true, completion: nil)
        
    }
    
    static func getRootViewController() -> UIViewController? {
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController
        
//         OR If you use SwiftUI 2.0 based WindowGroup try this one
         UIApplication.shared.windows.first?.rootViewController
    }
}
