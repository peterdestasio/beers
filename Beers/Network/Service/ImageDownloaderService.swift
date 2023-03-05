//
//  ImageService.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation
import UIKit

final class ImageDownloaderService {
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        self.session = URLSession.shared
        self.cache =  NSCache()
    }
    
    func getImage(imagePath: String, completionHandler: @escaping (UIImage) ->()) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let placeholder = UIImage(named: "placeholder")!
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            let url: URL! = URL(string: imagePath)
            URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            }).resume()
        }
    }
}
