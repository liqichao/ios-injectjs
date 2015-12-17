//
//  ViewController.swift
//  ios-test
//
//  Created by 其超 李 on 15/9/29.
//  Copyright © 2015年 其超 李. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler,WKUIDelegate {
    @IBOutlet var containerView: UIView! = nil
    var webView: WKWebView!
    
    //隐藏顶部的状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    //装载视图
    override func loadView() {
        super.loadView();
        //从服务端获取js并赋值到jsString
        let jsUrl = NSURL(string:"http://localhost:8888/example.js")
        let jsString:String?
        do{
            jsString = try String(contentsOfURL:jsUrl!, encoding: NSUTF8StringEncoding);
        }catch{
            jsString = nil;
        }
        let source = jsString;
        let contentController = WKUserContentController();
        let userScript = WKUserScript(
            source: source!,
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: false
        )
        contentController.addUserScript(userScript)
        contentController.addScriptMessageHandler(
            self,
            name: "callbackHandler"
        )
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(
            frame: self.containerView.bounds,
            configuration: config
        )
        self.view = self.webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let url = NSURL(string:"http://m.jd.com")
        let req = NSURLRequest(URL:url!)
        self.webView.UIDelegate = self
        self.webView.loadRequest(req)
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            if("\(message.body)" != "reloadjs"){
                print("\(message.body)")
            }else{
                self.webView.configuration.userContentController.removeAllUserScripts();
                let jsUrl = NSURL(string:"http://localhost:8888/example.js")
                let jsString:String?
                do{
                    jsString = try String(contentsOfURL:jsUrl!, encoding: NSUTF8StringEncoding);
                }catch{
                    jsString = nil;
                }
                let source = jsString;
                let userScript = WKUserScript(
                    source: source!,
                    injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
                    forMainFrameOnly: false
                )
                self.webView.configuration.userContentController.addUserScript(userScript);
            }
        }
    }
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (aa) -> Void in
            completionHandler()
        }))
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
}