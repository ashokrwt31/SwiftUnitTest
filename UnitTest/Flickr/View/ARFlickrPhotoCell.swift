//
//  ARFlickrPhotoCell.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 11/05/22.
//

import Foundation
import UIKit

class ARFlickrPhotoCell: UICollectionViewCell {
    @IBOutlet weak var flickrPhotoCell: UIImageView!
    
    var addButtonTapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    private func setupCell() {
        flickrPhotoCell.contentMode = .scaleAspectFill
        flickrPhotoCell.translatesAutoresizingMaskIntoConstraints = false
        flickrPhotoCell.backgroundColor = .lightGray
        flickrPhotoCell.layer.masksToBounds = true
        flickrPhotoCell.layer.borderColor = UIColor.lightGray.cgColor
        flickrPhotoCell.layer.borderWidth = 1.0
        flickrPhotoCell.layer.cornerRadius = 5.0
    }
    
    func configureFlickrPhotoCell(_ flickr: ARFlickr?) {
        if let imageURL = flickr?.media["m"] {
            self.flickrPhotoCell.loadImageUsingCacheWithURLString(imageURL, true)
        }
    }
    
    func asyncAwaitPhoto(_ flickr: ARFlickr?) async {
        if let imageURL = flickr?.media["m"] {
                await self.flickrPhotoCell.asynAwaitloadImageUsingCacheWithURLString(imageURL)
                self.flickrPhotoCell.image = self.flickrPhotoCell.image?.makeImage()
        }
    }
    
    @IBAction func navigateToDetailScreen(_ sender: Any) {
        addButtonTapAction?()
    }
}
