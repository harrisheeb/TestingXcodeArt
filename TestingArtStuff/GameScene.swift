//
//  GameScene.swift
//  TestingArtStuff
//
//  Created by Harrison Heeb on 1/14/18.
//  Copyright © 2018 Harrison Heeb. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var obstacles = [[SKShapeNode]]()
    var numObstacles = 0
    var obsTexture = SKTexture(imageNamed: "weapon")
    var sizeGrid = 10
    var angleBox = 0.0
    var expanded = true
    
    
    
    
    
    func addObstacle(xPos: Int, yPos: Int){
        obstacles.append([SKShapeNode]())
        obstacles[xPos].append(SKShapeNode(rect: CGRect(x: 0, y: 0, width: 50, height: 50)))
        //obstacles[xPos].append(SKShapeNode(ellipseOf: CGSize(width: 40, height: 80)))

        let yValue = numObstacles*Int(self.frame.height / 4) - Int(self.frame.height / 4) - 50
        obstacles[xPos][yPos].position = CGPoint(x: xPos * 20 - 20*20, y: yPos * 20 - 20*20)
        obstacles[xPos][yPos].fillColor = UIColor(displayP3Red: CGFloat(arc4random_uniform(101)/100), green: CGFloat(arc4random_uniform(101)/100), blue: CGFloat(arc4random_uniform(101)/100), alpha: 1.0)
        obstacles[xPos][yPos].lineWidth = 2.0
        obstacles[xPos][yPos].strokeColor = UIColor(displayP3Red: CGFloat(arc4random_uniform(101)/100), green: CGFloat(arc4random_uniform(101)/100), blue: CGFloat(arc4random_uniform(101)/100), alpha: 1.0)
        //obstacles[xPos][yPos].size.width = 30
        //obstacles[xPos][yPos].size.height = 30
        angleBox = angleBox + 0.1
        obstacles[xPos][yPos].name = "weapon"
        
        self.backgroundColor = UIColor.black
        
        

        
        self.addChild(obstacles[xPos][yPos])
        
        
        //numObstacles = numObstacles + 1
        
        
    }
    
    override func didMove(to view: SKView) {
        
        
        for i in 0...sizeGrid{
            for j in 0...sizeGrid{
                addObstacle(xPos: i, yPos: j)
            }
        }
        angleBox = 0
        
    }
    
    func dropSquare(){
        
            var randX = Int(arc4random_uniform(UInt32(sizeGrid + 1)))
            var randY = Int(arc4random_uniform(UInt32(sizeGrid + 1)))
            while(randY == 10 || randY == 11){
                randY = Int(arc4random_uniform(UInt32(sizeGrid + 1)))
            }
            while(randX == 0 || randX == 1 || randX == 10 || randX == 11 || randX == 19 || randX == 20){
                randX = Int(arc4random_uniform(UInt32(sizeGrid + 1)))
            }
            /*
            while(obstacles[randX][randY].physicsBody?.velocity.dy < 0){
                randX = Int(arc4random_uniform(6))
                randY = Int(arc4random_uniform(6))
            }*/

            obstacles[randX][randY].fillColor = UIColor.blue
        obstacles[randX][randY].run(SKAction.move(to: CGPoint(x: 0, y: self.frame.height/2 * 3/4), duration: 0.5))
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(expanded == false){
            for i in 0...sizeGrid{
                for j in 0...sizeGrid{
                    
                    obstacles[j][i].run(SKAction.move(to: CGPoint(x: cos(angleBox) * 200, y: sin(angleBox) * 200), duration: 4.0))
                    angleBox = angleBox + 0.1
                    //obstacles[j][i].zPosition = CGFloat(angleBox * 10)
                }
            }
        }
        angleBox = 0
        
        if(expanded == true){
            for i in 0...sizeGrid{
                for j in 0...sizeGrid{
                
                    obstacles[j][i].run(SKAction.move(to: CGPoint(x: 0, y: j * 50 + i * 10), duration: 4.0))
                }
            }
        }
  
        if(expanded == true){
            expanded = false
        } else {
            expanded = true
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    var ticked = false
    var secondps = 0
    
    
    func tick(){
        secondps = secondps + 1
        
        
        //dropSquare()
        //dropSquare()

        
        
        
        
        ticked = true
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        let fastTime = Int(currentTime * 200)
        
        
        if(fastTime % 10 < 5 && ticked == false){
            tick()
        }
        if(fastTime % 10 > 5){
            ticked = false
        }
        var cool: CGFloat = 0
        for i in 0...sizeGrid{
            for j in 0...sizeGrid{
                
                
                
                obstacles[j][i].zRotation = CGFloat(currentTime*2)
                /*
                if(j % 2 == 0){
                    cool = CGFloat(sin(Double(currentTime*2))/2.259)
                } else {
                    cool = -CGFloat(sin(Double(currentTime*2))/2.259)
                }
                obstacles[j][i].position.y = obstacles[j][i].position.y + cool
                if(i % 2 == 0){
                    cool = CGFloat(cos(Double(currentTime*2))/2)
                } else {
                    cool = -CGFloat(cos(Double(currentTime*2))/2)
                }
                obstacles[j][i].position.x = obstacles[j][i].position.x + cool
            */
                
                
                
                
                //obstacles[j][i].zRotation = CGFloat(currentTime*2)
                
                
                
                
                
                
                cool = CGFloat((cos(Double(0.03*Double(obstacles[i][j].position.y))))/5)
                let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
                let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
                let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
                
                //obstacles[i][j].lineWidth = cool * 50
                obstacles[i][j].fillColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
                //CGFloat(arc4random_uniform(101)/100)
                //obstacles[j][i].position.y = obstacles[j][i].position.y + cool*2
                
                
            }
        }
        
        
        
        
        
    }
}
