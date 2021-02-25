import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getNews(_ country : String, _ category : String){
        let url = getURL(country, category)
        print(url)
    }
    
    func getURL(_ country : String, _ category : String) -> String{
        //return apiURL + "country=" + country + "&category=" + category + "&apiKey=" + apiKey
        return apiURL + apiKey
        
    }


}

