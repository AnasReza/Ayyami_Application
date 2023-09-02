## 2.0.0: 
    - 3.0 flutter compatibility


## 2.0.1: 19,06,2023
    - added tuhur start timings after beginning questionnaire ends (issue: cant start menstrual timer bec tuhur was not started before)
    - the timer after quetionaire ended was not uploading correctly, after menses ended from questionaire, it should take end time from there and start tuhur immediately, instead it was adding time.now() homescreen
    - time selected on timerbox was not displayed correctly, and padded with '0'
    - start stopwatch menses - time going wrong - fixed every uploading time
    - after start timer with date/time, tuhur ends with current date/time instead of selected date/time
    - added mock second last tuhur at collecting questionaire time 
    - instead of getting all tuhurs, get only last tuhur by desc:false & limit 1 so that it always takes last tuhur instead of tuhur
    - Added description and mapped test cases from book to implementation and viceversa


> TODO/QA: 
    - convert mock to actuall input of user - implement
    - Why is menses ending with assumption expected end time and not actual end time? verify test cases

## 2.0.2: 27,06,2023
    - sychronised all maps with 'days' and 'seconds' fixed bug conflict with 'day' and 'second'. exception caught was map has no valid key of day rather it has key 'days' (with s)
    - Initial testing : pre-marital test cases from book case study scenarios
    - added habit record because assumption was not fetching the last tuhur time correctly  

> TODO/QA: 
    - convert mock to actuall input of user - implement 

## 2.0.3: --,06,2023
    - userProvider not setting beginner or accustomed, Fixed at Splash_screen.dart:226 and first_question:215 hence after menses-timer stops it was giving null and causes exception
    - added version number to identify tested deploys and for updating app in future
    - TuhurRecord:66 had invalid firebase field doc['start_time'] which was causing exception
    - deleted 'days', 'hours', 'minutes', 'seconds' fields while starting last Tuhur: TuhurRecord:63,64
    - startlastTuhur with or without startingValue
    - handle cases of invalid tuhur 
        - where habit days intersect 
        - where habit days doesnt intersect 
    - Reset Timer every time stop timer gets called: MensesTracker:2177
    - Added .limit(1) in home:startLastTuhurAgain:211
    - Added mensesProvider.setTimerStart(false); home:186 try block, hopefully its resolving the error stopwatch not stopping after stoptimer process

    - edit pregnancy count and week from profile PregnancyRecord:08
    - time converter with weeks not giving right map utils:timeConverterWithWeeks
    - duplicate timers in menses startTimer added reset before starting timer in mensesStartTmerAgain and mensesStartTimerPregnancy

> TODO/QA: 

    - if married and not pregnant, show 'im expecting a child' button and show dialog
    - convert mock to actuall input of user - implement
    - set mock account for testing
    - in case of invalid blood and rest of istahada days, notify her to pray early
    - validating start and ends of selected timings
    - if start after invalid tuhur, eh should be notified?
    - add regulation messages to invalid tuhur
    - many enteries name 'start_time' check if they are valid
    - if days exceed 10 days notify regularly on realtime

## 2.0.4: 16,08,2023
    - regulation messages generalized
    - all cases of married beginner
    - all cases of married accustomed
    - all cases of unmarried beginner
    - all cases of unmarried accustomed
    - app translation 
    - pnly targeted exceptions 
    - timers duplication
    - splash bootstrap setup
    
    
## 2.0.5: 17,08,2023
    - changes in beginner cases


    
