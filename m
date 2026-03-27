Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246CE10ED65C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 11:43:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4401C402C5;
	Fri, 27 Mar 2026 12:43:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1641640280;
 Fri, 27 Mar 2026 12:43:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774611816; x=1806147816;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uiBn+sLRqm4bpH5xRimwgGAPZHrBt4ke5xYI5gGM04s=;
 b=kKP2NnkiISlam2UfkgNPnFi7yJB5uSi1d3ErRp68kBxdASCk2SafQ54X
 1OFezpVu8jsp8hFOSiMvjjrn18lMJRFY4GquyfH5mzNcx+vLTZUsMsglA
 tNsckzzSRNdzgMKjKgUb0iI0TvrsLwfQESTsj0H96ASMWo9wVDfPPS3I/
 YVnYx4Ns7Y6tqUuZiNtkm87n0vJdiwGPRicultSTlF9wWcR839LzQnQUQ
 jh4wsgOvE7liIbMAc+vPnQ+Uf2np5eOcxctaahgVnhTKnqHwoR+ZhaM4T
 kCrpVGn8rvUUPpNScD3BKkA3aW2fMUnQN4nVZwVayCfjhJN+Dh9KHUXPP g==;
X-CSE-ConnectionGUID: 3szjQJh1Rt64bxHJfzhoHg==
X-CSE-MsgGUID: saG1xyzpSXqwqtq0TrmpYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="87157401"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="87157401"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 04:43:34 -0700
X-CSE-ConnectionGUID: 29qWM6yUS8SeoQdR0lLXkA==
X-CSE-MsgGUID: FfrtWtNlRECBGYR3AON9sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="218675479"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 04:43:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 04:43:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 04:43:34 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 04:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGDH6PPFVASV1DpB99GPTpPx2JQyu727VGBQZxJZMAXfeHoSk5LEsKnq7tG679nUW7ir5lvpAQX8ojgAtNrhoZrU4rd5ABLBCOYnvLr+/7ucXzNCSFeOSDSufY/UBeY+jJzMyoLufvOSOKUuaz92LnY2GX+y+83FtpzvEIEl7e0tJIrSYEbvgvlnsNxyRRVeek8U8cMPd0rN63DjyMdifVu65N+ZApYQoE+royLTl2xAUW+DcfP2A/QT6RjNbKUyCcENUGsZ92GZhnraYDLgDl+3bhv6HuzM/PeeBBGomIhWh3V35+OI8Hkg9jb2m8rKBPS/S/hU+QFCFtQ/n71gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MfHyXCPSmqQCewQgI2XAh8O72WVL+QNJzF+nlXViRM=;
 b=j2CrGHO8/5dSpQl0+FXgqeneXtVEnG5qpug1HDSpYMjajyVjBlbaBV8k0nXjctF3/r+W+dYe3x5vss9ttlwV6U+b5cNFxxkeVvE3I2J59DBzXW9S9zzBN4q+05+NYnjzIGs5GYLWklBQFLg8WhiblMZgSoSP9IQi8518L2HAE4y/q9nybHCmt3BMusez1zdAdRRnQcnAV5BFKtihFpnnBVEhZ8VQWPscFOTW5gIVT+x3Txva+/SLYHuStqaDk5/BH6lDBiEStlA4uW6jSoPqMOK4GHsQ8/tgKFLJGsnnctZT2n4sjrKQDN9Y/7tvzxAiuiTVMRrHD8P81kNCzbfVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 27 Mar
 2026 11:43:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 11:43:28 +0000
