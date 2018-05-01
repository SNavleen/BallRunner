//
//  GameViewController.swift
//  BallRunner
//
//  Created by Navleen Singh on 2017-11-02.
//  Copyright © 2017 Navleen Singh. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let screenSize = UIScreen.main.bounds
//        let screenWidth = screenSize.width
//        let screenHeight = screenSize.height
        
        if let view = self.view as! SKView? {
//            let scene = GameScene()
            let scene = StartScene(size: CGSize(width: 640, height: 1136))
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
