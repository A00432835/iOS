//
//  GameViewController.swift
//  firstApp
//
//  Created by Aditya Tandon on 2019-07-13.
//  Copyright © 2019 Aditya Tandon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var number: UITextField!
    
    @IBOutlet weak var answer: UITextField!
    
    @IBOutlet weak var howMany: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNumberField()
        setHowMany()
        // Do any additional setup after loading the view.
    }
    
    func setNumberField(){
        number?.text = generateRandString()
    }
    func setHowMany(){
        howMany?.text = generateRandStringBelow4()
    }
    
    
    
    func showLostAlert(){
        let alert = UIAlertController(title: "Sorry, You lost", message: "Please Try Again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler:nil))
        present(alert, animated: true, completion: nil)
    }
    
//    func showWinAlert(){
//        let alert = UIAlertController(title: "You WON!", message: "Congratulations!!!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title:"OK", style: .default, handler:nil))
//        present(alert, animated: true, completion: nil)
//    }
    
    func navigateToNextScreen() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier:"WonViewController")
        present(viewController, animated: true, completion: nil)
        
//        let range = 7...
//        if range.contains(Int(numericSlider.value)){
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = storyBoard.instantiateViewController(withIdentifier:"WonViewController")
//            present(viewController, animated: true, completion: nil)
//        }
    }
    
    func generateRandString() -> String {
        var result:String = ""
        for _ in 1...4{
            let digit:Int =  Int(arc4random_uniform(5)+1)
            result += "\(digit)"
        }
        return result
        
    }
    
    func generateRandStringBelow4() -> String {
        var result:String = ""
        let digit:Int =  Int(arc4random_uniform(3)+1)
            result = "\(digit)"
        return result
        
    }
    
    @IBAction func submit(_ sender: Any) {
        
        let answerCount = answer?.text?.count
        
        if answerCount ?? 0 < 4 {
            return
        }
        if let number_text = number?.text,
        let input = answer?.text,
        let num_Int = Int(number_text),
        let input_Int = Int(input),
        let mul_factor = howMany?.text,
        let mul = Int(mul_factor)
        {
            if(input_Int - num_Int == (1111 * mul)){
                navigateToNextScreen()
            }
            else {
                showLostAlert()
            }
        }
        
        
    }
}
