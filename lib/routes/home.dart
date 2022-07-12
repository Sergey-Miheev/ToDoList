import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todoList = [];
  String _userInputTask = '';

  // void initFireBase() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initFireBase();
  }

  void _menuOpen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
          centerTitle: true,
        ),
        body: ElevatedButton(
          child: Row(
            children: [
              Icon(Icons.logout),
              Text("Выйти"),
            ],
          ),
          onPressed: () =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        centerTitle: true,
        actions: [
          ElevatedButton(onPressed: () => _menuOpen(), child: Icon(Icons.menu))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("No such tasks!"));
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      key: Key(snapshot.data!.docs[index].id),
                      child: Card(
                        child: ListTile(
                          title: Text(snapshot.data!.docs[index].get('task')),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              FirebaseFirestore.instance.collection('tasks').doc(snapshot.data!.docs[index].id).delete();
                            },
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        FirebaseFirestore.instance.collection('tasks').doc(snapshot.data!.docs[index].id).delete();
                      });
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Добавить задачу'),
                  content: TextField(
                    onChanged: (String value) {
                      _userInputTask = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('tasks')
                              .add({'task': _userInputTask});
                          Navigator.of(context).pop();
                        },
                        child: Text('Add task'))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
