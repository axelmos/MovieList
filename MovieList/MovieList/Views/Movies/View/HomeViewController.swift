//
//  HomeViewController.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import UIKit

enum Sections: Int, CaseIterable {
    case UPCOMING
    case TOP_RATED
}

class HomeViewController: UITableViewController {

    lazy var upcomingViewModel:MovieProtocol = {
         return MovieViewModel()
    }()
    lazy var topRatedViewModel:MovieProtocol = {
         return MovieViewModel()
    }()
    private var storedTopRatedMovies: [Movie] = [Movie]()
    private var storedUpcomingMovies: [Movie] = [Movie]()
    private var isPersistedData: Bool = false
    private var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "MoviesTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "MoviesTableViewCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if NetworkHelper.isConnectedToNetwork() {
            isPersistedData = false
            getUpcomingAndTopRatedMovies()
        } else {
            isPersistedData = true
            storedTopRatedMovies = CoreDataManager.shared.getStoredMovies(isTopRated: true)
            storedUpcomingMovies = CoreDataManager.shared.getStoredMovies()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getUpcomingAndTopRatedMovies() {
        upcomingViewModel.getUpcomingMovies(sortBy: "title.asc", page: 1) {
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: Sections.UPCOMING.rawValue), with: .fade)
                
                if CoreDataManager.shared.deleteAllMovies() {
                    CoreDataManager.shared.saveMovies(movies: self.upcomingViewModel.movies)
                }
            }
            self.getTopRatedMovies()
        } failure: { error in
            print(error)
        }
    }
    
    private func getTopRatedMovies() {
        topRatedViewModel.getTopRatedMovies(sortBy: "title.asc", page: 1) {
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: Sections.TOP_RATED.rawValue), with: .fade)
                
                CoreDataManager.shared.saveMovies(movies: self.topRatedViewModel.movies, isTopRated: true)
            }
        } failure: { error in
            print(error)
        }
    }
    
    // MARK: - UITableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Sections.UPCOMING.rawValue:
            return "PRÓXIMOS ESTRENOS"
        case Sections.TOP_RATED.rawValue:
            return "TENDENCIA"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell {
            cell.delegate = self
            switch indexPath.section {
            case Sections.UPCOMING.rawValue:
                if isPersistedData {
                    cell.populate(storedUpcomingMovies)
                } else {
                    if upcomingViewModel.movies.count > 0 {
                        cell.populate(upcomingViewModel.movies)
                    }
                }
            case Sections.TOP_RATED.rawValue:
                if isPersistedData {
                    cell.populate(storedTopRatedMovies)
                } else {
                    if topRatedViewModel.movies.count > 0 {
                        cell.populate(topRatedViewModel.movies)
                    }
                }
            default:
                break
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.movie = selectedMovie
        }
    }
}

// MARK: - MoviesTableViewCellDelegate

extension HomeViewController: MoviesTableViewCellDelegate {
    func showMovieDetails(_ movie: Movie) {
        selectedMovie = movie
        performSegue(withIdentifier: "showDetailSegue", sender: self)
    }
}
