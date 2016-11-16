//
//  MovieViewController.swift
//  ayannacolden-pset3
//
//  Created by Ayanna Colden on 16/11/2016.
//  Copyright © 2016 Ayanna Colden. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var infoMovie: UILabel!
    var movieJson = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
