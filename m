Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE572CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 12:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EB79402A9;
	Tue,  2 Jun 2026 14:28:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id E2FE140150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 14:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780403290; x=1811939290;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=UKsT22fh0QGthBB8TSpUx0nZsWCnodAhl6GLZxUNY54=;
 b=JAv+OrIAkZmYErvK82PjJx19Vkhml21fzJfOTdLUbXOWxzmQaq7OI78w
 XqNJFb2tXcfegYDInPNxu9UuiZd9z+M3+P51EUTlU7n5WjCwqK21NUNhd
 BIEkI+24zSlh9wzzvW2gCNoWap/MG839woBaSdN174PC3+YTbJ/0EFp0w
 cWH9zzgN85+R/WG0ZkcG7N2jNHWFS1tcxHz4Z6Nh2QZhthPFtnCdFylpb
 eXF5+j8Jf53c6FZIR1OkXvLDhBPITVjOfgNwf4KAjNPCWWHRApmC5QCRN
 eeE6vjsOp3cDHL8TOVEnskmdpgZyQIsWyLG22bp8MR5gdggUz2gSf9cN/ g==;
X-CSE-ConnectionGUID: G/LtJVbYT/q3CBOOtLLInQ==
X-CSE-MsgGUID: JwzTUT4qSZu7XQvznPgelQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="68729703"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="68729703"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 05:28:09 -0700
X-CSE-ConnectionGUID: 7tABZ67zRXaahi3FRlOEXg==
X-CSE-MsgGUID: gAQPBLRSQMGlIOWfUCU8iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="242870560"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 05:28:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 05:28:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 05:28:08 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 05:28:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXs0rT8xD7VgyhFp6vpGnvH+lpim5MAQF/QOsUie56EdAWdIlSSh92lERYJPTknxmotUy5RcmczPorwX+TjDs+NDDGa7jYjn3cbATM5V4QUimxiA5sd44r7cZw83GJ8zkYNz+tS/x3zgwbsP+MQ2x17Wkr6OORObIFMhabrVlifFnhI2pt1XFYGcGI8Iym0s40jcuOUgtovdSSMORVoL+Q4cS2Cjx/zUdsOrUpFHnuSsXoZ4si/OmQySpNG8jbvyHmn6ghhQ+eQOp99B6jNZ+N3BzZhapdrdoSdE5YfbDzjGW/Wr72nzVJzxS4hOtg+0kAE+Hw7DZgsYt620V6/wCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+McOatdvlYQ7KFCgPCuqkAG8blPLA4TRBuCv9H9gA34=;
 b=ivxpUiZ14SBXPdoHtkfvhagaRJh58RLFzJhcZDLUF9ATdifaeZl4CRiT5a63jD34Sh8kATABLXl5Mn++eNcHpicG/FFwkFajegopr71CgZVwnSdXM8hqkLj5HWK2EbVws2aUhZ7ansYIO4R5j1MMj7vDRBk6d3O0N0b8d3xZFoCdGB7HaMW3aV85JGHiDEaSQVVx9rBB4KzNd9sG24HHYV4dHeGk72GH3beTw+KLFQw+3nESvxmbSpBO6IlZbrS3ODIBEAFYwe3M0cpI153IWhJqbQSlqe/JLghjKQZa3/eGqNLkrguoY1q6yv4wEf27obJisw+dIAOZvSVyLVNctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB5281.namprd11.prod.outlook.com (2603:10b6:610:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 12:28:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 12:27:58 +0000
Date: Tue, 2 Jun 2026 13:27:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 3/3] build: deprecate HPET build option
Message-ID: <ah7MSjPxMZYGDSOf@bricha3-mobl1.ger.corp.intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20260602090847.905721-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658D8@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658D8@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a1931c-3c16-4a0f-da6f-08dec0a26151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: +CveInezj+5UoQgkUYeF5n/bVD74qgug/rKvEZtBA/ZhLimDJ6eBNqvs3w20xrmWUPkrX9pIbmX+RUKFpzF3lOKJitoJW4B/J2KQm6PmaZGYblmfnxvjuzHaNjtUcJD0sLilvtvDLjtJGKpkp9lVtJt+yhuKkrsko2iuMF0NalygeV4Uto2l7eh/i9bdAff/pfWtVlyf7iiNaMtNwbCwZ2SSPOBnMvRpuGwDj6G/E1keXdZwmo9g4JmRjzd8XuH68TmljEhDsAOzkh0BQa35bW4NLkY8ZGkteEHZ6IQgiBndaMT+FYPYnux2nrJhr4ZRkSCsFew5DB29JBbvegigAkz0VjpmZH5WwcCJNJArm08k5QEk11KjwyKflEl0kU5qz3g1IcGlPiw5v51xbXt4/Pytac8xLej1YqRLB6ZBSEWKCvub/cDQcFk1yN/JkykSa8SI+/NUCYWH59sVpnb5Gs9mBxDNONJrOp9QT9cO/HZ724HhHE0+gCrQ/38UJeKdGLsWtC063/gIBvqw7KyRyS4bhalGkSmj0eM3jCJs7H1g3arjMS5qMMJF8OIloAivvqMGKhc09J6XWlnAKUkbPAxad8GFR7E8lS6Vhp94bGp0lgJJTmfV+nPo4EFoQIb/K8W/518qc10+KHGJxNxecYQqQkkOqGIV5l0QDWHX7aGsjg3dZCqugW2VPP9TF36r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AB4UJbv0GrC6AA3IZc/fHQAdPZwweNUEhiesDvha47Zhcpeo6BkQv3nMng?=
 =?iso-8859-1?Q?5viKmFXyLIwSmtBD+3VA6hjwniMOLc9TlPn5H0hFLpp5V14dHLjISOjFhv?=
 =?iso-8859-1?Q?Q26vmf3oOnb+c9WyNRM03JVjCXYlqqdczx70fikmAssX/tzEtKmnrgc/NR?=
 =?iso-8859-1?Q?GG3r2f29xxYZwr0HFGkXIYK0RE9svC5N/I4xecrdx2KsZvfNqhjiVhTs5u?=
 =?iso-8859-1?Q?Z0aQwC9gm32RmPcw0e4K4kCMSYUj+l7BODaJQF1x4+FVeUKxiO8BiQV1Mt?=
 =?iso-8859-1?Q?ZWaYVDF79g8UPRL39GOlnoC0r64dco0UpuNCFZcLveQCsxzWmtlIvxE9Je?=
 =?iso-8859-1?Q?urQZWcUJL2Q93BNUN4hp7E4DzcFk9rDBjMvkAQ9K+fJyHEyt0IH+nkeuNt?=
 =?iso-8859-1?Q?6eYKc0JyERCnHqVXTBuivuA1yU+EgM7tRvtgnoiQFLwOgY8hh/eoriJWT6?=
 =?iso-8859-1?Q?X5LkM0LkmC0qwkyFZwdXdpIHQA/It/hWMR66cxVSq5z08b5MfbvfGuWuof?=
 =?iso-8859-1?Q?Mhsm9HXp6q4I3cY7JXTlsrgll9PXr/Spy9NBMXrMF7vPqJyX754SLnnLxZ?=
 =?iso-8859-1?Q?Ap7sTnbrot1WO2q1JJ7DYP4b2er0XRGxTWUbO+9LTDjodVVOv1jnzYH+Q+?=
 =?iso-8859-1?Q?/oFh5O9yXwf7+9fk9e2n9Q74w+30QIvFUXqgoserpc7EO8msKbkbkVIr1p?=
 =?iso-8859-1?Q?QJ7XEOt5iKsZFHooF/SOPD8rXVOgsBcOjnexP9OxUzHqCnLUMJNUUkq9QL?=
 =?iso-8859-1?Q?kA7T2rQW7ey6SIpJ9oEip79P93TlypZu/+fTeUItAPGL/iy9DVIu/UF8zF?=
 =?iso-8859-1?Q?+1Cp5+eXzY6bmVdHktJZBdvYT8udT6TtsohsPPEgRdo0GgHNEX9S52yXDo?=
 =?iso-8859-1?Q?TQ2lKaIwVdkIBO/wbRZwHCEk9wKcxE6d9yq5pswQy2jQyjU2yptLmYkGul?=
 =?iso-8859-1?Q?GwcnafWmBIgsW7/uoDss85pwumJvpxYUbbFXMXcaWfMj0BvS2Htrtw+4Fi?=
 =?iso-8859-1?Q?kU04+3pAsxPo2GeRRNLf+kTOLWXxEQY6Yx8f/D1Z4Hq5UW9GeWt2U9FTIf?=
 =?iso-8859-1?Q?1/4FGSpiTA1Ti1D8AdE281xOx1QHwW+1h9dtXZJ73kIbFpdA1SJcbBQupY?=
 =?iso-8859-1?Q?m7YUZmzOzqXMf+a8u8wrcvcxjKn43UHDowNdZFHTH7M6eD9jO9RGPqRTeJ?=
 =?iso-8859-1?Q?zYAwM7WuPoVePVlfhSczcxVZDGawuc93uk+7Aomq+SXhBh5EZmgIey79Gk?=
 =?iso-8859-1?Q?GOKfMJYIUGlh7fHVmXTLhhK1FIedaTSl4abipLojLm9HrvkIZIyG3CvPdH?=
 =?iso-8859-1?Q?wKgwZCu+GIMjq40Y+gyqOl51iQzVt+DGrU8IzKV7EbylOJ9sKOdc2t8/IM?=
 =?iso-8859-1?Q?aPI7n4NjxFIC7F234p3MeB7YW/w2TyHKXEUIx7fGyf1+nTwiswfvfnULbM?=
 =?iso-8859-1?Q?Vq3qFEA3Xia59ybkEKfskvCs7GzVfBLM1g+UeP+f51UB8Zq9xz2TFM87Ah?=
 =?iso-8859-1?Q?Hz1iveCk6FF08oJH+36+I89a7ux5iUnjCHWH/2G4PZ2U1bRkKIV4saKYfN?=
 =?iso-8859-1?Q?gqrzeAhtQ+cuLnHXKWncRMPu9WSV3AE+za55ey8YD0SB2AWiT97FFEDRc2?=
 =?iso-8859-1?Q?thi/tpRv9LXKaHoX2fmJ0w+9m58ZyJPHbaXbfLPE6P07QBo+NRTStQWzMm?=
 =?iso-8859-1?Q?nyaj/TEudJO934X1SWC6tHBz7mIAfz2okus8X01f0FfFrIWm4tJYxkfBsB?=
 =?iso-8859-1?Q?7/mXSwkLpDTOTBhodo4/GlCMZHeCEt4gVfnXN21KFpnCxyzWuo29s04lcN?=
 =?iso-8859-1?Q?HKmruJ60ozDQAt5lwJAJUEo4HT64xRw=3D?=
