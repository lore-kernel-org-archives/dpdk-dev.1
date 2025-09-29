Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6636CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 09:43:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE8A04028C;
	Mon, 29 Sep 2025 11:43:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id EFDFE4026D
 for <dev@dpdk.org>; Mon, 29 Sep 2025 11:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759139006; x=1790675006;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SwBX76MmNna6o80dTc/2pukYQx3lHXGZZ2M3JVR3VzE=;
 b=A2GlJbe5ta2XdxiXXYxs+P4bKDpthFqAYp45cNKyXNr+nsbqjVmmROb1
 1Swj/vMFl286Jknoa0UBxid+Hlwwd7YY4AThz1MhCWR3DllVF/2MPcsm9
 FBS13ExQCNfiMEIg7cHpWllwI7AhUVlPTNVgcDldiG0BpOi/pW5gXmBgc
 v5ixWUb/Yf/m/NjlYgBOJYvJZV/P8NB2anxCt2qLnKL84+LT8LT27YVrm
 dibw1djzPpOexYE2Htpvpyqhk/dMewNNGIqQLrNzErrO1s9j4gwbuDWmE
 aJ6vBmq+tUsqG3RNpa8jn5rjnQAPgxrR+mqcAbruzf1zDc/isQsOs2yHa A==;
X-CSE-ConnectionGUID: 2SEqmgOqTX2GWHv+UezAZQ==
X-CSE-MsgGUID: An7tZiPKSDmPeG7Wq7P0ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="60588033"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="60588033"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 02:43:25 -0700
X-CSE-ConnectionGUID: H67WjkR1RfuoZQVXgGb4qg==
X-CSE-MsgGUID: RNtWLRj9STGbQQebFKzJRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="183372344"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 02:43:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 02:43:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 02:43:23 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.15)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 02:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+w7R8bAqrUbs/H/8pP/iTAaYvoGUATPvWqCM7H8YOp2VszHoJwY9MXQvMAA2C542NAQ6QIATW286xzLYoQ2UqiKcDxvG5cKqQ244/qD9/QGWSUf5TBKIl/IBeBZqIbB7Q4afUP9LV7sTQDiWp9m03P/u3mxYEYCAVR8M5COvIfcTTNAb1XJgtDJwl0QLvqInlLxw4BuunVc0POR+AJVfyHH2zvVlLJG3xB4OH4zvQN7Zb+zg6S0p0PuyhnMPk6xNmETe3OWx1nD+lZSBOtFttccA3Rs8lLjVDPrbBNrpx1G/9+kSvw+10WdrBl25sc7f12vwySktqo0dgybp3auJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jJqy9+ZOZPMIaXKPWO65Lgqd0wvCaAP01VQwknX0gs=;
 b=BJzz/4ka2yi4dRUR0BZvz3tyZczNpsqPBVyC3CotH5Eo0n3NhxysY+8i/3MjfNnprwIGl2qpkkr45ef5scu4rykPgeYeV+r/Nlb29e6ppVGrcwg3RE4L0oRi6wem1iN6JqbJZLwy0TDe0p/RSyirEKr9Lb0VvFDVPYlRcOBL7y56XK+4m0+It5yI1/8XgFUDSgFKqphrKjYI8w4NUxmj6VxuRShAyRv4ElU2a3Kp5S6lkdfVy1+bqp+3F1LBNi1ocFuJ/j7YNgWCDXCsKVCGPiLZkRYNNDhPPRDaNXzjoJd8imlEMQMPlgI6sbigqUuP2RI6hwfxxQDzchKXCeb0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CYXPR11MB8709.namprd11.prod.outlook.com (2603:10b6:930:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 09:43:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 09:43:20 +0000
Date: Mon, 29 Sep 2025 10:43:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 8/9] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNpUszmhWSxvEtQ7@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
 <20250926124103.750844-9-david.marchand@redhat.com>
 <aNpAXuCNZmNy6bAR@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zKKRdiSyHvNwQu5u6WUrrJX2uAApfThAwwkhR+JFuARQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zKKRdiSyHvNwQu5u6WUrrJX2uAApfThAwwkhR+JFuARQ@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CYXPR11MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cb83a9-645a-4c47-7587-08ddff3ca004
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yx1Xdt1coUPWv9EoHIWVWFvXHkhjW/6MgCt4z4GiMSoL6GHv5dxHZBIxC6J9?=
 =?us-ascii?Q?wU1DcEjqSrIfAIaXVRx9+ypBoD1+aH37lVQEgVHKfgvJsLcPihYn/6dWueLb?=
 =?us-ascii?Q?W8fvC2sFYtQX3nq1ujKpdUeYGaSvCFLlVdZpCOPA+P7Zk8E3fsoJFfSd+BJh?=
 =?us-ascii?Q?xwpJqlP7ErFmbWl1pJe6U0iCVZzdUlQXv2ogRFXTTeIWHiSkcgX43IG/8kqZ?=
 =?us-ascii?Q?1Dt3SIG51Kl89rh8rLJE9CyGJFTUPNH+EtnirjqKrGOnPipG+UPCvwA2w2HN?=
 =?us-ascii?Q?GpYO24pc5adaS/tYVkKCE+C910G59m4bx3IRpVV+lbWUpUJte9NYH7xR2L3y?=
 =?us-ascii?Q?QYUtQYl3H69UWIwyT+z9ZsJw3gNs34TB7t8grOkKBYsRsvjuENITDGS+k7mO?=
 =?us-ascii?Q?7nZIhUb3r7GHTQ0aPRGHXYaKCqAyTQ696RAanTTMSsqUl+XQOChSASzBnSxL?=
 =?us-ascii?Q?CE4qvWwJB28sPONSN8cgah25cQYMyElkzXIkGpQv+XxC6xdT+hEkARTbqNpS?=
 =?us-ascii?Q?O35rP7JouDgX9SrEMz51xBqDhZSuZaAxsosysB8qqd79i7PC6wT5P3M9JNZu?=
 =?us-ascii?Q?RIhVsPs1CGmt1qUCPfiMxt0RnCIahZQGQ+D5koS5+J5geh2uT49QDAP0rUq+?=
 =?us-ascii?Q?aov9S1Qe/3X8I9RBFtEb7Lr83HfM9jSyawTrkbgyxL/aXffwwlkTkZ8+aUcy?=
 =?us-ascii?Q?U6M4rzy3s9zBGg9UaL81QU475/LbhMd5bPhOkOQksbTs0X+3IrQsZOrEyncc?=
 =?us-ascii?Q?nR/bNzRldGrR5DhWookLR1hPemCwltCYwTwxczYK2WLHOLXAEca8rStgFhY8?=
 =?us-ascii?Q?YYHHfYgndwJ1JUB/D7gCmKrW1uJjq41oSLCD1VN1+vQAd9hjrVRRn0gGdXSY?=
 =?us-ascii?Q?AHExMsbAEtusI3kyLAJyeD5wMeN+bPMNhS5FR2DkGTubh01IEIkA90+Vqlup?=
 =?us-ascii?Q?WT3oNzEhYFDzRAaayVk5KKvYn4pKBnwRuny/Z3EiAO4FW1AXu1KAe3a+6gi5?=
 =?us-ascii?Q?dBajhuHgjBs8xFnAnqxhqMd40w8nbxXYaVPfifB+pVsvdDaVYoNWl3Nksfub?=
 =?us-ascii?Q?4Mh8qXA41mFmJBsnYW8nTaks5mybKMKe8k/b+eQpccWP+tb+8zYhdoXBZFX4?=
 =?us-ascii?Q?imkRwaKjpzPpornx/q70lrd/MxWzXP4eLKegd9teL1vfLfi7U176nwB1/4r9?=
 =?us-ascii?Q?5n+xn0Uz8P+GKAJEAdrSEBBJmZNVISm6fr/UtGPzGT+Mwv2obhCA4L72+Yos?=
 =?us-ascii?Q?tb3IwZFAs2CkszGu+QxH759cP28f8a934nPK+q/WWE+KkPGtOi1SjzgfVwlt?=
 =?us-ascii?Q?U4tc1fyszqEuwjCxxDpwPodcbi2Y8/J3ZCMEhzGfH4Dpx58XkKdzrY8Y0M1x?=
 =?us-ascii?Q?GYpOrh69A9tMEy6USV2EFNuXHaPy++9k7eeAex5JwoHfoz+blw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wh15wKOcS2i9UyEFjgAN8WFQOGRw0OZOwnxdyLapUiRHsgHs+YhUcqLX/VDe?=
 =?us-ascii?Q?b5W3jRsZANJ8kAuX5z7WF6u39GGKLo6iu0eQh1ZTj4I6p18CB3qoviImSe57?=
 =?us-ascii?Q?ndOHgt5xXa6YqmYdHph2vj3Bihh8W/RXNPyvUHbwEzcjvV5+wWTN7zjQukwc?=
 =?us-ascii?Q?ikwGghoaOpDSvYNpuyobvi9a7JRjFS+2UN7ukEmM6NQMKxWcpMjwih3YiskU?=
 =?us-ascii?Q?ebqHa0+5+FMScNZ6NZoyf93KKnrWM7GWiLBJuBTu3KecWWp8SbWkslh7KCWN?=
 =?us-ascii?Q?0yJx+3uXXdcnOW/Eg/snKatxPUE16t3vuKczr+ZghX2ZhftuQ6BXJGO8OCFQ?=
 =?us-ascii?Q?TuGzwnys5SQdWag86LwYoFmxfynnCem38FkGMdexvbzvcQk+rl3Bzol/a2DE?=
 =?us-ascii?Q?29wvcpsvyGGNRtqZDJt+F7qyvc4ryowWW8lZ6apOVtC+hk+DoINkksfur/Gt?=
 =?us-ascii?Q?DqpJm3KoU4gQPNiZsDQObL3CIvxbx3lyYKlBieH/jI1gx7lGPUId4ylOlrVr?=
 =?us-ascii?Q?+7oozf9Duwr+13AHlkW5PAiCCMgD20s52UC1MChXJT62EELsx4WhAADLYX/y?=
 =?us-ascii?Q?4l5zLXIBONkWWz/Iabubzm7WIhorb0f/8OmjW8ExMLoj+Ab4LUGat2E+0Mii?=
 =?us-ascii?Q?v5foBgde6S0UX4jTJBJno2EtJMdcxn9G6jHuytC/ZRUvGEg/b+CZS68TvSfl?=
 =?us-ascii?Q?dJmPlv+m/DafNdBuY+cf6XZ5aSdfk785Ku6l+1Fisahtlm7HqlgSFWjgCW7S?=
 =?us-ascii?Q?UYU4FDUTXDxeI3NrCN8xZXQAZGV1NZDeXaXOSyKVORFdfgEenHvKz94Xmo1T?=
 =?us-ascii?Q?1ZPLpsCA9tGZvR1vRmCgpbtIak74MtlkkjoHCfCgNzF/UIj2mMHMQJl0P7DH?=
 =?us-ascii?Q?i47sSZFBgCxIZP0aHhnhVj2XfZepFTbEDyyuihGZ3Qhq4JaQy6WO4xHg6xdC?=
 =?us-ascii?Q?ii5VgZfIISTJXEOFD7ZCy0ODMVx8SzCkewUSK1z+dZI6E18sxxnJ4roS8wBG?=
 =?us-ascii?Q?GSVlZf+DMnE5I555tYhxanaOcEUoVK1dtI3PhrE+VeFh033h42WDnXmm/K6I?=
 =?us-ascii?Q?H9OGKkIFNIhcefZc6c9Zm9tMHMkV/Cm7fm1SPNfaEFJl2NhOXFghVQGxcLX9?=
 =?us-ascii?Q?qAfi860E5d8y+qrgL/7sgYPGLf5dmF+jMV/B0PKD56KIPH5T62mz6P4LTJ4z?=
 =?us-ascii?Q?gJH1SgHFaRfG0jjjX4SeA4uBJv+eqHd7YHc1C0dFyBGvCzmswWRrI5BX8974?=
 =?us-ascii?Q?FuDrV0ix04bMVgYz1hjRXJ+qsnFm/TgA/glC6KwM1NbqATSpD62CLjnhPzhh?=
 =?us-ascii?Q?MoehJrPq1iAC1u1jyD3ZMJWRY6J63CP/nBUJer/uZzRyT5ObgCZwTM+ddXk+?=
 =?us-ascii?Q?crJO8wJoAQA2a97VarU4qNyGQp0bY9EcAV9JzUxaC6sPa0gcBONPFLdU8Ch8?=
 =?us-ascii?Q?6Mt0JhQJqGANPZyqPIYEuIujsiyy/SLapwCvJR9zBGomQexRT3o6JbtEbQv6?=
 =?us-ascii?Q?QOlvZscMdr6MI3wYYif4zbmd799ec7rItt5cCqIppsQgab+2KYDrN0C0Mki5?=
 =?us-ascii?Q?v/xGJBpd0445sXach5SciiKhEUi4c6UJO0C1sUkEe+cEWytiTJ+p19rByFqh?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cb83a9-645a-4c47-7587-08ddff3ca004
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 09:43:20.6228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/u2t2WM/nbMASzJUnrwihgMGizPU/hR5aQPm1iRWUQ3Cc+lWOP4bJ6X1ahYz7PrkNUUnp3oXvlB6U21m0XThr269i7bB6mKivk/uRZcaSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8709
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

