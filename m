Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D72CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 10:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 705AE402EE;
	Mon,  8 Sep 2025 12:49:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C279440264
 for <dev@dpdk.org>; Mon,  8 Sep 2025 12:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757328590; x=1788864590;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SpCvGAT1SSVC8dSWl8B/Xm+xCMCboq7wdGsLz6JIb+w=;
 b=CHkYZdOh6G1LwrzY/L95vo2pgN2YSYePhpekwCPW32G+O7fd7oPDrX50
 bu32/8kdhYxhS4E9tfMVGEMndYZ6cZG9GQY/+Dx6EreraeWzOwllH20s4
 y2uJ40hQq7j04wAjjxi9op+OfsVhTZHnqI2P9Vzf293VQO0jvmdRNP6oX
 /DiH0XI0ate+dDRAp+JZI8l5WdGQvBOAg7YNx4ZBrMmXnOWFpAiDHrLQO
 3YmfcVZVmSQ+xMJrQNKg8CKp3MUzPdwZjykbm2i31kSRoQ25s5hpghTji
 zqxYvMV1kvr8+LR6zYwcqbc/dZ4L4JxXki69Y7THMkP0ywBjWiqyXbBT3 w==;
X-CSE-ConnectionGUID: 1RSqrXhrR3+z1xcQ3G+x+Q==
X-CSE-MsgGUID: sHkjEzNTQkGtc586tWpj1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59690504"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; d="scan'208";a="59690504"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 03:49:49 -0700
X-CSE-ConnectionGUID: wLf+yJd0Rse15Ryu82VB7g==
X-CSE-MsgGUID: PA+qlxzoSbq6SxBH5zfDcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; d="scan'208";a="172022885"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 03:49:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 03:49:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 03:49:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.40)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 03:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNXpLbr1q7jLEFLrWmvhOH+fg9IkRoGDmdOHrqw1CitTYBOErb0i+ZUIdGcwcn84YUovbVu8vO/VsT9+vC72Jgxq/hbhJpUoCcO+6fUTcQRgkOiwlqg6dvM8Qi31I4eBG+QyDvyBSOGIc8VSihCCMsbekMTTQqT8xfGjFfz1G6yxaxXu1o5cUqAfmvjfnkU/foWUhCtCnRxntLjALrQRt6Ijt5w6KNK8XOnfZy7lP85cBtLHoa0Mdy+moWT7DYdo7U5B/D1uWI3ermPfTtWvOnbYilMbPIf3poDHrGUrIFlro2l/guAMg/44b5qs2dZ3YK6rSS1WBzxQrdmvEnoUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+iJIBgC0xXkZ63+95yszExK5/wCcFXh5KUDzOHWPfk=;
 b=mqSEED+FbkQW6kv8gFMAsy9M3zGlZ2emW3yPNAwORp6TrSqECP2XvDjgPTe1dQNbEEhzewlGutqzsEr40s0HCOPQ4/ATrq3H5nA08jvQbSsu5U514ChOnp3ELAsD+ySbHojSkK/kdj2pxhKtOR5ogWFB14UaHf5WHPmgPjMn/tYqbPGcU6W/S0E8YZt5uoJ3CCsikiRafeX8QGW5gnOeR7WoNg/f6T3MKU0oYaLXWjKS7cAZ0PO4rwIzmTNtzUjXs7jIpEsgee4+A3QZeLW19bTTPag5iznNqZ+VdQ4W2tsoCnBADYlsvZyjWSzXmJN/yV3/Ssem4YsJ5NhGbVTfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Mon, 8 Sep
 2025 10:49:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 10:49:41 +0000
