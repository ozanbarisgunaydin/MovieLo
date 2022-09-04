# MovieLo

Fundamentally, MovieLo app is a movie searching app which includes the detail and imdb pages of movie or serie. The app uses the Omdb API for data providing.

App writed by the VIPER pattern for the advenced maintability and depency inversion principle. The networking layer prepared cleanly with Alamofire. BaseViewController structer embeded for the clean building of scenes.

Image download proccess managed with SDWebImage library. In addition, for the event logging, remote config and push notofication Firebase libraries used. All of the libraries added with Swift Package Manager (SPM).

App has 3 scenes: Splash, List and Detail.

The Splash screen check the internet connection. If there is connectivity losage alert showed for the closing app. In addition, the Remote Config property of Firebase provide a text for the title of the app. In addition, the push notification settings added and prepared for usage. Needed certification process can be added for trying.

The List scene contains a search bar and table for result of the searchs. According to the data empty view or the filled view showed to user. On the calls duration, a custom loading spinner showed with blur view. As desired, the initial situation of scene is empty. The search proccess managed with workItem which is used DispatchGroups for the preventing unnecessary calls. The search actions sets after 0.5 second for the better experience.

The Detail scene provides more information for the clicked (selected) movie or serie. Also, user can visit the imdb page of the movie. With the help of the Firebase Analytics library the event logging trigerred with the detail informations of viewed movie or serie. 

![alt-text](https://github.com/ozanbarisgunaydin/MovieLo/blob/main/Preview/PreviewGIF.gif) 

The auto layout principles applied for the better experience on the different phone sizes:

![alt-text](https://github.com/ozanbarisgunaydin/MovieLo/blob/main/Preview/DetailScene.png) 
![alt-text](https://github.com/ozanbarisgunaydin/MovieLo/blob/main/Preview/ListScene.png) 

