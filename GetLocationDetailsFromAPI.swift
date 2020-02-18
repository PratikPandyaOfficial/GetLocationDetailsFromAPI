import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getIpLocation(completion: { (data, err) in
            print(data)
            print(err)
        })
        
    }
    
    func getIpLocation(completion: @escaping(NSDictionary?, Error?) -> Void)
    {
        let url     = URL(string: "http://ip-api.com/json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request as URLRequest, completionHandler:
        { (data, response, error) in
            DispatchQueue.main.async
            {
                if let content = data
                {
                    do
                    {
                        if let object = try JSONSerialization.jsonObject(with: content, options: .allowFragments) as? NSDictionary
                        {
                            completion(object, error)
                        }
                        else
                        {
                            // TODO: Create custom error.
                            completion(nil, nil)
                        }
                    }
                    catch
                    {
                        // TODO: Create custom error.
                        completion(nil, nil)
                    }
                }
                else
                {
                    completion(nil, error)
                }
            }
        }).resume()
    }

}
