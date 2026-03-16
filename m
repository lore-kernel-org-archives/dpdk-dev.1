Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B584AF53D67
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:02:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF6064025E;
	Mon, 16 Mar 2026 16:02:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 581FF400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773673367; x=1805209367;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d2nAlq1vxswqgUmWix5d/CdafacY64A+mzSC6EKofuY=;
 b=MPJ9AANSt7xvFal9cNRyzovi4+TiNPftbqHbUSmL1Rt7PkZ7YOOh+PZ4
 mkIacr45+LDf6JLPKV9lFdrPv1jlH1727/TLvf99EDELzMFMxcb7M4RA/
 br6mIUEbM4+tQJymlQq6nB/HF06lwJQglgAOT4GQXza6US8UvsVXKCkZW
 cLVi3sT/Cawzu0WD+YTshDz+CzTXAEYEwL6mIwuSEA69Lij11bxiAdgkE
 ViRyT01foyJvLIWgzikemTVc3STGYUNdqqulxFw6g3HV3ObX7RSsMnxHg
 P52b+Fqb7C0o2o1sPqLM+4Nq3cJfL08sFTGbR0Ioap88w35isKl4zBZhC w==;
X-CSE-ConnectionGUID: Ymg+y7UcQZyyAS60D51yYw==
X-CSE-MsgGUID: Y3By7c6mQe2X8ryAtsRmfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86168980"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86168980"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:02:46 -0700
X-CSE-ConnectionGUID: SQMiVglPRdi00rqZLN15Pg==
X-CSE-MsgGUID: x62XMIpFTG2hKq20T5i6sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="217761801"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:02:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:01:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 08:01:38 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rywx6Yqz5bD+UICFf2woVelutCm6I69nZVK+2GDSCjAxhsywaD2rHtAm/DwwOF/gQmXcBjGEfEsjX2/7hLRP23yCIDBvpUBKLcJkZOK+12V8FtlKa9yAGj2gosyRr1CnrL6KpBPViJtbLtcHZRhIfofTuWlVqLMrVHUduPK/XgmBeX6wzRG7yY9vT/8bnEOYugLezDCCjdlw8VP2JhSKiDp9cii/isE6GV2rx7fxjSAHxHbpt8B6ZwEip8g8pn+duixVweX4D+X28uoxPYkiEblijny83dmjm2yP9+FUSNg+nztREx9pHoeSzHl1gnnfCE0DzM3QEWl66XMITLWPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZmXv2EBk3s17tnbtOf5F9vhwMRyoJ7IWflzdPQDvbI=;
 b=ihR1DBxlYUeTARKw0V9TTSnvh8MKtxoN58MJjoLSo3gJJBvxxabNVKqgG/hAyqKjhmNjyC3s29C7rHKjOpi3nmqPe/mkkNBneaCGPtF/unOviPWst/qe0hU8fjfRwrnlg9+en/GmmTd+M717tExKYtr2P2lJ+qNsbVvcQaPH93DBsPldZGH+EN/6TGYYk9IZw8V7nm0hRoiK9xxr4vkHFsymQFxqKKx74DA1HhmlZOuYtHFjsOBkUjezlDordLufSVwS4UmWjjmyvnKxi28srORR9bxlFd0LKTWI8R2vAoh8jWbrxgjDPF3ToFCAjDEQN9nc8s57B1ovSAc34dwFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:01:18 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 15:01:18 +0000
