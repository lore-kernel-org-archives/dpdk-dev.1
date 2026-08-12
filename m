Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4CFC5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 14:34:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 470AF40298;
	Wed, 12 Aug 2026 16:34:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 66DB94025F
 for <dev@dpdk.org>; Wed, 12 Aug 2026 16:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786545257; x=1818081257;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Xb5jDZBSRFpbsJmZH0gcVes9i4zo6xxDMHRPpiwIe28=;
 b=NjFSdYW9PD1IG6Tfk2XuP52fHO712uJ6pVMkEe32xDmmuXSAhEmwiEN9
 0Yo81FVI2nMNSopP7WL56sDADHgO3ncFefBB5lgzxuU+OideRAmqvY+Ba
 jm4dVrlpCEiRRFWNF5iPJAT9k3aUHFUVAuz7L4wYTWxDs4izjdsoyrz46
 G8UMX7G6ymb7/pNFc2uW1NDmFhD5KsFhvIkz5DQK1+6q5LX5AfZp+mSvd
 NLqKSVX2tSHw24edz0dxbMIT1t5vtv3v9ioIPaL5ubX/9w3jNSwEsWaTf
 RrzGjF2lZ7aSI/D180ambs6SelUTz1As5bUdJKrUjLEu4bmmQyL6UO7rJ g==;
X-CSE-ConnectionGUID: dFGT9O3zTtexHzgDcThxPA==
X-CSE-MsgGUID: a4KTxjRIRnOAwJG4O/0GJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="74638888"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="74638888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 07:34:16 -0700
X-CSE-ConnectionGUID: xMc72lgpQmu4i8RvV1Q2Uw==
X-CSE-MsgGUID: 1DAhGzhpQSqXAR7JXuEUxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="293607420"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 07:34:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 07:34:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 07:34:15 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 07:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUBVQLPxlIrJINC5YRsMy4cLScLuBfFBdXmaZLxEhq0WVTnFkmn/r7d+Yfze5Wk2yUiQNuUxZWO+m5TmDwQs7ZUQIA+zDbJ7RFfftKBuRjwtIN9FyGv6WRlAtRfYLkrfPrwkmxfnPIF+b1D20FLdgl8GluUgMflslEPbwWRZCoy0e5bjZBkB9fbUVbU/JrUmu8O7iRlbNbxbPx5yBiFPaj7z5JkAXwNK3EVHmJhW07tSXAJegyiTWYU8FCT/OUPhjtZ+0Er6PK2f/dtVqAQ09xxnvm+ra9gvk/gFANVHy7Bft6q+/xsCFZZvpGLHxKpjxhhI/NyThnsFniR6EWwMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBVSCr9vv8gK7XkJKlSUWK6vQ8LH52bKzmIh3agjqvY=;
 b=C1x2+7/A2S8i+fVKh5jFXV2d02rNyzCE8dL0nSdvjl8p7VaVfy6DX43sNUttGeD1lel4q3BQSL9/NCmT9MxZQRTtG1IK1LWkhu1TcrORl75Te3kQK4y9j7fQBrqPVC5RaLPuZR+r8iwyB34nIPZrEoqeDdxXN4v/nAn4uFtW/r7F0rLOoGbhfYJ4/fc+4yC1YjZbbQGqHnbyxDnSP+1qEJKTzfkZ07CVrX1tRlPaeI/ea5B9vx8wZm2jx/gF+Lxho/FwFqAT15tW2NtJcTb5U4rVAQNWACq4r4nKK7umE9o22GeTDPV2+on6alC6DDtKyX7LuLWoU43teJ1yc28DiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by MN0PR11MB6160.namprd11.prod.outlook.com
 (2603:10b6:208:3c8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 14:34:06 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0%7]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 14:34:06 +0000
