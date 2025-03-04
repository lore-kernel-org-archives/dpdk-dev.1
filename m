Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546D2C282D0
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 10:47:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2035240156;
	Tue,  4 Mar 2025 11:47:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 63A1540041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 11:46:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741085217; x=1772621217;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TLZ146+CgsRw2OV1yFCihrfRfGQCBDtffcW1ifSKVvc=;
 b=iRkTk+7op22iwrvXsl1b+gi4PJ3GyhxM+naORG6P5O6qdk+LrkV2XgGq
 dBn6HvjiyT08WkWI/LM7IkXU8GBIANUjxakHaCpzuP3iSRtYb0pNBrhsZ
 kZH3SngSePSBHhv6RA9f5zFtFPTYmwULSriWuHRwrSMjkqLDxlkDdRT6V
 TVHTgU87SgMeLWCwLaSjOIdMO/yCcHnFMMt67hXyi2euXUBezVDNFk+Z9
 8nhqnc29TO2fU0WyVnhoYudOUVzzW9q2FiL6aFaeCYn5UJQmaJFSg30xD
 pPQIKDRhpNT4JHh+02INON06oHA4BDBCkFGmZHMnIGHvTlg9nqhokS5BX g==;
X-CSE-ConnectionGUID: DaLHpk0VTxu3W4CxP9qzUA==
X-CSE-MsgGUID: sOHz0PZ4R36XEdpoFU2V1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59545644"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="59545644"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 02:46:56 -0800
X-CSE-ConnectionGUID: +I9p9fdVR+m5jJXhQ7V/rw==
X-CSE-MsgGUID: p0YrdWPrS7OWcwxw7QkNUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="141561376"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 02:46:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 02:46:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 02:46:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 02:46:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGRrL6F5O/QX8NTn3+ngOaNTpAwf8nYwPl1DfiL7I8/cEpFb0zYWp2jPCxvozqPNdOungFbIPOIuW040JnV4+pcjmA2A3/sZBE75fZZuxIabZ97J6Z1fKqv8PUUIEYKhmo5yXwPXWd1raBOulwLNzg9guszwLEaFoqefol5g52oboU9JpJy7OxbhgiXQdbLVAVxdKIE0uryMCfaVKVub3Ian+m6XHDtb7Dwvq9mUyY8tZHhlE4I1hGiy2RFSUuLojiqBbEEfz2b47eF3cdQSr2XPkv6RcTS6pCECyF5QcTO5Mu8mKYxrSBAFSAiT4Tl9p9Rv0WPVQe0J/nZaZzpbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eczGnypAoavlmO01Adfo+rH4MWxfBA6VnUjEriHRoRM=;
 b=oPFXZbkx/E828qhZ2aTokMmgmHqA3kRbiNPi7KAzWqEZDZ9RrLWMYvpFCRAysZq5GfSdUpY4o29A7k6iGEnWW5foDdkl3JFVfLqga/qhJgHGWpYQFi1gPZYSy/AQ3R1uAL2ibQ7Ml4tHQeBFa94mpnmw92YtFgKzQo8Xa8pbiekf57I6WKxauGWrNPcbWK3+1doQbb5tEWasAvhU1pQHEY0u5bx8lTRYDsR4N/nQFR/s2AutY7IiMaUqBBL3B0/xzo3UcUdVO2hzW6PGvtycLlSCEChIRRGokphBE3HsKiBGjbveUjMFAy8AkFuFNqz6J0zq+9l5lv4wmzHa/pGOTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Tue, 4 Mar
 2025 10:46:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 10:46:11 +0000
Date: Tue, 4 Mar 2025 10:46:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 <dev@dpdk.org>
Subject: Re: [PATCH 1/2] lib/hash: initialize __m128i data type in a portable
 way
