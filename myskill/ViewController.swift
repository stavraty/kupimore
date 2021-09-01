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
import SwiftUI

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    //MARK:- Variable Declarations
    
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showAlertSheet = false

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
// NetworkMonitor
    var body: some View {
        VStack {
            Image(systemName: monitor.isConnected ? "wifi" : "wifi.slash")
                .font(.system(size: 56))
            Text(monitor.isConnected ? "Connected!" : "Not connected")
                .padding()
            
            Button("Perfom Network Request") {
                self.showAlertSheet = true
            }
        }.alert(isPresented: $showAlertSheet, content: {
            if monitor.isConnected {
                return Alert(title: Text("Success!"), message: Text("The network request can be performed."), dismissButton: .default(Text("OK")))
            }
            return Alert(title: Text("No Internet Connection"), message: Text("Please enable WiFi or Cellular data"), dismissButton: .default(Text("Cansel")))
        })
        }
    }
// NetworkMonitor

