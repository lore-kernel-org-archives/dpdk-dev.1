Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA2E9A764
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 10:52:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD4D402BE;
	Tue, 24 Mar 2026 11:52:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4E1FB4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 11:51:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774349520; x=1805885520;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iemqm5dLHrfaQJCiLlpHlIlNkR0oMgntpwMs8XHz+zU=;
 b=KeAp4Tb44aaiVVmm6fi354lbYY3+2bJ5RTVdYmivfQUWMHaeLNKZquCL
 dfbbhVsrD9hPbFdHV/1Yr5vAhMiqnJqHQaGdN4G5Xwz6QVSB2mFAZQwN2
 uwffr6aK34QutlActi47b3yQ5/OLZV2tXL1SpvF0FWqVCgHjc9eIJgoN+
 m1Q4v/fD1FO18vEWjOKjZxVOXf02gKeDpUVy5Jqc2ARod/ECoD/IwU0H8
 OJSQ2pru4oEJXkAEgsNRtjhObp7SjS1Ugew9ot5Y0BpESI/bzl8FEcA1D
 OagbJjb9PSbHK+B1INGmvUarjXY2HxOqHscJlUiVK8QtVIjqF9rTPUc0F A==;
X-CSE-ConnectionGUID: Fq5ra217SUuyo2ggz0bCPA==
X-CSE-MsgGUID: yt5/qinWT0iBCv97AuOwng==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="78957168"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="78957168"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 03:51:58 -0700
X-CSE-ConnectionGUID: 0O6XnKhzSFG6BZbYlQMqXQ==
X-CSE-MsgGUID: Ru1vHqxDQDaWYp7RtlJ5LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="221420760"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 03:51:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:51:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 03:51:57 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:51:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiwIXf0u21D7CbwXYhsufiS95Hiwzo5OX/nszUH28g7Imjc30Qh0SP0c9IqUrgFpk+2zXLuXRpMo/Jxg62B0KwqpVAU20JxVRb9PPHQaIcmKv/u85nZwBDqSbkymEi4pUZ729l58HU/AqWCKN6K8nwZrqylFBX/KoqQPbgtIrxHDLag1PDE6CraifKLKAdApIkEukKM37Ytunx+8jYMDz8KdWQlbbWKk0uUlT7Azk1sdCyaWsGyfxRkhCvpKsyuJhFDrpZpaeelPJvv6/72RoEjAFmzh22dhxw7HCnDgjuz7Ql2R1XRCbGDpmjK9ZFn+RdYnlxa+/p0qOzJk3s6Z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5FdToLWwvUVbTdyYH3zh/PrQFCN4y2oRHuFqYzEu54=;
 b=X3vv84NHblxcV4cRseU45J16SN1/8vq1N0TuNBv7wP9dSCPqtlNsmRBUrxleJBrKnpU7mj8yxikD2zRxikBsc9T7NLGs0jzdOfhLqSxvOrYZHqISJM3VemGZ4bDLDL/ehC7OigxH8X/qASKxqtEKhVHYmv2re5Mg/hyuKPZGFM4Frm6133oXLg5u1gpiExqbCDRZgSDX8IGr7WbhNYBAVCkw9Wl84DfPU6Hc/uWum7TxAsuW6ncoBAqJyYiWz9JKT7rGcgWzT/UQiPBUqcHdFyDCVKDSO+W+PnmUHwfqyR1wIZ7focSHuoN6f8cwVTvpE+MXk+6pQX4SjH/qKUT7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7735.namprd11.prod.outlook.com (2603:10b6:8:dd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 10:51:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 10:51:55 +0000
Date: Tue, 24 Mar 2026 10:51:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jay Wang <jay.wang2@arm.com>
CC: <dev@dpdk.org>, <nd@arm.com>
Subject: Re: [PATCH v1 0/1] net/ice: add Neon-optimised Rx/Tx vector paths
Message-ID: <acJsxiGZNAW4IOZJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260323183231.3988257-1-jay.wang2@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323183231.3988257-1-jay.wang2@arm.com>
X-ClientProxiedBy: DU7P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: ca983112-b837-44c3-b3da-08de89935d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: DFPq2toPRy3Od4tNIOcKE5WD/ObnXrdd+SVGHDPmCwan5S6HAlxaPugVWRF9Jm2amPG3L/uqQg/4D0Y7RYfASQmDD8a22DS+Hmw+PKDYYFvMNjE/ibEjeIRcqOABDkkktZMkxSOiE2tzODnfDJqFwXfpShTMEoZDGLpTk79OvdLBN7O9+l65IxD/V4FtsYezfnLm6eFBQm/lSVMib+X1nPOSINxeWXTKryy9TdEfQewJ1daKIwl1MWUyDhvDxyOp1mcRs7BYMO6FjVJyh6c/3MZerf5XLWCsTBvhxpvZfRvyk4z4ftEQ3g+AprRuGF1xG+xPrOHJ3eYXWLdUEy6DJBJpudmxkFnPgEDTT3tQnt2+xUqao1D8bpl7yO9E74IG1buWElF3hbS20880g5PshoBjst17uYq8M7sDf71kpI5ONBA/5Xf6o07aJZ+5sU2uw6C5emxaMRubjjKC/ZMf81IAEpDkL2AGz4H9oWBNhiK5uc1KVPrcTy/E75gnBKBpp9Vhy+eG4yP+huu2YkUp+J9oGQbmB9NzQA+YFqcXQj2ldvsQzAj9Xviwa9b7+35arif7aEqaa8I9aLrBzhxdD9RXrPws1/RO77nSXdOCJmpdhXXb+X2PP8WpCFQ5fhVZ60fz7JdET/GpoyA3BTlwglmSawXBFHGecD2ddTQuR7WXEzMhbGWTzYvAvDVrjyJxeUvO4KHBPxbXZXbngXagZv/NxVky9REglNkSHRel81o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YazmzlUr9z8AyeITluqTrOlgLfC98TagEQU+8AU9jiPvh2FiFCqwv9N4GpVK?=
 =?us-ascii?Q?cy7ycW3cw08GbAvR4RZ+ig5Z509ocUmqdkFKMtuQp5o/hPaQUFDlih82On/g?=
 =?us-ascii?Q?hi0K8e9eWee28Xibt6oaKqV7yTuwMMELtO7Alzk9Y1V5JaEcngkljgXtXt3m?=
 =?us-ascii?Q?20nE2bliBnYR6D5L2PfdAU1mUHEaXbGc/wkutl8VqD98IsvYZjf6qlqL8rHA?=
 =?us-ascii?Q?ZaELO0In/Y/mwY2eCdRACytk8t67VSzBmpPWVlbxX5P8TYCpEdVbpEy/7C76?=
 =?us-ascii?Q?a50cvX3wGQCDpKuK31HorSCVbDfvPV6VVtyADJCjXB1WfDPiRw8+9tiLbCxN?=
 =?us-ascii?Q?4/apK9I3EnrOXIAKnYjsRrJAmLO/ZmZHu0eq/FClFvgr0uYKCMBuTUXGYxqm?=
 =?us-ascii?Q?cvH3R7Cxd/YK2TzfnZf69p13HCs8nDHwoiBV0Ke2EGo0+ugoPyivbDz0ucEQ?=
 =?us-ascii?Q?bWwP1WQWjEEiNpyx9KOSBHyB3SZpKJusM8gJAC6oKOG2/6H82gLXRbCTVW4E?=
 =?us-ascii?Q?cLkEDmGwHw9XlBDd1prtGvd/L5YWyWIHubLSl0uBOhnTTud59eB3BkQfJYRG?=
 =?us-ascii?Q?QB2dhebJk8eggwIlr8/9O4I//LDhWZNfgqVu5hZJrOfArLoO++liTPPGXlxl?=
 =?us-ascii?Q?OFJiN0DLz/bFQqWw5glQB9M8Axux5Sl+iGLaTdQPgGXcS9t5c56YCVFpigNV?=
 =?us-ascii?Q?1tym/3u/VpSAFKWsy9VkdPASVspsw7BkLDhkIwMKUQnYK5Ut/UgHynAfG0wa?=
 =?us-ascii?Q?Baiuzi8RvRPqqTqVH/wFJjZdtBMCiLdfylCiRo+DkYbs3tKsogI31pPUfoGh?=
 =?us-ascii?Q?JyNdh0GA4qvhjTgYwtbrM8grQx5kQdsHc5koz/l4Ro7mPTVOh+8TsKrLdGVG?=
 =?us-ascii?Q?JDT108xvT48VkAFv6r1uXXW54Ou9w7VMCFgGpbJgRJn8b2W0tNHoP3vdt4fX?=
 =?us-ascii?Q?+KnfyfsAaMviOYTeSIpfCEG43b/HdK108/eJ/IjSwC1yTmef4fwcR3dTIiZx?=
 =?us-ascii?Q?sKoRpF6KumQpPhDV1EYel6GCmnZngEN3m8y/8L3ngJoaKVHiTvHpyIvIotbo?=
 =?us-ascii?Q?PJ1xYoWDzqDB41NCV4xiXAAnpivhWhtf7pvCxIj4U9VeoLwBylB4R5wNVcFk?=
 =?us-ascii?Q?KSG1WjHdxqGKKY7ed/DAkIwtbO3xDFZuta1mDrEIpKTKm45XtjEc/ZnFTqfC?=
 =?us-ascii?Q?0/f0lI5Lv985wFwnbkxFPhzUwRzcIveg6iaY3KXlIPT3WEyy4ap15RDfj5Nr?=
 =?us-ascii?Q?YlDnEAtC4pQbEUINwYW9+qedPHvOaxTT4aBJKlvfjOxcKwH3aM+c82BbPySw?=
 =?us-ascii?Q?1x5VoeLd9/26jL5/pt/pfkes1rHmxkh29kHJ2NoKgZi9nVHOhb7c+swXW6RX?=
 =?us-ascii?Q?woCXNtnjehV5OSUQ1aB3UxyUrrOMc5ShzYfXU8tiWPZUivZA+YstqEKB649L?=
 =?us-ascii?Q?IgRo0fZ2lCK40kxy2Do7a5Ihtx35lQ83s0YkWhP8Rje1K1iA8Ib7tZrAzwBd?=
 =?us-ascii?Q?Wmo+VCQ2ruVq7vY6lWyUH1AQprjgR2Q0pSeAwAKAs9yL/igHVFMGWADudYKs?=
 =?us-ascii?Q?kflCxXQVEU9NY70QBUfmJGEFm/oG4adAuYN7Bt/lyOStjzYCiXK+UY7OfJpg?=
 =?us-ascii?Q?UULJmKzMAKZPmAq69uD76gKVzqSArEZEtrXpcI8ChLME535zIf7DUIL3R9Af?=
 =?us-ascii?Q?jAXlJ+Oq/bO4YufqSfXPOeL8Aa8fx0vie1QVPf8jhXKKo6jpU7Y4kdJHaHQR?=
 =?us-ascii?Q?1GQ3hgTmSr1NHEvlO87aKrW5j4M2TWc=3D?=
X-Exchange-RoutingPolicyChecked: vfUW8N7KhVVEKOKBcGQpV3Pz2dXxRJX9cYk9yLsWgOmbwMPEfYlYTKmi1Srjj0VHY9ivvb8Kdt721B5+C0TgM+AunEgcHMQTZF0MnJ7WR9/7Kw2e0riIcJ3CzzmvRHpMDlT5xyBiw+irySGqo/M2DOOMsUv3yWNmuH3uDu8/UFmKeVnRtv1zld80oCoQZ0GdP6saRKNR3rqknMshFBox3Jl2khqP2PqiGt1WtmzPeu/nws8j2agzmsjdeSIh+Uy+u7GT9kIm0jw07vUvIy3ACrugjreAQ58qmwtc2QzPBJP+PRJ6t3C8rqv+SgH6aqtYSt38u665vk8c2ZLPI0x7zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca983112-b837-44c3-b3da-08de89935d80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:51:55.6502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjDYI5BlnQkGOC7uxelzv2AVLUHEMfWJczfyjkVQh/SAw2L/mJ1B995Pdd0EjLE8c7bXzxjfGQr8jQw40unE4Eut2RRgzFryRcnpy2XE+Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7735
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

On Mon, Mar 23, 2026 at 06:32:30PM +0000, Jay Wang wrote:
> This patch introduces Neon-optimised Rx/Tx vector paths for the Intel ICE
> driver on AArch64 platforms.
> 
> The implementation mirrors the existing x86 vector paths while leveraging
> Arm Neon intrinsics to achieve comparable performance.
> 
> Tested on: - Arm Neoverse (Ampere One) - DPDK testpmd/l3fwd functional
> validation
> 
> Jay Wang (1): net/ice: add Neon-optimised Rx/Tx vector paths
> 
Thanks for this patch. I see one error reported in the CIs in patchwork,
which should be investigated. Otherwise, since it's late in the release
cycle for 26.03, I'm going to defer this patch for 26.07, and will look at
it as part of that release cycle.

Thanks,
/Bruce
