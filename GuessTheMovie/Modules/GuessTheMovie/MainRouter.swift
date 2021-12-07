//
//  MainRouter.swift
//  GuessTheMovie
//
//  Created by Ahmed Ramy on 07/12/2021.
//

import Foundation

public protocol MainRouterProtocol {
    func showSuccessAlert()
    func showFailureAlert()
}

public final class MainRouter: MainRouterProtocol {
    private let mainView: BaseViewController
    
    init(mainView: BaseViewController) {
        self.mainView = mainView
    }
    
    public func showSuccessAlert() {
        mainView.alert(title: "Well Done! 🎉", message: "Correct Answer",
                       actions: [
                        (title: "Ok", style: .default)
                       ]
        )
    }
    
    public func showFailureAlert() {
        mainView.alert(title: "Oh No! 🥺", message: "That was not correct", actions: [
            (title: "Ok", style: .default)
           ])
    }
}
