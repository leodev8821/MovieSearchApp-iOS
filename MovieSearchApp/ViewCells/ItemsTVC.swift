//
//  ItemsTVC.swift
//  MovieSearchApp
//
//  Created by Mañanas on 8/5/24.
//

import UIKit

class ItemsTVC: UITableViewCell {
    
    @IBOutlet weak var posterIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    
    func render(movie: Movie) {
        // Establecer el icono de prioridad basado en el valor de `priority`
        posterIV.loadImage(fromURL: movie.Poster ?? "https://via.placeholder.com/150?text=Image+Not+Found")
        titleLabel.text = movie.Title
        yearLabel.text = movie.Year
        typeLabel.text = "Movie"
    }
    
    override func awakeFromNib() {
        cardView.layer.cornerRadius = CGFloat(8)
        cardView.layer.borderColor = UIColor(named: "colors/light-gray")?.cgColor
        cardView.layer.borderWidth = CGFloat(0.5)
        cardView.layer.shadowColor = UIColor(named: "colors/light-gray")?.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2, height: 3)
        cardView.layer.shadowOpacity = 10.0
    }
    
}
