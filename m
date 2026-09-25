Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF87C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 13:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C7DA402D9;
	Fri, 25 Sep 2026 15:16:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1266540294;
 Fri, 25 Sep 2026 15:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790342185; x=1821878185;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rn5zvc5gzO1P4jgyEvpLI3djXXDAZoE4+wQScw14KLM=;
 b=BA/vwAdDaFDrIHrx2HTbJeRys8m7ld6PK2RRH2fZPC+1Lo5mbq02sOzx
 s1Qc50zxeCTdhaN/G3kjuy4q3PHMVWot7yvO3EcCxFpdpTQxlYoYzz2uK
 wGgl0b4pAvAoZRf6KhHZPGuEuzPZW7zsefX2hkDaZLy0iSisSVhxPxuRy
 WYVH5EG495XGa8Qv6oyjhBPDItgZQdGchRFu/l1xfQDs8KK2qacz9OSri
 NF0/hhPF/MrOCOIbMoB0ceXL/BaQB4Fb4hUq6VQwGfDhrM6UQVoLMiDJB
 AZ3gOTMKj5K2fGPA4U/Du6KN07fsZ6Tmy+FARc4+sWBNo9ltw2EhS9ao/ g==;
X-CSE-ConnectionGUID: kvjPjDlmQmm/GLeJQKoosQ==
X-CSE-MsgGUID: HlAyfJTpTkSnqvL2cAnn4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108618287"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="108618287"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:16:24 -0700
X-CSE-ConnectionGUID: W7ATejIBQuS5TF1rAh+QHg==
X-CSE-MsgGUID: HwHRCQpQQPSfBfUK1Cr/eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="282413346"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:16:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:16:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 06:16:23 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLNj6CBVcHg7u+uGEXTAJWr6Q7uVCl+qPfv5bEGf9gn2IagzaVwHhbSnSPi+caRaIogtt1ibYz/oAq6S1jx0Gr8ZfxdSkpuB6qk3B9z1pF/Du2Ix8IetOaEppq13P4yW/nJ0vxhtRZ9dKSfCzv7muG33YhV7B+InAYEx1Wa7Zbd6Q4KPbnZFKWgftrzwxhdFuQFX1SZe7rYMGLrFczxRtSflt1l9Kkd2M2/WQrxPNfXqg3pHFksTEPKq+1yt4k80Y8XFqeKw/SW91ywQC8fUHmVqlnPEfHX31aCfzxU4Nx6hpUJeHQWrNwimJjXCNyYWPb+xnHobLoGLujxJ6E5+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TU2AiS9mGglB/nmkVklsyMoz5p7ZSOO8GyObGwl8xY=;
 b=nREDeJiI5Mnicb25O+MZ1AirGGYq2atsfagSDWWmm+E/5iZJs48kawwq6ASFAlKSaEkX4THAZAVlYHWnqd4Oa/AZETriTzK1FSIHD3mZULf6do+s6KfUkHOcgjLTdQRr454cudmW9VInR6W/rcoARMWbLgPGAHkeLoihW1V7GoOtJZdVncI9LFBv81wdmRLXGvNVxpTOPQBB8pH1zkPJt4OAKgzYXY23YjM+ob3QoivbLXL2KO245OrCLb5Lq2aOep2NtwCD/z1d8q81jSayBtRAngJ3i71xCB1brFatNV/KPC68SPNXCsSt/tjmbHeNCghhCw6nHVJ8ew/ZaXyuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:16:20 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 13:16:20 +0000
Date: Fri, 25 Sep 2026 14:16:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix storing field offset arg
Message-ID: <arZ0H_3tUSLDWZ5W@bricha3-mobl1.ger.corp.intel.com>
References: <bug-2038-3@https.bugs.dpdk.org>
 <20260914154559.4045256-1-bruce.richardson@intel.com>
 <5e9888a4-d71a-45b0-a29b-ffa06d117a5b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e9888a4-d71a-45b0-a29b-ffa06d117a5b@intel.com>
