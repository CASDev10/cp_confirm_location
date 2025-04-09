import 'package:cp_confirm_location/modules/dashboard/cubit/current_location/current_location_cubit.dart';
import 'package:cp_confirm_location/modules/dashboard/cubit/geocoding/geocoding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:html' as html;
import '../../../utils/display/display_utils.dart';
import '../cubit/confirm_location/confirm_location_cubit.dart';
import '../cubit/confirm_location/confirm_location_state.dart';
import '../cubit/geocoding/geocoding_cubit.dart';
import '../cubit/order_detail/order_detail_cubit.dart';
import '../cubit/order_detail/order_detail_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String id = '';

  @override
  void initState() {
    super.initState();

    final uri = Uri.parse(html.window.location.href);
    final idParam = uri.queryParameters['id'];

    if (idParam != null && idParam.trim().isNotEmpty) {
      final parsedId = int.tryParse(idParam);
      if (parsedId != null) {
        setState(() {
          id = idParam;
        });

        context.read<OrderDetailCubit>().fetchOrderDetail(parsedId);
      } else {
        context.read<OrderDetailCubit>().emitNoResult(); // if needed
      }
    } else {
      context.read<OrderDetailCubit>().emitNoResult(); // No ID in URL
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Order Summary',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFEF1D26),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<OrderDetailCubit, OrderDetailState>(
        listener: (context, orderDetailState) {
          if (orderDetailState.status == OrderDetailStatus.success) {
            context.read<CurrentLocationCubit>().getCurrentLocationLatLng();
          }
        },
        builder: (context, orderDetailState) {
          if (orderDetailState.status == OrderDetailStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (orderDetailState.status == OrderDetailStatus.error) {
            return Center(child: Text('Error fetching order details'));
          } else if (orderDetailState.status == OrderDetailStatus.noResult) {
            return Center(child: Text('No Order Found'));
          } else if (orderDetailState.status == OrderDetailStatus.success) {
            return BlocConsumer<CurrentLocationCubit, CurrentLocationState>(
              listener: (context, currentLocationState) {
                if (currentLocationState.currentLocationStatus ==
                    CurrentLocationStatus.success) {
                  context.read<GeocodingCubit>().getCurrentLocationLatLng(
                        currentLocationState.lat,
                        currentLocationState.lng,
                      );
                }
                print(
                  "LatLng : ${currentLocationState.lat} , ${currentLocationState.lng}",
                );
              },
              builder: (context, currentLocationState) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth > 600
                                ? 600
                                : constraints.maxWidth,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCard(
                                title: 'Customer Information',
                                children: [
                                  _buildDetailRow(
                                    Icons.person,
                                    'Name:',
                                    orderDetailState
                                        .orderModel!.customer.partyName,
                                  ),
                                  _buildDetailRow(
                                    Icons.phone,
                                    'Mobile:',
                                    orderDetailState
                                        .orderModel!.customer.mobile,
                                  ),
                                ],
                              ),
                              _buildCard(
                                title: 'Invoice Details',
                                children: [
                                  _buildDetailRow(
                                    Icons.receipt,
                                    'Invoice No:',
                                    orderDetailState.orderModel!.invoiceNo
                                        .toString(),
                                  ),
                                  _buildDetailRow(
                                    Icons.calendar_today,
                                    'Date:',
                                    orderDetailState.orderModel!.invoiceDate
                                        .toString(),
                                  ),
                                  _buildDetailRow(
                                    Icons.payment,
                                    'Payment Mode:',
                                    orderDetailState.orderModel!.paymentMode,
                                  ),
                                ],
                              ),
                              _buildCard(
                                title: 'Ordered Items',
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        orderDetailState
                                            .orderModel!.items.length,
                                        (index) {
                                          return _buildItemCard(
                                            orderDetailState.orderModel!
                                                .items[index].quantity
                                                .toString(),
                                            'Quantity: ${orderDetailState.orderModel!.items[index].quantity}',
                                            'Rate: \$${orderDetailState.orderModel!.items[index].rate}',
                                            'Subtotal: \$${orderDetailState.orderModel!.items[index].subTotal}',
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _buildCard(
                                title: 'Charges & Total',
                                children: [
                                  _buildDetailRow(
                                    Icons.local_shipping,
                                    'Delivery Charges:',
                                    '\$${orderDetailState.orderModel!.deliveryCharges}',
                                  ),
                                  _buildDetailRow(
                                    Icons.monetization_on,
                                    'Total Amount:',
                                    '\$${orderDetailState.orderModel!.invoiceTotal}',
                                    isBold: true,
                                  ),
                                ],
                              ),
                              BlocBuilder<GeocodingCubit,
                                  GeocodingLocationState>(
                                builder: (context, geocodingState) {
                                  return _buildCard(
                                    title: 'Delivery Address',
                                    children: [
                                      geocodingState.geocodingStatus ==
                                              GeocodingStatus.success
                                          ? Text(
                                              geocodingState
                                                  .addressEntity.address,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.black87,
                                              ),
                                            )
                                          : Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Lottie.asset(
                                                    'assets/animations/find_location.json',
                                                    width: 150,
                                                    height: 150,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Fetching Address...",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 20),
                              BlocBuilder<GeocodingCubit,
                                  GeocodingLocationState>(
                                builder: (context, geocodingState) {
                                  return geocodingState.geocodingStatus ==
                                          GeocodingStatus.success
                                      ? !orderDetailState
                                              .orderModel!.isLocationUpdate
                                          ? SizedBox(
                                              width: double.infinity,
                                              child: BlocConsumer<
                                                  UpdateLocationCubit,
                                                  UpdateLocationState>(
                                                listener: (
                                                  context,
                                                  updateLocationState,
                                                ) {
                                                  if (updateLocationState
                                                          .status ==
                                                      UpdateLocationStatus
                                                          .loading) {
                                                    DisplayUtils.showLoader();
                                                  }
                                                  if (updateLocationState
                                                          .status ==
                                                      UpdateLocationStatus
                                                          .error) {
                                                    DisplayUtils.removeLoader();
                                                    DisplayUtils.showSnackBar(
                                                      context,
                                                      updateLocationState
                                                          .message,
                                                    );
                                                  }
                                                  if (updateLocationState
                                                          .status ==
                                                      UpdateLocationStatus
                                                          .success) {
                                                    DisplayUtils.removeLoader();
                                                    DisplayUtils.showSnackBar(
                                                      context,
                                                      updateLocationState
                                                          .message,
                                                    );
                                                  }
                                                },
                                                builder: (
                                                  context,
                                                  updateLocationState,
                                                ) {
                                                  return updateLocationState
                                                              .status !=
                                                          UpdateLocationStatus
                                                              .success
                                                      ? ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Color(
                                                              0xFFEF1D26,
                                                            ),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical: 16,
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                12,
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    UpdateLocationCubit>()
                                                                .updateLocation(
                                                                  orderDetailState
                                                                      .orderModel!
                                                                      .invoiceNo,
                                                                  currentLocationState
                                                                      .lat,
                                                                  currentLocationState
                                                                      .lng,
                                                                );
                                                          },
                                                          child: Text(
                                                            'Confirm Location',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox.shrink();
                                                },
                                              ),
                                            )
                                          : SizedBox.shrink()
                                      : SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Fetching order details'));
          }
        },
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEF1D26),
              ),
            ),
            Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFEF1D26), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(
    String item,
    String quantity,
    String rate,
    String subtotal,
  ) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(quantity, style: GoogleFonts.poppins(fontSize: 14)),
            Text(rate, style: GoogleFonts.poppins(fontSize: 14)),
            Text(
              subtotal,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
