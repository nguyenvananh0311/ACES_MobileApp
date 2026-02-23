import 'dart:convert';
import 'package:ems/models/feedback/feedback.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/attendance/attendance.dart';
import '../models/attendance/attendanceBody.dart';
import '../models/attendance/branch.dart';
import '../models/employee/employee.dart';
import '../models/employee/memberProfile.dart';
import '../models/employee/profile.dart';
import '../models/leave/leaveRequest.dart';
import '../models/leave/monthlyLeave.dart';
import '../models/login/login.dart';
import '../models/notification/employeeNotification.dart';
import '../models/notification/subscription.dart';
import '../models/overtime/overtimeRequest.dart';
import '../models/replace/replaceRequest.dart';
import '../models/response/ApiResponse.dart';
import '../models/response/multiapiResponse.dart';
import '../models/workingday/publicHoliday.dart';
import '../models/workingday/workday.dart';

class ApiService {
  final host =
      "${dotenv.env['API_URL'] ?? 'https://203.176.128.5:5678'}/api/Mobile/";

  Future<MultiApiResponse<LeaveRequest>> fetchLeave(
      int employeeId, String companyId, String? status) async {
    final url = Uri.parse(
        '${host}GetLeaveRequests?id=$employeeId${status != null ? '&status=$status' : ''}');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(responseData,
            (json) => LeaveRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(responseData,
            (json) => LeaveRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return MultiApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
        index: 0,
        pageSize: 0,
        total: 0,
      );
    }
  }

