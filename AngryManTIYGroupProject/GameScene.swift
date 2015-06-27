//
//  GameScene.swift
//  AngryManTIYGroupProject
//
//  Created by Shannon Armon on 6/26/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    
    var ceo: SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

        ceo = childNodeWithName("ceo") as! SKSpriteNode
        
    }
    
   override func touchesBegan(touches: Set<NSObject>, withEvent: UIEvent)  {
    
    
            let juniorDeveloper = SKShapeNode(fileNamed: "juniorDeveloper")
            juniorDeveloper.physicsBody = SKPhysicsBody.self
                juniorDeveloper.position = CGPointMake(200, 100)
    
                        addChild(juniorDeveloper)
    
                juniorDeveloper.physicsBody?.applyImpulse(CGVectorMake(500, 300))
    
    
    
    
        
        }
        


   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
