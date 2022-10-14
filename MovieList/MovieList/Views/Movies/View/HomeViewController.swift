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
    private var storedMovies: [Movie] = [Movie]()
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
        }
    }
    
    // MARK: - Private Methods
    
    private func getUpcomingAndTopRatedMovies() {
        upcomingViewModel.getUpcomingMovies(sortBy: "title.asc", page: 1) {
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: Sections.UPCOMING.rawValue), with: .fade)
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
    
    /*override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        
        switch section {
        case Sections.UPCOMING.rawValue:
            view.titleLabel?.text = "PRÓXIMOS ESTRENOS"
        case Sections.TOP_RATED.rawValue:
            view.titleLabel?.text = "TENDENCIA"
        default:
            break
        }
        
        return view
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell {
            cell.delegate = self
            switch indexPath.section {
            case Sections.UPCOMING.rawValue:
                if isPersistedData {
                    cell.populate(storedMovies)
                } else {
                    if upcomingViewModel.movies.count > 0 {
                        cell.populate(upcomingViewModel.movies)
                    }
                }
            case Sections.TOP_RATED.rawValue:
                if isPersistedData {
                    cell.populate(storedMovies)
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
    
    // MARK: - UITableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
