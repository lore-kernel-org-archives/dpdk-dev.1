Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8135CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:23:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 383D840611;
	Wed, 20 May 2026 14:23:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id EF43840611
 for <dev@dpdk.org>; Wed, 20 May 2026 14:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779279817; x=1810815817;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FMw7+ZWrF+jCD0x+VXPu9fTNPIz0VGvUnoY6CPdz+Bc=;
 b=Fu47y8KNl9MB4SKY72Va8X63JZ7D4JL1iZnf2MBE4AzNgXVwWVvRVdnH
 nQNCL0CMOo8h614b0BkPdWiShIamEfuFgEmCBHxVg8FXD1Dh/CCh+6dK9
 ukx7jzr1D2Q2ZPPpJUrL6Wu8oUwNunwARnzOxWn1TE9ghw7zlKFZWfPy4
 V+XfPeijwSaBfc02xM4JdawRwlZn9tl/pdf99+SaUDU+JoaBrTuypRZiD
 g1824vhnFKNGHCtEwYirRQuywDoJV0Nb2n9Y/YUtTrQsNDsgwRj2AlOCg
 TELLsW2qyDwgDkEcaQ+KHyphZizArjWYgPfCYdlIZRWHvgtQmCFXYHYuM A==;
X-CSE-ConnectionGUID: caMSwJLbTqO/KBWIueO7cA==
X-CSE-MsgGUID: NHxPScKgTZCtdNripsgrBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="97604298"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="97604298"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:23:35 -0700
X-CSE-ConnectionGUID: abn8rs8aQoCu3d03u7EcDw==
X-CSE-MsgGUID: mAyZqBQeSOKjF2wbhP+rZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="270512052"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:23:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:23:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 05:23:34 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9HpnLDezKOZvyPqRZVYNXQBlUiAEA6puign6FCSDmDAo1YFPJrf7IjB85ZhCmXpuOWZbUYeXtnWCZ7xbYmx7ENu02SCgtKzt/GdgGi5+OyKuJzDQwpVOgfuakGM9eGmuxnfIWHkHIVUTjctCRpgnQzlvM4rdyY1o6SDYls7/VLnXoASghD9imOUxh3E/aSIZQgn39yqtYn97O35GommLe/7z7WegmXuTlp+yyxWiXEsNf5oxzXYCo6rpWqPyAJQvJkfJZM0pL+tGmp/a86VmzKsc66dTAxEIJbsKuFeLxIjYRwwjsQ4nIae0BNqOmOXYmCILdwFd7MHo4Sde+X+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeJgyd/wagJY539KLTfxIlPvNtIXln13XWW0PTI7Q58=;
 b=UOAhRq3HLfdjte2V0WSB8MtSj4ruaOpnPjlv7103SEWmFlY88QbHoB0cHxpdJwTtrPVOHUWkGANz86CH+gPQowxqtFCwuM86qlvZ6XvSllhhYG0iMfKl9bItQCpJX4v36qS0uko11YWz+b5cwiGaoFMc34ZfcT9uSZmjtBt0unmw0DSiyezkTAi+yZ/3OlMgRR/m7UtTKGfvAA4hpFbRzA/vqoVIbCpCYlqn1g0WwTIwmLGPGzid+A2o06G9NxlTSGzgxlrWNfU4LU3wwBgmbj1pHPD9MdbCVc43EYPUbS0oUnVy5dO5y3zg2zNO9uvndMBwu1iF45jZNUqX74YIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:23:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:23:29 +0000
Date: Wed, 20 May 2026 13:23:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 5/6] net/idpf: fix split queue AVX2 Tx buffer size shift
Message-ID: <ag2nvOVOG8ORJv67@bricha3-mobl1.ger.corp.intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
 <20260511090935.2288837-6-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511090935.2288837-6-shaiq.wani@intel.com>
