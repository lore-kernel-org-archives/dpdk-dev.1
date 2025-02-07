Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF6FC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 15:56:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84F4142E9C;
	Fri,  7 Feb 2025 16:56:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7BD3442DDC
 for <dev@dpdk.org>; Fri,  7 Feb 2025 16:56:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738943815; x=1770479815;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0uIi14xZyfSoHvzbOpd9Fd6eiuyIINtp5bv0PxopYo4=;
 b=nsQmo6IG9v1Wd440sJJQqUsye8HWOa+Nn58gQwtk5h1ay9HHdKcRZPZ9
 rJw6mKahUb2UIRM9yYQWHHFgykJr8SIz1ytlJN4VEPaXSOnyv6h6xK5w7
 J01hmTBUEwO9nZFNzcR9UheFVnLCpTwp/iuEc4g/V4pgBrmZzD6gjw0Gp
 Rh+w+POm2bhYzpHaQ7sH4Ad5fHf66uuOxqnHa2xN+z+NOaaaIdKmPObVA
 e16oytEAD3UIF8/zGKbMVpsW/Y0xfNZErD9hI56nnxEO57JOb74VgA5Bp
 ZTwZpta6mC5FwMhnEIBpAwzT2pYxaoisW2n0E9W3VjRiE9KkdXal60Jx9 g==;
