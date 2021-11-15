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
    let htmlOpen =
            """
            <!DOCTYPE html>
            <html lang="ko">
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
            <style type="text/css">
            html, body {
                font: -apple-system-body;
                font-size: 16px;
                width:100%;
                height: 100%;
                margin: 0px;
                padding: 0px;
                }
            img {
                height: auto !important;
                width: \(Const.WEB_VIEW_WIDTH)px !important;
                object-fit: contain !important;
            }
            </style>
            </head>
            <body>
            """
//
//            """
//            <head>
//                <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
//                <style>
//                    body {
//                      font: -apple-system-body;
//                      font-size: 16px;
//                    }
//
//                    image {
//                        height: auto !important;
//                        width:  !important;
//                        object-fit: contain !important;
//                    }
//                </style>
//            </head>
//            <body>
//            """
    let htmlClose = "</body></html>"

    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlOpen + htmlContent + htmlClose, baseURL: nil)
        uiView.contentMode = .scaleAspectFit
        uiView.sizeToFit()
        uiView.autoresizesSubviews = true

    }
}

struct HTMLText_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView(htmlContent: String("hi!"))
    }
}
