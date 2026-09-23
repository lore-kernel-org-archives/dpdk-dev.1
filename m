Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF2C982EA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 07:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8280F42759;
	Wed, 23 Sep 2026 09:30:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7DFEF40E28
 for <dev@dpdk.org>; Wed, 23 Sep 2026 09:30:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790148628; x=1821684628;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XK/KETk60B8eYOFnuhS3S4lDSEGiYPkWQBFcoTZxbr0=;
 b=lOl0JXpfu5CQ2KP0ZKGTPR17Sn7tzjfoNUTuRXFk67TW3MYl17Yn2nT+
 1j8aZXGjI9hKwJlk5+T1fktAp+FS27wIeLW0oMrTDJIOAKbjbtROGrRfm
 0MsDjPX/R3IWK7pj7TLgbN/uIqnsMXn8hoy7AN+FqXMIkC3EWkQ11s7il
 8lK926+s6+2NwB6C+vKuouDxsDh0Vh0Ee1psrt1Zz5Wp8E1wUYmf0pvlJ
 MQt2OaHFtdsQfixPfOw0Gv0ll2f1tmscQ/5GtJtXgaVgSa5nFN+94Ek2a
 OewwYc3DcrwLU9vh+uw9OaH/rl8Dlq728FfRYjaX0XHPioQpoXZzVK31/ w==;
