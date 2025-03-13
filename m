Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348D3C28B28
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 08:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1601640EAB;
	Thu, 13 Mar 2025 09:56:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 66A7540E49
 for <dev@dpdk.org>; Thu, 13 Mar 2025 09:56:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741856181; x=1773392181;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=C5krbZT4gHdNUkUi/n1iZDRAB8qqOa5n8jSWCEcD2dA=;
 b=UWVVn7gYAahMCfRJ9ZbJDDBPsaMKfPLM8L1Fm8KoFKDzfpIZ9TKcVRk3
 i9Szrw2lDUPoYQmxocaUl2/IrJHLbS+2Tal1JuAFm1L3NBKBFraVQJBrv
 YlDp5JXJcLXi5Nvq8yLLIhHMnomCfNf/uQ9NuicDYvizAbYlkS7r8/EyI
 iWEDLanETJazKyg5V21yrOdUppmjg7c5ZIG2tLK+WbKgZD9J3r//E/pgp
 DFojcKKxShKaGluSBlvfmh0FC/MCwdNk1JK2AiPbIAyF1Iyl3L/QZTqlO
 MGO/taPMSHtVkOjqc4CKZX51ZNzJU2uZ75Dz4fSShXD10KRUXdMMT7i1i Q==;
X-CSE-ConnectionGUID: hQe0ue5NQSCOT5xIR6ETag==
X-CSE-MsgGUID: svBMvdy+QEuN6lN/flbQIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42991871"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="42991871"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 01:56:18 -0700
X-CSE-ConnectionGUID: +LiJthITR4mnMmgkFVyeMw==
X-CSE-MsgGUID: hAEEwStkR2qdwRrdnMvhPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="121382392"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 01:56:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 01:56:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 01:56:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 01:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0AB39mIP6GICPe9vTQcjRD82lXK8BMvleMYkC3xAhBb5FFDrJFVlCpelPWMgchmeoznWdwlX6anXL/V6EPoQnuQtVkEGoddG4SyNcvc3fLNjYHYiS51ajeYTDleGX9dkurO36oOPG2JjDuHR8BPSNQp0pO1matGXeZURJCHC+ghhF26+UHfO1cJGzkrEecq2KO4mpyLzyXmXyTRbehtRiGN38RD1qYr+GWJzI0PjZptS2vSms+9NPAZD2E02AGOmJA+CmhLaKq22qzBw7kM4Q898ArW3JSXxN6OG3f1AzX/XlwztypaQXD6LBhFcZ63koiTorqfcLdPrW3f0Xsa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SN0dCZt+mJbprqZCyeGXdLlsgPmGotJk04odvZuIM24=;
 b=ALGXbEmVpmeipZtz+CbOCyKZEkraym12oHnaPPG1R0b9H2DHEfk2XvLHnsv51lqgiFdwz5mxtso0oqccrbUfUy8aliIQ+4395aYCbBvMvNwMpYkDPymCx+BQfEfUfmGCHqeteFuwCtjdJ4M9GPHgfcvHZnIy2c+U3sLgr/KBB1lY7WlDXZOBAlseeD7EaVpbCrY1LWysSFAhm7E4lyuBTyUCF8LumNpkQTw0LRWrCp2exjJ/R+2UHm6/p7fagl2GzVEsJQEdgGjysYpbVHBOGZugBnMjRwlCrOk3eK75LdBQ9DAzENftLDsCVbKpwP4LwbrhRm4a31MyV3wH5IWYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 08:56:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 08:56:12 +0000
Date: Thu, 13 Mar 2025 08:56:07 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Thomas Monjalon
 <thomas@monjalon.net>, <dev@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Message-ID: <Z9Kdpwgbs9a5sE8n@bricha3-mobl1.ger.corp.intel.com>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
 <20250214172134.73908-2-stephen@networkplumber.org>
 <12279496.nUPlyArG6x@thomas> <20250312160225.2d90e78a@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FAF6@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FAF6@smartserver.smartshare.dk>
