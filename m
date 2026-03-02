Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB740D58E7D
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 09:04:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA480402B0;
	Mon,  2 Mar 2026 10:03:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 40A8F4028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 10:03:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772442239; x=1803978239;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NXLtFGr2OJ41YEZ/hLt5r/hAGh0QespLng3otIOJCJQ=;
 b=CXq9xzUbt7I3KIyXJJ0yiyNOsO3SUXoqVKuHlNQZe1Zcfxboi8yO7gZO
 WC5TwUzVgt4FSPcnarrk8LxdcUW6HYyLmENLnwqg5PN6+0YeKYPqEsQEE
 P3idxSNR1HW7NWzo0ehJC9OhsLP9jR2xBoIOjMxP3x0MBn2i6bVvtTyb2
 AnWpd6NGC9lTs9qEUjI6Sjqxs3DaZp1weni/En6jR9DhnxRt5T1edhULD
 06hoDSUbDZ3szM7y7jkc9mZGmu0iFeKicgxiuk0f8MKuWyDB/QZzR4WlQ
 JibV9u3pDreTuDznzEA4yNkIfSiucHMcxfiA0ehTlHgG61s3bx00WfYxy g==;
X-CSE-ConnectionGUID: eHONZZKQQg2lvFzCyAYsxA==
X-CSE-MsgGUID: Fkp0x3jVSUCyVlfS5NaIXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73484098"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="73484098"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:03:56 -0800
X-CSE-ConnectionGUID: qKrxULAOTCW7wJESJLmYng==
X-CSE-MsgGUID: KfJCrHGBSumfOW0mog8+nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="255443886"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:03:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:03:41 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 01:03:41 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:02:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPoeSs3sU6hQBR4mXuCBxTiVhM4w/ge1YP4O5xNtn8Tn/DeQF287AAh8wKxh0TTp9HleyU/5driPUCgL+u6DwB/wJydOV0WzaNYL7KU9Lr8sINc00eyTreAZXplZYS5kaFOCnWQKsNSvEi01ex6h6xMvTiuJsL6ElAUqDkfxyhS5UogTvFbkdHVX6gZseeJXz/+QISkMecwanGm+cRAMyO1rMeyR/H1pvpYR45C3tsVqlpEbBxpxPh3/eI7Z3k8siqJfG3+ByVORbO0lAlkH1uOlISYfCZV/Bk9K2aZSt2gztw161+uxltAFpb3fDKoYBV+jXcDPk5sxmXRvN9ynPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VId8/DO571FcDiK84K5OMziMlTxr9+SizavlbcU0F4w=;
 b=vkjiSJEEOEpxOy+gFMxSswaSHha4rWh6jZI8+YfSObIlrpw+lmrXP1hXnFH60BGcx+a9S434Lqe7hzww0Uy2yVWnV0y8hW4Y47X95apnBDiM0oqkLongSgnphpFpKHGM38tuAK+pp6JfhaHMVED2uLRd0b7JwJXFad28NLnZ7ekoitRyf2oP0+lMk4UqoTi+ZiVWfqfitqYY1NK5VBmEAY2CcL5+B0BE5qCfed+vp4jEvJhfC88MimMZVdfNvsRURQ+GANnD909diTf6r5/R+i459u19NwjYKK7dmIaXfqL7UkO2yZAREq9asTAAb7hrT4k4QwceuN0+udK7lexJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 09:02:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:02:26 +0000
Date: Mon, 2 Mar 2026 09:02:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC v2 5/5] eal: configure initial device probing
Message-ID: <aaVSHYANsEFRx-oQ@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-6-david.marchand@redhat.com>
 <DGP1R1WJWJGI.1TU6RUU13GBYQ@redhat.com> <4506449.8Dcp7MaWsk@thomas>
 <aaGhdEEgxiA4Z33A@bricha3-mobl1.ger.corp.intel.com>
 <20260227141045.236af55b@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260227141045.236af55b@phoenix.local>