Message-ID: <Z8bZ7vyeLYXyzF3q@bricha3-mobl1.ger.corp.intel.com>
References: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DUZP191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN6PR11MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e60a893-d885-4713-2c36-08dd5b09c72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rYj5G4TQKPdyrnwoHBLvS5UpMQpnBqdgjBZmLbJj0N8U/sL7RtWAw9mk1z3D?=
 =?us-ascii?Q?407jCHI356gU5otTJ075CNVCKOZq0itUaR9FGoNHoF6hYsOP3j+1IR+kuEh5?=
 =?us-ascii?Q?BKQvhyguo45PIkt+8GqSWspq4wbcSAock32BPLAX2wWIaq+gImRr+D60KGsl?=
 =?us-ascii?Q?W5rIU11GBjvUKyW3uzjrY6NPWKmGSZQpQqDLRe6kYRjipu+0Was5wxX/oNxA?=
 =?us-ascii?Q?9bv0OQScaI+TnwYPZ6EAsWN+V6qdvcAXjpkMJH1kxjo3zix4Hjxaimej7xON?=
 =?us-ascii?Q?CzvkQ76ay7s+PiohTjnMxTyhKiprAVQz7H6EcbBopVx7yP3Wn6whFsqAU9Gd?=
 =?us-ascii?Q?NsRfrGB5WjGL1TVMjdBW8dekYt6GuVrZ9qafdaP+rdj7gYLGorbNIYy5/XvC?=
 =?us-ascii?Q?RGu5aT9hBCwsQwb4N3gBJ9Fd14WY+xZnSRpD16s8CnrABhcBgLcT5yJhZF17?=
 =?us-ascii?Q?jSmGGWe2RlyplrNgVOmv2ocuWASNT7G3Hi7U+gPHTULrbFUDMBSKJ6ek/5vI?=
 =?us-ascii?Q?sLtXc1IjMEhkn2ysFDZveU44GJH5K04PP7xeksPUUL3vn1ABkHVlSscpTWrV?=
 =?us-ascii?Q?lTfdvKVhosR2R66bdTbjkVjxBGuy2X9f6D2u1S73WVv2h6T7phcMvFHo68WY?=
 =?us-ascii?Q?pAN3tQEQ4WqMIV54LQJ5TxpMS/UaKJhqTwsSk74oyKQdcKlUUNKlqu3P3J/F?=
 =?us-ascii?Q?Mi0pqlNUNrrOuQNHJSGBvCkUJ63clSqWo0X+W6bh0X4xSkCC3GTdu8ft18L2?=
 =?us-ascii?Q?JQZiEhAU7c3bwclN+bHch03grYpFSdG2Zd3htEGwMVBXLtGSuwdSDCM63BB7?=
 =?us-ascii?Q?cXgh3UqMAOf7W/YRN/vFe1t3dNoIQ3ExA/OgY/1gsQ3Ov/p5KolfdJ1wOCzZ?=
 =?us-ascii?Q?45Db+q0WTbDIJUzVj4EFpZ4zT49v3PKs9gs7AjGyugMhl5aJUtD6S4h//L2g?=
 =?us-ascii?Q?HGOvjxVnhD6D468IQJULwFMGiGH4lQaSz+2QdZlqofV+kd6cmu9RzwQvcIHh?=
 =?us-ascii?Q?0ZwZ2HVT2XX1dVDyWERrtzyLHFUqpwUTlj5ODM2e8HW6f7/uQTd+n16G9L97?=
 =?us-ascii?Q?kWKwes6dVtFG+pWFeaJX3UOUiy1a4P8YS9CMY+LrZX6lylJ+oCbMZABh2vF0?=
 =?us-ascii?Q?L3yrbiNBFXG/9Rj8WeyuSRVrFm3k0jrhDZpMYF1tCfQqoYMtwXcYhLraZhXH?=
 =?us-ascii?Q?iG7z54CsITW7p6k3HmFJF6qOyoDgnAnBUmvNsfhkD5YN6aixgRWwL7oSxRmq?=
 =?us-ascii?Q?160EHZvqDahL2Is6j7RTHtABSLjb65Qcxn26/r/FrhaPbeNVygYw1w+mIwYj?=
 =?us-ascii?Q?7a2SHixfst3VV7jXRr5FF6Lzaz8z90woMxO3UV6JhAafAhuz7nbLruC582qy?=
 =?us-ascii?Q?OvHGUoq5ZlmoTXLM4/dIJ2JYZFjd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8pw3nTp7NpcPiIWdDixtKUbSaTkyA0Xz8TKN1YCAZxwAqtx1WrIz1Gq1zi3?=
 =?us-ascii?Q?RbGkZBtJyQnvOADb3LNkBfVn8/OJQGTpLchYUN4cY+sj7fkMYak4d2b0M0Aa?=
 =?us-ascii?Q?Bwc/FhWl1yE2eo+nf2sQMe4RRoGR4cWWfuYzJBHjQ1fVA97NAp+/EFhAtSw7?=
 =?us-ascii?Q?POkmKBO4dfqZ9i9FxrV2r1kh2rRhecsfF5cCH4jQMTzTqNWDv1n6FwkXQO3z?=
 =?us-ascii?Q?Y5zxx4+witR1RRz6sxx6DAcH7IARdOg1OweyxmqCDUbgTQf96Ah2DXy4kGQ8?=
 =?us-ascii?Q?nhAEUv7K+K6J28IPAcEIyP218Q91Mt0E2ofHrtUu6r5HEnyiM0FbnlviHwLT?=
 =?us-ascii?Q?7Y1N5qZJwsNFkPUVU19RRnLIV2AG+ahcycFBS6q+LDJa+J3gbEKwcIJxf0Kj?=
 =?us-ascii?Q?WX8jYmog7OhrmvZ7dXETUuOwD2uudpC7dFFyg6qTstqVEOWRzpeCRn312T2Y?=
 =?us-ascii?Q?aCQE5SGqblmc/7oSCfnPZN3mBfXx1K/cDMTqyom7zVerLPqN2jrM/Cg12+fo?=
 =?us-ascii?Q?9MZEgcMBGErqR3Z/WXeBs2qW/I37Y/IzAmY8dXjBb2Jr6PjzG57cRgrCtj/j?=
 =?us-ascii?Q?nwh1QKcRy1KH+wxjUoS9Vz6MIe9jfDaQDars9C//Gc+5+CgrjS3zmyyGhCHw?=
 =?us-ascii?Q?6Jkav5iz6SsB8Wol4L9vaBbs6Q1AhYFuCfUKCstN4Di+GTE6Y0gKXO5CxkVM?=
 =?us-ascii?Q?v4uD3AF/CEkzR0qUk++OhAEvQ75HUgYKV2pVsUljO8L0dz4SFY+ixX1WEm1Y?=
 =?us-ascii?Q?jyUw2IIll7N7WrUob2b5MZ3JqXZRjdsIhYApfMcf0WKtEHJV34pYCydvefal?=
 =?us-ascii?Q?qmrnEhgP9O0zDE5hxPWUQ4fe9GFxsNrxyzS0mpLE1w5UGpr6CvAXOV55e8WU?=
 =?us-ascii?Q?93Z3+IcxjrUvKWROzaZ3SH0iczpWCbqvIzSPREtoQ+k8mQtn9Ud9rKbTQFBm?=
 =?us-ascii?Q?c9gKkI2lRsb8hagw9vBmsD3g8yKIPUjlhs9Ed0OnjQiVyLtpeULVJZqG302Q?=
 =?us-ascii?Q?nSkWi+ftwoD5L7XBGx2GpyGh3kgHsHVZn/wooFa1Ba3OwQXukQA4FMoMapqL?=
 =?us-ascii?Q?nR+EWkfQGPi0a82Ct8SzP78yU8oU18zyjSKuhV9s6nv+C15F6gtW7Rd9AF9W?=
 =?us-ascii?Q?jkWofVN4myaVjkIBNop15Mga8JHODDjFuADwIcx2uWiJHA/VLRJj9J/YWxE3?=
 =?us-ascii?Q?X45m2HcTMrOMvRL2y6FfcRwm4HnCoS39nqaZQPJm6CJKGnZtZNhhVp7x2Hiq?=
 =?us-ascii?Q?bWECiT7zYr7V6bU2g3dNZ3cG9cAHvi2qBDgMvbihbtPRcsYAWMArYWYJn0Y7?=
 =?us-ascii?Q?pVqJ57MxgpR978s8YLyQEqEGsqvAMPnORC2QGU5FBW8wOO5Xn+pa1FVBqHhb?=
 =?us-ascii?Q?mrHAB3P5uo4ZiS4llfYn5se0MBYfrmXtvdjlldEZJImOD8J30McBwMlB6RSB?=
 =?us-ascii?Q?8asgbP9EimdGrAegf+ht751U5THj94gHvYL2P+LyblDOy6l4zYv4Vfzo+hPq?=
 =?us-ascii?Q?/knoZRSgZ9M3Iwu6VwF6Xa+Kz2m7SPNlQKbqWgYfDoHqaZSvyiXuYoP2h3pe?=
 =?us-ascii?Q?dIZtCL0zkqLpFkmBb6W+19TRg9VQ4aABnC/go2msO+Z26uqT3pF9WIK5qFwD?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e60a893-d885-4713-2c36-08dd5b09c72e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:46:11.3226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALLn2i2+IKE49jnqXda1ZhBx4C5gPZx5tOuYDHD6TfrVGlrOOggJEuMMihZFw5VQC4acbwgHRvZ7kIPC9Vi9A2U7XWzVBBjs6NtFy7VnFKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
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

