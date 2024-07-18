//
//  KeyboardAwareModifier.swift
//  Malltiverse
//
//  Created by Godwin IE on 18/07/2024.
//

import SwiftUI
import Combine

struct KeyboardAwareModifier: ViewModifier {
    @Binding var isKeyboardVisible: Bool
    @State private var cancellable: AnyCancellable?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                self.cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                    .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
                    .sink { notification in
                        if notification.name == UIResponder.keyboardWillHideNotification {
                            isKeyboardVisible = false
                        } else {
                            isKeyboardVisible = true
                        }
                    }
            }
            .onDisappear {
                self.cancellable?.cancel()
            }
    }
}

extension View {
    func keyboardAware(isKeyboardVisible: Binding<Bool>) -> some View {
        self.modifier(KeyboardAwareModifier(isKeyboardVisible: isKeyboardVisible))
    }
}
