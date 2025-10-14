Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E4CCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:27:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DCEC40395;
	Tue, 14 Oct 2025 16:27:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id E49E2402A8;
 Tue, 14 Oct 2025 16:27:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760452029; x=1791988029;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=huUHJuRLx2gavP/TozWGmgmgtmmu/A9p/5RbYWaQLM0=;
 b=fVrhLawmkr0Y3I6lGGs7DvozSfbA16xS09v8XRroCLv+PwcoTxYWfuZr
 udjWFuwOKKVXbprHF2/po+3wX00vPM6PRbE4jygxkMkF8kezGCyMaC36V
 DuKRXxc/Y092V0WkKcG8Q/OOzHQ80FjPW5zZBXdAUEYcmLYMqX/xsUfmj
 +KkVKsu8iF4fmMyaMLp0TukhBRiiVUca2ZAaoKzMelgJhfXbYcWC4LyTh
 dvrQB7C7p30GO0YoyfHcjj5qF4cv7GuHnOF0KcopS+Y39fpmp0IjbdYrK
 66pkNSL4ACt37MujlCTGWuUamtDyaRi6lNfBMOBvqvQPfBbgKbU7M2Q+H g==;
X-CSE-ConnectionGUID: FeVNnO7jRfCcrwWMZg2C+g==
X-CSE-MsgGUID: 15t2c8LfSTKitaqSNUmp2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62541472"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62541472"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:27:06 -0700
X-CSE-ConnectionGUID: ArsJr4wjQ8+JqSp7wQpQTQ==
X-CSE-MsgGUID: ldBorRzGRh2toNrcn8jAUA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:27:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:27:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:27:04 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.27)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:27:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaEY3LR9O7JXKRXHz00XtWf5+Hlffbi2CSqPb5u7kr7uSzBy7mfBengGCeg0HwHwUxchZmfHThDiIi1j7PfTzeIlidf4VsqDoZfjrYj4BN1c32ii+99hi/U+rBf9Je35IEkEVDQ0oPWjsAbQdwDBlIrNF84/wZHsZDLqNojLCSrvvZRhFuPgyU5zjBtP+PoP1Eakh6XbAmxGwI9Kc6+URAjFJcSdOqFOYmfnMn5WmswE5H9F/WNTK7K2yV+5kUVSCW8fYuSkLHwR+ptWICjt4h3QO+knTCkG7YQsOIGZigana04KR488LqRYaJs8TIIAgxMwc3M4p7EuTZPgAFm6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbWIQzPbEVd6FX98/yoT7qGvP/rO5F4H2vM6UwQoIBE=;
 b=Ejz+4X/mZCRkOkwq3xg7TCCRK9jfPmgUPrQxVIDmjFqtve2o7YUBOv7cbo/rNbmJe4XHVEweVup+WGVQd+9KOMrhKBHsz10tvvPETiTdb2enNbk7aUv1YarXcEdyDEHMraplx3gHCS9lr3AV1SPTR2smlKIeLutif73HiBL4iUVCu4ioDNJI1uRQxt5uL4q9ZkJtsvLhfvGi5KD+tMQSUJsmZqC0RKfwOdWg5RuYrGxJe/O/ppmCmzDCED1MipJsK4K3s07UwNtpeqiYiG5TGH9uw+dRLG0jnlhvFSQBG0rJ2OnD/oKHntx4VafIxWxjS0xTSDuQ40KvCKsdFLw7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV3PR11MB8696.namprd11.prod.outlook.com (2603:10b6:408:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 14:27:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:27:00 +0000
Date: Tue, 14 Oct 2025 15:26:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 2/6] net/iavf: fix Rx paths feature definitions
Message-ID: <aO5dr0x6znyeb4N6@bricha3-mobl1.ger.corp.intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251014084517.1407407-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014084517.1407407-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV3PR11MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f093f6-7b9a-4312-4c04-08de0b2dbcdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KKK3N91GQJH9g6IBwtVVJy+dUH/fIGYjJQCqWq2k3UMztz7fGCRghcERUz1s?=
 =?us-ascii?Q?dbFp5ESgjUwOPkvdfHdXc6TshuQKJOC2ZqC58T3eXk+w0Jds/OFJsOD8j9hd?=
 =?us-ascii?Q?ji97c2HmKNy4BOWqn6HsBcpGpXYND6CXpimfuHDZoByEY6t7CpF2eSWRzHDZ?=
 =?us-ascii?Q?UMD9fWKomMAgXTf4nEBuAkCS6b7v79vE4mzLnL7zEDMnCB0X6fKDL7ugNXCB?=
 =?us-ascii?Q?3Q4pYGUS7u/iJILEWzTUohHID7xKDLuCn0b62dUzQczy9wj38Ue6oQzlU2km?=
 =?us-ascii?Q?e7IwFYIeLWoUGSsaH1nzDbuo+EJsXpC3HwKTdzZAI4eLEfBrBdvWU9PrZCYb?=
 =?us-ascii?Q?lbJ+AgorQzyN5yrs5EYN5mHYUDtdy7KJgKHzT/W2y3C663rmUGsVBmp2Ycep?=
 =?us-ascii?Q?aJfkoWSx5TzPQ4Dc2B5k6LDJ+pOGiNrm1SxHiFXWia74oaq168y4F+eBN3yd?=
 =?us-ascii?Q?pc1FuydsPdKAZldk/cPLt8ZTm1CV10sSWmXAsVPBBcEcV3vEpeuPuA8Melue?=
 =?us-ascii?Q?3kgXDSI1BzRZtoJSrwHhvClR+m35X2Sk7BXN8BDCekklhOqnUo/MhUR1uqmV?=
 =?us-ascii?Q?rXrW+S5Ur8WpJyDljQfFnI2Iw5s9017IkdiBo1GWpHZGVT3sA2hpX7mYVr0k?=
 =?us-ascii?Q?2O+nkvsIme0uTYrrR6P4xRyUd5c6amEyGML6Rw3Bs3ayUdHx1gx3I1mcFOqm?=
 =?us-ascii?Q?HsLaOhKaDzZZQv2YGA/IOb7P58zxs5mtXbBmemKkKq5ZC5N3mVQOsALgpznl?=
 =?us-ascii?Q?rNuw+eMBYabH6eBlglN+WViHyx9ZUrLbBFqr3bS8aByf3U2m/8XeaDT6jOvM?=
 =?us-ascii?Q?SUd1RUTvCiSkt2RR/fedz+AT6kg9Ddb+433jgpGaj/9ggiGm+I+unKD30Hxk?=
 =?us-ascii?Q?nz51KK9AqZFUV/n7q3PSyZwxG8VMca3C5qYRTQmfaFiDIN88MK8uamG334+Q?=
 =?us-ascii?Q?tEL2c77O9Rdl2VwsPQQ9t28cmPJRClFD3XVHNwY/Dp3pE2ou39/YQRP0aswb?=
 =?us-ascii?Q?NmhygbVePDL16jIr1LbG8Sv9rX98dMyLYDvKXEWt+WNvPJQp1p2EpM/1B/31?=
 =?us-ascii?Q?MBfrlreBrNZO2/wgYyW8E3yp47KqHjovl5wJgyr4Gs+zdad+RAW8yEykipdR?=
 =?us-ascii?Q?g/3ZqKpiSLiFphUb3GEcmeR2mmVMN6WyakwXHGD1A9u2IyV3lbEhdOtoV+g6?=
 =?us-ascii?Q?HgN3kHSMwn8MFZcBNRnTvaGfj/EHjEFHBgxCmlQ+y+/xzkVarUQh/j4lbCsi?=
 =?us-ascii?Q?pUHIRPrF/+To+NKSfG2IrKTzmebgPmBPXh/c3a0TC0KnKG4qf3hP/61KsiEQ?=
 =?us-ascii?Q?/47YUEqeegud1aCGT66HzlWpA6Hn+mJClv/2bEXOfK705tILXr3Z8OevhfTh?=
 =?us-ascii?Q?PFigDPCSpIP80UR0CpsDHY/aISnhgVLZKA0mFFKqnc6aYNgxkRkWlN8yuB/v?=
 =?us-ascii?Q?u5dY4qKpUglTwyXTYek2H5tqYErspz1D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lBg9UsH8p9BmTmMuM80grKvkRLYw0Z3gNrH2KyhKjtDgSWkYLnyiF3+paj1+?=
 =?us-ascii?Q?TdPYrKPv930T++3R/ZcYb26mepHSHNmERb2woJNAXPG2e5tFxuHkD7wHjHFw?=
 =?us-ascii?Q?wM9s1Uxf8T4rreRCwH/zl5EXEIKtm+bcAaEDrb/DW8eCRWc6AOlZu4sInydN?=
 =?us-ascii?Q?9wN8Q9rWqX8E63fw8pQp9UDncJEjL0Y0B0Yu/g0BtERWalP3lv4eokoADi4h?=
 =?us-ascii?Q?jaL/eD0AntvSm/xc3TidK0h4KO3cFQCtXW6YCgTR3qeWmU/tRpZ3lUhCJqOq?=
 =?us-ascii?Q?tajcb1URljjbd7LpuVY2WfIGKammaRWGb4zSiq5+CYxllgyEnJW+oxQHYaM4?=
 =?us-ascii?Q?tp1R2NRHtSSAkV8VetDrJnjucQAKCGrcz9iXYMpFihVX/SIVlRfI7RWtUCvQ?=
 =?us-ascii?Q?ku4zEJyU7UwHI2/4ZPLQcVkUj6D5eHZP1RqzmFgLpuFtWIYnY99YxgiG2N01?=
 =?us-ascii?Q?m/Wrd2sV9gHHnhqSSU3Gkyh3e4VlvCaPQqaYHJG1Gft/Vg9UUrJzJSeaOZJs?=
 =?us-ascii?Q?P6oeEPXDGGBN0jJ4zzQ9y84/SqYbcEApxDmZgZvpWqLLznq/aegLR8wJSRY3?=
 =?us-ascii?Q?CU42HnD6r5A/l5PWr1KLG+3PyyyHDxT8wG9sc+UcfwNUqaJ3YshuIOecEfbG?=
 =?us-ascii?Q?lGuQ87on8btnlDRf1UjkGmfR4635afKCZPd1mp3FrlJN7R1xXMe9tyJ7kkiw?=
 =?us-ascii?Q?qagN1cwYuI38n3+fJVk4N9Czq86CiNtH9gfyZGkTp0pCRftZdXtn18Auo77R?=
 =?us-ascii?Q?asjiBlCsNV1UXNxsUQipeWp9MLQPqdKT0y7wTyU0ReAK+A3zw7IbXas54E5G?=
 =?us-ascii?Q?2hbhN36XPXEi4TbWpWpfnfWTQDV7C+MXFbR26z1Pb1HqtYdzB9vZAW/rFr6l?=
 =?us-ascii?Q?8RMThZuThwSkS4jjnBYTQ776Z4//Z0trltZMzi9CGe+88EF5vg9Bf7KjVKKQ?=
 =?us-ascii?Q?lvrUrUJFGSG+ruzXDEATRfYRU3o7IR2Do3l2FgEv/O3pCLHgipdwEhadtjdx?=
 =?us-ascii?Q?SPMsZUmNzGYH+RGxJnIO2biNMgXLUE/vr+g68Z6E103epOwKaJSMCLamGrNZ?=
 =?us-ascii?Q?pxM3q7f/AJ3wQRbwDYzzm3RYAa4710bGFEKacp78l+Je+Nh3ZsZkYcK5mXqD?=
 =?us-ascii?Q?SXKZAivEok2IGRGR9DGIkhu9MUgoer5NIUv5nETfk13aWRobTr6Vxws+0cvp?=
 =?us-ascii?Q?Ncwx5WvHv4eL9aT1qnhKzfS1nTJLc+ZHuJYW8E/8Yw4XK2HTSjvdo2YxsGBW?=
 =?us-ascii?Q?+BsDm3mz8dXA6HDMxn85Zc3kagtA921s1x9/GGIiqtTshRXJdqX7gCOk/tbW?=
 =?us-ascii?Q?m0ElbbLtm6b8D//9PqnmOH9jvJH8IqzGuxp1jx6CSOpgMYPr9+cZaDfaTCay?=
 =?us-ascii?Q?L5PpMVbYAgyPExBgHFp7A/3DYpdCMhmlR02zII1GL4qZfRjqQqX8GxJHynWj?=
 =?us-ascii?Q?dwqR377iR0tIFRR3RM5KqfkwL6CR8ilnzQsrvcnCIC3NaFurFz+1mXTj4gSR?=
 =?us-ascii?Q?/LwyB/km7I2FEbi4BOO3CaFhU/3veIHKZCJsQUgGhz+Ct0jVvYo3RazY+jkJ?=
 =?us-ascii?Q?k+7oVyZ5oXNN7V8qYAAqFNmEPOANjurh91Wb03XLOdzw4JAvkg2XC9WOlVyx?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f093f6-7b9a-4312-4c04-08de0b2dbcdf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:27:00.4899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NudRorWWzDEr0KZ2pwpXbJhf7d22iBaiETuMOagt7c3OXwnYE3/uuO5bzvFdmiUFQVhDGkPBz57GzqBE+zJRHl+OxP5/ROlzscly6hMcEic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8696
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

On Tue, Oct 14, 2025 at 08:45:13AM +0000, Ciara Loftus wrote:
> Two rx paths had incorrect feature and offload definitions
> which led to incorrect path selections. Fix these.
> 
> Remove timestamp offload from the list of offloads
> supported by paths that use the flexible rx descriptor. It
> is only available in the "offload" versions of those paths.
> 
> Fixes: 91e3205d72d8 ("net/iavf: use common Rx path selection infrastructure")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx.c | 5 +++--
>  drivers/net/intel/iavf/iavf_rxtx.h | 1 -
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

