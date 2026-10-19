Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86DFCCF2DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:20:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91C624060F;
	Mon, 19 Oct 2026 12:20:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C6EEE40269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 12:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792405223; x=1823941223;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lMBsxe6RM8LY7rzaOg4nXThDfXMpgGpwcrFUrncXj4E=;
 b=g07wUx5BGnQLc66UZZxtnIG5+xycc2P7TL9cYIQ7fd3+qXDJ/zWTv5zi
 DnrpBUfXTawF2TQ/IskEcHZHr1tREETrzLQ7/Si51ni4z/LUuTEtI9iKx
 8CQNjJ1OPwielDT67atHhrFl7YMl1DjD9hWRU8zbwkQvnmATFhzAeGE31
 5HUwhPyAR6GraP7ApyiEG+cPnwWCeYnrvB7VLDnrjtvRkCxYXkaGSvPS1
 nWqkcFCCIY24unJXZjXnzp132fL4um5Ed9/eWl0lHMCtWtJ1J5tVHcBPM
 w0EoJkZc2qHvPV88bjd71e3Y/0ubRZld1qkJqNB45nACkxoj2ZkZIgdcf Q==;
X-CSE-ConnectionGUID: IGRzqeHdTdOisjhK+Q3CWg==
X-CSE-MsgGUID: Y9AboYw1Sja83twr1yw1Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="967505"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="967505"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 03:20:22 -0700
X-CSE-ConnectionGUID: 8l7VdaqDQvSkoYZkDNEeSQ==
X-CSE-MsgGUID: Q/12K+I0RJyKLqOXxv7/KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2494914"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 03:20:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 03:20:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 03:20:21 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 03:20:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIscYXZJa8T/1B3ntljXNWPTqNcyhLaeva5rueMP7IrB+epCC04k/bPL7vD1D9NuFbZm7byZigyiKokqy+9LJwl2ZcpnigNLeM0PRvxYhxU3hg9M6W44CSGlEBi1+sRm4MM9vzuood6kVsVL7DQgVEz1PAmgI/WPEv/TwvBVlW0gzGgZ52KnywxMtgOm1LFlLCmne3QVHw9UblXncswMpwPBCBJlVp1vG7oL4wnsTgquzyfk0fMXiH1UF2Wlf/Obcfxm/prmjNfra5Z3EoxZoydFTTKo+3Nx+DOZ9Ltr31USggC8C7RhHe5KxRpwWgW9F9rlX4YRbsK07Aj0YMEn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e72QEQ07jmInfUAa1MtNDC1gUe10xdVugpfIJlxa5UI=;
 b=quItQrpGQPd21NSXLnDxl1a0drdpwCy0B1chd/vngXkX/3y5lutbl+6hwLZgjsCA/OAiRSYN3ViGjZwxmJNVik+aF2dUFPbNeOyyRdT706Wl6JnBzUyEmqI4PW7aOZkNl2xOuCFxju1VJevJXU1suMdBoazRDnLTVZbROb+bSEHzOrbNeZj7QiIXGdXKiw5NY9ejaZxFBN7H8HuYBYHAwkl4qO82FzUvlJUHIO22tN8H94zFDuiGwF6u72qDYcRoRcCKcnXX/oKQbdeFEbN/zWvG10D7sC5A6lacxP4q97PdGC1onxHlZ6t3DQto7SJwMaMF5Mudo+dMbxvt+oOY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:20:19 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:20:19 +0000
Date: Mon, 19 Oct 2026 11:20:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH v2] argparse: support range step for corelist parsing
Message-ID: <atXu3p9LJzErvnFF@bricha3-mobl1.ger.corp.intel.com>
References: <20261016093001.9067-1-fengchengwen@huawei.com>
 <20261019085748.34787-1-fengchengwen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261019085748.34787-1-fengchengwen@huawei.com>
