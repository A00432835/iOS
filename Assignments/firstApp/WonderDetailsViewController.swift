//
//  WonderDetailsViewController.swift
//  firstApp
//
//  Created by Aditya Tandon on 2019-07-26.
//  Copyright © 2019 Aditya Tandon. All rights reserved.
//

import UIKit
import CoreLocation

class WonderDetailsViewController: UIViewController {

    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var activityIndicatorView : UIActivityIndicatorView!
    var wonders: Wonders?
    
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
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(WonderDetailsViewController.tappedImage))
        img.addGestureRecognizer(tapImage)
        img.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tappedImage() { showAlert() }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Alert", message: "Copy Image URL?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Copy", style: .default) { (action:UIAlertAction!) in
            UIPasteboard.general.string = self.imageURL
        })
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alertController, animated: true, completion:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            let mapViewController = segue.destination as? MapViewController
            if let latitude = wonders?.coordinates[1],let longitude = wonders?.coordinates[0] {
                mapViewController?.wonderLocation = CLLocation(latitude: latitude, longitude: longitude)
                mapViewController?.wonderNewLocation = CLLocation(latitude: latitude + 0.0015, longitude: longitude + 0.0015)
                    mapViewController?.wonderName = wonders?.name
                
            }
            
            
        }
    }
    
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        //contentMode = mode
        spinner(shouldSpin: true)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.img.image = image
                self.spinner(shouldSpin: false)
            }
            }.resume()
        
    }

    func spinner(shouldSpin status: Bool) {
        if status == true {
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
        }
        else{
            activityIndicatorView.isHidden = true
            activityIndicatorView.stopAnimating()
        }
    }
    
}
