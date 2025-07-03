Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34E1C83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 08:00:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B745840287;
	Thu,  3 Jul 2025 10:00:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7836E40285
 for <dev@dpdk.org>; Thu,  3 Jul 2025 10:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751529649; x=1783065649;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vWAu8zZLLJ9Zx6eE2PTHOvvc3/9HcVnyPEuzKFGNC+Q=;
 b=dybK0PluxSZwaDWgNbtW7PGtgg70OJKjI5mHlC7we9FBTZthdHU1LNQn
 FCnfY/CxBxPXMoTPd4/51alEN+jWU24ijJs0FvKakAXemadfdiiWccFi6
 XDLeoEh1dfbkh/ei1DMRJkCpikjH6IxXAoqLz4PEHF6O3ptbHaPfA9Mfw
 8BKv71fLW7jzX1AEUFHZDk+HoVT+s4eHuiQv5RGbYfbvdnm42mR4QxviI
 t74qFap5rKUM/gJtTFjj/QY1vCbagAxdagCjKDAi37Pfsli/yk4iM9mZX
 kt0SZsXUgTTOR5gmOpAAOHpefC60ZIgLR0Oi6Q7tF2LAw5iNDov/N9DSA A==;
X-CSE-ConnectionGUID: 0TX+uW6CQZSnY7QS7144NA==
X-CSE-MsgGUID: KYVLxbjISlmP9Ps84M7YZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53709911"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53709911"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:00:47 -0700
X-CSE-ConnectionGUID: tUy6RVHeTrOIdHCCmjTvCg==
X-CSE-MsgGUID: +SPSnJETSmWHx59jBJkYoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="158346629"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:00:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 01:00:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 01:00:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 01:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLw89IxNyN3SSQki5Ggql0yDMI6u2AXHqo+VL0anN8mMwqUhn9zgFcaNKIAs1zr8o4C4XKvDpwdJvnhT+1U6EE8bNo+2/yzSp05u0R7sS45FU4vW1sXVOk++NIehYL5y4Z3n+yUUxdx+/Ay0hKYQ7vtcRLuzKwh65BDOV1c5Fuv/FpIUVXxVfxwte6j3YyM8qQLCTquQaVG6aa/cQEOymyT0yA6xtynRYfNJCD/yqKY8TtONwMM+EwqOSCPUobs3GU6VJLSQU0fX0lgHUkRqkp3drwm6EWEVvzySavrDQBPsPYHaZQ9QrMA2KSXctxhySUk6/dKRA6Oa04Tfggn3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2+vOAi8PbBAlGsdCe4QzSzRXMLFbK3AXmc8ZgcLKzo=;
 b=q0gwL3gZTsLu7parNx9bzmZ6XSkYzG2QgooWgOJJgHoHIiH59SGfGwKTD2SobGyG4OufJxnrS3/4xxBkMlfiC6MNDauozmOpaUZrV/irW87aYi5tXC6G8LdiCp5FucFEaCZY3V/nw5y2/WSo6axOS0bLmP0p/CghnOomWv1qaqLwPR49yQkBHwGGsIKFx69RITqq0tQps6BCkd5fyT1FoW8zL9+rVMZBKsGjblbBwNw2u3EBw/ktcqkdKHQ1Qcx5g047utxrshv3Mnm5Pz93BptSbGi8vWmHDCc+6zePyV+70zT8k40Wj6BL8UEu5XoJvup4PyFWUTRRa0SIW+jatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 08:00:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 08:00:36 +0000
Date: Thu, 3 Jul 2025 09:00:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>
Subject: Re: [PATCH v2] build/x86: fix support for older compilers
Message-ID: <aGY4nkFZXSBFCZBp@bricha3-mobl1.ger.corp.intel.com>
References: <20250702155129.3440210-1-bruce.richardson@intel.com>
 <20250702160138.3441279-1-bruce.richardson@intel.com>
 <20250702112242.7b93d978@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250702112242.7b93d978@hermes.local>
