//
//  ContentView.swift
//  BottomSheetDemo
//
//  Created by Sharvari on 2023-11-14.
//

import SwiftUI


struct ContentView: View {
    @State var minHeight: CGFloat = Utils.screenHeight * 0.3
    var body: some View {
        NavigationView{
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                Text("Bottom sheet like Apple Map")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
            }
            .navigationTitle("Bottom Sheet Demo")
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(width: Utils.screenWidth, height: Utils.screenHeight, alignment: .topLeading)
        .safeAreaInset(edge: .leading, alignment: .center){
            BottomSheetView(isOpen: .constant(false), maxHeight: Utils.screenHeight) {
                List {
                    ForEach(1..<20){ i in
                        HStack{
                            Image(systemName: "globe")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                            Text("Item \(i)")
                        }
                        .padding()
                    }
                }
                .listStyle(.plain)
                .ignoresSafeArea(.container, edges: .bottom)
            }
        }
    }
}

#Preview {
    ContentView()
}
