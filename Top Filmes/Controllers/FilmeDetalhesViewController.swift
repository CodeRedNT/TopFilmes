//
//  FilmeDetalhesViewController.swift
//  Top Filmes
//
//  Created by Code Red on 13/07/19.
//  Copyright © 2019 particular. All rights reserved.
//

import UIKit

class FilmeDetalhesViewController: UIViewController {

    var mFilme: Filme? = nil
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtOverview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblTitulo.text = mFilme?.title
        lblDate.text = mFilme?.release_date
        imgPoster.downloaded(from: "https://image.tmdb.org/t/p/w500"+(mFilme?.poster_path  ?? "") )
        print(mFilme?.title ?? "objeto nulo")
        
        txtOverview.text = mFilme?.overview
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