X-ClientProxiedBy: DU7PR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 48de81a9-2428-450f-5ddd-08de783a6cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: mCt8CKE1/eixTBss54IZF4SJ49KP9vQG3WdrSjc8kwz8phmGD3drZvZK4ub7SXNYAsekwj6qlAmKYZwQwPRr2kT8XYn/CLhufr9WZNFCEAFUAhHi5BWEXM1UQsYi2iy2nzVJ2lTE//9DGdoUkLfsg0YPN/gOGdKlvKV5+iRGFXiqIl8hWooL1j+b0FQIbR7r4jWf0hBvHVDzKmAnbxKe3KbTYRJh1yy/azUVkjXZ5l0kKegBe6Qf2KI2cvUq1ZfGkoOjQwbOtvo9RCeGsOfItzb2D3plOtdk7d0n0D5S1J+uPi9PUjYD5hOXWt0PfgBAngWfoyp4F/xeu+kf/iiytMvPxSYyk87l5d1qas4KjfnDaYMxY1ppPPgaPLOx1rZc3+esTUL8zfyutHBECOevMCmUeiFol3SXAPlGFObB1n+x8FaCLr2hZ3FWLSpyBtPCrMh4DKvtvZs0iFX9GmtgIeLjxNYVekthlYKbegdRb6D2p6fiHLZai0S5bxjnfBl0w31gfvU6TewjkO31d6gTlnTtv+P7JwmSG6Vazof18X2B6WkBzi4BScRC58PNMgyz5/79rREHiLTWILTxNZdlOr1TJ2/zhj0pahuAiBLLJfRqOVb9IJsPeahy8Hwtv1OmWkPVW8HT4HNdOxxdbgrpIYSGbf7fZaia3E97VHwscWnS/Fq+ijOfBKnPh7KZeMA+gzIAYDJDMdHAGGsP8XCl8wlwSpbtV02zEJml3IOSty0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oG1zcMuDr9ks8/ci9fp9KfkQgKRVuyM8tT2PM43M2LpXudmdjLTqwRdiiuxf?=
 =?us-ascii?Q?LXqBfbtpz3JmY9YvLYIbo+eBkHHp9yhVlmRJ4pU1GZY4pCm/t0e7UOy0fyGe?=
 =?us-ascii?Q?RaB6+jPl7asgLBg+WQvqjgBz6KjY+W24oTvnNTKuFJ5nhjKZ0K62uK9D6Wm+?=
 =?us-ascii?Q?evqGK/THV4UWPXQNh1MiCar7MpgwONh4FTyLLP2gqZmV/g6VSjbg6Qdhk9hm?=
 =?us-ascii?Q?TUOUAqHnQHc/49EMWAgmXxCLu8qVb27V3tqKJwwvWSTuwbkfgegShRVaAdX1?=
 =?us-ascii?Q?6CUx3bz+8vkBTd7oWfXtyF98Z+l3x0Sf0UeYsxAV3VIdNy66Vj3uu7WOaTYX?=
 =?us-ascii?Q?+grXN+/DYY3BeJAnTd8ZejBkrMks0cgMgQ+KsnQly+lz3uowHQ7xHjE0AAlQ?=
 =?us-ascii?Q?gjqw1s/sioe1MNqDPp1may+z4qWNBYQY9xeIQGRzO/t2osjd9/2Ixu52nQHH?=
 =?us-ascii?Q?9E4s5xHr4HZbfwVzQ0b3CIn8oAQttuqucAbq7roSLh6rQ+4njO4rf/QnVqPj?=
 =?us-ascii?Q?vZbVJ8rZza3It7TuWejvxhee8NIaIQiw2s6cC5OKKIDpNlgSc4Xbp/Ji7de7?=
 =?us-ascii?Q?qe4FpNaMUBavIyEcf46GPIkUBLJza1lNPsL2Zip0/3raq9M2TnPuLMxm3+eJ?=
 =?us-ascii?Q?zZjRY3+9J4+RFX9UcO3tcTxyMynz9DvLetY1CCmBlt5Mo4WmUldfXGwHB0iJ?=
 =?us-ascii?Q?8f0H+O34Q025zV0YoNsSL9VJq/P3yC4SVjTCkm6jduwQcrlI9gbj1Kjk0fof?=
 =?us-ascii?Q?QFHaQDHZvWRFkz4XsbmPKQme9dnUmqO3sVn0PaKE/DyBaCRerltqAEOzUDPh?=
 =?us-ascii?Q?4y7epa7vGeSIQHxI/KgKb5APUqlsvoZDh61WGhzoLNV/SonQBKY4ucI2dPqA?=
 =?us-ascii?Q?V6iXBcscZp3gUN250sguPNECcrwQQW7mVlesfHYnJlFGcl6COV15+sdZhd7a?=
 =?us-ascii?Q?LwoWse1Klduh589ZbDkN4mFguaHzOQuYU/swE8yjPYn2pUBt49vw1A6+V5kg?=
 =?us-ascii?Q?Ce3Gz23fnHunfql7UrT6HaLq8ESckxASI7kXKOIWc39AjD8BG4aIMt0UCGXN?=
 =?us-ascii?Q?VfY5CbiQQU1TmJi/eeI7ngs/S63tHBR/RU1uRATyDap87KOfZuJxEmy9efDi?=
 =?us-ascii?Q?0aU9i2mG2ncYgLF0d2lpDfOGrbYpgXMunwj4pCh4dbvBDwGX22CI66yRnJEJ?=
 =?us-ascii?Q?CLQ07slOkraGDGKdC3cxy95Z1NxucvhDd3Qu67IF4S8VV0X/HTvCwB1yc5b9?=
 =?us-ascii?Q?Hf7em8R8/F+uGIdsY2iz7mGo9JqtkgKwuEI2CHGm1fppSy8iWFfTh692AuDn?=
 =?us-ascii?Q?U9iskazG0cmHqMANHiYiwDfkHsRH8vdjZhM93eeB85P3kqu4ld5RYYZd3EwE?=
 =?us-ascii?Q?Tdv6hTdtxa8rZ+Qdw+B2bAVdUBowOW5XSmOoWSHFeQbFinjbTRHjvbpKmjzU?=
 =?us-ascii?Q?FVa9aZzb4+VRwQQI27PJZoN0J2DkOIikgCTdCz3zEzHCLisuUkn1PjrrKf7V?=
 =?us-ascii?Q?oJcEV4rS4f512IcJZBaSAXCIbpBiOeHqw8CTK5jWDBDYlITOqoFiv/ub2Iie?=
 =?us-ascii?Q?NrKMkVDNHnHhSn+bi5o+COhWK+YoiE56jDSfANYkr31aKGgrlN4zHaFDf6/C?=
 =?us-ascii?Q?1ZTBjp0Y3gHm0/XBFSBNgSplzAhhV47GLT6yp7gWFOZ1fs7J5goB3HJKISyk?=
 =?us-ascii?Q?w8hKEBxEqgxo3ufwn6tz9hAKR+ZnhPTvKbcKTg4/O+vE/tF4d0PkZnR4oi9t?=
 =?us-ascii?Q?O7Z+Xxwy6sXh9DArqd+o/6YJIwpEH9M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48de81a9-2428-450f-5ddd-08de783a6cd6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 09:02:26.5560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAPWxGSdyvzsNlz523+o1Xt9hAf6s7dJ9kPXRdtzqAcnIbkdmdMq/B2sGN89m+9FaowBjQMEv8dDog6y7Ha+W3bXxlj5K3Q64aICvwKdpfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
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

