Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54978C5B552
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 09:30:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1E8A4025E;
	Fri, 30 May 2025 11:30:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 172B54021E
 for <dev@dpdk.org>; Fri, 30 May 2025 11:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748597443; x=1780133443;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=iEOrnGtDerHqkHrWTVpFQQc2VmECvA8IVE7DvaeDLSw=;
 b=Yw+rwylj4BOZafjaEdJZwiNz8l+WRxc3GV+aRUH4tYP+2mztwD4hzx/9
 45X2C1szXW4EzseSCx1uxzr8Zme2yDDZBkgFQGziuNzxKQqLXKAXDryt8
 034ojeol2nU3Jui7mrTPKCdkDwvEOg3DOTp1avjFSJD9nV2SR8hPP+yew
 cYXl76Umf/kro/bOUUHcg2ANDF8wnkiRBVH9HdqXjw3C+TOzp7oLqvKA7
 mgaEdTk17/eSUcnlwxp15Cglrs/q/H5dZgDgOVBT1LtqWAeRVORamCkJV
 TBayevXSbzcAzOT2VyCLUQByukgE/Aqb0WcYjwezgJALaCqdo5v4Ejac9 Q==;
X-CSE-ConnectionGUID: 4sgqpxl7Taqih/EZgLA+Uw==
X-CSE-MsgGUID: 06mJu6YwTc60N7aCIX8PFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="68109171"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="68109171"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 02:30:42 -0700
X-CSE-ConnectionGUID: 3VKz5p4XTnuG4sS7ZLmu0Q==
X-CSE-MsgGUID: 7W/xmwc0S8S2Igtyccxa9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="143651964"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 02:30:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 02:30:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 02:30:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.82)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 02:30:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIiv8LE7uVJVTyzO5IAuaE0u38KeESj2HUHNZaSuO5cA1/rrRqwaB/yV64FA6DGvZ43Vi/57xUTX219s1dhPLm5NBu6zxlozwhZbUkbhCme4+zPD+lp1mpELtYHtRAJ3kPcJWEtNKzh4gt+uhd5IcBUfo7TmyZhA5YkZcpALsQXLoDlTaIl25ItC7qADm8+UApK14a1eJiE5aGdKsvXo8T1T07UByEDeyhdDOqiQvfTElRkQ9N5Hv7NP6HQjqlV+lAleBjuYjB7E0M/x+aZbxwAHGKzViwH1t8dXseQgVWBxgJOCEE2sh0Br2VUi7QZh/E7VewZWsvlI7421ycOWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3yEVme/rEu3T9zOYPQwuqsbYVgIS1gkGJk0KmaYVpg=;
 b=F6sMHT1D477SEgBGMgLIcD9+yV5w9bzY6Fhi/1UdgDjS+k9Hs5YMzlwp2QgJFfF09MNGKXGk1i2+76YNfYFrFplRtitHz7ZOHOuNb1dt2cIc7SdsNc+u+JyDpYqEnMuFOwjDBiEbof8xIe6qWQnyO3pVMreFec+UVrXs3weowDnkcSUi1dmaMXYFq7gHsL0pU7aTaZaISOC+mJkTndxLDHt4UWZjUZg0C/bIov5B2eQuwmkmyRs9Lw5wptkbhWfmcWWOYUVrEkK03YKXUvf1OR8F1EF6/mqPDRHQdKK0HoSkrfkbEs2xb6y7dCmkPU6cfWjka4osyKUSlt2ino95Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 09:30:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 09:30:38 +0000
