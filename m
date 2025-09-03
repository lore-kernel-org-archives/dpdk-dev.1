Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0474CA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A0A240281;
	Wed,  3 Sep 2025 17:46:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4AB1740150;
 Wed,  3 Sep 2025 17:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756914362; x=1788450362;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=XDhoxhMGOPuxrd23um7UngQgeZsdyKvnZwsU7Yxyh2A=;
 b=gT+Nqnqckf580OZGgYbL9d2Rfz9PRzNKSrZz/dYXulu8fRKAH4NVCblz
 JZD5xQF/dy2CdIQC4sNK/uv04x8Cu8AqPNoYPyXvKPJDohZK15L3XA1so
 O2Z0j7WskQcTNvB6edzLLFWKOraoWCuntx4zbfXgaShJ4l3gIsR8B9Ldb
 DwmyE0TURJGBmMI8RXhKxEA3Fjb0EGfBCAcZ67Uhf/2L+s22v9luqCaV9
 IQ61xGsZ5CNuZPki2wc/yNUHa5GuIEKTcKf0kd0RNREijzp0pW3cFICvU
 DpkFgmBb5MF2G28WgqvVxG9H6ylWgkTcZhncdafXIQgtKn48StydWZGlo g==;
X-CSE-ConnectionGUID: FtdodxG9Q7GtaDuW5UT/1A==
X-CSE-MsgGUID: ogVDCcEAQfy6oWvIL26PNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="63053265"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; d="scan'208,217";a="63053265"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 08:46:01 -0700
X-CSE-ConnectionGUID: ze8oSrfDSD6QZNebeKAQLg==
X-CSE-MsgGUID: 1FF8zB8xSL2NHRfFWLlgiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
 d="scan'208,217";a="202579523"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 08:46:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 08:46:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 08:46:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.74)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 08:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceHvcLCwlJRmGbSnuxsLTUM72kKCAODyzJoop4oy7PsQy+4cHSmvNTdfFFw1M99o8DkTJQJ7h/vbw5Dg7RngdHZLTv5G5nBVWpESXzzNQpIjgznlwk8eZrXkrRMQeicx3lPfbY6RgXFexesSohyf1uXshljHyLyO1OEtWE6yzKHUhZuIYlIzzuJs+KJfBDK6IjZVQ4BAdl4uHbBgBrcc8VchDxivK+qU1m2VipY2IfkfMak4mSKXL0lbuNI0TMwWetcJrqxt+H9qWHLZwj/aD/4PY7pws8LANydLxPyxE/NhMmqZD0ZvdRoXIwIS4j4MShg+JCDymx9NhMSntkqvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5h3BlOBIX3ImmSDEg06FoIA/BTvxHS/8UxO3LG9nVk=;
 b=pn7njuy017dsPBLkostZ7q3BaNVlDCltV6zCcVTC674ehXZ33WI2L4C22GBwfqdiSTBmpC3flI2CftsSdiCwSwXLS6fkOwsyj9WGPFnYWX/XpGfd4zG+s0FW7Caj66lrfkXxxYWbbJHby2hvSWzj8PPVeUgee5ai2eRoL2kih3yhPTc7TkTJ5e2R3HkPfq8GZ/7wuu4aXkbLCOUq8g7865vDU+9iVNJYfoHB/0PXp8CSIziaQELINC3LVbY6ftQGUaRyqBg3ZltH8uk1YPzs3hrAUK24XfiGT9gaDOVjgZbbHqwdEnU/16qiGEIdPJTsDNRGmV5PpL5FMTA0R+ymXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA1PR11MB8247.namprd11.prod.outlook.com (2603:10b6:208:449::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Wed, 3 Sep
 2025 15:45:58 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 15:45:58 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Shani Peretz <shperetz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "suanmingm@nvidia.com" <suanmingm@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Kobylinski, Michal" <michal.kobylinski@intel.com>,
 Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>, Marcin Kerlin
 <marcinx.kerlin@intel.com>, Piotr Azarewicz <piotr.azarewicz@intel.com>,
 "Doherty, Declan" <declan.doherty@intel.com>
Subject: Re: [PATCH] app/crypto-perf: fix plaintext size exceeds buffer size
Thread-Topic: [PATCH] app/crypto-perf: fix plaintext size exceeds buffer size
Thread-Index: AQHcBdOQ3nqKXiCjmkmUsN+HfdSC5rSBx+lM
Date: Wed, 3 Sep 2025 15:45:58 +0000
Message-ID: <DS0PR11MB7458E16D4DBBC73149AEEFBD8101A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250805063800.225231-1-shperetz@nvidia.com>
In-Reply-To: <20250805063800.225231-1-shperetz@nvidia.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA1PR11MB8247:EE_
x-ms-office365-filtering-correlation-id: f216cd92-00f6-492a-dc09-08ddeb00f9eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|42112799006|376014|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?w9ZRSrD1R3l00YfHnHCaozykkOrcmj1jkAjtlOr9WiSkFeN/XWN3Ll+nO1C8?=
 =?us-ascii?Q?GSGlbYCWoVXg6YFQOP0AyAU6W7sIMDfTUN4TCgWE9NNaZZiroIFBitY+Rl8i?=
 =?us-ascii?Q?EMQvjpD5RF4sGTInvw1XBAweeB9UD5IjhJpQ2WL07uHn/Rb1fXpSiflOMRr7?=
 =?us-ascii?Q?Gx9ZZL+FBoVc7DWct3N0vBSCG0PxUZAPHEsr95iGLHFf42JkbF7umNEOxaQ5?=
 =?us-ascii?Q?lHUY8Y5Zt0WPq2C85IEplXiuAuNnri2BVTv+5BEw1z8zQw21mTvyVvarn371?=
 =?us-ascii?Q?WIH7iL8+s3xmqIByx5k7WGRPJ8fAONZ57YefWBhc/DXFMVG6RpF6iXRzS5Ja?=
 =?us-ascii?Q?SCwdmDFz83jX0qOGB/v+8U5uj2jw8uwgD9hdYwNClyQJ4KPii9jEZ0zLswJ4?=
 =?us-ascii?Q?JoBj2j6QXee7yq4yuIWMFJ8wyXQdSnu7XUVpoZjyDITxA1fKWjPjj6narfgY?=
 =?us-ascii?Q?tG2JZdlyXsX5iMizXLTDAvexS8lDNrCaR8cr/LTvBtyq37CMzwW1PZtyCrbd?=
 =?us-ascii?Q?gHUO5Onho4N3h0JFT+I/DcqYY8rvCKC4X4UjxE9+1BWc7bbW7GZJKa+MZJMo?=
 =?us-ascii?Q?mVLp7/1cYv7gIQhnsn2zx3GqcLgCqoSAFcnAISr376RmALPqneXuEsCuv9xN?=
 =?us-ascii?Q?aN8Y7nCykSwq/lAmyIv7IR5/18QqlIZTcZkPG28y3HHtAoVqzQtZl8BC1EbV?=
 =?us-ascii?Q?p4ypq/cvL87h1lAywo679/3DiRkD3ABW7n/45X83s6V+0dOXWm+43t4mC1XH?=
 =?us-ascii?Q?0AEuPJd5pPFz3Q+AlCQCO0NppJGyBpgT5X8/XiQCVlyQ/u6Ov8sE34cO//IX?=
 =?us-ascii?Q?xeeKtvSKQNDmTKIkVkZ8X4gmEYRUoMLxn/+H0IfI9Pyne9Bj3yS4R5ARGtuZ?=
 =?us-ascii?Q?R63PdBgG24NR58SoFennn5156tUsKBHtkQufc4qHBeg8dsH3//tYugJQIpKK?=
 =?us-ascii?Q?eVUMzP0rtdZVAZHiQJS3GvI8mrMlkqvH0iXGNvZzGyEQHi+dszHL1AHi91Lo?=
 =?us-ascii?Q?cqcNMvyQi2vBEn28anoY/5mAdzvq3unu1EdALVRuQovwC//iJBE5NhryzleE?=
 =?us-ascii?Q?KhplPlOEwaANdABJ4JrqIyfcht0/1x31vim0F74E2Iv4jssXVIlJTKOmK/WR?=
 =?us-ascii?Q?yo2rs3s71a/do2Aez1nep2o2MI2VbZYut2sHdo05oo2RG+iUyMy4NRT0VAr/?=
 =?us-ascii?Q?aib1cGfRW8A03xWtjxNNCyYLPAYgprNCm5gxtsT1KHbB0EDzWN40Od2JNTE+?=
 =?us-ascii?Q?8RuADer3NLYs0iIAMbUa1sjHDzonY/rYLSliTqpXVX4qqBVKFNAkU+pVmviO?=
 =?us-ascii?Q?+XQAOTDYu4vTouZ7e8XLNaqKJp9AURhjsV3RQWK1LAuEWIbL3GeWW39caPte?=
 =?us-ascii?Q?RaX+U6/bmzQp1/spoHpFLtuLQlb1XwLyNOkVuPINOmwMEOyW5HvEbPgqhDvH?=
 =?us-ascii?Q?8BCHKEoHWNTGteVPuUvpDzTCLwBbSaOeb7mK4TlW/tgimpOJ5GVT+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(42112799006)(376014)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+0fI9IX7Dl1ekyU5nEWYJpyES2ZCai7gWX9JcGsKkwv3JcFF6mb+h0L31NI+?=
 =?us-ascii?Q?eeTTtcdl18aoOtrrIDKfFryvkJG3WEwH/61YmGiLsfR1V4Dx5a1qZLZX0//Y?=
 =?us-ascii?Q?onRc3cAe5Z6CIYYvqcgCL63/8DSZ3BQgiKn805E46aBNrIXM3+7FS918Aa8g?=
 =?us-ascii?Q?6EKPTxujFfe+PifA5N1lCoVgOnXkYE4zUAsOcPUnUuAvO3Okk+KeOiYL7zS5?=
 =?us-ascii?Q?36B20CH3QNm9ZlTSB+JGnJghq76JyVk6dxK4ViYIDX/rOwKAaX1yGgtGE3i6?=
 =?us-ascii?Q?yZYVMNulng4oBP6Nn+Lh40TpXFOoxTWhZrngZSRCBy0igGxiveI7NaV7sSTC?=
 =?us-ascii?Q?74q7j/u9SdqI3msh1Yymv34Di51AsR1+0OPqBJkgYWzIWm+gYGvcoWks47sx?=
 =?us-ascii?Q?gZbI7OLYkoT7D8ONnFrmjglb2Q+vz/EafTkQSjq8zJmlLrNWO8DswHWWtkqH?=
 =?us-ascii?Q?sHB9+Eqf/+MqSgZF6w7QSghs/OM2NLJmrhgE5kH9W8rWtL+rDB1WAoqlp13F?=
 =?us-ascii?Q?bc1rPyh5201VvS7JU9LhvhfX8DAV+XgOP+OB8gheHg1kJKnxFq26Nht1hvB0?=
 =?us-ascii?Q?CgkeAOaF2sLSzUeDW0ZbAGhPpbHfIThZfbjmuI4sFzO37tvhVeFW72MHuLsh?=
 =?us-ascii?Q?r1p2RhvoBvAC7ETla+U6czgzJwdICxkKIDad/UqyzbT4oYajKySHoxh6mvuy?=
 =?us-ascii?Q?rUPC2MGJ52kza2FVuUzt3ZQSqGZ5QY+IA0V+RUYKR76clqeSh8JTsQZweG5E?=
 =?us-ascii?Q?phxjGfwMehXvqdYbs8QTxLzzDSjuGJlCAyvdJ60TkzFGBnjbexMLReS6BWky?=
 =?us-ascii?Q?po4Uoqhi8Cv8COio/7SJNKVxA7+NWUgf/Hw5TaBKCOUudvw7tlr9UvcKeKSh?=
 =?us-ascii?Q?ToW+giIQbzbSMiOhedYvba0uqONy8mk7BXhgEFRnDYbjAvckAw/AzPIBbD93?=
 =?us-ascii?Q?X8n/zKqT9EhZZqs1mhyDrFFuyyUWeqOx8wphbGI6C3dsY2QZ2LmmIUPf0+TQ?=
 =?us-ascii?Q?/IYAWSqnET/v7niKT0TMdV7Bf/n/sKrfCuqhXHYa2qE2UlaRRrOnsD/tnrpM?=
 =?us-ascii?Q?iarQja/OGHYPNjKPBLhKJezT+Km7xFIUV5TnqNjfSw25rLm3lHqB3HlY6wvQ?=
 =?us-ascii?Q?B2y6O7P/9Jb3t/zu4TJQkPjiYU+CGlXhh2xzIDqEzWP9qLPIRfgfxdNwNW9Z?=
 =?us-ascii?Q?mGlMaeUdI0djf4lLk/tcfjHE/+IazOR9czyn99qS40jl/m+b+ENTAdoJynqF?=
 =?us-ascii?Q?yshySNj8wq87S2Z4YGUGc+GSPmShr/1JZJ4gkkzZcTUZBJKT0f8LWL5hZeXV?=
 =?us-ascii?Q?hOFyjl8CyOQszOo6gpt7CTaNJVELcPI/+tOAUimSmZAmhJvuBTOaUrP29nyJ?=
 =?us-ascii?Q?+wmB0A5xHzhj+3JncWW7FKgm+EzN2Sxh82IboMGTB0Cf2deIXCn5qhlwuXmP?=
 =?us-ascii?Q?6WnBZVzZQmjYhYXcemJ+RwVFht8JC4z3boMYr3SDxw1IG6egXdMiD1KPcqiv?=
 =?us-ascii?Q?r4YMHicJGLlowS+cBY5nuR9viZIpMkzF8jSMJ9Yr91IlFhM2/6kGCCkRlPUH?=
 =?us-ascii?Q?kyAj3pil7r1c6lFGyHSKGZhXTaGkWn1Z01r8q74hfc4t/2UdCShSUkC5YtZS?=
 =?us-ascii?Q?+80FESsVcFsHw4ZPw2yomYM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458E16D4DBBC73149AEEFBD8101ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f216cd92-00f6-492a-dc09-08ddeb00f9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 15:45:58.1047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWB21McxreRvnga4rCIeVIos26G71B0OEwDkjqUPEYG4dottx44JPHGpKwWwAaMw+CDAUiSV5tjScgS87IRUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8247
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

--_000_DS0PR11MB7458E16D4DBBC73149AEEFBD8101ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Shani Peretz <shperetz@nvidia.com>
Sent: 05 August 2025 07:38
To: dev@dpdk.org <dev@dpdk.org>
Cc: suanmingm@nvidia.com <suanmingm@nvidia.com>; Shani Peretz <shperetz@nvi=
dia.com>; stable@dpdk.org <stable@dpdk.org>; Ji, Kai <kai.ji@intel.com>; Ko=
bylinski, Michal <michal.kobylinski@intel.com>; Slawomir Mrozowicz <slawomi=
rx.mrozowicz@intel.com>; Marcin Kerlin <marcinx.kerlin@intel.com>; Piotr Az=
arewicz <piotr.azarewicz@intel.com>; Doherty, Declan <declan.doherty@intel.=
com>
Subject: [PATCH] app/crypto-perf: fix plaintext size exceeds buffer size

When test vector plaintext exceeds buffer size, only the first
max_buffer_size bytes are processed, causing incorrect digest
verification (computed vs expected mismatch).

This patch fixes this issue by checking that the plaintext size is
larger than the buffer size and returns an error with a log.

Fixes: f8be1786b1b8 ("app/crypto-perf: introduce performance test applicati=
on")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-crypto-perf/cperf_test_vector_parsing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/app/test-crypto-perf/cperf_test_vector_parsing.c b/app/test-cr=
ypto-perf/cperf_test_vector_parsing.c
index 737d61d4af..04ca9cf019 100644
--- a/app/test-crypto-perf/cperf_test_vector_parsing.c
+++ b/app/test-crypto-perf/cperf_test_vector_parsing.c
@@ -308,6 +308,12 @@ parse_entry(char *entry, struct cperf_test_vector *vec=
tor,
         if (strstr(key_token, "plaintext")) {
                 rte_free(vector->plaintext.data);
                 vector->plaintext.data =3D data;
+
+               if (opts->test =3D=3D CPERF_TEST_TYPE_VERIFY && data_length=
 > opts->max_buffer_size) {
+                       printf("Global plaintext larger than buffer_sz\n");
+                       return -1;
+               }
+
                 if (tc_found)
                         vector->plaintext.length =3D data_length;
                 else {
--
2.34.1


--_000_DS0PR11MB7458E16D4DBBC73149AEEFBD8101ADS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Shani Peretz &lt;shpe=
retz@nvidia.com&gt;<br>
<b>Sent:</b> 05 August 2025 07:38<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> suanmingm@nvidia.com &lt;suanmingm@nvidia.com&gt;; Shani Peretz =
&lt;shperetz@nvidia.com&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt;; Ji, K=
ai &lt;kai.ji@intel.com&gt;; Kobylinski, Michal &lt;michal.kobylinski@intel=
.com&gt;; Slawomir Mrozowicz &lt;slawomirx.mrozowicz@intel.com&gt;;
 Marcin Kerlin &lt;marcinx.kerlin@intel.com&gt;; Piotr Azarewicz &lt;piotr.=
azarewicz@intel.com&gt;; Doherty, Declan &lt;declan.doherty@intel.com&gt;<b=
r>
<b>Subject:</b> [PATCH] app/crypto-perf: fix plaintext size exceeds buffer =
size</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When test vector plaintext exceeds buffer size, on=
ly the first<br>
max_buffer_size bytes are processed, causing incorrect digest<br>
verification (computed vs expected mismatch).<br>
<br>
This patch fixes this issue by checking that the plaintext size is<br>
larger than the buffer size and returns an error with a log.<br>
<br>
Fixes: f8be1786b1b8 (&quot;app/crypto-perf: introduce performance test appl=
ication&quot;)<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Shani Peretz &lt;shperetz@nvidia.com&gt;<br>
---<br>
&nbsp;app/test-crypto-perf/cperf_test_vector_parsing.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/app/test-crypto-perf/cperf_test_vector_parsing.c b/app/test-cr=
ypto-perf/cperf_test_vector_parsing.c<br>
index 737d61d4af..04ca9cf019 100644<br>
--- a/app/test-crypto-perf/cperf_test_vector_parsing.c<br>
+++ b/app/test-crypto-perf/cperf_test_vector_parsing.c<br>
@@ -308,6 +308,12 @@ parse_entry(char *entry, struct cperf_test_vector *vec=
tor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strstr(key_token, &quo=
t;plaintext&quot;)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rte_free(vector-&gt;plaintext.data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vector-&gt;plaintext.data =3D data;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (opts-&gt;test =3D=3D CPERF_TEST_TYPE_VERIFY &amp;&amp; data_=
length &gt; opts-&gt;max_buffer_size) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Glo=
bal plaintext larger than buffer_sz\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (tc_found)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vecto=
r-&gt;plaintext.length =3D data_length;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else {<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB7458E16D4DBBC73149AEEFBD8101ADS0PR11MB7458namp_--
