//
//  GameScene.swift
//  BallRunner
//
//  Created by Navleen Singh on 2017-11-02.
//  Copyright © 2017 Navleen Singh. All rights reserved.
//

import SpriteKit
import GameplayKit
//import Foundation
//
//extension UIView {
//
//
//    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
//        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
//            self.alpha = 1.0
//        }, completion: completion)  }
//
//    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
//        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
//            self.alpha = 0.0
//        }, completion: completion)
//    }
//
//}

class GameScene: SKScene {

    //Variables
    var obsticals = [Obstical!]()
    var player: Player = Player()
    var previousTime: CFTimeInterval = -1
    var start: (location: CGPoint, time: TimeInterval)?
    let minDistance: CGFloat = 25
    let minSpeed: CGFloat = 1000
    let maxSpeed: CGFloat = 6000
    var jump: Bool = false
    var ballSize: CGSize = CGSize(width: 41, height: 41)
    let tapStartLabel = SKLabelNode(fontNamed: "STHeitiTC-Medium")
    
    
    override func didMove(to view: SKView) {
        
        //Add to the screen
        let background = mainImages(image: "gameBackground")
        background.zPosition = -1
        self.addChild(background)

        //TODO: think about moving this to an object so if the player hits it they dont go out of bounds
        let leftBar = mainImages(image: "leftBar")
        leftBar.zPosition = 2
        self.addChild(leftBar)
        
        let rightBar = mainImages(image: "rightBar")
        rightBar.zPosition = 2
        self.addChild(rightBar)
        
        let platform = mainImages(image: "platform")
        platform.zPosition = 0
        self.addChild(platform)
        
        setupPlayer()
        
        // set size, color, position and text of the tapStartLabel
        tapStartLabel.fontSize = 60
        tapStartLabel.fontColor = SKColor.white
        tapStartLabel.horizontalAlignmentMode = .center
        tapStartLabel.verticalAlignmentMode = .center
        tapStartLabel.position = CGPoint(
            x: size.width / 2,
            y: size.height / 2
        )
        tapStartLabel.text = "Tap to jump"
        
        // add the label to the scene
        addChild(tapStartLabel)
        let fadeAction = SKAction.fadeOut(withDuration: 6.0)
        tapStartLabel.run(fadeAction)
        //createObsticals(index: 0)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if(previousTime == -1 || (currentTime - previousTime) >= 5){
            previousTime = currentTime
            //print(currentTime - previousTime)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                self.createObsticals(index: self.obsticals.count)
            })
            
            //player.setScale(1)
        }
        if(player.size.width >= 80 && player.size.height >= 80){
            jump = false
        }
        //print(player.size)
        if (jump){
            ballSize = CGSize(width: 82, height: 82)
        }else if(!jump){
            ballSize = CGSize(width: 41, height: 41)
        }
        let scale = SKAction.scale(to: ballSize, duration: 0.2)
        player.run(scale)
        
//        let playerAnimation = SKAction.repeatForever(SKAction.animate(with: playerTextures, timePerFrame: 0.1))
//        self.run(playerAnimation)
        for i in 0..<obsticals.count {
            obsticals[i].update(currentTime: currentTime)
            //Check if child is removed then remove it from array
            //print("x: ",obsticals[i].getCordinates().x," y: ",obsticals[i].getCordinates().y)
            //print("width: ",obsticals[i].getSize().width," height: ",obsticals[i].getSize().height)
        }
        
    }
    
    //Set the start location and timestamp when user pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //createObsticals(index: obsticals.count)
        //player.setScale(2)
//        if let touch = touches.first {
//            start = (touch.location(in: self), touch.timestamp)
//        }
        jump = true
    }
    //Apply the swipe fucntion when user picks the fingure
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        var swiped = false
//        if let touch = touches.first, let startTime = self.start?.time, let startLocation = self.start?.location {
//            let location = touch.location(in: self)
//            let dx = location.x - startLocation.x
//            let dy = location.y - startLocation.y
//            let distance = sqrt(dx*dx+dy*dy)
//
//            if (distance > minDistance){
//                let deltaTime = CGFloat(touch.timestamp - startTime)
//                let speed = distance / deltaTime
//
//                if (speed >= minSpeed && speed <= maxSpeed){
//                    let x = abs(dx/distance) > 0.4 ? Int(sign(Float(dx))) : 0
//                    let y = abs(dy/distance) > 0.4 ? Int(sign(Float(dy))) : 0
//
//                    swiped = true
//                    switch (x,y) {
//                    case (0,1):
//                        jump = true
////                    case (0,-1):
////                        print("swiped down")
////                    case (-1,0):
////                        print("swiped left")
////                    case (1,0):
////                        print("swiped right")
////                    case (1,1):
////                        print("swiped diag up-right")
////                    case (-1,-1):
////                        print("swiped diag down-left")
////                    case (-1,1):
////                        print("swiped diag up-left")
////                    case (1,-1):
////                        print("swiped diag down-right")
//                    default:
//                        swiped = false
//                        break
//                    }
//                }
//            }
//        }
//        start = nil
//        if (!swiped){
//            // Process non-swipes (taps, etc.)
//            print("not a swipe")
//        }
//    }
    private func mainImages(image: String) -> SKSpriteNode {
        let image = SKSpriteNode(imageNamed: image)
        image.size = self.size
        image.anchorPoint = CGPoint(x: 0, y: 0)
        image.position = CGPoint(x: 0, y: 0)
        return image
    }
    
    private func createObsticals(index: Int) {
        //TODO: add blank obstical
        let randNumberOfObsticals = Int(arc4random()%obsticalsType.count)
        //zprint("Number of obsicals: ",randNumberOfObsticals+1)
        let obstical = Obstical(gameScene: self, numberOfObsticals: randNumberOfObsticals)
        //obstical.speedOfObsticals = 50.0
        self.addChild(obstical)
        obsticals.append(obstical)
    }
    
    //Correct way to create a player in a position
    private func setupPlayer(){
        //let rect = CGRect(x: 0, y: 0, width: self.frame.maxX, height: self.frame.maxY)
        //let midX = rect.midX
        player.position = CGPoint(x: self.size.width/2, y: self.size.height*0.05)
        player.zPosition = 2
        addChild(player)
    }
}
