Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F280CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 15:22:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B599B402A2;
	Thu, 21 May 2026 17:22:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8F216400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 17:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779376934; x=1810912934;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=7rACmHpihZMB5NFFI32Du0yHDOCtBtLcG1zkXn/JmIc=;
 b=Il05GFJoB+FcRtC5qXpT9OS2c9bwsn08R4WMwZ+It87DQqXiyAFRxzf7
 xcM9EbNqi0xzxPwpMH7OZoIwL+E9V69gpP61ZOampXft20i/RfwNdzU2O
 ENbhVyJec9eziA88rCkHWdU4B7b99NzLfZCgySQittRKQWwbDuW0M3wGr
 72g0edK+mFCO4TcsIAX9xGbOTtqLDsgIdSsoww7PHaQd5O5BAxfu2765Y
 hWOZzK1jPXFRNwrPy2Nd1ih5rbsfexaZKF7J+zG2JqtV8SyX9+arWaHZJ
 esWSrxd2YdBjIyjm22UU+bAMtkzd8Dyk0tw2Q/DENclZjYwvHbM3x72yc g==;
X-CSE-ConnectionGUID: DkcYjCszTu6hazl+3RcPYw==
X-CSE-MsgGUID: 7JpbC16TSGCpgJVqIfuxYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91405536"
X-IronPort-AV: E=Sophos;i="6.23,160,1770624000"; d="scan'208";a="91405536"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 08:22:13 -0700
X-CSE-ConnectionGUID: 0fe/UKRTQPO1iJfOtFSgNQ==
X-CSE-MsgGUID: /tzXuQElRB+wSQ2hicJSgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,160,1770624000"; d="scan'208";a="239538502"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 08:22:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 08:22:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 08:22:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 08:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt1EYhi9HqguZvZu45mZch5R02sUw3/G6IdaJWWN0jbBfjU45MbX8IipyIshiZkz/nXO5zm2pT0+vmpeM2pOVCspkpv/kYzPBoJ1SLD0h5LJF3+U+7G+qekgjJSXmPbG+hNwymSYpldonpy/N5o8fwgg5vYM6AFFCh0Cc/RmwRWB9p+njlEdAxHe7ahvnm3GqIvL4aI41C6/39txVWH7KBZVg3iXaqQyRLw6kV4uOtB8FMsrUiWXiUGolgANEd4GFvxH2Qih+JZOQx+tBXcIW5PtcvhJCGiJ1aKL1QMVVX8nbFbP3c1beUJA+fKZ+yk/+ik37U8ME/t9wxjYnKcjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JI/jQZevUcD25FjlH67fkao3pq4NNxBWnEYiJJNCjc=;
 b=F6zYOq9VGZCbP47Ugg34rNUaE55iQROgrwlugX6mtHdkCGIgxoOlPlNx6IRCpNiI5W+v5xo2EkxbtLVUzgYCSxNGi46/ikFgiINW/z2Qq+45jrisPfV5V5wt+d6j5T3OnvgK45NEmOJPznDr22J87TxOZbUmOsOG+2uzHwJ5CfRyVgwKpzrBBwEGvFmC7le/grnIUhGNReAxRMZrUxt96KFGq9NDM0ZDypR8WcCC3Pz9LrirVv40VzpAZ/gK8MWCDPb4XPxt+1euZie7Um3cT5MGtU+AKkKrXPnlNj2uvopGTt7QFgkpMIiIFtquP54t4EFCBjiWa/qWp7sTarkQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7774.namprd11.prod.outlook.com (2603:10b6:208:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 15:22:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 15:22:05 +0000
Date: Thu, 21 May 2026 16:21:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, fengchengwen
 <fengchengwen@huawei.com>, <thomas@monjalon.net>, <dev@dpdk.org>,
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 2/2] ethdev: add telemetry endpoint for list names
Message-ID: <ag8jF4E2RnQcFrYu@bricha3-mobl1.ger.corp.intel.com>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <20260520093804.29102-1-fengchengwen@huawei.com>
 <20260520093804.29102-3-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65887@smartserver.smartshare.dk>
 <ag3ME5EBdDSAhaW8@bricha3-mobl1.ger.corp.intel.com>
 <cd4f1bcd-3d66-4ffe-91d7-7ac1fdfe8c2e@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6588F@smartserver.smartshare.dk>
 <20260521073716.3a788175@phoenix.local>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521073716.3a788175@phoenix.local>
