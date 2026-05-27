Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A061CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 10:18:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD33940285;
	Wed, 27 May 2026 12:18:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9DEA44026C
 for <dev@dpdk.org>; Wed, 27 May 2026 12:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779877105; x=1811413105;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=cWnSnnGPuciCn40G4JQSKQwrPReXr5qf/CX59aIKML4=;
 b=h10J/rpbTpGWOvidr853OY9Pjun8uOsivVAtbgGf2snD1RMb47HyJqJ/
 SmhyKOHOz+Y1Y013Y35DVbCKryqWczlTE5dDDhcAXl15Kq86bJzh/eVcn
 QneBgGBjTQr/kaP/OxF5rBLuE0M6K/EHx4hveOMEemMPHcOpgJmExAjch
 NjPMksJO/JfK07PeyaTYVKU4ZN3+nuePCkxgIA9J8G3pLqEEOzX59jrFB
 lMCwku+EM4um0TRcmhlierMdhCJB+aUZhe/dvnCYq8JxAvU+CrGqXxsog
 pX9D7GYYiWJ8lBH5IH3qDoVJFf2Xk6Sc7QqbhLsIJ3ERmWQ3suKkYDShX g==;
X-CSE-ConnectionGUID: XYnbUK9ZSAGYNYOd5QOP5g==
X-CSE-MsgGUID: vUmtwJBBSbW8NNuGdw+rww==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80813837"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80813837"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 03:18:24 -0700
X-CSE-ConnectionGUID: 6aeVJ06QRxGEELrAaCg62A==
X-CSE-MsgGUID: qqi7VtqLT1CokXS47qx3SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="235820683"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 03:18:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 03:18:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 03:18:24 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 03:18:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X86KUg5pdtRPqDs60L55ZqRggUbc1HCcy3ACuWVNcrktUy0M3+1XBFjNgNv3s1l62wTw7Vm6ZQynFdgltszwMu8MOWdKejd+hYqI8ABdkrKJhoWICYTv/AxookwuJf7kY4L157NlRdYqSxJdHRJGBbi9UPQ24R6OKRJ4QGRFnY8YaZbYY1U1imskmTkaWcouxxTyl2DL+XW0Mr8TsSKAwOY/SP0AyWa4LurbaF11k5Dlil4Nmf9d4jrJwHbhcMYfxtSuQdKSpo/29t13y419gWv+Uxup+tazI2+YkMTFL4+O3HTabMKDTIvE6Kpz0pAP8pfm1upM7apA/g8mBjwe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDMnTPm/RWLgdoDudLUGDDuM2I80AQpeAyoqPomHyJs=;
 b=SskempmRwDFosS5lcxJLLFodhOqt4hx3bWnH5GqY/Uek5dtNcR0yDIM3GdtdIEwnC6i1104jYRgym3Kh3hrNooDH3Kn/Za7kbGHkKyZooay9kOkFfDM7HZnU5h1pEh2aO7LbyyHQfP0OtF4ch8jvAEmp8HO/3tpfQlgNrVRJC/Y9ejbezU+3EGeyIulJTPfTgEpWK7md9meyAy2qdkhpMFyYpHXlB4yUe6YeByProwBH0tqEWlki4YHmm16cgGdK9MXq4zX8xCIdMy5yyuh7jA+9TjY8ysoJIUjk/JTJVNOrzagqYqv4TenY0ssKESzf1hhscvPLZm1rfbYJ3T5Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:18:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 10:18:21 +0000
Date: Wed, 27 May 2026 11:18:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mattias =?iso-8859-1?Q?R=F6nnblom?= <hofors@lysator.liu.se>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>, Morten
 =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Mattias =?iso-8859-1?Q?R=F6nnblom?=
 <mattias.ronnblom@ericsson.com>, Yogaraj Baskaravel
 <yogaraj.baskaravel@ericsson.com>
