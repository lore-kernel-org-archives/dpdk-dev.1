Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF1BCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 16:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 503AB402EE;
	Mon, 29 Sep 2025 18:50:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2A35B402EB
 for <dev@dpdk.org>; Mon, 29 Sep 2025 18:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759164644; x=1790700644;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xuYQQIJdOaEExali5WoxFoa3fT5a+Mx6U4cNHGabtE8=;
 b=OhzQrktKX/EoP9mF9JkznZZY1okU4rpfWArWVcENDiKDV5j9Pt/ZImTw
 15DAft0Om0CLS6ihA6q7rg/8x+Rd+uweyRaW7rIHs1J+NzOMTIOOPurUy
 /5xCnIZFxC3hzgVETyZsB0hOqmOasqu019SrTuHn5MokKiVtGwOyd0iWw
 roCOXLOAU5GjenpaYy6rHKFM11bxqffNQMtoHKQ9meJDv0VSkfwrT8eG6
 iOQlgvNHkXtGJ9dCIgx8F//2p+m78XN1R2KAIGBlpQmhAUYQCq66FmP3z
 dkBBTaOtjFB3r9871S5llByE61KLYEqmXkAMKD0iVRbiEpWa+O0FkgpIo g==;
X-CSE-ConnectionGUID: oEcMdWstQ1mN4SaNrUaW7A==
X-CSE-MsgGUID: nz3RjLkARIClvo9cSti9OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60446186"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; d="scan'208";a="60446186"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 09:50:38 -0700
X-CSE-ConnectionGUID: +xpCBLfZSSKCzGrOnnDLFw==
X-CSE-MsgGUID: FokB2mbETECnZRojOx7acg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; d="scan'208";a="178674248"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 09:50:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:50:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 09:50:36 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3k8i7d2I95RMaxt9ZN8WdGQkGff7ZOnoNR9PMQR3aWTv6guqcMkfXoXZxVBFouNYLcZIApogtdR36lm+dkbV3TC+6B7nRJH62Qc6y++h09GUR9x2GtE9KcZfV0WrB8TaMdm5pl4parP6nSLU8BS82ImnxB8UPjvIm0IWJfwmkEqudw5C2tUGG96Cm0xJQUpo+KrcCvJP1kqUlLHj5yEQjicQdt6mmvV9zPNdffzpHTp9FUS5l1oISkyzU3vvaMq0fU+44N0cj0mkjObkA39Li8JVuYLl/Dt5GUa2YR4veoMZ5aO/1vPrUnQ28mlsBYTiUO0X3gbqPXCZ5rUAHlkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzj5UC43pEGfB0pRhmDWqGOXX+aEPzr426nI3KGdPWo=;
 b=yI2UB0DpMDOBsi00brzH/S+5KOZtfIMefKNu0aYuV067UxG9YqD0q23/dGWixewjTPCDph5DxeFf0kDnsJ0W1SnBaUfGcDSVAv0J+0zZthFKVYgAPJrBCgOXdvO6u85bTq2RVKMhjOq6Dt63BXEncSeu2HohCQUrS/AIAziO4qsLAR83/NoNkKUyfc1jUzCxUbDrZeWbvKWilOF1f2CZixSFWIevxn6kVwyjecVJr/D06ko37lTySUzD6eRqQKjhKqD7hnqlTEing9qfzJK4X6jzmsqdrmUs4vQzL5m1QUFjC1O3YTZA12MevkqmWaNUwMDLBXsdcVyFnpw7G9YLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 16:50:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 16:50:34 +0000
Date: Mon, 29 Sep 2025 17:50:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/6] remove deprecated queue stats
Message-ID: <aNq41d8CU53IsZtE@bricha3-mobl1.ger.corp.intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250929150009.1542208-1-bruce.richardson@intel.com>
 <20250929094116.23d76e0d@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250929094116.23d76e0d@hermes.local>
