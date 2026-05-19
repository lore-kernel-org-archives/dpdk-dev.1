Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95C7CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 17:00:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B915402EB;
	Tue, 19 May 2026 19:00:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id EE404402E9;
 Tue, 19 May 2026 19:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779210052; x=1810746052;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kaPLWgnXhWu0UXrEX05sutqOebDpCPAVqzLegSbLs2k=;
 b=TKfPhJ+vvwtlp6lUIEhtvFI/zXgeAr1hMRtips/5RI85N4KF4Hs2UC13
 z6TgVqBCd5owZ0bSB1+vlQiV9SJOoA4B4lIlhTI2XshOh5GSXMxJGK+VT
 Wb5Kh2JmKZEVdz3OeEbpuYSJmnxOXu5aI6p0SoOzezv0JczyDXkS55aVH
 SD2RxnbgYzysQQ/WOwajivV2QVKEpQj3rD99Sc1X21PRN2qHLaBzD4bCy
 xHaimZc2IwFLbpRLhq2xRLLctLxyHN6NaNKvOE+W9xzkc+F/7H1A34xI7
 KITc+OnGNULLtSug/xKUA5lH4fZ8Z8xO+IgxK3E5GEyuRwxosgfZohVOK w==;
X-CSE-ConnectionGUID: UOm7788/QUeYtLjHfTNVLA==
X-CSE-MsgGUID: 3nQpbicdT3qPimLMnWKcyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="82661728"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="82661728"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 10:00:16 -0700
X-CSE-ConnectionGUID: CWaHDnWJTROnnGCRbszg8Q==
X-CSE-MsgGUID: TJIY8oJZTj6a+i7dZ+ZX0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="241660602"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 10:00:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 10:00:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 10:00:15 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 10:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnlsaKdkXBpv/TYtj/MpV9miGkXONjIMAyv5uNgvtuo7dqe2Lct5Wcs8UCto7R2ZryH+m5+p0UC8l10L37dKi5EIR56zze2OC56VguGt7xegsXE2HyJZxXfJiDEtk1tX55kjZeY04ZTji3uVrgcJF5dJaMAceZD6XxZar0QMnIFaW8GKOeXOHGd+BKU0LOpZWPtUfm+hY2qcJvtfa2RcZy0JSjuXfxJyFUVWf/vMZo+fUkPupH646kC83By25hGeSE0eiZqYUIfNqRFA97Mslwcv5hEo1PE1PDjSp5Z0lW006c9TYgSQ+wTj9zTFOyilOAvCXjtt2E1WEl+dHozjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C719zOHycoWmtSpE3espXpzd7T3ugJqOqE5BSf6Mz4g=;
 b=JDoZvbjBAgzA0OKOBYdOOGY85RbmI3wOjH2WHxq6kQ7DjNkLQJmZF0Q8MzZBSjzFw2yMlul3GmNzoaqlf2pJYxXz0Bz6Sn2PYIk+fhtWIkI/LVgVnotM78q7QP4RIEdZYCiG5orI+GYUBZaBWelMlFF57Y2N+dRPc3A6db34hSQ9ugVIQaT9nuYGLqCB/pFky7BJMpOq9yjTNQ+q9y3i9fnH3JO38UybDwIsqD4fcaz7dm/r+jd+SZIb2nCmPyMxDo6SOlxC7dFuZCdbu3BC1j66diMxgD7+tZVK3bj/zVmtdXxK713UwF+PR/ap0R9HcyNiA9XEGzBzOmH3RZAh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 17:00:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 17:00:10 +0000
Date: Tue, 19 May 2026 18:00:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Daniil Iskhakov <dish@amicon.ru>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Wei Zhao <wei.zhao1@intel.com>, Wenzhuo Lu
 <wenzhuo.lu@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>, Daniil Agalakov
 <ade@amicon.ru>, <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: Re: [PATCH v2] net/ixgbe: fix MAC/VLAN item validation for ntuple
