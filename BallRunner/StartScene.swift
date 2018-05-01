//
//  startScene.swift
//  BallRunner
//
//  Created by Navleen Singh on 2018-01-04.
//  Copyright © 2018 Navleen Singh. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class StartScene: SKScene {

    // you can use another font for the label if you want...
    let tapStartLabel = SKLabelNode(fontNamed: "STHeitiTC-Medium")

    override func didMove(to view: SKView) {
        // set the background
        backgroundColor = SKColor.white
        
        // set size, color, position and text of the tapStartLabel
        tapStartLabel.fontSize = 16
        tapStartLabel.fontColor = SKColor.black
        tapStartLabel.horizontalAlignmentMode = .center
        tapStartLabel.verticalAlignmentMode = .center
        tapStartLabel.position = CGPoint(
            x: size.width / 2,
            y: size.height / 2
        )
        tapStartLabel.text = "Tap to start the game"
        
        // add the label to the scene
        addChild(tapStartLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = scaleMode
        
        // use a transition to the gameScene
        let reveal = SKTransition.doorsOpenVertical(withDuration: 1)
        
        // transition from current scene to the new scene
        view!.presentScene(gameScene, transition: reveal)
    }
}
