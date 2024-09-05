#!/usr/bin/bash -i

#input
file_name=0
Filteration=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
PURPLE=5
# help func
function Display_awk(){
    awk '{print $4}' "$1" | sort | uniq -c | grep "$2"
}
function Display_grep(){
    grep -n "$2" "$1"
}
function Color () {
 echo "$(tput setaf $1) $2 Not exist$(tput sgr0)"
}
#functions:
            #Report general 
function General_Report() {
    Color $BLUE "DLT Types and numper of repeets:"
    Display_awk $1
    Color $BLUE "DLT System Events:"
    Display_grep'System' "$1"
}
            #Filtering
function Filtering() {
    Color $YELLOW "Filtering: $2"
    Display_awk $1 $2
    Color $YELLOW "Filtered $2 Logs"
    Display_grep $1 $2
}
            #Error and warning summary
function Error() {
    Color $RED "ERRORS:"
    Display_awk $1  "ERROR"
    Color $RED "ERROR Events:"
    Display_grep 'ERROR' "$1"
}
function Warning() {
    color $PURPLE "WARNING:"
    Display_awk $1 "WARN"
    Color $PURPLE "WARN Events:"
    Display_grep 'WARN' "$1"
}
            #Event tracking
function Event_Tracking() {
    Color $YELLOW "EVENT TRACKING: $2"
    Display_awk $1 $2
    Color $YELLOW "Events Logs:"
    Display_grep $1 $2
}
            #Log or type of DLT
function Type_DLT() {
    Color $BLUE "DLT Logs:"
    awk '{print $3}' "$1" | sort | uniq  
}
function main(){   
    echo "Enter the file name to search in:"
    read file_name
   if [ ! -f "$file_name" ]; then
        Color $RED "File not exist"
        exit 1
   fi
        clear
select USE in "Type_Of_DLT" "General_Report" "Filtering" "Error" "Warning" "Event_tracking" "Exist"; do 
    case "${USE}" in
       Type_Of_DLT)
            clear
            Type_DLT $file_name
        ;;
        General_Report)
            clear
            General_Report $file_name
        ;;
        Filtering)
            clear
            Color $YELLOW "Search For:"
            read Filteration
            Filtering $file_name $Filteration
        ;;
        Error)
            clear
            Error $file_name
        ;;
        Warning)
            clear
            Warning $file_name
        ;;
        Event_tracking)
            clear
            Color $PURPLE "Enter Event To Track:"
            read Filteration
            Event_Tracking $file_name $Filteration
        ;;
        Exist)
            clear

            break
        ;;
        *)
            clear
            echo "default (none of above)"
            break
        ;;
    esac
done

}
#main
main

