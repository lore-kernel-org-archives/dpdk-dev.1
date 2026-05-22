Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6892CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:57:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F189E4029F;
	Fri, 22 May 2026 16:57:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id F01814003C;
 Fri, 22 May 2026 16:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779461835; x=1810997835;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7EWzB3qKsSWxII0o1CmR1wfzoECgI2kNvsmkdY0Z4lI=;
 b=DIWRDlOI+jimg09UtHk+DXTD6CsdZ6vfbhG/Bzvlha305NrYORrZWf3y
 pouWDRPngN2VqsnroP0GLOU+z5HInCJYJywcgzO6qMMtBzlB9QirPKBqc
 f1h58QsMdkzleay/ZhvBE38d/fI+2dQaCS9vY48SW4o3TX5BgbwDJiPED
 gAXgCvRbQpklCP2dAVfOICi7WZtp7yZbWe68SeLbYVJeMKzmmYbGwsZDb
 ZPjd4SreYWqJG6b5DhuiIMBYOrH1gyoAv9cG/UVWDB6FM7iHihrhetgn6
 d9RcSQP5QY+tl+sfjJX8+JZidoYD7UjY60zvH7h5d9dmqTLE6dYU6QxSQ g==;
X-CSE-ConnectionGUID: +Nt8SswrTQSrdM5tC9R7QQ==
X-CSE-MsgGUID: X+8s9P73Rve5r4fRm+LaaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="90966203"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="90966203"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:57:14 -0700
X-CSE-ConnectionGUID: ko8o4C9bTbKmCXQeZI0sSA==
X-CSE-MsgGUID: vTdVmcAkRlipDQdL50AaJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="246005403"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:57:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:57:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 07:57:13 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:57:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leRq5NWJ31742lQYkaH8zIg8vLJgTgM3A+1lAAHEh/ugjAtZJuh0GezKukiKC9mcnRz7VCcuwvLK4OL/6jdWJfsbxEdrpqQkC9CT83ViiMWjMXCKLJkUxXs/BYyq7aKE3Kj6Vxlmo5bf2RBtNC/cMMLisPoz0bKuaqX586k+x1jyq9RUDy1JfTYJW7DS1vJYFYqqWI3o+vICeIE8BkyzoHD5OKM2V8rd6KRaYiFE92DtXG0+9ksjqIk/pPn8TQ4A/iIcE5VXxfkbuVduBMHGiGhQLuclOHhyLt/TSBFJm/KLPkLftH3cpoECj+4AE9Lfn7K3weWaKfqVKd2iZqMNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcM2a06m5Xi7Pby2tpUwCBx0pJvINortty2sgq18lsI=;
 b=oaC+WSMXwSzMl1/8zIeugHNaw81t+H5958YWh6abKHVGI4Bz57wK5Qb1QYJ57GnJWsBKSN6XEchKaWy/SUG9/wFi5wtNTfwY7PA2PXpLiebMrvQuDmO7GrL3HX635Reum4/Dyb2Jo5tZQHYGSZlBJXi/NMo5Pqa8GGqKhgbP1HQkVCOuiR5amvtp0/8YQtCVA/ecbnR4qNKDUfk7TrSo+EYdmSdv8lNf2ykdKw61ZmBSALUugjPwV59w+l9pPudtezICZQYmOhsYA6iFg2e2uqAdCb7FhKsXgd5SR4SmhinDt6Yr+T4myVgVQbb7nP9Do1z0YCYa6P3lvaVj6oPF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB9454.namprd11.prod.outlook.com (2603:10b6:8:28c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 14:57:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:57:09 +0000
Date: Fri, 22 May 2026 15:57:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/ice: fix TM node ID validation against configured
 queues
Message-ID: <ahBuwKgxU6gTontR@bricha3-mobl1.ger.corp.intel.com>
References: <20260505123157.1387791-1-ciara.loftus@intel.com>
 <20260520150717.365942-1-ciara.loftus@intel.com>
 <ag3SIFeXpwhWKocg@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ag3SIFeXpwhWKocg@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccd4e7a-19e2-4d3f-6ebb-08deb8126621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|11063799006|56012099003|6133799003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: W/abPXrrLxqXC57UWmCeYoWlAVC5zcYy2KFQGoLqU5GqzCXdy5RPOG4sLS+LyPf74g0L43UO+qY8aYMsPYsZG+eN5kPC2Eh3kBTBYPhg+3e7JHEUPeiSsZ8AVcO387wx6vr0qFP8U0Bd/u6v2oZ2Fs/GYZ0WNZwkQOYuoGeb58Ttnxd+JT8ZDMVhhgld9Z9g2koJ1QAIDaGxmB+YF2RMVlKPQh2lfL89LyXnYnnDL3dAghTPxHcpbxHiUXgcKdINvg/lAKnQ6Iv0c8OhWH74TdmfWMLXSACVfcapeWDejiZVj+9qIIkaw6CCtFVUhXgi+7FNGOQQIHJk2z6nV4FKaSvI/dwLwIJM1g3QvBwZpuYTL3L31KPX52lb9rAAvuiIGFsAjn4eGYN43J7fr3+cwVNO2yiOtMmNzmQXAiv0W9nsYiP50CagRPjEUG3qoz8PFBmtHSo1B8nNPFHIn0MDBNg7QHTg4cWIz3D7SkKGLMlExXEHCVMn9Y12CsIHppj0XGRaVr2eoCO2hzPddsrTI5pau9ljpdMK+2QsE6vf3VHnkcn2LpGGHKOC6ya/w1r0iG6wQtWGo4kb6DNtqEWKFUsNtjnq9WkZ2RtWCoKT6eCFfih7sPW/OkePmGV5Abju6+7nszLJciBGUl6V+p75li8q9Fi2U58GWNbQrGDPFTJPa85OxU2R4lWsJWa5B+zV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(11063799006)(56012099003)(6133799003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YtMlloJcwkBECr9eiWOLCHFdpy5lsL32xqshKuG+z1LbeaqgfnKaMDsUOcHw?=
 =?us-ascii?Q?RVVBku9x6rc4uqRALru7dst5IC6mLjpy+AV17BpNCBTRuWU561CnsKPFBJSS?=
 =?us-ascii?Q?aIuP0e+UrskCgRxtX06H5RzFtEstZBObQ6WnCjzPVs0I+IyS1FrOH8I7Ge2W?=
 =?us-ascii?Q?aPZtfk/w1kq8FJX0FcmoZ4EiVsO3sTZryygKrnJUys/Hnpu7O+tUaTX9CjYh?=
 =?us-ascii?Q?iV8alQrsKfEJa5//JiucvvRiXncnRGk4V4t+IWnmYLl2MqQL8j/j09CQEnIO?=
 =?us-ascii?Q?IHTFZbyAxUWkfOKSMa8hva1m2073sg/1KhQgW7qG3nh/C+XLKFBs48ne8SwJ?=
 =?us-ascii?Q?KYRoUhQGfbyQz0N/9wKDytsMAFfjUD/m/taw9potDAQ2lRkq1MJadqfqIdwk?=
 =?us-ascii?Q?d0PU7Y8QYCcDY9iUBhBVDAMXqKEHXwMMVNm7Zg3/SngYoVpGyOAnv3NZdmZ5?=
 =?us-ascii?Q?f8ab9tm0/JkReYdIfNyXrwZ57W76zaeWUX3Tr9u7MX8g18PgF5Wpue0Q04ZW?=
 =?us-ascii?Q?qXoR3tmhYQM5V+56PAo3Mvj3HkV4gIvrHDYAXRr7TZ6O8z1tGLEBf7zex12A?=
 =?us-ascii?Q?AhWIOSaArYDNtDYwrt6a1a0Du1d0Vxyq1DJHeXS57KkpsPhuMyKk0K00tmIq?=
 =?us-ascii?Q?y6r75oUTAS99Jd14xmwP6/cUoF5CLNdY3IuDHyIlprlz0wqTZH9bMRdcM0bP?=
 =?us-ascii?Q?0bf0Di9PBaMbW8D/8rgma6/kSRTt3a4ko0wl8AHMGunySmdlUBqYv+LFVrRV?=
 =?us-ascii?Q?ZmKOEqVZHX/lLWBzZBTh8HBQyBmUOz6sEAaMmsLAIIVKpDDofGbd5DjA62bf?=
 =?us-ascii?Q?TMJQB1lOSvNigKgxEQqkPfMZOkkhPV/vn4CqPX++FQsDm1iK2JBDeMZIMBIe?=
 =?us-ascii?Q?ov4EqEdxRBf5dziqc9GT0ind/Mb91I6X6Nubjr77fxG7mqKZDEo+g5lhmG4c?=
 =?us-ascii?Q?VRqzTZoM0iOvo6Ha+mradtwkE8G+/+QNEX7loo2lgNAc6yewqQKvhtIi2eCy?=
 =?us-ascii?Q?8VDmhglqbWGNdP2DFxAHwyTEB3TYC8GP+npzkertCOwIvotcoZhSA4aGX4sT?=
 =?us-ascii?Q?OKdQ3eZyZKYxmDWNnUPbP2uEvwPD1ImBWO7xbcbOVzCQEEYLeU8SFrzTrsnk?=
 =?us-ascii?Q?IH4bqUUjQcCIdaiWzclZBWO1weZvRh8aUcAODlzbMIopOKhcrA83EsmDp6ai?=
 =?us-ascii?Q?DAm3c7yAdb+OuQixFoLjBwbRHT+FYaxKqTR8zHskOoAt6eTYxk110Y2FHTuP?=
 =?us-ascii?Q?zgg45gs3I5Kj6siGDGuxvbqL+pcJXnz4PNH5f90O4Qv1z5jl+NNmonOB4ze8?=
 =?us-ascii?Q?96Xj37A6F2eNH+GQsqiv0A2QIQqvoITXOhaTe0maz56tqX8CC/uNWotU1Rin?=
 =?us-ascii?Q?jfcrP82OyWDOdewXQV14c4jbK535BMUkqWEg1J2V7MTs4YyhZx7p7KWKftd3?=
 =?us-ascii?Q?t8ag25rQJx64n3r1ZybpDEr4m2TO4CV423lxBhQfVh+0JR18B75zCDrQJ+vs?=
 =?us-ascii?Q?WppPyzZsLGZdd1L9m1a3jgH4rBF0n8VWoNXAEaQhR9LzhJUeRJDwoM/yKLr9?=
 =?us-ascii?Q?d5PtxLTtfU4WhefZ+x5MP3BP1Fhy/UVwqiLryoOW6jgJobf44MQzdSvZSXQd?=
 =?us-ascii?Q?guXKQ7XASpovrYl4XTB57xO8J7aHMXSVq4gyWYOk4vPpGpCMWEGgTWQEg5F8?=
 =?us-ascii?Q?/SHhrLnQTBDHBep3lCjD6XWxMvjE7cErQUqgzHPEHMchAcpKf+/Jx5g+jNTa?=
 =?us-ascii?Q?QGH2bFcy96SwOE9rlhLc5ENWNoYOeuU=3D?=
X-Exchange-RoutingPolicyChecked: fcytMD1BoLR2fRMTetO5ANkQ85+74BqxBQiImYO3E3t66wIcVH5Vtm4fyzD0jf14LXSguijQwSVuJ2c8EPYpq6tsTc8+gcq5WaRETYnh6zgK/CNC7V0+Ydj9MYDpkJ61XSHf2FD2TgJpGwHjV9T7LHvDoAf7Hf89g/43t2Wa4OWcLEGlV7TwhxmH6m4jtuB8SJ4UvtOxuMkNX1OTokOn5X9jKhEq+9v7AS7s6xYyB+n5ewsog13VbZyZVXTj6moLnR0mzTgbVBE+IRYhLTMxHiI28KOYxe4dik6MIpPbGpfcRq+j0ll/ID7FRl00UiusQHaWEW578PARqQbmA068bQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccd4e7a-19e2-4d3f-6ebb-08deb8126621
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:57:09.7833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwKEh1tbjMV4pVPZpPbBrGuBEXLBGNKtF9He09UgaBmlJlPFb8PNUp9t05V7yPG2BID01fIst24nJSrXXkFOd4P7NH1v6qKHcpy3GpSu920=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9454
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

On Wed, May 20, 2026 at 04:24:16PM +0100, Bruce Richardson wrote:
> On Wed, May 20, 2026 at 03:07:16PM +0000, Ciara Loftus wrote:
> > The leaf node ID boundary is checked against the compile-time constant
> > `RTE_MAX_QUEUES_PER_PORT` (1024) rather than the number of configured Tx
> > queues. The rte_tm specification reserves IDs 0 to N-1 for leaf nodes
> > where N is the configured queue count, so using the constant produces
> > wrong results whenever N is less than 1024.
> > 
> > Fix by using `nb_tx_queues` as the boundary when queues have been
> > configured, falling back to `RTE_MAX_QUEUES_PER_PORT` when `nb_tx_queues`
> > is zero. The zero case arises when the TM hierarchy is built before port
> > queue configuration, which is required to support queue counts beyond
> > the hardware default.
> > 
> > Also add an explicit check in the non-leaf validation path that rejects
> > IDs in the leaf-reserved range. This condition can be triggered two ways:
> > adding a leaf node before its parent chain is complete (the node resolves
> > to a non-leaf level), or assigning a leaf-range ID to a node intended
> > as non-leaf.
> > 
> > Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
