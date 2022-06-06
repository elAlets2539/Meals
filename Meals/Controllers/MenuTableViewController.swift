//
//  MenuTableViewController.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 03/06/22.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var colMatutina: [Comida] = []
    var desayunos: [Comida] = []
    var colVespertina: [Comida] = []
    var comidas: [Comida] = []
    var colNocturna: [Comida] = []
    var cenas: [Comida] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuCell")

        self.title = "Menú"
        self.tableView.backgroundColor = UIColor(named: "InicioBG")
        
        let menu = Menu.menu
        
        colMatutina = menu.colacionesMat
        desayunos = menu.desayunos
        colVespertina = menu.colacionesVesp
        comidas = menu.comidas
        colNocturna = menu.colacionesNoct
        cenas = menu.cenas
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return colMatutina.count
        case 1:
            return desayunos.count
        case 2:
            return colVespertina.count
        case 3:
            return comidas.count
        case 4:
            return colNocturna.count
        case 5:
            return cenas.count
        default:
            break
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrays = [colMatutina, desayunos, colVespertina, comidas, colNocturna, cenas]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = arrays[indexPath.section][indexPath.row].nombre
        
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor(named: "Inicio Buttons")

        return cell
    }

    /*override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["Colaciones matutinas", "Desayunos", "Colaciones vespertinas", "Comidas", "Colaciones nocturnas", "Cenas"]
    }*/
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Colaciones matutinas"
        case 1:
            return "Desayunos"
        case 2:
            return "Colaciones vespertinas"
        case 3:
            return "Comidas"
        case 4:
            return "Colaciones nocturnas"
        case 5:
            return "Cenas"
        default:
            return ""
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
