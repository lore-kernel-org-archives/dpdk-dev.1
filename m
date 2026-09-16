Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96985C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2AA54279F;
	Wed, 16 Sep 2026 15:06:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7F8DB40E12
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789563999; x=1821099999;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6GLPj7uPQTzW7GEG5jzp7HMRQtDHKnF8So2yTaGWEQ0=;
 b=YGF/JcvMu9/qB0Tj6CrUxATsKURv/aqGQNhGzyGlFVHMkFYvxcXp3tg3
 tVoiPJdv4fmleD60uysv8botFeE10iRwUlMhtya+pfT0M2aFhot1W5tOl
 xIrRpZkmPP2Cv4zS1jHX1+ev6Ju/jo3rOy4Btkeu1OpZrV5W7rDTtIdVL
 VPAN2jmhXSC4OCbtOUtEa5LlnEk7PJ8+3dynzGl4SoQvAfyZM4OKrWrgC
 wh4p2Jx0F0OoOhdrLflYjKc5fgcMb6l/b0S85cRq3+C/ILiXneW1YjpnO
 6AMEsH/bteejfKTAU/bSquskhEd13MDzC3PCOqMFog5DrCzjxZ4c0I0Z8 g==;
X-CSE-ConnectionGUID: VSXyNh0pSJO3SWb/gBbmAQ==
X-CSE-MsgGUID: 9KuqJwVVQO2cm7NttMjUVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89957882"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89957882"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:06:38 -0700
X-CSE-ConnectionGUID: bQRPvhYPQqiAvo63W2Ig3g==
X-CSE-MsgGUID: s1+Z8WaZR5+osPpyiBeWVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="311624411"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:06:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 06:06:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 06:06:37 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 06:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsrDIGl6ajVvkFtNdfzLoPMap/dcvkWuHS9fZTDlcYtFLEsBQdnZ/lN0mv710MyRuNqmy2AKjhbHvFKcUvcSqyTKeDxv7nfjWCpmJVKvFOY1R9Kj5kUKZoRb1i0O7Z0OgES+ls+DXhrd373GBJfumqctOc4CzUbR7lbKq4sYi6f/ULb1e+uyTTTHnZGvTsCsFICrqybP2O5MR497BQUAff6i5gIXnJs4BpRiC2Udg7ZoWCldjuVdfSPH/Y4flRbMpmzDd5L0f2tPKwXRvmah9pcQcRDjuadLJi5lWsBBL4IMsvLzGJ5m/y3DSqzjceFQlLFpelVwNhhZu6b1LfH5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlxGQoF/wN/k0/f0TCQeY/kWX2BCNTvZoOf5SGZz2IU=;
 b=FtXN44MRK9z3yOLn2czvp/1iJreXdMzjXQoHaePULr7IiLQZSa59IoyByAmOmdtaVQYDEZlLo/mA/zE7Yawv8d7x/26O/Ay6y1ad/8LJGB61sYMolNhuRnw7I+pK8hVTx/+nDdGhdYKkAR+ojlhdB658WWYgDwyrl2O13iKQcecHzWnCFjXsiN32a921NGkTjDF6A4AlDkz47MkckH1W9n3u+R0x4WfTmM3wtWe/HF0roHCd/9/gXWlIzyZ+Rv15t7SVzx44Bs43+svdYZ23oZkjE0UqKU/reM4oqKqao1cE6B52Hx7u9Vx/81Mx+GXLKRISf+MEaWxZAWwRnxHfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH9PR11MB821391.namprd11.prod.outlook.com (2603:10b6:510:3e6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 13:06:29 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 13:06:29 +0000
Date: Wed, 16 Sep 2026 14:06:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 14/15] net/ice: enable context desc offloads for
 vector Tx
