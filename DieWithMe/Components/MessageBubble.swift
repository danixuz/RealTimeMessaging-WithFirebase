//
//  MessageBubble.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 27/04/2022.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    @State private var showTime = true
    var body: some View {
//        VStack(alignment: message.received ? .leading : .trailing){
//            HStack{
//                Text(message.text)
//                    .padding()
//                    .background(message.received ? .black : Color(.systemGray2))
//                    .foregroundColor(message.received ? .white : .white)
//                    .cornerRadius(25)
//                    .overlay{
//                        RoundedRectangle(cornerRadius: 25)
//                            .stroke(.white)
//                    }
//
//            }
//            .onTapGesture {
//                withAnimation {
//                    showTime.toggle()
//                }
//            }
//
//            if showTime{
//                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
//                    .font(.caption2)
//                    .foregroundColor(.gray)
//                    .padding(message.received ? .leading : .trailing)
//            }
//
//        }
//        .frame(width: .infinity, alignment: message.received ? .leading : .trailing)
//        .padding(message.received ? .leading : .trailing)
        
        VStack(spacing: 5){
            Text(message.displayName)
                .font(.caption2)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
                .padding(.horizontal, 5)
                .foregroundColor(.gray)
                .opacity(0.5)
                
            HStack(){
                if !message.received{
                    Spacer()
                    VStack(spacing: 2){
                        Image(systemName: "battery.25")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 10, height: 10)
                        Text("\(message.percent)%")
                            .font(.caption2)
                    }
                    .foregroundColor(Color(red: 100/255, green: 100/255, blue: 107/255))
                }
                Text(message.text)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.trailing)
                    .flipsForRightToLeftLayoutDirection(true)
                    .padding(15)
                    .background(message.received ? .black : Color(red: 40/255, green: 40/255, blue: 44/255))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .overlay{
                        if message.received{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 45/255, green: 45/255, blue: 50/255))
                        }
                    }
                if message.received{
                    VStack(spacing: 2){
                        Image(systemName: "battery.25")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 10, height: 10)
                        Text("\(message.percent)%")
                            .font(.caption2)
                    }
                    .foregroundColor(Color(red: 100/255, green: 100/255, blue: 107/255))
                    Spacer()
                }
            }
        }
        .padding(5)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "ierg", text: "היי מה קורה", received: true, timestamp: Date.now, percent: 1, displayName: "hello1967"))
        
    }
}