X-CSE-ConnectionGUID: 2jnex+kZTVSSzYQAXfAM0A==
X-CSE-MsgGUID: ienivsRdTcetdVDMllrhww==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="43350264"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43350264"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 07:56:54 -0800
X-CSE-ConnectionGUID: usIpB4kBQNa+8ebMer6wDQ==
X-CSE-MsgGUID: jPF7MYKaQHmPPqZwDWt0zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111405955"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 07:56:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 07:56:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 07:56:53 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 07:56:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+2LorAJfV6k+JOmaCMhWP0f5+4Ias48VFQJFt0NENiDyj+vv1BTOqvYgSgLNUd8Exq18jAkGRAifzlEqnZ5VMrDeZMkGJb/hETwCCx/Gr7myCz/WkoHf7EXjzgaWetSvd7u4RPgVh9OqY8tyPeKpVW99gbcrrm8y2uEPUHHt2khmR+Em26w4wac7EpdmuBjR5SLu+DZZH5aaDNESKaWcXtbe1JHTnjpnZtVEJU+58kJqMmpAJD3LWodgJ3GLiG0MsZHYDUE8XVyMf6uBIUKoqxjzgyKWNI++unDCpEsjSgAhn2iDaN410y70pCLjQ480MMZyPu6HtUM0x5dcgRX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl5EegjrF4cZxL1jkux01SpP0YtHR1Aypm1IN1XyKiM=;
 b=yCRz9dYrmuE1JqkcG0VN+WBE2kB9goumPfHOBxx3d79ZwRBqxYkh94aXYczVKRjgI+slRwe5l66EOqKXQrxY+vD/lP3Jb+i3ftBLB388fGZSvFieOr2SaIhngFvB8oQyMyZqkkLmxsj2P2VX2DInmgM0cSDesH6YYswUCemdufm5SwV0f0avG5iaVOQx4osU6kHT8GY6/bRJm8xVaa8dmbA0HmkOrZYB4JdQeAZ1kV2HQi57QnaIW7uDQrAFX5kjmySttvPjMCMAizZFeCnFzjcY3kSR4h50QEBy2/YN1yj7F+H2j+EUAEEyrg3CHLjpFi3LST7vDYQuuTp3RuAfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by BL4PR11MB8799.namprd11.prod.outlook.com (2603:10b6:208:5aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 15:56:48 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 15:56:48 +0000
Date: Fri, 7 Feb 2025 15:56:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <anatoly.burakov@intel.com>, <dev@dpdk.org>, <ian.stokes@intel.com>,
 <jochen.behrens@broadcom.com>, <vladimir.medvedkin@intel.com>,
 <stephen@networkplumber.org>
Subject: Re: [PATCH v4] drivers/net: use 64-bit shift and avoid
 signed/unsigned mismatch
Message-ID: <Z6YtOvnCZp7Ta7Fq@bricha3-mobl1.ger.corp.intel.com>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1738783944-10172-1-git-send-email-andremue@linux.microsoft.com>
 <Z6SX9MGQC3f776nN@bricha3-mobl1.ger.corp.intel.com>
 <20250207154603.GB21754@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207154603.GB21754@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DU2P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::30) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|BL4PR11MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 04269074-0e4c-4516-f920-08dd47900767
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0bFXDKCAV0tJfEvpkBSBpBkMmZxDPsqtS5VC5JaYH3/WdX6bUviDDLRGdwlz?=
 =?us-ascii?Q?ULVJFrUE+C03Zp2r/VOYGdTaC7HNwvmjfKaGolLs6pVzrcaXSbB1XKERKFgy?=
 =?us-ascii?Q?VvsjT11ofVD0fagnbrcWx/kmXa8vKWmXqzVsTPu7HaFHjM9Bqk1zHnvvZAqj?=
 =?us-ascii?Q?eFBRXRhzIr55vknDSwYQp0pHBOu09R7xmuyodE4V9O7sKZXa16cjnNcb1kb1?=
 =?us-ascii?Q?gSc7OS2ic2fw2ZstBV91nvuCs4p10TvcsTZMum3LCUCV8Rkv/KVxWeOY/qnr?=
 =?us-ascii?Q?uZGim1LH2SIWbKosjveYXzlfF2MFwivpN4u5wK+5Tw8nAGvXqJiEHZcPaBHd?=
 =?us-ascii?Q?lW/XhM70uKcezN083Yve9H2DTZNcIBnrpfwmh5fY/4u2SPBgg6cRuSZEtbU2?=
 =?us-ascii?Q?pA0qCQzhCM5ldulI0ui7uElCuTNFvYSlt4qgH/NZMvuLF2S9zl0NYZSL1pcU?=
 =?us-ascii?Q?QrTsr6Ir3VAzkN+1vqrnv8MwAAed0R2GPydsgpgccB/Wolqx2bET0sJqhUGa?=
 =?us-ascii?Q?aeEjpQESpGZCkdxIOLzq0cHVnMfD2FqWsNS4JGQ9NRhx8t0xRUKDVf3TJnDg?=
 =?us-ascii?Q?PZv/+ZXjPh6uuPofwY+idFsA6cI1VxYcbirDhrR7NF//44J4hhFZJqxJPIqe?=
 =?us-ascii?Q?jLumyvROvF5llxbdQaZ0hQx51affPvjUr5NavTNRwu/lx2gfK4t8NSQEjiBc?=
 =?us-ascii?Q?O2m6WjxF+wuzjGENMbjuKlUO0ED894gpvKom3z2SB3CFmnVpG8ih3jNf3O0V?=
 =?us-ascii?Q?Qc5uHBIajp4vDYd+ciYsQxeGoYlRITuwkgzayTSei/zm5US/a++QYpODTsBk?=
 =?us-ascii?Q?vW/KwzLf3R9WfCf4Gzk1kNQ3wmuBTJNOjaQoVfEJLAwnpIiEO0nZDVky53IA?=
 =?us-ascii?Q?Ady6VEafcxWLA+dFj+ouVX0BgA8Yeh9a0fRbJ5/7xuAgekL2ro2FvtucKmaF?=
 =?us-ascii?Q?f12uBjKrYrbPaQXxVwsRkhlmBsJR41+co7zkTdaksy0zuSKq+mS+iBUh6OvQ?=
 =?us-ascii?Q?5JvOWPkzwCfufBAvtQqIlBF/Ul2sUSa04id4z20T4nEmZN3CL7X7kIKD5WL9?=
 =?us-ascii?Q?n99QUE3NTgnP3tlxxG/xD/XNEJacwTEJMyZFEJwEXWEzq2elDGv7iPW3hl2m?=
 =?us-ascii?Q?/hI4UaI8Bx2N89XDGBXI3xvCuYhie2EvH/1HG2JVoPlyLFZmZBiTDi2K+LIF?=
 =?us-ascii?Q?r3tySs+GQY8g4v12TQUT9FyAkJAEYBx/SAXjKbUVE18nsaUAbFfM83SklnLI?=
 =?us-ascii?Q?oUCU7bA7ZxTzR1GhbW0vcA5IWGVdKHmGlG7rc7jS4UqB0cXHA0B+wmMexE5t?=
 =?us-ascii?Q?PGMBq6HvFipAqDtEj1x/WMZOwEAmomSYrGf8846G+7tlcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybbrP17ixRL5Hcd04sn/pVJT04xm4sgvWBfQqI5Zi8siYNFRJlwei/WWAaZf?=
 =?us-ascii?Q?FxshPmHsvf9hVIDFYhw7X/i+FguVIxQu/FJ0dew30c3SY4IjZZAXqI88KAEC?=
 =?us-ascii?Q?qe6Cwgg34gEeUNx/alzo7B1W3rQOlBU58AAX+tnG9kD57FPnIKgA4Ff7v9Jr?=
 =?us-ascii?Q?gMr8DvmxzgQ8NIyaE8IgowsSgcCSlrD/Jl7Yp3PzH+56gZ5/40WPg8oL1MZI?=
 =?us-ascii?Q?NrKUUj2ncUezQFT3kygVtQtpPYlC1oNOatrD/cwXh1PUdJjX900+6hES8n/T?=
 =?us-ascii?Q?Q/wOneawEeFMo7+y1SQEFC66ep20iTmbZ7vlMvQjM+XtrLp1GOdvH++eCuVK?=
 =?us-ascii?Q?D+55SYf9Q6vMLXL7ZbJrtPsU+io24p1ZAWmo5o7W830UiM0vGqjJNSQnGUIQ?=
 =?us-ascii?Q?EPUQ1QbgpipeAERXuxtmqwaLN8rtAChWTFYw/66qfPbuw/0Hi5dxKscChIqT?=
 =?us-ascii?Q?yK2XP50z81LAYbzDEjKMUrqJW6vRata5gw91WgPauqRVZC31VRd2NilbNdKG?=
 =?us-ascii?Q?XiA8JjUtnoeKcz48m6D/icowbrhz0sWjHbtYkL3IUATzMl59wD/QKmJEhfMJ?=
 =?us-ascii?Q?csAl9qbZraLS2NIPQeXiCpHnBaNXBzSq5UKVjNGKkbdCoook/WROBKKKaJPK?=
 =?us-ascii?Q?AVfw85S/zqIznXXJnxq7YbTnDEjntY7xYVwbSjjrqeFnnSTpr0Svl7y9HB+A?=
 =?us-ascii?Q?2xijHCUQeqRY8ti8elCjJvy0vwOhPSFlgYlxwjA2eVBlu0I8s6gzszqvPSM6?=
 =?us-ascii?Q?v4hsd0wFuaaA+7idKGzIb/jZgyLbKPpE0xBArtaW4V7jOej86P/4V3MuE8nl?=
 =?us-ascii?Q?JgORZjGqT1zM52TM9GxJcvbyZjNbKKqJzQ8smHjpGcH+X15JFSwAPE9wtVCD?=
 =?us-ascii?Q?9tUMwFXCmjsXljp6CdCpg6chFkSwa2j3mMeKuTU8z+0u1/0YpyEufGeKujT4?=
 =?us-ascii?Q?AT07A57EPCx7KJC6cmSfmzMHlq6aKfMc2mPT9ekRLo4r4vp5icn3IgIATv+P?=
 =?us-ascii?Q?XDodlGDLEDuZaSl6m7Z01wE8rbjVoFo2ZnnVrGnBlLiQWBzi6jlRSCVT2ESx?=
 =?us-ascii?Q?JQB9WiLfFtZMSFKtnA65FrnhoWHW8WC+PHDINQvwvEVtH7rVBT472PlCwiWw?=
 =?us-ascii?Q?kmGJyxibRWh5+DtglPE1mFWL+DtlZtiri6SvvOnlIHhd7gwUhmdyFe5y3Dtq?=
 =?us-ascii?Q?lvHguzJylE3olPGjig2V3a9u1CvKrXXpWniNZlrty5OFevdAiWP2tIlI2BLO?=
 =?us-ascii?Q?dTHKqT/YQKOPZDKLs8zEYx+nK77A4knzEsgYCHSAw7fM/3GwKJVDyvJMgfvI?=
 =?us-ascii?Q?ZTJVzEaS3yuSgmPP1b/4A9M29ew3hZ89JAzJIjUSnZ8ED4PB1onoftln+HTS?=
 =?us-ascii?Q?l4Izh79qJAgNc1u7DLpoMzybg7JsJliU1g2KxE6kyB6CipDt2gocBLxGIxWh?=
 =?us-ascii?Q?0HJxK53VX+Z3ccGRf0WBlcs9+RyzJVh9zHAOwLNWxpRLRFm9g5gd+NwDS5xE?=
 =?us-ascii?Q?jY/R4qKgiow0cnBqFiTFBDEg83DyJ+zZL90tXHP3C63Ewxun4I6KaSC0Jzg4?=
 =?us-ascii?Q?ikOSMzdFdkEwdbpfCcb9jfT3cGTrBWwiOc2D32ATwHgGT8BGaJefvKoGOtqr?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04269074-0e4c-4516-f920-08dd47900767
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:56:48.2949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elbtqnYJHqstGw2ux74YFugCFWWVgup8Bv/nG1r/7rRItGM1xRTsWBxGJq2UUbzLcS7oPhw6cQuBieQ6nFck7bralk3YP3AF4X5zRfQ95zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8799
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

