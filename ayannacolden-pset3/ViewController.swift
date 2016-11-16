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
    
    let json = String()
    let urlString = String()
    
    var movie = [String]()
    var moviesYear = [String]()
    var yearMovie: String?
    var moviesTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchMovie(_ sender: Any) {
    }
    func requestHTTP(SearchInput: String) {
        let searchInput = searchBar.text
        let urlString = searchInput?.replacingOccurrences(of: " ", with: "+")
        
        let url = URL(string: "https://www.omdbapi.com/?t=" + urlString! + "&y=&plot=short&r=json")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print("error!")
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            
            let dictionary = json as! [String: Any]
            self.movie = [dictionary["Title"] as! String]
            self.moviesYear = [dictionary["Year"] as! String]
            
            print(json)
            print(self.moviesYear)
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination: MovieViewController = (segue.destination as? MovieViewController){
            destination.movieJson = json}
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DescriptionCell
        
        cell.movieName.text = movie[indexPath.row]
        cell.movieYear.text = moviesYear[indexPath.row]
        
        return cell
        
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesTitle = movie[indexPath.row]
        yearMovie = moviesYear[indexPath.row]
        performSegue(withIdentifier: "MovieViewController", sender: self)
    }
}

