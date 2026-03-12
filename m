Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4457B105A594
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4819B402C9;
	Thu, 12 Mar 2026 13:23:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 51107402AC;
 Thu, 12 Mar 2026 13:23:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773318228; x=1804854228;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NLsaf/wAK0ax4WqTWBN0uKo/enHw2rgWlBm+zs+ThfU=;
 b=kfy7s6Tns5zX1hKDKjjgWlTo/fEBo+c6He7zmUj9zpRFxYvMUO87xCJJ
 Lk9UgTvDBF716FLCd8nW/fHf9wwfyP2BaXLZCSnpHwK9apVne/xwbAmSv
 jr2uoAZbAnuw+2Rat9ChME4XZdaTdSGiRwbIyVbqFxLaKIlVGOkN746Bf
 9pD+8lItaU6ketZMscNqU+S7e64HVrpI6GP+lC445fcJxOG7JKawc6USD
 R6EH2zsI+a9Xw21DW1aMsZjjCTx/WFanfoiDdDxSLSBJHZcALyhbWLWlm
 hD3Lqa9YnvzGOvh/NiCSrPhjDftFwgHzagnQE/fJXomlH9kKx0pjonh1G A==;
X-CSE-ConnectionGUID: Hznaxl7rTsGv3aaogI4evQ==
X-CSE-MsgGUID: fZT++rnIRGi5BvgfQa7EVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="78011071"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="78011071"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 05:23:47 -0700
X-CSE-ConnectionGUID: gSiXxkIlQYOkzIKoZkInCg==
X-CSE-MsgGUID: +ipi4aaTShqu2HqEexv2Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="217356789"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 05:23:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 05:23:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 05:23:46 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 05:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2WR8QQWBJKeN4W5mLxK7yN+s4YgWECJebSXrF7OXHR2kRRJHAnhSbzqzIxBeJKU1VWC2p1ahDb7OgNIXVYAWA795+eob2oHYHBJNv02IIr1/zNzs5vYj9cfBbpQ+mW6yzoPWPZL+oqUVMIO2epI8qvDafZii7MShC+HVEP2zfypQAxpu6I6S3uVXWoZMAtNZyeIy20dwCysSnCPfe90K8CLl+lRYo2KzYfT5fi/Ny6XhGWs/niwfMbPSk97Ge8fpWsm/526h+8+HfsKeoAXrQeL4VN8tvlH96klCD/9gufA7vZMDxbqWH3KxMoQU+lol36mXwDmiUi4A8RSeLNA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4f0Vd/PI2jY1GUds5vZ4Kxys6/o1EBsqjkSYho5684=;
 b=F7UpJhmGVU97u3ffcbxFF71Ck5N6+6GyWx/ToPp6j+ExYR+GIjs5Vbnnmnm4LsR0ojPwLtdy32KWG4drZhVqMrW0dVwaBeIqIlKWTcJ4NDEt6hIYlrqfcNRL1f1fXHneF1ig9mZfg5O8sRIQw5lU5bX9JEQkg2+me19FRGHg/er6TZoHhmfXSiP+ujh1pTf6sThJiSHwzapUoBNEaC7Y75HdwNYx7IQiJ7vLkPVvyA9Zl5Ta5xiHyx7NOjK54Xn3tSMHqzi+oCVCnh99HJhwEL1PMs53z+n7g/sQAQWo61HKXnG9pbiJGhx35YhTNJSSpXDW7H623MNhusxMK55WDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB5988.namprd11.prod.outlook.com (2603:10b6:208:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 12:23:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 12:23:41 +0000
Date: Thu, 12 Mar 2026 12:23:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v1] net/intel: fix mbuf leak in idpf split queue Tx path
Message-ID: <abKwSJSq-Muu_6rk@bricha3-mobl1.ger.corp.intel.com>
References: <20260312110133.629246-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312110133.629246-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0273.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d74cbd-f879-486f-a51d-08de80323241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: VOg46FWGh/X1b18N5qFzvI+VYOKOmcUO/GJx8GfOozNuGvBTQ94rbveWq1/JL/OR+0CtHtUVpjtMoqndn8zL4MFgOCz5qArzvUqdH2ImBBBmyXh/vMwF+Yig9BgzTpEsfohwvHSmJ42lwlrGdK/7r1/pGj4GiRMdHRveE1cSYteMXJeGUhweAUxFXIK8tOtvpW6FZMskzt/C0Cm6hNIO9SW8wTayDuGbDJ4He7HOrjiz2F7nPzNPxJnnLF8wB6/39bLjiqxGdTMA3HI2eq9kqcqdRPZBn4I/CXbfgkYXXKSBIsAWJeIykdnLy4NDmbqnk2piXKGhxlodZFNB89OU9wufrfa6E7t0ZAovJKaVrZXIgHLDlyXBIZN2gwEMTuyCV5zLbaQsrw3Pj41DTMd1djuPeZujje9TPmUc0cFgM2hSqO3lDXdKM62cCpZqwJtCEshlCgdX34t/EG+w4OCdHrGqX115No32ZnXaX4+/jaa4nTVP+kzNNIg/u7S0GzJy5XnkDwgtkbHzqEd7IGfqdx96e7x1+8nBty5r0lGorYtbxWhNo624SoYpstkWZc9Jqb6aFKmZupfhDbYDPPfgz9uTJBFhgDTyVNJ9P7W/+bljKq7JMY0Ts4MvdNn6DHq2HmGg4Jc2DJ+9Nf38e+4c55pI9a5fiBGb8cSBD50htsuwWtKJzvNNUJC5DtXGOskuK51tFgxxSM0gRiI5gepLhAhww5HDtXUD870NkZKsrdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?94IZAYwALJGVVs/sK/3Rx8gTOJKhngJxnniR0XX/wD0JK3WwyetlBaLzUxf4?=
 =?us-ascii?Q?Bf9VDGqGz1YI0UoU3TSKYcqUTjKlNNJ2ygm7fg25ER6Ikq2NRImcmMibwGuj?=
 =?us-ascii?Q?0dJiaoOcj3kThv6yEJTo0FwY/bwqtctxjXNxZVC3b/2zkghDnYzMeBALitZL?=
 =?us-ascii?Q?bB6lAo2OKy7Ti/9Lb3eDKME3SluUlGFilXktAEK/OVtwQ/DLmxZwfzvAEbWJ?=
 =?us-ascii?Q?QVHoNKYcFseyeFi4itnMcPNVKfEojzkpcdb2ApR99SgPyFK1RJ9ZNStf5PyD?=
 =?us-ascii?Q?iWbqlJrjtirvOQKIAYkhnJjARHS+hMJYP9lKRnyCIVawukWfGloNRufcAFUP?=
 =?us-ascii?Q?5Dl0kCrHLRqbm0zOF/a3NIWi8b3r8movnywWlR8rjjCFOeBqGgzfCETboyau?=
 =?us-ascii?Q?qnMWvkNQEY4ynBF3HF61ocZW455iXYXdQuycJPITnazVM5SL3YGAVtJOxmKG?=
 =?us-ascii?Q?DzLhLYbPvnVtJvbf7OM96s1oFjyRVSbmOGjbXzBPCsRcl+zM0mqcaEfgmEO8?=
 =?us-ascii?Q?wG6weJZJpDKvCly5tUH8HIPxmi3xdwZc4NpRibL7NiocCNpkW4DNsJlBmmF4?=
 =?us-ascii?Q?uaqAd/WhE5ZNWTq09PJohyzEi+D0ZYVM1pGDvFxtU5gFSBiY7BkEZ5U3dphU?=
 =?us-ascii?Q?ZSH5lgejByn0a9Pj9ALkeJIPP0TGF8nGPRLDm2jvu26915BZmZvzaJG133GD?=
 =?us-ascii?Q?T2Iv3MMOg9HK9JVfB09qdr2zp/Ij9TD4Wz/ojrw6cw1SOC4MKd/+Xhynl1On?=
 =?us-ascii?Q?Vb2VNe6NEWcgTjDYXmlFvmFDuzQp04hBA41au0IyKx7AtF/Ko4QqGyTACqJx?=
 =?us-ascii?Q?B+qrRaOHNUzka6A5UYxcaZVcYEKCdOjc3P4Ts9LTNHI1EXs9tOYipagHmEfr?=
 =?us-ascii?Q?i4zfC56L6n8DhV2Lvd3vQbfQPETdKOyzmHCYzoGnFjTqt7KczDitC8712Pmy?=
 =?us-ascii?Q?mbV1ZPmwUR8XLET8qMORzz3wuBuqKE214wZiBqB4y/Cprl/gEM6bwnQy/ZX7?=
 =?us-ascii?Q?RB+VxOkUa6tnqBjIorRQeWxh+g+O8Ek/2FtZlq8jCtKguUfrws+TtRC0r9VE?=
 =?us-ascii?Q?ql6qs1iZBiqK14pZQWIaZqetdWNi/xAzTozQ3plp5GWhqGVjj4kWqGX7WlpU?=
 =?us-ascii?Q?qDJJacO5W3fwVlZj77t7LruV5jaBDqMWx3eFsMIAaEDW14x5OKHGcBkI8Kd9?=
 =?us-ascii?Q?IosPOM8+qAcecZ9K1S7nMSrxrweb3lZhnapw840QztaAHOnACnndjQvZcnYC?=
 =?us-ascii?Q?zJFNB9qfSiTxNL7bzhrykqpyQh46NLcGo3xHFb2r3wl4MHq/+ckLGae1QaxH?=
 =?us-ascii?Q?9E/aSnQixJ5modKg3V2Y/4ubNHtSB1aeqWjTuSdJzMLFj71qOAcyrZW5TVdq?=
 =?us-ascii?Q?wDt9AYtOJCe71/yLs8st9UEy1gZd4JjSncudmPM/dpXhyyuRZ5nTUufbWh2W?=
 =?us-ascii?Q?DDAe8CyPGgmTQxT80SeIRwxRsfIsqajauQSXBOguAdXp9nEVGMbz3SdC6rsA?=
 =?us-ascii?Q?SGAleOerKcwRdlEboKnGkVozzcjXvnF/eynJ/i5KA4i8e8o+QaKTdtNSlJdt?=
 =?us-ascii?Q?SiX6rbDXgARHKV5Sepkmef6pCPPsFyFTXUoIS/Sc42w8L/u1BTsMbxd6pY2a?=
 =?us-ascii?Q?EbyEJIbL7xwUKNFtJA3w7eli+1/IozEAlMx+ftemYaAYHHQGxdZ4YUOiu9Gy?=
 =?us-ascii?Q?8bSoyeAXZbcpuv+FkBnpXwReACgJocva6j4dW9W5grCpUm8zjpjFaRajKb48?=
 =?us-ascii?Q?1XQL4AfArP5qPmBRAcGb+rai3Zbgkc4=3D?=
