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
    
    let viewModel: AlbumListViewModelType
    let disposeBag = DisposeBag()
    lazy var tableView = UITableView()
    
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
        viewModel.output.albums.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumListTableViewCell.identifier) as! AlbumListTableViewCell
            let url = URL(string: element.artworkUrl100)
            cell.albumArtImageView.kf.setImage(with: url)
            cell.albumNameLabel.text = element.collectionName
            cell.artistNameLabel.text = element.artistName
            return cell
        }.disposed(by: disposeBag)
        viewModel.input.fetchAlbumList()
    }
    
}

