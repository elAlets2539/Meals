//
//  RegistrarComidaViewController.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 06/06/22.
//

import UIKit

class RegistrarComidaViewController: UIViewController {
    
    let menu = Menu.menu
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var tableHeight: NSLayoutConstraint?
    
    var results = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    let registrarNuevaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Registrar comida nueva", for: .normal)
        button.setTitleColor(UIColor(named: "Text"), for: .normal)
        button.backgroundColor = UIColor(named: "Inicio Buttons")
        button.layer.cornerRadius = 20
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(registrarNueva), for: .touchUpInside)
        return button
    }()
    
    let buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    func setupViews() {
        
        view.backgroundColor = UIColor(named: "InicioBG")
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Buscar comida"
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = view.backgroundColor
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(buttonView)
        buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        buttonView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        buttonView.addSubview(registrarNuevaButton)
        
        registrarNuevaButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
        registrarNuevaButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
        registrarNuevaButton.widthAnchor.constraint(equalTo: buttonView.widthAnchor, multiplier: 0.7).isActive = true
        
    }
    
    @objc func registrarNueva() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let agregarComidaVC = storyboard.instantiateViewController(withIdentifier: "AgregarComidaVC") as! AgregarComidaViewController
        agregarComidaVC.modo = .registrar
        agregarComidaVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(agregarComidaVC, animated: true, completion: nil)
        
    }
    
}

extension RegistrarComidaViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        results = menu.filterResults(searchText)
        tableView.reloadData()
        tableHeight?.constant = tableView.contentSize.height
        
    }
    
}

extension RegistrarComidaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = results[indexPath.row]
        
        cell.backgroundColor = view.backgroundColor
        
        cell.contentConfiguration = content
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "¿Registrar \(results[indexPath.row])?", message: "", preferredStyle: .alert)
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .default) { action in
            print("Aceptado")
            let dataManager = DataManager()
            dataManager.registrarComida()
        }
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .default) { action in
            self.dismiss(animated: true)
        }

        alert.addAction(cancelar)
        alert.addAction(aceptar)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
