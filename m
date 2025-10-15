Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63DCCCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 16:31:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D271740691;
	Wed, 15 Oct 2025 18:31:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4813F40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 18:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760545878; x=1792081878;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vGN904bAJ+gbyHlsqvEUbLSuDiArmD9xea1n2v42tcM=;
 b=EOtUKXJqxrkI26QrWkpX5FCEyYN5OQq+diQhWFCmOJyQ/o0tJ36Z/J6m
 OV3+Zr4vBsWkrG0klopHu8OU5ZSoNF21FLUSRA90FDzVSV+G5/wKr+VHX
 ZKdt9LvKIWuEoql2hhGpcIYvCTQSV+pI0KMKt4X6yYyjddWd8LhGcwUw0
 MEqbF4yBH+taSCbpUXnynHob56VY8R1MfdUmlUAkfsCgF+/rKKVRKcfi5
 Hd6jwAHpu0IsPo0DJD9DxhXWolaBqiQIu9EuknIB1DEVFvL8hLlEHBMGT
 S2G/QAy51qJF3GPHoIl4xZWP1t1ZY5cYeuf5Z77T+7AdpDnz3LESt/SJV g==;
X-CSE-ConnectionGUID: 8m+2ANPhQ2CWFWPp1E5IQA==
X-CSE-MsgGUID: H+svdyKZRxmX7nN1bMrNDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62765455"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="62765455"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 09:31:17 -0700
X-CSE-ConnectionGUID: LsoUd4IEQF24DtRf9auBVg==
X-CSE-MsgGUID: btSpMCFCQA2Y2zhJOYdB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="187507610"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 09:31:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:31:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 09:31:16 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:31:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugajJe8PjKkmnubUAIxrjGsEVOnUsiNy/QkXWiqUp87K46XHPrso8dGM81iqHZySMZ3hsgc0nRMcdD/6eOK3TKbHj3P3Ya5Kz4loStI/wcxO7CPzQXInwYu1JdpmnK4wzQR94V9gbtORmZF/Ph06a/rpH6RcWbiFCbo7Xh6uLcMd2Eu+SMs40DCtjDsEz/FtJZ/wP1A47g3RN4by5NDlkj1lAyjZeH7wlGlmw0ADoPmkHQDp5qpllckbuoEu4HLQxP/xhgmuaEgAdPjLlxfaffjfgWwA+st5L4MeRCaF3ZUGq+MAZTPtOQBdb53AXcIcrUn5UXiO7ZuamNRYjuD2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez/SURBrn0iASPUYeyPaMNBIUh6mN5akNf5mglj+R+I=;
 b=FLSngQZu4p5XX4YwnhmrQoThKqRR0n5GoMplv3sZj9GIo6XuequwuIcibXu8WW0DJUdUzdncM8jVZ6Asq7vKQHkFB51naoZg333xu06IaIqv44AbCXjpkJEjo4JlenqKDXCmJitDuHaHabptCmI4beYEInB9wf3MkbNEmPgWzFEBCuqGmwerGGuxoPAqd4Wr3LJb62FeQL0WxeJuNVegqW9hXlb0A0ERCrD58BcNJ8Y85Ml2lHHFOBn7gs1JPPeBfzsZFv2m7WG6PlBFzdq6m9tR4aOhzEopiKpDEOwdd8jVn6jPdFXyVmLh37iCN/WDa2miVoIS9wtA+ExofXi0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 16:31:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 16:31:12 +0000
