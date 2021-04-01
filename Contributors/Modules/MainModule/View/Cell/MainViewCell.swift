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

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    func setCell(contributors: Contributors) {
        
        if let login = contributors.login{
            titleLabel.text = login
        } else {
            titleLabel.text = ""
        }
        
        if let id = contributors.id{
            idLabel.text = String(id)
        } else {
            idLabel.text = "Empty"
        }
        
        if let avatarUrl = contributors.avatarUrl {
            let resourceImage = ImageResource(downloadURL: URL(string: avatarUrl)!, cacheKey: avatarUrl)
            self.avatarImage.kf.setImage(with: resourceImage)
        }
    }
}
