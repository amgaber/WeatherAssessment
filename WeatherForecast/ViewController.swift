//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Alaa Gaber on 02/04/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var cities = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.cities.append("Cairo")
        self.cities.append("Paris")
        self.cities.append("London")
        self.cities.append("Vienna")
        
        self.tableView.reloadData()
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell =
        self.tableView.dequeueReusableCell(withIdentifier: "cell",
                                           for: indexPath) as! TableViewCell
        // Sets the text of the Label in the Table View Cell
        let image = UIImage(systemName: "chevron.right")
        let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!))
        accessory.image = image

        // set the color here
        accessory.tintColor = UIColor.red
        cell.accessoryView = accessory
        
        cell.titleLabel.text = self.cities[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt
                   indexPath: IndexPath){
        
        let mainSB: UIStoryboard = UIStoryboard(name: "Details", bundle: nil)
        let details = mainSB.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        details.cityName = cities[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
           }
           
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
               cities.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .automatic)
           }
        }

