#!/bin/bash

# Check for superuser privileges
if [[ $EUID -ne 0 ]]; then
    zenity --error --width=400 --text "This script must be run as root. Please use sudo."
    exit 1
fi

# Main menu using Zenity with auto-sizing window
CHOICE=$(zenity --list \
    --title "Regional Settings Management" \
    --width=400 \
    --height=400 \
    --text "Select an option:" \
    --column "Option" --column "Description" \
    "1" "Set Locale" \
    "2" "Set Keyboard Layout" \
    "3" "Set Timezone" \
    "4" "Set Date Format" \
    "5" "Set Language Preferences" \
    "6" "Set Hostname" \
    "7" "Set System Clock" \
    "8" "View Current Settings" \
    "9" "Exit")

# Perform actions based on user's choice
case $CHOICE in
    "1") # Set Locale
        LOCALES=$(locale -a)
        LOCALE=$(zenity --list \
            --title "Set Locale" \
            --width=600 \
            --height=400 \
            --text "Select a locale:" \
            --column "Locale" --column "Description" \
            $(for locale in $LOCALES; do echo "$locale" "$locale"; done))

        if [ -n "$LOCALE" ]; then
            locale-gen "$LOCALE"
            update-locale LANG="$LOCALE"
            zenity --info --width=400 --text "Locale set to $LOCALE. Please restart your session to apply changes."
        else
            zenity --error --width=400 --text "Invalid locale. Please try again."
        fi
        ;;
    "2") # Set Keyboard Layout
        KEYBOARD_LAYOUT=$(zenity --list \
            --title "Set Keyboard Layout" \
            --width=400 \
            --height=400 \
            --text "Select a keyboard layout:" \
            --column "Layout" --column "Description" \
            "us" "US English" \
            "gb" "British English" \
            "fr" "French" \
            "de" "German" \
            "es" "Spanish" \
            "it" "Italian" \
            "ru" "Russian")

        if [ -n "$KEYBOARD_LAYOUT" ]; then
            setxkbmap "$KEYBOARD_LAYOUT"
            zenity --info --width=400 --text "Keyboard layout set to $KEYBOARD_LAYOUT."
        else
            zenity --error --width=400 --text "Invalid keyboard layout. Please try again."
        fi
        ;;
    "3") # Set Timezone
        TIMEZONE=$(zenity --entry --title "Set Timezone" --text "Enter the desired timezone (e.g., America/New_York):")
        if [ -n "$TIMEZONE" ]; then
            timedatectl set-timezone "$TIMEZONE"
            zenity --info --width=400 --text "Timezone set to $TIMEZONE."
        else
            zenity --error --width=400 --text "Invalid timezone. Please try again."
        fi
        ;;
    "4") # Set Date Format
        DATE_FORMAT=$(zenity --list \
            --title "Set Date Format" \
            --width=400 \
            --height=400 \
            --text "Select a date format:" \
            --column "Format" --column "Description" \
            "+%Y-%m-%d" "YYYY-MM-DD" \
            "+%d-%m-%Y" "DD-MM-YYYY" \
            "+%m-%d-%Y" "MM-DD-YYYY")

        if [ -n "$DATE_FORMAT" ]; then
            timedatectl set-local-rtc 0
            timedatectl set-time-format "$DATE_FORMAT"
            zenity --info --width=400 --text "Date format set to $DATE_FORMAT."
        else
            zenity --error --width=400 --text "Invalid date format. Please try again."
        fi
        ;;
    "5") # Set Language Preferences
        LANGUAGES=$(zenity --list \
            --title "Set Language Preferences" \
            --width=400 \
            --height=400 \
            --text "Select language preferences (comma-separated, e.g., en_US,fr_FR,es_ES):" \
            --column "Language" --column "Description" \
            "en_US" "English (US)" \
            "fr_FR" "French (France)" \
            "es_ES" "Spanish (Spain)" \
            "de_DE" "German (Germany)" \
            "it_IT" "Italian (Italy)" \
            "ru_RU" "Russian (Russia)")

        if [ -n "$LANGUAGES" ]; then
            localectl set-locale LANG="$LANGUAGES"
            zenity --info --width=400 --text "Language preferences set to $LANGUAGES. Please restart your session to apply changes."
        else
            zenity --error --width=400 --text "Invalid language preferences. Please try again."
        fi
        ;;
    "6") # Set Hostname
        NEW_HOSTNAME=$(zenity --entry --title "Set Hostname" --text "Enter the desired hostname:")
        if [ -n "$NEW_HOSTNAME" ]; then
            hostnamectl set-hostname "$NEW_HOSTNAME"
            zenity --info --width=400 --text "Hostname set to $NEW_HOSTNAME. Please restart your system to apply changes."
        else
            zenity --error --width=400 --text "Invalid hostname. Please try again."
        fi
        ;;
    "7") # Set System Clock
        CLOCK_OPTIONS=$(zenity --list \
            --title "Set System Clock" \
            --width=400 \
            --height=400 \
            --text "Select system clock options:" \
            --column "Option" --column "Description" \
            "1" "Synchronize with NTP Server" \
            "2" "Manual Time and Date Setting")

        case $CLOCK_OPTIONS in
            "1")
                timedatectl set-ntp yes
                zenity --info --width=400 --text "System clock synchronized with NTP server."
                ;;
            "2")
                DATE_TIME=$(zenity --calendar --title "Set Date and Time" --text "Select a date and time:")
                if [ -n "$DATE_TIME" ]; then
                    timedatectl set-time "$DATE_TIME"
                    zenity --info --width=400 --text "System date and time set to $DATE_TIME."
                else
                    zenity --error --width=400 --text "Invalid date and time. Please try again."
                fi
                ;;
            *) ;;
        esac
        ;;
    "8") # View Current Settings
        CURRENT_SETTINGS=$(zenity --info --title "Current Regional Settings" --width=600 --height=400 --text "Current Locale: $(locale)\nCurrent Keyboard Layout: $(setxkbmap -query | grep layout | awk '{print $2}')\nCurrent Timezone: $(timedatectl show --property=Timezone --value)\nCurrent Date Format: $(timedatectl show --property=TimeFormat --value)\nCurrent Language Preferences: $(localectl list-locales)\nCurrent Hostname: $(hostname)\nCurrent System Clock Status: $(timedatectl show --property=NTP --value)")

        ;;
    *) # Exit or cancel
        zenity --info --width=400 --text "Exiting Regional Settings Management."
        exit 0
        ;;
esac

exit 0
