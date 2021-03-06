//
//  ViewController.swift
//  Flix
//
//  Created by omhier khan on 2/24/22.
//

import UIKit
import AlamofireImage
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   
    
    @IBOutlet var TableView: UITableView!
    
    var movieHolder=[[String:Any]]()
    
    override func viewDidLoad() {
        // TODO: Get the array of movies
        super.viewDidLoad()
        
        TableView.dataSource = self
        TableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
              // TODO: Store the movies in a property to use elsewhere
                 
               self.movieHolder = dataDictionary["results"] as! [[String:Any]]
               self.TableView.reloadData()
            // TODO: Reload your table view data
                 

             }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieHolder.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movieHolder[indexPath.row]
        
        let title=movie["title"] as! String
        cell.TitleLabel.text = title
        let synopsis = movie["overview"] as! String
        cell.SynopsisLabel.text=synopsis
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL (string: baseUrl + posterPath)
        cell.PosterView.af.setImage(withURL: posterUrl!)
        return cell
        
    }
    
    override func prepare( for seque: UIStoryboardSegue, sender: Any? ){
        print("Loading up Details Screen")
        let cell = sender as! UITableViewCell
        let indexPath=TableView.indexPath(for: cell)!
        let movie = movieHolder[indexPath.row]
        
        let detailsViewController = seque.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        TableView.deselectRow(at:indexPath, animated:true)
    }
}

