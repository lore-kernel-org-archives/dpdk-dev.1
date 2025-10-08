Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CA5CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 08:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A90540611;
	Wed,  8 Oct 2025 10:11:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6808E402A0;
 Wed,  8 Oct 2025 10:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759911115; x=1791447115;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=T4cVqjP/s11ZADdk31YEpd81hmpDf7JJ//bWLIoWKCs=;
 b=Eno73C2YvA33JoIync0TzEL2xtf7fsiS+V4rzQgjgDELS1lNjAGKuyfX
 SgtSvMW0Wa3ImPPtpgtfj1KHshL5dFlnev157Z1rK+SYQ8D5X4m5LR0a8
 4QfDoLuZh7cYXPAJHLTtxHvBPVOtUci1yEFwjxYqlMEraCLZGUlA+G18w
 7JAdozKIFX7gi8dLqhqdDADOFTYsxt8SbBy8j/4AYqm24GSOODFMg8shy
 3CkM+oxXqKzNAGQF8Ii6WVJyuej25pKaEoElOyv6s2sUsgbJDQ7W2T5mA
 exT4dgR6jAI0Xv0TBMpvXqY2avKwpBDJ3Ey3tZwOKwVLuWJnxNUieIuTy g==;
X-CSE-ConnectionGUID: ZX1/+baZRVGBDevgu1i/VA==
X-CSE-MsgGUID: VJzxOtSUS9ONIB9FATu4dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62196432"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="62196432"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:11:54 -0700
X-CSE-ConnectionGUID: cZY89SU4QL2XeCBM5A/+WA==
X-CSE-MsgGUID: Ex/4aWFrSJKFtx930teI+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="204106440"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:11:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:11:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 01:11:53 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcW9ijKNQmAEx0S63a0Bokbe7sKJbizN/hQSrpC6oQBdhRZJ6XKhjVQzasm0JD5ncRKaY3OJXO403Pf0FDIzYd37uw3Y7ZcMcK7ps/CIaKKc7EGHHKlNMkWwXSCzHgNRE+bY2hwWI95s8M6QxpemqDOoYCfVNOySUrTfsR9RBkmT7g0ttXijBfXJmNz2vPjWmAPwGmxP1XIj/vFn4S1nao9x/QFfWG9NOHFsR0NP+Y2/RvvH7BNfpNjDJEs1XbWD6LqPHwBJ8ny1m2arQSru0zujAW2043kxMDBqFpM2mN9VNYKY7hCZgSX5ONW7+RCoCPf7RRyGBzAHLu1790C7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/qa+8pPiukDWc6SN1lb07BC0NbsI0cdH2IuhnVkj/M=;
 b=B3v/9uonzDJ+Gf9kKyABkCHJwD5ika0FueYm5DK73wGnrGW3pWgurb7iTMSecTeLQIA38XhVtXa5uocTd0gHTJyzBWpDmHGqj7I4jc2s946a3IRvQvm1sVZzZILmm2eJHzaJ/EMIw+6Jh14SQlGVLJLQlb15Fh0C+RtedDpjaihzm5PMJ/li8mKAePI8zTxDN8n78wuMQ7wKOBxyOd14Nx3RYTPcvSyE9KwqWNBmOzirpg9RJr2B85sfCgZgxA0lb6pI0hTy5yQt1S7eopEIa3LUclhosdNdFPDn1mXQ94R90PJIK1oiRl2jf4eNBHQMQb6fArGMtZ2WTkG/GcN59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5020.namprd11.prod.outlook.com (2603:10b6:806:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 08:11:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 08:11:40 +0000
Date: Wed, 8 Oct 2025 09:11:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>, "Stephen
 Hemminger" <stephen@networkplumber.org>, dpdk-techboard <techboard@dpdk.org>, 
 Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v9 00/18] Simplify running with high-numbered CPUs
Message-ID: <aOYct2gmwSJ4OzTf@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <CAJFAV8yuo6vVSGKx4Cbs6Qqv9Y9dPsLteZtmN+Kr79BmnMqCbA@mail.gmail.com>
 <aOU8qESdjcs7Qkqi@bricha3-mobl1.ger.corp.intel.com>
 <4032978.kC03pvyZki@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4032978.kC03pvyZki@thomas>
