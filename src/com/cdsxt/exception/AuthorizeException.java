package com.cdsxt.exception;

/**
 * 用于抛出权限异常
 */
public class AuthorizeException extends Exception {
    public AuthorizeException() {
    }

    public AuthorizeException(String message) {
        super(message);
    }
}
