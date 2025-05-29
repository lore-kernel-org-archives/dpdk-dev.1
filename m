Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C24DC5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 09:42:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB4474067D;
	Thu, 29 May 2025 11:42:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8A80F402C5
 for <dev@dpdk.org>; Thu, 29 May 2025 11:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748511764; x=1780047764;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qR/9wVaYap3J2tzt1y8hlUnSEYS35Vo/XciKkcV7Gt4=;
 b=N6WG38HRYRuHoBxWqzRircfI2I9ukyYdJGCvrYB5oF1o+bWqydETsREC
 8TC4uA5PhMBea1fVDT/VVAhIeOB1a4yLcaCj60HsaZtAw/wZep0/5EPr0
 0wdz8xsELFE2VuunEjLNFtpE2eY8rasVFEQEsPHHu4j3xApktV8RZyhAn
 xSnn3bL/pnVusFct3xOvSA7yJqFzNSjI/uS73gQ3/OTkQMsYvjQM6H4o4
 XslzRT8VRXxuD8MCwt3+zz/a6BwEzMzk+soMCmVRBdDijJ6G3VbD+RBGT
 VzQdaW8hK+EjI7RxD8FJHZnov/tsT/WrIOmVSZhQckTNkDjpXc/LKa9JX A==;
X-CSE-ConnectionGUID: K9haSsw4Q16+kOW7R/hhEQ==
X-CSE-MsgGUID: 8zn8K83XQLS7YXpwG2t+Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="67984868"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; d="scan'208";a="67984868"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 02:42:43 -0700
X-CSE-ConnectionGUID: WDhubUabQrOJELBtSP50cQ==
X-CSE-MsgGUID: kst4M266SuimPZ3t1R48Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; d="scan'208";a="148550808"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 02:42:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 02:42:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 02:42:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.46)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 02:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOMQizf/wmCpo6e1ccfhSlNxvlCZFFJtZWu0n/JefiYvY6CQ3OgF7QeeERRHzU2LzoZ7Vk00hUmCGCsFQ77L4X15w7HopanHSAH9d1nXvI9o/N80krcPi7bM47/M4J4kkPNxF6Y4xnjGhiaiO2qRD1Wzpl2WB+kHZ8i5fpR2nUYmCRGmLvKedTKrKCE9k8Al+86+/rr9spK9McovnT3CWBp4BkSDjuU3C5TfxhnQ8SmTjA8Yh7VlNSbD0tLvCzaxb4PUGMlKdCrDN7+0SZ/gOTqtgrFNdHLhboz/NRRVOaOS9G9M1eAD8NrguxFc6x4iLEFz+xxxUeMzNcOTdiIzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj4uVwyNQcGmYfigFtiMJuiYJDU/iaEdK4+EklNAXlw=;
 b=QJyuEzSpT+VPFLRFGUF80i6z6j8+SRUzZrWXzRAvbi10xZHi7tMFCbTEAzdtP1QQ4RqRFFPUxF3hHeEOh/zOBHsNTto5dtyR0EHR6vZUk99Hc/S/nv4+CJ7orFxZ74i7TPbNtW4ZytWMLQEkKNcJetkFFzJqgx2v/VyHw8ciCs5nS9MQ5GjyQ4Xa83YCYsgJeVW4b9TwnvYiCQoM5Cyak4riWDEQeTduk1rZWRtd5N5i4A+2NJ80Tcy2TOtl6tOZf/bT/r/UDLCDV63diQKLhJ6H0NL/FkC5xwGtshECEFrcIiGPn6xJ00dceFhaj/XvDJ3vH8SuuFHnGAUG9fkDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SJ0PR11MB4958.namprd11.prod.outlook.com (2603:10b6:a03:2ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 09:41:59 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 09:41:59 +0000
Date: Thu, 29 May 2025 10:41:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Lombardo, Ed" <Ed.Lombardo@netscout.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: DPDK Ring Q
Message-ID: <aDgr0eXU7u7SAcLV@bricha3-mobl1.ger.corp.intel.com>
References: <CH3PR01MB8470603D8C5E5DEE5BDB5EBB8F66A@CH3PR01MB8470.prod.exchangelabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR01MB8470603D8C5E5DEE5BDB5EBB8F66A@CH3PR01MB8470.prod.exchangelabs.com>
X-ClientProxiedBy: DU7P194CA0019.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SJ0PR11MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e4efa5-84db-4aa8-0336-08dd9e950690
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bfV6koOk2+yW0D3g946zbNJoAfjb0K4axliSsnSm6rV26fEkjL9QZLtKCKmP?=
 =?us-ascii?Q?yh4q1AOceivlY2Oynt/XTWBdDkLWyHj6RGcPlYCzBVWzxNPH5/2vhyc0sAM4?=
 =?us-ascii?Q?JvpWJCkLZmlNXQX0v84IS//k1bADr/FPd2ICMKt2LsbnP0dneLNV/ZsOg0xK?=
 =?us-ascii?Q?+GMM+WW0xdFb7mtDumm5Pv2cm8P1oXg1i4+OgRzWkiqnprKArbt5nTEWcY69?=
 =?us-ascii?Q?xrUTdi4NI+FzrOE5hMyH+F4eEKXNsFScsfeshF0J/NMrQ0VobKWEtRXW6NSo?=
 =?us-ascii?Q?KBsXnWwxJD7eSrrRbwdzwKL/BVDUKAfEjFu7geEI5Ce/K/mv3X5DY7EbIWBD?=
 =?us-ascii?Q?7owOZCzXkuY0I7YLb/TzAmc0H5yP8Em7pZh7N7KNA9wy2SMToHTMVkaM8VEu?=
 =?us-ascii?Q?JvgQT8oh6YQAaWPvinyWr+maRSepCAcPCE/+Ve/ZbxJYbV1mduOX9eTm/F4y?=
 =?us-ascii?Q?S1aQeB8icnD/8emBwMEhh+GHbFdsHRhfs43wdOKGd8rCLQHmFFjXlGjp1zfX?=
 =?us-ascii?Q?KTg6Gxcotgf2aN/mnRTmhGaplomy62LV5yshZioQZcDkJERDBHabbimWhy4P?=
 =?us-ascii?Q?6KWRxjUXY+5QMVuELvlJ6OPGtOHQuTgkK0NosFEebwVzxtO79zBi7SeSIEwr?=
 =?us-ascii?Q?0kcgbXKO1exAZhhEvN5SBD7KsMjmQAYz5MVljXLFASzHYDeUdPW90HQstCjp?=
 =?us-ascii?Q?Uah4KEE9KXOSLqWLtpVdpKU6Mn5ThjdpQ2YzeAlhCPClIOxF4AoFACiEFIaY?=
 =?us-ascii?Q?LS6b2LNr53PtymrtxuVMJhpXux354Rn1GATkcMewy77Cmzq3rxbJ6C2gJ9NI?=
 =?us-ascii?Q?v2+lPbM0lH54NpkRAWiGokCetAOKEY8vS0uIwSmjvbHpUpJnvpPiekvi6C+w?=
 =?us-ascii?Q?Ln2D2Uo6wT0xX9bkAHC8CxGWVJZ6q/8SvlrLQm14Fwp4VRFyYZtywPC/V5gS?=
 =?us-ascii?Q?8ttKvcQtsXdgViciep26OGZf7r5KaRiqSTNdOOXC/Y5iam71V9TY7Fs7JMIn?=
 =?us-ascii?Q?0rnzw1IkYeZE1OF/LW13sYKv7Dor3v0FDGiFEHplMpCS9haNSE2ozAS7IU2e?=
 =?us-ascii?Q?V+p+BXWrvzVp1llsmITSEnPRvB/chQoAin5EETqZHAlMbAmNpgWE5G/yXjbZ?=
 =?us-ascii?Q?1NcZm7RpVyL8Oz4WxcpULfpNYHZ4K54IltT5aVzZ5azp38eON+BbdoRkrYSo?=
 =?us-ascii?Q?2cQqZBG8RJvIdppB6CtBw304d2rnkw38jkHdTP8SyAARYQnI4DFhPaBCAeut?=
 =?us-ascii?Q?6JQSCB1oQ6rpwVs7r2BFi58iHvg6Ql56LfgzFX7vPnLcFNYS6QJnT+k0y6yb?=
 =?us-ascii?Q?6H3ed78y14mnDuay1Z+DMVGJQdpNHBHRGMdiLbtrpipCQ6Nx9rGybZSg8ecl?=
 =?us-ascii?Q?UZ7sHLRipaqmYK0Uy1bmkXKYMaM6LduB3aXLzVe5wOiWxZUI7SXUlw0YB7UF?=
 =?us-ascii?Q?7bm7Mf6A24M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oyPXsPq59nZFtP6kdg99w8oPQeZk7iXM0+JDs18iveeWefIwgbOISNYNW0Um?=
 =?us-ascii?Q?HcNJBIvn++Q7aRyoi2tf28WL1InYDDmLBUDv/5CQv9qBnS+HO/lgGsktnjyE?=
 =?us-ascii?Q?fNFGjJsR46B6lC7V2/5kexbQivchBFrQ9bLVY7e20URomTJjtx5zpuKsXpCM?=
 =?us-ascii?Q?/fT8MHEr9ZC7dBRgm9zFUFRA14s6FQQtyqNjHXj+/bfdFxuZifsEz0T9ue6m?=
 =?us-ascii?Q?Ze+DFetPF3rbBrycu5sYd+XPXGX94wAtfCPyEXsekOS9JpQhjkKrkA6k6ixk?=
 =?us-ascii?Q?gYB7/uqTNBraE5aUIYOHJ8qHHT5RABfXTRoR1gmnsh40BaKiYg3gaoLxkg3l?=
 =?us-ascii?Q?UmG0AvKIysfCtb2G474EXJT3lIpCF0huAP6SBBjhqM09MvJJoV3o1Vumw7QK?=
 =?us-ascii?Q?FK50anPd1J2dIn5FC6W0pJogbxeeco/9V8L2aU+IONDVmSBID5YxAyWCqGpN?=
 =?us-ascii?Q?LcXT0K7ZVZ97JwNuJut0lIR7jdLnXxrGSlA5V3GMg7psPSuP7w4GBcI5hVDf?=
 =?us-ascii?Q?h2PohWaWmv/oX7K/PzduX6Pd8YrS/Cy1aErX7oO5P+xF9kVWE3E0r8va8RaH?=
 =?us-ascii?Q?MBpmjL/1cDPZIvoKGnyEttyfL7zKjlaoNKiOwg3ewuKsI6IrGv9YD6ngAb3w?=
 =?us-ascii?Q?VmDXG6nwHi9wFjVYkJAUMeXLe35W9CCvJwjFR9jmCPARn3C41/q7AGanwhYs?=
 =?us-ascii?Q?wyM9shUd1T78M4ox4fnTu1iTMASvr4bxcsfltvrOAeFNsD9oWuZ1b0RgXygt?=
 =?us-ascii?Q?j8rdi9dY4pLLKjJe95Ubg2SpZrcgVYO/DXp+iOXFoiaV9Pgc3o2gFk4bhTo4?=
 =?us-ascii?Q?mfrE58BzAGnbhey2ApDhsRO4DMw80fczVQYeIYV55BbkbupzohAnGSOFLFYD?=
 =?us-ascii?Q?HMV4kWnZYXHIQ2BXNe4HAyG7vKjefZmlQaq4DYdBoRHgttMW0GDPb37OE8LD?=
 =?us-ascii?Q?HXbYDyAWYEnrDkonsCTJHTgjiaH21EhIuEAKyYmeMk1qHC3C0IOPk029SOQa?=
 =?us-ascii?Q?oB/o+p0/xr+w2qWnvlUmr0/pqPQMbiFx7o3peVGYJo5APDKtHF+PHBR80+nx?=
 =?us-ascii?Q?l+gjjnx5m9mJowORVlXWvxqeRCrGxDWkPqwh/cCgeTIifj5YQXvm5ww2tcSW?=
 =?us-ascii?Q?6yx5MEnrKmYK0ThaKiyfvM4jZLSJwPEvxukEqba2GO3apdNuW7zX3f0D5/zV?=
 =?us-ascii?Q?mURcI7x2TE2XOqhgVqzElIaDSWusTv5XhA6RcGdS4WEQPfja8abflqNBU5kE?=
 =?us-ascii?Q?1tSjpeJ2HnRMsE6HzVjk8YOsAD2MTksySCtOyJujaA9fID23aemkAt85Fv5d?=
 =?us-ascii?Q?YhUhTHUEXNkAlzTMYXEdvRqd2r59bUKBtx86h9ZfV6Dw6dT/lDXcUz3ql54G?=
 =?us-ascii?Q?ZZGF6f4k65UXe2mDOC/+wV3ZGZ66MSV78ecW/Zwky8ekEbv3Go4/7JQyebHJ?=
 =?us-ascii?Q?clR2wTJkKa5DXJ1YjBzeazRAnrxLDhFDRRqsK44UNFjZEIC9tp7xvoOXxVCt?=
 =?us-ascii?Q?1iXpLrCt9pmrevvPFQtUOeARIO1+IPfBlWU+bA+zdvCNVJQjlG6fUdgHqUZk?=
 =?us-ascii?Q?SO8KHeVu5PEG9Dn2vQJwjcQgjj9Y7bXo/R0TpRuqnqNj+OR+t5u5hSqadxr0?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e4efa5-84db-4aa8-0336-08dd9e950690
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 09:41:59.6210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeYoXEZxA4vNu/sDcGnDN2wIDz211OMkzY/ZgVFxBQ0y5VQ24hPrl+cCnWQ6enPCEg9MeOVHD9x7pqt/BAN6FPAR+610vQP1eL58HTIiH8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4958
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

On Thu, May 29, 2025 at 05:20:25AM +0000, Lombardo, Ed wrote:
>    Hi,
> 
>    I have an issue with DPDK 24.11.1 and 2 port 100G Intel NIC
>    (E810-C) on 22 core CPU dual socket server.
> 
> 
>    There is a dedicated CPU core to get the packets from DPDK using
>    rte_eth_rx_burst() and enqueue the mbufs into a worker ring Q.
>    This thread does nothing else.  The NIC is dropping packets at 8.5
>    Gbps per port.
> 
> 
>    Studying the perf report, I was interested in the
>    common_ring_mc_dequeue().  Perf tool shows common_ring_mc_dequeue()
>    92.86% Self and 92.86% Children.
> 
> 
>    I see further with perf tool rte_ring_enqueue_bulk() and
>    rte_ring_enqueue_bulk_elem().  These are at 0.00% Self and 0.05%
>    Children.
> 
>    Perf tool shows rte_ring_sp_enqueue_bulk_elem (inlined) which is
>    what I wanted to see (Single producer) representing the enqueue of
>    the mbufs pointers to the worker ring Q.
> 
> 
>    Is it possible to change the common_ring_mc_dequeue() to
>    common_ring_sc_dequeue()?  Can it be set to one consumer on single
>    Queue 0.
> 
> 
>    I believe this is limiting DPDK from reaching 90 Gbps or higher in
>    my setup, which is my goal.
> 
> 
>    I made sure the E810-C firmware was up to date, NIC FW Version:
>    4.80 0x80020543 1.3805.0
> 
> 
>    Perf report shows:
> 
>       - 99.65% input_thread
> 
> 
>          - 99.35% rte_eth_rx_burst (inlined)
> 
> 
>             - ice_recv_scattered_pkts
> 
> 
>                  92.83% common_ring_mc_dequeue
> 
> 
>    Any thoughts or suggestions?
> 
Since this is presumably from the thread that is doing the enqueuing to
the ring, that means that the common_ring_mc_dequeue is from the memory
pool implementation rather than your application ring. A certain amount
of ring dequeue time would be expected due to the buffers getting
allocated on one core and (presumably) freed or transmitted on a
different one. However, the amount of time spent in that dequeue seems
excessive. 

Some suggestions:
* I'd suggest checking what the mempool cache size in use in your
  application is, and increasing it. The underlying ring implementation
  is only used once there are no buffers in the mempool cache. Therefore
  having a larger cache should lead to fewer (but large) dequeues from
  the mempool. A cache size of 512 would be what I would suggest trying.

* Since you are moving buffers from the allocation core, to avoid
  cycling through the whole mempool memory space I'd suggest switching
  the underlying mempool implementation from the default ring one to the
  stack mempool. Although that mempool implementation uses locks, it
  gives better buffer recycling across cores.

* It is possible to switch the ring implementation to use an
  "sc_dequeue" function, but I would view that as risky, since it would
  mean that no core other than the Rx core can ever allocate a buffer
  from the pool (unless you start adding locks, at which point you might
  as well keep the "mc_dequeue" implementation). Therefore, I'd take the
  two points above as better alternatives.

* Final thing to check - ensure you are not running out of buffers in
  the pool. If you run out of buffers, then each dequeue will have the
  refill function again checking the mempool ring to get more buffers,
  rather than having a store locally in the per-core cache. Try
  over-provisionning your memory pool a bit and see if it helps.

Regards,
/Bruce
