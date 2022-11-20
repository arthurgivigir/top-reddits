//
//  UIImageView+ImageCache.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import UIKit

extension UIImageView {
    
    private static let imageCache = NSCache<AnyObject, AnyObject>()
    
    func load(_ urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            load(url)
        } else {
            image = nil
        }
    }
    
    func load(_ url: URL) {
        if let imageCached = UIImageView.imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageCached
            
        } else {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                        
                        UIImageView.imageCache.setObject(image, forKey: url as AnyObject)
                    }
                }
            }
        }
    }
}