Message-ID: <agyXFTaQWbcJZ8jc@bricha3-mobl1.ger.corp.intel.com>
References: <20260507132117.1449179-1-dish@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260507132117.1449179-1-dish@amicon.ru>
X-ClientProxiedBy: DB9PR06CA0006.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb312fe-d247-4fd8-5858-08deb5c81637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: IGsU1Pp9pAo6Y37lBmXVM6kRihy5eA3jShbbrMgBDXeHZL76laopHlAlQUrpwwyP/6v2ZyN8o3S3BO6fO01LXMS8347YqcJ+gz9XqU+tSO+eBYWIaJ0/CewjeU0CLIk1RKjK0vBYHoAAq8Va3uf3rO+MwQS3e2kTwBHFrpx504e5i5CKcM+T8TdJXR+8wNH7O8NNM6+A1ngnaMYknqOAYrLKIp/svdHu+Qao1x9BSWCajGEL4hZFYA8ihzkSLyF6v65ZtfBsN+AI2kseCxcES1i3XZVpSKAtl5u3TdfC7IyCfXkAeFIpbvQIBFWL/K2KDCVwnfjY8kCs2NJUqYTSywRVdlJyQ2rWsdMNgB6jjETmu2Bl/quMftlCAZS5v14e2/MUisgTYV5HUJIFcURlPiWoauwOK/v4FgLUeDpCMt2GyOO1FPjq4qGSOQMFinRgM+THbj8BpbIw799ARHdz6DfheivBEJrs/pkK7/lIFQr8U80EYYJDwsOAqbBp9qpljN/Wc3XXUqtbOeUQR2p40ymIxLxu5Y5bh7gkueiM9Vyf0x0i2Wj2gAS28fR89TyDQznCZ73YAmov5EENoEBgfiCzBzPxvdUTSgQUL1E9FSbBljrikh9uu3f+kLL9tCzemVOx6DPJVk9YZj68UdLQ2KUhOjVhPODrsvYUXkl2cH59rlpeZI+/Sj2oRDiwGB13
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6VqCr+9CooUtuUame/A8Bc9CCYo9YOW2YTneVNAAJpPaAnTJjYHPMUdZGbb?=
 =?us-ascii?Q?2qH4YviJCQgDu6MTDy0cMFcP77A+LuuDc6wse/vDqR/v+WG1rYD3oJHLd8Z/?=
 =?us-ascii?Q?WrdEJHEcbXijm2p4h1gqTU9B0552KMcy/ElsAB+ECjGy5QxphmSDk7iv23GS?=
 =?us-ascii?Q?/9+cX0xiwKVD2jM3wRiL+N0UgCXBB5HFnFyQ5TcZlic1214Y2PhWC06paBoL?=
 =?us-ascii?Q?ksntfhhQKDIx/byBAe4Elx3YMEHe9fRkPki4JFMTorHrBPdcUV1wULhA9Ziu?=
 =?us-ascii?Q?/+B8f5YawUfpJs/iNJ8BGuWDQRkkjA4XMsg/P59CjGILglyjrLp63igjcL5b?=
 =?us-ascii?Q?hB9wUT7U7PTkqmNlxi3Yz9JZyiwxWesi5Q9ObQwn36epvc5lQ8sW0/qE4Br/?=
 =?us-ascii?Q?MmHsRNrNIQejeSTGGe0pOJav2KTtdXhZQlHBJMpDJI42h83xUHsTfDEa/Mzv?=
 =?us-ascii?Q?RoILKJmTEo7O4LtPDKbgnj/RsnRKBeTfPKbPtnBzZdnqzL8Kk35vmdLk2ZAl?=
 =?us-ascii?Q?HVLLeltNztCAoVnqiKk7U1f62g0/qShATeIqUDotrtJfCkwpFtCiluShyG63?=
 =?us-ascii?Q?L6SWFsaizto2OtDLDlPh4cYRtvcJoGgQtmvSR+ycw8NR0wPu7bLWdS0w8qjW?=
 =?us-ascii?Q?/fQXU4KLeDshIGbRIHGN3TSDXFYTWphJkCwvexEsiwAaQt/xxWz0sHqb/vz7?=
 =?us-ascii?Q?6c0EORP2enu3sDWHfD/WU8fyOfD2YwX9/qn8ezJZpyLXWUJ9CqvZTa6fOK/2?=
 =?us-ascii?Q?+nm+U6KtSF4938Erspmgz9xCwuCy2l/MndRZ2QuGXh51GdcNw35B/LfB07p0?=
 =?us-ascii?Q?Ec7MsWNNj1sAkS5ridwnIzD6K3hycE7u9xhSw7W9kXPbc7CqNeSJzK98Z3sz?=
 =?us-ascii?Q?PYc1Gs0g65o9VLN5aKrYOVf/exyZYGhZF+dVqzId/bVr4tK0lCmfYKwy5cKf?=
 =?us-ascii?Q?u7zfizX2dGYcSPvjSCzxyWO8SX9+cXgNf7pibFgEcK/SJp9Mch2PZ7SbwEEn?=
 =?us-ascii?Q?AxT2E9kbPR2SAlB7u7xGKiiyZzotKFmMZwEAKPj+UFErYQS5HTywcBLhBr79?=
 =?us-ascii?Q?lHHEvGk4yGcxkYHHJByYs7sPOyJLyJmT0ssAfBYH7tXqHrCz7+w7cdSuCkp0?=
 =?us-ascii?Q?F4vpryM+2LoN/zongY9UfVVhLA75MtP0X5XwmT00XvU/2iiPeGa0DsB1Mnzu?=
 =?us-ascii?Q?vkBfJMKqes1+RCfFlffgGso9N9n315a/v8OLcEKY2w0aUZ237vaOT1G+gfSN?=
 =?us-ascii?Q?20sB6xfDD+H6Wd34vr0imw2crV3lfCBR5wh0ThaHPRQ/cuj5SeAyC/XfGNWI?=
 =?us-ascii?Q?vJsEbo2D3JhdXsc+x+U6PutfNFNEe5hLYAFKfel9dM9HLVfcflYwISXxFqxQ?=
 =?us-ascii?Q?vAQZH7pSZye3UsoHJvEZKAQ8SPKMI5gp8CATa7tLGFvel+91Jcc0gr5v310T?=
 =?us-ascii?Q?ClNXYHDklRaXOPu9bMvRqRkJ9sqLTon+ogyIQo18zJUolcaXEmFvQA12xFcd?=
 =?us-ascii?Q?rRiLhbmkK3X9mA8QAhIOlpt6c7/YWCOiKIyjn7KsssOzrw2WhoNMNbsLlcsJ?=
 =?us-ascii?Q?tFEdIxquVW2jB1a9QYF+6oRiih7NQ6vISCz4vy4EbEH3z3+QufCjgHW32G+b?=
 =?us-ascii?Q?yxCJ8mX6V1Z5CzXMHIztmhhq9FJxi/xGkUtphGKg0Q2PiS1PYOEIlCFz5/3S?=
 =?us-ascii?Q?btWewG9rJS2T/BRrHB2vaIoTL1fQj9qRalP6s40RApQ9BMdpquGp6JvKUYyL?=
 =?us-ascii?Q?YjKnaCMDBHTcEcma/PPX4uETiYOGev0=3D?=
