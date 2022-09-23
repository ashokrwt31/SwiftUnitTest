//
//  ARFlickrDetailText.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 13/06/22.
//

import Foundation
import UIKit
import WebKit

protocol ARTableViewCellWebView {
    func updateHeightForWebViewInTableCell(_ cell: ARFlickrDetailText, _ calculatedHeight: CGFloat)
}

class ARFlickrDetailText: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var taggedLabel: UILabel!
    @IBOutlet weak var descriptionWebView: WKWebView!
    @IBOutlet weak var heightLayoutConstraint: NSLayoutConstraint!
    var isWebViewLoaded = false
    
    var webViewTableViewDelegate: ARTableViewCellWebView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialCellSetup()
    }
    
    private func initialCellSetup() {
        descriptionWebView.navigationDelegate = self
    }
    
    func setUpCell(_ flickrItem: ARFlickr, _ isWebViewLoaded: Bool) {
        self.isWebViewLoaded = isWebViewLoaded
        titleLabel.text = flickrItem.title
        authorLabel.text = flickrItem.author
        publishedLabel.text = flickrItem.published
        taggedLabel.text = flickrItem.tags
        
        let htmlStart = "<HTML><HEAD><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"></HEAD><BODY>"
            let htmlEnd = "</BODY></HTML>"
            let htmlString = "\(htmlStart)\(flickrItem.description)\(htmlEnd)"
        descriptionWebView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    }
}

extension ARFlickrDetailText: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, _) in
            if complete != nil {
                webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, _) in
                    if !self.isWebViewLoaded {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                            self.heightLayoutConstraint.constant = self.descriptionWebView.scrollView.contentSize.height
                            self.webViewTableViewDelegate?.updateHeightForWebViewInTableCell(self, self.descriptionWebView.scrollView.contentSize.height)
                        }
                    }
                })
            }
        })
    }
}