X-ClientProxiedBy: DUZPR01CA0268.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: d3911d11-5504-4148-ca06-08ddba07b1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N7rdOpB3o+SOxalkmrlaWLR0UGgkVQaSnx+Es6+Iuo3QNs0HMut3trKjmYyt?=
 =?us-ascii?Q?XhJKzD6CNXq7baAuD9fzmj0gWsESqYUil1tskgMD8Vhjvtxitzei4gYvnN2u?=
 =?us-ascii?Q?Y/InliES1wsSCCK/UVCINoeAntVVf7FHGEHIsvxHJtMmZSKDmU64vjk6yz9b?=
 =?us-ascii?Q?38DZm5JuSd5t2WlkZ5qAFNggvWKkGG/Saso8hnskRbqEBFk+e7MCep5JtuWD?=
 =?us-ascii?Q?3+Age29e+fg4eN84V1utNbXBosPvYw0VnznTBh31QXoPRaXs/CY3TyNup2Dv?=
 =?us-ascii?Q?ggFY+Rd41st4UVJFMJbtkp3xYalwdkW8rh0RYTxdDtkxtojKS1RsegucGt5F?=
 =?us-ascii?Q?Ssw04PZj6Ks4FURMewhGj0IuOvF+5AV8jEu+0Eslco2yaGPqdV3o2pvvWX1y?=
 =?us-ascii?Q?APc7mvJv8x7ewFMuNQwLJTDdgK3yxyBz2XIrXngW5g9tXF+J+4qISTDxnvYc?=
 =?us-ascii?Q?fCutIu1PzgYI30Q+RiLPKK0etHvRHC0gbwSOcZlnJneW9c3vedg5x+oShiCt?=
 =?us-ascii?Q?RfUU9DbuIoXl0bpG9V6+5V2RDZVVbPYH40CehITrgG2Z0yALoQMU+L+9mANd?=
 =?us-ascii?Q?I1Aprsif3cDws9uhD8KJvsvAiG5eLBSL1Q4Rzjue74bW0m7xvqveyyTRW0zL?=
 =?us-ascii?Q?hgmLPS4mjhEVbbrgCBET4wDSZu76l++pwzUNHJ6WjBv/+6ClTHhz4H2R2dt9?=
 =?us-ascii?Q?EWzDuM2rLHAwAZsP1rIYKfw7UFZyz+/1YU8tUWCesqC7k+aS2um3QEU0zaJT?=
 =?us-ascii?Q?Ogq5dgkWNsiSQFbi5T+3AfZ+hQPbiuxLhLptD6FuU1AqNG8d1iBAeFlqghhq?=
 =?us-ascii?Q?XtuuOAWUkZK5J/jpCqFzzb1egcRNg2NcG1oDrxwl2DdRh/TKRDAMvbecixAd?=
 =?us-ascii?Q?Q1qJZHu25qw3CitzqrWt3O4TIPT8P8p5WZxiExI5cwHJ5u0PVqzskRTDnuLg?=
 =?us-ascii?Q?tBOLKrzuS4ger/pUVnsGnm56Bo06tPNijkOgcqblNGNyY4gLLCPXrMKl9SAe?=
 =?us-ascii?Q?drks1RKSE988JzNedNEEE16mtAoDHaDPNwAB/t+ONpabCo6OpbBj9TT66icL?=
 =?us-ascii?Q?KoBP0nViL5NYSFD0UGvxskpk5IF4nfXH2fQg9QCCYFR3ut2GH7ppuNXAg7GV?=
 =?us-ascii?Q?hlSYAJNw6+4wyUnYlnd+R049NY7uVLerU2eNJ/MZarGi1ebrFnpqLjpv3xuS?=
 =?us-ascii?Q?w/slM9dd30r3k3gRCuX3hK3alocynlMer5UE8B7PzsIiOl3Szsn49uv3p7gX?=
 =?us-ascii?Q?MursWnV/+csGGjbBbxakyOSqlE57F6waH5FxIZKRoghfYbrYfMTVwWtY8UTs?=
 =?us-ascii?Q?8h1uDx0RCoS45dG21zuALRZtqRd9RQNIvnGr/Qfe8P9qeSqoljzSaqv1YRoj?=
 =?us-ascii?Q?aYoFPoY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eja54Nd2zwFJv1RULyWH+dTPAof3ZJH3BOOxqPlojBHFWvwr/pDtxxXG05AM?=
 =?us-ascii?Q?V/dTelihaOxGabrWrEyXgp6zSiqcF5iEP7KfbrU8TBx6c6X3J8cxgMmByHr6?=
 =?us-ascii?Q?yxndBcYYsVQNqVPDZCj3ObFRwKyyGaVlVxGGm8x/KuYetie1hiNZ996BTxyj?=
 =?us-ascii?Q?caaoIHPgdL9YVVyTjEyW0W2WADiEeEpCZZ0nT9okvGKD/mhWlaHn2scA6+O8?=
 =?us-ascii?Q?Gcy8rXL/tDtrC43W34SvEajqWE1Q3ge7GJVDja08YQkYn56R3achCXxX+QWa?=
 =?us-ascii?Q?1o5J3Jw4Gd4XJDR+BAGoVmm1Ek/gykPcmA2KPgVX9sX3GpT0dZJ/fkYDSDjf?=
 =?us-ascii?Q?xhuMJowIOQ98++pYBm3rSsoXVc7jR3QzWIEx2SrEYh6BWFmzj2sn2RdbjC1Z?=
 =?us-ascii?Q?1RYtf2zYIwEry6LylMOjEhSxVqvksAqp8GTfmNWcAksKmDLFKyAtz4RQG+uv?=
 =?us-ascii?Q?vkNKGMypfZ/GNyNUYSOEPGeEHBaX5JHeR2Ov0E6UA7REWDsBLxT6QIyL+LKh?=
 =?us-ascii?Q?U7wFHjr6k///wpAsEQu/Fpj2ALuaE+lqq2TyEeYrqQLk11R7ZdeXr5Xs2RUt?=
 =?us-ascii?Q?P7IMoiaavsSJ7dK/SkkvSlXD6rR3nWLEAm+sN3hHGwOa+7w8DC55Bnj0kgQZ?=
 =?us-ascii?Q?Mej3K0wDpvHbXskcyUupLNPWkcFX3sH7C3l+HN7UAsfr3wkDc4USNT1MNNam?=
 =?us-ascii?Q?gJS8rO+9wf9EfSRX+D/wc/Olzx5SvpqYUnc/RfDPENfGelLaKfq0XAGbfcCi?=
 =?us-ascii?Q?P799fQYBUgBg3VOYjxBm+3eI5kkgUGzccsP9+J0iRqLgM3YXilN/our/bKQF?=
 =?us-ascii?Q?NCa0C4NEpEjWXjldaNA+0RktUhz+G4NGD1l9a+dklVYZeFA0GTukDzeh54MM?=
 =?us-ascii?Q?DwQXbQeFFP4ca0cvCjWUaii2e+xFurKPCJ4m5ZtIDAQ+k4w/niS10SfxO4Vn?=
 =?us-ascii?Q?bz8/6kTQuxF2ISbNG+S0U7hyOU0fSCFywpuimF1o9tNXKOWJBP9ZmvIRTKse?=
 =?us-ascii?Q?57T6gXCDTRFd7FJHj4leiTR1rZ4O4zuGgGbGfrEEDzOEt+97xNSvZIYCyWkB?=
 =?us-ascii?Q?NNeUBr8SVmQEM25srS7UX84+YMFniQxzReinEvba6ZmGR4UY9eQksiSMfHqk?=
 =?us-ascii?Q?6z4x1HvOTVBQfsSZXTs7fxNezPUkBB17AEY3PgLjTqFvxQ+6WqP//mlm+TYh?=
 =?us-ascii?Q?yK2oa2LA+5LL1/v140mgNIgpF+xGRoUy+NW7BXswHwsYbVPG7RRJ9msf0Qta?=
 =?us-ascii?Q?KZLBZ7cWHkvjbtH+wIUlpwCfR2Xyi1Gn4p7/t6cYlnrgr8elcAwrhHOyO9Gy?=
 =?us-ascii?Q?QBD8+zOrRdO/jZ1E0QjmFrkHgi2GzewH+SenmIForGzo3o6xrHMqwpPpV7Ui?=
 =?us-ascii?Q?Za+Vkpy5/8tcBzfIKrdRgbD3zbN7apY9Wkx61gXYQpFyTLEokf9Ik4VKJ7fa?=
 =?us-ascii?Q?f3XFDZLeWBH9Q4dt+rIcMS+BLSXx5C/fAO4ZRQBJDWKcnUEZ2lIomioSR/6C?=
 =?us-ascii?Q?CZrvCbjCzQESccYYZJf/WYaHqaw7ORaC0XTVDykJhLQzo9LeNRBGmixEiXh1?=
 =?us-ascii?Q?RSbGVIxy4vDTFSTQDxXAArufb8pBfxb25I1DFIg3dil1wdk52yua/WduRfjO?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3911d11-5504-4148-ca06-08ddba07b1a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:00:36.6663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvWQ749r3JLv3Mf1jAUGlvE2sXWAkhoVCIJa51AuFPce2kDC6yHvH6pQzPnlh3iilbAMWNm8pOrgknsYXMFOnh3Cnw6wDCAt7/+GNmcWBLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
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

