Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3705FE81A5D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:30:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CBBB40296;
	Mon, 16 Feb 2026 18:30:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5E32940289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:30:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771263025; x=1802799025;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bAkgkw9ViTOhFo8vrTlxSso5NZqLpi/7pTEJoVh3hK0=;
 b=N6kofvs67WArUT+uN282FZZxo0arTdXDdYFC2WKdr41psBHsLp3Mz3rS
 EwcIf0ooBrihUdrRTFZ125ODNwFUbWG1GKLR4BJR9t/SZzLdTYU0/3t3f
 +4h6JzyXHtrjX80adtqWfhWFW4Bjitkz5KlSl5tX8VsSmCPDXfmyvKwbz
 5YMa9ONF73cKpxfCX3Ri61L6L4Sq1ve7vuvBInBRVrhmu/pxoPUBRwMwS
 7E2eGMnizF/r0KXmScHUwaxZ3ckFAX5oOY15zwO3UC4ORsXHJ0y6dEiZ6
 3PAoKz+Pegok/bM+8PSK6CF5nqlIxxHD+OTtlbpwUYIyKqG6PENFmLyH4 g==;
X-CSE-ConnectionGUID: vcvKdT5uRriMr8K7BepWlA==
X-CSE-MsgGUID: 7eKjTKXmTUirErH0MtyJAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="71542766"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="71542766"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:30:24 -0800
X-CSE-ConnectionGUID: pvMqoUwNQbS8EOw4qGcN0Q==
X-CSE-MsgGUID: L+GNyeUtRi65DkVCzdaFRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="251344130"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:30:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:30:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:30:22 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:30:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bC0z87gCUGWXLCKrpqwYz/a9XrZbT76A3/GrOe5IQmHOGPSw6CiWqxZTjuQkQrq4wZeUJGVT7/oSoTabcw0o+4SkfPjr/WXPV0LCNf4d/fxDtEmODlyiqteVZe5VBjh88htvwGReJDyp/UeDo1lYUeZChz08jHY0FXlTQKI0viTMrH+uiMjdGjFSxYoIfQ6wqj7bNJT2ajX0BYlvTyR20Djw8G55WxcNTJmL2bUjyuDBH8+MerbSGtKHfVqWw9n7lmTxHkkcw1DRhk9fFmUuqacWSGjVFH/nPf2uxvc+1cm+Zu8rhm2ediG1lgDNbNNCqhsSkk8f3sFvopQ+F/kjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhMEm4h9v9z+CrE4CsuJJbJfqZXcKq4eCaSttRgFuNE=;
 b=x7B7oJUbU6sz3Ko/ZjwfwpQPqeSXLGk4C4TXH0ifn4AsbZQz38Ij1TdZoTh5axkze6Px8HAGK3yLQJrzMHoI4csrhgHObFKkjYNvTbr/NMmnnGAhliWPwB7S+iennfu7mo+TG4+DEZlrFmRD7US4Cwet1AcfuVjsqvRhyRlwjL2MGn5veoGUhPyqPKPSkQjLEBG+54SeiZOXv4TOC3YUragT+gazJPHTfxCFQ/Boa/y2yQYzKc6kqspiP64o2Rbc0K1bPXTnBJV1lZBLp7oNyduUS8Lj1UkuLNWPM5ZVfUNMn8NLuKU2QwEjwSPeXaUWvqItiSCdn/7tZGsv7Vlbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF8A8418B02.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::840) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Mon, 16 Feb
 2026 17:30:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:30:21 +0000
