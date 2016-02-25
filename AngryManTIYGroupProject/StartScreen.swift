//
//  StartScreen.swift
//  AngryManTIYGroupProject
//
//  Created by Shannon Armon on 6/28/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

var startGameLabel: SKLabelNode!
var redButton: SKSpriteNode!

var swtheme = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("swtheme", ofType: "wav")!)
var audioPlayer = AVAudioPlayer()

class StartScreen: SKScene {
    
    
    override func didMoveToView(view: SKView) {
        
        
   
    var button = SKSpriteNode(imageNamed: "keyboardBackground.png")
    
            // Setup your scene here
            
            let bgImage = SKSpriteNode(imageNamed: "wallpaper.png")
            
            bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
            
            self.addChild(bgImage)
        
        var soundEffect = SKAction.playSoundFileNamed("swtheme.wav", waitForCompletion: false)
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: swtheme)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {

            let transition = SKTransition.flipVerticalWithDuration(1.0)
            self.scene!.view!.presentScene(scene, transition: transition)
            
            var soundEffect = SKAction.playSoundFileNamed("swtheme.wav", waitForCompletion: false)
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: swtheme)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
        }
        
    }
}

