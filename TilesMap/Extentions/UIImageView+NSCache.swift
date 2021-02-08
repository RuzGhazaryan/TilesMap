//
//  UIImageView+NSCache.swift
//  News
//
//  Created by Ruzanna Ghazaryan on 2/6/21.
//  Copyright © 2020 Ruzanna Ghazaryan. All rights reserved.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImage(urlString: String, placeholderImage: UIImage? = nil){
        self.loadImage(urlString: urlString, placeholderImage: placeholderImage) { (url, image) in
            self.image = image
        }
    }
    
    private func loadImage(urlString: String, placeholderImage:UIImage? = nil, completion: @escaping (String, UIImage) -> ()){
        self.image = placeholderImage
        guard let url = URL(string: urlString) else {
            return
        }
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            completion(urlString, imageFromCache)
            return
        }
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data) else {
                        return
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    completion(url.absoluteString, imageToCache)
                }
            }
        }.resume()
    }
}
