//
//  ViewModelProtocol.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 18/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public protocol ViewModelProtocol {
    associatedtype viewModelType
    var viewModel: viewModelType? { get set }
}
