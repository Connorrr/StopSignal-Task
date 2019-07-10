//
//  Block.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation
import UIKit

class Block {
    
    let blockType : BlockType
    let numberOfTrials : Int?
    var trials : [TrialInfo]? = []
    var isGoTrial : [Bool] = []
    var trialImageFilenames : [String] = []
    var stimulusType : [String] = []        // H, N, A
    
    
    
    /// Builds the isGoTrialList in this class based on whether its a practice block or not
    /// Practice block will be 10 trials and not will be 60
    /// - Parameter isPractice: set true if this is a practice block
    init(blockType: BlockType){
        self.blockType = blockType
        
        if (blockType == .practice){
            numberOfTrials = 8
        }else{
            numberOfTrials = 48
        }
        
        buildStopGoList()
        buildMainBlockImageFilenames()
    }
    
    private func buildStopGoList(){
        var typeBlock : [Int] = []
        var loops : Int
        
        loops = numberOfTrials! / 8
        for _ in 1 ... loops {
            typeBlock.append(1)
            typeBlock.append(2)
        }
        
        typeBlock.shuffle()
        
        for i in typeBlock {
            if (i == 1){
                isGoTrial.append(true)
                isGoTrial.append(true)
                isGoTrial.append(false)
            }else{
                isGoTrial.append(true)
                isGoTrial.append(true)
                isGoTrial.append(true)
                isGoTrial.append(true)
                isGoTrial.append(false)
            }
        }
        
        var goCount = 0
        var stopCount = 0
        for i in isGoTrial {
            if (i){
                goCount += 1
            }else{
                stopCount += 1
            }
        }
        print("Num Go: \(goCount)")
        print("Num Stop: \(stopCount)")
                
    }
    
    func buildMainBlockImageFilenames(){
        var suffix1 = ""
        var suffix2 = ""
        var numStopM = 6
        var numStopF = 6
        var numGoM = 18
        var numGoF = 18
        
        
        switch blockType {
        case .practice:
            suffix1 = "N"
            suffix2 = "H"
            if (StaticVars.isAbstract){
                suffix1 = "X"
                suffix2 = "O"
            }
            numStopM = 1
            numStopF = 1
            numGoM = 3
            numGoF = 3
        case .neutralangry:
            suffix1 = "N"
            suffix2 = "A"
        case .happyneutral:
            suffix1 = "H"
            suffix2 = "N"
        case .happyangry:
            suffix1 = "H"
            suffix2 = "A"
        case .abstract:
            suffix1 = "X"
            suffix2 = "O"
        }
        
        var goList : [String] = []
        var noGoList : [String] = []
        var imageNums : [Int] = [1,2,3,4,5,6]
        
        //  Set nogo male names
        imageNums.shuffle()
        var fName = ""
        for i in 1 ... numStopM {
            if ( i <= numStopM/2){
                if (StaticVars.isAbstract){
                    noGoList.append(suffix2)
                }else{
                    noGoList.append(suffix2 + "M" + String(imageNums[i%6]))
                }
            }else{
                if (StaticVars.isAbstract){
                    noGoList.append(suffix1)
                }else{
                    noGoList.append(suffix1 + "M" + String(imageNums[i%6]))
                }
            }
        }
        
        //  set nogo female names
        imageNums.shuffle()
        for i in 1 ... numStopF {
            if ( i <= numStopF/2){
                if (StaticVars.isAbstract){
                    noGoList.append(suffix2)
                }else{
                    noGoList.append(suffix2 + "F" + String(imageNums[i%6]))
                }
            }else{
                if (StaticVars.isAbstract){
                    noGoList.append(suffix1)
                }else{
                    noGoList.append(suffix1 + "F" + String(imageNums[i%6]))
                }
            }
        }
        
        //  Set go male names
        imageNums.shuffle()
        for i in 1 ... numGoM {
            if ( i <= numGoM/2){
                if (StaticVars.isAbstract){
                    goList.append(suffix2)
                }else{
                    goList.append(suffix2 + "M" + String(imageNums[i%6]))
                }
            }else{
                if (StaticVars.isAbstract){
                    goList.append(suffix1)
                }else{
                    goList.append(suffix1 + "M" + String(imageNums[i%6]))
                }
            }
        }
        
        //  set go female names
        imageNums.shuffle()
        for i in 1 ... numGoF {
            if ( i <= numGoF/2){
                if (StaticVars.isAbstract){
                    goList.append(suffix2)
                }else{
                    goList.append(suffix2 + "F" + String(imageNums[i%6]))
                }
            }else{
                if (StaticVars.isAbstract){
                    goList.append(suffix1)
                }else{
                    goList.append(suffix1 + "F" + String(imageNums[i%6]))
                }
            }
        }
        
        goList.shuffle()
        noGoList.shuffle()
        
        for i in 0 ..< numberOfTrials! {
            if ( isGoTrial[i] ){
                trialImageFilenames.append(goList.popLast()!)
                
                //print("\(trialImageFilenames[i])    \(isGoTrial[i])")
            }else{
                trialImageFilenames.append(noGoList.popLast()!)
                //print("\(trialImageFilenames[i])    \(isGoTrial[i])")
            }
            stimulusType.append(String(trialImageFilenames[i].prefix(1)))
        }
        
    }
    
}
