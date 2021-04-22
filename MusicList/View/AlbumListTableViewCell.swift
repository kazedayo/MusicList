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
    lazy var favoriteImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        selectionStyle = .none
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
        albumNameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        contentView.addSubview(albumNameLabel)
        albumNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(albumArtImageView)
            make.left.equalTo(albumArtImageView.snp.right).offset(16)
            make.right.equalTo(-16)
        }

        //artist name
        artistNameLabel.numberOfLines = 0
        artistNameLabel.textColor = .gray
        artistNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        contentView.addSubview(artistNameLabel)
        artistNameLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(contentView).offset(-16)
            make.left.equalTo(albumNameLabel)
            make.right.equalTo(-16)
        }

        //favorite indicator
        favoriteImageView.image = UIImage(named: "heart")
        favoriteImageView.tintColor = UIColor.red
        contentView.addSubview(favoriteImageView)
        favoriteImageView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(contentView).offset(-16)
            make.right.equalTo(contentView).offset(-16)
        }
    }

}
