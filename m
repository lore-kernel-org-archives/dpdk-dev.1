Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC05EB26F3
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 17:40:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF6B44064A;
	Tue, 10 Feb 2026 18:40:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0574840608
 for <dev@dpdk.org>; Tue, 10 Feb 2026 18:40:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770745234; x=1802281234;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/HrhkEUb7MBDN+XRbD3JdAJ0veZ00xGxaEsCjwwnDUg=;
 b=NQSHXMYqLIISpxcSbhqpUQKly68Mkv2TA/RNH4VvclvGKYXa4MA1hHns
 arozoJ88IVyp3KNozZqy/MOjE1SSq7nLI/d7ohTdyjR/6qZSqwqoW3kKr
 R0F2koh6AJOKcXlHwwVRKLtZZDDTsCd4hScNG8dVxgNzTL0NdpQK+qspf
 z0Rzw7H/n7Gu6i4faoA9ojpmFCzvlHfEqUXUak43HuguPco+aeeyISt26
 Xh68cpq2DppUmvnATCW9fthaf5iRIO5NAG0TzSWkMWOzWxas7DKWgs+5H
 ySc//GN+CL1mlIb098VFEcS612njYgswKfC9UsjRmxyjqVeOQPOUKQREL g==;
X-CSE-ConnectionGUID: WOyTIO/tSuKfJo++O4sKQA==
X-CSE-MsgGUID: YTvSngLlRza9uZDScVU8Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="70897280"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="70897280"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:40:33 -0800
X-CSE-ConnectionGUID: STAUXamcTzyKyHwK+tJF9w==
X-CSE-MsgGUID: uP6GSoXzSeSJO4KUoXlTsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211460523"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:40:33 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 09:40:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 09:40:32 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 09:40:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpN8jWaYIvFZjWxklgZrNuYMvuPj0sujZ/DkXUHyBR4eqKeU78dHaq9CrcNcNh2Xtu8lRP2tjGHx4ZXgZQW3NZJChIZltrg/yc87fjYpdwelBtXDUEY/9BgHZZQ4ASNK9O96ttmEFgHRx+rmjIjsXUmdXub6YfmhNNzW2fzlBzYXJq7cCUy0KePVnC6KIKxvqJK8CzD9QbO/H5XbwIIh+vIYlifWAPL69inp9kB06S8HxPmEfHaY3NvIrPq4xakyrnQmCcTx3yt82DKHIdfsGZcTRoiSFV1TAj84Ry1PmC/ZXeEkNO9DMBVBnAvXAEk6beEalgRNhK3APPFWz4clvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQILy+ny6x8zweMnWYsJt/BisZM2vIK9dyPAv23g9XM=;
 b=rX3YN1iPBVAclMXOIdaaI/738b9fyCJ6/ByqaP454Rcbaae8+P3ylW4FN8zsJduOpZbClts7HRSXmOyr67UtwnVylFMrCJJvmm95nK2Cp56B3GXxzphwWUZSVnEj4031xBE8dFQdZL0svUN1sFBS7jQqnY6G0LvOYGqFhEe49l2NlTXypWZDJxLexMtZEr9P68ttJAbBCVYmSOmteU12phnTijzGtsLXaOHPRL+c5YKHDc3DE2dS/TsiHtVolO9SLpw09Cb0FwcWaIXl7r7SVPEmYcXSaAFSGDnwyUrTTJe+1ohsMXx8Tc0hme3yfBTKuH9B0PkQIxlrW9/pTYT+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB5253.namprd11.prod.outlook.com (2603:10b6:208:310::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 10 Feb
 2026 17:40:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:40:27 +0000
Date: Tue, 10 Feb 2026 17:40:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 06/35] net/ice: refactor context descriptor handling
Message-ID: <aYtthv1wbK7xHdm5@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-7-bruce.richardson@intel.com>
 <f3a53f53-e636-4660-81a8-5ae3b3fabf0f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f3a53f53-e636-4660-81a8-5ae3b3fabf0f@intel.com>
