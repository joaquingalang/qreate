import 'package:flutter/material.dart';
import 'package:qreate/utils/constants.dart';

enum Logos {
  none,
  upload,
  facebook,
  instagram,
  linkedin,
  x,
  youtube,
  tiktok,
  pinterest,
  shopify,
  gcash,
  github
}

Map<Logos, dynamic> logoImages = {
  Logos.none: Icon(
    Icons.not_interested,
    color: kGrayColor300,
    size: 20,
  ),
  Logos.upload: Icon(
    Icons.upload,
    color: kGrayColor300,
    size: 20,
  ),
  Logos.facebook: Image.asset(
    'assets/images/icons/facebook_icon.png',
    height: 30,
  ),
  Logos.instagram: Image.asset(
    'assets/images/icons/instagram_icon.png',
    height: 30,
  ),
  Logos.linkedin: Image.asset(
    'assets/images/icons/linkedin_icon.png',
    height: 30,
  ),
  Logos.x: Image.asset(
    'assets/images/icons/x_icon.png',
    height: 30,
  ),
  Logos.youtube: Image.asset(
    'assets/images/icons/youtube_icon.png',
    height: 30,
  ),
  Logos.tiktok: Image.asset(
    'assets/images/icons/tiktok_icon.png',
    height: 30,
  ),
  Logos.pinterest: Image.asset(
    'assets/images/icons/pinterest_icon.png',
    height: 30,
  ),
  Logos.shopify: Image.asset(
    'assets/images/icons/shopify_icon.png',
    height: 30,
  ),
  Logos.gcash: Image.asset(
    'assets/images/icons/gcash_icon.png',
    height: 30,
  ),
  Logos.github: Image.asset(
    'assets/images/icons/github_icon.png',
    height: 30,
  ),
};

Map<Logos, dynamic> logoSource = {
  Logos.none: '',
  Logos.upload: '',
  Logos.facebook: 'assets/images/icons/facebook_icon.png',
  Logos.instagram: 'assets/images/icons/instagram_icon.png',
  Logos.linkedin: 'assets/images/icons/linkedin_icon.png',
  Logos.x: 'assets/images/icons/x_icon.png',
  Logos.youtube:'assets/images/icons/youtube_icon.png',
  Logos.tiktok: 'assets/images/icons/tiktok_icon.png',
  Logos.pinterest: 'assets/images/icons/pinterest_icon.png',
  Logos.shopify: 'assets/images/icons/shopify_icon.png',
  Logos.gcash: 'assets/images/icons/gcash_icon.png',
  Logos.github: 'assets/images/icons/github_icon.png',
};
