//
//  ContentView.swift
//  SwiftUISample04
//
//  Created by ParkJonghyun on 2020/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var items:[PlayerData] = playerDataList
    @State var isExpand = false
    @State var activeId = UUID()
    
    var body: some View {
        ZStack {
            Color(self.isExpand ? UIColor.systemGray2 : .white).edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    Text("Liverpool Players.")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer(minLength: 20)
                }
                VStack(spacing: 30) {
                    ForEach(items) { item in
                        GeometryReader { reader in
                            PlayerView(isExpand: $isExpand, activeId: self.$activeId, player: item)
                                .offset(y: self.activeId == item.id ? -reader.frame(in: .global).minY : 0)
                                .opacity(self.activeId != item.id && self.isExpand ? 0 : 1)
                        }
                        .frame(height: Screen.height * 0.45)
                        .frame(maxWidth: self.isExpand ? Screen.width : Screen.width * 0.9)
                    }
                }
            })
        }
    }
}
