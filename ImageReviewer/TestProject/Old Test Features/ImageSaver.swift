//
//  ImageSaver.swift
//  TestProject
//
//  Created by Денис Мусатов on 03.09.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI
import Photos

func getDocumentDerictory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func saveImage(savedImage: SelectedImage) {
    DispatchQueue.global(qos: .background).async {
        PHCachingImageManager.default().requestImage(for: savedImage.asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: .none) { (image, _) in
            if let pngImage = image?.pngData() {
                let filename = getDocumentDerictory().appendingPathComponent(savedImage.id.uuidString)
                try? pngImage.write(to: filename)
            }
        }
    }
    
}