X-ClientProxiedBy: DU7PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 796c54c1-a4a4-4cef-0257-08de06424f34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oOggV87MNFSQ928juC0OKXa4XJyl4co1na0wk0eYPyfRs2qUCoscIC/J/1yP?=
 =?us-ascii?Q?YuXUPFdZseXJW3+bnyAtvBnS9E+dCjDy2wWDj4M6wXTZ5ZLo47lqKzSGlHIX?=
 =?us-ascii?Q?DZopeEoiJDkE1XOMauxeWbe8JBJ7DHe+Oqi8bGyJqwiuONR67w2iDLxZnCqn?=
 =?us-ascii?Q?J+K8Pcj9Jig3ui7Fdkpvoa92lXRVlhAU1Fy21t5M2vy6fOzZO58dhPOPfdG9?=
 =?us-ascii?Q?0kRGhHg2KFZcDa4orVqwDN8xMp9qlIsXabLyjmSiKQPEXHyU201MyKcSJ3Mt?=
 =?us-ascii?Q?/UlloiIClZBWAnECleB0Ken4T15McbUM9pNSNw1BivIfHkSwtykv0Vnfl7Sm?=
 =?us-ascii?Q?FFLN9lxJSV0b99MJZWoPM2jyvf2/0/XHTV1Dg179hsC2lBnjA37kj8QbKGKr?=
 =?us-ascii?Q?laQQZ/KgY66ACywc+yaT8mVm75EwnpvUzzcAOiS3eaJEu36IiH2KZL2Kue+J?=
 =?us-ascii?Q?SwC3BMsk5EKD591bajahGdT/i2JIVLoho5SYmJOJizSg4ov4zyH2UomtCFXH?=
 =?us-ascii?Q?LK2wxv8nW2hwLC4ZBep24Nw88mjK726yLvZU83iOuLXVandMSA8Uzf0k6j9W?=
 =?us-ascii?Q?5FWFMKaPLNG/Mil+XYLL90l+lQhcNdD+3JhuiA40By8o1Ryo0Eb7mPbUvUgu?=
 =?us-ascii?Q?MVNgad299uxFMl97xGCy3FS+j7evwnBhuySAnW/NMDuBmxzvxNIOKObgaacd?=
 =?us-ascii?Q?1r+y1gnawIAKxrdISg+wSILGifYZ1Q0b+mIyEBPveR20JJxSg/202BzlHj0E?=
 =?us-ascii?Q?NETfi36WHaVXlhIOCVU298cC0XcTBbFcECVXHQklnovSt2Q1A5Yphy+T5HFt?=
 =?us-ascii?Q?8r2clMQODHuj4r9NTAD7zWVE9PyajCZ9P7Nu2W5hDJdTexF04HQ/IWmsszLK?=
 =?us-ascii?Q?HnKV6moxrxioS613GkoQI3I6IuJqkprxpXaJ+EwuY3G0KC7LOtE4yI6olGm2?=
 =?us-ascii?Q?wZzl7cGlsMLoSKcS6boaMvbIw11ZL5OIUDPIbl9r8TmBIotLsr7PUQuxSHJ8?=
 =?us-ascii?Q?tAY1ALYctpWDywTjSl1Vu+xGpnJ/nt7Dr53tmvDsClTBcm/d+ErgfCoaXkMu?=
 =?us-ascii?Q?6L3g+llBq0c/N2utcZPA2bcpM0PbkAQEQONheoHcm4ZtvOcPv8Gr7oVv9O1T?=
 =?us-ascii?Q?a7Jdc3RvSYpeXu2twBVkBNuyJcMEMT4WgBta6JaUUICJ6Z3UrVRB6HDy+F0D?=
 =?us-ascii?Q?qegZEmzvkxGkdkVEfanHgnFPsWclxpOtUQT8mJFPcEfLCHlxIAfKr5GlZfwa?=
 =?us-ascii?Q?se97wT8PQEIuIxo/+Fzj8XZuUtOQL9GqBub+vkGsvVI4fx3EsWP8ldjJS26d?=
 =?us-ascii?Q?5TIB9wy53qMKZMwOnvduBVu/a9M1UvvyZOb9aaJvrR+7HgjFJgEf/uHLNGVp?=
 =?us-ascii?Q?Nq4Jyxu3uT/jMvkCGjRsONU8oJkECAOokt4g2PuwOVvDM91VirTUhy1PTfMW?=
 =?us-ascii?Q?byaJvDVMI643eKGOfj/0K9hz0uzkkQV7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r83b+IemIASM/4cOQ3uIQDb9yWsNuutbSDDOVsQbWYQnOmd63zrPdNcY/W+N?=
 =?us-ascii?Q?iasPGgeu0OU6VqzzHjE7RKfa6dFh3IPb6LNKTEtSuW1irOY2nwau2p9Y+/Oe?=
 =?us-ascii?Q?R+9rqvH5A9YC0QI5zEIzihRBKyBI/7Yh8mHjV1y8/ef0qyhMwVHb/tlBTbeB?=
 =?us-ascii?Q?j0vOFi9WW1Nl5IV1OJ+Xx2jNQDxAjbqqUTd2A3z80r0YME/S9VEINWWLKL9Q?=
 =?us-ascii?Q?nWLbmQrnXVj0KsnVhw0qsnBi4VIVo39WsNk0udhpHWwhGVZ1dPRJQkqtBMYt?=
 =?us-ascii?Q?dqUNKqCo/VLy6v09ZtTtmwKgL2CctN6NTjDaZrTwLbKRoDpEIDN08OsMBA7R?=
 =?us-ascii?Q?Yq7ODk5LXrjmvAMmXCEV/sjXnpy9WmUrbsP9hRm77Yk7EK2geUpMPdxQvO4/?=
 =?us-ascii?Q?xZjwQcqVXyADEX1VhWk2/Msd+CkhlFPsyOkmF0LWq9RCQECaQkJVsKGeciQC?=
 =?us-ascii?Q?aIdumTVTbHDkUNP8125/l+zWlmtXBsvkvqfgcOAS58o5J/sQBhH2accu3B9+?=
 =?us-ascii?Q?M/JXCxN+aaJ5QpT0dyesnHbRaunW/jnYQYH7oxLmp0W7FSU9OtAAqwvkveYq?=
 =?us-ascii?Q?mtqaiXbaPjG/leerVZ4GDeNT7AQXU2I+RLuGT0sLhlhZElALotY90YQZ5m0B?=
 =?us-ascii?Q?7Oyt3S2ixuMA9a2Cglp4/tdyPYYzwZaxHu5G+g/o/q/94beG+VuciREO61ah?=
 =?us-ascii?Q?ejjdWt1g9ZpjZlLfXS9yQCwIFT1HSi18l/0g9N3aFG4nSoQ+7bOWFEfmMZdu?=
 =?us-ascii?Q?eoxOm58tN4rR6VMR6QyTk3wzHFORkwgABgrJP9QaViFXjlTC4694j1xunk6c?=
 =?us-ascii?Q?W38E9mmy7j3gENnkBPvNII7qhKpvvlD22UmBvPtwWIOJJ8Tjs4QLmB+/LWJf?=
 =?us-ascii?Q?/NEknmFiihb7s0CiwxucEDmevZbLr/cf8dQvjJGajdhbHVKnqD2zteLDGWly?=
 =?us-ascii?Q?rMwPS3QUfO4XfoDvbfyXXnW6KNdV9ZqWANPA+DH6KQtGHYv5OiEfEw/xtDMQ?=
 =?us-ascii?Q?yyLmpgxuNs8tZsMQayKWx7M5xSNcceK4MJF4RdQ30bHLC63RvaGHUobIO8cW?=
 =?us-ascii?Q?Ujrxi+vzo/exoxWdvNKkrVv7+F2Xc+CQ0CL0mTnZxf+hs9mGTaGiZDEOZncD?=
 =?us-ascii?Q?Jeg4JAR+7AQdQEVUMsZ9BeV+tkidw3tCbwdD+luehubqZFgCLk1X4aiD81Mh?=
 =?us-ascii?Q?OPD+R5JPySlFhFOBCnWi3ltJrPV24FUPEKlUM5aomQTXUPiYOW5HDp/DwDVl?=
 =?us-ascii?Q?XgDAAqhJj5Upafz4/nTfxPXsmGKN5aYphAHyJCWlfOCXZuN+9/qi93XzMvbg?=
 =?us-ascii?Q?GrdgwdnVcgu/WzLjgAiTZEW6aMrlVKf7KLACChtSVWlDKxy3nWMKJ5xyEbzk?=
 =?us-ascii?Q?4CxlBb8yY77mubh2aGHsWBy56nMignoGTjJ4jE7LISv2ykW43R8rpG1jD0ZS?=
 =?us-ascii?Q?4UQqdpXB7STYW1gKXjJRyM8yT27KeFIx4wE/IwHvTrIXVVI3Uf0a8Tp1hu1D?=
 =?us-ascii?Q?JamZ2+aNngjnp4pqi0cF54PMrKWdfVrNojKzQD8yc1GZBk0ljjrFjf48X/8A?=
 =?us-ascii?Q?ErO/rVkM3FGmfDs03RL5akpIED1wB2T4fjjHCk1PMprwVIhtYirABkDW7p+x?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 796c54c1-a4a4-4cef-0257-08de06424f34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 08:11:40.2371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGWBV/2ER9N5mg+20rDuTiY3n6rY1hjtGN4IewCuvx9FdiAL96KAnbCZIM797fRAfl34OqDsVV6AukYs32bbCERHPhEzZe2+qHQJaNrW9fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5020
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