On Mon, Sep 29, 2025 at 11:06:48AM +0200, David Marchand wrote:
> On Mon, 29 Sept 2025 at 10:16, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Fri, Sep 26, 2025 at 02:41:01PM +0200, David Marchand wrote:
> > > A problem with the current headers check is that it relies on
> > > meson dependencies objects that come with their include_directories
> > > directives, and all of those point at the library / driver sources.
> > >
> > > This means that we won't detect a public header including a private
> > > (as in, not exported) header, or a driver only header.
> > >
> > > To address this issue, a staging directory is added and every header
> > > is copied to it.
> > >
> > > Drivers and library headers are staged to two different directories
> > > and the check is updated accordingly.
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > > Changes since v4:
> > > - split global_inc (isolating config include path from EAL headers),
> > > - moved all changes under buildtools/chkincs,
> > >
> > > Changes since v3:
> > > - removed update of global_inc (which was unneeded, and probably was
> > >   what triggered a Windows clang build issue reported by CI),
> > > - moved all staging operations under a check on check_includes= option,
> > > - moved staging directories under buildtools/chkincs/,
> > > - renamed all variables to reflect those concern the headers check,
> > > - made chkincs binaries depend on staging deps instead of having the
> > >   libraries/drivers depend on them,
> > > - added C++ check for driver headers (missed in v3),
> > >
> > > ---
> > >
> > Played around a bit last week with options for doing chkincs, however, I
> > didn't find anything obviously simpler or better than this. Let's go with
> > this solution!
> >
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Thanks for the review.
> 
> I got an interesting comment from a rabbit (in the middle of a lot of
> noise ;-)).
> https://github.com/ovsrobot/dpdk/pull/106#discussion_r2382870892
> 
> That's not a common case, but this could be tricky to someone moving
> around/renaming headers.
> 
> What do you think?
> 
I think we should probably do some cleanup for the headers, yes, because
moving headers is one case where we would really like the CI to confirm
everything is ok (since moving things probably implies other rework as
well).
