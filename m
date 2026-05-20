Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BAFCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:21:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 645074029D;
	Wed, 20 May 2026 14:21:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4E16A40144
 for <dev@dpdk.org>; Wed, 20 May 2026 14:21:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779279660; x=1810815660;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Skzw29ZI83uqdhqhB2HNJD7tHt3UtoawXrEMSG5TpkQ=;
 b=MlxcaEDD7TPmiuRgUvHpgmw1bGEPnDf4tX/zTqdCRAkCn0lzfWedFI2j
 GnaMLHfK33viXTVlHaHJpVQyuGHuw666nm3D/9BX+evoCVuCiUg1Xl+tt
 POsXP/cgyKsGFc+NbmkSR7MB8r5VaguFOnplb/yUKc35Fs51eger5D4gk
 XoVyj489DHCBgD+0Ci+tXLPR5j6GR/xUQBd9g7gIMm+WOxgADwuZOcNhn
 0o705+c9ULho/Ef2Iuncxc8kDqxrtYJWz+K93/QM7Qpa85EGEHj0Ynh7+
 HgqBEJSH8Psav+vvv3IV1Z/OzLVi+rGxaWCkSyiWn8/JzNgkCCmQtMLtv Q==;
X-CSE-ConnectionGUID: hNIESScTS5eAWAcWVjUAUA==
X-CSE-MsgGUID: SWTrK8VuRti24lyAV739Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84056807"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="84056807"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:20:59 -0700
X-CSE-ConnectionGUID: znaTN7C+TtCTIt4SfH+MLg==
X-CSE-MsgGUID: JHbKnVXNTFaXpyfvogeIeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="239315515"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:20:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:20:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 05:20:58 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fv7viOz9dYS5LKHqcZELyKsoCUptMjuc/WRfn1FKvPIiiBKbHcVQGqzBkvXAEZ2K8HdrWBOfhBWLEhHIUBL9NUDIoRwQ5fsqwpfbPN92R79oPA1fSxmiTbJt41z8b7/m5xpETca/sIZsY0OGRtIRQxt1rhHh3e/BlcFBaOfMhKrLz6w9zhvSkCqvwBJ+ZFrVRH6D+KIB70nTZt1QSsf+Xe1Nc2feQePQ5yEcDAuMpw8indDF/yzRupehWik2fCj2Fs8sd6LRTI/AOM7FlgffSwRThOaaFewo6rSAqTs6AuF4GRrh93k4wPrdDHUdLiD6EKF4ZsB/5ETtamsLfGTH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o72UGC6TjxQhlTllCpMlD2hQhLhwpFmZA4ln8WWYi+o=;
 b=DQAznQuA5FhwvMgdTKd1LuO1evCrmywevYW8EXkCWXyTi/m5QAPP99EagnezLTnO5lMGNaV7g1xDBREF3OwS9V9KRRVHzE9jBKaAwEPpNcyTozgp2mgBmQzxeYjn66BMLGIOMXjnQlCgJFgsOLwnT2TZE6/6BeTU//ERUBCxyJuVXY9wTULQUHidy/y/ggkw8tnHdTRPJLdogWS4pb9YI5LVhTBLvw7oyzJFYFin217ewDjdDjxmjqwqF1Ic8wNtVxxRS/GTvQjJHdT95jdodH8ECOvLkFtHzwoTByNwOi/Sfbh3dqbEoqCbx1XRR0nAGTr19Cbnn9Af1Ev9NNR8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:20:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:20:49 +0000
Date: Wed, 20 May 2026 13:20:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 1/6] net/idpf: fix gen bit extraction in split queue AVX2
 Rx
