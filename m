Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C695EE3698
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:17:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B18F4025F;
	Thu, 12 Feb 2026 18:17:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id ECF2B40041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:17:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916643; x=1802452643;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hzOmwS6ZyusI3RflupKoiKW2IOkpg3dptcF3OBWZ4SU=;
 b=l7wZx8Zi23YMlNkZ2LTGcfKlAkygR+cpSopj1RzBYzixy2XUbCtcVXLl
 YXF1GkVaaPpX6xxSgZx6jOMC/jXGX16iuCxK73cK2+4kvTJKl4G/zDcYz
 ek0npeWcQDjXo+OE5PiLMMuZY3Vo6KpG2xaR7dCU3YcMqm1a/f/JIsKw2
 rvX3Rt7Wa0bPFAOJ9mvb9wEtWbA36ukxIiqKFZPnuTbPJcUGixMm0O03m
 zNUpFZDvIePSSOd2UO7Kp/ssfIvXbn3ous/v1D5LjfNi/1y03Sq6Qg2iN
 xuiFRA43/ObZyx/SJPt10f5Ic7OnzyJdYJqBH026e9FMehn+EcQM23Amu A==;
X-CSE-ConnectionGUID: emTt9Re8TmKbmEOrVe6hYA==
X-CSE-MsgGUID: vWAyp8S3TgSV6g4nBW99tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75719590"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="75719590"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:17:22 -0800
X-CSE-ConnectionGUID: JBh95+RPRe+5LFzKCYiGkQ==
X-CSE-MsgGUID: SuVDm/cYQlKdDIIAurIUqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="211903849"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:17:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:17:21 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:17:21 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:17:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XguW5Wh9KEAYApsU3pX9DQn//hZpp7IhcBK6eFppombsyz4OAhsad4dImFw8VCRJ0xlV3Q1l0oerChRZxGqPABEnC8ZQGdAJKh5czVs2J+veO25MnuxJzvlDE6IShKlHqCjeRL+lpukOpPT0GjIA8WR9AwBYQP1NpE5n6h3oQjyXYEOtvHoh15yGFllQXPpHLhQAfR4Zzk20/PCziyead9lk2vW5ZovKD4oAxYixDwajsYIUZIpEPPqj45pF5zKpqt/ladthKc7VW3eEqJRK5j4vzUR82/qohl1tFMUPn3xJFG5WsZYuv+Mp49nnedSFaT3hmaNveN7EHhxrAuHlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKU5hww39XnZskum/TThkZ/HdtlXLBZVhLOKwZe7660=;
 b=yjj5y/6KvvDLEYjLPSUcoGknzAxWCpD86+671NpTNYkE5FJKnOEyKndTDyGgsn3+OPklEzDHfGHRAieBEazzbDzT+sSNZp1LtTSMNoAxh7vjrDrvDBrhLrJ1bK8uy4wjsB3U+FRfKC0huDv42DlQ5iOPoan2wOx8jbBYyQLhss74w0opoDuglLyXpGJ7spvdjLTrkvNlkhVMZLpCPXizcA8CII4eN5/VAgfqIFLbC3EZ2AqegOgK7PJ/NddG9LKufszFA1km/EMdPtMdT5PVeqBdHwZgD9XByk1VgtS794lYghs/LAkaZL9m80tNaAFRrNXf8X7QeOzOgHm8G9zoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 17:17:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 17:17:18 +0000
Date: Thu, 12 Feb 2026 17:17:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Radu
 Nicolau" <radu.nicolau@intel.com>, Declan Doherty <declan.doherty@intel.com>
Subject: Re: [PATCH v5 05/12] net/ixgbe: fix wrong pointer handling in IPsec
Message-ID: <aY4LGKrTeEkzACIT@bricha3-mobl1.ger.corp.intel.com>
References: <134252a49d330111781e4cb1baba470474091853.1770900758.git.anatoly.burakov@intel.com>
 <987bda2e-d92e-44f2-ae04-2a9dd6143b49@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <987bda2e-d92e-44f2-ae04-2a9dd6143b49@intel.com>
