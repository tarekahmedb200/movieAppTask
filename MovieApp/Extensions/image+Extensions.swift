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
