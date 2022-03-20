#!/bin/bash
# Move this file to your ROM/build !!!

# To run this, simply cd to your ROM folder and run:
# . build/changes.sh
# :)
TodaysDate=$(date +"%m-%d-%Y")
changesFile=changes/$date/$ROM_name-changes-$date.txt
changesger=repo forall -pc git log --reverse --no-merges --since=$NumberOf.days.ago > $changesFile


while [ $# -gt 0 ]
do
    case $1 in
        '--debug')
            #TODO
            ;;
        *)
            echo "unrecognised arg $1"; exit
            ;;
    esac
    shift
done

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


warmWelcomeTest () {


    echo
    for l in W e l c o m e ; do
        echo -n $l
        sleep .1
    done
    echo -n " "
    sleep .1
    for l in t o ; do
        echo -n $l
        sleep .1
    done
    echo -n " "
    sleep .2
    for l in h i f i i s ; do
        echo -n $l
        sleep .1
    done
    echo -n " "
    sleep .2
    for l in C h a n g e l o g ; do
        echo -n $l
        sleep .1
    done
    echo
    sleep .25
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
        echo "Creating changes folder..."
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
        echo "Moving on"
        sleep 1

        # Now that all the boring setup stuff is done, let's let the user know.
        noMoreBoringStuff

    else echo " "
        echo -n "Found the changes folder!"
        sleep 2
        echo -n " Moving on"
        for l in . . . ; do
        echo -n $l
        sleep .1
    done
    echo
    sleep .25
        sleep 2
        echo " "

    fi
}

setROM_name () {
    if [ ! -z $ROM_name ] ; then
        value=$ROM_name
    fi

    # show it to the user
    sleep 1
    clear
    tput cup 0 0
    echo -e "\nROM name: ${value}"
    sleep 1
    tput cup 10 10

    if [ -z "$value" ]
    then
        read -p "Set ROM name: " ROM_name
        echo "Thanks, ROM name is $ROM_name"
        sed -i "10 i\ROM_name=$ROM_name" changes.sh
        echo " "
        sleep 2
    fi
}

gitchanges ()
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

        echo $'$ROM_name changelog\n' > $ROM_name-changes-$(date +"%m-%d-%Y").txt
        repo forall -pc git log --reverse --no-merges --since=$NumberOf.days.ago >> $ROM_name-changes-$(date +"%m-%d-%Y").txt
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
        echo " "
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

        repo forall -pc git log --reverse --no-merges --since=1.day.ago > $ROM_name-changes-$(date +"%m-%d-%Y").txt
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


# make it look cleaner and then cd into build folder
clear
cd build


# say hello
warmWelcomeTest

# Create the changes folder if we can't find it
changelogFolder

# Set the ROM name for the changelog output
setROM_name

# Time to get to the good stuff
gitchanges