Date: Wed, 12 Aug 2026 15:34:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] stack: introduce pile
Message-ID: <anyEWVXfFEHBbsAJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812134756.1829613-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0228.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::23) To SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|MN0PR11MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b02056-6cfb-40c4-fede-08def87ec36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: AmIMh2z3d1aCjoDCLVhDUZB2hy7mREcdsTLtJ6XKyE6G6lcxYJJQLwPEecT4scwBS+UzyZKbtdklx/pJGnPiI3lUR7B8YiJEJHbQE570xprpGHvzm2nSL7yhTjo1sLfSYHVv3KWiwO47pHDTVsuK86s16TRsVx7DhBRtDuWx2mvFDJaswRGaFF+uCtB6R5+GxDQqn5eAjaKj51hD5jlpfx3DfQvaKzlvIILOtb4jSkt1bYvmIx5H82qfXRGva5Z1cbgvKg0aRFJcRvUXBFqu1W4hyymO/n/uMFZLjJ1gOQxwP3ovQ+tG5IkHbZFjs7UIAvW+Q2FtsKGAljI/hcQ+mx6xSPAEVvNKpdGni5VMCtj9FXC6gu/byWy6t0anaxtxKiGNB/1HqwwQ6itjeGxdRvgI/oL0hiOyM+wcofl0fXkJ51P6thOwvHRZbyFinC+J5iovTtCU7KnBi4lwrlPyCDm5RrwfGTyYM+Xts4ABNpuDJ3sdEfjLm5ka7+i+voor25GtzKMsfXoWDsPWAODQwmu3HsTvcn4zFWwfeE0yjxafbRCd8qjZhzsfylqjj7hPG4S/VVBTcK8I/3MNZI6P0fz/SRsf1yL4VL3O2394VhrhnORxIGWQWJxHuIvns8+1IKmFwEgr8jzAr5sLLxFnBTI4iBfksWnpdGxcwRmy5UA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8iPKEyfzL8quwxijmRiqwfthGq99bPOzzGo4RnVGKEZC/mi3F7n7YvJryS?=
 =?iso-8859-1?Q?0N5fREqlqWyamLe+jq2t5ieTW/rkPGeU4QoEH6N6niP+Xx3c5Y7tNaKtWA?=
 =?iso-8859-1?Q?Y/6WVd+b9h6NrRuu4mw5TXYStCMl0VwEA8MMwFT6HH1DSgcfcDGs00Nwps?=
 =?iso-8859-1?Q?30Uw/WoN0FtCpP64DUPzCnAUDp/vcfvqju1yrsRDWLk9x4vhBNZbGMdjtk?=
 =?iso-8859-1?Q?xjTASwNfGujRngzIMAlMDG3og1fYJVlfZjq0CVOsxOAYKPLY3nFr8iANqd?=
 =?iso-8859-1?Q?qrpj8uYbkKcTiHgPS9+4LiQsllT/+/JeM29o5TeNb/m1HnZ1xMlLqUyD6g?=
 =?iso-8859-1?Q?quxjDAftZEgqIYGPwTWCBmX5pIEEtaOFHzPFCfLdTsmzsiMGvZFO3wS+Hq?=
 =?iso-8859-1?Q?kvXg0bYe/Kv84pVmlahJTBE1UOXEmE6/frofTTXKJUMgltnpBDPfIrdM5b?=
 =?iso-8859-1?Q?z5QJachvExO5B0e6cmGZpsuXCSMnO/gOtIOvQTFkZXdosYIBjUUzmXloEF?=
 =?iso-8859-1?Q?284JDp/X6gElvwrsK/j+xKXbf4K9Tr7cEsoV5b6p2Vm22ddQik8pSM92rv?=
 =?iso-8859-1?Q?BZ3boXVzXUD210xaTHb4eUKfqK8ayPci5pCgrJxO/EJh4WvEMdkMWXJpOe?=
 =?iso-8859-1?Q?4aoKzoBCJQKpHk+ffLSdDrc3gjSUGUjaWI38R3/c9INNykAUNab8qQeLGi?=
 =?iso-8859-1?Q?uQDpHFFLNyCWD45u53bcXR6dGXUCgwbXyKv4IV2lRsYswpwUxD0wVwtmm/?=
 =?iso-8859-1?Q?cVwBxQdGrDcnZBICtQL05JQFlPP8L2e6lnbC8CJLIe/ZEQ6jSEn5uoAIMH?=
 =?iso-8859-1?Q?KbU3yQ1y5ikc4stP56Kn50wQBV/NPhlZ8R6cOkvgLSk5Y4z6BQ5VQsHrZY?=
 =?iso-8859-1?Q?M96WWAZpoMbYB2g0liW5BHeWFk5ziZjUm5ONN3vNPky/eI/k4s42xH6l2s?=
 =?iso-8859-1?Q?xqTBOIPs80eGzvW06lQC7OcAdvoqfAfHPbsc8/GD7wL9UdGgcDr0KlR2ms?=
 =?iso-8859-1?Q?MWazfxEHg3J/7GrfcBkLI/RvM3dJAHg+B/E3QPANu//t7ZGPhe+N0f3Lbq?=
 =?iso-8859-1?Q?opf68bwAv5Yqm53fdVppujSp8+SYsOQNtm/yT7yGwneDeEfJVSWViA9jTO?=
 =?iso-8859-1?Q?Pynsrknl9C0cqoJGRe6mulOXxZ3aodOluw3JoyhMIYQPjUAG8En3JjTbb2?=
 =?iso-8859-1?Q?33XbBbyEnJVbTC+dnGBdVycfBIOTP+H0R94AHau1JnhIdPCjCTMv8P2vw+?=
 =?iso-8859-1?Q?6qEtbm0qYV9M5d8Oj0l8iEEmVwdqqDCmHXde7pJm7W8+SfY0jLERAHmjfI?=
 =?iso-8859-1?Q?hQV8oUSFZ/gymyMDFg26j8Xjzv1h988Rya3V6VgYyEqV/p+oVHSv6uuTv4?=
 =?iso-8859-1?Q?u1884Y9Z+VxWLZcn5hWBfd6Iw+f3wz295m5Wf9kYx9uyh9Y4tCDqi142e0?=
 =?iso-8859-1?Q?x4SOHf2vevzXifc6JKiNhwnxFuDRjv/H50oOS1CpSdoHTVgbmdNpcSecXQ?=
 =?iso-8859-1?Q?9W8cHh5SUUSpJfuU1OCNPNU9WtlrKRexvq9sRiIIfESd+UT2g9Z78A8dDU?=
 =?iso-8859-1?Q?b6OIQPMgjegcoz3WfdNymRvSNmjgoMzNBkUjKGH1rlGEtfPOxkhMCvUFt2?=
 =?iso-8859-1?Q?B7OZR0ra9HcknbXyT3L8uRMnwbUXSsGXP9P6Qe/zZyYga/XTp6Ps3arEs8?=
 =?iso-8859-1?Q?n+CQUETdD3pZH21SMNnt57InsMMgvt6HwfNKZvqH0yZcSvwFrT8Q9fo43r?=
 =?iso-8859-1?Q?kn9KcQBJltCBkRdG33XmlpMmya1gKgRD10tzvQ41tR+l8svjlxMRvb6HTl?=
 =?iso-8859-1?Q?gPXjm/xwqq37GYYVBZStmqGA0HDOUu8=3D?=
