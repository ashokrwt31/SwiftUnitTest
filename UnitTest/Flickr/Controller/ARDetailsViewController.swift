//
//  ARFlickrDetailsViewController.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 10/06/22.
//

import Foundation
import UIKit

class ARDetailsViewController: UIViewController {
    var contentHeights: [CGFloat] = [0.0, 0.0]
    
    @IBOutlet weak var flickrDetailTableView: UITableView!
    var webViewHeeight = 0.0
    var flickrItem: ARFlickr?
    var isWebViewLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAllTableViewCell()
        flickrDetailTableView.reloadData()
    }
}

extension ARDetailsViewController {
    func setupAllTableViewCell() {
        self.flickrDetailTableView.register(UINib(nibName: ARConstant.ARFlickrDetailImage, bundle: .main), forCellReuseIdentifier: ARConstant.ARFlickrDetailImage)
        self.flickrDetailTableView.register(UINib(nibName: ARConstant.ARFlickrDetailText, bundle: .main), forCellReuseIdentifier: ARConstant.ARFlickrDetailText)
    }
    
    func setupTableViewCellText(_ indexPath: IndexPath) -> UITableViewCell {
        if let cell = flickrDetailTableView.dequeueReusableCell(withIdentifier: ARConstant.ARFlickrDetailText) as? ARFlickrDetailText, let flickrItem = flickrItem {
            cell.webViewTableViewDelegate = self
            cell.setUpCell(flickrItem, isWebViewLoaded)
            return cell
        }
        return UITableViewCell()
    }
}

extension ARDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = flickrDetailTableView.dequeueReusableCell(withIdentifier: ARConstant.ARFlickrDetailImage, for: indexPath) as? ARFlickrDetailImage, let flickrItem = flickrItem, indexPath.row == 0 {
            cell.setUpCell(flickrItem)
            return cell
        }
        return self.setupTableViewCellText(indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}

extension ARDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ARDetailsViewController: ARTableViewCellWebView {
    func updateHeightForWebViewInTableCell(_ cell: ARFlickrDetailText, _ calculatedHeight: CGFloat) {
        let indexValue: IndexPath = flickrDetailTableView.indexPath(for: cell) ?? IndexPath(row: -1, section: -1)
        flickrDetailTableView.reloadRows(at: [indexValue], with: .none)
        isWebViewLoaded = true
    }
}
