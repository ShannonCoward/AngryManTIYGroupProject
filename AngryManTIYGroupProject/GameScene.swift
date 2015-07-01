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
    
    let newCeoSize = CGSizeMake(300, 442)
    
    var xLabel: SKLabelNode!
    var yLabel: SKLabelNode!
    
    var budgetLabel: SKLabelNode!
    
    var selectJD: SKNode!
    
    var reset: SKSpriteNode!
    
    var selectFullStack: SKSpriteNode!
    
    var budgetNumber: Int = 50000
    
    override func didMoveToView(view: SKView) {
        // Setup your scene here
   
        var bgImage = SKSpriteNode(imageNamed: "wallpaper.png")
        
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        
        self.addChild(bgImage)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
       
        println(physicsWorld.gravity)
        
        selectFullStack = childNodeWithName("buttonTwo") as? SKSpriteNode
        selectJD = childNodeWithName("buttonOne") as? SKSpriteNode
        ceo = childNodeWithName("ceo") as? SKSpriteNode
        juniorIcon = childNodeWithName("JuniorDeveloper.png") as? SKSpriteNode
        fullStackIcon = childNodeWithName("FullStacker.png") as? SKSpriteNode
        computer = childNodeWithName("computer") as? SKSpriteNode
        
        
        
        ceo.size = newCeoSize
        
        println(computer)
        computer.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(20, 20))
        computer.physicsBody?.usesPreciseCollisionDetection = true
        computer.physicsBody?.categoryBitMask = computerCategory
        println(computer.physicsBody?.categoryBitMask)
        
        self.physicsWorld.contactDelegate = self
        
        budgetLabel = childNodeWithName("budgetLabel") as? SKLabelNode
        xLabel = childNodeWithName("xLabel") as? SKLabelNode
        yLabel = childNodeWithName("yLabel") as? SKLabelNode
        
        selectJD = childNodeWithName("juniorIcon") as? SKSpriteNode
        selectFullStack = childNodeWithName("fullStackIcon") as? SKSpriteNode
        
        
        
        increaseX = childNodeWithName("increaseX") as? SKSpriteNode
        increaseY = childNodeWithName("increaseY") as? SKSpriteNode
        decreaseX = childNodeWithName("decreaseX") as? SKSpriteNode
        decreaseY = childNodeWithName("decreaseY") as? SKSpriteNode
        
    
    }
    
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent: UIEvent)  {
//        
//        println(ceo)
//        println(ceo.position)
//        
//        let jdConsultant = SKSpriteNode(imageNamed: "JuniorDeveloper.png")
//        jdConsultant.physicsBody = SKPhysicsBody()
//        jdConsultant.position = CGPointMake(400, 200)
////        jdConsultant.physicsBody?.mass = 0.05
//        jdConsultant.physicsBody?.usesPreciseCollisionDetection = true
//        jdConsultant.physicsBody?.categoryBitMask = jdConsultantCategory
//        jdConsultant.physicsBody?.contactTestBitMask = computerCategory
//        println(jdConsultant.physicsBody?.categoryBitMask)
//        
//        //    jdConsultant.position = ceo.position
//        addChild(jdConsultant)
//        
//        jdConsultant.physicsBody?.applyImpulse(CGVectorMake(35, 35))
//        
//        
//        
//        //    var soundEffect = SKAction.playSoundFileNamed("fireball", waitForCompletion: false)
//        
//        audioPlayer = AVAudioPlayer(contentsOfURL: fireballSound, error: nil)
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
//        
//        
//        
//    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        touchPoint = location
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var juniorDevelper = childNodeWithName("JuniorDeveloper.png") as? SKSpriteNode
        var fullStacker = childNodeWithName("FullStacker.png") as? SKSpriteNode
        
        selectJD = childNodeWithName("buttonOne") as? SKSpriteNode
        
        touching = false
        
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            
            
            
            if let selectJD = selectJD {
                
                if selectJD.containsPoint(location) {
                   
//                    let projectile = SKSpriteNode(imageNamed: "JuniorDeveloper.png")
                    
                    let projectileTexture = SKTexture(imageNamed: "JuniorDeveloper.png")
                    
                    
                    let projectile = SKSpriteNode(texture: projectileTexture, size: CGSizeMake(200, 200))
                    
                    
                    projectile.physicsBody = SKPhysicsBody(circleOfRadius: 20)
                    projectile.physicsBody?.affectedByGravity = true
                    projectile.physicsBody?.usesPreciseCollisionDetection = true
                    projectile.position = CGPoint(x: 250, y: 250)
                    projectile.physicsBody?.categoryBitMask = jdConsultantCategory
                    projectile.physicsBody?.contactTestBitMask = computerCategory
                    addChild(projectile)
                    projectile.physicsBody?.applyImpulse(CGVectorMake(velocityX, velocityY))
                    projectile.physicsBody?.mass = CGFloat(0.01)
                    budgetNumber = budgetNumber - 2500
                    
                    var soundEffect = SKAction.playSoundFileNamed("fireball.wav", waitForCompletion: false)
                    
                    audioPlayer = AVAudioPlayer(contentsOfURL: fireballSound, error: nil)
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                    
              
                }
                
            }
            
            selectFullStack = childNodeWithName("buttonTwo") as? SKSpriteNode
            
            
            if let selectFullStack = selectFullStack {
                
                if selectFullStack.containsPoint(location) {
                    
                    
                    let projectileTexture = SKTexture(imageNamed: "FullStacker.png")
                    
                    let projectile1 = SKSpriteNode(texture: projectileTexture, size: CGSizeMake(200, 200))
                    
//                    let projectile1 = SKSpriteNode(imageNamed: "FullStacker.png")
                    projectile1.physicsBody = SKPhysicsBody(circleOfRadius: 12.5)
                    projectile1.physicsBody?.affectedByGravity = true
                    projectile1.physicsBody?.usesPreciseCollisionDetection = true
                    projectile1.position = CGPointMake(250, 250)
                    projectile1.physicsBody?.categoryBitMask = jdConsultantCategory
                    projectile1.physicsBody?.contactTestBitMask = computerCategory
                    addChild(projectile1)
                    projectile1.physicsBody?.applyImpulse(CGVectorMake(velocityX / 2, velocityY / 2))
                    budgetNumber = budgetNumber - 500
                    
                    var soundEffect = SKAction.playSoundFileNamed("fireball.wav", waitForCompletion: false)
                    
                    audioPlayer = AVAudioPlayer(contentsOfURL: fireballSound, error: nil)
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                    
                }
                
                
            }
            
     
            
//            if selectThree .containsPoint(location) {
//
//                let projectile2 = SKShapeNode(ellipseOfSize: CGSizeMake(100, 100))
//                projectile2.physicsBody = SKPhysicsBody(circleOfRadius: 50)
//                projectile2.physicsBody?.affectedByGravity = true
//                projectile2.fillColor = UIColor.cyanColor()
//                projectile2.position = launcher.position
//                addChild(projectile2)
//                projectile2.physicsBody?.applyImpulse(CGVectorMake(velocityX * 6, velocityY * 6))
//                budgetNumber = budgetNumber - 5000
//                
//                
//            }
            
//            if reset .containsPoint(location) {
//                
//                velocityX = 0
//                velocityY = 0
//                
//            }
            
            if increaseX .containsPoint(location) {
                
                velocityX = velocityX + 10
                
            }
            if increaseY .containsPoint(location) {
                
                velocityY = velocityY + 10
                
            }
            if decreaseX .containsPoint(location) {
                
                velocityX = velocityX - 10
                
            }
            if decreaseY .containsPoint(location) {
                
                velocityY = velocityY - 10
                
            }
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        xLabel.text = "\(velocityX)"
        yLabel.text = "\(velocityY)"
        
        budgetLabel.text = "\(budgetNumber)"
        
        
        
        //        if touching {
        //
        //            let dt: CGFloat = 1.0/60.0
        //            let distance = CGVector(dx: touchPoint.x-randomObject.position.x, dy: touchPoint.y-randomObject.position.y)
        //            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
        //            randomObject.physicsBody!.velocity=velocity
        //        }
        //\/\/\/\/\/\/\
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
//        let firstNode = contact.bodyA.node as! SKSpriteNode
//        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask
        
        if (bodyA == computerCategory) &&
            (bodyB == jdConsultantCategory)  {
                
                println("Score")
                
//                let contactPoint = contact.contactPoint
//                let contact_x = contactPoint.x
//                let contact_y = contactPoint.y
////                let target_y = secondNode.position.y
////                let margin = secondNode.frame.size.height/2 - 25
//                
//                if (contact_y > (target_y - margin))
//                    && (contact_y < (target_y + margin)) {
//                        //                        let texture = SKTexture(imageNamed: "ArrowHitTexture")
//                        //                        firstNode.texture = texture
//                        let joint =
//                        SKPhysicsJointFixed.jointWithBodyA(contact.bodyA,
//                            bodyB: contact.bodyB,
//                            anchor: CGPointMake(contact_x, contact_y))
//                        self.physicsWorld.addJoint(joint)
//                        println("score")
//                        
//                } else {
                
                
                
        }
    
    }
        
}









