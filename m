Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97547CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50AF740150;
	Tue, 23 Jun 2026 10:07:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id EC5014014F
 for <dev@dpdk.org>; Tue, 23 Jun 2026 10:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782202040; x=1813738040;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Dz0GN/xHNvUcrl38q2hPPEjrXRb/F2Qzdakk7YNn7sk=;
 b=loQ8fS3nO91VRo11kPalNJgnaKdnsoC2f5vwKXk/7xrTksdgdgd6GtuM
 8QC5mXCJi0XSIp/VFWtrB7eRX0F//f5rpc0VINB92Gf58hM7WbiCnEZEU
 exCdzktK3h5kjvu0IT86x5LRd1cL7a0IXe/Kv/dlIAMTlNv33vzljI/KC
 lNC873vXCgBdDGXyVWK3K9MU2miLHhEVf5yGZt0NTM0EZYPIUIVaYXvEC
 c5TkU6dMIzc6KkU4eHe/BvNEalzFGyBE71032JRfbF890QnikGZAQDmlu
 N/F5ytgd/3tDv0QVarjY8dqGRbkxNxY2c45AUtNlYhk94C/R4mMOtct5E g==;
X-CSE-ConnectionGUID: LyDS7uWFRaS9VQN2Vp9gyA==
X-CSE-MsgGUID: 5xabPC8uTUyjC5hb5TSIKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82824322"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82824322"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 01:07:18 -0700
X-CSE-ConnectionGUID: Ve2PI8CQROmFrrL/SMMdNA==
X-CSE-MsgGUID: rConXOL4R1OEhUitsNXS1A==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 01:07:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 01:07:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 01:07:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 01:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs1ISJEpcMcJb4qVSexeTpzOeKPeEvGeL8f/zHeMsBKRM2GFnQcfsAgSDc1xroWZEpSKtJQ2mPRO5nvAXMloYWSfcaWEeDyf9MF0NB/03kO1S+i5Qqa3cBc7Zksiiuslgy0Yi9kyfp5jQgXusMyhfSF7DXtYZ77s7Yr1VpzT0P2fVWo8zuameNd+zkwYALz5XcWWz9GVTCNy4We4Sxd3ZKYkRkfGZJce0n4nEYZMdlUrrFW6cxTmGuLAuHYn8VTBuZrcsrdz6/QdepehcCn+xK1lPf9Hv8zAZbeGHgLhwguz4FttrKLp4EmTS0axunnThUfKPClbSNUrOrQggKhfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEdAhH6RIO5PjGuo/rbzdcMmHjraOOADxSafyPZGhtI=;
 b=xwmxDLUH5+hok0W4RGUrkpKcBPzyLHsdaGMIUa5V/fI2jqNSiEf+U0nPwToI434SanrchUELCbuqe1d68kwLEbucvk/VT6bATeLqfhiKqZ4iJGd96vQhEs3K7P2ZMlltUXJ0TyuOU8Q6LKThBzYxWErL/tR05WZtYm244I881vaC5NQcXpeEb2kY1BbAhkJc++W9GRe/hZut52s9XGCzGd2kwb28abflkM7ygHxoTjqyU4ZWlVi3pBIN3/ZqVs+uLDWLsQWfpV/KjpChI99LJ+UsBE7bNFkrQW+IhU6UANzysfuwIc6aU+GqY2a787mtSRhDUNbRC3KfxhsxhR4XYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA3PR11MB9038.namprd11.prod.outlook.com (2603:10b6:208:57a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 08:07:14 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Tue, 23 Jun 2026
 08:07:14 +0000
Date: Tue, 23 Jun 2026 09:07:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Rupesh Chiluka <rchiluka@marvell.com>
CC: Cheng Jiang <honest.jiang@foxmail.com>, Chengwen Feng
 <fengchengwen@huawei.com>, <dev@dpdk.org>, <gakhil@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>
Subject: Re: [PATCH] app/dma_perf: skip case if worker maps to main lcore
Message-ID: <ajo-ra8UUPRXKoWF@bricha3-mobl1.ger.corp.intel.com>
References: <20260623045841.2602104-1-rchiluka@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623045841.2602104-1-rchiluka@marvell.com>
X-ClientProxiedBy: DU2PR04CA0312.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::17) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA3PR11MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bf158f-4c88-421d-674b-08ded0fe6f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: daDORL+MDZ/h4LcL64rW6xovRFEMCuyiLxLQlPdRt5bx/fqFVGS0JW+MVtdLKWVhgYV/K6b4wHAQaqOkNPE406ZT9wF6F5WJXAtuEIOfDZjhy2lC8J75t2ktoe2EaRK0GTmdow3cs0TJt0QVBYMhdOCcnG2outi+g7ElkiZbfwywvuLjT4BXkXa4GziAUfdgBT3JWGImavBVcGXBolHYipCMUOxSSTZzP6UfXN8c/4dbEEWpBXitrGnD4uDTXt3ovaWZzkAZ6QIKnqu7+2G90sd7R8/8eeqt0zwk2kiAVycnLTY52crseQdnsSyyg/2W2vACqfcbjqW7RezQctsZhvYqplav2aR889Dq+aTM/8M70iknMgMK1+zgs4DieR15Adxualb59EICWmMV43USX6ueGfcRY1vmo2IGAfI7k0govBpgyCE+uFJ6FhGK4EJmYUMI3GqMhXIxR40SzyKCW4StMDaFuzGjRDAQUU3WdjbEJjXW88pUZ/8VqVOhtJ5UlNuCxq0IQNqyf5QbaZmE5qc3eiy2B8TdzOq2WedyakrvDC8a96IKU3BvN0UoKGJ2clgeUy1jMiYGe9H6Pn+NvR4514qXisZTRMRa4fTGiEgrhX7Z6hoRMY6FuMc4zDK65WvuPozlxX3FrkGjwPMjWopkg9dYDWzZJTqKUMwmwS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8q974ue9pVzO7Y3c4yJaDKAVW7GEoJ9nuwQGxbEJSlV0MPkmQWHGwQAMQDOt?=
 =?us-ascii?Q?ze8EgknBfEbJ64fi3yymMcc/QtnuKCCsT1s+XFUmiCsyOiU0mRo9qfHWaEzW?=
 =?us-ascii?Q?h268iK1EmikE+Vlj1SGC5FQ8HcLVTJlvutfJr7MVqRLDS3mgLOvks9zRW4YD?=
 =?us-ascii?Q?6EL0DcOAPhQBwM7tkSztIZsDlq4w+iW017o0zMiy76BOa24rzdPmy+lqOeC4?=
 =?us-ascii?Q?QVMBBNho8pRkw+Tq7BTqZK6l6c+W6aJT1DPGvNEw/GX2yRBIO2lRfC0rwwvc?=
 =?us-ascii?Q?msTWPrSb7QGXzq834J5t/l/jFrThPx1nt+DI0kIfiS6YqZCgvN31Lse4e+5w?=
 =?us-ascii?Q?TZPHw+zd+7/scVE5xcaPeypKwbPMLlNlxj2n2DGaQvdG1VLtPZgWdb5XoDym?=
 =?us-ascii?Q?k25ijpeVRHKVQKark5i5tOrS0C1OYLCZz2++WYuX8XI3XwJuGaLQL7UHQ/Vl?=
 =?us-ascii?Q?+CLfVeASVXtiE45FjV3Gkjc5ICikqjq8JfIjajwMoDnQTHq4wlz887q3cwHl?=
 =?us-ascii?Q?Cht+7MWoSkbrlNOvAFk8nVb/Cswxt9ymppm/ngOmn/iQ4UElRaWASVGaW7DM?=
 =?us-ascii?Q?gS0ywBYbXUqeQVVpZ8VtyHEFor/MFljBZdl2g0Cfkxaip6bhAGIgHkSec1FG?=
 =?us-ascii?Q?ABupAuRTUBy+4DTxMEF8hlDA8CuTTKXeCPxPfm/QvhB9mCdh8nndG/TqPP1M?=
 =?us-ascii?Q?xEMmmVgmkg4fwGVoOoAqiNDLMytlpk3aLoLZLGdznA7quW1S3lamK924MQQQ?=
 =?us-ascii?Q?v5lFQcC4LaCKdmA6ztaJD4gw58dtniDwBJTc3fd3WCUCbzd0f4RKSxL1xOzm?=
 =?us-ascii?Q?E9E7CJdq18ROEDNPf3qXGGHi0uXe/x44JsKypfPRgkHP9+QAeChRpXgL1+pC?=
 =?us-ascii?Q?ZvcNqYD1FBePEiGoyWmQ5eb7YeDg7IXCze8gYVZME5PsMfs8FOcYvaZTF7uu?=
 =?us-ascii?Q?ZysauHp6XEleqrYmXyvtmk4lwn1LLDB/ttdEk0d2yWfX5IkrBgb1tmzDJkYL?=
 =?us-ascii?Q?F14N5DSniRRBXC8c62SFLIr+noxUqoSy1a6iHeHpOrWiNQwHbjWLDENnyfRF?=
 =?us-ascii?Q?3q+9kZg7ygeBC9X2OiT/Lp03qKIIxscxBeWEqqjUyblmidYo0wGV7+fUqY/s?=
 =?us-ascii?Q?TAIbCellg6HTYMoEYaODDP4zOjgQsQkNjXcwyBUrQTycaFnzLG6VBeSMz3/R?=
 =?us-ascii?Q?8AuNsdj1ORVCS/2VNWH4QDk0zE4d54E/lqhkL7F4Aj4y3PUjZ3HRyoJHHR+c?=
 =?us-ascii?Q?SZHlYTUUQvKxrhZltjIm76EdGtt9guHIzxUhoxDLFmJ5EtrjHUUUFNvSiCzs?=
 =?us-ascii?Q?Eg96/GFVkMq7TzSVNjIxEqRvPT1y/ZE/vDFRNcI0SUU/TdjssGKwmq1G1TWP?=
 =?us-ascii?Q?Vy1kv9ADA156vv35lmwulyN0fi8bkMUZvVH13+n8gAM/U2zx7g4+BvyT2ntz?=
 =?us-ascii?Q?f1X1NJjieC9+++JJE6YxmsAcrMpG+CxXP/x3vInPY9BXj79rmRSaHGuq9+Bv?=
 =?us-ascii?Q?SGwy0yF/5xoBM+nGJBnj8fvnr2xICYF+/vtHhTeo2VxUU/aNvICFdw3bcFJ8?=
 =?us-ascii?Q?J2Br4uUO8HW26mYNj6T0EZnuLC1uXRgsOpYPTlEnyk/nX47kzyWe/DYPtEsI?=
 =?us-ascii?Q?38meu3IOhJRsCrC2GLkDTJEMnWnwA8hxCfEB/2zGh4+3Gqun4tKuDaSCV0x3?=
 =?us-ascii?Q?kEhPXbRC0kCtMVnmJPWEB66/jQ8zGUQXvIU3ezuXo0KxHQ5bXHb7pUI2UPjd?=
 =?us-ascii?Q?YqtPx/zqVjh23SG5nlReaop9L5phZ1M=3D?=
