Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA7CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 11:45:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87B9440262;
	Mon, 17 Nov 2025 12:45:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 016694025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 12:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763379919; x=1794915919;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yuTOynYzGvMHg/8DQfcKrEF0xg1l+I0Jj1cR6C+AlIw=;
 b=kBO1mf7Nzz6OCUJWO1lXCw72GaYUeVV3C6ka8KzLVxI8DNthi/2md0/N
 KK9jvrNV4BEBtFmUmknZ1oxyOTnjqo7m3idab+dxmuVIvlLetTPBZ6CCV
 8KalUh9lYK6SFzhdCIZPHn6qPrAvMA4hlWBQ+wTkywtYuxrrpgSkucAQB
 kMr2B8x7gauYusQlipKR2lgWdFeCgazYN+tJk8Fqet07bojvnLjdPrPS9
 EaR50fmiVtI3hhxr3tINkyCwP442HhArrZIm+QguV3Ku0FTGm1twjHXW9
 qVPy+7c4vX43kJgWemf2i8vYPg3z9LKWJJi1GCGa5DPBjWppC/TYjcTeK Q==;
X-CSE-ConnectionGUID: DLNjL+lWSJy8SRXb8uFH9g==
X-CSE-MsgGUID: zPWkUBSYQsS8MM1WEtgbkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65277528"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="65277528"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:45:18 -0800
X-CSE-ConnectionGUID: 92MFfS3sRjWqUwn8mIV3ZA==
X-CSE-MsgGUID: GKXIOHa1SSWDl1OGposMNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190225703"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:45:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:45:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 03:45:17 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:45:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeeNwlwb/bc8fYVIO5k3iHKGlraSUju3a1Gl/2tnk2OHUHg5Q1vd8L1CG1+3oRfqa9z8aknDd8OZkFPON43+e7KhXZgZMg0AL1UN1dRomeWLAG2caOno23MONPbA3LUymSbBtLWQg20eVpN5U9fe3Id5Epdes8ENTUKfE1K0fnowGtWwwaj2DiWWwrn9sqzr8HLACMBozl3M0+50ts9d1a88LxMxyxpWQ1xwme3Fuo0uuwF4zVpkZzdL0FCowrq1/sLAcRAsnD99RxGv0/6Mtcis10xjX9uf+Yr1vYAC7eg2Tv6lYQv8o3Pb3iZIN3a5PGlo+XiYKyqedeWxe3GsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwJcKLmVOYMWy5ziiBoGJer3zi+65McI4/4KypSpRWg=;
 b=lsANHJilnQRJ7CaeiMlfbPNopctDyT0IyzFczbPXkvCUDALQhAxKOC1jd4SrWoRVArJXLFh/LQ6KiPNBMSw+5VrUE9GMLEceLENQln8pkb8sLnOGcgsHv+fE3JAIi/cCdbhoZx5NRPdgr3NhWwghQnMOpu9c8yTLpCBHt0oXtvLQzrIcSNpjIu8xe4s8+/P8SNZu6Q0jF+58TpeWRh9TPWKuliz8M3ioBVVTSJkj9xz0RFMIOyw1v/YoTzmz4OD+6IVTaplvpG4+MSp4ymKteJu5PRElpDnK806bobMxAI2RPL4I8BpYE43CraAUmKkhUUKj2reEYkMs7mESnFqqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 11:45:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 11:45:15 +0000
Date: Mon, 17 Nov 2025 11:45:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <dev@dpdk.org>, Paul Greenwalt <paul.greenwalt@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 2/2] net/iavf: check Rx timestamp validity bit
Message-ID: <aRsKxoVBqZM08nKF@bricha3-mobl1.ger.corp.intel.com>
References: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-0-3d9a0168087b@intel.com>
 <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-2-3d9a0168087b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-2-3d9a0168087b@intel.com>
