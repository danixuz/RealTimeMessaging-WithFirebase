//
//  ContentView.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 27/04/2022.
//

import SwiftUI

public let screenSize: CGRect = UIScreen.main.bounds //get the screen size

struct ContentView: View {
    @State var text: String = ""
    @StateObject var viewModel = MessagesManager()
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                ScrollViewReader { proxy in 
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            Text("היום")
                                .foregroundColor(.white)
                            ForEach(viewModel.messages, id: \.id){ message in
                                MessageBubble(message: message)
                            }
                        }
                        .padding([.top, .bottom])
                    }
                    .onChange(of: viewModel.lastMessageId) { id in
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
                ZStack{
                    //MARK: BOTTOM SHADOW FOR TEXTFIELD
                    Rectangle()
                        .frame(height: 100)
//                        .offset()
                        .shadow(color: .black, radius:9, x: 0, y: -20)
                        .padding(. horizontal, -50)
                        .foregroundColor(.black)
                    MessageField().environmentObject(viewModel)
                }
            } //end of vstack
            
            //MARK: Shadow for the status bar
            Rectangle()
                .frame(height: 100)
                .offset(y: -screenSize.height/2 - 90)
                .shadow(color: .black, radius:20, x: 0, y: 75)
                .padding(. horizontal, -50)
                .foregroundColor(.black)
            
        } //end of zstack with background color
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MessagesManager())
        ContentView(viewModel: MessagesManager())
    }
}
