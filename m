Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E745E83EF6
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 17:32:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84C26402F2;
	Wed,  4 Feb 2026 18:32:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 44054402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 18:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770226360; x=1801762360;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=aBnV9cS/lvee3tPQLWk11amZkV12W3ywFnrAV8zQh5c=;
 b=kRutEqWgLeSVh/HqQTQ1TBdsLVdYy9owkPQyrQxIbTmG1grCbHvC7CXh
 Ix2bvu2KdQkHN60aoKW+O42Sa/CxEw6frnLSxZNFkCtd3BTPM+XRJdOIW
 m38DlNmA6tSMsnfDdXEE3wGXK+7w41+n6uJhKfnSbkpj9UWSR8yLQ3T7L
 zGYWsDikyyCFlKwyfkr/DWJrZmmDaQUv18SlZLZHXoZ4WmVznG/b9SBAY
 mgvDLNlha1vO0u+bMHm5hSgF3bjzrA/YKafV7L1dDa4SG7gFOUvPorzJQ
 DR3pW4EEJG6Uaxw9Y17n/K/QdcXgvko2GmdiWtcTJg1MUIoIvs9qMDnzp g==;
X-CSE-ConnectionGUID: lCA6+yPaQ3uhMDT3pokvww==
X-CSE-MsgGUID: 5rHWRd6RQ/6bXGs3TyI8BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71146059"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="71146059"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 09:32:39 -0800
X-CSE-ConnectionGUID: DWaE4rqCR+eyqeUpG4rPpg==
X-CSE-MsgGUID: g51QfYE9ReKcKT8ZTgQrjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="214754148"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 09:32:39 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 09:32:39 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 09:32:39 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 09:32:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnoe6HK8OC64QZEGmGkg740yxg81nwr1qMrcc1McaI62vy5LosmAeZIvfZWgdX7aaa1SCox3EURyxCfFM7aNmay/ja983uybXjeP3OiVVZaaz4sbueM+agCM5tdbeZCq+s6dWTNuxWHA2K2B2zOyph14WC39Tg6ha3U+8NkbDqxFyQt8CQjq0mQz+s8JEx+vVm6xsP/FC1/azS1B9sB/S2QzDDOJPU6RbvDRESh5+qYD05Be6FolWqO2kuCV4o29Qh8et4fL9BI5ZvU7nMoZv4RysddDssY7ixwuIaQtV850Hxle0VbbMTvZIX1vEDCpPOdKC3739WI6h4naayfpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sS5c7DWQRAxKokUVt0d8LkbJ/NPzrSJuLIq+TxLU+o=;
 b=r8i/x3wGPGkn+m8KKnScZqbTMGwZFF3e5AaEurkOwduWCyAilo0DM5kFWJUnokKnuH0h5l6Wt1OWXjeT4k7CJs9IBjeAGRguBwpilUSE1T73e5znlv7MDbkYQBJfo+jldtf6XmeoF8wuhSTjNhqbqu53Hi8rV7yh1PXlZf1+uDfL6WeTr0QlqdtASk/xKmu8055gviSvLnQgQO6KZqhKXZQ29RCq3GahDsv2tsIGyWs9bDxKNM2GwiOZduuygNXKFUFKOAUihVgi5Du6D64B0+0XqXE/XbDvbuPzC4S0AH9DUTB23Yr6Hp6dLI00uUENKlVMsw96EmIjnhxV9tY7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 17:32:36 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 17:32:36 +0000
Date: Wed, 4 Feb 2026 17:32:31 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4] devtools: replace checkpatches shell wrapper with
 Python script
