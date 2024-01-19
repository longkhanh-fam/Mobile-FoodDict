// Routes constants
import 'package:flutter/material.dart';
import 'package:fooderapp/config/colors/colors.dart';

const String baseUrl = 'http://192.168.122.1:3001/';

const String homePage = '/';
const String loginPage = '/login';
const String errorPage = 'error/';
const String albumDetailsPage = 'albumDetailsPage/';
const String profilePage = 'profilePage/';

// Home Page constants

// Icon Constants
const Icon downloadIcon = Icon(
  Icons.download_for_offline,
  size: 35,
  color: secondaryColor,
);
const Icon favouriteIcon = Icon(
  Icons.favorite,
  size: 35,
  color: secondaryColor,
);
Icon moreIcon = Icon(
  Icons.more_horiz_rounded,
  size: 35,
  color: greyColor,
);
Icon shuffleIcon = Icon(
  Icons.shuffle,
  size: 35,
  color: greyColor,
);
const Icon playIcon = Icon(
  Icons.play_circle,
  size: 55,
  color: secondaryColor,
);

// Small icons
const Icon downloadIconSmall = Icon(
  Icons.download_for_offline,
  size: 20,
  color: secondaryColor,
);
const Icon dotIcon = Icon(
  Icons.circle,
  size: 8,
);
