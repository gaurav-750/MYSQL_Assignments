package com.gaurav;

import com.mongodb.MongoException;
import com.mongodb.client.*;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.*;
import java.util.logging.*;

public class Main {
    public static void main(String[] args) {
//        Logger.getLogger("org.mongodb.driver").setLevel(Level.WARNING);
        MongoClient mongoClient = null;

        try {
            //todo connecting to the instance of mongodb:
//            mongoClient = MongoClients.create("mongodb+srv://PCSB:xenia1234@xeniacluster.ehu7w.mongodb.net/Xenia_Database?retryWrites=true&w=majority");
            mongoClient = MongoClients.create("mongodb://localhost:27017");
            System.out.println("Connected to the db!");

            //todo listing all the databases name:
            MongoIterable<String> dbNames = mongoClient.listDatabaseNames();
            for (String dbName : dbNames){
                System.out.println(dbName);
            }
            System.out.println();

            //todo choose a specific database/ create a new
            MongoDatabase database = mongoClient.getDatabase("Hostel");
            System.out.println("database created!");
//
//            //todo creating a collection/ or getting an existing one:
            database.createCollection("Boys");
            System.out.println("collection created!");

            //get the collection:
            MongoCollection<Document> collection = database.getCollection("Boys");

//            //Todo inserting documents into 'Boys' collection:
            Document document = new Document();
            insertOneDoc(collection, document);
//
//            //todo insert many documents into collection:
            insertManyDoc(collection);
//
//            //todo retrieve all the documents from the collection:
            findAllDocuments(collection);

            //todo Update:
            collection.updateMany(Filters.eq("name", "Partham"), Updates.set("name", "Pratham"));
            FindIterable<Document> doc = collection.find(new Document("rollno", 3));
            System.out.println(doc.first().toJson());
            System.out.println(doc);
//
//            //todo Delete:
//            Bson deleteQuery = lt("rollno", 1);
            Bson deleteQuery = new Document("rollno", new Document("$gt", 1));
            collection.deleteMany(deleteQuery);

            System.out.println("After deleting documents:");
            findAllDocuments(collection);

        }catch (MongoException e){
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }finally {
            System.out.println("Done..!");
        }


    }

    private static void findAllDocuments(MongoCollection<Document> collection) {
        FindIterable<Document> documents = collection.find();
        for (Document doc : documents){
            System.out.println(doc);
        }
    }

    private static void insertManyDoc(MongoCollection<Document> collection) {
        List<Document> documents = Arrays.asList(
                new Document().append("rollno", 2).append("name", "Advait").append("skills", Arrays.asList("Cricket", "Dsa")),
                new Document().append("rollno", 3).append("name", "Partham").append("skills", Arrays.asList("Pc Games", "Cp"))
        );

        collection.insertMany(documents);
    }

    private static void insertOneDoc(MongoCollection<Document> collection, Document document) {
        //SCHEMA: rollNo(int) Name(String) Skills(List<String>)
        document.append("rollno", 1)
                        .append("name", "Gaurav")
                                .append("skills", Arrays.asList("Cricket", "Mern"));

        collection.insertOne(document);
    }

}