Message-ID: <aYOCr5S3USrer0vp@bricha3-mobl1.ger.corp.intel.com>
References: <20260131204823.29363-1-stephen@networkplumber.org>
 <20260204165949.19709-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260204165949.19709-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0300.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::35) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 914ff193-c0a6-4bdd-1df4-08de64136326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QnI8+L5P5Yb+LptClUKkx4qxWll3t3NHgTHRmb59nsAD0MYgujbjMHxFYrju?=
 =?us-ascii?Q?0C3xhKcS9dxCk28QGYN0mYKEPOfvzHuBH9hDa/11N2k0jdWLWP9/lwE+VnMt?=
 =?us-ascii?Q?ycnQPzBoHGKn1//pvFlKDWeW8c65IZyXF66XCryHnSv/3VOoTLKDlM6LLPjq?=
 =?us-ascii?Q?TKdp/HgNxN7gD8cYbpB7b1I10u4BF+iHvBDR4vAUFOKEKt4GraCbeZRSre2B?=
 =?us-ascii?Q?WUvvIJmAWXsfcH269L3Betj9we9gX6pNWpTtHL0tNoCpFv05KivOlwWCsThF?=
 =?us-ascii?Q?IMJU3nGZtxmkr67CaHkVfaC3M79b1LmpV7ORcVJUZv1VaUqTzCrqyfbp7MQF?=
 =?us-ascii?Q?hwaGSG3w0T2Z37+knHkcryNyjNWjBu28zHC/o0XPJIkraegX41SWMIZC8JoG?=
 =?us-ascii?Q?ZXEdi7iqsuTDNyakdPYMUtiCWLqU968ZXAQq6iEWRpK45olqVMsVMsOInrkq?=
 =?us-ascii?Q?q+UjIiM4uBZyFlEjXXsmo1hZTg14hVnNtMVfZpUu6gAk5f2GvYpjO4r6kR3x?=
 =?us-ascii?Q?NQDdLuC1pl/m8zP4MEllQ4KhrJyCTjnD/d/WcdxV7c3OUshDIkXN7C/SyXl/?=
 =?us-ascii?Q?8t47VS9nZ6Rs7hsfNvRVvLNNLAVJ3Wp2VHRp1o0VMnPDh26b/X9rpHbJvDSO?=
 =?us-ascii?Q?1yxp56nw+DI6bZM71Iqi7zS+mkn3X9UY/BI4iH66EJptmkGjT5CSGfRfMwvb?=
 =?us-ascii?Q?P5yuWoYQp5PJVaaH/VSgVJZ2DwG6p3Sa6RdR7eOnIBM4wc12il0SZO6tz5jd?=
 =?us-ascii?Q?p2Ig5azykT16LTNxZKKa/zgbcM7vpcWrIsqgD3hXr+SO+tWYUqWC12sgIuDE?=
 =?us-ascii?Q?zDWds4k3O16cy0V7/GGsZnRDa4Kiz3iVekcKd0ffWEShowb0/WoJrWDhfxSO?=
 =?us-ascii?Q?oJMh+r0anc9o0rniSUTArAutf1kLNDBgbpFfGday3EywGoFb3M6sGhtZsPW4?=
 =?us-ascii?Q?QZFs5qLP89iJqMzNI7rGSD+Mj7vYGd9BK++98TKTPEagerVswYLWeUY8fap9?=
 =?us-ascii?Q?vjhOlc/o1evz3oDwYNLgx+P0AAmC5eElPhK7O6D7vWDzuJoDlCOwkTZEInZK?=
 =?us-ascii?Q?L97NZCVP2Df0bZCRLXWHu36SXkF3+MyqR3jP2MjiCdSgaS+UH+iRCrTZFmWQ?=
 =?us-ascii?Q?/fVBc+yWFlCTsCpKO8qwvfLFJrTMC1tKTAOKqB3v0DriVt4btiGiLkXgGgIt?=
 =?us-ascii?Q?Tylt2meZZGK/LYTb4fzCPZ6WvoIPgMW+Hwm6w0Cn3Atu/u4q5AfmCcYVi4ev?=
 =?us-ascii?Q?2NXDClwUkkwKxXtCMvd++z4jjXTAlv2n1DBpNw9Iv9Rn1L+3e00hafk2/O68?=
 =?us-ascii?Q?r4FE6sVihQnkHNFDt6Ocf/rqmvbZaGR4Ysms0XaySGD7FcP/Fu12wjMIlIm8?=
 =?us-ascii?Q?9uAc5I7A8/yrBdsvvzPtxGcJ6vqZ4nRd8XeJYUVaQ+bQePLvf0939K94ttgE?=
 =?us-ascii?Q?LjNon66XNZduHD3S1mQKN+1soQpwXIDcwxAr9CbakMTJzydJ4ffHlVApTzst?=
 =?us-ascii?Q?0FYYZCwdst6lixISd4Q82mpgNhdsvI6MkVxJ0LnuTfFfaGbIcGkJzRrl1b2C?=
 =?us-ascii?Q?jH5jiiGiS6zAoPhwePU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DhDru00o6XlaaOixfH/APgh5Wf6rGmhITcrKMbdXNDhN6zPwibuKf0Vb9D4W?=
 =?us-ascii?Q?bTP/fy+pnEhE+hzCtU5e01F+Mlb+oD51ZVnLaj4JYsZN92WU7wVqRMRsKPQg?=
 =?us-ascii?Q?Jc3ITV7vTdyecovKllCaCgMvEZRE5vcTMi/Vgze8J9nNNKjWBBHOHXO5GYjj?=
 =?us-ascii?Q?LKJAmCDzTv6k7byX6LhscGPKDgDhqP99GrR0DOUZvivXNLBC9f1XZ3iBqVfx?=
 =?us-ascii?Q?zXy1e4CNJVrnD0MV64Gi8bWcvM4WPVEnmuzMJzUnq7EpLM45nZgpi1vdcxCf?=
 =?us-ascii?Q?pUrGcL/XWesYLKbakc+eAAJlXwRRLHSsqamV0oGkFHC5+uwqpX1sBZYuk7YB?=
 =?us-ascii?Q?IrT8qi/+6H3HVrzo6bv7NhVG0hvb0hvQBlBowdCeiDwa4xgVqzhiS+CMr/62?=
 =?us-ascii?Q?nSK3fnlkyL0w4UctvMR43XlRb0I/Q5cpjkYfs2yveeQN0lyeO1usoLTvZjxX?=
 =?us-ascii?Q?Pj0eoTWjq71CWwo/KyoM0lRc4t93MKURafkdWkIaIWvlL5VxN5E/nLSfWaPx?=
 =?us-ascii?Q?z5h2r2kiikIlPqD29jMltlY+JgySVecX2H1G5M+Tz8lAf2iOf6FPR4k2EsWp?=
 =?us-ascii?Q?Rd3TdysQkt3/UUC8TiZGjLSloo2PW1f1INWu8/OU7/yurqppGq/Vsse3KAnq?=
 =?us-ascii?Q?L3bZM8dkDdiPicFj6WQcLlWe+6XKnqPSv/17qv/p/uzDwdCwpFqOKKpx16jT?=
 =?us-ascii?Q?8BDyGeKPHh0gJHa4QKINWkhhTxB9qphnjoYUXVZinbodQfz2phtXb971WgDL?=
 =?us-ascii?Q?PoME4kChDWJTViciZAMw+6yL+B2qdEUdaE6T3w6idKu7d6UmJpdNDE6HwPs8?=
 =?us-ascii?Q?dHL2D6grUUAQcglfN87d4JSr4B9CTr1qkw/63le13jGfAZD9mr1uzGzFXXRQ?=
 =?us-ascii?Q?dnOI5DSK7q7GyeVLyCWxro/q2ZrK31rznCztKnp13nvUbdHsF0+tjn9O1wsD?=
 =?us-ascii?Q?UV+Z96pO+VbudEi65DzeGirc+1jPP9ovd8H42vPkx20D/zo+OEi6InUDD5jR?=
 =?us-ascii?Q?0GG77DwtksMC3XH+UrIkLuO9HYuQcP2mHThJfo5Li5fv1jCC2R2v+11K6r3i?=
 =?us-ascii?Q?ciDrxmH9wlEaGRT9HwFUnCPrdehtd5Mj0P4xMQTrNjqzp6zBGX1OOyFs+ACp?=
 =?us-ascii?Q?q9k8RuYZKv8syGXwQXdGzgtjHzkraAe4ltbfyQyqHwzdoDDTEApF/S1OX1e4?=
 =?us-ascii?Q?RQDFKXgcGM87S9Cenqwc8em0dyhB274uDtE9SHffCvsRu/+WeNLovC1Q58oj?=
 =?us-ascii?Q?UF3fMEJD5zDIb+3vN/NxKe8FqRNCI4/HsXB7yFF6CX3FnwkFvM71gwSFJUXy?=
 =?us-ascii?Q?BEZm7pz1Fin5r7h2totEu/cHGMViIs1SpnMOJN9SOSD1jQrMf4rZgNFEUw/A?=
 =?us-ascii?Q?Ot5ch41vdw6ZBvQ5drk9uPtwTyhBOmfJrml47UmW4KcI7nlN6Kg1acI1OzZj?=
 =?us-ascii?Q?bWM5R1qKIeLbfx+M6aTNuZH64Y4jsqalNLEPlheylNy+4xbYiEIM01Ha4ThT?=
 =?us-ascii?Q?YKR6Eyl/Rx+W3sCZcW8NocR4f3M68y6wy9KROOyQGUejagi2rFgHsuaMbakW?=
 =?us-ascii?Q?XrjNMzhEdK7yhA8cn8GKUmrc9fPsMQsPC1kk+2swaP55fIVJXshMtn56x2Un?=
 =?us-ascii?Q?YcmWA956Q5UU/wvX1KXJ6TNhN+njKwgIbPqt3c2RmWCJ5lEM9KwDUCG4cJow?=
 =?us-ascii?Q?45Cm3kp62tCiG9JfaEQuYQIKLG6iFBR7pMavJlI49qpXkI/TS66o7/i1uC52?=
 =?us-ascii?Q?RtlMV7f2P0F/t23NUQu0+lkdS5DgpIs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 914ff193-c0a6-4bdd-1df4-08de64136326
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:32:36.5904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECtq4yeEAd1Rm20PucK/U5e+uF57n2EC6AtDLGYNxtCcdMlmch76vF5WUkFB2lNkQ2QiR0a9SqOg7GKuXm0zYGJFpzObc47YTsVJG3XbeIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
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

On Wed, Feb 04, 2026 at 08:59:17AM -0800, Stephen Hemminger wrote:
> Alternative to the checkpatches.sh shell script that wraps the Linux kernel's
> checkpatch.pl with a standalone Python implementation. The new
> dpdk-checkpatch.py script provides equivalent functionality without
> requiring the kernel source tree or Perl.
> 
> Performance is significantly improved: checking a recent flow parser
> patch series dropped from 2m23s to 0.43s (approximately 300x faster).
> 
Yep, it is definitely a LOT faster. Running on top 10 commits on main tree
with old and new script:

$ time ./devtools/checkpatches.sh -n10

10/10 valid patches

real	0m32.570s
user	0m30.517s
sys	0m2.256s


$ time ./devtools/dpdk-checkpatch.py -n10

10/10 valid patches

real	0m0.255s
user	0m0.214s
sys	0m0.040s

32.5 seconds down to a quarter of a second is a massive gain. Looking
forward to switching script for checking patches in future!

/Bruce
