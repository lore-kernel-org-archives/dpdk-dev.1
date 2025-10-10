Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D714ECCD185
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 13:20:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FCE8402A0;
	Fri, 10 Oct 2025 15:20:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 859EC4027A
 for <dev@dpdk.org>; Fri, 10 Oct 2025 15:20:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760102431; x=1791638431;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=J9djtSfUMSp9xRCpUbPMXMsQKxhS4/pCtTGqMZoCsKQ=;
 b=Co/b9TQ4wYZBMCXbn/Q+l/BfNRy70fAu0zJ0sFSMHSBgGykNG0vVN8iI
 ZvT6PCKotlXC+IrspsasydsoZbJcNxx8GYw1VHmAWQut8UDB5+pKpK4WM
 YQDiNo4ljWx3mQiYdyTgU2sv8jDQ0kRsDC3HnYy7URWDq33mh0VpURsPH
 YD3rc23MQ3S49SOBUPVqtZHvtjv4O6gajL9I4vKckJYdWN+wj9m1G6M7B
 7+prKgaKiG7C9lrV523ufqCfIF88XXwqBV4UHc8MP0OtsI+MshA+wlS/x
 +bJvBydlT/Qx6FNrabqeq0iKhSzylH/xW5+KyEcJQzzVU2Blguxa+nuAU Q==;
