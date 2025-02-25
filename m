Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74082C021A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 03:19:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B27E40662;
	Tue, 25 Feb 2025 04:19:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2AF8C402B1
 for <dev@dpdk.org>; Tue, 25 Feb 2025 04:19:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740453575; x=1771989575;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RDwK8pQ5ujDkA4lEpHwrd31vEdcmmTziWoynXlH6u60=;
 b=llM1LeQktufO05ypzkHICmCGos7MhhynnfpirNx/3qtF95VG/sXqtTug
 fmuyDrdmZ5rSyLcPHCKRVFhwEeldt7TtALfPh3+qhNjuiuXqzzIeJL/NS
 c/lNTjIGBXtA+J+gBWMiYRxG5M/Xyu5l5BFw2RXnBRShKBnqh85laSiAk
 f0vTzyZVOSntgCKHfM2r7DtLBztQlBXyB5wlNs/S51HPuKLJoXIaVcuWm
 y1krEhDuR93UTehLP4ycB6/1p8AMNXiJXQXuY/LglPkLzYR2480UgHqjr
 NNSeptqyNWGycZzh6I5tj0TdwDg22wLkhR2tu5Bm1halwS/A4Czfan9Qh g==;
X-CSE-ConnectionGUID: tc+9/drkR6SVp88qCYzvLA==
X-CSE-MsgGUID: ptpW6aZsQ1ubS0N0thEbAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45153536"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="45153536"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 19:19:33 -0800
X-CSE-ConnectionGUID: Ud1gWTFwR9SIgi7WSc5uiw==
X-CSE-MsgGUID: L7ciMfS3TnO4qlDu79SmrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="147095581"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Feb 2025 19:19:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 19:19:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 19:19:32 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 19:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hchxZgiZEFeHExrvIroS3M76FBSwVXrqpDE/vqU48ZnS0vSXdRz7JZDH9pQTRjaVl0zb+kelwRe7FBr9yeyAYvDEoBVpq0UGBGBwB0gQO2VOZN1tKJCm86ESj7Sftlf173013H8fwF/Wk8qOA+ggAmIEPArFVriGu2hO7ZCQ5m7yqWNOTB11esXatCJe45uaDcsE+NAg5Z5tPQZFbMcbY8xxqMPlyIP24phtXeV52L5E4Zr1JKkTQ6oEMk/bdZukFcNF+FQQG26RDZpLBQ6yp5umGGuR5L8BBkMG7C38y2YixkjNhxHjXBWhfpD1JAdGLPxmowA97KmwR39uOxdb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDwK8pQ5ujDkA4lEpHwrd31vEdcmmTziWoynXlH6u60=;
 b=XfJFkcfXuPI3hcThKaJSsGQqFYN8R+8jLCsS/FrCrgy6Ctep4ERqIl+6LSeeHFS5zctr2Mwc++I5wGXwi72VB0HcqX1Gl9zUB4Awx83S3MPZLUDlNHQqk/8wR1wZdKvpv/PW+/3WHAQF4e8IT3Mgb7A4ZR6SbGg6sujdSr3Ohleu0yKaHJNyDafxQL10UoEfrkLUNNGj+JyHtO6b3yh2qoLaJWCYwDmCVtEyherY2SqcwUrUsndPLMZd2bN7F8FOp2jAC/VJGgcP/7trbkqW2lEQ1qigbzbSUCeEIHGy/r4735sdNXOHCUZRXRAUa4BxF74jMyGcKkHYdHwZqsIaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7120.namprd11.prod.outlook.com (2603:10b6:510:214::21)
 by SN7PR11MB7996.namprd11.prod.outlook.com (2603:10b6:806:2e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 03:19:19 +0000
Received: from PH8PR11MB7120.namprd11.prod.outlook.com
 ([fe80::7708:b89d:b301:b690]) by PH8PR11MB7120.namprd11.prod.outlook.com
 ([fe80::7708:b89d:b301:b690%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 03:19:19 +0000
From: "Li, HongboX" <hongbox.li@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Ye, MingjinX" <mingjinx.ye@intel.com>
Subject: RE: [PATCH] net/ice: fix ACL filter uninit
Thread-Topic: [PATCH] net/ice: fix ACL filter uninit
Thread-Index: AQHbhD6DXD7HVNisS0iEuvmyzHikmbNXXaGA
Date: Tue, 25 Feb 2025 03:19:19 +0000
Message-ID: <PH8PR11MB71207C45844501675A2180E39FC32@PH8PR11MB7120.namprd11.prod.outlook.com>
References: <20250221082510.332677-1-mingjinx.ye@intel.com>
In-Reply-To: <20250221082510.332677-1-mingjinx.ye@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7120:EE_|SN7PR11MB7996:EE_
x-ms-office365-filtering-correlation-id: 54e42842-ec6e-4200-8dae-08dd554b318f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CDUWTj86yvDSUMOgG66DXq2Re9siIfiOKMrIimxoJICDRwW/MmWch6PGUZTM?=
 =?us-ascii?Q?5BLvZglKrxMYpazm0w1BuGUAIWwQSBbTzqqbv6395SjIChBB55i7fVTzFO7O?=
 =?us-ascii?Q?fH9BaRkMjtyYHJ9NJ2CBh9mYwHlgOddklw1iel+vDgimSIdEHEA451iVJyzo?=
 =?us-ascii?Q?FghQaeBYEANXhMHf26TLvxgfuc/H4kmf1DghLHptu2Msylng4sd8lwxLmWVo?=
 =?us-ascii?Q?pk0t6ke+K42UaxKgFIQmCcKiu9Z1I6ddzZiNDp1CORVWutRIC4BFvmxNSF6c?=
 =?us-ascii?Q?thRYKGT6PEPoh27khtINVuy1Y03t60i0d7Ze+d0h/gU7hCJnyyiHRS1KCAoo?=
 =?us-ascii?Q?V5Suo9XoyH0Xg9Dd/F+vDjwgk9X2R6y1Tvpz6DhUPT/VJ0lxEy8uQ1v3NxNJ?=
 =?us-ascii?Q?X+2yKqVD3AcOW9n8GMpfQIkVjBQCWM1KamWJRSazVBTs3Gxaq3YKT2aCky31?=
 =?us-ascii?Q?LAYPfF0CKWb4H/VLZdhf3G0b16Si2YYVOO+Lft1aQssi7DZZzSkCCbrywg5b?=
 =?us-ascii?Q?pcBbE/ykVTcU3Z+lRP3ZJPEN8Xd44D+CozDK5UAOalx3EOhEq6hYL+KGz30M?=
 =?us-ascii?Q?wcAlivPpD9dau7IhJ8ARLjzf4fMwmQAV/P57/LGWvBsO4etI84d6ixnMDDhX?=
 =?us-ascii?Q?TPurDrYPWgVVJh/Zi50gp+obbqPDVHh1XYin9zu4ryjrHFp7acRQEH4n522N?=
 =?us-ascii?Q?AmXcLuwwlO8XE7Lg2XMRgysJ5GGXfndDYX33eqV6R4TiOVy+7mSCe8hal4a7?=
 =?us-ascii?Q?4C6ThyrH1OkHjrTU27nN+0xK54m2qsaKF4wxjV3Xst/xdYVOtaARcaOqH/ra?=
 =?us-ascii?Q?kO874nHFmqwQzqc332z3LJzjZVfH16zy0j5W/Z3Z1RnkvSavYBRfsxlMX0zH?=
 =?us-ascii?Q?i+OvGbJg3EZxtEMMrthI8CmUf0tl6dofCFB46/2NBxTs+33373wRUiTvMFzg?=
 =?us-ascii?Q?sPSez5cjf8cCuRDmhDWse8y3cB5ATUDhXjY1Ji3WbiAxvPd910e9vPLt5OuQ?=
 =?us-ascii?Q?KeqbRir+/zIpnDi8QzIxcptFWZYeO4F2vtYCN+9ZnBo0tcRC3RvXsP3FQ9fI?=
 =?us-ascii?Q?mQzoRCn6jVOR+S5GGmEUsiXP7I1BQWf5lpljQKXHG/AnqhhHx/w/WDuvlDvI?=
 =?us-ascii?Q?NMNLADg0BHcGajZB26JsiaoVG7G0XPkbKV90XrZRQ9P1Or93VzAlHUZQY6NX?=
 =?us-ascii?Q?aOuHKeNG57vg1naV7g7A3ShhnXNSFLo2NDPXgEjr++GZ0/G+GgmVWEEBTiet?=
 =?us-ascii?Q?Seue4J/FIc4oh5S5beQWTo97SI2tVyfK/ln5e61BKpZWSPI8YfAyvsyrfv6S?=
 =?us-ascii?Q?RZKDqBW//RSfX81pgBm+jaNUr/3BX0UFFN7U3EwRBU8Ns6pNoMKcsBi+ADZo?=
 =?us-ascii?Q?VfQQCg9CT8qXrbscp/3bA1YDB+XwJI3sBuuFgXeIzcKk7CD/SYIwnaNmoVkt?=
 =?us-ascii?Q?Gk0IRgohGNb62FRtF7Nn3OdcQ+kcwdQi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7120.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WC4ILFCzWW1HbUlF6RXTdDDijYxwsWoD6XhNjj1b80YcCmFHWGpp2jpImIHG?=
 =?us-ascii?Q?sgjDiMkJk+cFErRKzOMvw8mb/SlLRw4KTYXzk43tj5UcCPplCu/XQtxnU4b1?=
 =?us-ascii?Q?mgjgF2owKoD8DZIRqq1pDOLMC8mHOzF7mH7lFTt5OrlmdVNz3pYeU/g88TAB?=
 =?us-ascii?Q?pyv/l6megcyG3X7eYyWzoFDX63/BdikuRbecTx1Mc+DsFA05OtKz6gRCzMre?=
 =?us-ascii?Q?H3de3M5WdSOygaeKbiwyR4JmIfu/7u9KXkwb9LsiC3x64IKAIUCANcsRhkIE?=
 =?us-ascii?Q?m+SrAkwe3RMkl4wUEBN0A20HOBehpV5p3teJR5e/r5SaHuBo0o5TTd991AK5?=
 =?us-ascii?Q?xJfHmAnwV5dXDUflEAVQUiIjO6fCPNOxkgLFrc8CibdOGwUZATfIoGK7aM86?=
 =?us-ascii?Q?J3/PggfTe8CrKKmQBC1v3MGtCANB4QekfybSRtVMT0PNAkUIAdMWVfzNpsN3?=
 =?us-ascii?Q?MSe9RqPlMKx4idrSU3I5VRn+/PnhG5gy5h0hQGpEJbJl4WcAXF8PepCslXQw?=
 =?us-ascii?Q?123WGn9Hbe2orbgF2IbV3ms0dEW5YboivEY661NonZLur1LE0Z9KfqOIlQ5E?=
 =?us-ascii?Q?7RYmGXs/iti9lNKMU/b2SrMVDclYosXtHdY49kICCgqMr+IqoxvLRKnKAgco?=
 =?us-ascii?Q?tul4xBoqNHg14e7RQtTwUFeSljjaNYUe/zy8vtU8F6AWjvvJphuYuV34hC5V?=
 =?us-ascii?Q?RMqw+uE4Z0NYkTyJu/UaErPKFrU3Tn8EjZYHv4NNztXXsZYD5l43a3ZFO1fu?=
 =?us-ascii?Q?iZg7iNCB72hSVw4kwEHHhcEweffJmvLjbXDmiD7/39tpqqrlKLMsjs8DtRBF?=
 =?us-ascii?Q?a+3Dh86GHifZ98wHcG2nnweOrHmMWkHFiFirlsOqTv9TwwxIwWwuF2WVryYQ?=
 =?us-ascii?Q?S8cbZg80KJlK3YTABe3CKX+Yg374hxy/wQ783C1NrqOsYgea7iaIc+D1iyQi?=
 =?us-ascii?Q?7v26Huns1avqRlwuXUj82tNOp1fJ2Ra0gRu8qGkT4mkoB61ggDaAXvgy7Vh8?=
 =?us-ascii?Q?rgBEw2AzgWsdczFwfzBIvSY1Jz59EVQY55Ejbd+A3UArE/W0CUQoe8te7epk?=
 =?us-ascii?Q?vTl3+dX/NiNY9U21AJlMSM+IzPOqjoJZknYF3BekVd6kkfHNkmm7Kb5tYA3Z?=
 =?us-ascii?Q?NOOOT2GdU/RkXhr7/AOWh7NbrPrw9ObLr0MvBje3G2Hwq5yl30bk7kSDT3va?=
 =?us-ascii?Q?vTGC9H9oCWKa+EnoATFWtgy3O728YLBEOAOhEl/gc5oGNryb/2Mj4OCVgwUI?=
 =?us-ascii?Q?HrwmKgsgUXpprbSYg5mr8pMDmksx5BlktMRA0RnPWcAJ1fWuz6GunXgAir/o?=
 =?us-ascii?Q?JpdsAUVQitPmezLLvsyNpJCyIe/H9t8asjxTVxzys/cs/gmHzOfk9lDL7ieJ?=
 =?us-ascii?Q?hkDWcbxE98UyWlLlHSp4TR+BgeW0c3fD+x0FHz8Bg4NVJlGg5yxM4CoSkoDB?=
 =?us-ascii?Q?yiUAVTGgf3GbJ+zu+RqYtAebikfQ9YwdHgbJi/wialBehYsXpu7wRSf+OQId?=
 =?us-ascii?Q?pLvlcBRpxEOGbN4rUpnsUnAGj8cPvHGhQ+W5cxaaiBAgU/cs5raa5VsrE+EU?=
 =?us-ascii?Q?9ue66odfzzesJ5vhQqwWaGDAgp1jB8iTpLq56a1J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e42842-ec6e-4200-8dae-08dd554b318f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 03:19:19.8520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbxLN+ZiY8YJTlrQ9I8R290tgKFmisIbLy/fVccTMlLvGtFl3dc+N6eNwu+PSkWyotptDe3VpHb+BL8ZiGCnIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7996
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
> From: Mingjin Ye <mingjinx.ye@intel.com>
> Sent: Friday, February 21, 2025 4:25 PM
> To: dev@dpdk.org
> Cc: Ye, MingjinX <mingjinx.ye@intel.com>; Richardson, Bruce
> <bruce.richardson@intel.com>; Burakov, Anatoly
> <anatoly.burakov@intel.com>
> Subject: [PATCH] net/ice: fix ACL filter uninit
>=20
> The pf has enabled the ACL filter, so uninit is no longer limited to the =
DCF.
>=20
> Fixes: a9d612291c2d ("net/ice: support IPv4 fragments in ACL filters")
>=20
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
Tested-by: Li, Hongbo <hongbox.li@intel.com>
