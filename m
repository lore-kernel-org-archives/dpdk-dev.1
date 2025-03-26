Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8CDC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 09:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91369402DF;
	Wed, 26 Mar 2025 10:11:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7F554402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 10:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742980265; x=1774516265;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rPf5cTunYs6Yt2kPh7bKksVv2Ao5HOChrD73IUgdL8U=;
 b=Rnao2yFCEtfXwNRyK4tS71/4nQaXMu6B+KyNt/HTFgXs75DCiOLlaVZj
 waZqUDWSssmkJ6ALi78pl1oSYLqOb44tM8hhZpbE4JY5dUaw1wPOYjMYp
 L6dv3dMyKmiLWSD9UNtOFpkuS0rKRIIC+5f5efto1Bi6x7lds2auNijvr
 XzO3xNiUDvDxlmB9qr7y4spp9wMLMOV0DwdUIVclXDa65mp3YHpOYbGIF
 wk6vjoMB9f6oVTedwUScOCFO2X7jnnQbUfo7effYZxejRUgZnkuPunoPQ
 fpCcUGCIn5gkqoJQZ3/yjjZnnizCfD0Q8rV1xI++VjFEO7r6qe3y6fKfi A==;
X-CSE-ConnectionGUID: vkWWwRVSQJmuHtJs1UPpzA==
X-CSE-MsgGUID: RSedrpVIT1O4HZl51NEMiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="48132939"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="48132939"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 02:11:04 -0700
X-CSE-ConnectionGUID: VCGB7ObLQfqocrqBf328KQ==
X-CSE-MsgGUID: C32tkrtIQBauYtMTyLbJVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="161901249"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Mar 2025 02:11:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 02:11:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 02:11:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 02:11:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVVUKYgFeUpc4wklTtNnKpH4CNb0OFLuTAwnBQBaTIVKt/NgUn0FjNN/0EfHfWc4o4fAv0ifXAVMSmQQPNN7mRhPsJ2MaVlgVhj3SYBrvH7JULtNSTCglecH+s9FV6wSsdvLhxjirbYzY+8coGJB9t5O+x6sijBkpr1dQ3E7wxfiPSRPn5d8gmrP771WxIWmO5F8ygcmTFOk42MjQxZ1ojxr3ULEBu717/eKxlUTOZTSir9H9nCNNfq95Df0S5mtNyyON2PvueMZHCq1sfCR5q3rVxA0MnUPomgOVpijCq0EaS8wnW7/eSCP4PSFUIcHScTjroSpZljfmyI2QNYJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue0fiYa/mM/T0/RXQBqiw1CIZZRfQdLkPlMuNaF5pXc=;
 b=kLSlk/tXRQHVNjSBjagy9EPjEclerxTyP4cWp06VGp0iNv0AMCCvAsZkiuJTSD/BiPrsfnwA4okXe5CQUabosbONFTZNxjO5iotYDzAwqA2czeeo+jOSAAKuXhSA57CL5nTcmudjgki8uDaPMt1MvL80dU5chXPcln92q8jWB1lyqkcq1eW2SZhS5CTa4LDw/aX8wtWXU9hD2dwcBwoRcR9rkxFljpPU7czvLVTHaYKl75Zv2dqUlliOtw0t3zYrVUuDYyJm+DE3ea59HWllUmmYHxo0xGx5IwXckVNwLzxtG7JAEciEGSkzfSQIE+vgvQgS6Rc9UpSQusm5+rVszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 09:11:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 09:11:00 +0000
