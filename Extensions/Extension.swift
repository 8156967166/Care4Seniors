//
//  Extension.swift
//  Care4Senior
//
//  Created by Aneesha on 15/02/24.
//

import Foundation
import UIKit
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()
    var isOnline: Bool = false
    
    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isOnline = path.status == .satisfied
        }
        
        monitor.start(queue: queue)
    }
}

extension UIImage {
    // Function to create an animated image from GIF data
    static func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        var images = [UIImage]()
        
        let count = CGImageSourceGetCount(source)
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }
        
        // Create an animated image from the array of images
        return UIImage.animatedImage(with: images, duration: TimeInterval(count) * 0.1)
    }
}
