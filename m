Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1044EC44500
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:39:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 568B74067B;
	Tue, 30 Jun 2026 17:39:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B910E40611
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782833954; x=1814369954;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VZR4OSwJwqPWNoALeyK0KnnwK914um161cXs44X/A4k=;
 b=WwkwHJF+bQ1XcMDQIWMGWW+MbOiwvk9bJymbn0/8AtNV/9jy+UAXGFwf
 bHZSfHBNkyU1dPP+72HyJDIGp1LRaX7DtqTfSMZqo/+4VXiSh1XC8nB1l
 7YcVnPO5P8efqb8AR2bUtsPYQBFxdSy9Fv2BbH/Jq6tBx0Bab7KinAxr/
 OMLRoWUrcJI6j8KfX1N+Ut5VyVT3vHvWI1dVQXiadNMDDjQJ+QjKUTEcl
 jl6YZS2B/jCZA652cx+4Q1OpPiTqkFlm2Trwb205tpqpWRzlODG9GFtvV
 RtJZGd851Y37eHgDbKYU8/QMc0ZokDqgJ2pL22ju/UxpZcuz778FuL0Qf Q==;
X-CSE-ConnectionGUID: EJnwOS32ThukzGtOusUMUw==
X-CSE-MsgGUID: EwvyqYPISLuhMzynZlkiOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82540496"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="82540496"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 08:39:13 -0700
X-CSE-ConnectionGUID: 102YzuqNRJeHJ0iey/4Nrg==
X-CSE-MsgGUID: b4Whr+KKQ12QE1/Etz1uTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="248310357"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 08:39:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:39:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 08:39:12 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8+DPOuEniPPYSuRSEFFY591jV0+NpUM4TLfSZknk7sn4LO2HrJddSLbaFpcYCsbedlcrlFYq9oShhEJSf8+97rEQ30rBd2Xc5fCEYhfuDykTMlIL8LkBidR1rTOsmxzWj/1icic5tt208OQvFZqxWAIS7eVOw+xg6ZR5p1Zf0cFHdhBxWF8P6ZeJi7JdlQRQZGdLx3y4YwXpeYECZFCt/4MoDG1b7BwxSTQORWAzerS/IkwPQFexLMxp83n+NiEYmApMAaFAriPOvq4lV965NuNA3uNoYgWOLS2y+zkup7y7dui9yRs5wBhBI4v20M1xsjODdf7zqHrXy7smF55jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o7tb1xZayfHNISBjLbulMz4S6P01SOEB1tsL6PMfSY=;
 b=F7AvsvkS90PIsOr9hxirc5i7hx+rdWhRNIEXEqDbKWIbPowXGZE4wxHE5v9x9YVM/gIrNNaRtMZzVMTmU4lHWeGpIXZPek6hMmpteX+x8UAmg8AzzprI1RRbwFej0sLUDkoEOgJZhkrPhFVUA7wm0KvKXnYGWxekuY9k5cTeuCLrH8+/Hfv9y1dM4bY3nQa9t64u/pAGQoQbntNFvZN8ubtO2uDQHz85n+BFqDil6EwJsKtoXYq7R/VIxwsdxcW7O7kFpKR2pzWtLOqchp6HF9Ou5gMWsA6qPG6o0aESG+mIhsyJQTJETKX2IQggdE5qxHty5kdEKgBrhShYU+EsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:39:04 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 15:39:04 +0000
Date: Tue, 30 Jun 2026 16:39:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v3 4/6] net/ice: timestamp all received packets when PTP
 is enabled
Message-ID: <akPjFNVasdvxrAwu@bricha3-mobl1.ger.corp.intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
 <20260630120657.1046588-5-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630120657.1046588-5-dawid.wesierski@intel.com>
