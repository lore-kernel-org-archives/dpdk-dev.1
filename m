Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C27F9B5F5
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 09:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98C844042C;
	Wed, 22 Apr 2026 11:19:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 24E4B402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 11:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776849554; x=1808385554;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HeqKZJ7kM50eb+jcr1y0MMeN3663cRzxaCPBk48rgFw=;
 b=Vi+mtDAfLtkrBy8pwCGAYV8JoBQ+3RF6/hMBGqJKTt44ZlG8OLT/cXGb
 fqNnP2uRIfIljAxVRhFniYvsr1lgveBUizcQ5vKfo0xnSmv/uVo6CGc2f
 //dVaIVcitTgvrNsvGXmQBFU+gc1HB1uttcI9D0QlY9K/ZVkDTIBKuZj9
 ZF5prGvPT0fcYngrUlzfkXPd+vVwuGibXMuv+3v2e4GtESrGAvQR6/VJD
 9j7yBi0n76H1f4g0y/Lcrp4ul0DT19ZQyCkrB9/EotYgrP9bnVZ1YjGrH
 6vyDYipkvWRO9l+L6TWYzrPq86izqAodAyPhjczgzMquVpfDTa2GyrrUa g==;
X-CSE-ConnectionGUID: iu0kpE8vRMGzpOENTb2Gwg==
X-CSE-MsgGUID: JL+CiyFmTxqp7+FUYlKH6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="80384770"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="80384770"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 02:19:13 -0700
X-CSE-ConnectionGUID: /Ifk201sSlqCebrsYnUxwQ==
X-CSE-MsgGUID: evnsVHjpTQagtXDXgHkLbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="229130887"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 02:19:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 02:19:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 02:19:13 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.15)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 02:19:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFSMIwJczI8lYuZBKApNy47aFKFVcxcBy3vdxxpfmLgIpkZsqo3+IEEkE1mLBTmL2Pil/j5GSo3XU1Ia3RCzIpvEhPqd57HLCTMpwUjIfWtSq2OIItBtgr1rgqi1CENNWqdAwcUEgHbZl7N200iDmmr5raIia1iY4VoB9MxpRP8rnMOIu9PiyryM2IO+QDFpPN+o7vjtIq+sJIgSRhwE6UKn0tczTphQdEC26F8xl2QIZujpQ1+V1y4WGcT66VmdAoT5LqUjabutAuOQ36ihjxrf2NExEQOHL3uDgbn4qgvQS9wE3O1r/8f2gVKwwW8TUiygF2C/mMcA78pJvtrnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT4qU+cXfsWvxruRP0BrT2ghhkOfuk9bq4MFpwuFP6w=;
 b=OGlN9lOrvU2UZv3GbGiXzsMz2Gj1ORHQrbfQVa3jjOR8fWBFa5fuSpL2Qsmwo6At9DSroaKcbR1/0cYcWrROU4CgNZUbDbah9N8gaBTAjNvrdyicu13t/EBzRuQrDag0rv2DL3b+hDT3zD1jMpduf0uziTUCv+XhKF51hD8zVLrl6dbjOtSnzVkCoiaile+WirM/DNOlsqq37+lv9N4LCY5VsZTIk2Ey1dggu6k5NwFLqJUPrzcpw3lZPgX9LXlTrcKNmQ/5F1puzTEH/o/7QSDMhF5okMzdvVuRMR2RnYcwrF6eUkePCxtl5nzgBvKfZQ7Hbvq2R/FkllyGq6zwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by IA0PR11MB7282.namprd11.prod.outlook.com
 (2603:10b6:208:43a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:19:04 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d%6]) with mapi id 15.20.9846.012; Wed, 22 Apr 2026
 09:19:04 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 1/3] net/iavf: support LLDP Tx via mbuf ptype or
 dynfield
Thread-Topic: [PATCH v3 1/3] net/iavf: support LLDP Tx via mbuf ptype or
 dynfield
Thread-Index: AQHczlIhckB6/8B+ykKcbMFuYn+ax7XjFVkAgAe/rtA=
Date: Wed, 22 Apr 2026 09:19:04 +0000
Message-ID: <DM3PPF7D18F34A166EFA460B662BCF58D118E2D2@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260306115214.467033-1-ciara.loftus@intel.com>
 <20260417100804.1143121-1-ciara.loftus@intel.com>
 <20260417100804.1143121-2-ciara.loftus@intel.com>
 <aeISHrR7qdHJSNh0@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aeISHrR7qdHJSNh0@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|IA0PR11MB7282:EE_
