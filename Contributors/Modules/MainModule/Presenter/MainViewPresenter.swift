//
//  MainViewPresenter.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import Foundation


protocol MainViewPresenterProtocol: class {
    func finishingFetchContributors()
}

class MainViewPresenter {
    
    public var contributors: [Contributors] = []
    
    weak private var mainViewPresenterProtocol: MainViewPresenterProtocol?
    
    
    func setViewDelegate(mainViewPresenterProtocol: MainViewPresenterProtocol?) {
        self.mainViewPresenterProtocol = mainViewPresenterProtocol
    }
    
    func getContributors() {
        
        NetworkingService.sharedInstance.fetchRequest { data, error in
            guard let contributors = data, error == nil else { return }
            self.contributors = contributors
            self.mainViewPresenterProtocol?.finishingFetchContributors()
        }
    }
}
