//
//  WebView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import WebKit
import SwiftUI

struct HTMLStringView: UIViewRepresentable {
    
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        
//        var webView = WKWebView()
//
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.scrollView.isScrollEnabled = false
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