X-Exchange-RoutingPolicyChecked: GZ+g+KxLn2omPAxYrqzrbp4YtHY1+y/6munZ6rPRmdwZXTu3cYPu7GF8Aev0NPoH/tmXuRr+bRobSBeRyZEp6mp31D7GcZYwPABMrywLgImbAZU3NHLcSa1oeAhpIrnGfmoECWW/Tzrwq/VuPuibPArEDGgTwFeTt6FQp/7JHKpc2aICjddGCnmmD1xngl810Vkgc6oiEOboA5YfdYmxhnDZ2wRd/j1oMHWTL6M0S0/mkHPq6Yij84Z+Fq8WkLURpMD8CXudbVQCf9jMy8C+uDybzjvrTf3egnjbYRnEU2+Xy/KPY3oGeIx+agnjBH5OSksEN6hbtuirLSKUVAr+NQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d74cbd-f879-486f-a51d-08de80323241
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 12:23:41.6945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcPU6IyX667ebr6ArLPV2frVwIFSCyxF25bK3fZL9+1IOdkcwoHpjTNG01Af99hOMiPvRuf5HZOMa0DsoxwLxrIjCijM93GkCX1BhNalA4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5988
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

On Thu, Mar 12, 2026 at 04:31:33PM +0530, Shaiq Wani wrote:
> RS completion only frees the EOP entry's mbuf, leaking preceding
> segments of multi-segment packets. Add a first_id field to the Tx
> entry struct, record the first sw_id at the EOP entry during submit,
> and walk forward from first to EOP to free all segments on completion.
> 
> Fixes: 8c6098afa075 ("common/idpf: add Rx/Tx data path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/common/tx.h             |  1 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c | 26 ++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 283bd58d5d..53e61c0b62 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -121,6 +121,7 @@ struct ci_tx_queue;
>  struct ci_tx_entry {
>  	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
>  	uint16_t next_id; /* Index of next descriptor in ring. */
> +	uint16_t first_id; /* Split-queue: first sw_id of packet at EOP entry. */
>  };
>  
>  /**
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index f73716e57c..bc0677f2ee 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -825,11 +825,23 @@ idpf_split_tx_free(struct ci_tx_queue *cq)
>  		txq->last_desc_cleaned = q_head;
>  		break;
>  	case IDPF_TXD_COMPLT_RS:
> -		/* q_head indicates sw_id when ctype is 2 */
> +		/* Walk from first segment to EOP, freeing each segment. */
>  		txe = &txq->sw_ring[q_head];
>  		if (txe->mbuf != NULL) {
> -			rte_pktmbuf_free_seg(txe->mbuf);
> -			txe->mbuf = NULL;
> +			uint16_t first = txe->first_id;
> +			uint16_t idx = first;
> +			uint16_t end = (q_head + 1 == txq->sw_nb_desc) ?
> +					0 : q_head + 1;
> +
> +			do {
> +				txe = &txq->sw_ring[idx];
> +				if (txe->mbuf != NULL) {
> +					rte_pktmbuf_free_seg(txe->mbuf);
> +					txe->mbuf = NULL;
> +				}
> +				idx = (idx + 1 == txq->sw_nb_desc) ?
> +					0 : idx + 1;
> +			} while (idx != end);
>  		}
>  		break;
>  	default:
> @@ -979,9 +991,14 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  				tx_id = 0;
>  		}
>  
> +		uint16_t first_sw_id = sw_id;
> +
>  		do {
>  			txd = &txr[tx_id];
>  			txn = &sw_ring[txe->next_id];
> +
> +			if (txe->mbuf != NULL)
> +				rte_pktmbuf_free_seg(txe->mbuf);

Does hitting this point not indicate a problem condition? If
idpf_split_tx_free has not cleaned this slot, surely it's not correct for
us to free a potentially unsent mbuf?

Also, does this code path use out-of-order completions? If it does, then I
think we need to always check each slot for NULL before we use it, and stop
as soon as we hit a non-null descriptor (potentially undoing any descriptor
writes we have already done for the current packet).

>  			txe->mbuf = tx_pkt;
>  
>  			/* Setup TX descriptor */
> @@ -1002,6 +1019,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  		/* fill the last descriptor with End of Packet (EOP) bit */
>  		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
>  
> +		/* Record first sw_id at EOP so completion can walk forward. */
> +		sw_ring[txd->qw1.compl_tag].first_id = first_sw_id;
> +
>  		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
>  		txq->rs_compl_count += nb_used;
>  
> -- 
> 2.34.1
> 
