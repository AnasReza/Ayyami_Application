# ---------------- TEST CASES MENSES - BEGINNER ---------------------

## TestCase-1 : duration of menses 
    int days = menses_end_date - menses_start_date;
    • if (days >= 3 && days <= 10):
        - menses
    • else :
        - no-menses

## TestCase-2 : duration of tuhur 
    int tuhur_count = tuhur_started - tuhur_ended OR last_menses_ended - current_menses_started;
    • if (tuhur_count >= 15):
        - okay
    • else :
        - tuhur cannt be less than 15 
        - ?

## TestCase-3 : expected/assumed next menses date
    int expected_start_day = last_menses_end_day + last_tuhur_habit_count;
    int expected_last_day  = expected_start_day  + last_menses_habit_count;

## TestCase-3 : difference of last two or habit consecutive tuhur count 
    int tuhur_difference = last_tuhur_count - current_tuhur_count; // 25 - 18 = 7
    • if(tuhur_difference > 0):
        - it means bleeading started before last tuhur count
        - she should pray after current_tuhur_count because shariah says one doesnt know future, 
        - ? 

    int menses_count = last_menses_count ; // = 5
    int days = menses_count + tuhur_difference // = 12;

    • if (days >= 3 && days <= 10):
        - menses
    • else :
        - no-menses