X-CSE-ConnectionGUID: wnucOCuoS1mDsZuVIS8+Fw==
X-CSE-MsgGUID: RYuN3nICSY6t+dkjVtvSAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89949285"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="89949285"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:30:27 -0700
X-CSE-ConnectionGUID: cwDYYsnfSHufj8NafKt0uA==
X-CSE-MsgGUID: MCNi4Wq0SZiRqe5eNjsRiw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:30:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:30:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 00:30:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.36)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPUQqOnVpwdFQx95wv2ShtSxEUyKhGFClbyk4fvb3qSQzdPV2nD5MSbeoBu5+lDS3gUJxHydf7CCYhYDzEuTi8dBb/nu+BViyRsiL4dYSlb9lywoBOHs5XyOAXHNuk/xrGU+3GSOV5QBiy0RNtHkliLvIT1r7OtSyED94QlxyI/RYQlS2UBfiUOA+jjSqxDm8gpuqRroFifzAEMPTbHlEE+aDFr2VFB6BI2ibt6Wfp+zgMDJe5vbmAfBx6TXUuH9/TS5ZOg/IpoM24O88PYxVLbZdOZqmGOGCG74EVpav7NzSiWCaTvk74HE7OHXtC5H9eAnVpZTdJkrlkcfqOUU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ9ZtVweOBLC/w1tcKMrLTNoj50fDZ5gpAJahnX4h5k=;
 b=zWuwm09WjvR1TRhjDDC6ARHvUN4hJI6lfAKLm8uS3/jNf3rbj1msU5bogVnxPwIOU0732rHNRDgXnMhv0qHI1e2KexZ4mDSS5SpWtlp1BneC/ByzboOEnudZ1y0G7xDcwtdDoPXgommf3kbZUoUFcsIkU2f/gciJq0IZgA/gS0ERHdZdA1HY7g7iwZdQvpt10YahUNDiOOKaag2R5chZmJlrlYTQo1So0hRR0JzGPxhjKjMdMu6MnU0gywFyyYO3BRTBn4vGbA/EWyP/8mu7jg+j04oGC5UF9vHvKKVru/8jCU67MH9WFcZDIAQBecvBcu4quMH0NH8449P5PXCtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB8292.namprd11.prod.outlook.com (2603:10b6:303:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 07:30:23 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 07:30:23 +0000
Date: Wed, 23 Sep 2026 08:30:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3 02/16] net/i40e: use common division round up macro
Message-ID: <arOACkkEd71gFm5u@bricha3-mobl1.ger.corp.intel.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-3-joshwash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923010742.2468145-3-joshwash@google.com>
X-ClientProxiedBy: DU2PR04CA0344.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd44928-1514-4779-ed71-08df1944876c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yHwEmu29nC9g0fYcLm0ctOVPm8p2af/Yp0L62gsnMWLVQ8JPwXkF9DYXT5WgG+mYK3AkoHgAm+h8iI6RVU0nS1w5i4jQl0usijZoagTqQInZH5Q41M22fG/Hjyk3maimkoevFj9mmT5H5A/p4au/wktdommdyXQttD01HYyMWC4kZCNxxEHFrbICTF/yvaBf0R6igkrMQAr7vIW3+WQ38VZNYAn9LGuZOdcVa4saNxa7uOqjlgsDG5LcepuzyAPNSmv3a3/PnhZPlUG0ShhaxRaqO20Z3aOf83CSSCaa2Dm0BPRZO3K+ppyd5vfqq/XDWtEB1EAGp1M8I/FPmUS5WrPWb0oM7Rg7DsIc0jCRY6E5ca9DRtoV5eiJW9s2cCfE7yYUIzvkIzdAug+QpI3o4qsVN9sga9YF4wNjn0IgmVYPgWeKNBqfrh530Yg78B2cW7p7QmPEkRJokTZG/+Orlx/O++YQCqBf0Bgz+8Htjl70mZkGIzOmFNzwt5uW1fVN9Ca3h60CMVKpcThjmlxoZ4KILmAwXf5uQNxZGzd/NTSDXaVtYStBzZFFsz74dph6LdZYGIyvyjBJ6F04rYY2wvPrR7Xe1+yeyFuHHB1GoXWfdCuPj20+HJjC8osYuulspNEFynJtkU0R/25q3EjmNPj0G7JEcGs9xITD/NnVelA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?atEIUP23XKdVGxlgnf1fCcxLxWN7QQhOEuanF592auOdw0/465odYaZZCuPP?=
 =?us-ascii?Q?3z0sO4W/sLAh76rj9kK4LMntE5ZJjALUlOJ+KXSasj6NDkoz5x6z5/vJGPkb?=
 =?us-ascii?Q?C5xaOEAtjLo35L0AOZ5r8VEu+V8/0V6uUNDnAIbk4e0NjdDSx7a5ndO3I+NO?=
 =?us-ascii?Q?JoDIkuSMtbeSEpOSfXNL//ronAH31qLPYNgLkWHLf1EPTvo4LuLMg5ndcOcb?=
 =?us-ascii?Q?mMw7HMgGB8QRCTR4r5aznNaRBriXCH1FePyh29LCglQpGIf2TPrKPx/5FcHs?=
 =?us-ascii?Q?ZEFtUUB9YbF9wmk04XwtItabz+I0Fb8BklUO9OqmTVlSbhQP2Iv4o2CF1eDL?=
 =?us-ascii?Q?VeXDhNqscy56Eie58JHIFxDTzmB24EPyjrP6gPLrXc9PPapypgawgwEcLPRh?=
 =?us-ascii?Q?ffmqhlZ22PR3pdLd8UL6ZfiqTWIwfSGi6aAzy3C0aw4GdkJr26m0trLd7cQ4?=
 =?us-ascii?Q?n/rayI1mGCsfbx2gLekzC6jn88yzoDkHR+8GFVdiv2bcr2fPHtBjqr6ZZQPs?=
 =?us-ascii?Q?NqOdxusyWksq9yC9gqdc7yWCBT4RA2N3ILZfj23eK6UE4oxnFHBVI90AO9Ih?=
 =?us-ascii?Q?59s1MEmCEdxb5LhCAXvfUe+6fBfuxLyXRvkqpZpwZe2W6qQZjVN6s12cGu8N?=
 =?us-ascii?Q?D+/g/YIr3PPFScewifrWMjKpSp1XQnh+vvfvB5nQ5inESd8jro9RxSf24aiD?=
 =?us-ascii?Q?AaT4FP/6aq6762DssbrvF4ObyggEvhyvzjPUBW75nH8jn6PhdmmEF5bsE/P2?=
 =?us-ascii?Q?hSKDwlTGtrbsVMi81sRRC7jnEdOBc799W1vIPKl7UHazJ/poWXuvJgkuvWht?=
 =?us-ascii?Q?S+IHB4ZtlVGqOoPSOEGkzZEC89P8lgQupry574TUXckJKdLyrVLpHEMDQnez?=
 =?us-ascii?Q?kDbRUg8q+mZK6zm3MHRZbwH8Drmjfuyig3tnggTh+7ytMjw1wgru9HZOTcPW?=
 =?us-ascii?Q?Q8lRvb7M1FCDADUnwvr2ZM4cRyU15Sc+GnKkfxAkHB0ykgf9tWu1P1jBI4io?=
 =?us-ascii?Q?vGc2L3hOS/6u9NgKI0YinaQVbustQM8ynY3y6EPMn754SQpu4cNxHH0kmyC7?=
 =?us-ascii?Q?MdgEwdX5l7rNABaKAnx9PxrF00lbFm6UcxZlKTrIKSmBSpoIWZUFveEr02PP?=
 =?us-ascii?Q?vlt2sK5XnWl0ipXWArOxZMELH2c6F85sJuV8XjBJyIr7fQ/O36jVQ4cGEeYu?=
 =?us-ascii?Q?g53UX47XcAhhzleeVqDIrRaAezuX89tl4v8FH0T4meWfMHhIRWnnlXu6AMvc?=
 =?us-ascii?Q?6B4s9s3TviJ4m2LqrrLI3BnkeUMNnjAmG5aE1rGXgYzrFwu+Q8a9kcl8aXQ1?=
 =?us-ascii?Q?pOteC7WU7Vbo9sFc3iGlfsaP2N0nLt/n4ZybILQndnIITR3lz+tVSYMyINmE?=
 =?us-ascii?Q?g+q0fVl7d2tlSNMvzEhlmJH9ZikDpXX/MTN+2VI93dxSdu8r+IsxhW2ORPA9?=
 =?us-ascii?Q?fCCnmq0CgA5EYoO5dX3Y2TMtLeEOd9eiLyem7fDJEITYvG6a642B6K3RAB1V?=
 =?us-ascii?Q?LCkk08QitwoXpOpr8rH1k94byQ6nRKNPCbldCPnIbMAJ8XsC8NvoJwdcx/Ff?=
 =?us-ascii?Q?SYvJLLoAErG5AioZQ9Gz1yYDrQDRmXGrxpBO3bOIowTfi6T5rFr9AsYKWhNj?=
 =?us-ascii?Q?Uj4XAf12vVzg5L6srK54NIFokmmDwd3P/XafHFlgiA/01jqkVMmtBFD85m4B?=
 =?us-ascii?Q?tf2X4+4IeK498Af8scU1yNITFhXAYqKizleYffFRCDyWe/e/VslwspdLVx2c?=
 =?us-ascii?Q?Ubwa7zTI3qqqEG9RPAzi0CVi7zM1Roo=3D?=