On Fri, Feb 27, 2026 at 02:10:45PM -0800, Stephen Hemminger wrote:
> On Fri, 27 Feb 2026 13:51:48 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Fri, Feb 27, 2026 at 02:43:46PM +0100, Thomas Monjalon wrote:
> > > 26/02/2026 17:50, Robin Jarry:  
> > > > David Marchand, Feb 26, 2026 at 17:20:  
> > > > > Some applications use port hotplug as their primary way for using DPDK
> > > > > resources.
> > > > > Having a systematic device probing is a problem when not all available
> > > > > resources will be used by the application, as such applications won't set
> > > > > an explicit allow list at startup.
> > > > >
> > > > > This is the case for OVS on systems with multiple mlx5 devices:
> > > > > one device can be used by the kernel while the other(s) are used by DPDK.
> > > > > In such a setup, the kernel used device may get reconfigured in
> > > > > unexpected ways and trigger issues like the one described by Kevin
> > > > > not so long ago in bugzilla 1873.
> > > > >
> > > > > Add an EAL option so that we can change the default behavior from
> > > > > block-listing to allow-listing.  
> > > [...]  
> > > > > +	const char * const argv29[] = {prgname, prefix, mp_flag, eal_debug_logs,
> > > > > +				       "--allow-explicitly" };  
> > > > 
> > > > I am not convinced by the option name. What do you think of:
> > > > 
> > > > 	--no-autoprobe
> > > > 
> > > > That would match the Linux sriov_drivers_autoprobe sysfs.  
> > > 
> > > The name --no-autoprobe is better indeed.
> > > 
> > > The exact effect of this option is to disable initial probing
> > > of devices on all buses (except vdev).
> > > Another name could be --no-initial-probing
> > > 
> > > I think we should add the opposite option as well
> > > to allow changing the default mode later.
> > > For such an option, --autoprobe looks better than --initial-probing.
> > > 
> > > Other opinions?
> > > 
> > > 
> > > [...]  
> > > > Depending on what option name we settle on, could you add a short flag
> > > > too? E.g.:
> > > > 
> > > > BOOL_ARG("--no-autoprobe", "-N", "Disable automatic probing of non-blocked devices", no_autoprobe)
> > > > 
> > > > Or:
> > > > 
> > > > BOOL_ARG("--no-autoprobe", "-P", "Disable automatic probing of non-blocked devices", no_autoprobe)  
> > > 
> > > I don't see the benefit of a short flag.
> > > It makes reading commands less obvious.
> > >   
> > I actually would prefer to have a short option available, and I'd really
> > like that short option to be "-A" since it serves as the perfect addition
> > to the "-a" flag to specify devices to probe.
> > 
> > Based on that, I would look for long options which allow "-A" as the short
> > version for example:
> > 
> > --allowlisted-devs-only
> > 
> > /Bruce
> 
> Also if -b or --block-list become a no op with --no-autoprobe. So it should be a warning?

Yes, I think a warning about ignored parameter would be appropriate.

/Bruce
