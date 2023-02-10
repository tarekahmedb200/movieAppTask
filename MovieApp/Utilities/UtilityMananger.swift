//
//  UtilityMananger.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import Foundation
import UIKit
import Kingfisher


class UtitlyManager {
    static let shared = UtitlyManager()
    private var activityIndicator: UIActivityIndicatorView
    let timeOut = 30 // seconds
    
    private init() {
        activityIndicator = UIActivityIndicatorView()
    }

    func showActivityIndicator(in view:UIView) {
        activityIndicator.frame = view.frame
        activityIndicator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        activityIndicator.color = UIColor.black
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeOut)) { [weak self] in
            
            guard let weakSelf = self else {
                return
            }
            
            if weakSelf.activityIndicator.isAnimating {
                weakSelf.hideActivityIndicator()
            }
        }
        
        view.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
}
