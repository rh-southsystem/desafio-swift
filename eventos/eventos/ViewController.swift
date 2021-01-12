//
//  ViewController.swift
//  eventos
//
//  Created by Enrique Dutra on 07/01/21.
//

import UIKit



class ViewController: UIViewController {

    var movies : [Movie] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = Request()
 
        
        request.popularMoviesRequest { (movies) in
            for movie in movies {
                self.movies.append(movie)
            }
        }
        print(self.movies.count )
        // Do any additional setup after loading the view.
    }


}

