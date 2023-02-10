//
//  MovieOtherDetailsCell.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import UIKit

class MovieOtherDetailsCell: UITableViewCell {


    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var movieText: UILabel!
    
    func configureCell(text:String,cell:MovieDetailsCells) {

        var localText: String = ""
        
        switch cell {
        case .movieTitleCell:
            localText = "Title: \(text)"
        case .movieRelaseDateCell:
            localText = "Release Date: \(text)"
        case .movieDescriptionCell:
            localText = "Description : \(text)"
        default : break
        }
        
        movieText.text = localText
        
        setCorners()
    }
    
    private func setCorners() {
        cellContainer.layer.cornerRadius = 10
        cellContainer.clipsToBounds = true
        cellContainer.dropShadow()
    }
    
    
    
    
}
