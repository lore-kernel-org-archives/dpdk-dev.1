Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9CAC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:20:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCDEB40EDF;
	Mon,  9 Jun 2025 17:20:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 123B640EDB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749482411; x=1781018411;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=oMOVoZ3Ejfln9VjlxqlrW9eF6tIaaiAKSMoIC5pJtjk=;
 b=OjtxPAKSrFtC/Y62CePqg/skE33hQVkT/wj8gO0WWYa72PZYF8BDtTWC
 Ccxl9qyc+pW6FPGtHe1cs0lnGUjQYr0WIDhBvtBuUK7koyw/EAuf4RhFD
 RcxgfmlhfBwhPKsqBBmzn5gK/T2DcmGrLVbcD34EXQDcKkEZtcpv4XdTy
 8biOOdfKr4U+MOHTDVT0I6mrVnwUQkjcVm8zoHr9gorieWMlVzdflncok
 lggEgL1z2EDSkIk43804ARjc+HkFB13J0fS/qxEb2EKOxH6d20DxbvNaY
 K4RO0DvRHCYsp1w0MRyuhSbP9GAhnevD/A+0smfXYJCp+uGA7VNZwJ2l3 A==;
X-CSE-ConnectionGUID: N7hKc/CaQ3u9CdXtzdyWkQ==
X-CSE-MsgGUID: SVzN0Y+TQhK5oG7y98GIiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55355505"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="55355505"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:20:09 -0700
X-CSE-ConnectionGUID: taHixwOVQESfk4RpNPBv0Q==
X-CSE-MsgGUID: YWMge0agQZWFgECg1+3jaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151792288"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:20:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 08:20:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 08:20:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.59)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 08:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEEi6TKOE42qJEPC/IcZqSw+/risAt7Hn0nBTVPQwtrnxN85ohFA6IHmzPWExGZy5pJ1tR0IGfLppdVpQJgkO3RUnrobF9ZTyVotTkmSkfdvPEmgORYAssNYuOSiP+igHqdBb6SUfvSAHqX+4PJBnAsr8KZUHf2PTndzNyFWpoRA5lVp2NIhXgUwIvAbzDsQXnbdi1R8e9OU7JMl2oIIoMZRxn84gmnpMykBYOO/cGYdmAmx7EMHS3swjnIVRDO5w25rCI/CVF8x2fPa6qlcw26BvRWzJvBz/vthiVU6Avi8Vo+V25e41igV7wVsHWpbo8iGv/5MDauvO25YPRIMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71OSD3QVxpAmS+vGDCFV5fMth0oZoFsGJiX5eF0Zg9k=;
 b=DuzLLYeK5pG/+tmeuRwjTifW35bsluPV17kGmNXdq8HYpNbzeCYRQmTkE0ZnWxqIQoQmaga92wAhwDA2nI2b3I0LyFoiIG14Ek0IqCfg2MBSRWrM4BFtSwFfOUrw3Groa0H3WG0SJjH9aoJE67Q+guOGly+kreh85wnmA//wsjA5akRIlRmDqG9FyedE79+GFpDRttTF2WGQYL0JNWmhaR71acW7j+s2Ftq67stLGnKYju7+I4kTLk8cm4UXYVpgff+zisqnWmhd0YyloT7A1usRi2mu9tsPl702HN0s0whPoDXSO2wKyw5bcUgFtvVaWzJMAb7/YaQ86YYcs4Y1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPFD56C4208E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::858) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 15:20:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 15:20:04 +0000
