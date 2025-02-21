Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17570C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 14:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B53B3402CC;
	Fri, 21 Feb 2025 15:36:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6CA2B402BB;
 Fri, 21 Feb 2025 15:36:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740148610; x=1771684610;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QcSOgKcNnHO+slUk1hBLJjk6YC933KVB/GmfOVT2d5U=;
 b=GE/jW2kXfKq37wkZst3MxsGIZ3+Oi2cgRwdemGtFz/ADuPSZBK7c3C39
 ztyWR0hUAX5G0VuUNSglhQhC3ZlCFUmA2VpN2JNE2IZdV7BP1UqwvZvSc
 TUaNJdH7Gfy/052bg0u6rXQIAmzg56KhFKfTc4r3Kh0icnndBpJWJd18h
 83r2mE/ekvuHYsdfxF2VFAXEnQU4Em1l7/NBYoaIxwmVMz3mCF37YHbSj
 o/zMCBUCyN1+PFgj9c1TXdlI6PquKixwPCq5Ay4jpku/vmhFahVQ6YAlp
 hWNqnQxLqCBSB0fgWPJxgowExlJwb5oeneeOVIZAl9gQzAiuX7J9DA0Hl A==;
X-CSE-ConnectionGUID: XAEn4hpXQhGaAiDKMNcdQA==
X-CSE-MsgGUID: IPeOo9TjT/yygvo3ttFIow==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40197982"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="40197982"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 06:36:49 -0800
X-CSE-ConnectionGUID: AwskL7x9S+anPc6ocwbXCQ==
X-CSE-MsgGUID: gkFf94VdQXub7euRc9u60g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="120313529"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 06:36:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 06:36:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 06:36:48 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 06:36:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWymz2x0v4QI2EfUHBPcXGQmZN3sYzJBzfp+CLOv+coH54Msb61c0Qg4pSjMuG0JvrBlsrn27Zw53DjFdYpArgKh5m6wIKx+NqgHFov+NYSFjf8WUcmXO1zg0yJfXBEkW1qsu8g8w/eJbkA5nQ0JPYpBQBG1ekeffB8WFEYorT+8cEn/LkqFgbkfQAmgwmP4SfDi/MlCS1H9emqSFo6YF0DLIXGWj2mTCh/xu+dvpNFJ7hvjt8b82LHvrm/tN0+50wPLO+xkLQ/4AveHlu0mgMHst6eWnSUYhWL0bBSlz8tohGMK5j6H/+Y8AwoUt2hhEAPa9/Valp6ob2wSorRtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV+/WNS/wT5/1cWrJ3eW3vmSqFSeEOe9k/9x8iE53Yk=;
 b=AD3QpfA6h5WkzVMO6nFALsdznFo7Z+ilDAXrdP4ScXi6mnjzQwIrfPVE//SuRKJQFd25wivCdXNHk7xUWE0eoned9sJPkmoTigeapfF8oCcSxouX84+UgXRwKxWLQfGVd2ewem4MVQYlRYKFa0WhviA4mNX+SCJG22iJiB+Bk6AyWDuSfuF4fJGeFAF5mJ/a7VSBImSSdS61KO/2jhzJqAVOOlOwGurUACz4I048mRzsYwl+pnRogmdWhJ9rcaYsgp8VC6MI3N1cD8IQtaI1kLM8o2pyNqtNqH8lng+2DYz3UDa/fJTTZdLpLXkBngewdIY4qYpEGLuCA1nCDEY85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 14:36:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:36:30 +0000
