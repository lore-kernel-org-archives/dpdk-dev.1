Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CDCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:39:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC12A40650;
	Tue, 14 Oct 2025 14:39:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5FFE4402AE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760445587; x=1791981587;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lDiU1ZhMsgm87VnZA9/rLfeCKKE6rdU6NRiJegsclds=;
 b=UrEyegq72YW5mS1kWb0lAPDMkWUOCRCwkvgn3e1idufMhftaqsHpuI/8
 nNI/rASt1K/pVNtblUg6AZ7GRohT0Af35q44pbOzDiFr6Cew9my15UcQ4
 UMVDrxk0sStq5tNqxeuiQa18KS0QV2tMsO4DKyqH8i/G9wg4Wu78Znnyu
 H3b3pZUdyfXdlugB/mybInELuPWHuO1cDS5xsXm/sy7eMSSubV8XkSW8K
 dlXlMeLaGrQ39wnCgTJhcsWyGEydqdkXV9vQrdqnIEYFFSJ/qYi/Ba3YA
 jnqtlTjyjZKP9HGbFcW77g7Oo2AbUz2ihMiDU1gLjFmdPnkoLatvK8Tr3 w==;
X-CSE-ConnectionGUID: dmDr+PVwRxmUqh1P1tLSNA==
X-CSE-MsgGUID: 5P6XdBJ/Qyqp9uTGIfI+pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="65224380"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="65224380"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 05:39:46 -0700
X-CSE-ConnectionGUID: 5n8bYKuLTvKMoDg2ZFh0KQ==
X-CSE-MsgGUID: gRwOpHacS2yutAECveroXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="212838580"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 05:39:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 05:39:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 05:39:44 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 05:39:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfcswMhnaHJQ1okRBCZk7c45CuXmH7sxrDOEglfEAuoN2AWTsGd56ee1gSd8I6mYbTOszyC5WetC1zwy4oWdfOWsnAjVeNOH/8ZuzXkfyq5ufkJOA4AC6hJ0dOvHzAtPg2xEUYhvZrk0aIWiHz9jX9eURbIhMBPXfNuZnqYEaQTmoJWFH6d74J488mgnujYlD4hylbqPO6Qrt5AXQzb5EhaToC+Dl1PqBT0unxf05UCqk339LRDsojO+SaaM0RL5l+/D8VFlAFqEQ2l8Q8RCji297/R+xV4A9Pbn71UhnjHSB9t+6FD9w9ZXAkdEvvp47X/TNlwj0yFWX2rVBNSdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYt4orHxw0Hgr3miHBb1CxV4oBuBTB9vGxWEUoNM5F8=;
 b=yqTjF4iSN3AxP6VyreYSUQU2vRPQd5jwpoUgrMn5ibsOmciyWJX1mrLx2Pv9Q4pnZaBLJ5CfdKR2CisqahXrLNyo1zvaMe9TU4luyCMgm2Nb1IBMbut5GmMfFlUUh7/nsbG4TPsGvkxIeVRB2jmf8V7X6Utt15PZB9rYKst75xjUcaRuaR5nSTAogTnzfWQiGazIokYZhG7e39Pk7m9p55GLNswP5mnUJh/BNMZ7tnu21avcB7e46sfwzeGs25PL7cJSMkSV6ofUwfxrGfDtsnp6zxxGKaaI/vej6Kr2+r2dpXJgcIusu9wazy8R3Pd99RvivZ3gz3YJwn6BNwMp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7613.namprd11.prod.outlook.com (2603:10b6:510:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 12:39:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 12:39:40 +0000
Date: Tue, 14 Oct 2025 13:39:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 0/3] Enable DCB/PFC support for ICE PMD
Message-ID: <aO5Eh0X2O4gd54kS@bricha3-mobl1.ger.corp.intel.com>
References: <20251003124037.342760-1-vladimir.medvedkin@intel.com>
 <20251013180523.61468-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251013180523.61468-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DU2PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b764f2-7e3b-4c98-1a19-08de0b1ebe6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aMhVDJNew9tnuxzFzJH8JmomooelwuBWPytQpt2KmgnzvfZO+tUm+DjyT39s?=
 =?us-ascii?Q?R3G4lcncCTyqK83GkA8XjNH71xY5UPxdtBS701Nf9Jnsbj5JK4mJnBYcnFzT?=
 =?us-ascii?Q?c/9V+wiFccOr+hDuAWtVcFJAmbZeAogDGhysm6hVjw9fPuEysV3ACW66tQqr?=
 =?us-ascii?Q?x9vQb0BDUuUD1Gi4aLk/qnl5UKHO0MCm0xPo1LUrjawjeUQkyWBeixtuwpWO?=
 =?us-ascii?Q?iKiX8D0giONtdxSGIyZ8qWuvP+Dp1HFnNxwWmVoB8wNRdYfGicmXsFEhUmb5?=
 =?us-ascii?Q?giQbsbhPiy69Q3+nx/bmEEVE2tHMJgPc0biYnhUTKtslwFYYS8sQr9WfPoQs?=
 =?us-ascii?Q?fvxBIaWvc1YN1KsPXMrs7r3p7+t5U8v03xPndtw/57aTn5983bs2syzk8lIo?=
 =?us-ascii?Q?1oD94kYUolwcmr9tRfD8cDs2ykbwaZJpCEXRFsFCJbIGgzqFM8fthuBlkMp7?=
 =?us-ascii?Q?oQuXE/AxioFxzFu2NyqhTTrOWLkqmk2ZZi/x8AxyDvGTjTfOhFY+bqOF3ZSi?=
 =?us-ascii?Q?2++g/A14RE4ybsbmhaNk5d9pILDdSxJnVIub/htA0dkF88ifcqbNp3upFMtv?=
 =?us-ascii?Q?lyZdWVmtlyaG4x/jUjTD/qgA255/FbjWeAu3PRHf0H1pujQugdADw7nMIAZS?=
 =?us-ascii?Q?HSqohAXNuISgHLZ3YR+VmTfK69qHJZ/kKyoG0g5JiXJt9ePiIoyk5/rZqsBM?=
 =?us-ascii?Q?QVHB/qLXDMimarEoCUYRLvVZ85ej6RVky+a2hh1wDjRVVKnh71GJyDWcD50u?=
 =?us-ascii?Q?3fzpf4FUPGuiefwuTAcqh/Lrh68XTt4jphOthxZmMUBWHGiLzifJU2FuYdK2?=
 =?us-ascii?Q?5X5snDZk37ddF1f5s2riI/LOCz5Sfc8ZsBMbN7OaMUftjPkGuyc23GH/bKop?=
 =?us-ascii?Q?xlj5Ek/ZBI2knj38SeIis1onv82y0T+Q0Rou4kRHODdUaqJix5w9rY6DHdu7?=
 =?us-ascii?Q?5iPLr1EkGaDvhKj5kDMeQM01896teZmQpWi6dSlOx+ORYAXGZxLq7rcZXKMZ?=
 =?us-ascii?Q?gKoe8CjoYHFrcMh5OcY6RutyfZeKftK8PMUslaZfh0ZORwo3F+OnpCkQx/Dt?=
 =?us-ascii?Q?v0FI9F4QjxtlAA8Vcc7sVQHcLwGsnMIS28QWY8D57ADWohP1sCkOgmn8s4GQ?=
 =?us-ascii?Q?qXXMRPv52ThhVVOwQHqzWlR6u4wdniSygvGYHOnNUgyzCYRAJ0YkNF9vDFXV?=
 =?us-ascii?Q?QVcqdVRaWzY1MqzEdPmIGiE5N4MX0UHf8y/pIVoO+ycIMN0cq6M7X0pXw43y?=
 =?us-ascii?Q?jXZQWjepRDsJa8oBObCZjevd29OKNuhtlhj3H0JY52+Q1BYEEZphz6iV39I/?=
 =?us-ascii?Q?eX1w1fKw6pT3h7MWr9M+zGhcfT+tTaTXHDAwWBTN5vtqwQFy91n9f+0JESwp?=
 =?us-ascii?Q?ZqNAHOMJ7zbaz3/7bwiAbkSeMJbXNyizGZ0ATUunrLZvipSbBLFHLt7PrBag?=
 =?us-ascii?Q?jcYoIOTu0p9ul22AGxaYuR6GI1EBLJ5j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rz9RwLqI7CGG4C/yR12Plm/YWewskBbw2oW/sjpEf80tW4bSotHvht2WPtoF?=
 =?us-ascii?Q?VgMk31iP32uAkxU7hEORikd2gzak12zHfMwy9Zrn7DEHh81zMwzd6j1Na65y?=
 =?us-ascii?Q?+pXFawYQXF4ZESVPKHBlWtQtO0kJOvL6IP/aJpKdyYwciTeIaNSTCtWkysdn?=
 =?us-ascii?Q?PV6w11/YcRcMytcOIMP7ztI58AFGh7spM3/+uEgX6FI8ND0X/ODGzp56CwqU?=
 =?us-ascii?Q?1rlT/GZ4opnGoZ1f3Uiei5F8xspz+v3VwSsM5rpBgRiXq/fo8W7IN09ZE5qS?=
 =?us-ascii?Q?VZVpMcEi/TBkQYhZCEobIA2b1WlefTJcCyKfW0mRxo5C2pjNg/1yVkZaJGZy?=
 =?us-ascii?Q?/1XDJoNEIQ/0H2ZuTSr2VnGQppFB12y8QCwps8SFdojTuy4lCBfiKuHk4QF7?=
 =?us-ascii?Q?5545jj3VfONGGn6anBwZUJoIhNZKpiQdIJEp4y7U0PEmOV9JILfcMOm18Gaj?=
 =?us-ascii?Q?1vleg6XoSIQFfDV8E32MQyW2FAH+dbSLcEjx/2V5tM10448Kw7X46LNrRdVS?=
 =?us-ascii?Q?/lAIpbF13A5hgzUt2KIuH3jQ13SDmgSwG5Bc7WAG8WM/+OEg+PS/aEGA9vXd?=
 =?us-ascii?Q?qUxNgzn6V4cJsXZ7aikMpHPQuwWCOe0sqTCHVfh0yeyzqgCXbXrr5Ko1bbPi?=
 =?us-ascii?Q?T/588ry7d9dFu/fWFiOg9V/9cdcCUqfcmOEZ7/You2ztazFUjxS4XXa8B87x?=
 =?us-ascii?Q?lspRuS3j/BA+fbfJ/EAwHLhPh4tIWRWXz7svafk+RpCs7WHU1+ThElMIg2+k?=
 =?us-ascii?Q?ZCc6PmmbSCwtVte+ubwWeQTzsBsBbBZyuUEFob3I5mP0xVxZVzQZFNq1wN94?=
 =?us-ascii?Q?6nDol0w+lJ57OHpGKllODHi3Nbe75zPRQwC030Withak83U/0wutBL8J5y00?=
 =?us-ascii?Q?8QKHJ2tNlLSsFFkZ4KbPja1nuw59fcjNOoYrlhUsEnc1ZwwgU2gkeqZn81f9?=
 =?us-ascii?Q?e3k+guLOw+6FDa2m/07z2bQn/YlZsJG+i/jixCHPfWW030yTHxnDzA7iqTAn?=
 =?us-ascii?Q?7Cvcub9UqIY0X8X7DaJjiboMPrh943Yb95xe24zMlGWVQxkXfAoo6wOTunpl?=
 =?us-ascii?Q?iuIqTTA98No2Djmbf9413TfGFi/EbeZgs9OkgYsCWIYgYuTWLXmKRITuTrfc?=
 =?us-ascii?Q?oTluTlbCmrl72+rajcnIHlSpi8+eTwC8Pfq2HlZi6QzzrVfIDv4YuHZo8mEt?=
 =?us-ascii?Q?Mg7AJRrxCXryzdPi2O3Rm3v7mhzRTtPS4QV75v4ymqoWsRGoDXIEB4EuL5Tx?=
 =?us-ascii?Q?wQ4+dJk9IaxgWDbjigMMAwNhJck9xI3uU532NJWno1TIpixPgl02wcuwxlz4?=
 =?us-ascii?Q?+BVNhCQELu4xWRRdWYjF4ty5+bOGjPdB32tG2VkGMnNSuunwGnDJLLezS2MS?=
 =?us-ascii?Q?4YM4IBcPUhgT8Ju1jn3mG5BFQorqY82vrx7SD0uXA73oldmw/1IBr786cjlZ?=
 =?us-ascii?Q?9Qjgid7lttsHj9HuLDW/C6I8KnDWz63bOS/Nbq0ElMV20HZJ070+80Z56mrS?=
 =?us-ascii?Q?iKYdba0yZ5cERPFpFDHSn8KD5tjyHR1vnePn2yZZVaAjDLPfBZCGPzjc+qzD?=
 =?us-ascii?Q?NtI3QjQ9g8X82o0fB9sa22TYykuPxpIOSh0nYO/9WS5YoaFGwn1GlBO1ibkt?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b764f2-7e3b-4c98-1a19-08de0b1ebe6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 12:39:40.7628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVB54G/hmtY7ONE6Ag+ZqpdYjMdHnLMDKuvsjciujVTCU5jBiqKe2W/siz3lkgCnNzdA6Tc9znlsLANqHA+AA6te8lqz52ZEdFN68isqjog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7613
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

On Mon, Oct 13, 2025 at 06:05:20PM +0000, Vladimir Medvedkin wrote:
> This series introduces an initial implementation of DCB and PFC to the ICE PMD.
> This includes adding support for TCs in ice_aq_set_mac_cfg() and asymmetric DCB/PFC configuration in base code.
> 
> Current implementation relies on current API and has a number of limitation and assumptions such as:
> 
> - Symmetric DCB configuration with respect to RX/TX, only dcb_rx_conf is used
> - All TCs are configured equally with respect to BW they share
> - No support for Low Latency TCs
> - All existing queues are split evenly across TCs. Number of queues must be power of 2 and be no less than configured nb_tcs
> - TX queues assigned to TCs the same way as RX queues
> 
> v6:
>  - various small fixes
> 
> v5:
>  - drop base code patches
>  - rebase on top of the next-net
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
