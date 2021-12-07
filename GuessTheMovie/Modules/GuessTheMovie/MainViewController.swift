//
//  MainViewController.swift
//  GuessTheMovie
//
//  Created by Ahmed Ramy on 07/12/2021.
//

import Foundation
import UIKit

class MainViewController: BaseViewController, HasViewModel {
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private var answersButtons: [UIButton]!
    
    var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = "The Wolf Of ...."
        movieImageView.image = UIImage(named: "the-wolf-of-wallstreet.jpg")
    }
    
    override func viewWillAppearOnce() {
        super.viewWillAppearOnce()
        bind()
    }
}

private extension MainViewController {
    func bind() {
        viewModel?.movie.sink(receiveValue: { [weak self] movie in
            guard let self = self else { return }
            self.movieTitleLabel.text = movie.name
        }).store(in: &cancellables)
        
        viewModel?.answers.sink(receiveValue: { [weak self] answers in
            guard let self = self else { return }
            zip(self.answersButtons, answers).forEach { (button: UIButton, answer: String) in
                button.setTitle(answer, for: .normal)
            }
        }).store(in: &cancellables)
        
        answersButtons.enumerated().forEach { (index: Int, button: UIButton) in
            button.addControlEvent(.touchUpInside, {
                viewModel?.didSelect(index: index)
            })
        }
    }
}
