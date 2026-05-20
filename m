Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D1CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:25:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C0AD40611;
	Wed, 20 May 2026 14:25:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 26CA04029D
 for <dev@dpdk.org>; Wed, 20 May 2026 14:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779279956; x=1810815956;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+J7VszfAB6/pi2V7leax+hviCEUQubOqq8CSQ/xa7Po=;
 b=S9QTicVDU/CIMFn7wMAebRGrWM8NTWbkj9BUIj4zTeD7oSuCKNj6FHXA
 M4KOjVyv52h35OuvnUXTz0iptfuqzzIPzn/58ICvgJu1V4seFNCeVtHUC
 dpqCFMXXfSzYRG1MMsNKTTWrJ8ju14TomVNwaSfbL8CKD83F+PSfd9ISF
 QVUljmJKH0euNEG+YT04oVsSna0XiCaUkHwiehG0ub9xcNfC0ftosNdtF
 CiUb6Sgq65104rf2RbHjB1HG2uieF4TOadGVYNoCIu0rYTKPzTpn7rJUR
 mkXVXW+OjGSMvGrPGpvM+3+2HuUEXyh3eZoS+M5UvFW5n6TPnyoe+P3Dl Q==;
X-CSE-ConnectionGUID: kgWlQ+BZS36Nlr6j/hrCrw==
X-CSE-MsgGUID: /qYyGao4RvumoqrtPJxzJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="97604680"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="97604680"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:25:55 -0700
X-CSE-ConnectionGUID: colAdGMOS06oRDFCCe5IAA==
X-CSE-MsgGUID: ER5i6cEbTuCEyohxrzVarg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="270512621"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:25:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:25:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 05:25:54 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAHviFiTMAnZJgqX9OLWt7LeD7S63WdVI5NjjjijLu3j51DR5DI8ehlrrJf98eJ5mvqv5AxcNqpbz60mtFDaYC25dJUpNyt9q3nrrIubb0j04sQk0Azx6G/Uow9mzdvHlbTThVbg6L5jkajKQtdGV4RZE3RiO2sPqolpjfqt1//T6mNkMovNlg7YDCENLjLw9zA+TGLfsyjPFyD/TIeDS9v9fQQIzv/6D/N9Je96QUReEbvkDhw28caMkQpSre6QdsrICXdr8HcrAZcwlBH9X5dRHRG0L4EZ/d75vkfYHv2pAsbuFwTkE0NihKKytPQhveam+uGgpoaWJ3fhX5Csbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIWe+/+CJQnaZSzHdyVAVn1rqZJTdJxNWIYBjbTUgLI=;
 b=lxV/tfYAPPTsB3lRvV9YUOUAXUh7q3uIp0vBZbuY54iGvqBsSvw4cDu4E9oi6a1+TYbS6BvPg9DprONNCcWFLge3FyydmOUtjxhzhN67kGDpmRm4eFyxiTHmQJ/3PUhmq6mXS+tjHyil4NEKSPSi9uCJFMMHl3Bzingx0lVSWVHouX4rddjJxvOQylHohFEQFWob4Xc9baE+X/E88OWh/W4UC5WyY3Ocl3GUn0j0VmUd6UyCfJmvFtjpn1PKxICYVD7DKQq/xd+x1YjngOI/foguw0yNVe4SN2zd6KV+v7wQ801brdTdX6c438ekOlLDLv/Uo3txQHyFwQX6TwazLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9448.namprd11.prod.outlook.com (2603:10b6:208:572::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:25:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:25:50 +0000
Date: Wed, 20 May 2026 13:25:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 6/6] net/idpf: fix split queue AVX2 Tx burst and completion
Message-ID: <ag2oSQq8lGrbm3qi@bricha3-mobl1.ger.corp.intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
 <20260511090935.2288837-7-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511090935.2288837-7-shaiq.wani@intel.com>
