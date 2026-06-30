Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D71C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:29:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 816234067B;
	Tue, 30 Jun 2026 16:29:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 953E040654
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782829774; x=1814365774;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=F2cMloeTxOnHUPkBL+Y6NeI/98tHzSz5oDBnfmkS1Xs=;
 b=lFV202g/URUcHgyueu0DSDFqjodLlJBoz16lpuLBvGpncMD1Tvfc/uo8
 bigu2fegAzfyWzMiuoEpPYp+86WFf29Wm1ji/ts4lMBwc7Bdi1SaWzjGN
 p5cnXayuOEXT9yC4O+62FtUaqpAVNypMWoibc0KgwRHKQDYB7BfpJeql3
 SchpLY3lYVdpivs6GTs3US3qno8u2y1QQg6vyshgjuPJkMWGmmZ0r5ejL
 P8XcV1SwqdtdVnhnO78mdBRIQ4kJNPDUePXs9tJH1tLQIOpZ4/go2RjZv
 Ta4hS7hq3Mjchb/EV9kLSqrXR8Bfw252uzbdHDkUhj/4RkTDAtN+m9xR9 A==;
X-CSE-ConnectionGUID: U6YJvjwkTDePuDxnEmUHUg==
X-CSE-MsgGUID: D2uJVFHfQkSzT0zVbwemww==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94694739"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="94694739"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:29:33 -0700
X-CSE-ConnectionGUID: 24He+VqdSlaRHifrBm92fA==
X-CSE-MsgGUID: mM4En7J/TLCdbqaKVXodiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="248296023"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:29:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 07:29:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 07:29:32 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 07:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSOBKAHHLzd+weMUoPCGJvQWM7e/hzV9gW/ix2l/Z5UZ4xo7yrWSbXVJkkj4JfrgCT8rKGfoWGKs2Ko/3B2y0ZeqCMGAzbc8K6N394c4Elu5ffy+fBdIk+1mznWe0rjkR9QikIJuiWYlE5lQn6vZToVgwfbd7ftEoEIwFTlqkIvnwBo340LMRatBkq7a8/6MfgpmJU8PGOHDJOIP0zukkzb7VP4EijkTqHTtH2IXNGhEn1cSbHZ1PPeQg5vAkRoAdHcKVz2IhWp5f8RJDs0YeZ6V3XzgdgEfF9olnksopn/ownnUye7Gvm5bYNSQ8ix97YV22l+O1R1rbZJFe3LX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5Xk3Bfx8zwZmlolDclPy+rgHN7NbmJodxmc/6AzEaA=;
 b=dNRkF4Gpa+ZobIikq907V+669iDaMYz/30ID9YDOexG5DCygZ6Me+uGznCYGHCdnnl7cmMYWK/xV0EkiME/rqQoMSSAwPXwBHTGVaI8BYvA6/2JsiUKT0bv+6xEbWPDzxdhDNuGfPjGqQwbxgGa3uB1KMSbXnOwyQYDmzg9VSss74FTqo79bts9e64h7qUCOkPF4drNqNqDAAzRASRgn2RvXPRWD6fOYD1iDCEihP3ZF92kgTlQ9n0Ll1sPeKCCgtDe6OgrW2Zcq6LUbkMaPDjNqBtufSyqZl9fb5HjDAZCPSesKpMBIRAFrrS5GIUmVjeTvy65aaFiyOwg0jEBCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 14:29:23 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:29:23 +0000
Date: Tue, 30 Jun 2026 15:29:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v3 1/6] net/iavf: increase max ring descriptors to
 hardware limit
Message-ID: <akPSv6FjroM3XEbh@bricha3-mobl1.ger.corp.intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
 <20260630120657.1046588-2-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630120657.1046588-2-dawid.wesierski@intel.com>
