//
//  PlayerView.swift
//  SwiftUISample04
//
//  Created by ParkJonghyun on 2020/09/23.
//

import SwiftUI

struct PlayerView: View {
    @State var dragValue = CGSize.zero
    
    @Binding var isExpand : Bool
    @Binding var activeId : UUID
    var player:PlayerData
    
    var body: some View {
        ZStack(alignment: .top, content: {
            VStack {
                player.images[0]
                    .resizable()
                    .shadow(radius: 5)
                    .frame(alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onTapGesture {
                        self.isExpand = true
                        self.activeId = self.player.id
                    }
                Text("\(player.uniform). \(player.name)").font(.title2).fontWeight(.bold)
                
            }.padding()
            .opacity(self.activeId == self.player.id ? 0 : 1)
            .cornerRadius(20)
            
            // over lay content
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    player.images[0]
                        .resizable()
                        .frame(maxHeight: Screen.height * 0.45)
                        .padding(.top, 40)
                        .padding(20)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("\(player.uniform). \(player.name)").font(.title2).fontWeight(.bold)
                        Text("생년월일 : \(player.birth.toString(format: "YYYY년 MM월 dd일"))(\(player.age))").font(.title3).fontWeight(.medium)
                        Text("포지션 : \(player.position)").font(.title3).fontWeight(.medium)
                        Spacer()
                        Text("\(player.style)")
                    }.padding(.bottom)
                }.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.isExpand = false
                            self.activeId = UUID()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.white.opacity(0.2))
                        }.frame(width: 30, height: 30)
                        .background(
                            Circle().foregroundColor(Color.gray.opacity(0.6))
                        )
                    }.padding(.top, 30)
                    Spacer()
                }.padding()
            }.opacity(self.activeId == self.player.id ? 1 : 0)
            .gesture(
                self.activeId == player.id ?
                    DragGesture().onChanged({ value in
                        guard value.translation.height < 200 else { return }
                        if value.translation.height > 400 {
                            self.isExpand = false
                            self.activeId = UUID()
                            self.dragValue = .zero
                        } else {
                            self.dragValue = value.translation
                        }
                    }).onEnded({ value in
                        if value.translation.height > 300 {
                            self.isExpand = false
                            self.activeId = UUID()
                        }
                        self.dragValue = .zero
                    }) : nil
            ).scaleEffect(1 - (self.dragValue.height / 1000))
        })
        .frame(height: self.activeId == self.player.id ? Screen.height : Screen.height * 0.45)
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.6))
        .background(Color(UIColor.systemGray3))
        .cornerRadius(self.activeId == self.player.id ? 0 : 20)
        .edgesIgnoringSafeArea(.all)
    }
    
}