X-ClientProxiedBy: DB9PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c771a82-c469-40bb-d961-08deb66aed5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|56012099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6f6uEsqRNH4K5cs+cbgYgQq/un9qJ5mzXJW8x+TPDHP8HzCEcyuq9d6t9IFgsl1lJkMRoVFdUwDY+VwmfJtWzeE1wSnUEGpdalWIUk62hs37gg5fpy/MrJmex3NfjkkB4qZyoQp4H8CMxEVU7DmV90d+y0Mlaan6jGPfgJ5XVlaA6/bGq7YcJ7120DKhTAleAXais+UIBWw/JS9bdauMzt6jVumG3VkG3fcHiJZoAhKLdHLgkGrrIM3/QJZVgK/CHUTDjHQAPsg0qCf8pRyuEBDW50LjpIRvYbe39rGCArz0xvtVqcRK/LvXm1ZiOwhUiTqOlPRq/5RvwYMHza6gAGQkFU1ySEegIu5vf5XuflHmEifopxb6LzNzq1oQnX078DC6LNbL1fVbmQyWVKzoU023A38UxBwAVfIgOaXY/Ww1x1T1P1uh+mMXOzDoGq+aBhO/ZhwgEJeKCfb7e2lQU9gFjR1MDGJcRd/7vRq0xRyx1UTm4IMVDfRFQhElSHf0CRvFjdggHZs689vFS/zb3+nO5LbDV9p3N7+zBPpoudVto7UAxpVdCk8X2U2wjDhnVNB2Nuiyb91Nj5hFdzByROl/SY2asJwWpX9a9uyWgA330pbKAhGJAug24L6CT/KqQJEsKBE9x9S/I1Bk7z0Hf6C4aYseuiMNmPV5gQPmXNCXxVwrPjfwhc3lQLkLq3t1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(56012099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ag/c8Aj2Om9GNKdkqF6kWO3JZ0Q3az7/g1A3wtQB/wLkKYveWEUJAt+sjxnK?=
 =?us-ascii?Q?wHVY/eplWKyCQ2AMDfNIPX/7JJ0x/Tv4kIN7o9XQ3XrVMtX5wlNq3V8up2F5?=
 =?us-ascii?Q?wMHqywa1nka1bsw1yrjYUB+Q6YraTEWkPbmUZqnwOAKXdoiiu0mh1bVTnJf2?=
 =?us-ascii?Q?Nd1QFF/mXr4J0oqiQf7UPLztP42snHIvAX+JVQMoBHbCOPMk+Iw274oDnVZw?=
 =?us-ascii?Q?bIdFXz1u0YdaL0mZjyy9A/moqeNLZKJ8QmAlJ08BDFGKTdGyDj8iIhNgs+lH?=
 =?us-ascii?Q?TmQUSzMavKKzCnncotHFvTeUk3HLIV0guhJ6VK/iCeKCdJnLbpDElFjBt4xx?=
 =?us-ascii?Q?HqC3DxSXx8Zz2zFkAdaYAGBhTcg1sfJug1UgxzpmF916/xE61krC1XwozjAx?=
 =?us-ascii?Q?aXCVtb0mx7GZ2zF4/+79n2klwvENtwQbVnxXZDjgqqV17U1SAUjo1+jQqM1H?=
 =?us-ascii?Q?Q4rtX/MaNGTNox6jwSU2NFur+NRdnMxR7M8gmzpSSvumcpkb8NmnhzmpZfD9?=
 =?us-ascii?Q?GXTY4x6SUcKxdeXuKxwAVpfKp5MPYp5q/4v7lbek9TlXKmmf6xBL1gAK1SoU?=
 =?us-ascii?Q?4M2TFBLAI60B5VNxjFHErXeD2APk+pMQqoAEL1gpUSI2jRHN32IbP/q6pCTa?=
 =?us-ascii?Q?RSS5DoPpCzzocDP3fm0IV7eEwuVqbvx1JpBacYHR/5tWKml0sscbulXZ5+Zn?=
 =?us-ascii?Q?ZCClkmgl0LABhEmQZQcFqDxd4+FuiRR71CIS5zxN5Wv2sFfDiYbYcO5PwVGC?=
 =?us-ascii?Q?+WOt7CXbKF4P3MCVbskjfvkY1emTMN98BgXA2UjjrNpJqu58tLBIS8qyMGcM?=
 =?us-ascii?Q?7qraXJc9xOP9ZPnLjTlzS1cVTgbkxXzCCs8ChUV3Tei+zrDSbAte5GzjHDo3?=
 =?us-ascii?Q?JDIFCIs0l+vmdQwo0tLnLHOmRDV/r8HR2yA+4iGjznU6QVXd+mDOKMliH7OX?=
 =?us-ascii?Q?mWwCn6r8WoLPCAU3+Ar9vbVaFdXq9jDSpYCdqb/EnjpJgrdhh8FrocMWOimd?=
 =?us-ascii?Q?NTQvsnOp7+IUbL7vkyYOzNl0cyHRTOM+c8dUxXh5/0Wo0aA25gCbxp9iIXpA?=
 =?us-ascii?Q?6TSMUW+Bf7aKPpo+Y828byYa5/9Xo4CuWmFzhmPYUUSTyszSoHU4RTsRecgS?=
 =?us-ascii?Q?DgEIwf7OTXf59PDJEJxmCZYNG5W7LSbwPPRbh1QYy9FJgNKVBzmwy4mtkLD6?=
 =?us-ascii?Q?8PaGIECaLbykZaKA2i9R17lE5WquRrMkc+Vz28dllGxez0YZalOC1L2c93kI?=
 =?us-ascii?Q?gdkpCAD2PeoGN5DcGAgu8uABMn/IdsNiKypP74JDkxZB8FAbk/CfYkUEtmmV?=
 =?us-ascii?Q?QAcOQCMdMVRZqmOmy4vigQt8MA3vHWoZQlnC22PNbV2PCnqtGRoN+Qrd1tbC?=
 =?us-ascii?Q?XnrLFBO+ii6VgbKq5kMq4B81ru91kp1kuDOM4MHYt9mvz++CDhTR1Iuzrb6E?=
 =?us-ascii?Q?sYBNSo255Ijh8dqPBXAfJGg2DUSpDBE4EHRFXH9P6nOLc3r/vMl9ncW9I9OO?=
 =?us-ascii?Q?BSQeLYwCBUXBUlPOsY1cNQVzQJvAYl28Pdmc0kuEWH3WarKNIkfdpJLW+KGl?=
 =?us-ascii?Q?jrfspKcGbcZgVzOlCNzqf1Y2ibpVlBX5BlJirmLgjfsReGLRxcXPxxj8Emvi?=
 =?us-ascii?Q?1JBcuBOvtywIjWVivbEvObxdauEc2gpRI3OEaAcybZMGSX6hhDSnFlXzNShw?=
 =?us-ascii?Q?vExnrdI1pEz3pGk5FWqZVnDuxMK97/QSaLR52CiT63Nqngor2IR57qABvJS6?=
 =?us-ascii?Q?a8NfKuKgaxHuGlBuI42d46M/nATaVJY=3D?=
X-Exchange-RoutingPolicyChecked: F6IgUfPJGWKI9H27hbDkr7Rvosn+tHUaTdvbgOmpipwLLSb9JjDdCm7Ggo+qz+6M//MibH7NHMoHIDaUSrbPlHpw5Y7w9qxvcDVjys2CD+bSbVe1tjfQBhXh35yPQt2D8l83mUQweXfgdxc43VEk0gLDjjTFgFnC0B/JBN01cl/oEyCDnMFABMeF4kCz/0iF4phkhFNk5QFSPbZvmCO3bRBvBXFraYXnJJSzHsyFt+LmOkReOkXSP9Y01gRaPJ8ZoylBHmGjFuXZB6Acl47rZ5XCDjdRtda5wH11P+a+kg+/wJh6rVZmeygEjjwBrz4MLeVkaWBVE/OlYv1Pr+BZ/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c771a82-c469-40bb-d961-08deb66aed5e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:25:50.0394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLWoabjVJcldqpctnqh68UbUih1YIqv/X7i+Q+U2/kdRFU/+6AFmKH1up/sumVEmr+k++D4/T344TUrDudougiz7oOSm9xVdFFPCFNCz7eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9448
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

On Mon, May 11, 2026 at 02:39:35PM +0530, Shaiq Wani wrote:
> Clamp burst size to tx_rs_thresh to prevent crossing completion
> boundaries.  Update tx_next_rs on ring wrap and after each burst
> so that completion tracking in idpf_splitq_scan_cq_ring works
> correctly.  Fix sw_ring pointer to use base-plus-offset.
> 
> Fixes: 57560a92167a ("net/idpf: add AVX2 Tx path for split queue config")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 24 ++++++++++++++-----
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 7c547b5f09..b6c4fdf20e 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -884,17 +884,21 @@ idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
>  	struct idpf_flex_tx_sched_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
> -	uint16_t n, nb_commit;
> +	uint16_t n, nb_commit, tx_id;
>  	uint64_t cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_EOP;
> -	uint16_t tx_id = txq->tx_tail;
>  
> -	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
> -	nb_pkts = nb_commit;
> +	/* cross rs_thresh boundary is not allowed */
> +	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
> +
> +	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
> +	nb_commit = nb_pkts;
>  	if (unlikely(nb_pkts == 0))
>  		return 0;
>  
> -	txdp = (struct idpf_flex_tx_sched_desc *)&txq->desc_ring[tx_id];
> -	txep = &txq->sw_ring_vec[tx_id];
> +	tx_id = txq->tx_tail;
> +	txdp = &txq->desc_ring[tx_id];
> +	txep = (void *)txq->sw_ring;
> +	txep += tx_id;
>  
>  	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
>  
> @@ -909,10 +913,14 @@ idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  		idpf_splitq_vtx1_avx2(txdp, *tx_pkts++, cmd_dtype);
>  
>  		nb_commit = (uint16_t)(nb_commit - n);
> +
>  		tx_id = 0;
> +		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
>  
> +		/* avoid reach the end of ring */
>  		txdp = &txq->desc_ring[tx_id];
>  		txep = (void *)txq->sw_ring;
> +		txep += tx_id;
>  	}
>  
>  	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
> @@ -920,6 +928,10 @@ idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  	idpf_splitq_vtx_avx2(txdp, tx_pkts, nb_commit, cmd_dtype);
>  
>  	tx_id = (uint16_t)(tx_id + nb_commit);
> +	if (tx_id > txq->tx_next_rs)
> +		txq->tx_next_rs =
> +			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
> +
>  	txq->tx_tail = tx_id;
>  
>  	IDPF_PCI_REG_WRITE(txq->qtx_tail, txq->tx_tail);
> -- 
> 2.34.1
> 
