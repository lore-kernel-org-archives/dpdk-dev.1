Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B2DCD5BC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 11:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F0FF40DD0;
	Thu, 13 Nov 2025 12:05:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 35CDB40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 12:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763031954; x=1794567954;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kdIPjO48XBCmDeZkQluPNsxM9GS61RuYW5BMbt3yl4Y=;
 b=Hn6MygeQpdH6an/9vxwxeM9JsJrc1oXdX15ZPcC+vsI5we29sxCrwhdM
 iBKVXM/v1aR569FMikDq2xBdAdeA1ceS4EqhpXECGaXjpIFPp8flYtekn
 quhVRoGFe3eAM3b76hWhKl3htxSWYjsTMALVt0EeLvy03G64cfUePpkKV
 N47s01MQ3PnCVYbVrAL64ZsK+6tqPS6F0K7JjpVosaX4DycQ6vP9PJmQ9
 JyY23XsDRMbAV9adQHzMWCzfH/Mo2B8wHhoGNxPWrlTwxFhzi/Amo6btm
 c4IIVOeDQh3s0Kb53WklW0Imc1iXHkpEUcAHGvOxx7fJb6GuVvR1qYoeD w==;
X-CSE-ConnectionGUID: FDncuawWS2mcmgKkET/2DQ==
X-CSE-MsgGUID: 8JzF1wxDTCuDAGdE7bi3VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65035168"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="65035168"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 03:05:53 -0800
X-CSE-ConnectionGUID: aIwliOXNRX6rwcY6BOAqzg==
X-CSE-MsgGUID: VJT0K2ROTB2jT4hL6SSHyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="212860859"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 03:05:53 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 03:05:52 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 03:05:52 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 03:05:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tfzt3pn6uicagivHyMSJKhu7vnhHhVi+QFt+ycCRRmx4zGvUMgHxDMJJP2CnGD8N3BRGTkfqmzNfYSKjRKf3afwRVwQ6h/tr7CGw+J61iO2fiuWkI7mBqJ1Lf7M7o+VxE0MW463Rb7c0dQfw4UidTFNQOUw7wER4vB2hR6BHTn8spS5I/oKC6nQkaBU+6gAGDt2q3GNV9YzkkKb+O5N3HAUHsheljCzOiJ9HUVVlR0R0Nw0FK0JDsKBK06BJ7iKSS9q3Snb6RtLNcId55o61SUNqkI2GVg99KAVFxL98DJOW9DIBaDtsYGyqi5JArSxO1g7I+2OqCqa40zWR2AtF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIhpkyRyYIP2yztLPxi3nFsgNfe4o62CIdB0XfyZoWI=;
 b=rclXZjNO6VAGIlnmg6GKZcN7jmrTuXIW53N9vd9nA7k5kFk4L4DcLV0aqgTPdyIXsPSt+2d6KNcJPEcNLO4YyeEvqN/XhDRKFCdq1BXsUuQZJbDUbL5kjYyuyBcgvOMdvwW5ZzdkorhF+4lVVfIwsCbpIFT3OSCNsti99lQMb4jNBzxF4QK68dCSQM+6uGZRp4Eixll07LAwuXv3qq86cYZwWF5NxbSOYQmGWme5hVZplsnCLJxf1zkDcevbxaapiyvieh6WTHPUPGIuIwucEcncx124TSGUBjMi1jT2IGSzWoLcJgZYgJBQM9KQ6DF2gojiAbdVCjYz4Ym6FPNKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 11:05:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:05:48 +0000
