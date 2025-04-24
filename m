Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94E0C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 06:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1C3D40156;
	Thu, 24 Apr 2025 08:45:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 84231400D5;
 Thu, 24 Apr 2025 08:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745477116; x=1777013116;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YbK2UPc0yVW7DqbgNAXXwFtA4+yLo9Mdrw4MWJcfYPY=;
 b=L79UW8th8hhJvnOXFGvzOAlk7wDeVvzIs3+iU7y1eBHEepZypOLYnFUw
 3ZQYFPdhRAziDnbeR1VpRgl200y1TDZn+Xo/zRQIBBsS+viQyRmWlahR/
 3KK6I3DP/qkZSB7VZ5oZquQ1aP3KO52QD/Mod29YSNbWpiPRmQRMGdcDE
 L4T+FLdM8yKMdkBnWGNvmu0C7K2FYS8vwPGl1YRPRqqIvLYDSoS2jGYw2
 v7cB/XVpFlQ0QNpPfgbTxlwnZeDwR97vW32x5+9z8tZVbAunkXvPipqcp
 Hmk3pyhwGmAhxYXcR1FDjvyl6pUPbf72pwgld0bCbkfe8eRg1Vv1Smgev A==;
X-CSE-ConnectionGUID: zKvItKZCTcG72pGTidDR2Q==
X-CSE-MsgGUID: dTYTUFGkQd2BMQyeUgPYGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46978402"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="46978402"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 23:45:13 -0700
X-CSE-ConnectionGUID: If6O1cD/RPuD0N6tNgg7Kw==
X-CSE-MsgGUID: g5ZW8eCCQj2iGz54fZlATg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="155758997"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 23:45:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 23:45:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 23:45:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 23:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9Z+/WgHZqqAOStoleh5mevZh929e+bnhjUiFlQkzZYlv3azkQ2wdbKGFmxiYI4n5JKl3CnbPcZg5HoJmDpRQn8tfcSi8we8wI2xnUo+rN8XYWvDvxgcYbL0EyqQ84uIzFgQrU2mlPYdj2bH4XbhigpKuvkZQPGCRh6Afur44LPNvnHGcZPbbmvYoVIUo50VHsw390utGa27Mdoz4frGde+kuSazdALdd0ctCP3lg/FzKNt05Noi5PSLU+ypGEl5FWYoityEV5RBzgoBiOt2Ll8Vy5e5nSg26qsf/ADKiA1R1Pnvn5lh/iQ4wXvQ7NQ9Pr/5n0aFRlTJmEcvU30o4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbK2UPc0yVW7DqbgNAXXwFtA4+yLo9Mdrw4MWJcfYPY=;
 b=mu/ZULiSH8QQNXR5bvZcagTjv9BRl51NQ4l8998IamoLHK+DELktYasdNiQdHQsbm2iRYt4rC5bqOjcjItky22G3b3hPoplZ8ZIvWM/8aU8FSoZwcdDoSVhIubOCfh8GfhDyhDUt+htZNcPdMl8DRVWzKwPLKKpOkFMT+IPljhEjlNc7upZxPVx8exlygbMEaLy1CmsHOyJhqN/Wcdb0TsfHbWvP7YpPzTckSRN3s6P6QUmB+eXjslsrKpVk87nn11Q+C3iLaj3X5ri5LTLQZ0gwYEGo/J3RpXbce2QMpmpJIY3zhuOpQ8ENBYPur1OFy42ueKXktHSorcNIKAfHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20)
 by BN9PR11MB5321.namprd11.prod.outlook.com (2603:10b6:408:136::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:45:06 +0000
Received: from MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21]) by MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 06:45:06 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "Deng, KaiwenX" <kaiwenx.deng@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "Deng, KaiwenX"
 <kaiwenx.deng@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, Wenzhuo Lu
 <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>
