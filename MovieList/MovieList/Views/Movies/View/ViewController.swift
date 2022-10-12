//
//  ViewController.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import UIKit

class ViewController: UIViewController {

    lazy var viewModel:MovieProtocol = {
         return MovieViewModel()
    }()
    private var storedMovies: [Movie] = [Movie]()
    private var isPersistedData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if NetworkHelper.isConnectedToNetwork() {
            isPersistedData = false
            
            viewModel.getAllMovies(sortBy: "title.asc", page: 1) {

                print(self.viewModel.movies)
            } failure: { error in
                print(error)
            }

        }
    }
}