Date: Mon, 16 Feb 2026 17:30:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 21/27] net/iavf: avoid rte malloc in IPsec operations
Message-ID: <aZNUKI6gYTPgVS43@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <969fdcf1fe6b66562d79a08e77171b54961776fd.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <969fdcf1fe6b66562d79a08e77171b54961776fd.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: LO4P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF8A8418B02:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f3f7e0-9853-4c78-5247-08de6d810f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3x3fzNePQL8FUz/Oqx5Wk3js46UoSw0dL/PAKBjTmz3vsAu26izqu5Kg1ExL?=
 =?us-ascii?Q?VWtwRLljut0tUWMh5B17j8sPaw09ggOujbA83rtzz/aHkRHY76k8zD/q/wCC?=
 =?us-ascii?Q?GSbrC5RGldAQwyiOu5FRiRzpasuumO7umBBTzdwN7duePZ0MNb7mHuJo5A7J?=
 =?us-ascii?Q?54zW7VWnjPLbiMN8A7jikEdYsWQQucIvYppGmt7sI16YPq9Bo9cM0mpRRYUK?=
 =?us-ascii?Q?AuzviwtCS2P1uYzGjQX130DaDfd6/uL8r7euI2BGTgPLgJvzeq7kej6vKRdM?=
 =?us-ascii?Q?JvrjrbtPNq0M0u2OjJ/jt3vuVK2DqrhHRy9GheStTwpYwz1KkbJzu6YOlabc?=
 =?us-ascii?Q?ZQmOtPAghJbodsExUomVuKR+Hq0BReEGQXQHxj/ut/wWR4lyshcGiymn5Y1A?=
 =?us-ascii?Q?6/NQGqqZT2T8/1g8U6YMO9MIPd6rLQqdwIq5PUSa6bm8OqzkuHEAY2SiqwhF?=
 =?us-ascii?Q?zY6gRnwntvlCkGnMCwvR3hiSNNoM7vl9iPFT+WodEoDfSiWe8LRQGRBIiTAT?=
 =?us-ascii?Q?ulTqM+4j5yE9+0iMsy3+zHyUHVuYxArCflbvZ79di1vYBcqVRuUSTU7GLjc9?=
 =?us-ascii?Q?uhIEpIhSYk3u1yH4XfTtfifEV4yjH3AfMVdIcoBGJ2oBS1yfc6uE3dzBGQ5/?=
 =?us-ascii?Q?ZJXPvy1teY0IIcGJhQyzRpzMYx+ceEfMrS/XMrjvx+Dz2AsB13VsTaMjwKGt?=
 =?us-ascii?Q?qggzbEYQEa5v+uVewgXk1w1IOfMM6WLZI4Q/2VRKTt4S6fzkHB6tTibjh8u6?=
 =?us-ascii?Q?ehFgcM+R0iuTRZfmYFF0Z/awWqRus6sqrIR3Z4CTiwFYri7MaHcR0lwLaSne?=
 =?us-ascii?Q?xsWYlttZtaynUonaC+Nv2sFLkIav54e6rjN/cuseY469BXHytFpiY55nXVY1?=
 =?us-ascii?Q?0yzM3RzlqyEKjBSHQ4wsg/JIhcEMS5XcKM1GtAaRYPI9eT+dRhSdCMtbVcRd?=
 =?us-ascii?Q?7/FfHYq60eg9jO7dwCRwe1E1lyMxkDJks/CV4oKcW32MgwVowenxA8WtFX3O?=
 =?us-ascii?Q?yH5H4hBfBfizt24DbqKTgwfO2S+kng8c2ezrzcs09HsopVydtt6oU55KrJkh?=
 =?us-ascii?Q?2uCY/YKZjzFAQdeU/xStPTWDfBRMXg2lZxN2k/BhgBg2jXiEOq/hdFmrcbqn?=
 =?us-ascii?Q?rOfHaHAirroTainjhFjUXY4nvZoVvCyAMSwFZeT/HeHhEf5Ggmv6GUqspubr?=
 =?us-ascii?Q?qUUnSMRG9+z3BmNX1Vr4aC2rGM8h+0GsBE674DdijAwX2mukYXJvoiH3iYlL?=
 =?us-ascii?Q?z88EIblaAH3Q04XQ0iE/cwFCOxb8oytV1YoACNs707diTqH9lnPJvVK8D3hX?=
 =?us-ascii?Q?h2qkueWzukULkFcvfV+FdNzqXCFWty2nR/6wfvqORuEZ/672ETvud6+99Fyz?=
 =?us-ascii?Q?6m+Q4imeMBYP4fbcTnxyKgx2O6Qmlx4Pyw+6KZwtLuk+G2wbHzJGd60UfTjN?=
 =?us-ascii?Q?ZPXlhny7xou4NtH05KdcomQ1DemG05yGFwD5gAjSH72o4fytzHD7kwy/AwsJ?=
 =?us-ascii?Q?WZ6UQ0zgjGMDbSbX3TtJhbg9oP2w3BDA+rCoV6sdWCxO4TbLyTGDdGriQsgB?=
 =?us-ascii?Q?chYtPuUiohUXrPyyoGE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FSUX2PLR52sz8eHl4WyY1qRvKrwr/HmwmZ075VLW0hbwlZD4VmhNySoOHdVI?=
 =?us-ascii?Q?V58PEQOpy+ceF8m/xxtQeGKOE4gQKaQdXPoBRp4+F57omNQ9FVPmtH1escSv?=
 =?us-ascii?Q?OFVYCWM7FzdRxACQPb4D8iRV+lD0xhoS0G2tiskFG8yXIXYyR0G/Mpxc2x1L?=
 =?us-ascii?Q?Kmx+sxJ75hYkCiqoyXvX0st+ZLbSmThhXxoFD8BcHwHjCUGrxNzdzWJJeUtQ?=
 =?us-ascii?Q?Huo1bd1tSbyxPumN5sEAprec5EtCgWsnIVKA31FHpEwCNn/bpbpYslZTVslg?=
 =?us-ascii?Q?f1JzRGRKsEhZ6/6yOTwD/lDMT0V09UG/FYd2z4ZCxf85lROa1DrCzUkXTTdY?=
 =?us-ascii?Q?9cRXI35tI7Hkpp9l7PheybfS8pyxhfKwG9UeLEMLY+xvhJr/ycKK4ScF65gP?=
 =?us-ascii?Q?/wyIL6y45u5m0csPQgbS4Km0qaIa73438wYXMuf6tKQhX0ZB8sJ656Hn3BIi?=
 =?us-ascii?Q?CkCWfj6a+SqcNfH2Oxv8Tsnd08l2fum9gT5e9W2M1B/sV+op8DfqAw1M/Ojj?=
 =?us-ascii?Q?SNiFPnPz1deMvggGkTHIJONpXCCqsY+B8eZ1xV92yN63j96bApRjeIeZ1kuF?=
 =?us-ascii?Q?WtZcfnIjuDfM6B2KFc/Eq+ZNpcifUVC1fZhOQNNcc+xAuBuDF0thnhf/Bf3j?=
 =?us-ascii?Q?tMnXXdm0lFARCXwtwWIaglJQV421h4FB7289TDIMyLzsyZvZ0ZOqdhtOwajG?=
 =?us-ascii?Q?9LNnALMdvcTrOkHLNY9cZV5y/qf7bFvglyp0wKwnbUTKqaJNmqG2AemrSPNu?=
 =?us-ascii?Q?lKXqRzsFVBHeN7en1zuIeNXwU+dzV5HkjuZxr3KnGSu7GzDmHVYSKgjF8cho?=
 =?us-ascii?Q?8udpeCXAHLfVRRn1D0XwQcpRgWup/kLZd0uRbWGDpoFAZ0bhNghipQj8uV11?=
 =?us-ascii?Q?5AaZFAkWZC+voJKfzu56qdDIgrvsm5k6DpjQD1RAeVegQLqCYW1daITQrly3?=
 =?us-ascii?Q?L4hszj/JlSqyzN3nG9Y8gaI8uJkxTAlsq4EZTQ6jCWYyVS2D0C/HAHDlcZDH?=
 =?us-ascii?Q?QPv+Jd5oQmPKTYSxLkOor4AsfmFm0LqAnpGh3GxnCPACDeS4LRcUj0iGnefT?=
 =?us-ascii?Q?GxGE5Uv+g0nnrQnbzO7IaXJ0chqIc4KbTHpkHgHJEiJ02Cmvwgl1mtTupzkc?=
 =?us-ascii?Q?GQU6TjR7e3XbRhO7uk76xpVA36V2upGh3ffWgiRHSr1OfuBa9tp5U2bD51PN?=
 =?us-ascii?Q?xvTBmpjIZ8cLQ2N4T6PfM4V5l2cYFOiNwev1GojTEfm6S99Riqn1Jv1yd03o?=
 =?us-ascii?Q?vd/tVrSJVwluAND21gVMV8GbMp2x3EDGPfroINSz/CBMB1vV/ki4zfa8tQSD?=
 =?us-ascii?Q?9XpQJkQ/ne3fOpgsCvk7mnqTidcpuSGEdb18GpcFeRvoFu5XSltpgrO3RyKv?=
 =?us-ascii?Q?p8m0qFV8Jb71uehw7VqGPNA7dg8uVpsTtUYGr5NLtucvGPZOYN8kHkmyNFWh?=
 =?us-ascii?Q?I7DDf8kdCGVXygjPDsFBv/7W09e/pZ/oYgc+5Og+RV28YxnYpz5H2Nskl24D?=
 =?us-ascii?Q?kWnpN6YHJOKmhjzznrn6q1U7nw5fb7jSzFjNWGFnyIXKeIsraFjL9ymN00Lx?=
 =?us-ascii?Q?HJRddRNRS+owZRI5qbJ5C2qKxqmHSabVmfP4JOnfq3J+hOakpJZzuPa+nF2X?=
 =?us-ascii?Q?fkVW4dMA23HBic/xHPV8z2Q7Esy8RtcaA2qDKzHuxTL5cJ6PfVXmq8QI7IKC?=
 =?us-ascii?Q?hxdfImohid7GM7fpADPcv+ZKJniYOo/o6rhaACA9HEtsW04oEyaFcarIpoNd?=
 =?us-ascii?Q?LR1GWGv3QMH4iXgwzMs9OO+aIyrInv4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f3f7e0-9853-4c78-5247-08de6d810f56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:30:20.9608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsGCOlIpG74h2LjZmN8FpVdMfK6mUDR9n6oKtMhNZX8qGwIhTM6ABewMt96Y2dikt243aYUALvYBhh8sfY9+RnI0zOLaHEbmvMuAvfIUKIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8A8418B02
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

On Fri, Feb 13, 2026 at 10:26:32AM +0000, Anatoly Burakov wrote:
> Currently, when performing IPsec security association operations and
> retrieving device capabilities, we are using rte_malloc followed by
> immediate rte_free. This is not needed as these structures are only
> used temporarily, so replace it with stack-allocated structures for
> small fixed-size messages and regular malloc/free for variable-sized
> buffers.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ipsec_crypto.c | 58 ++++++++--------------
>  1 file changed, 21 insertions(+), 37 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

