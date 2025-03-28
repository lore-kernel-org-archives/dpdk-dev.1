Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A8BC28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 17:25:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFEB54028B;
	Fri, 28 Mar 2025 18:25:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id E748C4021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 18:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743182754; x=1774718754;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1g6dWTselkduVdILu4vzgqMk1DLrkJocbFvVWWP8PVE=;
 b=NW3EDtZCRKPDNVkelrgXLDvYWgrdtWnSgdDl7FLIAGTMysXcribNejRx
 YkjMGqEO+PJFoDq9rMy8ea2qlROc6A26X9RWn9EpZYsU8Ab7GK9otWWL/
 AGLdcSZhhnIiGDsDdp0Elb6sO3vMDlo03bz3HSHdb+Daaf92pX7qgQdzi
 powjGgPgn+HVoJw8+lL3IvbOOf3QuZHJYYgzUHOqsVvdy1olasrHjo6F1
 mC3CBAhuI05ytFWdDN6YYCiPhw+237VPKL7L1HxWQe7CFJ49WqrslPBDu
 iPGsrsZB7Dv2RfWHoTv2cfGRBgQzT5lPkAT0g0ettQQZqxlU3pS6QLPDK A==;
X-CSE-ConnectionGUID: sWELxdyETCKzmBx/Jpz5QQ==
X-CSE-MsgGUID: /K8v7YAwSLaIGt90MVxn1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="54750287"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="54750287"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 10:25:52 -0700
X-CSE-ConnectionGUID: eRuDRmQQS8GIFcfabR4KJA==
X-CSE-MsgGUID: 2OOjxnGSSbCLTppWuweCFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125398333"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 10:25:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 28 Mar 2025 10:25:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Mar 2025 10:25:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 10:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBJeKtId01A1YWm71uF/+972DshX8ehxHSjbHgWY/fUjNtrLJf9eXWnQIaF+taSe1jxkcd+PXqyhq0ukL9PS3eElk3GN+QbpGkkJIrt9UQsfayXl2l7tTXvbHmbdRJLWaRfCsF1zjahbvAxRaRP46dNZ8btKD9DT5OkUCxrZBNwxpON5aT1cPsqP8UsxN3ItOBKuxKJcm3flHZYXoo6rhBRrF3LQj6eU6oQk86cpTXqmRqHWfpO0cgIWFe+BBjlkWNGc5EvtDdsxKSM+R6YBwP/KjYaFGBhcWsiOdflIcTXuRTpj+IDDSnSVS+fvb4Dpfm/9GtpUME2aDPEMv/FHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CWEBUGTa6qdzqejzFVq1TIhuERnJWL1+EwZwUmpAzg=;
 b=cz+n/wgiElvM8dbAo/rxeCka182ZJ2Ir6osEPsWxqd87/fB/uJfAtR4ZMqeP8wRt/o3RG5Ksszm4KvZn3QA+4ocRAQ7EwUveFyrtVbI/LUcoAI7ycWTqTnQnlIKUDYFdjMrj5kjCVob7kILRNm16Mr5CSDtd1AYwb9z9kDYXiZYFDm6IW0EBExSYD14YaQMuVa2ceGPZFQByRt9FkplyyjyxMf0OHdxgMCbIz6Kw22yINf4kw96ItiIkLOh2zCLOBhyLHQtlyEk8PW/C7Iz66DbBW0i8okj4fvuII89aFbmckHqfgjwlzJ4gOYrRkWQWIKq7vpwUzKvPs5FvODYMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:25:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:25:48 +0000
