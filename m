Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76993CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 16:16:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B501B402AC;
	Tue, 26 May 2026 18:16:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E981440290
 for <dev@dpdk.org>; Tue, 26 May 2026 18:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779812212; x=1811348212;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wq3LEl/6OL5qJYy7K3arRa4ftDZE7xuoBlQGwe46IZc=;
 b=jMbX2MmTruvzjvC3fLseU27/S/1qjg1g6oy6jx0c+8USHBwhrL+32vX0
 ZPhPO+uePFbotGRgzJQ/8ZPkIVNUG3kZQG/WZtBxSq+uv9NE5siqWxUow
 tzipOx068HpewkeBssCr5vFZylmmOjpLZ+nJwcqjcEcIm/GEGhrW+fSa/
 1MXUmmNr55NpecABKV1LEKOUfSZyCKlmtEKxEhTFJRtu0vZd+buuHPKh2
 KcoyKJ2C/u4ZnEoSbIJZacJvQoUsKJVO0SFW1ugXX7/yTYzAKzO1G5Mu8
 Pt2OrmF0S/1TpYUzxpeYfMA5+DPrehh7lm7ChAq4X72XOj3rx5ug1iPJY A==;
X-CSE-ConnectionGUID: TfyOP7/GRMiWP6Tr7ABhEg==
X-CSE-MsgGUID: cUeJofd7T+iw3kfZ5EqYsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="79665944"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="79665944"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:16:51 -0700
X-CSE-ConnectionGUID: +dSCBlzRQSWecBiAEmGckQ==
X-CSE-MsgGUID: wEwd+4H3QvGDjJsFCiBbEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="237796931"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:16:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:16:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 09:16:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:16:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoToxUcrF2pF0rINAcrwrq0+d1vAzxXD2AIdYPeGFzmgc2YGjP2Kt3eWDEz9HlVCBPIFC6P5kokVnCiq3WLvHVoR9u9htQ1hIfv8LsEO51CaMnbe27ELHRMDA6zNV8RJVoVSLU8ZvV+u+WbCWNOgd4/1Xg+pZ+paMKDqsLSLmLPuwcrBYNxFDij015ZkblyeMIoYoZzr/vuNCTCLYYJ9pMojzyCs6Oa4Tn+9tWSvOsArHb8k8hxDlk9Da+U7wXn42jqXAjitsqfeDHrzrHcH6W1T36HkZ2kFsCmpVJWwx/qbCHe1LPTZts875EP0M+UTiPERc18O3TJiuogF54RchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8WFS6aaIGkLbLpfyot/v0V1xmZGKSdm/gz6Ztycy2M=;
 b=lE6qLcHE3+ePULC1HLrX3B9q5FUmr400ko+e4BDVQDZZy+1NQkgrJA7osgAe0RAuXOZtjvjd56uxI/+Zpc0LHWrxKIT6R7HOC3yOA99+/ndOvtqsqRwR2p4yt6D4N0bjYOvBeSRSGaEP0s+QyHTEliRTLYg8/EJeDkqiz/LDLcwMJOwIqfADyrnWndTdWoJD8XLmu1DgYqtIAbz0Out/IXn22weMTxsdiHZLMBTYWl5PIovFSjcwu35KXVNpnyVQMNxiYKhcTkmxDhPDvaAhKAZZJNcHo9Dm0clywu5YwFsDlRZjvRp0Crlpy4sT7OTWfiYBdb7WKAGVboiGQ/L1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6657.namprd11.prod.outlook.com (2603:10b6:510:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 16:16:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 16:16:44 +0000
Date: Tue, 26 May 2026 17:16:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 6/6] eal/memory: add page size VA limits EAL parameter
Message-ID: <ahXHZx25kPDmjkMD@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
 <968ab78a3f7bd130287e269dfe82a3481baab161.1773417833.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <968ab78a3f7bd130287e269dfe82a3481baab161.1773417833.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0280.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c819ba-6382-4313-5e9f-08debb422dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099006|18002099003|22082099003|18092099006|3023799007|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: xhhpEhzlc2vPje8nMePrHGAcwFMYLHA5BVGTA6GTK177eh+D1ZP/X8wXBl3RiaZ2l+fbK6QgFb1yFH0gpG7ipIcykbTExXOTJsJSmyLvqJKLdz/cKgIIi27J6zR1EeEMNBkkkxX0O0tPuCS2nnrXvPKvGLJdEMUJFq4c+8FHI732PpfU2e3/L4xZq8pCj6Iw8JjIrTSBTobpVerYgOypZscqozdQKS3geqF4Lvi9GvJA92WeDEfX6T+fRL6VXpOyiTdGLZ34e5SGgnO2v9fckNJlF7HQIUPwrFHvByoesU5c7Wi96M3lo+svRSu+t0Dzy/0oj40qKklPGDsSVrPRFiRmTPrjiaJN17ZVCKIN4rSx1iyncrs+hHC6dwpPfaWZFk3UWAQBHcQ8BZAowFBr9MkQtePdHFMk1bYsSkJE7LwhJrktdfLqg12M1tbeuqZcvFLXg75HM4XpahHNvuI99h5+D7sktLULiAddL8zvGAM6PatvMuCqUq18gXOxIxbRQ0uXk5CfesuhG1BoKCnGgL5XWb5sbl7dNWHK+zyj4SuEomBjs8azz8tgrgLVbM/cZSgfvRjG2i2qLXR4P5V+sjeD+dqfv8z0RdGzs01hQIZits0aH1PVr7isnTFxQkiizyPBx7s9YNve43H8YzSP0Q1wSRY6OZTDRtYJyr/0YhNpAn+ULEzmytyDlptKkwg0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099006)(18002099003)(22082099003)(18092099006)(3023799007)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/WS0QUJHWUl4PUorphrsDZw0KDVWksyuc6llvq0juEG54o5iNtUInLcZptF2?=
 =?us-ascii?Q?Eq024jic06KKtRMHENwGHrIlGtpxmJOMlUaRPfVsq2MxkDzz9vOQJtA/IYaG?=
 =?us-ascii?Q?NED1GmncYwld3vNvmGLbgL+/ljYN4QsU+8SnaRyAb1D+R3zFN4zD/xUJymgC?=
 =?us-ascii?Q?n+qiJYQkyRLXW8D477V5n6dPSIdsm4elMwx1NnF9zPfejPg3AMTMsFxw3Ji0?=
 =?us-ascii?Q?ipw2e8VYV6FJ/JlzHIckg1/cVJiJrZNCfVE6ZOUQciBZeC9GC1tCq85gavZD?=
 =?us-ascii?Q?0VC+C0CFQrRigtE0sCZWluj9YtFxZpWhfWa+pIc9ad0rM3jhiyKoxEV9RTrL?=
 =?us-ascii?Q?9pF3ffl7gqmWSV8ZOXZxYiJx91qdtvhhciLN/djw+xOO8zCp729QuFjzKxhr?=
 =?us-ascii?Q?GiBrXVCnkXKUWa8NrrQ7EfJ1sRwMqywQFyOlhcGAcYqmxxyZsCr+UijpHKNM?=
 =?us-ascii?Q?tZOQPdfQDgTzBOb45JZq6stkuuKsKlSHsqvfTmNSghq/JgjBDBOUtdlJ+FTF?=
 =?us-ascii?Q?dSPzTmj8qp1C34S1xi+f8OzGhyI4ezx7aCOqZpqGNqeL7w8kNhaL/1QP/QQM?=
 =?us-ascii?Q?VFKvlzMCLX9czlwwUuBKC2sDOrc12R07dVYSMGk6Jf0zdEmx0bSBDpDytU2j?=
 =?us-ascii?Q?eV7iKVhV2VlpNWtSTikmpwGQhOpIf/R/ioHOoeeMakoC+HWso/C0/9ZqjlXA?=
 =?us-ascii?Q?vp7+KJh9y61RviSevyzG30l7eloPFaqa0SqnQGPayU2A0+LmsgLAwqAGpgw/?=
 =?us-ascii?Q?/UuV+Z86g8s5Ct96WXiu/0pTN3Fgdk+OYOTe50KiMHwwx9pO5w5ybZildI0v?=
 =?us-ascii?Q?D7pR0Yg2MlM8eDdfkVIaYko81YSpGW+Sdf1dkvw2sQzusc8uQsFGsEnvForB?=
 =?us-ascii?Q?eFP3Qs+Ahljl3/vOUzA596To5SNW42Sl7XBGvJCD5ofnR7LUkkZ+tfFUA+Bm?=
 =?us-ascii?Q?GRnLrc5r+ZOvaz34Iy/C+GSW6mtelL6BT1hoy6q0pfAx3ZJcRdFVut7jCGUF?=
 =?us-ascii?Q?FRQRZwil+5M9f3eBr6SxqFKs6f57DAnZT6fez7t79/Btl31hftLtbloKstMS?=
 =?us-ascii?Q?lR1l9Kv4VAoOEdRFNWutmWqDPWjQKJhR6JYTwavKHU2o5ly2mUf6S268zmrY?=
 =?us-ascii?Q?Hs6I8wJj9fdSk23Zj9vSQXNO6qEpuBhm30jF9R74jr5nm1I0zmOk4OPIB8Kz?=
 =?us-ascii?Q?kQOsp6C1zXEkXMNj0wCHO0vvlGFgu8BDoOB0u7Bd1j3nb7Q1JzVQBru+3rxD?=
 =?us-ascii?Q?rA3F4rizpb/zIlHDN3c76Gz/cc8BmA4XG08Vt6okkP330rCPEylMxlPfgbAU?=
 =?us-ascii?Q?IjodQTBrYAcbHK9BDh+nlpRSkEyYg3zL2qofVBAa5fRD8KWVIMrFUCJSgtTW?=
 =?us-ascii?Q?IMfzPreOMyVjQ3/ASLJ93cKgQESLrHyRPiixvj1xerm1aQ/gF9VpAi1K4Pix?=
 =?us-ascii?Q?uviowjSx8h/dKwcxkc6HT/Wwk8J6mI1DnEjuO9u5m9SdOP9uG3AL5O792KjY?=
 =?us-ascii?Q?Cm44zd0l//wBu0bUCsRwhDGc64+8p1e7N9x0qwzmvIDsxrYpeQIUTPM9gLSQ?=
 =?us-ascii?Q?zIiQh/OeSL63AqZF4O6qGPofaExqRMaTeyGBUW0C4Oe3tZ53lKSqALwuGj0m?=
 =?us-ascii?Q?gXryqnylZogPPMLBaVLA2M0fSn/lRy2ue70WVA5I0Lm20deX5m+073HuefNg?=
 =?us-ascii?Q?Dvt2XZ/2CnbTYPrU3b7nyOUJWfTCbsC7U3OctNoeI6isIT1Oz2RE7n98wmSb?=
 =?us-ascii?Q?JQwyEL75jYPLwDQz/+XWqXQsv3zgZEw=3D?=
