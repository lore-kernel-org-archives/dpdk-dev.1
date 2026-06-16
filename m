Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD358CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 11:40:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9912040289;
	Tue, 16 Jun 2026 13:40:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 41EFD4026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 13:40:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781610011; x=1813146011;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=x9JlsXJxvoLJqx99X9zjJZzkGwnMpo/ENNYTzn590bw=;
 b=gqbI7loMmDTl3CbNMyL0Uu1c3H0JEtOYs7hHX7jzODshXp8OQmyynuo5
 ofI8UywQ1a/edz3Rw7kD0lNnY1STALiOr6Fgr51w+473WAi2IKdMKMN/1
 NnPauq5KJpV0vnYxWGN0UNWbWzRli2qzmMNg19SVnZUurGYn4xsxhmyUE
 Drg/Pz+3tWg/r7gdhyEF6Dq6HH0Zuk/IBEqq9I+Io+/zr7yZO4vvaKzmf
 UaPwOIeD4N2R/VMwHqJrObFYpdx36IvuAkiFy8a5scGsgH6+u31qhr6/Y
 aUkTG2H5YSlpfbZF5h5ratYy4SKyGwPNaO8+/JH4voF39jupROcHdczyR w==;
X-CSE-ConnectionGUID: f7oZbWZnQZ2q7lAKFHW63Q==
X-CSE-MsgGUID: bKtAzmDEQa+fhH5PNAsyiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="107801989"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="107801989"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 04:40:10 -0700
X-CSE-ConnectionGUID: 6ZgNXi67RtOXX4qlmgH3dg==
X-CSE-MsgGUID: VhhiFoigQuCkVJVf1K4gkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="244863765"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 04:40:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 04:40:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 04:40:09 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 04:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuTwrUq210eN26QnVgbgqtn9Mf8PfvvHPSikk0/dTxaS0Iprj/uvZ+L7rqBegZfg6aDpyJ0AW9vg4ryBOVOevY2GuYvxSYCvAIdSqm9GqF8gJnkW/P5FyQNmYXhGQqtRq0XtKMNol2GnS54wJe85QfZS53pU2WqKqH1XMj/1OplqJ8RWIXg2cVVrm0O4g82ZNELycY45ndD477l7VkeyX8wESifSFKcm2IizOBGp7VPfU0gDGvCM1yzorLL3VmaPlh3QJXjGd7I2fW8k3f4lY320+aSgnePpXilzzSmSxkZiYsanE4TGrAaomJKRUaIBHv+s0V0qEwO2JiZZC9by8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqaDnyM6ygUrevK4UgOq1EH5nBJh5fHRnu5y9h9uj98=;
 b=NPE9nTEc7yORtThwqDSq3qttLlbRimgBMs7qPEQPf2pmiDl8VKBGnQTPbxw4F2sgNXsjGSIfm5+uhzOfuTlol/fb+VoL16lZfgxkN3Yt80o1c2U/imBWy2UrZJp7m0kPlA2BFA9wp+4bBWQAk0/T1y+1ra/GFGwbhN/iyfJvEjxKlIcgr+msbuzzqlkAHUbePBi57T48qgnmNfJXiR4Txn5uSBu32MXyHGqPyPBAA5c6ZTZKEZ+wFl4GHvWP8HpgeIGy6Ms5B034/PJ9pGSS25u44jdThVOgzo1M9ecjewmS4TvsbXQWaNGmsi4JpLucW91bwOq6nzOs7p1lTMDbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:40:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:40:05 +0000
Date: Tue, 16 Jun 2026 12:40:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <aman.deep.singh@intel.com>, 
 <shaiq.wani@intel.com>
