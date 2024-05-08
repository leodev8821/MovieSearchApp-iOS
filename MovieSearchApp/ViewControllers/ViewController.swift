//
//  ViewController.swift
//  MovieSearchApp
//
//  Created by Mañanas on 8/5/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    //MARK: IBOulets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Properties
    var movies:[Movie] = []
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = movies[indexPath.row]
        let cellTable: ItemsTVC = tableView.dequeueReusableCell(withIdentifier: "itemTableCell", for: indexPath) as! ItemsTVC
        cellTable.render(movie: item)
        
        return cellTable
    }
    
    //MARK: Functions
    // To catch the input text and call the API
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            Task {
                do {
                    try await movies = MovieProvider.getMovies(searchText)
                    // Actualizar la interfaz de usuario después de obtener los superhéroes
                    DispatchQueue.main.async {
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }
                } catch {
                    // Mostrar un mensaje de error al usuario
                    DispatchQueue.main.async {
                        // Por ejemplo, utilizando UIAlertController
                        let alert = UIAlertController(title: "Error", message: "No se pudieron cargar las películas. Por favor, inténtalo de nuevo más tarde.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    print("Error al obtener películas: \(error)")
                }
            }
        }else if searchText.isEmpty {
            self.tableView.isHidden = true
        }
        
    }   //end searchBar
    
    // MARK: Segue
    // To pass values to another ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "navigateToMovieDetail" {
            // Verificar que el destino del segue sea MovieDetailVC
            guard let movieDetailVC = segue.destination as? MovieDetailVC else {
                return
            }
                
            // Obtener el índice del elemento seleccionado en la colección
            if let indexPath = tableView.indexPathForSelectedRow {
                // Obtener el superhéroe seleccionado
                let selectedMovie = movies[indexPath.row]
                // Pasar el objeto SuperHero al DetailViewController
                movieDetailVC.movies = selectedMovie
            }
        }
    }

}

