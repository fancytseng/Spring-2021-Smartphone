# Get data from Rest API's

1. Create an App and add Pod files to it. you should use Alamofire, SwiftJSON and optionally SwiftSpinner

2. Remove the Default View controller and add a Table view controller on the storyboard

3. Remove the View Controller class and add a new TableViewController class, Assign this class to the View controller in step 2. 

4 Create an account at https://newsapi.org/ (Links to an external site.) and get API Key

5. When application starts up make a REST API call at http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=API_KEY with your api key. 

6. Once you get the data display the title of the news on the table view controller. 
