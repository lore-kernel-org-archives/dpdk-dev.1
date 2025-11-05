Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6A6CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 16:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9573440678;
	Wed,  5 Nov 2025 17:42:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 735144021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 17:42:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762360974; x=1793896974;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=f0np1QDdawpkyoe4uhRxtPU8OkPFdarKeBhXiQ189f8=;
 b=JLrt9pnQYS7VRMcc4lZUk1LzV6A8uPn58gEJZMCAfCLyzLF2KUu9aGWi
 7fsb2jRwLZyj8fXdr9mA3RCjOGqJC+CZ2492r0m3D+VV7vSP7efnG0jsV
 ckUtoETSsi2kIatH3W14rG4SAJfAmBBMjrig4Gov6E6GzyGl2hGinR0ft
 e6fETzHluQzR9YybVi2LTRHQaKh6bYVJvmTzJNFntjF7vUfs+K+Jta9tx
 5cRfuCj1dRatbVe5WMm4a11U13zFRpz+uk8lck4j56yiy87rlqTl158oy
 Ar/CcWUsGvFTdO5fegl729MKYTsLX1m28W1Bpc3A6uUlOwYIohDdvrmuJ A==;
X-CSE-ConnectionGUID: Xha4Qp66RMmTXEOLSXtQ5A==
X-CSE-MsgGUID: NySowhisSRmwp/CUEpopNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="81885244"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="81885244"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 08:42:53 -0800
X-CSE-ConnectionGUID: U42uEw/NT425WOGdhx5tMw==
X-CSE-MsgGUID: SQHXLMvSTXKch20d9nI3vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="187199311"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 08:42:54 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 08:42:53 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 08:42:53 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 08:42:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtzVC0Y3uV9pKsK1AzRqA3ipVXcZl7cFJePZuagoUnpjiBzZo1EEjbSiw6Xo/sTYEidEUwylURzvGhTbDm9oaGdLXNKxrOdVXX3/6bJTnR6dMlOnGyu1c3t/1U8Wf3JY7tNd+zsaqRvvjbIpigzC5TVb0VUdO5KH40P+DJdhX9+WGaPvUyGAFxF9gJF1JAwkeyoDF0x8d19G5HQJfUbXpvxBPYT205FrlhE7B86t9U/9S4iMH5pDhA52fSYBrkjYtm7lUQtzqo0jwP1DjnaFuAHLC2wSN0/SM1Eef5//1Rxfu+OKgz/PBALjiLvZM039IYdfhyeE3JF3BSiIUQqo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVtKUhjpR0fSNz1EJyVB/dmjrUSh4QPUtQYmE4zG6gQ=;
 b=fKVQZtBZzlWZOFK428RSQ5e9CHkTr5RIzXox7xbSLP1HZ3DKVxHVZUevzWUtBSyqdA6AfwqDIWGj57Y/bVruQql51UrvysiheIqdx2SrTpmFCF6O2iRkBXY7CcS4a4RHjtc7xwPaEj/96t5e5dPCW4AZ8xa5wivwwODcMtB8y6oBrHxkbDHkjj4aLStWsUx6m3Bowjzl69EYKjo5JZHJJhGXkxyk9/gqtN48C/u/HzUBKJGXyNAUSKfH0L7mWNDfhFZDB9SzhVA16zOahoR5M6Tx3Zq0NdPRVh1UPwK5M2D3GmWGHzBeUH4m06etMUlrvdyuMol8EO6DZH5G6bv+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF37A184CA6.namprd11.prod.outlook.com (2603:10b6:518:1::d15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 16:42:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 16:42:50 +0000
Date: Wed, 5 Nov 2025 16:42:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [PATCH] doc: update FreeBSD python version
Message-ID: <aQt-hNN9Zkdr-BjE@bricha3-mobl1.ger.corp.intel.com>
References: <20251103193038.135022-1-stephen@networkplumber.org>
 <aQkJMHX6NWmZcJEd@bricha3-mobl1.ger.corp.intel.com>
 <2829936.sGnKIMrFRI@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2829936.sGnKIMrFRI@thomas>
X-ClientProxiedBy: DU2PR04CA0218.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF37A184CA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f7a7a9-af62-403d-67ed-08de1c8a5bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AW0RRDlZK4z5wQts8KEP8aa7pFIibUSPxB15g8rg0+xZ95iwTIu5zm5xkdyw?=
 =?us-ascii?Q?pyI16Kjto9Z7rpXRzqgk9DgvGxlwZMDfsYqO/eorgbdUXKHK4HDqIQqy1Hpw?=
 =?us-ascii?Q?N6hGuRF8HBQhjRSFNQJobTG/9C7rxyU7eAOc/oBGUAJ1W5i3zKv1g5wTxQt0?=
 =?us-ascii?Q?KhgEX+t9fve5A0kTfj/FNn/l8CFGhFJLt6DDfX9t5QqLC7GMN+GinfIwzi5/?=
 =?us-ascii?Q?rkcm2z/2upxyUr0bDaDHXcgjt6luDzs3gzM+VX4L2Ap8IAboPrIvd9UFeS1o?=
 =?us-ascii?Q?MzaSybRqbibGyMUIg8Qoagzwglm987sHnK8bNj/1XTZ/6OTl2DpCIoceSi0g?=
 =?us-ascii?Q?lOiIOs5XFytb0W4H2djhzAcamS4uPumnZFN2UVY8neke5bOPiVd0lWkTOPbZ?=
 =?us-ascii?Q?7h4WE17XZyRiLSkT2Jqf3oRs4Eg/a1tIdPkigeHvUYFFfo+EV8ymrnh2Loyi?=
 =?us-ascii?Q?pcpyutHWJf/eOFGgY5bDeNafWX8dc6BZO1Jy1s5IcTECm+2ApRj5CSuH9swT?=
 =?us-ascii?Q?rnioHe3BEZfQlWT6FB/T/tO6+VaIreIbqQHaLdPp1cvMeq+TY2ZmCfupQ6iX?=
 =?us-ascii?Q?I6T0kY+1U2aTgF/xza03y3dDlxm03Zm3m4CwP6BirndbhjoHon3AEuy2w0Gq?=
 =?us-ascii?Q?3noNZ/7LgNPjoXEcTQ877JaAMZUIE8E37x1rVJeJ+qm6gI5Edgife5g2GB71?=
 =?us-ascii?Q?LLCh3UBQgyF68xoLB/A6doytahu5NL6kvIiKGmRkxOpQ7yZxPkDqZ6m2+v85?=
 =?us-ascii?Q?RgBL9fIjHcEg32t+GeYFxwWaeM7zcCINyXf8K40Uo9oDjZ2swuXUvwz5tpZ0?=
 =?us-ascii?Q?QC7rp27KsgqHigR66ECfDp9COYleq49QedVsLZEM46CdubeIjnqbpAtV8bxk?=
 =?us-ascii?Q?5jMcXf8jrQsXA4XwRLdkhUKZS6Nm5WrpURH1ubUoshYI8dhzN3rTG/Eh/AYW?=
 =?us-ascii?Q?2C4nYO2MS5Twh5240/qwOcjzFbkQxni5Mc08O1cTre7iOe15fq6/1mqahgk3?=
 =?us-ascii?Q?AWE3sOp0GJazn064D3ABURMmWV1S7W7/o1Q8Qhp1ZX6tWtkTIyA0j+qzKGAz?=
 =?us-ascii?Q?cG/0gBZHmnMpt7+78yNnpwanQRrY0EM1tBXGru2UcDYYyKLUVFPQBR9VzsbU?=
 =?us-ascii?Q?p8W2dQVWDnh7CB2o8Atl9f46aq1ut9ERMMHwDQEbrosvtr0hCeEUuSwTXA9n?=
 =?us-ascii?Q?14ICLJRIyC3SPk1q8pBkNRQ7EUCQaiYFHwvcUZKsoMWlhIHR2IZoZL857t/u?=
 =?us-ascii?Q?bbmGVnJyed/rLKgaHD505K4/nTaa46D/hN+TlLt0yKTJue++ImYWTDLXxrs+?=
 =?us-ascii?Q?tD1NGAYzE3ygbLcNdCZN4oi96boRSIQcrjo23gnXGEzWNV3gHRJF80m9yVj+?=
 =?us-ascii?Q?hb6bcbtmBxZWyQbn0yqq8pb23BpBVUM+Rvrj3+hjE9LqcFHwm7uNOriNJDkT?=
 =?us-ascii?Q?gCdTGXn49kZu1ZLnfUQMP5g+lz5722uo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ONHSjB88OIRY9sECfXUBLMwfZRqGl5kpulzMzbKQ+Go1bN9K2remtvBXpPFq?=
 =?us-ascii?Q?59wl4egv8G5qazSsBib88SfnXC+pjBqH8WVZX5LHAmnqLeN3G7/2enYfikGD?=
 =?us-ascii?Q?KvQUkFE8g7pc3VBSkFUu7UdmvLuYs/pzQmOdTLrZTEc8BrkpeT4dprj3Zzxm?=
 =?us-ascii?Q?xOG2xiqeMqnm4V6M5vySY1WWKq+kGvy6tqCcZPy+C3cER9RGUNwY/17fpQER?=
 =?us-ascii?Q?SaaezQPatelAOtpY0vD7beh4dUgNDFm35MFjIKBjSlHNPKi6GpltQ6fIbjb9?=
 =?us-ascii?Q?wHo84KehC//DSU0//QXwHqhZ+xLCstEzlwcZomYox1jVpCyMC+0+YatZzohu?=
 =?us-ascii?Q?hMtBXfrJM/8pg40ykEhzfz4NYuMblCsyiOGZPvyTG1+0g+8T/KTV7BLFk8lE?=
 =?us-ascii?Q?kolD2VBlMcqpDh8xLV/S+fHCIRfGenUaYNFXw9w5iOrzPLAmJWz9eYvJT/ls?=
 =?us-ascii?Q?+xXFcw5pT4wJKQxxo7wMMJupsJuqmr7PE9oit2+Qth9VwSR8THSCFNDm6MUI?=
 =?us-ascii?Q?wqE11Pt+F+7/SrdT6zSmt48QPW4/UgyrH1p5gqDgLnUVNgmGHAhlLBiR7pts?=
 =?us-ascii?Q?ltMOfEJKy9dIcksg8muQRzwswGM3hYXPYWP55l5QHPx2Q3/PyLzsW1+V/A56?=
 =?us-ascii?Q?pQF4DFfx8XuxcKWABU/bXyqGjGOYa74pyUit5QZAl/0f9mJXmL4XtuCIV1va?=
 =?us-ascii?Q?KtmXYNfkcJaUzPW2F7MqXCUH9O0bvBk8zKpBOcYUuj1vBC3B1BZZgwHl9H0K?=
 =?us-ascii?Q?8dxsNX5M6zBBx/nZFYdaEboch7fWqcCVpn/ckjYoy2j8w8/URa2k3uBwn3Aj?=
 =?us-ascii?Q?+tQeJ17W2swgduYyEVz6EW+gdFCvZVbLscFosfwh0evJfHJNqVi+/MLUTn+b?=
 =?us-ascii?Q?b71JpURGdL9p0w+jB544MISwubXX7QIn+Bx52ZUmQG/hDvum1CwO7Ec+44NS?=
 =?us-ascii?Q?pztPZ/HGpqOfK2gK+2BPbPv2sBmgpLmHPqgO3AOGNZnoO05ptL+2ycojKEkA?=
 =?us-ascii?Q?G4eGZaR+RpwsyFfMUlKOmVFChgFe/6vwjlV60c+VEUSUlRVO+AlJaAZQhRM8?=
 =?us-ascii?Q?ddrzv/3yPNVgkJm1rIWaYPe6ew8JIediMjomaJdwGtGGjySnnR5GbACQRYcc?=
 =?us-ascii?Q?OxShh2lJzvNQpKWkGJmwfhgCw+zEPCmRWaQjKWob5fwLfdO75Eh93n4i5ull?=
 =?us-ascii?Q?s4QbX5hzqxWmfghAVzUaNAmxb/RPqO0WJXR33cLBqSleXsLo886LEsSpX3d5?=
 =?us-ascii?Q?IU+BoMkfn0NxQXrcpotc7aH9TeyCCsczjrPM0XJRyGDQKoL7Nmf4EzUMdrLj?=
 =?us-ascii?Q?8cdnxG5V7otuGHtVrUi1RVxIqji+V93HAS8fOwEB0YEIK8/7c+XfitaajTFs?=
 =?us-ascii?Q?u5TxPtljl9ACaUyDyopxTpxsa4OYpTYl7Zj309z+JwBZAEbLwZ7oRjrQe+DG?=
 =?us-ascii?Q?IhsLb+7V+RHH4LdDn6UH1eu2QSGS5ZE5AtKKOoFiUkdlHkApbklfZZ90sc2G?=
 =?us-ascii?Q?NhhN6/gKMG/3uk7Wr8rsA2TXdmi4qbEiFxs0tl+ShFudNhg4+2dK3d4wbEae?=
 =?us-ascii?Q?O+4AGuxyseyFHoxdj1+vd4szM5d58gvdGxNKM2b7j8abGeuPU1bcsk3NeUm2?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f7a7a9-af62-403d-67ed-08de1c8a5bc8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:42:50.7009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgCUXaAdGjdSxGWptddWyRJnkkaeGpfFHnohKXeOR+pKeAI4iIWkwlf2D076dWyr8vGyMGtf7Pz1eJrTB7XfT028z0X4e6vgDl7KTLaTV6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF37A184CA6
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

On Wed, Nov 05, 2025 at 04:13:39PM +0100, Thomas Monjalon wrote:
> 03/11/2025 20:57, Bruce Richardson:
> > On Mon, Nov 03, 2025 at 11:30:38AM -0800, Stephen Hemminger wrote:
> > > The version python used in current FreeBSD stable release 14.3
> > > is now 3.11. Update documentation accordingly.
> > > 
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > ---
> > >  doc/guides/freebsd_gsg/build_dpdk.rst | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
> > > index f98292bf41..c8b2964a4b 100644
> > > --- a/doc/guides/freebsd_gsg/build_dpdk.rst
> > > +++ b/doc/guides/freebsd_gsg/build_dpdk.rst
> > > @@ -16,16 +16,16 @@ The following FreeBSD packages are required to build DPDK:
> > >  * meson
> > >  * ninja
> > >  * pkgconf
> > > -* py38-pyelftools
> > > +* py311-pyelftools
> > >  
> > >  .. note:
> > >  
> > >    The specific package for pyelftools is dependent on the version of python in use,
> > > -  Python 3.8 being the version at type of writing, hence the ``py38`` prefix.
> > > +  Python 3.11 being the version at type of writing, hence the ``py311`` prefix.
> > >  
> > >  These can be installed using (as root)::
> > >  
> > > -  pkg install meson pkgconf py38-pyelftools
> > > +  pkg install meson pkgconf py311-pyelftools
> > >  
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > I always find the python version included in the packages annoying, but I
> > don't think there is anything we can do about this. Thanks for the update.
> 
> Do we really want to update the doc after each upgrade?
> This version is not the truth, it depends on which FreeBSD version is installed.
> 
Python comes from the ports collection, not the base system, so it's
independent of the BSD version. Therefore the commands here should work on
all supported BSD versions.

/Bruce
