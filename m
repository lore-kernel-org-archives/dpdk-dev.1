Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7963AC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 09:42:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D6054028B;
	Wed, 19 Feb 2025 10:42:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 74C904025A;
 Wed, 19 Feb 2025 10:42:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739958133; x=1771494133;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/2jAan3tPMqXpSvkBeMD0opwpSiGDgxkUIKk+85rdg8=;
 b=JLhngwDTY1FhMYh5nrZJJDslJ9oRCZ3qUky+aeBUsrnVBrlH2ww6Alj1
 UFIMucxD+cMcHtSdFRzS5yDOufznt+YBImLBFX/uqW65UNXM2qW/8srgy
 2hGSjEU6Y7Fiba7SljHg9wT8mRk8mWfILUqP0e6QTSuoUcp0pEAOaeHqb
 uG2LnFcm35u4NY2Q1D5F0QXg89HFq8UJq6Bmi9OGlVjjtGisaYc2NdeWx
 NRtI4/TzdZRO0TEWdDdErfzlHKsAPGJEBporUAD9/Zbu5XvYBjJubRwwC
 pYCKkHGqph92oAIAGws3OrqYrL+EfAzIspstOTZMHZdrQR23OcbHDsncS A==;
X-CSE-ConnectionGUID: oRRcoIg/Sgao7IhA5GIqmw==
X-CSE-MsgGUID: MXTMubvqRaWX/LA3MQ6Z/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39875722"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="39875722"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 01:41:54 -0800
X-CSE-ConnectionGUID: X/HEJi+BSWKe9hU1rDqMJQ==
X-CSE-MsgGUID: 16TlAfnwRMGRztnf7ed9/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119309325"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 01:41:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 01:41:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 01:41:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 01:41:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTvFYn994P3LmnQFbJ9OWrclo/qPBj9xFoJc/tx7wWyXzwTZt1YiaG0il3uDqfVIT+zfePouAcuZEOwW3mQUlO/lBcrR0UqSSqvPTC6MmCP3lBtRPAnqoS7/oq+fShM9Tpt7KICVypsZAdPibfdtRV7q2vugRk7WbzmgeUGQjCNw6MaRHRj1YJC6BJhVpK6ogmD5nBHR+qrrqf0L9aA5MtAg8jX3jDedJJ7+pl1FjaeIZ6Gq2XMOicsmiyVsZnXxhqeYa5D1pHZB4d1BTDAtR6mGbCtGLcmabZQRZORuL2MhcDwc8L671p6o1srn0VRychANDNtNBhsBNBxlGg0I2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNJLBVLM2o9+5VRbffkSmeDba2mjmD2hIYYsXg9LDXY=;
 b=oUa8W+vuD+/18w0RPO4zi7KTHWOFvZzhNu95Gc5kknu51RR7qkBiA64qUaYQkZ5/+h61CQ3RvtGfS9HXV6F+8s0vgrxt2phpJ+WrncKgq0YRzq/ROO+5FDx9z47C9Z/uUBa2bzXbms6WcqfKWjdXWhp74YvuBuYjFOiydpDKbnxEdv8gqPesPltshld2kwS+A+UBFYrBw7gt4tJZWwVbI1u03cNrlJgkwtPzwiTGXbg3MhppCWOffB2hZI4wuPtDRL5LkTA+oP78ehOkj+88uafyk4Ud3bVcmO7DxHDl6E+XpigPHyl6oqu4U8F1oixVuuKzCw+GWOtKQAZeXHJOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6)
 by MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 09:41:45 +0000