On Fri, Feb 07, 2025 at 07:46:03AM -0800, Andre Muezerie wrote:
> On Thu, Feb 06, 2025 at 11:07:32AM +0000, Bruce Richardson wrote:
> > On Wed, Feb 05, 2025 at 11:32:24AM -0800, Andre Muezerie wrote:
> > > This patch avoids warnings like the ones below emitted by MSVC:
> > > 
> > > 1)
> > > ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
> > >     result of 32-bit shift implicitly converted to 64 bits
> > >     (was 64-bit shift intended?)
> > > 
> > > 2)
> > > ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
> > >     signed/unsigned mismatch
> > > 
> > > The fix for (1) is to use 64-bit shifting when appropriate
> > > (according to what the result is used for).
> > > 
> > > The fix for (2) is to explicitly cast the variables used in the
> > > comparison.
> > > 
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > ---
> > >  drivers/net/intel/i40e/i40e_ethdev.c   | 22 +++++++++++-----------
> > >  drivers/net/intel/iavf/iavf_ethdev.c   |  2 +-
> > >  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
> > >  drivers/net/intel/iavf/iavf_vchnl.c    |  2 +-
> > >  drivers/net/intel/ice/base/meson.build | 19 +++++++++++++------
> > >  drivers/net/intel/ice/ice_dcf_sched.c  |  2 +-
> > >  drivers/net/intel/ice/ice_ethdev.c     |  4 ++--
> > >  drivers/net/intel/ice/ice_rxtx.c       |  2 +-
> > >  drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
> > >  drivers/net/vmxnet3/vmxnet3_ethdev.h   |  6 +++---
> > >  10 files changed, 35 insertions(+), 28 deletions(-)
> > > 

