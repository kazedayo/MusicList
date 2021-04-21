//
//  AlbumListTableViewCell.swift
//  MusicList
//
//  Created by Kin Wa Lam on 21/4/2021.
//

import UIKit
import SnapKit

class AlbumListTableViewCell: UITableViewCell {
    
    static let identifier = "albumListTableViewCell"
    
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
            make.left.equalTo(16)
            make.size.equalTo(100)
            make.top.equalTo(16)
            make.bottom.equalTo(-16).priority(.low)
        }
        
        //album name
        albumNameLabel.numberOfLines = 0
        contentView.addSubview(albumNameLabel)
        albumNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(albumArtImageView)
            make.left.equalTo(albumArtImageView.snp.right).offset(16)
            make.right.equalTo(-16)
        }

        //artist name
        artistNameLabel.numberOfLines = 0
        contentView.addSubview(artistNameLabel)
        artistNameLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(contentView).offset(-16)
            make.left.equalTo(albumNameLabel)
            make.right.equalTo(-16)
        }
    }

}
