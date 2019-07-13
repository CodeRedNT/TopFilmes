//
//  MainListaViewController.swift
//  Top Filmes
//
//  Created by Code Red on 12/07/19.
//  Copyright © 2019 particular. All rights reserved.
//

import UIKit

class MainListaViewController: UIViewController {

    var mListaFilmes: ResponseData? = nil
    var mIdFilmeSelecionado: Int = 0
    var mImageSelecionado: UIImage? = nil
    
    @IBOutlet weak var tblFilmes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregarJson()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFilmeDetalhes" {

            var destino = segue.destination as! FilmeDetalhesViewController
            destino.mFilme = mListaFilmes?.results?[mIdFilmeSelecionado]
//            destino
        }
    }
    
    func carregarJson(){
        guard let url = URL(string:"https://api.themoviedb.org/3/movie/upcoming?api_key=ffb23f57606392a1fa4f7377ca07b990") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else { print(error?.localizedDescription ?? "Response Error"); return }
            self.processarJson(json: dataResponse)
        }
        task.resume()
    }
    
    private func processarJson(json : Data) {
        do {
            //here dataResponse received from a network request
            let decoder = JSONDecoder()
            mListaFilmes = try decoder.decode(ResponseData.self, from: json) //Decode JSON Response Data
            // Carregar Dados
                let nibName = UINib(nibName: "FilmeTableViewCell", bundle: nil)
                tblFilmes.register(nibName, forCellReuseIdentifier: "idCell")
                tblFilmes.dataSource = self
                tblFilmes.delegate = self
            
        } catch let parsingError {
            print("Error", parsingError)
        }
    }

    @IBAction func back(segue: UIStoryboardSegue) {
        
    }
}

extension MainListaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mListaFilmes?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell") as! FilmeTableViewCell
        
        cell.lblTitle?.text = mListaFilmes?.results?[indexPath.row].title
        cell.lblReleaseDate?.text = mListaFilmes?.results?[indexPath.row].release_date
        cell.imgPoster.downloaded(from: "https://image.tmdb.org/t/p/w500"+(mListaFilmes?.results?[indexPath.row].poster_path  ?? "") )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        mIdFilmeSelecionado = indexPath.row

        performSegue(withIdentifier: "segueFilmeDetalhes", sender: self)
    }
    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
