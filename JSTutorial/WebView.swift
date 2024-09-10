//
//  WebView.swift
//  JSTutorial
//
//  Created by 황인성 on 9/7/24.
//

import SwiftUI
import WebKit

// WebView 구조체를 정의하여 WKWebView를 SwiftUI에서 사용할 수 있도록 함
//struct WebView: UIViewRepresentable {
//    let url: URL
//    
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        let request = URLRequest(url: url)
//        webView.load(request)
//        return webView
//    }
//    
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        // 업데이트가 필요한 경우, 이곳에 추가 가능
//    }
//}
//
//
class ContentController: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "serverEvent" {
            print("message name : \(message.name)")
            print("post Message : \(message.body)")
        }
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView?
    
    init(request: URLRequest) {
        self.webView = WKWebView()
        self.request = request
        self.webView?.configuration.userContentController.add(ContentController(), name: "serverEvent")
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    

    class Coordinator: NSObject {
        let parent: WebView
        
        init(parent: WebView) {
            self.parent = parent
        }
    }
}

extension WebView {
    func callJS(_ args: Any = "") {
        webView?.evaluateJavaScript("iOSToJavaScript('\(args)')") { result, error in
            if let error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            if result == nil {
                print("It's void function")
                return
            }
            
            print("Received Data \(result ?? "")")
        }
    }
}
