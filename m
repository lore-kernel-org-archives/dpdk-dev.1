Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0784BC77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 14:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4581340267;
	Thu,  3 Jul 2025 16:14:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id ACAAC40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 16:14:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751552066; x=1783088066;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=sG2fiUii9eTRmL6+puzwPnois+R0k9LbSW+Qlb9rfJc=;
 b=gaVYqWkL1YfoC3wwouB2mRh6PKU4z2pAL3OPHN8W64qwY4bfIezn8EfW
 G+0ymmNX52bBJ7aJKWD9l4lXqXsEvYnGh/Xec6jQpJm4L1mHBoniS/Y8t
 AuPkkTsQ3wLf1fokU9HyCp/eiOMiq3D/4njmMFtlER6o7jv1I0z6c1LQb
 sLHRAL4F9qTNlRMIhmDT45nInDJnggVPGpk0Nc19sYrfT1N+TNOZnfFGB
 w/GQUXashpRNC8YNnA8IYYdZ7lDxyNB4jgULtO+cMmX7Jbo/twakUmvFV
 h+/0lJqIsbUuR3eUU+1sJ2xBa0MmYZqHUT9foCJbznH623K37tklX079n Q==;
X-CSE-ConnectionGUID: G+3A4zE+QG2dStVqz3pHJw==
X-CSE-MsgGUID: RZ3SGN0hRteCNLLe8GMpfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="41504948"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="41504948"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 07:14:24 -0700
X-CSE-ConnectionGUID: 6m73T6a9RaeVsVTTiOWBcg==
X-CSE-MsgGUID: O8reTiqLS7y1FKuV8Ra+RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="158944851"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 07:14:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 07:14:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 07:14:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 07:14:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQt0AfmPxxC+A/xwTBFI4UN936FOmEkIK/0VRTV5ViQTOn0zo+NJGumgU1uu/r8g6qiuFBfXD/3pd9Ni9HQzhw8talRb1OmmiIgSnx3ZgCLrB/jg0xrcRTnnSvUAhr4wUEhsBN5Ry21jf4NyhvRik1mV+JXWnLzfK1pcqaIQUI/hkTITcMDCXDQtS5jBw+wcD66IAZ9JYYqbus/4y3l5hKOkZIhgG0MYxUuz/FD+JI8Jt1DtdueWjiQVi3DuCPPAL+4a6P5yOqEmhlp1aM6GtytGLZvqxze2ChnzFVJP0hJGuTa7XUdafRmHwja5j/X9tz/FLnGII1SwCEOB1OLjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVFgY/aFnzMNHIqOft+tWV+p8rCpzTv8OHKGtVRWLbU=;
 b=cbVoWNkUicLe47LVxzFV6flZtHZVjEtR7IXD8gH/B9SPnbMgL8AaLUgsjYUMH4yr4HLPuVdxHykxkV0urBxTfUY3K8nSR3knKiIYiiHkHTh1U98D8CvVIq1lajEoZ27TDLU6yinnBXjuMlAOYAk+JYvulxHXxSfa0pXUdJmtJSTcvgQlktNrt3TazyV7rufdRVFViCVKc50yLWOBDNdvqKCuqek892MlAICb0LhYZDtL6WR5ZMWVHOnW9hp1ImXpcl0BPjATg4jdCuLG4lbmYyoQOBzKLwBjnwo+JjsJue9LmG4eU0EDHV7g6U1LqWzR9Cv5L8Qc4yMBHm6IpPJHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 3 Jul
 2025 14:14:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 14:14:19 +0000
