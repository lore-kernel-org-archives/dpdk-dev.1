Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A96CD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 11:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FA89402C8;
	Tue, 19 May 2026 13:03:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 877CF40296;
 Tue, 19 May 2026 13:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779188615; x=1810724615;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VaiFFpXSJCKZAIH9X98AlUryp922UDlTEUsXrOQ8N1Q=;
 b=X5PkX7awpGgDzK6V9t2WJFEhpbTIMRE6/NScG1b5hhueIggsXIEbEJFt
 KzahYQYNSkPPtCxanFWodMOzfvrWpzVoIeBamY44WmDh4W52t+BRaHUVb
 eq/Nkp+tpyA/hiDBjf0BdrXMSVW5Hibk0meKv8pQzl3pOhtQsh/8Zrnl3
 I4TPm9sUhs5ZJcOK0Pq+JtDBDTvlVZX4/cQ6YC06OC2x0b/FevvKpqEQ9
 yg+YlFfniJAr1/AVUsa2P3wryjl+15kZ7bciRaVHiCcOxEA94gbhTxq0D
 +SqouGftFnsT6gpK/k+xAHHHa+s25bFFPjmu2FwjRNoNLyUL4mD6FqyVk Q==;
X-CSE-ConnectionGUID: xEFavBynR8CQgSCIgFoOxw==
X-CSE-MsgGUID: +8/V6/OrRymn7P1duwI0pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82627807"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="82627807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 04:03:34 -0700
X-CSE-ConnectionGUID: bqy4odGNSsG+jeHhRLW4aA==
X-CSE-MsgGUID: SgqItQ+yT8mIq9pk/nWvHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="233359588"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 04:03:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 04:03:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 04:03:34 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 04:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXbMnOCIf64cg1SfC8B+3sb8DiQn2dCUIV1S6Z8EHbrrYML1pdvJjABKcRy5m7P/WydYwy18UDEUAxX84P+pf5AxUqxBrOHMG726I7k/6EB24DgKFyJC86c8m/jMaa2jUW37zOTQmAOa2vYWbI+gSB4XgpCr6DdQAo2fhpLsOfA38wjxxeB/51NdUiTc3UzYbHEA+Ds1WHvXsShVBfGY6zuIfABsuFQhTNhuNcT/TxjEvGGsZhKB63yUMZX07I1Jlfi/0kKrhb4EGnbYvmE4YiCgSPMmcw/7VbxOY2lKSeltsZms1G2HDD/d9i1YNYpnYaR0+yTJczXz7NGFY9OimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC+oJFgoz1LkEM8F1LkxtiBAiGQIvBmXNljRyQZJWC8=;
 b=eTQX6q8nmaVVt3T8JoYJ1JrH862Ywgcvl4pvWx6vXt2j4gJ8GbbV44HdrZUUxz/OwlcOMT7O72XOXLjv+wFzbPBb/cgeqAjozexULAxFqK03uL1CsqxAT2z+8fQxXCcY2ZFgobTfvNM60jiCP+Ne/PAxLdE6smjHDXjpJu5NXLBC0odhQFsSYQAJQe0lROcBihg/R1Rtvp4noFaB5PAFi3BpRX/LDlVuITRYTZfjtG98g1B1rcKrOs2fewHDj1OsvUsOWBEG/7Y+dHdCFX5jgMJyWDC7GM6gbKU9waQJjN3QmdUSccGrwEXpSy3ZOFTCgcqLE1xCr7oxNckVD7TO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9256.namprd11.prod.outlook.com (2603:10b6:208:57f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 11:03:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:03:31 +0000
Date: Tue, 19 May 2026 12:03:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, Robin Jarry
 <rjarry@redhat.com>, <stable@dpdk.org>
Subject: Re: [PATCH v3 1/3] spinlock: remove volatile qualifier
Message-ID: <agxDfVCC-xfCwcCG@bricha3-mobl1.ger.corp.intel.com>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260519103640.3986710-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519103640.3986710-1-thomas@monjalon.net>
X-ClientProxiedBy: DU2PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:10:234::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9e064a-f8d4-4038-0441-08deb5964343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: iM6sVqcxVKV5JWSZI+j0SZPgoNoriWqWRkmiLuHmoAJMjIK+oXsrakd6YZODAc7j/VLdv5/XhH6pi5KIGMIxS7z3p6ywIu74I1aCod1nsw6M9AYKyfTTtiFfpb0LI2wY/zq68Vfc91lkxaY5Yn0xj/P3V8TAr4wFcZRAchPhhVgitYFPdp9bQ3mMhtWLnoKqt0T0vZahBEMKzkqnionbk5/NoVH4KeRdCDr5FpWg7G0+GWIfIG6oO21TpOKeU18MR1Vy4wMUXHl6oahWNElXlCqB8fjAV5j5i22ckKt2Wganjg8+SiqGYtI03FdHeX6uIIGjnU6x7rSa5yxLwvIPBIX61UwPMHRs0BsmjACSssHtxRh0R02cAUxXV4DEQ81PY+N3nuaqOWUb5k2qBIguHBWzqxQe360ukLVHmkI0kQJyV2kgYbyBtwTMoyjZjJJhggcIQBYe984cwbe2SPHTVcfSVzajJgKW1sW9RkpMHapWK7NpxJEXHCd8y9FoACR5EOgVU3d3hLU5/CVglOgroPSOVFCpLtC8Mq58fcsWq6+Id++MEjhnjfIZ9CyRnfs60CxuD7UstZPbgDgEsm2djY8z4qsagippUcHSscXTLDtrURY/fdgmjKxPfkX/sB+ZDTSrtQfztoLoelZpob5lX0YRiI2EHvdqVnLRTpTj05r8QvTXo0CxCcyukQr8fFPX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EjkfJEZPgevzDysnGp00QcFVFE7nzX1MddrHWFJjnoYV1T05t63nzEhKhMVE?=
 =?us-ascii?Q?YFeBDDZuJ3c0jllSS6gIdZtzPuV/+s0nV88cKzZwSwOxdwa2seq+c4LNYlJs?=
 =?us-ascii?Q?r9lSIeRm0fEeJwH4s5MMpDzvZA4G+qj9imczD8cUKmHSCxS00lMsQ/Bbd3QP?=
 =?us-ascii?Q?eKymIVEb+qaM3gO+vJAYBUgl/J69Tf5GNJGE3JGGtgOLZ/w8deTmgcP/l+lW?=
 =?us-ascii?Q?gduR1+Ib4R3j4lur4EIRjL1L4CZylDZnP6/4gWXunrHHSbu145AOMG5GzFya?=
 =?us-ascii?Q?wwMCQYLywwpOl4sl9KzwA+U5IaHvmLorcI/NjcqqhQZFu6dcTaG37KV2otd3?=
 =?us-ascii?Q?SQ0EBoHoyVfCKWqXTgFKBnNUJ7dsuKVxn/GgIK4KPfWDX4yIz3PbNzg83tnK?=
 =?us-ascii?Q?OX2rRBhVewhAw4uDTycYzlukR8vdfms0f3Fwh5/ntDW9RwyTgdpTm193QjFX?=
 =?us-ascii?Q?C1MfuU1k3zRElziURvrmgf8vpgsz9/yVHiJ4O7036XOyWgzgRe84ZAFGvW+E?=
 =?us-ascii?Q?q0agkMDSwpSOpup4V8KkoPZTTuVsIsSdrcKa5m3exS3OfqkK4exPa8iucto2?=
 =?us-ascii?Q?6LyIAgQiybOBLT5eIPGVTI8wKewODmgRDgBjMcV050EaOdi/vEaFL1hEwxz5?=
 =?us-ascii?Q?IoD3pGIfOJSfCvILmivMMeQ6fHfgAIey3HDLsi2OVzK9hqcJb37i8S+yzme6?=
 =?us-ascii?Q?QYS8pi/E1zQbSBWgERYNLoa/2+tpS1f5+YhYQpqQ+LpQ3UXAqmc66OtX6u/O?=
 =?us-ascii?Q?yjW37gbypVoWdNV1WgN95x5RuCkMJMC4DTit16dvb5xqtqBsv51tDyuoQCDv?=
 =?us-ascii?Q?ql3XINuhuqAvD3DjRMlEKRqu54UqFgcp8F+rQ89+LLSSKC92hLD2RdYpS+An?=
 =?us-ascii?Q?B6eT75H1VhIURnIpl3haxy8/dlc9aa0XoclQjDHVkprBOGGphivJlEVaM3Mn?=
 =?us-ascii?Q?dRWzMnmBOKrKnColor6nLPHX+aLU3zaU9JOZUFV2Uhr2PkLrr5u7CUkujTUe?=
 =?us-ascii?Q?qGx4XqCNMF3MsTuPI6JUk8knWKu3+4IpjF8vT3nGBTPqAw5jVHZqMwCK2U6g?=
 =?us-ascii?Q?8JohEq/Aar+HqWVC9kdld0qKLzWkd+Y/wTNkolUA8UYqMSrjuPT5FTaHyvrl?=
 =?us-ascii?Q?wn6mfI0qDYq0uCuKMzTzl8UoowWErFbwaPvOPDMG4dWEQeijfEmcJUOYI/zz?=
 =?us-ascii?Q?ja7a5QDywhgE+Ks+Ns9KGbqyno7li48HE6k3dz5R2dQU9rK5El9iK3E54fme?=
 =?us-ascii?Q?LQnNTD6C8WbRpGFG0ej9rHhPCf//mU3tsfGsQ4gxqpU4662Kf1uR/R8eKbVa?=
 =?us-ascii?Q?oB12BxFO1Gm6rUdBuUYuAHz5mdBvugRWEm1tR3YsNHQ+VDoF/g+FgPBYp7Xm?=
 =?us-ascii?Q?g0TAk60ZRFX34zDNOhe9idvpZ0hjdNw5ePjDp9msnPzUXboGG/P/ID6EngAi?=
 =?us-ascii?Q?m21OvHgRw1Hic4PBzGj4hjss4Dy/VNocyhDTBM1AfqVFFlXmBNlkelcPKSde?=
 =?us-ascii?Q?7znQJr2uYCno+49Y6yDpaEiHx0aatkuTQ1k4QYFZWcFg7H2tzbywfK0cVAT0?=
 =?us-ascii?Q?K+57DywvuHMsgSBMsTIUV1c8LP53oSWJ6ov5Ol/O+DL4JqNgQY2e1FdB6yHA?=
 =?us-ascii?Q?qpNaeDbqYC6kxvx2J0iDb+wPfjsD2PU5aSuWGAL3MEXqVR9Lp3Ta39JTClqv?=
 =?us-ascii?Q?ZuTNjgBIPkQDdprzyHwrxnVH/zbAJ1Zw9QKH3t3D9heace9Dxlxl5qL/bToL?=
 =?us-ascii?Q?R0kwtY4cjUJfsn+kOLbtwiK42cGkaKY=3D?=
X-Exchange-RoutingPolicyChecked: k/QMZ6/Abg9wJpgVzZNQmn4l6k286yqmBHPqCW8S/CmK89mRonyaHofI3mFTwWS8bGHZgdw42FDnqsV9zNKdgP4ahLWx/NkeKpoRgbSMnAC3D8myGUw5u+b2DOm71b56WySOUhMBihkLwIk/L13DlB+h0uswsKhuc0ogEVF9GOf0m/O1wnBXSXkXgiq6ffhS0rp4mh7tEcSsq9uez/9X9L2pd7bc7pkIm8xp6d2R4zrrKZ2r5VsVtIqKh0EoD5ziNa6p8fm7iuoVb/VMtRloXuShMxR+yKxR52/D97Kal9x7b3OByBQNJFmGUw233anbbVn6oh6ONUdvXxJd3qBgAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9e064a-f8d4-4038-0441-08deb5964343
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:03:31.3374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bd77+9lLh+5ij3UeRNysVm2ExuQpL4NN/ez24+UYPKWku5QPV/HAG/UesWCzckMCsiUXRPUNSnjL+mFnRGJvOaSYk8XsonRX9XDZB+MH2VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9256
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

On Tue, May 19, 2026 at 12:34:14PM +0200, Thomas Monjalon wrote:
> When compiling with C++20 standard requirement (default in GCC 16),
> the increment and decrement of volatile variables are rejected:
> 
> rte_spinlock.h:241:14: error:
> 	'++' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:252:21: error:
> 	'--' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:278:14: error:
> 	'++' expression of 'volatile'-qualified type is deprecated
> 
> The count field of rte_spinlock_recursive_t
> does not need the volatile qualifier
> because it is only accessed by the thread holding the lock,
> which already provides the necessary memory ordering.
> 
> The user field can be accessed outside of the lock,
> so it must handled as a C11 atomic variable.
> The name is also changed from user to owner.
> It will break if an application is accessing this field directly,
> which should never happen.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
> v1: drop volatile keyword
> v2: make user an atomic variable
> v3: rename user as owner
> ---
>  lib/eal/include/generic/rte_spinlock.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
