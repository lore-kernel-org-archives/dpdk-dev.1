Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A474BD3E787
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 03:24:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B209540289;
	Thu, 11 Dec 2025 04:24:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9686440285;
 Thu, 11 Dec 2025 04:24:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765423489; x=1796959489;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VFHq6PzNYAH4Use1mj2xxbEtApuTS7V04jQupd1LWFw=;
 b=SYgABjwDeTaK8AZPAg73ajA3rlDrt4NdpLLZFcJcdDtyuXJNBV+6Lqjj
 oM3LdBoIi77F/s29wvS1yqKFP9/Kp3iMUewo2LUdysVYUGHu0BkQzr1k/
 /Q+ze4c2Jfea7bhgb13jGWCm5h+ZPk0JHU+M8vy/atuTXsv3yvY5d9biu
 Gzayo2ZufRUyB9ZLkdoO/KTAGyB8Chlj5sCKvqmL9L73DfZZ9LzYOdCgG
 h1DAZ3KJ/N5vP36AA+e1bETuE3Bky6b2Dwd/WgnsLwJyLP5yOLDb5VSTo
 cWearVplTOqAIkzynBn6yhWzHOpQ9AMl7rhsWDKDLrwgL3uMHonuQuLO9 w==;
X-CSE-ConnectionGUID: 1wNPNuplRv2A2MnTb+QVcA==
X-CSE-MsgGUID: YH/qMpj0Ts2IR6CCt7jvYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67131449"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67131449"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 19:24:47 -0800
X-CSE-ConnectionGUID: AEEUyutBQmqOUdDq1LB+QA==
X-CSE-MsgGUID: ob8nzhdkQgad9x6fCeVvRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="197494314"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 19:24:47 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 19:24:47 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 19:24:47 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 19:24:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKuD5wjiWtiUA0p+fdBimpmJtYzXVGoJwS6Wx/0r9EZPuUXNn0mVBZdcEO0zgRWlf4HqjddaqA+hcW/oJPgTjwpQb8/vGS2+pg3Rqqq/mtWlqqXqIl4Vn1S0AITBDfpWLA1/uxsuv8p2JcOxfEFCccAOL4P3XKepxEzqIFlWdPeh45w1O+PR14t6jBbTsbBsw3DNyYhvrrgGV3h6vz1/w31qXSsPG8Y0PJJlqu8mcIlvff3vzNbrmEnKlLMncS7LcV8yD370PNsCe39c0WzG9UiK1DEmSFw3La5Zu7zFbeltgw1fWXLmaWqsIG7YJRDTYwmUx/r2lA/5QSUWRHa1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJKOSrxpmQqShPLDNgHOn9MzmVal2J4agU1CIL7cvMY=;
 b=QCtv9aMgmIKHqKPp4tKsrUjzRSSHd8QYzqW1HlZjjEWQkLdV65vHYSdbjVlyOrFavtr0Ib15Ysgjq/u1C2uYVMhqYFzB5CkK06Sh9JpXG1wCA3cJ5MBx8Q1fuS5UWcHixeOPfY6eFakXVLduIcYm8J1upHQJhKJpq0qCAzYEGDCVY3MzQztGVYUPO8bNfLcTJQDJKEvG6rnc35WxrCcKkJddjGxrmpM9KJ8ncxQRFTG95WAbBZ1SyAn/pkShuq8e2TdJNUueo038feLcsMakyrHLOXy2YA52fxuEN2+ZOrGX1T1bBKapD2ayUnrbbsHi0MTMdAK4ZNbnQJYjnoDRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 03:24:42 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%3]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 03:24:42 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Zage, David" <david.zage@intel.com>, "Hore, Soumyadeep"
 <soumyadeep.hore@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH v2 1/1] net/e1000: use device timestamp for igc
 read_clock() operation
Thread-Topic: [PATCH v2 1/1] net/e1000: use device timestamp for igc
 read_clock() operation
Thread-Index: AQHcUIRQDYBW/lNWsEGNqPeD0lYJNLUbT0wAgAB69vA=
Date: Thu, 11 Dec 2025 03:24:42 +0000
Message-ID: <IA3PR11MB9254B5F33796A18695D658C1D8A1A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20251108080613.123969-1-yoong.siang.song@intel.com>
 <aTmp_sa2vA_2N3bN@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aTmp_sa2vA_2N3bN@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|IA1PR11MB6145:EE_
