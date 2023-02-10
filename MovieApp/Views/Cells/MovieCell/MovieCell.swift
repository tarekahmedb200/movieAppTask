//
//  MovieCell.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    func configureCell(movie:Movie) {
        movieImage.downloadimage(path: movie.posterPath)
        movieTitle.text = movie.title
        movieReleaseDate.text = movie.releaseDate
        
        setCorners()
    }
    
    private func setCorners() {
        cellContainer.layer.cornerRadius = 10
        cellContainer.clipsToBounds = true
        cellContainer.dropShadow()
    }
}
