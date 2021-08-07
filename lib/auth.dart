import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_aplikasi_tugas_akhir/applicationState.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ApplicationState appState = ApplicationState();

  Future<dynamic> createUser(
      String email, String password, String displayName) async {
    String error = '';
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = _userCredential.user;
      user?.updateDisplayName(displayName);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        error = 'email yang dimasukkan sudah terdaftar di akun lain';
        return error;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> signInUser(String email, String password) async {
    String error = '';
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
      User? user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'Email tidak terdaftar';
        return error;
      } else if (e.code == 'wrong-password') {
        error = 'Password yang anda masukkan salah untuk pengguna tersebut.';
        return error;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      await _auth.currentUser!.reload();
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<User> get user {
    return _auth.authStateChanges().map((User? user) => _auth.currentUser!);
  }
}
