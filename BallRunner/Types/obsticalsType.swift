//
//  obsticalsType.swift
//  BallRunner
//
//  Created by Navleen Singh on 2017-11-09.
//  Copyright © 2017 Navleen Singh. All rights reserved.
//

import Foundation
import UIKit

enum obsticalsType{
    //obstical_...
    case LeftSpace
    case CenterSpace
    case RightSpace
    
    static var count: UInt32 {return 3}
}
let obsticalArray: [obsticalsType] = [
    obsticalsType.LeftSpace,
    obsticalsType.CenterSpace,
    obsticalsType.RightSpace
]

