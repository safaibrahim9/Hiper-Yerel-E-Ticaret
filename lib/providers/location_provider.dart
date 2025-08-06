import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class LocationProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasPermission = false;
  Position? _currentPosition;
  String? _currentAddress;
  String? _selectedNeighborhood;

  // Getters
  bool get isLoading => _isLoading;
  bool get hasPermission => _hasPermission;
  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;
  String? get selectedNeighborhood => _selectedNeighborhood;

  // TODO: Initialize location services
  Future<void> initializeLocation() async {
    _setLoading(true);
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      
      if (permission == LocationPermission.whileInUse || 
          permission == LocationPermission.always) {
        _hasPermission = true;
        
        // Load saved location
        await _loadSavedLocation();
        
        // Get current location
        await getCurrentLocation();
      } else {
        _hasPermission = false;
        debugPrint('Location permission denied');
      }
    } catch (e) {
      debugPrint('Location initialization error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // TODO: Get current location
  Future<void> getCurrentLocation() async {
    if (!_hasPermission) return;
    
    _setLoading(true);
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      // Get address from coordinates
      await _getAddressFromPosition();
      
      // Save location
      await _saveLocation();
      
      notifyListeners();
    } catch (e) {
      debugPrint('Get current location error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // TODO: Get address from position
  Future<void> _getAddressFromPosition() async {
    if (_currentPosition == null) return;
    
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _currentAddress = '${place.street}, ${place.subLocality}, ${place.locality}';
        
        // Set neighborhood if available
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          _selectedNeighborhood = place.subLocality;
        }
      }
    } catch (e) {
      debugPrint('Get address error: $e');
    }
  }

  // TODO: Set neighborhood manually
  Future<void> setNeighborhood(String neighborhood) async {
    _selectedNeighborhood = neighborhood;
    await _saveLocation();
    notifyListeners();
  }

  // TODO: Save location to local storage
  Future<void> _saveLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (_currentPosition != null) {
        await prefs.setDouble('latitude', _currentPosition!.latitude);
        await prefs.setDouble('longitude', _currentPosition!.longitude);
      }
      
      if (_currentAddress != null) {
        await prefs.setString('address', _currentAddress!);
      }
      
      if (_selectedNeighborhood != null) {
        await prefs.setString('neighborhood', _selectedNeighborhood!);
      }
    } catch (e) {
      debugPrint('Save location error: $e');
    }
  }

  // TODO: Load saved location from local storage
  Future<void> _loadSavedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final latitude = prefs.getDouble('latitude');
      final longitude = prefs.getDouble('longitude');
      
      if (latitude != null && longitude != null) {
        _currentPosition = Position(
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
        );
      }
      
      _currentAddress = prefs.getString('address');
      _selectedNeighborhood = prefs.getString('neighborhood');
      
      notifyListeners();
    } catch (e) {
      debugPrint('Load saved location error: $e');
    }
  }

  // TODO: Check if location is near business
  bool isNearBusiness(double businessLat, double businessLng, {double maxDistance = 5000}) {
    if (_currentPosition == null) return false;
    
    double distance = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      businessLat,
      businessLng,
    );
    
    return distance <= maxDistance; // 5km default
  }

  // TODO: Get distance to business
  double getDistanceToBusiness(double businessLat, double businessLng) {
    if (_currentPosition == null) return double.infinity;
    
    return Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      businessLat,
      businessLng,
    );
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
} 