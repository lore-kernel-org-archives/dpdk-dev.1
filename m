Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F3C35FFF
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 10:31:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE5A840276;
	Fri, 21 Mar 2025 11:31:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 70C4540269
 for <dev@dpdk.org>; Fri, 21 Mar 2025 11:31:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742553102; x=1774089102;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=6fR8Wt8iYLE8RHak4PygddNxvDhjocEIOjthwDD1+wU=;
 b=SQFgIIKYCV1kpJskQRkFVy60oN+irBe8T8g1iXkqgI2taz8tNqBiihlW
 FVClMH0ANOyVJbHbv2bfYceIGIDlk9lR1oP8bXez506/D8Bqxy8IxVqgg
 RxV9uX0XxuDh8JvspiZRqi8R67agiQxUKE46CNuHlzyJZy+yx0B0ufV/F
 secCnGXbhjvrPgNZQbUU6rQAWgTO+/SDciG7ONgLbcVMQPZUYONiW2tE9
 tccEl5mOxJE6JlKPtFpEAWRMGs1aZTZDEkjJsPbcvHxhJvPUj3KSAvILw
 9NvQLT3wClc+PstnSpE8dOPko8qcKb9GMk/DEgVYs8lB3LsUfM4t3j8Mw g==;
X-CSE-ConnectionGUID: ML2fdAT8RoKwtrxAcfkEWQ==
X-CSE-MsgGUID: Z/dAKzZsTCmgPL/NgefaAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43741373"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208,217";a="43741373"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 03:31:41 -0700
X-CSE-ConnectionGUID: t+a/ZvrxToSvwy5nnxoB1Q==
X-CSE-MsgGUID: 8KzFYVWKSI6a2ninAAeORA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
 d="scan'208,217";a="128472467"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 03:31:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 03:31:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 03:31:39 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 03:31:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/+YhfT0N/bHvoMysVe2gcSXsfmjLf1+Sa32fUxVSVuYfokdRsjx3sEanzLfufo+MHaNjpNkzt6nPL2QzKLtKv+atSQe/tEwUA1CKQW3fokhcLNHJKuBn3RJlLCEzzF4ynmdy5gAybRw5RoJbMPrUKVOtM5/otL0b3/C3FF/E4DoRGSb3wUGfPqK1eEvGsFbCa9KKUNJnj35j5+lCsF0EWV6XI1p+tV6RtEEMYiS0/YurDuSGFpvA3Mf2va0ff4P9w0rvQSpI59d8lrqQbqCWSj+YHNCYndzEtXC3ZFLBxwXJVunr8/14/TBtxxGLZrXgBdJ9YDB0xwi9mdRZnaVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fR8Wt8iYLE8RHak4PygddNxvDhjocEIOjthwDD1+wU=;
 b=SIUA6MTYV9Ac3ptI5Z8I50FnMVtiGTn18sDpWTbideg/tkaULIixjFt6Vn82tCEFvaLTIuEz85VoUCieY6ZrN6T0EButb5UUsID9/v1dfA1M1LQdsNpKM48n3DJuhZ62HRdMFtFtCW8QKDKICgylQXqXSWgyMihfT+hlSnYqW2P7DpLLmhTgP/jevxs82QVlZaUoxIdi5lY89pw1bekKkDnmtmwqAyAFMhDooiCQxU8RtL/SdwvNVaf6JEleXshuedqRnesuOAgFVtv/fvDMagibRlMghKS1k9sN1/QTKVMMdCgEPlkubIJvFqoiFm5+7PnSTi+X7V/YpCHe9IxSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA0PR11MB7792.namprd11.prod.outlook.com (2603:10b6:208:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 10:30:56 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 10:30:56 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Dooley, Brian" <brian.dooley@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>
Subject: Re: [PATCH v1 1/2] maintainers: update for crypto performance test
Thread-Topic: [PATCH v1 1/2] maintainers: update for crypto performance test
Thread-Index: AQHbmaNiYsoo04WpLUKO5YGTXB9GhrN9ZTLO
Date: Fri, 21 Mar 2025 10:30:56 +0000
Message-ID: <DS0PR11MB7458FE1EF46B36E8F91FE6C781DB2@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250320142113.1130872-1-brian.dooley@intel.com>
In-Reply-To: <20250320142113.1130872-1-brian.dooley@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA0PR11MB7792:EE_
x-ms-office365-filtering-correlation-id: 6dcdf5cf-3f7d-4f53-5892-08dd686376df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?H8O59nPpypRqg6rJj+1hItS5IIbfm/IcvcE8qIVd4Wm9s7RZe9PmwlD1I6xh?=
 =?us-ascii?Q?DZYHYMrCu8LskjTPI3ajsEKrGvZq2tlNCiUyNBBl32UoE2yqlLcsWMhJXT38?=
 =?us-ascii?Q?GBffk/RF12I0hmxIt5LKbgDSdkoqZn/xp5P3nXLWukw+EfhCUgwQZB6npd6e?=
 =?us-ascii?Q?IBbPr6pnXgyO6QZcmbASojEW1g65zGqK5KKOVYxlyEDc4EMW+cYbGgPSuU9c?=
 =?us-ascii?Q?MwcfwQdX+dc80CJV9MQ83Auz5GD3EZuUqVh6DrhErOOBqrrI/2mcw4rmcfqF?=
 =?us-ascii?Q?g6DBCJQaHgvwK6YVNL7RWEoOzvKyH3GXY4O6PwnmuaL2a+SbZ4p09KMnZffP?=
 =?us-ascii?Q?8YEVvlHS79QpahmAdTTUsF81hFsjRA8M9IKuJ2iUogl3iwzN/q7xW58WGGGg?=
 =?us-ascii?Q?HeSMBzigaCzz2KAJrHSAqxhFyZ3i3Eu/aMf0VyRsYijxvu3ghNWd0RTohC5D?=
 =?us-ascii?Q?aMfcfSf8+qwQglz4VkXNWIV0TCyYjrEdssCBVxCMZmQPPd2Nv6ATTdbfdxbk?=
 =?us-ascii?Q?yDwZrqyANEaUvxJkd62e5EAB0fPm2tEd7B6Ud3dksaKvzu6KcEFaRbgh7uM+?=
 =?us-ascii?Q?B65OOlimaSfQWgTSKBfsGC6P7l3a+hAIfmhPU49onObHJWbUT7WagpfL3U6B?=
 =?us-ascii?Q?K5I/oA6U/hRgLp5D4rpw0kuhsug2vgyuuQvqd2+0vbvPSQXO6ZUmUjKoAmRl?=
 =?us-ascii?Q?YM1f3R0q32LUhy6L0gC8YTORiGT3COGLRBJ+oN+LyHjh8Nrj1TRi/E4VLOxJ?=
 =?us-ascii?Q?X0LF5Y6XXNfZC0jpHwwWI8ZUObRqHoqgLc8pcEbW4GyPquEFrCuHLlujwgGF?=
 =?us-ascii?Q?U4uY6XeXtz0vu0VrXxYRbzGMprg8ZiPVmmTgFPqzqcv0BvskGmdJqqj0sg7r?=
 =?us-ascii?Q?Ip34etZxV1FMwZ/OTm5CE622Z8qtm9KsnykjeS49eE0LHSCmhA3YtGVHGpCJ?=
 =?us-ascii?Q?LzDwwlxXKQuxEvgYg5iCDyfVrGlbflFKDFA+Z3IsrYy9kVfHk0OI4106Ncs4?=
 =?us-ascii?Q?okfMVjPT+kxT59+ZOVxaIELESEdfCEQczjju1XWLnrG+fnRqoHCQ+kcZ0n+S?=
 =?us-ascii?Q?ipkQoga7ahkKjb1fROwujG3b6JAn2THFqDFgOFnuim1MZZ6n8Y5nVM/unyuz?=
 =?us-ascii?Q?VYnS8L48hxIc8GjQqNqMRQHaCDFLtcVc41vbM1a1OKkI71fCHF3iBK1eXTu8?=
 =?us-ascii?Q?Rwd94nNJ0dPidWTp9K1Bg0GhK7SIZ5rscTIfJPgBt6qIUCMMUpvbtqFCQb+r?=
 =?us-ascii?Q?GoowxwpeRHIikxSrrLzFNNYKxDTHqRMBBSghAgcZqMMUD8okzTNGU2nwkUF/?=
 =?us-ascii?Q?Smn8HZxaif4InbFwKKkIDQXJjT+CqgWHD4+Rqoi+VWAug1UrXB8D6UOtm3HK?=
 =?us-ascii?Q?vGTlIIL2UtIMCATcLNf/EyLTeHP67EEZgdtw95R+a6DnN8J7Pa9O1ZzXw/I2?=
 =?us-ascii?Q?Ezas16z/j+AYUgNGQz8YlIhwBTGEu2p3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ai1i0dMsCoSaepnJzvNTxXkKbWHkaVvJM+aVNzTC5FfqC4NWIZAdkRdw8lcZ?=
 =?us-ascii?Q?aWdwJ7zlLfWVNSRVBknnEkBFWWMpWFSChM7XY8jfvV9Rdp3xOpVkXUQilgKg?=
 =?us-ascii?Q?B7+t8/hqVPYUNNvkjeGvQ1t87h4PCxUtwX1nIlouQ5SAqMl5Tou8ly4x3cgR?=
 =?us-ascii?Q?J9Q3I+TcXpgB48PhxaY50fYyA8jflTnUVCI3ypWDf8wPP+w/kpQDpC+O+Qxi?=
 =?us-ascii?Q?KQTfmDscOWWsy0CZfjMC9Syofm67lh72YU7+T7Tmu7E/SVPuAzp27DxS2hQ8?=
 =?us-ascii?Q?KxgFq7DBagBQUdY27zOY5mHGhREyCsn1Id+x+2HAzxGRKlbNHB7u0zmaD6qL?=
 =?us-ascii?Q?j6GWDsbbrfbOwKbf1S1RJOnycIZZ0Mdhq9y9xUx4gnNNMI49MPyjJPOGi2NZ?=
 =?us-ascii?Q?hAyTU6rSXIZa8omHehmc5pc9w0P/fitpeDV15iGLWdwFhyMOcY9rxH0tGZQc?=
 =?us-ascii?Q?dZ/qYy3vjsJat1Pzb3MVkMyhGcwtoYUEwJ0rnMS2OFVAO/XGXwUq89WnxEi9?=
 =?us-ascii?Q?o4VesbHIma9bc7TY8RZ0h7pk9uwNF1ldVJTmtO3R24Zn/hTbfCBJUAVRElmF?=
 =?us-ascii?Q?Gj2tG/IHpfijCuphauRWnWgde/rOwMByAd4B50p1K/nPE6JxeLwTjcml//4Y?=
 =?us-ascii?Q?QXUUiwA0hAlPZBNkSZQfKJ2hFdFyeiHeBCUI4PcEnxECGEFOf8ucA7s0uZpo?=
 =?us-ascii?Q?f3P1TPRSeKrowqCxthjvnc4rCndMl5gHhG92UR/EVno2fTS1VXf6Kd4BSdHR?=
 =?us-ascii?Q?6K3OzoIANgDHSq1+d1CtAtdsJ2iWxEgAuuRdFP280tyuL9W9rE8XC0KMnh78?=
 =?us-ascii?Q?oYDPLxP89DnwgFD206aTlcX/JyJEkFC3mPWEmrnJBnfLxmlqBHJhA+KV04mt?=
 =?us-ascii?Q?mIr1G3WtoJqrrtueSmHA7RieCwpsP00em1MyZTMZ3ly+17RU/JDMBpMu3XP/?=
 =?us-ascii?Q?W1dPXn/Fjl1HEO+KC+hnHTTO8zbzOslrEwb/Yb4N/VyoyE017b18I+DFnLD4?=
 =?us-ascii?Q?109aOXBMP+nyLKkGrO6nU3Lv/TP+K4zq7vSxuz/azUa28XEJftXPZazHmQBB?=
 =?us-ascii?Q?8lcniZeXidNH3LdZvCmuhS7T/FqfnCTSJ/UpEI5q5IPMHQcoXpy8LidveXyM?=
 =?us-ascii?Q?Mllic5Rx91ATN5dWmhlSGYI9OaxxfRIXJtNjJs1gi5r3xSsyHAypv8ByI6xG?=
 =?us-ascii?Q?8eUFWJk30CA7xG8F0u8fpEVbshOlvCxHIW5KQPLDtj5X0ODShhF6cNwCXs9c?=
 =?us-ascii?Q?tS0V3cYqFpiPUwBUzyOxdNCcQZhvFiSb2s4IvNO802TRhksvdhNc6CUqVbwB?=
 =?us-ascii?Q?iTFay8KILJob0cms0PTaHENrAG+L+WXtpEmoDIcyMYWYuQFCuPPxNGuu+G7P?=
 =?us-ascii?Q?hG+j0ohlPzv8j87c6RhtcrAB3w0REatv4qixPQXWwhkdOq+SZjQ49cuf4xT6?=
 =?us-ascii?Q?Mts6ECSJ7F5Gayy0W1YokTkfHdYGfOMF3UKDZ1q/jPbZm9FKVHBQBt5oCRcL?=
 =?us-ascii?Q?LatUdjn9FSBbDUp1U7iYATM9XM74oW460tSqiynJM/X33Zhy4hkcHbwiLY1V?=
 =?us-ascii?Q?42HDuQKS5FxbhQIJ/UE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458FE1EF46B36E8F91FE6C781DB2DS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcdf5cf-3f7d-4f53-5892-08dd686376df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 10:30:56.1788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wJxe74ABCr25qkW4irKQgWyseuuKYPHAYIcAYghoHPUuGRdVM1H5IgP0/l1xDxLdVroXdx3yeICA3RYRSohkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7792
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

--_000_DS0PR11MB7458FE1EF46B36E8F91FE6C781DB2DS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Dooley, Brian <brian.dooley@intel.com>
Sent: 20 March 2025 14:21
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org <dev@dpdk.org>; gakhil@marvell.com <gakhil@marvell.com>; J=
i, Kai <kai.ji@intel.com>; Dooley, Brian <brian.dooley@intel.com>
Subject: [PATCH v1 1/2] maintainers: update for crypto performance test

Replacing myself as Crypto Perf App maintainer with Kai Ji.

Signed-off-by: Brian Dooley <brian.dooley@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82f6e2f917..cdcea9aa72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1936,7 +1936,7 @@ F: app/test-compress-perf/
 F: doc/guides/tools/comp_perf.rst

 Crypto performance test application
-M: Brian Dooley <brian.dooley@intel.com>
+M: Kai Ji <kai.ji@intel.com>
 T: git://dpdk.org/next/dpdk-next-crypto
 F: app/test-crypto-perf/
 F: doc/guides/tools/cryptoperf.rst
--
2.25.1


--_000_DS0PR11MB7458FE1EF46B36E8F91FE6C781DB2DS0PR11MB7458namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dooley, Brian &lt;bri=
an.dooley@intel.com&gt;<br>
<b>Sent:</b> 20 March 2025 14:21<br>
<b>To:</b> Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; gakhil@marvell.com &lt;gakhil=
@marvell.com&gt;; Ji, Kai &lt;kai.ji@intel.com&gt;; Dooley, Brian &lt;brian=
.dooley@intel.com&gt;<br>
<b>Subject:</b> [PATCH v1 1/2] maintainers: update for crypto performance t=
est</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Replacing myself as Crypto Perf App maintainer wit=
h Kai Ji.<br>
<br>
Signed-off-by: Brian Dooley &lt;brian.dooley@intel.com&gt;<br>
---<br>
&nbsp;MAINTAINERS | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 82f6e2f917..cdcea9aa72 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1936,7 +1936,7 @@ F: app/test-compress-perf/<br>
&nbsp;F: doc/guides/tools/comp_perf.rst<br>
&nbsp;<br>
&nbsp;Crypto performance test application<br>
-M: Brian Dooley &lt;brian.dooley@intel.com&gt;<br>
+M: Kai Ji &lt;kai.ji@intel.com&gt;<br>
&nbsp;T: git://dpdk.org/next/dpdk-next-crypto<br>
&nbsp;F: app/test-crypto-perf/<br>
&nbsp;F: doc/guides/tools/cryptoperf.rst<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB7458FE1EF46B36E8F91FE6C781DB2DS0PR11MB7458namp_--