X-Exchange-RoutingPolicyChecked: PKCfyRRXVt5Csx+vKR36QFZ6onJBNUoPVb/Yne1gtv4f37nhEhY82oKOV38UjZ1rys+3JJCdwbWP1UVr9BaTWYBEB3f/aEqPw1D7UlG0ZfBrIhBIyw6tbalLSOHOOH+qTzDT1aoOXYcID5GJufuwyuQTIywuB3u9/m7ox4mBI7t/dq1zV0ujSLYcJNJMlYH0jKccdzQ9ZWXTZ6ajC/qi88yCK6EeB5lzwctFdpIRzQHTPU+4oS9b5vgmUIbbJcccvRQLVBz9a/jMTQUCTilgSbd1OfoUG8aYYVDK3pRzvbAAbV3tNTKV0ERFe3OVFwLdLC8jIAcR4MxfcSiUXmXiWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c819ba-6382-4313-5e9f-08debb422dbb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:16:44.4873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqbZfBp0eMAksWBmIZde+jdtdDwCmA0LtKeeUqMOAUU2/dbLVf1UKHQ5/USdM2XHA1mGc3TaFzFo10KkiIgmDZ3THTuxoNBcaq8ISAOjV64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6657
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

On Fri, Mar 13, 2026 at 04:06:37PM +0000, Anatoly Burakov wrote:
> Currently, the VA space limits placed on DPDK memory are only informed by
> the default configuration coming from `rte_config.h` file. Add an EAL flag
> to specify per-page size memory limits explicitly, thereby overriding the
> default VA space reservations.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