Date: Fri, 28 Mar 2025 17:25:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 4/4] net/idpf: use common Tx free fn in idpf
Message-ID: <Z-bbmOZB3t6GfeSR@bricha3-mobl1.ger.corp.intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
 <20250327160437.2296127-5-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327160437.2296127-5-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 235d7bd7-d0f1-4b5f-5b82-08dd6e1d94c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gw3tig/vnS8szxVzODvDRXV0SWwctZykQn4L0xnrrdHGgPwqGjKuQvf94EIL?=
 =?us-ascii?Q?srMCZdCOtbeC31HsOlF8j9OFLcCa2nGZCIZ6PTA/gP2QPcas/6XQ+pg9h87r?=
 =?us-ascii?Q?76YRsmboya9HB2srRYUHSFQIFvnSMqiUV+eznF+1ykBGUTrqGAzCwH8u0DTl?=
 =?us-ascii?Q?p82etbFislutYwmieIU52aYq8hk7nrN03dykuitH+p+riOwI7qhr6KQkJzRr?=
 =?us-ascii?Q?HnD390aH4udH9/EKB5qMfo/etZPsRTed1RjegzYrm6x7Nhv8IP7rhTvfwOMc?=
 =?us-ascii?Q?bkDVx9XRs5BSFPm5vwkt/tqCtdvfA9Y52mItTdrbVO0kMAKHMKd5rcohJ/hC?=
 =?us-ascii?Q?sxMhTh/bW5+Ud2D9aqx5fZD9w9dM4RVQ0Q3mc7ryqsvvfDzr1xlqpsCGndKU?=
 =?us-ascii?Q?bp/Rp2rXPZSgoTj5xZ7rrTrXAbZ8jpw3X7sMYMztZdAurL8+2eun6Cph57Q+?=
 =?us-ascii?Q?Buu8FLTG7fu8m0sYqeBnuFTeVxQMUk11OawG8fPu5gUkN1vOlO/3HC9Og89S?=
 =?us-ascii?Q?R5Ek3lrMA/jfqqoo0llm7WiPFl7k+a3fGIt+mfPK1Nm0ZzfWQjoYBp2DIk/9?=
 =?us-ascii?Q?9utNouB58IEqs1UD6vp3tftKnkSJDDaBQ9/SXSE91d2v0UWEINP9M1WGn5DX?=
 =?us-ascii?Q?AammOmUtPRV0IikGYRrzdcMW7po+l/cM3iwJu2TfP619uEiEGkMKkc4Bu4Xh?=
 =?us-ascii?Q?gEd51rEboEbbK2t0Mj5ti5ohIE9DpTh+mXjiHvmfZf6dy8HrHYQxnaou50+R?=
 =?us-ascii?Q?myu7NScx0MQA8Y9SdXQSZJS76Jflr+h08TRi5JwcT6Kadqk7XbxyUAWhOAse?=
 =?us-ascii?Q?zvqRyRds4nHSaSu7c/SyWgJCJQTTU8oysY8BgIAKSOMF1Wuj5Uyg9eXvvSE5?=
 =?us-ascii?Q?cJvfaj5Tf0nJB+xfDFymV8cydCiKUjpVmAFW7T33hVz78UEqDwqY17rvrWj6?=
 =?us-ascii?Q?R+1inkAzGUTUQBlubhbDL5SqI5o+B+AK04s8G+CeJ+tYOGUuGJPHZJWAx1ra?=
 =?us-ascii?Q?btgqytHeQuIJuo344f4nGG7Uy5g9HIXljUp+RUVeMBSvx0B9pBZHZjnHBh9H?=
 =?us-ascii?Q?xBvyVgk7c08cxlcWcFhpoEjY//xFcaGNjPSgPvt6UESiQkO0lhZfpgmlmc/8?=
 =?us-ascii?Q?WQrWPgok1cU0kX8pTbriyaEqdBAVBXLGv7uS5+UP2J1PYRez0G3k83D8ECTS?=
 =?us-ascii?Q?yfVZQybvH+RYO6JaaGmbH+TlBaGJDj0+z6/+yrN4eo/mnI2ecs+ZPrJ1kWjX?=
 =?us-ascii?Q?iS6q7FT1bHdilF4GnGtihsDBIrTHKuwjWGIo8nYjLydC3QmgfkDdL7bMRRy7?=
 =?us-ascii?Q?mjb7vcOis8ARPq4Yz3yAJwaxFx41vUQ1x58hmpsaa8jhNmHsVmrCtXTNq0EC?=
 =?us-ascii?Q?Hjenid6P1HKUnUZwY58s013DGB89?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b9JTzsypDJFGupQd9atLhspwR5zK8h+feujOcIMV0YDWefLAeJ9KYEWrF0t0?=
 =?us-ascii?Q?3B3SrErBrpBTGmCI/S4AZ3ACATsds3DhHKwg+M6Q7QRl/EGJ0f/Ayc8+8BrB?=
 =?us-ascii?Q?bMZHO4u/tst3akOJmg3qOd4I5Vf5HTPUYzTRxNGe3mC+cSrtdOI7oqKApmLd?=
 =?us-ascii?Q?vQMnOQiU7RY+qgu3fGiMXD8x6xlN4M7FD5pAVz1pyUek8/7juI29voMJyF49?=
 =?us-ascii?Q?31IV+VY53X9OZDqGctcvSav3V63qwO9BiB/7iL+5NKQwfus9iECxAC7ISeng?=
 =?us-ascii?Q?WJJ5wa8Gu8zCjZCEXu28I0cUpDKokCnFUyaDioxtN+TF3iq5r7IU6lVe6xqF?=
 =?us-ascii?Q?oU/lBx/8v66sUlg2N1gOKzQs1F+0nT5EgCDOJZrdOsJod6m+9+eG57xnLjtN?=
 =?us-ascii?Q?87TIOYKfMbuu+85DJatPOS/QDG/kZctwneaQnfZzPqgn5OsAHjkhgtkgzL7g?=
 =?us-ascii?Q?6JwZlDzUMTelVHIFHJrmp6uXSCMcFafgEvxOr+M8sES2+WzNljNc61qhAD5A?=
 =?us-ascii?Q?hRFrJVC8Fjl7G2avTrqEn1ykKr42Q6G0QazFGZ/NrsP2iZZhLIp7n+ePwp7x?=
 =?us-ascii?Q?Y1AyPBqk+psQ6t9lt1Jcz/FMVifjr6zfrtZ4wTGBXqkwflQjZsHJCnwmfoHW?=
 =?us-ascii?Q?YsUfdE04jtPE25ABcP639931LDR/ijkRPtSRokMqwSN1nZ8DVRqXGrG/xmog?=
 =?us-ascii?Q?3Uw4KsxUKdHThwFJxZjvHhvNB/Y4awhc9pY7jel1iTpTOGvtbFgMbzHuS9xv?=
 =?us-ascii?Q?dNBJZRuOnf9a/f1+/rthYkHul4hSEFJdwusf3v9w0ra9aivU8VdbHjj+g/1b?=
 =?us-ascii?Q?PLrl4ULFXR0QnlMluclBBtraTlh66ew7J+qaOFcZL85y3S3N83ajPeN2qGic?=
 =?us-ascii?Q?t1Ai0Ks7fiId47nZXFNHbmP9mVfRXrm1beYMN34xcTA6ER+5giqx5S5y0quM?=
 =?us-ascii?Q?kawdmncYgBa91xNJBN+iL6wlI1tcXCCeQtM593Bc/IBwh392/doW6wgz93rb?=
 =?us-ascii?Q?9wa55vrZBu/96iE7lpKpTeZbz42DaA5FehxWgcCGIpPrGk2qX1gX7kZTitFU?=
 =?us-ascii?Q?JxEIOpkpJkvVS+YQIHIbPpBKM2T/NSm8L0VNjsfaHrhLSWQG5D/7XRXRLI2K?=
 =?us-ascii?Q?wtd/NMIv5oDaEB52KA7nLV4KzGmceZVE/MLVYTshF/mlUmQ8GeWr2WY12DJu?=
 =?us-ascii?Q?LXBV79DSYQ/cUPlW7TEoLXNw+KFbgJy2izir6Sz9UNS4yqkrtV635864xYfi?=
 =?us-ascii?Q?7tYpHgUso19DhvbaK0YrDK79QuT68oRHXFp8dcw6Aml3MXescPygSuJO1en8?=
 =?us-ascii?Q?igpOb4afKFMNZFFL/0HWAD0WxZLQakIT8iU0NegyCQZsZu91gS77U0qgb3/A?=
 =?us-ascii?Q?hFAuIGsLZIluWaya+zShzqC5UaqIIwKtx4Y5SCMlMFxjr6ELRh6rBvpeCMHQ?=
 =?us-ascii?Q?P6wI8ibCr/98Ujfb5SPgd+Q92WszluSJ0sH5UWxIHhiwvhyf4qxwkJyX39rv?=
 =?us-ascii?Q?eEBEs15wOyXV3Vyn0ODg+PCCjGbilG/J4U/dnqNbh5NELcZiS+smilY5GYfw?=
 =?us-ascii?Q?C2LY2fqPPfiJpJ7HAkMpQ6lsHp5SwT98KSqR408MNwlBUiec7ZaK/4Tqugci?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 235d7bd7-d0f1-4b5f-5b82-08dd6e1d94c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:25:48.8002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqjmoG6EEYqb9psyw8n1xi+eYrGKEGi7Y9cczOQphSzJwMQzaf6YOIP+wrQlYQvYmYHGW86yM2CWS/0CI+xpTaYFwED5xcdmIah84Gtc2kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
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

