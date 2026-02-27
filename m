Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCEFEFB4D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 13:51:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A441402C5;
	Fri, 27 Feb 2026 14:51:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6095E4027F
 for <dev@dpdk.org>; Fri, 27 Feb 2026 14:51:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772200317; x=1803736317;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=26+SJbHIfycoGts89TciO40TVLnHGB3CtpsdcwLWDZE=;
 b=iCZtBiSEE1A1a3NmoJz1RCOwb8hvt95WC7sXvjLNFowPDMzKRJTjl3zl
 PGVJFbAn7P3CjIWZbu4OhMY5sOEOsyKBlWbuLnIyK0/U4ibZCfKrIh2ac
 F8GmCyLiZcYgfRQxLpixIzNJqyTnFtdgcC/CoKrIlVNY+O94wCl79PjKr
 yS/CkPlmHnBgyiqWp+6Cd6eyyMdXlKuI61y3ol1gjksDinImqp+3Wpi/P
 X8/KFei1BNuRoQis91PhJvXcMPsOx34MvawvRYwB3fKpWDSoX9x3ARHa0
 f1YT6pDt8O/pl5xsMaF35qVvIPCOLXG8vIufrpTTAknaBZ5kCIMVV/Gdz w==;
X-CSE-ConnectionGUID: 5DBaRSMNQnadXiTuQNAz2Q==
X-CSE-MsgGUID: sfET1aR+QBCHIvAGvJ5SxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="83916359"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="83916359"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 05:51:56 -0800
X-CSE-ConnectionGUID: 4y+1CbMAThalUOXT6GjGSw==
X-CSE-MsgGUID: LdO2jz9WS+qEGH5ooa7GWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="214752797"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 05:51:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 05:51:56 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 05:51:56 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 05:51:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YveZNuJKsGZBY/SNtxz1TI0vjFYsnaZ2BiHN/x6NyI1v9yUPbUANPqBUY9++qJx39S5BNqumsho0EJ9zR6sRCi0Tzsm/8fCudi+cw2SGcejiJBL0zWpZlF54i9DF3+W8aoJ5MvMqBPjU9f8RqA4363xR7P7jrVSZGXKSAN+21gMUPPnYSOlHjJn8PZJACJgrj8D37pd5UveoyIS/IpVHTx+t8fwyb8o2gzmfT/6P4lHHH1jCST11L+fsbnWnfITLaig4NP0Qjv1kiduszVZFM7HIFpmc5CwzwPGhcK13tg1Uhg8hQ0dLXaMR+e6j04iOzsy83l0Rnb8pC+Fv5C4JNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plA9pnBMJK8fle+7XYSOGLHITKWQaJn6+DySyWkZy8I=;
 b=DDw4OTI+RMec8jPULHqW3GFqEh4dFTEt6Vxmrq0Co93iadaV5Gp0ZeqA7r6mFIE+yTT8ZKF4QHXaRNMVqKBbq0L4gx9AYP9oi/Z97NlLyPJeQZNVvs6cAbLjOfy88UvGpadVblpEcgCOqpw2IFpCHr+yf8lhERk4nvg/VZBoEd0yZ7W4Zy/cqutDQCo/m1DeZaZhVYOgJmlwPXD5s7pLUSuZ2yXSevHkPjOKoXyFLSP2FA7d3yq/bHxTz+bVlNJWPumwbLSDdWpbzPS3bVLCqYPfCbqxwdegE9xkCQoqnM+iDkG5pQpUzm2v4n0oX7LQtp3nFofYAGp8lWbrURsfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SAVPR11MB9552.namprd11.prod.outlook.com (2603:10b6:806:4e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 13:51:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 13:51:53 +0000
Date: Fri, 27 Feb 2026 13:51:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: David Marchand <david.marchand@redhat.com>, Robin Jarry
 <rjarry@redhat.com>, <dev@dpdk.org>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC v2 5/5] eal: configure initial device probing
Message-ID: <aaGhdEEgxiA4Z33A@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-6-david.marchand@redhat.com>
 <DGP1R1WJWJGI.1TU6RUU13GBYQ@redhat.com> <4506449.8Dcp7MaWsk@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4506449.8Dcp7MaWsk@thomas>