Date: Wed, 15 Oct 2025 17:31:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH v11 00/21]
Message-ID: <aO_MTLqh-TNAULat@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <CAJFAV8y+cWnMr0QNrsvtBKLOsRq-1QN3tcRP75LERj9b4-eBYw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8y+cWnMr0QNrsvtBKLOsRq-1QN3tcRP75LERj9b4-eBYw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: fe12331c-f180-4e62-7f7a-08de0c0840f7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MUBX6h2iER1YqhaV89dkDxo5N4pGEDR1ZGG+vWdy74OHDvOL5lJWbi8ARlMU?=
 =?us-ascii?Q?2QcYWAgzeBMDn/beqK2sjAowzudJ5TcEMyN1aVZdR+TF2i83/EMq6Dh4S5Fw?=
 =?us-ascii?Q?brjO/P5w+waeSf08ogjbzCZUsdVyDweZv8bn0fZmPx0owYwRBxDsFSMDWxZo?=
 =?us-ascii?Q?poMkQPkEhAgfoKIEZFuA5BCa1n/Tth1yfNPQDKoN6F8Cr2Hs2U+2XHl/qtoz?=
 =?us-ascii?Q?KaP6fVMkjld2ygrnXEjBkXboBhnMyeGukiDbRq3W3z/Ytzi8PdVgbJBAoBSj?=
 =?us-ascii?Q?oT0r2Q5Od1fKSAo+LZqknfYkOPlkYE16Xg+dfOdmqS8Dd0NI0EMjo4Xbm8Ll?=
 =?us-ascii?Q?wK8GXdrOYrFpBy1BLcP9r6HiEi/vpV09nWfekQCuuFhsxbzIVSyFjNtIuPHV?=
 =?us-ascii?Q?dCr+4PUFZNJ8UB5BQDLZV7rcFQT0VLULBix8qXhhTqEXFr9QAODlx6cf7Cc1?=
 =?us-ascii?Q?oNDY+11Ng8jo72eA5qCOk91WjBQqZXR3jBM5Src73TGH1LTW7wnLCGPFoAON?=
 =?us-ascii?Q?pvU2HnfNKk44Q8FUfiyGQ6SHkYVGEsa1BbeHVSBdkAkq/lrNowIYsXBhRnrn?=
 =?us-ascii?Q?JxrGKrbK7/OVFIVGrOw55eyKsZLXWwJzCkUfBGU8aJDmMVFToGfKFUvE+PaA?=
 =?us-ascii?Q?t+HzOP/6wMMVcfSb1VPC8Q0YTS0Cr9XOpb/lIBHK3/8qUEavr9EAuO24190j?=
 =?us-ascii?Q?I8BVKumYmstpbRIpfzAa0wqEQXOSyDcyTxqUdelGTikXVFReLH/PHT+BFJlB?=
 =?us-ascii?Q?LPnP9dGcQg6gbdPtCwUiUjoI5TRgDxZN/i9M9MQwB/MFgchsoLEYmxP7XUIR?=
 =?us-ascii?Q?MxoSOkMR5ezZuowENJzoupPxTCcDp/Meufcg1RVAvAO1Rupcy4cseIU/IFqr?=
 =?us-ascii?Q?5F9lFF15acvA5qP8LBCrDCaC8Lruk2E8Cp3YFBhDs5tvg6A2U6EXQTrsXdZw?=
 =?us-ascii?Q?BxgzksLfivWOu+z+f3u3Ifn6rDrD25JzCzRT+g4K03b4OphtyDzrj8XW3hmR?=
 =?us-ascii?Q?VqCoR5chlPFYGVT1MU7pjgMVBjH05yR8u8Cwfwb6QGzFabsZ1OhftU9/Co9n?=
 =?us-ascii?Q?MD9N4uEzZaT4kMzlQYP6pcvOJB+taIsix+0FSbh8mctJ8KPomXIFfXGLt+8h?=
 =?us-ascii?Q?Z9BJrOweQh1aZzXCmtIoVauksn5aHf4yEnV7T0be/lJVR5/N3Gv2u9bV2kLn?=
 =?us-ascii?Q?xPL3huZtgUhv5HAZyhDQ5jXqogz0MZeypV3Q7GHP420QekZiEm5KGO7se+zV?=
 =?us-ascii?Q?CYx0SfmNWFC6/SkusKhtm5J59Iwva1oSSL0FICTeQ8jVRbVOrXc9HOsF0Fmv?=
 =?us-ascii?Q?rTpsnX9jlsmYjPzmDk0Xqs+UGq5gF5XG9SRBZNrOclnr99yAdLcuP4tZMqLy?=
 =?us-ascii?Q?VpVdXZymINxkw8TNzWZaOf7EnRkzqmafY8amo98BXSBWvZGQzut7UqG+8Rnj?=
 =?us-ascii?Q?eYLmGdpjvgQcIvem67GEJZZ+aKcFk5A7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xRJ3qQZ1dUhSgT2n46KNVMddAT43wzQGUR0k4kAXT21cd4ouDP/iGxC4Xhm?=
 =?us-ascii?Q?fs74T8bJacHRP/NfSYcfEa9w4B2yTV+FKDAm13F2DrHb3KQkEDWxvE0MJrmI?=
 =?us-ascii?Q?1qlD7CZjOsagTMy5O4cdvFRKvRyTJfsV/wozWSq1b9sBb8tD4IV0NqoN80fA?=
 =?us-ascii?Q?mwxto8MbZzwkwDE3ewGdJh3pe/0YObvPRl9nbnMOSft7CLjWRFBPU1GXV4Jx?=
 =?us-ascii?Q?YCYsODQa2BSrJ3rjvY3ozsc0Z7BL7c5nrzrx4+8V+i3BafUt17EHTlMZ1M3y?=
 =?us-ascii?Q?2ytqmbDPrcOIsxEOzCTJJRPBx6AogOk3mA+zHSs6y1OixV7OLfhjAHtNYj2y?=
 =?us-ascii?Q?/6qVyjnTCEIx/qNkHQLZ9NRWAdTCYxnQYA9otq/ddMkPK96B6XblsnDlrVG5?=
 =?us-ascii?Q?bSZBO3ssWKs43cPTKxn0EDeesZQniRTnjhAzASz7yL8pumNvgU1MdyZ4YSIH?=
 =?us-ascii?Q?xY4KmbPnefd4pRXu8eziB+rwA1bT7nHqbEQlUzOdRRmUlNxgEkjrSPgGBTJc?=
 =?us-ascii?Q?tvkNoxRBnNKIW6v+TWcD8J/VK+lB0eJ4Y0ZrGIDH4CmOZMHP3YKHc6PP+whe?=
 =?us-ascii?Q?d3mPl4NvSyYC6Jn4Y7KkPV73xnfbx2jFOHFEMv8sivZuy1+XwOcYB2lzzQD3?=
 =?us-ascii?Q?o94H/f6fLT0ad5uf7rw4ciU/EmD4iEyE8wgM9Em3tqEmOQOYd65A0E9ovtvt?=
 =?us-ascii?Q?z030GoofyVpf9WPs/Wfn+F7mFo6e+6Z1XG/5ZBV6QuE84j84j4qBYh1C+DHX?=
 =?us-ascii?Q?IPLb7FVG9+Kd9XVtXRGgTbxRQXjDxc1vg42FI+ynQt0R9wKMkaYumrYnrzSm?=
 =?us-ascii?Q?6ZIjCfR0ThEUIF0bwcS2tpjgo6vKBbpexEiSFqWRVMTbcxslGw6ErhADBmlH?=
 =?us-ascii?Q?7aHc7qYlA32sF6ZVRMdGHks2H+03lfMloh3/STYM1lcMQrsaZn9Mv5aMv32+?=
 =?us-ascii?Q?aOm1dBmq7VJ4RKMgzcHAlrw82YaH+vlc8ouTCplQAeFYshHagFQyUXYHDBV/?=
 =?us-ascii?Q?LtiWY+Kuk76v5xEdlYjJUxn7CmlYKoiIP8q1W/e0YySE9QafKcdpjy29DWfw?=
 =?us-ascii?Q?N77A1IyYd4bXn4D4AGCH+wL/cEnZq7QWw2GN8ZbMzqZZ7uOp6G1B0r4I1SZH?=
 =?us-ascii?Q?vgU08FNIk+0el0airbngGy4aBnkeOQUU+Hc5zuzi2/BFKTNN9wH9Gie6GzqP?=
 =?us-ascii?Q?QXUHexxgjcqE0881q0jR9CXRtjAFbwlkfg8/RH5SQKakZkMZN60ku1q91FtA?=
 =?us-ascii?Q?TSVM6scRxRWY0xO7kCd2FNQ6WDc8ZtBVzPe3//fEZr6YsSXBeLclJibB1ncK?=
 =?us-ascii?Q?C5mtDSrbodO0vqIYTuhK4uZfPJulAAwPTzz+wQgEh/y753LGduv2aYpRHar5?=
 =?us-ascii?Q?f4wkrzY+ZTlkeTerP8LVdzQhsZYYL/czsz2Mm0EIzbfHF4C3XogTY+Eb5X1E?=
 =?us-ascii?Q?o31r/cqFyvEQJDWX9KvWMllJUCa6vVkVzFm7T12Os7APZ0pxY5puG2eOIBbU?=
 =?us-ascii?Q?RfnPZ6qTHm36YvfpCBD+j+40zzfD0mmTa5U9naZ1zHgrrwGIRb8gDiI4MjrP?=
 =?us-ascii?Q?KPBZIPA44sfJZPqs9SYY47p2UePws9z/3GE1TjgglU83uyJmRP1yvkGvy98T?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe12331c-f180-4e62-7f7a-08de0c0840f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:31:12.4728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/dMI3dIlteu1jrew8TQIkFzRMt8T3W94UvjLjURgFVQBCYACsYiioTHAXGNnxXxdURu8p7GCw4g6NNOrkyCBwCHMejpQsFnD2HpgQU3wwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
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