X-Exchange-RoutingPolicyChecked: BoTyh/zr5Z/3g94+dNSPsz1tmSqnD8wnEokFY8MAUW74eqfiRoX8PN/cGA/FDyvd4WsClFADTnnu2R6NP2JeMsKy72WCTCpfb2BL8OBBHl+AS3sCfLBsSLZcpohlaxuGEPfjauoKPrqX2SX6aNUQHj5g/pklB8gD2VkVJVL6PQrvVyyzuZaO1HgU85I8q289L9dC9iE7nuem7uJ0PT5/zHq99fK2yLI2VHxcKvl5RIpD9FN7JMTvPSLMt1vhnqi2mFTo8vxk2EqTNDCE09PJJeBsy7dPb+EGyJwr5poc8gMo9eBBZ0pwpdomRGt/eZLZQGnii29dDPAQCSaNO5APNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb312fe-d247-4fd8-5858-08deb5c81637
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:00:10.5878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZVo6w6bth1BzfXqD3SqcEExGzAJzdywdZM2alV5kvWwtaAF6DH4m5NRxrjwJjEkFoM2CCBLgdLfzBFzTNQS4WktkP2IrY6R5EFSwdkDhSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8735
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

On Thu, May 07, 2026 at 04:21:17PM +0300, Daniil Iskhakov wrote:
> When parsing an ntuple filter, the code attempts to ensure that if the
> first item is ETH or VLAN, its spec and mask are either absent or
> contain only zero fields. The current check is:
> 
>   if ((item->spec || item->mask) &&
>       (memcmp(spec, &null_struct, size) ||
>        memcmp(mask, &null_struct, size)))
> 
> This condition is logically incorrect. If item->spec points to a
> zero-filled structure and item->mask is NULL, memcmp(mask) would
> dereference a NULL pointer.
> 
> The intended behavior is to reject any non-zero spec or mask.
> 
> Guard each memcmp() call with a check of the corresponding pointer while
> keeping a single error path.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 46ea969177f3 ("net/ixgbe: add ntuple support to flow parser")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Daniil Agalakov <ade@amicon.ru>
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
