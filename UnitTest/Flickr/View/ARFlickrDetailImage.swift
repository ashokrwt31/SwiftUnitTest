//
//  ARFlickrDetailImage.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 13/06/22.
//

import Foundation
import UIKit

class ARFlickrDetailImage: UITableViewCell {
    @IBOutlet weak var flickrImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetUpCell()
    }
    
    private func initialSetUpCell() {
        flickrImage.contentMode = .scaleAspectFill
        flickrImage.translatesAutoresizingMaskIntoConstraints = false
        flickrImage.layer.masksToBounds = true
    }
    
    func setUpCell(_ flickrItem: ARFlickr) {
        if let imageURL = flickrItem.media["m"] {
            self.flickrImage.loadImageUsingCacheWithURLString(imageURL, true)
        }
    }
}
