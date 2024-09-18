/**
 * Main application factory class which is responsible for returning the correct business implementation for the unit
 * of work, service, selector and domain layers within the application.
 *
 * NOTE: Please add values in ALPHABETICAL order, to prevent duplicates
 *
 * @author 		Adam Marchbanks (amarchbanks@deloitte.nl)
 * @created 	October 2017 
 */
public without sharing class App_Application {

	public static fflib_Application.UnitOfWorkFactory unitOfWork;
	public static fflib_Application.ServiceFactory service;
	public static fflib_Application.SelectorFactory selector;
	/**
	 * IMPORTANT: Domain classes must have an inner class called Constructor which implements
	 * fflib_SObjectDomain.IConstructable and you must point the sObjectType below to the inner class and not
	 * the outer class. E.g.
	 *
	 * Account.sObjectType      =>      DOM_Accounts.Constructor
	 *
	 * Failure to do this will result in an exception when the framework attempts to instantiate the class.
	 */
	public static fflib_Application.DomainFactory domain;

	static {
		unitOfWork = new fflib_Application.UnitOfWorkFactory();
		service = new fflib_Application.ServiceFactory();
		selector = new fflib_Application.SelectorFactory();
		domain = new fflib_Application.DomainFactory(selector);
	}
}