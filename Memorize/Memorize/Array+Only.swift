//
//  Array+Only.swift
//  Memorize
//
//  Created by Денис Мусатов on 27.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
