library constants;

//const String BASE_URL = "http://13.244.137.70/";


const int API_ERROR_CODE = 5052;
const int API_TIMEOUT_CODE = 5053;

const String IN_PROGRESS = 'in_progress';
const String PENDING = 'pending';
const String COMPLETED = 'completed';


const String NULL = 'null';

const String FONT_LIGHT = 'GorditaLight';
const String FONT_REGULAR = 'GorditaRegular';
const String FONT_BOLD = 'GorditaBold';
const String FONT_MEDIUM = 'GorditaMedium';

const String PDF_TYPE = 'pdf_type';
const String USER_UPDATE = '_user_update';
const String DEFAULT_TOPIC_NAME = 'connect';
const String API_ERROR = '{"state": "API_ERROR"}';
const String API_TIMEOUT = '{"state": "API_TIMEOUT"}';

const int GENERAL_NOTIFICATION_ID = 101;

const int API_REQUEST_TIMEOUT = 60;
const int LOCATION_REQUEST_TIMEOUT = 15;

const String PRIMARY_COLOR_HEX = "2f47ae";
const String WHITE_BG_COLOR_HEX = "#EAF3FC";
const String PRIMARY_COLOR_LIGHT_HEX = "4366d1";
const String BUTTON_COLOR_HEX = "04c9e1";
const String DIVIDER_COLOR_HEX = "3569c5";
const String PRIMARY_LIGHT_COLOR_HEX = "BEBAB9";
const String PRIMARY_DARK_COLOR_HEX = "1E1D19";
const String PRIMARY_ACCENT_COLOR_HEX = "FFFFFF";
const String TINT_ACCENT_COLOR_HEX = "FFA000";
const String DARK_ERROR_COLOR_HEX = "580000";

const String PENDING_COLOR_HEX = "#D9D93A";
const String COMPLETED_COLOR_HEX = "#128235";
const String PROGRESS_COLOR_HEX = "#F8A12F";
const String DARK_GREY_COLOR_HEX = "#525252";

const String NO_INTERNET = "Pariwar Services is having trouble connecting to the internet. \nPlease check your internet connection.";
const String WENT_WRONG = "Something Went Wrong!. \nPlease check with Pariwar Services support to resolve this issue.";
const String NOT_AUTHENTICATED = "You are not authenticated with Pariwar Services. Please login again to use the platform.";
const String EMPTY_TIMESHEET = "No entry found. Please check the date range and other filters";

const String SERVER_ERROR_TITLE = "Oops, something went wrong";
const String SERVER_ERROR_BODY = "Try to retry this request or feel free to contact us if the problem persists";

const String TIMEOUT_ERROR_TITLE = "Oops, request get timeout";
const String TIMEOUT_ERROR_BODY = "Try to check your internet coverage and retry again when the device backs online.";

const String SUPPORTED_APP_TITLE = "Supported Application Not found";
const String SUPPORTED_APP_BODY = "No supported application found in your device which help with this action";



class AppConstants {
  static Map<String, bool> ONGOING_ACTIONS = <String, bool>{};
}