Date: Fri, 21 Feb 2025 14:36:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/ixgbe: fix min Rx/Tx descriptors
Message-ID: <Z7iPafV4-GhtkW_c@bricha3-mobl1.ger.corp.intel.com>
References: <20250221082318.331815-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250221082318.331815-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DU2PR04CA0087.eurprd04.prod.outlook.com
 (2603:10a6:10:232::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 76aa3bf3-fb45-438d-8046-08dd528521c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?44noSBg5CmzN/a6/fJxPgn8phYTXbT0gW4nV7Nhe+843PMOzevPugvKY9UNB?=
 =?us-ascii?Q?DbQlz8WMy/YD42cDpBNF4ArUKBKEV4ndcMjhLIQGlOW8oMioW7UUGqrhrzja?=
 =?us-ascii?Q?Or1OwbBFgsuzav8QO4yiqfUMH2flofhz4IscUakQgS5J7Ge2oicTHHUnTbwD?=
 =?us-ascii?Q?jcVJr2PU4Dp+M2yuD5cXaJPOO0zbTzDB/f0TWt6jJ+viKQ6bOJ3F+BEpZVge?=
 =?us-ascii?Q?WLZbqfINid8FyV0+4YndBJvjDk3pEJ+5PwFPHNd7a+U8ZPwgSgWs9TdwkU1I?=
 =?us-ascii?Q?fAv7kzcl5WwXJ/SU16hqEeRHaGQGzi5YB8tMTnSRP1k7qhAKTNKby8HaogcN?=
 =?us-ascii?Q?R12gozL/y72HmTyWOI4AdzENwWokruUnHbDzS+FaIs3M6bLzBH4lxlj4j98/?=
 =?us-ascii?Q?sPNeR+UygxUdmHudLE1gSm5rHuo+jcc2l3m9vujLpWnwbOHJRrLUcHm0i47j?=
 =?us-ascii?Q?iOLYdyUd4Tw3gD63Oobx7yhPtx3HaJLTQhyrhakuY6ll3xUDw1CLexplIAs0?=
 =?us-ascii?Q?JmAI/1T7kmzIXsQT3tG6ZsPotvC9AS8NJe3Qa5TjxyaTOXis7JAq0h524Q/W?=
 =?us-ascii?Q?uV6p40YX0IKhNpHBeoonGTw1rfOpqC7tL23E3K/OnxS04/HKG2fH0or4M/Ml?=
 =?us-ascii?Q?sWQeh9pPzz4t/oCaz60F42WzAVJwGeTzchb6u6Ad0vc0wE/IP3RcwkHliIH6?=
 =?us-ascii?Q?lIi81Qs6MLdmBknQzXSh3Kr3eKRTvbm7HKyU7p2gFuvdbOGIe7p7kXeUBol3?=
 =?us-ascii?Q?1E2CeNgWMM+rpme/JAOCrjRUkdxjkJFQIb86rsHn7psCR7SnqI/CVWWI7Js0?=
 =?us-ascii?Q?H5cuQztuefGEdSkKwwPmxtOsln8kip+s+bq7ym/T8iYO3wlAh++b5CGai9o6?=
 =?us-ascii?Q?6ajcp/AxEI8TgdqgVc9UrSuNa9Y1oftmISZz/rb9vjdfundCsqEbGaghOGw2?=
 =?us-ascii?Q?bovyJwlkS9AU2mwD0YQekNGoyWnZElsTvQwlGqXyd3KyBvJ6KD4eUT+yOcIJ?=
 =?us-ascii?Q?hnS7qq8FfcR1qP+UPJAonMv04BPHX7g/p4wuxrP9jJcIRwTheJOkjnC9GNyH?=
 =?us-ascii?Q?olDPMkQreZU7vpyfaCcrZ67lETVPfxtib1Ubwic1NMY03lEiqRkNzi13slKR?=
 =?us-ascii?Q?hFdnDXs8EFJisRlSXP7chcxCxAM2KYOLlc5v6memaJowa96DrHkTmmpDWk4j?=
 =?us-ascii?Q?86Sv+6llxywOsK07/1iBNqUFLTNod0H0J3B9cR67Mi1NUDvp8OMYgF5BM9OC?=
 =?us-ascii?Q?P2WUMXn6nPXsD49qxMBav+fi1mfzB2ADNnyOB1oANvc30yGp/YSj2CN4dYE+?=
 =?us-ascii?Q?np7u6/x0t6vvetc4IjU8rFDFBsELjm899Td65B3vBXotTudV9lCNkxcuCaGs?=
 =?us-ascii?Q?rkC+eNxh+HESfzJ0+dEqxDlQOTua?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNYyDxt29P7JWerTf2KZSCs2PL9aFWDEfgJb8eosdpDvLnsm35t7JIxjIs7h?=
 =?us-ascii?Q?SQzAAGQHCfx3kMsNdiiBgoK+ORJ6Td8iPwA5qubOJZ5tnn7Y4MRo5CSclswo?=
 =?us-ascii?Q?eLIH1puvOAqhPeZMFOs83K6217R8+ywtpTGTeQ42lcC7lB7o+1uXRGZyL5VF?=
 =?us-ascii?Q?cuI3Dpk2RayxNDimHHQMd+ipTMuTWaf6nG593t1hzZikvTutSFkBbxWPp3xv?=
 =?us-ascii?Q?guIWcJjKQ7at8R/acyYFdALNaXh6siPqCfapUb9HIUH+lqBu5Vi9+tTLvGR8?=
 =?us-ascii?Q?oZGznm3q7kTMS3+jsMcoysBgI/dI/8YNFYy6yjmXnHL4M/P4M+qN9o91SVB9?=
 =?us-ascii?Q?HL4qbIu4+xfL+7FJzPMcPJnT8DzgwTiymfneSfca/5WHTK3WK6nLAQ/6Te+4?=
 =?us-ascii?Q?V2UIZIa5iRFKctyZ2PmOelLSOY1UR+cnejrk9V1gAgYwUQLlgAXy/MgIxyGS?=
 =?us-ascii?Q?J1YqtccaMs7MV3UqIzVhmqt5yz457wRjM7/667YhD82P8Hr3fC3LoIOD+gJp?=
 =?us-ascii?Q?d+bUPosgur5gzNyFsZnkhXLaWsiQdb+MPnm1QXst3EAta8LkE7MelAx5k7fy?=
 =?us-ascii?Q?MV+oMWKvlUmvM8PucAXK0oRXk7JORdI010BXeAOqiCSs7JoxOpUhFglk/Cj1?=
 =?us-ascii?Q?eTtZGskkQSM2og9k1OJ/FU1kktZB82laFhohkSzne6x3AB1ZmZotUNVI/u97?=
 =?us-ascii?Q?hHMbkY4ZvNurdls39oHWjXAlMJl1qdJarbWzyCsD/ifVzCB7ZNLxcQL8WuZY?=
 =?us-ascii?Q?6JqNh3TG/KBSi8eGIPAZmlbeGxh0o8c+3j8JfNwWgf3a9m1d5GBCbhFAWxBf?=
 =?us-ascii?Q?kuguw7cx8Y4sdOvqTzCQPT9ehpUOqE+PLd6n77NG18t6dx2ALMVos7EhxS9N?=
 =?us-ascii?Q?QI0u5g5TfQiDF4DkNJUlMv1zsMkdAVSxq/VKUDc11wERxb+IoRDItaflK185?=
 =?us-ascii?Q?VNPwp4ZyzFrJFGWTM3bZQqbUXDTmVWZSeGhodUbBIvPcL2JiUoCqXruXPwK+?=
 =?us-ascii?Q?IJZT1weFzCBQUopC3UYvrkoPfNHLW7MbeenfX+JQNTlKY/vmvc+RSba4AXAj?=
 =?us-ascii?Q?Oz4ftMa7YXkYxHCyqIKU76GesTkH6qs2v3+EchUpvywfTtjlc/5EeJrJMs7g?=
 =?us-ascii?Q?OLg9c3W49JEWmUe6bZVsbXvW8MwwSqzzwsKj4Axa+VqYvoeWhIejeSKwQ/bP?=
 =?us-ascii?Q?3x3UK8sDft9i/t7nagllDd25XHWvjEvjOuIpXesQz32cJTCyDQGIrjc5dcOC?=
 =?us-ascii?Q?3pwUdURNyrCRIwGmFJpCOMYFMgWK3ZBB3vFcVN3ZJqlcZrldoSE0IEcv26lB?=
 =?us-ascii?Q?YWSr+QyD+1NZs74xV4n0QpoyQlYXtb7IJcbufyUNR7M9nbjl3glsRM3UbvGF?=
 =?us-ascii?Q?IZ/i5MDGbdA2MjjDgRVbOzHw5uaHPNf1ySP3DbcnldIu1SCvpRyN7j5V1ZUW?=
 =?us-ascii?Q?u76vorWVWPThG3drjGgBrQCZOaqY5itxA4QUEQ9SZMU/cQh4SXWPNfR/+pwn?=
 =?us-ascii?Q?Ch/7LjeqdpSmFpctXpmjEesOpquZGhiRT5jT2ed83CHrfOxWWlA1lZ4oixd2?=
 =?us-ascii?Q?oSGtzSJTxTz7hXjQBxtUjBiBQ+Y7JS1Ag0ylFGEtukarGadZCBTnZ6WJQcQg?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76aa3bf3-fb45-438d-8046-08dd528521c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:36:30.9009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSplx/fFQzUIHaS+bIY88YdZqWpm9V+KH+W646AeQaP7GAhFZt0y1LYqNL0ZAUW+THWTxrCDX92QnZzOvJDuQIXwVQcRmVkUVlsNVNeI4tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
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

On Fri, Feb 21, 2025 at 08:23:18AM +0000, Mingjin Ye wrote:
> The minimum free packet threshold (tx_free_thresh) and the minimum RS bit
> threshold (tx_rs_thresh) both have a default value of 32. Therefore, the
> default minimum number of ring descriptors value is 64.
> 
> Fixes: dee5f1fd5fc7 ("ixgbe: get queue info and descriptor limits")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
>  doc/guides/nics/ixgbe.rst            | 2 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> index c5c6a6c34b..10a0cdd270 100644
> --- a/doc/guides/nics/ixgbe.rst
> +++ b/doc/guides/nics/ixgbe.rst
> @@ -76,7 +76,7 @@ Scattered packets are not supported in this mode.
>  If an incoming packet is greater than the maximum acceptable length of one "mbuf" data size (by default, the size is 2 KB),
>  vPMD for RX would be disabled.
>  
> -By default, IXGBE_MAX_RING_DESC is set to 8192 and RTE_PMD_IXGBE_RX_MAX_BURST is set to 32.
> +By default, IXGBE_MAX_RING_DESC is set to 8192 and RTE_PMD_IXGBE_RX_MAX_BURST is set to 64.
>  
>  Windows Prerequisites and Pre-conditions
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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

Ack for this part of the change. Just ran a quick test using ixgbe and
things stopped working pretty quickly with an Rx ring size of 32.

With the doc update above dropped:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