x-ms-office365-filtering-correlation-id: 73b26700-0863-4088-1ad5-08dea05032d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: nmcuL5M3Yk0c4GhMOtgO1jkPG55zzD9AG3mU2TRG3TQiKtS3mm7FlNI2Lr6G03BRBoTDQUDioRzDfZcjWJajFj1FNjScdnQtx6rV5oBFgu6UZ4mtmhEGPEP2IafKeWWtMp391WPeC2JoaAvn6bfrS5Ii20sXAgxHweRyC5qWYO/riV/5nB0izcDHcbPnmQMeuc49Ft+7ihynRB8QzeMx0RUgmzl9SidohorPxOoBTVWTl1Nt16gVGn+ZjsZg8gASFO0uJv/sPrDypfzkKPznpK2CRtlfs0f3EgwC+CuY+UTAYvtK1GrQ0UNT1Kpwa4wv+Y+4ByizTDv1P0kJhMKXRL5aS5GCq3EkiczQSD8YubsL9jUpDSe9Jh5vUc5BVnQL4lDKuJQilsidALtpJ7HKszcN7H/FqcmCuDPyqOwmJZwKB4qaLQnHg0w48GCna7k9GlUiKjKI3XgreUaS8QpzHNWzfyWQjfzT7PA4IxLwbG/tJoxb7fi1ts7/unDD+OTpjWvmmvMgyFluH/s6rDyte8MrffHLl8Jsvvn9f1xzG+aCd7x2SVDHHPU4X/ndEKDxaxbCU1DCqKKwu5ZitirUgzKigcLIhAbgb+ra9ZDO2fn9Hb0CVYHcP8oz6dHioLIt7KrpPcrKR9z7zBv0LZjrI+3SPQm29jNddROTk1XFyRiPgP3E5Gyo6j6ZR6tR+LvTIV9pULketjRNdxZ7XPBVZVd/jkl5urYYRzxzntp62ve2X/7l3RQY0JMyfP2/85qUqX0Axq2Hjh+/1Etqe4/KMe2JIYEexEvv0AaTvFNCwyA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tuy4dhqzH8ocevZc/6UXZq/Dnc4NVIBVKoQ3f/KSzvZXWaYXMc2Uyntx2QdE?=
 =?us-ascii?Q?0Lh494lemPbtKy7zl32hCCRaKpZtYIndhnO6xAymqm3Lc+KuzsfLmrXqf4uh?=
 =?us-ascii?Q?vWvqOZUlhkKvr811YBSaTa6mHZtJt6Hyc/94dZ0H3GWC5y0Jh4Q/saow3E1J?=
 =?us-ascii?Q?G8bcPwa5WpvUXoKBzcEhgobT711X7HTTGbTb+ujYZUn5ty23kkBTOhNSl9cL?=
 =?us-ascii?Q?8O3++mCJOh5CuhAQcrIneMOtZXj5yPoULI1h3PFcPqmyu4O+qAj+B+rQFlhV?=
 =?us-ascii?Q?QCJptv6uu6ibN+MGqUQaWd1kuXw2TLp1eH0EZEk53MuAVAyuf4xD30F5VBX/?=
 =?us-ascii?Q?cW7w1dMnHnvbiWxXN7c3/UsP42g17eAQmLSQuGi4pRd37eaaV0EKyc9lDwQt?=
 =?us-ascii?Q?wR0XFzUxBXC159pVFIO/ULaQogk/HQ9YRFRUgQZv9qolXfhTQCzXzoibYeqg?=
 =?us-ascii?Q?ixtDNkAVOg/Jig2GUrpCC41jElkOW8qsUia2a62q8iUyTsOawRzyMuYqkbgd?=
 =?us-ascii?Q?aNkVvkXibBA8ojzKfHDMy/42/zLOYynU7eYvkZqKox2NLXP5XBRivDTHEtXl?=
 =?us-ascii?Q?2ADOdbTffpPBGYeADXlznMIlnF+9zDhb9uwUL5po+5eoPz8BWjQ6RbrYGZ+k?=
 =?us-ascii?Q?24ePCBvmmICSFiXf7/0cUbqpcHJhIMwmyv/pHu4zO0Svw9Ul7XRWEGT2JWx8?=
 =?us-ascii?Q?g2XoA0CnEePsjRtn/CMbeDsFtyn2yhr7xjOLdk4U8+wtlkbOmmOBoNTdg9NI?=
 =?us-ascii?Q?5icOfudl/ArQnhuH5wEM9DchjqQ6RmFtIZKfqEddPAhfJefsEZRojG2KHYo5?=
 =?us-ascii?Q?99YOMT7XE/uNCOH+KLD4lckZnd6whDxR8soqSvhkg0lj9DN0RYfmHqHTb4UW?=
 =?us-ascii?Q?HRPxKAQXO3MghDa1NKf/aR9Z0T3THDA0UMWx6EXKS6vO83FbANxFnL+HYQ6l?=
 =?us-ascii?Q?g3I1EOy104SbZGovritv3sVx8TDOa57pb10yHnXVIaV4sbuG4ltMMHGN7B7J?=
 =?us-ascii?Q?sSYjkr1Uw1wGkrbCpKiFHSGB1L0DuAi10RyHhzPSnqsK53Ioy1Tu3LzuTJee?=
 =?us-ascii?Q?HyKtQhZvA/HDIP5F6C3lYLFfLYJNNlHGwBkLmmz0kBqIVpTAAXCQguOCmTxu?=
 =?us-ascii?Q?a1LId4OcQRiARME9GlBRvA+nFacVjhlugaHUf02lFCa6p7iNzThij4+B7Yyj?=
 =?us-ascii?Q?M0ssgwfmm9pxJT+uuhifcXnlN3HUYWpzPmkkkx4mMkkn+yl2G2pgTMbqicrp?=
 =?us-ascii?Q?dJ1BQEaKjJVdU8PAhXqCVKiQgcC1ut+uoDw3+2knm3zvfzz//VvjNd4FtiVf?=
 =?us-ascii?Q?07WX5Aov7tPT38cuBDU1sqM7jslRjurM5P/4twGvbGroMigKVr32qvLylkw3?=
 =?us-ascii?Q?hE7UU3Tk3Me/YrnXADwcQE1lqj11V4NWQCYyoZZUXBHEZuQAfTmgfvu+kTo8?=
 =?us-ascii?Q?6qsKjlADQ911LCcnN42Sl2vwSoBukMBmhb3cBJCfZ4A1am+vrby+rKYCely+?=
 =?us-ascii?Q?RwFdjj/g+9NEnCRnGWei1O/aJrhqfBkHGvOD/aVgzSo9JnnQ46mpu7yLS0lW?=
 =?us-ascii?Q?nOWFLG0A58TsgRltO4ed2X1R20TZlHCuELc7FNFa6D58zCH5j5h8PX6DuRqt?=
 =?us-ascii?Q?loOUVPyz+5sZyRNNcNBx/zRoDGYLHk8TYYX9g5fQwj5Z64CPcG+LN/s3z713?=
 =?us-ascii?Q?4Nis/UvbLdUcyuV+ajPft4Cho5HrbIftJa5gPh3a1pVpxvlSnUuodRstkMZ7?=
 =?us-ascii?Q?RyhgB5SDLg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KwTR4znTLIB6zWvrOUhvNDKnRUPken7heaXQke1slI6dijco3ZYQduilUJvlOUbHoJSGxiFjgYyAN5lw765xhBE1XrxM9TYY17gec8odGmXgAMuYFxXaKBXrDfCrC+LFc5ToyiWL6thSGki8UCemtsRXnY1iKccbYV2BhGL6uwQ6PQwUOqliOI2xrdaNOR/utt49Z/hPcJEV5rwwm6vLSvD1JYsJTM3B7VVIcZg3Gv9Xq41+6d+v2RsT3wLXwVMBvlIzPJrFo3FnpWlvdYZunThdypFFK9bjMVvlCoTiOwJgH5J8wg2yrVlmLsR+1QSRFd/VDi4xSzuje9E7skvshQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b26700-0863-4088-1ad5-08dea05032d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 09:19:04.3366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiSYG8+mkDWcyOwCTvb74mKNMFCvYHT+00ZcU0hVC2qhSd3Nc/CYkndY6oBGo0aJxA8HRsEAT8LH/fokEv5NVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

> > @@ -688,6 +690,15 @@ Usage::
> >
> >      testpmd> set tx lldp on
> >
> > +An alternative method for transmitting LLDP packets is to set the
> ``packet_type`` of
> > +the mbuf to ``RTE_PTYPE_L2_ETHER_LLDP``. This, in conjunction with
> enabling the
> > +``enable_ptype_lldp`` devarg will cause such packets to be transmitted=
::
> > +
> > +    -a 0000:xx:xx.x,enable_ptype_lldp=3D1
> > +
> > +When ``enable_ptype_lldp`` is not set (default), ptype-based LLDP dete=
ction
> is
> > +disabled, but LLDP transmission via the dynamic mbuf field remains
> available.
> > +
>=20
> The previous method describes testpmd use. Do we need such a description
> here too?
>=20
> >

The ptype method doesn't require any specific enabling steps in testpmd, it=
 is
enabled only via the devarg. I've updated the documentation to make that
clearer.
