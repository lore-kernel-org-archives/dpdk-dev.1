Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D189CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:21:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7E7B40611;
	Wed, 20 May 2026 14:21:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5C71640144
 for <dev@dpdk.org>; Wed, 20 May 2026 14:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779279693; x=1810815693;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ZoRQNKvkKhUmoZEyY0irwvulq/34qLhkSaKUfhV+Nmg=;
 b=dcDAtGNVSgQsHFsoMBsg+j5XMqd2KMGcVsVLsOkM3ptqCiT70VrlRduY
 ZZtz+CiSQabsUsOlFDCFxz1YcMvFMLHUKwQtOpsgNXbbTTLo9WenmN7He
 SsYN/g6bTZhlyBA3uUwpxxzwsLlXQSUwgrP/ecZC9vslk9zSpjKeAVe0L
 hTf8d5d8u9J9UF8H6xjt+U3vF2XivVVodAqIFkbEa1vsKIjNSaFE6amNB
 A1mEm3uCNgMXkQm79K915O3zSbhQYp6RiLsfaFwZz2xWx3rI9cKlrjQgD
 rAvBK3zIRd4adc8XoVlpBQFt3lB5ceT10J2PdhLnFdIN0cl7TLsvurWmI Q==;
X-CSE-ConnectionGUID: Maa7AyqDRMqVpwrLNUHkhA==
X-CSE-MsgGUID: TI/1vfyOScCwwV5DhvZuxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="97604072"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="97604072"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:21:32 -0700
X-CSE-ConnectionGUID: BEkCr+1CRlW8Us/i4R6N2w==
X-CSE-MsgGUID: Hg4g9lJbQk6dBUobSZCONg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="270511484"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:21:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:21:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 05:21:32 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:21:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrAd+Kj0VP18hokCQepungKarG0wmFd28yZy+2y/Nxra5KZDr9RSOnOitgdtKVbW1ei51BTgKUwJ3wj9tvjwIpu182eCSYwG7igEPXHlPpKympSve2dl+3A4QJV8bXBcAnocrCbqMrFwZde9eASmR6fvexUiHzNruRTxcfge50fr50dSxfJab4C8uxVFrT/tBzjROFqo7sOsC6Cjylv/fNCohqtpkq82QSsgJNwO341K1rQsxSYXMy7zoftK6GJ+Gb3SEPsgJQQwyQhMa2JaIp5X1EfAC9sm+P7Vj+c57elUVNlyarccwvmxy9T+DnKN3+Ooa/BtjjUYNQVawvpgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJJ9E7jf548JBn0+HY0m4NX5p9pEw3W0qkLHQc6yH6g=;
 b=P8hGwLhuaGnfqcyARv9deBGfonRX3ZAUXrQpFvVnwv7dwVzwfaewhfBw4CR9N+33HacHwQOXncGi4iUyu3udYXCCtvQFrnEnIbt5tti8C+Po1n/HpJzLyB8jJuWysnPS14oLjcu6nRDZG38M4blx36EJMcZTOWezJn+a/UcDDFMvlP/lB+UDJhaBHZobWwU4QuDch8DVQE6HXaZEe/vv8MkwIDYyfH6MCmGffBCGrZpN6miL1ez0wa42gCDKaV4cdbmtJMUCXYAI1EO5AnsgwEHS5rFRWhjVlLHttOEywymugzZa4sTtdE0IRaxH+PLjGJUd7EqaEwSPi15fCbmXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:21:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:21:23 +0000
Date: Wed, 20 May 2026 13:21:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 2/6] net/idpf: fix DD bit byte offset in split queue AVX2
 Rx
