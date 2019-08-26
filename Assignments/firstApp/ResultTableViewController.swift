//
//  TableTableViewController.swift
//  firstApp
//
//  Created by Aditya Tandon on 2019-07-20.
//  Copyright © 2019 Aditya Tandon. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
 var wondersOfTheWorld: [String] = []
    var imageNames: [String] = []
    var wonders: [Wonders] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        wondersOfTheWorld = ["Great Pyramid of Giza", "Colossus of Rhodes", "Hanging Gardens of Babylon", "Lighthouse of Alexandria", "Mausoleum at Halicarnassus", "Statue of Zeus at Olympia", "Temple of Artemis at Ephesu"]
        imageNames = ["pyramids", "statue", "flowers", "lighthouse", "tomb", "statue", "temple"]
        
        loadJsonFile()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func loadJsonFile(){
        guard let jsonFile = Bundle.main.path(forResource: "wonders", ofType: "json") else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile))
        guard
        let data = optionalData,
        let json = try? JSONSerialization.jsonObject(with: data),
        let dictionary = json as? [String: Any],
        let wondersDictionary = dictionary["features"] as? [[String: Any ]]
        else { return }
        let validWonders = wondersDictionary.compactMap { Wonders(wonder: $0) }
        wonders.append(contentsOf: validWonders)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wondersOfTheWorld.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultTableViewCell.self), for: indexPath)
            as? ResultTableViewCell else { return UITableViewCell() }

        // Configure the cell...
//        if indexPath.item % 2 == 0{
//            cell.backgroundColor = UIColor.gray
//        }else{
//            cell.backgroundColor = UIColor.darkGray
//        }
        
        cell.wondersLabel.text = wonders[indexPath.row].name
        
        cell.icon.image = UIImage(named: imageNames[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 300
    }
    
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
