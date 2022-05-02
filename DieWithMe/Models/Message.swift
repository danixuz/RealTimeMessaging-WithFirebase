//
//  Message.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 27/04/2022.
//

import Foundation

struct Message: Identifiable, Codable{
    var id: String
    var text: String
    var received: Bool //if the user is the sender of message or getter
    var timestamp: Date
    var percent: Int
    var displayName: String
    
}
