import 'package:flutter/material.dart';

class Authorization extends StatelessWidget {
  const Authorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authorization"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 80,),
            TextField(
              decoration: InputDecoration(labelText: "Login"),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: Text("CANCEL")),
                ElevatedButton(onPressed: () {
                  Navigator.pushReplacementNamed(context, '/todo');
                }, child: Text("NEXT")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