Subject: RE: [PATCH] net/intel: enable ethertype filter for E610
Thread-Topic: [PATCH] net/intel: enable ethertype filter for E610
Thread-Index: AQHbtBuECWpFnjVJdkKyHeEZb09x37OyYIeg
Date: Thu, 24 Apr 2025 06:45:06 +0000
Message-ID: <MW4PR11MB59122B51B4F90F9AE32E1A859F852@MW4PR11MB5912.namprd11.prod.outlook.com>
References: <20250423055339.79209-1-kaiwenx.deng@intel.com>
In-Reply-To: <20250423055339.79209-1-kaiwenx.deng@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5912:EE_|BN9PR11MB5321:EE_
x-ms-office365-filtering-correlation-id: 4a2f5944-a8f5-4744-11d5-08dd82fb8cb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5Gmy91HUanfRehBlPsNy8ORuc5F14mIboDjJUDup0N0ghsaeAnQMbjL5M7SL?=
 =?us-ascii?Q?Et1LCoAy91j7KDCOopDA4UcF3WCfHXtbznlHC0WTCjIL3zzDBG7CCTat0ENh?=
 =?us-ascii?Q?E1Vsf/hx49xtIE8U8nQ87yN1qdUelkbLsS1Yy0Sa7YneuQUCjJPBK09vRu0V?=
 =?us-ascii?Q?nkfoR7+Nr41wuI7rr5rjd+dv7fLzQp3HORN7RAb90klRomHH4nIlcmyIjg8B?=
 =?us-ascii?Q?KJG7LiK+vsqzA0c9rzn8Q5ENGkVaMP7qLqr7eBYn+lcq8FlmYbe0+gxHTMjp?=
 =?us-ascii?Q?GI3mHnK3A2EyqPnAjMMu+ztg6oWUS+NEVcc4Apjpj6j4Fdsp5dlrbmCuuIcg?=
 =?us-ascii?Q?mEJUy/tU3oawIx6tkzBm451HQcfvc/6xdGlK4M0uvqLp8rISa+QtrDkZ3Sdn?=
 =?us-ascii?Q?YAoYTWU0QWQx2znn/+Fjpv5/kaVo+dARYtVuzvCgOMkJP/uONxeUS6T5tdYF?=
 =?us-ascii?Q?puiuXNNE7SuCWY0xQka7/9U2ZwpOhqUlp9JWA+0zT/uhuRYp/3vp4+urAPz8?=
 =?us-ascii?Q?rODxfW6PkHfqBCSUbPuXwjD8qkUrskUVLw7vAvx0opFpqiBe62W50OdNRxC0?=
 =?us-ascii?Q?ZkMB/mCl3szlCjhNRNIwE08vH/KsZXIJTHAfOJ9hKMbYFp4zmBPvDYp3B+XQ?=
 =?us-ascii?Q?rz4dDMHf+ZTfwSiVrJW5FEK9UqIl3q8mBCFoP39aoB/9RNuwY3jcXtOUNO/w?=
 =?us-ascii?Q?V0YiCA0pxa7iaWeis+LxZhvkH6QdTv1KelpTVUKsruxCtcLWFUdkPpCe3osJ?=
 =?us-ascii?Q?eXH1ASvxdBvtPfLtFm/kbv001wdTAvevDgjqvI9NJ2OedAXflX3mNCdzK7tn?=
 =?us-ascii?Q?YlCuEAioNRwXTya7O67YZKQdBKdt0JEyPEfJgqzpodfdKW+fNeNIsyMkov8J?=
 =?us-ascii?Q?U5EltfON394lsHwXVT/Kb/4yg5oVoNWPH3k3dpANqJeYMeFnIg0bA/O/jwBs?=
 =?us-ascii?Q?BALmIhqjEuC1GrCOOcZnfOHE16YDa6jlWpULY2Pe7o15ivgGOfehlSTq/Uxt?=
 =?us-ascii?Q?EuLx8Wk5hlKp4D8vHSvit2ue8/mhE2aCalE2oHpanDMSqvohVzkqXStUa2CC?=
 =?us-ascii?Q?TCAvexzEZ+fb+zIl+5h5FteYg45Yb5HtuUYpCRTMAOs8106ytQ3hBIt1foYw?=
 =?us-ascii?Q?gNo8O4n1lKk666LbLQoAAhBnV9aYQC81SczD9ErxvCx2+R3wfQekc7rzIpgW?=
 =?us-ascii?Q?ttcOZ81+Es7QwGj3CxE/Z+dAq9mWi7agTZtDUABATQfQdYh0qCXjUezBquJm?=
 =?us-ascii?Q?t+aa+gyGbcmwP5Bq581Bu2MI+puLFJB5UZqbDv85t+qRsk4VEzVQf7ZzKra2?=
 =?us-ascii?Q?Dk/ED37Gp6cpZc1//ULo/lrH2zTiZRwVUWHpbsIzr0yY/C41xNEnMcV5WgcJ?=
 =?us-ascii?Q?usE86QhocP4qh2aAo7pRt8MyRN8jxRK7CKT8I4TnwCOCqPf/oPyLFsBT3oBa?=
 =?us-ascii?Q?FFusYAX+M58E2GmP1jr21EHRuzmipKxf/g0jEfimWMTmVJHFmgpHrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5912.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HfZRI0HoBI8w0sk9PROf3orvCJL8BSI6UkPTpzDtebfZvKNnRjAxF8uhBuRg?=
 =?us-ascii?Q?9xnpc65VVaoZaJVzuwt+tEefwScy7CHIMh7WFkSvS+PZPFLP4TaXdAwJt39k?=
 =?us-ascii?Q?qRN3SV0R2CN3kVNTZ4soENLN5iln7M8I4jRqsifQFMusX4ganb+IzwUqu/3H?=
 =?us-ascii?Q?WX0lOV5UUpFCEisat6lVJztA/fwN82SDlnyK+ShtscGVi315GQ/HsRlTkWXa?=
 =?us-ascii?Q?X2x0sPLEww2Mi0VNElf0RbJJN/DlSFCD7Q5uh+52lMEZg2a4FAtCC1inbM/W?=
 =?us-ascii?Q?NsKibLSxAM67duoJrNl+CAAsEfoJCwk/0WDNa8aKrCVCq4iQlsrOWIY9l8Bg?=
 =?us-ascii?Q?8NfDMDRhylpeoBuBdNfONJx3dzgFD9qV61Fj1wqnjN2ldVc6WR4TYrGYoAPT?=
 =?us-ascii?Q?k38jghHcRYE0DwAgOCCk7gX+elLCYqRLR1kESJftizKqZx5KwdT4NVW8qEpE?=
 =?us-ascii?Q?VUJLt1m7mOxqzHJnezrtiN7w4v7zNlWK+C/mXfjdpWGzgUW7BjrQBGymsOGr?=
 =?us-ascii?Q?z9i63W/vl/bcB4h5Oh3PB8jqJ78YVmK9TtHK/uA43YeTq4AwnwqHH58R1ZkN?=
 =?us-ascii?Q?h2lpqLeqY3kekmjHlaIwlaZNEe/iIRRU4IMtyrDA/hOHbsqvCs+yShCr6ccX?=
 =?us-ascii?Q?JOgSCFSbHbjhdCyc5eTfLMjhDbiJmxuskKBcaG4wEH9vc/dque+8ux3y3h9T?=
 =?us-ascii?Q?lYYTCil5CBGfmeARd2xkAH85fH/dRLYuY57zwm8GWkwMszwRjbsYOCL3DeoC?=
 =?us-ascii?Q?pPtIWowzM+SkFrQtISgu8pd++Pyxr7jR3s6xHKU6Fs3Bq8dkQVqIa91fa/zJ?=
 =?us-ascii?Q?4HL2j4cVP7P+s/sEM8eM+RNeK9dvi3EnRRdn6PqydRnDby2QcWknqPD81u0F?=
 =?us-ascii?Q?TpvK05u8B5jpeJVxPZ03OLSMz+r2MA/dRxSrXDddkyHDxT2SFmo7EoSrhk6V?=
 =?us-ascii?Q?WllbivBxqeWge0Q3jKiJyLACLie7FKHclqfLvaNpds9LXODANd2d813q7AJ1?=
 =?us-ascii?Q?Lsc/ki7wdPI6s62fd/xBzOIhNbnIujiz4bMbUKsOjGFBf/Aix+4FZrvwsyaa?=
 =?us-ascii?Q?/B1ron9cQx89/TIAaPQylY+V5Wxm/lrHYGIBTfwT/O5qdeHu66y2Pnn31+Is?=
 =?us-ascii?Q?8hJLygkU/ZJd8G0+fQuk1o0xfAXi1FC93GwxBiNnlynIgNiRE7fBfhChAd0P?=
 =?us-ascii?Q?p5RAMNiHYBgZ3mx4GlU45xsAGztb3DaBtoieYp9c1Mriap5nsID1NeOY4f+c?=
 =?us-ascii?Q?28OCkolBC2XFybvTdcw3aQ28ska3I81bVXOsiUjcWBHoZxXNrnEO2qtQD6Qy?=
 =?us-ascii?Q?NCVCEnAgS0+US578trnDu2pCIHBjO0DDjxTCxWsQ2oRN4Eab5oYuJS9skxsM?=
 =?us-ascii?Q?rx0nVlpZEmbrBpnQ5huGcDORcMoC7GBQPDNxACDt5pysXTYuAekQIweSwUJO?=
 =?us-ascii?Q?lTF59fvDj1ULTZGfXLianIlb4KLAmabvUcL69ddJ/jyPMysp4IDjpwLqRZIZ?=
 =?us-ascii?Q?gFB3WmuZjeu0v5iv+5HmP0ZUaYho7iDqMWn+3PPM1ca5Su5PqP1cPDHINv0L?=
 =?us-ascii?Q?pyXjWdF5bl5dBQxlOrLcW5w7gS7OvSMoMGOJpJKQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2f5944-a8f5-4744-11d5-08dd82fb8cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 06:45:06.5212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AC3AE8FuRWqh7pMnrq52aAR2lkINwT3kk3FBiq8V4QFXaXne5Ai31hZHyFGTWIclKu7GD6TEJVjxRCbAKPamDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5321
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
> From: Kaiwen Deng <kaiwenx.deng@intel.com>
> Sent: Wednesday, April 23, 2025 1:54 PM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Deng, KaiwenX <kaiwenx.deng@intel.com>; Burakov,
> Anatoly <anatoly.burakov@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Wenzhuo Lu <wenzhuo.lu@intel.com>; Wei
> Zhao <wei.zhao1@intel.com>
> Subject: [PATCH] net/intel: enable ethertype filter for E610
>=20
> This commit adds the E610 MAC type to the filter support check.
>=20
> Fixes: 962549bb27c7 ("net/ixgbe: move MAC type check macros")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> ---
Tested-by: Xu, HailinX <hailinx.xu@intel.com>