Date: Mon, 9 Jun 2025 16:19:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 4/6] net/intel: add AVX2 Support for TxPP
Message-ID: <aEb7nmqDkIMV_8nm@bricha3-mobl1.ger.corp.intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
 <20250608113223.487043-5-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250608113223.487043-5-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU2P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPFD56C4208E:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d91397c-f55e-4b7b-667c-08dda7691c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qA/LdUQ50EV0nB8H7HC2uspO3nHkvsHpxBAeaSPHykSxaNAlKCpU1Wl1RzvO?=
 =?us-ascii?Q?ojGIofCjJfuasLJqjcPlYP+0y9ux4LDO4QfGksMmOFPA3/9lQlxD/5v7cDF7?=
 =?us-ascii?Q?Z4Zl2MVNXH8x/Sc0UTzxkDTpTjjSkMoiSpiXhbLwUL/6rEj0mC/UuLwm9Y6b?=
 =?us-ascii?Q?Y3QNBLl7MdqaMBzupK9nRF5tBCR/2035WRQzzDBoYDE5FmKGd8jNOXLX5/ez?=
 =?us-ascii?Q?OAZbC61ok5+zZrMmekOvaZ14HUsHcwupf0xR6Z7dlWJJEo4tQiOjE/Rb539R?=
 =?us-ascii?Q?GjQ91JwrnVzjX3reGDKXzlyXkDKFIe56WyJapb5nWvK96xBDY+60INZTGjNk?=
 =?us-ascii?Q?OmWaR8ZobNQDE2LE1hD+vkSdY3rEfktkU4yorOC37Os/R8CUTM4ESNubjcgO?=
 =?us-ascii?Q?1/4l+fMKVPv3YLtKjNQHgIOi05kqREOBvQNfi9V6t+x93OiUJxgP1Vcjv04R?=
 =?us-ascii?Q?MzO86R9OlU5/0cC5iXPuRlpM1x5jZBcu5u7aSEkjqtYQKlQkoDoPwUfFbXHi?=
 =?us-ascii?Q?Hhe81+X2gmXgSF47p3ivrsqgmtDYg7lgy5USjzde5A6CYQWfw9DqmxDrh7ts?=
 =?us-ascii?Q?v6HA4/Y7TxQURSNpBwsUcMOLJjuc5fFjmkWKSR03HzR3GfyRbw84urGHWuqG?=
 =?us-ascii?Q?zR8Vq6/dyAMzPJetS71MV4h8lHxwj4zVJy84aUpsj8ER53i1acMUl+frJLZW?=
 =?us-ascii?Q?t5F4oLMrpXsfnJYDes1ZHaFTwpIB2wpLP5G3t1szQbLikrEdyWv8pEYVL6ju?=
 =?us-ascii?Q?nCjds5yQPTeE3GIjGTQKIuZJKE1u8yRk+EolZ9IZeSES+5EorHTpv61W7IPI?=
 =?us-ascii?Q?S6na3f8qZ7O8h8wvi537aG5MuzKqs3FTdx94Hobkc2CFCS04SL4BpHIrQSMJ?=
 =?us-ascii?Q?XwtEOTUNp3E5Cc2IdexJyS3uu1LkCB3b/CZu1ZYfOWQCuQoXoLGGxVZ1+SPr?=
 =?us-ascii?Q?Ev7movosyp8AP4hVX1gBBXmjmZdvwoLD41oejeVIBYDoQlCFVBohO3PVVra3?=
 =?us-ascii?Q?FvoBOwJmq9cqPEURQ+VQg3jILfqph6MbGJ8E4MjvdfXpBphhKMXyVMWbCZpw?=
 =?us-ascii?Q?58CDmxBmYdml7lJ36ivL8Ng16PXaKgiX1QY36hlVgKj735u1xKT+FEIXEZHz?=
 =?us-ascii?Q?K7r7sMC/9klag11cEbsqYm17ZOHzdMkOej7xp33eUlDB5tdq4QZa5W6mmDYo?=
 =?us-ascii?Q?GgAAqyqDbAhvy/8Ruemt5DEqHdH1rX1I7C1gAWtyrGqaV3WD9Tlf6rfrL+0Y?=
 =?us-ascii?Q?4J/p66Ip7xAEc4kPlx4XCvnu8kYVb7rNdEP+dL44SCcP8zRqz22S3bVUeUhj?=
 =?us-ascii?Q?DfKXeJItGOgNbhW1KTUi7lUXKDeUI9SLUlMM4FOjJWyn4Ga3U3lkIzBDLwBX?=
 =?us-ascii?Q?KUHjRjp5v5ZHtgL/lHqqlxLmDV/wdlWOgG3SU5WoCXRCFcaTDLKnhNbIICid?=
 =?us-ascii?Q?pVX8S9KxLfE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XnZZk4mUblbL5xKCQzofYZXB/Muuuq95PsyARQ1xmj6bnNHHWdvEdO7Ul7l8?=
 =?us-ascii?Q?/QIyDAf5ruEegrqbsFXzdqIiF+TI4if7ho4a6ayDbb5U2cwlK4AM3R+/O/qW?=
 =?us-ascii?Q?7EhdJWvjZjx8wm/Xa1bgmIt+DRyn3e214tdDH95izbj/7Yq1It49lkfns589?=
 =?us-ascii?Q?3SFgEHzKb745DKvkorRmG81DGNrMv/AQmlen7CdeiSmjMUmieOx9qNtzJ84w?=
 =?us-ascii?Q?OCqgUkOzuMA2p3VgXYsjTtY8Cdgel7UgsOAhubfLpY7Y8ltWlUMBZmIMhpuA?=
 =?us-ascii?Q?jRAj9oONuESJclzzyFDPpgACymeEUWyoz2n85EkY4WLzv4W/LDt6ndNixv1R?=
 =?us-ascii?Q?c17ikJyAjR9PiN5GsYA5zCMsHXTcmEkSZab5EQzYmD3qJlMuii9LXJac9/s7?=
 =?us-ascii?Q?KPAbj3DM388GxGvrl6G8M5TkLVv7B0xFNNgAi9WtLQoUsogfcNO2gknsyqW0?=
 =?us-ascii?Q?RQESZldJnBy+Y7Rhbj6H4jZA9cI8MeZ4gj3sqUlRPcfeJotSn9261+Ny64Vp?=
 =?us-ascii?Q?IDJ5Tv43exEhWt2p+eHH5fDaMxScy1JYAFwt1OmsP4Y1l1pHkXknxxGYC5hY?=
 =?us-ascii?Q?+xQ6MLg9JSaS7RLA8ruf86CmmlZSByBJlDPV8mc4GDthJNVV5nTuop8JAyUn?=
 =?us-ascii?Q?mzFCqhuukVBM6/pUahyex04F9X6RPrwokWQONdekyPD7cNJ/ssQ768yOZams?=
 =?us-ascii?Q?+2S/q9lkHcqdoOu8oRUxBI2WtSSukEQD3dT7rGq3rdwlkz9iuiiwhsp6TT3D?=
 =?us-ascii?Q?tvS0TiAnBYZjWPPOmoFh7ZGqh56MY4oRUr8uEHF8pK1lFMZPrtS9NclxBnGY?=
 =?us-ascii?Q?uV325dd1WzbfxSsVEVWl9NtmN+tbydli75Xe1lKRmpjeYbjs10CYKhuqYPFH?=
 =?us-ascii?Q?Cuv4l4QHdqOtnvGfr7+C/yIVyFVWW2vjtXGjRA1GkLA30gumdKx8dOOgl822?=
 =?us-ascii?Q?2kWODbyOoDZbWaTCJOqNDsbf07wAFch4LZtxAzYDFIL8KbdvjyJCFIML1wnT?=
 =?us-ascii?Q?SZ/cQfZfkFB/QWccqEwkKg0vknI0WoQy0hNpS6iTZLeQ1NHAR+p+01DsvEzt?=
 =?us-ascii?Q?xkV9wRyfDyOWAf07Bn/eTPZWdiaR0DBq/NQ85PHEJD/te01DAv9GOfvz+Feq?=
 =?us-ascii?Q?U42kqQhRnBdxHmRuLz5+0z3mUoU8d7tJQQKS9yXlX891skaDzlBC1Tq3w9DL?=
 =?us-ascii?Q?YhBomCmRZZaU6H+URXGR6AYF+R7Tcvj6oIdjo5ukZghobplnD+pKfNpVwDwG?=
 =?us-ascii?Q?Qw2MvlUi/Jp0zvKE7PPUaK/dZK789psF9/2X7CCY0IINPke2SWCT64ZGqaDG?=
 =?us-ascii?Q?47dxSJJunR2TQ+mLqVYElDhNAK/LN1d09cwPt5KO79MkBVsWL2OoCmlz5vRT?=
 =?us-ascii?Q?Gr1rB9XcZ17Iht1OC0dI2LbcEHhaxLBhb622nzXXOOjR3FerEsXPJmvqvHFx?=
 =?us-ascii?Q?pjsdORv20BqYb7s6TQatTyy9NOa1PWpsGfJFZEnB6G40nzhoF6o205nHDSCp?=
 =?us-ascii?Q?DWn33A/IBjg9AuUKUyYQxdyYhYdCIvHAugF4noGWfp2/WlzGSEPu8RvWe9MS?=
 =?us-ascii?Q?3hSW8eDyK1CTOESK/DhYhiwRKb/coKcv+mLX8W2Vdxbomd4xpxktPD9E9JjC?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d91397c-f55e-4b7b-667c-08dda7691c4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:20:04.7268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHK6rqqFQ5+seSrsCoT7mnBeXWF7xFtIMJDLRnTlUVbGR8HGS/YVsrIHsCNPK+EkGu+HQHg/e8nYY3fLJNWjW5w7dfWdcqG6ZMU0lIOSRMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD56C4208E
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