Message-ID: <aqqUT4xQZqb6QFv_@bricha3-mobl1.ger.corp.intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260916103622.319874-1-bruce.richardson@intel.com>
 <20260916103622.319874-15-bruce.richardson@intel.com>
 <IA4PR11MB92785894E1A756E6978908798EB92@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB92785894E1A756E6978908798EB92@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0312.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::8) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH9PR11MB821391:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dadfbae-465c-4431-5843-08df13f35279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PTKODPw+/mxK432X6xZLx4pibgSbrfGFVHrjnHdpglniekC14V5loGosPGUw4u/N352LNp+SxHX0tsYGrAQtwb3qC1I5thblmgYD1+7RkVYGeQEz2uemWiNKwRExwvwyCB+0TjaWbKxN7BRonC6cuCyhqfz/2puOtWWAI6oE4wPyrK9LqwDbeIfjJHEFcSf75+gaG9rtL+Nyz2dUfafUgfnW+CzoBeiK0fCNG1qfmV7bsOmcZEycyeSpG4+jb7a0HpMIPSh+uymVdDVuWuW/JemkYYrd2MXO2LV9WRViuUogMXFuPkUrFOMxBR9YQ2VlYI8ItcEtFmZs78I0QBhEnA6DYv6HlYzMldkFStOAYwuDai3Z68KJUUKHf0r7un4RGkE/mOPHeZlyJqBaS98dhfzMxfQJIS8127vxAJRsTYLUVuD1SSNh8fizYLxbGHna0oYvWkS9RbYP5fhlrUvANNZzoeB58klcvp/uX1kLQQQWhCQZTtG/3HhtPBCipUDMVNwS8jIHQGA2rEctSBGxY+VNKRlfaEWmTR5eotb+NgpSWBZuhLHczVz+82m2TI+UEuZtrtcOEPdA38MRLot/bHwvBfsTWxmQCRVe0lc+KSXF0g81NR4uWZi9ERRsiAHKuTmMPSTPhjKmmQmClTGsJKPQ+U1LPJo+CNJvfIpPcOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6w6dDuNKiU6jeVgxbXJRmiUptRSLEAy96R0YZc7hMZwfRFPjQQggGsr9u+iO?=
 =?us-ascii?Q?8PTGBy10m35EX5LgiWR+yxSNgAsxVwAE3UEv5Fb9usU/9FfTPk7L7hycu/Yn?=
 =?us-ascii?Q?yai5HRqtffCgeBx8LW5XAY/d8K9de7s44/vrhKQvToyyEqA9zrDUjlvCxJnC?=
 =?us-ascii?Q?yLj0TTGkO1JW1jWs7JUly7ei6aWfpX6Gl/n403vMzWU9B5q529xZmKoFoIc3?=
 =?us-ascii?Q?Btj6tu573oL559rtLRh207Gas0WvqSsjNoUrXaNlqcPp8XZZ6ISTiCvZHVM/?=
 =?us-ascii?Q?whcBDULiiaH1GbY7AHkcA+dhweH4QHFt6DRiaIl+h2sd2nEasT2Wa1+VjhaR?=
 =?us-ascii?Q?eFMn6A1uBu037hF0ENsKjKfyYbpyoEPkt8geAbjncleZ1tLvKwgT81q+yOC7?=
 =?us-ascii?Q?bT2FfnGb1ErGAVWeKQG6Eyqn1P2ho86v2AZvkZd3eSUCckyCpTrjU1nb2LMt?=
 =?us-ascii?Q?kmOx+1Hscf/C/Lzbcd/J9b+rr9uuNFKNNCPYc5ETkxK95gZxBvYuX8onNQz1?=
 =?us-ascii?Q?lwasBW6Cr/Rw0tdos3AEi+SrWTnTVMJCs+vd5S1afMp+5HVWrm9/QZ8iQFkG?=
 =?us-ascii?Q?u8UASXYsLXah19VgM3lgKm5/6ENncMhvUFb2ZkY4cc74qKLv92x6/PCFzCzK?=
 =?us-ascii?Q?YnUJrWjYh8O91gChX0+A52I3hw04VqdGeWCmcRGHM989m7arU336fPmNJi04?=
 =?us-ascii?Q?8vfVbFCSscXrIeQc8tYRHfAd67KcgjtGTqF+MUKj/cqZ1HwVNx4t20mLXaHP?=
 =?us-ascii?Q?aiEzbFfW4qvmLSngJDLuYSHC6qenZAtkwpv5hmYfwCawG44uKdqyDYXCsLfr?=
 =?us-ascii?Q?h00VFu0/OKpg6hlw87pbA5xPNGOetmPKqdtzxipSw67E4waoxLF4SrNahSC9?=
 =?us-ascii?Q?McHbX7jjP4F5neS1qD5SAZZcoSzetrxuinxmQbW0bL6RXrCFHXH1/0DJrffB?=
 =?us-ascii?Q?RJRY4OwtKI19q2fAUdhMW0QZW0mm6XsgSOVbQEDsXn+5w9OWSeD44Cnbrn1N?=
 =?us-ascii?Q?mgLdLlePB1YuXZQoqrsFgpuQiAZyhFWTgCwd6YcsAt952ZxJNNotyGWe0Ien?=
 =?us-ascii?Q?cc9ktR1SedhJphfG0DJ2yDE0q/zwJ+uEf3fll/XAeztp7EymUZRKVyD8uLuP?=
 =?us-ascii?Q?/VixxqGZUAtY0Gn7j6awqEGPCAbwbH+1Jtf/U0Kdg6uZt2qN1fBWIJG9d6Md?=
 =?us-ascii?Q?50JWt4BuRcHbjdL0hj3/4lEf66dmO9IqTaXUaQNorRvHypCj6mBESHoIBGnm?=
 =?us-ascii?Q?sOr6FZvatDuExVu0iKsMpEie51BMtPUkyB/q0IY+622bkDy2K3DYJZoTo6Ah?=
 =?us-ascii?Q?ftYSofXImgI/KNWaozUkH1TsN+mIDU5p/5KBqduqWNyn3VshERgwozudx5Xp?=
 =?us-ascii?Q?pNn5A3I0z0pw6XKKsOB2R6SS1xTgNtlXh2OKH10CEHWPUe9mak446Fwz0qYN?=
 =?us-ascii?Q?/glThYxldvOlZUw+LMdWvxxOVEV+MXGuOo8LyVc6v5bsAeNkKjRV1/IeGHoQ?=
 =?us-ascii?Q?UJuSuxUq5TmTEJmItfAJ0nYsYV/W/n913D65aFjR+lcgaS4PbbdBKtq61t1e?=
 =?us-ascii?Q?kjLbRFmnif4uBFqCjko+25GXvUir4tawc6hQzSqbiAUeNcBMTj42T1dZfA5J?=
 =?us-ascii?Q?2cPknQ7ue6Q+HqpX6qoYfDsMhdus+EKWxUFblGFrfxJUj/5ZRTWEuC1NmzYe?=
 =?us-ascii?Q?kRCr7kmB3cAsQT14dZKwpw8R2ec25bWykVvnNNtYk1IEj/a5//IQQOrAYBi5?=
 =?us-ascii?Q?NDoPHhd3L0Qne7OTquRKV/zIXvAjmoA=3D?=
