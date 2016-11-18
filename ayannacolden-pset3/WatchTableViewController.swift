//
//  WatchTableViewController.swift
//  ayannacolden-pset3
//
//  Created by Ayanna Colden on 18/11/2016.
//  Copyright © 2016 Ayanna Colden. All rights reserved.
//

import UIKit

class WatchTableViewController: UITableViewController {
    
    var movieYear = String()
    var movieTitle = String()
    var moviePoster = String()
    
    var arrayWatchList = [String]()
    var arrayYear = [String]()
    var arrayImage = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        // put movietitle in the watch list
        arrayWatchList.insert(movieTitle, at: 0)
        arrayImage.insert(moviePoster, at: 0)
        arrayYear.insert(movieYear, at: 0)
        
        
        // read from stored data
        let defaults = UserDefaults.standard
        if let name = defaults.stringArray(forKey: "title"){
            print (name)
            arrayWatchList.insert(contentsOf: name, at: 0)
            print (arrayWatchList)
        }
        
        if let year = defaults.stringArray(forKey: "year") {
            arrayYear.insert(contentsOf: year, at: 0)
        }
        
        if let image = defaults.stringArray(forKey: "image") {
            arrayImage.insert(contentsOf: image, at: 0)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "addMovie") {
            let defaults = UserDefaults.standard
            defaults.set(arrayWatchList, forKey: "title")
            defaults.set(arrayYear, forKey: "year")
            defaults.set(arrayImage, forKey: "image")
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayWatchList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "watchCell", for: indexPath) as! WatchViewCell
        
        
        cell.movieTitle.text = arrayWatchList[indexPath.row]
        cell.movieYear.text = arrayYear[indexPath.row]
        loadImageFromUrl(url: arrayImage[indexPath.row], view: cell.moviePoster)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 

}
