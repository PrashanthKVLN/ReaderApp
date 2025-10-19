//
//  UIViewController + Extension.swift
//  ReaderApp
//
//  Created by Prashanth on 20/10/25.
//

import UIKit

extension UIViewController {
    static func loadFromNib<T: UIViewController>() -> T {
        let nibName = String(describing: T.self)
        return T(nibName: nibName, bundle: Bundle.main)
    }
}