On Thu, Mar 27, 2025 at 09:34:37PM +0530, Shaiq Wani wrote:
> Switch the idpf driver to use the common Tx free function for
> AVX2 and AVX512
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  68 +----
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 237 +-----------------
>  2 files changed, 22 insertions(+), 283 deletions(-)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index bce0257804..6399f357d3 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -79,6 +79,14 @@ idpf_singleq_rx_rearm(struct idpf_rx_queue *rxq)
>  	IDPF_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
>  }
>  
> +static inline int
> +idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
> +{
> +		return (txq->idpf_tx_ring[idx].qw1 &

Minor nit - watch indentation here, this is indented by two instead of 1.
[Next line is correctly indented at 3 levels, though, so don't adjust it]

> +			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
> +				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
> +}
> +
>  static inline uint16_t
>  _idpf_singleq_recv_raw_pkts_vec_avx2(struct idpf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
>  				     uint16_t nb_pkts)
> @@ -479,64 +487,6 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
>  	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
>  }
>  
> -static __rte_always_inline int
> -idpf_singleq_tx_free_bufs_vec(struct ci_tx_queue *txq)
> -{
> -	struct ci_tx_entry_vec *txep;
> -	uint32_t n;
> -	uint32_t i;
> -	int nb_free = 0;
> -	struct rte_mbuf *m;
> -	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->tx_rs_thresh);
> -
> -	/* check DD bits on threshold descriptor */
> -	if ((txq->idpf_tx_ring[txq->tx_next_dd].qw1 &
> -			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
> -			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
> -		return 0;
> -
> -	n = txq->tx_rs_thresh;
> -
> -	 /* first buffer to free from S/W ring is at index
> -	  * tx_next_dd - (tx_rs_thresh-1)
> -	  */
> -	txep = &txq->sw_ring_vec[txq->tx_next_dd - (n - 1)];
> -	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
> -	if (likely(m)) {
> -		free[0] = m;
> -		nb_free = 1;
> -		for (i = 1; i < n; i++) {
> -			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
> -			if (likely(m)) {
> -				if (likely(m->pool == free[0]->pool)) {
> -					free[nb_free++] = m;
> -				} else {
> -					rte_mempool_put_bulk(free[0]->pool,
> -							     (void *)free,
> -							     nb_free);
> -					free[0] = m;
> -					nb_free = 1;
> -				}
> -			}
> -		}
> -		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
> -	} else {
> -		for (i = 1; i < n; i++) {
> -			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
> -			if (m)
> -				rte_mempool_put(m->pool, m);
> -		}
> -	}
> -
> -	/* buffers were freed, update counters */
> -	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
> -	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
> -	if (txq->tx_next_dd >= txq->nb_tx_desc)
> -		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
> -
> -	return txq->tx_rs_thresh;
> -}
> -
>  static inline void
>  idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
>  		  struct rte_mbuf *pkt, uint64_t flags)
> @@ -621,7 +571,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
>  	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
>  
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
> -		idpf_singleq_tx_free_bufs_vec(txq);
> +		ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
>  
>  	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
>  	if (unlikely(nb_pkts == 0))
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> index c0ec754642..dbbdc71e22 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> @@ -122,6 +122,14 @@ idpf_singleq_rearm_common(struct idpf_rx_queue *rxq)
>  	IDPF_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
>  }
>  
> +static inline int
> +idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
> +{
> +		return (txq->idpf_tx_ring[idx].qw1 &
> +			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
> +				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
> +}
> +

This code appears above two. Can it not be put in a common header to avoid
duplication?

>  static __rte_always_inline void
>  idpf_singleq_rearm(struct idpf_rx_queue *rxq)
>  {
<snip>
