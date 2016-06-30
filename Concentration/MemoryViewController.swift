//
//  MemoryViewController.swift
//  Concentration
//
//  Created by 廖海平 on 16/6/26.
//  Copyright © 2016年 廖海平. All rights reserved.
//

import Foundation
import UIKit

class MemoryViewController :UIViewController {
    private let difficulty : Difficulty
    private var collectionView:UICollectionView!
    private var deck:Deck!
    private var selectedIndexes = Array<NSIndexPath>()
    private var numberOfPairs = 0
    private var score = 0
    
    init(difficulty:Difficulty){
        self.difficulty = difficulty
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        startup()
    }
    
    func startup(){
        deck=createDeck(numCardsNeededDifficulty(difficulty))
        for i in 0..<deck.count{
            print("The card at index [\(i)] is \(deck[i].description)")
        }
        collectionView.reloadData()
    }
    
    func createDeck(numCards: Int) -> Deck{
        let fullDeck = Deck.full().shuffled()
        let halfDeck = fullDeck.deckOfNumberOfCards(numCards/2)
        return (halfDeck + halfDeck).shuffled()
    }
    
    func numCardsNeededDifficulty(difficulty:Difficulty)->Int{
        let (columns,rows) = sizeDifficulty(difficulty)
        return Int(columns * rows)
    }
    
}




//MARK: Setup
private extension MemoryViewController{
    func setup(){
        view.backgroundColor = UIColor.greenSea()
        let space:CGFloat =  5;
        let (covWidth, covHeight) = collectionViewSizeDifficulty(difficulty,space:space)
        
        let layout = layoutCardSize(cardSizeDifficulty(difficulty, space: space),space:space);
        collectionView = UICollectionView(frame: CGRect(x:0,y:0, width: covWidth,height:covHeight), collectionViewLayout:layout)
        collectionView.center = view.center
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollEnabled=false
        collectionView.registerClass(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        collectionView.backgroundColor = UIColor.clearColor()
        
        self.view.addSubview(collectionView)

    }
    func layoutCardSize(cardSize:(cardWidth:CGFloat,cardHeight:CGFloat), space: CGFloat)->UICollectionViewLayout{
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.itemSize = CGSize(width: cardSize.cardWidth, height: cardSize.cardHeight)
        layout.minimumLineSpacing = space
        return layout
    }
    
    func collectionViewSizeDifficulty(diffculty:Difficulty,space:CGFloat)->(CGFloat,CGFloat){
        let (columns, rows) = sizeDifficulty(diffculty)
        let (cardWidth,cardHeight) = cardSizeDifficulty(diffculty,space: space)
        let covWidth = columns * (cardWidth + 2*space)
        let covHeight = rows * (cardHeight + space)
        return (covWidth, covHeight)
    }
    
    func sizeDifficulty(difficulty:Difficulty)->(CGFloat,CGFloat){
        switch(difficulty){
        case .Easy:
            return (4,3)
        case .Medium:
            return (6,4)
        case .Hard:
            return (8,4)
        }
        
    }
    func cardSizeDifficulty(difficulty:Difficulty,space:CGFloat)->(CGFloat,CGFloat){
        let ratio:CGFloat = 1.452
        let (_,rows) = sizeDifficulty(difficulty)
        let cardHeight: CGFloat = view.frame.height / rows - 2 * space
        let cardWidth: CGFloat = cardHeight / ratio
        return (cardWidth,cardHeight)
    }
}

//MARK:  uicollectionview  datasource
extension MemoryViewController:UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deck.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! CardCell
        cell.backgroundColor = UIColor.sunflower()
        let card = deck[indexPath.row]
        cell.renderCardName(card.description, backImageName: "back")
        return cell
        
    }
}

//MARK: uicollectionview delegate
extension MemoryViewController:UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if  selectedIndexes.count==2 || self.selectedIndexes.contains(indexPath){
            return
        }
        self.selectedIndexes.append(indexPath)
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CardCell
        cell.upturn()
        
        if selectedIndexes.count<2{
            return
        }
        
        let card1 = deck[selectedIndexes[0].row]
        let card2 = deck[selectedIndexes[1].row]
        
        if card1 == card2 {
            numberOfPairs++
            checkIfFinished()
            removeCards()
        } else{
            score++
            turnCardsFaceDown()
        }
    }
}


//MARK: actions
extension MemoryViewController{
    func checkIfFinished(){
        if  numberOfPairs == deck.count/2{
            showFinalPopUp()
        }
    }
    
    func showFinalPopUp(){
        var alert = UIAlertController(title: "Great!",
            message: "You won with score: \(score)!",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func removeCards(){
        execAfter(1.0, block: {
            self.removeCardsAtPlaces(self.selectedIndexes)
            self.selectedIndexes = Array<NSIndexPath>()
        })
    }
    func removeCardsAtPlaces(places: Array<NSIndexPath>){
        for index in places{
            let cardCell = collectionView.cellForItemAtIndexPath(index) as! CardCell
            cardCell.remove()
        }
    }
    func turnCardsFaceDown(){
        execAfter(2.0, block: {
            self.downturnCardsAtPlaces(self.selectedIndexes)
            self.selectedIndexes = Array<NSIndexPath>()
        })
        
    }
    func downturnCardsAtPlaces(places: Array<NSIndexPath>){
        for index in places{
            let cardcell = collectionView.cellForItemAtIndexPath(index) as! CardCell
            
            cardcell.downturn()
        }
    }
    
    
}