X-Exchange-RoutingPolicyChecked: Tu8RY/fs8+AjCA+1ttPeRdgl8kZsRTAwPVWH0N1HVKSYqhW02pfs/tDmlJJt/cf+jD6NXihLBEWfNZ+Oq/BpC1lMSZePzn19TL15llRhh7aGXQa3afswirnYmRzxXtrXgeGt3tMDCEjdnVWIFZgA+Qotbe/mU9N/J0RsjCG5L5y7s4LMeuRjvfOG0GrVvu/zNIV7eKKaNZl6yzzyYB24Zx+wjADZVKCfnVJ2ue3ci/EemxrQKMJhcN5R5q8HE1FdIHVEQlrYbdECLXT7JdxWvRMGHd7bBiIGpflkabcz29iPKc8OQ50J2mKQM37db+chz0nX9qcuaTz8z7zOUe9Fpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bf158f-4c88-421d-674b-08ded0fe6f80
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:07:14.6324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EF/5y9g+EW2mWq0lfRrRhHfol/Ez+TSsZnjAZKqQrwLaR3IN3Rbm0+6hdmWi066VGPqnPqqL9rUp+YZsrqYiXbmKKneIqVQporT+bPI8YMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9038
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

On Tue, Jun 23, 2026 at 10:28:41AM +0530, Rupesh Chiluka wrote:
> Refuse to run DMA/CPU mem-copy cases when any worker is bound to the
> EAL main lcore.
> 

