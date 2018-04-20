//
//  ViewController.swift
//  sampleproject
//
//  Created by thuyiya on 4/18/18.
//  Copyright © 2018 thusitha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let sharedHttpClient = HttpClient.init()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies: [Movie] = [] {
        didSet {
            updateUI()
        }
    }
    
    var moviesTask: URLSessionDataTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        loadMovies()
    }
    
    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func moveToLogin() {
        
    }
    
    private func handleError(_ error: NetworkError<CustomError>) {
        switch error {
        case .noInternetConnection:
            showErrorAlert(with: "The internet connection is lost")
        case .unauthorized:
            moveToLogin()
        case .other:
            showErrorAlert(with: "Unfortunately something went wrong")
        case .custom(let error):
            showErrorAlert(with: error.message)
        }
    }

    @IBAction private func loadMovies() {
        moviesTask?.cancel()
        
        activityIndicator.startAnimating()
        
        let moviesResource = Resource<MoviesResponse, CustomError>(jsonDecoder: JSONDecoder(), path: "5ad9eb552f00005b00cfe020")
        
        moviesTask = ViewController.sharedHttpClient.load(resource: moviesResource) {[weak self] response in
            
            guard let controller = self else { return }
            
            DispatchQueue.main.async {
                controller.activityIndicator.stopAnimating()
                
                print(response)
                
                if let movies = response.value?.movies {
                    controller.movies = movies
                } else if let error = response.error {
                    controller.handleError(error)
                }
            }
        }
    }
    
    private func updateUI() {
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.summary
        return cell
    }
}

