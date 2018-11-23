//
//  ViewController.swift
//  Movie
//
//  Created by ahmed gado on 11/12/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate {
    
    
   
    var filmArray = [FilmeItem]()
    var currentFilmeArray = [FilmeItem]() //update table
    
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc550&api_key=15ba5b4f91d3b4a9ef14ad6fc095ae12&fbclid=IwAR306QZ5FLwg9D-mTiaYbAQwV_VbZYfcA5odbC9TfTdNwRvMmekiKI716OE"
        ReadFromUrl(url: url)
   
       setUPFilms()
        setUPSearchBar()
        
    }
    private func setUPSearchBar(){
        searchBar.delegate = self
        
    }
  private func setUPFilms(){
//        filmArray.append(FilmeItem(name: "FilmTest1", image: "Logo", detail: "FilmTest1"))
//        filmArray.append(FilmeItem(name: "FilmTest2", image: "Logo", detail: "FilmTest2"))
//        filmArray.append(FilmeItem(name: "FilmTest3", image: "Logo", detail: "FilmTest3"))
//        filmArray.append(FilmeItem(name: "FilmTest4", image: "Logo", detail: "FilmTest4"))
//        filmArray.append(FilmeItem(name: "FilmTest5", image: "Logo", detail: "FilmTest5"))
       currentFilmeArray = filmArray
//
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentFilmeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableCell else {
           return UITableViewCell()
        }
        cell.nameCell.text = currentFilmeArray[indexPath.row].name
       // cell.imageCell.image = UIImage(named: currentFilmeArray[indexPath.row].image!)
        cell.SetImage(url: currentFilmeArray[indexPath.row].image!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: currentFilmeArray[indexPath.row])
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? ViewController2{
            if let Film = sender as? FilmeItem{
                dis.singleItem = Film
            }
        }
        
    }
   
     //Search bar
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    // one way
        /*
         currentFilmeArray = filmArray.filter({film -> Bool in
         guard let text = searchBar.text else{return false}
         return film.name.contains(text)
         })
         table.reloadData()

         */
        // secoond way
        guard !searchText.isEmpty else{
            currentFilmeArray = filmArray
            table.reloadData()
            return
        }
        currentFilmeArray = filmArray.filter({film -> Bool in
            film.name!.contains(searchText)
        })
        table.reloadData()
        
    }
    func ReadFromUrl(url:String){
        do{
            let AppUrl = URL(string: url)!
            let data = try Data(contentsOf: AppUrl)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            print(json)
            let MoviList = json["results"] as! [[String:Any]]
            
           
         //   var arr = [FilmeItem]()
            
            
            for movie in MoviList {
              // MoviList.append(FilmeItem(name: movie["title"]!, image: movie["poster_path"]!, detail: movie["overview"]!))
                
//               filmArray.append(FilmeItem(name: movie["title"]! as! String, image: movie["poster_path"]! as! String, detail: movie["overview"]! as! String))
                filmArray.append(FilmeItem(name: movie["title"]! as! String, image: movie["poster_path"]! as! String, detail: movie["overview"]! as! String))

            }
            table.reloadData()
        }catch{
            print("Cant load from server")
        }
    }

    
}






//
//class Film  {
//    let name : String
//    let image : String
//    init(name : String , image : String) {
//        self.image = image
//        self.name = name
//    }
//
//}