X-ClientProxiedBy: DUZP191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdfbadb-2c16-4009-53bc-08de68cb7a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oxqIUBaOOBiT9+nPr6lKfgNsgqcD00Lw/MT1Wjj0dT8Y3N7xrEBkra2mQa6p?=
 =?us-ascii?Q?3EdwFiOI6h7ko9t20vU+5nWAme4J1PSrGkYRk/fhtzIKty0OPfc97/k6MNKX?=
 =?us-ascii?Q?rLqGMrd0dwRbvt4j4Iw3mjT3ukbAgPqnpRsSMKeDrL3bsdzlDGvij0+ndbYl?=
 =?us-ascii?Q?PTxv/JKJuZsv+NAXbEwolQCspV1CmqxdzLg+onadXxkY9tvSO9JYA1aNulA2?=
 =?us-ascii?Q?SINcOi5xbsWio/qaLTM1ByuK7FdvuFxiEDwDMMv6Aomoj4U3TgyaeSr8wPJ/?=
 =?us-ascii?Q?9go9Lo8xfA65xDryZr/1/4vh7jQykA5oul06RLAg/Jgaek6rshYda561sXvD?=
 =?us-ascii?Q?EXxL/uZDI9nuHMpxKMrZffIa9s51WifDThm5aZ9P5i98I7iKKoKtTw/Sbg+T?=
 =?us-ascii?Q?huK9kCWJAvX2nIm51VaYjhtdEx6L7KSRufYykYKD60K9tl41gHxHxvy83DJy?=
 =?us-ascii?Q?A2al8wPqleAY12kj5N9LEZ2meoSnxCONyKhwhI9/csX3j++lRpgBiLtazY/Y?=
 =?us-ascii?Q?arxuU+vE4NeUbnuFaifrSMewjZ2ThMYLjM769evxTD5mQyOSUCF3RiWDst8e?=
 =?us-ascii?Q?OI0elAomFAMtLJurowMVZv4GYrsyo8CEQ7CrYRiPoGVuzJjSo4o72JYZSrxv?=
 =?us-ascii?Q?L+uofSHIa2GAmRjQh8Txkz2l6ZPkmff8LCWk4Gsg2Bs2z+9tBf8TzJduFPFB?=
 =?us-ascii?Q?f2ZVfy89YrIXbcd8n2Mrzbs7C22k5swfM1xFQU/9JaXS2KAYp2YvtZt+ekOw?=
 =?us-ascii?Q?h+fhA7r0cupP+iJ+k5f8Lvtoe7P4nCcCBrtyN8tc0FNTtEyWGJHW6rsXAYaM?=
 =?us-ascii?Q?/fPG5EfEq/iykK0Lp5t1XTKmqo5P1dqloJsyTEBg++9A++28nixgDiWRYibo?=
 =?us-ascii?Q?idTi7Zi4O9pkuTDx0nHw5Th+Vs8p7pj8nkiYX7QCyQTTstQ7TewXqhHfqjAH?=
 =?us-ascii?Q?/0wVEPvaxpcYe1K0ekziuI03vOQBngA7z2EEKhAd0/H/3wpBDfk8MrYLv+w7?=
 =?us-ascii?Q?EKDMn5OlTaX9vF6SycqN4PmaW2wD5PgipX0CmWa9K+xEtNluA9njfrUIMz5K?=
 =?us-ascii?Q?tflYwikHFg4A+jMB2M0HW3W0jbowQ9djI1jc4MyWDvQhnoXFjCYwE5BVNqiP?=
 =?us-ascii?Q?rRlw2mFYCsZ1lHIgYPfSBK41NFQ4fcc1X4tFcMhhHO7/90EzLfJqnv8ObaYy?=
 =?us-ascii?Q?z69CN1EMYDrWhXDx+f9wA4iu2oiUnqooMV0aaK3EIr6hjA490KTm/AjoOD0j?=
 =?us-ascii?Q?8dunBj9ynZgCfoJ98xOA26XKiHb7/tJJ8JrGrx2XmQyDihjgS/FqD+pHhrNR?=
 =?us-ascii?Q?TojUyLvPZRouO3NJrpNPRz+w22HbMH9lbwfPy2B1od7TzlN/VzsoFNDceT5I?=
 =?us-ascii?Q?x2HYDjWdNQoJraHtl/rMDYtJ7cAc1Wc9OhRuZuV5AsjU4Fk/8odR+Gxb+glj?=
 =?us-ascii?Q?m03pEJGjx+gzXjYW80OJG1TLa3KuPBLNZU9xjvuu2kTyjUqNphzsEFUoO7bH?=
 =?us-ascii?Q?XZ6dupF2dlIRRaKONKADbtqfMFOvxxNWPpdNtsFJ5q0jyaPJQAVx5sV6Cgtm?=
 =?us-ascii?Q?8Tr3dcjsramvVLL2H+I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5VRWpmn949e/wWhhhlWvI+08zSvB69J4nQM4k9cmtgiTkD5s5N9LU4Tie+b?=
 =?us-ascii?Q?O1E2bddHfvY/1m/ToCmlMKudxqOyj8SmVFA6JdRlSlliLcsieWyWxboWbp6N?=
 =?us-ascii?Q?fLUTMLumSpVVVbMdmFjmuQ5yn3XvA+GeMGcTBSUpXH8pyOw7D1sIgzWcQTGQ?=
 =?us-ascii?Q?zgLs/fPT/pD8C0TLUg6Y55Aa0W9E7sh5fhZW/hhkbapHhgo0591yD7PHNV7A?=
 =?us-ascii?Q?FwKQvQQn22pyNkdfYuE92hxvjYj6Wbw+HLS1bpHO1Mym6a9nDv9d3hBD94xe?=
 =?us-ascii?Q?uzcdoaiszgANZFzQTXCCUMqbHafY3n4qL3/IuJeHMol07a0XZJZut/KaD70J?=
 =?us-ascii?Q?bY/8JxZSZ+iBW3XKDi9OBrwP5I8AqVx/SVtfewKYqur4eYn4r6jB5Y+DDCqI?=
 =?us-ascii?Q?pRJmN8av25x4VPE0Ui+CG5W6pbcWRSR2MBPTJpQG4PHGreJSOFLkupFUwRsD?=
 =?us-ascii?Q?MrxkStFNju7MXAQ3yllUWyt8LjX5tTzc1BrqUYUIFCXizTqm9JaWajGoOLh/?=
 =?us-ascii?Q?szSghT7PgS1YQXdnjdnsXFz3l5KOyeI3N3l6I/ZcLvFpvmFTNmQRiJQn2Vfr?=
 =?us-ascii?Q?Ce64hKKn5UJWxL106pzeHW73CpBAy9Cr2DrPrUSh0OaoVj9P21VLAr3FjcdW?=
 =?us-ascii?Q?hWqlf3DwDHCnitXfJyEMOAdWnaK37DlBWtgBmLy7J8GsW9lQI+pvPtmkDGlv?=
 =?us-ascii?Q?GB/dJRZ7P+uhThsm0rTaP/G0HiGogXZ7p3cIZuUYsP874HL1ftLzlU6nT6cC?=
 =?us-ascii?Q?1aBYVFbxoSSLyJDW5YCZhXYHoPgyN4Xa0v1XPl0L5zU98ZKI48n2wqfsVOeV?=
 =?us-ascii?Q?+JFImkE39lhkLvkN6tVNc3Poz2uFQOW5zSRrf5BfpUIllpQPeDQQd+8PouZG?=
 =?us-ascii?Q?ggYXbiUcHKHi+/vFl//zfR5WerpOZdhKgv63l2FywZyZC0b/KW+dnouxdEMF?=
 =?us-ascii?Q?1OxOryb9UpofikpmGhITILiE8fvqoSqjXcAEZ9bDju4dlAg4CEUVb8DGTDIN?=
 =?us-ascii?Q?jAWcc/MQVHHgMh8HDS4uh0qpq05JuNB0qbxTyNPN4G55rddfJuhMUminfHL7?=
 =?us-ascii?Q?vIcCKJznTM0RC4bsUDdO+zrsskSRSbGfjUpJjZH9A3O0tsA6w8KY6AtNBgzR?=
 =?us-ascii?Q?/CDhU+an+dHmPdJKhvTQYzMuvG+s9lJcgbFKKMi3sokN/eJjng+Z457GK7sV?=
 =?us-ascii?Q?vthYrEk6lMSIrJx29GGkHT4iVkgazlPFvmHtu+7w5IPMp3k/+eekGlGIK5L/?=
 =?us-ascii?Q?8J2y0Bvs76C85bZ8K5Kppa1MRcJSS1gRPcydtmnz73nvP1gmtzht8K/q2Wjs?=
 =?us-ascii?Q?IqHabXlTUM9CWRamKcrPs5yFWlVTKvUQTQ+rOwWjfWFmBoNIVf+mvhtx3577?=
 =?us-ascii?Q?6diBTY4VG841iKun9BtbNllm7iMcX+pkui+e2DbbEX9Jk3Vkuq3IyMvqRNcn?=
 =?us-ascii?Q?TAYgfPUDnAUQyvYqDO4CNbU7u69XzPtKOE0fuGgnn9KFWgT8hgfpQDUWeTNw?=
 =?us-ascii?Q?v/DvvKaw1ssraKgxnwhvI8VyrIZg4ae+EA+1uWKExNxSF39vAgxbU/1w3dyo?=
 =?us-ascii?Q?TSiEFeiba59h6jkXURilgnBM/iCSXbcSTm+C2y5aI1y6/VvDp8ovWjNLgd64?=
 =?us-ascii?Q?1h0EnBNWzDfZmtSPegZ67zTSvZDrQPmlGi1XNYo3ihAtJNrwJ/IReLswJ9z/?=
 =?us-ascii?Q?as5CwXTGhlYThapXiI0iWyRk4v2XTWTcJsxcpx5EUe/f/IHCLu6EnznW8XQS?=
 =?us-ascii?Q?8gMP19OaH58fSVxAXDiYdEczsg9LJ7E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdfbadb-2c16-4009-53bc-08de68cb7a1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:40:27.2184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tfw/T1U9Rd6N4QtzLvXquS7pJvGoHnPauzAM4bLRIYORxA/5xy0sOim0Un6Iq+YysQbK1bF52hy4g/ac+42VloXtLG9e1DZOIifRc5Px6p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5253
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