On Wed, Oct 08, 2025 at 09:53:00AM +0200, Thomas Monjalon wrote:
> 07/10/2025 18:15, Bruce Richardson:
> > On Mon, Oct 06, 2025 at 04:10:52PM +0200, David Marchand wrote:
> > > On Fri, 3 Oct 2025 at 10:15, Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > The ultimate of this patchset is to make it easier to run on systems
> > > > with large numbers of cores, by simplifying the process of using core
> > > > numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
> > > > shortened to ``-R``, is added to DPDK to support this.
> > > >
> > > > However, in order to add this new flag easily, the first dozen or more
> > > > patches rework the argument handling in EAL to simplify things, using
> > > > the argparse library for argument handling.
> > > >
> > > > When processing cmdline arguments in DPDK, we always do so with very
> > > > little context. So, for example, when processing the "-l" flag, we have
> > > > no idea whether there will be later a --proc-type=secondary flag. We
> > > > have all sorts of post-arg-processing checks in place to try and catch
> > > > these scenarios.
> > > >
> > > > To improve this situation, this patchset tries to simplify the handling
> > > > of argument processing, by explicitly doing an initial pass to collate
> > > > all arguments into a structure. Thereafter, the actual arg parsing is
> > > > done in a fixed order, meaning that e.g. when processing the
> > > > --main-lcore flag, we have already processed the service core flags. We
> > > > also can far quicker and easier check for conflicting options, since
> > > > they can all be checked for NULL/non-NULL in the arg structure
> > > > immediately after the struct has been populated.
> > > >
> > > > An additional benefit of this work is that the argument parsing for EAL
> > > > is much more centralised into common options and the options list file.
> > > > This single list with ifdefs makes it clear to the viewer what options
> > > > are common across OS's, vs what are unix-only or linux-only.
> > > >
> > > > Once the cleanup and rework is done, adding the new options for
> > > > remapping cores becomes a lot simpler, since we can very easily check
> > > > for scenarios like multi-process and handle those appropriately.
> > > >
> > > > V9: rebase to latest main. CI complains cannot apply v8 patches.
> > > >
> > > > V8:
> > > > * dropped the final two patches from the series, dropping the new -L
> > > >   option in favour of the -R modifier.
> > > > * reordered patch 11 to be with the other argparse patches (now patch 5)
> > > > * added patch 12, which uses macros to initialize the args structure
> > > >   from the arguments header file, avoiding potential issues when we add
> > > >   new args.
> > > > * simplified and consolidated lcore mask and core list parsing to always
> > > >   work off cpusets rather than arrays of uint8
> > > > * enhanced debug printouts to also work better with cpusets and handle
> > > >   core values in those sets >= RTE_MAX_LCORE
> > > > * for completeness, ensure the new -R option works for coremasks, and
> > > >   for cases where no explicit core-list or coremask is specified.
> > > 
> > > I was planning to merge the first part of the series (before reaching
> > > the cpuset rework and addition of remap option).
> > > 
> > > I am facing two issues for which I prefer other's opinions.
> > > 
> > > 
> > > - First, I see a change in how non-option arguments are handled with
> > > the switch to argparse.
> > > $ ./build-mini/app/dpdk-test --no-huge -m 2048 -l 0,1 func_reentrancy_autotest
> > > ARGPARSE: too many positional arguments func_reentrancy_autotest!
> > > 
> > > Passing the test name after -- does work, but it was working without
> > > -- before the patch, so we are introducing a regression here.
> > > 
> > 
> > Looking for input on how much we need to handle here.
> > 
> > The quick patch below adds support for ignoring trailing args in argparse,
> > which means that the command above would work. However, gnu getopt also
> > does argument reordering which means that this command works right now (on
> > linux anyway):
> > 
> > 	./build/app/dpdk-test -l 0,1 lcores_autotest --no-huge
> > 
> > since getopt moves the lcores_autotest to the end.
> > 
> > Is this behaviour what we need to emulate too, or is adding a flag to
> > ignore trailing args sufficient? [I'd tend toward it being sufficient - mixing
> > app args and EAL args together is not a great idea IMHO]
> 
> I am in favor of being tolerant.
> I agree mixing args is not a great idea,
> but rejecting them is not really kind, and is a regression.
>
Disagree on it not being kind :-) but agree its a regression.

I'll work on a new version of the set based on your feedback.

/Bruce
