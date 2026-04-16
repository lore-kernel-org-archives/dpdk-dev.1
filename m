Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2D4F8D753
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 14:44:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 344C840272;
	Thu, 16 Apr 2026 16:44:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2889440144;
 Thu, 16 Apr 2026 16:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776350690; x=1807886690;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PNbVYQ4s4B39WQm8WzxR7mooitPd+Ph627qoMKqWkD0=;
 b=CKNnGSj92OVUkjfCtny90LCPe+5A1PzqKgtOUHonmXawlE1BC7WQwtNZ
 xhY069cZS9LJ45nYqkvcnq3qouwjbUb2T3ndheDmKcZj1a9OG36hP89pf
 xWIdcIgOs++6ErGej51mgtPr7tO/2TzRsvGPfLfn4p1aAOMBXNUp6nk44
 HtpuBOjDYI1qmSOn2pZamDuXtxjJKvvh76Zf7775xeiNwbBByZ672yzQu
 PfHpmdBTwFSkZN7KCLz/hACn1MLTRSWiiE1Tvo4P80F7cmLY/Ku7Tv0r4
 p9mM9fB5jr1MN/PbVa1n7kwull2IDbg2g39hoFIeFk5sxs9YavdhyImfz g==;
X-CSE-ConnectionGUID: g4D1CeJYTlOwT0fpGGty1Q==
X-CSE-MsgGUID: 9ASa7BLtQKWGGiRuE9qlXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77424500"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="77424500"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 07:44:48 -0700
X-CSE-ConnectionGUID: IOFDpAcEQuid3QweauzH9w==
X-CSE-MsgGUID: kJHl7ieLTEiG8PUEd65lCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="232494093"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 07:44:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 07:44:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 07:44:47 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 07:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN7pnyNVcTzR/EKcqDTtrJ9rUdf1MdVuxjQ8A+/tmDP81jiCNpAfUEoVhmgREjnNbgfIh8m6YuDWO8frbL0fAmIKef+MxZspg34RunyJTeI9uBXO8/Lrk8wemgECVVtOM/BLKyLNQzUU/842Q1os7mj8otg6XDUhgDCufolQR1WYqSMGdt99S1u6CaK6174046bNRtRNgNqPv+oPpam1bCi+mvFt+NBbdmyDq6fPbNi96/iMgdVMC8tvU/zhU/b3xjjrppPSrsGYK/Me0yLqNr2OsVyydYvzh9n4V1eOh8fOjEVyHjRK9xcjpFWV6l049GVYIj4WmTnWXzdvmTODZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8oFkTVw821CigWSFBbIET5woGOq/KwE7fBLqxy9juE=;
 b=h/InKIjV5/HYUyRuuyXGrS7ZvzVIa3vNSRm6Bz5SBPe6xcrP4FUzpqhH0poj9JbeNxr/pya1hKpRwrQpdKTSxnEY3fN/2hWhMwy8Cbbd/WVio67HTtWdw+s4PEzRZTI98Qrx7HJS4DDRK1KcbO9klI1ivXV3SD6mhZ6Mcoobml1a2RkG7ieCIFxCGu9tEt92akl79PHol7/rH+A4hfZG9Hwn/D24/95VW9k2obDPhVCp/y8q46tJwiS95SnQWErC7xKvLYqcB0I/AJ/w/hh6vnUr2KHSFA/RX+6BbMc59Y1Ua1iJTfmJZSy+xoY6lWx2LWXZWUyb5taTgzq9rcPXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB9456.namprd11.prod.outlook.com (2603:10b6:8:290::17)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 14:44:44 +0000
