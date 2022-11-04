package Main;

import java.sql.*;
public class Java_Mysql {
    public static void main(String[] args) {
        // For Intellij
        //TODO File -> Project Structure -> Modules
        //Go to dependencies and add JAR file which we have downloaded (stored in lib)


        try {
            String url = "jdbc:mysql://localhost:3306/college";
            String userName = "root";
            String password = "pass123";

            //TODO Establish Connection:
            Connection connection = DriverManager.getConnection(url, userName, password);
            System.out.println("Connected to the Database");

            //TODO insert into table
            String insertQuery = "insert into customer values(1 , 'Kanak')";
            Statement statement = connection.createStatement();

//            statement.executeUpdate(insertQuery);
//            insertQuery = "insert into customer values(2 , 'Gaurav')";
//            statement.executeUpdate(sql);
//
//            printTable(statement);

            //TODO update rows in table
//            String updateQuery = "update customer set firstName = 'Kanak Somani' where id = 1";
//            statement.executeUpdate(updateQuery);
//
//            printTable(statement); //print the table

            //TODO delete rows from table
            insertQuery = "insert into customer values(3, 'XyzName')";
            statement.executeUpdate(insertQuery);
            printTable(statement);

            String deleteQuery = "delete from customer where id = 3";
            statement.executeUpdate(deleteQuery);
            printTable(statement);


        }catch (SQLException e){
            System.out.println("🛑🛑 Error 🛑🛑");
            e.printStackTrace();;
        }
    }

    private static void printTable(Statement statement ) throws SQLException {
        //TODO print table
        ResultSet res = statement.executeQuery("select * from customer");
        while (res.next()){
            System.out.println(res.getInt(1) + " " + res.getString(2));
        }
        System.out.println();
    }
}
