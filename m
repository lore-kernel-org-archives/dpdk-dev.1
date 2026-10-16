Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D6CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7165B402E9;
	Fri, 16 Oct 2026 16:44:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id EAD5540291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792161888; x=1823697888;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ihc3lPAzAh9QYyXsoFI8obtxkNMKjIpBvOvcr97V8gg=;
 b=ji70/skcDPh0Utl9BkH83VIJMtfsXSDa2YwI/kida3vaWp/fIsQtwiNX
 33I1KsVulVo01/kIsoDrxyZJunyIlj54lVwrD3DdkrnWCe3g6S8XgWJlP
 afjFHalrmxOPAjHS500RkZmO6YwYxfC3WxYCLanty5rqQod3WgTZCj2RA
 86EYz7KJbqRZXWo5q3fAD4KdpIusNVn0BmG/zN9sQleAIRMUAcll1j3of
 bx0jS8j1WvtGffytC45Qu/O8ymHYGf7eYk02Yi1SeO54qYeyIjIzR7dPK
 MDtq9VZ039FwwslWQbOauo4PNewK9OUDB6MOI7hGmwiSrVSvwgMynkH5n Q==;
X-CSE-ConnectionGUID: dJSwwy+8TA6Lb82xCUl6Ww==
X-CSE-MsgGUID: hvjHDwhLTyKfe/NblBh9+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="837290"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="837290"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:44:47 -0700
X-CSE-ConnectionGUID: /6fdUtKHQSyKi27qFYmrLA==
X-CSE-MsgGUID: 8Zbyle1rTs6kkbuDPYIXoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2063070"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:44:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 07:44:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 07:44:46 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 07:44:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdgL0Ub9xyongu3GFcgr7+OnVZkB+cZ5ZiFmnrber9lsnJGoEiOxqHQamzdQPfNz5ptFk2LF/BUEgCXxtqGAvm1wLd1z4umowtyG86i2DN+J+w5oZlVhDdYipSAW5FIWYWkNovwW2/VP4UAA30+K5iFlqpgjQrSHkAoqUImOeIObo4ZrJf7qIedJt/blaZhmpQgcKD5rd26opXclRVH+NTsL7Cs961rqs59PuqyIPSppBq/cUe/L2BCuUs59ncFkSVYZ941uiVJ0CfcvuuTSf0Q/X2r5YQ4PxEh//kYXEbASEFSzDPUWfjXVRQmjxAJB36d+VuJnfhF9rfnpBOHfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFViVEIKCYiWjQcA57R9zp4xOcNKLDPDbl98IFxfyNU=;
 b=tUpose1SmCGgYRoswVFr8qvfRk9tcAwJr0Su8fgsBc3P4z4mUlMfUHP1yRrRh3pSQRepj4y/P3x7njuFwRztevQu0fpGFcm+cXYWd0/BJrF+21pLU21t1CszNYToQKbCnjDNxr0vlvpNSasmRUdZJgCABsfGcgkmZqfPp4Lnoliqk9X7vCBvGXBkKTLWZwNzSrWjr6P2Q4IgVuyQW62uVkZft/XnweE0JAV9CZ91NDUM0Qnv192TwmtM7vL++x4xXVpUTOMNDRSGtEjOAiZHgWScp/IoN81/TNetEFgpBBEikPsgMF0DzfPgwcrKIFKReckNWKKOOp1I3qtsVGjo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BL4PR11MB8823.namprd11.prod.outlook.com (2603:10b6:208:5a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:44:44 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 14:44:44 +0000
Date: Fri, 16 Oct 2026 15:44:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 00/12] Add config-time dependency tracking
Message-ID: <atI4Vo8qoomdEOHo@bricha3-mobl1.ger.corp.intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
 <CAJFAV8zGPrMZMJU-8rF5GiGqQMBaN8H707h_Y_Hss3u8EHgZ9A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zGPrMZMJU-8rF5GiGqQMBaN8H707h_Y_Hss3u8EHgZ9A@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0311.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BL4PR11MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ec4333-f01c-40ed-5299-08df2b94041b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: jLQIjwM2eYkzD5s9WRM6ClLeX1UHTGtvoVz3KCApkIhxaCDc6cBij9vqNFbM0AgpZ6qRCIr8kdTCgjZ+HqW8i167uHRPCTqOymLztJ8hoQlgcWyRIcFBrZQWaqTt7m5WDC67bzvZdtyf1Uz7aVLy8/YqMrAyU6Ip6PLDQctIdZEi/YaXswi41ykpBPSpJuyrsl3MzMhVS8APs2sRyCuRVPgC53dQEM7yDJfMpEtJGFHGeyIp9BOV8EiF4RqCnsdnWyFuIBJH/3um8DKZIR6YAGu7O+vShjncsvNwIcpp8x8cPEXsFRPFKHZpCra8AAeQ9s3f6/3jDxwB1/PYVl8sYvGWtz36Z4x0BpR2PrLGf0H22Kpq7O9EvdkL+4cJObwAvVqSCiOInWUhMwcKPkYcKKrXne9TyKNca1cGaa5i1xULzlGxwtoX6miJP95tPuQwgtdtzDVq81WNFSxiRgfrWWds4LV3aVcheKcw8MLfRRkz1BrEfM1S5sQd0wxXTQ13KN5UxfLPHkv96JSlpJvs4Vihh+yeiGUb7AsT3hpwlvpyHTLEJ1169WcoBqLbEi0TTZ5PZMQrjG7nUmqqjh/PxYIhLdJ8uRtCjK9XTscXuOg26cvOEzEBVrsjZX16NN/QlYXm/oahdKYL8NB28eUjuWYNcBiQj05V1zd9zBr8/SM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQNCgw5B9oFAWnj1UKx1GYZ7I6PK6e8oA7b+SM3MrPyN7eJFTrGoOAw/BYDv?=
 =?us-ascii?Q?TM2PDS2yI7mPG6Wfrkph+5gmYUNFom/TwciFgc/qKSWbpOBZUE/SQFpCbT6z?=
 =?us-ascii?Q?aetAxkszIVNlEIJvIiUVqsymVAIslO0GQXMOj1uqAuYnzcSdPjkqNiM4dVWK?=
 =?us-ascii?Q?Y9reYhFTT2gShSKDbwRFYQVhEsyYiTrXjfp2cuT88DYWwTFO5UzwSxjL4uQQ?=
 =?us-ascii?Q?mr5ayGkJMhmJQegXosuNDfYdfWV1nD310m3C4o05Tc8tVVSRlaUPgQalwhr5?=
 =?us-ascii?Q?rffSMRRNfnw0/LYY9U7V2v2bdeTTHeuD38zBEu9oqAG3OArLWHqTc/hnyOge?=
 =?us-ascii?Q?+mxC6VUKWg6Ejl/MYPUW7NV7usUhi2aXjG6xFBu+Ny8PbJ5T2tCgjJcTKEcy?=
 =?us-ascii?Q?3s2nNfYxtNFeAI60hVw91upiPkYWsARYVtc+iTvRCyFo4RwRJokCSY5ApjDG?=
 =?us-ascii?Q?261r8DbPAvSX4xaRldf/2KhvtI9s9AjwS3iqEwqBy0cZSSxSFfFo5LnfxU+d?=
 =?us-ascii?Q?1pTZeQLrNUhL5lXHQwsHY5EXrGii9vdLMd3yRzUPYBC/GUuHZBc/Pf83F1vb?=
 =?us-ascii?Q?ruOXWb7cD0iEQgqv96hv+9eCMvWACOSxs4kPIQ4N8aVVTpId+fp1fJpcdf8n?=
 =?us-ascii?Q?7cqI8JaPCZUDXL5qt59vtpM6WrQmUMyEZWtVbkAEty7LdJ+EkvcaG8VfpLu3?=
 =?us-ascii?Q?IGNsojnQhmXe9ZnhSUooa8slZlqvm/CnrFD5wJsRn6AFBvmz3smOS1AI7c92?=
 =?us-ascii?Q?b7eTeSd9u4yJGyeMMcIXw5Yk69HAy4c18tZ7ixoM1l0RrFy6TyFVQWPnt/7k?=
 =?us-ascii?Q?6nmwFC3QdrRC4QMjHRn80ZA3a0IJMPW/KQGaYJPZx3wFw7WRZxbgLRCCVmvL?=
 =?us-ascii?Q?r8fMtiEpgGF5F4xbDWRCwcBB+pzzjOpziwjHhPKO8VwvI0UxJsY99af0VIpF?=
 =?us-ascii?Q?+V2auEm1wvvlu7BfuE+xWAnqDy+qcpoYOOotxht+nApAbyI1xXGchfg7+eCa?=
 =?us-ascii?Q?1LDl5MdzankHBv8U5Hlf3hYHpbZt8H2hw911ByhJQKok1pAzbLZxWeQzm5Hk?=
 =?us-ascii?Q?BAfGrnqae0pEAOz/yWh68SKszBanyLyixPUZZ4q44oUt8IvttaRs4vrlVl3P?=
 =?us-ascii?Q?iOlqU0u1NVXgTP9L+avDVNJhIN9w9OKy1TEsHKHSznYE4rCoe7pXfrousqi0?=
 =?us-ascii?Q?FdI2Uj2cjw0lBQoHVQng/dagVll/FjGCeiWHqji7Or2+P4hHxecw/rO5diHz?=
 =?us-ascii?Q?AJSig7Hvf07pSeEHYz2Khl/gPqKZBeqAH12uGDcnn5T0W0BUsaaI4gCOwAN8?=
 =?us-ascii?Q?Hsu1Hc5iDf1MvaNDfCAxyVzBuY9Gh6Nb31lY3GS2QmVk8NQLO4BfNHVow5lk?=
 =?us-ascii?Q?dhpUuiEG6nbfhdl89YKTN5w51y0+xyQ+/uwzmDe2hun1n5Qrp+dJPxup8J+D?=
 =?us-ascii?Q?hpvsqegSAIKNSq7KWmzSCzJ6oY0Mm5nBbe27r3yIwjW2QSxtGJ5bTT9PIRyt?=
 =?us-ascii?Q?nMW4xdFbQpjfwHn73Eya8rum06f1Nq18NkWHGrr0SQfVw4rguWMDwNeUUwCk?=
 =?us-ascii?Q?U1W/Gl0xuZZLiKPXfz9SfMab4w5hvMS18Blsanfms1ERJ8sdSOSiqDnxYCOd?=
 =?us-ascii?Q?HYeE68KscQ9ghPnt+zkYs47SIV9Sk7lla2gCgmLGVpm5RnvmDChQfrSOc/gJ?=
 =?us-ascii?Q?nP5UFZCljIrRbbYYEaALMacnPVp2/qpvKFPAoAtiTKm1QVi68fZszb5BuKoY?=
 =?us-ascii?Q?i4gM294+mOMLy8UJrLJzTv6WglBVDRQ=3D?=
