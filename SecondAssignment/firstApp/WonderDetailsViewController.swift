//
//  WonderDetailsViewController.swift
//  firstApp
//
//  Created by Aditya Tandon on 2019-07-26.
//  Copyright © 2019 Aditya Tandon. All rights reserved.
//

import UIKit

class WonderDetailsViewController: UIViewController {

    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    //var image = UIImage()
    var name = ""
    var detailedContent = ""
    var imageURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: imageURL)!
        downloaded(from: url)
        
        //img.image = image
        heading.text = name
        content.text = detailedContent
        
        
        detailedContent = "The whole content"
        // Do any additional setup after loading the view.
    }
    
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        //contentMode = mode
        print("downloading")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.img.image = image
            }
            }.resume()
    }

    
    
}