X-CSE-ConnectionGUID: hv/wqRPGR8Oi3czLhNtA3Q==
X-CSE-MsgGUID: Vo47Fn+fSlGOi5FB3BCTaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="72932848"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="72932848"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 06:20:30 -0700
X-CSE-ConnectionGUID: mfMdoUHmRQuHo2TkXiIH5w==
X-CSE-MsgGUID: yiDjttu6SOuFXpzyzxj4bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="211629634"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 06:20:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 06:20:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 06:20:30 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 06:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0+DbxGtgtx+pD1OXQa8XRggFS+/DNAtWXiOampS/8utu18X71vQe/GzIpRrOftAQ1sY76EBfuQwz5jGhU6cCZcIfqElNoqsZtxRPj02trwfZWWVYecSxT89sLFQSNWKYvCvhGNJNrziP73n74fda9b96UU9VKvDJlE7qFM8uqJEBHMFdshNkIsu2hvXviVq58apFdHGdzQ/6HWOvjkOdbyXunSQxJfVZDkvZdq071lp64VyAMggBCBJ6y8SiQvtkhXPNRqrd5GH0Ucgrc7UFBh8xRVenlFhbuM/6OsGmuUWOqvJ1hD6TU/WUJrd/6cP+30T2mKm3LwbQDGa9VjNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/39SRj9hUilrxiOtYS3hQC+yM5N3KfZZhLJROMq/HjE=;
 b=MNHx/FYCNOm9ITHSKXUzowdIinrOyyCKEca6OIG1Mn40cKVJFfSC6AMA2FGwwuo/i3qMO/O/SBKNtmgTvBJlJZX1IOuRRhXMrow23EzaO/7f/AQwlkJ5cWSwDnL0TZNXzGq4Vp0rlGamTS7uo4o++IIoYFE6A+jKZFF6sgFAWE3JK6/F9dCiWGzafma9CgHgVD3PcUU+uLw4cXyfABYxqb0n3Fz9Nt2Geq0WGliFQsfarrCYuxtB+LUOQrvCmlxHE0ngxjueDjRxhFuWzZO0xtXo1eb6sKBf52kwpPakBQ69PnQp7XD0bJ+tua+MKKh+XvM9+bN7gIWRvCkimIct7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8861.namprd11.prod.outlook.com (2603:10b6:208:59a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Fri, 10 Oct
 2025 13:20:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 13:20:27 +0000
Date: Fri, 10 Oct 2025 14:20:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>,
 Olivier Matz <olivier.matz@6wind.com>
Subject: Re: [V2] net/intel/e1000: reduce the optimization level for gcc > 11
Message-ID: <aOkIFu1EtAcgId22@bricha3-mobl1.ger.corp.intel.com>
References: <20251006124506.388456-1-thierry.herbelot@6wind.com>
 <20251006130257.391200-1-thierry.herbelot@6wind.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006130257.391200-1-thierry.herbelot@6wind.com>
X-ClientProxiedBy: DU7PR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a14139-9aba-40b7-abab-08de07ffc6f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s91QHX3lpjiKHEzk8IvYrtmdz4XfRJNfBTT+PWNp2m44mdXKmsZEeUFfLDHu?=
 =?us-ascii?Q?grsuckQ7vz0gTnfLLAi5c+MYyujYmtWaFx3E5VfKA68+LsylY4K/RBWQkgOH?=
 =?us-ascii?Q?d9kIOInFMCXzORfgDBwbB+tt8/BBy0fDnNBw/RzCCRiKmbEDvAaM7E2+b56T?=
 =?us-ascii?Q?uwojxc6k9yiC0obOaBFPuMVQaDag8/lW3yQ6VoM72vhZ8wjSihVgikYap/ui?=
 =?us-ascii?Q?eSJARbeR951YVuKIxpaLGEPBoJzupxHH1dQylGRn15eEilk/5IujKXV2fqbW?=
 =?us-ascii?Q?cgGMmso2LfkB4R7T76DIZo90srjuGDN7CSTLrbtvGPLO5Ier19SO4804ZmJV?=
 =?us-ascii?Q?IEZuBmAGk3hiQvmYcjQnVqosNWBaL7IrS8rvuk/UIlT3i+6Hv7x3zS9pg5lB?=
 =?us-ascii?Q?2HYMQG6FlIOWFxlnDr7LFocZ9bAETLIhddO3LwWdR2WtFigK+8IxDPUYse1W?=
 =?us-ascii?Q?cvanIm7WNjpZohfRQrzDj7YLXc/tiYaOC4SX9yuwi0zzXHXwYQlXdZvi8uMc?=
 =?us-ascii?Q?R5KQ5IyZTmWurS4c8qWAg3KLPvu0I1JpNt8MMMGu571zEzawVF+buMGvxlYU?=
 =?us-ascii?Q?TEkrxPXKez8c2wRiCq3qp6sYw8+QnYJQeCScV4qaNKLhNiPvi6WZLkc9yuvA?=
 =?us-ascii?Q?KVTOalC+JgN/W9DwefUQZVy2sAn5W4wcFN/vhoZ3MABsNekjQ1Twg0oZXlma?=
 =?us-ascii?Q?/VY+grRMg3wIvfTbSOLaBJMtvECNfn/8nkgHgli1T8N/rAds7VNqk+4+70Uf?=
 =?us-ascii?Q?tQbmBqGFkt+I8mzcWHoT0qDStSVfgyAlZHB8ujBO4Z7WXmAtUCD7kMsfdsSV?=
 =?us-ascii?Q?ijk8d37NhRUiKyoYJOIik9Nrej4tBnb1GyzLJQoO6jJejqi54xtvDltcPf2d?=
 =?us-ascii?Q?zQSLai6lrgOtkN3V7jSFYxZg7owIm+dExrXn/JABcCgfjtjBEuOzM/xDvYxW?=
 =?us-ascii?Q?t8GHbaqqDQxm61vfSAW7GFlLqNCLKUj/WrJkv9QB/RmA46Us5tUiHhbmb3/z?=
 =?us-ascii?Q?twq7AqFn6bBBtRpSOaWbg/vNzOdhSIONqnom7e/J7xKfpulsi1rVSfcrIKo7?=
 =?us-ascii?Q?Xx3ut53CXAw18TX2sgIHYccG25bMjtYaZiQv0uS4J3m/pR4Z4VpoeqiAbuFw?=
 =?us-ascii?Q?yCYPVdpCTooKwNb+okrWK0/oF5J8t6VIslhqwP0rGSt27BI4esm2qFRQFoaU?=
 =?us-ascii?Q?MakpsOCzTVve9HUsmETxtb1jwOYYSE5LeYWE4pb7aZWrLuwQOu0Pg5C3YI1+?=
 =?us-ascii?Q?pGlyxR/SuL+zq60SI95QIULOWGlw8eGhJX3EvFn4mmfIOMkw/F3sS1iIEiLy?=
 =?us-ascii?Q?ylCEVMt2gagVdigMu3SHrW7alFl4BNc0y7Q2875KTg5LxkkRQyaQGzQ7LkjL?=
 =?us-ascii?Q?BEGHiqf8TsHBlyx03rJIyf0K/ZnVuOXuF5VEQWYzE/VFIc/+Ww=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?43CQiq1O6LNHktF3VwT0tIUV5EYGxG85FgfukcrnTRgD8zU+50TNKmOlMBSZ?=
 =?us-ascii?Q?BpSLAcr5HhlOxPpFVOdp+5oRw86NpsMyhCgs8D/tyEjitY2aaoAvE4mbII9W?=
 =?us-ascii?Q?GdgAp+SZtAWviGOfc0a67M/cEmfgFfi5v0zAgAmFstRcujH68K8IQ+9uCsLg?=
 =?us-ascii?Q?tApfvqO0XZmtf5iq0lCgb8E3aWOPQPPGK+IkQajF6mKTqt9agIiBqE6no77l?=
 =?us-ascii?Q?Y9ShZMHY+4vm0Mo7XL/RYkpq3M59Rwap2v4qLSxcdwrwIw3QE0oGh/GkXP8W?=
 =?us-ascii?Q?WA3ScVmVHaPrz6PDNZwJXiWLYPcbugD66lG8Ix35c9KSQQSIPjEbj2rbKJIX?=
 =?us-ascii?Q?3xiMivXcYVdCrfN6rNeC2KUE6wv1BvP4zN53PL4Uuzq/Nxv4JouBNF4gDm5w?=
 =?us-ascii?Q?w+hbIDwTGit3IARVlpwe4nSH7Q2oIddDoohxJad6Gmigsr0gYpTC6IGAegFf?=
 =?us-ascii?Q?OamSGyyzTxiyUIyf4sXJowz2YnFKjTlHNub4iGVzPixrxfICCJleBkf1Kjzy?=
 =?us-ascii?Q?xZB1vflxih+5fC6+n3cMtMa/lAob4NTnOm6FfzxshIfGIlZtHr6vtn2309Xz?=
 =?us-ascii?Q?POUymf8kDQEnQu+DT5TkxDUPhHlZZkF8WH+uVXb/q9mfrYpJjfCzHtpWNNTn?=
 =?us-ascii?Q?FJDbRDFsLWzsZb8dQS/qG0Am1PBwZkPpXVY308Gt73xxr95J9xyrPITsAgNX?=
 =?us-ascii?Q?So3jhW/crE9F8iTYguNjvyX+ONtDhdEMkCGpwUn8sO8G8D1Goo6iMck9Wi9M?=
 =?us-ascii?Q?RZQnGDfUcKAx9oTk9ITu/gRp+hX9Ii5Nic58Ok5HimTGO9KQnNaYlGo0IqER?=
 =?us-ascii?Q?mSV6pQ+K8G8ZJRQ6kLsHBCsAsk2XBRF78shdl2icUPs1kG7m7Wwg8UJBuJy/?=
 =?us-ascii?Q?7druH0klAYd3tDB42SZ3oi83WJbfPaHB8s/6UEMRwBnoTa6UNIujw5a9enSF?=
 =?us-ascii?Q?hzKn6cEodXFp98On77TwEiUJYg4nOwClD8qlQr/Ku7AkgFDWJ6ELQiLZOl6H?=
 =?us-ascii?Q?aSS/3JVtD5mvsna9YrWU5c8I8viHt8shQxrKhOpoZekVzVi+Q5hRErCxZmxB?=
 =?us-ascii?Q?rGvgKzY2XkLdzEzMh8y6J14p/rjJkFViP3FNOqWhp2CFZ7BJpcc7gNUtS7xv?=
 =?us-ascii?Q?OGfPW/cpU4dutCcTBicQqVpZzlk0tSehA9ZG94l1koHlzqj6EytghEuIGqzS?=
 =?us-ascii?Q?GVNqN89nk5XQtvAsNNHkqJy9k2fCiPUV1TjB0voJhFsOsX7MGdgyinKRLkDx?=
 =?us-ascii?Q?xgTxORp8cdbtir5InaB0gQG96UHitz1zgtGQVbz0cV4FW4ltlGHS9nompZ/W?=
 =?us-ascii?Q?OJszyo4IFrgygJFZIvIpkTHnd0OEuVmiAaUJb6oL7o3Fml6UyOqNt1MChr5c?=
 =?us-ascii?Q?ShZ/zi+FcfnVME+Zore/olJJ1FEi2yDZCAiGbbRxwsSvNZily3UwWoJS3CLK?=
 =?us-ascii?Q?4qU34Ix6Jmd2pBuk4jy5Q5MdWNh3E4WeIda3SvBWaQs1U3U4YMNEo/h90TTK?=
 =?us-ascii?Q?eU7CINTXB9CAF3qrl/aSD7dSxbTC+P2qpYXqcX9PoEGoN8XtS+7TMooqfZMr?=
 =?us-ascii?Q?sNXkFWSOvEzJ+QP2QorFXswq24hvUSRgvj+4lSGkfRwsdOb5Hjmu5u6C3dJ2?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a14139-9aba-40b7-abab-08de07ffc6f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:20:27.2585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+6HiKMOa9FVTZ+q67aUODxOlVKH0wdZNbQUaqm9O+eO+AOVon1tkG8YDk0jpsJVdxXxc7XmZboIEFcesf8NvIQB58vVIgB3QmDof+KNg7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8861
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

On Mon, Oct 06, 2025 at 03:02:57PM +0200, Thierry Herbelot wrote:
> The e1000 PMD stopped working under Ubuntu-24.04 (using gcc-13) when
> compiled with -O3 (default level for all DPDK code). There is a crash
> when starting testpmd:
> 
> > (gdb) bt
> > #0  rte_read32_relaxed (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:290
> > #1  rte_read32 (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:345
> > #2  e1000_read_addr (addr=0x1100800e00) at ../sources/drivers/net/intel/e1000/base/e1000_osdep.h:106
> > #3  e1000_id_led_init_generic (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/base/e1000_mac.c:1844
> > #4  0x000062aaf653c85f in e1000_init_hw_82540 (hw=0x1586788c0)
> >     at ../sources/drivers/net/intel/e1000/base/e1000_82540.c:308
> > #5  0x000062aaf6db8227 in em_hardware_init (hw=hw@entry=0x1586788c0)
> >     at ../sources/drivers/net/intel/e1000/em_ethdev.c:920
> > #6  0x000062aaf65340ff in em_hw_init (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/em_ethdev.c:445
> > #7  eth_em_dev_init (eth_dev=eth_dev@entry=0x62aaff346000 <rte_eth_devices>)
> >     at ../sources/drivers/net/intel/e1000/em_ethdev.c:314
> > #8  0x000062aaf6db8b71 in rte_eth_dev_pci_generic_probe (private_data_size=11240,
> >     dev_init=0x62aaf6db8310 <eth_em_dev_init>, pci_dev=0x62ab2853dd90) at ../sources/lib/ethdev/ethdev_pci.h:150
> > #9  eth_em_pci_probe (pci_drv=<optimized out>, pci_dev=0x62ab2853dd90)
> >     at ../sources/drivers/net/intel/e1000/em_ethdev.c:365
> > #10 0x000062aaf646adf5 in rte_pci_probe_one_driver (dr=dr@entry=0x62aaf82d8020 <rte_em_pmd>,
> >     dev=dev@entry=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:299
> > #11 0x000062aaf6a15f7d in pci_probe_all_drivers (dev=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:383
> > #12 pci_probe () at ../sources/drivers/bus/pci/pci_common.c:410
> > #13 0x000062aaf7a485f3 in rte_bus_probe () at ../sources/lib/eal/common/eal_common_bus.c:84
> > #14 0x000062aaf670585d in rte_eal_init (argc=argc@entry=146, argv=argv@entry=0x7fffca468898)
> >     at ../sources/lib/eal/linux/eal.c:1253
> 
> The crash is linked to the use of gcc-13: under Ubuntu-24.04 testpmd
> compiled with gcc-11 from the same DPDK tree works as expected.
> 
> The perfect solution would be for someone to investigate why the
> PMD crashes. However, this depends on Maintainer availability.
> 
Hi,

can you test with [1]. It's still a workaround while we investigate more,
but a less severe one!

/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20251010125848.965340-1-ciara.loftus@intel.com/
