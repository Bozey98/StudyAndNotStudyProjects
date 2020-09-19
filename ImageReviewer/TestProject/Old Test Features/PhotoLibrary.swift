//
//  PhotoLibrary.swift
//  TestProject
//
//  Created by Денис Мусатов on 30.08.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import Photos
import SwiftUI


class ImagePicker: ObservableObject {
    
    @Published var photos: [ImageCard] = []
    
    func getImages() {
        if photos.isEmpty {
            let opt = PHFetchOptions()
                opt.includeHiddenAssets = false
                let req = PHAsset.fetchAssets(with: .image, options: .none)
                
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
                    
                    let options = PHImageRequestOptions()
                    options.isSynchronous = true
            
                    for i in stride(from: req.count - 1, through: 0, by: -1) {
                        
                        PHCachingImageManager.default().requestImage(for: req[i], targetSize: CGSize(width: 250, height: 250), contentMode: .default, options: options) { (image, _) in
                            if let getImage = image {
                                let tempImage = ImageCard(image: getImage, asset: req[i], isSelected: false)
                                DispatchQueue.main.async {
                                    print(i)
                                    self.photos.append(tempImage)
                                }
                                
                                
                            }
                        }
                    }
                }
        }
        
    }
}


class ImagePickerConfigurations: ObservableObject {
    
    var image: UIImage = UIImage()
    
    var assets: PHFetchResult<PHAsset>
    
    var imageRequestOptions: PHImageRequestOptions
    
    var imageManager: PHImageManager
    
    init() {
        let fetchOption = PHFetchOptions()
        fetchOption.includeHiddenAssets = false
        assets = PHAsset.fetchAssets(with: .image, options: fetchOption)
        
        imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.isSynchronous = true
        
        imageManager = PHCachingImageManager.default()
        
//        for i in 0..<assets.count {
//            getImage(id: i)
//        }
    }
    
    func getImage(id: Int) -> UIImage{
        var tempImage = UIImage()
        //DispatchQueue.global(qos: .background).async {
            self.imageManager.requestImage(for: self.assets[id], targetSize: CGSize(width: 10, height: 10), contentMode: .default, options: self.imageRequestOptions) { (image, _) in
                if let successImage = image {
                    //DispatchQueue.main.async {
                        print(id)
                        tempImage = successImage
                    //}
                }
            }
        //}
        print("return")
        return tempImage
        
        
        
        
    }
    
    
}


struct ImageCard: Hashable {
    
//    var id: Int
//    static var lastId = 0
    var image: UIImage
    var asset: PHAsset
    var isSelected: Bool
    
//    init(image: UIImage, asset: PHAsset, isSelected: Bool) {
//        self.id = ImageCard.lastId
//        self.image = image
//        self.asset = asset
//        self.isSelected = isSelected
//
//        ImageCard.lastId += 1
//    }
}
