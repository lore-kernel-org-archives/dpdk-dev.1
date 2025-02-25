Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AE0C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 15:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 585E640299;
	Tue, 25 Feb 2025 16:53:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9F42F4025E;
 Tue, 25 Feb 2025 16:53:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740498825; x=1772034825;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rLr/D6fJp8LvNrQr/F/wolXEqB8fjWGF/urfd87rcQA=;
 b=HaRe5IH1+mjzr9sabZQblUD/f6MoML5XdUKiRlMXGp1VyTfUQWYWLKLI
 03m3hlIkLARlUaKF0mUKx/N60ZzNPcwvRz45yttRJFeOanfUWo8+oF3MJ
 HujfyHIYFRgcWAY7gFFXCzi39ul/VBX613DD2C87k4y3sngNgHURH42Ke
 OEjA4MrW7v/P7OeZyUZgFbCoJUCoYrov8p7Hr5qdzzG343t94uyYOCzwO
 qnw0dEA7klwpU3fnn1grZwJHc1Jzax/khiaB3nYe/gtmiT+SbRm/ruej0
 pThiyew4FBn6QkH46GOrIRj3ymFPSdSgw+iLi+ZdfGurnQZCHalisd9bq w==;
X-CSE-ConnectionGUID: AkVyTTsqTjOnZAQi/IwfKA==
X-CSE-MsgGUID: tSzQJLhKTJ+wm8dBsy5jig==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="63775567"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="63775567"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 07:53:41 -0800
X-CSE-ConnectionGUID: U+LtoJIFSg6G2746d5d4kw==
X-CSE-MsgGUID: 4DRHPr1oSDmWdHhpSbUVsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="121516055"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 07:53:37 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 07:53:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 07:53:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 07:53:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnFLNc+DiaSi/iDpAvCShhtn6t6S1aPMiDrk7ziHwGPcitIW/OYDzI47q4VVDZooz5eRYxi9nGMVMtADWD+DVSTHflyvkKuiK7vSV1aboOny1Us0ib6wUBSnlYtmgVLq1DXf0b7x2cdOnN4b1j5HCABTjqIc4HWl0aTv3mIVOYcVyg/+3vaP0NBa+Mwi4rTPogz4r1Ll+TK0prhNsWCW4uOfJuyY2kUgS2yyeRpwINN5VXvEtcHZuDiDY3F+bCmmX0yUHSrOO3Omp6snCTR239EDMZwuvG3xeAJURMdMReFC+z+5isMbUm7oUYynGhpbMs/GN3e9wOvwx3WqNW9xgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37aLTw+E74DL2O99HteblClmDkmBhPiqegciCRNeHgc=;
 b=NZKaxnJm+N+TxcETSfSKgDfeXjA0TTL8w2mc0ZNDLNKSThvqihgxl+s5X1xh4QBvfabn/QjRH4Ly2RvRQ0MQFasYmWCEJnqTZ9SaSU33WRmCfOb1TbOmI8JzfS4fBt2OWwot4Ac57/Su82L26J3sGb1dmOsiaxvwdvhK/OUKP1RPru/g5yvF/QzLOtjNVSDcHJC7s3Ukzac4zDO4PIzga8FfbLX2P1BMp+eA7JPJ/84mqQVTHArVIIILo6i61kFB7joFC3u3wvXDlbTeSlJu+cY1WwTiHhiqgbBqTOMpgGyIGSgPNwuuEwa/5hGccb20mIlyK4JxJipvlYEIhLrAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7368.namprd11.prod.outlook.com (2603:10b6:208:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 15:53:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:53:15 +0000
Date: Tue, 25 Feb 2025 15:53:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2] net/ixgbe: fix min Rx/Tx descriptors
Message-ID: <Z73nZkQwPIavFL7B@bricha3-mobl1.ger.corp.intel.com>
References: <20250221082318.331815-1-mingjinx.ye@intel.com>
 <20250225091236.357008-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250225091236.357008-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DU7P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc8dc3b-08e4-4629-3011-08dd55b4842a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G4+AkjlyuNPwHPaVRL9QkDE5hS813+fROH0EHQK/nnOzkTXf5iQFG2KgMkcy?=
 =?us-ascii?Q?oix5oy1A04IhUh7bwTA57B/KZmVkjzEjO2ZonjfPqjRQwNFT52RHCaFIEH6N?=
 =?us-ascii?Q?NyikqE0fpaMzcjlk6/fmGg4mwksWWX8+TIImKfVFz2sZt3bUUzz1zKH4Ak+N?=
 =?us-ascii?Q?qwZe/XE/7gktgUokkYHwEvyJNL2+OfNPtO89g5xifVCesbKucR+tJLmuqna7?=
 =?us-ascii?Q?W74MyxxnfFrWkSyaCQ8TTcINFyd45/GRDG7bQzkiTIc4EW3/iBFoVx0XdV7P?=
 =?us-ascii?Q?UDTmu/2bjR0QhCY8le5nz303CRYJWtkwdIh9hySL1mIRqhQS5tExWqPQxBwT?=
 =?us-ascii?Q?Sa2MSrxAWFxNOdmTVKO8m98O/icRmhxlAXW2K0hMigIpfFKFmLEzLsuK99eo?=
 =?us-ascii?Q?ywlu7QdUCcJcO6yB3nzjIV7TOCV93MCcofq51ez9Q0QLitx/I1WZo632HHYz?=
 =?us-ascii?Q?dAJuzDgefHQJEuvyv5mGuhJ55wsX5joP+hrt22T619fYjes5fJ1L2XMxlkWy?=
 =?us-ascii?Q?AEqFgBh+6BXX7Suipjyw6osuq5xm5MOTA5Wcyg2CzJaM9dPjRtlWUK4PkikK?=
 =?us-ascii?Q?2vZNyUEGJ8YxBITCOdVuCkT+ZzZwBG1nWaUoKY+aaQgMqI/Tog0Ep+3WVRTN?=
 =?us-ascii?Q?X47ZIusE7K9pbtUce5+oxZ6gQ6yA3WVAzUmasPZmJQ3H/3y45rWeXM9Q+2qS?=
 =?us-ascii?Q?TKzkNi/9rC8U11cIQLx7w0lrYATnFWCccdCltAFVPVwUD7uIlSqU/+4cdE6i?=
 =?us-ascii?Q?dccceSGHqffBKoyoi8pNcTu06Zi44nGzJa6AP40gaf/QpGjFhGJzKSko3xsa?=
 =?us-ascii?Q?SqwkAlx/ywBhJQl7n4rBePUOJkC3wSVpe1oF+Gc0ctCgiY/geYTSM9L65Icy?=
 =?us-ascii?Q?TsJeKj2iqStRk1ALu+HuahcdZTh/fnWbJkOcblV9lQm0HmACgaSgQ6tfbhuO?=
 =?us-ascii?Q?eKM114RuwdEBZIeJjCf5wAK1VW655k60TpbR3xDTPdqPwJMBUxUlRKQNI5Jx?=
 =?us-ascii?Q?wsRkSYCPZ6Pf7AHTdxtye+kcie26AGJA/Kv8gfqAkUBLuxKqXOu5FzjA972+?=
 =?us-ascii?Q?yufU/LpzGk2hOrCTmTdhSL4Fxcj0cd5/qpmHBrTYdUDrS4IU7r5nT2wDTVd4?=
 =?us-ascii?Q?zXhAuJ51r8mmb9veVbKzG63PKtJ9pIlemfOQWIYFcf5C9PuZZE3yM/2v5+dD?=
 =?us-ascii?Q?g4MVugGSlPUdVU0uHY8evA09+vb4oyYYMvGxCle5bd5uk5pIMJutCpr/HaUJ?=
 =?us-ascii?Q?Hunxq0Hb4piBGVDMH/gafHyzc9ytWvRIwYq0DkfFdP9BjwvBMohUgfbT+cHr?=
 =?us-ascii?Q?ohfuro3lvvWTqyzs7J06YJgU6bWoj4RcvIGCH3UxcACn/pMsGUIeoJay5Q6s?=
 =?us-ascii?Q?kJPkGdFIXJGxrI+7kXratZ3zjWq+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9QgmlvK1mgHsIfUWfjnDZcUB6iCwcZVCiTpu5oicHIREeDzKiE90eVFz3fV?=
 =?us-ascii?Q?T+VJMb4VhcJGjxSYH/7H0HFqxz+IwrLapOQ24jVaJDigZ7A2TctGnWkrH+Ho?=
 =?us-ascii?Q?/NyfzLFH4UfAdqsKnhqbxUWN96C55nzdZTYTFsoL7TBqOm6/y6YJmsAj+Wbx?=
 =?us-ascii?Q?uIbHMXvmDTmAf+Tie8LFjAXQSx43HS0HGRfMkuzQ3J8CmWsMjkikKd8DFD+a?=
 =?us-ascii?Q?IUXKAl09iroF8bDmLr+kJt8Knufi0tS0KsoicOoPYOkg/gA3t/OUw/zULfeq?=
 =?us-ascii?Q?0nl4oCJ0Y4JVf+13ED6q/FcpzOxh9HTKIgOORnZ8mSnvCqpD2BxihgSqumtN?=
 =?us-ascii?Q?4s4XcklkmGbpYq/sSo6J/NdSZ/orq5ZE1qVzLoQhKlKQsGuaJ88mh8M6AN8s?=
 =?us-ascii?Q?UhzDmdJUKLwAbahAe0eTc8ctDum/T9qer797zGi44aOh7aWff0wnwO3RckcV?=
 =?us-ascii?Q?JDZTFesVR2Ms6+SuwEb0e045uGiwYMl74vLraEHvWdWJVnFOqFv/atqDj1Ml?=
 =?us-ascii?Q?NfQqfZox0jONWdBdWqC1Bjd4pUt1VxlB9dIpIt8ChQDTO1mdPGn9KQIs1szl?=
 =?us-ascii?Q?axisNSbkVlSibUT3oiC2J8Grvn1pzfzsGOwVzcGXZST9YgkVN5UZ5XljVS7O?=
 =?us-ascii?Q?Ht1RZdXK6s2r/Ym2atPJtOY6X5MqnNqRurEKV9dOirkarb1XkwJzAqSVZ8ab?=
 =?us-ascii?Q?gmM/5GCF0edQTFuCXIuGBd5yZzh4hjHTZvB052z2bevRROABPKxCr7jOrboR?=
 =?us-ascii?Q?iAttDDLIWMOW/sCz9xY4L+7Zju/ijd+CPlj6obIlqxOgHKKjiWbIHbUVTtyC?=
 =?us-ascii?Q?EBkhbRrLO3TnOrYKlJxrkrHa1sG/+mCw39lO4Xy4RIJCRXZO20o+Ipg/AScM?=
 =?us-ascii?Q?1HCrrsiEPn2d+9ar2Eg7cQu2wtODa6oN5ohv7/0qnVxujMh0YDz7wUQGnzpv?=
 =?us-ascii?Q?rzXA6DkHFu5+BV/F66CeMbGm0jlhhEo8FXFqDnF7UPmlc1j7lTzdQE3Kg0zg?=
 =?us-ascii?Q?5q23lDU5AzgUM3ML5DUzHko2GDbHaDmJ6bJp6cJk2r//3lGbfvz0mD3Pj4TJ?=
 =?us-ascii?Q?3Ff5IZZobL2NVT5zwaenq3KYv9sJtiQ4IEONylNfMsp7Y8kBc/G1fj/J9KJT?=
 =?us-ascii?Q?fHkEIITqVg+qgNMBnGMzOq39MagXPiqJ+z13EslYEoCGtCCtVZehrIVDPrJM?=
 =?us-ascii?Q?IC7Gay1DJcV5II6APLB3iIHVlYjpxcGMmpY/zLKxhxjEz2HstAndsrW6rseR?=
 =?us-ascii?Q?mBFLO6qzyuJ9wQGC6lzAAvB8YosHgdTa7nZqcZJJkEOZk4aILHALMxcx8VIu?=
 =?us-ascii?Q?ky1x+/BFfQEEGRXi7p/4SD9DI7+16fXaF2m/NkXdClMpcsN6jijyFS3XPR6v?=
 =?us-ascii?Q?2Vz0C0vWRKJDv+X1UpJnT/y7B0I0CapGUp8+1jrhhERoVgUYKk1s0CHnC42H?=
 =?us-ascii?Q?9rijoFXypULTBd4j2hwk4c9BGcoC6pyjJOLmsux94N2fSOnpcZF2Ox0jKEjK?=
 =?us-ascii?Q?EN4lbNyNish2JBUdcJVXxdrn66akpWk3y+RYR4iXZcs5SIw7q95HTDyc+FX8?=
 =?us-ascii?Q?1Q9w4XYUqsRRk/Cc24JbkUVvvHoePIPrj2tZi0Z5l5qlwiQXB6yM5XLtNXXp?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc8dc3b-08e4-4629-3011-08dd55b4842a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:53:15.8570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ac5fZeJKvLTktMJ4KAl5D4RJ48IPlV+ioixuS4dkXf/Ioj9f9nfKTs0Gpfw5129RpmZ2uio/aLP/sJn1mIJU83tOo8aOrqQxGDYyYEOfGrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7368
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

