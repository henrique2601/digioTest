import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    private var imageCache: NSCache<NSString, UIImage> = NSCache()

    func downloadImage(from url: URL, indexPath: IndexPath? = nil, completion: @escaping (UIImage?, IndexPath?) -> Void) {
        // Check if the image is already in the cache
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, indexPath)
            return
        }

        // If not, download the image asynchronously
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                // Store the image in the cache
                self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    // Return the image through the completion handler
                    completion(image, indexPath)
                }
            } else {
                DispatchQueue.main.async {
                    // Return nil if image download fails
                    completion(nil, indexPath)
                }
            }
        }
    }
}
