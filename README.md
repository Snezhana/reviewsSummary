

# Reviews Summary App by Snezhana Stojanova

## Description of the solution

 I was trying to create a solution which is easily extendable and different components can be easily replaced. It is similar to VIPER (clean architecture).

The main components are:
* Configurator
* View
* Presenter
* Data Source
* Data Manager
* Data Fetcher
* Model

All of the components have different responsibility and knowledge and are defined through protocols.

The initial conrtoller of the app is ReviewsNavigationController, which has a role as 
Configurator. It creates the connection between the implementation of the protocols of all other components and presents the View as its rootViewController (defined in Storyboard). Similar as some approaches of VIPER.

The View is presented with ViewController. A lot of responsibility of the ViewController according to the traditional MVC architecture were transferred to the presenter and dataSource.

The Presenter is responsible for handing the requests from the View and sends back request to the view when data are prepared. It is the connection of the view with the data.

The DataSource is the owner of the data and it serves the data requested by the presenter. It loads its data using DataManager.

The DataManager is responsible of getting data in JSON format and mapping them in a class which confirms to Review protocol.

The DataFetcher is responsibile for fetching the data and providing them back as Response.

The Model is represented with Review protocol and it is implemneted by ReviewItem.

I chose to use Storyboard for drawing the views, but not for segues. The reason is that I haven't used so much segues till now and I found it more flexible (at least for me) to do it programatically.

I included Internatiocalization, cause I think it is much easier and no time consuming when it is started from the beginning and can save hours.


I also included some unit tests for covering of the functionlities of Presenter, Data Source and Data Manager


## UX Notes:
According me, presenting the whole review on a small device can result with presenting only one review on screen, so I decided to present the reviews only with the title, rating and version in the overview and if user is more interested in the review can disclose the details of the review with selecting the cell.


## Assumptions:

Top 3 Words should be presented for the Reviews which are currently presented in the table, which means if filter was applied, the top words will be calculated for the reviews applicable for that filter.

The words which are smaller that 4 characters are too simple and don't provide realistic feedback fort he overall "mood" of the reviews, so I decided to take into consideration only the words which have more than 4 characters.  I tested with taking into consideration smaller words and the top words were always "het","de", "voor" ect. Also to remove possibility of not counting some words because of signs like ".", ",", "!" and "?", I filtered them if they are at the end of the word. Anyway ,this can be improved with better and smarter algorithm.

It should be a Universal app.

It is enough the update of data to be done only on a cold start of the app.

