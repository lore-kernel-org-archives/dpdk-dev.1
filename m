Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD327CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 09:40:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4906402E1;
	Tue, 26 May 2026 11:40:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D5A76402D7
 for <dev@dpdk.org>; Tue, 26 May 2026 11:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779788401; x=1811324401;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=CQxseAKl17aeFsqvbUdqwHvxg61t4Bb4+OnGhWMnjEA=;
 b=Pj9Nur3hWhU6DbIjaxavt0URYQCSxNr10MDhTlYfe6SjVdctezxZ4Lqw
 yAyI4AQwuItfl8VYYsnqbF6t8KDbcw30+7CiawhPTEg7ea+ur5Jw15Cjz
 8nML4c5l25/uA8mCscb5O7bobj1ZSOWYXDdHQRbeGz5aPGGUfkhpZL3yR
 aTfraf/V6ZGHlUEuQAVe7C0cz/l/XFyal2/gYwGUQJexQBgb4pfW44P20
 pNYNa75GugQoA8HAT+tXF2k3zHBs+C5JFbKBIWSYimAkkVtJagV0Qz5xB
 aljFXkCNYAEW5BAsTE8K3FSkVoOfCPBcoBUBVyU7+fIMSV//X/ODAYfbY g==;
X-CSE-ConnectionGUID: +0z+ObUITJODhTKOs8yesw==
X-CSE-MsgGUID: DOFqq8WuSqq32G/C5imiAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="90897352"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="90897352"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 02:39:59 -0700
X-CSE-ConnectionGUID: DTGU6VXkSEK6wIyts/Qizg==
X-CSE-MsgGUID: CxTXyiTfR2u6aQgawh6dCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="239273289"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 02:39:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:39:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 02:39:58 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4R70iuWnynr1JLpNabDoyqtZdeQ/otAWL4x/5QXt4dmSoEV6DPYfE2m05DigO8SFoFsIFtHO5UCPprs3TEdvlPpYLhJBEQRtjGw37liaQsv1aW/tBo0i3S2lWiHxLToh5c+VjI7qlzx5wkw/GlidePrsxKK5dJtThQ1FmxTTsO9sH7e20HUOCiuakg/kbwAHPMrqQpMbck5BMCZ9uZxTKz4yiqu5TdoFvKkozhAEYy1I97cPe+PXze5fPcgUdmPnpFbYonflDGW5sAyAGYsg112H8V2q7GK3c+LaivDMl4gmhkU068dbbeujtuZQ/1J8kmo+BHAJjrR80h2aQx6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uyTfyjFuCeWXhR3MewuqVg/OUSMZbfJ97W1Y2WeBg8=;
 b=bMHEuqdJPeETcctaArHTuJM2HW3h3aUFzkMK4v7xm/6TO47YSye0sumJlUCtjGk5EdcqtR1AyToi1x2zEDm6HmXT1tRK4E2oEI1YsMBXq0PSXqOEc22FhnDhGOXT1vdEtf+jN314NEX9qwGMrxGffJl29056xM+koZ2nyUWhGnXPe1fBCfZ9WbxU5LtbvijWuhtY9qCLPyo9FEfMiG81KLavRgxH4EjHIuvDeBkzP988zsWWVDMjGZsEzZ4gGqFO8sIuxrq1/xPIYGGWw7ZS55U4RRxE5NWZ0BqhEjAoYIirlevxb8OktORbHgUvbAoC6C51PuEjnkxXJmMvuGB6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 09:39:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:39:52 +0000
