Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE39CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 10:31:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEC49402E7;
	Thu, 25 Sep 2025 12:31:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 2E740402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 12:31:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758796269; x=1790332269;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bgu3yVaNycA5OPSQOqxUo1AFZfuaLBykHPqhkePbLPM=;
 b=QBA5Ek+jS3QtwoIRBZ5AkNhS1puaMeRTgRogJvebPHNQWV5IRM7sVqNU
 PFC+aCR+IhjknIOLcKN3za4XTOyQVFO2psLf0RGgjSTS0Sv8gCr4ShRUi
 SWnEW2CXUmiIDcLillcx+GnMVuYLjOX4ENc3Gg5pyAEcTeRS1irx5jjiw
 gb5v/uAAmJxfbI9AlL1XZjKEzrliGPMraaRJIb8+El+QU/AXCLK2uikVr
 XBaT7zpv18YqutTw2BnbabLhsMVQDPRf2/tCzkWzuFCvfwSEMj4uir4Ns
 9rKP9T0ZL3qqVgYgqQ44M/SKcLtbwtdtg8nV5GO5umhU1PDhGM5hEPMMy A==;
X-CSE-ConnectionGUID: wFM8OXcEQQ62v/sb0qoFkw==
X-CSE-MsgGUID: Sks5L5ahT02jG2gFpVjUTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="86554781"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="86554781"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 03:31:08 -0700
X-CSE-ConnectionGUID: keAHO91sQium8+vc5/dOlA==
X-CSE-MsgGUID: gIAkPJR1QjOJk4uNcVRZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="181301862"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 03:31:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 03:31:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 03:31:07 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 03:31:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnI8Qzqhpp8Ox1hllbcNWykfvuGgsoVYjxIWVlmduzCWG6pFLkBZIkikxnMhgvEgj4aGg+m4y+CE1qYwlgtxkWxISq5kcNcIQqkew90PJXmu/ja6g8T8qT1Irv5aoz5ipo8bAlE6JC8qPU/UU5cwlEo+4zk7Ju0VjhRSobAu6xihDpMVHObo4Iz4qw7g+FAyqYTIQvAYnX7wDeLuqJYKrl5s/M8Qy95IJHUAdXJD3IJ1hsDMUu9LIxCO+eb6DqVZr7EaUIxMSCcRNGS9X/PHpN3Ra/OkLOob5f/cBzcK49RXEL/WBtYbWrQuq98tfkfo4am88M2xWNa0nu1FQlWMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJy2QviXfav/LRdHXaX83UVGA+XWg3Q4hsPdWtK+A3g=;
 b=Hb3TO4ET+o/G9U83CmoxcGR9FUWxT7O4Uv1hvVcyiK8ONPWuvwEhY7POa/K+4PRf4ye14SLGNQ7pb2tawFG+yg3NPxZtj9ZlPoWJKFFDFxphtik6ub3nT60ARNbJHxxfOq84atTesNDgDRaJx1vYU+uWAhcAK+EmB1Mb5uGOuYMAXRvHG4sNGYDAveL/x0rcfyN/VrNx9gP2IAAn2MUXVLbgqLWERdO/kqbf2h3RO/vmsz3c5M7G4gLQeyGqTObPKFUhUoqslWTw3skp9AuX8+L0CJU5ux/rrZqiGn0VRb0l0YfwQ1L+wN3nSOnh6+XGGMnXBS8frv4+7ptP15QUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.23; Thu, 25 Sep
 2025 10:31:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 10:31:05 +0000
Date: Thu, 25 Sep 2025 11:31:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNUZ5EATVthRDXb-@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
 <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
 <aNUJ3yFwNVpZdGzk@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8xY74d7-W1AGxYAKGAgcX4Lwd5KDaX493kkjPLZ-TOXZA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8xY74d7-W1AGxYAKGAgcX4Lwd5KDaX493kkjPLZ-TOXZA@mail.gmail.com>