X-ClientProxiedBy: LO2P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fc5a65-a173-407e-20c6-08ddff784efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5nsNkGdI5jxpmcX0rRVTE0ZnfmIx3qoYF6g1r6ZPfcJQizTICXTfyD3L3m0s?=
 =?us-ascii?Q?xLC++9VMxs6gVnuIVDQc8l3D19KqVS87s8J7qC133Hn9moZ4MoZhGlrpgQ0y?=
 =?us-ascii?Q?2LxeUDuApdwRpBzrEYkz8DeDTPkoYIV6KZOdhAAgmt0Y4skoUlkiOaM9VNwQ?=
 =?us-ascii?Q?UwXhc8ibfSs1GYJmq7VHAbfJNxibeYeLzFhjs0uuyO6eFTW/B2RT0ycjytKb?=
 =?us-ascii?Q?vAnlkLk2RCv9niBjZFlzj4kBuBgtgXM4G9Vk+xdQV/N6WgOzzSgaIKHvhuY+?=
 =?us-ascii?Q?y2X6y+dMsLL/PxbILq5M/re27bRLUY0GqXxYC6ZZCWRFtuc55iHGrFvPnHMl?=
 =?us-ascii?Q?XF5C9ceKtCXJQekRDc9zIecanctLaYdFmR97yJWwocQlPQvBF54zcPB9EiAv?=
 =?us-ascii?Q?YN6l+0HCvdQMGbhRRuICIzdTO1w2ou1eqOAu0EBUTud3yunYLVbov2A/FCdD?=
 =?us-ascii?Q?T45ciHwlTPIGnVy/BKirwswkZx2MAP/d80ftznkxJ+egPFQveiRyqh4MVeW7?=
 =?us-ascii?Q?kO9TArP3yHtrYNMdMkAGu6dNMEnOwwFiR3gEx44S3DUqAdGLPtpdW8BZcysP?=
 =?us-ascii?Q?PVvZx4JCHfqLqJXgVZTZxqD4V6GswTW6mvjdZg9BwB7GAMhydCGR31YR9UQR?=
 =?us-ascii?Q?Q/u6rVFXl7RHKjocYaofRRTDsBBCjES3QV4UWPdPXsHmw+0Ila7GWQbWuf1y?=
 =?us-ascii?Q?UwLwq7ulGm++rwwwefAjAhkaU5YYe7scdrWXU9mvDe0RUqmjv8QwUyD56Nc6?=
 =?us-ascii?Q?GifItD7bRhNcmW9FAMFUkV1jcwgC3sTx8zhQcTo8afGEay2bZd1nGL5f/4Pt?=
 =?us-ascii?Q?pydifI01o28ocHaJaP2yshJCrVq+lgm7mw7ADkHIE0pSc//deQUiXY4aPTPK?=
 =?us-ascii?Q?HAIgKsyXAHUC0nHt1Bwhz+HfG/6FJzjazfCYTHFTcVQGRKzhe1GkO0ro5IVE?=
 =?us-ascii?Q?jyzO8colHd8A9SpzHHP4kUl2Orv/2CvlMNNqaDWx1scEhhLIKOCKQcH6tCit?=
 =?us-ascii?Q?ao078CONm12Xs73VS93OKcNLRE9MIVRC+5bamC/ObCZiCjREf5gsSqpJTQyz?=
 =?us-ascii?Q?88UzR5y+YMb0Rn4sTtJUyihrwsN28PTR+ISGZgOF98tIXu5vWvysfbmuZlr0?=
 =?us-ascii?Q?gZcY6F2FXHuSBTCjGNAuh2zPaYllics/fhbSN1Zzjxu6VZKL2R+WgvOG4HWF?=
 =?us-ascii?Q?ehIGe97QSx1XJYGOGb4Ro624PYp6pmk7oy3diiaB2KVaOOs/k+uvPsO1lw0+?=
 =?us-ascii?Q?9eeO7bS+ysxjAIYeC7G/yAlaazRaeOznZIXPdxlHOO41Tiem9QmpC8AVcVlK?=
 =?us-ascii?Q?9/nbIoNDX7kSMXo+MBU+EBgUgsnXB0o/bwbkN1YsuQzQgrd0Atn6isC8SmYd?=
 =?us-ascii?Q?rGRlA+V2aHiLHx1pS2hdn7Bm+kgN8iGml19AHOyRqhxs6/ddalYzw1Pw971t?=
 =?us-ascii?Q?N4frykhiH8uHUblTdWaP/KcOo0zVOnIQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eu2YtK1GpDFLUyXyXywNEltg5Iw8jp9rEnDJ0GUl+5dv17Z1U5Xlws2II25S?=
 =?us-ascii?Q?LBcJl0xhmKC1+FrHmtG0/FiwTSuSxC1dxmF2HAnsfs8LDAnHgrdXgBzdOmXM?=
 =?us-ascii?Q?9Ek8/vnKtTk6Jb2Rl3x8qSzASjh2TUOY818UJAa1NQnfyRoQxUxmvQyWyQgL?=
 =?us-ascii?Q?WfVsZOEnrT823NBhbpQ1Lfm97d9sRNcSMlsjvXmd+Yw7GpwwiHee4a6LEPdU?=
 =?us-ascii?Q?4TWEAr7pVMuGNAcCvoAHyim35K7yeWOWRgNwKUYS6p8aFVNZak9EjFXzvaq8?=
 =?us-ascii?Q?jSt174psEi/CV0jgKIXbQHt+JyAIg0HfIHruGy+OMZEWBP9HNUB299YShltc?=
 =?us-ascii?Q?sYYhr2P3DD6fMl2HP1bvwsbkLI9DBtXLy3QqALtNVEcCq/G2SS/O7Mj/kFvd?=
 =?us-ascii?Q?w/zCG6G9v+coibnjvDAuKORWqID9zGft6N5EYhON41Vm1wVaDPzU8EnO7Wi4?=
 =?us-ascii?Q?Hrp/7eCO/EORtGm+5W2RwCJVTFt65g9p1wbDa9st1nCxadaxYts54Icdxgdr?=
 =?us-ascii?Q?Xqvz9YPuME3r9W4ws5630k6sOEm/Y2EyJ0QOF2CAPm3gpbfONsDD74UPS0O7?=
 =?us-ascii?Q?mDbvwx366HT1fCakB7WIImhV5Mx9Kq6KpzIueUA+q3yEWRoWsRuTJBptn3fm?=
 =?us-ascii?Q?xmvcFTjcCnA50VIfEKIhRHndvRpyGDNZC1jICeZk6E6cvk+i1IBvpyikkf+h?=
 =?us-ascii?Q?wUBIHdomeZQuGZkgtgCX4X3STlS3QLz2ynnwoQaRqEY1t4SNmAcqRfxxfrwW?=
 =?us-ascii?Q?Iv3EQnXfKDpV9ONo3wXnRBXRKe4n6Qo8s8ntBT+AvnCuC2cc9/SD7Y3pr+j4?=
 =?us-ascii?Q?SzEeA+cqfSx2+7Hc7DuKSvCfdDa3tbXVxD2eVPFeBmTwIA/AFlWsw6nu6rt7?=
 =?us-ascii?Q?/zRXraWq3GkedYJVnQSWpNU6ctsdCo3heqtXI5QaZK7KDaknxUNYPHmBj9in?=
 =?us-ascii?Q?sZ2icIqNUh60b6uvS/BmHdOM1Antipb/BG5ZCY1frDpqgTCur7DHzLb1AFYi?=
 =?us-ascii?Q?7LKaK87NvoWFVIYepM9MnWGRnEmQmo8EKd5QeghXl8a2riB+roDhb98JRt7U?=
 =?us-ascii?Q?lQ5afjkzXfRfCRw4Gx+yXt/uyXoxrxDxNfYlTjeeM1wCbwv7KUQl5XkaCDQq?=
 =?us-ascii?Q?HQ9xz1o3i1VTZc7tAmyt9CM5QyS0Zf9wZ6cBxRTkZGrZNEHtbQUYnrkxExIQ?=
 =?us-ascii?Q?6HGWJKRGCioG68XobXG5elfHWpMwq3z9BM1xbw3PlrDXVdJEDg+95mw5SVsL?=
 =?us-ascii?Q?rsYd/w5YUcaJgknFPS9zVvYyR++qww8Q6VIFapP6a+HseKOa2kN5jDjZs7EY?=
 =?us-ascii?Q?eRp8G6ycQCOoBAyAJrV3iY9JdQvBJM1izWa+3YtyBtJdK/4tWYBs9Rw0YgGP?=
 =?us-ascii?Q?6/8WqEovgHMpDQW/LQkLIi4ke5x0ya0EMOEq3dF6LD14KpyeWxSkbLwBbjEv?=
 =?us-ascii?Q?YuwnnkI3BHb8tvspCS7u1tvr1lFzF9YiB+KOdK08PhzJqon56h9mUfx0RIlb?=
 =?us-ascii?Q?/fxi8B7OPagpCjl08VysFzHOa/KIWmsxlLCJw17nd+MDzppBzhGxewc/vBXt?=
 =?us-ascii?Q?Wa/wjYeOImPiuyr9nfpkM7GCciReU5/NfKK1Y4KGqwA0vuI3GVEK8UPqLng2?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fc5a65-a173-407e-20c6-08ddff784efb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 16:50:34.5291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTU6HsT8h1o+0lvOO8X4fQU25P3uDeJdWNG5fmTyyf/X7rt4PTymPmwbBqI8KHmat1v36ugUVL4B2Um5Zkfp93FOP1Vkdkgff6J8q7Bl01o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
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

