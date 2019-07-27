//
//  NewWondersTableViewController.swift
//  firstApp
//
//  Created by Aditya Tandon on 2019-07-20.
//  Copyright © 2019 Aditya Tandon. All rights reserved.
//

import UIKit

class NewWondersTableViewController: UIViewController {
    var wonders: [Wonders] = []
    var image = UIImage()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonFile()

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension NewWondersTableViewController: UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return wonders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellViewCell.self), for: indexPath)
            as? CellViewCell else { return UITableViewCell() }
        
        
        cell.wondersLabelView.text = wonders[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "WonderDetailsViewController") as? WonderDetailsViewController else { return }
        print("itemselected\(wonders[indexPath.row].name)")
        vc.name = wonders[indexPath.row].name
        vc.detailedContent = wonders[indexPath.row].description ?? "No description given"
        
        
        vc.imageURL = wonders[indexPath.row].imageURL
        
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    
}