Message-ID: <ag2nPo_qs_JS8zU7@bricha3-mobl1.ger.corp.intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
 <20260511090935.2288837-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511090935.2288837-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P194CA0010.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: ad065f7a-c86b-4357-2ea2-08deb66a4e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: TbFLGx60HhOo/NDj/SJQhQb4U4TmFNj9eAkxiMzCilUKShZD62tH0hnka1zI31BQgqQ/WozEoDQY/l11yarnDdEaSY51+QpKqmtvmgHhi9CuyOntuyeJ8k0iY+cyIUp1qbyDov92ZA7NQSXiOm2udWkJ+aqpGwxAlnLpvHfkldMG52vrIl3P4NHcsIiTOir0Atm0A6ZeWd00gzrrpVmpzL+BjLyHcNbWeotZSh3IJdTc4i1oqXnrZv/aMwrSaIVSEpOWYduHjwqNcu0yP3EBX8c2QBcJAC4dWF/yejgvJM9serjmo9p0vlizapBbhxSciMlz0J459xsQpoOqdktHkRntUqB9z2euW/hHqosWkZ+slGR5nJPrlVZg10cPECoiOmoFuX+dcMO7xy14wTBpxYq1uBNMQoLSCgTPmzG9cOLhqXBy36ELxM1HimjmfOfNDDBexuXpxHkcyau7+Nlo0mhDNWT7m66/8vcP2LgY/r1HXLbTEUSG7cR+V+MoohnoKMOG+1785P/OXl+hOcZFziatnG+zpEeUAfMc3cStWTiWTwH+Rx2xaP6WG0NR/UPuN0mw4E/gO/Ew3Cwwy+i5BrEWcd20kofXI6LlQ84ddkdpTXYIcMz7dOthJaweDXPbjon2n9NDqdGYQkFyCi1+3ueLQOOXagtUY9A6kE+OHBlzIGxJOMMK0kmgnu7gdzK4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ndlP0tVn8a3wqTJED/8FOFcJH6zqtAa8XiaUmjuu1akOznL5XeINaQW4Wvbg?=
 =?us-ascii?Q?p55rTzWVcWuXDU2BeC0qoj/MrHn2Q+ACIC+0sqrNy9Y5SHceeeC/kzvoq3u5?=
 =?us-ascii?Q?O72O/tZLrJdcGiup9O9sS7fnoP1J9EQ/OuxgZ8Nev0+ShHRF0hVHYW9bj9Z6?=
 =?us-ascii?Q?jUF5hZ74v6ChqEZXlc0DxfHUBSYhMrv1kfrmXumVHWFd4VcDXTt4A8Y6cGeI?=
 =?us-ascii?Q?bO9641qQB5oyngoullMicRP32Rl5iU6dfo93rE5iM8NO91khcmHsHALHS2hy?=
 =?us-ascii?Q?iQNgoIqqtuQMbBhyjhOIQaC0KPTpGA176ghFoknrkEuNdTXuQMRI06Fuf11m?=
 =?us-ascii?Q?g+hv58qtcOsSRMqz/q2rb9do3DRgwPVk0bzPJJPPOo7mLDcXcw51uX24bVRO?=
 =?us-ascii?Q?x6SaoaubvwP1aUFeQwN8BV9ay7XSQ0rGvWf5Mz4UKquf0kdlItkCtySrJQNW?=
 =?us-ascii?Q?nS4C74YuRTFksrUE+JqQt/B7JbmThChtsHlDwlhfyp3T4Rt/vJE9ylaJO/f9?=
 =?us-ascii?Q?rToSZVc82BNfqYdjx162WqMi/sGELd/MOAYgHn3ILGIaA8Mv8FUr2KeVV8sm?=
 =?us-ascii?Q?iE5cV7apEeptlzLHf3zztllMvCmgyzPILNDuvvV6Ym66vfNuLu+I4B290GFn?=
 =?us-ascii?Q?p+xJhn/QXmDJuOMUI9uhvaZYfhIXOFg/5Hz4EAsR3gKifIFanOAhHH+mrg/7?=
 =?us-ascii?Q?WTjJzMOpse7INKuQng8shqZ29NGx9HXhkZB5kfpP/lzoPFwauCBhWxc1jvmZ?=
 =?us-ascii?Q?iXOAh5lBvyY0H0yTkUQmSBA0wsHByxiWF0KzqYpQCVvnIcPS3pnETiEdzQRm?=
 =?us-ascii?Q?gYZ8+geNEa1hhTMj7crjSQdI8oXQLmFTzHZrHvmXAJvQ1GQFYWwN1avQZunw?=
 =?us-ascii?Q?I511pN3ar0kn/Dwm7pzT7vgHRvPmGsUoRCpfJ8LHCQc9onCVXe6X2oHu6MI3?=
 =?us-ascii?Q?iBdbq87svYf3PydFcJmOSy2V59TrdoYy0cqRC2Q9L8WiZftL7+tHMdghO7RX?=
 =?us-ascii?Q?SLu/AHFG2+2CxYxVbi/XExDSIVfijc6zAeO3QBlZaLn/Gpxv0m+JZ1Ps2x7y?=
 =?us-ascii?Q?mnol1f1Gxl/MWEX6fR5gI0jGOu6HtzMG3JbHVOrWWBwBpVISKIIm2J7CkWXl?=
 =?us-ascii?Q?4wENgakIIXVflvxHjStqUJ+g4gt2Jbsp2Fwv+pRsMoNssPzmNMN3fOCR1dE1?=
 =?us-ascii?Q?Bhq993+9qpDiI4ahMR0e0FLrsBGuHNKb4zJQ28GGFi3/EyNEupeojPe7i4lk?=
 =?us-ascii?Q?JJiofSwhHfy5dvhO8L/rzrmDEBBmtuDcze3ZTfwe685mYWrsh+DBFSN5ap3T?=
 =?us-ascii?Q?Ql6muCgak52ZI8zIHMWs1+uW4MStYzni1/hA5uoALdwi64y0FCX6/7Io+FVJ?=
 =?us-ascii?Q?3cFV+A+2vQqeGSWvWUgAwFOKrGGvLNb5CJFRxQ9/3Mh5NN4JpwuygivBMpV4?=
 =?us-ascii?Q?DKwBzKKD/PEGO9h4Al5wyF2/pbGEbpx4zQGneqReqETZwXzxdbX1sm1cXk/N?=
 =?us-ascii?Q?uJ7Z0hyPZymPXis2uEsIH4WM2fMwJrkKQCQOrqe1bYHoeULemudlmDnI3ZFN?=
 =?us-ascii?Q?FCFNZhsBukNeyElO+1YvgX6oFdLR5Jeyab7j2AB8SYKq0zj0ErbFYRbDvSuH?=
 =?us-ascii?Q?SMIDwH6oClvk00MAX4xQ7PhB53atIVqvmA6ysoMMDN1UFbrXQ3r1qjcykPXD?=
 =?us-ascii?Q?X3iuWpBNnPNbTkAVeyw0dj8yOb6gfD7AMOKZDLyc8rBWgHpcs1QUeVBp1ggY?=
 =?us-ascii?Q?0BqK3Fqz2YdUJdTp5FEhI/lehbaHFN4=3D?=
