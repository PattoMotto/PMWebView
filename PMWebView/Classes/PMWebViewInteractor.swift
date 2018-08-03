//Pat

class PMWebViewInteractor: PMWebViewInteractorInput {

    weak var output: PMWebViewInteractorOutput?
    var urlSession: URLSession = URLSession.shared
    var timeout = 1.0

    func fetchData(url: URL) {
        var request = URLRequest(url: url)
        request.timeoutInterval = timeout
        urlSession.dataTask(with: request) {  [weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            guard error == nil else {
                strongSelf.output?.loadFailure()
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                case let statusCode = httpResponse.statusCode else {
                    strongSelf.output?.loadFailure()
                    return
            }
            if let data = data,
                statusCode == 200 {
                strongSelf.output?.loadSuccess(data: data)
            } else {
                strongSelf.output?.loadFailure()
            }
            }.resume()
    }
}
