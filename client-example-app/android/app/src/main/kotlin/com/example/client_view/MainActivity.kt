package com.example.client_view

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()

import androidx.annotation.Keep
import kotlinx.coroutines.*
import java.io.File

class Example {
    companion object {
        const val ERROR_MESSAGE = "This is a static error message"
    }

    fun aloha(word: String): List<Int> {
        return word.map { it.code }
    }
}

