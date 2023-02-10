//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel : MovieDetailsViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCells()
        setupObserver()
    }

    
    static func instantiate(with ViewModel: MovieDetailsViewModel) -> MovieDetailsViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        
        guard let movieDetailsViewController = storyBoard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController
        else {
            return nil
        }
        
        movieDetailsViewController.viewModel = ViewModel
        return movieDetailsViewController
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerCells() {
        tableView.register(UINib(nibName: "\(MovieImageCell.self)", bundle: nil) , forCellReuseIdentifier: "\(MovieImageCell.self)")
        
        tableView.register(UINib(nibName: "\(MovieOtherDetailsCell.self)", bundle: nil) , forCellReuseIdentifier: "\(MovieOtherDetailsCell.self)")
    }

    private func setupObserver() {
        viewModel.stateObservable.drive(onNext: { [weak self] in
            guard let weakSelf = self else {return}
            switch $0 {
            case .idle:
                UtitlyManager.shared.showActivityIndicator(in: weakSelf.view)
            case .reloadData:
                UtitlyManager.shared.hideActivityIndicator()
               weakSelf.tableView.reloadData()
            case .showActivity:
                UtitlyManager.shared.showActivityIndicator(in: weakSelf.view)
            case .hideActivity:
                UtitlyManager.shared.hideActivityIndicator()
            }
        }).disposed(by: disposeBag)
    }

}

extension MovieDetailsViewController : UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.movieDetailsCells[indexPath.row] {
            
        case .movieImageCell:
            
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: "\(MovieImageCell.self)") as? MovieImageCell else{
                return UITableViewCell()
            }
            imageCell.configureCell(posterPath: viewModel.movieDetails?.posterPath ?? "")
            return imageCell
    
        case .movieTitleCell:
            guard let movieTitleCell = tableView.dequeueReusableCell(withIdentifier: "\(MovieOtherDetailsCell.self)") as? MovieOtherDetailsCell else{
                return UITableViewCell()
            }
            movieTitleCell.configureCell(text: viewModel.movieDetails?.title ?? "", cell: .movieTitleCell)
            return movieTitleCell
            
        case .movieRelaseDateCell:
            guard let movieRelaseDateCell = tableView.dequeueReusableCell(withIdentifier: "\(MovieOtherDetailsCell.self)") as? MovieOtherDetailsCell else{
                return UITableViewCell()
            }
            movieRelaseDateCell.configureCell(text: viewModel.movieDetails?.releaseDate ?? "", cell: .movieRelaseDateCell)
            return movieRelaseDateCell
            
        case .movieDescriptionCell:
            guard let movieDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "\(MovieOtherDetailsCell.self)") as? MovieOtherDetailsCell else{
                return UITableViewCell()
            }
            movieDescriptionCell.configureCell(text: viewModel.movieDetails?.overview ?? "", cell: .movieDescriptionCell)
            return movieDescriptionCell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieDetailsCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch viewModel.movieDetailsCells[indexPath.row] {
            
        case .movieImageCell:
            return 400
        case .movieTitleCell , .movieRelaseDateCell:
            return 50
        case .movieDescriptionCell:
            return 200
        }
        
    }
    
}



