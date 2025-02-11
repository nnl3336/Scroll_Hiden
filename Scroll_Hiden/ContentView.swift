//
//  ContentView.swift
//  Scroll_Hiden
//
//  Created by Yuki Sasaki on 2025/02/11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isButtonVisible = true
    @State private var lastOffset: CGFloat = 0
    @State private var isScrolling = false
    @State private var scrollTimer: Timer?

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                lastOffset = geometry.frame(in: .global).minY
                            }
                            .onChange(of: geometry.frame(in: .global).minY) { newOffset in
                                detectScrollDirection(newOffset: newOffset)
                            }
                    }
                    .frame(height: 0)
                    
                    ForEach(0..<50, id: \.self) { index in
                        Text("Item \(index)")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                    }
                }
            }
            
            if isButtonVisible {
                Button(action: {
                    print("Plus Button Tapped")
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.blue).shadow(radius: 5))
                }
                .padding(20)
            }
        }
    }
    
    /// スクロール方向を検知し、一定時間停止したらボタンを表示する
    private func detectScrollDirection(newOffset: CGFloat) {
        if newOffset < lastOffset {
            // 上にスクロール → 非表示
            withAnimation {
                isButtonVisible = false
            }
            isScrolling = true
        } else if newOffset > lastOffset {
            // 下にスクロール → 表示
            withAnimation {
                isButtonVisible = true
            }
            isScrolling = true
        }
        
        lastOffset = newOffset
        
        // 既存のタイマーをリセット
        scrollTimer?.invalidate()
        
        // スクロール停止を検知するためのタイマーを開始
        scrollTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            withAnimation {
                isButtonVisible = true
            }
            isScrolling = false
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
