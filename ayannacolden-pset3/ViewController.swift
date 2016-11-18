//
//  ViewController.swift
//  ayannacolden-pset3
//
//  Created by Ayanna Colden on 15/11/2016.
//  Copyright © 2016 Ayanna Colden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let dictionary = String()
    let urlString = String()
    var movie = String()
    var moviesYear = String()
    var movieDescription = String()
    var movieImage = String()
    var moviesTitle = String()
    var yearMovie = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchMovie(_ sender: Any) {
        requestHTTP(Title: searchBar.text!)
        
    }
    
    
    func requestHTTP(Title: String) {
        let urlString = Title.replacingOccurrences(of: " ", with: "+")
        
        let url = URL(string: "https://www.omdbapi.com/?t=" + urlString + "&y=&plot=short&r=json")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print("error!")
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
            
                let dictionary = json as AnyObject
            
                self.movie = ((dictionary).value(forKey: "Title") as! String?)!
                self.moviesYear = ((dictionary).value(forKey: "Year") as! String?)!
                self.movieDescription = ((dictionary).value(forKey: "Plot") as! String?)!
                self.movieImage = ((dictionary).value(forKey: "Poster") as! String?)!
            }
            
        }
        task.resume()
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
        if (segue.identifier == "MovieViewController") {
            let movieView = segue.destination as! MovieViewController
            movieView.movieTitle = movie
            movieView.moviePlot = movieDescription
            movieView.moviePoster = movieImage
           
            
            
        }
    }
        
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DescriptionCell
        
        loadImageFromUrl(url: movieImage, view: cell.moviePoster)
        
        cell.movieName.text = movie
        cell.movieYear.text = moviesYear
        
        return cell
        
    }
    
    
}