  Future<MultiApiResponse<OvertimeRequest>> fetchOT(
      int employeeId, String companyId, String? status) async {
    final url = Uri.parse(
        '${host}GetOTRequests?id=$employeeId${status != null ? '&status=$status' : ''}');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(responseData,
            (json) => OvertimeRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(responseData,
            (json) => OvertimeRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return MultiApiResponse(
          isSuccess: false,
          message: e.toString(),
          response: null,
          statusCode: 500,
          index: 0,
          pageSize: 0,
          total: 0);
    }
  }

  Future<MultiApiResponse<ReplaceRequest>> fetchReplace(
      int employeeId, String companyId, String? status) async {
    final url = Uri.parse(
        '${host}GetReplaceRequests?id=$employeeId${status != null ? '&status=$status' : ''}');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(responseData,
            (json) => ReplaceRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(responseData,
            (json) => ReplaceRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return MultiApiResponse(
          isSuccess: false,
          message: e.toString(),
          response: null,
          statusCode: 500,
          index: 0,
          pageSize: 0,
          total: 0);
    }
  }

  Future<ApiResponse<MonthlyLeave>> fetchMonthlyLeave(
      int employeeId, String companyId) async {
    final url = Uri.parse('${host}GetMonthlyLeave?id=$employeeId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => MonthlyLeave.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => MonthlyLeave.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<Attendance>> fetchAttendance(
      int employeeId, String companyId, String? date) async {
    final url = Uri.parse(
        '${host}GetAttendance?employeeId=$employeeId${(date == null) ? "" : '&date=$date'}');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        return ApiResponse<Attendance>.fromJson(
          jsonDecode(response.body),
          (json) => Attendance.fromJson(json as Map<String, dynamic>),
        );
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load attendance');
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<MultiApiResponse<Branch>> fetchBranch(
      int employeeId, String companyId) async {
    final url = Uri.parse('${host}GetBranch?id=$employeeId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        return MultiApiResponse<Branch>.fromJson(
          jsonDecode(response.body),
          (json) => Branch.fromJson(json as Map<String, dynamic>),
        );
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load attendance');
      }
    } catch (e) {
      return MultiApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
        total: 0,
        index: 0,
        pageSize: 0,
      );
    }
  }

  Future<MultiApiResponse<WorkDay>> fetchWorkingDay(
      int employeeId, String companyId) async {
    final url = Uri.parse('${host}GetWorkingDay?id=$employeeId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        return MultiApiResponse<WorkDay>.fromJson(
          jsonDecode(response.body),
          (json) => WorkDay.fromJson(json as Map<String, dynamic>),
        );
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load attendance');
      }
    } catch (e) {
      return MultiApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
        total: 0,
        index: 0,
        pageSize: 0,
      );
    }
  }

  Future<MultiApiResponse<PublicHoliday>> fetchHoliday(
      int employeeId, String companyId) async {
    final url = Uri.parse('${host}GetHoliday?id=$employeeId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        return MultiApiResponse<PublicHoliday>.fromJson(
          jsonDecode(response.body),
          (json) => PublicHoliday.fromJson(json as Map<String, dynamic>),
        );
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load attendance');
      }
    } catch (e) {
      return MultiApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
        total: 0,
        index: 0,
        pageSize: 0,
      );
    }
  }

  Future<ApiResponse<Profile>> fetchEmployeeInfo(
      int employeeId, String companyId) async {
    final url = Uri.parse('${host}GetInfo?id=$employeeId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        return ApiResponse<Profile>.fromJson(
          jsonDecode(response.body),
          (json) => Profile.fromJson(json as Map<String, dynamic>),
        );
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load attendance');
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<MultiApiResponse<MemberProfile>> fetchMembers(
      int employeeId, String companyId) async {
    final url = Uri.parse('${host}GetMembers?id=$employeeId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(responseData,
            (json) => MemberProfile.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(responseData,
            (json) => MemberProfile.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return MultiApiResponse(
          isSuccess: false,
          message: e.toString(),
          response: null,
          statusCode: 500,
          index: 0,
          pageSize: 0,
          total: 0);
    }
  }

  Future<ApiResponse<LeaveRequest>> fetchLeaveRequest(
      String requestId, String companyId) async {
    final url = Uri.parse('${host}GetLeaveRequest?id=$requestId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => LeaveRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => LeaveRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<OvertimeRequest>> fetchOTRequest(
      String requestId, String companyId) async {
    final url = Uri.parse('${host}GetOTRequest?id=$requestId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => OvertimeRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => OvertimeRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<ReplaceRequest>> fetchReplaceRequest(
      String requestId, String companyId) async {
    final url = Uri.parse('${host}GetReplaceRequest?id=$requestId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => ReplaceRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => ReplaceRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<String>> cancelReplaceRequest(
      String requestId, String companyId) async {
    final url = Uri.parse('${host}CancelReplaceRequest?id=$requestId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId,
    };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final message = responseData['message'] ?? 'Request succeeded';
        return ApiResponse<String>(
          isSuccess: true,
          message: message,
          response: message,
          statusCode: 200,
        );
      } else {
        final responseData = json.decode(response.body);
        final message = responseData['message'] ?? 'Request failed';
        return ApiResponse<String>(
          isSuccess: false,
          message: message,
          response: message,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse<String>(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<String>> cancelOvertimeRequest(
      String requestId, String companyId) async {
    final url = Uri.parse('${host}CancelOTRequest?id=$requestId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId,
    };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final message = responseData['message'] ?? 'Request succeeded';
        return ApiResponse<String>(
          isSuccess: true,
          message: message,
          response: message,
          statusCode: 200,
        );
      } else {
        final responseData = json.decode(response.body);
        final message = responseData['message'] ?? 'Request failed';
        return ApiResponse<String>(
          isSuccess: false,
          message: message,
          response: message,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse<String>(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<String>> cancelLeaveRequest(
      String requestId, String companyId) async {
    final url = Uri.parse('${host}CancelLeaveRequest?id=$requestId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId,
    };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final message = responseData['message'] ?? 'Request succeeded';
        return ApiResponse<String>(
          isSuccess: true,
          message: message,
          response: message,
          statusCode: 200,
        );
      } else {
        final responseData = json.decode(response.body);
        final message = responseData['message'] ?? 'Request failed';
        return ApiResponse<String>(
          isSuccess: false,
          message: message,
          response: message,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse<String>(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<LeaveRequest>> addLeaveRequest(
      LeaveRequest request, String companyId) async {
    final url = Uri.parse('${host}AddLeaveRequest');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => LeaveRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => LeaveRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<OvertimeRequest>> addOTRequest(
      OvertimeRequest request, String companyId) async {
    final url = Uri.parse('${host}AddOTRequest');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => OvertimeRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => OvertimeRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<ReplaceRequest>> addReplaceRequest(
      ReplaceRequest request, String companyId) async {
    final url = Uri.parse('${host}AddReplaceRequest');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => ReplaceRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => ReplaceRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<Attendance>> addAttendance(
      AttendanceBody request, String companyId) async {
    final url = Uri.parse('${host}AddAttendance');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => Attendance.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => Attendance.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<OvertimeRequest>> addOTCheckIn(
      AttendanceBody request, String companyId) async {
    final url = Uri.parse('${host}AddOTCheckIn');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => OvertimeRequest.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => OvertimeRequest.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<Feedback>> addFeedback(
      Feedback request, String companyId) async {
    final url = Uri.parse('${host}Feedback');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => Feedback.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => Feedback.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<MobileLogin>> fetchMobileLogin(String qrcode) async {
    final url = Uri.parse('${host}Login?qrcode=$qrcode');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => MobileLogin.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData,
            (json) => MobileLogin.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<int>> fetchTotalNotification(
      int employeeId, String companyId) async {
    final url = Uri.parse('${host}GetTotalNotification?employeeId=$employeeId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };

    try {
      final response = await http.get(url, headers: headers);
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(responseData, (json) => json as int);
      } else {
        return ApiResponse.fromJson(responseData, (json) => json as int);
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<MultiApiResponse<EmployeeNotification>> fetchAllNotification(
      int employeeId, String companyId, int? index) async {
    final url = Uri.parse(
        '${host}GetAllNotification?employeeId=$employeeId&index=${index ?? 0}');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(
            responseData,
            (json) =>
                EmployeeNotification.fromJson(json as Map<String, dynamic>));
      } else {
        final responseData = json.decode(response.body);
        return MultiApiResponse.fromJson(
            responseData,
            (json) =>
                EmployeeNotification.fromJson(json as Map<String, dynamic>));
      }
    } catch (e) {
      return MultiApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
        index: 0,
        pageSize: 0,
        total: 0,
      );
    }
  }

  Future<ApiResponse<String>> subscribe(
      Subscription request, String companyId) async {
    final url = Uri.parse('${host}MobileSubscribe');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData, (json) => json as String);
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData, (json) => json as String);
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<String>> updateNotification(
      int employeeId, String notificationId, String companyId) async {
    final url = Uri.parse(
        '${host}UpdateNotification?id=$employeeId&notificationId=$notificationId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };

    try {
      final response = await http.put(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData, (json) => json as String);
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData, (json) => json as String);
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<String>> updateAllNotification(
      int employeeId, String companyId) async {
    final url = Uri.parse('${host}UpdateAllNotification?id=$employeeId');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };

    try {
      final response = await http.put(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData, (json) => json as String);
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData, (json) => json as String);
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }

  Future<ApiResponse<String>> uploadImage(
      Employee request, String companyId) async {
    final url = Uri.parse('${host}UploadImage');
    final headers = {
      'Content-Type': 'application/json',
      'CompanyId': companyId
    };
    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData, (json) => json as String);
      } else {
        final responseData = json.decode(response.body);
        return ApiResponse.fromJson(responseData, (json) => json as String);
      }
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: e.toString(),
        response: null,
        statusCode: 500,
      );
    }
  }
}
