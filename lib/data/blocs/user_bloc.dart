import 'dart:async';

import 'package:neosoft/data/dbhelper.dart';
import 'package:neosoft/model/user_model.dart';

import 'bloc_provider.dart';

class UsersBloc implements BlocBase {
  // Create a broadcast controller that allows this stream to be listened
  // to multiple times. This is the primary, if not only, type of stream you'll be using.
  final _userController = StreamController<List<User>>.broadcast();

  // Input stream. We add our users to the stream using this variable.
  StreamSink<List<User>> get _inNotes => _userController.sink;

  // Output stream. This one will be used within our pages to display the users.
  Stream<List<User>> get users => _userController.stream;

  // Input stream for adding new users. We'll call this from our pages.
  final _addNoteController = StreamController<User>.broadcast();

  StreamSink<User> get inAddNote => _addNoteController.sink;

  UsersBloc() {
    // Retrieve all the users on initialization
    getUser();

    // Listens for changes to the addNoteController and calls _handleAddNote on change
    _addNoteController.stream.listen(_handleAddNote);
  }

  // All stream controllers you create should be closed within this function
  @override
  void dispose() {
    _userController.close();
    _addNoteController.close();
  }

  void getUser() async {
    // Retrieve all the users from the database
    List<User> users = await DBHelper.db!.getUser();

    // Add all of the users to the stream so we can grab them later from our pages
    _inNotes.add(users);
  }

  void _handleAddNote(User user) async {
    // Create the user in the database
    await DBHelper.db!.saveUser(user);
    // Retrieve all the users again after one is added.
    // This allows our pages to update properly and display the
    // newly added user.
    getUser();
  }


}
UsersBloc userBloc = UsersBloc();
