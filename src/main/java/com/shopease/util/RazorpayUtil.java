package com.shopease.util;

import com.razorpay.RazorpayClient;

public class RazorpayUtil {

    private static final String KEY_ID =
            System.getenv("RAZORPAY_KEY_ID");

    private static final String KEY_SECRET =
            System.getenv("RAZORPAY_KEY_SECRET");

    public static RazorpayClient getClient() throws Exception {
        return new RazorpayClient(KEY_ID, KEY_SECRET);
    }

    public static String getKeyId() {
        return KEY_ID;
    }

    public static String getKeySecret() {
        return KEY_SECRET;
    }
}