X-ClientProxiedBy: DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM4PR11MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b1e3da-7c49-422e-f06a-08df2dca93ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: l2VL/dynN/hJ2YuoeOYo8GDWQQOML7Hzv12JZLy0tRbYWlBhv4FnAHNKQTUK+NKcVbPjGp5LNbPRVsAcxbHHnvXFWI4Rgna53lahJqCN/gIfg6OFzUEy7AWCrtqtB3zVnQrfuZZSr8UnZfsAZ3ilGGuOKU7WO+ypR39CNzuFOu/UCW6rPvYPAir3vIwLhVugdLDrF6b/uVTJjGG7vzTAheJUzXEtC9Zc6meSke1DSolZpvuZC3X8xroD0UgZGgxAwf0s9fp3bb8HE+d5keN52jAGnwT4tcYpFToKjhJxhoh5j3dibW9mfJOEPU+UQxi9Q11CetS/wGx8ewMfDDNvFTIfaSX+Jn1QmZKCYrIReb5AEsMHA2cmfVYxc4X674fKC21LwWrWxNgCphTbYRBv1+t8Ch0hACnmqYkI3jRhd/hO9JADm2UHhNT5tp1WT4metOkDrr2P/HoZD16kqBnV+pOkJRsi37ZeK2uPmzMq1/tmGctb0EQ2whaMzZIRGpiRYkpYxpOSjV33/wAzbkg60Q7M0wJbrItPuhYcpBd5QX/BVgdHRqL4/H7yQ/Xp/zRKet+bz6lHD3F36AQQcBWYKSjR/zZeIvmrpAC4DvwsGPZNcNs6Lcm2g2MaEhVR25BYNIgert+uueXWXqpjSRr3/A8eiiS2Aq+kGNcic37hOxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GW8FdX+YujamWVcQykPkDgRGePyC2rhJJbOPaA9pVy3UzBooIUOeeeIqoYBw?=
 =?us-ascii?Q?7HledwVxmLN/f/Vdw5C20WnxpfzfjdBH6a+SP4FVPpNYSLprH3ycpnTP5U2k?=
 =?us-ascii?Q?xJf0lWNr0DvuNksONv/Q5ea5xXanQiecUc+IDBaOnSdVicilV4M+j3BVo+Xu?=
 =?us-ascii?Q?he6ggPwqMun2uN1bnZ9XqIX9sN1qewzrwXtUz05phaQF6z9fxedX12cZSM85?=
 =?us-ascii?Q?QBzlkr6nKWgDrLg8qyJklEppLa3WjRVeEdVAnCyE2iWXb6MmpA8wsZsWrt1Q?=
 =?us-ascii?Q?/JpKvpdQtdja9ZUK1j4PduCde8Kdh2AcjJ4IZ+cHPpATpG5rvIC4h1fmaSLz?=
 =?us-ascii?Q?NN6931133uED7Y82AMzjlNrVLoAFw44u1zLk1B2DFI3jdV2RfbT5ZNEiIbvr?=
 =?us-ascii?Q?evhxJTMN/nSxsfwjHeqTID91fcEfGkkO1JwoLy9AwWYStAwQQY+Nkvn7Cokr?=
 =?us-ascii?Q?xLyigkIUtMjh5a4sCQyv74sF5Wu6TYlI9UnO8ZzE7I+jD7r+dlIi66BxY8FK?=
 =?us-ascii?Q?ieqS+b6q66tqWwwWhIE2a0SXO9oPpFOJKScc3rFsQ8WwGjHWtxlvQMBVYElr?=
 =?us-ascii?Q?mfoBj4fIBFyW1tPldQqw2wMbcfaJCUldBPMLDMLeurhhzaxgWLmnWgQeeq5N?=
 =?us-ascii?Q?jM9dNex6F22LRUiEcsZb+APMzUYHyns1Gruf77te5WJRncgPH+B/hXfXWafz?=
 =?us-ascii?Q?EezlhmtW810AWxHE3VAyHeq5CNR2Li7uvT0ZzG+woDVHMKywjaWuK6Fg1Qzf?=
 =?us-ascii?Q?3CbyHg5Gx0Eb7ieQuly3qF4hbyYycVTAO8XaUy5djSEvqZg9mUuWeEIi6fR+?=
 =?us-ascii?Q?fF1VOEkKTextgtYqge6+iVS064wXygqWEnhP6Re7f80B/o8rQq/WMYM/6gNx?=
 =?us-ascii?Q?kD5hzceHUu2ocmmk5pYXjYm+Z/BpSjcWgqc6YlBX7df4nGni5IOGXI6yExeW?=
 =?us-ascii?Q?+uWZ/LqMDQCfrNjDTWl9T8cIQZpMKtxJ/Oo61By82VnhS5HjrW5Y28cIWZWj?=
 =?us-ascii?Q?/Ks9D9pD+yEWytpFMX/DZq/mEOadzEqlIJMVzNyk85yowdaFeHymDna0ZOGk?=
 =?us-ascii?Q?cQkzmNZOpkK5U4MP3CUDsbGd2DpcL4pAQe/f45jZT1jLBNQqW3nh1/h7/o5Y?=
 =?us-ascii?Q?k7vWrBNmXLiFZ6wk2EZ50YMgxIfQCcr2z6op5RR4nMA2PfbdkNdV1omhWH6m?=
 =?us-ascii?Q?Q77qS9rRAFHhdlxa5dYRHz286p6iGHT04roNA7TUmYKBPwV3DB6Pxcdhqk/r?=
 =?us-ascii?Q?V5vn2+OcAEgz1nu9fXHl0HUXCE0gPISkn+gMqNNuqnEereHwRLrKPEVX7fut?=
 =?us-ascii?Q?TaV8n+R1CyghTJl/3pF4k693sgyArMrTt1GwPkCnnhlSWArOWeiGk4IU1c28?=
 =?us-ascii?Q?DU+uxGZkAay5K6Ry4u8rL5OH0bfD3ujodPUdaA6wxkb5fRQoQrOUBGXitXGF?=
 =?us-ascii?Q?edfuTYq4/AGHS/nrGAypRJdwoUpMr4Dqtcsr8Yyg+iba+B07P4KOTJl8atu6?=
 =?us-ascii?Q?27jhfqxO0dW5/xR3nxj+fto0TCuquuYsD3U7c+fuLcRGe3HXbD4Xly3tR2G/?=
 =?us-ascii?Q?Cr44G5SwamNbe1tkG+GVqAOUp9WYBL4za2GESjj4yzvBWwTZDk3GLpG7VOu4?=
 =?us-ascii?Q?41yuMpRUCwqtMIgrR+39BQBS6wc7XZVRc4ILHo6CwYk01hQ0Tdh/7Ofg3gWC?=
 =?us-ascii?Q?+EpT8budU8XqNR14mhLBfYYKnIyAfbuhnmSktG4Bjy/zXALUMdDBU6UVBEq2?=
 =?us-ascii?Q?izjIr2896OObL0Uuf9xFwwTcz6nLyWE=3D?=
