//
//  ContentView.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 27/04/2022.
//

import SwiftUI

public let screenSize: CGRect = UIScreen.main.bounds //get the screen size
public let adUnitID: String = "ca-app-pub-3940256099942544/2934735716" //testing
//public let adUnitID: String = "ca-app-pub-5071907213978032/1962697599"

struct ContentView: View {
    @State var text: String = ""
    @StateObject var viewModel: MessagesManager
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
                //MARK: AD BANNER:
//                BannerAd(unitID: adUnitID)
                SwiftUIBannerAd(adPosition: .bottom, adUnitId: adUnitID)
                    .frame(width: UIScreen.main.bounds.width, height: 60)
//                GeometryReader{ _ in
//                    SwiftUIBannerAd(adPosition: .bottom, adUnitId: adUnitID)
//                }
//                .ignoresSafeArea(.keyboard)
                
                
            } //end of vstack
            
            //MARK: Shadow for the status bar
            GeometryReader{ _ in
                Rectangle()
                    .frame(height: 100)
                    .offset(y: -screenSize.height/5 - 10)
                    .shadow(color: .black, radius:20, x: 0, y: 75)
                    .padding(. horizontal, -50)
                    .foregroundColor(.black)
            }
            .ignoresSafeArea(.keyboard)
                
            
        } //end of zstack with background color
        
        //MARK: Blurry menu bar
//        .safeAreaInset(edge: .top) {
//            HStack{
//                Button {
//                    //private messages
//                } label: {
//                    Image(systemName: "message")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 21, height: 21)
//                }
//                Spacer()
//                Text("צ׳אט ראשי")
//                    .font(.title2)
//                    .padding(.top, 2)
//                Spacer()
//                Button {
//                    // settings
//                } label: {
//                    Image(systemName: "text.justify")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 20, height: 20)
//                }
//
//
//
//
//            }
//            .padding(.horizontal, 25)
//            .padding(.bottom, 15)
//            .background(.ultraThinMaterial)
//            .preferredColorScheme(.dark) //force dark mode on view
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MessagesManager())
        ContentView(viewModel: MessagesManager()).preferredColorScheme(.dark)
    }
}
