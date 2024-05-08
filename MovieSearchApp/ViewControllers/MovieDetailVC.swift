//
//  MovieDetailVC.swift
//  MovieSearchApp
//
//  Created by Mañanas on 8/5/24.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    //MARK: IBOulets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieCountry: UILabel!
    
    //MARK: Properties
    var movies: Movie?
    var movie: MovieDetail?
    
    // MARK: LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCardView()
        loadData()
    }   //end viewDidLoad()
    
    //MARK: Functions
    func loadData() {
        guard let imdbID = movies?.imdbID else {
                return
            }
        
        Task {
            do {
                try await movie = MovieProvider.getMovie(imdbID)
                // Actualizar la interfaz de usuario después de obtener los superhéroes
                DispatchQueue.main.async {
                    self.updateUI()
                }
            } catch {
                // Mostrar un mensaje de error al usuario
                DispatchQueue.main.async {
                    // Por ejemplo, utilizando UIAlertController
                    let alert = UIAlertController(title: "Error", message: "No se pudo cargar la película seleccionada. Por favor, inténtalo de nuevo más tarde.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                print("Error al obtener la película: \(error)")
            }   //end do-catch
        }   //end Task
    }   //end loadData()
    
    func updateUI() {
        guard let movie = movie else {
            return
        }
        
        // Actualizar los IBOutlets con los datos de la película
        moviePoster.loadImage(fromURL: movie.Poster ?? "https://via.placeholder.com/150?text=Image+Not+Found")
        movieTitle.text = movie.Title
        movieYear.text = movie.Year
        moviePlot.text = movie.Plot
        movieRuntime.text = movie.Runtime
        movieDirector.text = movie.Director
        movieGenre.text = movie.Genre
        movieCountry.text = movie.Country
    }
    
    func setupCardView() {
        cardView.layer.cornerRadius = CGFloat(8)
        cardView.layer.borderColor = UIColor(named: "colors/light-gray")?.cgColor
        cardView.layer.borderWidth = CGFloat(0.5)
        cardView.layer.shadowColor = UIColor(named: "colors/light-gray")?.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2, height: 3)
        cardView.layer.shadowOpacity = 10.0
    }
}