X-ClientProxiedBy: DB3PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:8:1::37)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fd82c4-acfe-4651-4914-08dd620ce7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?O2vNiY9a2S+u/ZX2VMgfWggBoc4mQG+lhDBxvkM8eXhFg7q9RXvtM7xxL0?=
 =?iso-8859-1?Q?An9YUk3Cj29PWbgsGW4UVUDoUFwAd+3C6NRxmlMreDrkNFTWC0M/RoEyoD?=
 =?iso-8859-1?Q?B+IIuFMSiqDmeo4UoA/lYYgUmL+HhBTUp3/wb5Mf4imhY/zJcOYXfoO5Re?=
 =?iso-8859-1?Q?XeEEOL//9ZsRDM6uTqmkmtpqc7pAjMQFTAmhwxWDQkjstfsqurHQbaoQeX?=
 =?iso-8859-1?Q?NE/kAN9K9yJgqoKWISsx1ycqGbv8mgK/6QSCcb6su44KcPTDdMG5paFuIQ?=
 =?iso-8859-1?Q?MbVcFUBr2OEmZHNys5wUex70h7eyWp/aa93aJbembrESYOxKWo2AULUUtw?=
 =?iso-8859-1?Q?HbRBc99ltooA7S/lZkZQ5fPYH6zotJEdoNt0DneCfxxyjuWzNpga5j+6Jv?=
 =?iso-8859-1?Q?d7y5vAXiSxQwqByxHUdLkGOPtYTNEpuWqW37c9Az2XpAr+E6Mj3yLwHE8N?=
 =?iso-8859-1?Q?YFZLYpxyRjOG0+A51UuCnfnK7nu4PJEycCLxaBK5JgQy1E+rmCIaVZZLCs?=
 =?iso-8859-1?Q?S6UmTukAQFxuRdi9Di5xqvLU24xoheokHXIpmtyv1KOSgFsIB9qe8UA/Q5?=
 =?iso-8859-1?Q?FjXEh1xDn/7TkFHSdvoTP6/RjIF4m049ZoD7y8Q596RyfFfAn20qv14ugn?=
 =?iso-8859-1?Q?KICXu1E6/t40o5dCIsLAqkVU0AG/Egx+eueE0cH666EvDmEutWOrwXV32L?=
 =?iso-8859-1?Q?rgGXGypAwMIzkOlHkxrVxTNWvuM8VhwmMjYhrfrYUFpfGxHfqNX909id5Y?=
 =?iso-8859-1?Q?st1OGZuPkTcZXpLHIWlbpPp4YGVRTnjcReKyWs1Amrd1SF446oH2GxPhxL?=
 =?iso-8859-1?Q?3nLr9jt2w669gpqUDzkszKkszkM3FLFjcY80tWOmSG6GNJAhHzZzEz/weA?=
 =?iso-8859-1?Q?vbcZn9I8wWyH++q8kW0HZp6ZvxC21CWEuEwu+Fn6YSaiYsTmT+08SIDBsJ?=
 =?iso-8859-1?Q?fdVYHpGtdrl1K1fe+OQpkN+MyQEGOeyu7wvou6dRYIaChmcwfPNSszzVIK?=
 =?iso-8859-1?Q?8IqPWcREH5WRUNN5PkTTzbZZsyLiGQ+2qA+KnGAbbTIVFPEjbkwK2AZR/K?=
 =?iso-8859-1?Q?gursX4snKJvxtCIHnTO7aq5pXOOJ6UzHlZxLV3Y3gse/0aeZHrIRtKFF9o?=
 =?iso-8859-1?Q?ss8UyfmFThu5jaHAq94MQCeII+gwote9dfA4DIwH/q70huSroLnC1sEghq?=
 =?iso-8859-1?Q?TT6Y3diFDtyw1m14CIPSF3II75e7Y/eTIyUX2PXpXLSQqo7SAqbzxJbQN8?=
 =?iso-8859-1?Q?Q6mOeGUx5jkj+DHBklmsZoi169i4KktXOGmqxuIpJRXaSm9dcB3tpuw8EW?=
 =?iso-8859-1?Q?6eSXd9jrIM1aJCjTkyCL5AHOqVh7DlfFoaH2GG15BcrCls+P5pflkhW4dq?=
 =?iso-8859-1?Q?d9CZvPN2P7tvb9PJP+YT5Q0OU/cMjKQRvJZZvwjYkM+i425c8FYHgtNeD3?=
 =?iso-8859-1?Q?N7F9baBBwmu2VQsQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?u91k+aVQ5wg5lFfADanDCr9JTKD+hWCQP1t+5DDifbGldXfs6FPt0F9gPa?=
 =?iso-8859-1?Q?Slh+h9YPTbFiW8ZcdVj+r3TnaM14dv4AeVJW17fQjTHgixDS2r7z2jNKEt?=
 =?iso-8859-1?Q?KUPFcR3ox62AbrsGEI2Bhe9pyjSJ2QuBs5UFJFX/e/nIIMMS9wKpmWaXnd?=
 =?iso-8859-1?Q?RC7VBOi8szl2RKj10gZ85XwvWVqVFabXjywFkPI+nF64JptvlHiHFQPUWH?=
 =?iso-8859-1?Q?H1y6Mjj0lB16S/JlpeT+6iXSZaAYzUSjC0Kixid8d0pYo3mQoyGJZaP2v+?=
 =?iso-8859-1?Q?R0knLhe9Xb1BFW9YjDhEN8ZhKt1CBXW2ovSKHwdckeDv4Im76ZJVd1VGJJ?=
 =?iso-8859-1?Q?n/d103zTwSMK2HIIgCkkaIhgdrMOKLXf6Q2A/68NZyP2/N6267DK5u7i5+?=
 =?iso-8859-1?Q?sYaUyiOS5OMU16w2xPZEjZRasV/kZY9BnU3TIM2Ko3JXzC2qTsOGAOUBIb?=
 =?iso-8859-1?Q?zR4wsLE0fETy08bmD/PPnpnUl+te8DtgIsg1Aj5ZYSzyjCl17NAB8N0VBN?=
 =?iso-8859-1?Q?Iyhz68MTAlnko5W3FJeIftnNXV74pCtU2F/8Y4UKG2YvQ00aZKKPaZcK5x?=
 =?iso-8859-1?Q?TL0nD7kr2DTyn9pnCA4bS8gtH3PFzfwT54KGx39UnSTx2+qwiIGhP+3EOq?=
 =?iso-8859-1?Q?TzEzs/1axgPp/kYbQQ96z319hq/LhF99ajBFjhDAsciKLogZQW3WRQXynU?=
 =?iso-8859-1?Q?3MPnjK1Mi6TIAkI3fS8xuSJIgw/i8CRDij668tjUmS3i1z+PFNdNybXu90?=
 =?iso-8859-1?Q?MAVdU4QKtsm0/BdSBCx7HQCoYLc5WfoowTtcH0ulHsJtNtCLj5LC80s+oE?=
 =?iso-8859-1?Q?SkVQ6rTmIzokz6bPNSXILfupF3He0IcBNf9Oeu2dW0GQO2G1zSNideXxgB?=
 =?iso-8859-1?Q?M/ouAj88DtJ+VwWsBgGIQSYaDOhwbjE8jIlQJW+Pb2zq0YMcmWu/rDhKUT?=
 =?iso-8859-1?Q?hKVR6jiA8HuKMXUgjF/s2Hvhdfw/qcw+lnPGhFwOpVuou2nWNTvu1JNLYY?=
 =?iso-8859-1?Q?24CsvirYvroqe8HMUgsqwod1A9fTHFMiKruq8SkCN53QMcp8KNYGAzMq1k?=
 =?iso-8859-1?Q?10/LPnSLAEegMM1bFppPvc/zLpMlsBVEuHSMNvZWPMB+wJ12aTXNGYLW2p?=
 =?iso-8859-1?Q?ZjX39+OrWIhK/nb0tzdn4sYWp3uzJb3ZaUTC6aTn/4LbjPh1bXFvzNdRL7?=
 =?iso-8859-1?Q?Hvn4P3+g9WVYcOZ0AjY9l8qQc+LrAZ4ciYnGWBqDYMJ2EuPPvOod1SsmLk?=
 =?iso-8859-1?Q?AvF9BmcRaMho4SCoEdHgkwn97gKFHXZHh8P0bbnPJ5ZPm5Ac6lHsbrVIgG?=
 =?iso-8859-1?Q?ROUmDp08tlHfAg53p4HdsFYJXcH1dmXtKm4jlJasIk9vPG7zUR7PVKQERG?=
 =?iso-8859-1?Q?Dm5oSIMtT1idut5H3+4s7IxTRuBzb6tbauY6aOWgb2c28mdwSvOixJ53yV?=
 =?iso-8859-1?Q?pMtfgK3ryjRsU+vAHXMMVTpdvK6Q9sZ79pt9hvO3o9BIOOoYneQ5ShOXiN?=
 =?iso-8859-1?Q?LeCZAd3aWdgP6XvdWm36aJAt+4XG+62Px4Ri0uuuCXEX3z7oo1m0I/c9kC?=
 =?iso-8859-1?Q?ZMrd05t1uAslXqIFa9cDw8dOV8VfWyuWraq0UGRypKfm36wtjRtm5+SdI5?=
 =?iso-8859-1?Q?efUTdCGX311Pyg9EFJ8eu+xSAehwKou1Jj89FaAt114ZTM5aJee8W40Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fd82c4-acfe-4651-4914-08dd620ce7ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 08:56:12.4453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJtp7T6UoaDKOAyxWolKr5LcNmLw3TjKqyj2AV7P8AgS9+U9FjaiEGY92shSIh3dbpfe5K37vpseCf9vqANjxy2V3k0gHhQfu2UbZnCHR0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
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

