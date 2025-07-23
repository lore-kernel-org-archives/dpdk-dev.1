Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FE8C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B150D406A2;
	Wed, 23 Jul 2025 15:57:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 733FB4067C
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753279054; x=1784815054;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jnL3m6V5cV1lZ5aesFTpEYBRwl6rrZb02Rhdm+OxnEY=;
 b=AajJFV36KfdVY07UKLSWnCVF/QBfsIRE/s0guJOmc7XC73gjeyslSes9
 qHG2DpVSbostIQA4qgUdFCwTQUmQBo/CcIAttdHVMxPXirjC7EUUUT2xT
 huc+47Hen+7btMaqnSY1sXIHCFkEINdrPHKw/fcvrmwO+05B0BQlYQWz+
 uyk1RMa6w1Cbw6J5wk/am09bg85AaNuUWHYLASyaCObwAQIvs2dl8jGkw
 Q7Tq8A7uzv69uVJ2vh1VCmu7J29wNKAlrMd4AgMESrJ/mUbAwdUYyql/8
 QdjBmpQ5j3LlthhN4LK4OK8SbcwH15uh7EFB14qQuXIQVB9ALFsdDHUXf Q==;
X-CSE-ConnectionGUID: NL3lba1WSF+Nx7t2tSBjWQ==
X-CSE-MsgGUID: rVAWgo+gSwG2wYygdj1QwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="81007926"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="81007926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 06:57:33 -0700
X-CSE-ConnectionGUID: 2L5GiVngQFq2H2Ju+4Rzlw==
X-CSE-MsgGUID: ZHotRLF4SJ6B7FpJyNytAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="158803944"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 06:57:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 06:57:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 06:57:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.55)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 23 Jul 2025 06:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TorOmVMJFXd9+I0KyVaugX/nUmfuVhsF17V+2oZ3Emv4UhgAHvZ5H+4G9yJFVg5C7J/Kf+g5D57tGYY1narLo/LmqrftSAUNE+grm/9Vdp109j4x0EOqvvdkSmYWAR0AjFE6lH6g/fZMSB3Sow+n0+P2l804gmJOpSKP7cc5GKZ97RjcHiJxUtKaxKcLXQOV/MxWIaFR7txvI8coA9Y4nsAK8OnU64qpkPKLJPTQpn4pfs2ljVTErnZAu1XCF0ieXm1GyXvo9PDh/at8LDZNj8AglVoLOst5lHtdp+1i0UPDbGKcxU0VXFynfZFYkVIC2+UPnOQpiSPvNmGfPkQk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cvzfkyl8xsN2HhD1vPB68TbYHQaEekTxJz+zHPPpu/c=;
 b=HBT7XBW95uf1NTl/i7xY2reyHGcuyg+AojSGVZkh+6ChG0cdwgXNPhcpxwesOjFggOGsSUho7QbVoAYljytvAXloqv48i4/vRPoq2hOsFrJE9wjq3YtyURtIrlZkGM6qE7TRCYHfQbumXWkRmPuMflDxhPAXAiYfDV1x7GjrBc77nXYNAFZwrpU0KHn5yXCbRc//UN6ET1oU4CTbMOt9NY9OEdNAUUCRkbj4Yhii1/4ahTQL7SeMa3FBFuj1FLpH69cwujONwQB0r9AKthespCdOipHR0APqU+Oas81Xbsxa9H8It3zSiuFUPGWOoloJyRjRHm7ahty1aj6MtallCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 13:57:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 13:57:29 +0000
