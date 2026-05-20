Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A7CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAD434066A;
	Wed, 20 May 2026 14:22:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id AD83D4029D
 for <dev@dpdk.org>; Wed, 20 May 2026 14:22:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779279777; x=1810815777;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eqhTFkZnkjCEgcuUbIHrzG6rShxX4mn3GS8ixk2aTV0=;
 b=Ao9a40o+T3Fv2Yt0lxO3z32GP/RFoNwj9NY0zryElTmMxNN5HNR0zQKy
 yLG1+bCcqRN9Y7eRvEdz5R2sTyND+00Q+sSvZORjQZ+UMNZ0OX/yy31f3
 T7EX1VW5r9BhPRWk7kgMtCSgb5/uQbw1WXGaCGM+2+3MXXrUwKw8sxVaU
 CporzLGZ3wux2FXq34dRK+6vlX69OpYlGs4hCkyWstenlHOYlWBJVZ2vj
 AjkokoFrk4lBFl+pP5qDev4ZkGW0SldFZ5JBsx0lFboePFtLvFGsaegwK
 /n4as9UJ84OW0NPHO/VL3bp+XCy+NU6bLO/9nEXBJN5hRSzTiJphTLvFP Q==;
X-CSE-ConnectionGUID: 2tlKfsV2QHOurz0UQJuRYg==
X-CSE-MsgGUID: cq/EbpTyQj+zskOWJ2xVIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="97604206"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="97604206"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:22:56 -0700
X-CSE-ConnectionGUID: c7ESkLxfR++thdWDktr3Sw==
X-CSE-MsgGUID: 17nKUmtgSeGBME3Xyg+9uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="270511788"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:22:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:22:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 05:22:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4BlN42dL4VWKWmUhW5QlD9Tp7URgOvLJKWoLUHM8JioGguPAYF+4WfWuXM7pKpX/hCRjGoC+KASRIxLHu8OW+7oe6s68vaWWGVLP1J4T7kOK6YKdoivjy0QoWnGvCi2K3MV3YGvFlWyi4PAmLCElY52wcdWKuvEKeigKGQ3u6+oc4K8+RKElsLFKWLelPxLnIITBKT/NdLuDiSauHuSAIvJTiJGhYmVwJ+vxPzTwg9BQq9iayAyjAka5KET8LetKb/zPBEvgsHDy6UFBOwbsJwTJ8VCs1C2foOnQ6I5owe9WeFrvCIAJGDQCqY1hb9lfKdSqoALeyOY1Xk9Xuc0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Co/rC5PLQrert0z6k/p7urzYGSDMVFhNKfM33ME738=;
 b=CuIXy3WYePrbaW8xwRZCw4WH0V0DyrP7wnnyV2SH5gGQw3vviYSEvhWmaLHvGySyt8OAOsNBPxsrqMbqjO7LgGs2vioav0PSTZgfnj57MKecqNbqKgTMGGUeQ+BvaZMqfOQkCd0MYLuMyVZNcbGQ5LvkPNBDjANaTNu++4dx5ChlSI76slW59ZIw5Ahwf51od6fDV46NcBEvCG1swGQ6O3UUL3c+yyvtvMa7XxTTqik97rMxQ5pnUL5g7ozOzsn00fFfoNtc+fSBhooGP7DrmXe6UNf8NptUj9i/JaxQtaLZLdITvU942lvpMMPTFk4o6PK6Lj+EZugq2R6kj11h+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:22:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:22:46 +0000
Date: Wed, 20 May 2026 13:22:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 4/6] net/idpf: fix ptype insert position in split queue
 AVX2 Rx
