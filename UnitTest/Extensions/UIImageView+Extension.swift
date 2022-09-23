//
//  UIImageView+Extension.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 09/06/22.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCacheWithURLString(_ urlString: String, _ cache: Bool) {
        self.image = nil
        
        if let cacheImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cacheImage
            return
        }
        let indicator = ARActivityIndicator()
        indicator.startIndicatorView(self)
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, _, error) in
                indicator.hideIndicatorView()
                if error != nil {
                    self?.loadImageUsingCacheWithURLString(ARConstant.PlaceHolderImage, false)
//                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        if let downloadImage = UIImage(data: data) {
                            if cache {
                                imageCache.setObject(downloadImage, forKey: NSString(string: urlString))
                            }
                            self?.image = downloadImage
                        }
                        else {
                            self?.loadImageUsingCacheWithURLString(ARConstant.PlaceHolderImage, false)
                        }
                    }
                }
                
            }).resume()
        }
        else {
            self.loadImageUsingCacheWithURLString(ARConstant.PlaceHolderImage, false)
        }
    }
    
    
    func asynAwaitloadImageUsingCacheWithURLString(_ urlString: String) async {
        self.image = nil
        
        if let cacheImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cacheImage
        }
        let indicator = ARActivityIndicator()
        indicator.startIndicatorView(self)
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
//                print(response.debugDescription)
                indicator.hideIndicatorView()
                if error != nil {
//                    print("\(error.debugDescription)")
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        if let downloadImage = UIImage(data: data) {
                            imageCache.setObject(downloadImage, forKey: NSString(string: urlString))
                            self.image = downloadImage
                        }
                    }
                }
            }).resume()
        }
    }
}


extension UIImage {
  
 func createImage() -> UIImage? {
    let size = CGSize(width: 20, height: 22)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    defer  { UIGraphicsEndImageContext() }
     
    UIColor.clear.set()
    let rect = CGRect(origin: .zero, size: size)
    UIRectFill(CGRect(origin: .zero, size: size))
    (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 15)])
    
    return UIGraphicsGetImageFromCurrentImageContext()
  }
    
    func makeImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), false, 0)

        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.setFillColor(UIColor.red.cgColor)
            ctx.setStrokeColor(UIColor.green.cgColor)
            ctx.setLineWidth(10)

            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
            ctx.addEllipse(in: rectangle)
            ctx.drawPath(using: .fillStroke)
        }

        
        defer { UIGraphicsEndImageContext() }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

