Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B66C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:58:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E26D440E3B;
	Tue,  3 Jun 2025 17:58:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2282B40E39
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:57:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748966279; x=1780502279;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=q/J5WbDLuH+SvkO52T9WjKVpjYGx4v1PstpLCLFt8aQ=;
 b=n0DJEerIq0MkwRZfaF7aM+ieDoeg4plpdyVFbCZj711nRyg2cpZoFBTv
 Agolu9pSfyOm+c7QThoLZY0U+TDmImw/FH2DVEvnEP96AcoRXFNAGaYSE
 wemj1LLiJ0xpWwnYJ4Ke954xtClsOsZE9Xr5G2MA3lkmOfEu2/TAtzqOD
 yOOEaF/y1qB+Gtn6vWfU9C8JLmHGbJzJG/TnN0VZXRoHzyFweb/7UPbPe
 Lb1zE0scY47d5OLFhIAeJwyubrIot1q+1KTdnvQyI/vN4Wq4b/hQYfZUy
 vxJNGMBqzG3lWEk62UydHv98W0e+NmfKV6OYsxTl4CwVNHogzAw6NI5wv w==;
X-CSE-ConnectionGUID: ZmFoLofARsmsCcFEjWbeDg==
X-CSE-MsgGUID: wjem9Q1VQuGXsXVAwT0XrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50254172"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="50254172"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:57:35 -0700
X-CSE-ConnectionGUID: 7Y5IUDCkToWtjhiOIyVMqQ==
X-CSE-MsgGUID: SL4yMyH8QOqufGfX0uQ9Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="148747864"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:57:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 08:57:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 08:57:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.67)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 08:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBu8uzXGOdi4TU3w/G6PuHI3DfNT1ppSnWz1sk4ezUtQ5qhrFGC6ga5lr0HIhJDVRKs5vCeIFTpaETY10pul/5rfjmJqjgusqqvYVOnUROnoB39dfM/8Ganq9IEEI4iLa/UJNBFG/eMjEbnibiGZqj0kgDaF14VBOhnWj+6lksIDmIobuLZpcfx8EaenXZ8F+nKk/c/m2d5A2Q2Uwlx3wbgSyrUAMTingw9CXuWe+sbpwD+SH7sLW9/DkWv3W6yYqZi+5Ze+semUqgGhDDe5zE46DqB+hGQprZEBKKC3uh0ViIZ8vdkgZYJ6a/jAwrqm56a1TEfj85036igtXo9Onw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz00jYUvm6ytkUAHadb3PV8Uh73oA+q68l7G5nlW8vI=;
 b=xRP5/SFu3d6SIfFsA2mMLx0vK5qJApRGTPaHeqwsKyLL4e8VFguTgWDGaCZOLrEAexSGrQDbvWYg46KOReaw/32gfc+llsJFQLKeKFs+gEnj4iHZbE8TvXic1P9L0kJdXaScvy8J5DXQrsmuvA0mHFIGtFjgPXWjpGJagIrxEn27cA/1Yl23RgFLPpkcigWzWBbej5JipKo6XI1pGjNeg458lsxdyoIXpHS2mUYvXM3gzM7elK3Xl/aPleQ65IjsAgetPP4cNe/iZcjAAuLmiSGo9M2Am+jnOc+iXWMk1myfbifJ6jchcOkEzVqY0gyEC7ifF3iFHUi+Yvj0KFVfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 15:57:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 15:57:31 +0000