Date: Mon, 16 Mar 2026 15:01:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 21/25] net/pcap: add Rx scatter offload
Message-ID: <abgbOL0uGl1MGYvX@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-22-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-22-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA0PR11MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 78742f56-a290-4dd5-fc73-08de836ce066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: CWrUKY5vh0vSRPqrvb49OTV5LP4e/E/RTMDZRTwEm6DjNcIrhKyRi1r3YvfRFKUNVtyQMlMnfM36Utqk3viYI/7k/CJbC6Xn8wrxmcynmkt8LLd201xjzBGQ/e7kfOzXC59VpmehKJUFfeG3OT62GVEchnSsCvfVDok7KDDOOLG4Dq8+FvXbonCp5HNeHyz079lsW5zHZI7VmkSkbMBSwjvyULlTYF77KiWEHmoQcoHNRw+4iH+rJffPRcdR2AKJQvHGstThXmmEXZ6qcYC5llHkL0h5X+zEmF3F1jdfVGKoGW9qwsV0vxSOoOlAoe22jXFR4wwY50UjXPJrh8z+PfG12M5gFt5ZyJ7rartqDLAMZwk67DuDECrrLlijrtS3ARSK3ZlEnM8nVWKGx9anoiV+UskwVsLF93Wvvi3UAXvrioZ1c3S5F9sJlLsXg8cfVClgy9Ahd9oTMksYRMNaLwlup9kYGaFm07Xr2IMBnS4Te7Oolx0TWysi3ar5SPI26C5zRUX5SDOolqt98Qx4YtqKoiw8mlP7r5arNF3lIcgzeMDeuvSSYDWYLY90/qjJ4609AFWAfHnpWQMslXcJ+d8XzDoK/ElvtKNrb7zJPpOJsqOOLkGtMgH9NKumHMvHdgnDynJeoxBeuZlXV3EbEVi6KbGZl/1lqrD+7dA+ki44Nnm/s0h0TBvLSCOBWqCE8/V/oCz+ysrwY73P2gbId88uEqHXwBrbPrQpGQtKp4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N+I4Q4GWlu1qpAAM1tQm8PdZ8Py1l1v8P6XUDuBNCYYZoZzJxacgCwVLTMkj?=
 =?us-ascii?Q?f4i1xX5QgmpLte4Ny2d7pHoPRhs5WpLMa8yLpZiAIlyxtBXn1LSLhjols9L/?=
 =?us-ascii?Q?A7GPnUu42a0yi7ATpblzkCqUCyxxAwMZLUTqfjSOYukqLIoAC4nQnfmEKSvQ?=
 =?us-ascii?Q?n3wgIwG1gC4g3O9NucmX/qIz+SId1N90OJffh08ROdiZGkSGwC/+5FEeyHNH?=
 =?us-ascii?Q?q6+dBC6fkdBj73pEVIO+kSOlwjPtDqbHkAIP3aPashwN9iu7vKZE1AybWvQb?=
 =?us-ascii?Q?WmDl3tfQR2bqY6b375tzRwuUbCjtQ1SfBDzGf2ERwx7aJv6C324LYLLObJWt?=
 =?us-ascii?Q?5iXNz9jLucuH1gVR6tRCwxYU89reHjzIigLL31/IHsIgoZLBVgB/5L/NzsMZ?=
 =?us-ascii?Q?Yrn2dcHlnKQ00qsB6Ptu3ReIE43xDU29frUCiTu/Uci4McLJAvWF5Qm62XjA?=
 =?us-ascii?Q?8M2Igvs79UvJyZ2+tnIrBD4Rq//a0pNI9q3jJHn0zi12hfgvP0LZh1K5Ee88?=
 =?us-ascii?Q?CcVUBjnByNmxFspx3B/MP9a5b7QwZ3b6K5uTfNHNWPcl9rj7Qe5lopkZUqt7?=
 =?us-ascii?Q?umojS06BSB0QhB2rmOY5kDN7bGw41oCKkfjx6GaWTHmy7RMxmUPkFfkn6AP1?=
 =?us-ascii?Q?msF83dyzpmRFc/Kpr6a0BxJUMDaXj76yTYh1MShZ4nQFs2RwCZT3W2P/ShoD?=
 =?us-ascii?Q?RzTkB3iUoGGA8h1ymbL2V3DV6c+ZwiBkLQkP17BPZ+ssG0D/g1GQPBWZchC8?=
 =?us-ascii?Q?0Zts8Pzzh9Ot9JgnVXsugYn421dKxFzMVGy4qMjAejOCFaQdVMoXvMpK8l78?=
 =?us-ascii?Q?InxZSN5e1ciFQkxTtTXenVAoNtbMbnsK29RRSC0ggWFWTobEaR0aKmIWKKg2?=
 =?us-ascii?Q?8B/4KdcbYNE8hBamdP7FhuvNcxJRv1S55NMFBwgOeDrapt5MNXjMqqLjS/hN?=
 =?us-ascii?Q?nBYVoyQ2Ls3PFJK/zMkZczD2PBUkz9tXtnKwXu0Hpx5MFPcHTkjbarIU6QgQ?=
 =?us-ascii?Q?oUQbWrAAo8meAx7mc8qIkPSoyw+c/xsRirLyoAGWCxktiVU+u/DmQT79Lrn7?=
 =?us-ascii?Q?hEZe1in5FwN9g2bypzPQ2pB0ZQawj6x36ZvIMcEExeg0Z3u0OGFovZNdUTxf?=
 =?us-ascii?Q?EEUJr5XplFNvwxdvY3nwRlrikOJsiWFCM7rhUt9uOhnKIDMQv+qlkU/LniYw?=
 =?us-ascii?Q?vGbVuxTVpJTCt3vSou7rIWpyx8Ylp2VmpdA0fZ9LK2IP5jEuPmQ203XHSclJ?=
 =?us-ascii?Q?lTXoajgqBGM7uYrZkpOprc+TZD66bmff7sTEfbgtZIkvX2Q7SxvF06y2CB6z?=
 =?us-ascii?Q?NWY9DgeTkbMRt0pSBjjFVUVzEWclmZUwFgxBbnLLLPjReWi3mZTi6fRj+Zwb?=
 =?us-ascii?Q?7zXCCVcg7MCipa8WE+dX/j3DJHan2oNSi3eL5TQhDwau0esVZcTsccE/mi/g?=
 =?us-ascii?Q?mzoE8TgQr4edr32WgQ5qvfm807hLA4Z+Kc5nmtxwrW/mdcyoqVV77Qe272FD?=
 =?us-ascii?Q?drMxR2vT6lGZxKO7qJeRlXZo3AsquU3s/F2Z4L4XPFuOkYKVgtwOqDIGvsbm?=
 =?us-ascii?Q?srIGCHgdvr5HA4pqDwIYLqSKV3O2csEr+vVN8ZzbU0vzlvxeRZ8tXpCNxtvr?=
 =?us-ascii?Q?6g1hJPym8FX0GkSUqAMYWoH4SbUvHHjX2gfEoa71R7yZZ4Gz6qUZezvM/wi+?=
 =?us-ascii?Q?4rT0j8dwhX053slJ3HyeQLC0DJzdVYa4lFFWn3ecR8ifCSF2VBwMKkQbNtvU?=
 =?us-ascii?Q?WLoyUYKLSvs0cF8840WzazKof2c/FPs=3D?=