X-ClientProxiedBy: DUZPR01CA0316.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SAVPR11MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: ce246f76-70f9-43bc-fcef-08de76075d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: TzV0Sa2vOfFRnKbwCkFZcqIljwKiENmo6SiTcGPfDcUERQmTIVbpctffCnFD+TYOwSkH4sV9H1i+xRXBq4v8VyFgCF+jtZYcWR3Gs5OT599WtAg+x35Jrc0oS9V+vJ3spseCCz1it+o2sVc4vsne/OzYD7KZPJeSmfFRYvSwSXi0rbfzLbG+P8Et/NzqVSB1cF4jJhYKUXuKSf2EKMkcqf07aYrKB0XGpQhlW82+ltwfcSTnEQ+ioskAcb6qJhXwG1SfuosREIQiRCA9C/vk6xO8Z13aug+XcAxLa2MrGGzDUc8nhwo/mtqpg326B76nTvVt0a0AQed2k0Ykdb/Oim0x6YSCuAZ25VwwmUkMcdfHNhGNPqHV+MW49xaL3vzfz3c5ZbiQNuXyoWwOP3T4xv9jlLxbbFw17eNUEXkzFJHIeXNnBVpmCvUETKYjPsG5ZxStTD2geThWPtkoGFPsMUk8gRQFZLorA4tnk1OUOXb9d0W9/IahKG0GAah8kmeFdP+YkpgYwY2jyLieyqNAbgBgtUA+UFkWMgqKQrRfbKBbW8RTc5BdLo8AyVjja+C5UXZlzWHGQyUfYlu4KmMAQ6/KdURbBmGcqeOsbFE905Fp5U++sECajNTI5M2uNc6jJBvRolMcb9T9H5qu1eWnQ7XMyYjbM5saI+qK3iyCxW856gR2l5hmZk0LEeGHkoPWHf0RwBDZKPCApD1kCVR8AyTj1YrcWhWtuJ882OINBG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/YAAE62QYgVN2wpUDqn9cDTaBKUsxrdPxuUDA7oAeAZbG6yNsb8LZ2t3hVsb?=
 =?us-ascii?Q?6gy0Mskh7CRfd+2P8+y5sB5S6F+SrgboqMu53ZaAZb9htQmaf7Q93el9DaZE?=
 =?us-ascii?Q?YC+G5l8VtTaTPjk/+edbdcQZW0MnTkqXppPgaQfgiBmt9y2Ai1nVm0t9w46x?=
 =?us-ascii?Q?1J/vEoilZDmgvAZ0Ik49/7sLFwc+XX8NHYppd/W0gYHGYJxrqU048OONR8gK?=
 =?us-ascii?Q?31/4tKMJy4A50gewYlvJXdZDAT1lV5knh83KtkRZ0FjnNsPSXM+4gjEf/o9f?=
 =?us-ascii?Q?LwWvk3myguJ14XoPr29wSPw3tNAd/HgN1gR8S3/5KSZ8hOqjaPZMHMN8zhOk?=
 =?us-ascii?Q?OfQL3MOhUj+6cN0MMW35+2OF0hRv7/BjjmPBpdmLP4h6GHNBqy93LPqtX0uG?=
 =?us-ascii?Q?yx4sntMiItkhY18crf0UNTHXufXWmUCPbCNx+wpSjccc+vf7in1wzEfBGECr?=
 =?us-ascii?Q?1tiDo5EWqUkcl3GFEqPA3REbGDEmmzKzOOxnl2/pLIfNSJ/0C795NOlhA2V3?=
 =?us-ascii?Q?6uv1p7m8ks558dHfF+3wH3XslZyAv5CRMmpaFQxBa+dbNihQ0gHDRydYkPff?=
 =?us-ascii?Q?EQcohQHLpaZoCeiITJzA0ce1aPmV1UjgBnPui8hnIi37vn9mbyhiuugDRqyr?=
 =?us-ascii?Q?uTmZ1oYGPXGOkFxq8SGrY7C+xkKWgRlXjvZJD1d9tbFYy9k++/xEfbRsYtKu?=
 =?us-ascii?Q?eMkb8F3R5jMkKEuBrIOKnsI+CHN4T//fzlXbJnu3Ta7pHXXdQdeKcXRT8Jld?=
 =?us-ascii?Q?bc8xBMYkIaFe+JAi+pXBc+0WEKjaVLZXU+KRdbkyPpDGd14c2Rme5CKyN7s+?=
 =?us-ascii?Q?aLsq6raOSzQ02kgvGhVgka5x43/pgsnxeyifFXYf+UPIZBpdAUzD1XgRX1vL?=
 =?us-ascii?Q?VcyNn9sB8QPqmzys+c+0ymczpHN0BT8Rs0dnTgW7AoaSeqRGpSQyHqmKgiGv?=
 =?us-ascii?Q?l17KGeu/E0XIKGQ46f50dJyDDvm9RxrL0p9WpEshTP/b0FLaqyV0W7EXmkzf?=
 =?us-ascii?Q?WFVNRrV/Fe3X3qQ8RFUb6WOx39w620y5sqSK6blqgwsGZBd9+/fmDvz0D6my?=
 =?us-ascii?Q?YMsfAAFYMuedrux0kPqi4XKLU1eLJjsWVoUmfDZnxkHTMM7G0a1fpHdEeEju?=
 =?us-ascii?Q?t0SwmmYUswDo0vBQJO+8c3pIafI8hcew4yWgPk6Ae2xS7DMyWYRaTGAeRPv9?=
 =?us-ascii?Q?YhxZ7sppowkE6vsZJ1BWY5ChDbmwYtEzvyCdVgQkyPdqfIf9K6AKspj9IN0q?=
 =?us-ascii?Q?cJfFG66WsN0KdgdUb2mxDQdZebifLvUViWnc2yiN7gdkgpBzQVqR5ALX01PR?=
 =?us-ascii?Q?PasoEGlAxNUhjv37xYcO5ylgrkcwczdBGXoBApQJ5WvpmddQUPiN0rKf7rOT?=
 =?us-ascii?Q?0ptHzTzGOSaECWAyET2qCETC6rNw8OaM1OUljcl6aAdBfCoNIVm2GzMOXZXg?=
 =?us-ascii?Q?ShCELpcloqhJXzV6rqCuMvPSfU4S7MPIaZpRs8hEkHNHPAsSScaWduSHxXVG?=
 =?us-ascii?Q?hq/9X/PykKiwDpIzR0xEvGDqVujDiWyBDFB2iRyz31i7DKHJEi+Ci7H9A7VG?=
 =?us-ascii?Q?Hx8yzHEOg+4YdFQLkFLdVieaYTy6ciyY8vEw8f82VnmjAbYxkmK5nhPBFhEw?=
 =?us-ascii?Q?vpyRDsgruHhJRZOIX0MhrImgyyGSd0p+acr5TibbcsAImOJV6FgAkrMf3SAZ?=
 =?us-ascii?Q?5Wj7PewQapo00Bkp2YjnDW5ioINBOoQSnFH0ClqRoLGTROqslTUSkxdjwo7n?=
 =?us-ascii?Q?hBtTAachT7RRa3orz2kElalGkkCQuxI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce246f76-70f9-43bc-fcef-08de76075d1c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:51:53.4617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAYDn3Hqgx1HJbNldd0+9XK3IwAyR8THyMKnZ5I/jLSh0Ckd5gNWN0jhBXCAbkx6wkPPD50Qryg2oQQd4vDxKDi+++HrBMu15KVDDN/9g88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9552
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

