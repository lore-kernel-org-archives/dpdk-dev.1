Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8607C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB176402DC;
	Thu, 15 May 2025 13:07:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 79EA440289
 for <dev@dpdk.org>; Thu, 15 May 2025 13:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747307263; x=1778843263;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GgbJYowz2o3h8IFQgSQRGXv4DzE1ECrjH+Q2g3d+Jg4=;
 b=EsJ4S5Pbte8NOGmu73VlshbG6wttBi1RGZASqFg3wL2d+V3t5/STQRsP
 GJNME/NbHO48WRsT/ImEmw3/sAgd24v70x9L7CA8FZR9QquBpJUDRwy/O
 nNUSd36iU9Y/4C4dNfjDt7Nz5g9qOhTn5nsN+2gii3/VSUVVPhIlH8JhD
 UvEbs1u+Y/QFRDp2k9wPNZ0foRLuZPvPXXAPscRubE1XdBgNl0XjM/bXp
 o12066F71UCXT5CiwxW/VjHeQfBBxxvI5nif7iD7q6t1x8Lk8rov87EDB
 aClCruNPXWdSt4ZGR3DbrG9DW+AYol/MthWM26n+yzTlusqU3FenmMP/m A==;
X-CSE-ConnectionGUID: jicU7k0XQ+CO+RgLt6AeCA==
X-CSE-MsgGUID: u75hE1C4SiKgvJ6uv1lvBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49349780"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="49349780"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:07:41 -0700
X-CSE-ConnectionGUID: 7DhII+shRWengV4vloAe/w==
X-CSE-MsgGUID: 8CtlU5juTKetSPnRiTHQTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="142344610"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:07:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 04:07:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 04:07:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 04:07:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8YOKkGeGkDGq0TM5oh4YRrfY7q9W8wOzA31j/DO5J2j8dPtnBePVi6mC9zbjTKpyVPd1MAChIL52jiISBMnzSb4SRV3gOYFPHpEod38QP9/qoyxzZybfpR3OYWxkXDd8VRbMLONE1p5otbp0P+6aCCIjWBnI+jTO5ey05V3a9M6UrZGwbj+WDqSPzUvuTeBio9bgg4WgBRQYE1FxBfbdva98MDQkQc8riiCOHL59HeO6NaVqNFlVLFxw8CIwsGo8sItwz1EYRvbeucXoSB85lqndPpYhe0CL9KvzwQJil9gQVdraGSSfRjA/IY80IDBGwRJPQJq7/vqZ1ai16PXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgHBtF6HfAEs775C/T31re/9SojgJn8T59Jk+XzDz6w=;
 b=jKIMalQHp8P7ZgQsA9rJ/CXlzmPumwyncWloDBBHB92g6+1S8ocKsnUMSiAi+O81daYFHj87/9rspJXS2vEx5G83llFsmzbbE6XZGQUAP3m8AC4cxixPVdcE6NJr4h8L9XQiClk0DbeVbVd8ZwH9BpzOOU0xeWpr6ZHo1Ze7kpEYcTFSP3C+hfPHOMPS7UAfR1/T6QwRBurw77oWJPwI2edRomcSC7CkeMsifcY7jxgTzX0nZRibhLKZii5RYGqu98Bq/DdIU6yUoNpCZPQCrMtGEeN2vlrvs1CSPzPleqTvgMY0VvW8GAUGNBtJUlYKUv5UHkEJtiEdy9sJcsiK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 11:07:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 11:07:37 +0000
