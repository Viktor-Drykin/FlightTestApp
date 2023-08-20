# FlightTestApp

1. This application contains only 1 screen.
2. The screen in implemented using `SwiftUI`
3. `Async/Await` is used for async operations.
3. Part of `FlightsPresenter` implementation is covered by Unit Tests(didn't have time to finish it). If I had more time I would cover by Unit Tests: `PlacesService`, `FlightsProvider`, `FlightResultsStorage`, `FlightsService`, `FlightsModelMappe`r, `FlightsMapper`

## Details of implementation:
1. Source places are hardcoded: Brno, Prague, Vienna
2. `PlacesService` is responsible for downloading destination places
3. `FlightsService` is responsible for downloading flights
4. `FlightResultsStorage` is created because of requirement **That is, if your sample app presents some selection of routes (f.e. PRG→JFK, ORY→SFO, ...) between destinations on Day 1, these exact routes won’t be offered again on a different day, and so on**
   > #### $\textcolor{red}{\textsf{According to the current implementation based on this requirement after some time user will stop seeing any flights because API returns fixed flights based on source and destination ids.}}$
   So basically this storage:
   1. check whether flight was already shown for other date or not
   2. store the flight
   
6. `FlightsProvider` contains `FlightsService` and `FlightResultsStorage` and provides flights for `FlightsPresenter`
7. `FlightsObservable` for better separation between business logic and UI. But at final implementation it seems unnecessary. I didn't have enough time to implement it better.
   
## General Structure of the app
<img src="https://github.com/Viktor-Drykin/FlightTestApp/assets/142505425/165e0cff-043c-49a4-b58b-dd043b1f2cb8" width="700" height="700" />
