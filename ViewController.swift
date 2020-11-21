//
//  ViewController.swift
//  Demo_fetchData
//
//  Created by Jian Ma on 11/19/20.
//

import UIKit

class ViewController: UIViewController {
    var apiService = ApiService()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        apiService.getPopularMoviesData { (result) in
            print(result)
        }
        
        
    }


}

