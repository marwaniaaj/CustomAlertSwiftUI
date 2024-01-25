//
//  View-CustomAlert.swift
//  CustomAlert
//
//  Created by Marwa Abou Niaaj on 25/01/2024.
//

import SwiftUI

extension View {
    /// Presents an alert with a message when a given condition is true, using a localized string key for a title.
    /// - Parameters:
    ///   - titleKey: The key for the localized string that describes the title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert. When the user presses or taps one of the alert’s actions, the system sets this value to false and dismisses.
    ///   - data: An optional source of truth for the alert. The system passes the contents to the modifier’s closures. You use this data to populate the fields of an alert that you create that the system displays to the user.
    ///   - actionText: The alert's action's button text.
    ///   - action: The alert’s action given the currently available data.
    ///   - message: A ViewBuilder returning the message for the alert given the currently available data.
    func customAlert<M, T: Hashable>(
        _ titleKey: LocalizedStringKey,
        isPresented: Binding<Bool>,
        presenting data: T?,
        actionText: String,
        action: @escaping (T) -> (),
        @ViewBuilder message: @escaping (T) -> M
    ) -> some View where M: View {
        fullScreenCover(isPresented: isPresented) {
            CustomAlertView(
                titleKey,
                isPresented,
                presenting: data,
                actionText: actionText,
                action: action,
                message: message
            )
            .presentationBackground(.clear)
        }
        .transaction { transaction in
            // disable the default FullScreenCover animation
            transaction.disablesAnimations = true

            // add custom animation for presenting and dismissing the FullScreenCover
            transaction.animation = .linear(duration: 0.1)
        }
    }

    /// Presents an alert with a message when a given condition is true, using a localized string key for a title.
    /// - Parameters:
    ///   - titleKey: The key for the localized string that describes the title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert. When the user presses or taps one of the alert’s actions, the system sets this value to false and dismisses.
    ///   - actionText: Action's button text.
    ///   - action: Returning the alert’s actions.
    ///   - message: A ViewBuilder returning the message for the alert.
    func customAlert<M>(
        _ titleKey: LocalizedStringKey,
        isPresented: Binding<Bool>,
        actionText: String,
        action: @escaping () -> (),
        @ViewBuilder message: @escaping () -> M
    ) -> some View where M: View {
        fullScreenCover(isPresented: isPresented) {
            CustomAlertView(
                titleKey,
                isPresented,
                actionText: actionText,
                action: action,
                message: message
            )
            .presentationBackground(.clear)
        }
        .transaction { transaction in
            // disable the default FullScreenCover animation
            transaction.disablesAnimations = true

            // add custom animation for presenting and dismissing the FullScreenCover
            transaction.animation = .linear(duration: 0.1)
        }
    }
}

