Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368E9E9D41E
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 17:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20695402F2;
	Wed,  4 Feb 2026 18:29:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 88E5B402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 18:29:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770226167; x=1801762167;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=reUr5Co/bA9HZElvQUvpOsaY1TAaW/bGJO/Mwm/wGOg=;
 b=hDrzoDjdt04R/unS1FShSub7bmlkXmZ1eDqw1ftoSpBERwjNa49JtJ+X
 /ZfAGHGeoI94KZOqFCipXN8P/NrOifjVZj16fTTPlFm7ZMHApD2HFBsbO
 s+gm9/zC/6Q+qmKOqk6sEo0vtI+e9kqocK8yUCvVnq7O3BltzMwa6wiHJ
 3JFibuc0p+/A1OlXJ5lcXMRhRELYYzT+Atzrn6LvVhFS3kOrHibTkTq+2
 DTzxyaK/o/YnOfvr+KXj+3vRszqlURaTQ83PukAE4fR7M2CrNBDGYG24L
 OlfBQ247aSgHSzvnO74vr/1t2XGI7yvS8VktXkxWzazLPMfurcr7bxx6J w==;
X-CSE-ConnectionGUID: ozpnB7QtSeqTLl9WMx2x6w==
X-CSE-MsgGUID: aHucDBkRTIKUUlha/428AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71145663"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="71145663"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 09:29:25 -0800
X-CSE-ConnectionGUID: AVYObg5gTMGWIGLWXVmqFA==
X-CSE-MsgGUID: IH8rBFSOTUygpLwZ8B4u1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="214753143"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 09:29:25 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 09:29:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 09:29:25 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 09:29:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDG5pTChtV7l3MWbsguOcUxu0QvU7cVx6ZkIvIWHxftPhxYIkGrStOeiQtrO/F/BjGBWeENHeYdkYc94KS4v53ZlyTLiRoQRenjR5MqEg5AsrgBQxDt+XEKWZmN+vtMYoIFjmCgK3Ib6tiXHRJFeD0ZO3JsoK+ERrPhDaKTe9OVaUIoMNfpb1Pf2/K+aLBp+yPvCtq7VxDw+7CC10DylRwugX+cZ0I0Q1Laqw3m903bR6iJ+++vEzGs57SSXskAY4BeFjrXNdJ/lzF3R5dehR+jSUP336Fk4trBC3CGQ+nCrQ7pBv7j5vHYFmryJvwBoblxh7m0eh5d4HJPXvkxArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbxHbixMfnL6Gm06uD1B/bLVCiGGwxn4PL9vg64jTos=;
 b=IeumuS9yVabKo7Bwvg0ZFrbkLOGJeByajloh8waumfqk4d+4/EDxor53CdWlC2mWm7hmYjiYsPTy/EOon5vZbhNB285FzMz5JRiwoWTKn8RuCFq5d3rMcIw/vjAaqOi2EDiHy5F/fPY6wBSOoClW+Zdh+rsYyZXfd0OMUsCp7ie+vtIEqjhK4UESLmq6jGL9726HqAYMu5ujhOooV70HLSoNh9kuZ/ps/Am3QKZZodW0GQM+kX9ZSPDvjdJfhT7XGkAKsAH8SIHAQs5wu7dBZ8k8KL0RxsQHWevnXQg5pzRtlJRGxECNLsLdLUOIrOVUE02NPrlorMzHQUS9fcMVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 17:29:21 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 17:29:21 +0000
Date: Wed, 4 Feb 2026 17:29:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4] devtools: replace checkpatches shell wrapper with
 Python script
