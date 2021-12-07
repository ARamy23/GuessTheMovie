//
// This is free and unencumbered software released into the public domain.
// 
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
//
// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
// 
// THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
// 
// For more information, please refer to <https://unlicense.org>
//
//
//  ParametersToMultipartFormDataAdapter.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 13/11/2021.
//

import Alamofire
import UIKit.UIImage

public struct ParametersToMultipartFormDataAdapter: AdapterProtocol {
    typealias Input = HTTPParameters
    typealias Output = MultipartFormData

    func adapt(_ input: Input) -> Output {
        guard let file = input["file"] as? MediaUploadRequest,
              let type = input["type"] as? String else { fatalError() }

        let multipart = MultipartFormData()
        multipart
            .append(
                file.data,
                withName: "file",
                fileName: file.fileName,
                mimeType: file.mimeType
            )

        multipart
            .append(
                type.data(using: .utf8) ?? Data(),
                withName: "type"
            )

        return multipart
    }
}

public struct MediaUploadRequest: Encodable {
    let fileName: String
    let data: Data
    let mimeType: String
    let uploadType: String

    init(mediaType: Media) {
        mimeType = mediaType.mimeType
        fileName = mediaType.fileName
        uploadType = mediaType.uploadType
        if let data = mediaType.data {
            self.data = data
        } else {
            LoggersManager.error(message: "Uploading Request had a nil Data".tagWith(.internal))
            self.data = Data()
        }
    }
}

public enum Media {
    case singleImage(UIImage)
    case singleVideo(data: Data, thumbnail: UIImage)
    
    var type: String {
        switch self {
        case .singleImage:
            return "post-image"
        case .singleVideo:
            return "post-video"
        }
    }
    
    var thumbnailImage: UIImage {
        switch self {
        case .singleImage(let image):
            return image
        case .singleVideo(_, let thumbnail):
            return thumbnail
        }
    }
    
    var image: UIImage? {
        switch self {
        case let .singleImage(image):
            return image
        default:
            return nil
        }
    }
    
    var data: Data? {
        switch self {
        case let .singleVideo(data, _):
            return data
        case let .singleImage(image):
            return image.pngData()
        }
    }
    
    var uploadType: String {
        switch self {
        case .singleImage:
            return "post-image"
        case .singleVideo:
            return "post-video"
        }
    }
    
    var mimeType: String {
        switch self {
        case .singleImage:
            return "image/png"
        case .singleVideo:
            return "video/mp4"
        }
    }
    
    var fileName: String {
        switch self {
        case .singleImage:
            return "\(UUID().uuidString).png"
        case .singleVideo:
            return "\(UUID().uuidString).mp4"
        }
    }
}
