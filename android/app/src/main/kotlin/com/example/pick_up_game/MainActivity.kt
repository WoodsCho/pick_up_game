package com.example.pick_up_game

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle


class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        intent.putExtra("background_mode", "transparent")
        super.onCreate(savedInstanceState)
    }
}