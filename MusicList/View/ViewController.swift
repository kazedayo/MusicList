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
    private lazy var tableView = UITableView()
    private lazy var showFavouriteButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Music List"
        //table view setup
        tableView.estimatedRowHeight = 132
        tableView.rowHeight = UITableView.automaticDimension
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
            self?.viewModel.input.toggleFavourite()
        }).disposed(by: disposeBag)
        viewModel.output.albums.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumListTableViewCell.identifier) as! AlbumListTableViewCell
            let url = URL(string: element.artworkUrl100)
            cell.albumArtImageView.kf.setImage(with: url)
            cell.albumNameLabel.text = element.collectionName
            cell.artistNameLabel.text = element.artistName
            return cell
        }.disposed(by: disposeBag)
        viewModel.output.isShowingFavorites.subscribe(onNext: { [weak self] in
            self?.navigationItem.title = $0 ? "Favorites" : "Music List"
        }).disposed(by: disposeBag)
        viewModel.input.fetchAlbumList()
    }
    
}

