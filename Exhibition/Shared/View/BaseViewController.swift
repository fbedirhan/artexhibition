//
//  BaseViewController.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 3.08.2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var activityView: UIActivityIndicatorView?

    override func viewDidLoad() {
       super.viewDidLoad()
    }

    private func showActivityIndicator() {
        if activityView == nil {
            activityView = UIActivityIndicatorView(style: .large)
            activityView?.center = self.view.center
            self.view.addSubview(activityView!)
        }
        activityView?.startAnimating()
    }

    private func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    /// set navigation bar with large title
    func setNavigationBarForLargeTitle(title: String?) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = title
        navigationController?.navigationBar.sizeToFit()
    }
    
    /// Function to show the alert
    func showAlert(title: String, message: String, callback: CallbackVoid? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            callback?()
        }
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Function to show the alert for error case
    func showErrorAlert(message: String?) {
        let errorMessage = message ?? "Internal Server Error"
        showAlert(title: "Error", message: errorMessage)
    }
    
    /// Function to show and hide indicator based on status parameter
    func progress(status: Bool) {
        if status {
            showActivityIndicator()
        } else {
            hideActivityIndicator()
        }
    }
}
