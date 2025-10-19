//
//  CommonProtocols.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - Loadable Protocol
protocol LoadableViewModel {
    var onLoadingStateChanged: ((Bool) -> Void)? { get set }
}
