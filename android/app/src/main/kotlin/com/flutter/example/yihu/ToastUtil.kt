package com.flutter.example.yihu

import android.R.string.cancel
import android.widget.Toast
import android.content.Context


/**
 * Toast统一管理类
 */
class ToastUtil
private constructor() {

    init {
        throw UnsupportedOperationException("cannot be instantiated")
    }

    companion object {
        private var mToast: Toast? = null

        /**
         * 短时间显示Toast
         *
         * @param context
         * @param message
         */
        fun showShort(context: Context?, message: CharSequence) {
            if (context != null) {
                showToast(context, message, Toast.LENGTH_SHORT)
            }
        }

        /**
         * 短时间显示Toast
         *
         * @param context
         * @param message
         */
        fun showShort(context: Context?, message: Int) {
            if (context != null) {
                showToast(context, message, Toast.LENGTH_SHORT)
            }
        }

        /**
         * 长时间显示Toast
         *
         * @param context
         * @param message
         */
        fun showLong(context: Context?, message: CharSequence) {
            if (context != null) {
                showToast(context, message, Toast.LENGTH_LONG)
            }
        }

        /**
         * 长时间显示Toast
         *
         * @param context
         * @param message
         */
        fun showLong(context: Context?, message: Int) {
            if (context != null) {
                showToast(context, message, Toast.LENGTH_LONG)
            }
        }

        /**
         * 自定义显示Toast时间
         *
         * @param context
         * @param message
         * @param duration
         */
        fun showToast(context: Context?, message: Int, duration: Int) {
            if (context != null) {
                showMyToast(context, context.getString(message), duration)
            }
        }

        /**
         * 自定义显示Toast时间
         *
         * @param context
         * @param message
         * @param duration
         */
        fun showToast(context: Context?, message: CharSequence, duration: Int) {
            if (context != null) {
                showMyToast(context, message.toString(), duration)
            }
        }

        /**
         * 执行toast
         */
        fun showMyToast(context: Context, msg: String, duration: Int) {
            if (mToast == null) {
                mToast = Toast.makeText(context, msg, duration)
            } else {
                mToast!!.setText(msg)
                mToast!!.duration = duration
            }
            mToast!!.show()
        }

        /**
         * 取消所有的toast
         */
        fun closeToast() {
            if (mToast != null) {
                mToast!!.cancel()
            }
        }
    }

}

