package com.mae.demo.Logic;

public class DoubleIdException extends Exception{

	private static final long serialVersionUID = 618653727093157995L;
	
	public DoubleIdException() {
		super();
	}
	
	public DoubleIdException(String message) {
		super(message);
	}
	
	public DoubleIdException(Throwable cause) {
		super(cause);
	}
	
	public DoubleIdException(String message, Throwable cause) {
		super(message, cause);
	}
	
	public DoubleIdException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message,cause, enableSuppression, writableStackTrace);
	}
	
	

}
