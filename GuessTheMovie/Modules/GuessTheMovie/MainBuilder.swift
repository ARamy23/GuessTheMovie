//
//  MainBuilder.swift
//  GuessTheMovie
//
//  Created by Ahmed Ramy on 07/12/2021.
//

import Foundation

public final class MainModuleBuilder {
    func build() -> MainViewController {
        return MainViewController().then {
            $0.viewModel = MainViewModel()
            $0.viewModel.router = MainRouter(mainView: mainVC)
        }
    }
}
