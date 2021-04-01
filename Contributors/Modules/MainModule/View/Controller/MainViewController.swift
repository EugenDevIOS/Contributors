//
//  MainViewController.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var contributors: [Contributors] = []
    let presenter = MainViewPresenter(networkingService: NetworkingService())

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(mainViewPresenterProtocol: self)
        presenter.getContributors()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.kCellIdentifire, for: indexPath) as? MainViewCell else { return UITableViewCell()}
        let contributor = contributors[indexPath.row]
        cell.setCell(contributors: contributor)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let secondViewController = storyboard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
                secondViewController.name = "Ivan"
                
                show(secondViewController, sender: nil)
            }
    }

extension MainViewController: MainViewPresenterProtocol{
    func finishingFetchContributors(contributors: [Contributors]) {
        self.contributors = contributors
        self.tableView.reloadData()
    }
}