X-Exchange-RoutingPolicyChecked: PAxCXBA6mh3/3vl9YDj7SqAEn1j0TxBWbTUOJ6Aet3hLBk1Egak+eoP4ygYyXPEh/rpf0V7TNxFRuhtliPabCffy45/yIcmN6l5nycOlP863KPAPqyrOGVETB5xCQip0HLDIdYwwY/w+TyoCwFUs9XdYNsJoTwJ+oyUsqnqBJGIh1dFioGWDO+XlRi3r+f7QZArdgL3vtoWC1bWwoOBMCpRSkrhNm8WQCOsMkWks/KilXGyseF52amTAQM3OAX/usfzfq8BkPgVdjT4usCIqp2ICmuhBtm0v2dQ3125+gT5KHNG4p9Qe+d5BFr/P3gZTSvOZI4I3KEvLx1K4x88EzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ec4333-f01c-40ed-5299-08df2b94041b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:44:43.5700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaPyqxG9mlkvIClyYZfP10GjawaUbFEOKm72MFiVgpNLvtrKW4+M/6TTaZY4VnNU5cWoFq2BegWEbYOXGY4SC3JBkATu6CoaoLrNwVqdjtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8823
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

On Fri, Oct 16, 2026 at 04:35:51PM +0200, David Marchand wrote:
> On Fri, 16 Oct 2026 at 13:00, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Add configuration time dependency tracking for libs and drivers in DPDK,
> > so that when a user requests a driver, all dependent drivers also get
> > enabled. Similarly with libraries. What is not enabled in this RFC is
> > support for enabling libraries based on driver requests, or enabling
> > either libs or drivers based on the enable-apps config option. I've
> > omitted the former for now, because it would involve moving more logic
> > out of the lib/meson.build file and drivers/meson.build files into the
> > top-level one, something I'm a little hesitant to do for now. The
> > addition of apps only adds value once the cross-type dependency tracking
> > is enabled, since no app depends on any others.
> >
> > The first 5 patches in this series are cleanups and bug fixes. The
> > following patches then implement the dependency tracking. While I
> > investigated having meson parse each components meson.build file
> > initially, without actually building it, this failed to work due to
> > logic other than variable assignments in many drivers.
> >
> > Instead, python scripts are used to manage the dependency list. For
> > easier debug, and future introspection this dependency management is
> > split between two scripts - the first generates a dependency table file
> > which it writes to the build folder, allowing us to analyse this
> > post-build if so desired. The second script uses this file to actually
> > compute the necessary per-component dependencies.
> >
> > The final patch of the series is a major reduction in the number of
> > required components for doing DPDK builds. We completely remove the list
> > of required libraries, and assume that a minimal build should only
> > require enough libraries to build EAL. However, EAL does assume that we
> > have a few additional buses, for example, EAL args are present for pci
> > and vdev. Also, in order for mempools to work, we always need to have
> > the default mempool ring driver build. That means that our de-facto
> > minimal build target set is the set of components needed to build
> > "bus/pci,bus/vdev,mempool/ring" (which would include EAL in the output,
> > which is why we can remove any hard-coded library lists)
> >
> > Bruce Richardson (12):
> >   build: fix name of base library object
> >   build: fix ignoring requested driver when class is disabled
> >   build: prevent overlap of enable and disable lists
> >   build: add direct support for optional dependencies
> >   net/bond: rename directory for consistency
> >   build: add script to generate dependencies list
> >   build: use recursive addition for enabled libraries option
> >   build: use recursive addition for enabled drivers option
> >   build: improve error reporting for unbuildable components
> >   build: add EAL common directory to global include list
> >   build: make EAL an explicit dependency
> >   build: simplify mandatory library lists
> >
> >  MAINTAINERS                                   |   2 +-
> >  app/meson.build                               |  15 +-
> >  app/proc-info/meson.build                     |   4 +-
> >  app/test-bbdev/meson.build                    |  18 +-
> >  app/test-crypto-perf/meson.build              |   4 +-
> >  app/test-pmd/meson.build                      |  50 ++---
> >  app/test/meson.build                          |   6 -
> >  buildtools/get-deps.py                        | 203 ++++++++++++++++++
> >  buildtools/meson.build                        |   2 +
> >  buildtools/resolve-deps.py                    |  80 +++++++
> >  devtools/test-meson-builds.sh                 |   3 +-
> >  doc/api/doxy-api.conf.in                      |   2 +-
> >  .../link_bonding_poll_mode_drv_lib.rst        |   2 +-
> >  doc/guides/testpmd_app_ug/testpmd_funcs.rst   |   2 +-
> >  drivers/common/mlx5/linux/meson.build         |   1 -
> >  drivers/meson.build                           |  85 ++++++--
> >  .../net/{bonding => bond}/bonding_testpmd.c   |   0
> >  .../eth_bond_8023ad_private.h                 |   0
> >  .../net/{bonding => bond}/eth_bond_private.h  |   0
> >  drivers/net/{bonding => bond}/meson.build     |   1 -
> >  drivers/net/{bonding => bond}/rte_eth_bond.h  |   0
> >  .../{bonding => bond}/rte_eth_bond_8023ad.c   |   0
> >  .../{bonding => bond}/rte_eth_bond_8023ad.h   |   0
> >  .../net/{bonding => bond}/rte_eth_bond_alb.c  |   0
> >  .../net/{bonding => bond}/rte_eth_bond_alb.h  |   0
> >  .../net/{bonding => bond}/rte_eth_bond_api.c  |   0
> >  .../net/{bonding => bond}/rte_eth_bond_args.c |   0
> >  .../net/{bonding => bond}/rte_eth_bond_flow.c |   0
> >  .../net/{bonding => bond}/rte_eth_bond_pmd.c  |   0
> >  drivers/net/intel/ice/meson.build             |   7 +-
> >  drivers/net/meson.build                       |   2 +-
> >  lib/acl/meson.build                           |   1 +
> >  lib/cfgfile/meson.build                       |   1 +
> >  lib/cryptodev/meson.build                     |   2 +-
> >  lib/dmadev/meson.build                        |   2 +-
> >  lib/eal/meson.build                           |   6 +-
> >  lib/ethdev/meson.build                        |   2 +-
> >  lib/eventdev/meson.build                      |   1 -
> >  lib/ipsec/meson.build                         |   2 +-
> >  lib/jobstats/meson.build                      |   1 +
> >  lib/log/meson.build                           |   1 -
> >  lib/mempool/meson.build                       |   2 +-
> >  lib/meson.build                               |  76 +++----
> >  lib/meter/meson.build                         |   1 +
> >  lib/metrics/meson.build                       |   2 +-
> >  lib/pci/meson.build                           |   1 +
> >  lib/ptr_compress/meson.build                  |   1 +
> >  lib/rawdev/meson.build                        |   2 +-
> >  lib/ring/meson.build                          |   2 +-
> >  lib/stack/meson.build                         |   1 +
> >  lib/timer/meson.build                         |   1 +
> >  meson.build                                   |  21 ++
> >  52 files changed, 478 insertions(+), 140 deletions(-)
> >  create mode 100644 buildtools/get-deps.py
> >  create mode 100644 buildtools/resolve-deps.py
> >  rename drivers/net/{bonding => bond}/bonding_testpmd.c (100%)
> >  rename drivers/net/{bonding => bond}/eth_bond_8023ad_private.h (100%)
> >  rename drivers/net/{bonding => bond}/eth_bond_private.h (100%)
> >  rename drivers/net/{bonding => bond}/meson.build (95%)
> >  rename drivers/net/{bonding => bond}/rte_eth_bond.h (100%)
> >  rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.c (100%)
> >  rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.h (100%)
> >  rename drivers/net/{bonding => bond}/rte_eth_bond_alb.c (100%)
> >  rename drivers/net/{bonding => bond}/rte_eth_bond_alb.h (100%)
> >  rename drivers/net/{bonding => bond}/rte_eth_bond_api.c (100%)
> >  rename drivers/net/{bonding => bond}/rte_eth_bond_args.c (100%)
> >  rename drivers/net/{bonding => bond}/rte_eth_bond_flow.c (100%)
> >  rename drivers/net/{bonding => bond}/rte_eth_bond_pmd.c (100%)
> 
> Interesting series.
> 
> I did not review in depth, but it seems promising.
> The first 4 (and maybe the 5th one) patches can go to 26.11 right now.
> 
> I noticed a little formatting issue in patch 9 commitlog.
> 
> One thing bothers me.. but I did not play enough with the options maybe...
> 
> Could we use new build options (request_libs/apps/drivers or better named) ?
> This series changes the enable_libs/apps/drivers semantics and will
> likely result in confused users.
> (and we would need no support for mixing old and new options)
> 
Can you clarify how it changes the semantic from a user viewpoint? Unless
I'm missing something, the only change is automatically fixing a broken
build for a user who didn't know the dependencies of the driver they want
enabled.

/Bruce