X-ClientProxiedBy: DU2PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:10:234::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b2a478-6c89-40f2-7d2d-08de6a5a9306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eZcIfIIQWLoRKJZjhFwakE23V0zbLdsTiEbPAt6+w7KWiudfQCAv1pzoqmqv?=
 =?us-ascii?Q?Y+KNw2z23U3HKlChuPmM3szareml9ExGadSkEy4rVkgfpJ/8ckxWH+/aGmKY?=
 =?us-ascii?Q?iPAkLguLSp4tBjyfpeKwhgbMXWODBRK4UBmGCZSBiDopNc1HusKVp93HzNYC?=
 =?us-ascii?Q?dtBt9P5io5MIXPqRDgUmh8vckHfEbOlDtJIIrd+vkiSymc4K2lgl7bfPwu/I?=
 =?us-ascii?Q?KmapLx0S+UKLd56BVqjwcQw0srlP4HrclXYwmjUI+BQxEhUAQnZyOvZbtP/5?=
 =?us-ascii?Q?oWwvqKkiWTsqkXUJy9SoxDdn4JtnYMVhpmMV51gQAfVL3MpTg74y0hXVTTNt?=
 =?us-ascii?Q?+7PFF0QPc/PSloVxjwo6pt2SDWpsD5kNZvx0jzlnTgxl0VjiZ7ib9Vjv/Mym?=
 =?us-ascii?Q?FjoOHKlbgJvTdRNOeTjqcC+Pmvy6FHAI/s1lcO7hMEClV0uQ4c+h6oSCJ9ij?=
 =?us-ascii?Q?XuHSPM7RmbJAzyoK/nYcWnUUAEdOd9rFu4T7QRgBhl+UCkxA3wknpEUz9LCu?=
 =?us-ascii?Q?au3fBceiW71oYgDqGYCY3NTms4cfKesez+evJgpf6a1gsD4OTQC0S8m49wJ+?=
 =?us-ascii?Q?EUDa7CccxOLmJJEx3HIrmQMxId7DaQpx5kz3NnQsDuiTwQSYIb9XJavlA3SD?=
 =?us-ascii?Q?QQj09/hYpxuEB5Kbzqky7zTjlAYc2LDT+owILmZQwTpF4327uZKR2uCup5QT?=
 =?us-ascii?Q?DxEYcEiX0MIXixfqy+HMbhWh1egfOvUYqVHt3R8jS98GVsvicjYsOEiaNDyt?=
 =?us-ascii?Q?9r9eL20g11buq1nch31FVH5YCjn8udL4FS/bgChC6f1CABZDuYgwJyoXEAbO?=
 =?us-ascii?Q?N3sEJ1f25UuqDXcuvg0eXPn57AaEoLy6gIEjP2HAanq+QmqzaWTXs3NyFmEl?=
 =?us-ascii?Q?5i2csxpL9HT7PNjPviZP8todVI6QGMNhQHPXaiF6eptrlot90lpN0kKqFmex?=
 =?us-ascii?Q?Ke+zTDuUoU9lu8YVneT457IVj+AyFygSPLJJyZSo7mq/SE7LWFM56/CerFi2?=
 =?us-ascii?Q?o8WWvavZB5+4O1752w1fH4uDmIddG2o476JQDuEfTV5lTNfl9v9cDY494j1C?=
 =?us-ascii?Q?G1rzw71ayomX9L/cnERnLDNkKIjSoraGHXS4SUoaJ/yeMfi6FHTMxWNnr0JX?=
 =?us-ascii?Q?l01ctMYs7P3M+z3Z0VSfkWPB6Fl0ZxoFtT6wZi3XaDpdkrDKGKSLn1aHqeZB?=
 =?us-ascii?Q?NzkDDhgQ9264wgxyuMRgEeh9E3EcUElRriCHa6HB2etmyeIlNfhK135COsAh?=
 =?us-ascii?Q?hvROJGQxd36/9OOreZTpK2rLQdaokWeTyeHaq59SSAtm/zyoyL9lIZpUh+Bb?=
 =?us-ascii?Q?o7u+zwr1dX1E2uuMEqXnr9hwBl+1QzoPyufLeJM77qCOzPrd44Dy+i989EXG?=
 =?us-ascii?Q?IxTbmPsdfQwEhnRUajalryGftMmLpeW/VJnOQYMtMcDee5GpvmR9Cfhhp/CV?=
 =?us-ascii?Q?k5Q+a0fnsFpW2VFmwcc6mOirL/59pKHrI3GWEGor4XJJ2ap8JjY27X96sCYs?=
 =?us-ascii?Q?xEy0hqPY1xQw3m0o5NiQYy/w2CW97q2d9GgL6kh/9pSGuv3GL/z2zvAqZJAG?=
 =?us-ascii?Q?SFo1lNb3iMgEY8BP8kE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1W4gcNXYaqYM4x0WpsLGOVwTiYDnoM/RriIOTheJWyfL2fhUJFzISWnaxQVZ?=
 =?us-ascii?Q?XYbE6WLbEBaInVPXELh40+CwUY8B7srD01iz7u2KZl6INHCcZBgwPX7eGcmo?=
 =?us-ascii?Q?KX2cmoq4LvfuPEyEVOd5nit1LrUmdVRC/NdUtXeaKCAwvC/sp9V4n6RMph1S?=
 =?us-ascii?Q?fuUVCeup2OffFBeOJ9f/3RoSUD6DdpTTKIxqnyKOSgsKp9eXoHefr4wvrcLl?=
 =?us-ascii?Q?2eC2I6Va3qy+EN0rI95A1X5C8n2RD2eYVuSEM9E+JHT0b+ZIrU011T9STffJ?=
 =?us-ascii?Q?oZrRdhBwEd4U4EU7DUNdIEX6kJIoF35UMlgh7OEZjROjdsvBgRuVVvWnT8QJ?=
 =?us-ascii?Q?t3ZWo4FOEWpUDI6JEti5tb8fp/xVXlm3RTrmUXCcovYGpm6tfoXaIqnp33x7?=
 =?us-ascii?Q?SiD45nurtlpGgGMLH41X4XtiqUDVhnnIb1nmoiWsPcctE2CvhYwCJoVgAulr?=
 =?us-ascii?Q?N34UqnSjju/eGW2iI0JAm3/TPiIiBRnuPmc5UnjtV0kvLwBmG7+GuJOpHaIo?=
 =?us-ascii?Q?lk1ZXwsWCob6kuFTeEmr0A+3NNZDoIyf+nxWEHXxJHFRPq6yC5R8XpmbmuWE?=
 =?us-ascii?Q?DwYrMjHYarnl5Om/moQbT2vKLNPHenTKE1cC+c0e1p5woylFcZ34He6WGP0G?=
 =?us-ascii?Q?FRxNSuDZKDcHuy82VrETIakI3ZZ2Zf1fNWuGCNKC7Mlq46I5fBUrgeOTMbVL?=
 =?us-ascii?Q?2g9nUo8lgnhZVsyv6TQRG06P9IVy7B7o+iJeCSlS39YDkw+flnPKJiBGQmhv?=
 =?us-ascii?Q?SsTCoN4/akHKUGIj3Vl42esrkmKzFilZiK6K+jQoOv+8h/WrzxlKozsAWOrd?=
 =?us-ascii?Q?5RQi7WpzszgYki9bnmJl6QhDRd6E4Tq3yeXvKi7/pV8DVFpdLrybEVIs6Y/f?=
 =?us-ascii?Q?nlR7INMUvs90+yZIhdJOt0BBj+nqs0xQsYtlJrtXxlXrwshW93UQ9vX87KSj?=
 =?us-ascii?Q?OrzTHz6r0AMJIaSstwGNFyLjoopAIXsoF7OC09zEoJBaWc3+BQNUu988u1fp?=
 =?us-ascii?Q?d5SC8y75oZkHD/iRrXCKkjwe4EcF8PqIbCxkbyZmijtXHebbYWiyFtSziSnq?=
 =?us-ascii?Q?WXSMDyBDcdIf+FfWUdhfYryCMB3O8f/N49nWo+gRzhThay3ZogKi5WHd64ie?=
 =?us-ascii?Q?wKKOSdmRe+f1/Dbg6Dl/Z+3kdJxwfm+PDSIyLfMJHcN/pX+spynPONkzKK01?=
 =?us-ascii?Q?Hg1Twmv3gyIelSW5PMeUBkd1K32WwamDJhvDPlgUquaOThiuH8th/8GgQ2kR?=
 =?us-ascii?Q?ejTqkse1kFIx2jfKuHpmlM1LVSUavAAnSdacWUK5BSglULvDWmJyppf7mJAN?=
 =?us-ascii?Q?NIdfwDUg8aKYs91guHe1iSVniAJtkmQSmP2LfC4xRrRFsZp2zvjVLr6E8CS3?=
 =?us-ascii?Q?YHHr1/BDPLx9z8WMELa21WkcmCu/WoWj7GGeu6daDhkZ83hrAU2XpMx5xwkl?=
 =?us-ascii?Q?XK3i4mBZPAWVpnESEJIEVktN3vVABZDhp+no8uTHnD29KKprBwdKpwbVoQXn?=
 =?us-ascii?Q?GX0LF3VSRCsyyp/6grIqXvTo6haCD2vA9QM73FTrFwdOpZjujchKLN6uf1cQ?=
 =?us-ascii?Q?MUb0gYRYvxVygpbBTj4mcehq3koHR1C//lIhuBojeiSPPl/W4IlWcangrfzY?=
 =?us-ascii?Q?+taGl0Z+yIZL4fSr1ARpHuvCNFgeQik2dJxKHa7s0vEn4AnthKBXqrt+dhn/?=
 =?us-ascii?Q?EUmdRMWiJm9Q2umW9UYX1zyIs69Z3+ajSir/R3nh+JpZr+aJ23cGvwhc2dTu?=
 =?us-ascii?Q?jK74ohv+X14LOzAoDBYydnnp337ALxQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b2a478-6c89-40f2-7d2d-08de6a5a9306
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:17:18.1708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz/xQH0vqB5m4FIWQnXjD0JjnaDh4HqnD1IBHkr5zQou/ypSZrIrYRtRDC8meX9ozjQhBfbLzrfFaZCo/E1hh+3fm0Z8dAShKeMKe52HCK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
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

