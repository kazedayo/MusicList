//
//  ViewController.swift
//  MusicList
//
//  Created by Kin Wa Lam on 21/4/2021.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    private let viewModel: AlbumListViewModelType
    private let disposeBag = DisposeBag()
    private lazy var emptyLabel = UILabel()
    private lazy var tableView = UITableView()
    private lazy var showFavouriteButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
        //empty label
        emptyLabel.text = "No items to show."
        emptyLabel.textColor = .gray
        emptyLabel.font = .systemFont(ofSize: 16, weight: .light)
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        //table view setup
        tableView.tableFooterView = UIView()
        tableView.register(AlbumListTableViewCell.self, forCellReuseIdentifier: AlbumListTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(view)
            make.width.equalTo(view)
        }
        showFavouriteButton.image = UIImage(named: "heart")
        navigationItem.rightBarButtonItem = showFavouriteButton
        setupBinding()
    }
    
    init(viewModel: AlbumListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBinding() {
        showFavouriteButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.viewModel.input.toggleShowFavourite()
        }).disposed(by: disposeBag)
        tableView.rx.modelSelected(AlbumListItem.self).subscribe(onNext: { [weak self] in
            self?.viewModel.input.toggleFavourite(id: $0.album.collectionId)
        }).disposed(by: disposeBag)
        let tableViewObservalbe = Observable.combineLatest(viewModel.output.albums, viewModel.output.isShowingFavorites) {
            return $1 ? $0.filter({$0.isFavorite}) : $0
        }
        tableViewObservalbe.subscribe(onNext: { [weak self] in
            self?.tableView.isHidden = $0.isEmpty
        }).disposed(by: disposeBag)
        tableViewObservalbe.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumListTableViewCell.identifier) as! AlbumListTableViewCell
            let url = URL(string: element.album.artworkUrl100)
            cell.albumArtImageView.kf.setImage(with: url)
            cell.albumNameLabel.text = element.album.collectionName
            cell.artistNameLabel.text = element.album.artistName
            cell.favoriteImageView.isHidden = !element.isFavorite
            return cell
        }.disposed(by: disposeBag)
        viewModel.output.isShowingFavorites.subscribe(onNext: { [weak self] in
            self?.navigationItem.title = $0 ? "Favorites" : "Music List"
            self?.showFavouriteButton.image = UIImage(named: $0 ? "list" : "heart")
        }).disposed(by: disposeBag)
        viewModel.input.fetchAlbumList()
    }
    
}

