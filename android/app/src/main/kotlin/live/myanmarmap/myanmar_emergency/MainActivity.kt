package live.myanmarmap.myanmar_emergency

import android.os.Bundle
import android.os.PersistableBundle
import com.google.firebase.FirebaseApp
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        FirebaseApp.initializeApp(this);
        super.onCreate(savedInstanceState)
    }
}