Date: Thu, 3 Jul 2025 15:14:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <thomas@monjalon.net>, Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 <dev@dpdk.org>
Subject: Re: [RFC] ethdev: TX mbuf fast release optimization
Message-ID: <aGaQNxwbTTTF0Al7@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD87@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD87@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0341.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: b541ef9f-18c1-41dd-e7e7-08ddba3be6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?nUeMHL/8JOad3kv7n1NMuGe08BZizbG2HRMQatgLDxNOXaZ+RvlZfY06R9?=
 =?iso-8859-1?Q?ku/2E3yS/M6UbABSOC6SAs2UV8NY2UuRR+vsgOPk2P0ebCyvfKQFPL0gIk?=
 =?iso-8859-1?Q?GUEvWFxH+wmrdsdnq1YPaZ6xpkqe//B5Sjx2m3i6Nd7q/LG2wz4TGrbED1?=
 =?iso-8859-1?Q?DBxGDJ0kJzcpqoyFeXWzML13HMjeD0YP+YjNzNd+5SgeE8uLZL/7SmQ32J?=
 =?iso-8859-1?Q?v5VQ4AH/XMOX9UDMl8xQvdKwXFnKb6ejGDVa1GETsltBqDwYbyjubHs3LC?=
 =?iso-8859-1?Q?Wc1vCNAuMTmCO8E2v0M/3K7X/j8JclLVpaut396dl8+iFzYSvq6Rdo2Wxb?=
 =?iso-8859-1?Q?rVUw6GE4VbdFZDDvTDuq1MpklH/Sb5DDicK60A1IRBemy/+yebsql7/5kE?=
 =?iso-8859-1?Q?2ePdQfdnaD8nDqKDrTsMEIYMakrATBMPqYhHqfUv7gaxFy/p7f1n5I0WxY?=
 =?iso-8859-1?Q?LMCqcodQCi5R3AA0STKZ1/zlYmOXUAHLz+j+58xsRj4GO8oLVXwEm3iVU9?=
 =?iso-8859-1?Q?J7/k2oAQh9/8o3AlRp44AiaOPzyJsCHrOn+xzYX14k+fnhqS2iEuSgf/Gl?=
 =?iso-8859-1?Q?7/Kb0NuGCNHXXXT2Rdw+OtOc+9jEsm6CWt4vdedV+0rZaMs9JUToJjwLLY?=
 =?iso-8859-1?Q?pqPL/Qil7hCn5Z0oLbOlddqMS6PJaRvd3yDgY6GIjizie3uY7YJipqo0EU?=
 =?iso-8859-1?Q?/T1B9AGSwGyHzft9B0ARntfrRk/SJ4l0mOT6+9D5XQsBz0N6HzEW9FnVoV?=
 =?iso-8859-1?Q?iDTgABn1SZxc6OpaXT9hgb/fsLt6h09LPE9kBkKxrBc7DMYMm+EJLerUKe?=
 =?iso-8859-1?Q?9OPYNpAzdR8kMkiFjk4Ppx6Kjz2Oda8+dj1giPdYbu4ZPj/sKJ9uRmFwYG?=
 =?iso-8859-1?Q?EVCcWQcgMEVagg8UJc8QSK2R6SVtxwc12XmDC6JjZOmG9tKGli9Y2USuCE?=
 =?iso-8859-1?Q?4fiDKfrQ0CgA0f+B47lrZP8RDY18A3zRjL2RQGo+EDd0mmnXOTjABCgus4?=
 =?iso-8859-1?Q?0D/BZd3hzAJjlcZT3tEkiD7VXxgt0oEY3uvdaqJwBtlMpnIvh8+ILImIWy?=
 =?iso-8859-1?Q?ufoTjGR6PZcJHvKi2IX2gh+brCT6uEcIyRRh02e4DJJt82YrEZr3cspDuJ?=
 =?iso-8859-1?Q?JUoq4FIAPCJApYeVZc0WTwCkSw6p7C3G3I+8uCR0UQ0uRhJydA2t5ZAcQo?=
 =?iso-8859-1?Q?7XzfEXSqDl/1zGL8IiLYAzGjrD46Zf14N+1ztSugv9q3tKxU7onVUm8dlG?=
 =?iso-8859-1?Q?6higIJVbS7VmDGtnop6frmWB0rvFiPdBP86BevOkgpqXB082CLbEccmc1k?=
 =?iso-8859-1?Q?kPztLaNch+p0GmjQxO4xR2efTwqvHT82rdDlTchPIg6WY3VdTvmsm0xr2B?=
 =?iso-8859-1?Q?G06vketcNsa4EpxnFxx/Pj2eNOyj/ATc9IPl4OidhKz2DaZBNuK3c3oGOr?=
 =?iso-8859-1?Q?Qr9XpifQRu8dyM5gAnrrB16yZ8G5JMaM49XL4vdJwiBtiyQzflnvFgeqgt?=
 =?iso-8859-1?Q?g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?te6x7fXsecfqjHIaZXyiELFJFD0bCZGS7rMbsGh3phs1vIahERkIhFrSFb?=
 =?iso-8859-1?Q?1sTizOJqWZ+T66YbYYAcJNQ6baRc6bFzD5ibrAtzMURFNfSbol4mO1Bqyw?=
 =?iso-8859-1?Q?UB5gWLaXrBcqA3DDwqNssczwjfJPkYftc0gOLCaUzJ46ok6A/UlvKEu9Dj?=
 =?iso-8859-1?Q?ch9K8swSllyvAcGFW5M/wkjH+K9ual2yIj/khK55y1VEzTQ8G6q/9Hc3hx?=
 =?iso-8859-1?Q?hTIbVr+gXmRrvmMNTlbiImzUgqS8TauW39Vo6pXy2bj32lmTdY7YqOjifr?=
 =?iso-8859-1?Q?fd+urKFUOuUp5gZLi11N+FOXddrReqmmOL1FOzvX+N+LZLyVoTZo5gbPXR?=
 =?iso-8859-1?Q?BOpdLzLBx616DHSeY+Xs7nBDtP1zTnd3Bx3KYRrV+1WhFvUwjMjbWGBmmt?=
 =?iso-8859-1?Q?iWE07PQnqd2QIRE1CmxlX7DtLZ2ma8O30N6KyktvfGEMlt9+YBqEcIq6CU?=
 =?iso-8859-1?Q?jiDkfpQMwccPA7Rljh71XY3ESfRnfSlePv5YihrTgJMWj660PPCToK2vGG?=
 =?iso-8859-1?Q?ipXWmAPO9WD/T5zbHy3XEwOsxggkoKs5VaYf2/bkl2JCBcSPU/ICy17cFr?=
 =?iso-8859-1?Q?kgra5+AsC+gmm4AnE4q3Uywwb6hgfNM3TKpaUmWK8ROg70NxNuvsVuaVZo?=
 =?iso-8859-1?Q?ZhbKmMaaicAZnAzSOLz7eobRQfhj/uGz63rC8AZ9MnynguzvsP1HOxxHNl?=
 =?iso-8859-1?Q?7CzzCU3ubwG+zmKpj/WBUIP6oJqlv/AqcabL07MmDGZpGdi6QBlfnXPwZd?=
 =?iso-8859-1?Q?h4QtckjZBXQ0F9PE8sp4aVP29WDYYTLDEAslcLZc1oBI5cYLOXNdD5pfoT?=
 =?iso-8859-1?Q?P3PwBci8D/BBjRKdHNVNnD8Q5AWqDqfQC0XvANsxCE9DoZhCzeGF+TszcM?=
 =?iso-8859-1?Q?ZXDiB5yZDuXhh7MjVKGDfRdSRkhOrbuOx/QSCuEtI1GlUt0LrHxV2h4B/n?=
 =?iso-8859-1?Q?63TvRCzlAd0lJxpOTZag6CkWwMPWO9J3X33cHSrlAHd5Pfrv/PYnDJm2q0?=
 =?iso-8859-1?Q?YK+mp3boR/bauFLwry793zE7GHUyluNI5slvUYp4bBczQf2oquuVdXZDgy?=
 =?iso-8859-1?Q?aE31x0tsgwakOMFTWUmzPtCZbah3MOwzU++62tTnchQrMbdp2WvBl0IHLu?=
 =?iso-8859-1?Q?z9rW2URB1PDNUPVAFHgNeiIyYeui4QBdpTKGXaHg+t7KDlrr2iS0mSMAuC?=
 =?iso-8859-1?Q?7OBS84S+jUCTI9OOhi/l7YYd4tdaXemVuOGiAtE5pxz/PtGPMNXhyCaqsS?=
 =?iso-8859-1?Q?7TQUJw9QL6MGdMZLTvwm17Yqd7HD4VTp2WKIz+qFFYFU+O1duWMCGGhHIe?=
 =?iso-8859-1?Q?ECZikrJkHRMuE+LaLxOD3kPf/b3knaat3y4y3OaDXl8aPV2ZBW5ky5MU51?=
 =?iso-8859-1?Q?YICLjL6g3GxBqgS4PF63abiVziObOnDzwC4lbmlPl/E8HGZuNLV5JquzHj?=
 =?iso-8859-1?Q?1ra5W3VP8PYhjHFPgZHC9Q3n/52ZaJkXSfn0syi7xRTY9yaYCQKpge6eOg?=
 =?iso-8859-1?Q?9KcxsSTEXegMoqpYGbLUv1XAB6zuTinsScImK+Pb3MnueLBcUm6Fp6PkO0?=
 =?iso-8859-1?Q?uqn3fA6aqqI22sKmYClhwEOjKBMnjXck5pjbthT93hJGRh81J7MPOLvxLi?=
 =?iso-8859-1?Q?+fEpZzPt8PacK42FMvycWc9QpkmAKCc7CakzZd998zEz61nrKZH2l3GA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b541ef9f-18c1-41dd-e7e7-08ddba3be6e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:14:19.9117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVGU6vCcpCjdOtnlgM7XegnQSwQzifLhXmhl9COISEer3WBxDrko025sBXhW/Q3HF4PD0xoKkdAO0WndT4Sqdfcev2IPqgvYxa1OHRRuEno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
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