Date: Fri, 27 Mar 2026 11:43:23 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix RSS LUT access for global LUT VSI
Message-ID: <acZtW2K9yi0ET2BO@bricha3-mobl1.ger.corp.intel.com>
References: <20260325163959.3968209-1-vladimir.medvedkin@intel.com>
 <acZqMkNeJgCneRga@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acZqMkNeJgCneRga@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU6P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8bc764-9362-4dc2-9732-08de8bf61036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ym4HF/UEhSZrQTvCYdvD/XUtAlr/BXZ10D1Kaol+9yuxnDtnUS3Or/NoulEqpydHabB1OPhydeh3z9++KqOnnRLho2m8igCjYqNAAUpXTrZqYaekfdvSY4vlg9d2pgf76MO3+BkC6Q/wUKTKUeWp8nUat9R5/CbumDYKOAHFNNpG9e/vMmY6GbOIX00CvcqrN5/2xD+o87yxelLxsD1BctiKlxC+LrRp9PYHanhGU/UqkDxCKuDydmOKvFmGLVLQVUBYM3BbjIuokXgUmFxOSZm3E8Aygw+cqnZdyUG0u4iqV7w1engJSFtj7q+oyIzcNwZAQVG6+yt3vyhO02j8MMjNp4HSVOu3yJ9vXaPrTobezzDjtKmuIu5tKXnTkCLOO8dL2OJ8y1brRTj1jVMgEeHD8mnX6Mxb6nNJSAnTp4gn4kACVd5R6x0jFvOhK30RdImmPx1mHkBVBBzm6BWUr1mUVIoX3ok6yN89Xt8HQHgj3wpWF5bjVkZICe5Zv7NEbFdQurlEhvSb4nwEtIp+i25zXo0pLclW5rwVGOuKrgIviHHSg3NDOh2AbM6eJM9O4qIOF5QMQHFAqxj7D2Eek/7ymN5ZX3oUnaiNk1KyvanAxR80KioU2QFZAEbUidmkg3h1XKNdf02Du3BvLk1b9qloula4RbzhswpkjEMZNct26REWlgnaJMLhRdHwul9cftZupK+2MXuyq+UOrOQYADPThfIu/g1gCZQ9xOcEQe4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rldQ3y4KfTNOPIVAW87aUmPXrsLsK9upJWqxPfJ71b4WcWidiWXUSCVQ+FHf?=
 =?us-ascii?Q?F2T2Ce6MMoq/YRdoyDt9/eaGKN3FHdQnFFISidB8jyadaMyWblihZjrhK1Ll?=
 =?us-ascii?Q?pgOwzjPOMUqkwdW1VsV/8+zCNgOXvZvLqCcsMo53yYvAdSFof0OT1TLbg1sR?=
 =?us-ascii?Q?g7PMWZ/mYLXsWwOEe414BVVnZioS89+I493EvhVh58I/1SOoNyu8LDES2YqR?=
 =?us-ascii?Q?dumBVWrSrbHQ8SsFsHYpkeDqYJkFet5l7w+zhrGlZ9YaibwozG3ZV5F22Iye?=
 =?us-ascii?Q?RFCZ4K1j1G9znfOixj+E5IM8LOQoRAkvCJF9AUwUBBtrnIeuhfJeeLVRfUGC?=
 =?us-ascii?Q?PvoHAI3SpJRGJ8kFzJ7m6PoBaV6OhRaZOm4q/3BF/Xp5QfTSdEEYnIATna1h?=
 =?us-ascii?Q?rVJ5gvAp//qzcIX7Zu+yaNwnQY71Nfyb3YG1pSc+E5gwrLcrlqsRG1+v9We5?=
 =?us-ascii?Q?8Uv4YT8zOvlE+6gcmULAwIq12JAu7oGgwmZH0BR1k97J8A109d3N3ksmNVS2?=
 =?us-ascii?Q?Y+H1wIi0cnyrEB+PDiTUITRqDRx9cxijtwR0tSIUfH0ITTlpsyyJuYs0HxH6?=
 =?us-ascii?Q?b9i2RKCw+BzxeBfyF+imIS1+lX1MBz02hnLfBhQ+NIhBVzpGzLTKu280gAFt?=
 =?us-ascii?Q?8lbY2jtFnNb0DipwcBPgv97Zk+6H4ijG4/FyTAJIVwWi9+q9CFJWWcHGMVXh?=
 =?us-ascii?Q?lKHEEm+TgBieEslmVNFz6vZD6T5bfdRzPt9gvgFOupD3KNjhaKwmhim8vpRP?=
 =?us-ascii?Q?WzyeZBBecXSMhhIh13/15TPR9x42oJUPDRFkITb+rdt6jnO+3QJRbz4ZL3+a?=
 =?us-ascii?Q?rl0L1beW4S7bPuLu9ogTOJz++TGDXx6eH0s1CmZb2GvcXmmNZO3nGUWp6Le7?=
 =?us-ascii?Q?JDb+LRW2ixXfzYNlsDpxpl0ZCdgLkFB6Sj2MNxWGzRMhexr58V43XRZoZptW?=
 =?us-ascii?Q?VpYSWkQjDMeJWQ7VNs/82cuw30AqZFrPZSJedW4D/FYo9VhL1NoHHm68pECs?=
 =?us-ascii?Q?QGbDvIZ1CG9BSQDluonKGPW8zcY2BM0CwcFejTWiH6MYePLdy4nbnUgBz9Mq?=
 =?us-ascii?Q?mO3nBG0SGdcLbaYCHZU7eN2RPiZp2qaOzPiUlewvcaq1fbYl+KpT+t9MfSZs?=
 =?us-ascii?Q?2bnDo02Sl32ipbwtidXgwA8W22dU2FG+KWpacWNhxqiKWvaBTtvL3jUt21dh?=
 =?us-ascii?Q?U84eCzuW/vLnEOA+p8s9yLx6oYY0Cmu2lGbpuOVmTPLqyCeV9QmtgBXUWbv6?=
 =?us-ascii?Q?1v7l1XqzE5jV3Si7gBHg3SFP5Nm+BtdqA+7sO0ygZ9vwrh/7f+Ww3JBnQIA2?=
 =?us-ascii?Q?UwPZzqo01PpVAcMmQSP9WTzG0W8W01KDX9Yto4G1VetpsBBmH7Ix9mzULrD0?=
 =?us-ascii?Q?SlM+y3bTQCzLUcy+k7AFP74yeaVVN7a6pniOmolRPW9gZGKTxS5g/caHN2Nb?=
 =?us-ascii?Q?Ybf4WdMJakLWXwXPyVJaSrAWKBeTri113NbZlUrLYhTZmWG5ap4iU5eudOGd?=
 =?us-ascii?Q?9bgVx+z75ODDxbXpBxBz6fo+ANXM618ZdWIo881FJI08yVYJm+I3zZeOlKjp?=
 =?us-ascii?Q?9A2erz1aUewPmc3Fvm+bOl+RJAOczGM9x9ahtssAzB69/Mg9WD0C/y/DNDAT?=
 =?us-ascii?Q?nhJkTsbNv6u+GK6+tXWcpQiGXpNto5qa0U3FCX7yppIEBUkJ8d2vtopj6PgI?=
 =?us-ascii?Q?Y/Xs07RTrxd6p1FRaffMMp6RI+2wPHinqHHLKGMMhMnzcmgP8jlx1krg8s4V?=
 =?us-ascii?Q?e2vMvbF9EvI/NVnidrr/sHLmkSGeBWs=3D?=
