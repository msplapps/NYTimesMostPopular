//
//  DashboardInteractor.swift
//  NYTimes
//
//  Created by Zelux on 2018. 04. 28..
//  Copyright © 2018. Zelux. All rights reserved.
//

import Foundation

class DashboardInteractor : BaseInteractor, DashboardInteractorProtocol {

    var communicationService: CommunicationServiceProtocol

    // MARK: ctor
    init(communicationService: CommunicationServiceProtocol) {
        self.communicationService = communicationService
        super.init()
    }

    // MARK: InteractorProtocol
    func fetchNextBlock(with offset: Int) {
        weak var weakSelf = self
        communicationService.fetchMostViewed(offset: offset)  { (result) in
            guard let serverResponse = result?.results, weakSelf != nil else {
                return
            }
           
            weakSelf?.getDashboardPresenter().presentMostViewedResults(serverResponse)
        }
    }
    
    // MARK: Methods
    func getDashboardPresenter() -> DashboardPresenterProtocol {
        return try! getLastPresenter(byProtocol: DashboardPresenterProtocol.self) as! DashboardPresenterProtocol
    }
    
    deinit {
        self.presenterContainer.removeAll()
    }
}
