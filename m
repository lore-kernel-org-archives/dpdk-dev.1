Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C77EB26EA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 17:26:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 892264069D;
	Tue, 10 Feb 2026 18:26:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4247440696
 for <dev@dpdk.org>; Tue, 10 Feb 2026 18:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770744360; x=1802280360;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0HfOAmIYXy2YSnUszZFu4hrT/X3Jbq6/ZjUUL9IlQ84=;
 b=RNnHwVKPeN0eSIvQp/LYIForQy7VOSH9bKUqNUgz0qh0ayEEQrgA+48x
 QD2kU2/MNvIAhsh0oo3gGxoTzLEI89xfx2tZRtJzGObMv1BLOlwkG4/wX
 xQXO/uTZk4JVaSEYXScZCCw1bMSbmBUG4EPvDtLsLSKYJZGgJyDaP4wBw
 xYjOUgiljmnxbtRlInA3M8/7pPUrIDMJ5bAfOzuMpZNaUweoQX41W3Yt8
 VwVXbXIyJ7c4TfBkXRfKGtTy3IxDBpuE0He3K595Lmrhg40RgwwkAsPkV
 MYjNqOSt7OPFsQeSgFFoWOnB8BGPZZkgiVwOh+GDNFJEoSuA841mZMeIC g==;