X-ClientProxiedBy: DUZPR01CA0137.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA0PR11MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8c532c-c4a0-4b56-f574-08df1b07304a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|3023799007|10067099003|22082099003|56012099006|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: NsxGCh5MV2fG4n46IiVAVTIFZl/eqVXpIvofCdht73jbhGEcaLTtX/LvT5I42IXEkQlmhJwx2KR8+FW68KlcLEZMPxC74yypW7gS3FS+31UJkFDQQkY/PIIgEOgUDyP3OFWuXrKlBjQmuqXM/kSdIMnKcaRxQvLhAv0S0RkjvzRRju/7o5kdkCjZkp5LDxNi7K3Ei49Sn3aa2IYQk6FHzsQTuhTrQG+mmRHHpakVgAF7R33YI8h0A/fE1R4KAK0S0ca19JPPzEnT2obLFucxqQYQjrBiDC1g2vyPhwD9FDmptg1ctA8ld96FY6rcBkGX48QdtD80mMRKRqNQLHwQlo2YTVp1qtytEJ/nkTOXwLXBxA6RJNXTctx2Xu8lRLPtg8PVq/EECJ/vMtS2Yc9/ug87wqSFnGxcIFi4yj1r+oX0x+Vl9Sn3W/kAkabchxMH67Uwx4xMW1jg4Tqj60QruC5l2q+XTjhs3HjFssTMYuXFYoB3QfZwAlifT6CyB8TfajfDuaqabW50rTalq+zRrN13Gv/Hvonu8oxPeDelLhUNLB6h1ODPa+B47s920leXfwkkd1X5klPBn23cVQ+rO8EAOKcszC3VT+SRp1GiEGmzexMNSF96Tj2xUB/bHozdyeBgFGs4AsAUMrNbKRe49BG936YWfgIRPQlhMaPdeRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(10067099003)(22082099003)(56012099006)(11063799006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?60eRJwt9J+v9OfeuioBEcVa4NUrLIAMlv0jqUlNEog+LFSsqfPu2y0YfPFWZ?=
 =?us-ascii?Q?4DMc38dUvTZPtBwtevTQMLIlKHe4Feiyg9lyDEgMakSaVfE6ywrfcYSYXJzK?=
 =?us-ascii?Q?nvNhbWBUUfSLi62ozeyLT10VJFK2lk9/uIePu8bdrph4P1rOzMSfbEC0hbj8?=
 =?us-ascii?Q?MQy0mtunV/ZxF/e4sIsmrk/e2xu6fGQzYQMfnNACBZsL8Foymo5GGtYUF96s?=
 =?us-ascii?Q?B8vbGqk8ZC9e+YA6/WrcfBW+v/MFJGfX6wFCNZL+QOopoEFyorjE9i+RdzMI?=
 =?us-ascii?Q?6saqRB/L1qYpqfsysQpTfmKtSHgYCdVovoQlyX5V2k4k+1SzLFXPS5gMOW8c?=
 =?us-ascii?Q?W5d/ougsndi+imeb9OFOL+A7mf/kj2hUdrlFPqwHg2Va76znrDrSDZvQrn06?=
 =?us-ascii?Q?fdvsV3ZmPc/eKxNHk+e91OBI+uKjO4SijBQhegXsOwVEarkiqVG5g3Yz/ImX?=
 =?us-ascii?Q?fjM1PjyOJYZLjcjqR0k+II0H7gNjLXOvyh0WrIpqbIEyt7u/4+ffdccxEhw0?=
 =?us-ascii?Q?hJnFCRcR6aTBIwfZX2779fqnva3UDYJndopuTMREEOs04CI/gmmJn7hbwQo4?=
 =?us-ascii?Q?0rGFzZgm+t+OuJnzino4UJ5xFePhmCQLeEJleUL2rkmG0VzEUDdlo5FFOl/r?=
 =?us-ascii?Q?E5AwCWLAlJ2yiWzlESOSn6khOmct7lB5qsGcyIrG2PSpRjqkasX0m3H9lsoD?=
 =?us-ascii?Q?37ZDxWYpXZbwJSeI5WCiB//A4jcZN9G8iWmYlXoljW+jCRQs4B0JhH/b3OlZ?=
 =?us-ascii?Q?BAc9KxLWNtXoeV3S9+Pclaf4tElXMAXpRIA0+iZYMlm45hfZ0JuuPqSMBC5L?=
 =?us-ascii?Q?RnWhQ9uBbF4jdF0TWCJ5kKWXiMKyC1FJUASqLrZEKZznKszP3nXQcyRaUps/?=
 =?us-ascii?Q?lI4H7j6atRvBjF9JquqPmi7ID1wXxux3SC3bO5zIq1JwdMWzNcJrxyWKgN1R?=
 =?us-ascii?Q?WqwdbhRoPrX2kzrlmp8jcsXfqq620tZe01TJM/3AaA4BZQyZ2mblPiAgxPlX?=
 =?us-ascii?Q?KO2uCFcPFXrZ3P46DAl18o/Px0mCNbcdYvGR5KF16g9y1U+k5MoLieFoKzPX?=
 =?us-ascii?Q?MsWSK3g9Yglrnwsx6tC+l9zTWwXgVUF7Xec4pJEEGs76hHGLHYnoKv7Fzqjg?=
 =?us-ascii?Q?+0JQU4wLraX2FyeRVyXMEFRLEdjEX5q0eUOvB4MJppbNC9ZVK/htNDE1zjCY?=
 =?us-ascii?Q?ZlDN3+hC9CR0pzNTqEXEZ6IHMT0hvVo0kHRfJwxOeG62inP8YGrszttUjdMk?=
 =?us-ascii?Q?a8NQvMZH4xS9MaUKJSPLMsjE/soeq8mkzdsFBGMlcoV2s7qbAV2VYYj2OeZO?=
 =?us-ascii?Q?PL3nGrxH7nqYyltJeOlaIXG0s30JNigiLWIuubFBSRvqv2myJ5scWzWCVK5r?=
 =?us-ascii?Q?hYgKJiutuGZ0sVCsMEQJR/Y6PMQ4vh4jxUtPuGawD/mktJPKpi03kfcA/ywQ?=
 =?us-ascii?Q?Fv63vyi3dckFjVzZhatGhAzIGxBvr/gogCfYGxY2wtZR5bJKJWGe8tC0sV7B?=
 =?us-ascii?Q?9x2IB1VVq7LJA1fOwWY3wDIpQXi6b+UuSQm1I+tSH8w2TalpATT50Tr7OdYW?=
 =?us-ascii?Q?wJTX/kbhHgczcds8FVti3fYHmveXA5os3bl0J3jwXVkdbYUGV3d8B2nZTxOp?=
 =?us-ascii?Q?lpexN/LP5b6hdnvtzeaVKFEGJQQBwqvgh0Hx2DpquOhRplUDbPcAAAkOfhK3?=
 =?us-ascii?Q?yG1DMWnOuF2nNvvLp8vPHmZ0uwLWosrcCKUXLBJRKTgB6DNdAFwpxXcjT5em?=
 =?us-ascii?Q?mU+o3EH6QztHYBMxh2GyA7S1lEEJ09s=3D?=
X-Exchange-RoutingPolicyChecked: kKSy1hs5gxA43YArKdg93wOloFpT9kdr8XlEICer/I6QLPaZNKNKF2i9ke7UaqECKB94jij1bJDsV4ivU2q408i09l2t8vZtgJ/FdayloESRPuuM2/Gz549WP0CKMFzylZFRh4oBFBaPCaUBChFbZscgKDa6CA2iVcXvAdETvEo+CofXBkFGnn3qlNbSf+Sd1/BvDNFHFFRCMRi9lVrG582+j41HrgsCdjww2Yl8mAByQwJ8WlE9WsSGBfIIeY7XdeP9Ax/Ei+2NWjWVk8fVbIkqp+IvD3KzIFxne/iyvhAy8G2Dd9/bbHNCpxzouJF8p1B4KhXJcdjZa9LY5pMsDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8c532c-c4a0-4b56-f574-08df1b07304a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:16:20.1594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xu6ctEWncn3nDdGktFgahKyIdB9JZEtMiKDtTR1sSNOqIjze44SznwKvsFzc78DIaQUKApha8GvH1V19g6rSrRUfQiqdDUIZBmVSQyifds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
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

On Fri, Sep 25, 2026 at 11:41:08AM +0200, Burakov, Anatoly wrote:
> On 9/14/2026 5:45 PM, Bruce Richardson wrote:
> > The field offset argument type inside ice driver is of "int" type, but
> > when parsing and storing the value from a devarg, a uint8_t type is
> > used, leading to 3 bytes being potentially uninitialized. Fix this by
> > storing to an int type instead.
> > 
> > Bugzilla ID: 2038
> > Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> > Note: this fix is superceded by the kvargs numeric args patchset [1].
> > However, that patchset relies on new kvargs features unlikely to be
> > backported, so this standalone fix is useful for backporting or if the
> > whole other set doesn't make the 26.11 release.
> > 
> > [1] https://patches.dpdk.org/project/dpdk/list/?series=39247
> > ---
> 
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel.

/Bruce
