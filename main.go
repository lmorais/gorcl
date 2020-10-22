package main

import (
	"database/sql"
	"fmt"
	"os"

	_ "github.com/godror/godror"
)

var (
	DbUser   = os.Getenv("DB_USER")
	DbPasswd = os.Getenv("DB_PASSWD")
	DbHost   = os.Getenv("DB_HOST")
	DbPort   = os.Getenv("DB_PORT")
)

func main() {

	var date string

	db, err := sql.Open("godror", `user=`+DbUser+` password=`+DbPasswd+` connectString=`+DbHost+`:`+DbPort+`/ORCL`)

	if err != nil {
		fmt.Println(err)
		return
	}
	defer db.Close()

	fmt.Println("Running query...")

	rows, err := db.Query("SELECT sysdate FROM dual")
	if err != nil {
		fmt.Println(fmt.Errorf("Error running query: %v", err))
		return
	}

	fmt.Println("Query executed !")

	defer rows.Close()

	for rows.Next() {
		rows.Scan(&date)
	}

	fmt.Printf("Current date is: %s\n", date)
}
