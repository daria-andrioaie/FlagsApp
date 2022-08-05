//
//  saveExtensions.swift
//  Flags
//
//  Created by Daria Andrioaie on 04.08.2022.
//

import Foundation
import SwiftUI

extension View {
    func saveAsImage(width: CGFloat, height: CGFloat, _ completion: @escaping (CGImage) -> Void) {
        
        let controller = UIHostingController(rootView: self.frame(width: width, height: height))
        controller.view.bounds = CGRect(x: 0, y: 0, width: width, height: height + 45)

        let image = controller.view.asImage()
        
        let cgImage = image.cgImage!
        let cropRectangle = CGRect(x: 0, y: 150, width: 3000.0, height: 1500.0)
        
        let croppedImage = cgImage.cropping(to: cropRectangle)!

        completion(croppedImage)
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}


extension View {
    func snapshot(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        view?.bounds = CGRect(origin: .zero, size: size)

        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