X-ClientProxiedBy: DU6P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::21) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 843559b1-4a5f-4785-8cdf-08ded6bdb74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|22082099003|18002099003|56012099006|4143699003|10063799003|6133799003;
X-Microsoft-Antispam-Message-Info: Hth29avydOEV5h4dMGYkLXSlHoGBHxmkuARIJE4vf5PrYPEEDesUU1zbkuqHkjd6N/bjQx/RKjLqouw7e/J3qOc9stpxZ3bcLVKRTNatWj5GAY08cCecoyKptjL+kgIZ7zI+bmXjUXorW3+NECzl50p27ejCY3RArEZmLRuOxgqiMNuSfEoaAdQdnswK+1YIOBY6xd2KLaL3yljClcnF7PDRGOh3ej5VLuf5AzFI2pjzN3dgxw7iqEb3ZtG76ALrZMSWLNirUgrFODYxybAGG22u2AIr/tPFBSWv6PoKV1MPCM8Au3iKM3Hl2l4IeJhm44jlduY+CJBg0HZDNLbMLvtCNUohZRa8ayqzUTam8QDecGckT1j6h12z+n2HvvDn1LSYJCeJ2eMFRAyq5fGWohyZoaBj5KdWkiQmE43sDLIvJ34PxgTX/cQZS6jncBg8FVl5dUVhzzcg3GrBZWCuDq6XhOBbaWbiTENIwY9fnkk8n7i6Mk25Y8xQKbmgjKawsvNxNPj5mAJYgKG1sEptQdTAp6RNEGA2rpJQaAvqvzyP9ObyopdbRqlpWJaDFW/iOpiKJXuJOHb0p0yu/ACkGyQfny6FfyW8HEIN/O38a48N2L+cio8Y02J83evgVJrtS7ImQ1hRbVeCbzParxNp+neFi7rhWAF6M6u2t+nxJ2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(10063799003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2y+uA+0BwGKDpBweLpg8Qok3F9at9dEvdsWBx/RfwVhzbDWknJh1YFwCj79K?=
 =?us-ascii?Q?Vv7j5NMlTn0nwmPcQd67rtgRTwmN4E9QvdZnDsl9IPyDXjjPUeA2m/PaT7WZ?=
 =?us-ascii?Q?h19IB4oZdtSq5KwcbYruZNFE5y6otygq9mva8DDso23vUjZ7NsvSuMbALRYM?=
 =?us-ascii?Q?1kF4r9zuf0K+nec37mtyIe5rEIk0ap+ZdtH1GPrazcXqA07Ye4bJDI0gNeHQ?=
 =?us-ascii?Q?jrJlWUJx1HltRiXZ7ZDXy7Wd9xwnRTMI5gCsfc0QDwCfuiIOVsCG9d9SP4Qk?=
 =?us-ascii?Q?igIRFSRIiYPBvrdUc/dcbvGJQ+LJJOYS1hfhRA8Qdgj+owe0GqPoDJJfpCLx?=
 =?us-ascii?Q?XgYqd4tOyXThQHbgLdfaZuPCRJlsGuMYhOW4JzTU1o4Gh+F+wrJiat3v5Cip?=
 =?us-ascii?Q?s5RyJeC23NXOQ1OLz+r2+ogdTwj5ZaT/X/0OT67tK1Lp+K1EBSKJIVGZMziT?=
 =?us-ascii?Q?gf9WPQwgXYZMxYMQ7a5tN2jr56EDEY4VfTcdKmQXHkr21BFYRE9DU/xquYta?=
 =?us-ascii?Q?A18WKLEhHccNebHfCUbPvngpyaq++OFAsffSNo6/T4bZBiyXK0M59lVcmTxl?=
 =?us-ascii?Q?wOefDuAObPqPxi0OqUUuW55pDEchB31PRr7xsLBXAM/aOdGP6ScYYYzTNNdl?=
 =?us-ascii?Q?caErb74NKRKUq3L8iYhy47PIoR4/zLMsC3zcjp/HFAeZuBG2oAi/cktvhsxP?=
 =?us-ascii?Q?/RnJfQcFtJuIS5+NC/jDsVsu/8GQ5UtSkCcb0W6Zot4u8TNYfiue8JLT7R+H?=
 =?us-ascii?Q?joaGgOO0i9ZzIF94/xkcvdzQYhG6LUhA7g4gOV4JvXyn19KRaXoaCelO5IAG?=
 =?us-ascii?Q?bvGxo8M4eXfM1ZSwa/7QjHE3EU6NPAzS4BqMgkquFcRxr12/GI9i4AbwLYjR?=
 =?us-ascii?Q?NwgUnWyH86j087zqLHDSaLNCdl6tF7nTbJ4svFoeqFi6uW3rpn3zvpd60gGY?=
 =?us-ascii?Q?5F7sdO63hTbpy3lp4Ka5d2T792GJhn+4avkAtU0BvELcT0gIdmDiMetF6KZu?=
 =?us-ascii?Q?XC9JY/PcGmt6mhqSNTk2qbB3YbI2d0SRUB6tLMEAU+odS08zRmXUvNYBxNIg?=
 =?us-ascii?Q?SSJ0mYNkrTE3PpK5XK5bQdGs3QxwKl1XiBjLcGuz28M6ag7vFCvrwQUb3/Qr?=
 =?us-ascii?Q?p0F/pYMS9/9NR/ucxUlB6KPE1H4Snms+pX72j4PIokk08KD/sJDn9EpkkcNm?=
 =?us-ascii?Q?CvxHdr+MfgG0SxVfc2ewIjvvPmzk0njjpqBHDZhcWH7a0pQDVZ1n5n0B3D5l?=
 =?us-ascii?Q?QonT8c18+5XVasifJx8ZsV8rCY41UpBbgZ8yQfUEX9p8G92Vi/Tj/jVHdaGw?=
 =?us-ascii?Q?2gyhM0gPRS4fbVD0hZiNgQAek90e1NwBaJDjU0U+AU1vYKNm6OfLsb/VkyKy?=
 =?us-ascii?Q?eIBVysvAbs7t6G2eynTyeufBl1PUWBS1x9aF/LltRKeP2qaHs4LjpGImOcPI?=
 =?us-ascii?Q?aaXBXZPRAzT1myRSU8ubgOxeJ61UMbID+NcIDJMggct/3FF73VVepBEJqaf3?=
 =?us-ascii?Q?6H5VrAtSFJEjsPCSAeygG1AkFP/hb/QG1ykLDU0U2tjjHgASk9Up2yf8jMFL?=
 =?us-ascii?Q?VM7SOvhyQeOCe+VoFNZdnhIpi+zng8blxZCtkqiOkxddl6p+1ublg6gVYjJY?=
 =?us-ascii?Q?jyQByonPZ4zfSuFCqa0G16LrL3DE8JI5jvlrEBviyHg38PgvHb+BXftgcO53?=
 =?us-ascii?Q?uAnJ9kVrFhBMKzq9YXujvfKP3fUUS04eMlVSAvLUeFmZ6FOPZ3ZLLivP/47I?=
 =?us-ascii?Q?utQsrbovcrYGsiqWy5hpuO2xsXtgWl8=3D?=
X-Exchange-RoutingPolicyChecked: gJRbzWpgjQ/qLiimoZFh4JCGSRuLyoXgb0V45wvFnAdtNLwCIFpaPTtGZBBeAfGVpJrEPkUC8H6FIw7P58QAQkrva2okX3f3gwVHpJXhfYYhU0J8MUkPpw7Ma8+OZv98wkZhD36HAqKi4m0yrISZHpZpyPX87+vpz+gr+mU6zvspysGicYO91EbafoS6WtMEpKbvfQEPPOD/Ff1C+ZJKOfEbvuRHI4GualeoutUdz6Dr2fE0Du7vXWT9y9d+RdvrrtQYGoQe9jHcpn0pLd6rTwvIaS1tvl+BrkhJXi6/oAfWvh4h6HYyFCXGfBkLMxW/DAZ1bHB8sFM98moyw+on4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 843559b1-4a5f-4785-8cdf-08ded6bdb74f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:39:04.7353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYo+y4hrIWbx47y9w4Sn3F48N6iPDBUkahbjY31j99s1NY4u9Di4xJEfb0dur0SrejHL88PCCXHxzaLi0qFQquC7hD4fIjQKbbLzI1FISAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
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

On Tue, Jun 30, 2026 at 08:06:54AM -0400, Dawid Wesierski wrote:
> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> When PTP is enabled on the ICE PMD, hardware RX timestamps are only
> applied to packets classified as IEEE 1588 (Ethertype 0x88F7). This
> prevents applications from obtaining hardware timestamps on regular
> UDP/IP traffic.
> 
> Remove the TIMESYNC packet type filter so that all received packets
> get hardware timestamps when PTP is enabled. This is required for
> time-sensitive networking applications that need per-packet arrival
> timing on media traffic, such as ST 2110-21 receiver compliance
> monitoring.
> 
> The change affects all three RX paths: scan, scattered, and single
> packet receive functions.
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index c4b5454c53..8d709125f7 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -2023,8 +2023,7 @@ ice_rx_scan_hw_ring(struct ci_rx_queue *rxq)
>  				pkt_flags |= rxq->ts_flag;
>  			}
>  
> -			if (ad->ptp_ena && ((mb->packet_type &
> -			    RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)) {
> +			if (ad->ptp_ena) {

Dropping this condition means that all packets are now marked as PTP
packets, even though they are not, which is incorrect. At minimum we need
to check the packet type before setting the PTP flag on them.

However, at a higher level again, I think if we want timestamps for all
packets that that should be a separate feature from PTP support, which
should be more limited in scope. I see there is already an
RTE_ETH_RX_OFFLOAD_TIMESTAMP block above this in the code - does specifying
that offload flag not cause all packets to get properly timestamped? If
not, I would suggest that that be enhanced rather than pretending all
packets are PTP. If that doesn't work, do we need a third alternative,
perhaps?

Regards,
/Bruce

>  				rxq->time_high =
>  				   rte_le_to_cpu_32(rxdp[j].wb.flex_ts.ts_high);
>  				mb->timesync = rxq->queue_id;
> @@ -2390,8 +2389,7 @@ ice_recv_scattered_pkts(void *rx_queue,
>  			pkt_flags |= rxq->ts_flag;
>  		}
>  
> -		if (ad->ptp_ena && ((first_seg->packet_type & RTE_PTYPE_L2_MASK)
> -		    == RTE_PTYPE_L2_ETHER_TIMESYNC)) {
> +		if (ad->ptp_ena) {
>  			rxq->time_high =
>  			   rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high);
>  			first_seg->timesync = rxq->queue_id;
> @@ -2881,8 +2879,7 @@ ice_recv_pkts(void *rx_queue,
>  			pkt_flags |= rxq->ts_flag;
>  		}
>  
> -		if (ad->ptp_ena && ((rxm->packet_type & RTE_PTYPE_L2_MASK) ==
> -		    RTE_PTYPE_L2_ETHER_TIMESYNC)) {
> +		if (ad->ptp_ena) {
>  			rxq->time_high =
>  			   rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high);
>  			rxm->timesync = rxq->queue_id;
> -- 
> 2.47.3
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
> 
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
> 
