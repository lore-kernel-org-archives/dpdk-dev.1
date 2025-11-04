Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D052CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 13:27:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF8A9402D7;
	Tue,  4 Nov 2025 14:27:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id EC6B640269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 14:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762262849; x=1793798849;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=J8jXdvvH/auJVbJ7Cg5G5lKfCOzba3tisQ5DMuKq31M=;
 b=K5GAQI6rNM1gHxC1Q8KzGuDNShOkl4wJ43bi0CijLVGD0at7Sr/kH4X/
 VnyDVJhQl0MmA/GOaW48LXQzhrVi10JOprkuQ6r/5nQfVBXQ3vbNUnxmS
 cK2UU9wH2LYY9VXL2BRALzBu47rEClQbyNLD/R4oOye/Y3FODyhRt0MOJ
 N7wHYvBQ0ntGycrMD+e0F5P5hVH29EjjJfDQQHnvPlJJQG2ltWf2AbJ8n
 kxwa4OhkIt0SgI3W/Rxdqz0RNB/eGMVJALrWUuhJi2Gi8h/AidSdIJWOV
 8vzr4IyrY0jlciEOghiLiLu4soG48MLQ+bMvmZqYCgKvpy7oIbXwmUDaY Q==;
X-CSE-ConnectionGUID: Kwc4xUUoQ4i50sAufQPYaw==
X-CSE-MsgGUID: LGfQbucLSGu2ytOIAh58vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64284437"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64284437"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 05:27:28 -0800
X-CSE-ConnectionGUID: NN8VjDbBQZ+PS6s0WyYKQQ==
X-CSE-MsgGUID: 8uVL0b6cSImEVPyK/y7Abw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="187888606"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 05:27:28 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 05:27:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 05:27:28 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 05:27:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFJPC62SZY1HDnMbmCWYLz1B86wSk5IuRAZAkGdPnklrQU/MlaBHz6QpJPHaqMJComvrs2xS+n92DSChrw0tx0KwdofgApJeQWs3t0rv4NqHNLujw1Q0Dv2CIUp3q7lAyVNYICpe1h1+LZilA6DBLcroas+kFXuJwPQqOc34gg3AS4shNTvzK3UgN0V7jIWC0WcVOgs+WGzqWFsuxO6tjCDE7iJFljnroVxqJ4yYwVJVl7PK0lwFuO8iof6llIWqiFvkDXuerlq/T8zaXVkx2y8huMH9qXP1ig544i91uqVoVqIHNowechTi45AIEv46UfHXukDilcLy8Q6UOKabnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgaKZhLCyAGO4kj9EMCzEJk8RxPX3VJOhO3AIbAR81o=;
 b=epbtIVzaGgM3OrGfZ09OI/zukSQYq+mdJY/Tcp7NhX4WwYQq7+umsVmocx5I2ffqT+BX7OVGO+f1Fqn8FQJjlX2tab+r6haDa1Zo9MuzKpBIVobYc+u1zyXzGxOX6uH8hvU6S02TUYKDWzETgl/Vr/miaJGtFS3pKbaUpA6MF7fIkCDorRUxwMS5DgFD5EsbDZIVRnMUHLmXPQ2McJWd5HXTHBUrmhr5LWlbdD4bHPRSNVzRK6eM4FQ+uyiiVOGnQwHjzTjhGQbv177JNAMPWYataEB9hpL/YC96umy1oSZOta+cBIlAqPU+r5kK+ZhP1E+McZu2PzG2AgkH+sQRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF807974CA6.namprd11.prod.outlook.com (2603:10b6:f:fc00::f33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:27:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 13:27:23 +0000
Date: Tue, 4 Nov 2025 13:27:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3] doc: update documentation for ICE DCB and PFC features
Message-ID: <aQn_Nzo16b7loInb@bricha3-mobl1.ger.corp.intel.com>
References: <20251103155150.965108-1-vladimir.medvedkin@intel.com>
 <20251103172621.970792-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103172621.970792-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF807974CA6:EE_
