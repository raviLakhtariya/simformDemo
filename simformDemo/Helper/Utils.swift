//
//  Utils.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import UIKit

class Utils{

    static func displayAlert(alertMessage:String,viewController:UIViewController)
    {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            viewController.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }

    static func displayErrorAlert(viewController:UIViewController)
    {
        let errorAlert = UIAlertController(title: "Alert", message: "Something went wrong, please try again later", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        viewController.present(errorAlert, animated: true)
    }
    
    static func convertDateFormater(_ date: Date) -> Date
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let date = dateFormatter.string(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return dateFormatter.date(from: date)!

        }
}
