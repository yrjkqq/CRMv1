package com.cdsxt.exception;

/**
 * 用于抛出权限异常
 */
public class DeleteException extends Exception {
    public DeleteException() {
    }

    public DeleteException(String message) {
        super(message);
    }
}
