Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F1CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 09:31:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3F0240661;
	Thu, 25 Sep 2025 11:31:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 56159402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 11:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758792709; x=1790328709;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d1ZLDlL3/0gAA3TjZ3TkPaPTEzIUzXTbW2lIoj6w64E=;
 b=akULoKYXSHfcm9Vo6OvnlZ0R9o0f44839FZuHnPLHEbuYM/B6KQwbvqx
 n2kYqlPcDwfNHhXBjCjvISGQxflODwARI85IEXFg9FWxNEXcf9GqWTEX0
 9nnoBOgR5MLDk50O5+4kK/ffuufwQG4reNkEgflagrkcGBbyehfYCWmX3
 RAKHMgd5reGVgpwDNxEkY/evhUmpddiyGGaGpfVLvPq0EdfPSSLWbTEmw
 bCjq3JjNKO2HvUJ0wy8H8jQvZ/XDdo5WcaDOc3+/24z0JCwT5KHR3bTdO
 cSh/G7RLouF9PEU6tc2Hn6oL0ETQHaSeuKluPMWqxs29s55BaY8gUTBCv w==;
X-CSE-ConnectionGUID: q7E0M96tRry0dBo/h9MrXg==
X-CSE-MsgGUID: hwfuxQKUSnaTOETl+ZVeSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61213150"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="61213150"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 02:31:48 -0700
X-CSE-ConnectionGUID: 3dRQWnQXQy2O+VZjBAj3+w==
X-CSE-MsgGUID: jIGUBkUGQNi6PRVxBXExww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="177343633"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 02:31:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 02:31:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 02:31:47 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.21)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 02:31:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJXqm5R6IX9qsOg0+PxpT1Mq1VAxvz7vnkZJJ7Yz7SieXywfVSQJA6hiYxuO1tt28M2wU2DEiHlUw7NRixS9JznttHra7Os/H+zyEY8MOWwya0wZn3fSMFUTWTgadfl2byZwYZ3nfjIJdxUUtg4wX3j4DILMqjQIdsXJRpEK4RA0V4u5xPTV63flcxq7tS+U4yLBWdl4jgXcGB7o4uxMd/3fjpN6Sx2M3DK7jeCd/LqDNPwofle3lP2QmkL5TCFfjMcqsvO3uLjgoyx9qgUGv5EJguzRJn2UMS1oUme1GvD+46fAaumo5rs3BGJ5yZ/Um7gfHp0OH2WEFtfdJuzWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjM3jOYoo3ePwKiHxPJu78sZ4ODVJ13UVuuXxn5Z03s=;
 b=CkqZOCZtMhVaK5sxUr5UfIyo0rwunv/gUIucZPESObEQfd7OofSSkZA2MbnXM+KBImhgtzZM/R3Hqtgmrpk7SwF5pRAjxQjddtX9sHFqAcDb8EGndZ9uh7nTXv0623tesjCa5hZYOppXjOSC1l3JyuIqxURbfrK8SotyxxQNNvf+xoT0YIO5WhyTi8AYi3Q8M8t0O1CJbOcZlA8khrYBqhFQcjsKoblW1U03J2NZyJg9nKZHWv6X7nDtzDzxNHgdauiJCQjRAXXsI2yzQ9+ejL6cIDWuscZ2BdxPMw9tqRqFag+IA9y27yqoLf5uVmOCdptEO2dDnb56hO0olkOCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB7325.namprd11.prod.outlook.com (2603:10b6:8:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 09:31:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 09:31:44 +0000
Date: Thu, 25 Sep 2025 10:31:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNUL_Pl6Hf2bmcJJ@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
 <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
X-ClientProxiedBy: DB7PR02CA0023.eurprd02.prod.outlook.com
 (2603:10a6:10:52::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e098d7-6d16-4652-5833-08ddfc165756
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zvrauV3wqq12wentlitTrC+svGOdg7/K10zqVi3ANX+eENAonnCe/yOLkIQa?=
 =?us-ascii?Q?ufnzg+oqHOKvYqVUKOPXNpAqVoOBaLHbE505xMosef+h2S4OXKnTt9WylRz6?=
 =?us-ascii?Q?RN5QNqsGxaK+APEMhvT4Suk2Tpc26TCOqV5q3Xnt/KjNMTq57ex8VljfoyqX?=
 =?us-ascii?Q?NvLuTeZBlWxMoidI9CC8wb14LV4UXvFkxsNGIWRVv5brmYipmNnaB5LV1htm?=
 =?us-ascii?Q?aDryVU8jwUSe/F6GEszePmtWHKlbVGrhcgIOuVYGBx45IW1u4G1b6WzP1BjX?=
 =?us-ascii?Q?6eTsKhIWrKVccleAuO1d28MTiFa1X8Sz4wp2z06LFO/TAHN/cYWoNLDzvzzq?=
 =?us-ascii?Q?aFVE68CsmJA9dbPvyx3MiOodC2YDdRboKAXOrbV+JgXsdvM+5Eau6uCW9hon?=
 =?us-ascii?Q?DV1iimRMG5iMI8jBvLLgxhgjTVlCuGiQk9YIZ6NpPMK9Y0wiLWTmZLw3TH9h?=
 =?us-ascii?Q?gMlT8rM9Ctt1d3Gh0O56hDrZ2AMWFEtY6HOyo3DB9fhADDRxkzwVDcEYXH+I?=
 =?us-ascii?Q?P6xJexjrRS1USmJb4oL7ieERD76LBf7DOkAEcMO37JKkobib4MiVVUV/1nPX?=
 =?us-ascii?Q?GzLeSDH0Ck2DRhdVF8KJ+TFgY2BC+wuuBf2sqb2jqOJCvcsaEEZ/jcQSab6P?=
 =?us-ascii?Q?6yic5zPs2JobYNMPqIPTwRpAjlbp9nTWNwfODJqj1HnTpYdwSxkHeXNV2hut?=
 =?us-ascii?Q?aBGStISuEoL0Pl7EmusDwB+6/WM52VuKVDJupqbL4Ip1bYxpxgbZALtNajG/?=
 =?us-ascii?Q?O12lDZtRa+m3RVkQ6FzlRzNUMe0JVd6abTv8THsEnY1o3gOMEmj2FaH0ekoU?=
 =?us-ascii?Q?GJGMRJbu7D7Z7fp1Ha4zYbiTsm7vSfmkmdiCLJk9KsX/385E8S/Ktpv+7SzF?=
 =?us-ascii?Q?DUZKu49Kgjn2Bx6cPJIpQWHW56h0Z+6RwhF7zUSrSeHz5KQEJzLAoDjbiZQ9?=
 =?us-ascii?Q?BMtge81s2Zd1wqqwSyzFdgXfLUAHWVwJEq0wcxibJtnlRpdQzfC6NhtN2CgR?=
 =?us-ascii?Q?IMS7hRNAvQaZqH5pcbEwpDwD2CFzgXZnIXTt5lS4Rw77LFzRYlccT/JVeWfY?=
 =?us-ascii?Q?uic+4ZKXyRJ27d8bx2i11FxF10HA+2CJYR2AN8rZKUeH3NIZnzXdiq3Yddvl?=
 =?us-ascii?Q?NE4Dx8/FmIjteZLrJrN4MMax+bg82ZR1AJDdU5R6q9H1ie6WBug+wpD7g/EO?=
 =?us-ascii?Q?zhqEsXf/C2YIN9GxaDkeWcHQsX0EseaehHwe02z8AI40EQTKX62W+Nh2UosB?=
 =?us-ascii?Q?qAqAzOSxmNOjxd8T2ckH3gMh1biNlvlunIz7Ga4zBzAYDbG6yXFOLgO/AvMz?=
 =?us-ascii?Q?Msz9H7aRt3CKV8sxwkK55UlRAUcWkjIrdARmDR1iTBSVtVtNyqHwPOk8+XNL?=
 =?us-ascii?Q?/C69wvcDK6W6dSG20Tq1DZC7M4hL2QEvvUEU3F2/ZWjm3ylAC75BJhpmm74W?=
 =?us-ascii?Q?EYXvGDwXsck=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6mp8B+2S0Io+6UmYXFaLbER5xL1mUTrqDvcw4uSYKQqwJb28h3XNyuo/for?=
 =?us-ascii?Q?rjSUcb/Yz8RFkxcCbFoOsQ9PzZ+8uVhhYWsDVx5kvcz8qmcGVAmBkWEF7zFE?=
 =?us-ascii?Q?nRyW+UBg7Z+l3Sjq3S9Zr9Qo0916p5U/2PCH7LZrzPDiPn5ydoqUypu6GzcU?=
 =?us-ascii?Q?1EiJZYB6oBzKOVK7xQyVeHftC/VN5websCvWdFCUatOE5GD9dyrguTXpCCdi?=
 =?us-ascii?Q?dABjP5Is7Bt5jMHU86WHEhAUDAiqsCNktCZEITsqL+G7kr9FNxKa1d0/cfdD?=
 =?us-ascii?Q?EBZO4aeVkqx6RprVi+THjs3mfDxmpKwoOX+NnL7ctyQxc2Y5uMP7PGvfBJf8?=
 =?us-ascii?Q?4ieWC8IEWU8IQWz6Mb9r91p30KT/Lbc9CG4rGlMdwdujx1eD520FHBXurAhc?=
 =?us-ascii?Q?3vJf7vDuoz5XKnvZdHCSsmayYV/vIUe55PqAV8oZ2YAAxdmeIVXxU3pSD5l+?=
 =?us-ascii?Q?cNAzdVHO0NvcQ3Dpnz7gxbZBCKgPDPH00zyqtPxrQoquPSnIZ3U/W7KRffgH?=
 =?us-ascii?Q?qsAj/chmsW6kFJfy1j7by5rO5a4t+vSOY4e+b67YE6p/8Fsvsrcm6C8+w492?=
 =?us-ascii?Q?pxFmG3oRt2pFszzFVmS55e+mJPUoOUzlFGggFsmvZ1mafR+KEljTEdszdwRe?=
 =?us-ascii?Q?CHwSjrecU+ed33RXHob4VMBtBOr/80FkGbSspmMilQdqqBpISM2NGdm+sS7K?=
 =?us-ascii?Q?cABGccFi9GGplbK8MGADYAs3MuFjiIJXDa6LAVdgGh0rl5n2JEeeBBLWJjJa?=
 =?us-ascii?Q?+Zwgptn52nxsfCfXsaxhWwQeKoJfMtMImU5hKLYcYQTZNbh+obuyYkK5whQw?=
 =?us-ascii?Q?Bv7MvvWGvm6MPLG53li9uYFNDc+iuXVmm8jry9eXc58RUYBQbfaFuYZxFMja?=
 =?us-ascii?Q?0z4XNNceku0ceVyO16GLC48UFbq++FDN2DpyShGQIuonVJLdkeL79L5Q9LpW?=
 =?us-ascii?Q?5jT+ORo/skqwnvy1pSeNoYK7ZHlRsDwCmwezkKBnADP7mFdPQEpm5tO3nM+2?=
 =?us-ascii?Q?ugRkqAbJbbEEEnZG75WFdpn3B2w2K5vYxWbnn2TEiZgClncviv3iV/nK4Mj0?=
 =?us-ascii?Q?x9shuLB+fAsa3/qqv7r7DOlUK8uJt2472bYQpxiUtNGlUFkRZXSwuJweNMlZ?=
 =?us-ascii?Q?LC8THH6yIvkoqwrzPrWWl87ctI26c6QC25geXKCONQPNgCAchg8yIVlPfALp?=
 =?us-ascii?Q?GjDxq+YLEpB56YOfyv+l+ZJbw7eMBPt3i/yvBkGud1FgbIOC/9LZPG0FkgRc?=
 =?us-ascii?Q?qb+CnnFzY8t1kgncXtiFVu3mqKWWrICYgoh3XZsvH5JtMfJwnKcJiICVZDBi?=
 =?us-ascii?Q?aFci1Hz8reP9OdcXhMbXdFUPfnObsR1JEEfJtB19dn8UIL2xFJ6JLomL1AQD?=
 =?us-ascii?Q?FUUBqBZ/Wqsb/Nd2oiUBnlV8CF9XQwJTU/7GcPhecefZnVtasMLRRyoUL1T4?=
 =?us-ascii?Q?g9Dd16q8cbyDUbHhSko/dIq8lu24evj7Kel8AqbzDno3JhDEO5snpN+Bq087?=
 =?us-ascii?Q?SlR97oX9an5puJcNvswRzYm/C+OQbIf0kKyIyzH7lmNDyD0UCPNhZF2MNFSN?=
 =?us-ascii?Q?bNIY2I87XRQ/oQIFaJA2567GlTi1ZTtQtPwMToMq8C69Z09ngqQZB6msL2eo?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e098d7-6d16-4652-5833-08ddfc165756
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:31:44.2388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeoD8vVxZZTdWFbni4OmoWsVhoCrNPZw97d97M2gJjp1Rr+GMxIiqAcZ9qvX96YN9FQtww2Q9ejsUJYDQvs50fZfCx2CPePCCU0zaaksS4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7325
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

On Thu, Sep 25, 2025 at 10:42:47AM +0200, David Marchand wrote:
> Hello Bruce,
> 
> On Thu, 25 Sept 2025 at 10:00, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Wed, Sep 24, 2025 at 07:25:34PM +0200, David Marchand wrote:
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
> >
> > In general looks ok to me.
> > One small comment though - can we not have "staging" as a top-level
> > directory, but instead hide it inside the buildtools directory, or even the
> > chkincs directory? I dislike having too many subdirectories directly off
> > the root of the project, especially ones purely for internal tooling.
> 
> Well, at first I was trying to change the whole build process iow rely
> only on the staging directory and remove all the include_directories:
> directives from the declare_dependency() objects.
> Libraries and apps were ok, but there were a *lot* of complications
> with drivers (what a *huge mess*, especially for NXP drivers with
> "compat.h" includes, and Marvell drivers to a smaller extent).
> I may retry in the future with some AI tool that will brute force this :-).
> 
> For now, I gave up but did not reconsider the location of the staging part.
> Moving to buildtools is indeed saner as it is only for the check now,
> and I can also make this staging stuff dependent on the check_includes
> option now.
>

I wonder should we just consider making chkincs an install-time job rather
than a build-time one? We could look to build chkincs using a custom
install script (meson.add_install_script) after the header copies are
already done for us. That should cut down on the complexity within the
build system, but it does mean an additional install step to a temporary
directory to get it to run. However, for use in our CI I don't see why
having an install step with DEST_DIR set to /tmp shouldn't be feasible.

/Bruce