Date: Thu, 15 May 2025 12:07:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 13/13] net/intel: add common Tx mbuf recycle
Message-ID: <aCXK9BFZlfRSSb8u@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <3c5ab3604e55ea75a942a0d6ddcb5c52aa5a1ce0.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3c5ab3604e55ea75a942a0d6ddcb5c52aa5a1ce0.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e78a30-b064-4159-df55-08dd93a0b35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8sPQ733mHQOD6GAcyuR17VRtnYRBsVLYlPnaB8n66j817Szf+fQ0AbP+aIt8?=
 =?us-ascii?Q?tVHlbs4haGoPw+mb5Vr9u2+J5jY+xi6PfFGM+w2FZnGnLz5HKPjH0uhTk7rb?=
 =?us-ascii?Q?19N2TQAwpgDnLWFD5xVVdweaIDtNiaaCdflbGb97zzzs005qtaiprxVHHXXY?=
 =?us-ascii?Q?+y+mNw0MH5xZGFqKdALiLuu6hp4esqmSVwUmMQdW9z0YjPiHzujz0h5kSzaA?=
 =?us-ascii?Q?b2UgzZv9tvtOicFallzrkUt06OwAqCr/mASvQ4ASi46iH4E3uV1+HTgrHWbu?=
 =?us-ascii?Q?6xJdn0cTeouj7aYLjaEEi62yqe43d7FVln6Pt/x7RSVZReY6HPbh2LTGN5mM?=
 =?us-ascii?Q?UnY9i2RRgmJoDYaIoHjVnhSJJNpAhhqC8o5bQ1DwkeKvf8g1Ig3Wu9bGIO1A?=
 =?us-ascii?Q?YLVrb1TfjFm8bl/SZESd98kawh6IkMq/2yicCHKXkbvgQUtBVw0Yr5g6zUCe?=
 =?us-ascii?Q?dj76/7lIZJpB9z8Sq8U8utqWA9R3GeSiRn1ZVXqMJQNOKMfd0q0Zv65EMx7p?=
 =?us-ascii?Q?eYIFQ1ZIRPEOJ12YK2S6CFvPa1ASfadLqjrs1hcn0rH9j3MHVsFMzktjHixo?=
 =?us-ascii?Q?OGUdMCpElv3e4p8933WESEZ84OSGY2IdspkwGri5m1Mu+WkJhFZjS0BOYXwC?=
 =?us-ascii?Q?Qd3JTfIKWIOBcwgI+oFi/2eg49t00mAn3VrXDL/z1Tn/K7ml9TTi98AHCtxU?=
 =?us-ascii?Q?FXxxNs/8SIGVtLoVvg8cA2R+0v91PHv0/n3uNGabjNujYNJkSnmIawhYEkHH?=
 =?us-ascii?Q?JG/4yfZFefqq11mE7jzKUpVn85opOEoDDPhboId2XdODtIKsVkcehH1L+TVH?=
 =?us-ascii?Q?hsM+ITiD7Qt2hDnHmXWf2DKyHf8LPRsw3N2sXXxcwGAIVvkDBOG353aLYGV6?=
 =?us-ascii?Q?BawzGyAjyxJQiUIUD6A6TB62m/38pQLLkxyyg2Z1qtAmRKr3tNweXSsnxuNS?=
 =?us-ascii?Q?OkJ7tnxGhVYdWK+VpC5mqGARfYCudRqbLB59nl0Xg1mvrjEO53u17hqs4utE?=
 =?us-ascii?Q?mbh59Kdntr7R+9Tbr7aoXH3xcAhIe7sJPGC2xDJLgLolobKhEDp7Nf5JCKUS?=
 =?us-ascii?Q?6B5QoXFuCVPoBhtbam7z85kuFJ1uKuz6qKvjm4ZcFxsWAO/jx34Pu/LV7suH?=
 =?us-ascii?Q?+f7m2QkmZcbOKYp5s8+2XyFKFbRBxLfdFC4IYcYDZonH+ou+r9DH7mFtNrcS?=
 =?us-ascii?Q?UFXlFnIuLd6rJ/mTrU1V+jZK44rBNVHrxPK5zs62k0IBWZ7yawX3t/aYi5ro?=
 =?us-ascii?Q?HIGcmIEpxHwr9avvJLIO8j75hyvoftup6VsxLDLPdwmX5Ra/WuYQNizTDgNl?=
 =?us-ascii?Q?4tWmaykwrM9T4cQxQeqIfeiC53mQ3BDAAlFRgIn3gaJywwgUEyqo75nMg8Tw?=
 =?us-ascii?Q?iIOjEM+9bBjfbv0b3dTIavCF4TiXwrHWcHw1+dC5f0IOaqrz+xa+dMb5xqbk?=
 =?us-ascii?Q?xJIy8sdwrq8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VDi1w8uKEqEJ3vBNTUPrnYgCDNjLvIXU8p8tY/IhVljhNReMNtZU2mNaSACS?=
 =?us-ascii?Q?F6cEt51D2a2E+HmFSuFzKRCbAQvXoepSSN268YU8hejXVWAiUvvrWZyKaULs?=
 =?us-ascii?Q?BXyJIIWnAWRkHFb32RS0cMeX92Anjalc3uT296LTna7YWMPKxu/iYJ5Csusr?=
 =?us-ascii?Q?koh19OCaDIt6x8DBWICvDFiyt4LvzD5WqGqJh8D1xhIhdm+ug9iDM/rA/TUX?=
 =?us-ascii?Q?Kb/8gVo3dNKoUtwqg/pqog1PxPWxByeszBstuEpbmeCtorzPGiFnwejA3tQZ?=
 =?us-ascii?Q?RH6YAbwNd+wRMm45iDrxYUTRFyp8C2u1XvlpkFjElvsTfD5AQ1Y+fHZqA4pX?=
 =?us-ascii?Q?da2CTFa6JxuqiieWjibwu1XfVIz7lUfLQTpsMfcZzh0iNLGHaJEYzO21wbtc?=
 =?us-ascii?Q?cGbyKxyuAM1AHvNi95I7Mtpm4uTnZE6xEr+zPzb7pWEtLabF8PHTGn03J1xn?=
 =?us-ascii?Q?Wcq6RTL0uVKlnbQUsFoFStZFzYzzptohYZ1C2zYPpIIrLW9ch2XNjKwUBO3f?=
 =?us-ascii?Q?RtvJJuLhliogZ5Ljzf+iqIrP6HiCZyvz7thUwSOfZb6548TmqqX29Z3x0AIK?=
 =?us-ascii?Q?VO6CxVHsyOomhVjryGIVqM7vhDaPz9xR3jAAsGFFOGSpeq7RcaFnqQ/n8EPH?=
 =?us-ascii?Q?C2EqrJ8bC1VRfVpKOotJE9EjUm69RNiaIT4xyA8bgOoCMxzDO5b0dRZ5lSZ8?=
 =?us-ascii?Q?9ttHeJ8Q9iY74Rb4bYHV2G23ImSFxmSbOurAjMgQ80y6GBhTI3ZabZyGPqDC?=
 =?us-ascii?Q?vXNbkuvLliCnZKMixpgXHOgL0udPq5ogNupJIntz+9FEKjoVFDrNE8W6+bVv?=
 =?us-ascii?Q?QO5DaWcO2SdL6Pk80jL3MllzizLCh9EhXREeuWe4DEKFIiwwpbkIkvfBAwGp?=
 =?us-ascii?Q?Sh/5cWh+h6Fkss0kXyzSzeSIB5aGT/NnzmMWkp/SzOaBfxIGtxDtlxzBBJmt?=
 =?us-ascii?Q?KFNvpenKQ7v+BtT5gEKSDk+YB53ZRtBxiRu9SE96xBiysbMpIy7yXBH6IH0S?=
 =?us-ascii?Q?k0KY4gmmmbNB3IX34hW4Iny5fVFML0XXHMHSr7J8CHOFZtcY3Fu9K5KFuT8b?=
 =?us-ascii?Q?doeV1epCPQookj8FBWD54h3O8tNCzj8CizftrVzHQlGm0uwLMxe+/uZRs282?=
 =?us-ascii?Q?osE6xlLbIR4uBVHI3VbAdumIg4bDiqulNbizCfiqOpiyyQ1YZ5xm5jcTWJ1t?=
 =?us-ascii?Q?fk/XHowpJ1LSmNmfpuEBlqlE1pC8ir164ullRdRYpNxzNBoLN54Ofa2S7DQq?=
 =?us-ascii?Q?uttfGUhdTvYl7kt5WMpiNiFeXgw5jYfLmAb6WO16HeL9KzTK6T9whMS3bwjO?=
 =?us-ascii?Q?pbsjWcmhuHsb5pnuwsRoAWkFoL9znLpQ+NjIEbRsa8SWn41zXb6j31shI6qB?=
 =?us-ascii?Q?CzaJG5AIcG1acoUh5mBfwWL8Uojbw7Gwxk6kPy9iYiXB3NdoVfyV62KioqdA?=
 =?us-ascii?Q?T2UCgM2DpYGzXPqNqtlolcTVUhfGXIJr6xqqOwcV4TubDzTlOA4xdgH0JZQw?=
 =?us-ascii?Q?LO5EbllAZqQpK0WdhVNWSBbvKCTy8JF5GZ5fU+3S/ALmuzkHDyZOaUNSNypJ?=
 =?us-ascii?Q?oyyMyz/yC7h5QuEMpO4DJvE7GmJDtnSM68g2G2HMAdNA3ayGcLaprr7ZfexD?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e78a30-b064-4159-df55-08dd93a0b35f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:07:37.1353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VqCLcIehp4nx/4xLULE2gQkyqhpTAMBqBhPgo7zxpDtegw7KULsnL7d2WlMDHkq6s894QyoDJLPcNxrb/ePjbCj3SxqhdGSNjgxkayIhMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
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

