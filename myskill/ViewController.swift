//
//  ViewController.swift
//  myskill
//
//  Created by Private Capacity Ltd on 04.08.2020.
//  Copyright © 2020 PRIVATE CAPACITY LTD. All rights reserved.
//

//
//  ViewController.swift
//  myskill
//
//  Created by Private Capacity Ltd on 04.08.2020.
//  Copyright © 2020 PRIVATE CAPACITY LTD. All rights reserved.
//

import UIKit
import WebKit

let reachability = try! Reachability()

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    //MARK:- Variable Declarations

    @IBOutlet var mWKWebView: WKWebView!
    
    //MARK:- ViewController LifeCycle Methods

    override func viewDidLoad() {

        super.viewDidLoad()
        
        mWKWebView = WKWebView(frame: self.view.frame)
        mWKWebView.uiDelegate = self
        mWKWebView.navigationDelegate = self
        view.addSubview(mWKWebView)

        let url = URL(string: "https://kupimore.ru")
        let request = URLRequest(url: url!)

        mWKWebView.load(request)
        
      // R
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via wifi")
            }else{
                print("Reachable via cellular")
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.showAlert()
        }
        
        do {
        try reachability.startNotifier()
        }catch{
            print("unable to start notifier")
        }
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "No internet", message: "This App Requires wifi/internet connection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default Action"),
                                      style: .default, handler: {_ in
                                        NSLog("The \"OK \" alert occured.")
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
}


