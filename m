Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA065CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 15:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D39104042F;
	Fri, 16 Oct 2026 17:42:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 19091402F2
 for <dev@dpdk.org>; Fri, 16 Oct 2026 17:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792165365; x=1823701365;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=A/1htgtVpgxoyc7inGQOZG1STsofgWq5Kd1lP+tmc7s=;
 b=FX7+LlWy9EnZuj+OEfOBZAZs6CsTZfLrMz/qzAdNJATCwexBCckE83nr
 uInskx5VpptFTwmm3U4ySVb06vG8iXDxM+/PZ+Qh/r2DjkvudU87U0Wxa
 lWBi/umukEd2DiV84QiyicwZiE4rpRC6UyhtK8o48ChCRsJK24MetB3EM
 b1qa5k66OYGQL+khIiyffe1F+RGupXpNDbl9w3cpqCdSlGRoA6+sODAKP
 cH842Syny7efLuFwms9a+6NM/ZzbAneaDsR10C1Prk3ZVClf8R/a/+YWc
 I4rIAdPtD22s75kISpTQ8wtQKtbWp0eNgPBQPnsUpwCRBToRtBhfEF0xS Q==;
X-CSE-ConnectionGUID: Bc5VRbEHQ8ynMEJ2PrmL4A==
X-CSE-MsgGUID: oQuPfIQ2Rman3xqxdKH4rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="964080"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="964080"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 08:42:44 -0700
X-CSE-ConnectionGUID: jA9g5ug9Rdy6xzlLJGG06Q==
X-CSE-MsgGUID: qAGx08/rSVqU7hg5VaYlTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2223176"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 08:42:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 08:42:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 08:42:43 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 08:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtMAWwE9rEfHt0balCV84Oc1udaanxg3Nva1Co6YnwmPpH6/Nl4TVaVRpr8TZmknBY2FKv+jZmj0DjcPR1qBicROteretcEtBWJ4h9uubkj9i3sML8+Ol4mRJUhYqWsi4b3ApzsC9AwteljbHwzb3rg+FPWx2YOAlwo94wzFvKKSFOzcMikqNfwPbNQcSOOw7M9UCQ1svwXnOviJ7q9RCp3XfZ/u1QL4ohyplgUWW0tE7gdZUycGXF/1+8HuehopEfFniyQhhJPaR9KC/UCJvi3xixWjIZ712N2Oh9VFna6hSKXEjMA0JszE6kfHyL4M6bCabn+3aqbxsuMDx27s9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR/lnHwkUoiisW85zRKmOJBm5UIaKUD2r8GIF93wH80=;
 b=RbDGPOMiToW06wDsTpxkhikWlJSYqqo09oPLr/HgtibBT6v89ZeqasLNsbXA4mWYjHjoOIxIIQHIjEr8JP6UlZcCSz1zpqp1LF5evUFW5722RY1szKMnQcsHpRHzFA97WfViK6OBJwNC9iBrw3hM+e/rVaPFe5kHfCmx/21Wg+0m2+KZnEhQNWAaWTua0Xs1g3J1DCuFuTaDJd5vjYBsN2RNzr3ec+gWWCUu92tVc+1h6ZfizmNHrZ0VIl/Q5SkshldnwpBjoBlW0SBob5hpZ/7y/t4x61IFsKIZPmkMCPkCQkW2K1uXSIcUQHr0zZbs7Tstn8C77qRwKcVypBPnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA2PR11MB5004.namprd11.prod.outlook.com (2603:10b6:806:112::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 15:42:28 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:42:27 +0000
Date: Fri, 16 Oct 2026 16:42:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 00/12] Add config-time dependency tracking
Message-ID: <atJF3QvCmQ23hIR7@bricha3-mobl1.ger.corp.intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
 <CAJFAV8zGPrMZMJU-8rF5GiGqQMBaN8H707h_Y_Hss3u8EHgZ9A@mail.gmail.com>
 <atI4Vo8qoomdEOHo@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8w9E1fmTQ5+xbkUdX2zxJGnj4AfiirLQLkHtE45g=73yw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8w9E1fmTQ5+xbkUdX2zxJGnj4AfiirLQLkHtE45g=73yw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0002.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::7) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA2PR11MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7eccf0-24fb-41b7-89fd-08df2b9c148f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|4143699003|261009223027099003|22082099003|10067099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: eGxEJ1gIcOEdtxexEVJ2wG9d3PAcOKU4zSKt5/NZb66P6aHXKLZwUlkvxS+7wTB1IS2pnOdxaIfQ9MsX7KTWyURvdSJV7Hjrh5f0+SYT6xIlq+vZoBhwIgn3wIZFPTZnfZhNLuaPJvCK6VqnEQ4C+6lPfokkb+zHKapGJbCIHW/olTx/pXbjU+ncCB5nMMIli/6hmW0LEkBaBdtWknrpXrZBt1z5Fd/tZpiJyigiDe4RvjdxU0+WZV+7OZ4lNuQKtsQAyM+WE3BbNHz1oWlzhNXJMaBHJyqtUDMO4szSuJSUCvSmqns4eDAFNk9Q8MMdvjKL2SYdrkOZ/Qu4rLOo+FSRvqwu2aNr+SdPPDM0OYln8K5TdbSmGUbEzsASpbHMbI5J6aT2i3reqVOGHEprnwVTkypmLS9ObKyA02dv83fFx/xcx8rNRMM7pkxUWKcrVlkufqtfYwO0ZaJ3bssPkmC47BKUBdxIEoEgbY88odcDddiLHR+HCWQjH5fSlWXpn9MQsrErwb4FhmlW0NnLsDrbVPE+0EOJ4D450vrdR88pGY1Y4Z+qGTYqTJlPjxHpJRocKrmuqiMHrC/Y+WPuz2CWuW5dH6wnEIHHQQbji7wZU0pG6ifZNT2dN0YVL35OzF/BQOgZevg9oWYbSstc6UtHBT6ujwbOFtVvE8FVfjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(22082099003)(10067099003)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?djbXEsgA6XLBaml/TEEK5nZFFsu6eHbRnirq7fmVaqnVqrw8o48DBxvUCvCm?=
 =?us-ascii?Q?T1bhFnTmCLr/JKmr/6U3HRgBMEw+6bHdovqpbUDHjuKmZTcT5QVZuZMiwg9t?=
 =?us-ascii?Q?IDFrCG8O415RDxvByi7HeLXDBtewwhMhC5N5fU4k21aXZ3HGknpShM1m4XS8?=
 =?us-ascii?Q?F9eiCHiAgzI+10h+rgJus0PmA3IbvnB0vUIEK13IuOaXNzlfoXzQI2uKZ+CQ?=
 =?us-ascii?Q?LdH7cLd55ky/0wObrhwLb8S8h5HO3qmnPlT55yv8v/Zdkrnk7P/A1CqatcFW?=
 =?us-ascii?Q?IfSAUjc0p34U2QVglu4h+2OktrHJZNK5NbJSHxNSbd+pEjnsnv6Q0SVVoIH2?=
 =?us-ascii?Q?+Ke8PlQdQEahCifbdGHDFX8E/8GWm/a22/m3ndrnVZaHv9B6dpL7uTsHJRLc?=
 =?us-ascii?Q?QEDhxSqk2jIT27Eer1IcnZhDTPd3d6su9AxsglNn6p2PGO4F2JiQvLP+LmGR?=
 =?us-ascii?Q?F3emXufDWSG2LVdTMN43oBfJ7Fk3WkONDtPn9hMZkQj0RTGAVKa9aa7Y709y?=
 =?us-ascii?Q?X5Rm625BgtF0WHu9GrXfE7lxjqm96xVE7KAcx7OFIcVzsmRu8E+yldfCB6qS?=
 =?us-ascii?Q?N7zy8oih/yE0DwyRYdBoW5ZTS4oOGBt2gz7lJRewwEOa5dYSn0M1EwE/Jfbe?=
 =?us-ascii?Q?+Of1o8jP1DtStCSqTJXD42Pq1D6JYp2hfop9XIS5QbAAGG+seVIAdjXe8WPf?=
 =?us-ascii?Q?P6HjOcr/FOki6FhyLe0f81KzP4uzUuY5s7ePm3WGcM1OCQNMSKapbh4bx3TA?=
 =?us-ascii?Q?uiKzKywtnV1is6H70Onlhp7BWHeHkcklWaqLb7770cw7jTg1K7AlKSrw75fS?=
 =?us-ascii?Q?1Za9Hbkodl627sUF+ZXAhY/jFCHmkMvKfGwn8G4pTfyjdQ8XqclAugV8C+rO?=
 =?us-ascii?Q?UbrDlrSNBMxQxYcq60dK96Q6BAHrwIuwQVNQU/txpJ0I6BH9fi1GiVp7Ndou?=
 =?us-ascii?Q?7OGASQQLl+3t55nhHLlcDCfDiaAmgJv2ndMXxZz1RuviEn0L76DkV2Rmp3Bm?=
 =?us-ascii?Q?oLHyTSRCXLpxewyEtxRDn3juRurwSckIj9niNDknnbY45sxpuh+rCJq4GDMa?=
 =?us-ascii?Q?voLTswxWaoc0F6U8EUTpXpfSJO3VuJ8XwsQ5reCzuEswjZNz3lWNVhNa/UWt?=
 =?us-ascii?Q?0sE/6trWap+bqvdp7IlvmtQCmSyisDSK1h29uqbvVS5XTHDR1BNT7Ta2qSud?=
 =?us-ascii?Q?9vk+4sBt6dzxY8+0hGd3RxXqcSWn1e9heyZCS7DbopT4113cYSm68z7IKDiT?=
 =?us-ascii?Q?ZNI477HlshdbiGEqJnWLQscR/LF/nx6dLKBoBqU/TcK6W7HQxBZ3xfSP6AVP?=
 =?us-ascii?Q?0lQZm5eXfIC98d1sbPf0waX223TamSX7tuOwhBakZJWNCHqBw/ZqnQCZmukF?=
 =?us-ascii?Q?8I/YwQv8+W++7BrtnPnPLij0T/l+GgFGfSVu8a4RuA5MfI5Q5E8U622y24+s?=
 =?us-ascii?Q?g1AJe/l9afPAJHIMEWmo9z7KRIlLhqvPsWhD/A29C5ZQeEN9XAY8l2oIRAWg?=
 =?us-ascii?Q?kDwMgh0VeSowOYmUDDEIUueAFDp7u4KHwPyk/0pRwTkKprCv55x9XKDyIlwM?=
 =?us-ascii?Q?rtEEjfiP6rj4/K+v/4DiFtQ0tFB0xPD19w/LpjCtPs/wLt71KDrqPAyJbw8d?=
 =?us-ascii?Q?oeZwPPh1dJXS1GLhGS16l5I2yCW4/kFMcbFt+p6e6OkzFkaQvSAPkDrYol01?=
 =?us-ascii?Q?1hl3j4+N6Ex4qneVcVZh0ufPHreGWnPhOGtYc1XDkcDRXMXaohs9q7CljOwf?=
 =?us-ascii?Q?37JG+Ru2nZoJUlt6B/4lojRA/TGBKDM=3D?=
