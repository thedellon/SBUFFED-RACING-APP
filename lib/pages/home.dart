import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'driver_detail.dart';
import 'events.dart'; // Import the Events page
import 'championship.dart'; // Import the Championship page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // All data will be refreshed from this function
  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.black,
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: const Color(0xFFBFAF00),
        height: 50,
        backgroundColor: Colors.black,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const DriverCard(
              firstName: 'Julian',
              lastName: 'Nelson',
              pos: '01',
              pts: '40',
              driverImagePath: 'assets/images/drivers/julian_nelson.png',
              teamColor: '#F7DA1B',
              teamImagePath: 'assets/images/constructors/renault.png',
              driverNumber: '1  ',
            ),
            const SectionRow(
              title: 'Upcoming Race',
              showSeeMore: false, // Hide "See more"
            ),
            TrackInfoCard(
              raceName: 'Serapi Grand Prix',
              trackName: 'SERAPI BORNEO RACE TRACK',
              location: 'MY',
              raceDate: DateTime(2024, 9, 7),
            ),
            SectionRow(
              title: 'Standings',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChampionshipPage()),
              ),
              showSeeMore: true, // Show "See more"
            ),
            const StandingsCard(
              title: 'Card Title 3',
              description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent, // Border color
            width: 0.0,        // Border width
          ),
        ),
        child: Image.asset(
          'assets/images/app_logo/sbuffed_logo.png',
          width: 100, // Adjust width as needed
          height: 40, // Adjust height as needed
          fit: BoxFit.contain, // Adjust fit as needed
        ),
      ),
      backgroundColor: Colors.black,
      elevation: 0.0,
      centerTitle: true,
      scrolledUnderElevation: 0.0,
    );
  }
}

class StandingsCard extends StatelessWidget {
  final String title;
  final String description;

  const StandingsCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 29, 29, 29),
      child: SizedBox(
        height: 245.0,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}

class SectionRow extends StatelessWidget {
  final String title;
  final VoidCallback? onTap; // Nullable, as it might not be provided
  final bool showSeeMore;    // New parameter to control visibility of "See more"