CI reports some errors with 32-bit builds. Also a couple of small comments
inline below.

Thanks for the series, looks some nice simplification.

>  app/test/test.c                               |   1 +
>  app/test/test_eal_flags.c                     | 126 ++++++++++++++++++
>  doc/guides/linux_gsg/linux_eal_parameters.rst |  13 ++
>  .../prog_guide/env_abstraction_layer.rst      |  27 +++-
>  lib/eal/common/eal_common_dynmem.c            |   9 ++
>  lib/eal/common/eal_common_options.c           | 121 +++++++++++++++++
>  lib/eal/common/eal_internal_cfg.h             |   6 +
>  lib/eal/common/eal_option_list.h              |   1 +
>  8 files changed, 302 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test/test.c b/app/test/test.c
> index 58ef52f312..c610c3588e 100644
> --- a/app/test/test.c
> +++ b/app/test/test.c
> @@ -80,6 +80,7 @@ do_recursive_call(void)
>  			{ "test_memory_flags", no_action },
>  			{ "test_file_prefix", no_action },
>  			{ "test_no_huge_flag", no_action },
> +			{ "test_pagesz_mem_flags", no_action },
>  			{ "test_panic", test_panic },
>  			{ "test_exit", test_exit },
>  #ifdef RTE_LIB_TIMER
> diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
> index b3a8d0ae6f..4e1038be75 100644
> --- a/app/test/test_eal_flags.c
> +++ b/app/test/test_eal_flags.c
> @@ -95,6 +95,14 @@ test_misc_flags(void)
>  	return TEST_SKIPPED;
>  }
>  
> +static int
> +test_pagesz_mem_flags(void)
> +{
> +	printf("pagesz_mem_flags not supported on Windows, skipping test\n");
> +	return TEST_SKIPPED;
> +}
> +
> +
>  #else
>  
>  #include <libgen.h>
> @@ -1502,6 +1510,123 @@ populate_socket_mem_param(int num_sockets, const char *mem,
>  	offset += written;
>  }
>  
> +/*
> + * Tests for correct handling of --pagesz-mem flag
> + */
> +static int
> +test_pagesz_mem_flags(void)
> +{
> +#ifdef RTE_EXEC_ENV_FREEBSD
> +	/* FreeBSD does not support --pagesz-mem */
> +	return 0;
> +#else
> +	const char *in_memory = "--in-memory";
> +
> +	/* invalid: no value */
> +	const char * const argv0[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem="};
> +
> +	/* invalid: no colon (missing limit) */
> +	const char * const argv1[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M"};
> +
> +	/* invalid: colon present but limit is empty */
> +	const char * const argv2[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:"};
> +
> +	/* invalid: limit not aligned to page size (3M is not a multiple of 2M) */
> +	const char * const argv3[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:3M"};
> +
> +	/* invalid: garbage value */
> +	const char * const argv4[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=garbage"};
> +
> +	/* invalid: garbage value */
> +	const char * const argv5[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:garbage"};
> +
> +	/* invalid: --pagesz-mem combined with --no-huge */
> +	const char * const argv6[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, no_huge, "--pagesz-mem=2M:2M"};
> +
> +	/* valid: single well-formed aligned pair */
> +	const char * const argv7[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:64M"};
> +
> +	/* valid: multiple occurrences */
> +	const char * const argv8[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory,
> +			"--pagesz-mem=2M:64M", "--pagesz-mem=1K:8K"};
> +
> +	/* valid: fake page size set to zero (ignored but syntactically valid) */
> +	const char * const argv9[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=1K:0"};
> +
> +	/* invalid: page size must be a power of two */
> +	const char * const argv10[] = {prgname, eal_debug_logs, no_pci,
> +			"--file-prefix=" memtest, in_memory, "--pagesz-mem=3M:6M"};
> +
> +	if (launch_proc(argv0) == 0) {
> +		printf("Error (line %d) - process run ok with empty --pagesz-mem!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv1) == 0) {
> +		printf("Error (line %d) - process run ok with --pagesz-mem missing colon!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv2) == 0) {
> +		printf("Error (line %d) - process run ok with --pagesz-mem missing limit!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv3) == 0) {
> +		printf("Error (line %d) - process run ok with --pagesz-mem unaligned limit!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv4) == 0) {
> +		printf("Error (line %d) - process run ok with --pagesz-mem garbage value!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv5) == 0) {
> +		printf("Error (line %d) - process run ok with --pagesz-mem garbage value!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv6) == 0) {
> +		printf("Error (line %d) - process run ok with --pagesz-mem and --no-huge!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv7) != 0) {
> +		printf("Error (line %d) - process failed with valid --pagesz-mem!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv8) != 0) {
> +		printf("Error (line %d) - process failed with multiple valid --pagesz-mem!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv9) != 0) {
> +		printf("Error (line %d) - process failed with --pagesz-mem zero limit!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +	if (launch_proc(argv10) == 0) {
> +		printf("Error (line %d) - process run ok with non-power-of-two pagesz!\n",
> +			__LINE__);
> +		return -1;
> +	}
> +
> +	return 0;
> +#endif /* !RTE_EXEC_ENV_FREEBSD */
> +}
> +
>  /*
>   * Tests for correct handling of -m and --socket-mem flags
>   */
> @@ -1683,5 +1808,6 @@ REGISTER_FAST_TEST(eal_flags_b_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invali
>  REGISTER_FAST_TEST(eal_flags_vdev_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invalid_vdev_flag);
>  REGISTER_FAST_TEST(eal_flags_r_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invalid_r_flag);
>  REGISTER_FAST_TEST(eal_flags_mem_autotest, NOHUGE_SKIP, ASAN_SKIP, test_memory_flags);
> +REGISTER_FAST_TEST(eal_flags_pagesz_mem_autotest, NOHUGE_SKIP, ASAN_SKIP, test_pagesz_mem_flags);
>  REGISTER_FAST_TEST(eal_flags_file_prefix_autotest, NOHUGE_SKIP, ASAN_SKIP, test_file_prefix);
>  REGISTER_FAST_TEST(eal_flags_misc_autotest, NOHUGE_SKIP, ASAN_SKIP, test_misc_flags);
> diff --git a/doc/guides/linux_gsg/linux_eal_parameters.rst b/doc/guides/linux_gsg/linux_eal_parameters.rst
> index 7c5b26ce26..ce38dd128a 100644
> --- a/doc/guides/linux_gsg/linux_eal_parameters.rst
> +++ b/doc/guides/linux_gsg/linux_eal_parameters.rst
> @@ -75,6 +75,19 @@ Memory-related options
>      Place a per-NUMA node upper limit on memory use (non-legacy memory mode only).
>      0 will disable the limit for a particular NUMA node.
>  
> +*   ``--pagesz-mem <page size:limit>``
> +
> +    Set memory limit per hugepage size.
> +    Each time the option is used, provide a single ``<pagesz>:<limit>`` pair;
> +    repeat the option to specify additional page sizes.
> +    Both values support K/M/G/T suffixes (for example ``2M:32G``).
> +
> +    The memory limit must be a multiple of page size.
> +
> +    For example::
> +
> +        --pagesz-mem 2M:32G --pagesz-mem 1G:512G
> +
>  *   ``--single-file-segments``
>  
>      Create fewer files in hugetlbfs (non-legacy mode only).
> diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
> index 63e0568afa..e2adf0a184 100644
> --- a/doc/guides/prog_guide/env_abstraction_layer.rst
> +++ b/doc/guides/prog_guide/env_abstraction_layer.rst
> @@ -204,13 +204,36 @@ of virtual memory being preallocated at startup by editing the following config
>  variables:
>  
>  * ``RTE_MAX_MEMSEG_LISTS`` controls how many segment lists can DPDK have
> -* ``RTE_MAX_MEMSEG_PER_TYPE`` controls how many segments each memory type
> +* ``RTE_MAX_MEMSEG_PER_TYPE`` sets the default number of segments each memory type
>    can have (where "type" is defined as "page size + NUMA node" combination)
> -* ``RTE_MAX_MEM_MB_PER_TYPE`` controls how much megabytes of memory each
> +* ``RTE_MAX_MEM_MB_PER_TYPE`` sets the default amount of memory each
>    memory type can address
>  
>  Normally, these options do not need to be changed.
>  
> +Runtime Override of Per-Page-Size Memory Limits
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +By default, DPDK uses compile-time configured limits for memory allocation per page size
> +(as set by ``RTE_MAX_MEM_MB_PER_TYPE``).
> +These limits apply uniformly across all NUMA nodes for a given page size.
> +
> +It is possible to override these defaults at runtime using the ``--pagesz-mem`` option,
> +which allows specifying custom memory limits for each page size. This is useful when:
> +
> +* The default limits may be insufficient or excessive for your workload
> +* You want to dedicate more memory to specific page sizes
> +
> +The ``--pagesz-mem`` option accepts exactly one ``<pagesz>:<limit>`` pair per
> +occurrence, where ``pagesz`` is a page size (e.g., ``2M``, ``4M``, ``1G``)
> +and ``limit`` is the maximum memory to reserve for that page size (e.g., ``64G``, ``512M``).
> +Both values support standard binary suffixes (K, M, G, T).
> +Memory limits must be aligned to their corresponding page size.
> +
> +Multiple page sizes can be specified by repeating the option::
> +
> +  --pagesz-mem 2M:64G --pagesz-mem 1G:512G
> +
>  .. note::
>  
>      Preallocated virtual memory is not to be confused with preallocated hugepage
> diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
> index c33fbdea6d..7096f46ff3 100644
> --- a/lib/eal/common/eal_common_dynmem.c
> +++ b/lib/eal/common/eal_common_dynmem.c
> @@ -127,6 +127,11 @@ eal_dynmem_memseg_lists_init(void)
>  		mem_va_len += type->mem_sz;
>  	}
>  
> +	if (mem_va_len == 0) {
> +		EAL_LOG(ERR, "No virtual memory will be reserved");
> +		goto out;
> +	}
> +
>  	mem_va_addr = eal_get_virtual_area(NULL, &mem_va_len,
>  			mem_va_page_sz, 0, 0);
>  	if (mem_va_addr == NULL) {
> @@ -141,6 +146,10 @@ eal_dynmem_memseg_lists_init(void)
>  		uint64_t pagesz;
>  		int socket_id;
>  
> +		/* skip page sizes with zero memory limit */
> +		if (type->n_segs == 0)
> +			continue;
> +
>  		pagesz = type->page_sz;
>  		socket_id = type->socket_id;
>  
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
> index bbc4427524..0532d27aaa 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -21,6 +21,7 @@
>  #endif
>  
>  #include <rte_string_fns.h>
> +#include <rte_common.h>
>  #include <rte_eal.h>
>  #include <rte_log.h>
>  #include <rte_lcore.h>
> @@ -233,6 +234,20 @@ eal_collate_args(int argc, char **argv)
>  		EAL_LOG(ERR, "Options allow (-a) and block (-b) can't be used at the same time");
>  		return -1;
>  	}
> +#ifdef RTE_EXEC_ENV_FREEBSD
> +	if (!TAILQ_EMPTY(&args.pagesz_mem)) {
> +		EAL_LOG(ERR, "Option pagesz-mem is not supported on FreeBSD");
> +		return -1;
> +	}
> +#endif
> +	if (!TAILQ_EMPTY(&args.pagesz_mem) && args.no_huge) {
> +		EAL_LOG(ERR, "Options pagesz-mem and no-huge can't be used at the same time");
> +		return -1;
> +	}
> +	if (!TAILQ_EMPTY(&args.pagesz_mem) && args.legacy_mem) {
> +		EAL_LOG(ERR, "Options pagesz-mem and legacy-mem can't be used at the same time");
> +		return -1;
> +	}
>  
>  	/* for non-list args, we can just check for zero/null values using macro */
>  	if (CONFLICTING_OPTIONS(args, coremask, lcores) ||
> @@ -511,7 +526,10 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
>  				sizeof(internal_cfg->hugepage_info[0]));
>  		internal_cfg->hugepage_info[i].lock_descriptor = -1;
>  		internal_cfg->hugepage_mem_sz_limits[i] = 0;
> +		internal_cfg->pagesz_mem_overrides[i].pagesz = 0;
> +		internal_cfg->pagesz_mem_overrides[i].limit = 0;
>  	}
> +	internal_cfg->num_pagesz_mem_overrides = 0;
>  	internal_cfg->base_virtaddr = 0;
>  
>  	/* if set to NONE, interrupt mode is determined automatically */
> @@ -1867,6 +1885,96 @@ eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
>  	return 0;
>  }
>  
> +static int
> +eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
> +{
> +	char strval_cpy[1024];
> +	char *fields[3];
> +	char *pagesz_str, *mem_str;
> +	int arg_num;
> +	int len;
> +	unsigned int i;
> +	uint64_t pagesz, mem_limit;
> +	struct pagesz_mem_override *pmo;
> +
> +	len = strnlen(strval, 1024);
> +	if (len >= 1024) {
> +		EAL_LOG(ERR, "--pagesz-mem parameter is too long");
> +		return -1;
> +	}
> +
> +	rte_strlcpy(strval_cpy, strval, sizeof(strval_cpy));
> +
> +	/* parse exactly one pagesz:mem pair per --pagesz-mem option */
> +	arg_num = rte_strsplit(strval_cpy, len, fields, RTE_DIM(fields), ':');
> +	if (arg_num != 2 || fields[0][0] == '\0' || fields[1][0] == '\0') {
> +		EAL_LOG(ERR, "--pagesz-mem parameter format is invalid, expected <pagesz>:<limit>");
> +		return -1;
> +	}
> +	pagesz_str = fields[0];
> +	mem_str = fields[1];
> +
> +	/* reject accidental multiple pairs in one option */
> +	if (strchr(mem_str, ',') != NULL) {
> +		EAL_LOG(ERR, "--pagesz-mem accepts one <pagesz>:<limit> pair per option");
> +		return -1;
> +	}

If multiple options are given, then the rte_strsplit should return >2 when
splitting on ":". I'd suggest checking for the comma first, before even
doing the strlcpy.

> +
> +	/* parse page size */
> +	errno = 0;
> +	pagesz = rte_str_to_size(pagesz_str);
> +	if (pagesz == 0 || errno != 0) {
> +		EAL_LOG(ERR, "invalid page size in --pagesz-mem: '%s'", pagesz_str);
> +		return -1;
> +	}
> +	if (!rte_is_power_of_2(pagesz)) {
> +		EAL_LOG(ERR, "invalid page size in --pagesz-mem: '%s' (must be a power of two)",
> +			pagesz_str);
> +		return -1;
> +	}
> +
> +	/* parse memory limit (0 is valid: disables allocation for this page size) */
> +	errno = 0;
> +	mem_limit = rte_str_to_size(mem_str);
> +	if (errno != 0) {
> +		EAL_LOG(ERR, "invalid memory limit in --pagesz-mem: '%s'", mem_str);
> +		return -1;
> +	}
> +
> +	/* validate alignment: memory limit must be divisible by page size */
> +	if (mem_limit % pagesz != 0) {
> +		EAL_LOG(ERR, "--pagesz-mem memory limit must be aligned to page size");
> +		return -1;
> +	}
> +
> +	for (i = 0; i < internal_cfg->num_pagesz_mem_overrides; i++) {
> +		pmo = &internal_cfg->pagesz_mem_overrides[i];
> +		if (pmo->pagesz != pagesz)
> +			continue;
> +
> +		EAL_LOG(WARNING,
> +			"--pagesz-mem specified multiple times for page size '%s'; later limit '%s' will be used",
> +			pagesz_str, mem_str);
> +		pmo->limit = mem_limit;
> +		return 0;

Rather than just warning, I'd make this a hard error and say you can't
duplicate the hugepage limits on commandline. Saves confusion when
examining a commandline, having to check if a value is overridden later.

> +	}
> +
> +	/* do we have space? */
> +	if (internal_cfg->num_pagesz_mem_overrides >= MAX_HUGEPAGE_SIZES) {
> +		EAL_LOG(ERR,
> +			"--pagesz-mem: too many page size entries (max %d)",
> +			MAX_HUGEPAGE_SIZES);
> +		return -1;
> +	}
> +
> +	pmo = &internal_cfg->pagesz_mem_overrides[internal_cfg->num_pagesz_mem_overrides];
> +	pmo->pagesz = pagesz;
> +	pmo->limit = mem_limit;
> +	internal_cfg->num_pagesz_mem_overrides++;
> +
> +	return 0;
> +}
> +
>  static int
>  eal_parse_vfio_intr(const char *mode)
>  {
> @@ -2172,6 +2280,12 @@ eal_parse_args(void)
>  		}
>  		int_cfg->force_numa_limits = 1;
>  	}
> +	TAILQ_FOREACH(arg, &args.pagesz_mem, next) {
> +		if (eal_parse_pagesz_mem(arg->arg, int_cfg) < 0) {
> +			EAL_LOG(ERR, "invalid pagesz-mem parameter: '%s'", arg->arg);
> +			return -1;
> +		}
> +	}
>  
>  	/* tracing settings, not supported on windows */
>  #ifdef RTE_EXEC_ENV_WINDOWS
> @@ -2366,6 +2480,7 @@ eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
>  	unsigned int i;
>  
>  	for (i = 0; i < internal_cfg->num_hugepage_sizes; i++) {
> +		unsigned int j;
>  		const uint64_t pagesz = internal_cfg->hugepage_info[i].hugepage_sz;
>  		uint64_t limit;
>  
> @@ -2373,6 +2488,12 @@ eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
>  		limit = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20,
>  				(uint64_t)RTE_MAX_MEMSEG_PER_TYPE * pagesz);
>  
> +		/* override with user value for matching page size */
> +		for (j = 0; j < (unsigned int)internal_cfg->num_pagesz_mem_overrides; j++) {
> +			if (internal_cfg->pagesz_mem_overrides[j].pagesz == pagesz)
> +				limit = internal_cfg->pagesz_mem_overrides[j].limit;
> +		}
> +
>  		internal_cfg->hugepage_mem_sz_limits[i] = limit;
>  	}
>  
> diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
> index 0bf192c6e5..8475c87969 100644
> --- a/lib/eal/common/eal_internal_cfg.h
> +++ b/lib/eal/common/eal_internal_cfg.h
> @@ -98,6 +98,12 @@ struct internal_config {
>  	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
>  	uint64_t hugepage_mem_sz_limits[MAX_HUGEPAGE_SIZES];
>  	/**< default max memory per hugepage size */
> +	/** storage for user-specified pagesz-mem overrides */
> +	struct pagesz_mem_override {
> +		uint64_t pagesz;   /**< page size in bytes */
> +		uint64_t limit;    /**< memory limit in bytes */
> +	} pagesz_mem_overrides[MAX_HUGEPAGE_SIZES];
> +	unsigned int num_pagesz_mem_overrides;  /**< number of stored overrides */
>  	enum rte_iova_mode iova_mode ;    /**< Set IOVA mode on this system  */
>  	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
>  	volatile unsigned int init_complete;
> diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
> index abee16340b..164a0b3888 100644
> --- a/lib/eal/common/eal_option_list.h
> +++ b/lib/eal/common/eal_option_list.h
> @@ -56,6 +56,7 @@ BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge)
>  BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci)
>  BOOL_ARG("--no-shconf", NULL, "Disable shared config file generation", no_shconf)
>  BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry)
> +LIST_ARG("--pagesz-mem", NULL, "Memory allocation per hugepage size (format: <pagesz>:<limit>, e.g. 2M:32G). Repeat option for multiple page sizes.", pagesz_mem)
>  STR_ARG("--proc-type", NULL, "Type of process (primary|secondary|auto)", proc_type)
>  OPT_STR_ARG("--remap-lcore-ids", "-R", "Remap lcore IDs to be contiguous starting from 0, or supplied value", remap_lcore_ids)
>  STR_ARG("--service-corelist", "-S", "List of cores to use for service threads", service_corelist)
> -- 
> 2.47.3
> 
