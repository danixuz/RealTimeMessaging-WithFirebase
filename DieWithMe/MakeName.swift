//
//  MakeName.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 01/05/2022.
//

import SwiftUI
import Combine //to use Just

struct MakeName: View {
    @State var name: String = ""
    @StateObject var viewModel: MessagesManager
    @State var nameRegistered = false
    var body: some View {
        if nameRegistered{
            ContentView(viewModel: viewModel)
        }else{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    //MARK: Headline
                    Text("בחר/י שם משתמש")
                        .foregroundColor(.white)
                        .padding()
                        .font(.title2)
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 180)
                            .foregroundColor(Color(red: 50/255, green: 50/255, blue: 55/255))
                            .padding(.horizontal, 10)
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 12.5)
                                    .frame(height: 40)
                                    .padding(.horizontal, 30)
                                    .foregroundColor(.gray)
                                TextField("", text: $name)
                                    .multilineTextAlignment(.trailing)
                                    .flipsForRightToLeftLayoutDirection(true)
                                    .onReceive(Just(name)) { _ in
                                        limitText(viewModel.messageMaxChars)
                                    }
                                    .onSubmit {
                                        print("submitted")
                                    }
                                    .padding(.horizontal, 50)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            Button {
                                //MARK: Set name
                                UserDefaults.standard.set(name, forKey: "displayName")
                                nameRegistered = true
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 12.5)
                                    Text("המשך")
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(width: 150, height: 50)

                        }
                    } //end of zstack
                    
                    SwiftUIBannerAd(adPosition: .bottom, adUnitId: adUnitID)
                        .frame(height: 60)
                        .padding(.top)
                }
            }
        }
    }
    func limitText(_ max: Int){
        if name.count > max {
            name = String(name.prefix(max))
        }
    }
}

struct MakeName_Previews: PreviewProvider {
    static var previews: some View {
        MakeName(viewModel: MessagesManager())
    }
}