Date: Tue, 3 Jun 2025 16:57:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 05/25] net/ice: match variable name to other drivers
Message-ID: <aD8bZ2cbZL3jeEiG@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <730db61d118c257b4862a2bb64137c743549559b.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <730db61d118c257b4862a2bb64137c743549559b.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZP191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: d12421e6-2d31-48b4-2675-08dda2b7593d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GYbI4uKaqW9qXQnXI2nePTie8JonYNgPxgzCnLNv2Hagloa0OYeMmYuIV1EG?=
 =?us-ascii?Q?+avDG4JpNw8FYLaX7nZOxUpIyk5mUIpMrerQ5asm7PKvGhn/HRUq5jWm0meW?=
 =?us-ascii?Q?bsTqU0hx/dAWipDKZLeSFLp08u1wSGwfnqPbDo2uEMuCN5MI7bBokC6wyLKC?=
 =?us-ascii?Q?vvjxriE+crAGAT9drxU7B2dK+Dhd7iGryAIFqr5gFMkypcy+ihVOETgeC9Mm?=
 =?us-ascii?Q?3r2zfTQ6ccZ6z8PfT8wF+FTgFRHlSEToMr9DAyzYSCm6lHD7n8j5EKle8Tax?=
 =?us-ascii?Q?4WplUycIVga0JWCZlfGyWqFYlYIAuKjiX8/TkBYDNDZS4/Fa+PmIH/9Nh1f2?=
 =?us-ascii?Q?06+2nXyEULrduf5uAPTfJbd92ADcOXRSOwhd5WtpEbe7Zko2VjaYhcn2Zahg?=
 =?us-ascii?Q?5g/wfubSpAODMKfZwfK8EP5VINnGCC7qeemeOEU9jmCOxj2iLgcvkSLxlrWA?=
 =?us-ascii?Q?COxc6l3uTwr+CYhO8rPR3qX4L60NTJ3ryJt3o0RAAylQEQr1y1K1a8x952xq?=
 =?us-ascii?Q?YxUyHjECjYAxbNWE0+650fH8wBh2N8wCmsSga2lcBmRxrp3s8KP9fMKW7dH/?=
 =?us-ascii?Q?9bPek3z9xwt0WWGlvOUGwibnvZOMu1/FO7FDuEgytU55WHgCq5A0aDlgxPZ4?=
 =?us-ascii?Q?QSRVVIM11N7syZCBAkcgPs8lU9yI6GH4h7AOtn8T7DfYeLTh12hzIkFG+/Pk?=
 =?us-ascii?Q?hThL4I0OHJP1tvhTai9vCrogq26n6qp2Pe8iVyOqDO4tMj7hi8cWxjMTcACu?=
 =?us-ascii?Q?+BQCG1sHTJwQkeCYHl3fA4eKXdzjNZneBw7y5asAVcln26rwLnPPIwsckd7K?=
 =?us-ascii?Q?H7Ay1c+TloL6rtSEvfOEIAWfUWAhverjLVeUZx3+sNhH6MWQps5pcsgy45R1?=
 =?us-ascii?Q?Udzl9KYjTobZ8yWOTXMVjRNCpEK4s77dF3lUVCrz+qb6ZPUNpBz858gvJ5dy?=
 =?us-ascii?Q?QJhYgySAWlI74XEQ0ZHRTD1SUI3NmdqELosmWj0nDO3sFIdy0Qj/QD8K+Ryi?=
 =?us-ascii?Q?E/6dersOfFKwkoY7iSXATY2sg/LCEJ9BpeNxMzD9lhdXKeiyIKHzsBTihXM2?=
 =?us-ascii?Q?+Phs5+ja55RxC7R7cBH7htkxS7mRBZaf25/3M0Mov/LL4itAOdbh1SrO+7l7?=
 =?us-ascii?Q?W+iDz7/6FpdsNQ+opQAwjbplXiZQuqWaSi9ASbr/Dib6E5MAdM5oN1mMJ2Ve?=
 =?us-ascii?Q?LYS/ffxVPTURtLfaBQqtyWPmbFzyOgFqS0OcjY/y+F4K3eWGlJJtC5hFYrcA?=
 =?us-ascii?Q?WTG+OsSHjDGKodW3LARPabnEyqXJ6gDg/tnJ+S1p6cTELOzCrHe9pkRhYPzQ?=
 =?us-ascii?Q?5MqGW7vDZhMjW/wNBxEA9d1wIQ6pHzND/lMSPMndbEoBZnq+TgyEXATA9CSU?=
 =?us-ascii?Q?URF9TMxwP3TzE/HSJjG5N4IC46fWIpm843eHnmoM36UJktRaeGxd1cFLonOs?=
 =?us-ascii?Q?nWGqw/Nvfh4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVLYUzvxjG1xS3afbGxEJD3zeR7HlkKites1EXfApjaypz1u6xZ0AfksO9HW?=
 =?us-ascii?Q?WhyGKhs1s1fdchTGpM6EiKtBGp2Ijyfj28RO10AEheHLDJ4OHBwNhFdBQgcz?=
 =?us-ascii?Q?rCHzJ4u0ObWspXotBUbCT1VPtuG3OankbBYlFmuXx6ejnhSZDhIkgkQJlAEF?=
 =?us-ascii?Q?z0d4lXUco49R/XYZW6uN0IIvuKPEkfWBXI5ncRvv1wP31BHaXP2rySdjuMjX?=
 =?us-ascii?Q?yW42jLZOJwBvzdpclv0D5mXY4dJOwLtJPYHklg+CG5QFfDGnaQfSQWo34ioc?=
 =?us-ascii?Q?PWNHj/bQ6rzYsHlNnilaYhi6KlEG8GMGpEG0jcb2q5sUnarcjnz+PduByL3R?=
 =?us-ascii?Q?VYiT2UXcvMHVq5w2KXu2KCoqaYPw2v/BUjfsu+8Us1OzzxLLVOm2fPCSSb9L?=
 =?us-ascii?Q?ingtqd87IwKTZXYWAHBZJ425Jm7V3IuVUu0vRHnj/OOF2pSZChrqpKFX8CSz?=
 =?us-ascii?Q?x8hnLkgd20bi7yeffn06PT7vGXdrbt8L2Xn9SQHtiPn0+3uJygwXyWAwBDEh?=
 =?us-ascii?Q?QvaE4R5m7hRX8CdjUo36pAibkz28oTBPvgKfr813W14OTM6cOL6kf7Bfkn+M?=
 =?us-ascii?Q?fTibZbRR3y95gxcXxY2q8NG8IyQfFtD3F/9OFtI2+HqN8VN/19r1IcNcsfpe?=
 =?us-ascii?Q?XBKEuY/20bnWW9baQng2/CWgytlTtl/s3kDkHZX2iH4oReEhFussewsuEarM?=
 =?us-ascii?Q?GmtSWv6BQhcFL7+IUMKqHsMcz02Ta57knHMGZGac6XYgTvHJZ0Gxtl34ChnC?=
 =?us-ascii?Q?EEGPu5MUm7fLsCuZAGmIeX43fvRrJuuwdVdD0alrNzg6K8JTzN4soJFT+zjD?=
 =?us-ascii?Q?4SU7Kh0dRRp94opNWjnwX21lgmEV+i3iHuWe/Wh3yb/i/a0cbmR16jm4wi0S?=
 =?us-ascii?Q?HAaY3bXHzsusxRdcUIa+PxFUa8NAF/GqxYtx4MURmJ5MmgOIctl7oNyhSluG?=
 =?us-ascii?Q?Umls0G4zDHMwe/jttdgtR6Tczkc3VBksZgBjujc7Si8YtdqmUlvevEcdh2Tz?=
 =?us-ascii?Q?boVEofdgM15Dp323vqkjSNvOCtjZJAhx9mKFE/hIOgVSVJ/cHZdHHIGBEN+8?=
 =?us-ascii?Q?V3duLOCRq0PH21jSU+zEKwJbvxhl24mqLIYgeb0Gf4hC8wpxiMovHZkmmQiI?=
 =?us-ascii?Q?WvvolAZYmZQT4b65NWUzmz9gLfMbh5HUXcvvtptRGnYg1wHW0JGx9JrblBRM?=
 =?us-ascii?Q?UmX1CayXOkCOla56MRCfYottXRL7m1faM3gm8oKltde++Nz444+1kzAhf3CJ?=
 =?us-ascii?Q?gQJLaaaV9/bIuoGGw2lj8SWJwXsPYwkQHRBDIivOIZdGBKNBXbOACh+8ijin?=
 =?us-ascii?Q?7agTvLmrcdJODDoFDY+4HDTanH+Nc+AXDSKGoLyAHZhOP3+rAVAO4VSqhoWf?=
 =?us-ascii?Q?B2Uu6LaKUCZrLnIfQ5xjHdZhwT9788Rc51/DorBRy11ztpVUbg9K+O2gKLmv?=
 =?us-ascii?Q?YeUP6GQcdo1Fq0ArdCx7Jk4VWxqV6kgiGE5ycBpiqX5Uqleci0apALNTtvyg?=
 =?us-ascii?Q?TCEmetE23i00eyxDIeEeNJ/vNoExzf1Bw2qqhq+KPdYOE6Tug2tU+ZsfUJ4R?=
 =?us-ascii?Q?v0h4PK2WR76/MmKtBdsHAoOSyEKJb26lGWqO3b0vwA6NV3OBPAAexTLiGFh+?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d12421e6-2d31-48b4-2675-08dda2b7593d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:57:31.9027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVbwJMmU4OvI7fT2ArCkfY8+VtPQ1xiA5rcBV/5os/YpjWf+9St1noHXfrxovVYr3/4g6HkIQZ2quNObMZAVJzja6TyqLtsOQbugRgBkPGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
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

On Fri, May 30, 2025 at 02:57:01PM +0100, Anatoly Burakov wrote:
> Currently, the ice driver has a variable that have the same semantics as
> in other drivers, but has a different name. Rename `rx_ring_dma` to
> `rx_ring_phys_addr` for consistency with other drivers.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