X-Exchange-RoutingPolicyChecked: lQBu7jUlN4Wr1m99jS5/37BkQx6AAo9fCZJGMFEixpPMddT+VVVfKk7RmvBcmRDAWeDnWQv9eav+89IA6nztmzpcOkeUOgT/9s0n9iXZ5fz8k48OWvFQombVTmUdu5IBsN2E8utWPjrURDFEjjgiPm9Y/gV9Ryd5QTsJZbcNbHgx4B2/sqLkl1OVUZv80Nb9NFTkAYvxqUwWbmMcm2GuOESiK4CbmHtnJijKRdv2IXJ4yHh3zV9bbULRYjH1k/RUp9p/2eIKLs1gfUGJRdCDQisjPlMkjQBflCzhwJM6+465j11Q362c1C73GX0/fxBSF+pBvvq89rcJX5AXqNseYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd44928-1514-4779-ed71-08df1944876c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:30:23.2601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5S4FwuQAxMnjrl9uQ0zvUKSAWl7Q84HITtVtC2BQDXSZQSXOviAWiNn+u86v3W289mShDgwQkDvRPSBDeW6AKKRQgOyIUjrEklqafkwiKBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8292
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

On Tue, Sep 22, 2026 at 06:07:25PM -0700, Joshua Washington wrote:
> The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/i40e/base/i40e_osdep.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h b/drivers/net/intel/i40e/base/i40e_osdep.h
> index 9c5a94f055..93620f5c50 100644
> --- a/drivers/net/intel/i40e/base/i40e_osdep.h
> +++ b/drivers/net/intel/i40e/base/i40e_osdep.h
> @@ -227,12 +227,11 @@ struct i40e_spinlock {
>  #define i40e_memset(a, b, c, d) memset((a), (b), (c))
>  #define i40e_memcpy(a, b, c, d) memcpy((a), (b), (c))
>  
> -#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
>  #define DELAY(x) rte_delay_us_sleep(x)
>  #define i40e_usec_delay(x) DELAY(x)
>  #define i40e_msec_delay(x) DELAY(1000 * (x))
>  #define udelay(x) DELAY(x)
>  #define msleep(x) DELAY(1000*(x))
> -#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
> +#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
>  
>  #endif /* _I40E_OSDEP_H_ */
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
