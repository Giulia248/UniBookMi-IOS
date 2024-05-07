//
//  EmailController.swift
//  UniBookMi-IOS
//
//  Created by giulia.floris on 07/05/24.
//

import Foundation
import MessageUI

class EmailController: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailController()
    private override init() { }

    func sendEmail(subject:String, body:String, to:String){
        // Check if the device is able to send emails
        if !MFMailComposeViewController.canSendMail() {
            UniBookMiLog("This device cannot send emails.", true)
           return
        }
        // Create the email composer
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([to])
        mailComposer.setSubject(subject)
        mailComposer.setMessageBody(body, isHTML: false)
        EmailController.getRootViewController()?.present(mailComposer, animated: true, completion: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailController.getRootViewController()?.dismiss(animated: true, completion: nil)
    }

    static func getRootViewController() -> UIViewController? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            return window.rootViewController
        }
        return nil
    }
}
