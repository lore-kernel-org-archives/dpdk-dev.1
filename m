Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFE606A333
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CwgjokS8;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=WugDuW1t
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F4D8402BF;
	Tue, 17 Nov 2026 18:22:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 13BA4402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:22:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794936128; x=1826472128;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=94KfvTtzCjodiPMnyaBEdhRYDGL7sj1UXD+zA7dlQsE=;
 b=CwgjokS8r79sS6St9ZLNp1mfS+6xCIWA7SoQ4bybPwLHy8tftEuXsQfI
 CmV96WpKVWzwnG8zuQnT1FSQ4H30hg6KtNqwAMWk1sZEGtxWWO/nCViZE
 A/qFj2IbxHPUJZrLfU0Zv6iD7Av6O8JabbD4ADSpyzoIhULaDlOzQXm87
 JYTLOr+SLpBCCrvMtR1LbA6y+ZZRPn7LOiyUcDVVsX8M0SMww20CRQCUj
 3swIN+1azFsKPy27BajUPc1sALC6EeysR8q+sVk/bwoEA7ajg5qtlgZrN
 ONisbRt+B0OlCcDeS6IR2RO9rMzBdNYi4LZxM3S0rKUZC2pWJBisvcC2g Q==;
X-CSE-ConnectionGUID: vbyEHWYfQf6cB0osDPlHNA==
X-CSE-MsgGUID: jB8jheGIQO26r0473NX/0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3730795"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3730795"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 09:22:05 -0800
X-CSE-ConnectionGUID: sAGsqh09TvCGzlJbHaGY4w==
X-CSE-MsgGUID: YH0Qs2JETN2KzjoQMLs5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9967507"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 09:22:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:22:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 09:22:04 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:22:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWo2OuL2OawZseu4AmOz6VeBXFn0IuYOhEo+y3mH/srYRQZFIjD/6/g1WXtl0S5CoCob1GtIEAx9tZckwxrSgipiZtfJZxgFl8KX7gF1udt4r6mnra8tKVtx/l/9XWeFUyLCIMNCt4I4agp3zqX6f/V8LD5eN0C1oxOP6T2I/pjIkvrpi0i3vBEcW/tHSartLIP6/A7rb1yiFi2W1cpRXVpOJ8ggx7WOLr0jwITE4mOuDwnfeqInzAxcNY/6wRsIzUxl/Ni6hyDhyThZ8v/6cRpmakKk0q7Oc5o5NAnS9mfctCMBHYWmhse/YRi2Sq4XAB8Q98qIt5s3P1jPFkm1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lxvqe1SKac1joteKnXMCHByRCUaC2fdWOjgXouY2B0=;
 b=Q/0xNcky1T7lFQVEnXbDqEwBzk2okbJgEyIKT62pyjmqAIddnWeakdxEYejnZU1hNL3ix1+Vihbm8uUtwmQoFeMKqZLyT6VqhU8MGDhdqb3Aik7DzSEyjeXN7evexS7dmzMz+DHNUMz/Kv3dqUiISqqHO+qS1UGwQNPJKY6rtWY/cSU/f4IcD7x8fbvZcDVxtMbJ20taQmNjjkAzJxOPuTlVj0DtRDXiNZEHrG/kgfkfNbo+8CKTdWTZki7XgJtXganzKrBzLT39EjeFWO9yUc5+DVPw+hTP/SjisqfC8zHb86frpgDjOcSPHf21hgBuf1YoU3cWBgC8901DMWlNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lxvqe1SKac1joteKnXMCHByRCUaC2fdWOjgXouY2B0=;
 b=WugDuW1tzql7P3cLvUvZR2GNRV9ZbWARmiYh7ZfkqwtghvZuxYqODxGv6a4osKuV86ahXaWwa5KZP0Vq4t3I4Mjo3gsXSpJtK93nTIgg1/KPKhrf6Di/sliV8o+407xXyQ9u4lsaaOOdnvIAHBNF3XRbFx+QIJbw2A4dH8ccEAI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS3PR11MB9819.namprd11.prod.outlook.com (2603:10b6:8:364::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:22:03 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:22:03 +0000
Date: Tue, 17 Nov 2026 17:21:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [DPDK/core Bug 2135] eal: unreachable code warning
Message-ID: <avyNNcwSkwzkf2_J@bricha3-mobl1.ger.corp.intel.com>
References: <bug-2135-3@https.bugs.dpdk.org/>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-2135-3@https.bugs.dpdk.org/>
X-ClientProxiedBy: DU6P191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::16) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS3PR11MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3000cb53-3008-4cf7-310b-08df44cf4b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|56012099006|11063799006|261102123227099003|261026121527099003|261021121427099003|261022075727099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: Cx8TqOl0sxcm/2l/PB6lro0frtAaxfGdjhsW0/mFy8wrM2uZFsDOVJHR5qIdYMOs5CebQfJ19OqxVThQ7Xvm5DcabZna00dfcw7SaKcWuEyVgUzps1xCzAus6KdlN1NBrxn9y0gCqp9AmJ4pKvE92PMrviUi2bNmdn8JiOvG62kzJDm1ZFeLSuBcngPujOAopOn7RVXSMNTZNT74lCpTNGfjTmmdeqbeb+Pda/eQtB2DWqFK4cnkWAMNjOMIdZgm8Yrq+3C9his9eNZ25IxTC10YEVhQ5mEl7I+vZok4RrYf4RDcLJz+5A2830xp9dAkZaGmlzAsPxBKO0xSgui/Q/CNCpDo8SjFesWQn63pqSRTfInf4aj6hxaY3oBRLVcdf01CtW/x/qiOYXMJI6/qQioO/lxY90SB8YwpvOltciDpMUbLu4k6ARVropSt3ZIi7D28IIL59PRMs/xOqBeFFxhfxxxlrf/oW9oSi8OG3j8PiePR7+Mvi+oUXkRYMBe6y4Q8j9JXzba52vwLUU+1BQpBI0o//QgkmXJ/1G6dqatLRWNeunQ/RHqxw1tR98vlFJgmajvUAqfQVlVI5FtzbDswa+GwK6iu3fbagF3V93s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xsrWlnK/K5Wg9eS3uwtPhlUh85RyFTHXo1WnmoRaAyou4n9JtTYxTqz3bCxh?=
 =?us-ascii?Q?Zok/nXRfSt+SLH0P3t3uWfqUqd/RysaRf1RPqwK0NaGbN1m1OGFXXa3IsoT6?=
 =?us-ascii?Q?sISg7msCfJqwH6yQpOpWEY7HCfmDbubks+GUXub0jrOhVlcHBPPWdwNAh0W2?=
 =?us-ascii?Q?xfIzxifMhCfo1JN7DbhtVnaWYrE/9xJr3Lqs3qrIPjxbMestbyryJ9lX95L7?=
 =?us-ascii?Q?/P1eJWxsIfw3v44sJ4lnnVIbX9s/47V6O8cCc6UTlLBOhh1ezKAO0/vQtHgf?=
 =?us-ascii?Q?5v+jGee8i3n2dYdY4yiSrzVJltW7ZOH4NcmMkUQorNhQ7GGqdCV6hds9B8+J?=
 =?us-ascii?Q?OWQbADsPu0/dzrJWXFqA9Imf5SZwtZdA0eznrDuhuBuILeN6W6vp+zYn89sz?=
 =?us-ascii?Q?6rs5ZpPcstYOoOZE38QE3eStzWsELhSCC3zQFh8VIQT3jPo9eGXZFRnHytKZ?=
 =?us-ascii?Q?GoALaefBg9a76D75f8WYfeOu996rCA9ivFCbzlMPCr3MUFPOXARArhz7e5/P?=
 =?us-ascii?Q?0xXStgB8vxxL/dz4CFQ+zii+sT/ghQewoz7xEzoDEjq2vX6K7aAgNihRhKWm?=
 =?us-ascii?Q?K62daDOvtw9tRlfBzkujJuGwOmLM1oTZH58ciscbr7wdMnNOxik8ySVa2TPY?=
 =?us-ascii?Q?KHXZb552PyA7o2u6n9D6IsiQVSxBr5NUnflCFI4x2uGLOlkzlVffSAxDvcUw?=
 =?us-ascii?Q?Pv8n0zYgfRK8WxDfpqsPMxgU4iPuHDLd33QuKQukVS4kpAgj7sEA8OblYcAy?=
 =?us-ascii?Q?FHMJqzYGAw7Zcgv2hPQ5xpjp34q3tsxYCAWdRY4uQV5u8kmIyc+bj42Tf5gn?=
 =?us-ascii?Q?eoVbYUN8+/0K+scuYYVc2j7cHf3XKU48XKvaMIMbvVI8xGWgW3GdqCDalncx?=
 =?us-ascii?Q?d2MMDN3pwDe/L1usP0PwtSWItC3sKFue0NPeLt7qcKkCPAdE95kJsVOYsaPJ?=
 =?us-ascii?Q?muKhFmPuJoasNeip1j2biJchse8UsTXjklWN4cy8e/1DQMriC8fphtPawnuK?=
 =?us-ascii?Q?rfj92Ib50ii+raT1n8DQekjPDwYzu5ovbZkq5IqzN+EqmRRV5W3RlgTV6nLJ?=
 =?us-ascii?Q?mzw0fakdWljVHLFSA+jUFoUqHoF9D/Kw3fpU5o0tzn2RpOEyRUlPB/z1yYrd?=
 =?us-ascii?Q?zj70kjaWuYPnq0Nk4kHJKxNZmRQK4TB0VhCx34rbSV0MZ/RGYw8ggUaFoUtX?=
 =?us-ascii?Q?VAV3a5gDQgUxY3S2W8AgeSe5nFkUDxGTM9uR4+G7GCeGA3H0DkP47bWEOjAi?=
 =?us-ascii?Q?6IZKNQmkVAisJEbLaoNnal1zriqyy5KlYnE90fEqrTCLgADuMj4QdXWWCcD4?=
 =?us-ascii?Q?q5krYQGAe0k2Pr+OtRNdTZvusIV5xGUJdBO86Iz/R+JLVlH5DKkI32WnXRYN?=
 =?us-ascii?Q?WcuuDRn3oPUuMAY4sKQFeee0VTXV7imRkWPtiHSqV73MiQnUD0eEs8ww5GKH?=
 =?us-ascii?Q?wYCsgBr0/fUuQC1j0SmID1BYGvOd8QyMJEee+/vbltraRR+R3L49Q87TCGMx?=
 =?us-ascii?Q?boTw7nfWJEonI6rifX9O9Qc76asqbIIoqKmQiKfGFZiODSDMhWbMURPKMaDA?=
 =?us-ascii?Q?9F74fv8kriM7C6NRIWQxIlkJP4N8ii8hLQSKXM7R+UiywtNXQVhikuLcuoBD?=
 =?us-ascii?Q?XsZrjAAsEOUmZ+US2EvKBYYOOKmBsbkMZrDLR5a52wm1WaCCUIF67yI6UkPj?=
 =?us-ascii?Q?5gA1TvNORSNg+o7tiCEEivrt6sFKXso9olPRa2Sigvh5rp7iYMUII7ecmNxJ?=
 =?us-ascii?Q?XN5tb/HynN5knBVbC7iNiAGH7pbp3mc=3D?=