Date: Wed, 23 Jul 2025 14:57:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>
Subject: Re: [PATCH v5 21/22] test/func_reentrancy: fix EAL init call
Message-ID: <aIDqQm5L_TZwOWn_@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-22-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250723133157.159825-22-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0159.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c7a888-db17-4959-3237-08ddc9f0dd0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zMfHiAdHVvndnh95fMfNhcImF3U+jfVADF41iI17mHNkeCyz9rzRCZPNv5G7?=
 =?us-ascii?Q?2YBagr7lrshhOt8966x7GFgYAUIdfeIaQl0MkxMtToX7pE+5TYZGo33eZu3l?=
 =?us-ascii?Q?VNnaTv7IXfvOjtgo007ysExucb+AcCAe63vSo1stWs0nhLU7QceVKjt811p8?=
 =?us-ascii?Q?AcirRO2cDCogRD8DwDIMZv2OUVcA0sxIND0QdFmYuRoj9RDTNJVZ2GRHJBeY?=
 =?us-ascii?Q?CEGB1PaG44/yWentEFVxvYzF1Zb0y1J7UiaTR2CJO+qylLNfTQLEZXAMKBVL?=
 =?us-ascii?Q?0jM1ihl+ROWuGIqTfttxqr42ULsQQ1yBHiVNUopsV6rrRkaIKm0IJEHOcm/n?=
 =?us-ascii?Q?zTFpzd8VQB2Zi3Ksyl8Oua8sV63eXcR/N2Q3DIxbw63F3gKfkSOvOUpdDfgW?=
 =?us-ascii?Q?CjezfDtqKuU/NVHxvSSaedK4sRIzFPcJG9HBTNMh85bRGRQKQ6eTVUbo+U22?=
 =?us-ascii?Q?MuqXtiatToAn8GvSuiHfyrA4UsUAZBHJPrZmMov/PxYsgLHBbzz5Nz+uINZG?=
 =?us-ascii?Q?JuqT0osldDHBFe6VspepDk9n+pL6KKPEHnfm9eAIIYOn0akPT1wZeeCK/H7o?=
 =?us-ascii?Q?T6ZpPtVlzIzWwjk0zzS/1YiDfHfIBIbWnB0GdINi2jFUnuUBr1AWNgrUsGe8?=
 =?us-ascii?Q?b5BA2HWz9dFhPEFpThhoLpaCKMEtwVy/XwfLgxUeaWBRegFeyE96N03Ka+zn?=
 =?us-ascii?Q?kamAjGFe8gyijDRjgLONE7Ch1sXzzJU3IaYSoIsGqhpDj4M2rlaVczMy0zM4?=
 =?us-ascii?Q?cXhlXrl7DLkYDfy0FDHgShy+7xoybPD2Fi2Qt1dD8cbWxaPZ0IAnAUGiSjtt?=
 =?us-ascii?Q?smQMkjiyjGCMWfmV4Kt+Uxd5QC+Y5b8oA0vcpoYqplaq3PAYeLS4LYvGE6f3?=
 =?us-ascii?Q?NpRZ00zF2ojNGCDpSgeh2ReOhstv4zN0UQj4sD3+lCmVSD8KAu0yUb+WMZ5P?=
 =?us-ascii?Q?lTw9KsQjmfZVS1et4m2jFBlnMtujiiY9o0TToT471h/V9DFMUiKhsWK2m4Rs?=
 =?us-ascii?Q?92lU9fM3aMSuPC6tBNnzaC+eDaUONn/3fvrE3qNkzxoS6rc/eJO42w+qh6BS?=
 =?us-ascii?Q?NZDZiLVzXIAF7bnbRXbREUHRxDJpRoIUgTTPShI61gGR3swUU7K8nVSwv5hL?=
 =?us-ascii?Q?e2aPb1R0IhlwwJlTDiIGkpkTc145bl+v8+1YolhuxPp5wXiQC6PXM4kAkYTM?=
 =?us-ascii?Q?vRpOXC52CmDIdLhBvzZbMFAfwqjNpCtWf0hNfBW61t4/oy6OOOBdVZ9cDpHu?=
 =?us-ascii?Q?HLuV4q7Bp+c6am6AqT0JqRPBd9rpjChWCUNNsn0l11Q2P/7G/i2a9AwSMXzq?=
 =?us-ascii?Q?C8tLRDo7m5dmrTwlIb6IW1m46VcnH1pkVL8iQkGyHh2DeiHYsIAzo+t03hzG?=
 =?us-ascii?Q?ua4AH4FAU0HYoYXYnxE8SrzqvbAHl4M812vb1xEaybsRgvzML0RRQjVH8h+V?=
 =?us-ascii?Q?hxPi8YiB1x8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c29W5GJILdpcLqxCo66v7KAo4dh4Keae6IMRZCUhcSrS8EnilQh27GOaeiuP?=
 =?us-ascii?Q?QGAx+EqUTvq5VYJZeeejNJwfRMXYV146YvFJarkkOKR9DaHSS4GY0N6rlGml?=
 =?us-ascii?Q?EfgfLsX+xro45QxYF1dNLrW06WIIr9kEojsFtnC0YOoLPquZugYyqyeczISW?=
 =?us-ascii?Q?q+SptlMrpVOAR4N4PNah2WVWCRw0DK+P9p02w2l1zpcUtRl84zVHv56TfbTD?=
 =?us-ascii?Q?+Hz1gVDOML+1YaHS2nJ7uN1SWl9gFc6wzLEJa7Bu1VbozenRLDAdxNCTwDdq?=
 =?us-ascii?Q?1JGgGzCprU/G42k9VsdaLCdHacZeQl3+fduOcqSpzeysu5v5KVWua+CTWLll?=
 =?us-ascii?Q?zMes2IMlggYj09sYL9+lytvX02gDVcdMHRF7LB9tfRTomSyAmwE4eatJHLSX?=
 =?us-ascii?Q?Vbt8zmfzBXxr7/7FqoC2V5ifp1cZRml0GYc88OQ48GdYD0vKJ8+RfRJpZZ4K?=
 =?us-ascii?Q?3oNFn75vPHD4hdeOebvhlJ/3Bv4J+H2ni4taTtzcpuGOns+KHiM3OjSuXKVq?=
 =?us-ascii?Q?jIqLtUnUw52JU3HhQvXqLWo4rs5SIwkmongCkLruvbLlq7E3+9RltNXJiN9x?=
 =?us-ascii?Q?Un90c/oSO/0A5zMgQYiboMt7Fj9WqS976hZptRU4UUaGD7BgR1kG8iC6lmHn?=
 =?us-ascii?Q?hAXrzyd11AvReNP7fOFtHVNl+rdcNspMjHIEe48/25jltcOOiQ+lB9FXp8zP?=
 =?us-ascii?Q?R2ePomZ8nQHN/elQKgBfnZeCpHXLF5uJcm70px5NQXLwqm1CRW5EMy7hkXhZ?=
 =?us-ascii?Q?iHCADAidJQe8e81s9mh4p2vvKv+P06kP1IFUs1MLPqRYZJAkzOp1NqzHlvrK?=
 =?us-ascii?Q?cNG2oBVvNxx+WX6sYp8gdq6e6PfE5HU1NjdadiorMBAyBPGtVp6aLo3kFyyr?=
 =?us-ascii?Q?4laqtVFuaPjJDeRHmPgKN8QqXPawoi6iLGBJNxeRHWHxt5fcSlyf9FIRjaju?=
 =?us-ascii?Q?HOB9Zc+2j4c2qt5flRF+hJ29e0FHKcsoj7jvH/f39GO97vi5aJ9OqKHj69LS?=
 =?us-ascii?Q?w/IUWuTqD2Ros2W7A9VSfPrQQODhEnlb/hbkoiD/Lu6lQTL4lGRTX5uWO9l0?=
 =?us-ascii?Q?732LbDdAmK9KhHsTUUlXtzHUra8IwjfSogu6HYdhr6o4H8l3FsLwYYktg3tS?=
 =?us-ascii?Q?MVit0V3pRNIVNOnxgEWkTyGOZxjfQvSy160TEeLkiOtezBP3Qj1zvxdYaSjj?=
 =?us-ascii?Q?qXF0kSs1tYjJG9x5ZyiCNKzG9CTm0DP7AtvB6kI+6ipEhC2IQ2Wh+vcQ0OVG?=
 =?us-ascii?Q?Efz7vRINsUc8SgOp9ri/EM8fySofYDavqTd7uewuSxLXESGuKb15ulqk0A6X?=
 =?us-ascii?Q?Oyq8+F4uvTFK1AR2rT8/dj/F/T3HF2B/Gs2q26iRvvkA9m2ixfajjXMbE/B/?=
 =?us-ascii?Q?nZSAm5IBxRNwRiB20XUjEtGrlaM1sTqacOSmQ+gWwcYI8Rii5nPb4AJJkwZG?=
 =?us-ascii?Q?8INnm1CLC4wmtHz32mdcL9Ft2pFusPpdwY+7L7G/m8hKq4pTyhaQjzayuTI4?=
 =?us-ascii?Q?KnI/Ixn0XVwcpfH0T9PFpzVT36T5yfQ1DtUlj+6n7b44t2VEGbCjJHL4gUWC?=
 =?us-ascii?Q?Ex6sywBUx353f270dL2kgNIqCEwsCsFN4mErMFf+yvcEWSdnkGT27opgUZxm?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c7a888-db17-4959-3237-08ddc9f0dd0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 13:57:29.6770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdL0Tc0+X/d8ak6QRgJmyvvZUXdyW3QYX8Qvx6ZbSch2Fh2/C8tIP6+pAMTmEf3/5eSI05oETUfCJqbxVtryMmBkENpPQq8rzTAZIKYuPXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
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