On Thu, Mar 13, 2025 at 09:00:09AM +0100, Morten Brørup wrote:
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Thursday, 13 March 2025 00.02
> > 
> > On Wed, 19 Feb 2025 15:55:17 +0100
> > Thomas Monjalon <thomas@monjalon.net> wrote:
> > 
> > > 14/02/2025 18:20, Stephen Hemminger:
> > > > The Linux version of sys/queue.h is frozen at an older version
> > > > and is missing the _SAFE macro variants. Several drivers started
> > > > introducing the own workarounds for this. Should be handled in EAL.
> > > >
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > >
> > > We may want to unify with lib/eal/windows/include/sys/queue.h
> > >
> > >
> > 
> > Not sure, we have several options here:
> >   1. Keep using Linux sys/queue.h and add enhancements in rte_queue.h
> >   2. Make rte_queue.h a copy of FreeBSD version of queue.h (that is
> > what Windows did)
> >   3. Use the bsd version of queue.h.
> >      On Debian/Ubuntu this in libbsd-dev package and referred to as
> > bsd/sys/queue.h
> > 
> > I chose #1 as simplest. But all of these could work. #3 means DPDK has
> > least new
> > code, but adds another dependency to the build.
> 
> +1 to #2:
> If Linux sys/queue.h is frozen, and is a subset of FreeBSD queue.h, #2 would consolidate all the queue macros in one file.
> That seems easier to navigate (for a developer/reviewer looking at the macro definitions/implementations) than including sys/queue.h, queue.h or lib/eal/windows/include/sys/queue.h depending on O/S, and then defining the missing macros in rte_queue.h.
> A comment at the top of the rte_queue.h file could mention that it is a copy of the FreeBSD queue.h file.
> 
> -1 to #3; it adds an unnecessary dependency.
> 
> > 
> > No matter what, should add to checkpatch to block any new files that
> > include sys/queue.h
> > directly.
> 
> +1 to this.
> 

I agree with Morten, #2 looks the best option to me too.
/Bruce