  const SectionRow({
    super.key,
    required this.title,
    this.onTap,
    this.showSeeMore = true, // Defaults to true
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          if (showSeeMore && onTap != null) // Show only if showSeeMore is true and onTap is provided
            GestureDetector(
              onTap: onTap,
              child: const Text(
                'See more',
                style: TextStyle(
                    color: Color(0xFFBFAF00), // Slightly dark yellow
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}


class DriverCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String pos;
  final String pts;
  final String driverImagePath;
  final String teamColor;
  final String teamImagePath;
  final String driverNumber;

  const DriverCard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.pos,
    required this.pts,
    required this.driverImagePath,
    required this.teamColor,
    required this.teamImagePath,
    required this.driverNumber,
  });

  @override
  Widget build(BuildContext context) {
    final Color customColor = _hexToColor(teamColor);

    return Card(
      color: const Color(0xFF0D0D0D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: SizedBox(
        height: 245.0,
        child: Stack(
          children: [
            _buildDriverNumber(),       // Bottom-most layer
            _buildDriverInfo(customColor),
            _buildGradientBackground(customColor),
            _buildDriverImage(),
            _buildOverlayCard(),
            _buildPositionAndPoints(),
            _buildViewDetailsButton(context), // Top-most layer
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayCard() {
    return Positioned(
      top: 130,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF060606), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.transparent,        // Red border color
            width: 0.0,               // Border width
          ),
        ),
      ),
    );
  }

  Widget _buildGradientBackground(Color customColor) {
    return Positioned(
      top: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 450,
          height: 450,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [customColor.withOpacity(0.05), Colors.transparent],
              radius: 0.85,
              center: const Alignment(1.0, -1.0),
              focal: const Alignment(1.0, -1.0),
              focalRadius: 0.1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDriverNumber() {
    final Color teamColorFill = _hexToColor(teamColor).withOpacity(0.2);

    return Positioned(
      bottom: -25,
      right: -10,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Stack(
            children: [
              // Stroke feature on driver number have overlapping strokes (fix required)
              // Text(
              //   driverNumber,
              //   style: TextStyle(
              //     fontSize: 205,
              //     fontWeight: FontWeight.w900,
              //     foreground: Paint()
              //       ..style = PaintingStyle.stroke
              //       ..strokeWidth = 5
              //       ..color = _hexToColor(teamColor).withOpacity(1.0),
              //     height: 1,
              //   ),
              // ),
              Text(
                driverNumber,
                style: TextStyle(
                  fontSize: 220, // Slightly smaller font size for fill
                  fontWeight: FontWeight.w900,
                  color: teamColorFill,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDriverImage() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: 210,
        height: 210,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            driverImagePath,
            width: 100,
            height: 100,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildDriverInfo(Color customColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTeamLogo(),
          const SizedBox(width: 16.0),
          _buildDriverName(customColor),
        ],
      ),
    );
  }

  Widget _buildTeamLogo() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      width: 50,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.asset(
          teamImagePath,
          width: 50,
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildDriverName(Color customColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          firstName,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          lastName,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: customColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPositionAndPoints() {
    return Positioned(
      left: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 6.0),
        child: Row(
          children: [
            _buildInfoColumn('Pos', pos),
            const SizedBox(width: 25.0),
            _buildInfoColumn('Pts', pts),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildViewDetailsButton(BuildContext context) {
    return Positioned(
      bottom: 13,
      right: -20,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: Size.zero, // No minimum size
          padding: EdgeInsets.zero, // No padding
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink wrap to content
          overlayColor: Colors.transparent, // No overlay color
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DriverDetail(
                firstName: firstName,
                lastName: lastName,
                pos: pos,
                pts: pts,
                driverImagePath: driverImagePath,
                teamColor: teamColor,
                teamImagePath: teamImagePath,
                driverNumber: driverNumber,
              ),
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'View Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 0), // Adjust the offset as needed
              child: Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(1.0), // Full opacity
              ),
            ),
            Transform.translate(
              offset: const Offset(-15, 0), // Adjust the offset as needed
              child: Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.7), // 70% opacity
              ),
            ),
            Transform.translate(
              offset: const Offset(-30, 0), // Adjust the offset as needed
              child: Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.5), // 50% opacity
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _hexToColor(String teamColor) {
    teamColor = teamColor.replaceAll("#", "");
    return Color(int.parse("FF$teamColor", radix: 16));
  }
}

class TrackInfoCard extends StatelessWidget {
  final String raceName;
  final String trackName;
  final String location;
  final DateTime raceDate;

  const TrackInfoCard({
    super.key,
    required this.raceName,
    required this.trackName,
    required this.location,
    required this.raceDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventsPage()),
        );
      },
      child: Card(
        color: const Color(0xFF0D0D0D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: SizedBox(
          height: 245.0,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), // Same as the card's border radius
                  child: Image.asset(
                    'assets/images/misc/background1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildOverlayCard(),  // Add the overlay on top of the image
              _buildTrackInfo(),
              _buildRaceDate(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildOverlayCard() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF060606).withOpacity(0.7),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.transparent, // Transparent border color
            width: 0.0,                // Border width
          ),
        ),
      ),
    );
  }


  Widget _buildTrackInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrackNameAndLocation(),
        ],
      ),
    );
  }

  Widget _buildRaceDate() {
    return Positioned(
      left: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 13.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Color(0xFFF7DA1B), // Yellow border color
                    width: 2.0, // Border thickness
                  ),
                ),
              ),
              padding: const EdgeInsets.only(left: 12.0), // Left padding only
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    raceDate.day.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      fontSize: 36,
                      color: Color(0xFFF7DA1B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${_getMonthAbbreviation(raceDate.month)} ${raceDate.year.toString().substring(2)}'",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackNameAndLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CountryFlag.fromCountryCode(
              location,
              width: 25,
              height: 15,
            ),
            const SizedBox(width: 10.0),
            Text(
              raceName,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Container(
          constraints: const BoxConstraints(
            maxWidth: 300.0, // Adjust the maxWidth as needed
          ),
          child: Text(
            trackName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }


  String _getMonthAbbreviation(int month) {
    const monthNames = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month];
  }
}
