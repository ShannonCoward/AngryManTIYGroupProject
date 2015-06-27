//
//  GameScene.swift
//  AngryManTIYGroupProject
//
//  Created by Shannon Armon on 6/26/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var fireballSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("fireball", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    var ceo: SKSpriteNode!
    var juniorIcon: SKSpriteNode!
    var fullStackIcon: SKSpriteNode!
    var computer: SKSpriteNode!
    
    let computerCategory: UInt32 = 1
    let jdConsultantCategory: UInt32 = 2
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        ceo = childNodeWithName("CEO.png") as? SKSpriteNode
        juniorIcon = childNodeWithName("JuniorDeveloper.png") as? SKSpriteNode
        fullStackIcon = childNodeWithName("FullStacker.png") as? SKSpriteNode
        computer = childNodeWithName("computer") as? SKSpriteNode
        
        
        println(computer)
        computer.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        computer.physicsBody?.usesPreciseCollisionDetection = true
        computer.physicsBody?.categoryBitMask = computerCategory
        println(computer.physicsBody?.categoryBitMask)
        
        self.physicsWorld.contactDelegate = self
        
        
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent: UIEvent)  {
        
        
        let jdConsultant = SKSpriteNode(imageNamed: "JuniorDeveloper.png")
        jdConsultant.physicsBody = SKPhysicsBody(circleOfRadius: 17)
        jdConsultant.position = CGPointMake(200, 100)
        jdConsultant.physicsBody?.usesPreciseCollisionDetection = true
        jdConsultant.physicsBody?.categoryBitMask = jdConsultantCategory
        jdConsultant.physicsBody?.contactTestBitMask = computerCategory
        println(jdConsultant.physicsBody?.categoryBitMask)
        
        //    jdConsultant.position = ceo.position
        addChild(jdConsultant)
        
        jdConsultant.physicsBody?.applyImpulse(CGVectorMake(35, 35))
        
        
        
        //    var soundEffect = SKAction.playSoundFileNamed("fireball", waitForCompletion: false)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: fireballSound, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let firstNode = contact.bodyA.node as! SKSpriteNode
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        println("test 1")
        
        if (contact.bodyA.categoryBitMask == computerCategory) &&
            (contact.bodyB.categoryBitMask == jdConsultantCategory) {
                
                println("Score")
                
                let contactPoint = contact.contactPoint
                let contact_x = contactPoint.x
                let contact_y = contactPoint.y
                let target_y = secondNode.position.y
                let margin = secondNode.frame.size.height/2 - 25
                
                if (contact_y > (target_y - margin))
                    && (contact_y < (target_y + margin)) {
                        //                        let texture = SKTexture(imageNamed: "ArrowHitTexture")
                        //                        firstNode.texture = texture
                        let joint =
                        SKPhysicsJointFixed.jointWithBodyA(contact.bodyA,
                            bodyB: contact.bodyB,
                            anchor: CGPointMake(contact_x, contact_y))
                        self.physicsWorld.addJoint(joint)
                        println("score")
                }
        }
        
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
