Date: Fri, 30 May 2025 10:30:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
Message-ID: <aDl6uWlI4YNcBALO@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250529154249.1310449-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZP191CA0051.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e9fd54-0daa-4c3d-a37c-08dd9f5ca353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E5GujiVEsuwk00QzxHFEYaKkKwXP9wC3olyNr0bhX1THkZeRF1J5x82qyjMv?=
 =?us-ascii?Q?1S+zYulb18SF6YqHcJQLiqEhcpGNP/gboPYufUhtKL9WBZdjirmpYi0sl0DW?=
 =?us-ascii?Q?TYvq/04qAO5uK+OY3C3UpinPkVnRQK+AF0JHk9nnEQ9zwxvjH9vLdQIxoxXq?=
 =?us-ascii?Q?ck5oMn+VjdHG6XY+4gC9RJyLzVGefgGWDs6lBhQ1EP0zrL6cEGb6W9ZksC8l?=
 =?us-ascii?Q?x6Svu5b5DXfWc8O4LIejSaXTlK0S3oE7n8zmZZi1dS+LGgiGunsDufi46cdJ?=
 =?us-ascii?Q?XFCyPSdOiUylLFOFfo+VNhDsKpWJyte2j4ReHUA0cxzmBRJkqsIPAkV22T8P?=
 =?us-ascii?Q?6lpoyUpvxFdwpj572xX02R7c+SiekROtUjD8cai0XYWLEHb4TBS84a8XYwEm?=
 =?us-ascii?Q?ssHwY6V3f8V0WSR7IGWr9qBeUkzzsnIbn4/KGmAPDoTnTEl+PpLPoWn/Lef4?=
 =?us-ascii?Q?feKnQeOTZg+yoKYZWgSNomc3p9b7MfyuSBSPVTUfA11gjo52kc60mPmTJOjF?=
 =?us-ascii?Q?f060Or+h4Lq2GMmlHHUJMdAeoHLMGj3hHcK9h3FwRtpw0m2izRF+2HiHQ7bQ?=
 =?us-ascii?Q?OkgP8FWn7oXM3c4meUZmikEBIfvn9n80lz0RZxdpzVs5g817PrTafWknrGBE?=
 =?us-ascii?Q?WR33G86QqcRL9orZruhZXRQM8QGioiFgbSLyyHp80OBzMqSlI0rK62QMimE4?=
 =?us-ascii?Q?jfqp2RJHTyaTIW3NihFLgK7KOEKmMXHZnm4I4pcM77Tzk/CC/EPhdiRjQvI9?=
 =?us-ascii?Q?Ip5c2pQAOBPGHGLPTi5v7qu0rCniaypNWARWYlEWSUUKjeo/E9j2+WnOqPAk?=
 =?us-ascii?Q?x8A6x4aXTB1il7mYTLLDmAhH1BkOYt6F8CsfGWLYpqVNcwNsH3tBYdDD8jx9?=
 =?us-ascii?Q?+NFjsD9YVcMhRcp7IXOJIIQBOMBIFdK22TBphopR37CNWDtO7H6FHJhtC7vP?=
 =?us-ascii?Q?Krp5NSDS2z5yP6qICGYIMbz5KqpEd/rlmPBKlaaBBIvur1zn9Qrtkd/Vf7+t?=
 =?us-ascii?Q?U2brCg6D6uat3UfjR/ZNbIMt1G0jHIkkVG9vC89qqmEXoo91ZvxWT5sCs+TU?=
 =?us-ascii?Q?W/63ni980Lsa9/FPpqHMsJXxAx75xTsqeFlBsIc0UvXqwsU9UxPEcpA3tH7m?=
 =?us-ascii?Q?UcjZHfgCLHembaE8UUwdT+OPQ8cilZmRwkx1H5FM0fXMtoPQcrO/baspWwdg?=
 =?us-ascii?Q?g3W9bM7I/hgSG3RC9ICL3JxxxpSKvYcb6UVO7OBbPVnOT+UjghLHVZJVNhwB?=
 =?us-ascii?Q?63AuEkE4ERLn4OZZ80XpVc4V4/PsL28rGGWCafbbuyHLH+ZxZOzL7HolL1fG?=
 =?us-ascii?Q?tBHPkD2qNLogrOobR8kOsp67mHkHX00drTlL2liGkQMxoTBFD0b9FB0R5Ay5?=
 =?us-ascii?Q?Wp/CD3I4Jj/ubM4mpJJxsj94L6tIHrPpfxpOHp961iwFlPMBFR4RcHntoeKi?=
 =?us-ascii?Q?aEe5VXweVSo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHJxovFTCaEqElDSwKBjbFPFXTv706m0xuLfBDswpSpKfnjL6QrodeQPDnUl?=
 =?us-ascii?Q?bmJ6j5v/CreXtYblNdclan9bjWXE7rlBTHZnqUyFE3BR1+wnhbRW61Vaxtz0?=
 =?us-ascii?Q?my6UphYv0/BhXmRO63eCXQ3bY3iM+kJbTpuukUBgUAAVBOqU1E6zRHK42pnh?=
 =?us-ascii?Q?jkG5aRumlfBBxhrddQkzrE4lD3mRyk0JX2wMi0V7yEvny+tWRtspJnnLznPj?=
 =?us-ascii?Q?vB96HOCtqVI2H+K2mM0I3YPPp2AkMnr9JskBTYshKJFIQE2HdbWHh5C0k4dI?=
 =?us-ascii?Q?3dJthA/x0RR/wihjDWb1ajQA9JWxlWC7m26kJFA/XUwQ88WZmRnEBP0qgCnZ?=
 =?us-ascii?Q?z/p3SmcZn0O0oxhUn8URrxMcpMokcSNvPZpxAIi7MBWcxHxgqNllc8X+q/we?=
 =?us-ascii?Q?F6m/zQg/dr8mHCXp3wXRIn0MyQ5uDHST3/yVDTGiK5OdLzxwmU/mGlFALHgW?=
 =?us-ascii?Q?b0YUl959Ck04CxjJxdDbCrvtLA8rOWkGFp0neO/1uOzsTmPHNens3DsjDfpu?=
 =?us-ascii?Q?MbTmXS0nn7HhD+GQd+9ML56DJDic661daRstihQigkET9Yf+ipD9a/0455xK?=
 =?us-ascii?Q?iGjDXF04bfbi9q5jznkXXyr2TGRZ8v6CdXS3fbzDoQzW2za8YwOivcHFMihU?=
 =?us-ascii?Q?BXhIX58SFZGPGVla+EDVPPvx+t4a4yAbVds3hKNSH5uCXLKgbbo3h5rgv32l?=
 =?us-ascii?Q?Du84XCAMGQP/gEcvr5fKB7k4+M5K/8E5iPus/dm5x/MZZt7XZFMsjjJBKJDK?=
 =?us-ascii?Q?C+CMlshY/EJAL2ebHzGEi24h8kfoNdszcS2VrxFnhT147+jnHuUSnT2Sc47z?=
 =?us-ascii?Q?qR1BTbG468W1ZnTki9d4jOGHbJbbRfp2k3k2QZbd/PkIMSL/NwSlm5HDdVaO?=
 =?us-ascii?Q?SorjRVUMmG90vj4Cwdmyv1nD1/4WOg6SABAZ4XsbN9zT4ZOeu0zQkl1oM+2f?=
 =?us-ascii?Q?hG8x/ikCLzVoiBvKiX4wSj2oCj0ySt8aD9ip+cNseD6R3b5//j/lh1h0+Cdt?=
 =?us-ascii?Q?aKe5tzYLMHK40G9J8mkZ/WYl+0Y93lkd5SO0Ef6SjG4x7PpgRy5DqxA++bdE?=
 =?us-ascii?Q?jKpfsK3tjcBJ8AGZmmno3sBb6DB3QvehNZvndJ7PwEZVrloMh5VLCYOA5KwQ?=
 =?us-ascii?Q?wWfFplWWNGT41NBIVMbyp7t97APzyEIP/o5i/xGB9cTB61G+8KtsfwomsKVZ?=
 =?us-ascii?Q?Sk7BZpTTuefONwRe09lglwNU4I4fUh1UdwcjxpKh2QL4feC78nAnt6UgNlfR?=
 =?us-ascii?Q?7H0NC3NmNMqCqUkV11tsqA7uhccLTfAnIyB9qi3u256H8dVcER6/vUiHw/IU?=
 =?us-ascii?Q?lO1E8spRWZsyOx+A+I8WL5lFnjPMfmZLRbN53wr4oWJqwG8OS09aoj1fREOQ?=
 =?us-ascii?Q?i5oDJv8R/bFBvBxhboYYOUPVCyQMFT9hzxCa6uPERMpgYo+hoRbAkvCqP//3?=
 =?us-ascii?Q?/Au3ektlKFISUDDBdXOV4C6w0LQpUgv2t6ucikSx6qKW3huyuKVPxpU1oOdF?=
 =?us-ascii?Q?gfAW8gVce/7v1JzA/7BWdy86IyYfhOqOkMxGotVrgnebCOcQtO/mn7Q3cUj0?=
 =?us-ascii?Q?Lwiw4N3pbA5gY4AaKjeTxFrg+JkCsSny2uZldsWJ6g4stIkSS00QOSqo01o9?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e9fd54-0daa-4c3d-a37c-08dd9f5ca353
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:30:38.4793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC0dtEiqUULglV1xW2d1yz6a6CrOws9gx2Yd6qi+vM51+gB6sdCgk6px49fgZ7M4FBqgt3Ou2uAhRoUY32md0L8+u65Hh2G+qDPDsBx/GWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
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

On Thu, May 29, 2025 at 04:42:19PM +0100, Bruce Richardson wrote:
> When doing a build for a target that already has the instruction sets
> for AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> skylake-avx512 '-march' flags, as they are unnecessary. Instead, when
> the default flags produce the desired output, just use them unmodified,
> and don't bother adding in extra enabling flags for AVX2 or AVX-512.
> 
> Depends-on: series-35006 ("doc/linux_gsg: update recommended compiler versions")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> 
> V4: Fix error flagged by CI with clang builds without AVX512 - change
>     "cc_avx512_args" to correct "cc_avx512_flags"
> 
> V3: put in version check to work around an issues with some meson
>     versions, (hopefully) allowing builds to pass in all CIs. The
>     printout of the extra flags now only happens with meson >= 0.60.2
> 
> V2: dropped the doc update for the minimum compiler version.  Based on
>     discussion, that version bump is larger than proposed in RFC and is
>     now a separate patch/series [series 35006 referenced above]
> 
> ---
>  config/x86/meson.build | 31 ++++++++++++++++++++-----------
>  drivers/meson.build    |  9 +--------
>  lib/meson.build        |  9 +--------
>  3 files changed, 22 insertions(+), 27 deletions(-)
> 
Recheck-request: github-robot
