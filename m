Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CD0C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 16:31:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F411A427C5;
	Wed, 21 Jan 2026 17:31:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3592F40261
 for <dev@dpdk.org>; Wed, 21 Jan 2026 17:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769013086; x=1800549086;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/xWtufewvJvhiq2sQ+gBaC1aqxxiJDMPdr6UEskMCE8=;
 b=LGmdDu3+Ji//8q7DeV7ARt7Si6eC2fSFjl/uKFemufpq+J632ZzxQ+NT
 ZiYAuVSJxMlA9UtLwk7xGXfKWRVaZpH/3WBYE7ttY8ZsBeNiZuDzLUg4y
 ZQy4B/3BFRSXBv8SYPfN1yf85n9EMirvret0ut2KNLczxPQZHgseCJpn/
 dtSLV2lXiqjRAIqbvWsRLOUHh0ISboaHC6vNNIEWsILavV1Et2+29Cat+
 qggMb16+TWiu/LlWLWxQpQlLUFlTXJG8l1tX3Hqne9HBTCaK6yo8f5sJl
 IIRepjx8AV5O2wLJp6l/z8bSI7JXyYALI7xRDGDBLp3vDtnTi6HBQafpO w==;
X-CSE-ConnectionGUID: DsEJaZXsT4CfeJxosp4ujQ==
X-CSE-MsgGUID: +kGt3oMyQsqCV1y43uMMmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70409534"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="70409534"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:31:23 -0800
X-CSE-ConnectionGUID: Bmi4S7aHTdGrxgAmyV7n+A==
X-CSE-MsgGUID: KGtYCXmBRR69meIEUf+mWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="206304900"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:31:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:31:22 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:31:21 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:31:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMmIQjRY15jChbnkbVOjQx30bHuK3jve2VxU6NNK/BM6L2F4JkOvySy6MWTfu8wDz4K5hCh8KDweI7sVjzFovKZSLiacAOYSwd8C4mHzIOHBNn3f4Y1gtcaWhAeMRiBU3mTyFaOUbPhwZjUozIuDHGQAcf5Za2ZW1AW90Ckjl4OEe7wLY14SQWZiGbftaWNmIKnmRMt3O4Q7kK9aemUUBP20BCObXkgXGWLFs89egNktKQ4fdx1Orro2DALStsK8/3ZV//S0mzvWt4UJyW8EcUBJlPQMIrVw3HweCJO/2MvVRh3nNzuiM2ZKQAfqCBcus7vP8vWmEzDCKPZS88Ajjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q+ArVpfdma2MFbYq8DoIRmFJJVq9s5JJRsgenM1sGQ=;
 b=rql3NGp5fNcrmWgLpgiqojHk5BpzGDLRGZIeB59Bg4HVhgXnfxgmSPE8L5OHbE1oE53T8Y7fZUtHT1GMmRQItWVQw8fFzOQiQ9COLosCMq+kFVRZ/d5BvkA54G+HzivRZX6zfrZGTG9dHhutDfZCLpT2/AuiSGVypiBgJTZF5GGoIhWIj5wXHXnDHRiFKfyPfsVLPgpH6ANNnxsbwSAQRLj2IS0HbSyWiNCnyPuEpCSoGeNFxmqDqCh5f87WN0LbrP3als9B5P9NueOeIMutX0VEc5lYOKapSipVy4EUmqmCJyTKASlvDmCcBkAYB1/Pr03+B5QnZsaxx75uHlKnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:31:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 16:31:19 +0000