On Fri, Feb 27, 2026 at 02:43:46PM +0100, Thomas Monjalon wrote:
> 26/02/2026 17:50, Robin Jarry:
> > David Marchand, Feb 26, 2026 at 17:20:
> > > Some applications use port hotplug as their primary way for using DPDK
> > > resources.
> > > Having a systematic device probing is a problem when not all available
> > > resources will be used by the application, as such applications won't set
> > > an explicit allow list at startup.
> > >
> > > This is the case for OVS on systems with multiple mlx5 devices:
> > > one device can be used by the kernel while the other(s) are used by DPDK.
> > > In such a setup, the kernel used device may get reconfigured in
> > > unexpected ways and trigger issues like the one described by Kevin
> > > not so long ago in bugzilla 1873.
> > >
> > > Add an EAL option so that we can change the default behavior from
> > > block-listing to allow-listing.
> [...]
> > > +	const char * const argv29[] = {prgname, prefix, mp_flag, eal_debug_logs,
> > > +				       "--allow-explicitly" };
> > 
> > I am not convinced by the option name. What do you think of:
> > 
> > 	--no-autoprobe
> > 
> > That would match the Linux sriov_drivers_autoprobe sysfs.
> 
> The name --no-autoprobe is better indeed.
> 
> The exact effect of this option is to disable initial probing
> of devices on all buses (except vdev).
> Another name could be --no-initial-probing
> 
> I think we should add the opposite option as well
> to allow changing the default mode later.
> For such an option, --autoprobe looks better than --initial-probing.
> 
> Other opinions?
> 
> 
> [...]
> > Depending on what option name we settle on, could you add a short flag
> > too? E.g.:
> > 
> > BOOL_ARG("--no-autoprobe", "-N", "Disable automatic probing of non-blocked devices", no_autoprobe)
> > 
> > Or:
> > 
> > BOOL_ARG("--no-autoprobe", "-P", "Disable automatic probing of non-blocked devices", no_autoprobe)
> 
> I don't see the benefit of a short flag.
> It makes reading commands less obvious.
> 
I actually would prefer to have a short option available, and I'd really
like that short option to be "-A" since it serves as the perfect addition
to the "-a" flag to specify devices to probe.

Based on that, I would look for long options which allow "-A" as the short
version for example:

--allowlisted-devs-only

/Bruce