Message-ID: <ag2nHHmn-A3shpIE@bricha3-mobl1.ger.corp.intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
 <20260511090935.2288837-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511090935.2288837-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0239.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fb7216-b522-4611-0b99-08deb66a3a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: F7QitDpK8uMMzG5UYmbqo/Oz+iIB1JKD7wLj/0t6rbIad//O71EpPWlhf6O/zQFwlhzcgA/ONa0lyoK08JlHuRnoh9EjVB5tuBbEEtJq2RGDBaRVs1Dgsw5zxNXbdbrFogzoA1qoqxYW5kq/wLx9rd/Zi1yNZCzFp3Ti6aK/DwCCwDvxunWSG4JLNtjuE6uzTyxPLmpsAVtlbw9bqSxN1sAcMlrOqcIniatqgjFcyTmB9lytv2XtXu4P4EquCz0D9iZah4C6Sww3rvt/afLwbeMFHLQcmK10LEDkhoeesZLg+VNKgKgUXgguZzCOqnM7pPnDsCcHY2iyHDrNldnzw/hpvPjKuUqpLsXj/7nPpcnl8QGzOreZ6AweQPEbOK6DSLL756DMIeWsRqwRsN2Aturao+S7MJIt+nxiN0BKDx9MP2ewMBgzCeeESe9j2WbJXL+9rHJZ+RruqUN8S2+e55DI4lX3XMgmBtSx3vIMNVNBpx6NFt7rCxLyVZnp+am2kbNVysFUitT7gVrRievP74nyCd/zpx/UtQvvESZKCyzMzFPyZgSNqWb3rUF/ccZfuEXStber43G3K1jTkaIXWjq4Ni7r1wcOaR+IWCA0J5JA4D3W+Yli6sko0+cmCdx1ZYNU0tEOn0fgzs5iB6PKfLvaA/N3JvMNYcp1AjscXDIgdEBFYY2qHSzKg5sTYrG1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uJy0+prH4skZFpI/Hj2tZLux/lQxoPJaCYqAeDF/iI3ZYMcC1WyLyzg8pMWE?=
 =?us-ascii?Q?VCaYrMo/10JXt0ffEGMaU6cjDvj/WV1cvhAdeLIMwZoOJ6+wm0IGjh9BI5Pa?=
 =?us-ascii?Q?jJcL1vZ6BlI3FTtynezS1pTQKiiOF0g8eHj8v0kVPgdF08o7EZAwgG6xSA4t?=
 =?us-ascii?Q?1Yxp48EWBitB/QmaiN1wQ2YZ6zngWp7cYiZgwnRUiAbz2JWrnjR/nvR1fm0H?=
 =?us-ascii?Q?io4sWMUPhzqzx+1Ma+F9NAjFTY04MLdhQp15UdggkNhHVyAjVIuVwN831xch?=
 =?us-ascii?Q?nakh5qC10eBvuqxkTOqZWYnUvZpD0uHrzLCwcX6ti1rOyiDS60da1r2vRN2X?=
 =?us-ascii?Q?RcaTC4pTVAwkX/9lhG3VSj6Wh3B6B6WAmx1iFichzcG9c+fkurgTZNhBvw73?=
 =?us-ascii?Q?aFYGNdBjEVDNhrlzoGp0KfmlcFwfsicNyj7MJDLUjFLL+2uPFUL/VgkeDCMb?=
 =?us-ascii?Q?acJCbrnRlh0YZ2zYLigBsAhD1gqOUMUQhHWl4ndiKnKGzXpruXNxrIdkhoH0?=
 =?us-ascii?Q?N05A4dPNRfwhnRQSmPyXbSDPa7JCYwK93Vk3RaF/t2nCy7/5t/N2ihVthGTb?=
 =?us-ascii?Q?WOTeXkUDHUT7pZmJBJdj26ddhQV9sFLnROrDE7r7XZ1i97RSqGaw8Fg+I8TE?=
 =?us-ascii?Q?NDqFhenfPQsgTtcaQjq7GAKyAZhYGd/txQvAdpazra8j89j+arglBCdGbgu1?=
 =?us-ascii?Q?nqmxQwo6XEXcatQ6XCY3zS53nugLSjLFIDVQC7h6C2C+tOkRA7+TII0WrlGn?=
 =?us-ascii?Q?1qK+4d8WymQ2UiOpRsUKMtVUUe/NMLrbVAHjt7X7JFHdPaXbMdM2slYCdf+n?=
 =?us-ascii?Q?aVsmT1ffPyArhmSZ9H+Fg8uBL/W2SPkQQ7VzKiLQaaU+jC6hgS/6+723Kr3d?=
 =?us-ascii?Q?zgG8o1q8pfKTtE0uS9EdmDHOxP6EUrCD1aT4BB0kW/eTHWoyWLPzt3SRI9gm?=
 =?us-ascii?Q?YuaslUswLSVhN8Q61EuR0mb/qXn5xMrVYeCnpBnENB4SHzTnejjL0YEXHz5H?=
 =?us-ascii?Q?3AXiWj8xrHtOEYNyT4c58hmXOP6PkJRWt4GOLkDVlJOfcGSdQUKzFY+hSg3N?=
 =?us-ascii?Q?CmXWuHj+88fPA4gdy7sgIpp73J3E80eXq9JGtPKO3B4zRvoY1r7RpLH6ELkW?=
 =?us-ascii?Q?S7u80RS+qWCXU00vwaiDqeV2282kIR+CvYOmYdT3iHVABj4u2Dr2mCNLmKLo?=
 =?us-ascii?Q?eh4wnfp6Nkgw34skd/xIL+5/NRZVv2y69jXW/8RdBEJEEitTKGPTIEoizedl?=
 =?us-ascii?Q?Doy2gFghfUrO4Ggm+mgJt6zKB5/ARJ7HWPukdyaM5YfE+B5API6KcYxhdZVj?=
 =?us-ascii?Q?+/hdePqKMtdOWuOrQLea+TdKFeX9xtPdkcI6K0G0cmGahWt0S+G0caMHmPdn?=
 =?us-ascii?Q?8uh17/myPX2AcZeQf7hIveZ4r3ZGm/H0Hgs7sTztqxyUyT6qF1Q8lw+mnasq?=
 =?us-ascii?Q?v0riyYAaLni6hkv7VkMFQDVxNm16JfgvfuC1BsSfIYoEcg4YenQxclp1DB7W?=
 =?us-ascii?Q?yUD0wEdBD40TPd8M+GUfROBQxxkCljVJdCL0ozLMQh2OfstKu6bzPmUl+qEk?=
 =?us-ascii?Q?CtZgE1+y+GHzZv7m3yhGp9JxyURBHW6zV72CSaMhlgs52Aba/tPm1CHPJNRZ?=
 =?us-ascii?Q?ZnmDNgRSDQEFJ4qrVaPw/U1yzag29zmJKaifqLE1ldtxoWI4DMM/g2rsM/Cc?=
 =?us-ascii?Q?iMLh9UncMVG/OY2JT3YK3b94ygYpvH3OrcB5FPXFsAzakEZamg9Fmjzl3Uik?=
 =?us-ascii?Q?SpeJSRW8tiVysWiXgwh9MvaGxzky6HM=3D?=