X-MS-Office365-Filtering-Correlation-Id: a6062e29-8300-48e0-426c-08de1ba5e3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NTtzMyqA3cbnPxsEy+AMT2yOeQsWTczQyWb4xw7IF36DVELL50pqK4wNytoG?=
 =?us-ascii?Q?7cG/C4cnMsgJJey/E+FilygHpBivKME0+/mi+Iz7zChfy4khkf6XUlWA+oeq?=
 =?us-ascii?Q?9Mb+xV0GRZaYWhGHli6+pjrumAZ5nqnsuZ5Vp6H/550aWNxO50MFJkjMi/R3?=
 =?us-ascii?Q?guVrGg7Lr8wmCbEuBzCQ01sAfK6udNaNLj8pa/BfjZ1cnQCXYsnDg12riWxJ?=
 =?us-ascii?Q?VkCTGxx2gUvMrl7UTU8RBcGIw817BKdlDRkh6OeTlJ89NRf43NAraSSjutxO?=
 =?us-ascii?Q?tDieT4WXQGiEgUm3z7oaTkXnu1FPe9y+nJn4PGgJWxRRCUlV/mLTu73BHlxa?=
 =?us-ascii?Q?9jjPoBaTgoKqrjeWtAZQg3FynJKyDCgb2/VQQBsxP0ZNwpc3ggrgjCdFX3GC?=
 =?us-ascii?Q?1usoynwG23wTIIzHjDLJPZkL2my7urVxh1L4ZjOHoIwsdZrtE1geEged5MLm?=
 =?us-ascii?Q?khhHzdAl5To2MA67A/InR307jQp91I/1qMw+zYI72PZEsPa+iTNuRUohcUZ7?=
 =?us-ascii?Q?jShASKUnfTGupNUWOK8A60Gqk+RticrzPBKzAgWT2pGY5TpDsNvAVaJ2ZZ0H?=
 =?us-ascii?Q?ku/jMJP7Wft8TKOG3gBYYtISGJx0UMx6s1Fyrb6Tvqu5ffQg6ydPtZACQmsy?=
 =?us-ascii?Q?VKm+ZkqtkrNmTH9R9GLIHslf3BlSutIryAkyMgwYblzi3d4PFOHm+ikYcbR2?=
 =?us-ascii?Q?GBZTM/d2Vp4IEFcPw3jBKKOUb2cPnakKN0HY/UQqhjbcd+S9SUsG0i7L7kLd?=
 =?us-ascii?Q?E0hBooZ7KtUV2sdyX6C/hZAz/dcRSBf14aOUZ9/hAHA6i/WdMwu3uacXyie/?=
 =?us-ascii?Q?f83+XBptVkJdSlZgnQIcNQsd4wczzqzKCH+0xpYwEy0B0gopsCVupn9fycL7?=
 =?us-ascii?Q?gmNWBqUmBjxagNGU3BkOLwk+WAKivfxm/J6GD02Ms6DRf8FLQgql1B6MNDO9?=
 =?us-ascii?Q?n0+kqEJpYYrDmNXRJfBNdnM1xwlfVXvsemBXqYZUi9lusmD7Tk7Mlku+TS3b?=
 =?us-ascii?Q?CK7BVOv71bDtVREWyXXrozDabntQk/EVgcxZvqmDKsRHdwbK/u7W3uCPJY/G?=
 =?us-ascii?Q?fX1faUEwsEX14iq+EeTTDpm2+w2ubVQSUp/zmoT3hAj4ycm7N6sbALnqCZZy?=
 =?us-ascii?Q?f8g5+xUBL8FgLlj+wIrJBLmZCh1cC7R95K1Ms/NCH0ETyLeCYLhcKhSuKbtt?=
 =?us-ascii?Q?XvYcDC0+XaOPCRKdO0bcJA4Ycag9pmDK0E/2NDrMfRK8AsVVLjto9EBoQ/AO?=
 =?us-ascii?Q?TPcbGjgiLZdSua3K8JDeed5O0zAqRTVb2KDVcmVDXfbKUqmpOnunx5bMI/af?=
 =?us-ascii?Q?mK1CoobQbJXG+D8E3+SfKH3bukKbs8sK2ahsX/cSB+HzitOa6jPOEP9Bzd76?=
 =?us-ascii?Q?wJStbJ5ZusIzjxd1cqhM+53oSzGj9arZD9G3KUcWeRBTHVQ9vR3AhGTtptXc?=
 =?us-ascii?Q?tq5L6PIVWRf4KKY/qHQG+HXIqoc184VQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqkXFJQBECrUjnhxbXJsQS7J3kQjffGrTZvSNP6e/9l59aPDRUr3Fh7m3Fq6?=
 =?us-ascii?Q?IhcOY2lL2CSfSaSnmyfouSO9zKoj9eqMSayGQNqy6ZbO+5XAwS9MEAKnXHmR?=
 =?us-ascii?Q?XUodKzGz5tGtzpQR1fVxq8sJRgFT41Mv8mxIV8Ay1zfSSLRZii/IYfJZuv93?=
 =?us-ascii?Q?mlsB9C1RXMovefGJ9SGuEbksTqD9uYvfVLaVeF9T7ks5mgtpII2yhAR2hr5p?=
 =?us-ascii?Q?9stcHN4nx6ORzdjctGdzJvAnEtEEHstsoZY1wTtGunpPBjmo6sOWI2KdjrOa?=
 =?us-ascii?Q?CMcQm1lznmQCuiXLLVUG2c3atx4BSFReFXgHrcn9t/y523gOzRYKyYJ/tWGu?=
 =?us-ascii?Q?skiAQ8Xgi8NgsMHk75/Hd3rQZfqcATjWCDLAX1faTRKq5k0uHwihtw7DZFoL?=
 =?us-ascii?Q?uWV77ZCSIYjc5TLqU3WpIjU2eJLiy6nmI4ft3nEGSVP+vUvNYP+L+FB1lVO9?=
 =?us-ascii?Q?968ag3CJxbMbk8N7QtiAZDMEwOE1LnQZWPKzVYX2uKb+9K5YRUmtvmKkUtvt?=
 =?us-ascii?Q?AkGITpMoEaqX973MqOlFhh9P3N1eiWLSOfqmMddo6V8z+GzFTv7icqzRO8Q+?=
 =?us-ascii?Q?yu5IL1/rttfERLuSfxWR2UDyj3VjHEd1aqLL6MeN/j7GDLAm4C/UCRlRkukm?=
 =?us-ascii?Q?l4ey23iWRf1YbYqpDMGWOcv721zlILX80dY0VnANW/j6E2JYZnaWLrKwS+Ig?=
 =?us-ascii?Q?4fcEHC3eEEeW0ft1W7EJJVlPWrdnp0+id6cHviCN8hXdpRqX8CH5C8tod/V2?=
 =?us-ascii?Q?ai6GE5+nTpqJav+HUozV3FWhA6iza/58T+fuNE8ve5ilY28UkrIU8+v9FwWG?=
 =?us-ascii?Q?DWtDWRUP7t9FAMEe4baPyacLvQKoPiXqRRSjfPXe2jy1qZcdM28818weZ/SR?=
 =?us-ascii?Q?pN1xCKpwYCIYlLun7Yd1jNHOcYgMbovzY+A8wnsLGyfvO7z30Q8SVyU7mTnZ?=
 =?us-ascii?Q?F538LivSwqfx1C83F2dEzbeOvHXREm+HqWtTR0nwBc0z60rTjnrMZqFuKA5b?=
 =?us-ascii?Q?n4ltrEk7MATdT8gRJRg/tCDfpfI4q/zk43mGAYAMbUWf+ZEyDvAqdNP+naQE?=
 =?us-ascii?Q?Xwjwl5+V+tKQhJrqM1Ez5On8cJlJeFliBffvi0BIWuUSxXS7x5ZWLyOw1/kI?=
 =?us-ascii?Q?aOpU9SyEnmcWaCR5rxBKRvbU3DuhpPr85FWF+fCSR4OYoTDRl+lvmG/vYnJl?=
 =?us-ascii?Q?dntpHYLEZfEOgg5lKTe3njSEn1C2nvQmBqaRmHxLh41cOPeoI52KO702EV5x?=
 =?us-ascii?Q?wcuG/Dhqesnjp8T5abyKWNFEaUCoDSBUyVNtEzA1PJ/vCd7hkXkvMT2tNW0+?=
 =?us-ascii?Q?3dlIIRBnJTpo4xon1eA0tRCkUevK+GMbOApmfLOdkgQoWKHR/we2NAD5iME4?=
 =?us-ascii?Q?etNObVSgSf3R8mF6z+lhqDvLLZO8BDNgW/JVdR9T9ncEKJlkwL/mWdefeULs?=
 =?us-ascii?Q?Ox/08e72fqvb4KbvYU+6WsiGprrPbhv6kKDcg9OctsYlG8yxSmIjAGyebgnV?=
 =?us-ascii?Q?81WO3ChpzTWGC9zMxkpzdV8+btY46p5UJE6vz0JdM+JttFfTxQQeiTN+xmiv?=
 =?us-ascii?Q?k/HA/efvLn1PVvRM17q2EpM0ZxtqmNYBDpPHkHCFZFLyl4kDsFP7chi4NACX?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6062e29-8300-48e0-426c-08de1ba5e3a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:27:23.7818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQNlACASxjRSntv14NuQvl/W+XXxuV5e6rK3RNyDOEViW32Ag6VTAt1O3hUCHde3ws9WORbEbV2m3JDZDRIjOgRxQECSgqiYUyj737HNmnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF807974CA6
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

On Mon, Nov 03, 2025 at 05:26:21PM +0000, Vladimir Medvedkin wrote:
> Add DCB and PFC documentation. Update feature matrix
> and release notes.
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>  doc/guides/nics/features/ice.ini       |   1 +
>  doc/guides/nics/ice.rst                | 102 +++++++++++++++++++++++++
>  doc/guides/rel_notes/release_25_11.rst |   4 +
>  3 files changed, 107 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