X-ClientProxiedBy: DB8P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d157a5-cf06-48b5-0ff2-08de25cec650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7TnPtLQFRA5HGB7qCDJwnqdeZs0cMqq07yphG7GBe6gRq/jhIg2otIiAOC5l?=
 =?us-ascii?Q?riwwZtGzR2Moh+dwOS13a2j93vhFCWp+z5L8wYhFigZyaxylbcdNS6ffM0aa?=
 =?us-ascii?Q?8jHWhegvuUG59utVpWaKegOOzpffxIOigIY07mQeW0d3JSEKftFv177L0V/C?=
 =?us-ascii?Q?VhNbYf3vGw74E+yCzPlcWz7ai1AgMs6gDLiTY8zLsUq65EWT7E8N+SpE1swU?=
 =?us-ascii?Q?GD9KcQb1lRVYnzgILy+JZ/k9oyfkOAedztY2Co/HfJ6Dl6tAXLkJhExneIkP?=
 =?us-ascii?Q?kZ5e3RRBt1WKewG5j9Nsf0LMKIh623AE98O/oT+EGWVZiKg1NBo+5mqVSJQA?=
 =?us-ascii?Q?uo9JR4gsvOD39oTOZWluwEpc5B9w+P47lus+Nb2D8IKqbgxomOhdg1Ak7N6B?=
 =?us-ascii?Q?mPwBNYjf5AEpNr13nxJ69obI7HxzpyX3lFRQM12rNHgRXOeyXcgTdgFCVcMf?=
 =?us-ascii?Q?I80U4EYTpH/BOjupRmA6A0kQmITTZxfryqSGhhtRhTpD6UTD6+b1+ogxAAjV?=
 =?us-ascii?Q?sgWUrF6AJlZG8bz4TiHwiGef2LFP8NHsgqLFp/IHAs3O7UDjJoWEWLJ7mIdA?=
 =?us-ascii?Q?GTJGWXFAz61ToACrlFfh2gbAZpmJo+oUxgsNQVWQwNCAttYdlAC0Pax5i/wa?=
 =?us-ascii?Q?KoIg/kSnoTrVZyw4C0YILvVBbROfhn54BYLDYuWsGCDYmhA6mvmP8OtUkQC9?=
 =?us-ascii?Q?c2ZkmUNyeGJKT9AroOw+gtSSUlGyfjCzV0mrhCTsiI7Pv3I77d1tOWC0WVJ2?=
 =?us-ascii?Q?+oAc4Hdbo3Hm2gejkCS9HjGsJrw5/MTmLj7rw23WTGYtNQXvWeHVFZ+Opr4L?=
 =?us-ascii?Q?WGJ1hbZCnbh4HqektWLeiRb5ifmDchmjz0SHoH/iWEHqO4qYCCy5Bmp2PqKm?=
 =?us-ascii?Q?qYk/ZB3sRxN1SKBOMqf6wB/XliLp0KkXqfmOifMjwWhpZv3j72q9ymAOY/8E?=
 =?us-ascii?Q?3CWH9sf/emlAu4+Ld3VHDQ7qAmkiEazG80CCDHLSShkhi3kKkoggQDbWnVfy?=
 =?us-ascii?Q?aXcIt+A0oDcZuxibWdChFlELDvdiONAhkoEVSWANIDZVQ/9EmmB40LxdUbr+?=
 =?us-ascii?Q?tclruQaK/svvDfhV0CpM4kgnGe+twlZAzY8eU53AKJD3tWgdwqFP1uVYu+xi?=
 =?us-ascii?Q?q9hyS4/B26RtDYhnt+wQD/84k/NWWh3S835tv9NcdiJaWo+6cnV4fljbsqwU?=
 =?us-ascii?Q?ITmu0XJjBcOg8WdqHe07UvfGpGE15Hn7Lftcwn7fq7hFUSgqHWvN+hrTVE6Y?=
 =?us-ascii?Q?NxiSLHc6B1Q51ds3NHW2NL7Bh/8TTe6cyuaaxxCh1HSJx/dKoANPwzM4QIAO?=
 =?us-ascii?Q?fZVKuVTUtdEE16/LPuCq5ITZCYg4ikzJ+530OY9TKfvOImGlzL6YsQAOM6gm?=
 =?us-ascii?Q?kBq5yeVHcNNbbrOqHx3MmEOC5ygwrm9C9D8dRWN80AUzUA+NrOIBiiBEOmWu?=
 =?us-ascii?Q?EASsmGNTsoFtDGMVDqN9Urejehi+Vm5f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GoHQvE+lb57w8G2lf/NLcXEc2MOxrmcyct2nfSXBGFopUhFJ8Bedx6h13UnY?=
 =?us-ascii?Q?nwJxKZqiitJoNAMnfDOdnxNQ8XmQ/V/emZYMA0rRhIv6udB0Rrarq1jNpjGM?=
 =?us-ascii?Q?AW6Dotu0BFB+QNRnEre2d6ST6wKPkBUP48yhCRiJ0wXD93e2I8KmF32bC9k2?=
 =?us-ascii?Q?jhK7VpR4UgnTGsyq1YwISXfglK1ELZoyM6O+450ur3Fbtvk7FBM5sH9Ym7Yz?=
 =?us-ascii?Q?i6/5j6SkbdMdtE+N3aN8+MQB3wNujCgEtvg9xJd2L1aPLNsS8EO3dmanVw8l?=
 =?us-ascii?Q?6YTmn05sKGTWj4z2ukhuu3enINYl/a1vmoEZbPtOgqCv96zPwc2A5zvEiKY4?=
 =?us-ascii?Q?US9kfvIpTZ/3xU2Y+clxq9MErwOa7Dj+/BPp4hGjMKDCGQLy8D9PocE/Waez?=
 =?us-ascii?Q?O10l1PjNXuLRTKO/F99J7KpBlZleZHxc0IwXWiJ9tJxtbVTrY0c9ws4F31xq?=
 =?us-ascii?Q?crgGyisMg5w0ZSLBBwBBqr8s8sy2N+1Js9tPjpA81lEQX+JVUe69/Tq46YkX?=
 =?us-ascii?Q?i39ZyP9PfObbfCwJsuwmCEYk8K+gRAkzG7WaEq7vEJzH//zIyAMLMJgwumyo?=
 =?us-ascii?Q?BMhOLz/PlfW4dDCUEaC4SHcBlpdPfDDPKs/851thz/Z7L9nmzZvkBpZ65x2Q?=
 =?us-ascii?Q?kdEwleF+PzjMqSd+vDmWC2m7ijsa8SRFUzxO9AoRhEgVG8fGqN7L7Gk1LeZe?=
 =?us-ascii?Q?D4WT6w9KJeXYdsQ+YF+yWXaMY5nEicCRPzm+Pia1NthCC/bQqVWUWSVJm4kw?=
 =?us-ascii?Q?E4REXK3Bu5+p4jt7tMTGQ+ZHqNScxuSklrAgleIpz4cU2YYXHiqLx9mTRHlh?=
 =?us-ascii?Q?jZIBS567AEWFx90aF+LJf8Ib/shkwqQiWZY6JDE1niVGf0OvBoAg4iqssDU8?=
 =?us-ascii?Q?YvQWBEVCLnAFkVgBgJ/lPJ0LEFzkzIJ35eva5nDFHoFUYr976eOt7jEs/aJG?=
 =?us-ascii?Q?pdAn958d0qIVfteC7DdVtOlyRrJYMZAkkO/3Yjz7WyHTI25j8sL+CqokgoJu?=
 =?us-ascii?Q?OnX7m+6jOTzMNUFpVL8s2RfYPsyvXYtU09XIQbqpms1jI1sV7M4DRMalNBKk?=
 =?us-ascii?Q?7LAtsS/ORBYDzNUO/CRqXzKOPRuiw5U42m1NKtyHoboMq0qqsKpB78n9FZai?=
 =?us-ascii?Q?7GrV0fnOLJ0mRF/tDbvyDs+MFj3f24oIr6GUOsJUEom9mNZdCb1TVqhBCxZ9?=
 =?us-ascii?Q?9+/vowVxliSGoihzpEjKyYMpnX8Ly+DfTrEHGZ89DTQtqvRag31aIVGIEYOm?=
 =?us-ascii?Q?4GwjgLjOtOYog0vtAJ8e4p1nUFQb7lcHoQ1fb+tewAmeBC04ihCuEEbrCqV6?=
 =?us-ascii?Q?tTGgsR2V1tPqJWCMLM6/OuUS1iH1FlUPEmmI/KaLBXZ5ztS7GfzlygkDQ2+u?=
 =?us-ascii?Q?aphv+VTeWYJe4L7hXqrkkCvKl9Em6b2OjjeWX3iDahs1v4WhhXmOh8FMYdue?=
 =?us-ascii?Q?ECzUodXwlDF/cjPPDl4VbjMwWQzXemtwxtreck6ZbVxt28yn1/AJ0FejakNJ?=
 =?us-ascii?Q?1ygSzjLrQiWO+xuLGReTxcphAAAyjNd9iWPTM0rs2TGyKcY+5lKpcTvUnKdl?=
 =?us-ascii?Q?OWim5jDvU7V7TugdDyFtt2mGzWqnwFY+SNjl8eh/I/IR+w1/DZHqzjbJGNC0?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d157a5-cf06-48b5-0ff2-08de25cec650
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:45:15.6216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMjEs4qgqA9ZQzUJ4yAQWaK0zwLbqUDoO7vWRX1zoj4fzzlyqTM6YRUSp7h08d2EuUGXV2hv1Et4W8NBJtGAkLXh9Yp+aPIdfCdpge1AlrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
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