x-ms-office365-filtering-correlation-id: d823cc94-1875-4068-6cea-08de3864d352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?WPK2Mxti8/TR15XU7oOH4FJpLZjn5tGhbCQxt5wiARyDzqMyMs+3idwLRtj5?=
 =?us-ascii?Q?U+2ablnqvH6Vk7XBrfzmPkDkphsiNpzB5j12KpdK2gLpJjHprRhGu1aItxXS?=
 =?us-ascii?Q?+ftH5YXn6nJoxaWQOgSs8BJRx9IBKavPhDcIkwHAEgpRH6CkR/zYh8xzD57g?=
 =?us-ascii?Q?u0iUmal6OT6cjWt1CH+oME1l7YJie1zbM8Hk+/nxo026ZqHUnXdDW4MyYV39?=
 =?us-ascii?Q?lDMKWP47orlSj6Mcdc5vuuOuH76PXdDnAxHHaX6G/9l8MUt0z0m14FHChN2k?=
 =?us-ascii?Q?EbXnb5AJbQLum+GjKIEtwaE66qrOy7PW5gY+97RxMIOcfczN+8wJVYKuskD3?=
 =?us-ascii?Q?QtU/lAZOq8XKr0HG4WCeqc153nrl0SlUqreZVl4xD0DD4TcMmPaYaFTSbe8M?=
 =?us-ascii?Q?Tt/shsb3/GGhaKDnl5YMg/UeZA3rjF9s6VwVi4VZBdpnT98vq74Uvxgm5J7U?=
 =?us-ascii?Q?8K5xRGKvivexMLXic9h4+zfvpFISo/XcwNSfplTqNEeH7g9r2X7SMakSMdgB?=
 =?us-ascii?Q?usEgJiTvVMknZQKkfdegy2/ZxdNAz/rc41Ijy6OWGBZlGzcf/Z79QhZrjp5A?=
 =?us-ascii?Q?ZbcEAx4qATiNwMY8bVN0FQTc2DQcEzn2cp3wBzBlFj1vUosw5A/kej2XOEle?=
 =?us-ascii?Q?YKvyuJ33u9uPOSDwLipOxj6a7sBITdyG5ZzRlc7wdI3M0sk8zQbwPLruSSrm?=
 =?us-ascii?Q?wwMvbLcoRyp7Ebm+FWSiz/FR0PQH1zjXwuc1lE65eJYPSzfjscAN74aqDSmc?=
 =?us-ascii?Q?0QASPFAWb3UgKPp8rUWsyoN0pHdh++e+ag1KSibVebjwXACoTC7qdA3+9Uwn?=
 =?us-ascii?Q?nweMNb6XfuKb4AtVeX8WDKv0FnhF/U2NPytp1bJ08Elzqcgj6ZsrdIh6WeGg?=
 =?us-ascii?Q?z0I4je+E/ZuF0dfaMnUdd7znj+K3dWWZ9vJuQq9iRA5XBJPr6T+5kLrSshhP?=
 =?us-ascii?Q?ieU6fpyiB1V+MyQqQQrtNX6hOY0u6I3p++IKgLCauG4cOE0HG7uhUsDU1k6P?=
 =?us-ascii?Q?MZPyVUGqjXWOH4YwBzL6hu8COlC4b+z+PSnFfUx3PwnnQXYkxXoFv6OF0eYJ?=
 =?us-ascii?Q?z0Gx5IBnx/oHoHyC8uhvME6C/PeHWLv0qywMuaOlTk8z4Uimr17fyPdFyJnT?=
 =?us-ascii?Q?uTbIrJKbFtb+iExXGO8VGxb5RomqNIw6IEcjfF2Gsupd52DvstJ8cbvhyzdr?=
 =?us-ascii?Q?uK/ExJiMvh65hukQMlMJrjmae/jj0zLH28Y2UkAKFE1UaM16gpjR5L9iT9LL?=
 =?us-ascii?Q?Iaqi1a/jGwBtn6uE1ikpJANemkc149webVMcsVANgBXTNvyLDp0aZ6lI4/Hl?=
 =?us-ascii?Q?FDyjXx3jVGU5jSdXVGFfnDx/9cIgYV+yOqfsTtnmBpFJgRSObHqo2U9+BH9u?=
 =?us-ascii?Q?nmlEfwuyNYpbyXZ6KhGoT4ZWDkbtQ3sZLyAF/fmPDnilVDD66MbxL05/bY9L?=
 =?us-ascii?Q?vIbDZG0mbegoza1TPP4auPZOCSm477Pn5eHKQhDfrJLeyawxdm0VJY8xx0M6?=
 =?us-ascii?Q?/Bngsjb9jnDQr3HsW0o9Mp1FzlVTC7K8bRUX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9254.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yitplwlc6FXCWpdnXYcdhtHPM+Pm2cqbG+I1NKtaSPFpktM8MSUBxyo9Iv4Q?=
 =?us-ascii?Q?6fT1+8gW6JEormg39sAyYBlPpGjtaFKjC7RWgQX2bW3YLzUlUFBiu8hSPV69?=
 =?us-ascii?Q?ydQ5oiA4SEa7vgHwStCSBqHCFa7FzXX3xVrUOI9wZzJcjgjTpyKbtaPaHqVc?=
 =?us-ascii?Q?VaNWgQYiw3xXwjrXTOWTPlJCHkobPLyKokYONuq4fD+AiSz3uM8EW49jXY6N?=
 =?us-ascii?Q?aC2JyI/7y7TL5CToj991f6tJN6UXEw4iNd+Kq0Z4j+ioHqsqQhlydWAKDYou?=
 =?us-ascii?Q?lw6hp1i+O5LCkoMlumWYIrxCNQwyA+jtTcXq0YJXTjOWR9f3kV0FzHZAF8Ma?=
 =?us-ascii?Q?gogVCGh7gc+EzoZWPekfxImIIJZ/fFBCQxeCSKBS/W8PZiLUGuPVNiAki1sa?=
 =?us-ascii?Q?XhetVMluZIRRg2Nc2ti+S6nWDoHjYO1/KXPWeGDyCYnF2cN33vq3VJEmegid?=
 =?us-ascii?Q?q2ZfscRx+Rgfh2dob952sqGVu8/Z1HkyyrZ2LgMYPWyCKN2tYO2BYSkcrPHm?=
 =?us-ascii?Q?K4EH6xM4nF46JirylgOH9m4FU6f3zav8Fl/L+kDL/uH6RM5f6lu8j8iMyeOt?=
 =?us-ascii?Q?Z+oP98556+kXrdcXtoMobRkSYlpesJEBSuy7RMbHyfNoBVugkSpR2UGz3IOY?=
 =?us-ascii?Q?jQBGhAKgwVD4BOT1eOq7eVwgwshirIPN3iW5+wovMKEd/2CW3T+w1jvilQdP?=
 =?us-ascii?Q?pvAyx3uE9qcyr9UBMzljbZFlY1jiwq8/DfKX1vyLQjnpS9HblZMFK1MTRxJI?=
 =?us-ascii?Q?aQrTcfNBTOCrViHBmYOqquKUQlAn/pCo6/RDDNXr0R9rcamsqxxtqBvCZrzk?=
 =?us-ascii?Q?BH5q7hiurvKFwHcXBFlav5kg9fpP3oNewu6N6X8MKkmIzlBJ66XZqmx7P0OD?=
 =?us-ascii?Q?z6NEMpNvmwV06b42XH/oMSzwwAh66zmaeTqJTXcNA44rQhpgaXnQTkxcqVsw?=
 =?us-ascii?Q?tN3nGgbY7w9rGe3Ij8+TFd+Ho+Aeepe3eGq5CIHidtjEmy4ylSOfKb57imyi?=
 =?us-ascii?Q?gWbU+TpG96xmNFaVxnrJazq6GUv5PDTJmqpyXR5mSR1j3Q+wvkfQrQJxeSBr?=
 =?us-ascii?Q?AoQO18+04X25I9z66fKMO7TiKpGJ/FLn9e1HmugX77kNqdqIvP125J4ZeKXU?=
 =?us-ascii?Q?nNZRBJjwMSyo6k/7H/ItFpWWnveBTJhTw4b0H1j6qRUDoKlacXfIPgdWdbTn?=
 =?us-ascii?Q?W2+SLWn1Jxc2orq6u+1PEhs6yeegO/DZWjCi65iU58wvDuGOVivAuae8IvGf?=
 =?us-ascii?Q?GVI3jJVHNpXMHxyFNkvPobuUJ/+lRzSi5FyPXRV/XMh3Mh0b/lwjyrVhWPaG?=
 =?us-ascii?Q?zMKutqmzS8QVYrIGbcC3xMpM57cIe1dHcpI1nswwmTrrrERK1HFEkHSp7JIE?=
 =?us-ascii?Q?9ylMwVXCCu4UXJHWOKGHKLT3ZvQybvM+xkQpPt97+uIGxXBUxmFOES2zwerl?=
 =?us-ascii?Q?+Ti9db1tGKDbDkMJTDic9XYfdglIjxFrZyH8owKdRAqX2M63FhaMIefmRBby?=
 =?us-ascii?Q?dFd5yl2CmLlEmIGVSy2Hw3i1qGytavZ4cQTfN7WC/Z4sYjemyMbT6YMu4t42?=
 =?us-ascii?Q?XGOBdhy2te1pLsA3Ss8Rv9G0pAhW/jFnrc+ZL5C+6t/rONK3+migqNn+zpU7?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d823cc94-1875-4068-6cea-08de3864d352
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 03:24:42.6276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1WHNWATwimnBTq9LIWZBnKhc7c1xVDdRjgK2fZFlfiKmxgvxbUDD5vgIRRG8gllnunXKGfaVbxA0mnb8iQHCYkOKEIBK1cQ9o6UEA5vaCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
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

