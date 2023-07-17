//
//  AppTabBar.swift
//  rickandmorty
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import SwiftUI

struct AppTabBar<Content: View>: View {
    
    @Binding var selectedTab: Tab
    @Namespace var namespace
    @ViewBuilder let content: (Tab) -> Content
    
    var body: some View {
        ZStack {
            contentView
            
            VStack {
                Spacer()
                bottomTabBar
            }
            
        }
    }
    
    var contentView: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            TabView(selection: $selectedTab) {
                ForEach(Tab.allCases) { tab in
                    content(tab)
                        .tag(tab)
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.top)
                
                
        }
    }
    
    var bottomTabBar: some View {
        HStack {
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
            }
        }
        .padding()
        .background(
            RoundedCorners(color: .backgroundColor, tl: 22, tr: 22.0)
        )
        .frame(height: 70)
    }
    
    private struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
        var namespace: Namespace.ID
        @State private var selectedOffset: CGFloat = 0
        @State private var rotationAngle: CGFloat = 0
        
        var body: some View {
            Button {
                withAnimation(.easeInOut) {
                    selectedTab = tab
                }
                
                selectedOffset = -60
                if tab < selectedTab {
                    rotationAngle += 360
                } else {
                    rotationAngle -= 360
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    selectedOffset = 0
                    if tab < selectedTab {
                        rotationAngle += 720
                    } else {
                        rotationAngle -= 720
                    }
                }
            } label: {
                ZStack {
                    if isSelected {
                        Capsule()
                            .fill(tab.color.opacity(0.2))
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                    }
                    HStack(spacing: 10) {
                        Image(tab.icon)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(isSelected ? tab.color : .black.opacity(0.6))
                            .rotationEffect(.degrees(rotationAngle))
                            .scaleEffect(isSelected ? 1 : 0.9)
                            .animation(.easeInOut, value: rotationAngle)
                            .opacity(isSelected ? 1 : 0.7)
                            .padding(.leading, isSelected ? 20 : 0)
                            .padding(.horizontal, selectedTab != tab ? 10 : 0)
                            .offset(y: selectedOffset)
                            .animation(.default, value: selectedOffset)
                        
                        if isSelected {
                            Text(tab.title)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(tab.color)
                                .padding(.trailing, 20)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .buttonStyle(.plain)
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}
struct AppTabBar_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBar(selectedTab: .constant(Tab.characters)) { index in
            switch index {
            case .characters:
                CharactersView()
            case .episodes:
                CharactersView()
            case .locations:
                CharactersView()
            }
        }
    }
}
