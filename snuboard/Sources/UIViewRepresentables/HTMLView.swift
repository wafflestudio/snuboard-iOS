//
//  HTMLView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/31.
//
// Reference: https://hiswings.blogspot.com/2020/06/swiftui-html.html

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
        
    let htmlContent: String
    let htmlOpen = """
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
                <style>
                    body {
                      font: -apple-system-body;
                      font-size: 16px;
                    }
            
                    image {
                        width: 100%;
                    }
            
                
                </style>
            </head>
            <body>
            """
    let htmlClose = "</body>"

    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlOpen + htmlContent + htmlClose, baseURL: nil)
    }
}

struct HTMLText_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView(htmlContent: String("hi!"))
    }
}