Received: from DS0PR11MB9456.namprd11.prod.outlook.com
 ([fe80::6132:66e2:d774:92cc]) by DS0PR11MB9456.namprd11.prod.outlook.com
 ([fe80::6132:66e2:d774:92cc%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:44:43 +0000
From: "Gujjar, Abhinandan S" <abhinandan.gujjar@intel.com>
To: Daniil Iskhakov <dish@amicon.ru>, Akhil Goyal <gakhil@marvell.com>, "Fan
 Zhang" <fanzhang.oss@gmail.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, Daniil
 Agalakov <ade@amicon.ru>, "sdl.dpdk@linuxtesting.org"
 <sdl.dpdk@linuxtesting.org>, "rrv@amicon.ru" <rrv@amicon.ru>
Subject: RE: [PATCH] cryptodev: reset resource pointers in init error path
Thread-Topic: [PATCH] cryptodev: reset resource pointers in init error path
Thread-Index: AQHczYSLYwMBUQfJd023H5VtAQsje7Xhw1fw
Date: Thu, 16 Apr 2026 14:44:43 +0000
Message-ID: <DS0PR11MB9456C33924D58CC1F27323E3E8232@DS0PR11MB9456.namprd11.prod.outlook.com>
References: <20260416093437.711435-1-dish@amicon.ru>
In-Reply-To: <20260416093437.711435-1-dish@amicon.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB9456:EE_|SJ2PR11MB8346:EE_
x-ms-office365-filtering-correlation-id: 8cc4c3bb-6a9a-471b-7f17-08de9bc6b2d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: IWRA1DWAp34JTgEERuh7TxRdXh24SdKAQkXa9QYkkmVilHrDBM/Vzqagmf37R/vH+JQIof6VZj5r80lHuXnBh8yG7tUPLuTQtZYIggdoZRDql1PIpI46aJH6G7RX1pK/K8mPtFor86e7gfdo6oMZTtJ8k9aivEfBVAD87Zpc/p5QlVMv4thhWxMI139TxCBafYzGoDGIw2ciFD7sZExoy43pftVOHmW3+Qj65jB+XawiuFFI2EChEVlPzRouje8xZyRdsgWvq60YM6bXVaMo1TMXnlgykYF+9LlTF2PabD47TsV69PEgc5K72gbbeA/X3afL4i7cjYhNMsuelloyC6kdEtezllvYS13b56BPBtiQMxnZHHWC/kpeV5LqCgXRNMMmtF5eAM04ftqGx87YgTGWkcT02sVNlHQ3sF2qCXVCUI6kqGBo4KMu83HL1Gnnk4ICR1Pfzl2XoetNiaeOonMoi1I6V0S40Hp4Q5a0rIrCK4LzlAh6yvB4Mj9lr66qQAbR7mcnnp2BhPB/Bi6rsfB8cN2CL2JVHb7gdEg54U/iRZ6LJeiT3cBycWNk4LHLqyTAW5WybIgg7nxZgBe24p666rMld6Bz+AoY6+cduwNKDFUAPpyEF04On9O0XgtRCAWUoANDcOxFM6hjyPY8JJoZcUtZm8ZSvylEJIeiQl7jiRtlo2Wcje5983WJJkzFESuVx+ol6w5cd8ERzQ20RopnjCYUmk6BvqR+QMUYtwETDI1Z1Tj+RK7+dlTrFkNR2c3lOMhvBgX3UhJvLaj/PE6HWAqKdfDGqWUn/lYlRzU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB9456.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4RqG+WpoFsMch94Ded4WsM/pOpH1bniBryH9nKHmvLK9ai7LGYxKotd480Ct?=
 =?us-ascii?Q?+lRFNIyWGWx559WeKlMRUowMiS0FK04AdoZvrwUR1T8Gg3qVumtVZ7rLPmlT?=
 =?us-ascii?Q?0QLhHpqHRo8q3s/X4DtEbIInAU6tix7+4dK4sOF0VUOiNeYIWRgKIDfS9xCm?=
 =?us-ascii?Q?MPxBUl8AG/gyrgeFNHhIvPRv19Zqa+i8BizByG8ReGO2aS2XVmdhDnUL+AzV?=
 =?us-ascii?Q?qDG9601XLXVl0Cv6jiAV38yOrNgXDb7omhXQqnk89WyG/sF6V15F94XmsLV8?=
 =?us-ascii?Q?WAnxLHuzCn0SNW7RQU5U57wd3AVSqajJLgQ4FtnLc1za2bsDMA8tyC3a1q5Q?=
 =?us-ascii?Q?o8GglX3e5Zf8ChlK5tTlEZCfv118HKSEWlx8qK68DkfFI7jKdGwBZBzRwOVA?=
 =?us-ascii?Q?KA/2emRRLIp+bp2mWN/2bq3muF6o9M6PI2o314ghmyK8z88ahqUytkJGtxXo?=
 =?us-ascii?Q?wZbgiUaSKC0Cv8pUpIUJjxwlurmNbNYvOfbVXleRTT36rAifGkrIRHmw96bs?=
 =?us-ascii?Q?q/lLOD+pt6o83Cg7vRmRaO9+tJEw0mga3cc4MxqGpnMxAti1YAlEAwybkuPv?=
 =?us-ascii?Q?7PAwsDhSXNFKNHvl8nV/INHtULQMD2nOuDvbFS77mTf5GejauBA+zermCHnA?=
 =?us-ascii?Q?nE3sYqv35Rgr64djvxK5TqT4EFP9Iq6ULLRtV0gCp/PhMYWSmK8CF/wqLCj4?=
 =?us-ascii?Q?d5JXcgqGzJT/3IfiF3bO+/HmIpV2oRFsS8lwRjb4HRiG4fhnrCLasMM3gKcO?=
 =?us-ascii?Q?dmUfkXZFXw2Pa/ZuOIclo68R1/CwjQQBlf1KdfvO5deMpE2g4Ckmycce85YO?=
 =?us-ascii?Q?IzgpJ0P+viIWVvX2qSHyXb8zdSFzPKri7HPATBfehuvoVL53ccqU3ozLsNDg?=
 =?us-ascii?Q?N7uAoSPi/pYWdTQKcYQT+2Bt8Cicchxsp1NPDbbM+ZL7pTjCK/RrQHZK4WIx?=
 =?us-ascii?Q?yEKzNvTv1rYqrkIymL8YmgBFgfU4Y1QthHfxFh7dMWMgwyWCdgeFYZ/exHyh?=
 =?us-ascii?Q?0NpDHwNnNEZVw0KZ/tRlGu0vHNruDn1ANMuajsCligTzlY/LaV8ouek1Fwfq?=
 =?us-ascii?Q?u/+brTpzyzbZiGQbZaOVJ6AdcrYydDnFP2jfUjDPbK/VX/9eY6JisMzIzTvX?=
 =?us-ascii?Q?kVPE8Zy9MGel3lGi9xBbiWaKrGp2QobZE4vgcls0dfx3Gw6fhwP6YoyjXEtX?=
 =?us-ascii?Q?e2ZlL8QI0JAGdUh/vhoHMcvgRJFkvsTAJWsM7OVPVawfAQB7Ojkf85fEPDoB?=
 =?us-ascii?Q?kME9T9x+g4MYQGT3qEohmo81mOMDf1NRxrpnGQShwgdpzlQDkzYrdxq3tknW?=
 =?us-ascii?Q?owjvXKDnxbpP9gUCBdyjEIWPLGwsKOx3B8VuzWnwpypfO1KG6lc4sFLYxE/x?=
 =?us-ascii?Q?pVWKWoXjoeikysdk0y8zGgB1xDnLZarSUFLCcLCbyfii5zGgbUpb9QsSrKkq?=
 =?us-ascii?Q?+egk1XEyJDJv4wjIzch5AZNqCWP/DajJlqE/tHICnN+n8LBQ6wU+mUJjRpGu?=
 =?us-ascii?Q?I8K2yVJDvG8dpwGAGwCDiOt7vEtlzAHVGpTSofkcz4MylSkUx4IU/8VT/LZW?=
 =?us-ascii?Q?75bJP0RSiFMzkpASN1Msj+LTtosDpei2jKJKfTiNrTtSY6hVC1x+NgdLUgyy?=
 =?us-ascii?Q?xQpJeOAssdjrlg02ogKOkia+DLmdr9jiO8OXBjaNprNXQTsQ8pzsGIFyhTmj?=
 =?us-ascii?Q?kmLLBmVHglZaCcuWHi9ctzZNqPtqwR5UgghA0p7DE7wgbNPiSSLQ6To6XWY+?=
 =?us-ascii?Q?PlBj0zf2aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JjxDF+NJJNZQfeSejD+0nUkMbwOAYalUn9m0GQ8SUixwNP7Iwvn2aAdmpO7iv1xQNE+3if/w1IujpasKovm56kZhq42QEV+92Zzr3CuvWZT/IxnHEly3tn9331330zqOGUnnVoSg27Gp7n/3ShDifN6T867OKJSviuwdslVXIOuq9HmsMet+Dv/TVRgnKQTjIMfMEtI6At4hF0SD4PU8a0CNwLISQ2mW5KayyfaYauBvPL4kGaDwe0zZ4/K2vCK9sCVEvYQZYzRFLnKQXgDd0FXPGcKUvZ7b0I/ucOuUoxXhm+3XWbB8PydFJOIOSycf0/bagESvxjmW1ePVeb3iBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB9456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc4c3bb-6a9a-471b-7f17-08de9bc6b2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 14:44:43.9086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLwFDgIyq00CfXEHd0drTrhZ2WnKIsoJz+qrgFoRUUK6fSjTPwnQAY7110zxVzxAg5b9gdIaxUVO0uBvpFIGj5LmRCBwyrvIPMzkRX0BkMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
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
> From: Daniil Iskhakov <dish@amicon.ru>
> Sent: Thursday, April 16, 2026 3:05 PM
> To: Akhil Goyal <gakhil@marvell.com>; Fan Zhang
> <fanzhang.oss@gmail.com>; Gujjar, Abhinandan S
> <abhinandan.gujjar@intel.com>; Konstantin Ananyev
> <konstantin.ananyev@huawei.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Daniil Iskhakov <dish@amicon.ru>;
> Daniil Agalakov <ade@amicon.ru>; sdl.dpdk@linuxtesting.org;
> rrv@amicon.ru
> Subject: [PATCH] cryptodev: reset resource pointers in init error path
>=20
> cryptodev_cb_init() may free partially allocated resources on failure, bu=
t does
> not reset their pointers afterwards.
>=20
> A later call to cryptodev_cb_cleanup() may then attempt to release both
> resources even when one of them has already been freed, because the
> cleanup logic does not rely on both pointers being valid independently.
>=20
> Set freed pointers to NULL in the cryptodev_cb_init() error path to make
> subsequent cleanup safe.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 1c3ffb95595e ("cryptodev: add enqueue and dequeue callbacks")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Daniil Agalakov <ade@amicon.ru>
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
> ---
> Cc: abhinandan.gujjar@intel.com
> Cc: sdl.dpdk@linuxtesting.org
> Cc: rrv@amicon.ru
> ---
>  lib/cryptodev/rte_cryptodev.c | 1 +
>  1 file changed, 1 insertion(+)
>=20

Acked-by: abhinandan.gujjar@intel.com

> diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.=
c
> index 50071935c2..5cb9c93c77 100644
> --- a/lib/cryptodev/rte_cryptodev.c
> +++ b/lib/cryptodev/rte_cryptodev.c
> @@ -811,6 +811,7 @@ cryptodev_cb_init(struct rte_cryptodev *dev)
>  	if (dev->deq_cbs =3D=3D NULL) {
>  		CDEV_LOG_ERR("Failed to allocate memory for deq
> callbacks");
>  		rte_free(dev->enq_cbs);
> +		dev->enq_cbs =3D NULL;
>  		return -ENOMEM;
>  	}
>=20
> --
> 2.43.0

