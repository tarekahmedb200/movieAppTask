//
//  MovieImageCell.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import UIKit

class MovieImageCell: UITableViewCell {

    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var movieImage: UIImageView! {
        didSet {
            movieImage.layer.cornerRadius = 10
        }
    }
    
    func configureCell(posterPath:String) {
        movieImage.downloadimage(path: posterPath)
        
        setCorners()
    }
    
    private func setCorners() {
        cellContainer.layer.cornerRadius = 10
        cellContainer.clipsToBounds = true
        cellContainer.dropShadow()
    }
    
}