Message-ID: <ag2nkYaEHwIpSt4K@bricha3-mobl1.ger.corp.intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
 <20260511090935.2288837-5-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511090935.2288837-5-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0272.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7728fb-b38f-4980-2e5d-08deb66a7fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 6vKtrn7cZRxkJtlV66+y9ShCFrJPSI/b18TfOkO6ABOMWq/O3FFEGbQKD2Y6vE59AomuNp9QwE9bZPBBTXyAbfsC1VNBohtkPn4IJuU7zXyCAP+jxqTnI8HpVu6CMJtVxsiT1UddSWsKxY0ziK7mK8W7y5gx03oLqe8UF8gzR1P8ruD/o96x4uHK6OHiOsO+E6QGp2/371qjMfDNfIdyHE7d3iZzmnEfSfHHBgYlResPEs8/ETLZvKfoGES5MpKNK70Zx1u5seiQUFphKG/WfirKxQ05BCOg0J3fLbVtTPvHXGQJESBWq5fShZRU3whOPa8/jGC2tQGcE61C5lgdNkn1QDodKAaJpo9zJtLvkCu0IfOl1FbdaJawCz5/FcHsJ2X/DUmCYXB/PVygv5tdyPmxl3hVDbQNB0Y1omrW1pJyAgsWFeiNao6A+Uqmi95VsWEtTENup/VgDlPzMrItVy2krwNFhmLuMzX7kclAIJoljH3n7Of+FgwSijdP26mIZpOnzxBvZj3McRAYlcMo0+Inunt99ux0uzq4a0zh0ek4EFMNvWf4YktMGX8OVv0WOLkWQ4tEMJaBW+sdj90uA5pIQfulVpQaTKq1pPuDFDgIp0J60I4Xg8NPRbXjBTfwYSy1fUUez6rwyNb8k0YegRnQmkGc/tmAoZKvZw3IcarqUKjStJE1e3ibpnfZ83in
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zinkSz4gXFxZhA6F6gDFWyOyVQLlDGC/lCbItntpV02QN9/9OZy5sa1dAVHL?=
 =?us-ascii?Q?yoFuy+XaJAvN5dT3KxvTiaS1WTHtbP3Xtnq7B8YibKOd5deYu5vlAbtzsbpG?=
 =?us-ascii?Q?TxQV63rMCE1tC74d9A58qo0V1j356x8JokgtcLZeKTv4T3l6e08+hfiaTGQ7?=
 =?us-ascii?Q?k3L8OwHk5+Cm/J9Y9ysBWNwAdPjbphKJxm7644ECwmzSBp+h9vZB8++oCHeu?=
 =?us-ascii?Q?Ccs2rSileArJb7fzyfrHD9lqnI5tBdVA66AML5sDZiv0im1dA2DTzTn0M0ec?=
 =?us-ascii?Q?ntyeiEyaOjkeVhu+D0I8V4aQPQMG/+4l9JOTbapISuPPVIXjqcM7PX8aR4Al?=
 =?us-ascii?Q?X+xEowfjuFLi1jPOSeIhuvUljoV/tpTfleUJOY29xugPKDzcRoqUS87atqol?=
 =?us-ascii?Q?V52CElQ9FLTFUIzLLEpxNulsnUlsDDIa5jHvFNX0hhJRKvu+KvphMgVN6zXv?=
 =?us-ascii?Q?dT5cSfT8qTWYPUbNQ8mIgZcf3aZldlC2WanAORnEzTnZqXYxpHbSRds4gr8e?=
 =?us-ascii?Q?66eaPcBX7skQlHe6J2jCpq65Xrwt45nUApq1YOJF0sDBUVpPE4eaWYqqHtzF?=
 =?us-ascii?Q?A4NG++spjsnRepVOSqEHVUiNWt3SI+2Zz95iHqRiYB5lkI5Xh89gD3p99rF/?=
 =?us-ascii?Q?hTajywymksdGP+qwfqfFH4MKcfySFspQz+fJMxLy7PU0Yyjut3Mi0yCTMxAq?=
 =?us-ascii?Q?Zmp3RMT2akWJ/ED3Grcw2J6RelEBcy6o9sHytX8ZhenAypZxJpEw4EMQI51F?=
 =?us-ascii?Q?ldTBay7AshYie2qtTrYVRwM1v3o3eBbLU3Ih2c0Hn2sjouDdxTOt/0KkdUe5?=
 =?us-ascii?Q?/6wdKFXZSjsU0roQzxX+O1txwTChNMHe6oejDofXOsQPxgibPFa77TGcvNHp?=
 =?us-ascii?Q?xHeCPfo+eyeU9MkI/+LW3UdMy1SF/CxXMS4O7avqR63k0WU8DDIuN6LR0eiH?=
 =?us-ascii?Q?CAXMi3VXlZRmnBY0ClHbA/ousppyp6viHp8aeM+/nZK23QeLy+E8oCYHnXP7?=
 =?us-ascii?Q?WRP+gpmXH15ddwoOxjCZT6Y/DHr08VbkoMrYm+ggawnFh9XsyVT89EMuvu63?=
 =?us-ascii?Q?RZ++kK30EWSnY3K7kDwcwI5Jc3LnWSXpnigYRRnkcn0diz38Iz94iaF2gmgI?=
 =?us-ascii?Q?k4LPiQxhCFK4tryfy80zO7Sgn+uTZsZ3DwrqoHUBaYE71jfLPA79kZiZ8Vc2?=
 =?us-ascii?Q?8a7rdtQp7+AJqh/Y/LIGIsFaQAdJcTImx50q8N1jMBJkOnYxQWcIXnYle27f?=
 =?us-ascii?Q?lfuRDnZGZZdzmjE5TWJXeT4ogqiMduaFj2AX5XAm53ocj/NkkEBpifQE8sBJ?=
 =?us-ascii?Q?6Wh83waxa+DHc1cvMX1rq48FE9nf5b+S++JB0EvuTaGi6YBvLPs9VXERgU5h?=
 =?us-ascii?Q?IGie+jzjwZZTna4NzqneVhiqzb9VGsc1ltcVjx7qyrUrv+rDZHWNB4dk2EpL?=
 =?us-ascii?Q?rBVrs24VrvVsfhpS1Uh4ASPN6H2Q5oIXQ8qjRBpEh8Y1ayQpKBjjIPc4QLPd?=
 =?us-ascii?Q?Uy4FvZABW0cxgNRHymc3evKW6acJ1QNicoMQjh/GRrxxrR8XgI9zZF5kyKKa?=
 =?us-ascii?Q?C5OGsA5erf711bm6zmZMwWlzP5PgTR1SRKIpDAv2778b0W8I/Uy0hRmzh85R?=
 =?us-ascii?Q?FRD8EbSw7j7tTnzVDewA5UVlt1Cae+mgEAAE8CpX4PQRgB6pMNDFDrzBAzqf?=
 =?us-ascii?Q?RRhgyJzz0J3p2aE+eSk+QUh+y5iBkfyPKL5liKWtp3ImaiNX037OwAPANd7l?=
 =?us-ascii?Q?PyLsI2MvUyC9j5uTg62DFNtEeh7SE6w=3D?=