Date: Thu, 13 Nov 2025 11:05:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: Sunil Kumar Kori <skori@marvell.com>
Subject: Re: [PATCH v2 0/3] fix null packet prepare function pointers
Message-ID: <aRW7hzYk61-oawLi@bricha3-mobl1.ger.corp.intel.com>
References: <20251110122457.2575615-1-skori@marvell.com>
 <20251112141059.1576919-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112141059.1576919-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0208.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e8c2a6-315b-4fda-1dc6-08de22a499d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/eIuufcP3NXQT8OoV+/nrTM2BB8Z3JUNhG5gqQ9PIFZhPi4YyFYn8mAiWSha?=
 =?us-ascii?Q?qSHaPnudwUmvX4NMTOYjuna0W4RlQYxVb+iqa+qv82MesYsmWKwnwNk3Bvfn?=
 =?us-ascii?Q?M0xdJCFOdD15KhBbc/aBGs2BPiFAN/E3E+dtANyHE0f5OJwqXMRTMIAZQ4xL?=
 =?us-ascii?Q?6+Ioy3t5AX/0HtsTOzsA+0nGNVPEf20MuAqgBetpBcgd2oqce3K2OE3kdT+V?=
 =?us-ascii?Q?cLAiNH3JST3E542HVViD/QUswcHbtNRdXTWGXrcKtQPNG6XRMHKcU2Ss3lGg?=
 =?us-ascii?Q?my8QgqycU/I/MRwW4Fnk7ohSRAK9QZk0CV7Sdvq2bgqgs1rCHkxBJzpJ8XnW?=
 =?us-ascii?Q?ZMCqKPmGZ0bbs7OtWuJZW9kgfeUF7QGYabwPjh/sE4w+BH+13678jwz62GRd?=
 =?us-ascii?Q?5iDaT7z/HO/lEjxAdkVe9zUELzS9GwJ9w6WkyyyTz2Hoz4m8ByDcTFR9Hkgq?=
 =?us-ascii?Q?HBaFk4QKaQyPaZvh/pD8hseOAOOU0t04pVb4oqMGKfbT075EtRl++FnqBnjE?=
 =?us-ascii?Q?AnbJBpWpinw7uw5jKOVHsx10gxEKc67vnsYOo9f8fVVe8LrhybKkgycTwajG?=
 =?us-ascii?Q?Jb4E11rRuXlmsdyB8ZGc1IIDeSYmKAYvMJ9httMP6VidGujh4o3RXllKUB7a?=
 =?us-ascii?Q?HdzFyq6dEJNXpH/ZxY1rN/c/8sqTjHFOSV0r+WAl5O8h+7tFxQlfblJUQF4b?=
 =?us-ascii?Q?mifeXJn+np9TKQKW3yS5dxqrkpTR1G31Zrgzp49qdNLpoe3zm6JIwkvxsF52?=
 =?us-ascii?Q?YLWNZW2A471KhJK34r2A6WvB71hW6Qh+qLShbeRqaWtQeWxj/Ne+CJMDq6D3?=
 =?us-ascii?Q?ZfCj/jPX8Y9VF33fVN1IPWlQoZZq3duqYN8DLcTrRwT0slIuPpDqIRkJ+qXD?=
 =?us-ascii?Q?WxRyF2OpYSdrT8eF3sgDQ5gWIp+66OKyiH4WgcWTTc1A71d2oINzQ3vzWiel?=
 =?us-ascii?Q?sFxnkPxpcVp+v1sE+xa0NpblH6sgUYrh3tPxV2XWLa97M5hOm7G41lLlwivZ?=
 =?us-ascii?Q?cHE5dxUKRhj1b0Z94ll3bGWaWfbys+xA9B+upBYSSB+IdpddMK48qLeuEjzs?=
 =?us-ascii?Q?bSSlBkjJoSQzmbT7PYV9VmH/pWxZ1MNdkQjt3Js6nBFJsnKvKc+zAEI2a8qf?=
 =?us-ascii?Q?61F+DUORlVrvmUq3hpiHkKYQRBuar5fNHU2La1LmHmBaLgdIScjgz4QZrIpk?=
 =?us-ascii?Q?kRA5wLUNQHS4HzZTYvCk7xS7Gvo0RUCQ30RB6g+5nOU//x5ZtJSfBXQsW9dp?=
 =?us-ascii?Q?HDyeOjHNkGd7cAdu29TeBhHTt8M1EjLlxrrkdRHdUBHPuDZPkMjW9FRy4Gbh?=
 =?us-ascii?Q?F+nSLyMTSfFi/pcWgtm5dnC9RuU4iZjKQAKfiLOBsH+FAE0Ch1J4CM3lh7Fc?=
 =?us-ascii?Q?vEA5Y1IRK5/jcduG1LOABg9qQ344r6ikW0gA9NqomblC1Fagj86brjuhajmd?=
 =?us-ascii?Q?tkS7PCXpg3eh/y0NomtNe6oehmoQF7RS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPVWp3BrqA+GxksQ9FrEt2kFJjBYz0+vcS3RcZYrQTH9FlnZllL2ryorWVBT?=
 =?us-ascii?Q?NqUsaMNBNGQnApHVxCNEf2r2L3gB0pScB6a0GQS2tUt1YHOkR+TWxkYnzts+?=
 =?us-ascii?Q?Wler6Y036NuKifGV1mbc78HX8DDD1mNeEguIjGl4nEBNrTu/gkeIEM3NHXJX?=
 =?us-ascii?Q?LoUmTcVWlvZEvl0Jx1DRUxoqiN2kY0rWbNYrIoBq3ws7WpuT4Q4gFnouUeN2?=
 =?us-ascii?Q?HAQ8GUkJlZZCQqe7jXwGtYcjod85COWz3H4BgZi5OE/w47gAblUrPE7vVydB?=
 =?us-ascii?Q?HtE17B/rUAGA3IyGpejBLKICaq3ST5791Dblv0Y9teaTFsNhyEo66qdGBPV4?=
 =?us-ascii?Q?r6rpjAe3bmN4Qw02TAyTenV9fFy7Rx34CmiQUrUyKXaFON9ddMURNpOVGD2V?=
 =?us-ascii?Q?XgbdA6E1MCCMcb77uASEcF5PQBWhPbPRsPRt5fwe+bWCgyvb8L3bvnRX3CHE?=
 =?us-ascii?Q?y6wZhBLHEiEmX541yRDKdlhwHBcKyBxwjTjcPmWiT5+LRFjNlOz+M1CsFUC/?=
 =?us-ascii?Q?Ll5UGm2eO1w0Sn52y/dAZFiWgPlBFdjGC1TVcifhPs4iOmvO5+MIX6Fd4495?=
 =?us-ascii?Q?cc0xjt58DXrS+b4jHsBjfq6XX9B1i71WadsN7nbAqyMQwbidpiwNn7WyFoti?=
 =?us-ascii?Q?Y/iKow1VxR5O4kUZzkGRFJHBAlI0If87+RQ+/GHMzUqjBMqCC3YQ2vC+jAyJ?=
 =?us-ascii?Q?yfFrH6y371XiXb1o9aBaA7Kf+fxtmmTMqHHg1s7mRPm3AxdhPNeU0zm0oJUJ?=
 =?us-ascii?Q?aAsAto387+JbpeZTNIYHAjGpXWCMcPe4FlzAPeDr2fAi3uRiSgJsq18Akuhe?=
 =?us-ascii?Q?xNdUASTjmi76UZGioryZriu9obsGtS1etIXybttBWvfWKlMXky3VNo1VqPBX?=
 =?us-ascii?Q?kZKeUAK43p69Dvxw8vhi1SVtPyD5LMWnv3ro1tg1oClnLsWkapAzJ0jtC8Gj?=
 =?us-ascii?Q?njOT9cNiwH/pbGiS6Gx1cYwXijIY/1DoqtWvUfCSwZijB5HEM+N/MUwwRhaz?=
 =?us-ascii?Q?HrO4q8Us8ANfweg4aHkkrlZuQQBJp4QQzF//8shoGBwB6Nvz1KaJaO3S3VM1?=
 =?us-ascii?Q?pDgYt5P2x0+u08CbEdr7IYXojwzl2Ml8ICajErt3jjt2vLtgG4wawECjBNGo?=
 =?us-ascii?Q?+51F7S1/NvPpCw/sdPJbCpTUzJZG6tjf2Gh6hRaRnu6loG1uITl/OaJpL8Rn?=
 =?us-ascii?Q?k2GsicFoUgLUl6oVLgbtSgxZuHTuCPE2PIM+qD8lDPFHus0hzWYL5kQOqeNP?=
 =?us-ascii?Q?y5pKiRDAHAhXU0VhYqYSrhDP8rKpqW9Gi379CgdGMCSNhl1+aqPbsRnc5a4N?=
 =?us-ascii?Q?XAXaKpEwh497Te6c5m+Idb2xpgCT8wvzahwURdC9To0uG6+yJMbqai+LDuMJ?=
 =?us-ascii?Q?gp3akzPRF37ScA4leEwHWbrPdOoWJbwzmBKKeoUM0x57/soKuqb89xww6GtZ?=
 =?us-ascii?Q?Z7H87FQy43IzeCMq434uq5tLdrQKYjy786tQ/OC0Z/JHP3zAKzP+LHxY9Iia?=
 =?us-ascii?Q?efRvzokDR58/cInsnRmeogSW3Wd0Af9JOAL5dnh/B8sg9g2gnZNp8lukO8AO?=
 =?us-ascii?Q?HPmCr4N/8D5Qg2yEixIDcQ3ePv0wOWV1IMt60Qz/p8BmbsITxmZ1cxUVrKk/?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e8c2a6-315b-4fda-1dc6-08de22a499d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:05:48.5412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAZtn95/uuYViHidNaBtihiyDMHCA8sKZ2ArAD0ROkHPwJBOQkuzmt3W+kq5gyJXSe8fa6yTXHRRIe5Utwq78znppKgqwFIc17+ynXU6vWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
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

On Wed, Nov 12, 2025 at 02:10:56PM +0000, Bruce Richardson wrote:
> Update all intel drivers to ensure that the packet prepare function
> pointer is non-null.
> 
> Bruce Richardson (2):
>   net/ixgbe: fix null packet prepare function
>   net/fm10k: fix null packet prepare function
> 
> Sunil Kumar Kori (1):
>   net/ice: fix null packet prepare function
> 
>  drivers/net/intel/fm10k/fm10k_ethdev.c | 4 ++--
>  drivers/net/intel/ice/ice_rxtx.c       | 4 ++--
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c   | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> --
Series applied to dpdk-next-net-intel.

/Bruce