X-ClientProxiedBy: DU7P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::8) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LV3PR11MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: c1690c81-018c-4b98-9e67-08ded6b3fb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|4143699003|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: jaOksGaL+yY+nypxbwL32GgcOmX7xoQbXZhoym+5OCCxiXrM2mvaVZCtBo2Guuz3vdNItMe5yVxhC1704G9OAXHNHsipubmqgdFpSKfb9Egq6N4dn+KPGnP+dFm6yVI/tO2q03XDQ/MaAtsI+tLgPKC45w4YiXdA+PcPqOF6ko/DnbTbKBDFhJx7FVKMobx9maPrhp+1H/PPU45S7X2cMKPU3WkBs8Y2sOA6LFJWT9LJ7MWyGnxkAws2D09D1LHhsbXRYI8q53IVX5wioCb6/TqY0bkC8csZFynQw+MI44TTeW42AKuVAPXdVW9drnbqsjuQ11HCU2IRWfGfYpeLkWZ4TSzvhj9UR9AmB1LeiNR+vkpRi/NQUSmOEfZjFXqqIv1MewnDi5HuwtOWJfJ+nmDC5uzEhgJTf2SV9cPy5wTiB3NWuktGliSvnuhctP8tlX3wIrmcBZsYg5A1b/DGbICz759O5Ma/RSo33Qt2Qux8syBOa9FUn9QDe1pDLQ5GLC5eC+W6pBV4Znj9mn+SQZAW/l9iyhP7xSDIbd90d3QgwO/Ct9zPxifCc9xGFbwTkKVuhns/Jds9sE6c8E/BwdhhaszDcKVJle/b1pZG3oYaB85Rq0/oc4kxRzuUh5CIrDd57YwpjoaGksdQ36YtWyU32GTw7aqi6FtE4TmK8iY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(18002099003)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3l3azZFM2lmOVJwRXNGUHBRUEVBUWxqSkFwck13S2tzbWdDekk3UE43SnNm?=
 =?utf-8?B?YVlFQU5pc3JiT3M3SlAvV1ZmcW84Q1NtajNqa3lBOEpmVVFrL3k4L0h0RGdR?=
 =?utf-8?B?MVRQdGN6Z01CSEREMWZPc0oxc1pmWFFNSnJER0RyWE5GZjcreS9ZTlpmVHJF?=
 =?utf-8?B?MXJzbWNMeUpKWUpEUDBUS2Myc0JzWmZaNnU3WEhpOERWRG0xd04yTlZiVXc1?=
 =?utf-8?B?MlJSejBiWTRXdGp0RlhQYmdmNk8yRE5LalFNb1pLTExDZDJldnhXUy82ZXkx?=
 =?utf-8?B?YmpYR0NnQ216dWU0ekRqM2hoRXUrSTIzd1pKQm1idjU4MjVlVmNRd2NheE5U?=
 =?utf-8?B?YkxiK0E0MHozK2V2dXZZaDEyUUdQRjZZc1JOTWN3blpTdUs3QzNwSjY5Mi9j?=
 =?utf-8?B?cUt0WnYzWHMzc2Mvd1FPV1o0STVvbFoyRU1BTTlqTVRHQVE0TktQOWR0ZnZm?=
 =?utf-8?B?b1NiczQyVWNvMUpQM1RLT04rL3ZsazUxbWdOcmJRZHFTVFlna2tIRzlmUlND?=
 =?utf-8?B?SjhtYzZJYUIxYkI1RHRCNDFhWnJyaW1IbzdQYUFCeFE2SWJKNzdsb1BNQitz?=
 =?utf-8?B?RE5Pc3drTVlCOFFSNm9NNjVML0NRRThmNUR6QzgvWFZrUXFUNzF5SDJBSlk1?=
 =?utf-8?B?bGdnYUg1YlpiYnh6TEFVWm9vUHF3OGFINGtMYWpmVCtCWCtUeXlsRWhHQVdW?=
 =?utf-8?B?UUh3bWJuQ1FlclhNMWozZCtCOCtSdndYV1E3SHByVzZ6SC9XV1lIaXNNYlpK?=
 =?utf-8?B?SUdySUFuYVFKRzEvaVhqbm53dVJwTk5tUW41RDFNcUZyOGlFRU9hNTY2d2NP?=
 =?utf-8?B?SGswRWtJZ2R5UlJqbmJGYjBhL3NwV0dFaGhGRmllOTNHcUtJU1RMMVFCVU5r?=
 =?utf-8?B?NjdjakJkdXhTeFhQb2xGTDhjNGV3UmdudFJUWW1nanpsaTFGTFF1T2JydWlD?=
 =?utf-8?B?YVhEUDFmNzVNZXlZRFc0bTVhTlRpcnVQOUQwb0YxYysvNVAyVjQrK010U2ZC?=
 =?utf-8?B?QVJRWWNTNXVJNkdVbEVlVnVqR1R0WnRSWFlBSE1XRkpjZjNZQ1VDbzJLTWRm?=
 =?utf-8?B?bW4wMFNndG9SS1VFdHVWTUpUNnh6VE5xdEs0MXJlVEtzMnAvbFc0SzFrV1NQ?=
 =?utf-8?B?VE5NZldGV1pHOEJCcHE4Z0NxVURGZDVlUklZT2tNQzB0NDFKczJ4SGpFRmJt?=
 =?utf-8?B?UVVmd2hVRlJSdmRKb1pyUUVlcWZUN2pQWVJTZHhZWUd6TG81VnFiOWQ3dFFt?=
 =?utf-8?B?M2lWWjQvV1pFcWZlbm41ZTZodUxxOTdjc1JhNXZtUVluVE5HYURRMXhWVkI4?=
 =?utf-8?B?RjdXSDlLdzlDVDEvU2lBRm1rdEZhcDNUSzZJNy9oZHpPOFdSdGhkUnduTk4z?=
 =?utf-8?B?emxqSjNCMnJ4ZkJoWXBBaGJ6dmdPOG1MSGdrWE1NLzRla1UvTjJWSWpQUHlV?=
 =?utf-8?B?NUtLWlBwMkZrZ2tBSTZrUERsZ3VDYmwrMVArYVBhR3F1QWlJTkR6LzRLZVZr?=
 =?utf-8?B?Ynd3ZnRzYk1yWitPamQwOE45VzRKbytyZXVPVVV2a2ZBMDA2T1pLYzhpVG55?=
 =?utf-8?B?RkhPNk93M1FQQWxiSU5NSWh4bmYwd1hPYmlyeHRuOG1Gbmp2aENuZk9KR3FH?=
 =?utf-8?B?TVVsazVzeGZkV0RsWEZydTZpNW9neno5alBRVGV5dk5OeHdKSFFUM05iUGQ3?=
 =?utf-8?B?ZkNBcVFZaXVOQktFL1h2SU9sLzByZFd1d1FNUW4rbUZTaVJvU3NLcUhuWXNz?=
 =?utf-8?B?c1FpQ25DS1FFYUVXOWM1NkxMYVpsazFucXByYWxyR3U1T1hRbWE0bFlVSkw5?=
 =?utf-8?B?UTNvNlJ5QUVxTXVLcW9VMkxrbzRkZG54NUdUdGJzNWcrVElmaE9JMzhYRDFv?=
 =?utf-8?B?KzhIWkR6eC9CN0tpVkVZMjU0V1R4VG9Cd0dzeDNGVUdVdW93aEtncVlCaVYx?=
 =?utf-8?B?ZGYxeFJLbWxTblA1WU9ISWhqTmw0TXAwZnVBZjcwbFkwRTVQVjYzQnd0ZGZm?=
 =?utf-8?B?QmdWNjJndFVWTlJtL0cvWlVDWkVFY3JLZCtJZUJ4TmhGZFNHNndybWRSd1BH?=
 =?utf-8?B?VUxUc2c2R1piVjF3bjkxSWkyU2xsNlJyYzFCekZUUUJHckM0QjBVYWhvZWND?=
 =?utf-8?B?Y1RLNHlvMEFKMzJqaytrWi94bzJSY0ZYUE5seE1WMUNCVnF4TTQ5WlFpK09w?=
 =?utf-8?B?Yzg5TzlwSWlDQXJhMGx0NW11aEJsVHBZaisrb3BxdWhwUUVlbFFBSXZtWWVt?=
 =?utf-8?B?cjZMenFBeHd0cnp5VzY5VEhUcDBkRTdpN2J2eUdiL1ZwZXVaWUhyd3NRUE16?=
 =?utf-8?B?Y3BkeUlWS3FtajlaNmNCdzU3QVlTZzdRNDNJc3kvNFdRTUtSK0xmeXNvVnpL?=
 =?utf-8?Q?T2OdKeZNFdNn5iSY=3D?=