X-ClientProxiedBy: DB8PR04CA0011.eurprd04.prod.outlook.com
 (2603:10a6:10:110::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: de413451-ffa1-4fb4-ac95-08deb74cb6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|6133799003|22082099003|18002099003|56012099003|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: PiQ/VCXQPPjr6vUroWadm89feLVQgDSjXbdfzxObnD6HoHs0zjmNCGPu+DY3BUQDGumdrfcHfmk0khS6iKh/1w5zrzy6IvCA8HVR45DHQDZSDLxdOOHvLgZBtt+D0EQ3VyhozNKnzYaLXQRKpjM4LwVx0gj6Yj5WRnpmsbNzr+9aJryUYa/pgDVfDGmHp6bxV1esAEeF0z2tLZ90ixOx2N1GbQiENj8uoFWFxcZ8JWr8YaXrqDZ5AZlFA2A3Stn/+O2UCuGxW5TW+8TuvN3wukGb1hYMxFUR0fBQCa0M2sNnArUh9pn/lhcBrPVpAOFghWwy88M7Dz0dlPKvKjCnEIvrOH8sFrdBVY7Bt4eHFUapRkH6ByqukdtwrashsAa3N/HRG4MR2ohSAJhLpKUF7O9H8NvlUPKzIA0djtGrg5US9StnSdK86FNhsWg77oExhuGMQDRWz1tGGThOgtfHIsPM8oSYvDLZjuIP/cQ6of3PeZqkdijNTZwshlJguuqIYHB7dUj3TPrX8liyWAqWgmvy2c311TvqO9o+WRwUHvuoFsL8nBYoQgkpXVM2xl/1pjhcjJDcgLYxOfbOsV/LSyzgK6SPccCz+bZHNv0Z4JnjdOnbYhc6rqeay2B78Okt4QsADUieNyMA/PntWuh1sb/A1nC3L+pUVrPcRqIuvuro2tfYxMchHawRXtegllZH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(56012099003)(3023799007)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WaudlXOtgIJyV49i0IVGlaDdgsS1Ra5urJ0TOmJYc9mf2G2A7Z1bl7UKak?=
 =?iso-8859-1?Q?PaiW1nDCcGT+Ydpou5V0DFA3BzVcZ5pm3VKzi1wsLh4cyV0QbhhShpFQ4Q?=
 =?iso-8859-1?Q?YciQFkUgeSxcWuMSEpPEnOxdCSJv0Yy6geeKUplJYlRAB+K7qooClX+pV8?=
 =?iso-8859-1?Q?0+3lBwc56fHRAlA2GQGIzxMaYqlcVvRUH4G0vVW+FWPagBHoT+k79hp6qM?=
 =?iso-8859-1?Q?sFgAoxI6vhJXTjUqN48tyzGllgcqXKX823qRGYcJzShCAykVVBC3Y5dwtE?=
 =?iso-8859-1?Q?RWZAkNxOkoJuA50wNEF28qmEGtgnaEJczwqLUoggDEq2jY8S5Rzlfxdg8Z?=
 =?iso-8859-1?Q?8rT9nCsOwECa/GkX20nnvgMzqQwX8J8igLarN4OFbWiv1OZg6bGIDnS3cx?=
 =?iso-8859-1?Q?87xa4Sf6RvGI1UjocdCy8vR1IbU7/FtBFKKffgVwQk+K9dX2lCqsGKc03n?=
 =?iso-8859-1?Q?Zksv+N60vOr3vmxDnNb2YJABNHVSk4WPyvSg2aqsiFAOfotzu9SG92YWwj?=
 =?iso-8859-1?Q?KXtTXW/7cD/g7oAGfSvq6PsFLBKcirWXXzHEwytmXMjR3N0DwZvtgXzw1o?=
 =?iso-8859-1?Q?43IwzNazCCYaNwAU9lrrV60hFVcI2bAx4M6p1CAxx/DnLOc8JzLcNJJfxn?=
 =?iso-8859-1?Q?IMV2HndjL6lZL/PIcg7gxGOsdH8DlTsg9moZJOthBSvvmKiCdHiDIkbJLh?=
 =?iso-8859-1?Q?vCTI4Zpe5Hift4EZGqsc39FSip1dqEiyDUHW75E0InJWoCgdFNjOU+fdkT?=
 =?iso-8859-1?Q?bRI/r+oScMvwR3+YGnYCtPRu7HNEpjrlLzOa20N6yEFFRGCVoK5Vb3kxg9?=
 =?iso-8859-1?Q?b1Z8CwV66yEqT5bPYCCbmK78VLDN3ZeXUc5GY4Xm08PBWRO0vqRLOZZwBU?=
 =?iso-8859-1?Q?HKw+mJXu6VTpLz0/lBEeGxVhvPP5WG6gfodD8ZLPCSkDA0jDWhYNzPaDej?=
 =?iso-8859-1?Q?AoZIPzECZ+OXuXmFqoT5Y/Zd1vDMbmUHxuhNKl8U5EPbX5K9jrjstA5kLc?=
 =?iso-8859-1?Q?Vv00ewTMsjJ7vMqPoBK20EodGeBeRlRSwLIFNWJ5rZsdyTpeNpjpDm/Nhi?=
 =?iso-8859-1?Q?WEBKiCRthhwZKdLt/RUNfQLi1rZiNY1u7Fdd4RDVV3Jmq+b2RXRGaNolA9?=
 =?iso-8859-1?Q?pYKboM2XaNxTADM8HBdJxLKJlG9ZqWLMRxYWSDLV+3/5HtfsyEeLZdlrfG?=
 =?iso-8859-1?Q?Gjp9uoYm00luelV82xtHGrBpuANU1mGVey9GSKT4hXdjKuvgsHGVphsTwl?=
 =?iso-8859-1?Q?dzyWqB6uqJjQXlvwdtXE0cPdMjgmqZ3mWecBuU1RX1sV6Q4KGzDtoS/SYB?=
 =?iso-8859-1?Q?QrhOBRR4ov6mgCHt4en+vsTESNIbWAwX36EqALa4CUAffEgiCa+GaIV0UB?=
 =?iso-8859-1?Q?2+gnZ74pvve46hDLQkEibvzBQvyZFtrKrHv+QznUJ9YE/DIZef5UYbLGhP?=
 =?iso-8859-1?Q?flxvCBDshizJyJT508LY7Nmp9K4+j5X5kqv0Lw0MjrkzBM+bn0OPUhdp8e?=
 =?iso-8859-1?Q?FPgMmQ0hvOzUhsZoLtQdmoEFXibToeaiBjdQc9eIP8mntQ1l5gh98NmvCc?=
 =?iso-8859-1?Q?2PXEJBQ8uSrbFJ52bIoY+zBJwK7uGyvH3LtFI6vWdny7Z5a44V1XqIS8sy?=
 =?iso-8859-1?Q?wio/nk4rcLMvWJISABPxUt+RDVLSFgQPIdyutjsNKXzuQPbvGv/HFLn8vM?=
 =?iso-8859-1?Q?3nYc70SF3TtSgTc71Z8aZwlrMUNR6DkBaz4bVkzdhoXU58A5tIFJTFSps8?=
 =?iso-8859-1?Q?QDbPkRnjubA98DZzrqK1VpPPZMmy7Z8tIu3bcijCPI+6oRhNp+hfc/Z6sv?=
 =?iso-8859-1?Q?hcbWP6R82F2EogcCez9wloqVRVQIUGw=3D?=
X-Exchange-RoutingPolicyChecked: ZPR3RUpK0n3Kgv2ZYk/8G3hXUiert6RtN+edHAXX6+sVZJWp5KN1DTEKUoDznTtqmRczh7dglZ92QgsqUrtCoXE4jreosqth63ek/xjDgIrknZDQsZ6Qw5Lf8ON2QVGFGw9GHegkueXkjVE6M+PWgaUpV2NAuzTpAWtldhNYJoF+U6deY/crx46gVR1YFl64sha586Y71UsZyhryztey+XXe8O4y1cFKqw28mFystD3b9eApBX2BDuES0KMS5w6rTg6KofMqmkaF5cZB1wIYgkh9dF8umZC9nsIwWW1QvvAL/Nc4fZyYy8G8bOxuBomYgn6tOyQad6/MntpE4OhHlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: de413451-ffa1-4fb4-ac95-08deb74cb6f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:22:04.9309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzQd1BYVi//MHY436vNhyqY5qtiUx3+FAHvS/EGVhhcRpyVaCUQJwq0x0G3NESTV0Y77xSUmQgDZ/J5S9KjxNzaRqF/ChofdSVNic1ntARM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7774
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

On Thu, May 21, 2026 at 07:37:16AM -0700, Stephen Hemminger wrote:
> On Thu, 21 May 2026 14:40:47 +0200
> Morten Brørup <mb@smartsharesystems.com> wrote:
> 
> > > From: fengchengwen [mailto:fengchengwen@huawei.com]
> > > Sent: Thursday, 21 May 2026 14.25
> > > 
> > > Thanks for the feedback.
> > > 
> > > I intend to keep the current dict format. This concise ID-name mapping
> > > is quite
> > > helpful and easy to read especially when there are massive ports, which
> > > is exactly
> > > the main purpose why I submitted this patch.
> > > 
> > > In my opinion, adopting OData-style query would require architecture-
> > > level
> > > refactoring of telemetry framework, which is way too heavy for this
> > > simple requirement.  
> > 
> > Agree.
> > Refactoring the telemetry framework is different task, not related to this patch.
> > 
> > > For complex query demands, we can implement them by extending the
> > > upper-layer Python
> > > telemetry script instead.
> > > 
> > > So I suggest we keep this simple form here.  
> > 
> > If it is generally acceptable for DPDK telemetry that a request for a list does not return a list type, but returns an object type with "index": "value" fields instead, then
> > Series-acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
> It is necessary since port list may have holes due to hotplug or the ownership API.
> It would be good to have a more complete query function that returns more about each ethdev.
> I wouldn't worry about the size of the response. This is JSON and it is meant to be read by scripts not directly by humans.

That's where I think we have a difference - if the output is meant to be
read by scripts, we should not need extra commands like this, since the
information is already available via existing commands. The only compelling
reason that I can see for adding a new command to return a set of ethdev
names is for human interactive use.

Personally, I think the output should be just used by other scripts, but
it does appear that this quick-and-dirty telemetry script is being used
extensively for human interactive querying. Therefore, I'm working on
extending the script to make it more useful for such cases. I'd prefer to
add the extra smarts into the script rather than seeing a proliferation of
endpoints providing the same data in different formats.

/Bruce