On Thursday, December 11, 2025 1:13 AM, Richardson, Bruce <bruce.richardson=
@intel.com> wrote:
>On Sat, Nov 08, 2025 at 04:06:13PM +0800, Song Yoong Siang wrote:
>> Change eth_igc_read_clock() to read from hardware timestamp registers
>> (E1000_SYSTIML/E1000_SYSTIMH) instead of using system clock_gettime().
>>
>> This ensures that the clock reading is consistent with the hardware's
>> internal time base used for Qbv cycle and launch time scheduling,
>> providing better accuracy for Time-Sensitive Networking applications.
>>
>> Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: David Zage <david.zage@intel.com>
>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>> ---
>> v1: https://patches.dpdk.org/project/dpdk/patch/20251107031507.3890366-1=
-
>yoong.siang.song@intel.com/
>>
>> changelog:
>> v1 -> v2
>> - reuse the existing eth_igc_timesync_read_time() (Soumyadeep).
>> ---
>>  drivers/net/intel/e1000/igc_ethdev.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/intel/e1000/igc_ethdev.c
>b/drivers/net/intel/e1000/igc_ethdev.c
>> index b9c91d2446..d4edc82668 100644
>> --- a/drivers/net/intel/e1000/igc_ethdev.c
>> +++ b/drivers/net/intel/e1000/igc_ethdev.c
>> @@ -2813,6 +2813,12 @@ eth_igc_timesync_read_time(struct rte_eth_dev *de=
v,
>struct timespec *ts)
>>  {
>>  	struct e1000_hw *hw =3D IGC_DEV_PRIVATE_HW(dev);
>>
>> +	/*
>> +	 * Reading the SYSTIML register latches the upper 32 bits to the SYSTI=
MH
>> +	 * shadow register for coherent access. As long as we read SYSTIML fir=
st
>> +	 * followed by SYSTIMH, we avoid race conditions where the time rolls
>> +	 * over between the two register reads.
>> +	 */
>
>Not sure this is true. If the nsec value =3D=3D 999,999,999 on read, then =
the
>rollover occurs, the resulting timestamp will be almost 1 second out,
>right?

Thanks for your comment.

According to Section 7.5.1.3.1 of the Intel(r) Ethernet Controller I225/I22=
6
Software User Manual (Revision 1.4.5), the hardware provides atomic access
to the timestamp through a latching mechanism: When SYSTIML is read, the
hardware automatically latches the upper 32 bits into a SYSTIMH shadow
register. This ensures that subsequent reads of SYSTIMH return the value
that was present at the time SYSTIML was read, providing coherent access to
the full timestamp. Therefore, the SYSTIML-first, SYSTIMH-second read
sequence is guaranteed by hardware to be atomic and eliminates the rollover
race condition you mentioned.

>
>Instead, you should probably do one of:
>* read nsec, then sec, then nsec again and verify that nsec2 > nsec1
>* read sec, nsec, then sec, and verify that sec2 =3D=3D sec1
>
>in both casees retrying the reads if the condition fails.
>
>>  	ts->tv_nsec =3D E1000_READ_REG(hw, E1000_SYSTIML);
>>  	ts->tv_sec =3D E1000_READ_REG(hw, E1000_SYSTIMH);
>>
>> @@ -2972,10 +2978,10 @@ eth_igc_timesync_disable(struct rte_eth_dev *dev=
)
>>  static int
>>  eth_igc_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *cloc=
k)
>>  {
>> -	struct timespec system_time;
>> +	struct timespec ts;
>>
>> -	clock_gettime(CLOCK_REALTIME, &system_time);
>> -	*clock =3D system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
>> +	eth_igc_timesync_read_time(dev, &ts);
>> +	*clock =3D rte_timespec_to_ns(&ts);
>>
>>  	return 0;
>>  }
>> --
>> 2.48.1
>>
