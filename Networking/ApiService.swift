//
//  ApiService.swift
//  Demo_fetchData
//
//  Created by Jian Ma on 11/19/20.
//

import Foundation

class ApiService {
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let popularMovieURL = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        guard let url = URL(string: popularMovieURL) else {return}
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //  dataTask = URLSession.shared.dataTask(with: url) { (data, res, err) in
            //err handling
            if let error = error {
                completion(.failure(error))
                print("datatask error: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                //handle empty error
                print("empty response")
                return
            }
            guard let data = data else {
                print("empty data")
                return
            }
            print("data: \(data)")
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
        
        }
    
}
