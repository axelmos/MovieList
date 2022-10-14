//
//  CoreDataManager.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    func getStoredMovies(isTopRated: Bool = false) -> [Movie] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return [Movie]()
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StoredMovie")
        var storedMovies: [NSManagedObject] = []
        do {
            storedMovies = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        var movies = [Movie]()
        for storedMovie in storedMovies {
            let title = storedMovie.value(forKey: "title")
            let poster_path = storedMovie.value(forKey: "poster_path")
            let overview = storedMovie.value(forKey: "overview")

            if isTopRated {
                if storedMovie.value(forKey: "isTopRated") != nil {
                    movies.append(Movie.init(title: title as! String, poster_path: poster_path as! String, overview: overview as! String))
                }
            } else {
                movies.append(Movie.init(title: title as! String, poster_path: poster_path as! String, overview: overview as! String))
            }
        }
        
        return movies
    }
    
    func saveMovies(movies: [Movie], isTopRated: Bool = false) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        for movie in movies {
            let entity = NSEntityDescription.entity(forEntityName: "StoredMovie", in: managedContext)!
            let storeMovie = NSManagedObject(entity: entity, insertInto: managedContext)
            storeMovie.setValue(movie.title, forKeyPath: "title")
            storeMovie.setValue(movie.poster_path, forKeyPath: "poster_path")
            storeMovie.setValue(movie.overview, forKeyPath: "overview")
            if isTopRated {
                storeMovie.setValue(true, forKeyPath: "isTopRated")
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteAllMovies() -> Bool {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StoredMovie")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
            return true
        } catch let error as NSError {
            print("Deleted all my data in StoredMovie error : \(error) \(error.userInfo)")
            return false
        }
    }
}