On Thu, Nov 13, 2025 at 01:33:45PM -0800, Jacob Keller wrote:
> When reporting an Rx timestamp from the receive descriptor, the iavf
> driver does not check the validity bit in the time_stamp_low field. In
> the event that hardware does not capture a receive timestamp for any
> reason, this valid bit is unset, and the timestamp value in the
> descriptor is zeroed out.
> 
> The iavf driver ignores this and passes the zero value into the
> iavf_tstamp_convert_32b_64b function regardless, and proceeds to treat
> the result as a valid timestamp.
> 
> Instead of reporting a zero timestamp which users can clearly interpret
> as invalid, the raw 0 value from the descriptor is "extended" to the
> 64-bit timestamp. This results in values which are not immediately
> obvious as invalid to users:
> 
>   timestamp 1760629088881475583
>   timestamp 1760629088881475583
>   timestamp 1760629088881475583
> 
> First, if the value is printed in base 10 it is not immediately obvious
> that the lower 32 bits are zero. Second, multiple packets in sequence
> will receive the same "timestamp".
> 
> This occurs because of the timestamp extension logic. The receive
> descriptor timestamps are 40 bits, with 32 bits of nanosecond precision,
> 7 bits of subnanosecond precision, and 1 validity bit. The
> sub-nanosecond precision bits are discarded. To obtain a 64-bit
> timestamp, the upper 32 bits are calculated from the lower 32-bits and a
> snapshot of the PHC timer that is captured recently (within ~2 seconds
> of the packet timestamp). This enables reporting proper full 64-bit
> timestamps without needing to store all 64 bits in the receive
> descriptor.
> 
> However, when timestamps are not working properly, the raw 'zero' value
> is extended regardless of whether hardware indicated it was a valid
> timestamp. As a result, users can see what appear at a glance as valid
> timestamps. However, they will not match the packet reception time, and
> will only update when the upper bits would roll over. This occurs every
> 2^32 seconds, or approximately once every 4 seconds.
> 
> Instead of reporting bogus extended timestamp values which could confuse
> user applications, check the validity bit and only report a timestamp of
> the valid bit is set. This matches the implementation used in the Linux
> PF driver.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Fixes: b5cd735132f6 ("net/iavf: enable Rx timestamp on flex descriptor")

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