X-Exchange-RoutingPolicyChecked: BbyiLfQ1tGVV+VAnvwMcvcsa2O7bHUx9Lure35d6yT73XgHZDB9A6TYumwAGmUv9UysjRA+/dw1g4iaQbBoJmbcAKBZldbRPan1sqzXmkDA9e5fNyNYup/Q4XUt0oEtdNkL8T8MBPXN34Eiif2TVQDsNvoT3xWWj9i00xblguS3oW5FEWw2vllGAZv9QhqhSEkrBdYGQt62h2Yp4sxMK/8sARYxUBJyD9av7PSKsXJ94l0c7twWn11McLkNacHwqOFbTi6TQIMRMY72rzZ43d2xW3S+3gr4MmxcTVsRTKqbqfkBwQh24atsBdAco3rlYw2YQNAbStM7lwDpEiLHnmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7eccf0-24fb-41b7-89fd-08df2b9c148f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:42:27.2416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1a2kJb2EsIWFZM4yG4lunwF9Np54ksAvy7QolRKBNdT01fxD7y4oAgm4aOr45yluIsCY5Oi6ar5rZ9aKnIk4aFZ+PXzayh293n5rqm4HRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5004
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

On Fri, Oct 16, 2026 at 04:51:48PM +0200, David Marchand wrote:
> On Fri, 16 Oct 2026 at 16:44, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Fri, Oct 16, 2026 at 04:35:51PM +0200, David Marchand wrote:
> > > On Fri, 16 Oct 2026 at 13:00, Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > Add configuration time dependency tracking for libs and drivers in DPDK,
> > > > so that when a user requests a driver, all dependent drivers also get
> > > > enabled. Similarly with libraries. What is not enabled in this RFC is
> > > > support for enabling libraries based on driver requests, or enabling
> > > > either libs or drivers based on the enable-apps config option. I've
> > > > omitted the former for now, because it would involve moving more logic
> > > > out of the lib/meson.build file and drivers/meson.build files into the
> > > > top-level one, something I'm a little hesitant to do for now. The
> > > > addition of apps only adds value once the cross-type dependency tracking
> > > > is enabled, since no app depends on any others.
> > > >
> > > > The first 5 patches in this series are cleanups and bug fixes. The
> > > > following patches then implement the dependency tracking. While I
> > > > investigated having meson parse each components meson.build file
> > > > initially, without actually building it, this failed to work due to
> > > > logic other than variable assignments in many drivers.
> > > >
> > > > Instead, python scripts are used to manage the dependency list. For
> > > > easier debug, and future introspection this dependency management is
> > > > split between two scripts - the first generates a dependency table file
> > > > which it writes to the build folder, allowing us to analyse this
> > > > post-build if so desired. The second script uses this file to actually
> > > > compute the necessary per-component dependencies.
> > > >
> > > > The final patch of the series is a major reduction in the number of
> > > > required components for doing DPDK builds. We completely remove the list
> > > > of required libraries, and assume that a minimal build should only
> > > > require enough libraries to build EAL. However, EAL does assume that we
> > > > have a few additional buses, for example, EAL args are present for pci
> > > > and vdev. Also, in order for mempools to work, we always need to have
> > > > the default mempool ring driver build. That means that our de-facto
> > > > minimal build target set is the set of components needed to build
> > > > "bus/pci,bus/vdev,mempool/ring" (which would include EAL in the output,
> > > > which is why we can remove any hard-coded library lists)
> > > >
> > > > Bruce Richardson (12):
> > > >   build: fix name of base library object
> > > >   build: fix ignoring requested driver when class is disabled
> > > >   build: prevent overlap of enable and disable lists
> > > >   build: add direct support for optional dependencies
> > > >   net/bond: rename directory for consistency
> > > >   build: add script to generate dependencies list
> > > >   build: use recursive addition for enabled libraries option
> > > >   build: use recursive addition for enabled drivers option
> > > >   build: improve error reporting for unbuildable components
> > > >   build: add EAL common directory to global include list
> > > >   build: make EAL an explicit dependency
> > > >   build: simplify mandatory library lists
> > > >
> > > >  MAINTAINERS                                   |   2 +-
> > > >  app/meson.build                               |  15 +-
> > > >  app/proc-info/meson.build                     |   4 +-
> > > >  app/test-bbdev/meson.build                    |  18 +-
> > > >  app/test-crypto-perf/meson.build              |   4 +-
> > > >  app/test-pmd/meson.build                      |  50 ++---
> > > >  app/test/meson.build                          |   6 -
> > > >  buildtools/get-deps.py                        | 203 ++++++++++++++++++
> > > >  buildtools/meson.build                        |   2 +
> > > >  buildtools/resolve-deps.py                    |  80 +++++++
> > > >  devtools/test-meson-builds.sh                 |   3 +-
> > > >  doc/api/doxy-api.conf.in                      |   2 +-
> > > >  .../link_bonding_poll_mode_drv_lib.rst        |   2 +-
> > > >  doc/guides/testpmd_app_ug/testpmd_funcs.rst   |   2 +-
> > > >  drivers/common/mlx5/linux/meson.build         |   1 -
> > > >  drivers/meson.build                           |  85 ++++++--
> > > >  .../net/{bonding => bond}/bonding_testpmd.c   |   0
> > > >  .../eth_bond_8023ad_private.h                 |   0
> > > >  .../net/{bonding => bond}/eth_bond_private.h  |   0
> > > >  drivers/net/{bonding => bond}/meson.build     |   1 -
> > > >  drivers/net/{bonding => bond}/rte_eth_bond.h  |   0
> > > >  .../{bonding => bond}/rte_eth_bond_8023ad.c   |   0
> > > >  .../{bonding => bond}/rte_eth_bond_8023ad.h   |   0
> > > >  .../net/{bonding => bond}/rte_eth_bond_alb.c  |   0
> > > >  .../net/{bonding => bond}/rte_eth_bond_alb.h  |   0
> > > >  .../net/{bonding => bond}/rte_eth_bond_api.c  |   0
> > > >  .../net/{bonding => bond}/rte_eth_bond_args.c |   0
> > > >  .../net/{bonding => bond}/rte_eth_bond_flow.c |   0
> > > >  .../net/{bonding => bond}/rte_eth_bond_pmd.c  |   0
> > > >  drivers/net/intel/ice/meson.build             |   7 +-
> > > >  drivers/net/meson.build                       |   2 +-
> > > >  lib/acl/meson.build                           |   1 +
> > > >  lib/cfgfile/meson.build                       |   1 +
> > > >  lib/cryptodev/meson.build                     |   2 +-
> > > >  lib/dmadev/meson.build                        |   2 +-
> > > >  lib/eal/meson.build                           |   6 +-
> > > >  lib/ethdev/meson.build                        |   2 +-
> > > >  lib/eventdev/meson.build                      |   1 -
> > > >  lib/ipsec/meson.build                         |   2 +-
> > > >  lib/jobstats/meson.build                      |   1 +
> > > >  lib/log/meson.build                           |   1 -
> > > >  lib/mempool/meson.build                       |   2 +-
> > > >  lib/meson.build                               |  76 +++----
> > > >  lib/meter/meson.build                         |   1 +
> > > >  lib/metrics/meson.build                       |   2 +-
> > > >  lib/pci/meson.build                           |   1 +
> > > >  lib/ptr_compress/meson.build                  |   1 +
> > > >  lib/rawdev/meson.build                        |   2 +-
> > > >  lib/ring/meson.build                          |   2 +-
> > > >  lib/stack/meson.build                         |   1 +
> > > >  lib/timer/meson.build                         |   1 +
> > > >  meson.build                                   |  21 ++
> > > >  52 files changed, 478 insertions(+), 140 deletions(-)
> > > >  create mode 100644 buildtools/get-deps.py
> > > >  create mode 100644 buildtools/resolve-deps.py
> > > >  rename drivers/net/{bonding => bond}/bonding_testpmd.c (100%)
> > > >  rename drivers/net/{bonding => bond}/eth_bond_8023ad_private.h (100%)
> > > >  rename drivers/net/{bonding => bond}/eth_bond_private.h (100%)
> > > >  rename drivers/net/{bonding => bond}/meson.build (95%)
> > > >  rename drivers/net/{bonding => bond}/rte_eth_bond.h (100%)
> > > >  rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.c (100%)
> > > >  rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.h (100%)
> > > >  rename drivers/net/{bonding => bond}/rte_eth_bond_alb.c (100%)
> > > >  rename drivers/net/{bonding => bond}/rte_eth_bond_alb.h (100%)
> > > >  rename drivers/net/{bonding => bond}/rte_eth_bond_api.c (100%)
> > > >  rename drivers/net/{bonding => bond}/rte_eth_bond_args.c (100%)
> > > >  rename drivers/net/{bonding => bond}/rte_eth_bond_flow.c (100%)
> > > >  rename drivers/net/{bonding => bond}/rte_eth_bond_pmd.c (100%)
> > >
> > > Interesting series.
> > >
> > > I did not review in depth, but it seems promising.
> > > The first 4 (and maybe the 5th one) patches can go to 26.11 right now.
> > >
> > > I noticed a little formatting issue in patch 9 commitlog.
> > >
> > > One thing bothers me.. but I did not play enough with the options maybe...
> > >
> > > Could we use new build options (request_libs/apps/drivers or better named) ?
> > > This series changes the enable_libs/apps/drivers semantics and will
> > > likely result in confused users.
> > > (and we would need no support for mixing old and new options)
> > >
> > Can you clarify how it changes the semantic from a user viewpoint? Unless
> > I'm missing something, the only change is automatically fixing a broken
> > build for a user who didn't know the dependencies of the driver they want
> > enabled.
> 
> Well, the fact that everything becomes optional is a change in
> behavior, and enable_drivers=net/null not enabling ethdev is a problem
> to me.
> Or I misunderstood the last patch comments.
> 

Ok, I take the point, but that's actually a separate difference from the
majority of the changes. We can actually take the last patch and still keep
ethdev and other libraries as mandatory for compatibility. I just dropped
them since in the past we removed other libs from always_enable without
notice or compat concerns.

/Bruce
