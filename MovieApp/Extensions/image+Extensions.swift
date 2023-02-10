//
//  image+Extensions.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation


import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func downloadimage(path:String) {
        self.kf.setImage(with: movieDBURL.getPosterImage(path: path).url)
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
        layer.cornerRadius = 10.0
    }
}