X-Exchange-RoutingPolicyChecked: BhR3Jv7GqHZ3rxpFyXQxQHgnXPBYArtr9QgK1gRBpQVnJY0SlOF2Orszo9lQidmU6gg3huyBAFcppWpKkLqm8tGDEz9/C7IBEwoVIjdvBylF3KTWjH/YJior59WvC8bRelPMYkDLgyiw3TiMEjYy8a63LUWC32o1rESdHvhfm5yER6wl2BDY2ub3RX0dyE0iTVGzdNzpWzHAvUc89YZY9Yb4DwGzsLwReE2aB92irWj15XBfjJrcc+kcP4npltXbrhN9FH7g0MqTNFL65DHVItyzuW1MVGJvcQ0evGfyQwdfTkwxctngxv+//dLLZogm96tj89BsP6GyZc93iUa/ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad065f7a-c86b-4357-2ea2-08deb66a4e5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:21:23.3194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvC3leNG9AGv4IUGKTAnSPJ2/YBvcDoBuQ/DAyJsXYP63UExK3oxx2Gw4alnR9PCYsoS2feh/LHE1Of3ApdGN5F/xg7P6CUXZzPAlKkliYo=
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

On Mon, May 11, 2026 at 02:39:31PM +0530, Shaiq Wani wrote:
> The split queue completion descriptor (virtchnl2_rx_flex_desc_adv_nic_3)
> has two distinct status fields: status_err0_qw0 at byte offset 1 and
> status_err0_qw1 at byte offset 8.  The DD (descriptor done) bit lives
> in status_err0_qw1 (byte 8), not status_err0_qw0 (byte 1).
> 
> Byte 1 (status_err0_qw0) bit 0 is the LPBK (loopback) indicator, so
> reading DD from byte 1 checks the wrong field entirely.
> 
> Fix the _mm_extract_epi8 index from 1 to 8 so the code reads the DD
> bit from its correct location in the writeback descriptor.
> 
> Fixes: 1f065f9d75ff ("net/idpf: add AVX2 Rx path for split queue config")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index cd10c27a30..28d4246134 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -587,11 +587,11 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
>  		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 2]->rearm_data, rearm2);
>  		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 3]->rearm_data, rearm3);
>  
> -		/* Extract DD and generation bits from the already-loaded descriptor data (d0-d3) */
> -		stat0 = (uint8_t)_mm_extract_epi8(d0, 1);
> -		stat1 = (uint8_t)_mm_extract_epi8(d1, 1);
> -		stat2 = (uint8_t)_mm_extract_epi8(d2, 1);
> -		stat3 = (uint8_t)_mm_extract_epi8(d3, 1);
> +		/* Extract DD bit from status_err0_qw1 (byte 8 of descriptor) */
> +		stat0 = (uint8_t)_mm_extract_epi8(d0, 8);
> +		stat1 = (uint8_t)_mm_extract_epi8(d1, 8);
> +		stat2 = (uint8_t)_mm_extract_epi8(d2, 8);
> +		stat3 = (uint8_t)_mm_extract_epi8(d3, 8);
>  
>  		pktlen_gen0 = (uint16_t)_mm_extract_epi16(d0, 2);
>  		pktlen_gen1 = (uint16_t)_mm_extract_epi16(d1, 2);
> -- 
> 2.34.1
> 
