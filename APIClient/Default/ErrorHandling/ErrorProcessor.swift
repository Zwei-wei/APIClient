import Foundation

public protocol ErrorProcessing {
    
    func processError(using response: APIClient.HTTPResponse) -> Error?
    
}

public struct NetworkErrorProcessor: ErrorProcessing {
    
    private let deserializer = JSONDeserializer()
    
    public init() {
    }
    
    public func processError(using response: APIClient.HTTPResponse) -> Error? {
        if let dictionary = (try? deserializer.deserialize(response.0, data: response.1)) as? [String: AnyObject] {
            return NetworkError(statusCode: response.0.statusCode, responseDictionary: dictionary)
        }
        
        return nil
    }
    
}