X-CSE-ConnectionGUID: i2xq5IlVTZKdXh+X5pLvDQ==
X-CSE-MsgGUID: L1mQdIGGRSWiYu/lUrXRsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72066446"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="72066446"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:25:50 -0800
X-CSE-ConnectionGUID: tnmvpg7IQbWWxvjVqA34Ew==
X-CSE-MsgGUID: QlPp+akmQ2yFH/y/aU9QPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211614242"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:25:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 09:25:49 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 09:25:49 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 09:25:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mll19q8hcl8o/ijofNJVOQUinKen6jIEdV2EwDNCrnYhfkK29V0KX65+v2cqZ5NabjxFq2KrtIKqG9KkLX71k2CPA4qa4ow4bXgqfftazm4+7gDM2UUUl6ICL9GOzlTSoXQjovFsXNcFp1LqOyquT1rqezMEydvgURcUu8qWpMz3hPzfVjQ12SirZNEPBYalLWEnN9ae5UVm6rluBctH7UdOLIYUoV8t/a2OGUBEu9vNbTRdiQJFO6vB85mZUyQ+HF4Xh3fNZwA7uKTgIGHVH57YDi/otld2Q9KsfcQthvQPVMXQe/j9jJjo9O7+smOqynG0MwyYb+fbB9FoErx8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bVKF+184vS4U+Cnn5Z6AuB2aTXgVsngWejsU7xR2BY=;
 b=tmQG9k0AoPCIrdclfIa6S/tGY5V40qQF+Ncns21Tj0ZzLvUrEel+5MyS7ZBFUvksE6cSjlBAuLXR7nTP18y1d4T2aSIU0LLcgqwDcaBTS0c7CBfcVVc0pUxMhpFbE+N022JfvBjVnjOD+jfGjFhOQ44B6zwSjaDyv6TQOk6iE2nHE+ooh725rthq7WsVloOkal0QkFwxeyKXIIZPDWz42PrjYbJF2Jv2BAENUhaZfaoOZkz9cbQ1VXQv6POjZikTxe2LTINT6wfp95BCUuT17GA0rYDjrkx+xCZwMH5UWUWyabT1Hx0OqCiDOe+W/GQdkuNeR5yib+YWh1eeeod6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4941.namprd11.prod.outlook.com (2603:10b6:a03:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 17:25:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:25:46 +0000
Date: Tue, 10 Feb 2026 17:25:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
Subject: Re: [PATCH v4 05/35] net/intel: add common fn to calculate needed
 descriptors
Message-ID: <aYtqFdNmhwGWc3pW@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-6-bruce.richardson@intel.com>
 <cab7ff8b-b260-4339-b0d7-8a139b617ba7@intel.com>
 <aYs73tmg3YBlSXLB@bricha3-mobl1.ger.corp.intel.com>
 <1518516a-5c1a-4bd0-9c8d-f071ae33a8c6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1518516a-5c1a-4bd0-9c8d-f071ae33a8c6@intel.com>
X-ClientProxiedBy: DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: 34722bd0-ee5d-485f-32d8-08de68c96d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Iub+q09F2MbfPZGtPPWa6YlPr/Xj4VK5x9SMK4fZ/bwsBByu1MEDWx2CQIr?=
 =?us-ascii?Q?dZPlEtQpV3leLMR2cW4KOYmgj39tFxxEQjDh0QqiNGCTwA44tR+Q2EuyeO6x?=
 =?us-ascii?Q?ButW24s3n+UoLcAZFF0v6c7yraMFc5puD+h00BEX5LZd5Rn4hJnjWEQR49Eq?=
 =?us-ascii?Q?LBkK2pS/b+bq0kBRbRo9hFOnQHWdjMfJPMDxJRcqPbybQxdvzO3/UJ2QUFWL?=
 =?us-ascii?Q?IW8pzcHYcEPpZxgb8cK7enTauPx1ZzaiavWuL13VpGmPmA7L8LFKag0Rtbyu?=
 =?us-ascii?Q?QAxzfIldh1z0uMup5ccGKWNQpZW2kvNjGnGX5USYE0ybHkROT1Gbtjc62VaV?=
 =?us-ascii?Q?WtBvQPQOjiKSv0GCA9bWKsx4SRl6kejzQC2LW+OqlkTQZoFy3pbJghtkpWKF?=
 =?us-ascii?Q?xH8gDLZrW0/+r2fcswmpVdsghG6/ZmSNm9XE4O/VywomaLS+RKD4uwHuMx99?=
 =?us-ascii?Q?F7MGmEqVFh9P5oCYkbtuub/VpwcUaLbZqNfvEYap0/WlgrE1pGMnhDBVekEH?=
 =?us-ascii?Q?4Pkcj6p+0x7fwjJ+AHfgOd5IeFofeFQm+YqLU++k6pQw1dVplcBphDHzQztF?=
 =?us-ascii?Q?qKkaihwj7m/brx1GkRcX6KuxKwcDsphBbVO0tpZ7iRxWzj6PrFcsnIWPDzMQ?=
 =?us-ascii?Q?gzAEMKPxkZl0JeUE4YJVs/wf6PXINLGQH4+bKQtcW0KdXkRjCUF974G+01qR?=
 =?us-ascii?Q?/U5jIxuxre82M/fEJZ9t2T9b/rIOTER7XybLnX0rXC4h0knrlc1VFC5azIAx?=
 =?us-ascii?Q?f+6Y+cs9XP4fUi6kv9jTH3Jh99pg+5KDbj2Iv9GkBZWN87l/ZsyFuK6MNnD2?=
 =?us-ascii?Q?9nzL6Cs6Z9JjuDbZBAWpSTgkUZRhuXZiibKdGFQR72D8pYi7LcQovtLouyjs?=
 =?us-ascii?Q?8hxxgHWDR3pO0KC4Uk9+ztggb6NX0dAYctes0gY0NEaHPkTVMMJUuxhvB07o?=
 =?us-ascii?Q?vj3llmB9h8Jz1X/49YS4yDIjWCnJ0XWpZgcC6H4EjcnhitDE+t+Na124ExKS?=
 =?us-ascii?Q?rps2WfyFQKBGT3tP+0ilAQQs6J688bCPPhiLxgqgBPHi9G7lKohJoaKsuRgI?=
 =?us-ascii?Q?5M4ERpn5KQjsAkm2Awfc0UgWTEq4To/cdPRe5By90KGAspPVXQwOdwV5NPud?=
 =?us-ascii?Q?e3ORJPxGIubsOs4Y1T27W5iI/s0SgQp04xJdvTn0M+QwZg4fAspYr0ENVyab?=
 =?us-ascii?Q?zhz9E6bPeopSEvzbsG8777ZjSstbdcdpuisTO7BVkpLmnKu/SH4n/4yxNNsi?=
 =?us-ascii?Q?KQoC5osi1yvHtjkqJbhU6Q6+JAVNYcISZT4RoAImurZxRXzH3LRHLREGyrUZ?=
 =?us-ascii?Q?LH1CPu/aigcNb/EV0a+xtNLyi/Gem8e/Z1iESLcGTnySF0KjuhVbrQ7wi0ix?=
 =?us-ascii?Q?TeCMDHOISd6B9VRHi2YMF0iFCqZqFDURSf/wxHTqsbkk93Q8FihtVzLKwks3?=
 =?us-ascii?Q?DR8rblYd5QEGCOmGE/Hq16owANO7ph3Y2A/+erKj0jmPH13oYyesM8TKhLjM?=
 =?us-ascii?Q?DXZco9UR1XgBQzEPtl4yp2fix4jYfs9cT0D+12TwX4IDKkbO+Hob8YD79Kik?=
 =?us-ascii?Q?9EpJO/4pVM5Zl7w/hwk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wNTkgJi3kU0K2ZBEzU9f3YgkBGYOoSlkt8nNecj8to52cl0LN+vrla5RctuN?=
 =?us-ascii?Q?JKW1lkKgUxwd0s700ncRWY4lodfbW/wbo7ip5lTtBuwH/0HQMJmP13mL5Y7e?=
 =?us-ascii?Q?cUvI35hH5ZtvZBTSw7I+oPTWNnr38apwbbuwNrGmjr+bSYBiApY5uXs5YHfa?=
 =?us-ascii?Q?c9HWi9/SroWuc15/ABqKvzaAdslYdTkY9h9XzKcs0l9IZ9sz2Tirnof1hnoy?=
 =?us-ascii?Q?k86EXmAa5rFxKJXdFbJUv6VS7RRSzy3R42w2WCe+s9ElSLBuUQ2dJLAnOj03?=
 =?us-ascii?Q?NiaSIxRRRCA/QhPsLqreeTrZXrFn44FdLh1uzuEdDZpeKh2PSDQMNlHTiXDh?=
 =?us-ascii?Q?C4cRa1SiekYm0fBybGxEh+xqOvDLR1wolldbpvn967d8srMFSIY145AN8vEt?=
 =?us-ascii?Q?7eQC2AEFwIAMqVFWTGrEZ3fJO8R+jHM/OYfhZmDgZveAnzdy6WvG41wn7+dG?=
 =?us-ascii?Q?Hu5bMqbGIUD2xvqi8eXSWAAWGYwMmtD9bhP0ZI2tnTuJWMg1HooHrcjB3lf0?=
 =?us-ascii?Q?+mZXVJvTt79QdKSCWQ2fQtiRO1R44PECjYaYMzQ3BikVM+WXbRE59q1llWwC?=
 =?us-ascii?Q?CWTPRYGrqrJKddbUUmj4fi5KnKO7h2Ik8aXZZbkmdle1/mUOdzPecfayT1eD?=
 =?us-ascii?Q?+I9wNrZvs3IYiT3ghapMpxUNTauUhw39HkCNNfMFh1W8K4ktcg5z6ANQIhgH?=
 =?us-ascii?Q?RRZSjccyfrOmyFUQwIOPzHk3m6PEzWH1JywYOnjT6DbXik79ocXvJqXF85HZ?=
 =?us-ascii?Q?w9bQtDzJ0N2ZzkBrDTqFOjWRwGccqOykay5IXj0uJ/t9siDsDZ14suEp7WD/?=
 =?us-ascii?Q?kKYaYfo3gm/BPHh5351vv3/if388kg+wVWaGSs+OlorSiW3lSYrXzEGOmLya?=
 =?us-ascii?Q?MTQysh577jhicQqO1AONxpiErnpg3PGxm1S0A/BK6XU1rBg2tje2Y9AfKbKt?=
 =?us-ascii?Q?hyMJbaJRpWU/DpgtrcOPyB1Ges7KFCtVcFZ818kmGmbg/2GvuWJVzN5Bkjm2?=
 =?us-ascii?Q?qGX4g+5ky2bYDP1t7vPcotpSifsHACrz2NrUjBBOIRzZjPGUw4yU1D+5p+3F?=
 =?us-ascii?Q?vdNsXCw+ehrri5WyR1LSqtcah1jNXVq7Ep+pm9xJlDfgNGydog3jtvbKIzh6?=
 =?us-ascii?Q?0JMk0NUarJ7ttU2yxBtZtQrIONl5k4mA1V5Q8/g28+zXN7ySK8zWcFnIRdzh?=
 =?us-ascii?Q?UpBoXLL5yeAG1wE+zNbpbWq0dCH0gU32EDTaw99ndW340xa76aLTp+ZIIe/I?=
 =?us-ascii?Q?vrt7h1mtkA5NQf+y3Eo21PCirAj6T4yCKvANLftZ3041RK6Ylp3hfhX79HVn?=
 =?us-ascii?Q?zRK/YXxpcCWy/ToWXOH9zXq1JqjQGwXu5+sGenOHaVIlxvwG4X2dbgCHqYkH?=
 =?us-ascii?Q?581N+oozd13B9MQhE/JqMH1eBOnA4+UP+iF0u5VzVexyA/jw1C78hx3zzsIo?=
 =?us-ascii?Q?wpyoAWHKTxPhp/aOM4xvzr0r9f1F4sRuXUbMCfFjHw9Mlxkq4TD8Phb4KVfc?=
 =?us-ascii?Q?o8Jpj8VhEx1JHNeYdWRog8NW6YMo2qv8tWRM/GeoCL+I3cY59Qr5bKAy791K?=
 =?us-ascii?Q?AAfLk5EHUNzafQoHJNf/waYsQQgFOspvC5mPtcqgf/B6CmyXT0TR/zXWwusi?=
 =?us-ascii?Q?WgY6B+49K5DZybVcC3vrxAM2CgIwzdP+vH9n/oTqyP7ipO26HymyUSUmPOo/?=
 =?us-ascii?Q?7UXzrIMwmwGmGTEM/OMGv0Esg62OEYHEvCJXOVOF5SKQ2AC8EcoOveMkD9R5?=
 =?us-ascii?Q?sxQotvGOQYB7IVdVWLAlSWAHY/Cxzww=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34722bd0-ee5d-485f-32d8-08de68c96d3e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:25:46.6252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YluGf32lJat1HVyiK5iwARqsHIdNWVJx3f1S6IpTIPVMepXHaYvustr4ZYOWX/SrnUCmS46oF2g7ZaF6zbOHI/R1BUgU3GwRzx7l5amfXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4941
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

On Tue, Feb 10, 2026 at 03:17:32PM +0100, Burakov, Anatoly wrote:
> On 2/10/2026 3:08 PM, Bruce Richardson wrote:
> > On Tue, Feb 10, 2026 at 01:29:48PM +0100, Burakov, Anatoly wrote:
> > > On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > > > Multiple drivers used the same logic to calculate how many Tx data
> > > > descriptors were needed. Move that calculation to common code. In the
> > > > process of updating drivers, fix idpf driver calculation for the TSO
> > > > case.
> > > > 
> > > 
> > > "Fix TSO for idpf" sounds like a bugfix? Can it be backported to stable?
> > > 
> > Yes, it is a bug fix for a particular edge case. However, as done here, the
> > fix is implied by the code changes in the consolidation, and depends upon
> > them. Any fix for backport would need to be a different, standalone patch,
> > based on this.
> > 
> > /Bruce
> 
> So the original code didn't have TSO at all? I.e. this can't be fixed as a
> prerequisite patch to this patchset?
> 
Original code did have TSO, it just didn't support the case where a single
mbuf segment had more data than the max allowed to be described by a single
descriptor, i.e. where we had multiple descriptors for one mbuf segment, so
that "nb_descs != mbuf->nb_segs + ctx_descs". The other drivers all solve
this by having a separate function that iterated through the descriptors,
and to fix this in older releases would be to add such a function to this
driver. There is little point adding that function in this series just to
delete it later here, so I think for 26.03 the fix here is best and for
earlier releases the best fix is to just put the necessary code directly
into idpf driver. I've noted this down to do a backported patch after this
series goes in.

/Bruce