Subject: Re: [RFC v2 2/3] lib: add fastmem library
Message-ID: <ahbE6KvlgzG_XkSY@bricha3-mobl1.ger.corp.intel.com>
References: <20260525103642.55255-4-hofors@lysator.liu.se>
 <20260526085743.64396-1-hofors@lysator.liu.se>
 <20260526085743.64396-3-hofors@lysator.liu.se>
 <20260526062312.33f76fcc@phoenix.local>
 <b3982582-3023-4f2c-9c62-10d4af20d4e2@lysator.liu.se>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3982582-3023-4f2c-9c62-10d4af20d4e2@lysator.liu.se>
X-ClientProxiedBy: DU2PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:10:232::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d564e95-7935-4357-bf07-08debbd94790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|6133799003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: KsYZE4HyolRVr9Bene3BQ+LUfGS/3jtENnX+r5S5vBaQZNETsfuq+TynY/B+if7RFsa5pKWpE3Iwatkyx+JK3ywA3weiTtq6aFmykdHhaUqRM9ImNHTKEGSQpELdT22lv4PVxROhOLJ3yNmk/M4Dbv5LjynOPvYsDYFto9PNFj6CM097MWFSeX1J4qyvBRdpfWVNnrzz5V73NyoyYQSKCkjcT1So6DpqyaIdDf6z6ibaMOk85F28cpOj/KsQcaMoGrj4VtTn7iKf3eHvvJveKwCryx6CLBQoa/mZJ2Jn5Mj982jpTwdjRkA72G0AvMyiq1xCgNP1TKFQetWUdBua5p6sCUEMvUVdI1W2mwu09PeMHLM6CcyB3Xr+QR94s9OszJa51NbmoRphPv3HJRhNDsXzoQKcF5M+I9KDqj+IoWvY5q/DqVwnnkaR4NS+a2//+VAIiH2vW4Fde9cwcXqnvGJD9pNn6HW43IyIiHu5bKOI9PIPeLwcoLAIKaOM2goGij+N/i0j179+ZHSYaXKrh2YpYDsMipNVcBtZxB9i7h7YZxm8l/pPiMdunM4bXrAVdoQuvyJoh+0sa1tBwKkkxcCz8k8ePntHbFfcWlZhu01fxa9osOhx+necDpMBuXe3ONHk+iT+yEtw3US0v8k8L1/Kqkx5M/XtZJ0xjH1v7RCFFFpAnYhYk23Ok5OL1qxv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?iAoYIilI2M+vSy4t27fVe1s3yI3NP755ocboyfe37QVLi40JRyGz/atw95?=
 =?iso-8859-1?Q?iq0UpNeUSJzfVw+lOQJYFppQM5+eD5Gi79Xs86KxAGehV1fE+7OmHaEqhp?=
 =?iso-8859-1?Q?HJLQi1H7lkLo0tBmFhgnLLjw9eGuPE2ecUw07GoFnuzLXsCvLHZHcuEpzq?=
 =?iso-8859-1?Q?CMxX1d4KFA8sT3G6WkEVOUkSKVXe3EB2psrfro2zNMlzZeCtq3lyYNAUAx?=
 =?iso-8859-1?Q?NAuXHZZLfdhE8CzretXAyb8H09lcw2jNyr6whM4z2b1ZcZPApQEA7P3R5i?=
 =?iso-8859-1?Q?1FSOmLAy2Bqa6WDEjh57YTol9xUJOeynFrUhzldW8SWd8VXj4uDFqdlUfW?=
 =?iso-8859-1?Q?aYBkN0fEQzl9QdkVcxB2M7uObbNtAcv5Iq4hPoqQNUzP7fDEYgCkw85LQo?=
 =?iso-8859-1?Q?igWMhLMK+N5j5ooCzrIzR2ODmoHgjw2KE3BQ2KBm6Ely604e1ignMFQ/Zu?=
 =?iso-8859-1?Q?cGACGDt0O6gWlbnLN/qB0L5fGRUrqucTJszJHjhZpiT2ORJqS9PGmQZivu?=
 =?iso-8859-1?Q?nuv/kH2fWf4Urn5p79HioPVxMc2WWvsWKfm7XU7EDBAebAN54Km9kfdPko?=
 =?iso-8859-1?Q?lfBMHSdQI8Moy4+Achv1LA6KXgJCLqLSVzdWiopUvB9irvxqTzQtzJQsz1?=
 =?iso-8859-1?Q?EHcuNnjd9d8q4zH8ii0TinRIRd03kpuNFuaPLmYxi949uADcySBEDTj+48?=
 =?iso-8859-1?Q?Cam9TUdj2odVQH+sZPBvLj09S8Sl2U7QqD3jH3rplMbZMB6zCEqFu4F5z7?=
 =?iso-8859-1?Q?htMZVBvH7IwwqHfNo8URgr2jbM3WJdXRNz9ePHblyNpBW+PMnjn+SepXRK?=
 =?iso-8859-1?Q?8VuJK49Cf9Z4XA8iIL93ToYxO0zy4n1EamkiJKskfyiicb9hYUmn3xOqhm?=
 =?iso-8859-1?Q?QBCzKoOZy8zy81QrC2Vo4UN4tC42bZp7gY38PihhOM4Sfjp/5S75uxwJ3v?=
 =?iso-8859-1?Q?3T8EtLWsE1CK2sWQpa5BOzBi/63lCS+SfBQ3xn54J9D6yYN7P6s6OwIvnS?=
 =?iso-8859-1?Q?YEKsUWr0eiJGL59HQI7dmSMHqzFoUieqtfmlMtZn/lSzI9/Jke2wPX/mQW?=
 =?iso-8859-1?Q?J/qHilLWCEa4FsCS/L3wra5/mtE/Bx/5fjFC9l8Ha2NV3/hfWvIRF+/8//?=
 =?iso-8859-1?Q?j4u8BHC1vzcUWUueoIw/NcAmsZPJcwxpRcrA67II+HHkc76r9rYllB465N?=
 =?iso-8859-1?Q?A/AV322tT4vsS9n1pcP87PPqsi0NnoLcZWe87PQ200BuJBe9Pxqipj+QxI?=
 =?iso-8859-1?Q?mnSRDz0m+6rAiF6eI3ZBaATQudOp0BppMr1xn9cufUN2b+CgKlHux+C875?=
 =?iso-8859-1?Q?aWb0OTM3ky29ChB7MHCpusWEQaxscD2zGDitckrZnM9kIlmDvrejhpCvI1?=
 =?iso-8859-1?Q?z9PgCZzsuy0wdJ/fuWIrnx9jGLv8pn4fblR4kMtULHGAAnZ2lKtf2KYWZr?=
 =?iso-8859-1?Q?nSgBMrZyOQQYKczvDd1Cd9VcVewp9OLdlbpJtCmwpWxbr1vY21SBXj/j0a?=
 =?iso-8859-1?Q?6ysEyGn5E+i859ZiA2yDv6fqiFiP+0Pwb5mCdBTyeHGctzQC7eH4QstCPP?=
 =?iso-8859-1?Q?kw8oxJwPSfZO3APxR0fau8h3QsHifG+TrFQ6E/rkKzXUKvtd17x95DldYB?=
 =?iso-8859-1?Q?Jbbhb934f/HMzk3lLQf0L9rNuTpBPDQcPnyvkphlVilkQi6hwmVgXsi/sT?=
 =?iso-8859-1?Q?KbAVe1r9BvLS/aY2jjI3iSKoPapXxE+iFHiUOWokcS06Z9kYiVkTGzrhQ2?=
 =?iso-8859-1?Q?Kj2BOlxbz8R6PjmfyO2f+0/ONthnGM/mx/vCTGveGculZO7gm2aPulHMk1?=
 =?iso-8859-1?Q?gawCTfkFaH1ZfHKpY9GhsNcVGy2o/QU=3D?=
