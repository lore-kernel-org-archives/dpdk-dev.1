Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688E9C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:55:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4752A40E3B;
	Tue,  3 Jun 2025 17:55:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1399A40E39
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748966129; x=1780502129;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VK4yiSO1uvS0+WtXxHPKSTZ0DJi95SNjkr3Ty7EOoWg=;
 b=VkgUk9rnu6RwHErdTIZQ9hqSXNdKKOfQZlvIGTxHzgKzuv/iXOThiY9a
 ZU53wH33V1ZALQhacOv2EgaCY2zNfu8c7GmsFcgDfxVMP9a7gxwE1RbGY
 D2bJDvw2C+y0UGUTPdS1YLYbr+NQ74W1naTp3LY4dlMQTzEBpJRDFmgtv
 37i8tHEjbHnfqlJf5ch3M/w0FvbiYU/psDES2mLtrc6nj/2dq8+wuHiNt
 gs2KnWipuXC1f7SgKoJ7jnjL6NNzTLuc7Dl2XAfVF11/3GDbJtHeZTJMi
 9dgOgrUV+e/k7RUDwilDlxBhpGdhzlLD8DT4+1TZZEsMvP9M1HIVWpFmd A==;
X-CSE-ConnectionGUID: hRj4hfksRvqxBw9pif0oTg==
X-CSE-MsgGUID: YdwkIAgdSMWgrh0KdR8lDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51155626"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="51155626"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:55:27 -0700
X-CSE-ConnectionGUID: oIOqUMlLRK2EjHTf6fZOKA==
X-CSE-MsgGUID: xzjjNAf5RKmRiDAhU4eWWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="145866492"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:55:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 08:55:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 08:55:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 08:55:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2N4+87rOkNF1o1zHCHJ6u2zCq/tIiNvXHIpgcwQUPAPLUgTHgjCsR1Jx2O6wASa/uK6Qg+X9iN+6Yc2tgNZLRLcxdxt8EOJnyHS4UE1wJth/IN1M06ha8uBAQoaJGwIrPYlsNvTK6Wjy/R1ubhdH6CNaouOixoSqNI7CC6JQIEvouJpgSDMmC97Lkt8j/VrheGBQLCP4rgThHIXZsFl3iAJRLXhKx+val6USuDeTH+/sdj9ldI4FUnbiCffuR+DnxVBAt6GOMs44vgjaKcnicp+hW8IG3rV+v8VVtYew+41xh6dRO5jBHPFnznaCZ3ag7WkTSwFkQ4A7f9EeZ2BOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvO/ntvf8EcrW72whLZYVIPjUBcm7SQWjZQL//1gNgM=;
 b=xGZKfvkQzxQCl8qsraIyJlvXn1OhIBs7NQYXrhxpyYHDO1k0wKnVfTwKwtI0f7VlO7pjfG/E0a5ZPTrMcx3NxFecLSmieYqkUCXHQ3+lAHMuFrf7bnfIGumie685Txe/y4sK42aKDbgCjmizImqUR+XbT3LsjZtQdm0FJUdw1CnaMfJNhvFrpeqXdeMKLFzZ3buAlXIKDYZz/7Wy6eHnlumFHeCarQn0sI255wgpv5sUU18pYGQKNxmQZZBxNS9hcnfFmcqBpsT4JZXckSvC6x4yBhq4CjqX/p/8sc0eht9vp+zFuvR4ilZqhzGeEZF0+3WFg68fUvzc1mDhWvwgFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9088.namprd11.prod.outlook.com (2603:10b6:208:57a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 15:54:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 15:54:43 +0000
Date: Tue, 3 Jun 2025 16:54:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 03/25] net/ixgbe: match variable names to other drivers
Message-ID: <aD8avvEkTfXTv0Pe@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <a9747feec3fa0883117b7bef8cdfbf2fe9cf5e24.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a9747feec3fa0883117b7bef8cdfbf2fe9cf5e24.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0312.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 556be003-b8d3-4a7c-1259-08dda2b6f512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ehnV5by7oA2swSF5x5cJq6tenxxyafyLcJ6WNPIqXfw6DkOo+inDOQqst+r?=
 =?us-ascii?Q?lcPebnB0LKGUo5sMIXmvHOrvEFfTuOHQC5pdEcUXBgC0XG0i2SN5j+0fKo+r?=
 =?us-ascii?Q?0ZxxzdtD9uHkMgrpKfHA5tKLJt33bT/02VPmV2G6zSSJzAEO5g0WrhcYJaJX?=
 =?us-ascii?Q?m+dYXcVqNydwgFnfwymWrGU6a2SuKTEf8+RBy9dfYlwdOiXh/r9htSbwqvc1?=
 =?us-ascii?Q?NF/ut2kCkWq1agfyxT6bQxf/1fxYYDk2/7bYr0OPKT5/rpdumIJu8MIbOc5Y?=
 =?us-ascii?Q?9L8masQ13B+d+dCyvT4/J9CG//69VsL32w1dWpt/hwWBwuJKPuf29bLnFlMn?=
 =?us-ascii?Q?JnYSnZRaxJuSElIrfppuq7Ngt7OIi9MBCGYwb1DkYT7YO0A1A4peJ2m8L3yy?=
 =?us-ascii?Q?wxV4DJ0kj1zpqYdKgJdkTIok1poReD2+kCh8q0fVrzqkvhvvQQXsUbVEQb9K?=
 =?us-ascii?Q?Mtp28LpIpD5FrMFwlWXYrtm78CiewgpNtBe8X1Bbmgkru8iTf9Nso6jUZ5sD?=
 =?us-ascii?Q?4Lc/h23fBttLQi9mElkXRj4PBPg4keoqZDVUWGty2D6SecsajVvWoHjRTyP8?=
 =?us-ascii?Q?BJJz+sNvvhCNJFNRDA2s3/11Tfj7fD/xr+/HpwTegzSXCU9E8U97LEjSFfio?=
 =?us-ascii?Q?pne+sp+ilDG7i4emJZKiTJwmW9l2ND67e5lVVIldfosVEqHR1ANgkry7x3/G?=
 =?us-ascii?Q?ORO5pBJpOyDmHewHbprmk5xUFhTFBIFquEGSA0BVm0X9z9cwCFGN9j1RfsK1?=
 =?us-ascii?Q?BHN28tToJCmE5VQmC3df4xutSTg8kL9+NPnt5Te/KmDsideZo9lGnpLJd6j4?=
 =?us-ascii?Q?zWOpxK5vSL8sP1rxzP4x2SVEPYSx1mH9QkA5BypPb5Zn42QuplMcZRwqK/fd?=
 =?us-ascii?Q?0lXH5zi1Z30/WX3j3vDJDszx/WaGyUiqdOzjDwmwJKRM/YP17ikE12w6YCsf?=
 =?us-ascii?Q?KnEoD6Ruxk6k4c3miHmPpe/Erdc+f3X8rnwIqhKnivE1e6CoHJYHmeMVfnr3?=
 =?us-ascii?Q?mKXsyGLJDPJdQ0TvR9PxtpGcZSslCnizuqQYZjCmXw9bnd6MMchhSOSX1MGY?=
 =?us-ascii?Q?O//DQENsUM3UVlrvXQr7Ddhy4PX21Qxsel2M49OncoSb5kvgQzSVABmbkoOI?=
 =?us-ascii?Q?f9q+eaEGc2p7qER8upQh9Lmq4LGOc5UEIFlakE07Br7P5zERdraqzy5pesr4?=
 =?us-ascii?Q?QNxTn7+EckbBY/kCItm13xf9THH1C0I9nC9SCj4oTECIbzJTXLhS2P+bUiiw?=
 =?us-ascii?Q?MqJGsz72sxRYEgl6SJJ+oEYbbO8D6uD5WHGmpoC3a2x0UVfFYtCjxRHWW4dM?=
 =?us-ascii?Q?FIIdLseml804slH9ti2t/+KjlmsK4OVg8rlkj8F6jKxaUHL60WJsf2HSKQan?=
 =?us-ascii?Q?0TAFfANMhRiWncbnkgp6X6ngzuRl6UstTbCXCYJNPEllittI7lrvn2mFBfpu?=
 =?us-ascii?Q?PKbXRuxX+jE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?spVLalO3th7Ne7E4pJSIuwvc1fh7GPpl/HHfZ/03DflXb6ozu82ixaYwBxip?=
 =?us-ascii?Q?iKA17Zvd/4pgUuZSPnHFWrKAEpE2M7DtYmpHoJF9k7MAcw9nAU21JK28c2RN?=
 =?us-ascii?Q?t0Fe1aXTrjF7ax5fleR5Q83kDAbPgELLje8PbAYcT36kxCS+2hgfSoJUUolE?=
 =?us-ascii?Q?3xe47ySIYM/YpEfACBJFunlW8hBIzX8v1kAVfwupNgSZy4J7wyAfm6n20W2+?=
 =?us-ascii?Q?ATsnOW/4pBVw6TdNrJI1T7EMSAf7x4naxNxWW2OgbroP/iggCMixYOXSIVkM?=
 =?us-ascii?Q?DKdQkJfCNDhh15X9M3dPfyows7U9pcpUCsyWs00G9tGj3joNEk316qSEVGVt?=
 =?us-ascii?Q?ssIA2vAUfG3jov/nXKxQNgNAMBhckv/04sfw7T9KluD5RPIHuWCxTMXO2YrF?=
 =?us-ascii?Q?eWFHiQmjuV/BGUg2n9EYacbff7Orhgigs4VZ/5KInmZD5H8EQp5Yphys962u?=
 =?us-ascii?Q?DgEjvpUpVrwnGV5DRLafXtfRbyLkpyphyLR5QSmtEVytlm7ycp+cfmDwQL9d?=
 =?us-ascii?Q?ZCCchIOjMzeEJoUU4FPgi6kAMSJJThqkgp+DdW1nqov9UyrkY8aMufKmmUpN?=
 =?us-ascii?Q?o1tvw8l8eHrntplwvw0fdBNk/P4OFyE+DeYhh/1NwJZ4DRWzAA/NbgJzWvzz?=
 =?us-ascii?Q?/gfwUUItDFYFxhWO01ofsjoKOAMu8VlvS69mcAkv/S+N1el+mTrvGpy9RhlU?=
 =?us-ascii?Q?iXUYVPI7+A9kQVXbKjlHtaTfqyhjdUHIdS3pFIHT9yY7llc+HmnEVg0SyIzU?=
 =?us-ascii?Q?Oc9lN5Rl6/QfXpbUupnlPRUmKHiCNFGacYHPypU7E8K9bnFCezl66iUHdeVJ?=
 =?us-ascii?Q?5kRpFUnSGKoER5SHRs6zfCeeSP/GRX+JxbC/sAI/cf2gbpR/0ZAwm6FWQD95?=
 =?us-ascii?Q?gBkeL10Sq5V/IYBy+Mevf+dRc26K73HqCS/25uHbbhJm34akT4GCfsnhYYvN?=
 =?us-ascii?Q?TIfRlzq6t6JOuQbYfjnZk3vYvHEFzyMQ6wnxwNqLzqvSnenSFQb6LkHkzIlF?=
 =?us-ascii?Q?CjdAyzln0WFCqBOdqc/hmuXje4kfnkgAKCduPYaoec4lpWwmAjHgxhJxZAd1?=
 =?us-ascii?Q?z0cWxvne94O6DBoU0UDPGjbzRJCjVvV9uVQ0iYIY9RobKQA5FM2kF3rsRVRg?=
 =?us-ascii?Q?WIEZ7TVlv4TAyOAsWtGD1EzoLs94L9ZXrjdajrqhgRmOW9cgDIG1Q/gzr391?=
 =?us-ascii?Q?3mbFWm6L0WBHm0NfAzsf7t4+tLyY99a4NIwU0eu1my9d0X8cWwVxlC2yWv0H?=
 =?us-ascii?Q?LduD6NBSasGHDcNfiHwTMuLxP8ubW4VAMfq/4MWknKaXn5qEUMypn4eLqV/q?=
 =?us-ascii?Q?lgOSTAD/B3DGt3mvrWNZwJcKa8E+0bKYLnWn2AEM5AdBBNYSN2NhWDMeYAwO?=
 =?us-ascii?Q?n7+NB/USWo0rkH8P/b00ySklj66vDAUfxVwgzKMI8PEQ7dhNEI6k9u3aKwT6?=
 =?us-ascii?Q?PShinDhm+diuryMj9KsVi9iyyp/zGhaaWbCliOC9r7wg7zkKIJ9nLfEAeAxq?=
 =?us-ascii?Q?zB0pIeOav95+9VfHL/m0msNQIO6w9l7jg7tslWKj5CAlThhn1LS2ZyjbD8pY?=
 =?us-ascii?Q?WM07C+i5nYcFsAHEtDNxgG4t/ykWi/V2pH59eQ0pTAgZDjnfwbm2AYJMN4wz?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 556be003-b8d3-4a7c-1259-08dda2b6f512
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:54:43.7678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOnXSbnR6SEyRuAFIhFFyncMbWkbYvO55rywR0quWGdqxr4wXuapMPq1uS9mExcUN+vz/JhPpfNefYIdcbBFElMFyEady2H2UA7JQOUt9yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9088
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

On Fri, May 30, 2025 at 02:56:59PM +0100, Anatoly Burakov wrote:
> Currently, the ixgbe driver has variables that have the same semantics as
> in other drivers, but have different names. Rename these variables to match
> ones in other drivers:
> 
> - rdt_reg_addr -> qrx_tail (Rx ring tail register address)
> - rx_using_sse -> vector_rx (indicates if vectorized path is enabled)
> - mb_pool -> mp (other drivers use this name for mempool)
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

