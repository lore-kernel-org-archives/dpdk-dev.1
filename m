Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23596C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67D7740EDF;
	Mon,  9 Jun 2025 17:21:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B0D3A40EDB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749482511; x=1781018511;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6CbHqGsl3M990CHbfipWWE/8gCVo3lFLrelkSRUEOBA=;
 b=KczXEpecQgVq5sKtn7pBm7V58x5lBLyaTK+Nk8jZBnwxLvZw2R2+nTeU
 leOnDYRF0a2mnt/HLyfGhQremKrAaAJCT6IUKDvlZHoUvss0gaARJVVGp
 3x1do4O3en4gwDQ+z4tbZBWxpPMBCi+X17rKG5S4dzr1QvGo47LUGf45Q
 JgB4m4kjww1MVSpSUeSFDX2KYWOT9x3I52guH7jclAhOo7T8eBwNS321S
 CTtGBqHhBuyUdXRHRbJPl2HmeQZvQZl2BQz3Idsn1Vcxl+OoIAEj/FWFF
 ZiwKhBd4wdoqWsKUZQxJhc08b5zVGfUbVtZgf4YLHThzbvOIFH5Y4rI9M g==;
X-CSE-ConnectionGUID: G09hWxxVRra4rr9bDKv1Dw==
X-CSE-MsgGUID: i9zFmNKaRoy3BDXEtVg+Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62177672"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62177672"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:21:31 -0700
X-CSE-ConnectionGUID: fS8OEpUPSF+mAa4MPoQxDg==
X-CSE-MsgGUID: 9HJYlqpeQfaUxGbcYww0Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="183725163"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:21:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 08:21:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 08:21:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.42)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 08:21:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTJBlYT627RQua0Z/UPYr3lzP5sN4RJrq541LMqjZHYQu5ITEMQ47ud+uDNYOXuPYDzc6XG9ztXSVzUmzBz5xgXIrOfhkmYVplcjTwHkw3sOpAuA+cjyt14ifNUs7VPiFb1WDrV2iNzUkJDZR/oyX8qhNYPC5sklvXFCNVOu3qP15ALcgks2MkpVbmrRMAWwXDz06ic9XcgTgWhP3FIRBDisx8ncMNAnx/cbcPnHIQSixrj9RAvhCSAEMaDLcuARZBaxyca343hYtUb7OUwGMAX43qwl3OotMRPaljCEG95cWfBykZoUtquwPTzNlVKUn8G2dmZuLTcvfvcwf7Zqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr9g/cfevoEl7mAPewF4ZHEgVBm654AxU56ReudBS34=;
 b=EVpOOlq1V8l87Gc0+325with83VFZylqScq0Bek+YFACt5siwROuzmsAAq51QP2H9d91x1jxXtRkFyfjUHzYO3ET6GsDTF9xmLrtyfJlcu/tEzqcsJ2xZBFw01TVWBBmw1Kmd5Hy68025ebo2bSYK0bF0qtWntRaqTOaZQnnMPVhXEySTSW12kMYrhIPl8Vr2CAF4Nmy0UYZe3fzHcB/wTgwfk8I1dcYdTtdtV8nfYE+bW3gs1OGU+OnHa7tMGDlOr7SlcQprm2P4Z9OyNwa8sYvxP0bF3y0hfeZIEYaM6lGizNx53dL5nZFUsq3XdFv0Gys+Z0B6xhwNlN1zG6XYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPFD56C4208E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::858) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 15:21:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 15:21:16 +0000