On Wed, Oct 15, 2025 at 06:10:59PM +0200, David Marchand wrote:
> Hello Bruce,
> 
> On Thu, 9 Oct 2025 at 15:01, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The ultimate of this patchset is to make it easier to run on systems
> > with large numbers of cores, by simplifying the process of using core
> > numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
> > shortened to ``-R``, is added to DPDK to support this.
> >
> > However, in order to add this new flag easily, the first dozen or more
> > patches rework the argument handling in EAL to simplify things, using
> > the argparse library for argument handling.
> >
> > When processing cmdline arguments in DPDK, we always do so with very
> > little context. So, for example, when processing the "-l" flag, we have
> > no idea whether there will be later a --proc-type=secondary flag. We
> > have all sorts of post-arg-processing checks in place to try and catch
> > these scenarios.
> >
> > To improve this situation, this patchset tries to simplify the handling
> > of argument processing, by explicitly doing an initial pass to collate
> > all arguments into a structure. Thereafter, the actual arg parsing is
> > done in a fixed order, meaning that e.g. when processing the
> > --main-lcore flag, we have already processed the service core flags. We
> > also can far quicker and easier check for conflicting options, since
> > they can all be checked for NULL/non-NULL in the arg structure
> > immediately after the struct has been populated.
> >
> > An additional benefit of this work is that the argument parsing for EAL
> > is much more centralised into common options and the options list file.
> > This single list with ifdefs makes it clear to the viewer what options
> > are common across OS's, vs what are unix-only or linux-only.
> >
> > Once the cleanup and rework is done, adding the new options for
> > remapping cores becomes a lot simpler, since we can very easily check
> > for scenarios like multi-process and handle those appropriately.
> >
> >
> > V11:
> > * fix issues flagged by unit tests in CI and subsequent testing:
> >   - when passing in an lcore >= MAX_LCORES, return error rather than
> >     ignoring it. (compatibility issue)
> >   - return error when an invalid lcore set of "1-3-5" is passed in,
> >     rather than just treating it as "3-5".
> 
> I did some tweaking on the series (and put my sob for taking the
> bullet if I broke something ;-)), namely:
> - squashed the init arg list patch into the initial patch that
> introduces eal_option_list.h,
> - inverted order of the patch on coremask rework with the one
> introducing lcore remapping,
> - I updated patch 6 as Chengwen requested, and I fixed return codes
> for parse_arg_corelist(),
> - I updated the doc for patch 8 as Chengwen requested,
> 