On Tue, Feb 25, 2025 at 09:12:36AM +0000, Mingjin Ye wrote:
> The minimum free packet threshold (tx_free_thresh) and the minimum RS bit
> threshold (tx_rs_thresh) both have a default value of 32. Therefore, the
> default minimum number of ring descriptors value is 64.
> 
> For reference, see "Configuration of Transmit Queues" in
> doc/guides/prog_guide/ethdev/ethdev.rst
> 
> Fixes: dee5f1fd5fc7 ("ixgbe: get queue info and descriptor limits")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
> v2: Change doc.
> ---
>  doc/guides/nics/ixgbe.rst            | 5 +++--
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> index c5c6a6c34b..aaed324e15 100644
> --- a/doc/guides/nics/ixgbe.rst
> +++ b/doc/guides/nics/ixgbe.rst
> @@ -68,11 +68,12 @@ Ensure that the following pre-conditions are satisfied:
>  
>  *   (rxq->nb_rx_desc % rxq->rx_free_thresh) == 0
>  
> -*   rxq->nb_rx_desc  < (IXGBE_MAX_RING_DESC - RTE_PMD_IXGBE_RX_MAX_BURST)
> +*   rxq->nb_rx_desc >= IXGBE_MIN_RING_DESC
> +
> +*   rxq->nb_rx_desc <= IXGBE_MAX_RING_DESC
>  
>  These conditions are checked in the code.
>  
> -Scattered packets are not supported in this mode.
>  If an incoming packet is greater than the maximum acceptable length of one "mbuf" data size (by default, the size is 2 KB),
>  vPMD for RX would be disabled.
>  

These two lines in the doc should be removed as well, since they also imply
the unavailability of scattered Rx.
Fixing this by dropping them on apply.

> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> index 278f665108..54569c7ade 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> @@ -26,7 +26,7 @@
>   * descriptors should meet the following condition:
>   *      (num_ring_desc * sizeof(rx/tx descriptor)) % 128 == 0
>   */
> -#define	IXGBE_MIN_RING_DESC	32
> +#define	IXGBE_MIN_RING_DESC	64
>  #define	IXGBE_MAX_RING_DESC	8192
>  
>  #define RTE_PMD_IXGBE_TX_MAX_BURST 32
> -- 
> 2.25.1
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

