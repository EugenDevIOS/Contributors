//
//  DetailViewController.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import UIKit
import Kingfisher



class DetailViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    public let presenter = DetailViewPresenter()
    
    @IBOutlet public weak var avatarImage: UIImageView!
    @IBOutlet public weak var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: presenter.contributor?.avatarUrl ?? "") else { return }
        let resourse = ImageResource(downloadURL: url, cacheKey: presenter.contributor?.avatarUrl)
        self.avatarImage.kf.setImage(with: resourse)
        self.loginLabel.text = presenter.contributor?.login
    }
    
    @IBAction func closeTapped() {
        self.dismiss(animated: true, completion: nil)
        
    }
}
