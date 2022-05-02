//
//  MessagesManager.swift
//  DieWithMe
//  ViewModel
//
//  Created by Daniel Spalek on 27/04/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit

public enum currentPage{
    case chat
    case makeName
}


class MessagesManager: ObservableObject{
    var percentageTest: Bool = false
    func updateView() {
        self.objectWillChange.send()
    }
    @Published var currentPage: currentPage = .chat
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    let db = Firestore.firestore()
    @Published var messageMaxChars = 0
    
    init(){
        getMessages()
        getSettings()
    }
    
    func getMessages(){
        db.collection("messages").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else{
                print("Error fetching documents: \(String(describing: error))")
                return
            }

            //the compact map is like a map but will only return the non nill values of the document's array
            self.messages = documents.compactMap { document -> Message? in
                do{
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into message: \(error)")
                    return nil
                }
            }

            //sort the messages by date
            self.messages.sort { $0.timestamp < $1.timestamp }
            
            if let id = self.messages.last?.id{
                self.lastMessageId = id
            }
        }
    }
    
    //MARK: Get server sided settings
    func getSettings(){
        //get message settings
        db.collection("settings").document("messageSettings").getDocument { document, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let document = document{ //if document exists
                let data = document.data()
                self.messageMaxChars = data?["maxCharacters"] as? Int ?? 300 //default value is 300 if nil
            }
        }
    }
    
//    func getMessages(){
//        print("getMessages activated")
//        messages.removeAll()
//        let ref = db.collectionGroup("messages")
//        ref.getDocuments { snapshot, error in
//            guard error == nil else{
//                print(error!.localizedDescription)
//                return
//            }
//            if let snapshot = snapshot{
//                for document in snapshot.documents{
////                    let data = document.data()
////                    let username = data["username"] as? String ?? "nil"
////                    let name = data["name"] as? String ?? "nil"
////                    let password = data["password"] as? String ?? "nil"
////                    let postCount = data["postCount"] as? Int ?? 0
////                    let following = data["following"] as? Int ?? 0
////                    let followers = data["followers"] as? Int ?? 0
////                    let email = data["email"] as? String ?? "nil"
////                    let bio = data["bio"] as? String ?? "nil"
//                    let data = document.data()
//                    let id = data["id"] as? String ?? "nil"
//                    let text = data["text"] as? String ?? "error1"
//                    let received = data["received"] as? Bool ?? false
//                    let timestamp = data["timestamp"] as? Date ?? Date.now
//                    let percent = data["percent"] as? Int ?? 5
//
//                    let message = Message(id: id, text: text, received: received, timestamp: timestamp, percent: percent)
//
//                    self.messages.append(message)
////                    self.messages.sort { $0.timestamp < $1.timestamp }
//                    self.messages.sort { Message, Message2 in
//                        Message.timestamp > Message2.timestamp
//                    }
//                    print("message added")
//                    self.updateView()
//
//                }
//            }
//        }
//    } //end of get messages
    
    func sendMessage(text: String){
        if !text.trimmingCharacters(in: .whitespaces).isEmpty {
            // if string does not contains non-whitespace characters
            do{
                UIDevice.current.isBatteryMonitoringEnabled = true
                let batteryFloat = UIDevice.current.batteryLevel
                var currentPercentage = 100 * batteryFloat
                if currentPercentage == -100{
                    currentPercentage = 3
                }
                
                let generatedID = "\(UUID())"
                let displayName = UserDefaults.standard.string(forKey: "displayName")
    //            let newMessage = Message(id: "\(generatedID)", text: text, received: false, timestamp: Date(), percent: Int(currentBattery))
                try db.collection("messages").document(generatedID).setData(["id": generatedID, "text": text, "received": false, "timestamp": Date(), "percent": Int(currentPercentage), "displayName": displayName ?? "אנונימי"])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
