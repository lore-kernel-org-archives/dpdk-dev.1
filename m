Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245CECD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 15:53:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AF084042F;
	Wed, 20 May 2026 17:53:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B6E15400EF
 for <dev@dpdk.org>; Wed, 20 May 2026 17:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779292383; x=1810828383;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9YoSou/8RAphSwuRhMr1UnNqIN8mO/T4sQCzxaXhmmA=;
 b=Ovzz9d7nBM/E6kY9jBuMhWF3Exh0gWrXO/QusmVS3eDhJnUe1uaGAsGm
 vc5LbejzzN4PaPK+mIN/q3RUD072FfyfNXN0dX6tZgUJBw5BJ7GfvPMvT
 pzy3zDYTBIGl1CjqvyK+bg8zXWJd3kTjKva0570K70DOgwx/Ic11PMQEU
 Ey/HO6q2rhksxaShKA6rhEhOEeDUKJyELlB1cZJctQFVkkuprcfGD/+kP
 kb+9F+iBaCgLiUWeGJfXpzdVqknOSu3aRAfa66a/WEUjqY91XoSf2bE9+
 iJihye4wDMzwWqBHQheCnZZCoZBLfViBx3HBqSXdgrIdyTzMkrHP3pPoq A==;
X-CSE-ConnectionGUID: 1/nXwlWwQaCIprD6MUmujg==
X-CSE-MsgGUID: VqV8h0QGQeGzc/uxh9fHWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79925815"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="79925815"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 08:52:53 -0700
X-CSE-ConnectionGUID: f+kFWbKLQXWkrYvprQg8rg==
X-CSE-MsgGUID: UkczjjvNSi6Js3422HGfKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="244516118"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 08:52:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 08:52:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 08:52:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 08:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBSnLRbAenZTTtXzODWn2/RtOdPWcU/zL+K8OPy4QjG0+ZKODUzSg+OpcKNM9r2XWVn4l5ekZiWsZWI9s6Z1WgXGZ2ReSAZz9zTd5pfbXMaBfvtqtbAVTRIqsGIn2HnAJ20XzTBf1fAZSsjMEapWlHGzOt77VGvX4hzPehNGsFou72pG4rTKkRGZZO5QxFV0Bq+HDqEdlPElu1UiBRKFazjXQM7l5T383tQ5rRuEdyN4P4DhbSzqr4zEuTaQrxwEu6WLvp9dVC38isXmSQUNa0niLNO9QxKwvV9O7rUb5OTfkSfCR0pl8B2ZZQQYmIaJz68EHMejBAFSkwEIgVAvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4txo9l4w7RkdJ2UqVBUPZVsxAiLdsBg+sRGMrYAwiBU=;
 b=IeWL3v5m7EkpM36/IkfK9SgOzYX7Xnq+RYn0UlkRfGBEkw8N7pOUJAoBLLycRjAwRUI80is5Mk8Zoz6idjBkTOAG5g0BFKpa0+6hX3G6hsIG7eUsOJueBtXYgDYjywv+bXLozoYPaeApN2GL/67iplDE/JL7QBIRb7JwAbOa53beL+8yTn+tiVgvzSyVioyrdgDx+9qJDFRCnI130ynYaWZ/WO4aBAgOKVP2+HC1sXgwYFT4UpBdcedlCNrm0YTRwiLSawuZ5YbVF1nbCnMd2LPlWi9lDe2oIDRsYPVp/osDO4GPnFncj0aL+t2mBqRO0LXGG0Tv3GjO+dAPfS9faQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7294.namprd11.prod.outlook.com (2603:10b6:208:429::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 15:52:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 15:52:43 +0000
Date: Wed, 20 May 2026 16:52:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <patrick.mahan@hpe.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: improve log messages for DDP loading
Message-ID: <ag3Yxip794oKfUIh@bricha3-mobl1.ger.corp.intel.com>
References: <20260516101942.443871-1-david.marchand@redhat.com>
 <agykrWAcEnOBZvY-@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yLBFGVqOvfQ4SEZmy61g7xR4vrra7vyxG_NCc=4y1O7g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8yLBFGVqOvfQ4SEZmy61g7xR4vrra7vyxG_NCc=4y1O7g@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: aa62d3e8-05bc-4576-a96e-08deb687d47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: aLmpUVOPoudon1ZEeqf0ULbi0DoEbYeNz3J2KdzOi6i2YwEoBrPaa7OORPXQegCUZyFF4iLxd6SCLqqtlDNC4Is0JTXkvQp3PfZkWm2Vkav0rWdLNi6VfTzMskhOKK9Jk11icPvmKpGHDY2RMR2jtlZ3D7O4cD8BO6xesnDWp5ZHO4xksl0gtZ/p1QHRG2G2CGpqRxbwqgUAnhPItFfkJ/K9jGnx0G6X+RNq7qWCGDtyqAuIEJefqceWr//82lcP3m1Ped6uwUeyYHhA0zGbjpA8mmTTSccbRjFwa2vb5IhAYBv5qKFVrAWOQton7IO1tOwmBgIhPMTeCt3ZYDYal/abopmYkvbtlqLBJNEh8X5HmRaCrM3+dN0dn0YQFRtojL3/3EiSlLkKup9SxbqtG3DUf+ZBZ2qhFZrWR2EGN/dvADOP5Baquzb+Ed70g9QGvwnYyTKa4ZTmpvSmb17n28bJL4UWWRPD4w8Xil9gaiw/iDAi+Jt4fGu7vxk/24lBslM4sRPrU1FItFRkhSfl0cevrbo8MZyTFO5Z7kLitT9rG0Tif82EOinBZZP0blN0XTHVXYhtkmAOZsm9edjuEVsJQUAyEhevyZTX38T57vmsFUzQQUwri9DHH53evyH/NgMKhRV0BiMtWUfM+awWRqKQ3ZsYS+hgsHSKDKxpTJSU9unLBhcTeBX5Jv2GmN6T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D6gXT2ojvdRrw7ZloC57H9GEsamVbuLfqyg37yLbqVsZQzosdWeRDX/rJAh8?=
 =?us-ascii?Q?vfe4wVXu8hZkcaDCY0qvN/OhQfrs2wa+qbg8zPBCypCfVFcrydtUuPoM3L2A?=
 =?us-ascii?Q?Ql5QpIhI06tcRflxKBBFKV38izg2VrqOWIfCuK+uDBu6B2wHjXTz8RpZ5c0J?=
 =?us-ascii?Q?pmQ+P2a6TlXdYFZB7PthvGwW9uUsYxcqgrgerNukwDzkqSAMgGDtntTbi58m?=
 =?us-ascii?Q?3oBg0kuzNMzC0WgczsoagfOj8ON7LpEnEzxuYcdUb9iD64yniQuggj7uWnhS?=
 =?us-ascii?Q?lt2XbbosvKhcgRMzJNsBlUQHUdDe6qbDVKPz4eq/tGgA9uRgM8n93lYh4KGA?=
 =?us-ascii?Q?dBlCgkX3ACFLfsiyGWEWMh/5E94at+Gt8NGouau1uk32chPy8PLCY0wTisU2?=
 =?us-ascii?Q?H/JpNhzC8X6JcJJ3BSjcEtFpUgPyOOn42GzUgPS1xL7RwTp7E8Srr0CiQln7?=
 =?us-ascii?Q?MfRllkV2RJRSBtGfweY5rmDqKSAMeNBSejDAXiKt3FuUAvJHv0yP16wiPQB0?=
 =?us-ascii?Q?oR4AFvGPR5Ss6LNZoP6Yu7sDVonYqAMaUDZJzhdtGec+0kO5h7wXM7oX94+6?=
 =?us-ascii?Q?dmE8owsIp64V5xnCHZnaWytd718hSw3nUf6MC7X5GfNf288rZmTSdlwBsXsE?=
 =?us-ascii?Q?UZwSeYVaAHM9kP1WmReQGyNxK/fQXh6HdUApKHwuceQvMDYwPz6gKy9kLAma?=
 =?us-ascii?Q?4080VgtK5m+Ah1WwliSk9g62+F/Mgshx/nQlashTE2yIMRp5XJDG2sHnV1bx?=
 =?us-ascii?Q?S/hNvwXwZDgv8DqYisaBnmLkDkgpPqriFghElmIdPT4VbquG7PyeuE6Kogwk?=
 =?us-ascii?Q?U+MebWUaQc1DH6AvsYRWgVFGSuH/oD9veOl3/EXovGmu5xEpSCO+oM07RWof?=
 =?us-ascii?Q?TFJ2iu8dvrnA0VShmr3etrIjapZ0G8mnl+toYMkS/lY+IChfzf+L6+aVWMzH?=
 =?us-ascii?Q?CTRIRhjVmqDspDwT02uBcYF6SBVA7xJu6rmR5dttYdNsx8tPQV3/sSC0Heov?=
 =?us-ascii?Q?wA4sK1btJIo3yhFlcGOHOEI/9WNZRapIExnc1T7WlbuUE7BC2DOmXjwRxzTa?=
 =?us-ascii?Q?AaqoqxI0nnHWkM0Srf4FmeyGbJ6CLbidMnqSh7QsLX95QK35Zhad/psG8gSi?=
 =?us-ascii?Q?DdRuPJjzy8fXZTybiE5kSLyWmkmZ9RLWcDcdeKe+WOjL25tEKrIV5LljOk6T?=
 =?us-ascii?Q?Lao0RG/TALXdZPz2X8wvWuCpMdAfdHrnlfl/WzVCDf7ss8ahtMgkUvlOO33u?=
 =?us-ascii?Q?zhjDHOq82+EedwTYOivj4iiXPKxeBTefTApnhs79j2uG3nVqjv1nbpIjAPAZ?=
 =?us-ascii?Q?t55HoSdUOKRQffAwci6/s41obwFl2zW96UlxPogIsDTz8Kjyb2jiLLpqcBro?=
 =?us-ascii?Q?95BZEqjgUyvSUjhgt+pr3016RL6CqHwRnSM6iggyLa40QLXf/Vk1rPnmq3sa?=
 =?us-ascii?Q?gNa+ax7sPTp+WIS7bYi4TRH/SWAHu1flU8tcH9VNLzlYG+0Vr2F8JhbC4PEB?=
 =?us-ascii?Q?mv6QE/scroEIFpMFwNIOSnB/20DDK8V17ktTkm9PwbwBHoxEXNzCcdP82HhV?=
 =?us-ascii?Q?08na17+hBlb4sL/NKX5IJdeSpLBq/WbypaNnSlkAVLzzerVLyygz+KwY7suU?=
 =?us-ascii?Q?k3UHfXhYWBtwXn3t8+TUTK4ZJKnB/x+lpwdJ54botp36dHS8TD1ak84s23in?=
 =?us-ascii?Q?RwZLh/dPSpuFu1Sy+UFryiiMZXCozkZ9yTLHTLgbSZUIHplISo1dOuNAyLMu?=
 =?us-ascii?Q?hQd/IAmmrTWjPkVNH76NrebrZrNBvMU=3D?=
X-Exchange-RoutingPolicyChecked: rafZH8Eai8qi+KV65vJ4DQOy22ELuJq03ndE+27Ne/98gOqqyMHRP6sH5PS6dOuHfEi/lZuPUtFHi4W9pRgxorKAsC7dQJJzVb0UMB3G4V7tC/yvZ+m8q9Y3v3XD282PallPhdFiVuSJSrqa1p/JuOpNBHbHLZ6KIHKThVZzUQVZhGG24VaEUQfNElM87nkD1kkPP1FEMB/tbHUAqelUjpbj8xdabSAa6iCCumHBUg1ohpcxEc25P2UZmvnbmARzbryyYlm1aVtKVyQsmkPcbUAp9Uf5Gurr/nzy7lAkZahe4hOCJBpLZZE4LeZfiMZT6hD0Gx6BgZWo1nzRBwrtEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa62d3e8-05bc-4576-a96e-08deb687d47c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:52:43.6247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWR8IW+uHX83w3CSBtf+XcuWzE92ABO7v3dnl4tyk4pBmKYhf9olUrlhfSdNNQNwnq9+/d+/fPNYyrU5YK4INUZig6dRO6rh2t3gCcg2J+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7294
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

On Wed, May 20, 2026 at 05:44:14PM +0200, David Marchand wrote:
> On Tue, 19 May 2026 at 19:58, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Sat, May 16, 2026 at 12:19:41PM +0200, David Marchand wrote:
> > > Some nics may not provide a serial number (PCI capability
> > > RTE_PCI_EXT_CAP_ID_DSN).
> > >
> > > This results in a confusing ERROR log:
> > > ICE_INIT: ice_dev_init(): Failed to read device serial number
> > >
> > > This is confusing as DDP loading does *not* require the serial number to
> > > be present for the port to be functional afterwards.
> > >
> > > Besides, after trying various path, if the default DDP is not present on
> > > the runtime system, the port initialisation ends up with a vague error:
> > > ICE_INIT: ice_load_pkg(): failed to search file path
> > >
> > > Improve the situation with adjusting the log level when reading the
> > > SN fails, then add more debug context to DDP file loading and end up
> > > with a ERROR log mentioning the expected file.
> > >
> > > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> > >       /lib/firmware/updates/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> > > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> > >       /lib/firmware/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> > > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> > >       /lib/firmware/updates/intel/ice/ddp/ice.pkg
> > > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> > >       /lib/firmware/intel/ice/ddp/ice.pkg
> > > ICE_INIT: ice_load_pkg(): Failed to load default DDP package
> > >       /lib/firmware/intel/ice/ddp/ice.pkg
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > >  drivers/net/intel/ice/ice_ethdev.c | 31 ++++++++++++++++++++----------
> > >  1 file changed, 21 insertions(+), 10 deletions(-)
> > >
> > On top of the changes made in this patch, how about something like the
> > below to extend things?
> >
> > Rather than just debug logging the failed paths, we change the debug logs
> > to always log each load attempt. We also record the path as it's attempted,
> > and then on failure to load any path we use that record to print out an
> > error message for each failure, so the user can see in the error logs ALL
> > the failed paths, rather than having to re-run the app at debug level to
> > find them.
> >
> > WDYT?
> 
> That's a lot of code for something that is usually detected right at
> the first installation/run of your DPDK application.
> When you are at this point, restarting testpmd with the right debug
> level is the usual way.
> 
> But let's say you can't restart your application, log levels can be
> changed dynamically (possible with testpmd, grout and OVS)
> before/after trying to probe the E810 device.
> 
Yes, true. Probably not worth the effort at this point.

/Bruce