X-Exchange-RoutingPolicyChecked: lxqjlhXP5jHK6SgnoP9qs/lYCKasqP9bulfrF9cSxI0v9OFJ8YskoRyR2+Qj9Yr1xEIHOlnbUKpkHlqO9tozQe474D/G8PZHPFw5VBo32AsVlP2dodmxMnLO56CnHCXRpjj2lGRTemR1MQ+w8oDvwSm/OiqsJtApBF7zqB7kEzurfwz0uVTGteKNiQyOA6WYIF6tzwdmDdAPsm7V/pKxErsRnWtrnI+fpA/eT6pb+rq8kp3PweRoCLftmuSVAajb3epcAnlYuxiLVUjBrYorr1Q4BXv8WeuxNRh94DmtNMMRE3CKtAuTDJOVLdDJcFYxMVROMf5P7iQcOSSKZG3sAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1690c81-018c-4b98-9e67-08ded6b3fb2b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:29:23.7720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvkernHqgg+kk5uBT88XrbAVSjvgwuIHw6Je/5yMoJ8uJuszX/VpvjGKirCyyq3xQ7ADkhe8oH39eG66v2UeOdWVE1jqxeh/cKIixPNYdqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8603
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

On Tue, Jun 30, 2026 at 08:06:51AM -0400, Dawid Wesierski wrote:
> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> The Intel E810 hardware supports up to 8160 (8K - 32) descriptors per
> TX/RX ring, but IAVF_MAX_RING_DESC caps it at 4096. Applications that
> need deep descriptor rings for hardware rate-limited pacing (e.g.,
> ST2110 video with thousands of packets per frame) cannot queue enough
> packets before the pacing epoch begins.
> 
> Increase IAVF_MAX_RING_DESC to the hardware maximum of 8160 to allow
> full utilization of the ring depth on E810 VFs.
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  .mailmap                           | 2 ++
>  drivers/net/intel/iavf/iavf_rxtx.h | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 4001e5fb0e..d7b175de2a 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -366,6 +366,7 @@ David Zeng <zengxhsh@cn.ibm.com>
>  Davide Caratti <dcaratti@redhat.com>
>  Dawid Gorecki <dgr@semihalf.com>
>  Dawid Jurczak <dawid_jurek@vp.pl>
> +Dawid Wesierski <dawid.wesierski@intel.com>
>  Dawid Zielinski <dawid.zielinski@intel.com>
>  Dawid Łukwiński <dawid.lukwinski@intel.com>
>  Daxue Gao <daxuex.gao@intel.com>
> @@ -1014,6 +1015,7 @@ Marcin Wilk <marcin.wilk@caviumnetworks.com>
>  Marcin Wojtas <mw@semihalf.com>
>  Marcin Zapolski <marcinx.a.zapolski@intel.com>
>  Marco Varlese <mvarlese@suse.de>
> +Marek Kasiewicz <marek.kasiewicz@intel.com>
>  Marek Mical <marekx.mical@intel.com>
>  Marek Zalfresso-jundzillo <marekx.zalfresso-jundzillo@intel.com>
>  Maria Lingemark <maria.lingemark@ericsson.com>
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
> index 8449236d4d..22ea415f44 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx.h
> @@ -16,7 +16,7 @@
>  /* In QLEN must be whole number of 32 descriptors. */
>  #define IAVF_ALIGN_RING_DESC      32
>  #define IAVF_MIN_RING_DESC        64
> -#define IAVF_MAX_RING_DESC        4096
> +#define IAVF_MAX_RING_DESC        (8192 - 32)
>  #define IAVF_DMA_MEM_ALIGN        4096
>  /* Base address of the HW descriptor ring should be 128B aligned. */
>  #define IAVF_RING_BASE_ALIGN      128
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