X-Exchange-RoutingPolicyChecked: Dvc0IUvtQc9wtTH/SOhzAuJ/Gos2foYgUEJHteDV4JOz0b4kKGti0NLzOdOm48/XWg15IxeoNEOQSG8ys2HaHKymeBGNWg+7HprBVNmEtseMDAnJQ1yH8S77pgcHB99KB5G4F2bAN9xWY3304LIe7WFQMVTSflcsr1acht9uxDaW8qXDznsxtRqYnsKyZit4J/i0/VHnUP4fkBwaluOMNHvztXeVsAfRqoyIk5x680jWpsiral7P7tR27u6XbQcG1diYkdfdw8G26mwZXB7M9gNCGzBkcBvgMN+51i4M5RZyUJRmoE+skpg1qAqnscjSFpiJzHl+eoIoFjhIdi7EEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8bc764-9362-4dc2-9732-08de8bf61036
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 11:43:28.4357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw/MZ+oL+JU1QhHMgnZWQ6wHRenulw/5rRhdfuIqMRVm5wxSwg8HqjvkMUBY9E1/aPpdlXCE143A89Wza3lgPATD5GA6R8LIjEL21Zwhrkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
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

On Fri, Mar 27, 2026 at 11:29:54AM +0000, Bruce Richardson wrote:
> On Wed, Mar 25, 2026 at 04:39:58PM +0000, Vladimir Medvedkin wrote:
> > When global RSS LUT is enabled, get/set RSS LUT still uses PF LUT
> > parameters in AQ commands, with lut_type set to PF and global_lut_id 0.
> > As a result, the operation may target the wrong LUT.
> > 
> > Use global LUT parameters when global LUT is allocated for the VSI,
> > and keep PF LUT parameters otherwise.
> > 
> > Fixes: 193a11ffd3e6 ("net/ice: adjust RSS LUT settings")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to next-net-intel.
Thanks,
/Bruce
