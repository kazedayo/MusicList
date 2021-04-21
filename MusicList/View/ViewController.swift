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

class ViewController: UIViewController {
    
    let viewModel: AlbumListViewModelType
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //table view setup
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(view)
            make.width.equalTo(view)
        }
    }
    
    init(viewModel: AlbumListViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