On Wed, Jul 23, 2025 at 03:31:54PM +0200, David Marchand wrote:
> ../lib/eal/common/eal_common_options.c:1638:16: runtime error:
> 	null pointer passed as argument 2, which is declared to never be null
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  app/test/test_func_reentrancy.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test/test_func_reentrancy.c b/app/test/test_func_reentrancy.c
> index 34d685d493..f4c6cbc548 100644
> --- a/app/test/test_func_reentrancy.c
> +++ b/app/test/test_func_reentrancy.c
> @@ -66,15 +66,16 @@ static RTE_ATOMIC(uint32_t) synchro;
>   * rte_eal_init only init once
>   */
>  static int
> -test_eal_init_once(__rte_unused void *arg)
> +test_eal_init_once(void *arg)
>  {
>  	unsigned lcore_self =  rte_lcore_id();
> +	char *argv[] = { arg, NULL };
>  
>  	WAIT_SYNCHRO_FOR_WORKERS();
>  
>  	/* silent the check in the caller */
>  	rte_atomic_store_explicit(&obj_count, 1, rte_memory_order_relaxed);
> -	if (rte_eal_init(0, NULL) != -1)
> +	if (rte_eal_init(RTE_DIM(argv) - 1, argv) != -1)
>  		return -1;
>  
>  	return 0;
> -- 
> 2.50.0
> 