X-Exchange-RoutingPolicyChecked: Vj5pP0blx/NesdnlJYX319cs5YcTcpCixPhCuiBRblogrnU5uiZJczMpS+1uGhYHz6NZWU5rY6pk2PITmQ7sb2CVPeOT2WflfahYja2+nZxD5gGL3O3hcHdUQiIVVACO8ouEro27qzBJ1+/hCqBD3SsBg8BWBSbXGpBhmWSUVFR4CCK4m8C205eOjqXWCcZvXrBUOkvR88PiKxPsxDyGcLXzQ53ntzT+s46TIFmKG1QmpeWo4hSRklSfwzMzoBBK21myFXG7C5Q72gQGl69hLm+7YNiO3U4B2bGa8V1kWcFNRNEhuOPDd+Mw5L77qTEzLVl4Xn8nxOmt6dK/tQeRbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3000cb53-3008-4cf7-310b-08df44cf4b9c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:22:02.9743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jY3byozlNO+mJoGg+tyIl0hVmQdzNmEBGdwaWXkTp+SA9528FBht6wCPd79eP4Yng+zJ5EFbl2S8++6t9ExKI5fzcVoABkX07SuuZgqnig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9819
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 05:07:54PM +0000, bugzilla@dpdk.org wrote:
> https://bugs.dpdk.org/show_bug.cgi?id=2135
> 
>             Bug ID: 2135
>            Summary: eal: unreachable code warning
>            Product: DPDK
>            Version: 26.11
>           Hardware: All
>                 OS: All
>             Status: UNCONFIRMED
>           Severity: minor
>           Priority: Low
>          Component: core
>           Assignee: dev@dpdk.org
>           Reporter: stephen@networkplumber.org
>   Target Milestone: ---
> 
> Building with clang and -Wunreachable-code finds this:
> 
> [18/3982] Compiling C object lib/librte_eal.a.p/eal_common_rte_version.c.o
> ../lib/eal/common/rte_version.c:40:3: warning: code will never be executed
> [-Wunreachable-code]
>    40 |                 snprintf(version, sizeof(version), "%s %d.%02d.%d",
>       |                 ^~~~~~~~
> ../lib/eal/common/rte_version.c:39:32: note: silence by adding parentheses to
> mark code as explicitly dead
>    39 |         if (strlen(RTE_VER_SUFFIX) == 0)
>       |                                       ^
>       |                                       /* DISABLES CODE */ ( )
> 1 warning generated.
> 
> It can be fixed by adding parens, using sizeof, or useing RTE_VERSION which is
> already built by meson.
> 
Not a bug. The code is correct, but technically one or both branches are
unreachable depending on whether we are at an RC version or not. This
construct with dead code I still view as superior to using #ifdefs on the
SUFFIX. We can't use RTE_VERSION as that's a numeric version number only,
which doesn't include the "rc" part (see definition in rte_version.h).

/Bruce
