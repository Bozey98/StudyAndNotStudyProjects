//
//  ImagePicker.swift
//  TestProject
//
//  Created by Денис Мусатов on 03.09.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI
import Photos
import BSImagePicker


struct CustomImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImages: [SelectedImage]
    
    func makeUIViewController(context: Context) -> ImagePickerController {
        
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 5
        imagePicker.settings.selection.unselectOnReachingMax = false
        
        
        imagePicker.imagePickerDelegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    
    class Coordinator: NSObject, ImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: CustomImagePicker
        
        init(_ parent: CustomImagePicker) {
            self.parent = parent
        }
        
        func imagePicker(_ imagePicker: ImagePickerController, didSelectAsset asset: PHAsset) {
            print("sel")
        }
        
        func imagePicker(_ imagePicker: ImagePickerController, didDeselectAsset asset: PHAsset) {
            
        }
        
        func imagePicker(_ imagePicker: ImagePickerController, didFinishWithAssets assets: [PHAsset]) {
            self.parent.selectedImages = []
            assets.forEach { asset in
                self.getImage(from: asset)
            }
        }
        
        func imagePicker(_ imagePicker: ImagePickerController, didCancelWithAssets assets: [PHAsset]) {
            print("cancel")
        }
        
        func imagePicker(_ imagePicker: ImagePickerController, didReachSelectionLimit count: Int) {
            
        }
        
        func getImage(from asset: PHAsset) {
            
            let imageRequestOptions = PHImageRequestOptions()
            imageRequestOptions.isSynchronous = true

            PHCachingImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .default, options: imageRequestOptions) { (image, _) in
                    
                    if let successImage = image {
                        let selectedImage = SelectedImage(image: successImage, asset: asset)
                        self.parent.selectedImages.append(selectedImage)
                        
                        saveImage(savedImage: selectedImage)
                    }
            }
        }
    }
}


