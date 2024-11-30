//
//  ErrorStateView.swift
//  FetchTakeHome
//
//  Created by Ryan VanAlstine on 11/29/24.
//

import SwiftUI

// Comment: If there were multiple views in the app that might contain an error state, we could share this one.
// This could also be combined with the Empty State View to have one single view that handles error and
// empty results.

public enum ErrorViewType {
    case recipes

    var title: String {
        switch self {
        case .recipes: "Oops....we ran into an error"
        }
    }

    var systemImageName: String {
        switch self {
        case .recipes: "exclamationmark.octagon"
        }
    }
}

public struct ErrorStateView: View {
    private let viewType: ErrorViewType

    public init(viewType: ErrorViewType) {
        self.viewType = viewType
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: viewType.systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 80)

            Text(viewType.title)
                .font(.system(size: 24, weight: .semibold))

            Spacer()
        }
        .foregroundStyle(.red.opacity(0.8))
    }
}

#Preview {
    ErrorStateView(viewType: .recipes)
}
