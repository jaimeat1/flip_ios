//
//  SourceViewDelegate.swift
//  Flip
//
//  Created by Jaime on 11/02/2017.
//  Copyright © 2017 MobiOak. All rights reserved.
//

import Foundation

@objc protocol SourceViewDelegate {
    
    func didSelectCamera()
    
    func didSelectFacebook()
    
    func didSelectTwitter()
    
    func didSelectRecords()
}
