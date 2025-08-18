Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997CFCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:22:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9CA540395;
	Mon, 18 Aug 2025 10:22:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id EB7E240267
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755505360; x=1787041360;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iuwx6isTYZo6oxR0UD9GrkIQ7TIRnxQBMfRvNQexFYY=;
 b=Tkx4kw48e9DW/FO+qrR6MEvZD7wU9CfG7a2MlW0PYPl0XDXbFU0Jehe8
 YQEXRBa9SQxwFUtcaKDy9BVTbnyg8J+mx/ri5qSv26gZ3PJDQF/Wt8giU
 TEk7glt+KDZ7LZceVzfGUaUUj9+iOdTNWYA6wzk4Yy74Fr6z4JYvK12Jh
 +fN28AMCM0waEEymKnm4x2drTAwylOVmdWfwqQurjoA8EcosMxdz4mYk4
 yCQGjVBjWjK1/S6PLqprw6kBHyyf01JYku9H9nKXuwxYhDiVlY52taLtu
 3y8baEYY3WcKFlTtAQQ9IXj9z19cNg7cn9iOrwptZ6bHe4pvg706eTlSD A==;
X-CSE-ConnectionGUID: Br1CufuJRbiglKbJ8wKr7w==
X-CSE-MsgGUID: qGopDa6/TWuLw8Mm3Igv5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="45296858"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="45296858"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:22:39 -0700
X-CSE-ConnectionGUID: j6dp20BASWmJpFMM/6pvnQ==
X-CSE-MsgGUID: LtkGYo6MRpO4gPprAe2NkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="167870053"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:22:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:22:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 01:22:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:22:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+RioL7iuTMaendzpczOQ9MU1N8f2XI6QUQ/HBtirpw3DI5oj3T9WkdrbEU3Q6lMPyo9xZyQBjiDwpPsZfJXvbyeu+mxF7xg9VRyb2CWbv7vr5zk35NmSxs6FssiUTAz1HPs8LY6GsRaupu/LIraVaqCGmgiZazSV0xjdRdOMdvDv2cg1WQUNYJK8PyjYEW1kcBMdER1juzps3zwJw0ADFm5R9a5aeGgQeYdGaREr/wNAd3wXD4rJoaw2HPphRUBjGWKsochbSVDhjQl45efUQT3ZqB9oWSA/SL2IuYDDldWHCT/XTIsjbi4mH5wa2NbcGhOOG5STmAFr8EOYAtwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua8AfA0s3GaAZ9HDcS8BPxq4nDq8oqXGuM6ppfimnWc=;
 b=I4GPz5DXF3ZDeg/YvluLfLz/0YG/C1B9Z0NFB09t+F8VcuZ5S60L04yJhBLEVtFS796sVzg6YAWF94GsxIqF7mcew08zckwljEDcnNaRO65BLFka49zmquhbPZ5xr9pxowu6bTg8Hm/YUrr0/zs1jiytq8BYjBMcw4K57SYOZJtddCXNJWy6UkZZW/nKXy1WIaNc3J+nEi7cczdY9Atesj6ryZmsSoCp3TES0ZTX1odDUdPj4qIH8nzGx448N2lB4zoF5AH6QVUN8Q/mG59p30JoCmbagvklpLypCpV8CE5BS1NAOWo+rvvJa7uKmalVwj+WwKoVv43oIRqYaU1ARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB7153.namprd11.prod.outlook.com (2603:10b6:a03:48d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:22:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:22:30 +0000
Date: Mon, 18 Aug 2025 09:22:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: remove KNI diagrams
Message-ID: <aKLiwP6bJy-d5nfh@bricha3-mobl1.ger.corp.intel.com>
References: <20250814154604.6878-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814154604.6878-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU6P191CA0069.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbfde63-ca8b-43b2-53ec-08ddde305f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vjNmpgkx99fkRpjcFqkRi+5HzlufkoFpqzvFA9GRJ6e25B0wSE66/tKEawfE?=
 =?us-ascii?Q?WYH7EMAZz4+CMi27t8/SjZEkeWl3Bn/5T9h2lLvd6anPaX0XL6P4IIrHTPaT?=
 =?us-ascii?Q?9gsEHO5QacEcIszIMcB+wP3phhKoUnMdPRM2wDNXrApIfmlluBctgy3Tf0bF?=
 =?us-ascii?Q?GxoWEzNAYjKf+WFe8K/Pm6ami6HDAJm6qqHp666wEGf9qMRFN+A2TX70Ya19?=
 =?us-ascii?Q?tn1A4YA8kGKUNAM66dGeNFg6Fj/DcNRicqixTJnzKx9bTSRTz5PjFDHl7sT2?=
 =?us-ascii?Q?P8nE+q37LJdK87nLp+6cZBGe3+hb3sD0nDPJewznTlBw1gkejyZSwgwoUyom?=
 =?us-ascii?Q?+FRdTQK1yiX1pRmp59JS4ms38wAMJfFsGjztEwbYsh8L2g+xRcrG0Akps26f?=
 =?us-ascii?Q?OLvNlvHj6SedGXgyayPF3cItlsO+QTBU+QOCMdh5OUGmkxgTk7beTy2QOMU1?=
 =?us-ascii?Q?j0OsMuiPa47rgYYsdezeK9QnXet47XMEOIZ/zM48tK6qWk8ewKoWEToiPN1m?=
 =?us-ascii?Q?tmeRnie1AshwRvrf6y5LGEJZkjPs05XBZTjCHAewNKNii4ev+H3nRFwUsHIK?=
 =?us-ascii?Q?mMrz3IM9N1yaTsObMb8t4mf9ZrgohYINDKsegxaV+3uvzlH0GiWIskll+NGG?=
 =?us-ascii?Q?AoKVQg7yL0LX7HkjOVvHlJfSzToDzepKukq3yhiqKrJTm+DR3S+fjYmfgTrS?=
 =?us-ascii?Q?9/UexBRk8v93xCjYni7Uxp8vnK0NAvQsti3if/x/GX4kiS0IXClVEACa4GqA?=
 =?us-ascii?Q?LT4Iyjk/rTbVazNIuJbLZTx5KIF/FG6edaN9od5SW3R56LwrzGgWnCZECPBM?=
 =?us-ascii?Q?VKO4vVy5asldNdakkbHR8X3kGVmlQ7GyP6Cy5sNxd8ra7crF5ty1Xgh8fGxM?=
 =?us-ascii?Q?6BccLbjRZ1ix2kCD/d2oIEX5PC71iz76QYYUoeTlsikfumC4N+xMtlauzLi1?=
 =?us-ascii?Q?Xc/2Eh+rzBl/WE1UlcTezC88CzgAZ5LasotSWXM5ye6sS9W9DuATUS7hL2Gt?=
 =?us-ascii?Q?D46SYUQI47kPYk7Ue1Yd51RaJ9ShW7iuAZVUDAhcGHr5BMs3HHt9c7D6VSJr?=
 =?us-ascii?Q?mShGMYm9KlVK3Rlc4gmgTiAOXp/fWjMj48gC5ciNo7qhJyf5KwzgudJaEcC9?=
 =?us-ascii?Q?J7+IUl1gATjWK/NgBSIIN8CptELEg0gBSvpT/byckXURTIlNGt+2obLLAtVv?=
 =?us-ascii?Q?P7pQGwk/y9rWPRNv9/8x7IWaHRqRWCJK+yQMppoK/PZaKti3Ia6hBWGLsLoW?=
 =?us-ascii?Q?0j/zOJZPWuZKYl8hf38+ZPp3kBX+cAIzzwFt1Y8/VQDf7xjEv2CFXgU+BcAF?=
 =?us-ascii?Q?VgS736IOGmr1SMnTDlsx9dk7FFfkkuFZkpwX/r3NzaCmCpk3RruwNWN66mh+?=
 =?us-ascii?Q?V6BqXZipM18ZqxaTZLM78V/QQOrHnEfSYTvjMrXC/zrzJRQO9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rIxHcs8CvmzzILtVvM71p6cqE3sSyqLp8A8m1iR+KG5upZ+w5HLVxmayMxP3?=
 =?us-ascii?Q?NpeTRH0emr22h5QYPDH+OVqlT9bGybs/+PoYQC6ATqktl1bQg5kTi6UtxAwc?=
 =?us-ascii?Q?bZTfzv8aRpaOdMj4FTBPfV7qyecShtfYOODsMdXYEAG9TXoviora7o2DiOBn?=
 =?us-ascii?Q?NH03UDxNuGJ+PSp18dlxBj7tv3g/8QftBhr+743JHku/t9HHJ1HgJh8/humO?=
 =?us-ascii?Q?WOBhIIlspu7VQi2cHGTTQ6USgVyT1No2yaXpLdmMSgfaTjT6aJnIJny+Ow62?=
 =?us-ascii?Q?yIkBOFZuoI9NlnO6LtEjK/sRUa6ZldtJbu3AwwwFQWml92rJ/rHfEVytWZLm?=
 =?us-ascii?Q?cYZcIs616FnOOnw46LqJGv1dpIVNXRNf5DTVniaaeAZtNBb+o6rHAeIJeANk?=
 =?us-ascii?Q?WgzwxYXnepVG1yCo5BtSb+d4o9WUiR4nL/LByrXvgy8QUwiVvAQrs2gXucxr?=
 =?us-ascii?Q?fpvgNl20P6wDRO9dkuy866QQLKRyVDMcq8u+HCoqWSpol2D4qE9KNokGdHCr?=
 =?us-ascii?Q?gJpNQagIIHlYY9geaaduajkimdJgiLZBXOA4Fv59go4OUOoeDsQsgPzPh5O9?=
 =?us-ascii?Q?t06Iin7mrbB6u1AYOd9xIyDVIsl3q3+dXcsRNw4qTJRP10l86veDMblinqla?=
 =?us-ascii?Q?Jt6tYWxxZ/PRQiaqIUbP+Ro3jJKHfh6YX5Tc3B6J1up8AmPPRwWgjDx85l2b?=
 =?us-ascii?Q?YN29Yb3HCUC1VD6fNzu2o1HlZKbrpJxSt81weQ9FVAl57idQYcwL3LoFajnm?=
 =?us-ascii?Q?VIEhJ8UujwraRISNjTIFKxR22ITOf/SzeztgZjwqMtC6orc/t5ZWY+S06FZH?=
 =?us-ascii?Q?dUetAPtojhP/z0tWHZ2wsqyyp85BG/j6fEA6n+SIHyegvWTsrqZsgkD2nsRi?=
 =?us-ascii?Q?NgCc9Z2HvjBmW6o2mG8baW1V5BgXDyoCkzdVK0yG+KliQJfoc6H5qaJ24Di8?=
 =?us-ascii?Q?+ZvDkIkrn2lyFSrKcui4nuateVvW2tWjNUxg3nBlAZPz8aoI2rb2zMbuJOT0?=
 =?us-ascii?Q?pheidM+DM/JUTEk6vDm9GmqABkkcA+47NbJvmtnEQ+2528mYqnTSjRURnT2N?=
 =?us-ascii?Q?d5TIbSZiCDQIUChdYXvSBH9LP7WGgaeZ3n/YmXKH89uXuyUxottiVj+iwggL?=
 =?us-ascii?Q?lfpS3p8rd7ICG6dOCWVQwdlKtByvuKHJtxj6dwfgolla3BqpeVeSGLOSXDlu?=
 =?us-ascii?Q?tmhu7ILEXBZC5NPuq0NqrjP4sktiiV5xHD2s8o52u0Q75FKoBqdL3pDEsW3F?=
 =?us-ascii?Q?wHF+/CX7D2+mg/gmAECWZVHUDCUdB8v6C+c9mZBFsRuXW+Y3V9En8Fnv6SYC?=
 =?us-ascii?Q?8x8FFfFyNIs/yyZiUukbvjqgCQSqSdLF0B40pWLfRfBf5+0hUVNp+CL49DXB?=
 =?us-ascii?Q?k6SkA8xMNUjTyPAIdwEQQxF9ZWI8qP43gi2IbX29xaE7TXBF2o3Ne/HMH/7I?=
 =?us-ascii?Q?K/RFml1rprKP/0oZt/l+g+EWFixRVItuuzDJBnmEiKkYSKllqY7rtMNOnDwh?=
 =?us-ascii?Q?d87DglePvM7bmK7SlGkK/KlgXU5lHC0F59BSEor2Ee2yPn02cwQHLYBqw6XF?=
 =?us-ascii?Q?gXCprCvvMvosc2mL6tFyjYU5Yzbl3M7qXcY9flez9ZZxeJQuv2JYl7ILVcaq?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbfde63-ca8b-43b2-53ec-08ddde305f9b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:22:30.1803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vlh6dEYtZBrMBuurDgg/5/n4+9JYsVHoGqLyOFo4jSqVyNmJ1bpRnz5GfhgTmQSVq3e0vk5V42Gt55rjCwqqWzkuG6ggiDQ1BsyzQlahlcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7153
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

On Thu, Aug 14, 2025 at 08:46:04AM -0700, Stephen Hemminger wrote:
> KNI was removed from DPDK but the diagrams in the documentation
> were left behind.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/prog_guide/img/kni_traffic_flow.png | Bin 366308 -> 0 bytes
>  doc/guides/prog_guide/img/pkt_flow_kni.png     | Bin 51088 -> 0 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 doc/guides/prog_guide/img/kni_traffic_flow.png
>  delete mode 100644 doc/guides/prog_guide/img/pkt_flow_kni.png
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