Date: Wed, 21 Jan 2026 16:31:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/6] fix test failures on larger core systems
Message-ID: <aXD_UiSkSg7yFyuT@bricha3-mobl1.ger.corp.intel.com>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120015759.301155-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU7PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b185e21-dec4-4444-db29-08de590a8170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yzuX3I+iR2nq19LHXQfng1XZPX9z+FEyVb7vwI5igTk+2x06+iZ6W/Pl1UlF?=
 =?us-ascii?Q?r+Q/2OjbYz4jeHRghq9d2CoZ8ulD6DW1R82F5pQ2n1F1/7ovuqq78yITDJaW?=
 =?us-ascii?Q?EsB/QF8fFwChkZGBvHh2kEibtG+Fk8FioLHLglLw+JNHJjGQMdiFVQSTzSbq?=
 =?us-ascii?Q?bIMh7tja31foOIkZ9am2G22YLBIxrOqiYplZo3zoo8+Ta30KfLVLt72y2gKF?=
 =?us-ascii?Q?lx/rDuHvOW9sVslFIC9lvNPIOacV1mR7YI/jThmHwOInczQDH3STTLtnJ7bX?=
 =?us-ascii?Q?ODBvfxn17WkDq+5IILqFvsDVwRcMKwpE5pQIb+mF2iFEy8bEAXoZ1AytRK/v?=
 =?us-ascii?Q?o2hP/gjTIh6faPZpBDhcnpiYLexM3e7wonXWlh7mFxku+lMsfU7E93STJqSH?=
 =?us-ascii?Q?1htH9cbvVkVpVbyDKqO2cLSV85LhmwHDt9WnRNbkaS6e7s68KjfvTLMfUJ07?=
 =?us-ascii?Q?V3DU3i48XiuTZWhhwycsjKBQZ06mi7Ewg1IobxigM3ocDoS3OxyWj1VOAwjw?=
 =?us-ascii?Q?vQMchvWDUjFT8EqnjQPd0kj6ywLAjADqH0mbztxJOi7zcEtyNLLBcQUIS02k?=
 =?us-ascii?Q?2ywWjGxsSC/TuEQHS0pcartzcB0Jxup0ANNEZGCMLV6UjfVOFknu/sNU5/xE?=
 =?us-ascii?Q?8gVCEV9dcuOJ/EAbhEBFBDB1bnfZDWqhzC+kUTFJYvXdJ/rvZKhP2Bl3Rixj?=
 =?us-ascii?Q?Cmxqd2ltQNQK6x3vB3fCjU7RjC0XILQqVYrVyqy5jvaNERwi+UPxPrwXEhmr?=
 =?us-ascii?Q?p9ryu9tKdMfw3QX7U5xRpj+b6uLIvLUeg9582GTlvql2tDsTv1uv3gryDT2e?=
 =?us-ascii?Q?5mjs/yP4D5DKjwE3wmLC6xpShf4WUnTuClER59biJY5f4nbPfClf3epp4zzT?=
 =?us-ascii?Q?EUiMgS59T7p4BZCg52AA7WUDgPju0UQbnxokHdY7CAphh2PnvVPVO5ZS0Kc8?=
 =?us-ascii?Q?xbBtV7buX0ZQB4vWhb3VimmBG9+0gwg+sSQ4haxuyk6GZUP4VpFqT7S40RAo?=
 =?us-ascii?Q?tXSnELTeBfnBDTJMkGEnzjqing7LzaxlAFrHqTnssbb47ZexKr5SL8qSfaAl?=
 =?us-ascii?Q?r9OlasUMgykCiMLSBPK+qT5q9pFu9SY0Iupr82qy2zXBYqMYqWHDIGbyHCVH?=
 =?us-ascii?Q?RrkhXflUbBAahlIgpvVx6wEyFuyLFEsvNUiZV753vCBNPvM9t9HCGvdazAva?=
 =?us-ascii?Q?13m9xNs+ihMwrjzhDpc6h3XfVf4PnVXP92PL4sw07ANjWQK/4nbw8tOg0tM8?=
 =?us-ascii?Q?fd4SgI7HmsGR5z99jDPvBjumFwfY+DDEg5gpkHLNWTy4In3IuAadPFkkAov/?=
 =?us-ascii?Q?szd/y56h+34P8Om2hcGBtGWGDHKWK5wrWRPDu/P2MFiw+1DYwDknc19Wqj0F?=
 =?us-ascii?Q?pJ0g98JpWClWwGjYkonqb1JzdxwQ12MrQ9hB0jNRbXm8ZtOAbZ2cUYNZjYk6?=
 =?us-ascii?Q?m6rMiGFg9Bk6THOQfwB+BDkmZLpDSvXFoJY05jMKYW4J+m/Pcsx/Z4hQh/7H?=
 =?us-ascii?Q?/Uld529l4nJrxHIuknBG7h5G8tD40tG/8nv0m4IaKAc7mXHFflvPslUHp0bt?=
 =?us-ascii?Q?jI7+t1iv9DNzZ/isGJk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJ0UQqwcWrd6cmqQxeuWsu4lTRofK/gyKxIIqJfmmYLvZ7BtJYB76fmQgs8k?=
 =?us-ascii?Q?ulcy4CL0XNq57b9Y+uZeHNlmBaIulO2JYYWpNXee03zZPNNfNH/rlVra49Ck?=
 =?us-ascii?Q?yvUqD4GNCO0pRVoV0NOMlKdKFIjsZYyB56pDBSE7iuMxij6KNlEGkkJ7Ibhe?=
 =?us-ascii?Q?qwFXtj4mSZq0Iqv9OkDBHa+YpAfp/OPKfw+cckP+AmoXh9pKcc5aCj/vGmTJ?=
 =?us-ascii?Q?yLDOvOdbQk/Ku3nXNsR5YRJ0sqcv5feVxgz5vDtergK/Y6k/jF/YBxNqXF8E?=
 =?us-ascii?Q?2tqPOoHYjari0s0WUp4fwXS1JK4sHsbwpAmneaLURZhbJp8VqkkPwIPD16CO?=
 =?us-ascii?Q?ORDeLz2D1ivQDexdVo7pyXaayzIXy44qU24tkHcEx1MIce1/vV8HRwFxqO4k?=
 =?us-ascii?Q?6fwQcn8Jr+LwwoWiAuusxEZXvTU7p4kpsje44tS/GePVm9yBIKBwWr8dlh1S?=
 =?us-ascii?Q?tqlsqmtvpl+eqzwCwWNy0/ejbFwDNqCx/725hBZ9tnyiCIwVI75JCgn8un8C?=
 =?us-ascii?Q?9Zjk++xcKRjKhciXIdSbkkmnbuCpcusC4AsmJzbXg35YfJkSmc8MSkwtFInX?=
 =?us-ascii?Q?qq0C66WFyz/SQ/u4eS3d0iXjoS5GT1JavBj1mQRcbO+sa38Q4CvArLC5zkr3?=
 =?us-ascii?Q?unUrgeA8WBbCPIscbJePMCQHOjH21TVimfvY+fjpOZgqGPG1V5E9rJPoLowC?=
 =?us-ascii?Q?N4b+W0O1NQp1M3rDLryHol+G75O7TC8ezbqmWUxzYfZbpur0LFd08Ya88hvC?=
 =?us-ascii?Q?iDquLaBnlcpOdBDx8DgzrL3Zs2IgKFTGTg2y8VmjMjbjl5Ks8zLFYquQw0co?=
 =?us-ascii?Q?SHVqsfLmN8xsCQ3vmCAqjgwrqHiQuTb5s2CYvgGX9FwwfQMhN86d2VJiCwEv?=
 =?us-ascii?Q?mnablx6xD+oaFTcy0eDnDNVbPmYrF5eYbmgS4w8LfuCvlQlKamHdgZcLC4PW?=
 =?us-ascii?Q?Hka4983+NvIxt/9bk2Dt7J9joA504aDSrV9j4oDKVYmt4lITadoN6iKnJYTu?=
 =?us-ascii?Q?7QyzGZtwOlHNHwLZArzUa4ZxHzuFpKqrkb57ag3rlot5Uz/iFfa49BXwbDEx?=
 =?us-ascii?Q?LEcS85aVlijyE+QXHDbQBeRUg5BemMeemSR4ApWCfbvjfe53HBUyF5ldhohF?=
 =?us-ascii?Q?5WL+4D4zrYm3+0URsnW1T79o8xFYl0ldNXlxOlk3N8Z5QKOsR+66Ap5oGy7P?=
 =?us-ascii?Q?m2POPsw6xfl8U6K0WkoDdLeJaweMQtDZS9+bXq60yWJ4bo4vjRAbpCaTpeCN?=
 =?us-ascii?Q?+YiBRJzYyGOjl78+Zd7oaaWOB5jT7st0GVeK8+Z9rP7pGRp39dd0Pq+Cd457?=
 =?us-ascii?Q?fixZ+hCeVfZxRlNGjYzPTkoRKbFO73XpIiB10XzBPIfh+IrEWK0EsshVqxL6?=
 =?us-ascii?Q?1mUL3uEv+iQeoAW8M77KibicbmCThCCvkGBqoi9lDSYTKsL9AvzVpIONWnj0?=
 =?us-ascii?Q?KarJmiBa5tUM8azOMgcEvkXo/mn+rXuVwlUlhEajJRBX6lWmCE3UE11ke0qw?=
 =?us-ascii?Q?2nAL+i7JHrirSts8bUiw8MDwmanePf3UfaD8NtXg6qA1ATYut8G6t0z0zRhc?=
 =?us-ascii?Q?qugc4N7YLIx0fu4l0KZQtk8cNGddn1P02FHfknBgRZoHirAjmZ2CiVCl7REZ?=
 =?us-ascii?Q?9UZrLeXhB+ER35kg1gevLkOkpaxbP4ZUauhjLVF6er+jyHo6CpkYDce5qLGx?=
 =?us-ascii?Q?CjaMSKzuzvE+/qLl0URHeH4O2oCUiFbZPBwSnwv93CMZWehY9of7pKlwv7he?=
 =?us-ascii?Q?lH1gNl8ro66Ut+25olwRyyex6UWt3NY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b185e21-dec4-4444-db29-08de590a8170
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:31:19.0523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeoVPLzi2lvDJZHHsJirD1hipi68UyXiVqeL+L92D8spR58iUTrqAtoH2O/43sPWed9AK+EwCKAECEqenNcDL43/OFnlfnlQkB9RahWxiAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
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

On Mon, Jan 19, 2026 at 05:55:03PM -0800, Stephen Hemminger wrote:
> This series addresses several test failures that occur sporadically on
> systems with many cores (32+), particularly on AMD Zen architectures.
> I think Ferruh may have addressed similar problems in earlier	
> releases.
> 
> The root causes fall into three categories:
> 
> 1. Missing rte_pause() in synchronization spinloops (patch 1)
>    Tight spinloops without pause cause SMT thread starvation and
>    unpredictable timing behavior.
> 
> 2. Fixed iteration counts that don't scale (patch 2)
>    The atomic test performs 1M iterations per worker regardless of
>    core count. With 32+ cores, contention causes timeout failures.
> 
Testing on a 96-core part, I still see timeouts (with -t2, so 20-second
allowed) in mcslock, stack, stack_lf and timer tests. Limiting core counts
for those makes the failures go away, so it's likely the same issue as you
solved here.

/Bruce
