Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D26EDB7F2
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 10:47:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96E3A40265;
	Tue,  7 Apr 2026 12:47:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 01E574025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 12:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775558842; x=1807094842;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=p8w2d0Vb8HMOJ8PoMc1AFC4/sCBIoFi0ODyGHRWbkqY=;
 b=gZPS7KuAefLblK58naVV3VGkHHn1lg7DG13Dh6C1qFgVIyoAtg2cSBvH
 3re9VRKC6yzlCFdvHPX8snQaj9jX9oupb+TFV3J7NbpUkazS4IvTvowQm
 sXz9uJi1Gs6j12HAwxeSyf2/i9AXUvw25A7f29Bj3psAP+R0l7c0FcP8E
 mUdALn06hJbWnw75S76xmZCMuBcVeCGkuOPNM5TNaENt0k5cGXvQjDG0Z
 qqDS+/fp5ukV5Ildp6w7Cb7S5O812j2CX8f8HHEFAALHEy/jmdmylcW9X
 wJKDXAr6R+bWOAuHQX24KboQQ5oayvpI9dX18xE/NiPFUsgEw49BNouWl Q==;
X-CSE-ConnectionGUID: +iOK7ozSQT6VqsvttKXrZA==
X-CSE-MsgGUID: vXg1F5e4QeyBpMvGq07niQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="87144919"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="87144919"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 03:47:21 -0700
X-CSE-ConnectionGUID: 09lslPpTTWyRJLuCzjqcKA==
X-CSE-MsgGUID: gjL6/x7iTnSlMwPMV8sDpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="233008742"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 03:47:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 03:47:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 03:47:20 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 03:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiG4TIlsBEqJ5+xrzbVUL44zP6xmsqPva+8hRDxBv/P/5xHiwyibJP58Svt9Qcz9c4v6qrCCggANOqxbpqcw90ABi/RvcdkV0WIY5ZhE9z2Ul44eN0ykTf4tyDmyLqK2GZs1GsyXY1e60qDw/vbAoZYfveWAjTqVDDrPsXVnvT1r4wh3xjVAipjTewlKkTboY5LvHTcIsBM9T/mzWoK6Ep3kON7VqSYuVv2conMaClnSGaC1cJyj1XDhAJWRD6asEAd8RVDJ+1y9x6lRSmdpPIfz8VeIHy6XUqreyjZfuzr1cpVqrIp+MAjiOQpZYQ48OLTHW1V+y6JdVjlBfVhI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpSqJPNBVquy6mcaRUv1Mtt1t1Br3Yx/Qd+tBCvaHNY=;
 b=PnjMDZCBJ+mG2dPaYqt1mtkI4NBMRq3ZhO7I8FQZK7k5OCjDmleT9BvsXolkvGK3OaM6zUcrrEHVK0eSQ8sPoYidMznvUbzk++BH7y/OqepS2+thg92BoTiBLZQ1wuPav0sGi6DRuJYXvzD2S6qNmT0EHYY1HF5cKOSvaI7iX6xOHLFjYb43v4dK33zRwFL0WzHzlV2PfLCaqw/Zrm5QUGcurnEAxDRz8OyyGIKj3z1BcilOFcbyXy0bdhMOTCPvt2PAcshY7j3QDc6Uqj1XtBkVR9EEbclaR7Suny4GRjseuzE5qhiNbVG1aI2wVvxDxcVZ1g18/dVZClq7sB1Q7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LVUPR11MB9566.namprd11.prod.outlook.com (2603:10b6:408:39e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:47:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:47:13 +0000
Date: Tue, 7 Apr 2026 11:47:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jay Wang <jay.wang2@arm.com>
CC: Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, <nd@arm.com>
Subject: Re: [PATCH v2] net/ice: add NEON-optimised Rx/Tx vector paths
Message-ID: <adTgq107Xrq4yLD0@bricha3-mobl1.ger.corp.intel.com>
References: <20260323183231.3988257-2-jay.wang2@arm.com>
 <20260324162525.4083381-1-jay.wang2@arm.com>
 <20260324162525.4083381-3-jay.wang2@arm.com>
 <ac_Pv0hhrBFlY5oy@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac_Pv0hhrBFlY5oy@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LVUPR11MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a6094c-fc08-4668-e311-08de949306eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: fEQ+uCGP2GP+hmskyBDftHjmhays3giIOYugImvI+rU1D9JB3L0lDOAL3TWGJwLJtjnJgSSDTEbDEbKF/oQPYq5Ebjex0H4YjsaCqHc9zlyeJAeu+PkAbVWc8akWP2t86qsa8nd55HavzmojxN0zczzwXf5y7+Bf6yRPkM2jYmE/EsPjARQOHiDJWiOBPKDdZEuyQ5NFfOd+4OZaLfz2qTME87YxnCxDC95TMWKkcH3Qx4576NhG4OcOmqdsYbuXpzzsq+Wd+qtG32tgwQFwzCR7i1GjpRDPgnwM2kQmUjmUq7lXmiQdAPVb+EwecAVTcBZJ92KCuNeyJRoRhZaZiVMGpbSshoYgUpRQyzmmiSSsSzCsGzlNEsVihp4qaGV4vzVielY5S8NU7QDYqeYo2Pv2NZANCsEJIefU0hJ4wpNe0i2kUcrO+pQj1+rtOzDv5jvGbEVo/LPDVbhmeY113XCUkrpnSc8Dt8RkLLq8wQcnk/sK9iZ0nYbjQQA73klIhUpIDeH4eUQJsS8mb5rYBgwqgQSVQiE1JohQBBb2XakRJm/YIVb21z69S7/C1w5rJcSAyR3JSmZoSQj91/RNJIm8w9co+QqOwESB/6pHscMhU0XaZ1Qsu1JiZ/S3fByaM6LsmOOWZOSiEwS/sapw4n8ULEzX0jmNNfLvIMeuNX2NSBmalwCp/HDOILXFGPUXdwQkVO/Bvy1Vk+nf94fxq40xmnlw0X5uyCc7jLbgmig=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/WHb1jOlzm0BTnDoztZzz7vyZPSfumGV7HX8k89Am21uEQI2zVrB+bM2kE+b?=
 =?us-ascii?Q?jjvFNgvIBl6FYtUMHb1kzMv19FLNhLcqRYnaJ3EJGWcfeFlg4wDzP/kZpiG3?=
 =?us-ascii?Q?vg5ja4XX5yR51O1+pzvm3j0XLmxPxds40GrSnvTFWlLCWv2tmL9t/qAunJAg?=
 =?us-ascii?Q?Rqbqcrd13PAq4APQEqNPsg7vq63RfrONqqPh47w0o9G9zGQCGRApU0vwgSrP?=
 =?us-ascii?Q?x4mlgB4OoVYM2su6nI/pyRdv6qlV8lmnX0mvBHu1SkXprtOEznfppTKcGCHE?=
 =?us-ascii?Q?b9swEj+ERvxQcYwE8OrrB6O3TL9RIO7NAx1BXtTb82J3npYnqyIy2EKXQX5a?=
 =?us-ascii?Q?PRSzOjiUnmzPteB1n5v9uRO+FpuRsYTO114pd4j/H9CD8HmLbCpZu0Qt8Y/H?=
 =?us-ascii?Q?NWkXNcIfCkAUbIbMr4x0v1dshsnYTPlVg4D7OhUQSxFVZLg48jNjrZbKnS/8?=
 =?us-ascii?Q?1VGBOq8FYX0DZUnJ33a41q/QaoCg9xa/fymitbM5PeUujl4XqafdZUmK+qZ3?=
 =?us-ascii?Q?3Nlp4EG0qzbY4k4o8y2B4ASWZ06bPY6nJO5Uxmi3al9s1cImcNuixVz12qNq?=
 =?us-ascii?Q?KxVxEFKxhWyeluwVvJFZm6qe22qXHCgufFAdIV6+Y+FOLh62N//YZB5vXuP/?=
 =?us-ascii?Q?bXTCzUybYXSGSeWfJyVJPGk9T+48qI2k1dHaK9pJVYKt6WuDDdd+IftcHmEn?=
 =?us-ascii?Q?jGGseY8vmOqwQK8SNqfVPTD8beueCNmjyftS8lHuXSoKDkotbY1V9Zl3QSuU?=
 =?us-ascii?Q?wLzQQly3FgmProeYz3S1XWYboQJ6BLyNEm2o5VJcZwccih8wtTjJa2mLMr/n?=
 =?us-ascii?Q?kRx8unUUqT0w1qnaw25mjqx2hv5lElGJlMJiqs1m7yzZeZ8KxCzQbb1O2chE?=
 =?us-ascii?Q?fv9l30kZrS6tHYqD+MueDYEnsDKN9uV0w8ByuA1anOb/QFLQosHShyk0DU+m?=
 =?us-ascii?Q?CUcjwT+r8J47tKHveEBmRS4CnqipkG9d6OphMlUax9fH5V0GswU5g31xKtxt?=
 =?us-ascii?Q?MV543bcpBoMUf0QTzz399Vw3DtPIe4Jg8uf4DEYdkscnXs0v6JQ9oOIxxSld?=
 =?us-ascii?Q?wnoZWXpvbbjVfJ8VFFXZyUi21E4uNrsOwHGFxR+8pZYFakMRcpfpZClAdMJ4?=
 =?us-ascii?Q?Rj37vVpA4MpzkMjrYVGMYMMaSCWeFGu2B8Hyd+SCAdyweuimH5qjqEgORQrc?=
 =?us-ascii?Q?qLnFrQ72UtfJ2ch75g/DXq4pvTVNQ3sEqHpiBRqliDNs/x7NMYyTiyGOPpo+?=
 =?us-ascii?Q?OfroX1b0C3V8sWPr3VUflWeHJ2tgpGo4MutByxGHPeV9Dnc5uc1/udrybdWU?=
 =?us-ascii?Q?FXI+sXYlbaWwwjuTG6KZzobSoZejT4yUQnGzmQ+AVYI/rXv9Aus8+2cC3DVE?=
 =?us-ascii?Q?51tM5fo9PnJxnMn68iiIJVpiwC/+enmmhWS/9XE6EbL8cCFKobN4n7ee28Xu?=
 =?us-ascii?Q?xguZ1g+iU0Y9RYuVIPzMpX0lYx2zr8LyO2JvT8EPrVS9k5WtD3+Gt+I2k8zC?=
 =?us-ascii?Q?10v1bX1LOFWjfLswSUivcXkWVhMlwMgCuY471SCMmQvmotNNTai7kVy1X5Gp?=
 =?us-ascii?Q?kR/p/RCj3YBocb8l8UkxuEee8UerfuoU1uPhEXX5sijpkKcP+gTR/AaBeQJ2?=
 =?us-ascii?Q?8PqkOzfGeL0PCzvVkv8G4gKR5NVCVpRgEl0pEXQ1KOuGLM93Xuv17FOcVsB9?=
 =?us-ascii?Q?wUNR7+07r5szoUWfHkuxDs1slqXY84BTEv0zxgVZLaBcyIDnIhjP+EYFEHVa?=
 =?us-ascii?Q?kMEKytvLT6apPB5gyiuBDGJnMXuZK9w=3D?=
X-Exchange-RoutingPolicyChecked: VjoGN/9o4/mCn6tyydK83BdSbNSazgwQDsdKakXfjYZg7Rb8xFslOV1tsB7pDm4emvuYiyeOZzhR3XRSrRo5SvEYhP3mhE/T48VrYbpFhVHi1n7Fzg/FBPov+PVRiqtSTlXgt39aPZLLr/hYScOsLDCxnlhRNhudjaGcXd8h6WjddB/fyqesXKPjCPDgVc2ItIOqp4sH4GUYFa9XXgOXVgoaZwy8t9o66oTOPIwN9HqZg5PxLUw/e6ZF3Co72GpUCEuy7b9R16HhU79OBisqjlD/7T7n7bkeFTGv6ZxFCrYb7ZbkREN+wHlq7JBUXbZ5nYjicWEf1YOCGNQu3NRL/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a6094c-fc08-4668-e311-08de949306eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:47:13.2892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8KeNjPTuF+C5gKI8Mu1bbdlYYPUrVPkh3EFBtefP4ehEeA1XT72NxH+LV4BdrKkBQcO2AXmjC+IhVQ9YZEsAhko6ViVllA7LklOnSbxUz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9566
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

On Fri, Apr 03, 2026 at 03:33:35PM +0100, Bruce Richardson wrote:
> On Tue, Mar 24, 2026 at 04:25:24PM +0000, Jay Wang wrote:
> > This patch adds the NEON-optimised Rx and Tx paths to the ice driver.
> > 
> > Tested on Ampere One platform with Intel E810-C NIC and 100G connection.
> > Tested with a single core and testpmd io forwarding mode. Observed
> > ~30% performance boost in the above test compared to the default scalar
> > path.
> > 
> > Signed-off-by: Jay Wang <jay.wang2@arm.com>
> > ---
> >  .mailmap                                  |   1 +
> >  drivers/net/intel/ice/ice_ethdev.h        |   3 +
> >  drivers/net/intel/ice/ice_rxtx.c          |  53 +-
> >  drivers/net/intel/ice/ice_rxtx.h          |   6 +
> >  drivers/net/intel/ice/ice_rxtx_vec_neon.c | 761 ++++++++++++++++++++++
> >  drivers/net/intel/ice/meson.build         |   2 +
> >  6 files changed, 824 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/net/intel/ice/ice_rxtx_vec_neon.c
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Applied to dpdk-next-net-intel
> 
Unfortunately, I've had to back this patch out again as it has caused
errors in the CI over the weekend e.g. [1]. No errors were reported with
the patch before I merged it, but I see now that not all tests were
successfully run on it. Can you please take a look at the CI errors
reported and submit a new version of this patch.

Thanks,
/Bruce


[1] https://lab.dpdk.org/results/dashboard/testruns/logs/1985291/
