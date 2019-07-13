//
//  ViewController.swift
//  Top Filmes
//
//  Created by Code Red on 11/07/19.
//  Copyright © 2019 particular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }

    @IBAction func logar(_ sender: Any) {
        
        performSegue(withIdentifier: "segueMain", sender: self)
    }
}

