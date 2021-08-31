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
    

        // Do any additional setup after loading the view, typically from a nib.
        
        let reachability = try! Reachability()
        
        func viewWillAppear(_ <#T##animated: Bool##Bool#>) {
            super.viewWillAppear(animated)
            DispatchQueue.main.async {
                reachability.whenReachable = { reachability in
                    if reachability.connection == .wifi {
                        print("Reachable via WiFi")
                    } else {
                        print("Reachable via Cellular")
                    }
                }
                reachability.whenUnreachable = { _ in
                    print("Not reachable")
                }

                do {
                    try reachability.startNotifier()
                } catch {
                    print("Unable to start notifier")
                }
            }
        }
        
        deinit {
            reachability.stopNotifier()
        }
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    func webView(_ WebView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {

        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let title = NSLocalizedString("OK", comment: "OK Button")
        let ok = UIAlertAction(title: title, style: .default) { (action: UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true)
        completionHandler()
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler(true)
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))

        self.present(alertController, animated: true, completion: nil)
    }

}
