/**
 * Used for maintaining the request and response structures for the Collection Appointments API
 *
 * @author    Vengatesan N P (vnp@deloitte.com)
 * @created   March 2024
 */

 public with sharing class PNL_CollectionAppointmentsWrappers {

    /**
     * The request structure this service expects.
     */
    public class OverviewRequest {
        public String customerNumber{get;set;}
        public String pickupDeliveryAddress{get;set;}
        public OverviewDateRange pickupDeliveryDates{get;set;}
        public List<String> statuses {
            get {
                return statuses == null ? SAS_PickupDeliveryReadService.DEFAULT_STATUSES : statuses;
            }
            set;
        }
        // If true : service returns pickup record types. If false: service returns delivery record types
        public Boolean requirePickupData{get;set;}
        public OverviewOptions options {get; set;}
    }

    public class OverviewDateRange{
        public Date fromDate{get;set;}
        public Date toDate{get;set;}
    }

    public class OverviewOptions {
        public Integer dataOffset {
            get {
                return dataOffset == null ? SAS_PickupDeliveryReadService.DEFAULT_OFFSET_VALUE : dataOffset;
            }
            set;
        }
        public Integer dataLimit {
            get {
                return dataLimit == null ? SAS_PickupDeliveryReadService.DEFAULT_LIMIT_VALUE : dataLimit;
            }
            set;
        }
        // possible values 'start_date'
        public String sortBy {
            get {
                return sortBy == null ? SAS_PickupDeliveryReadService.SORT_BY_START_DATE : sortBy;
            }
            set;
        }
        // possible values 'descending', 'ascending'
        public String sortDirection {
            get {
                return sortDirection == null ? SAS_PickupDeliveryReadService.SORT_DIRECTION_ASC : sortDirection;
            }
            set;
        }
    }

    /**
     * Response structure which will be sent back with service contract and order data. Some errors
     * will throw an exception and may not return this structure.
     */
    public class OverviewResponse {
        // Indicates if the request is valid or not
        public Boolean success = false;
        public Boolean hasMoreRows = false;
        public List<OverviewPickupDeliveryOrder> pickupDeliveryOrders;
    }

    /**
     * Contains data for Service Contracts and Orders
     * Service contracts and orders are together referred to as 'Orders' in Pickup and Delivery parlance
     */
    public class OverviewPickupDeliveryOrder {
        public String iconURL;
        public String productNames;
        public String contractNumber;
        public String contractReference;
        public String orderNumber;
        public String status;
        public String reasonNotAcceptedServiceContract;
        public String reasonNotAcceptedOrder;
        public String statusIconURL;
        public String statusLabel;
        public String startDay;
        public Date startDate;
        public String requestDate;
        public Long startTime;
        public Long endTime;
        public String objectType;
        public String deliveryWeekdayShort;
        public String recurringUrl;
        public String createdDateOfPickup;
        public List<OverviewDailySchedule> serviceContractSchedule;
        public Datetime sortingDatetime;
    }

    /**
     * Timetable details needed in the expanded row. Only relevant for service contracts.
     */
    public class OverviewDailySchedule{
        public String pickupDeliveryDay;
        public String pickupDeliveryDayShort;
        public Date pickupDeliveryDate;
        public Long startTime;
        public Long endTime;
        public String productsOfTheDay;
    }

    /**
     * Response structure which will be sent back with the pickup service contracts.
     */
    public class PickupContract {
        public PnpContractsSummary pnpContractsSummary;
        public List<PickupServiceContracts> pickupServiceContracts;
        public Boolean hasMoreRows;
    }

    /**
     * This is a wrapper class for data related to Pnp contracts
     */
    public class PnpContractsSummary {
        public String appointments;
        public String timeWindow;
        public String productDetails;
    }

    /**
     * This is a wrapper class for data related to Hbs contracts
     */
    public class PickupServiceContracts {
        public String status;
        public Date startDate;
        public Date endDate;
        public String contractReference;
        public String changeContractReference;
        public String appointments;
        public String timeWindow;
        public String productDetails;
        public String commercialProductCode;
        public List<Timetable> timetables;
        public AppointmentLocation location;
        public List<PhysicalProduct> products;
    }

    /**
     * This is a wrapper class for data related to Timetable
     */
    public class Timetable implements Comparable {
        public Integer weekDayNumber;
        public String weekDay;
        public String timeframe;
        public String hour;

        // Implement the compareTo() method
        public Integer compareTo(Object compareTo) {
            Timetable compareToTt = (Timetable)compareTo;
            if (weekDayNumber == compareToTt.weekDayNumber) return 0;
            if (weekDayNumber > compareToTt.weekDayNumber) return 1;
            return -1;
        }
    }

    /**
     * This is a wrapper class for data related to AppointmentLocation
     */
    public class AppointmentLocation {
        public String postalCode;
        public String houseNumber;
        public String houseNumberAddition;
        public String buildingName;
        public String street;
        public String city;
        public String countryCode;
        public String country;
        public String collectionAddress;
        public String name;
    }

    /**
     * This is a wrapper class for data related to PhysicalProduct
     */
    public class PhysicalProduct {
        public String name;
        public String code;
        public String quantity;
    }
}