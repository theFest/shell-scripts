#!/bin/bash

# Check for superuser privileges
if [[ $EUID -ne 0 ]]; then
    zenity --error --text "This script must be run as root. Please use sudo."
    exit 1
fi

# Function to set locale
set_locale() {
    LOCALES=$(locale -a)
    LOCALE=$(zenity --list \
        --title "Set Locale" \
        --text "Select a locale:" \
        --column "Locale" --column "Description" \
        $(for locale in $LOCALES; do echo "$locale" "$locale"; done))

    if [ -n "$LOCALE" ]; then
        locale-gen "$LOCALE"
        update-locale LANG="$LOCALE"
        zenity --info --text "Locale set to $LOCALE. Please restart your session to apply changes."
    else
        zenity --error --text "Invalid locale. Please try again."
    fi
}

# Function to set keyboard layout
set_keyboard_layout() {
    KEYBOARD_LAYOUT=$(zenity --list \
        --title "Set Keyboard Layout" \
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
        zenity --info --text "Keyboard layout set to $KEYBOARD_LAYOUT."
    else
        zenity --error --text "Invalid keyboard layout. Please try again."
    fi
}

# Function to set timezone
set_timezone() {
    TIMEZONE=$(zenity --entry --title "Set Timezone" --text "Enter the desired timezone (e.g., America/New_York):")
    if [ -n "$TIMEZONE" ]; then
        timedatectl set-timezone "$TIMEZONE"
        zenity --info --text "Timezone set to $TIMEZONE."
    else
        zenity --error --text "Invalid timezone. Please try again."
    fi
}

# Function to set date format
set_date_format() {
    DATE_FORMAT=$(zenity --list \
        --title "Set Date Format" \
        --text "Select a date format:" \
        --column "Format" --column "Description" \
        "+%Y-%m-%d" "YYYY-MM-DD" \
        "+%d-%m-%Y" "DD-MM-YYYY" \
        "+%m-%d-%Y" "MM-DD-YYYY")

    if [ -n "$DATE_FORMAT" ]; then
        timedatectl set-local-rtc 0
        timedatectl set-time-format "$DATE_FORMAT"
        zenity --info --text "Date format set to $DATE_FORMAT."
    else
        zenity --error --text "Invalid date format. Please try again."
    fi
}

# Function to set language preferences
set_language_preferences() {
    LANGUAGES=$(zenity --list \
        --title "Set Language Preferences" \
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
        zenity --info --text "Language preferences set to $LANGUAGES. Please restart your session to apply changes."
    else
        zenity --error --text "Invalid language preferences. Please try again."
    fi
}

# Main menu using Zenity with improved styling and larger windows
CHOICE=$(zenity --list \
    --title "Regional Settings Management" \
    --text "Select an option:" \
    --column "Option" --column "Description" --width 400 --height 350 \
    "1" "Set Locale" \
    "2" "Set Keyboard Layout" \
    "3" "Set Timezone" \
    "4" "Set Date Format" \
    "5" "Set Language Preferences" \
    "6" "Exit")

# Perform actions based on user's choice
case $CHOICE in
    "1") set_locale;;
    "2") set_keyboard_layout;;
    "3") set_timezone;;
    "4") set_date_format;;
    "5") set_language_preferences;;
    *)   zenity --info --text "Exiting Regional Settings Management.";;
esac

exit 0
