#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "\n~~~~~ MY SALON ~~~~~"
  echo -e "\nWelcome to My Salon, how can I help you?"
  
  echo -e "\n1) Haircut\n2) Professional Styling\n3) Hair Perm\n4) Exit"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) HAIRCUT_MENU ;;
    2) PROFESSIONAL_STYLING_MENU ;;
    3) HAIR_PERM_MENU ;;
    4) EXIT_MENU ;;
    *) MAIN_MENU "I could not find that service. What would you like today?"
  esac
}

HAIRCUT_MENU() {
  echo "What's your phone number?"
  read CUSTOMER_PHONE

  #Get customer_id
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_ID ]]
  then
    echo "I don't have a record for that phone number. What's your name?"
    read CUSTOMER_NAME
    INSERT_NEW_CUSTOMER=$($PSQL "insert into customers(phone, name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

  CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")

  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")

  echo "What time would you like your Haircut, $CUSTOMER_NAME?" | sed 's/  / /g'
  read SERVICE_TIME

  if [[ ! $SERVICE_TIME =~ ((1[0-2]|0?[1-9]):?([0-5]?[0-9]?) ?([AaPp]?[Mm]?)) ]]
  then
    MAIN_MENU "Please enter a correct time format."
  else
    INSERT_NEW_APPOINTMENT=$($PSQL "insert into appointments(customer_id, service_id, time) values($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

    echo "I have put you down for a Haircut at $SERVICE_TIME, $CUSTOMER_NAME." | sed 's/  / /g'
  fi

}

PROFESSIONAL_STYLING_MENU() {
  echo "What's your phone number?"
  read CUSTOMER_PHONE

  #Get customer_id
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_ID ]]
  then
    echo "I don't have a record for that phone number. What's your name?"
    read CUSTOMER_NAME
    INSERT_NEW_CUSTOMER=$($PSQL "insert into customers(phone, name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

  CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")

  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")

  echo "What time would you like your Professional Styling, $CUSTOMER_NAME?" | sed 's/  / /g'
  read SERVICE_TIME

  if [[ ! $SERVICE_TIME =~ ((1[0-2]|0?[1-9]):?([0-5]?[0-9]?) ?([AaPp]?[Mm]?)) ]]
  then
    MAIN_MENU "Please enter a correct time format."
  else
    INSERT_NEW_APPOINTMENT=$($PSQL "insert into appointments(customer_id, service_id, time) values($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

    echo "I have put you down for a Professional Styling at $SERVICE_TIME, $CUSTOMER_NAME." | sed 's/  / /g'
  fi

}

HAIR_PERM_MENU() {
  echo "What's your phone number?"
  read CUSTOMER_PHONE

  #Get customer_id
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_ID ]]
  then
    echo "I don't have a record for that phone number. What's your name?"
    read CUSTOMER_NAME
    INSERT_NEW_CUSTOMER=$($PSQL "insert into customers(phone, name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

  CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")

  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")

  echo "What time would you like your Hair Perm, $CUSTOMER_NAME?" | sed 's/  / /g'
  read SERVICE_TIME

  if [[ ! $SERVICE_TIME =~ ((1[0-2]|0?[1-9]):?([0-5]?[0-9]?) ?([AaPp]?[Mm]?)) ]]
  then
    MAIN_MENU "Please enter a correct time format."
  else
    INSERT_NEW_APPOINTMENT=$($PSQL "insert into appointments(customer_id, service_id, time) values($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

    echo "I have put you down for a Hair Perm at $SERVICE_TIME, $CUSTOMER_NAME." | sed 's/  / /g'
  fi
}

EXIT_MENU() {
  echo "Thank you for coming in to the Salon! Have a nice day!"
}

MAIN_MENU
