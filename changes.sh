#!/bin/bash
# Move this file to your ROM/build !!!

# To run this, simply cd to your ROM folder and run:
# . build/changes.sh
# :)
TodaysDate=$(date +"%m-%d-%Y")
changesFile=changes/$date/$ROMname-changes-$date.txt
changesger=repo forall -pc git log --reverse --no-merges --since=$NumberOf.days.ago > $changesFile
one=1



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

    # thanks to TommyTomatoe for this neat little piece of
    # code to animate text!
    # https://urlzs.com/eqdzr
    # ^^^ link to code I basically cut and pasted

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
    for l in H i f i i s ; do
        echo -n $l
        sleep .1
    done
    echo -n " "
    sleep .1
    for l in C h a n g e l o g ; do
        echo -n $l
        sleep .1
    done
    echo -n " "
    sleep .1
    for l in C r e a t o r ; do
        echo -n $l
        sleep .1
    done
    echo -n " "
    sleep 2.5
}

changelogFolder ()
{
    if [ ! -d changes ]
    then echo " "
        echo " "
        echo "Creating changes folder..."
        sleep 1
        mkdir -p changes
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
        echo -n " "
        sleep 1

    fi
}

# Basically what this does is gets the ROM name
# that the user enters, and saves it to a hidden file
# upon the first use, but then remembers what they
# entered so of course the user doesnt have to enter
# it every time
setROMName () {

    if [ -z "$value" ]
    then
        read -p "Set ROM name: " ROMname
        echo "Thanks, ROM name is: $ROMname"
        echo " "
        sleep 2
        #    else
        #        echo "$value"
    fi

    if [ ! -f "changelog_config.conf" ] ; then
        value=$ROMname

        # otherwise read the value from the file
    else
        value=`cat changelog_config.conf`
    fi

    # show it to the user
    echo "ROM name: ${value}"

    # and save it for next time
    echo "${value}" >> $HOME/etc/changelog_config.conf

}

gitchanges ()
{

    echo " "
    echo "Time to set how far back you'd like the changelog to go."
    echo " "
    sleep 1
    echo "How many days back would you like to go?"
    echo " "

    ### Not sure if i should incluce this part or not. ###
    ### comment out for now ###

    #    echo "** Friendly tip! **"
    #    echo "It's recommended to repo sync prior to pulling any changes"
    #    echo " "

    read -p "Amount of days: " NumberOf

    if [ $NumberOf != $one ]
    then echo " "
        echo "Creating directory for todays date..."
        sleep 2
        mkdir -p changes/$(date +"%m-%d-%Y")

        echo " "
        echo "Entering the directory for $TodaysDate"
        sleep 1

        cd changes/$(date +"%m-%d-%Y")

        echo " "
        echo "Pulling the changelog from $NumberOf days ago"

        echo $'$ROMname changelog\n' > $ROMname-changes-$(date +"%m-%d-%Y").txt
        repo forall -pc git log --reverse --no-merges --since=$NumberOf.days.ago >> $ROMname-changes-$(date +"%m-%d-%Y").txt
        echo " "
        echo "Done!"

        sleep 2

        cd ..
        cd ..

        ### I will probably get rid of this part ###
        ### or make it an option ###
        echo " "
        echo "Settings some permissions..."
        sleep 1

        chmod 777 -R changes
        echo "Done!"
        cd ..
        echo " "
        sleep 2

        echo " "
        echo "Go ahead and head on over to your changes/$TodaysDate folder to find the changelog."
        sleep 1
        echo " "

        echo "Exiting..."
        echo " "
        sleep 2
    fi

    # just in case they still enter '1' instead of 'today'
    if [ $NumberOf = "$one" ]
    then echo " "
        echo "Creating directory for todays date..."
        sleep 2
        mkdir -p changes/$(date +"%m-%d-%Y")

        echo " "
        echo "Entering the directory for $TodaysDate"
        sleep 1

        cd changes/$(date +"%m-%d-%Y")

        echo " "
        echo "Pulling the changelog from 1 day ago"

        # make the changelog
        repo forall -pc git log --reverse --no-merges --since=1.day.ago > $ROMname-changes-$(date +"%m-%d-%Y").txt
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

# make it look cleaner, then cd into build folder
clear

### TO DO ###
# Figure out a way to see if user is already
# in his/her build folder
cd build


# say hello
warmWelcomeTest

# Create the changes folder if we can't find it
changelogFolder

# Set the ROM name for the changelog output
setROMName

# Time to get to the good stuff
gitchanges