<snip>

> > > diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
> > > index addb922ac9..dc5956f92c 100644
> > > --- a/drivers/net/intel/ice/base/meson.build
> > > +++ b/drivers/net/intel/ice/base/meson.build
> > > @@ -31,18 +31,25 @@ sources = [
> > >          'ice_vf_mbx.c',
> > >  ]
> > >  
> > > -error_cflags = [
> > > -        '-Wno-unused-but-set-variable',
> > > -        '-Wno-unused-variable',
> > > -        '-Wno-unused-parameter',
> > > -]
> > > +if is_ms_compiler
> > > +    error_cflags = [
> > > +            '/wd4101', # unreferenced local variable
> > > +            '/wd4334', # result of 32-bit shift implicitly converted to 64 bits
> > > +    ]
> > > +else
> > > +    error_cflags = [
> > > +            '-Wno-unused-but-set-variable',
> > > +            '-Wno-unused-variable',
> > > +            '-Wno-unused-parameter',
> > > +    ]
> > > +endif
> > >  
> > 
> > Do we actually need these if-else blocks here? The way
> > the code is structured is that we check if the flags work to the current
> > compiler and use only those that are relevant. Therefore, we should just be
> > able to have a list of error flags and leave meson to filter out the
> > incorrect ones.
> 
> Both approaches work. I personally find the if-else approach in this case a little more readable
> as it makes clear to which compiler the flags apply (considering that there might be multiple
> flags with the same purpose, one for each compiler). But I'm open to updating the patch following
> your suggestion.
> 

If you find it more readable, ok to keep as-is.

> > 
> > >  # Bugzilla ID: 678
> > >  if (toolchain == 'gcc' and cc.version().version_compare('>=11.0.0'))
> > >      error_cflags += ['-Wno-array-bounds']
> > >  endif
> > >  
> > > -if is_windows and cc.get_id() != 'clang'
> > > +if is_windows and not is_ms_compiler and cc.get_id() != 'clang'
> > 
> > Are there other supported compiler options for windows other than MSVC and
> > clang? For what compiler are we adding this flag?
> 
> Yes, MinGW-w64 is also supported on Windows, so effectively this flag applies to this compiler.
> https://doc.dpdk.org/guides/windows_gsg/build_dpdk.html
> Note that this flag was already there. I just changed the expression so that it is not used with msvc.
> 

Ok, thanks for clarifying.
Do we have a flag or check for identifying MinGW, because if we do that may
be clearer in the check.