Subject: Re: [PATCH v5] doc: improve e1000 driver documentation
Message-ID: <ajE2EJG65FLeGvRz@bricha3-mobl1.ger.corp.intel.com>
References: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
 <20260324230343.1050223-1-chaitanyababux.talluri@intel.com>
 <aifh_SRQq2aT5wbl@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aifh_SRQq2aT5wbl@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU6P191CA0060.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: d34ff15a-3652-4037-e937-08decb9c02b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pO8zvy3l9fNEL6ThVpjnPkhPof2MMwdQvlUJuL8U+RrhRSkaAMZuiwLY+rhUQc4goLbK4IpegrJBKmVBnhhGAutwpZjP3QFfScNbRNjcLpUDCBsJ/oRPpQ9dmoMUfdOv5m7Rvcp8BWnf4+iEk3U/JBjkb/lyOM2pFeT6KiYp5NSTIrQZlqj4bsMLPcRNxsbj0wA4abgnfgSxqIhyU5JOQ4511RZsWAJnhfSav0Egs1n7LGVtAKVEf9nfvTHr/YkBezQW6gDf8SZC1xOqqS3gjPfKyAjEdSIGrGk5i3JPChWyFQMWOLVnHpB4mUvZyeb0OgpeOMrVordEzTK/btcq9TBszHsTp+aotcD4yJuoFBTEbrGqy6NYj+L8B+PYrz73HakSWxJEt9LVsBoCJOhmdkUQM1FgRgIfQJGTwk8n2sCp3Otufn9pqUzK4IvTuc1P3tu8gE++MxjiuZOUXHG4CHiUh4MLrEPY2ebsLKbkgRxbBjA62MziygwzIUvHJk0VLjW2oI3ZhVPGqNhARTA8wTJcAbcsrI9oK/nRxv+ZO+kYI5vBK5NWRvGAU8l+VvqnktbDZf2a32sxxLZ0Cgha9+T+GepyN+1CXY+9QyG9aMFcqIppaX2Xj3nmUvJBGQxDSBHedoOItMgVgtkRDWWHZT9uEUGOpvHqE0uGpw1HJBmR8ejgM/tVfrvg4J4BtpDD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQ3jhbzUsVvshOCI7GbJVFNeo5Y40BHIOz4kSpyMup1+jUNzFNK0/gmmTf6b?=
 =?us-ascii?Q?uBWsn3ZkjDC1pNSFPezPSehBCdCrvPC4WbkWdBoHmPZS3Wvo/62bD8dGrcLb?=
 =?us-ascii?Q?xSEbcOLBugjuiJcvcOVHkjItS0C+67t/rzLlzsyyz6gOreC6cQ99ReYFK8UD?=
 =?us-ascii?Q?9PLqK69HMz13nowWJnGv+yfW/8X7rNCm/lNZgtlrx84M9iN5fHdh0GwUPJ7m?=
 =?us-ascii?Q?/CZhjN6z9s13foXQfcGBH/dBBSj29NGYslUgzJgQfFha6mlhDdJOiXVh5c4a?=
 =?us-ascii?Q?t1riRkHAc4f6l/ZyR6d6QUlSOXpzH59HJ11f9uJQjZPqL2tFATegL600bXCd?=
 =?us-ascii?Q?Le194s1Qb0OUI2FRyFD9CWdT6C4jZ5gamPOafjmPv1iRoE5R4Argwzl2hQjs?=
 =?us-ascii?Q?yOKzjc/cajQun4GmFgcHGNo76Obfrvc1cyV1MZg9N0Ni/QTUvw+q4ICRGUrR?=
 =?us-ascii?Q?14W8+jnjODX3Iq1qeydvkN6C7Em0H/yiPP9ZrGhZdu5731fEC4v1oIonjwwb?=
 =?us-ascii?Q?qHTJJNCemZXdhEy0oK7Reh4jCuN3T42KUkBL6SSvTxw9QzTLQxNlmSCFtOP6?=
 =?us-ascii?Q?sCJhlp6ZTDUqQWV4JdqOwVYGAHp82u2tboiwb28yzaigiMRYim+0j55XoiMr?=
 =?us-ascii?Q?LpQIq7Zj4/bZw7hEk0nJeEZzd2bI4V6SdGKMwrJAJuPWy4Q4a8VSVQaeI/48?=
 =?us-ascii?Q?HdrxqaZDKcANhCb1FDda5tROuIdRsi9nmh8cllyrcsoB/4lccDc4xjjgs+BA?=
 =?us-ascii?Q?7OSta7VLPeukihMVRWqu0BnihZieo9iQEn9V/xHCdwPwB3pAj2RGvvBXqV/l?=
 =?us-ascii?Q?cArb2Ujb9cc4OlYJ2FiVi05o8ZcLFugT+ocj/pdjOUdMPjJ/nhZNMsPp9ZEb?=
 =?us-ascii?Q?nWcEiltybmzt77agOJpLVTMfj5dCydg2GjHKDEcdRAUQBg/TVUtR3BAcfMOI?=
 =?us-ascii?Q?3c3C868CWU68h3zHU5sykfIhyh38fK86JwPw1DaPumLZeMVOA55++GRsK6qc?=
 =?us-ascii?Q?7udCrGUeShvIk7nCcVoLmcrHzEEP2Zfw+amDqaArA1LD881dOuidjtVnHuxQ?=
 =?us-ascii?Q?/4MAN1jdYNUjCw0sogdeHSk1TcthaFnVCz+f4MlmkPCJ4kperS1NYvmLi/CQ?=
 =?us-ascii?Q?5qLqm40U451M3OvK64fTzrrYwxCPUhgt0OUjvkaSqlYl8tSNjsSM7nx5hTEy?=
 =?us-ascii?Q?zcbtXO+vnSvpkS7euaOduubloj7wtzBFQePWPvXmaTRYLzliPU6O6IatwRSZ?=
 =?us-ascii?Q?p/CZErhxUsRBIn8m0gb+BAd5yCcNgqVkOz0MLxSQIHUz0x+UBMrqPc5EM8/l?=
 =?us-ascii?Q?N/opDeu8CkZU1Bfxj850xnSdv4Tevrync+BOQXC+7KqOw0XKO9wEb+Cg9lzv?=
 =?us-ascii?Q?0WwoE11X/mrlvUgCl3PNWAcrlri+rQlxscRboihhPIqzZ6xAuA0fptkgHj9I?=
 =?us-ascii?Q?3IxexI4Dg0DUJdZOAj2NUt2vBCk5mEnONuKkJ1cqFe0e4gDgDVp7wGGTGKFl?=
 =?us-ascii?Q?0vPYC7xZin+CZzOQjQZJtk8yOglUC1GPr7/aVJQbSDlHSynTkCnARtCJciul?=
 =?us-ascii?Q?4flL2s3Gz9o5XOaEQNqaQPTqGp8rHouAK+WFytAs7iyIB3ZKjO0MaaZjENdL?=
 =?us-ascii?Q?TtNT8SzSLsM3QtBW9pN7J9qVuKjLSqvc5AvHIhfn0yLMgPOxPxIYqHQhWSvn?=
 =?us-ascii?Q?x1Tvi3xtkF/Q3Kh4vqj4J96KXWvROtmA15SnqqsGgSFWne24vTbRBenzplWB?=
 =?us-ascii?Q?Fy2O+e2mTxXm09mkqfmLXLiggGVZ4x4=3D?=
