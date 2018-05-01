//
//  GameScene.swift
//  BallRunner
//
//  Created by Navleen Singh on 2017-11-02.
//  Copyright © 2017 Navleen Singh. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class Obstical: SKNode {
    
    private var gameScene: GameScene
    private var numberOfObsticals: Int
    private var previousTime: CFTimeInterval = -1
    
    var speedOfObsticals : CGFloat = 100.0
    var heightRatioOfObsticals : CGFloat = 0.1
    
    init(gameScene: GameScene, numberOfObsticals: Int) {
        self.gameScene = gameScene
        self.numberOfObsticals = numberOfObsticals
        super.init()
        obsticalDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(currentTime: CFTimeInterval) {
        if (previousTime != -1) {
            let yRatio = speedOfObsticals * CGFloat(currentTime - previousTime)
            let heightRatio = heightRatioOfObsticals
            for sknode in self.children {
                //TODO: once y - height = 0 obstical out of bound and remove the obstical
                if let sprite = sknode as? SKSpriteNode {
                    sprite.position = CGPoint(x: sprite.position.x, y: sprite.position.y - yRatio)
                    if(sprite.position.y <= -120){
                        self.removeFromParent()
                        break
                    }
                    //TODO: Fix once y - height = ## stop increasing the size
                    if(sprite.size.height <= 100){
                        sprite.size = CGSize(width: sprite.size.width, height: sprite.size.height + heightRatio)
                    }
                    //print("x: ",sprite.position.x," y: ",sprite.position.y)
                    //print(self.children)
                    //print("width: ",sprite.size.width," height: ",sprite.size.height)
                }
            }
        }
        previousTime = currentTime
    }
    
    public func getSize() -> CGSize {
        for sknode in self.children {
            let sprite = sknode as? SKSpriteNode
            return sprite!.size
        }
        return CGSize()
    }
    
    public func getCordinates() -> CGPoint {
        for sknode in self.children {
            let sprite = sknode as? SKSpriteNode
            return sprite!.position
        }
        return CGPoint()
    }
    
    private func obsticalDisplay() {
//        var randomObstical = Int(arc4random()%obsticalsType.count)
//        var oldRandomObstical = -1
        for i in 0...2 {
//            while oldRandomObstical == randomObstical {
//                randomObstical = Int(arc4random()%obsticalsType.count)
//            }
//            oldRandomObstical = randomObstical
            //Define Bar for the game scene
            let sprite = SKSpriteNode(imageNamed: "obstical_\(obsticalArray[i])")
            //TODO: fix the ratio of width
            sprite.size = CGSize(width: sprite.size.width, height: 0)
            sprite.anchorPoint = CGPoint(x: 0, y: 0)
            sprite.position = CGPoint(x: 0, y: gameScene.size.height)
            sprite.zPosition = 1
            self.addChild(sprite)
        }
    }
    
}