X-ClientProxiedBy: DB8PR06CA0061.eurprd06.prod.outlook.com
 (2603:10a6:10:120::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b4269a-3e18-4fd2-1942-08ddfc1ea219
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vrm24/S6hqtEc7VdzVbvYCq/7QLd+D8DXPLr9fUqGQyguV6pKf59lh5dOQWR?=
 =?us-ascii?Q?xhCdp8pVKZYtVBYtKlaskNVv44HnJfPGxz+GP0X72alhwt9rs/U0ETnGZT2J?=
 =?us-ascii?Q?pntBgi7AqmQGXD9nFAbvvOnondeftgYhO1bZd4XXilIUbEHpikwsgAPkABDq?=
 =?us-ascii?Q?d/Aef658kv7cnFywZwse0F7UDfCGRlIiKg+yAd2pvIOHCDHKY2FowNhUrXO2?=
 =?us-ascii?Q?MoWOFFY+PJ5fQWVZXFkKgJ8dm1WsC4Cr8jDzUDDNy+pKeTzSnoH+hWKpeBla?=
 =?us-ascii?Q?ebbXUAJj0alhTZK3Kjb3NMMI92OQxQg7Wl91CPDiicPCT6akBGz5CpIZjqWJ?=
 =?us-ascii?Q?KxaZvNU7pxhgau0UWAbdVNCkQS6Y3fXUloOWxnI/bPNHw5J782jCnYVYv9O6?=
 =?us-ascii?Q?8rTdecJn5ENGXADT+scM9js8ACqt6gq23Cx8716rB0YeZF9Xln0DVlFfSD+s?=
 =?us-ascii?Q?gqji7QLtKn+4MPGESBhrqKfQTd3KZ5UFyIZtj1KSbbb5OuRFdm3nVzbxGlAR?=
 =?us-ascii?Q?CdbqOeKM1AhY3rsOwf1/fxgt0NMUb9yWQ5jCb5fFHQ9PGdwGwrIgvRKeYqJr?=
 =?us-ascii?Q?nX5dxkUE8r9CJFEYZHOeqWryMr1+DiI2lTBsbmF0NqhHkJEXBm74VKCNc2ee?=
 =?us-ascii?Q?I24OgWEQlA3N99w8TvpBGELDy57MAgl/BdYIXi7uC5RmYT/YnzbX9EhsFzn9?=
 =?us-ascii?Q?87Ylz/4FbiV6VFbNRBBi/arj0X0Ct4C6PyPyDD2xJpxJCs8x1GYdzOpvqMNj?=
 =?us-ascii?Q?Au9ZxmDdOkPZu/RvX98Am1L2+rcM+kYdB0jnfsZQ3+gebiMVA67IYKl/I9ew?=
 =?us-ascii?Q?IA5uJ8/palEJMX/86hZo23dEj9jYW2NFAMdpoXZk6iOhZCYd38PhInWAidyq?=
 =?us-ascii?Q?hLyUIKDC+0Jx0HSDbDomgU3phhdkQIAVkwip1uhdwvYbah3kyRyb4QHJVvTO?=
 =?us-ascii?Q?u/HmN6TzR7lA/0YU9kRJIcJlqZmp70BNdQT0sE4JDUC0wIdR82qECfArPxLM?=
 =?us-ascii?Q?oAol9g/pyzy8vRX/hBTrduxFBNj6Ak4vYUr8ol9+Zt0uwVAqj8+vO79FXMCM?=
 =?us-ascii?Q?H8DHrR92kzY6Txr8101TxbBbFkxdP+tB54b1YbzSSFQaFBxk82NxT9uyiW6X?=
 =?us-ascii?Q?OXl6ldNDflejTnkk07IdhU4dOqfuOLAxeagz9tRqqvUeTn/h213ggcKv9GYS?=
 =?us-ascii?Q?UOq2jrKZ8+Xb5aobJAea7sESZVKgQ9LUaUsAydakvyV8zQ6zOPgSazJI0u2u?=
 =?us-ascii?Q?bYfkHx4dHnaVSqVOolwpLdVltMqB8IY9T1OeVoKnhI21NUY2aFIsMCcukdul?=
 =?us-ascii?Q?FikPa48JJbdRgWf/gEHH847/rlikPorGSzDqgZiz5J/ymOk0YxLNAtN4m3RR?=
 =?us-ascii?Q?6cKK5I1OZTemxytVQfg4pHQMvg35AOJjp34dl84NUh/ryv3nM4g3VGMnMatb?=
 =?us-ascii?Q?M/053yr6t6g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9dnG5/IS/TlN8dbdiKSf684TtXMiLrUHnjNNMA1tfTZMzyL4AlK50fOCqiz?=
 =?us-ascii?Q?gu9LbM33gr1dC0AddoorrlFeLN3EL0yqp6AQtE/io5etPVNACWqE+ZXYWe/l?=
 =?us-ascii?Q?cepTZZs4dxaU4dX5mMEoXv7tfWR9BZ5FQAb5U9OMVOj3GYtyGzUGDVkgfpU+?=
 =?us-ascii?Q?KFuibkwhQYd8zZcJn/09qbQ9Aju7Gxonh/avW17Ocz+eYxc4YmNHEuxBYwaq?=
 =?us-ascii?Q?H5FayBXavrTZ5u2JRHt5vH5MP2TaD6NnX9M5qP8X4Xo10WLvoDB5804BFL30?=
 =?us-ascii?Q?ulgPM4ouyzOuTrC1bEDRltogtNc8EmbX8UN25DRyhVAoTrKe58cL0ogwNywt?=
 =?us-ascii?Q?08c6Z8orMMOHnrxEQ94Ax/8dNJV66G+A82dagQRop0BGOljNi1rxvrNRobja?=
 =?us-ascii?Q?xO79i3UxV9t9WrDKXMDUrPdQ03wzX9V1vohaouuwKvSn6NaKDl9i/9DevX6H?=
 =?us-ascii?Q?f+3RTLGQRg4ElKuy4QRNZdolxv1Y4GZHpUkb4Klm8FKXZ/JI0YwcIx2lQshH?=
 =?us-ascii?Q?sPy2aLp2lMzizZrz1jhUMVhAQFzWOYL1aSkcjIcSHHxUnEcR/nbKKef/XVSN?=
 =?us-ascii?Q?KtLB/Qq02Y5ikYgJCHZLfFCPF2UPo5kM0oiESOHxkwH2vOIj9xXNsoJ1HIOc?=
 =?us-ascii?Q?WGmvHWjZ+7ArIwUy2Vs7jRXcybryFNdKEIR5D/2/tqyITvDROHqHUhn/MzQq?=
 =?us-ascii?Q?Xt/aeo4jpChRR2FLwLgwPc56iHLRd9q5Y+NPWM4ZHQTpLiFs9lE+HCBG7Xof?=
 =?us-ascii?Q?WTL4zcw64ZvIKHheeUBr9ubtmiBlvuneysHu4a96Oj082mQLzoeU/AA8LH0u?=
 =?us-ascii?Q?SMdlbSii4v4cmAIEAmUHZ0nLItIn61y13ysuvuvSoXgGWprg88t111zrOB0t?=
 =?us-ascii?Q?wlGCtJ6wP4CP56SfS6+kjyTQiu8IgCIMwMO7uzzNf0kHhKI/tPROe7PpCvKo?=
 =?us-ascii?Q?PPMJHlBIsoWPrFqHf9iWR0PX9Xxsn2SnuXwgF69i+dZOzDLSPQIwHeIL/kAc?=
 =?us-ascii?Q?ZwH5iovqn+Q/n/wosWo9AuWrUaZGnQPvdNcFVgYIHgBUY0x9pxq3wSRJl81U?=
 =?us-ascii?Q?hZ9zQLogn+KYwyiHgRnl1cFqW1QZVQ/b1nPnWFigeaaUBMR3P52RKEaBbHVb?=
 =?us-ascii?Q?5W5o4JqM7Ws9TEA7ZUP/iygGVt/FVJ9nDAFVDww7gpUGDAh+B3gYZ0nGG/xB?=
 =?us-ascii?Q?Nmqy1FXoOEGjR100tyJKbqemesjW8VoE6eAtN30fgvnAdh6B+abSWsEe/SBI?=
 =?us-ascii?Q?G1Mh7USfacaKY+PyrF5sub1UOgtLSKbJEUULJcvLOQ9DWc6x/T3qh08ESx4H?=
 =?us-ascii?Q?BckxHqYXe0n3lBvJ6GWyfXOsh7gbJmNHEuN3OUDvZPlsVzsyBxZWhURugSRL?=
 =?us-ascii?Q?WtO/VrDD9J7YZ7b4kdRy/b99jwHzkkJ3SC6dJxLSL5Hu7jqnJcnMsPcPRDxl?=
 =?us-ascii?Q?6I1bwSs7HIGRAghzoDDVmdDgYr9OtuCPIIMCSpQ3jwtH5OlSm1uWwN1WGd6C?=
 =?us-ascii?Q?pvw6M//aGSlPOfwf+Otn+a1Jie9cgVDWq3nipexXQ9J8UA0VycLNVPdp21mZ?=
 =?us-ascii?Q?yHySIgHp7CTkLMQgs6Kdt9L0WSnYj2z1cWGWMspF/G2EpYL79So81rnFSadf?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b4269a-3e18-4fd2-1942-08ddfc1ea219
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 10:31:05.7336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQ7XgSEI3xegbWDdutkmcB1BBhFiZhI6m8A+ZNEuXAEcIGosfr7y/+4k4r8CyFpiQo/ojfuKeDY06xOuXRl/XSiSy1hL4c8B+mfz/RkRnbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
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

On Thu, Sep 25, 2025 at 12:29:08PM +0200, David Marchand wrote:
> On Thu, 25 Sept 2025 at 11:22, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 10:42:47AM +0200, David Marchand wrote:
> > > Hello Bruce,
> > >
> > > On Thu, 25 Sept 2025 at 10:00, Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > On Wed, Sep 24, 2025 at 07:25:34PM +0200, David Marchand wrote:
> > > > > A problem with the current headers check is that it relies on meson
> > > > > dependencies objects that come with their include_directories
> > > > > directives, and all of those point at the library / driver sources.
> > > > >
> > > > > This means that we won't detect a public header including a private
> > > > > (as in, not exported) header, or a driver only header.
> > > > >
> > > > > To address this issue, a staging directory is added and every header
> > > > > is copied to it.
> > > > >
> > > > > Drivers and library headers are staged to two different directories
> > > > > and the check is updated accordingly.
> > > > >
> > > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > >
> > > > In general looks ok to me.  One small comment though - can we not have
> > > > "staging" as a top-level directory, but instead hide it inside the
> > > > buildtools directory, or even the chkincs directory? I dislike having
> > > > too many subdirectories directly off the root of the project,
> > > > especially ones purely for internal tooling.
> > >
> > > Well, at first I was trying to change the whole build process iow rely
> > > only on the staging directory and remove all the include_directories:
> > > directives from the declare_dependency() objects.  Libraries and apps
> > > were ok, but there were a *lot* of complications with drivers (what a
> > > *huge mess*, especially for NXP drivers with "compat.h" includes, and
> > > Marvell drivers to a smaller extent).  I may retry in the future with
> > > some AI tool that will brute force this :-).
> > >
> > One note of caution here: if doing this, you may want to consider using
> > run_command rather than a custom_target to copy the headers in order to
> > avoid potentially slowing down the build.
> >
> > We used to do this copying of header files in the old make build system,
> > and one downside of it is that it means that the build of ".c" files in one
> > directory cannot be started until the copying of headers from the dependent
> > components are completed. The decision to use the include paths in the
> > dependency objects rather than copying the headers to a central location
> > was a deliberate decision when moving build system because it means that
> > when you run "ninja", every single .c file can be compiled to a .o file
> > in parallel, because all dependent headers are available at their original
> > locations. For most components, it's only the final link stage that has any
> > dependencies, the compile commands are all independent.
> >
> > On the other hand, using run_command is not necessarily a good solution
> > either, because it means that all changes to the headers require a re-run
> > of meson, which will also be slower because of all the copying. :-(
> >
> > Therefore, I'd tend towards keeping things as they are here, in order to
> > minimise reconfiguration and build times.
> 
> I am sticking to the headers check update atm.
> The slow down should only concern developers using check_includes,
> once I properly gate those deps to the meson option.
> 
> Is it still a concern for you?
> 
No, no concerns about copying the headers over for check_includes checks,
that makes sense. I'm just flagging a potential issue if you want to switch
back to the old model of copying the headers as part of a normal build.

/Bruce