On Wed, Jul 02, 2025 at 11:22:42AM -0700, Stephen Hemminger wrote:
> On Wed,  2 Jul 2025 17:00:45 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > Some older compilers e.g. gcc 8.5, do not support overriding
> > -march=native with another architecture, leading to build warnings such
> > as reported in Bugzilla (link below). Add a check for that case, and
> > explicitly add the avx512 flags if necessary.
> > 
> > Note: it appears that it is only the "native" flag that isn't
> > overridden, which makes the issue hard to reproduce e.g. using
> > godbolt.org, or on a modern machine. For example, testing with gcc 8.5
> > on a haswell machine, using 'native' vs explicit 'haswell':
> > 
> > gcc -march=native -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
> > 0
> > 
> > gcc -march=haswell -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
> > 5
> > 
> > Bugzilla ID: 1736
> > Fixes: e361ae3f59d3 ("build: reduce use of AVX compiler flags")
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  config/x86/meson.build | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/config/x86/meson.build b/config/x86/meson.build
> > index e2ccfb6d12..0dcc5ddee4 100644
> > --- a/config/x86/meson.build
> > +++ b/config/x86/meson.build
> > @@ -71,8 +71,13 @@ avx512_march_flag = '-march=x86-64-v4'
> >  if not cc.has_argument(avx512_march_flag)
> >      avx512_march_flag = '-march=skylake-avx512'
> >  endif
> > +# workaround for older compilers, e.g. gcc 8.5 on RHEL 8.
> > +# if march flag overriding doesn't work, explicitly add flags for AVX512.
> > +if cc.get_define('__AVX512F__', args: [machine_args, avx512_march_flag]) == ''
> > +    avx512_march_flag = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl']
> > +endif
> 
> RHEL 8.5 reached end of extended support cycle (EOL).
> Why are we still supporting it?

Folks working for Redhat can answer better than me, but according to [1]
it's not EOL yet. Also, we support it in DPDK because users are still using
it - we had two separate people report seeing the issue on RHEL 8 on RC2,
so likely a reasonable number will be using it with the actual release.

/Bruce

[1] https://en.wikipedia.org/wiki/Red_Hat_Enterprise_Linux#Version_history_and_timeline
