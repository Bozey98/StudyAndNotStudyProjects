//
//  SelectedImage.swift
//  TestProject
//
//  Created by Денис Мусатов on 03.09.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI
import Photos

struct SelectedImage: Identifiable, Hashable {
    let id = UUID()
    let image: UIImage
    let asset: PHAsset
}