X-Exchange-RoutingPolicyChecked: NKhR1A4nK3//I8ukHwSfdQZlilz4+PFNZ0m2WnNlNjTOfhxwQcZZI0awD++ykce5rYvBnpwA1x/n4e07tPyPCZW4nAXJQnHs1eqsaD//s+kTKCuOVzBJeU8NuCMb/Jj7GFQ11DqMGhY8XEeHw9/kDO+/TZDkWjvZeN02Ga7esm+5Pxlvb35+hXe2vRbxGWZ5ASRDUewKgvguH6qsTAuGSEPIRRQcElPP8OSKvBSVEVBFaJ/sfKnfn9ntnk8VWxG+u4yihT3/PEJXWms5D/+EOhtJwi994hiLnhtiUpEFmzJxx35Gg30qOM7gBB1FAiV8LdTTrFD15+8+gsWGUHjpUw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dadfbae-465c-4431-5843-08df13f35279
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 13:06:29.4626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p68JxYhtazbD/7M8UiZX7I6Sw5nQVzT+VNojOqx+6Tl4TUdDOm2vulGnMGMBYcyRrTkjvFuYdBH8GfwTBKgVFto6a/t+OFEbQ6uffvmL60k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB821391
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

On Wed, Sep 16, 2026 at 02:00:39PM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH v3 14/15] net/ice: enable context desc offloads for vector Tx
> > 
> > Use the context descriptor Tx vector paths from intel/common in ice
> > driver to enable more offloads on the vector path for ice driver.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  doc/guides/nics/features/ice.ini            |  8 +++---
> >  doc/guides/rel_notes/release_26_11.rst      |  6 ++++
> >  drivers/net/intel/ice/ice_ethdev.h          |  3 ++
> >  drivers/net/intel/ice/ice_rxtx.c            | 31 ++++++++++++++++++---
> >  drivers/net/intel/ice/ice_rxtx.h            | 11 ++++++++
> >  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 24 ++++++++++++++++
> >  drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 24 ++++++++++++++++
> >  7 files changed, 99 insertions(+), 8 deletions(-)
> > 
> > diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
> > index 893d09e9ec..8674b588ed 100644
> > --- a/doc/guides/nics/features/ice.ini
> > +++ b/doc/guides/nics/features/ice.ini
> > @@ -13,7 +13,7 @@ Link status          = Y
> >  Link status event    = Y
> >  FEC                  = Y
> >  Rx interrupt         = Y
> > -Fast mbuf free       = P
> > +Fast mbuf free       = Y
> >  Free Tx mbuf on demand = Y
> >  Queue start/stop     = Y
> >  Burst mode info      = Y
> > @@ -33,12 +33,12 @@ VLAN filter          = Y
> >  Traffic manager      = Y
> >  CRC offload          = Y
> >  VLAN offload         = Y
> > -QinQ offload         = P
> > +QinQ offload         = Y
> 
> I think this should stay as P because the vector Rx paths
> don't support QINQ strip.
> 

Ok, will revert on apply.
Thanks for flagging.