Can you explain a bit more why?

> Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
> ---
>  app/test-dma-perf/main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
> index 4249dcfd3d..b6aa5b8401 100644
> --- a/app/test-dma-perf/main.c
> +++ b/app/test-dma-perf/main.c
> @@ -109,6 +109,7 @@ run_test_case(struct test_configure *case_cfg)
>  static void
>  run_test(uint32_t case_id, struct test_configure *case_cfg)
>  {
> +	uint32_t main_lcore = rte_get_main_lcore();
>  	uint32_t nb_lcores = rte_lcore_count();
>  	struct test_configure_entry *mem_size = &case_cfg->mem_size;
>  	struct test_configure_entry *buf_size = &case_cfg->buf_size;
> @@ -122,6 +123,14 @@ run_test(uint32_t case_id, struct test_configure *case_cfg)
>  		return;
>  	}
>  
> +	for (uint32_t i = 0; i < case_cfg->num_worker; i++) {
> +		if (case_cfg->dma_config[i].lcore_dma_map.lcore == main_lcore) {
> +			printf("Case %u: worker %u cannot run on the EAL main lcore (%u).\n",
> +			       case_id, i, main_lcore);
> +			return;
> +		}
> +	}
> +
>  	printf("Number of used lcores: %u.\n", nb_lcores);
>  
>  	if (mem_size->incr != 0)
> -- 
> 2.48.1
> 