On Thu, Jul 03, 2025 at 03:59:14PM +0200, Morten Brørup wrote:
> For TX mbuf fast release offload, I propose to add the mbuf mempool
> pointer to the ethdev tx queue configuration structure,
> so the ethdev TX burst operation doesn't need to fetch it from the
> first mbuf of each burst being fast free'd to the mempool.
> 
> This modification of the struct rte_eth_txconf, and the requirement
> to set the mempool pointer if the RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
> flag is set, will be an API+ABI change in 25.11.
> Should it be announced in the 25.07 release notes?
> 
> Note: We could phase it in softly by letting the ethdev drivers
> check if the pointer has been set, and fall back to fetching it
> from mbuf[0] if not.
> 
> /**
>  * A structure used to configure a Tx ring of an Ethernet port.
>  */
> struct rte_eth_txconf {
> 	struct rte_eth_thresh tx_thresh; /**< Tx ring threshold registers. */
> 	uint16_t tx_rs_thresh; /**< Drives the setting of RS bit on TXDs. */
> 	uint16_t tx_free_thresh; /**< Start freeing Tx buffers if there are
> 				      less free descriptors than this value. */
> 
> 	uint8_t tx_deferred_start; /**< Do not start queue with rte_eth_dev_start(). */
> 	/**
> 	 * Per-queue Tx offloads to be set  using RTE_ETH_TX_OFFLOAD_* flags.
> 	 * Only offloads set on tx_queue_offload_capa or tx_offload_capa
> 	 * fields on rte_eth_dev_info structure are allowed to be set.
> 	 */
> 	uint64_t offloads;
> 
> +	/**
> +	 * Per-queue mempool to release the mbufs to; required for
> +	 * RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> +	 */
> +	struct rte_mempool *mp;
> +

Is this really best put in the txconf struct? Would it not be better just
stored in the queue structure on free or Tx of the first packet? That would
make it not change the ABI.

/Bruce
