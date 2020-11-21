//
//  MovieTableViewcellTableViewCell.swift
//  Demo_fetchData
//
//  Created by Jian Ma on 11/20/20.
//

import UIKit

class MovieTableViewcell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieOverViewLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    private var urlString: String = ""
    
    //setup Mivie values
    func setCells(withValuesOf movie: Movie){
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overView: movie.overview, posterString: movie.posterImage)
    }
    
    //update ui changes
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overView: String?, posterString: String?){
        self.movieTitleLabel.text = title
        self.movieYearLabel.text = convertDateFormatter(releaseDate)
        self.movieOverViewLabel.text = overView
        guard let rating = rating else{return}
        self.movieRatingLabel.text = "\(rating)"
        
        guard let posterString = posterString else {return}
        urlString = "http://image.tmdb.org/t/p/w300\(posterString)"
        guard let posterImageURL = URL(string: urlString) else {
            self.imageView?.image = UIImage(named: "NoImageAvailable")
            return
        }
        //nil the old one before downloading the new one
        self.moviePoster.image = nil
        
        getImageDataFrom(url: posterImageURL)
        
    }
    
    // MARK: helpers
    
    private func getImageDataFrom(url: URL){
        URLSession.shared.dataTask(with: url){ (data, _ , _) in
            guard let data = data else{
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    self.moviePoster.image = image
                }
            }
        }.resume()
    }
    
    // MARK: - conevrt data format
    private func convertDateFormatter(_ date: String?) -> String{
        var stadingDateString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originDate = date{
            if let newDate = dateFormatter.date(from: originDate){
                dateFormatter.dateFormat = "dd.MM.yyyy"
                stadingDateString = dateFormatter.string(from: newDate)
            }
        }
        return stadingDateString
    }
    
    

}
