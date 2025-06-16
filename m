Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B00EC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 10:32:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE8740616;
	Mon, 16 Jun 2025 12:32:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4DD4D40430
 for <dev@dpdk.org>; Mon, 16 Jun 2025 12:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750069964; x=1781605964;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2WFWLjK45rAalT10dDpkbLobF/cpIH5UjPVUOMLyNQ4=;
 b=h70ZFPK9Nrp22IpfRC1JDTDFK/1+2F9Xgi5NUFLjDIP9hw3ylLphAXpV
 9BbLN8CC914lLy1xtsEtAUfP5ZQ3gm8lBM6w2tvSn8FeB85zGiAwrSg2z
 rk+aS4Nx6X0kqw6SdPVlqTW8ZxUrsA43pfSDRcRWNe+fKqNe0IlN+vvl1
 DeUdTn9Zg/G1l0eztQGWByHG2Zc6YhbmCnnKGT7LDTmUqcEUN/ufkJmy3
 GCBZTh8RJSvesyjJ7hFbOaHKCskVspdR8M7gbYLW+U/ps0UviOaC7WwfX
 skEMAcP4d5mO0jPjAnNu9B7/zteI59DlkHFro1Err0ADefdOTcOWnerql A==;
X-CSE-ConnectionGUID: JHwzjxxNS6e+SEnrYlUk8A==
X-CSE-MsgGUID: ACCy4L28TEqyTKVKtlpyZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52298084"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="52298084"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 03:32:40 -0700
X-CSE-ConnectionGUID: HU0eXWSdQQOzLk3w9x318g==
X-CSE-MsgGUID: +65ru1p5T62tGUdJZE8TaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="149335985"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 03:32:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 03:32:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 03:32:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.86)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 03:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLugaX5B97GxrNCm1+hOJX3d79kY0lL16JOeOjt+8jFt+OX1qmUOgN/xQXp07b6k27hVltcpeJgntY+tO7tkKF8r0+gkv9o1xbj12iEIZHbM+cax84fskf8Iw+Nsnb8tLtXdvElA0p+HAVPK7CrHp/v7DDC8D0yCeAojOwnMvcCCJtA5s9Y2zpH/S5wUQ824x40hauU96TxAZZD3OWruCBJLeY7kYMhVrz6RIand0qM00iMJygoZfNdxPKdmrVE+wGvRcfK5Ezo1jlB2C4GHRVD9V/JtLmggnr36l3zgt95I50gzydnB54oDMiy87Udc5q5AQ4ovBceTbLjwGG/Lng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFeYTnqVux9LyQCwdGpTz5H6A0s2Rtu+r1gDXraBRXo=;
 b=o3RJd89GGY2LKW7olXVIpSMUgDnHELZhpMwwaO0y8Jleyp4H/uUVdqvHLPlXvzKnM6ALMUBn9hk82n+ams4Doss7B3bzhl05frwmcO17xmKdwdkvAudASPvI0GfcwHA/Ba+1zJag3f4rzRpgk9xbiJd1wlBdW8qgqWYYeRaj3prARRAReFbY1NVoGn7UV+71VHqfTHHd4wGsIvudw6Jy6qlsOdhloePOoDELsn3VGxhidn3G8VU2B51tX/dY5vnQBULkFOz3s4+Mbk0EfCTfr5ddh/g7VStvXqQH402DFXmThXBF3B0xVaLXhLaccf+d/8MWdEYLNiPS9AaSCQdI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7426.namprd11.prod.outlook.com (2603:10b6:a03:4c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 10:32:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 10:32:35 +0000
Date: Mon, 16 Jun 2025 11:32:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Tomasz Duszynski <tduszynski@marvell.com>
CC: <thomas@monjalon.net>, <david.marchand@redhat.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <roretzla@linux.microsoft.com>, <skori@marvell.com>
Subject: Re: [PATCH 6/6] trace: add PMU
Message-ID: <aE_yvfCyj5qBoFlX@bricha3-mobl1.ger.corp.intel.com>
References: <21436140.jiFIW2sfyF@thomas>
 <20250616094903.3236231-1-tduszynski@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616094903.3236231-1-tduszynski@marvell.com>
X-ClientProxiedBy: DU6P191CA0065.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: ef490680-0e39-4b9a-e7d2-08ddacc11bb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1NrTe8RumdaiXEibNCsF+Dyvl1RkazPmYwwEoS6+4PGGBesohRHL6koA+KfK?=
 =?us-ascii?Q?h2Zs0xbxBhX0ouRQ8o6htPydXhCXfJ7PJqLCB7gyG7RLJw1uIRMMvRv9fSC9?=
 =?us-ascii?Q?sm9AwmtjO5mKp9cDBI6zdTGRW8Fv+CqX6MSyxK7srY/++FEtzIZuRP8ba8Y3?=
 =?us-ascii?Q?Mjc5dI5p2ckHp8GBMzV85EAT/t+pvNTS3wr8HBgkDWqLx5T47mKPP86xmh22?=
 =?us-ascii?Q?59SNQq/GrRLLhv2mY6CZH7OVO0Zd10FkfYtyPbgrGgiXOirtQN8oXaH85GHP?=
 =?us-ascii?Q?e1SdzqDZGnA84sd6fi0uOTlbFkKwczAeOm3JyE20mpdLafdiNNCBtaNsCe55?=
 =?us-ascii?Q?ApAvlz71e7x8/d9adA7R4cxYIsKRzzej3XTMR05EULFSGHYMY3q7gWhOlNIi?=
 =?us-ascii?Q?MU320A7uzdOs0GzrkI8OJIvTTKn7b39z64PWxhwMtzIeHzY4lE5vQEWpgz5/?=
 =?us-ascii?Q?/yxFw3Ys50TtxsT0cnnUpobf3X4PLJ6in3LC7ghiO8u1PNZGM/I1gPq+MP/H?=
 =?us-ascii?Q?wyTFZCvJqZZLemx/3kr/ugMJQY0Ya0FihcCKZOTDXsXzbQzKa6Af+bddsSj9?=
 =?us-ascii?Q?xA2zXkb+2Y2ilBXfDAjvNW63yBaaNAwY87U4v/pfGz3GIhqMBHMB1hyYONDZ?=
 =?us-ascii?Q?mqzSMYy2gvlXrsKutHIlpbXKGW/LZcKvhakyD9MgQ9ZpFbrlk83MF96RdaYQ?=
 =?us-ascii?Q?t4LyLsB4H+h8h/6Yip6gqLODlaDmvwaG9YBHI0CPFITzw3DOM6UjogmR3lkj?=
 =?us-ascii?Q?mNGuRP+SOTm9jahEyvDQBoPRry8RkmaWEvtWHQ8O0NavjUQ88oS9+s3SEb3m?=
 =?us-ascii?Q?nZDMtHrULIpdogwEs8GpgwakChZUJ4AAJwX/43pDsne1EebgNWhMTGRg/r4g?=
 =?us-ascii?Q?UOQeOYeIK243VNj8W324v7FM0JuPhJ3Zq3p1CF8J0qMTkAkEWQt9ClJkGf8K?=
 =?us-ascii?Q?7ESbKEOmCFN1RcY4UPf4tcuJtDZ/b2Qbo6NXPQRMDaTuqDXgBnqDJs1X9OMp?=
 =?us-ascii?Q?kl/9fVY4V7P7ZmfFOEMsyhh8OmnS73aiTyqiSalsFDc707t0xUYguZDH8eiy?=
 =?us-ascii?Q?LDnikWGLiI0OY9sNz7yDdnFWlKK/VLEJjTSH2rDgP5moxmx4E0PE3VBR+wep?=
 =?us-ascii?Q?nGbOkizCrW8BPcwizM5s1OxGTfMC9FxoO+Ga81bPHUO4aUg6mU3WFzkM9uTx?=
 =?us-ascii?Q?AZKApGVzUZnaSOw4W3y1GPNtW5MPl/zh7+QzItNZC/aN8CE+hiOJDjycrRBe?=
 =?us-ascii?Q?8ObOu3wnv/FyIy6ygWZ7aTyGCzD+SxTXkbinx+Rk9v91j4PbpPxsXK944lcy?=
 =?us-ascii?Q?H7PIgFcDr/kZLmVBOvI5r44XtjOihediyBdfAUBaQUlqDIFlEY5c1avbEsxU?=
 =?us-ascii?Q?ApH14oUNEY7injjMn5wWcBLViSHY97V6wsUP2qG2GYHhJMmNYS7cC1GB8Qnd?=
 =?us-ascii?Q?lwDf2tgOBPc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EV1Df1ahJ3DbUFeaIAAst45XQBBCmoiKfdCvN0yIZ09OaIK48A35gCe0rxp9?=
 =?us-ascii?Q?W/oQTPNOiJnGzCCFjggOknCpW8NI8Bmymyu/Qwf/gGrH6+UHzVapR0YOleZA?=
 =?us-ascii?Q?3Gawo4nWtmKwfBvEsLRK4p5gNa2tGRRqzXfpron4TDnhiaYGzxbd5zr5KaXu?=
 =?us-ascii?Q?vTvx244mQF7aHC5SZja1hDxxWsCFBsjLl2430Fe/KF++1puUC0BofP3ugMfJ?=
 =?us-ascii?Q?vC9VJf/RbkppCE8ff37P8puA8UVg5OcC1blY/AqnA3Hf9TbXnyTTKNRZwqff?=
 =?us-ascii?Q?LGIV6y4OBCa6YPf+AggbgsNFjxgU55YJ8LVCd80E9YJp8ydFzYKiJoKSKvRg?=
 =?us-ascii?Q?3FteWfIFeOVB9FdT4C0QW0Fda1fXr5uO4+hjWQaZP9QS1pfXnLBLTjqvUqAa?=
 =?us-ascii?Q?jNLurKSk32ABXHmUZ+bikbt+UVWJNk6ln3JcUrZcsyGjrc7BAZuJEI+AFK4f?=
 =?us-ascii?Q?uiok3FaMT+L1Eh/4v5yK+3dKJkMEZg2cB60hX/YP3g0ESktBE5iHCFb0Sgd3?=
 =?us-ascii?Q?/SmRZbquxZeh93TIRp4sBb59q3PYuU8g0YElpq6uF1jVP3xtOpNfa/mWhxtz?=
 =?us-ascii?Q?nUw3gF6rn+5I8yyD4SO4MEV5I0DhhaIU+Aa509UP9HSJuctAyFry8YS/Fppk?=
 =?us-ascii?Q?NKEdGBCmQ5J02Ak6atxZvAywg+T6+6ZAhQFJXnnQO9Ot8wjY1EYyhy6a3kiE?=
 =?us-ascii?Q?jpX+J9k263uFxTfL7kmB0NJ8x5KxGwlg6G4s8KVqIPPKeJZukRr1/0acI+4Y?=
 =?us-ascii?Q?JtJzWyGOFh8+5hY5Qxnkla/9vodALfifxZEUmMgrzSU3PnKDC2jdsI1DjpP1?=
 =?us-ascii?Q?VQIWm0teDT1qxUQZkdJh5bt6qnALghTA5YrXd3H7EYI8ArB36sOqS2jgHDZC?=
 =?us-ascii?Q?ycQi+EcwvN6R2qtHVkxrry5GLCpR6+dcBOJH8L7PywSIYaMn2ohWJIEk2izK?=
 =?us-ascii?Q?EuS20okXSdS9loy5LF/asx/2jIyRxzyo68u4FltzME1S3s9qasYH+WgVaPmL?=
 =?us-ascii?Q?F+BO31Bgav4PmUF6Iw39p8TFqu1qXGqMbe9R+7IudnQsGoJMVJzEP4bjJ3cG?=
 =?us-ascii?Q?l33mOF/apTY5r0RgTwMkQE9IsokyzsRzZplTxUgF2ApxFH6DiMb8h+/vgIfh?=
 =?us-ascii?Q?oyTOzQx9UYIzeOIRLaittdpIeLuIM1b5Nnm9PrxuHKKTtFlYD5SeGLDhelCO?=
 =?us-ascii?Q?fTu/LqRAMQ8Alv6Vo0U3j4ElnDg7vfr9PUMpJtC8KnVB4FVe7QDeQzT7MD0L?=
 =?us-ascii?Q?2Nyslpcix3Aj099ebLvQuen/Pk2jCMyV/Dssi1IZGV89QvIc8hFfA9H+TiJY?=
 =?us-ascii?Q?h/PMkyM+geaHANiS3TqCQQdqdv54PEmRhKkPO4Vr3qWwDntCKMRe7IkvSxND?=
 =?us-ascii?Q?EYlY+o/rJS8D/H5aefJMY4LWDWFR+besRIrIhYx0RYP5chY5/D+DdZWfYSfN?=
 =?us-ascii?Q?ICEMlL1pwP4c3mWhzDkc5b3l0wQv3/0MD4Jf5l1LO0/sNGckign59YlAWLPU?=
 =?us-ascii?Q?/QWZMoudcQElO76M7ovWx3jTf5dfsoHRkiwI+heKC6/8EHgOLLGR89Iw+eD+?=
 =?us-ascii?Q?2MFV65Xg/mDSxXn6MrvyDfEpjoQ61TAoW9B5wT8IpFCFMpnxamYHVvNhDlXB?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef490680-0e39-4b9a-e7d2-08ddacc11bb1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 10:32:35.0807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZO5i1xFq2dy+DOvFKfSKQ4mC58C2oMKqYP73G7cN90OXJC1P5kdYtA5SDPNSyAr5P1D6/ak3NHIgKiMXssvxdwJV1d/f7tiPURXGTlRSESE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7426
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

On Mon, Jun 16, 2025 at 11:49:03AM +0200, Tomasz Duszynski wrote:
> >16/06/2025 08:53, Tomasz Duszynski:
> >> @@ -86,6 +86,7 @@ always_enable = [
> >>          'ring',
> >>          'stack',
> >>          'telemetry',
> >> +        'pmu',
> >>  ]
> >
> >This list is alphabetically sorted.
> 
> Right, missed that.
> 
> >
> >What is the justification for always enabling PMU lib?
> >Is it a good idea to always enable an experimental library?
> 
> Well, since on Linux eal depends on pmu, disabling pmu ends up disabling
> eal, which breaks minimal build.
> 
> As for the second question - no. I think ideally lib should remain
> optional. However, since trace is part of eal, that indirectly forces
> pmu to be built.
> 

Or else you need to put ifdefs into the EAL code to only call the pmu
functions when the library is enabled. Given that PMU library is only
enabled for Linux, and yet there are changes in this patch to a number of
common EAL files, that is probably a good option to take. It gives you the
ability to make PMU optional, as well as supporting non-linux OS's.

/Bruce