X-Exchange-RoutingPolicyChecked: LSjAJwIQYKXDYa5GefvmlvXllSH8vVrfyIuIc4iGUlmzshTPkD8miJDnDNEUBcX2GaQJPpcKLFqMiOfuc/neH244VjvvhhhkWvJhMAsiiCvVppnd1OgmDh50KdugQPZf/aa+nEm5/6YGpqywyQjpC9DXJT2+5muCW5Qw5G4BBB+oGjF9FW2N/Wn1TdB2lDIeB1Dpw0k7rP209Lx3MH48dnmKe+fBkTyy3nexT6l6TTDAu8usHLfLp96sA3ub/MEXeWwvOPJIc/v19esPc+Thhg3PgGDorZXkqc8rFrBc8vyCKRPxIulDWZbg7QXl3gaRzYUH6IyISbwjoBzGxqvFsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78742f56-a290-4dd5-fc73-08de836ce066
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:01:18.4683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihC8I6TgQ7OLCjXRjqh49QtL4fu553nzYAJkxRUgvDfRq4uDhFuyWkI91RGBVkq3ht3r6dwu4YGiAGVYPnR5xvqcVdRtp/TV18kQfpaeKus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
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

On Tue, Mar 10, 2026 at 09:09:59AM -0700, Stephen Hemminger wrote:
> Add RTE_ETH_RX_OFFLOAD_SCATTER to the advertised receive offload
> capabilities. Validate in rx_queue_setup that the mbuf pool data
> room is large enough when scatter is not enabled, following the
> same pattern as the virtio driver.
> 
> Gate the multi-segment receive path on the scatter offload flag
> and drop oversized packets when scatter is disabled.
> Reject scatter with infinite_rx mode since the ring-based replay
> path does not support multi-segment mbufs.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/pcap/pcap_ethdev.c | 47 +++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index 8a2b5c1b4b..d8a924b0cd 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -79,6 +79,7 @@ struct pcap_rx_queue {
>  	uint16_t port_id;
>  	uint16_t queue_id;
>  	bool vlan_strip;
> +	bool rx_scatter;
>  	bool timestamp_offloading;
>  	struct rte_mempool *mb_pool;
>  	struct queue_stat rx_stat;
> @@ -112,6 +113,7 @@ struct pmd_internals {
>  	bool phy_mac;
>  	bool infinite_rx;
>  	bool vlan_strip;
> +	bool rx_scatter;
>  	bool timestamp_offloading;
>  };
>  
> @@ -342,14 +344,19 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  			/* pcap packet will fit in the mbuf, can copy it */
>  			rte_memcpy(rte_pktmbuf_mtod(mbuf, void *), packet, len);
>  			mbuf->data_len = len;
> -		} else {
> -			/* Try read jumbo frame into multi mbufs. */
> +		} else if (pcap_q->rx_scatter) {
> +			/* Scatter into multi-segment mbufs. */
>  			if (unlikely(eth_pcap_rx_jumbo(pcap_q->mb_pool,
>  						       mbuf, packet, len) == -1)) {
>  				pcap_q->rx_stat.err_pkts++;
>  				rte_pktmbuf_free(mbuf);
>  				break;
>  			}
> +		} else {
> +			/* Packet too large and scatter not enabled, drop it. */
> +			pcap_q->rx_stat.err_pkts++;
> +			rte_pktmbuf_free(mbuf);
> +			continue;
>  		}
>  
>  		mbuf->pkt_len = len;
> @@ -907,6 +914,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
>  	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
>  
>  	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
> +	internals->rx_scatter = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
>  	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
>  	return 0;
>  }
> @@ -927,7 +935,8 @@ eth_dev_info(struct rte_eth_dev *dev,
>  	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
>  		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
>  	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
> -		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
> +		RTE_ETH_RX_OFFLOAD_TIMESTAMP |
> +		RTE_ETH_RX_OFFLOAD_SCATTER;
>  

You should check for the infinite_rx mode here and only add the capability
if it's not set.

With that fixed:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