On Mon, Sep 29, 2025 at 09:41:16AM -0700, Stephen Hemminger wrote:
> On Mon, 29 Sep 2025 16:00:03 +0100 Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> 
> > NOTE: as called out below, on apply patches 3-6 should be squashed.
> > They are separated out here for easier review!
> > 
> > Since DPDK 20.11 release, the use of queue stats inside the
> > rte_eth_stats structure has been deprecated with the intention to
> > remove them. Sadly, despite 5 years passing that has still not been
> > done. This patchset finally attempts to fix that situation and remove
> > the queue stats fields.
> > 
> > The biggest complication here is the fact that, as part of the
> > deprecation, a new driver flag was added which caused ethdev to
> > automatically add the queue stats into xstats. While this was good, in
> > that it allowed quick use of xstats for getting queue statistics, it
> > now causes lots of problems because we have 35 drivers (by a rough
> > count using grep) which rely on this functionality to export their
> > queue stats via xstats. This means that if we drop the queue stats
> > fields from the regular stats structure, then 35 drivers will lose
> > *all* queue stats reporting functionality! This is not an acceptable
> > situation IMHO. [And in one patchset trying to change all 35 drivers to
> > directly export via xstats is not feasible either, since adding extra
> > xstats can be very complicated at times.]
> > 
> > Therefore, we need to make changes that a) removes the queue fields
> > from the regular stats structure, while also b) continuing to allow the
> > individual driver stats_get functions return those stats to ethdev for
> > filling in. I tried a number of approaches here to find one that was
> > most feasible to implement for large numbers of drivers, so that either
> > scripts or AI assistants could automate a lot of the changes. The most
> > feasible approach I found was to define a DPDK-internal
> > queue-stats-only structure, which would be passed as a 3rd parameter to
> > the drivers' stats_get functions. When calling stats_get from ethdev,
> > this third parameter would be NULL, but for gathering xstats, it would
> > be non-NULL for drivers which have the
> > RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS flag set.
> > 
> > For this set, I've separated out the driver changes from the ethdev
> > changes and the app changes, since the driver changes are so numerous,
> > making the rest hard to review. In order to ensure clean compilation
> > and git history, patches 3 through 6 should be squashed into a single
> > one on apply.
> > 
> > Beyond these patches, more cleanup should/could be done: * ensure that
> > any drivers which don't set the AUTOFILL flag have the qstats parameter
> > set as __rte_unused.  * For those that do use the AUTOFILL flag, we
> > should ensure that they actually do fill in the stats, and not just set
> > them to zero. (First two patches here fix that for a couple of Intel
> > drivers) * then work to reduce the number of drivers which use the flag
> > to set the xstats, with a view to completely removing the queue stats
> > from regular stats functions.  * Within ethdev (and testpmd), we should
> > consider what to do with any other legacy queue stats related
> > functions, for example, do we still keep the queue mappings functions.
> > 
> > Bruce Richardson (6): net/ice: don't report empty queue xstats
> > net/ipn3ke: drop unsupported per-queue xstats ethdev: remove queue
> > stats from ethdev stats structure drivers/net: update to remove queue
> > stats from eth stats app: remove queue stats from eth stats doc: update
> > docs for ethdev changes
> > 
> >  app/proc-info/main.c                          |  16 ---
> >  app/test-pmd/config.c                         |   6 -
> >  app/test/virtual_pmd.c                        |   3 +-
> >  config/rte_config.h                           |   1 -
> >  doc/guides/rel_notes/deprecation.rst          |   7 -
> >  doc/guides/rel_notes/release_25_11.rst        |   6 +
> >  drivers/net/af_packet/rte_eth_af_packet.c     |  13 +-
> >  drivers/net/af_xdp/rte_eth_af_xdp.c           |  35 +++--
> >  drivers/net/ark/ark_ethdev.c                  |  36 +++--
> >  drivers/net/ark/ark_ethdev_rx.c               |  14 +-
> >  drivers/net/ark/ark_ethdev_rx.h               |   3 +-
> >  drivers/net/ark/ark_ethdev_tx.c               |  12 +-
> >  drivers/net/ark/ark_ethdev_tx.h               |   3 +-
> >  drivers/net/atlantic/atl_ethdev.c             |  19 +--
> >  drivers/net/atlantic/atl_types.h              |   1 +
> >  drivers/net/avp/avp_ethdev.c                  |  20 ++-
> >  drivers/net/axgbe/axgbe_ethdev.c              |  22 +--
> >  drivers/net/axgbe/axgbe_ethdev.h              |   1 +
> >  drivers/net/bnx2x/bnx2x_ethdev.c              |   3 +-
> >  drivers/net/bnxt/bnxt_reps.c                  |  14 +-
> >  drivers/net/bnxt/bnxt_reps.h                  |   2 +-
> >  drivers/net/bnxt/bnxt_stats.c                 | 133 ++++++++++--------
> >  drivers/net/bnxt/bnxt_stats.h                 |   2 +-
> >  drivers/net/bonding/rte_eth_bond_pmd.c        |  14 +-
> >  drivers/net/cnxk/cnxk_ethdev.h                |   3 +-
> >  drivers/net/cnxk/cnxk_rep.h                   |   3 +-
> >  drivers/net/cnxk/cnxk_rep_ops.c               |  15 +-
> >  drivers/net/cnxk/cnxk_stats.c                 |  49 ++++---
> >  drivers/net/cxgbe/cxgbe_ethdev.c              |   3 +-
> >  drivers/net/cxgbe/cxgbevf_ethdev.c            |   3 +-
> >  drivers/net/dpaa/dpaa_ethdev.c                |   3 +-
> >  drivers/net/dpaa2/dpaa2_ethdev.c              |  28 ++--
> >  drivers/net/ena/ena_ethdev.c                  |  46 +++---
> >  drivers/net/enetc/enetc_ethdev.c              |   4 +-
> >  drivers/net/enetfec/enet_ethdev.c             |   3 +-
> >  drivers/net/enic/enic.h                       |   3 +-
> >  drivers/net/enic/enic_ethdev.c                |   4 +-
> >  drivers/net/enic/enic_main.c                  |   3 +-
> >  drivers/net/enic/enic_vf_representor.c        |   3 +-
> >  drivers/net/failsafe/failsafe_ether.c         |   9 --
> >  drivers/net/failsafe/failsafe_ops.c           |   3 +-
> >  drivers/net/gve/gve_ethdev.c                  |   4 +-
> >  drivers/net/hinic/hinic_pmd_ethdev.c          |  64 ++++++---
> >  drivers/net/hns3/hns3_stats.c                 |   4 +-
> >  drivers/net/hns3/hns3_stats.h                 |   3 +-
> >  drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
> >  drivers/net/intel/e1000/em_ethdev.c           |   7 +-
> >  drivers/net/intel/e1000/igb_ethdev.c          |  14 +-
> >  drivers/net/intel/e1000/igc_ethdev.c          |  33 +++--
> >  drivers/net/intel/fm10k/fm10k_ethdev.c        |  27 ++--
> >  drivers/net/intel/i40e/i40e_ethdev.c          |   5 +-
> >  drivers/net/intel/i40e/i40e_vf_representor.c  |   2 +-
> >  drivers/net/intel/iavf/iavf_ethdev.c          |   5 +-
> >  drivers/net/intel/ice/ice_dcf_ethdev.c        |   3 +-
> >  drivers/net/intel/ice/ice_ethdev.c            |   7 +-
> >  drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
> >  drivers/net/intel/ipn3ke/ipn3ke_representor.c |  14 +-
> >  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  29 ++--
> >  drivers/net/ionic/ionic_ethdev.c              |   6 +-
> >  drivers/net/ionic/ionic_lif.c                 |  35 +++--
> >  drivers/net/ionic/ionic_lif.h                 |   3 +-
> >  drivers/net/mana/mana.c                       |  15 +-
> >  drivers/net/memif/rte_eth_memif.c             |  15 +-
> >  drivers/net/mlx4/mlx4.h                       |   3 +-
> >  drivers/net/mlx4/mlx4_ethdev.c                |  17 +--
> >  drivers/net/mlx5/mlx5.h                       |   3 +-
> >  drivers/net/mlx5/mlx5_stats.c                 |  17 +--
> >  drivers/net/mvneta/mvneta_ethdev.c            |   5 +-
> >  drivers/net/mvpp2/mrvl_ethdev.c               |  23 +--
> >  drivers/net/netvsc/hn_ethdev.c                |  17 +--
> >  drivers/net/netvsc/hn_var.h                   |   3 +-
> >  drivers/net/netvsc/hn_vf.c                    |   3 +-
> >  drivers/net/nfp/flower/nfp_flower.c           |   8 +-
> >  .../net/nfp/flower/nfp_flower_representor.c   |  19 +--
> >  .../net/nfp/flower/nfp_flower_representor.h   |   3 +
> >  drivers/net/nfp/nfp_net_common.c              |  46 +++---
> >  drivers/net/nfp/nfp_net_common.h              |   4 +-
> >  drivers/net/ngbe/ngbe_ethdev.c                |  53 +++----
> >  drivers/net/ngbe/ngbe_ethdev_vf.c             |   5 +-
> >  drivers/net/ntnic/ntnic_ethdev.c              |  22 +--
> >  drivers/net/null/rte_eth_null.c               |  15 +-
> >  drivers/net/octeon_ep/otx_ep_ethdev.c         |  17 ++-
> >  drivers/net/octeontx/octeontx_ethdev.c        |   3 +-
> >  drivers/net/pcap/pcap_ethdev.c                |  23 +--
> >  drivers/net/pfe/pfe_ethdev.c                  |   3 +-
> >  drivers/net/qede/qede_ethdev.c                |  23 ++-
> >  drivers/net/r8169/r8169_ethdev.c              |   6 +-
> >  drivers/net/ring/rte_eth_ring.c               |  13 +-
> >  drivers/net/rnp/rnp_ethdev.c                  |  15 +-
> >  drivers/net/sfc/sfc_ethdev.c                  |   3 +-
> >  drivers/net/sfc/sfc_repr.c                    |   3 +-
> >  drivers/net/tap/rte_eth_tap.c                 |  23 +--
> >  drivers/net/thunderx/nicvf_ethdev.c           |  27 ++--
> >  drivers/net/txgbe/txgbe_ethdev.c              |  53 +++----
> >  drivers/net/txgbe/txgbe_ethdev_vf.c           |   5 +-
> >  drivers/net/vhost/rte_eth_vhost.c             |  26 ++--
> >  drivers/net/virtio/virtio_ethdev.c            |  23 +--
> >  drivers/net/vmxnet3/vmxnet3_ethdev.c          |  20 +--
> >  drivers/net/xsc/xsc_ethdev.c                  |  19 +--
> >  drivers/net/zxdh/zxdh_ethdev_ops.c            |  39 ++---
> >  drivers/net/zxdh/zxdh_ethdev_ops.h            |   3 +-
> >  lib/ethdev/ethdev_driver.h                    |  35 ++++-
> >  lib/ethdev/ethdev_private.c                   |  27 ++++
> >  lib/ethdev/ethdev_private.h                   |   5 +
> >  lib/ethdev/rte_ethdev.c                       |  37 ++---
> >  lib/ethdev/rte_ethdev.h                       |  11 --
> >  lib/ethdev/rte_ethdev_telemetry.c             |  20 +-- 107 files
> >  changed, 913 insertions(+), 707 deletions(-)
> > 
> 
> Great! but need to keep going.
> 
> Should also remove rte_eth_dev_set_tx_queue_stats_mapping
> rte_eth_dev_set_rx_queue_stats_mapping
> 
> Then pull dev_ops->queue_stats_mapping_set and related trace points.
> 
> There is also a related copy-paste bug in
> rte_eth_dev_set_vlan_strip_on_queue which in rx_queue_id comment.
> 
> Pull queue stats mapping comment from RTE_ETH_EVENT_RECOVERY_SUCCESS
> 
The stats mappings can't go yet, not without potentially changing behaviour
of some drivers. As pointed out above, there are a lot of drivers which are
relying on the ethdev layer to map regular stats to queue based xstats,
and, as such, may well be relying on the mapping infrastructure since the
qstats parameter is still limited by the same define. [Which is why, in
hindsight, adding the crutch of the new flag to auto-map stats to xstats was
a bad idea]. Until we actually have all drivers properly sending queue
stats via xstats, or we add a new queue stats API, we can't remove that
mapping infrastructure. [Or we issue a deprecation that the queue mappings
are going away and xstats for queues will always correspond to real queue
numbers - probably easiest option, given how few drivers use it].

So, while I agree that this patchset is only the start, it does cover the
most user-visible part of it. Additional steps can be done in future
patchsets, possibly after more deprecation notices have been issued! As it
is, I worry about breaking user apps already with this change - despite the
notice.

/Bruce