On Mon, May 12, 2025 at 01:54:39PM +0100, Anatoly Burakov wrote:
> Currently, there are duplicate implementations of Tx mbuf recycle in some
> drivers, specifically ixgbe and i40e. Move them into a common header.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/common/recycle_mbufs.h      | 98 +++++++++++++++++++
>  drivers/net/intel/common/tx.h                 |  1 +
>  .../i40e/i40e_recycle_mbufs_vec_common.c      | 88 +----------------
>  .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    | 89 +----------------
>  4 files changed, 107 insertions(+), 169 deletions(-)
> 
> diff --git a/drivers/net/intel/common/recycle_mbufs.h b/drivers/net/intel/common/recycle_mbufs.h
> index fd31c5c1ff..88779c5aa4 100644
> --- a/drivers/net/intel/common/recycle_mbufs.h
> +++ b/drivers/net/intel/common/recycle_mbufs.h
> @@ -64,4 +64,102 @@ ci_rx_recycle_mbufs(struct ci_rx_queue *rxq, const uint16_t nb_mbufs,
>  	rte_write32_wc_relaxed(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
>  }
>  
> +/**
> + * Recycle buffers on Tx. Note: the function must first perform a driver-specific
> + * DD-bit-set check to ensure that the Tx descriptors are ready for recycling.
> + *
> + * @param txq Tx queue pointer
> + * @param recycle_rxq_info recycling mbuf information
> + *
> + * @return how many buffers were recycled
> + */
> +static __rte_always_inline uint16_t
> +ci_tx_recycle_mbufs(struct ci_tx_queue *txq,
> +	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
> +{
> +	struct ci_tx_entry *txep;
> +	struct rte_mbuf **rxep;
> +	int i, n;
> +	uint16_t nb_recycle_mbufs;
> +	uint16_t avail = 0;
> +	uint16_t mbuf_ring_size = recycle_rxq_info->mbuf_ring_size;
> +	uint16_t mask = recycle_rxq_info->mbuf_ring_size - 1;
> +	uint16_t refill_requirement = recycle_rxq_info->refill_requirement;
> +	uint16_t refill_head = *recycle_rxq_info->refill_head;
> +	uint16_t receive_tail = *recycle_rxq_info->receive_tail;
> +
> +	/* Get available recycling Rx buffers. */
> +	avail = (mbuf_ring_size - (refill_head - receive_tail)) & mask;
> +
> +	/* Check Tx free thresh and Rx available space. */
> +	if (txq->nb_tx_free > txq->tx_free_thresh || avail <= txq->tx_rs_thresh)
> +		return 0;
> +
> +	n = txq->tx_rs_thresh;
> +	nb_recycle_mbufs = n;
> +
> +	/* Mbufs recycle mode can only support no ring buffer wrapping around.
> +	 * Two case for this:
> +	 *
> +	 * case 1: The refill head of Rx buffer ring needs to be aligned with
> +	 * mbuf ring size. In this case, the number of Tx freeing buffers
> +	 * should be equal to refill_requirement.
> +	 *
> +	 * case 2: The refill head of Rx ring buffer does not need to be aligned
> +	 * with mbuf ring size. In this case, the update of refill head can not
> +	 * exceed the Rx mbuf ring size.
> +	 */
> +	if ((refill_requirement && refill_requirement != n) ||
> +		(!refill_requirement && (refill_head + n > mbuf_ring_size)))
> +		return 0;
> +
> +	/* First buffer to free from S/W ring is at index
> +	 * tx_next_dd - (tx_rs_thresh-1).
> +	 */
> +	txep = &txq->sw_ring[txq->tx_next_dd - (n - 1)];
> +	rxep = recycle_rxq_info->mbuf_ring;
> +	rxep += refill_head;
> +
> +	/* is fast-free enabled in offloads? */
> +	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
> +		/* Avoid txq containing buffers from unexpected mempool. */
> +		if (unlikely(recycle_rxq_info->mp
> +					!= txep[0].mbuf->pool))
> +			return 0;
> +
> +		/* Directly put mbufs from Tx to Rx. */
> +		for (i = 0; i < n; i++)
> +			rxep[i] = txep[i].mbuf;
> +	} else {
> +		for (i = 0; i < n; i++) {
> +			rxep[i] = rte_pktmbuf_prefree_seg(txep[i].mbuf);
> +
> +			/* If Tx buffers are not the last reference or from
> +			 * unexpected mempool, previous copied buffers are
> +			 * considered as invalid.
> +			 */
> +			if (unlikely(rxep[i] == NULL ||
> +				recycle_rxq_info->mp != txep[i].mbuf->pool))
> +				nb_recycle_mbufs = 0;
> +		}
> +		/* If Tx buffers are not the last reference or
> +		 * from unexpected mempool, all recycled buffers
> +		 * are put into mempool.
> +		 */
> +		if (nb_recycle_mbufs == 0)
> +			for (i = 0; i < n; i++) {
> +				if (rxep[i] != NULL)
> +					rte_mempool_put(rxep[i]->pool, rxep[i]);
> +			}
> +	}
> +
> +	/* Update counters for Tx. */
> +	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
> +	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
> +	if (txq->tx_next_dd >= txq->nb_tx_desc)
> +		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
> +
> +	return nb_recycle_mbufs;
> +}
> +
>  #endif
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index c99bd5420f..cc70fa7db4 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -37,6 +37,7 @@ struct ci_tx_queue {
>  		volatile struct ice_tx_desc *ice_tx_ring;
>  		volatile struct idpf_base_tx_desc *idpf_tx_ring;
>  		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
> +		volatile void *tx_ring; /**< Generic. */
>  	};
>  	volatile uint8_t *qtx_tail;               /* register address of tail */
>  	union {
> diff --git a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
> index 073357bee2..19edee781d 100644
> --- a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
> +++ b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
> @@ -23,92 +23,12 @@ i40e_recycle_tx_mbufs_reuse_vec(void *tx_queue,
>  	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
>  {
>  	struct ci_tx_queue *txq = tx_queue;
> -	struct ci_tx_entry *txep;
> -	struct rte_mbuf **rxep;
> -	int i, n;
> -	uint16_t nb_recycle_mbufs;
> -	uint16_t avail = 0;
> -	uint16_t mbuf_ring_size = recycle_rxq_info->mbuf_ring_size;
> -	uint16_t mask = recycle_rxq_info->mbuf_ring_size - 1;
> -	uint16_t refill_requirement = recycle_rxq_info->refill_requirement;
> -	uint16_t refill_head = *recycle_rxq_info->refill_head;
> -	uint16_t receive_tail = *recycle_rxq_info->receive_tail;
> +	const uint64_t ctob = txq->i40e_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz;
>  
> -	/* Get available recycling Rx buffers. */
> -	avail = (mbuf_ring_size - (refill_head - receive_tail)) & mask;
> -
> -	/* Check Tx free thresh and Rx available space. */
> -	if (txq->nb_tx_free > txq->tx_free_thresh || avail <= txq->tx_rs_thresh)
> -		return 0;
> -
> -	/* check DD bits on threshold descriptor */
> -	if ((txq->i40e_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
> -				rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
> +	/* are Tx descriptors ready for recycling? */
> +	if ((ctob & rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
>  			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
>  		return 0;

There is the function i40e_tx_desc_done (and similar functions for other
drivers) to do this check. In the tx cleanup code we pass that function in
as a callback - you could probably shorten things a little by doing so
here. Due to inlining, the indirect function call is eliminated by the
compiler (as constant propagation), leading to no perf penalty.

/Bruce
