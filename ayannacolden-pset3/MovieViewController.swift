//
//  MovieViewController.swift
//  ayannacolden-pset3
//
//  Created by Ayanna Colden on 16/11/2016.
//  Copyright © 2016 Ayanna Colden. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    var moviePlot = String()
    var movieTitle = String()
    var moviePoster = String()
    var movieYear = String()
    
    
    
    @IBOutlet weak var plotMovie: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var posterMovie: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plotMovie.text = moviePlot
        titleMovie.text = movieTitle
        loadImageFromUrl(url: moviePoster, view: posterMovie)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImageFromUrl(url: String, view: UIImageView){
        
        // Create Url from string
        let url = NSURL(string: url)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                DispatchQueue.main.async(execute: { () -> Void in
                    view.image = UIImage(data: data)
                })
            }
        }
        
        // Run task
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "watchList") {
            let movieView = segue.destination as! WatchTableViewController
            movieView.movieYear = movieYear
            movieView.movieTitle = movieTitle
            movieView.moviePoster = moviePoster
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