Date: Wed, 26 Mar 2025 09:10:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH] version: 25.07-rc0
Message-ID: <Z-PEn4gSkJyCEbUs@bricha3-mobl1.ger.corp.intel.com>
References: <20250326090003.858426-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250326090003.858426-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0295.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 6367bd92-7031-4546-81f5-08dd6c462059
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NnsRflMPSDk5ibk9erT4tC11O27bmdeu5ZA0o+iNYz72L2xmkOaObGIi60gJ?=
 =?us-ascii?Q?QTMtaP/9Y1GS1oigO/bgkQNlli23VrtWpQSBCip+6PQfZqYTba4E3rt23M+y?=
 =?us-ascii?Q?Bt7bKPlp6/Wm1U7wreadM7yx9NSsRjOYJINy6sJPmp6xxRQBy0Xsxc386u8A?=
 =?us-ascii?Q?SvufIxg/4FB3cnw1dyBS4STT0DOOEbFM5oizyNp2rxh+S+lkdf/ffM/un/M9?=
 =?us-ascii?Q?qm8brZ0hvkpQeGjDyjNpvvWCiGRCCatJg5CDgR11mC0qHmk1DBR7dg4E7mzi?=
 =?us-ascii?Q?2dFCJzq/rI1cuR+bNkZ2O7MzNmSRyEGFqd7zePAerGNuKCvkRPUZup/F3dYt?=
 =?us-ascii?Q?J3edwgC6Q4fGMaRlJBmZvmwXwB6JDjHdkU2OICkeOdF03EM3+HmD7bpTF+mT?=
 =?us-ascii?Q?rDtmFmeo1cd7MqzHldyL1hBSFNKAYVRBbFxp44AL7Lv5ZlR6/gw+swFnYDQu?=
 =?us-ascii?Q?knNUM0jMvqlQojaGZQV+zfFMIKvlz6hzI2UpfJclIZuwmhHzxhL8rHf+Pmik?=
 =?us-ascii?Q?q2pn+7dvfUWMi05g88HZXQdGUJsmaA7KtEJ4WodNjsjjlYp/TDwMkPdfkQqz?=
 =?us-ascii?Q?rQQLRgLYG4RMAKNRjPrgKR4HrjVCMHfJclI3e/yWTM/bH1WVaCT/Ve8P/7EB?=
 =?us-ascii?Q?rgrT2wpE/gwDo57P6kjAxrrsBiwpwbfNQlANMBzfKe0wuRYqvvpQZe4XAMsz?=
 =?us-ascii?Q?ibOC4C6NnVMzqz9SjXgHycm8E4GE+NK2GkE8qzBl47x20/ClA+cptdVtQy1G?=
 =?us-ascii?Q?JNRlJXYK5zrFuFwD/hABA9BWOMDJZSENZp28AVqvnTRKpw34xLY5SaxDAqj3?=
 =?us-ascii?Q?gb0CDjYu8b1p6Q37baYkUloFTNtycWtzndaEhe3txXB1B91SblzIDO2pghNK?=
 =?us-ascii?Q?z5w4YZq9e0HY5B7S4B4gu+5AT63CmoTQY0+o/0PfLN8tB523hGOgqVdyjcgM?=
 =?us-ascii?Q?C+xISHRQxmc0JWbiL68D8rwRqTvhKPDF3TA6RCIBCKP1CuvMEJ/PTJFr7HbK?=
 =?us-ascii?Q?oQwwQIC7I8BWLWcPPzTYs10rH0xfhGweLxBq8xudD76KKhFbUVDKB7Epwf3N?=
 =?us-ascii?Q?y4+y7wdTTkiBl8LvKlDmmzUnI739yU2UlwdxN8U2RK3S4SBnBl7pR/pmN1bz?=
 =?us-ascii?Q?ZaJsql9n0Ij3APryt9pFWQWMF/WNsExvsX7DVE2BqNwwij3SzyNpA+8hOrK8?=
 =?us-ascii?Q?yLKZsWS4fUYnXU3H1zXi3TPjVHBWUA1wFl4x4ps0mgpL02L4e7h5GboVSkGg?=
 =?us-ascii?Q?fHfr7h92KNxkOOC3FFKK3GY9Ei/LySDtipZyHrqh3hw3W1+N0qmqS0Rpq7YM?=
 =?us-ascii?Q?ttmYEkBk03ONx+Ulho/l+zNcu1fNHi/cM/FJ11bNGqZRKRxgVgigLVOJB/5y?=
 =?us-ascii?Q?Z2e7J4p2MY17XhofZRVA/yhSgxZV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?md4Tu7+NqFSoFEhlVrA6eANQj0rTNnwXkUjRin7AFi3XTyxhTnJn7+KQR6Lw?=
 =?us-ascii?Q?LacUSGi013Fq8St5MPxHHn5QDS0hKjfT7G6tDEk6oWO40D2NE2ZVe46wSbAK?=
 =?us-ascii?Q?mEVA8icdl8v9S6nUVI5wn3I5X0gRPpMQhDbVtwwIF8jv1ZSwt9QN2/WJbU4+?=
 =?us-ascii?Q?EnKxqg4SPivzvjKemSnGbpCFY+Z1kvaP9rbjga7pIpZOw1XHOxb22khq811A?=
 =?us-ascii?Q?t/qw2y3QaRVKigiXTcqdTBX8pPkaYvIDbYpeJuGsG6R87K18K0GjUNP6Ug0e?=
 =?us-ascii?Q?ZZ3lydWZS/8rGd/H6G1e5C5h2/4GC5Mh7K4eZuw9vZmSqeWPVqtVA0OFQ8u/?=
 =?us-ascii?Q?nUAGLfpiLSIPktd0PwgWoLBgy/wFS01zrjLBaBJGdkpG41frZ4aLGQeV8Jen?=
 =?us-ascii?Q?VHp+mrOvsPH2jKYm2xel3A6D17MM5SkhTnH2SaNxhxgj9D2BZQiIgwRwuvoO?=
 =?us-ascii?Q?MtADBdXt6MBgpNraKF94/mG6/uBwSn5wZemgogLAha0bV7qux4gumdswrEbd?=
 =?us-ascii?Q?zXZZpidlleDqTOppb1s+wMozOey44F8nqtRzkDeFjnhAUuBcBhOCcmrZDVvb?=
 =?us-ascii?Q?XG1zxQdvVrvFOeJhb7Wy7s61x991TDpI8SsdRZS+FnZB3whq8HJHxMWjb0Ej?=
 =?us-ascii?Q?xaMLXX3qC8IgTAYDN9FBcsjBfjXp/HeJ4F6TOaMK8Uk9DP1mr8P4ixaAFaam?=
 =?us-ascii?Q?LFRgujBCm5BwtbEbm9O1SNRtzHIIaKkCqNFFmXrrePeYnvptDzvI3DqoDimM?=
 =?us-ascii?Q?wW61BOPLxyQpSEgrsGNs8UKgM+KC7r9v9chgSHvsO/zf6iLNI2pKDQHFaxTM?=
 =?us-ascii?Q?zL0KVLU/6dnflP7taO43vccARjhEyUvzn+A1hwnLJJlB390BorPW3YxnLw85?=
 =?us-ascii?Q?66IH8luTp3Q+mUAp9pzzmRv/OIa8kiHvihiJLo+LSu7EgIKOvKkvZXGba8l8?=
 =?us-ascii?Q?K7btTTuNYUA7uKmgegDnY15JeTKeZqy3lHq9/srpW1cKqjrw82KbkZ/nYyHO?=
 =?us-ascii?Q?ial/h9AYn8KGT27EkYo8p6CSi00m6OZQBsxv+KmiMl0pqVx5L7gOK4CZCzOV?=
 =?us-ascii?Q?nbm3r3yV4G4BJX1BQcO+l7QXEeheu8oWZktNMjZIcZxAPvaTVW2FiEhgMvcX?=
 =?us-ascii?Q?iZnf8cKHpJJwfNKfzOL/g8DUL+wuFyJJcgqdMSxKaAJa+eymXTpNZInMIot2?=
 =?us-ascii?Q?Zld07lRuaEM6soVHB5mudvZF8kewfEcsk0gRuRZfc4Bat3AnqDCAxRfU5vV0?=
 =?us-ascii?Q?GheJRn06XN9Sckd/YzDf6tBvJ59ameDWY1lGCDvgxFYZB0DB9rRrrYkE4vXQ?=
 =?us-ascii?Q?AFSA/xI6S7TZRxEBu6Iiz2zI9jEO7MebO05e4p24JGWx/MPCDuwrgCZHF0eb?=
 =?us-ascii?Q?rpieTOHNfZAtw7Cmm0E2eBXAPNGFCho5d0eHUKbVe7oYgMNHQDyKS3+wk2by?=
 =?us-ascii?Q?ErSfj+tf4o3Crx19jaGhc5m95n9y1cJ5XbTx3HdEymtuAmv8zRurO1/AQICk?=
 =?us-ascii?Q?zyMXPEFtdFo1wg4m8lNpuGXZyNeMLTKQ+Ga/9rTNprSFi2A7CHrNdinQ3Tf7?=
 =?us-ascii?Q?CuPpVFq9GFUMWEsbjIRISd6yE+t897nMgbbKwGLjB/dDyI2s50/GLt+0sWzw?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6367bd92-7031-4546-81f5-08dd6c462059
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 09:11:00.3951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9WaFFe5lWb3BgENxFlSOKnUY1PnZS91SGmtmmv4u+waRKHWIsCQSnildr+KoTheUX+gIMbrFuyQqMKAQBTM/HozUsTpBDU1pVYKF/e6a8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8492
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

On Wed, Mar 26, 2025 at 10:00:03AM +0100, David Marchand wrote:
> Start a new release cycle with empty release notes.
> Bump version and ABI minor.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

One query below, otherwise LGTM

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  .github/workflows/build.yml            |   2 +-
>  ABI_VERSION                            |   2 +-
>  VERSION                                |   2 +-
>  doc/guides/rel_notes/index.rst         |   1 +
>  doc/guides/rel_notes/release_25_07.rst | 138 +++++++++++++++++++++++++
>  5 files changed, 142 insertions(+), 3 deletions(-)
>  create mode 100644 doc/guides/rel_notes/release_25_07.rst
> 
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> index fba46b920f..0cc4d12b0b 100644
> --- a/.github/workflows/build.yml
> +++ b/.github/workflows/build.yml
> @@ -12,7 +12,7 @@ defaults:
>  env:
>    REF_GIT_BRANCH: main
>    REF_GIT_REPO: https://github.com/DPDK/dpdk
> -  REF_GIT_TAG: v24.11
> +  REF_GIT_TAG: v25.03
>  
Do we not keep comparing against 24.11 for the whole of the 25-ABI cycle?