> > 
> > >      cflags += ['-fno-asynchronous-unwind-tables']
> > >  endif
> > >  
> > > diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
> > > index 7967c35533..2832d223d1 100644
> > > --- a/drivers/net/intel/ice/ice_dcf_sched.c
> > > +++ b/drivers/net/intel/ice/ice_dcf_sched.c
> > > @@ -174,7 +174,7 @@ ice_dcf_node_param_check(struct ice_dcf_hw *hw, uint32_t node_id,
> > >  	}
> > >  
> > >  	/* for non-leaf node */
> > > -	if (node_id >= 8 * hw->num_vfs) {
> > > +	if (node_id >= (uint32_t)(8 * hw->num_vfs)) {
> > >  		if (params->nonleaf.wfq_weight_mode) {
> > >  			error->type =
> > >  				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
> > > diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> > > index 80eee03204..6f6f618a2f 100644
> > > --- a/drivers/net/intel/ice/ice_ethdev.c
> > > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > > @@ -2469,13 +2469,13 @@ ice_get_supported_rxdid(struct ice_hw *hw)
> > >  	uint32_t regval;
> > >  	int i;
> > >  
> > > -	supported_rxdid |= BIT(ICE_RXDID_LEGACY_1);
> > > +	supported_rxdid |= RTE_BIT64(ICE_RXDID_LEGACY_1);
> > >  
> > >  	for (i = ICE_RXDID_FLEX_NIC; i < ICE_FLEX_DESC_RXDID_MAX_NUM; i++) {
> > >  		regval = ICE_READ_REG(hw, GLFLXP_RXDID_FLAGS(i, 0));
> > >  		if ((regval >> GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_S)
> > >  			& GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_M)
> > > -			supported_rxdid |= BIT(i);
> > > +			supported_rxdid |= RTE_BIT64(i);
> > >  	}
> > >  	return supported_rxdid;
> > >  }
> > > diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> > > index 8dd8644b16..87a9d93e89 100644
> > > --- a/drivers/net/intel/ice/ice_rxtx.c
> > > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > > @@ -399,7 +399,7 @@ ice_program_hw_rx_queue(struct ice_rx_queue *rxq)
> > >  	PMD_DRV_LOG(DEBUG, "Port (%u) - Rx queue (%u) is set with RXDID : %u",
> > >  		    rxq->port_id, rxq->queue_id, rxdid);
> > >  
> > > -	if (!(pf->supported_rxdid & BIT(rxdid))) {
> > > +	if (!(pf->supported_rxdid & RTE_BIT64(rxdid))) {
> > >  		PMD_DRV_LOG(ERR, "currently package doesn't support RXDID (%u)",
> > >  			    rxdid);
> > >  		return -EINVAL;
> > > diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > > index 5f18fbaad5..078f7b47c3 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > > @@ -2722,7 +2722,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
> > >  					ixgbe_set_vf_rate_limit(
> > >  						dev, vf,
> > >  						vfinfo[vf].tx_rate[idx],
> > > -						1 << idx);
> > > +						RTE_BIT64(idx));
> > >  	}
> > >  
> > >  	ixgbe_restore_statistics_mapping(dev);
> > > diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.h b/drivers/net/vmxnet3/vmxnet3_ethdev.h
> > > index e9ded6663d..e59cb285f4 100644
> > > --- a/drivers/net/vmxnet3/vmxnet3_ethdev.h
> > > +++ b/drivers/net/vmxnet3/vmxnet3_ethdev.h
> > > @@ -186,14 +186,14 @@ static inline uint8_t
> > >  vmxnet3_get_ring_idx(struct vmxnet3_hw *hw, uint32 rqID)
> > >  {
> > >  	return (rqID >= hw->num_rx_queues &&
> > > -		rqID < 2 * hw->num_rx_queues) ? 1 : 0;
> > > +		rqID < (uint32)2 * hw->num_rx_queues) ? 1 : 0;
> > 
> > Why uint32 rather than uint32_t which are the normal types we use in DPDK?
> > Could this also be simplified to just 2U?
> 
> Well, I had just used the same type used for rqID (a few lines above).
> BTW, there are more than 100 hits in DPDK when searching for "uint32 ".
> I'm happy to use 2U instead though.
> 

I generally don't like to see uint32 rather than the normal uint32_t type.
Probably prefer 2U though since it's shorter. However, if you don't feel
like doing a new revision, ok to keep this as you have it.

/Bruce