On Thu, Feb 12, 2026 at 03:50:26PM +0100, Burakov, Anatoly wrote:
> On 2/12/2026 1:53 PM, Anatoly Burakov wrote:
> > The original IPsec "add SA from flow" function expected a void* pointer to
> > security session as its first argument. However, the actual code was not
> > passing that, instead it passed `rte_flow_action_security` which was a
> > *container* for security session pointer.
> > 
> > Fix it by passing correct pointer type, as well as make typing more
> > explicit to let compiler catch such bugs in the future.
> > 
> > Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> > Cc: radu.nicolau@intel.com
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> 
> <snip>
> 
> > +		const struct ip_spec *spec)
> >   {
> > -	/**
> > -	 * FIXME Updating the session priv data when the session is const.
> > -	 * Typecasting done here is wrong and the implementation need to be corrected.
> > -	 */
> > -	struct ixgbe_crypto_session *ic_session = (void *)(uintptr_t)
> > -			((const struct rte_security_session *)sess)->driver_priv_data;
> > +	struct ixgbe_crypto_session *ic_session =
> > +			RTE_CAST_PTR(struct ixgbe_crypto_session *, sess->driver_priv_data);
> 
> Despite being removed, the comment is still true. This is an artifact of how
> we get the crypto session (it comes from security rte_flow action, which is
> const).
> 
Why not keep the comment then?
