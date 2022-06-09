//
//  RegistrarComidaTableViewCell.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 09/06/22.
//

import UIKit

class RegistrarComidaTableViewCell: UITableViewCell {
    
    var nombreLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Text")
        return label
        
    }()
    
    var tiempoLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(named: "InicioBG")
        
        contentView.addSubview(nombreLabel)
        contentView.addSubview(tiempoLabel)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        
        nombreLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nombreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.bounds.width * 0.06).isActive = true
        nombreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        nombreLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6).isActive = true
        
        tiempoLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tiempoLabel.leadingAnchor.constraint(equalTo: nombreLabel.trailingAnchor).isActive = true
        tiempoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        tiempoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.bounds.width * 0.06).isActive = true
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
