//
//  MainViewController.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = MainViewPresenter()
    
    private var detailViewController: DetailViewController?
    public var selectedCell: MainViewCell?
    public var selectedCellImageViewSnapshot: UIView?
    
    var animator: Animator?

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
        return presenter.contributors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.kCellIdentifire, for: indexPath) as? MainViewCell else { return UITableViewCell()}
        let contributor = presenter.contributors[indexPath.row]
        cell.setCell(contributors: contributor)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        self.selectedCell = tableView.cellForRow(at: indexPath) as? MainViewCell
        self.selectedCellImageViewSnapshot = selectedCell?.avatarImage.snapshotView(afterScreenUpdates: false)
        self.detailViewController = detailViewController
        self.detailViewController?.presenter.contributor = presenter.contributors[indexPath.row]
        self.detailViewController?.transitioningDelegate = self
        self.detailViewController?.modalPresentationStyle = .fullScreen
        
        
        guard let vc = self.detailViewController else { return }
        self.present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: MainViewPresenterProtocol{
    func finishingFetchContributors() {
        self.tableView.reloadData()
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // B2 - 16
        guard let nvc = presenting as? UINavigationController,
              let firstViewController = nvc.viewControllers[0] as? MainViewController,
            let secondViewController = presented as? DetailViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }

        animator = Animator(type: .present, firstViewController: firstViewController, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
    }

    // B1 - 3
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // B2 - 17
        guard let secondViewController = dismissed as? DetailViewController,
            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
            else { return nil }

        animator = Animator(type: .dismiss, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
        
    }
    
}