Date: Tue, 26 May 2026 10:39:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "Jingjing Wu" <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, "Hemant Agrawal" <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@oss.nxp.com>
Subject: Re: [PATCH v5] mempool: improve cache behaviour and performance
Message-ID: <ahVqYpVXMn59Tl2d@bricha3-mobl1.ger.corp.intel.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260419095526.39526-1-mb@smartsharesystems.com>
 <ahCAPT1LEn_Rc7Pk@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6589A@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6589A@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZP191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 762542d1-592a-49a6-1fb4-08debb0abcd2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: wZceUfC2OKqcmD9xGEBzqgRMUvVUQ+JnV/ZXxI1AUDG/WFY2LpOspLGCVldkMZEotExnE4sqZaWWWNmov86L0tXs4N8fP8/wtTfI/I/SZGHiaOLUd65JgfSZ1/NA36DyrUmdlPcA+5y0RT7TLM6hJfjGBFm5+0si38aC/rd96caE7VX3nTvAN+JsxGsm8lx7oPt7DVubQNKH5tHZHWkkfabd3PXgGGTGygHDW8rmB43uEnNxBfW5iozSYBV33KAHZQL2Ld6tZYfUwGXFY794LqQZbOG4C2k7ftnh5dwJBjYGEDXJjhZ1Jtos3nC47Fz4WZBX+HtkA28HUzOfbzXqLu3in9OPhuxJC3oa7EhTR3MH4rKeyiwXBDI3GoIR98dTcBCRU2Xoww9tI19DhHnsy6VVRnr/FKAEuLsNPFTxpugHxVV5au/PF7aUtPxzUP5pChbOJGWCEfEL585iKm5zVnEqoVaWDGj/9KzFct1NjYiz6sVKvyQ6Yu9FU2GUf2CoiD/vprb2ZzBEH9WIlbl5SNC90Q4eGbpD4g7U8Gw7V/cnRm9M31TwhNcP3snrULxa2Bfx65Q6ZC52SbRJErwrF8gzaT8KS3RxYyVTJj+Rx0if0/iz5W2pV58fs/7UuJoDSQ4KqlBm+Z1ocNDgJNTpTPUbDV5dM2C+knKHUfc7z6XoQ/ZALnKwgd1iU3Zc9Uv0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(4143699003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UZGBdV9d2QrGp2rdqhEO0DENAICJWWqRfmHR6cRp0+lcU7BCN8ego88XuW?=
 =?iso-8859-1?Q?pR7usQ50kBLDyicFnIQNJ+k4pEzuLd2Bxxl4Kiv5WosYb4P4lQJUFUpC3h?=
 =?iso-8859-1?Q?TZBqZcKzZkyVX1YEEkVRTdUBXn2z097nnqs6V4RyOuAlZROgxjLaKaSy40?=
 =?iso-8859-1?Q?TDpTHQQaiwt/XKJqNF/qqo8PFVwI2i9Tuh7KN/LTkwqbHFGEjZ3of2eyb6?=
 =?iso-8859-1?Q?obpNPOA+yFW0Wzh3QaxlY6GuxZHdcjiJaL7OAopdigFCvdJgvmbI5KadG5?=
 =?iso-8859-1?Q?FSJrHa7TN+zkMBVNP9nJ/wkaH10khcKxuhKfMi5scPaSYTcJBZI9tWAebG?=
 =?iso-8859-1?Q?WCfvYcPMD2fZkA3lXQOGQSs08xZo6wOHLJJ/zQVZ2PrtW1VjW1Mlrnd0f9?=
 =?iso-8859-1?Q?0RXSLXeldynOZIBVXlNVv/7XObpvxhG58nUCT5qPq6ukSj0t+AQhtO/9JH?=
 =?iso-8859-1?Q?CXNEJ7/Z0yBlyNAKb3pWGaxQZ8poZDYNOx1de5loipGyX7E2psyKVfA5YY?=
 =?iso-8859-1?Q?jRy1M3sdQDDooYuI/O51PycvzbrlIBF2liS1SzUUpNJzRI/3i4ebR/o63O?=
 =?iso-8859-1?Q?rXloUn0iaTmCTphH4/VlqM3qOxhVNMZ8VGc4/tLp3qgsgNC5NI2/90Yxb7?=
 =?iso-8859-1?Q?WAubRWlrHiRAUK0uOArYCOv5uMGTUwdb+8dB/bijshh7aJK8bkPOgrCK/7?=
 =?iso-8859-1?Q?1IqX4gt13UIIJHR0WoYu0HuFXzE8G1tfxcigu92crD/PUzwBDFIfzNiIJ5?=
 =?iso-8859-1?Q?lypyhvDC+v7g72lV/hXudsItQx5z53ZXF6f5suS7l51fWfPChyrFwNPO87?=
 =?iso-8859-1?Q?JnPrPSq5cDf1nhECeoHOpX3tJI/sKwr+evtv09HuQZN430gxT7qTicCXPs?=
 =?iso-8859-1?Q?fFeSxpATdavJv53bmvDJBhsBXTsxgLiVeQ9bEky5tWVqskLMNQdfG2ELyI?=
 =?iso-8859-1?Q?PazIvsyqG+9mYOso1RSo+6llf+1jCEGyV8uHSE42hAtCRhrKazLxoQ3P2A?=
 =?iso-8859-1?Q?sGivNC/exYKqT1/u0uOVuOTe+0zj3fnLEnBAyKi85Vuhn4SpZfHircVqo/?=
 =?iso-8859-1?Q?XZVD7l0pgUcOu+AlUZwzQQ725ST9eMGcl55ZM3/Nclhnarjd/l0hs6Slr0?=
 =?iso-8859-1?Q?u7ApLRa2kN0VywaOhhwXbX2MS51B2qeSpAViRU9DsRPamL6l62xf4eUeWb?=
 =?iso-8859-1?Q?ShAHsBdOnlDxPcwAON18Oz9DxWrpDB2n0xquT8M6SjIH0BO3wHZ6euMJVS?=
 =?iso-8859-1?Q?V2azZfkkDY7FE2qRjOM2IMoxvf5nUKd5TifSnabU6HSa8rnWh/1m/5bb91?=
 =?iso-8859-1?Q?Nzqy1rZ2gxwGyjsdeSCTULgYP7B4xTthXaLBgCtoeNqhKRA4I+M4dV7t2P?=
 =?iso-8859-1?Q?tBtOyycjPeFVsOiEQyK4AseAzPOw+gpkkCUwwSgC3RxgHctFI6W1DvkPQh?=
 =?iso-8859-1?Q?JtYuRTX/JEVaUMClQhFH11U2znIj3ZJhJUqKUsoLjKnJI+QtBn6N9cLRYc?=
 =?iso-8859-1?Q?+tnWzMI7CXtL21DvAFGNNOBbzL3pKrTEXsVsUK1mTO24z6Zx47oCmrldsW?=
 =?iso-8859-1?Q?yA0lVsFT5QQliu13IOeg2Ri2EOKJYTtZnXzZMe/Nw7LY6FuXlHiw9QBhMk?=
 =?iso-8859-1?Q?Inq2j7lE+aOVNIbV8m/lsYGggVeNl75Oi79MwC9tHBFC/HvDqHrLaZ6pnB?=
 =?iso-8859-1?Q?jlto8AkNDqzkLCDurquuPcPmk9+Q4/pU0P/aboV5CLbV1lBUljFQ9JUsHJ?=
 =?iso-8859-1?Q?pMtVUJliBmQpRmXo6lzuDBlfB9X4HPfqD5e2CpJ5EMDdgC412GkcURky2e?=
 =?iso-8859-1?Q?Lr3xXmD1XECc7oicYYBB1OhQRyMSe8o=3D?=
X-Exchange-RoutingPolicyChecked: Qqv12ijA5H2HUYSonjxibWNdUFh80IrhkuZSou2GHdFg3mPUUBjA3pkXx3pj1jqYBrK8gOQ4FbMfypSX5PMkgRVJXF/9dcVnP08FUm31b1Ch68Z8ta4lIEYK4CKAMamdCQFobdvqTKVJWROV5uTtI2elhJmDZx7x0aHXvhOKwt/7CELptu3W3t/lTfJ7uc9yGPs+etqKVtv1cRvDijawm6ZNCU7YxJd7nLMo55X6lxqodjw6AG3NCMQk6LZEAjLJ/TQcHdIH9y/DDVn2GzIptopwKGat0J0mj0wPe4a9U3Yes3QeY+lJw9YKNpD4XCzePhXJSar0h4H0YK1vVz5QHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 762542d1-592a-49a6-1fb4-08debb0abcd2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:39:52.6575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76UGJrRp2azDReRm2vE0eE2DAoR674UJNsRo0RqLiJRzGMmJWctD4npHDUvXL/VTkeLAd0gUBzKG8gCqNg+0r4joLB5chntaB4BmH396n2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
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

On Tue, May 26, 2026 at 10:41:44AM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 22 May 2026 18.12
> > 
> > On Sun, Apr 19, 2026 at 09:55:26AM +0000, Morten Brørup wrote:
> > > This patch refactors the mempool cache to eliminate some unexpected
> > > behaviour and reduce the mempool cache miss rate.
> > >
> > 
> > Agree in principle with most of these changes. As we dicussed at the
> > DPDK
> > summit conference, only issue I really have is with the threshold
> > limits
> > here - allocating and freeing only half the cache at a time seems
> > overly
> > conservative. Thinking about use-cases:
> > 
> > 1 for apps where alloc + free (generally Rx+Tx) is on the same core(s),
> >   then we should run (almost) entirely out of cache.
> 
> I strongly disagree about any goal to run the cache low.
> The primary goal is to minimize the cache miss (refill and replenish) rate.
> 
> > 2 for apps where we have alloc and free on different cores, then we
> > have
> >   some caches always being filled and others always being emptied
> 
> Agree.
> 
> > 
> > For case #1, we only need worry about the thresholds for the odd case
> > where we have a burst that causes us to overflow our cache (and we
> > can't increase our cache size to cope and avoid that). 
> > Otherwise the thresholds don't matter.
> 
> It seems like you assume the application only does something like this:
> Rx -> Rewrite -> Tx
> 
> In that case, the per-lcore cache only needs capacity for one burst, yes.
> With my patch, the cache can be rightsized by requesting a cache size of 2 * burst size.
> (Then the fill level will be either size/2 or empty, i.e. one burst or zero.
> This also happens to meet your suggested goal about low fill level, which I disagree with.)
> 
> However, I don't think that is a realistic use case.
> Many apps do something like this:
> 
>      |-> Rewrite ->|
> Rx ->|             |-> Tx
>      |-> Hold      |
>          Release ->|
> 

I agree, that's why our cache size needs to be bigger than our burst size.

> They often hold back packets before they are transmitted.
> For a simple router, when the destination IP address is not in the neighbor table, packets to that IP address are queued until ARP/ND has been resolved, and then they are dequeued and transmitted.
> Or apps performing shaping or pacing, where packets are held back in queues, and dequeued at the appropriate time.
> For such apps, the waves are much bigger (than the simple Rx->Rewrite->Tx use case).
> 
> With a random enqueue/dequeue pattern, replenishing/draining the cache to size/2 minimizes the probability of reaching one of its edges (empty or full), triggering a "cache miss" (refill/replenish).
> 
> > However, for case #2, the thresholds are constantly involved as
> > we
> > always are going to backing store. In this case, we really want to have
> > the
> > allocs *always* fill the cache completely, and the frees completely
> > empty
> > the cache.
> 
> Agree.
> 
> > 
> > Because of this, while we want to avoid cases where we fill the cache
> > completely only to have a further free causing it to be flushed,
> > because of
> > case #2 we cannot be overly conservative in how much we free/empty.
> > Ideally, we want to fill to full less a single burst, and empty leaving
> > only a single burst in the cache. Unfortunately, we don't know what
> > those
> > burst limits are, so we have to try and guess the best behaviour from
> > everything else.
> 
> I agree about not wanting to be overly conservative.
> But in the use cases I have described for #1, I don't think a target fill level of size/2 is overly conservative.
> 
> I also acknowledge that this patch doubles the mempool cache miss rate for #2.
> E.g. with a cache size of 512 and burst size of 64, the per-burst miss rate will be 64 / (1/2 * 512) = 1/4, compared to 64 / 512 = 1/8 with a full replenish/drain algorithm.
> 
> In theory, we could make it build time configurable to optimize mempools for #2.
> But mempools are also used for other objects than mbufs, so that would have unwanted side effects for non-mbuf mempools.
> 
> If we went for an algorithm targeting replenish/drain at 25 % from the edges, the per-burst miss rate for #2 would be: 64 / (3/4 * 512) = 1/6.
> 
> How about addressing #2 in the release notes:
> We describe that the cache refill/drain algorithm has been changed to only refill/drain to 50 % of the cache size, so pipelined applications performing Rx (mempool get) and Tx (mempool put) on separate cores should configure their mbuf pools with double the cache size of what they previously were to achieve similar performance.
> 
> > 
> > All that said, commits with specific suggestions inline.
> > 
> > /Bruce
> > 
> > <snip>
> > 
> > > diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> > > index 2e54fc4466..432c43ab15 100644
> > > --- a/lib/mempool/rte_mempool.h
> > > +++ b/lib/mempool/rte_mempool.h
> > > @@ -89,7 +89,7 @@ struct __rte_cache_aligned rte_mempool_debug_stats
> > {
> > >   */
> > >  struct __rte_cache_aligned rte_mempool_cache {
> > >  	uint32_t size;	      /**< Size of the cache */
> > > -	uint32_t flushthresh; /**< Threshold before we flush excess
> > elements */
> > > +	uint32_t flushthresh; /**< Obsolete; for API/ABI compatibility
> > purposes only */
> > >  	uint32_t len;	      /**< Current cache count */
> > >  #ifdef RTE_LIBRTE_MEMPOOL_STATS
> > >  	uint32_t unused;
> > > @@ -107,8 +107,10 @@ struct __rte_cache_aligned rte_mempool_cache {
> > >  	/**
> > >  	 * Cache objects
> > >  	 *
> > > -	 * Cache is allocated to this size to allow it to overflow in
> > certain
> > > -	 * cases to avoid needless emptying of cache.
> > > +	 * Note:
> > > +	 * Cache is allocated at double size for API/ABI compatibility
> > purposes only.
> > > +	 * When reducing its size at an API/ABI breaking release,
> > > +	 * remember to add a cache guard after it.
> > >  	 */
> > >  	alignas(RTE_CACHE_LINE_SIZE) void
> > *objs[RTE_MEMPOOL_CACHE_MAX_SIZE * 2];
> > >  };
> > > @@ -1046,12 +1048,17 @@ rte_mempool_free(struct rte_mempool *mp);
> > >   * @param cache_size
> > >   *   If cache_size is non-zero, the rte_mempool library will try to
> > >   *   limit the accesses to the common lockless pool, by maintaining
> > a
> > > - *   per-lcore object cache. This argument must be lower or equal to
> > > - *   RTE_MEMPOOL_CACHE_MAX_SIZE and n / 1.5.
> > > + *   per-lcore object cache. This argument must be an even number,
> > > + *   lower or equal to RTE_MEMPOOL_CACHE_MAX_SIZE and n.
> > >   *   The access to the per-lcore table is of course
> > >   *   faster than the multi-producer/consumer pool. The cache can be
> > >   *   disabled if the cache_size argument is set to 0; it can be
> > useful to
> > >   *   avoid losing objects in cache.
> > > + *   Note:
> > > + *   Mempool put/get requests of more than cache_size / 2 objects
> > may be
> > > + *   partially or fully served directly by the multi-
> > producer/consumer
> > > + *   pool, to avoid the overhead of copying the objects twice
> > (instead of
> > > + *   once) when using the cache as a bounce buffer.
> > >   * @param private_data_size
> > >   *   The size of the private data appended after the mempool
> > >   *   structure. This is useful for storing some private data after
> > the
> > > @@ -1390,24 +1397,32 @@ rte_mempool_do_generic_put(struct rte_mempool
> > *mp, void * const *obj_table,
> > >  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
> > >  	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);
> > >
> > > -	__rte_assume(cache->flushthresh <= RTE_MEMPOOL_CACHE_MAX_SIZE *
> > 2);
> > > -	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> > > -	__rte_assume(cache->len <= cache->flushthresh);
> > > -	if (likely(cache->len + n <= cache->flushthresh)) {
> > > +	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> > > +	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> > > +	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> > > +	__rte_assume(cache->len <= cache->size);
> > > +	if (likely(cache->len + n <= cache->size)) {
> > >  		/* Sufficient room in the cache for the objects. */
> > >  		cache_objs = &cache->objs[cache->len];
> > >  		cache->len += n;
> > > -	} else if (n <= cache->flushthresh) {
> > > +	} else if (n <= cache->size / 2) {
> > >  		/*
> > > -		 * The cache is big enough for the objects, but - as
> > detected by
> > > -		 * the comparison above - has insufficient room for them.
> > > -		 * Flush the cache to make room for the objects.
> > > +		 * The number of objects is within the cache bounce buffer
> > limit,
> > > +		 * but - as detected by the comparison above - the cache
> > has
> > > +		 * insufficient room for them.
> > > +		 * Flush the cache to the backend to make room for the
> > objects;
> > > +		 * flush (size / 2) objects from the bottom of the cache,
> > where
> > > +		 * objects are less hot, and move down the remaining
> > objects, which
> > > +		 * are more hot, from the upper half of the cache.
> > >  		 */
> > > -		cache_objs = &cache->objs[0];
> > > -		rte_mempool_ops_enqueue_bulk(mp, cache_objs, cache->len);
> > > -		cache->len = n;
> > > +		__rte_assume(cache->len > cache->size / 2);
> > > +		rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], cache-
> > >size / 2);
> > > +		rte_memcpy(&cache->objs[0], &cache->objs[cache->size / 2],
> > > +				sizeof(void *) * (cache->len - cache->size /
> > 2));
> > > +		cache_objs = &cache->objs[cache->len - cache->size / 2];
> > > +		cache->len = cache->len - cache->size / 2 + n;
> > 
> > The flushing of only half the cache I'm not so certain about. I agree
> > that
> > we want to not flush to empty, but I also think that we want to do more
> > than a half-flush, especially since we do an enqueue to the cache
> > immediately afterwards. Consider the case where we have a cache size of
> > 128, and we do an enqueue of 32, with the cache currently full. In that
> > case we only flush 64, reducing the cache to 64, but then immediately
> > bringing it back up to 96.
> 
> I thought in depth about whether the flush/replenish sizes should consider the request size or not. (E.g. if I should replenish size/2 or size/2+request.)
> I decided for not considering the request size, for two reasons:
> a) It roughly doesn't matter, especially when considering a sequence of random get/put requests.
> b) The size of the backend transactions become fixed, which has performance benefits: With my patch, they are always size/2, so if the cache size is 2^N, the backend transactions are 2^N and CPU cache aligned.
> 
> > For cases where we have pipelines with all
> > alloc
> > on one core and all free on another, this half-flush would be
> > inefficient.
> > 
> > Instead, I would look to have a lower target threshold post-flush, and
> > I
> > would suggest 25% - taking into account the newly freed buffers.
> 
> It's not good for #1.
> I agree that it is better for #2. But I don't think #2 is the likely use case.
> 
> After our discussion at the summit, I did start working a patch targeting fill levels at 25% from the cache edges, but I don't think it's better; so I'd rather stick with a target fill level of 50%.
> 
> > For example:
> > 
> > 	/* if n > our target of 1/4 full, flush everything,
> > 	 * else flush so that we end up with 1/4 full after n added.
> > 	 */
> > 	flush_count = n > cache->size/4 ? cache->len :
> > 			(cache->len + n) - cache->size/4;
> > 
> > 
> > >  	} else {
> > > -		/* The request itself is too big for the cache. */
> > > +		/* The request itself is too big. */
> > >  		goto driver_enqueue_stats_incremented;
> > 
> > I think original comment is better. The request itself is not too big
> > for
> > the whole mempool, just for the cache.
> 
> Ack.
> 
> > 
> > >  	}
> > >
> > > @@ -1524,7 +1539,7 @@ rte_mempool_do_generic_get(struct rte_mempool
> > *mp, void **obj_table,
> > >  	/* The cache is a stack, so copy will be in reverse order. */
> > >  	cache_objs = &cache->objs[cache->len];
> > >
> > > -	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
> > > +	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
> > >  	if (likely(n <= cache->len)) {
> > >  		/* The entire request can be satisfied from the cache. */
> > >  		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
> > > @@ -1548,13 +1563,13 @@ rte_mempool_do_generic_get(struct rte_mempool
> > *mp, void **obj_table,
> > >  	for (index = 0; index < len; index++)
> > >  		*obj_table++ = *--cache_objs;
> > >
> > > -	/* Dequeue below would overflow mem allocated for cache? */
> > > -	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
> > > +	/* Dequeue below would exceed the cache bounce buffer limit? */
> > > +	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
> > > +	if (unlikely(remaining > cache->size / 2))
> > >  		goto driver_dequeue;
> > >
> > > -	/* Fill the cache from the backend; fetch size + remaining
> > objects. */
> > > -	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs,
> > > -			cache->size + remaining);
> > > +	/* Fill the cache from the backend; fetch (size / 2) objects. */
> > > +	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs, cache->size /
> > 2);
> > 
> > Again, the cache->size / 2 doesn't seem right here. We at most half-
> > fill
> > the cache and then take some objects from that, meaning that have just
> > done
> > a re-fill of cache but end the function with it less than half full.
> > Since
> > we take from this value, I'd suggest just filling the cache completely.
> 
> The issues at the edges of the cache are symmetrical.
> If we replenish the cache to full, and the next transaction is a put, the cache needs to be drained.
> That's why I replenish to size/2.
> 

Not necessarily. After you fill the cache here (to 50%) you then take
elements from it. If we filled to 100%, then we'd only hit a flush if we
freed back more elements than we just allocated. Now, that's reasonably
likely which is why I'm ok to not filling to 100%. However, doing a refill
as part of the op, and then leaving the cache less than half full after the
op finishes is just wasteful IMHO!

One other point. The obvious worst case scenario we want to avoid is
constant fill/empty/fill/empty sequences. However, so long as we have an
asymmetry in how we do fills and empty thresholds, a repeating sequence
should never occur, and even pairs of fill/empty should be very rare.
Consider the case, for example, where we fill to 100% but only drain to
25%. For this, we can ignore scenario #2, since we should have pretty good
cache usage. For scenario #1, of allocs/frees on a single core, randomly
interleaved, our worst case is:
1) alloc with cache empty, in which case we fill to 100%, then take the
alloc
2) have a free of a burst greater than that which we just allocated,
causing an immediate flush again.

That's pretty poor behaviour, but the thing is that after the flush we now
have mempool at 25% + freed burst - so expected between 25-50% of cache
utilization. That's the sweet spot we want to target - after each
operation, the mempool cache should ideally be at 50%. Whether the next op
is an alloc or a free, our cache can handle it, and likely a couple of each
in sequence. Therefore, our possible fill/empty combinations are likely to
be rare occurances.

[In all this, I am making the assumption that burst size is well less than
cache size. Also, similar logic would be applicable for the inverse
scenario, e.g. flush to empty (and fill burst) and fill to 75%]

Now, all said, I tend to agree that we want to leave space for a decent
size burst after a fill. That is why I think that filling to 75% is
reasonable. After an alloc that triggers a fill, I don't want the cache
less than 50% full, but not completely full so there is room for a free
without a flush, and similarly for a free that triggers a flush, the cache
should not be empty, but also should not be more than half full.

One suggestion - we could always add a simple tunable that specifies the
margin, or reserved entries for alloc and free. We can then guide in the
docs that the value should be e.g. "zero for apps where alloc and free take
place on different cores. 20%-50% of cache is recommended where alloc and
free take place on the same core"

/Bruce

