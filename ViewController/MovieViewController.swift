//
//  ViewController.swift
//  Demo_fetchData
//
//  Created by Jian Ma on 11/19/20.
//

import UIKit

class MovieViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadMoviesData()
    }
    
    private func loadMoviesData(){
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
}
// MARK: tableView extension
extension MovieViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewcell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCells(withValuesOf: movie)
        return cell
    }
}
