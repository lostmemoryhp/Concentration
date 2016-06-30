//
//  ViewController.swift
//  Concentration
//
//  Created by 廖海平 on 16/6/23.
//  Copyright © 2016年 廖海平. All rights reserved.
//

import UIKit
enum Difficulty{
    case Easy,Medium,Hard
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    
    func onEasyTapped(sender:UIButton){
        newGameDifficulty(.Easy)
    }
    func onMediumTapped(sender:UIButton){
        newGameDifficulty(.Medium)
    }
    func onHardTapped(sender:UIButton){
        newGameDifficulty(.Hard)
    }


}

private extension ViewController{
    func setUp(){
        view.backgroundColor = UIColor.greenSea()
        
        buildButtonWithCenter(CGPoint(x: view.center.x, y: view.center.y/2.0), title: "EASY", color: UIColor.emerald(), action: "onEasyTapped:")
        buildButtonWithCenter(CGPoint(x: view.center.x, y: view.center.y), title: "MEDIUM", color: UIColor.sunflower(), action: "onMediumTapped:")
        buildButtonWithCenter(CGPoint(x: view.center.x, y: view.center.y*3.0/2.0), title: "HARD", color: UIColor.alizarin(), action:"onHardTapped:")
        
        
    }
    func buildButtonWithCenter(center:CGPoint,title:String, color:UIColor, action: Selector){
        let button = UIButton();
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.frame = CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 200,height: 50))
        button.center = center
        button.backgroundColor = color
        button.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
    }
}

private extension ViewController{
    
    func newGameDifficulty(difficulty:Difficulty){
        let gameViewController = MemoryViewController(difficulty: difficulty)
        presentViewController(gameViewController, animated: true, completion: nil)
        
    }
}

