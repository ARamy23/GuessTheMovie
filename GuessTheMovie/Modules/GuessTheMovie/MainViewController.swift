//
//  MainViewController.swift
//  GuessTheMovie
//
//  Created by Ahmed Ramy on 07/12/2021.
//

import Foundation

class MainViewController: BaseViewController, HasViewModel {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = "The Wolf Of ...."
        movieImageView.image = UIImage(named: "the-wolf-of-wallstreet.jpg")
    }
}