Date: Mon, 9 Jun 2025 16:21:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 5/6] net/intel: add AVX512 Support for TxPP
Message-ID: <aEb75roiohANCGHW@bricha3-mobl1.ger.corp.intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
 <20250608113223.487043-6-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250608113223.487043-6-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU2PR04CA0034.eurprd04.prod.outlook.com
 (2603:10a6:10:234::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPFD56C4208E:EE_
X-MS-Office365-Filtering-Correlation-Id: 7779c424-31fc-439a-106e-08dda76946e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ExONoBxgvovAUHUwUs2X/36lHJel5vj8AFbpY8fdgXdy803wHB1URJGvSsqH?=
 =?us-ascii?Q?nl78j72AnftlnfA3zzQ6vPOiW/x8APfe4DfGSpg0BmdXDrwswjJDeb/kmu/r?=
 =?us-ascii?Q?qWFmMh+fy4WfWCAzI7qns4sBCZw4VIzot80RkJ8wPGpajvfC/ry82ymNoQGu?=
 =?us-ascii?Q?aIXBJ/F5KabG7AETPwsIusFJ/u/6Q+mV4UB9cEgcHks+uumSZN5SIs6TBd9I?=
 =?us-ascii?Q?iooI7piLsqLxpni1VjOSZY26vrRsb7hMjj6JrBxhQjPp4DLRfw4kx882VHqR?=
 =?us-ascii?Q?vPGpGo0l7j5/eG81qyMt0B5PoIY1+565Wc6LIWO5fuQjeOimb25IuV2UcH2+?=
 =?us-ascii?Q?BrcR23wC2ZNlepy7hxtIYpDQ+ovQssaekzU3Z8GqoUE0hWGI55jw/Ix0p9Y5?=
 =?us-ascii?Q?mDmuL9hYetTSh6AQXEFHrIznfMdLaSndWWYBv7+oumyJzUHCtX714zQ+U1G4?=
 =?us-ascii?Q?RbduTx51xjCsGRaAZOAjc+AyX9f3Xa/xQokGuEsQVAzB2EKDsQcebbRoJKxB?=
 =?us-ascii?Q?JYCS7U51ocPztnSvtS7+eVFj/UCRXsg6tCsy/ywuZzyt7qFI9SZfjuLXCS3d?=
 =?us-ascii?Q?HzhQLO56pUAknjtAgXN9K2vtFfB6Qp16pxOxfkG0SPJujwlO9sNkZTRQshCR?=
 =?us-ascii?Q?MVYl3SJ3LjbVq7tfKxpxzP/9ALE/sAMQGC20uxCPmUbcrcpr7/0zuT5HhQej?=
 =?us-ascii?Q?Ew7QNAcNiilsXXNSCNiaiT7sy85sQwePdO1U2s/fBTreTpjMV/sIlYuxvM3A?=
 =?us-ascii?Q?r92wmB890L3fAVsxhoBf+VsYm2Dto/49OVUNGvvCYlBNHEEzErWBreOYt/O3?=
 =?us-ascii?Q?i39v2AMQGXbJLPRCaptPOrnBy6kpud3df2TrvGZBNRstDEqaXLrAgSU1zgEr?=
 =?us-ascii?Q?T/iJnmZVTjMHEJ3pgIjMTgexe/lqgZYIebpC2g5ojWkL3efJ6bSBcrdhntTF?=
 =?us-ascii?Q?sbph/kLwEMlQzycPRnthgepFiPbqNQE/QJCRpu+YfvbYHjRWVJcMLKRQgTb9?=
 =?us-ascii?Q?jPJT6aNKz8nJzl4SesX+B7NwZgVl5QbduGHWKONBxqKMUuYfUtU8viPgWkUg?=
 =?us-ascii?Q?WeEiArx1obxuRt5m0vBUHxlwwbffW2NWCK0/Rf0Jl+nbGhrvr3qZPmzIx5va?=
 =?us-ascii?Q?kFCykpBnep35r9LKHYRpGHMCuJf/AzV1sdRZyjoag8I3lKJgAM8oJDv+suLW?=
 =?us-ascii?Q?dWy/SvDorkqejvHaZ7D+ibdVc9dnDeFDVQHvKK1QBhK6MGN81UlCzMDdlFcl?=
 =?us-ascii?Q?D7YvDhB4HpgdMflxt/ABvqFF+JYzOZlFJPoij32KOxqQfFkJ7NUnRknMppX4?=
 =?us-ascii?Q?T/AYFPHAt7iAh6+bGeGbWXtdMM6CVQWiqzPqLjaazaet49UYCmsOsTuZGKlD?=
 =?us-ascii?Q?jKIY9vPKZ5ABeOJce4qVMupboo8H68+rhjx9x7RjSh6UWkWqUgAgPetef9NM?=
 =?us-ascii?Q?9ad4Crempe8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ALOwNwYvWx8D2uOij1xrSGsbxoMV5MtgrQmKhXjprgzSzsa3N1FS2QyLdku?=
 =?us-ascii?Q?R7KfdRv5t8RwfKAiH7jE0Eee0ypUaxjSxPWW6E8ZqJ9UMrqieAMAVyWN8yT3?=
 =?us-ascii?Q?UxazEwpypXV/Od+6J3WgesEKErcANNRn9W/WxgESbFLP2RVvw07//B80Rwn0?=
 =?us-ascii?Q?4myMGms7xOC73veHz927EsHFkhTz3K6r2a/kf4qd2VTAzDb6qFQHSG4UC+Nn?=
 =?us-ascii?Q?/e1h7PlFLV/83/UO4ZvE/16JXNoptfnEFs2QD7C08WeUr1zA18WpmRPRRCpW?=
 =?us-ascii?Q?pUUBRHgExFV5o/A1/zXjBJ+EKugpHicZVaPhZyBL7L2/pDavks46ICzeKFCd?=
 =?us-ascii?Q?Ujn+wUojyzzGMOPCXQm3EsLHLLLfirgt6oAFds8aZgERZ/D4uG3SIEVZjQsQ?=
 =?us-ascii?Q?fhpSGfQ59yG8kkVLi8gG8ad5DzkEyYjVp66fTSBJTsLi9o2vp0Vvy8oTFB0a?=
 =?us-ascii?Q?x0UmHLyVzIg/YnM4yZlNbAcxHUVEPQfJ4MSHak7k1BqifkVixP6b8fzhY3bE?=
 =?us-ascii?Q?rkUSWl2ZbrgDs5THEFK+0vGfBBIqRH3SThZN23cIoPR83Or2Ta7Hpu+kTppR?=
 =?us-ascii?Q?f4w2MHe6PxPLtLCf+PkNH+lurdczQAbmC2/oNwwVbun6nmN1Drdg0qLj0uM7?=
 =?us-ascii?Q?BJ9H1aTEkGCHRTGzbJyEu9gj9cdC8u6+xIklVc5Y5ahJlsQfE1OHk/AmTY9r?=
 =?us-ascii?Q?qYUQvgiDoIHeZPJfU6LTKiplzNnN2ATEJY97naLvUX+ECKd0MkGXkblkC6DR?=
 =?us-ascii?Q?Y0EGOBwcfRjvS7MnAmaKJSp4q7IDznJAxuH9a8aC2tNUEIlZ/Zv9cq6KoGOf?=
 =?us-ascii?Q?lkOJuRoi5tCIhyIODy/FX5lC07+HoybF2GE3mhECqakHNX0fBSaz1tc+YWz0?=
 =?us-ascii?Q?nGyvZ0Gi2CAokl/2laE9C5Eco0GgYEtG1mp7DtGWjCZBPMcWItws71pZhFjI?=
 =?us-ascii?Q?cnZ06EdL+IeIZy5fYHobNuwgwSjyM7azE35x3KFzpFyWJihpbgJprB2lUrea?=
 =?us-ascii?Q?IRAyZGknZYTV+Ja6hbJmwS+d3b2qlJjvdbciXicE3wOrD6l/NTohsGf6VCqA?=
 =?us-ascii?Q?PfXNA+uulL4Xc1nYPUcwfl8nn//8d6I/8+IEy9D5AAjgmk5JfEbbDwi6n0d/?=
 =?us-ascii?Q?FFZbuGuVrRL8N944FUuWag2liZ3ta819Y9WOpCC1nPRsjdfVk8+MmVUFcuD0?=
 =?us-ascii?Q?u52EeeR/iA54wBpb/PZ9dF7lPG/wY9EWh0FCrX2e/9bpaWrX4ShQreNCZiI3?=
 =?us-ascii?Q?eqR05lcNj4Ud4ICAlQvgt6jMsI89iD/C73VUQTmUjRDhHPAgZWX6QmZ1ndaq?=
 =?us-ascii?Q?fPXrKGvjBssDuQ249b3aOusHxZ4prBq2mDIxybY8mlyNjYORa3Iwx8072XvS?=
 =?us-ascii?Q?jaieyiwFdRCqIJpyiiosDlgSg5Z3KROumEoi0wQUFgxHWcyMlNRRSdsL96PF?=
 =?us-ascii?Q?lOapeS5ApQFUPI5/v70mmdYUhxYys1wQ1ckbuodvce5Laokib/fPXjS5qVAk?=
 =?us-ascii?Q?2eYDVgWOLjsuI6v1iGbF5ipOJCC4B/oRoy7FxUVhGBS/1UunMYllx9d210ld?=
 =?us-ascii?Q?Rn5l1MWq60qFW3EpvuWOCeLAUG6n2C+50+SKKQf4LuP+cTn1HUdj58JFB5H/?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7779c424-31fc-439a-106e-08dda76946e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:21:16.1309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDZkIrLXUil7tLLBGjHXkR0ra3PzBWj8Q3BRb0Mw9I3NhBDx1N2oHRseVV8MYiJG+b7BZPb1H2HsSC2kqAawUooKwkMhMvybFFfi83CJpN8=
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

On Sun, Jun 08, 2025 at 11:32:22AM +0000, Soumyadeep Hore wrote:
> Tx Time based queues are supported using AVX512 vector.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---

This looks to have a lot of duplicated code compared to the AVX2 version,
can they be merged?

/Bruce

>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 206 +++++++++++++++++++-
>  1 file changed, 205 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> index bd49be07c9..394cd15a71 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> @@ -912,6 +912,200 @@ ice_vtx(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkt,
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
> +ice_vts8(volatile struct ice_ts_desc *ts, struct rte_mbuf **pkt,
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
> +static __rte_always_inline void
> +ice_vts(volatile struct ice_ts_desc *ts, struct rte_mbuf **pkt,
> +	uint16_t nb_pkts, uint16_t tx_tail, uint16_t nb_tx_desc,
> +	int ts_offset)
> +{
> +	uint16_t tx_id;
> +
> +	for (; nb_pkts > 15; ts += 16, pkt += 16, nb_pkts -= 16,
> +			tx_tail += 16) {
> +		tx_id = tx_tail + 16;
> +		uint32_t ts_dsc15 = ice_get_ts_queue_desc(pkt[15],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 15;
> +		uint32_t ts_dsc14 = ice_get_ts_queue_desc(pkt[14],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 14;
> +		uint32_t ts_dsc13 = ice_get_ts_queue_desc(pkt[13],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 13;
> +		uint32_t ts_dsc12 = ice_get_ts_queue_desc(pkt[12],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 12;
> +		uint32_t ts_dsc11 = ice_get_ts_queue_desc(pkt[11],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 11;
> +		uint32_t ts_dsc10 = ice_get_ts_queue_desc(pkt[10],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 10;
> +		uint32_t ts_dsc9 = ice_get_ts_queue_desc(pkt[9],
> +						tx_id, nb_tx_desc, ts_offset);
> +		tx_id = tx_tail + 9;
> +		uint32_t ts_dsc8 = ice_get_ts_queue_desc(pkt[8],
> +						tx_id, nb_tx_desc, ts_offset);
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
> +		__m512i desc0_15 = _mm512_set_epi32(ts_dsc15, ts_dsc14,
> +						ts_dsc13, ts_dsc12, ts_dsc11, ts_dsc10,
> +						ts_dsc9, ts_dsc8, ts_dsc7, ts_dsc6,
> +						ts_dsc5, ts_dsc4, ts_dsc3, ts_dsc2,
> +						ts_dsc1, ts_dsc0);
> +		_mm512_storeu_si512(RTE_CAST_PTR(void *, ts), desc0_15);
> +	}
> +
> +	/* do any last ones */
> +	if (nb_pkts)
> +		ice_vts8(ts, pkt, nb_pkts, tx_tail, nb_tx_desc,
> +				ts_offset);
> +}
> +
> +static __rte_always_inline uint16_t
> +ice_xmit_fixed_ts_burst_vec_avx512(struct ci_tx_queue *txq,
> +				struct rte_mbuf **tx_pkts, uint16_t nb_pkts,
> +				uint16_t tx_tail)
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
>  ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
>  				uint16_t nb_pkts, bool do_offload)
> @@ -920,6 +1114,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
>  	volatile struct ice_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
> +	uint16_t ts_id = -1;
>  	uint64_t flags = ICE_TD_CMD;
>  	uint64_t rs = ICE_TX_DESC_CMD_RS | ICE_TD_CMD;
>  
> @@ -940,6 +1135,10 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
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
> @@ -975,7 +1174,12 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
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
>  	return nb_pkts;
>  }
> -- 
> 2.43.0
> 
