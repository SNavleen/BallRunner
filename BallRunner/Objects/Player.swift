//
//  Player.swift
//  BallRunner
//
//  Created by Navleen Singh on 2017-12-19.
//  Copyright © 2017 Navleen Singh. All rights reserved.
//


import Foundation
import GameplayKit
import SpriteKit

class Player: SKSpriteNode {
    
    private var playerColour: String = "RedBlack"
    
    init(){
        let texture = SKTexture(imageNamed: "player_\(playerColour)_1")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        //animate()
        displayPlayer()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    private func displayPlayer(){
        let image = SKSpriteNode(imageNamed: "player_\(playerColour)_1")
        self.addChild(image)
        
    }
    private func animate(){
        var playerTextures:[SKTexture] = []
        for i in 1...2 {
            playerTextures.append(SKTexture(imageNamed: "player_\(playerColour)_\(i)"))
        }
        let playerAnimation = SKAction.repeatForever(SKAction.animate(with: playerTextures, timePerFrame: 0.1))
        self.run(playerAnimation)
    }
}