X-Exchange-RoutingPolicyChecked: K6XPBu25UDrwckE40wcTxbkhjcWXIL1nDzz2VD3EDWXx5QRVKFm3P4v0QCIxF2a/6xzCZ9XfgnFs9PdsdAztdTXcf9NcZe3SSM59fkdVDTkoh6X4EqKeFMKZOmko3c/vHVVd0xG7+/2qPZZNTANeQGkTAwYumx2G7xhDx51MP75MJ4m5R9nEprMtUCmD7tTTKY8EnP7uUqLrEa2TDkv7+FZ6F1I04OHmWcH1L2N+XyLGZoAW5brfCzDUnB+4fxUBLjKyqtByZGZiLXpuXE5GAwyoXCkzt7K5bsBdm+x2YqmrgAH7gWT7FUyKVElt/1ujO77TVn3RWN9FAzF0QGr6AA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b02056-6cfb-40c4-fede-08def87ec36a
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFED9C9AC99.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:34:06.3010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwaZj4j4RcPwPT5FrqQpKt/r5MKrV5ifu79eKkQO2fQ2+hvNDXY22p+QrSdsOmDk+yLMIHJ5qg0Sk41qlu1fW9cvVfB2nHkYyY6oAHNrg0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
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

On Wed, Aug 12, 2026 at 01:47:56PM +0000, Morten Brørup wrote:
> Added a new high-performance lock-free "pile", using the Stack API.
> The pile behaves roughly like a stack, but is not strictly LIFO.
> 
> The pile is optimized for pushing/popping bulks of objects, which
> it does significantly faster than the lock-free stack.
> 
> Pushing/popping a number of objects not divisible by the compile time
> configurable bulk size is handled gracefully, but not as fast as
> complete bulks.
> 
> Performance examples, stack_pile_perf_autotest vs. stack_lf_autotest:
> 
> On a single core, pushing/popping 1 or 8 objects is similar speed.
> On a single core, pushing/popping 32 objects is 2x faster.
> On a single core, pushing/popping 512 objects is 10x faster.
> 
> On four cores, pushing/popping 1, 8 or 32 objects is slightly faster.
> On four cores, pushing/popping 512 objects is 4x faster.
> 
How does it differ, or what are the benefits vs the standard stack. The LF
stack I'd view as a strange edge case, since even with the standard MP/MC
ring mempool driver you still have atomics on the fast-path and you will
still get stalls if a thread gets context switched out in the middle of a
mempool operation.

/Bruce