On Wed, Nov 27, 2024 at 02:57:57PM -0800, Andre Muezerie wrote:
> The mechanism used to initialize an __m128i data type in rte_thash.h is
> non-portable and MSVC does not like it. It clearly is not doing what
> is desired:
> 
> ..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
>     truncation from 'unsigned __int64' to 'char'
> ..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
>     truncation from 'unsigned __int64' to 'char'
> 
> A more portable approach is to use compiler intrinsics to perform the
> initialization. This patch uses a single compiler intrinsic to
> initialize the data type using a sequence of 16 bytes stored in
> memory.
> 
> There should be no perf degradation due to this change.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/hash/rte_thash.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/hash/rte_thash.h b/lib/hash/rte_thash.h
> index c0af5968df..3512639792 100644
> --- a/lib/hash/rte_thash.h
> +++ b/lib/hash/rte_thash.h
> @@ -34,8 +34,9 @@ extern "C" {
>  /* Byte swap mask used for converting IPv6 address
>   * 4-byte chunks to CPU byte order
>   */
> -static const __m128i rte_thash_ipv6_bswap_mask = {
> -		0x0405060700010203ULL, 0x0C0D0E0F08090A0BULL};

Does work just changing this to using _mm_set_epi64x(), or _mm_set_epi32()? 
If necessary we can just move this constant into the function using it, to
set use those functions instead.

> +static const uint8_t rte_thash_ipv6_bswap_mask[] = {
> +		0x03, 0x02, 0x01, 0x00, 0x07, 0x06, 0x05, 0x04,
> +		0x0B, 0x0A, 0x09, 0x08, 0x0F, 0x0E, 0x0D, 0x0C};
>  #endif
>  
>  /**
> @@ -152,12 +153,14 @@ rte_thash_load_v6_addrs(const struct rte_ipv6_hdr *orig,
>  			union rte_thash_tuple *targ)
>  {
>  #ifdef RTE_ARCH_X86
> +	const __m128i ipv6_bswap_mask =
> +			_mm_loadu_si128((const __m128i*)&rte_thash_ipv6_bswap_mask);
>  	__m128i ipv6 = _mm_loadu_si128((const __m128i *)&orig->src_addr);
>  	*(__m128i *)&targ->v6.src_addr =
> -			_mm_shuffle_epi8(ipv6, rte_thash_ipv6_bswap_mask);
> +			_mm_shuffle_epi8(ipv6, ipv6_bswap_mask);
>  	ipv6 = _mm_loadu_si128((const __m128i *)&orig->dst_addr);
>  	*(__m128i *)&targ->v6.dst_addr =
> -			_mm_shuffle_epi8(ipv6, rte_thash_ipv6_bswap_mask);
> +			_mm_shuffle_epi8(ipv6, ipv6_bswap_mask);
>  #elif defined(__ARM_NEON)
>  	uint8x16_t ipv6 = vld1q_u8(orig->src_addr.a);
>  	vst1q_u8(targ->v6.src_addr.a, vrev32q_u8(ipv6));
> -- 
> 2.34.1
> 
