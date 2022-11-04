package MongoDb_App;

import com.mongodb.client.*;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.bson.Document;

import java.util.ArrayList;

public class mongoDBConnectivity {
    public static void main(String[] args) {
        //TODO connect to the local instance of mongodb
        MongoClient mongoClient = MongoClients.create();

        //TODO print all the database names => show dbs;
        MongoIterable<String> dbNames = mongoClient.listDatabaseNames();
        for (String dbName : dbNames){
            System.out.println(dbName);
        }

        //TODO Create a collection
        MongoDatabase db = mongoClient.getDatabase("College");
        MongoCollection<Document> inventory = db.getCollection("inventory");

//        Document doc = new Document("name", "journal")
//                        .append("qty", 25);
//
//        Document size = new Document("height", 14).append("width", 10).append("unit", "cm");
//        doc.put("size", size);
//        doc.append("status", "A");
//
//        //insert list of values(array of values)
//        ArrayList<String> list = new ArrayList<>();
//        list.add("brown");
//        list.add("lined");
//        doc.append("tags", list);
//
//        inventory.insertOne(doc);

        //find all the documents
//        FindIterable<Document> result = inventory.find();
//        for (Document doc : result){
//            System.out.println(doc.toJson());
//        }

        //find doc with some condition:
//        FindIterable<Document> res = inventory.find(new Document("name", "journal"));
//        for (Document doc : res){
//            System.out.println(doc.toJson());
//        }


        //Updating document:
//        inventory.updateMany(Filters.eq("name", "journal"), Updates.set("name", "Journal"));
        FindIterable<Document> res = inventory.find(new Document("name", "Journal"));
//        for (Document doc : res){
//            System.out.println(doc.toJson());
//        }

        //Deleting documents:
        inventory.deleteMany(Filters.eq("name", "iPhone"));

        System.out.println("Documents deleted successfully:");
        res = inventory.find();
        for (Document doc : res){
            System.out.println(doc);
        }

    }
}