X-ClientProxiedBy: DB9PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d5dd34-c996-4648-c9ab-08deb66a99b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: NecXq1Cfw9dyD3sJDdR7B6zx4xiPdiVXLVUlNnOBBFp19wq1s/5DxkZkLDecOjG3XYpiy5k90VehVw7ZblblrhVMtH+7EvHZUjTeCi6BuMODBakvDAjanFzGKntVWwHy4JobRLrPcCftGlDPeCY/stvWF8fK+cs9uYmOFiF6GZmQiYpT4WvBvBq3CwVhB8CmWsSCXRWt4/l3ksIsyfrk8DKXvlKSvzD/0ZI+iB3xTrAFaG/jIr9XpFAomuRAAMcGsf34XoQgaI74gSsHpEfP4qo3tvIsqxP2Fm/G+pWTKsyCVTPANy6ecOSRdAUysbyApRmvITHfwe7cBf2Qso5iKrxnZsLVSucSOJ5xX4dMwNhNLH4iB7iZFr6R/YV5P9CV44HwdBWPDOF8ETwgsqXAVp9fV2gEpWFlbX3NulF9lP+ybS3dka6HAODfXT7WGny/Vymw8eoYPy8sxU7XQv1/DazKmEpxaAVF8n2irQ3IhT7UtMMkswHLC9piIdRGW0tnpynptYvmYpv/10Yn6iCY6Ng32jvpvYGdkNPXMRU/Jw1/P7TuFHfHHCQ/aADR3Fcs9FMmBqGWqKT/MqMcPL/MUl4t7Dje69UBmmBoqgsNiYnqtPt1VHrBLVbWWlMFY+3+IG1XQdbHp7wWnIw7VJSmXmxDPreRp9aoCZeNG3E04fH4eUmZLX1GfbxTCW8VxhqW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nH/n2M8ikJTM8Mv+EQjh+hM0A6MsKEG76D/DXYxnWZtG7hkjIdD5CoDpoEpH?=
 =?us-ascii?Q?rm5YkdT0X0w90ArOnjlzM875ZTqCsimqXFfNabFlKvVabOSlakkSghy19waD?=
 =?us-ascii?Q?jdvedpQ72rPajXe1eq9ziMrJPPzbLn4hGrdJUVrA2c/NUb8FGJKsZo/Jw6ga?=
 =?us-ascii?Q?Aeo5fKluo2eLl/j7EhNjuIrDybQ6Gj1qP7IrBc7v/cBR5hIHcCZlsW0dqm5i?=
 =?us-ascii?Q?MDuZ4fRWW/2uEiZeTXEfMFCN8LR+/IB+zQk3SiGSb0oKl/8GGVwoAOx9SgxS?=
 =?us-ascii?Q?7Am+JfZrdV1ITq1vzXeUTRZMiiRnmzqiEPup4ePdDlAQR1VuRUu2lhpjkxEa?=
 =?us-ascii?Q?KxZS7lhL5HwoesaHwF9NHWZE6yygNW7Btr4jk8dJ6o6Jo2dTQHjTQ7ofbroT?=
 =?us-ascii?Q?odyVJMrwIaB5JrI6LBl4WUStCzAYDBQlNcNltwIFe0FDvf4icDABDs0YgMjL?=
 =?us-ascii?Q?6OjkqFUQ9HZjEmrbLpCjtwLQaWIaKjhO+4bHeUhsMfjvoR8vTX7VRqiAmg16?=
 =?us-ascii?Q?3zHvMcc0ZMex94Ac+85Ms1tVQJkLTv6W6TcznXq6h0BJklRyrJ4JaM5aEB3j?=
 =?us-ascii?Q?g4nlduWUNIZzIR7DoPyaaQCJb9zbgkfKbmmGFvA1N1jEC7yOdj8nJNsKZOIz?=
 =?us-ascii?Q?AyxLP5UrIsx3JWOcovyVouAuLLqqu2VdJyTzckdza+caOmxu9dTC8B6zcx4F?=
 =?us-ascii?Q?sCovt8KEgdfQKb9dR++4X8NoBmuFegtJiIHvyS6jX4+meEiRNxevjWAWu83Z?=
 =?us-ascii?Q?ltCgTIfeMIRHCP7bJ0/D/2CFIEpwxLe2MtKN3Wnlz25WIdaK9f5VI92udrn7?=
 =?us-ascii?Q?w51t2VKqUWIeO4FhnVGoIC1HWLMQAarxT7CEYIpoaND9I8zJBtq1ko9MPh0C?=
 =?us-ascii?Q?XZ8iyy+NLY4DNzNd6XvkzGwg9ojRYtz6ulDk7Pkf2Ejp38seiT/hZp2C1awv?=
 =?us-ascii?Q?7SZrrjrnIlnPofflhAtt9qWYVFUaPRgNSIRw2QNc71h+1rL0KbKPC6OyaCE8?=
 =?us-ascii?Q?NLmfOfkqHWQjHtYiJuB7ykjNAWtJT08R2OaD8BNJwrDDXYYhDgNxKVbG/AvJ?=
 =?us-ascii?Q?8wt3LhuTjl1znL+fOvx/Wn0HDh9ySaiVPU8umGRJYaycTAwbnTkoEUbQ66F9?=
 =?us-ascii?Q?PJvf2c/LOqDnoh1wBqUrIdnzPt6vC4P88SB38PR2sbmYnSXaJcSzKmnHLlSY?=
 =?us-ascii?Q?ignBO2OLDhOCUvQ8FFziiv/sZdsKg1PlrA/3wfpB769PTjHNJLEsShezu65s?=
 =?us-ascii?Q?3fHgJeR9cFAIjTUhdRxcccSmoUbx2KOwhVZFS+UL3HBH4pvD8Tg7x4l6TUnT?=
 =?us-ascii?Q?SP5FfGpc3qq3TvaovqKM8zdp0dP85G2zkBlmZa6TfZP4I6GAg46aw+bnru1n?=
 =?us-ascii?Q?eOipmJlZDyAWIkCN4cUcRshYEWubMr1TFXMg2vnyCfv9bP7pJjQITSS+lprC?=
 =?us-ascii?Q?in83UjvEXiJ6FStOzSbaNS0abC2bAfBakNKgsdZec+KeF1opNIkIw5EMa5/p?=
 =?us-ascii?Q?mG4kNKwpn9JPqBCrtFSlCHZu/g6JWQ5qh/+aU2mbEQwL5+3hC0p/A7OY7tNq?=
 =?us-ascii?Q?x3wmodWmL/IiD9ifYgXgbfB/DLpUYyoJ880W8rtnOelPsph61/Xf1QK1irx6?=
 =?us-ascii?Q?QrJo5JQn4BeUZBJcFO9yGG7WIb6OGO/IT7vPbDR6sV/8KVD4WGdrXDg2Fzel?=
 =?us-ascii?Q?aVq6aQITSFUigk7SHdvnpgWz8ApPywhNEMvHHV36HiLEmSSJkEdoXWNxWJVf?=
 =?us-ascii?Q?pXEM/+W9TZRr3BOJXugY1saHU9JcqwY=3D?=