Message-ID: <aYOB7GmQhiQ9MKVw@bricha3-mobl1.ger.corp.intel.com>
References: <20260131204823.29363-1-stephen@networkplumber.org>
 <20260204165949.19709-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260204165949.19709-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0015.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::20) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 63deb147-0e6b-4898-402c-08de6412eea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xy1m4UNpG+GK9Jv2MvDZuJaW2o6c0p5uFw24Tfc4kO6HUEnObizcem/5Db1L?=
 =?us-ascii?Q?37/OIKaDMcQ1b3q42w0awpWHzyXGe+Sk1rTXJOkjkp/OajIF6gW1ALfwNlPB?=
 =?us-ascii?Q?nVw8PwSTaAwIuWXFROvpYc+klJrejZyw+dRPCj+zdddoFuSYjFwj8SEkiSXi?=
 =?us-ascii?Q?5FmLoO6BoI9LTj/dCfMmRnEHen726Rod70q2uoQipCRhVwZOhTeGx/Z1ZZ5j?=
 =?us-ascii?Q?6s+tKbpdRAPCMIBXFl5GyrJB1pzoFfKcalk4alKag33pZ5nyhwqz6CIwgHtF?=
 =?us-ascii?Q?aurZdX2LOioi1u8z7oXr3m80OdrR48S/yKI/Vvj5m+339BJMhl5L6+Fv64LR?=
 =?us-ascii?Q?6+SI3tU6im8Pm5E4rH7Wsc8gl5fbqKc6k0qgcbCbpFzKOPKsfQskfE2t4rN+?=
 =?us-ascii?Q?AABIe1hsvvqTc3a8A1RzWUWjpXPBmaacMP8vJKbSTitnKGBgB2YsxMoGYv8y?=
 =?us-ascii?Q?UhAXzCDeo6uzL7RBBYsepwmylSY61HdGJ/ReLWNQSfoUYvoVB/8nFIlCtxJY?=
 =?us-ascii?Q?uDBNQG/a5e+Wm3WMUFSK0mBVV4/G4S/uqsAbpMms46EZEQbiiZt1DYW27Q9t?=
 =?us-ascii?Q?GBJup2//RgOFpEU7gzacVA46X9rzQGUYj6Njz5wLYbXSReNHyFBXudEyUPTS?=
 =?us-ascii?Q?EUhMfktAqDKuDZf46WlLLVvdVpwRsFVx4nNzayS+g+SpNTp9YPB71+o1/iB4?=
 =?us-ascii?Q?MSjBbFwOcECNh3yoNW/AkWXnjHmw9X30OK54qc0BBYPOZ+let7uj2Zihsrk9?=
 =?us-ascii?Q?fCf3C7MKXJmctJH7xbN7pNHZPHkhr8iDZJcTTruiDJKCuUecdp27Vs02UUII?=
 =?us-ascii?Q?T+G0wyteUi3qj2NmhnHNJe83XzE4ZHn1Y2+wc1s9zN4VB073DDm49Fv2VKMa?=
 =?us-ascii?Q?6/SRCuew8h2Oi/CGG51C2gvp5X2+zyMi4GF8skS63wF9BfAvOfrUCUsXFIgn?=
 =?us-ascii?Q?/rcok96/ursw47LAQMUBJi3yhr1lmyv5IKK/m/Z7pv73v91YPItuIbPoUBLV?=
 =?us-ascii?Q?ggqzdImUsPMSfMbLObhve2Gvb4ZDx8tBrXAhEHQUKiujo+4faB8zN1KzyZTy?=
 =?us-ascii?Q?CC9z12kiZ7LLeW1JHYu2uqjT0zJ/nxJicK3wa9Rd2XyDm18RIpnst1whv6Yd?=
 =?us-ascii?Q?ssxKv0of9RKBj63mXI6AjMnwVk1/2uToItG7obShAXMx4Qx0CU0yXn4C2ZYo?=
 =?us-ascii?Q?s02i8KrPYMmRCvcQ/SqzeRkl0RCVdFJtWbFUtwIeQTpQLNIcCOsobebt68iV?=
 =?us-ascii?Q?+mtcoC5NzpBUOA6RIFp4H8FOI3VgJPh3xEJgywMZNLSOnJAwF8ccD4kMpQlK?=
 =?us-ascii?Q?iVD4p7rcNvm4lCBuWHseKFmxPZ9DZEFQy8qGkDXDYF9Avfh8d0nDA45kKAHC?=
 =?us-ascii?Q?zWZ3lGbjJfPK6Scgo4tK3zpnyXkTXwunMyecQ3HWPWjI2OwFrUFTX7TDcmMm?=
 =?us-ascii?Q?hSxZsRbjLe9yjfXRvjS7uh0wMb4O7SFGvy/VI4EjoEJflUM6uUz8Hm/OZNJr?=
 =?us-ascii?Q?IG+bNPGPYzuniKCH02C98HxOFG0g+vGmTZukYByGlrmcYOATG/zLb0ivKVcI?=
 =?us-ascii?Q?qn+KjlqVcXusn2gdIrY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aufuWnm1g2eSukITg8fFwtDGzwNMl8vhDroaY5qQL7z9ucIghqSn12H05vSE?=
 =?us-ascii?Q?NYfwz0x0BoVmGjJDqRMB4YWu0ndcIfvqB36mLJ73PZNosIXiRDiY6njKLUpJ?=
 =?us-ascii?Q?W+4TqpWfv0RGr/deSMR5XrYMuA2CC6LIP8uQHWiDKdbZyW8bJiSF6ItOcK5K?=
 =?us-ascii?Q?Zit+YRtYbUL/uep9LdKnBC66bfR7CVf8C5VN570wQwaLmsBV62mpnxKku37u?=
 =?us-ascii?Q?OO4pfOXMbPIm11oxs4KGHTxX5THPKSH2ne9mRQqbX6cvKxljmVGFVs6RJHGY?=
 =?us-ascii?Q?hHYxEMF0Wy1ZqJxpWJmL5zmFShRgG1OhIg0Ik0MNB23ZjvLXGpUqfkr4+LRP?=
 =?us-ascii?Q?deNJkWyCnAQkAhSC+sZOx2n/rob+nIDtGD9dr+u/X5qrsp5iY0tSDO20JHJ5?=
 =?us-ascii?Q?c6g9cDGSkmxZjUmSepxFRxFtefFJ1tMt9o/0IPQMtd45kLhI7wuXLgxD5nqc?=
 =?us-ascii?Q?mIEcAtKFtsh38bLp0r3No3o0Xm4tEfBnvz5dZg4k7bj8mD4A7RNSt9KRhtF7?=
 =?us-ascii?Q?ZyhdIOlTMrTWUo8zQUnHYx35T4xxQKjtMEXEG12RkCsWP9u6yWtCcRge9eBX?=
 =?us-ascii?Q?Ih4iIp4IjxFJQU5UlAISQqQt4hCdRzmUDbM3+davdNCV3Ora7De1Z798xjkH?=
 =?us-ascii?Q?o76oOB1a6wroUwI4ZT+m/x/rPfseta+htQJhfiFA+GcffAI7vPQQ3Bb0n/xW?=
 =?us-ascii?Q?tY4KR2wWtF0MZWamzULHa6P7/Cb9SPjomQpy19iV66zPXl31EQ4TIOkEDsTX?=
 =?us-ascii?Q?3CvbkRU+gzZBt+lv6C0a5SU9sKeR6qK1CxUiEd/NSAyebxZv+rQDm/YPgXH9?=
 =?us-ascii?Q?GZtGzM8DY7Cow6oTzhQSaYL7LxxB6JCvQsc1Tn3Hf7oJyfxpo9ascH0qk+Er?=
 =?us-ascii?Q?6hPYuDHYRrbES4EpZW5A41dTpaIRbdUVfdKBRGgmbLPP05PQKwHXVuIrjQpE?=
 =?us-ascii?Q?2y0Q15VQcGAdabyJZd94vwqQTTlVc+E4D9z14lEEU2n4jjog0WArTIjzhZ9+?=
 =?us-ascii?Q?ZPdEzPT+DiyL8M2pisiMKz5fcMZN0AEZ6ALvlXmC/f5t/sn3UGzXimCQiVdg?=
 =?us-ascii?Q?DWHf4tIHgmClPOxK0wV//EInFjrcBYWgM5wLpBYWmSFw9nf1gaDGb3IYoCdj?=
 =?us-ascii?Q?6Rj4nYzKOKCfEzuj+7CC2iHEXT80gYt8iQMIIGY+R6939QYAnhgj05s+5rNb?=
 =?us-ascii?Q?MyTrPiFsMYMDj83auA32SdEUjZ8iqHT0eKlhwB/XLWBcGZkie8wRxcPJU1bp?=
 =?us-ascii?Q?Zyky7gbsPXYZ4dUul+PqX0cZto9j7+RI7NIOpFyprdb5z3zvhArlZZUf/SJz?=
 =?us-ascii?Q?BIo42FwzHCevNTTAsVqseNADE2Epk2legeAF5NT5iWAtzm3OhYqI8OATNeeu?=
 =?us-ascii?Q?yXrDwvXcCMz0rs/4Ly7GeD4sRhil9OEAptfZ7+sTVqSgPTCKkIRftEU8dmDG?=
 =?us-ascii?Q?ePSeEIeSjHpDUMRFA/4C0nwytbFVJPre6DKShJ3mzUIaIhy1ksJDANSV/qXs?=
 =?us-ascii?Q?EGeyrjli6t4nj76v2U8Wb6W+2uQN+NuGFktr/vF5qpjtIegNvxaKJ3RFZieF?=
 =?us-ascii?Q?GgDclE/lRgdmKG7pOIfNTQA25fVVFhqX/FY8H3mOwUnRDmftNfb5vT9SdxPG?=
 =?us-ascii?Q?NxDFc0+tKibeEPgshh36P8tYqIsOy+NM1IjGlNQvKhFkkvlIrn1gTAj4WIR9?=
 =?us-ascii?Q?YpylruhtUFIYoWdT5PIn5nlGZZDjbqPnkoKCCSi7K5L5VvzG9dHe+BvRuY4O?=
 =?us-ascii?Q?NaRsRNprSgEDJyv6dSO/tidySYu7nVk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63deb147-0e6b-4898-402c-08de6412eea9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:29:21.3100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htsWxuYGvokMe8FKPSKc8DqUHQpAQIkMpBPgCTFotvqIVk9+0xc54RvmyTJsP8rssqCxXsCyETWczyk3ZTJRpSf29riwKNFZdY7LVekzflg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
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
> Supports checking individual patch files, mbox bundles containing
> multiple patches, git commit ranges (-r), last N commits (-n), or
> reading from stdin. Exit code is 0 if all patches are clean,
> 1 if any have issues.
> 
> Kernel checkpatch.pl compatible checks:
>   - AVOID_EXTERNS, UNNECESSARY_BREAK, COMPLEX_MACRO
>   - STRNCPY/STRCPY, RETURN_PARENTHESES, POINTER_LOCATION
>   - INITIALISED_STATIC, GLOBAL_INITIALISERS
>   - TRAILING_STATEMENTS, LINE_CONTINUATIONS, ONE_SEMICOLON
>   - REPEATED_WORD, CONSTANT_COMPARISON, SELF_ASSIGNMENT
>   - INLINE_LOCATION, STORAGE_CLASS, FUNCTION_WITHOUT_ARGS
>   - MACRO_WITH_FLOW_CONTROL, MULTISTATEMENT_MACRO_USE_DO_WHILE
>   - PREFER_DEFINED_ATTRIBUTE_MACRO (using DPDK __rte_* macros)
>   - TYPO_SPELLING via codespell dictionary
> 
> DPDK-specific forbidden token checks:
>   - RTE_LOG usage (prefer RTE_LOG_LINE)
>   - printf/fprintf to stdout/stderr in libs/drivers
>   - rte_panic/rte_exit, direct __attribute__ usage
>   - Deprecated atomics (rte_atomicNN_xxx, rte_smp_[rw]mb)
>   - Compiler builtins (__sync_xxx, __atomic_xxx, __builtin_xxx)
>   - pthread functions (prefer rte_thread)
>   - Reserved keywords, pragma, variadic macros
> 
> DPDK tag validation:
>   - __rte_experimental and __rte_internal placement
>   - __rte_packed_begin/end pairing
>   - __rte_aligned attribute checking
> 
> Expected differences from the shell/Perl version:
> 
> The following checks from checkpatch.pl are intentionally not
> implemented because they produced false positives on valid DPDK code:
> 
>   - DEEP_INDENTATION: tab counting without full brace-nesting
>     tracking flags legitimate patterns in switch/case blocks and
>     driver transmit paths.
>   - CAMELCASE: flags standard C macros like PRIx64 and DPDK
>     naming conventions.
>   - SPACING after cast: flags RTE_ATOMIC() macro as a cast and
>     flags unary minus in (type)-1 expressions.
>   - CONCATENATED_STRING: flags valid C format string macros
>     like "%"PRIx64.
> 
> The following checks have improved behavior:
> 
>   - AVOID_EXTERNS only flags function declarations, not data.
>     Using extern on data declarations is sometimes necessary
>     and does not need a warning.
>   - COMPLEX_MACRO does not flag C99 compound literal macros
>     like (const type[]){ ... } which are commonly used in DPDK.
>   - RETURN_PARENTHESES does not flag return with casts such
>     as return (uint16_t)(expr).
>   - TYPO_SPELLING excludes common networking abbreviations
>     (ND, NS, etc.) and Doxygen tags, and handles contractions
>     (don't, couldn't) without false positives.
>   - LINE_CONTINUATIONS properly tracks macro context across
>     patch context lines.
> 
> Known limitations:
>   - BRACES check not implemented (requires multi-line analysis)
>   - COMMIT_LOG_LONG_LINE not implemented
> 
> This script was developed with assistance from the Claude AI assistant.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  devtools/dpdk-checkpatch.py | 1381 +++++++++++++++++++++++++++++++++++
>  1 file changed, 1381 insertions(+)
>  create mode 100755 devtools/dpdk-checkpatch.py
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

A minor nit, but this could do with running black on it to reformat it
according to standard rules, and to limit line lengths to 100 chars.
(Running the script on its own commit throws up long line errors as well as
a bunch of false positives)