X-Exchange-RoutingPolicyChecked: A+lT1dOBM1ZSUIS0cJ2mTkhc6ZCRbvAhJc6Tv9vTX5UTRUMd3LwwcLeCNRQpOrSkWSsalcoN/8PJJd62frE273Tdxm8HCwQGtiVrBr00dxaVTM7qMMyj97fU+8ia2Hh6XAbjsGuOPEIz8TODNuQ9v0y2rCnanPxSy2D6GBrBr/E/QsH/RmGwnp+n2Z0XnlL26AePZwHXfQhgW+DvEUTe5iAXwxe3+OpGKaZCDwI72YUHQynhHbDClYZxsEEoaCF2oP1bmyQXn3Mzz98DkQPMFbMAP1ph1hm+ftNXtQF9Ggn9kk5QA/gHWg1bawYbnL1hdKCmrZC+XUzJ6UZU+V9kgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fb7216-b522-4611-0b99-08deb66a3a61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:20:49.7152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //Q7imo9M4jkiU+mYgUn68TW0NkClvIXDXD16gL+d1TUNqpEI/Vj3w+nl+rwRMfYD1w0r2vQbSnl12FM9nQBEfdpOCSaPKMqkqZEVaQMGZw=
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

On Mon, May 11, 2026 at 02:39:30PM +0530, Shaiq Wani wrote:
> The generation bit in the pktlen_gen_bufq_id field of the split queue
> completion descriptor (virtchnl2_rx_flex_desc_adv_nic_3) must be
> extracted by masking first and then shifting, not the other way around.
> 
> With shift-then-mask, the mask is applied to already-shifted bits,
> which can produce incorrect results when upper bits (packet length,
> buffer queue ID) leak into the extracted value.
> 
> Change to mask-then-shift to correctly isolate the generation bit
> before comparing it with the expected generation ID.
> 
> Fixes: 1f065f9d75ff ("net/idpf: add AVX2 Rx path for split queue config")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index db7728afad..cd10c27a30 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -524,8 +524,8 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
>  
>  	/* check if there is at least one packet available */
>  	head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> -	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> -		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != queue->expected_gen_id)
> +	if (((head_gen & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
> +		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) != queue->expected_gen_id)
>  		return 0;
>  
>  	for (i = 0; i < nb_pkts;
> @@ -599,17 +599,17 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
>  		pktlen_gen3 = (uint16_t)_mm_extract_epi16(d3, 2);
>  
>  		valid0 = (stat0 & 1) &&
> -			 (((pktlen_gen0 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> -			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
> +			 (((pktlen_gen0 & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
> +			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) == queue->expected_gen_id);
>  		valid1 = (stat1 & 1) &&
> -			 (((pktlen_gen1 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> -			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
> +			 (((pktlen_gen1 & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
> +			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) == queue->expected_gen_id);
>  		valid2 = (stat2 & 1) &&
> -			 (((pktlen_gen2 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> -			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
> +			 (((pktlen_gen2 & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
> +			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) == queue->expected_gen_id);
>  		valid3 = (stat3 & 1) &&
> -			 (((pktlen_gen3 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> -			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
> +			 (((pktlen_gen3 & VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
> +			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) == queue->expected_gen_id);
>  
>  		/* count valid descriptors (holes are impossible because
>  		 * descriptors are read in reverse order while the NIC
> -- 
> 2.34.1
> 
