//
//  AlbumListTableViewCell.swift
//  MusicList
//
//  Created by Kin Wa Lam on 21/4/2021.
//

import UIKit
import SnapKit

class AlbumListTableViewCell: UITableViewCell {
    
    lazy var albumArtImageView = UIImageView()
    lazy var albumNameLabel = UILabel()
    lazy var artistNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        //album art
        contentView.addSubview(albumArtImageView)
        albumArtImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(8)
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
        }
        
        //album name
        contentView.addSubview(albumNameLabel)
        albumNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(albumArtImageView)
            make.left.equalTo(albumArtImageView).offset(4)
        }
        
        //artist name
        contentView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(albumArtImageView)
            make.left.equalTo(albumNameLabel)
        }
    }

}
