//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by omhier khan on 3/4/22.
//

import UIKit
import Alamofire
class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: [String:Any]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text=movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text=movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        var baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL (string: baseUrl + posterPath)
        posterView.af.setImage(withURL: posterUrl!)
        
        baseUrl="https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL (string: baseUrl + backdropPath)
        backdropView.af.setImage(withURL: backdropUrl!)
    }
        
        // Configure the view for the selected state
    }


