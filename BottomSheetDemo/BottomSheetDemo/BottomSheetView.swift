//
//  BottomSheetView.swift
//  BottomSheetDemo
//
//  Created by Sharvari on 2023-11-15.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    @GestureState private var translation: CGFloat = 0
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    @State var minHeight: CGFloat = Utils.screenHeight * 0.3
    @Binding var isOpen: Bool
    let maxHeight: CGFloat
    let content: Content

    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }

    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 25.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .frame(width: screenWidth * 0.15, height: 10)
                    .padding(.top, 16)
                self.content
                    .padding(.bottom, 32)
                Spacer()
            }
            .frame(minWidth: screenWidth, minHeight: minHeight, maxHeight: .infinity)
            .frame(alignment: .bottom)
            .background(.gray.opacity(0.1))
            .offset(y: offset + self.translation)
            .animation(.interactiveSpring, value: translation)
            .gesture(
                DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                    .updating(self.$translation) { value, state, _ in
                        if minHeight == maxHeight { return }
                        state = value.translation.height
                    }
                    .onEnded { value in
                        if value.translation.width < 150 && value.translation.width > -150{
                            withAnimation(.interactiveSpring){
                                if value.translation.height < 0 {
                                    //Swipe Up
                                    if minHeight < screenHeight * 0.3 {
                                        minHeight = screenHeight * 0.3
                                    }else if minHeight < screenHeight * 0.7 {
                                        minHeight = screenHeight * 0.7
                                    }else{
                                        minHeight = screenHeight
                                    }
                                }else if value.translation.height > 0 {
                                    //Swipe Down
                                    if minHeight >= screenHeight{
                                        minHeight = screenHeight * 0.7
                                    }else{
                                        minHeight = screenHeight * 0.3
                                    }
                                }
                            }
                        }
                    }
            )
        }
    }

    private var offset: CGFloat {
       isOpen ? maxHeight : maxHeight - minHeight
   }
}


#Preview {
    BottomSheetView(isOpen: .constant(true), maxHeight: 300, content: {
        EmptyView()
    })
}