X-Exchange-RoutingPolicyChecked: QSj5mYPlHaAjX/Z0d82FCBcm4uuDk1uMrnvx2ZIGBBM8vR7s52JrpUOVC8eRnopg2kSmou9ylEuXw9qbvbBTmo7lHPxfrAIm/PdJJrEEthbWrAWgxyHcJnf11EF85iVvYGLr+K2syNe21WpcKjAZt/Y1i34vpupK259gP+FjAjSyTWvkYfokVcRZ6UJ+AXG4NfYjZtoQfeHvD2EG2luqkdJlOwyUSlg/AWrabYxB6pLASNnmvWeR+OvinlbpbfobbI6XPFzKPtUXqNQml1P/HYipRJ/1GFzclrzX5oSyQVEm5wcVQrdU1rLfTgD3vuhyiXx1qnruU+wQT+TO55f1aQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d564e95-7935-4357-bf07-08debbd94790
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:18:21.7062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnyW2fmA7p4w6O0/rNFUQhgGoRH2ZYnWhXVAZZWsPa18viw5pil33oac2E83e2/19JWiHuMO//2ZVpUnHKba+YlQrgABX2ihVBuZ/PQd2bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
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

On Wed, May 27, 2026 at 12:12:19PM +0200, Mattias Rönnblom wrote:
> On 5/26/26 15:23, Stephen Hemminger wrote:
> > On Tue, 26 May 2026 10:57:42 +0200
> > Mattias Rönnblom <hofors@lysator.liu.se> wrote:
> > 
> > > +__rte_experimental
> > > +void *
> > > +rte_fastmem_alloc(size_t size, size_t align, unsigned int flags)
> > > +	__rte_alloc_size(1) __rte_alloc_align(2);
> > 
> > Should also add attribute __rte_malloc which tells compiler
> > that pointer returned cannot alias other memory
> > 
> > And add __rte_dealloc(rte_fastmem_free, 1)
> > which tells compiler that the returned pointer should only go
> > back to fastmem (not free, rte_free, etc).
> 
> Done. Only works for the single-object ops (not bulk) though.
> 
> I've had a look at how to extend fastmem to support larger allocations
> (without suggesting this is the way to go).
> 
> Seems to me that implementation should be something like
> a) slab allocator for small objects.
> b) a cache-less per-socket page run allocator for mid-sized objects.
> c) per-object memzones for large objects.
> 
> If one would implement that, you would essentially have a plug-in
> replacement for rte_malloc.h (maybe minus some debug and some more esoteric
> DPDK heap features).
> 
> Should fastmem be an outright replacement, or something that at least
> initially lives alongside the regular heap, maybe with a run- or
> compile-time option to make rte_malloc.h functions delegate to fastmem? This
> is unclear to me at this point. I fear the more ambitious, cleaner and more
> risky DPDK heap replacement path will go they way my attempts to replace
> rte_memcpy or rte_timer went.
> 
> I would agree with anyone saying that we should have only one heap-like API
> for memory allocations. rte_malloc.h obviously needs to stay, for backward
> compatibility reason, if nothing else. I would like to add bulk alloc/free,
> and allow for smaller alignments than 64, since slabs can do that
> efficiently (DPDK heap per-object header is 128 bytes!). One could either go
> about that by extending rte_malloc.h or deprecating that API and starting
> anew. In the latter case, one could do many more minor tweaks, like removing
> the type pointers (only a nuance), remove the validate function, change and
> extend the stats interface, etc.
> 
+1 for replacing rte_malloc. For a replacement, I'd tend towards aiming for
compatibilty over trying to fix too many little things at once. While
changing a couple of things is ok, I'd rather not force applications to
make too many updates to their code when moving from one DPDK version to
another.

/Bruce
