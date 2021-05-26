import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:us_together/Backend/Entities/Event.dart';
import 'package:us_together/Backend/Implementations/SharedPreferences.dart';


class EventProvider {

  final CollectionReference _collectionReference = Firestore.instance.collection("Events");
  final _db = Firestore.instance;
  final SPreferences _preferences = SPreferences();

  Future<bool> AddEvent(MyEvents event) async {
    try {
      String id = await _collectionReference
          .document()
          .documentID;
      String email = await _preferences.getString("currentUserEmail");
      event.idEvent = id;
      event.idCreator = email;
      event.users = [email];
      Map<String, Object> data = event.toMap();
      await _collectionReference.document(id).setData(data).whenComplete(() {
        print("Event créé");
      }).catchError((e) => print(e));
      await _db.collection("Users").document(email).collection("Events").add(data).whenComplete((){
        print("Event ajouté à l'utilisateur");
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getAllRoomEvents(String idRoom) async* {
    yield* _collectionReference.where("IdRoom", isEqualTo: idRoom)./*where("StartDate", isGreaterThan: DateTime.now().toString()).orderBy("StartDate").*/snapshots();
  }

  Stream<QuerySnapshot> getAllUserEvents(String idUser) async* {
    yield* _collectionReference.where("Members", arrayContains: idUser).snapshots();
  }

  Future<void> joinEvent(String idEvent, String idUser) async {
    MyEvents myEvents = MyEvents();
    bool isExisting;
    isExisting = await isInEvent(idEvent, idUser);
    if (isExisting == false) {
      await _collectionReference.document(idEvent).get().then((snapshots) {
        myEvents.fromDocumentSnapshot(snapshots);
      });
      myEvents.users.add(idUser);
      await _collectionReference.document(idEvent)
          .setData(myEvents.toMap())
          .then((value) {
        print("User ajouté à l'event");
      });
      await _db.collection("Users").document(idUser).collection("Events").add(
          myEvents.toMap()).then((value) {
        print("Event ajouté a l'user");
      });
    }
  }

  Future<void> quitEvent(String idEvent, String idUser) async {
    MyEvents myEvents = MyEvents();
    await _collectionReference.document(idEvent).get().then((snapshots){
      myEvents.fromDocumentSnapshot(snapshots);
    });
    myEvents.users.remove(idUser);
    await _collectionReference.document(idEvent).setData(myEvents.toMap()).then((value){
      print("User supprimé de l'event");
    });
    await _db.collection("Users").document(idUser).collection("Events").document(idEvent).delete().then((value){
      print("Event supprimé de l'user");
    });
  }

  Future<bool> isInEvent(String idEvent, String idUser) async {
    bool result;
    await _db.collection("Users").document(idUser).collection("Events").document(idEvent).get().then( (snapshot) {
      if (snapshot.exists) {
        result = true;
        print("L'utilisateur existe");
      } else {
        result = false;
        print("L'utilisateur n'existe pas");
      }
    });
    return result;
  }

  Stream<QuerySnapshot> getFiveNextEvent(String idUser) async* {
    yield* _db.collection("Users").document(idUser).collection("Events")./*where("StartDate" , isGreaterThanOrEqualTo: DateTime.now().toString()).*/limit(4).snapshots();
  }

  Future<List<MyEvents>> getEventFromCalendar(String idUser) async {
    List<MyEvents> events = [];
    try {
      await _db.collection("Users").document(idUser)
          .collection("Events")
          .getDocuments()
          .then((value) {
        for (var elem in value.documents) {
          MyEvents currentEvent = MyEvents();
          currentEvent.fromDocumentSnapshot(elem);
          events.add(currentEvent);
        }
      });
      print(3);
      return events;
    } catch (e) {
      print(e);
      return events;
    }
  }
}