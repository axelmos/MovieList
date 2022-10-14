//
//  DetailViewController.swift
//  MovieList
//
//  Created by Axel Mosiejko on 13/10/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL.init(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)") {
            imageView?.sd_setImage(with: url)
        }
        
        titleLabel.text = movie.title
        overViewLabel.text = movie.overview
    }

}
