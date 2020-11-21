//
//  MovieViewModel.swift
//  Demo_fetchData
//
//  Created by Jian Ma on 11/20/20.
//

import Foundation

class MovieViewModel{
    private var apiService = ApiService()
    private var popularMovies = [Movie]()
    
    func fetchPopularMoviesData( completion: @escaping () -> ()){
        apiService.getPopularMoviesData { [weak self] (result) in
            switch result{
            case .success(let data):
                self?.popularMovies = data.movies
                completion()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    func numberOfRowsInSection(_ section: Int) -> Int{
        return popularMovies.count != 0 ? popularMovies.count : 0
    }
    func cellForRowAt(indexPath: IndexPath) -> Movie{
        return popularMovies[indexPath.row]
    }
    
}