X-Exchange-RoutingPolicyChecked: YwSs2t0wx5YpSogR6qzmU8fjIbRuYKX6ynMwNY1qzHRyxOZkNS5PTXFSj2tY88VDBYlmv1MtlpaYwTz5ru5RaQDU6NMPyMn5aBxrnHTV5MPZJfX+kCAljHKa9JB4JP291Gsve2RL3LxC9wJF1r5rhSaoZJpXkea76R0UZgJns4xw+tiL8OQT/LPHuKRpgp6DzboayUBpc7km51zaslOVWQKJcXn5PPzeAUMqqgJZBqw2E7ny8+pgwIKRXoZye/k3wiHQ3mEiiGLeI3KjeGd5KAy7cl5FKgDZIkdXOapsNoMau1rDjkn2R/YsCiCqy5TyRqftz+8KjPmL/TGf4sI4Ng==
X-MS-Exchange-CrossTenant-Network-Message-Id: d34ff15a-3652-4037-e937-08decb9c02b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:40:05.6680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlyYaSVlLuZgJNkq+cImQBvoJV3kPCPhz5hdf6Rw0fF9aUdwiLHW0BF4/ccDedCfpXp5OBHEyQJ8Sp/nW++cbs9FndqDWOqgRenrW5oDr28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
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

On Tue, Jun 09, 2026 at 10:50:53AM +0100, Bruce Richardson wrote:
> On Tue, Mar 24, 2026 at 11:03:37PM +0000, Talluri Chaitanyababu wrote:
> > Add an overview of the e1000 driver for Intel 1G devices.
> > 
> > Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> > ---
> > 
> > v5:
> > * Aligned PMD names with code.
> > * Fixed wording for clarity.
> > 
> > v4:
> > * Fixed RST structure, single top-level title.
> > * Used ASCII "PCIe".
> > * Adjusted commit message to match content.
> > 
> > v3: Resolved apply patch failure.
> > 
> > v2: Addressed review comments.
> > ---
> 
> This doc still needs a lot of rework, and possibly merging with the igb and
> igc driver docs.
> 
> However, this small patch is an improvement, so I think I'll take it into
> next-net-intel for this release. One small change I'd suggest below, let me
> know if I'm ok to take this on apply.
> 
> /Bruce
> 
Applied to next-net-intel, with suggested minor update applied.

/Bruce