On Sun, Jun 08, 2025 at 11:32:21AM +0000, Soumyadeep Hore wrote:
> Tx Time based queues are supported using AVX2 vector.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 135 +++++++++++++++++++-
>  drivers/net/intel/ice/ice_rxtx_vec_common.h |  17 +++
>  2 files changed, 151 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> index 0c54b325c6..bd2a277730 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> @@ -848,6 +848,129 @@ ice_vtx(volatile struct ice_tx_desc *txdp,
>  	}
>  }
>  
> +static __rte_always_inline void
> +ice_vts1(volatile struct ice_ts_desc *ts, struct rte_mbuf *pkt,
> +		uint16_t tx_tail, uint16_t nb_tx_desc, int ts_offset)
> +{
> +	ts->tx_desc_idx_tstamp = ice_get_ts_queue_desc(pkt,
> +						tx_tail, nb_tx_desc, ts_offset);
> +}
> +
> +static __rte_always_inline void
> +ice_vts4(volatile struct ice_ts_desc *ts, struct rte_mbuf **pkt,
> +	uint16_t nb_pkts, uint16_t tx_tail, uint16_t nb_tx_desc,
> +	int ts_offset)
> +{
> +	uint16_t tx_id;
> +
> +	for (; nb_pkts > 3; ts += 4, pkt += 4, nb_pkts -= 4,
> +			tx_tail += 4) {
> +		tx_id = tx_tail + 4;
> +		uint32_t ts_dsc3 = ice_get_ts_queue_desc(pkt[3],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 3;
> +		uint32_t ts_dsc2 = ice_get_ts_queue_desc(pkt[2],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 2;
> +		uint32_t ts_dsc1 = ice_get_ts_queue_desc(pkt[1],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 1;
> +		uint32_t ts_dsc0 = ice_get_ts_queue_desc(pkt[0],
> +						tx_id, nb_tx_desc, ts_offset);
> +		__m128i desc0_3 = _mm_set_epi32(ts_dsc3, ts_dsc2,
> +						ts_dsc1, ts_dsc0);
> +		_mm_store_si128(RTE_CAST_PTR(void *, ts), desc0_3);
> +	}
> +
> +	/* do any last ones */
> +	while (nb_pkts) {
> +		tx_tail++;
> +		ice_vts1(ts, *pkt, tx_tail, nb_tx_desc, ts_offset);
> +		ts++, pkt++, nb_pkts--;
> +	}
> +}
> +
> +static __rte_always_inline void
> +ice_vts(volatile struct ice_ts_desc *ts, struct rte_mbuf **pkt,
> +	uint16_t nb_pkts, uint16_t tx_tail, uint16_t nb_tx_desc,
> +	int ts_offset)
> +{
> +	uint16_t tx_id;
> +
> +	for (; nb_pkts > 7; ts += 8, pkt += 8, nb_pkts -= 8,
> +			tx_tail += 8) {
> +		tx_id = tx_tail + 8;
> +		uint32_t ts_dsc7 = ice_get_ts_queue_desc(pkt[7],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 7;
> +		uint32_t ts_dsc6 = ice_get_ts_queue_desc(pkt[6],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 6;
> +		uint32_t ts_dsc5 = ice_get_ts_queue_desc(pkt[5],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 5;
> +		uint32_t ts_dsc4 = ice_get_ts_queue_desc(pkt[4],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 4;
> +		uint32_t ts_dsc3 = ice_get_ts_queue_desc(pkt[3],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 3;
> +		uint32_t ts_dsc2 = ice_get_ts_queue_desc(pkt[2],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 2;
> +		uint32_t ts_dsc1 = ice_get_ts_queue_desc(pkt[1],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 1;
> +		uint32_t ts_dsc0 = ice_get_ts_queue_desc(pkt[0],
> +						tx_id, nb_tx_desc, ts_offset);
> +		__m256i desc0_7 = _mm256_set_epi32(ts_dsc7, ts_dsc6,
> +						ts_dsc5, ts_dsc4, ts_dsc3, ts_dsc2,
> +						ts_dsc1, ts_dsc0);
> +		_mm256_storeu_si256(RTE_CAST_PTR(void *, ts), desc0_7);
> +	}
> +
> +	/* do any last ones */
> +	if (nb_pkts)
> +		ice_vts4(ts, pkt, nb_pkts, tx_tail, nb_tx_desc,
> +				ts_offset);
> +}
> +
> +static __rte_always_inline uint16_t
> +ice_xmit_fixed_ts_burst_vec_avx512(struct ci_tx_queue *txq,
> +				struct rte_mbuf **tx_pkts, uint16_t nb_pkts,
> +				uint16_t tx_tail)

Avx512?

> +{
> +	volatile struct ice_ts_desc *ts;
> +	uint16_t n;
> +	uint16_t ts_id;
> +	uint16_t fetch;
> +
> +	ts_id = txq->tsq.ts_tail;
> +	ts = &txq->tsq.ice_ts_ring[ts_id];
> +
> +	n = (uint16_t)(txq->tsq.nb_ts_desc - ts_id);
> +	if (nb_pkts >= n) {
> +		ice_vts(ts, tx_pkts, n, txq->tx_tail, txq->nb_tx_desc,
> +				txq->tsq.ts_offset);
> +		tx_pkts += n;
> +		ts += n;
> +		tx_tail += n;
> +		nb_pkts = (uint16_t)(nb_pkts - n);
> +		ts_id = 0;
> +		ts = &txq->tsq.ice_ts_ring[ts_id];
> +		fetch = txq->tsq.nb_ts_desc - txq->nb_tx_desc;
> +		for (; ts_id < fetch; ts_id++, ts++)
> +			ice_vts1(ts, *tx_pkts, tx_tail + 1,
> +					txq->nb_tx_desc, txq->tsq.ts_offset);
> +	}
> +
> +	ice_vts(ts, tx_pkts, nb_pkts, tx_tail, txq->nb_tx_desc,
> +			txq->tsq.ts_offset);
> +	ts_id = (uint16_t)(ts_id + nb_pkts);
> +
> +	return ts_id;
> +}
> +
>  static __rte_always_inline uint16_t
>  ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  			      uint16_t nb_pkts, bool offload)
> @@ -856,6 +979,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  	volatile struct ice_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
> +	uint16_t ts_id = -1;
>  	uint64_t flags = ICE_TD_CMD;
>  	uint64_t rs = ICE_TX_DESC_CMD_RS | ICE_TD_CMD;
>  
> @@ -875,6 +999,10 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  
>  	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
>  
> +	if (txq->tsq.ts_flag > 0)
> +		ts_id = ice_xmit_fixed_ts_burst_vec_avx512(txq,
> +								tx_pkts, nb_commit, tx_id);
> +
>  	n = (uint16_t)(txq->nb_tx_desc - tx_id);
>  	if (nb_commit >= n) {
>  		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
> @@ -910,7 +1038,12 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  
>  	txq->tx_tail = tx_id;
>  
> -	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
> +	if (txq->tsq.ts_flag > 0) {
> +		ICE_PCI_REG_WC_WRITE(txq->qtx_tail, ts_id);
> +		txq->tsq.ts_tail = ts_id;
> +	} else {
> +		ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
> +	}
>  

Rather than having two branches in this function, if you move the call to
ice_xmit_fixed_ts_burst_vec_avx* down to take place after the regular
descriptor enqueue, you can do it in one. The timestamp enqueues seem
independent of the regular ones.

>  	return nb_pkts;
>  }
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> index 7933c26366..9166a0408a 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> @@ -215,4 +215,21 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
>  
>  	*txd_hi |= ((uint64_t)td_cmd) << ICE_TXD_QW1_CMD_S;
>  }
> +
> +static inline uint32_t
> +ice_get_ts_queue_desc(struct rte_mbuf *pkt, uint16_t tx_tail,
> +					uint16_t nb_tx_desc, int ts_offset)
> +{
> +	uint64_t txtime;
> +	uint32_t tstamp, ts_desc;
> +
> +	tx_tail = (tx_tail > nb_tx_desc) ? (tx_tail - nb_tx_desc) :
> +			tx_tail;
> +	txtime = *RTE_MBUF_DYNFIELD(pkt, ts_offset, uint64_t *);
> +	tstamp = (uint32_t)(txtime % NS_PER_S) >>
> +			ICE_TXTIME_CTX_RESOLUTION_128NS;
> +	ts_desc = rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +			(tx_tail)) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> +	return ts_desc;
> +}
>  #endif
> -- 
> 2.43.0
> 