Thanks for the rework.

> I fixed a few reintroductions of socket-mem (should be numa-mem) in
> intermediate patches.
> 

Are both not needing to be supported? With current implementation I think
they are just aliases for another. [Though maybe I'm missunderstanding the
rework here]

> I noticed that the leak reported earlier on patch "eal: gather EAL
> args before processing" is still present when stopping at this commit,
> and it is fixed in the next commit.
> We could have avoid this transient issue, but I did not spend time to
> fix as it is just a leak in the event wrong EAL options are passed.
> 
> There were some little checkpatch issues I fixed (plus some spurious
> empty lines/spaces).
> But I left the options definitions as is (wrt line length warning).
> 

Thanks. I think the options are better kept one-per-line irrespective of
checkpatch warnings.

> Wrt storing the cores as a fixed size cpuset, this storage is internal
> and we can change in the future (no ABI concern afaics).
> 
> Series applied.
> 
> Thanks Chengwen for the reviews on argparse.
> 
> Thanks Bruce, this was kind of an unexpected long road.
> This is a nice cleanup and I like this auto magic option and the debug logs.
> 

Thanks. It was indeed a long road, and far more churn than expected, since
I started out with only 5 or 7 patches in initial versions and ended up
with over 20!

> 
> I have two questions which could be addressed in followup patches but
> seem more risky than what I touched, and require a new round of CI:
> - are we missing a build check on RTE_MAX_LCORE < CPU_SETSIZE?

Maybe. However, I think be best way to fix that is as part of any cleanup
work to eliminate any dependency on CPU_SETSIZE. That will probably be its
own epic patchset!

> - should eal_clean_saved_args() be called in rte_eal_cleanup()?
> 
> 
> And finally my dumb idea:
> 
> Do you think it would be feasible to extend this remapping mechanism
> for multi process?
> I would like to start all processes with only the -R option (and each
> application has a dedicated cpu affinity, set by an external mechanism
> out of DPDK).
> Then some exchanges between primary and secondary processes are done
> at init, with secondary announcing a number of lcores it needs, and
> the primary replying with a lcoreid base for remapping.
> One problem is that it would require tracking life and death of the
> secondary processes to that primary can reallocate unused lcores
> ranges.
> 
I think that is a tough ask. I don't think I'll attempt to implement that.
Having users of secondary processes manage each process own starting lcore
id is probably not a massive ask.

Thanks again for all the reviews.

/Bruce