X-Exchange-RoutingPolicyChecked: YPCL1vX+opr9tqOq4pfOrjAV6U1JMctvXujizQDwWYTuy9Kk4FAqVmi4y2KyCZscwmcwPxX5+ir0SUWJf4XsIn5njkUCEwBasR0IiRfnknzSMGeb3UzuepDVuS+rpHt+69dydlLdLYAGdRhzrsCuL3Q+oqYwP78DOp87ECQDccOW6Q6z5sjkqabrAOtBeaG1X3RU1WnjXtMSbLehllDeOvNVuY8WKhSJ2wpxO8g4sTdUcs8fKz1nLhVVWOcUI20OK+ZjfoHRtmbBpDWKHPVYSusorwt1o787FE9pHI34aDKrg7w2+tl+XahA/T/R0FnVzAhcofY2VfyYZMxctU5fdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d5dd34-c996-4648-c9ab-08deb66a99b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:23:29.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T23oDJgkemRKm0qI4Ql4aCtKNJcTl7EBnTVTRBW+O/ztCM16X96ayeatuJlJy9TVk8NP6RWiNvoMX431BidMk+HMmklGXrpGT1tP/XwRi0U=
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

On Mon, May 11, 2026 at 02:39:34PM +0530, Shaiq Wani wrote:
> The flex scheduled Tx descriptor (DTYPE 0x0C) used in split queue mode
> places the buffer size at bits 48-63 of QW1, requiring a left-shift
> of 48.  The code incorrectly used IDPF_TXD_QW1_TX_BUF_SZ_S (34),
> which is the shift for base Tx descriptors (DTYPE 0x0) used in single
> queue mode.
> 
> This caused the data_len to be placed in the wrong bit position,
> resulting in hardware reading an incorrect buffer size of zero.
> 
> Define IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S (48) for the flex descriptor
> layout and use it in both vtx1 and vtx_avx2, consistent with the
> AVX512 split queue Tx path.
> 
> Fixes: 57560a92167a ("net/idpf: add AVX2 Tx path for split queue config")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index e66dcc7a14..7c547b5f09 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -819,6 +819,8 @@ idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
>  	cq->tx_tail = cq_qid;
>  }
>  
> +#define IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S  48
> +
>  static __rte_always_inline void
>  idpf_splitq_vtx1_avx2(struct idpf_flex_tx_sched_desc *txdp,
>  				struct rte_mbuf *pkt, uint64_t flags)
> @@ -826,7 +828,7 @@ idpf_splitq_vtx1_avx2(struct idpf_flex_tx_sched_desc *txdp,
>  	uint64_t high_qw =
>  		IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE |
>  		((uint64_t)flags) |
> -		((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		((uint64_t)pkt->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
>  
>  	__m128i descriptor = _mm_set_epi64x(high_qw,
>  						pkt->buf_iova + pkt->data_off);
> @@ -848,13 +850,13 @@ idpf_splitq_vtx_avx2(struct idpf_flex_tx_sched_desc *txdp,
>  	for (; nb_pkts >= IDPF_VPMD_DESCS_PER_LOOP; txdp += IDPF_VPMD_DESCS_PER_LOOP,
>  			pkt += IDPF_VPMD_DESCS_PER_LOOP, nb_pkts -= IDPF_VPMD_DESCS_PER_LOOP) {
>  		uint64_t hi_qw0 = hi_qw_tmpl |
> -			((uint64_t)pkt[0]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +			((uint64_t)pkt[0]->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
>  		uint64_t hi_qw1 = hi_qw_tmpl |
> -			((uint64_t)pkt[1]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +			((uint64_t)pkt[1]->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
>  		uint64_t hi_qw2 = hi_qw_tmpl |
> -			((uint64_t)pkt[2]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +			((uint64_t)pkt[2]->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
>  		uint64_t hi_qw3 = hi_qw_tmpl |
> -			((uint64_t)pkt[3]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +			((uint64_t)pkt[3]->data_len << IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S);
>  
>  		__m256i desc0_1 = _mm256_set_epi64x(hi_qw1,
>  			pkt[1]->buf_iova + pkt[1]->data_off,
> -- 
> 2.34.1
> 
