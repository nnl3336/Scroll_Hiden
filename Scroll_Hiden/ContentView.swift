//
//  ContentView.swift
//  Scroll_Hiden
//
//  Created by Yuki Sasaki on 2025/02/11.
//

import SwiftUI
import CoreData

struct ContentView : View {
    @State private var isButtonVisible = true
    
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    Color.clear
                        .onChange(of: geometry.frame(in: .global).minY) { minY in
                            // スクロール位置が上に進んでいる場合
                            if minY < 0 {
                                withAnimation {
                                    isButtonVisible = false
                                }
                            } else {
                                withAnimation {
                                    isButtonVisible = true
                                }
                            }
                        }
                }
                .frame(height: 0)  // GeometryReader は目に見えないように高さを 0 に設定
                
                // スクロールコンテンツ
                ForEach(0..<30, id: \.self) { index in
                    Text("Item \(index)")
                        .padding()
                }
                
                // ボタンを表示
                if isButtonVisible {
                    Button("Scroll to Top") {
                        // スクロール位置をトップに戻すアクション
                    }
                    .padding()
                }
            }
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
