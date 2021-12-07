//
//  ViewController.swift
//  CompleteTheMovieTitle
//
//  Created by Osama Gamal on 25/05/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = "The Wolf Of ...."
        movieImageView.image = UIImage(named: "the-wolf-of-wallstreet.jpg")
    }
}

