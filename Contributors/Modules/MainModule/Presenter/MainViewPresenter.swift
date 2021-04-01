//
//  MainViewPresenter.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import Foundation


protocol MainViewPresenterProtocol: class {
    func finishingFetchContributors(contributors: [Contributors])
}

class MainViewPresenter {
    
    private let networkingService: NetworkingService
    weak private var mainViewPresenterProtocol: MainViewPresenterProtocol?
    
    internal init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func setViewDelegate(mainViewPresenterProtocol: MainViewPresenterProtocol?) {
        self.mainViewPresenterProtocol = mainViewPresenterProtocol
    }
    
    func getContributors() {
        
        networkingService.fetchRequest { data, error in
            guard let contributors = data, error == nil else { return }
            self.mainViewPresenterProtocol?.finishingFetchContributors(contributors: contributors)
        }
    }
}