Received: from SJ0PR11MB5056.namprd11.prod.outlook.com
 ([fe80::4f35:279e:a725:ad08]) by SJ0PR11MB5056.namprd11.prod.outlook.com
 ([fe80::4f35:279e:a725:ad08%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 09:41:45 +0000
From: "Dooley, Brian" <brian.dooley@intel.com>
To: "Kusztal, ArkadiuszX" <arkadiuszx.kusztal@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "gakhil@marvell.com" <gakhil@marvell.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] common/qat: fix incorrect size in the parser
Thread-Topic: [PATCH] common/qat: fix incorrect size in the parser
Thread-Index: AQHbeUbii8z0LRIcNU2gkhfcC8IVprNOckDg
Date: Wed, 19 Feb 2025 09:41:45 +0000
Message-ID: <SJ0PR11MB50561E0071918CAB0166FE7B83C52@SJ0PR11MB5056.namprd11.prod.outlook.com>
References: <20250207095832.4032332-1-arkadiuszx.kusztal@intel.com>
In-Reply-To: <20250207095832.4032332-1-arkadiuszx.kusztal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5056:EE_|MW3PR11MB4763:EE_
x-ms-office365-filtering-correlation-id: f913cb76-fb12-4dd6-e778-08dd50c99fdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?D4M3Oy+9LhFdltwK9vviWwCYjkJDSkFqZlWJIGGp9xi4BvIGBBRPeh7/2NF1?=
 =?us-ascii?Q?7tTdGAMlGFy+z/M7fY3dPUPid5yB+CzmqWzWVLptvDS8GCCeXentti448yUP?=
 =?us-ascii?Q?mtgIZMqFWmnkRCGxTP+xd/VyBsgRv6Wf6N/lRCbWBNWIMQ4tXwOy3QGrnniv?=
 =?us-ascii?Q?w5Y9zeQiyyImldDw2V07fJOvnS6Wy/loM09Jnc2h8M9wCNE6OfPxcl+RVVzr?=
 =?us-ascii?Q?VZcbLy6F9ha/dP3pFu/n5n9S0kaJKJIIykWvBLXlG6wwc8RsqTU+tFdEeKJd?=
 =?us-ascii?Q?3K0g+GFZP7m7H4jxuaRl7b5Zt+AMghTIGuyDZEBEooWY0fCN4SBHqDVWGekv?=
 =?us-ascii?Q?Nj4m7Ch6dKdJzy+naat5w0sNPvTDsY3n3NkjMQV8XBMY5gz+E4cIvcDm3Vwo?=
 =?us-ascii?Q?01Ip6gv7Ev3JrTiivlAfEWTi3uPlzlgnLEPhkS4rLsvGGsSPF8YuzSUNStE7?=
 =?us-ascii?Q?MLPwcBlNsTt2g1RQzQzTjDYrFX+Qq/IO+sUGduHES71yCim37A9KpBYTn/5y?=
 =?us-ascii?Q?VDihRvBe34wL430iZOZa8ljwUCiDfbgNyRBKgnbi2r2qBAs0tWI0sbAw3ACh?=
 =?us-ascii?Q?x498aj5tvUeU03Uqc+kEeU1PQFhS7gKF3ZitcHBjtnvnU7cPS7MXHVULiJPS?=
 =?us-ascii?Q?LTfw2JuHlPj2/EdDt1htFiH8GO0q9e6PiRC4QZd3QR++cmvQcr71PGIIzBUO?=
 =?us-ascii?Q?NSLuCuqhoiKImfC9zgJ6ejLTkF9lT593P/7FL8lqjM11qP4SEdtZOQZFYfPV?=
 =?us-ascii?Q?TIBxuYLNXZ2Gp72Zznujws7PV07Hq7H+H1qaEr2uDi09AFUUI99g6UgcADbJ?=
 =?us-ascii?Q?ZDrzRRHxa8QvAvosPKwlRaImoMUfppvjRlWze/n16CVlz65+VgHbwZv7e+Hq?=
 =?us-ascii?Q?mjrR3xo9izfmHU2lQzmNZpwHF+jFS1+VFw7a+9WquHcUNLNR0dXT9bqrztNB?=
 =?us-ascii?Q?FVmw4bfpLPN4uaWjAEIgqBclZDrBMCCULz7vkIYDbBZz6amtPM84YfZyC0EK?=
 =?us-ascii?Q?aIir0RWohEIw800OU27txvzFL13XOOpN25HOxGzZJuE4wFa5Y4WhhHm10yTK?=
 =?us-ascii?Q?D+I5ipmGnM3vMEF5tgoPYfAEHUQUzT4MHrGRanCMTgHchJfaeFrRjCCaKkdb?=
 =?us-ascii?Q?sxoaHs3lF0dqD991sEO2o8DknkpT+xSqtGufkEp9X9/DOmNSnR0bOyNdlzrI?=
 =?us-ascii?Q?xDGOYOE2d5X/rQbWbMZV4nAlWBdx506mgg//dwmRozHv2HYJ6gW7gtLiLapH?=
 =?us-ascii?Q?xwYHrrU7NGVypc48mx7mutwoPNaCwRF22Zs6eAzWlacT5a1ZXB2iPzFNRzR1?=
 =?us-ascii?Q?Rz4o2YCKGKzl181cG+kHG/AuTiUYl0oA20tthQReB5CIOIGJdPVj+3+We3EW?=
 =?us-ascii?Q?VWEZwhDC5XEUkoYp3ayL6LhTb9UrGxIBjb7XThjDtfV+iT3WD9etdhQ8R4Kr?=
 =?us-ascii?Q?nx5S8fXo9bXFtjMQe8ueWrHBxeYZos+I?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5056.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yTlEdiT+0xZBb4Cgh8rqRM0HdnRzoGPSoquSEiH7L7Hc4rmPS/C1m65M2fJR?=
 =?us-ascii?Q?dwfs00caMvONsA/ir2yd45U6JSKdDGwD2nLUYaMm0N7dgwSyp243sG6QSkn1?=
 =?us-ascii?Q?j752DfRhcbFuX1G6d9CGFPs8fE6Z/R5WrHMFNupYV+2bzOZPkAEtAFQijwZl?=
 =?us-ascii?Q?Rzx7vpeybUwUen8Mk1iyP4Jz32WAHFNRHnD4iLPOXy7YBuMNO+5SQMlN11J9?=
 =?us-ascii?Q?6HYQLIwePf1Eqc3IJYaWZaAA5nr458uxq3QoMFdlkqNVeWMkzrInFCY9ysZ/?=
 =?us-ascii?Q?lEQMFRgW7xESKBHH4MC/JcNOA5YFQ6yMKHNQZ0wG7i6gm4hv80Ti9tyaljDx?=
 =?us-ascii?Q?0PTFXamy7JfSp7/BARI+lzIxtixDHxLsQJutmWEnDQd5g4BKrBu1o7/7RzFs?=
 =?us-ascii?Q?z8jSIPZu3X2g7m+Z4UIrL5U6LdTaTx+wcXcyxSMI4tmuB8P1Y0bRL7SrERJs?=
 =?us-ascii?Q?Yp6IlpAk8fFRti6VEImyJz6z5TWAtL07Q0LsIPblHKfLVSCXjtX0zbnrslTA?=
 =?us-ascii?Q?d2SufCqREm3bxIFJfC4B/jTJ0GHB9IQXUE0ZnP8TiSyboLO7aB9obrd+F40f?=
 =?us-ascii?Q?dMpMQlwuDWrC+GOszXL+5PnipZqjgxTFgUkRbO9UPhXuIpiiIeRcoJKoDSM5?=
 =?us-ascii?Q?URu2WrmaNjD0OQHcXR8dc83WmhZyyk1RfekKt5apUHKlLIng4fk/ggV99Sy2?=
 =?us-ascii?Q?PGqSSKe2C/D/Szqsk59Z4mibg9150pn2pYo9Ea9VkRZZSOh21kZCkZGX8Iu6?=
 =?us-ascii?Q?ole6+M8ZNLkpffz24jvrak08oS43S75PLRmWuYtPTwNSZfvrboj1PvG5dX7q?=
 =?us-ascii?Q?LxIMBmC0I6NTIlyGwfiJ+R2DmQWoDCvOv6Kq+plec6Qo+N+em6EGbdsYefbZ?=
 =?us-ascii?Q?aUj5yh73H2AoUV/lmeFq3HNxToR6TuoUxOWQI6LMfxk4H+osrvaW9IHCvdG9?=
 =?us-ascii?Q?3ONOGzEzLdV1i0uJClaiI+ffUiA4h3hqj+YYQ+aH11LcIagryh9B4XyOw1pa?=
 =?us-ascii?Q?+3cunPNYXyRlUq2u/T4Q16KFyNbwMey7rkwm8+RX53KASTXtPW9FUqajXGsL?=
 =?us-ascii?Q?QoPKE9DtrhmO8w+629SkEva2oLMOFwurORGZZi33kCqstqQdJGvswlS/4+75?=
 =?us-ascii?Q?eFhRfwNa1RI7yyNAauURgBvYqa/cnR9frSnFYJaSI88BeB8QuFOWwiejKAtn?=
 =?us-ascii?Q?me3ta4hv1vQhaGGMVXnXb3bBE7ICrALuNnV0OZ5ncdx1xwGZjTb9mED5U0GS?=
 =?us-ascii?Q?W0Nk5esjfh65EF/Uanf5j8ttFlXE6Y8cJHJ3GhRl+/AfsE2ie5pRmXS3vGxY?=
 =?us-ascii?Q?cJaFTXcuBLlw5KhlxChzDrrbRgmsnxix9ElIllZc14nS/HvW5CP4fZHWCUp0?=
 =?us-ascii?Q?YrJE0LB3Uc9S+KB7ApQGAsJAMvTylUsQCGJikl3iAntsrT1etoupOzSdoZfH?=
 =?us-ascii?Q?hBrTpD/4c2gSwP1yaOnMDltyr/InKAXsSmv1iv5I91uS+jnylnXTvdZE/LZK?=
 =?us-ascii?Q?gBvC6LNm9klOfvfX4igqInGjndcr3v85LQjdvAza235u3+zyQGZYZFbMDoEw?=
 =?us-ascii?Q?PoH9ET5Laa3VMk0fWU7/OwqMtwgIrI6Vm6PC7OFh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f913cb76-fb12-4dd6-e778-08dd50c99fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 09:41:45.7056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJ+dQNGOzBwL4kiw3ZRjEYaSjIn/NlRZty32Sr5R2MLyQmQJjDRmSE7N1pVLX5HTy8DANZ1TXWQRyoIFajVDgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
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



> -----Original Message-----
> From: Kusztal, ArkadiuszX <arkadiuszx.kusztal@intel.com>
> Sent: Friday 7 February 2025 09:59
> To: dev@dpdk.org
> Cc: gakhil@marvell.com; Dooley, Brian <brian.dooley@intel.com>; Kusztal,
> ArkadiuszX <arkadiuszx.kusztal@intel.com>; stable@dpdk.org
> Subject: [PATCH] common/qat: fix incorrect size in the parser
>=20
> The function `strlen` returns the size of the string without a terminatin=
g null-
> character, therefore a request to allocate memory space for a parsed argu=
ment
> is too small by 1.
>=20
> Fixes: 99ab2806687b ("common/qat: isolate parser arguments
> configuration")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
> ---
>  drivers/common/qat/qat_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/common/qat/qat_device.c
> b/drivers/common/qat/qat_device.c index bca88fd9bd..746d8a28bb
> 100644
> --- a/drivers/common/qat/qat_device.c
> +++ b/drivers/common/qat/qat_device.c
> @@ -226,7 +226,7 @@ qat_dev_parse_command_line(struct qat_pci_device
> *qat_dev,
>  	if (!devargs)
>  		return 0;
>=20
> -	len =3D strlen(devargs->drv_str);
> +	len =3D strlen(devargs->drv_str) + 1;
>  	if (len =3D=3D 0)
>  		return 0;
>  	/* Allocate per-device command line */
> --
> 2.34.1

Acked-by: Brian Dooley <brian.dooley@intel.com>

