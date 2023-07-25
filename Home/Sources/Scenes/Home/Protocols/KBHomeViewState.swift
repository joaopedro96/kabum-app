//
//  KBHomeViewState.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import Foundation

public enum KBHomeViewState {
    case hasData(KBHomeViewEntity)
    case hasNextPageData([KBHomeTableViewCellEntity])
    case hasError(Error)
    case isEmpty
    case isLoading
}
