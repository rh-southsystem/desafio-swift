//
//  ViewController.swift
//  eventos
//
//  Created by Enrique Dutra on 07/01/21.
//

import UIKit



class ViewController: UIViewController {

    
    let movies = Movie(id: 1, name: "Filme exemplo", imageURL: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = Request()
        
        request.getMovies { (movie) in
            
        }
        
        // Do any additional setup after loading the view.
    }


}