X-Exchange-RoutingPolicyChecked: D0u7TGYvxNFSS+DiSqapJGJgK9n8ESDHd9qhUR9zu7OgdpY5zejeNzNAcUcYGPeTYnC4prtyzIxKkbdGbuPEOMJWSCwLybnqhSXxFqH//IKIqrMN8aw4hlxroZDvDdSlLSAx3FDthnYvpYEDoGanywmFP6nzGVB745NH6bS/MGPyEg+IscuISjNOrzLxGbGIZkDWcHvZHnJElUsGu5uLUAJhVz7+CBEHbVlKprGgD5P36XlHwzqQ1xfocRdNT/u2r1Mwfa865+nTWIJ4HkbelUTvaKGCcHRtwXb2jlshKxCvzpKlJUquYcAgUIshLVxMhz2Kcepj6H+Hr4txiwRpHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7728fb-b38f-4980-2e5d-08deb66a7fe2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:22:46.3630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58oBixx3rIP+ZZGgjQIHwUL6uA7/7J0hNcZbvvdqeikOr4l+B7KQtWP3n+DZrAP4iGBMfP5stmTFqjJHp4os4kp7wAt6PF02J+ghRxiz/ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7175
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

On Mon, May 11, 2026 at 02:39:33PM +0530, Shaiq Wani wrote:
> The __m256i register mb10 holds rearm data for two mbufs: mbuf 0 in
> the low 128-bit lane (dwords 0-3) and mbuf 1 in the high 128-bit
> lane (dwords 4-7).  The packet_type field sits at dword 0 within
> each mbuf's rearm_data layout.
> 
> For mbuf 1 (high lane), the packet_type must be inserted at
> _mm256_insert_epi32 index 4 (first dword of the high 128-bit lane).
> Index 2 is the third dword of the low lane, which overwrites the
> wrong mbuf's data.  The same applies to mb32 for mbuf 3.
> 
> Fixes: 1f065f9d75ff ("net/idpf: add AVX2 Rx path for split queue config")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index d3a8e17778..e66dcc7a14 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -570,9 +570,9 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
>  		ptype2 = (uint16_t)_mm256_extract_epi16(pt32, 1);
>  		ptype3 = (uint16_t)_mm256_extract_epi16(pt32, 9);
>  
> -		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype1], 2);
> +		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype1], 4);
>  		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype0], 0);
> -		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype3], 2);
> +		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype3], 4);
>  		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype2], 0);
>  
>  		/* Build rearm data for each mbuf */
> -- 
> 2.34.1
> 
