# VIVA

## Background and Goals for Our Project
We were inspired to focus our hack on the rise of instagram accounts exposing sexual assault stories from college campuses across the US, including the Case Western account @cwru.survivors; and the history of sexual assault on campuses nationwide. We wanted to create an iOS app that would help sexual assault survivors and students navigate the dangerous reality of college campuses. With our app, it will be easier for a survivor report instances of harassment, while maintaining the integrity of the user data, and ensuring that data is anonymous and randomized. Our app will map safe and dangerous areas on campus based on user data to help women, minorities, and sexual assault survivors feel protected.

### "When I looked in the mirror the next day, I could hardly recognize myself. Physically, emotionally, and mentally." -A submission on @cwru.survivors IG page

Even with the #MeToo movement, there's only so much that technology can do. However, we hope that by creating this app, we will help college students take accountability and create a campus culture that can best foster learning and contribute towards social good.

### "The friendly guy who helps you move and assists senior citizens in the pool is the same guy who assaulted me. One person can be capable of both. Society often fails to wrap its head around the fact that these truths often coexist, they are not mutually exclusive." - Chanel Miller

## Technologies Utilized
- Mapbox SDK
- Github
- XCode & Swift
- Firebase
- Adobe Illustrator
- Google Cloud
- Canva

## Mentors & Help
- Ryan Matsumoto
- Rachel Lovell

## Categories
- Route: Hack for Resilience
- Route: Best Education Hack

## User/sociologist questions
- To take this further within the research sphere, there would be Privacy/IRB considerations, according to Rachel Lovell, an sociologist who specializes in sexual assault. Currently, the app maps dangerous areas without specifying an address, to avoid privacy concerns about locations of assaults.
- With the anonymous platform, there is the possibility of false information. How accurate is the data?
- Why would students need this?
- What makes a student report and what discourages them from reporting?
- How we can try to address that?

## Next steps
- Integrating hardware with Adafruit Bluefruit device

## Installation

## Survey results
We surveyed Case Western Reserve University students on the viability of a viva product. 83.33% reported that they know someone who has been a victim of sexual assault on a college campus, and 45.45% were victims themselves. 83.33% had noticed a rise of sexual assault allegations about college campus sexual assault on social media, which was the original driving force and inspiration of our app. Last, 100% responded that they believe an app like viva would be effective at keeping them safe from campus sexual assault. The survey indicated that the app could be a useful and desired tool for college students dealing with fear of harm on campus.

## Functions
- Account creating and sign in function using Firebox, to allow users to have accounts and profiles
- Home screen with heat map of dangerous locations in the area, using the Mapbox SDK
- Profile screen, listing contact information and displaying the user's past submissions of dangerous locations
- Submission screen, where users can enter an address, time, and story related to a dangerous area on campus

## Coding difficulties
Mapbox SDK
-  Integrating an outside mapping service came with a variety of difficulties. We ran into problems learning their platform and troubleshooting errors with the Mapbox view. Furthermore, Mapbox has a lot of navigation functionality. Since our goal was a data map with a lot of visual effect and easy readability, we had to translate the Mapbox SDK to be usable with lots of data inputs. This meant coding so that the map would auto-adjust with each new data submission of dangerous locations on campus.
UI Privacy Concerns
- The Mapbox SDK was created to be able to pin very specific locations. However, our app deals with data points of locations of sexual assault, or unsafe locations. This brings up the concern of protecting the privacy of the people who submit addresses, and ensuring that users can't see the exact location submitted. So, we had to adjust the code to limit how far a user can zoom in, and to read as a heat map of general location, rather than pins.
Coding for non-tech users
- Our app, viva, was designed to be used by college students on their nights out, or at parties. The idea would be for them to check the safety of their area while walking home or while out with friends. So, we had to appeal to an audience of young people using the app in their free time or during special occasions. This meant the app would not appeal if it seemed tech-y or hard to use. So, we had to work to incorporate a lot of functionalities, and a user interface that was easy to use and appealing to young people. This included allowing them to make accounts, having an easily readable map, creating a submission page, and incorporating design elements.


## Contributors
Andrea Tongsak, Vivian Zhang, Alyssa Tan, and Mira Tellegen