X-Exchange-RoutingPolicyChecked: GOTp4tKQT+d/xMKsIwGvhjttBhLQRsXAUBDgrbWNLYKaRbbx22UpCxjzesBliurfFOSnFlVR5RTjZtLFCObeqzkVXiqZcGWON9ugowdBvWa4tU20ApLA6zBbJiNl+mU+ObtY7rlofblL1aPSBILTJNxn709nB6ic8z8ACIALJBAGd1M2dBMscu2E2WUMtXSAjQOrFu6HqgbUmAuhljNFzXaG1H9POqvsFI6mvBd4UWArxBEboVT+IdJTscNkexwtZCqdzUd1WSkdZ6MT3lg/C0eARBFsxPK5VFAOaYBSVFDv6d9SciFxYfpMgYk51pGZkFEbhj6V3+sv+HPOAmvG0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a1931c-3c16-4a0f-da6f-08dec0a26151
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 12:27:58.5419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dvg1BlVmReAoacXli7y9ZqkijmCX6SFPJAxddfndPnrAYe6+Ekv1t3J+mBB/JbmCC31KtclmFqqGkxw5fpWiZS9DOF4nkhhig0VflTvIDK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5281
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

On Tue, Jun 02, 2026 at 12:47:00PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 2 June 2026 11.09
> > 
> > We can enable the building of the HPET code by default on Linux, since
> > the timers are not used - or even initialized - by default. Instead an
> > app needs to explicitly call rte_eal_hpet_init() to use the HPET timer
> > APIs. Therefore, let's simplify the user experience by deprecating the
> > option "use_hpet" and make it a no-op.
> > 
> > To avoid issue with the dpdk-test binary which was trying to initialize
> > the hpet on startup, move the hpet init call to the timer autotest -
> > the
> > only place where it was used.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Careful!
> I think this patch has unintended side effects:
> 
> On Linux, it unconditionally enables HPET (and sets RTE_LIBEAL_USE_HPET), which was previously disabled by default.
> 
> So, if some Linux applications use #ifdef RTE_LIBEAL_USE_HPET, they will now tell DPDK to use that timer instead of the TSC.
> We can fix the apps/examples in the DPDK repo, but it will potentially change behavior of DPDK user's applications.
> 
> I'm not opposed to unconditionally enabling HPET ability in DPDK itself on Linux.
> But I'm worried about side effects of unconditionally enabling #ifdef RTE_LIBEAL_USE_HPET in Linux user applications.
> 

Good point, I hadn't considered if end applications had code guarded by
USE_HPET.

However, even if HPET support is build-enabled, it still requires apps to
explicitly opt-in a) to use it and then b) to make it the default for timer
operations. That means that if apps have got the code present to use HPET
by default, then they must have a valid reason for doing so and have
explicitly opted in to doing so by adding the hpet API calls. It's not
possible for apps to "accidentally" start using HPET. [I suppose there may
be a risk from old/legacy code in apps, maybe where hpet was used in the
past and forgotten about, but otherwise I can't see there being an issue.]

More review and testing is welcome though, to ensure I'm not actually
missing something here...

/Bruce