On Tue, Feb 10, 2026 at 01:42:17PM +0100, Burakov, Anatoly wrote:
> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > Create a single function to manage all context descriptor handling,
> > which returns either 0 or 1 depending on whether a descriptor is needed
> > or not, as well as returning directly the descriptor contents if
> > relevant.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> <snip>
> 
> > +static __rte_always_inline uint16_t
> > +get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
> > +	const union ci_tx_offload *tx_offload, const struct ci_tx_queue *txq,
> > +	uint64_t *qw0, uint64_t *qw1)
> > +{
> > +	uint16_t cd_l2tag2 = 0;
> > +	uint64_t cd_type_cmd_tso_mss = ICE_TX_DESC_DTYPE_CTX;
> > +	uint32_t cd_tunneling_params = 0;
> > +	uint64_t ptp_tx_index = txq->ice_vsi->adapter->ptp_tx_index;
> > +
> > +	if (ice_calc_context_desc(ol_flags) == 0)
> > +		return 0;
> > +
> > +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> > +		ice_parse_tunneling_params(ol_flags, *tx_offload, &cd_tunneling_params);
> > +
> > +	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> > +		cd_type_cmd_tso_mss |= ice_set_tso_ctx(ol_flags, tx_pkt, *tx_offload);
> > +	else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
> > +		cd_type_cmd_tso_mss |=
> > +			((uint64_t)CI_TX_CTX_DESC_TSYN << CI_TXD_QW1_CMD_S) |
> > +			((ptp_tx_index << ICE_TXD_CTX_QW1_TSYN_S) & ICE_TXD_CTX_QW1_TSYN_M);
> 
> It's tangentially related to this commit but it caught my attention that TSO
> and timestamping are mutually exclusive here. They *are* mutually exclusive
> as far as the driver is concerned so that part is fine, but I couldn't find
> any signs of us enforcing this limitation anywhere in our configuration
> path, so a well behaved application could theoretically arrive at this
> combination of mbuf flags without breaking anything.
> 
> (if I understand things correctly, this applies to both ice and i40e)
> 
Yes, you are correct here. However, I'm not sure if we can or should
enforce this, as it is completely possible to have a queue where some
packets are sent with TSO and others are sent with the timesync flag on
them. There is no way for the actual Tx function to flag a bad packet.
Best we can possibly do is add a check to the pre-Tx packet prepare
function. WDYT?

/Bruce