Date: Mon, 8 Sep 2025 11:49:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 0/2] net/ice: fix drop rule handling and stats
Message-ID: <aL60wKQznqaLTDvv@bricha3-mobl1.ger.corp.intel.com>
References: <20250731044132.110174-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250731044132.110174-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZP191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 3253bb28-aeaf-4bcf-8b2f-08ddeec569e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+3O0VMyqzO++Cye65cK0Tnfd66Ezps4eXIBDa8iEjf/p0Bq5Os9pmcaD1gKh?=
 =?us-ascii?Q?0jBA+doy4TNxQvf7zj5NPrMeRe66+r5Z71BYR5pkoaQ7VjhBAdPxb9IrKtiX?=
 =?us-ascii?Q?66u3pOUff8Q9lS7e3c1LLfjSKkLoV1jJQl00H/BwWD1jEGSA5iPDG2exhbBj?=
 =?us-ascii?Q?V7BXZjumADO78tYn1YGLpospa1akYrbsvaNDSLn6BXEyx7nlfoV4dn0VcpfB?=
 =?us-ascii?Q?QACwIHPLsSfgTMUtikhj369oNpLnGOfSFNhnoKaxi7++10FaHWYZ5NB2ihg/?=
 =?us-ascii?Q?VgtJ2Fyqqqcy+oB67EgA7w4Zc2Vd+CZAjOCGr+hC58XevGFoA/r4u8lwq2g0?=
 =?us-ascii?Q?z6UHGuitVjUuJbB9AylEH3/CX4TAtEvJwlFb5rFEVL7XlKQhWbNN3Mq0lqOF?=
 =?us-ascii?Q?aBulxmE8Cu4gnEMZrDA58dx946gWJxHiMhMKo8a4wwgIOoglnzffWJ2UXaZM?=
 =?us-ascii?Q?rcOYEhiu5FbwzXfT6Yf5b7gKFglSPb14aP1UcX7jWY3wk/d8d4nkN59ZiIxi?=
 =?us-ascii?Q?XTnOXN1fL+dNCK+KT+tHcCekbQ8Qqk5E7aZfzK5oGS2gymETR04KCypjY6X6?=
 =?us-ascii?Q?eStflpyGbYoM7OYixW55arRfN0uMxytlDay+5ZuI7aoTxt9t8hpY4sxQqOrZ?=
 =?us-ascii?Q?9Pc6pAfwc10F6DW8xv4Lfo+jdLEn2dXDNwYu8JGkViNHCo4p69jxT3AvM1C4?=
 =?us-ascii?Q?j01/+MzYIxc4PQTH+i8do4oUjJbA4vPnCM9ULGZMgZo0OZ0UdX3ItWQ9OIVT?=
 =?us-ascii?Q?sHZ87qNoMaYHtGgzI2PgfRgkVcxY4wf+tqffagatqLQfutwwIIj3In4eI3F/?=
 =?us-ascii?Q?Sq8NmbcSaNxG8blxMZMlEssxHnuKnsw5Tb8BKyo8nIg6l1DxlZ5jd83qRVY4?=
 =?us-ascii?Q?e7mxk67U4EzPS9oISjdcZ6rUNNej6I0wdmfUkL//gJBgEM15SJVP+zUImdr5?=
 =?us-ascii?Q?o+8dEZPTGswFMXko+6RVi0Ez8954AiD/lcYqTY5gxt6/xspqD8JBl7Q2GmBd?=
 =?us-ascii?Q?tLolPbZ03w6atSIJLak081gyZhI/G7PuuvUmXxS4GF7xMU9LbXi06XlWVM4c?=
 =?us-ascii?Q?bf5iAqATuuszRmV1CkJDiVsmz7AG0qUUTYA9dzYHelqeTez8Ik7TFaDXXouH?=
 =?us-ascii?Q?9xuODiosDPQaGNcK2C454bOLoHqJ7Gnxi4U5LkuXgb8Q+q81gcvEdlZI9Xb6?=
 =?us-ascii?Q?i+Uk3LdZETaqUX4XJApdGYdf4aPOTGIbfEPhpWf8UCoFCuuqhtC8FmL5/svK?=
 =?us-ascii?Q?esgva2kTMqnEmQZUa4gbllpRLDNFBUytaKChku3mNMFHjBVg8hipqZB7BZYy?=
 =?us-ascii?Q?fj3dBExGU0mxdB7ZO77M3zBSl0xqj1MpbQVcqyO1sXGMQ543rIRwoWqJKDyK?=
 =?us-ascii?Q?uyuV8eqPRGAcT5ALR7IodnVHLKHBYF5NM6RzSGin64REsJE1s1gN8DrA+nww?=
 =?us-ascii?Q?+EYl1BRMhTc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AtNomL6k5Hsq1yjRWYkEYRblaxklG7ZNvWRxYk44ex0ijtwifyYjwH5jjnKC?=
 =?us-ascii?Q?2k3K4yxzkxpftJSKw5PoMHECHJv3YyjWL/mAkN7NwJgpRANNZBlHitHTfNiJ?=
 =?us-ascii?Q?ax9RXT5mR0b2WrhaZAlIBaaPoIhKa+OCTcN4ptZIY2pYPUhLOuUUDldxl+52?=
 =?us-ascii?Q?0+G6xg6uGz1vgqTVluhGW6um1xTb0lJM1URpmj5LpnrmAmWrUapE9tGoHQdG?=
 =?us-ascii?Q?FHBdqW2qPy6H4kNb6xVuxiPmELVMk7vcwI6KnznCR4roQuzUe7spItbjQ4rm?=
 =?us-ascii?Q?rjkhY9ReSbAoKZ4awJYycCzLWUUMIY3PcXRf2VUHvkTug8I/1gjJQN6S+6vB?=
 =?us-ascii?Q?kzLx7tyikwjZb85yEfYtmiL0Mj8eNUM3awFhcBhtHpoYC/FLQy7fjq3BGn51?=
 =?us-ascii?Q?2HXD82AFk48ehMx8JJoRs8jNRndSsuRC6PNG2VdlIjxRQvQ8jkGaakMHedlb?=
 =?us-ascii?Q?OTDFeNl6bLgPjPZdyiVsK2Smn5b2tWASOGT+wmz3iKZIIddXZLkWpwKQl9+f?=
 =?us-ascii?Q?2UKCn7q11Pjrrcw0HSAuKEXG/U1riByGbsPzhNADgD8wsd95XdYg4c7J335Z?=
 =?us-ascii?Q?zgNW1IewNcR1kS3JH2rIoe86VOfMSNalgNN/Rj0KoStpLGOSY+psqmARQPvD?=
 =?us-ascii?Q?oX67Cry5JtCe5TBVe95PnGbkdneBOHX0lwI4eqo0tEQFQaegVjo0d8b8r1ac?=
 =?us-ascii?Q?kzqMEccu1xmNVZHRuLl68d2LXzkW4jh+LnLZSLgragTSg/6JRSGIyrtsB6/M?=
 =?us-ascii?Q?jjyIYl0L01+mDu2r+2dVjTWLAG5A1bV+nJpBQAU1K7elgkwyq6wDAUdlHH9q?=
 =?us-ascii?Q?4J9oys7LwGQMWujqlBHRU4zSJjLdF6kW+R0eb2UA9G/7/9U0M2RaKrNWsFr0?=
 =?us-ascii?Q?yPMCgpWJtCc+lYQ54mSDJQivTIQQ4uWm6ybbrPzi8E6J6j+q41kX5n5+jjvG?=
 =?us-ascii?Q?3b9jZ8n52pic5vvDDtthofsr+L/y7/055T3j1bsm38IoH4jLyyTz9BqaD2Nn?=
 =?us-ascii?Q?mnJYpYXogrCWqxjDKytcvRBl7m6nKC4Nrdbkp5iBlE11BroJHnaw/uP4T38U?=
 =?us-ascii?Q?B5V2NCGqclHqnnex6nmzAfj2hNOoMiR7zfO2HwcleBDlsHE9Ml/Du/KtC1jP?=
 =?us-ascii?Q?AbjMNS5TX2gTd5pcRIfkwVxR7crHfFrBOul7/KkSi8+ZsyPqDW8eGwL7EsV9?=
 =?us-ascii?Q?JsxoSVQdkSBCNk9wykehACzYLLqAdZwgD9HrOuz9YS5jveD4cYj43P65+wEV?=
 =?us-ascii?Q?SkBiu9ZplNEYPwrCQkOlhaLFNALDt2HUYU0oY5WiwlWEj9HNIQVFBGncYYHd?=
 =?us-ascii?Q?7IOu8UStOkEeIQkivhXWfVqfmT90yZln3MCw2tYI6JdXTEb8GU46Vh0w6jsr?=
 =?us-ascii?Q?C4kOZ+VMBRX//6WLN1UPXULpb/ONHwf/BsNhiAYMYrWOnr7uBgMoTaqgxcJw?=
 =?us-ascii?Q?JWsiWW4hFJntj40ZOimVFtMU2CC/aPLbGXk9WKzsY/XwX0SvBskHRpepsj6V?=
 =?us-ascii?Q?tMvUaYagYRWVg1QEXt4BWgqaglFZUjCUw3yW+ctXlkfZMmlb093GREje2WWR?=
 =?us-ascii?Q?r/znoh+Mz0Qszs5LuWLM4LhZlYMm1TVE8wC2NcvRSGOOs4JbDA7qyRWM5BUF?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3253bb28-aeaf-4bcf-8b2f-08ddeec569e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 10:49:41.0585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxA3V43UKhezcmqJ+L1efm/S8NShShZe9JlXAgcqbSKCopwC58YEOCEQON9jddcv4NJRQPUOeQKEW7XDCXioX3VqUHfD/L0typbAnUlFAEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
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

On Thu, Jul 31, 2025 at 10:11:30AM +0530, Shaiq Wani wrote:
> Patch 1.Tx packets were dropped when a drop-any rule was applied
>         only on ingress. A direction lookup flag is added to resolve this.
> Patch 2.Added accounting for Rx drop packets in ipackets and ibytes.
> 
> Shaiq Wani (2):
>   net/ice: add flag for direction lookup to occur
>   net/ice: count drop- all filter stats in Rx stats
> 
>  drivers/net/intel/ice/base/ice_switch.c   | 8 ++++----
>  drivers/net/intel/ice/ice_ethdev.c        | 3 ++-
>  drivers/net/intel/ice/ice_switch_filter.c | 2 ++
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> -- 
> 2.34.1

Patchset superceded by base code update to ice driver, dated 2025-09-01

/Bruce
