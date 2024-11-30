//
//  EmptyStateView.swift
//  FetchTakeHome
//
//  Created by Ryan VanAlstine on 11/29/24.
//

import SwiftUI

// Comment: If there were multiple views in the app that might contain an empty state, I prefer to have a shared view across the
// app and pass in which view it is being used for (hence the EmptyViewType) so it is easier to keep consistent.

public enum EmptyViewType {
    case recipes

    var title: String {
        switch self {
        case .recipes: "No recipes found"
        }
    }

    var systemImageName: String {
        switch self {
        case .recipes: "fork.knife"
        }
    }
}

public struct EmptyStateView: View {
    private let viewType: EmptyViewType

    public init(viewType: EmptyViewType) {
        self.viewType = viewType
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: viewType.systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.black.opacity(0.6))
                .padding(.top, 80)

            Text(viewType.title)
                .font(.system(size: 24, weight: .medium))

            Spacer()
        }
    }
}

#Preview {
    EmptyStateView(viewType: .recipes)
}
