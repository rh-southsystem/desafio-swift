//
//  ViewController.swift
//  eventos
//
//  Created by Enrique Dutra on 07/01/21.
//

import UIKit



class ViewController: UIViewController {

    var movies : [Movie] = []
    let request = Request()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
 
        
        self.request.popularMoviesRequest { (movies) in
            for movie in movies {
                self.movies.append(movie)
                DispatchQueue.main.async {
                    print(self.movies.count )
                    self.tableView.reloadData()
                }
                
            }
        }
        
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as? MovieCell{
            
            let movie = movies[indexPath.row]
            
        
            cell.movieTitleLabel.text = movie.original_title
            cell.movieImage.downloaded(from: URL(string: movie.photo)!)
            return cell
        }
        return UITableViewCell()
    }
    
    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
