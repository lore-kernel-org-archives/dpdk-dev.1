Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D5C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 15:07:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE98442EAD;
	Tue, 10 Jun 2025 17:07:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id D0FDD40672
 for <dev@dpdk.org>; Tue, 10 Jun 2025 17:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749568028; x=1781104028;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9rEI6BCNefSb5A+AtPh6PjdkwDaTI2wu2NCxoohZIyg=;
 b=UC9nk/ZKbdIM+QarwrUcgLOwluu2dDARpJyKUSG5yOr14WlnJq/xhe37
 l4kMxtD0zEBbJmLx+C3OQOun+i+/aleCKpX9wLwcPynwXlb8pvZdLvxfO
 H0GJwLvPEQOWD4T/3fOgGTq6c+CmzPLl1m2OMexJmxwcZ8eyaFjo/UsY/
 k6R142vvFQF9LWymOptPxMludsqmePMgovccXNYqEbhYKAkrULJv1bS2u
 moWHdiWAQnP4dQtHHsigX8NK3wQKXfoVuPlFr2swVLdsroeqU6TCbsyIo
 Alpa3ncpKqB3hmNKT5DmwQpzYFjyOibZNTWU8EkerzeeOpVsxDbq0CJ7X w==;
X-CSE-ConnectionGUID: O78DlYk+QDGx0qJ7NbryHA==
X-CSE-MsgGUID: 6Oc44ijiSvSZYfbC1u0aQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55476543"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="55476543"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 08:06:57 -0700
X-CSE-ConnectionGUID: ykbCU81LRliWxQkWcrWBaQ==
X-CSE-MsgGUID: EhDAr194RsSeyBZY1/kabw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="177808857"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 08:06:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 08:06:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 08:06:54 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.56) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 08:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJUtcnvr1Yntm+JDdRo46m0vYz8nO45tXHXHKICtwlrsFoMmXEEEz8gy21ANi1ecy7JjxEYbtCdh7MJGxuo6k+5abGkPOui3C5iNp4GXuSUq591Ujb9j98sN6Nz/Ow6BQ4SIFGVTp0VeTxEXnxSnIwLoI+31AE9iRdVplT1aDWa9PjsbmQM+BuKeOWZz24zncofCRjEHCw1dFm4shopMd1W1Ms5KWN6aHGVdncujeIakQLIRt9mMHrFPv0J0SQfIuiASD5Kl3vJYup1c/dX4XnY+lJjPK2Mla8sTVASWl93b1h+Sc+MgysPWwglZvqgu3BCPWefBhgIFBI5f6HehDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HilBeAn7OIpNqWYbIkn0qqlIySTDAWTnRJzW55iMZAg=;
 b=fJz33y4L6blX+zyIFyReWw5iOlL5NLs85EGsDa8aus3o5SX0b65nPRbs7tC7hevJylSBtpHFYMopMOz8lHiTk+Q+psd0ju8CTpeqi6/mm1U3F8hHZQcHl0Wp4++pacPNu2MLvMw3tpV2DrxGvKJjFZjIP3UPiwUCfvdZ/0rfn24Gy9C+GPhmgh6n5GNFDOrxONW7CA3ZrQ/UCrsgrUUnSIBqOngshPDL6UmTmcuyTt2Vn3ew+KhFTXwcQzQvCMYbHlyxBTtnfCObP67ERHpFea7nzbxxomEDzcH02PViYyKxq7cu5lGsw4mWBJxfKqf9gaZT39yGKX3wXKLHr8swnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4727.namprd11.prod.outlook.com (2603:10b6:208:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 15:06:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Tue, 10 Jun 2025
 15:06:44 +0000
Date: Tue, 10 Jun 2025 16:06:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Song, Keesang" <Keesang.Song@amd.com>
Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
Message-ID: <aEhJ_7lkI2wptnXL@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
 <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB85969B5D596151F83DA09600826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEbSNr7iv7oNJ7_U@bricha3-mobl1.ger.corp.intel.com>
 <aEbUQNFZHhKFKGeB@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB8596ADB9B5BC7947CF6AC43C826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEhA3YgjW9SsMfYE@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB85968037EC67A1CDD36F336B826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB85968037EC67A1CDD36F336B826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: 159736e8-52d7-4a7a-5649-08dda83069a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pVrWGE/kGY1B0YDVkaoibg24cQVbRxvC8uRdLfHAfMcF1OpKTJM2XAppEt8f?=
 =?us-ascii?Q?9odcZjnSQV4nhlr9IIgPN8+ONo6B+GOXFd+CBHsMmWtao0M1VCclG00PM77d?=
 =?us-ascii?Q?Tv5P2pxh2fhIGMZC7spfuHZrUbIg8i0PZUN9+dxDH6S2DPiNXxVDrynhkUV5?=
 =?us-ascii?Q?kfzcFHaLTBR/97XS6j1NVNf+P224ZWewPktm8DQb8POZPufc8YdGHGAXv8vy?=
 =?us-ascii?Q?q+aDWux/A3gwPqUfx8tOlCEkn6YFMAKJKV/SkMl1BKLSuSJPuM8cbD8xnpON?=
 =?us-ascii?Q?RI2UuaYVfw0ha8dGkdC1wT9bdn5pXsoGBq8YK/kfvxB225X2ig2VGFoezR89?=
 =?us-ascii?Q?QVuibvZwkB5TElXbljxk7ASv1lC8PWcQCnjq+1w6Lks0vruGzVYPF0GaObSX?=
 =?us-ascii?Q?eaurx0qmug6acDLL9LhR6mhFDr0nBEgA9u8ndLGcwOBgcUik1Zx77TFoIO9W?=
 =?us-ascii?Q?ZNcGVcPsTBaeQD/qJ0W60ub3oZSWCMKJA7+1aOjMkIFWD9bUbD1oNwl0c2nr?=
 =?us-ascii?Q?qaSOPZhd7EFkBpjiYief/3jy1izTZZQnM0BNMpZ2I2xwXPpQLLQ6LynFaCho?=
 =?us-ascii?Q?5r0HsfLoKAL2moy+ydy4x8jxmImRD0YJJNckD+i9O1bYN0uO0WOPEZigXXPa?=
 =?us-ascii?Q?rqCP+A+rcG6hvzX1JLDkK9KVDV3EHPFewavP680GDCB+D9nnYCNSZh/yrJ9c?=
 =?us-ascii?Q?Ss6ZKmGkI0RX2vOQ6b+/Kal/tisa3nhYDSExS9s9d71imhi1jXJ0lz6UMQT8?=
 =?us-ascii?Q?1CExq+ADWlt6CSjqHsVcJ83Pfr2r+Fb/0t0g0bcveDlTYY9/BW455F/X9iov?=
 =?us-ascii?Q?XWx8YNQOAkpGinVW9GIooxPJqbvE1kzd+shdB0Xd/udBbit0xaGz5IOqUnI5?=
 =?us-ascii?Q?3S8B4z5WuHrT0lN1xgliCw1tvttIAMpoan/Y7DrD5Bx4dERD5aBo3prKVZZz?=
 =?us-ascii?Q?f46a0BYUJzij121uwxvey0Wbzokgo9sjxCgUy6D9Z76CZmbIOTGZ/d0VImDG?=
 =?us-ascii?Q?/2uGSFy74Mtqv3Jij2SPw7//bZCAQlhkjFL3CC/jrLC1zWloW5n9FG0J1ES6?=
 =?us-ascii?Q?+e8VRNwn8wV1euXKgvxex+qT3+ErSPOB0rH1bIClRX3gsKYR0Ex+iH1mHjhb?=
 =?us-ascii?Q?UOU4aTzcSTJRH38HRoHXXRorIEiCL+S4BRfm//tLQP6B8PSI5gaBkJSSVAFk?=
 =?us-ascii?Q?d/ne6kEd+L+YfowaSvlyfpJcEWSI/p/Ge7JU464NHM3xuJEhbR3NIqjrXby7?=
 =?us-ascii?Q?UIbFGnXozJn7T52w5mwVmm77ZhOpw0VcQBRFuXj3eocz1DmfNM0Q4L0CYY4M?=
 =?us-ascii?Q?fCpCaNLglAi11T0r9xoNhW1AmFq0Z9X3GlxEBxlNd2u/hvXO/OQZQM030UNM?=
 =?us-ascii?Q?IENjTmbKk4LAqaf4KVYn2Ci/L70TSveJATLMIgVhanb3aW9XpqI8KnPl9LCA?=
 =?us-ascii?Q?i8dmzfsFjkQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EFjudKjzDXBetFHmvHqZY3QcyyJ8Gct188VpWcrSJsUANsbwfLdONF+xY7cb?=
 =?us-ascii?Q?tDk1IEqIWwDsciuJqX2xdGMwYflqR2gcmvaR5wybLpog8j052H8K6zV+w3rj?=
 =?us-ascii?Q?Jzac/NyLAv7KPVMEExMZkej0YPXAvig71WCqyLhLXZMYdKLBoutw3ZQOP5FZ?=
 =?us-ascii?Q?whHQXZ+qC7jxpCWOyzO9RJvKoV7wQbpzfmOzTASOHZ2589McCrnNDzwv3uHS?=
 =?us-ascii?Q?+yU+t9/MJCCtQXl7FtgTRzKrJVE9QO8d5GzsGhbQTbFm4uuemAZiKWD24+v3?=
 =?us-ascii?Q?WG4euryY8ZdqM3AuEZpNxinC9crPv657fguEgQeNOymasLNirT5udi81EFAQ?=
 =?us-ascii?Q?r4QZw1NKLaKEEas59iFmkO3sUVAZ4iJoQcblaX6v2iND+8GKZTActq18lBoy?=
 =?us-ascii?Q?eOmqrxOWFPcnHUHBP/ipolUTChuACaWU0UfqHmf5UxFm2j4m8yIG7qjoALBx?=
 =?us-ascii?Q?t86ooTL+Un9qDdSL4Yjxtbp1tbqBe+OZ49S55pNeuWPhdIstTTefgUWSGG/a?=
 =?us-ascii?Q?rV8q4VewYa23WUjMV48Q8BSDLXZzVjO/zG2qfX3eJcJhopGzxHwJo1k9sgZw?=
 =?us-ascii?Q?5V0QdrwhyTI3C5301leQwi0/Ceyzfv9XOhLJVaBHAAI9jNYngeVQEZp4G0AY?=
 =?us-ascii?Q?co5hNU2oumPbiVMI7BwRi8VuZqmScBqDXWAp79pF/6M632agqNRMx+QeV2Dr?=
 =?us-ascii?Q?OnG9Z57TOUZ2X0MBkEPH6AxWQ1jNymgg7w+jWoEDM/YJgciY9WcneJEsQ4Sf?=
 =?us-ascii?Q?fPsh7vjJ+9eqCNZZvZPZrWbg/6j4/o4P7TJxZrZyWmPyFlj2TyKpHu7a1PZK?=
 =?us-ascii?Q?8o3yI6la0d/NNSAvWTYp3yBtt6hQ2RtQG6TSewzAChcLT9bBBhrpiPjVZgiD?=
 =?us-ascii?Q?H9rU0w1avLVliTNVi7mOHK4T6nI2O97VZexmJgO4PMDDAAKZlIOwNVibI14n?=
 =?us-ascii?Q?JuObllV4SDz7B1ebmJx9xspgm39knObMBAF83+0jMrqc398pWZ3vvZ30RbXJ?=
 =?us-ascii?Q?QM+Hr5Z8A4feWw+BfpCa2Genp8Ddjyt8HBGFCwRjSTm894daaI2+ug1RLCX7?=
 =?us-ascii?Q?/WDqvr+4Zduk8tmjQEJatcLyVHuY3g4hTywdYTCP0+qyrz/wgrKXVxBfV5jt?=
 =?us-ascii?Q?jPqQud55/RKwb0rClc2S1PrgfMsans6T+7Qx6zcvEUVGxVzh9YDhx0fMMton?=
 =?us-ascii?Q?u6qVWoZSa9Hvtvsbvo9XlnO7ArcsTQCa39TVabvTBG1el2qeHIUaa8U05UVe?=
 =?us-ascii?Q?Qjl1y3mYNkVYNCAaNLPxnxLen9/ZabA5BCOMWapW1JVh/x0/mhIuuyQKJus6?=
 =?us-ascii?Q?mUXDPvvbCTCsI+yXKzpG1ejMs6ZZtROWzC/2CPmyGIdv6oLy/n/hrPLHbt+u?=
 =?us-ascii?Q?wMbjUfidsX3EQ28fnA6SD/KE2YKj6bvUz8SzUtYHh9iZ5ViIRcIhMnnMhqE7?=
 =?us-ascii?Q?daJsuHdJ5n4bgy1nm5OwSN8M3l36zAfP2xRpkVQrEByxQ5fOdJdgAU+Jyoza?=
 =?us-ascii?Q?pirjyk7cIelu0y3quh/tsigneZ1EBdSpb2bMq22uALtiKartdN5Vbkp9vMzJ?=
 =?us-ascii?Q?NeVbXkRsILF/OS6YIiXtn7YvSUvVH+fU9St0hoL79PN0PPvv8JEKgn+7QxAy?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 159736e8-52d7-4a7a-5649-08dda83069a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:06:44.3764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk/X+VONG0clq2T4x6NHMs6VuNVpNnq82CFR6ahBhndJCdUlYw6P00z8MBoYF7pn7ds4fMKRfz6Fxo5mJ28i9+CSh8b7saqrq8YGvx/AYeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4727
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

On Tue, Jun 10, 2025 at 02:52:24PM +0000, Varghese, Vipin wrote:
> [Public]
> 
> Snipped
> 
> > >
> > > In above log I get `2 instances of march`; logs `-march=native -mrtm
> > > -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-
> > truncation -Wno-address-of-packed-member -
> > DRTE_LOG_DEFAULT_LOGTYPE=pmd.net.i40e -DCC_AVX512_SUPPORT -
> > march=skylake-avx512`.
> > >
> > > Question-1: I think this is not expected right? The `-march=native` is populated
> > from `cflags` and `-march= skylake-avx512` is populated from ` cc_avx512_flags`.
> >
> > The above command is correct. So long as the compiler supports AVX-512 we will
> > always compile the AVX-512 code paths for runtime selection. In practice, all
> > supported compilers have AVX-512 support, so in reality we have the two scenarios
> > you tested:
> >
> > * The target architecture e.g. znver3 in your case, doesn't support avx512,
> >   so the meson.build file adds on the necessary flags to add this support,
> >   i.e. that file is compiled with -march=skylake=avx512, which is the
> >   minimum ISA that gives you the necessary support.
> > * The target architecture, e.g. znver4, does support AVX-512, then no
> >   additional flags are added and the files are compiled "as normal"
> >
> > In both these cases, whether the target architecture is specified as "native" or
> > explicitly makes no difference.
> 
> So, for files which needs avx512 support like acl_avx512, fib_tire_avx512 and others, we then only pass `cc_avx512_flags`.
> All other cases this is ignored. Thank you that makes sense.
>
> >
> > > Question-2: if the target is meet minimal ISA why not we use `-march=x86-64-
> > v4`?
> > >
> >
> > Good point, that would indeed be better. I'm just not sure whether it is supported
> > widely enough on our compilers. Do you know what gcc and clang versions support
> > that target?
> 
> As I recollect we have been using `x86-64-v4` this from gcc 12.3 and clang-14.
> I am not sure if the older versions supports `avx512 that is x86-64-v4`
>

Checking with godbolt.org, to see what versions give errors or not.
* Clang accepts the argument from v12 onwards
* GCC accepts the argument from v11 onwards.

Unfortunately, that means that we need to at least keep some form of
backward compatibility for older compilers until such time as we have those
versions as minimum.

If you are ok with the patch in general, I'll see if I can respin a version
where we check for support for -march=x86-64-v4 and use that when we can,
otherwise falling back to skylake-avx512 as here. Does that seem a
reasonable approach?

/Bruce
