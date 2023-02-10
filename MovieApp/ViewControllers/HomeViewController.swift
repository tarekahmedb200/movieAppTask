//
//  HomeViewController.swift
//  MovieApp
//
//  Created by lapshop on 2/10/23.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel : HomeViewModel!
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCells()
        setupObserver()
    }

    
    static func instantiate(with ViewModel: HomeViewModel) -> HomeViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        
        guard let homeViewController = storyBoard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        else {
            return nil
        }
        homeViewController.viewModel = ViewModel
        return homeViewController
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerCells() {
        tableView.register(UINib(nibName: "\(MovieCell.self)", bundle: nil) , forCellReuseIdentifier: "\(MovieCell.self)")
    }

    private func setupObserver() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.stateObservable.drive(onNext: { [weak self] in
            guard let weakSelf = self else {return}
            switch $0 {
            case .idle: break
            case .reloadData:
               weakSelf.tableView.reloadData()
            case .showActivity:
                UtitlyManager.shared.showActivityIndicator(in: weakSelf.view)
            case .hideActivity:
                UtitlyManager.shared.hideActivityIndicator()
            }
        }).disposed(by: disposeBag)
    }

}

extension HomeViewController : UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieCell.self)") as? MovieCell else{
            return UITableViewCell()
        }
        let movie = viewModel.movieList[indexPath.row]
        cell.configureCell(movie:movie)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movieList[indexPath.row]
        viewModel.onAction(action: .clickMovie(movieID: movie.id ?? 0))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - tableView.frame.height  {
            viewModel.onAction(action: .getNextPage)
        }
    }
    
    

}

