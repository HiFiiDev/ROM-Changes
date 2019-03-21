#!/bin/bash
# Move this file to your ROM/build !!!

# To run this, simply cd to your ROM folder and run:
# . build/changes.sh
# :)
TodaysDate=$(date +"%m-%d-%Y")
ChangelogFile=changes/$date/$ROMname-Changelog-$date.txt
Changelogger=repo forall -pc git log --reverse --no-merges --since=$NumberOf.days.ago > $ChangelogFile

warmWelcome () {
    echo "############################################################"
    echo "#                                                          #"
    echo "#                                                          #"
    echo "#                   Changelog creater                      #"
    echo "#                                                          #"
    echo "#                                                          #"
    echo "############################################################"
    echo " "
    echo " "
}

noMoreBoringStuff ()
{
    echo " "
    echo "Good news! We'll never have to do this again. :)"
    echo "(Unless you delete the folder...)"

    clear
}

changelogFolder ()
{
    # clear

    if [ ! -d changes ]
    then echo " "
	    echo " "
        echo "Creating Changelog folder..."
        sleep 1
        mkdir changes
        sleep 2
        echo " "
        echo "Done!"
        sleep 1
        echo " "

        # Let the user know what's going on
        echo "Adding Read and Write permissions to the folder..."
        sleep 1
        chmod 777 -R changes
        echo "Done!"
        echo "Moving on..."
        sleep 1

        # Now that all the boring setup stuff is done, let's let the user know.
        noMoreBoringStuff

    else echo "Found the Changelog folder!"
        sleep 1
        echo " "
        echo "Moving on..."
        sleep 1
        echo " "
        echo " "

    fi
}

setROMName () {
    if [ ! -f "changelog_config.dat" ] ; then
        value=$ROMname

        # otherwise read the value from the file
    else
        value=`cat changelog_config.dat`
    fi

    # show it to the user
    echo "ROM name: ${value}"

    # and save it for next time
    echo "${value}" > changelog_config.dat

    if [ -z "$value" ]
    then
        read -p "Set ROM name: " ROMname
        echo "Thanks, ROM name is $ROMname"
        echo " "
        sleep 2
    else
        echo "$value"
    fi

}

gitChangelog ()
{
    echo " "
    echo "Time to set how far back you'd like the changelog to go."
    echo " "
    sleep 1
    echo "How many days back would you like to go?"
    echo "(enter the word 'today' if you'd like to pull the changes from today only)"
    echo " "
    #    echo "** Friendly tip! **"
    #    echo "It's recommended to repo sync prior to pulling any changes"
    #    echo " "
    read -p "Amount of days: " NumberOf

    if [ $NumberOf = $NumberOf ]
    then echo " "
        echo "Creating directory for todays date..."
        sleep 2
        mkdir changes/$(date +"%m-%d-%Y")

        echo " "
        echo "Entering the directory for $TodaysDate"
        sleep 1

        cd changes/$(date +"%m-%d-%Y")

        echo " "
        echo "Pulling the changelog from $NumberOf days ago"

        repo forall -pc git log --reverse --no-merges --since=$NumberOf.days.ago > $ROMname-Changelog-$(date +"%m-%d-%Y").txt
        echo " "
        echo "Done!"
        sleep 2

        cd ..
        cd ..

        echo " "
        echo "Settings some permissions..."
        sleep 1

        chmod 777 -R changes
        echo "Done!"
        cd ..
        #cd changes &&
        # mkdir $Date
        # cd changes
        # cd $Date
        echo " "
        # echo "Done!"
        sleep 2

        echo " "
        echo "Go ahead and head on over to your changes/$TodaysDate folder to find the changelog."
        sleep 1
        echo " "

        echo "Exiting..."
        sleep 2

elif [ $NumberOf = "today" ]
    then echo " "
        echo "Creating directory for todays date..."
        sleep 2
        mkdir changes/$(date +"%m-%d-%Y")

        echo " "
        echo "Entering the directory for $TodaysDate"
        sleep 1

        cd changes/$(date +"%m-%d-%Y")

        echo " "
        echo "Pulling the changelog from 1 day ago"

        repo forall -pc git log --reverse --no-merges --since=1.day.ago > $ROMname-Changelog-$(date +"%m-%d-%Y").txt
        echo " "
        echo "Done!"
        sleep 1

        cd ..
        cd ..

        echo "Settings some permissions..."
        sleep 1

        chmod 777 -R changes
        cd ..
        #cd changes &&
        # mkdir $Date
        # cd changes
        # cd $Date
        echo " "
        echo "Done!"
        sleep 1

        echo " "
        echo "Go ahead and head on over to your changes/$TodaysDate folder to find the changelog."
        sleep 1
        echo " "

        echo "Exiting..."
    fi

}

clear
cd build

warmWelcome

# Create the Changelog folder if we can't find it
changelogFolder

# Set the ROM name for the changelog output
setROMName

# Time to get to the good stuff
gitChangelog