X-Exchange-RoutingPolicyChecked: chLT4gcqlBTafBQH0cWDD16eXHdapipScTDU600JeWOawvs8hm5dsvSW3dchCb1Ob08FTqbaY+h0YMKOBlEOoahgqD/PRUeZYCGQf9qeObIWYUdBSHdSsbwwIMdjVXZAEeOnhkxqcjrsiKKQiQgXWTf6K/Mc1nv1N2Pu4kq6sh7qGzmJFgAHoT3dZ07Pjvh4gShhkwFQkpt41quM68Q621Vti7syvdxn1noRL8LAgAyCPIVqjvQhQOl++mpAkSktd59HOpfST9kazsCQkGDdA5CVtAYjMmAyJ2Prxo7DWhPzZ4akkLc7g+yT75sgc28DrcByCyDXJGtVCVXKPpSlOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b1e3da-7c49-422e-f06a-08df2dca93ad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:20:19.6020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSP4VX4S6Q7Fnl82ZHtL629bKMm3dgT87misiPXMGZ+W7oIEm5eJP/glaUrJ07KuRgFjx79O07fXo9DrF5kWnXXjwtK5EYIZ5x9eGz02Af8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
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

On Mon, Oct 19, 2026 at 04:57:48PM +0800, Chengwen Feng wrote:
> Introduce a stride/step syntax ('-l start-end:step') to the EAL
> corelist parser implemented within the argparse library.
> 
> On modern multi-core platforms, especially ARM architectures (such
> as Kunpeng) logical sibling cores are frequently laid out contiguously
> (e.g., physical core 0 maps to logical cores 0 and 1). When deploying
> high-performance DPDK data planes, pinning worker threads to adjacent
> sibling cores introduces Heavy L1/L2 cache contention and drastically
> degrades overall throughput.
> 
> Previously, users had to explicitly expand core lists via commas
> (e.g., "-l 0,2,4,6...126") in orchestration scripts to skip
> hyperthreads, which is error-prone and hurts maintainability.
> 
> This patch introduces the range step, so we could use "-l 0-126:2" in
> the same case.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
> v2: add release note and more testcases
> ---
>  app/test/test_argparse.c               | 123 +++++++++++++++++++++++++
>  doc/guides/prog_guide/argparse_lib.rst |   2 +
>  doc/guides/rel_notes/release_26_11.rst |   6 ++
>  lib/argparse/rte_argparse.c            |  53 ++++++++---
>  4 files changed, 172 insertions(+), 12 deletions(-)
> 
Sees a good addition to the library API.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
