//
//  MainViewCell.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import UIKit
import Kingfisher

class MainViewCell: UITableViewCell {
    
    static let kCellIdentifire = "MainViewCell"
    
    @IBOutlet public weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet public weak var idLabel: UILabel!
    
    
    
    func setCell(contributor: Contributors) {
        
        guard let avatarUrl = contributor.avatarUrl, let url = URL(string: avatarUrl), let id = contributor.id else { return }
        titleLabel.text = contributor.login
        idLabel.text = String(id)
        let resourceImage = ImageResource(downloadURL: url, cacheKey: avatarUrl)
        self.avatarImage.kf.setImage(with: resourceImage)
    }
}
