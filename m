Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C3DCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 15:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BC1E4042E;
	Mon,  3 Nov 2025 16:54:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 86CBA402F0
 for <dev@dpdk.org>; Mon,  3 Nov 2025 16:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762185240; x=1793721240;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=l5nfipG61viYL1S3i8zom5AjdaJEnrnZDEOZnqh+5RA=;
 b=OUP/zCJz0E3nXphMQ2v1Ec8gjErY6/AdZKeZD2BxsA4ZI1qsGVYexrhE
 cbAPR6qbTq+cMOXcD2hytChjqU3E59bdTxnY8iXJnZsdKJHAsrEUjyCiE
 NRJW19S602JJp1zfG6Wm65fkoXo6ShlzfVSO1h/Q4JJ1cVrQU84TeHLb6
 k44YPr/mXh3SKuiSTZTBwXYVu4l56wMibN/6iyEUbX1NNluznpgrTxyQr
 kjdv6t2LC89ZPSfOdORbGsDZ5ESGXq0CkJXI5mVaYudQIR1vUx63q27MZ
 rmdnIxGTX0n/d1HPJvrY5ZO8RKItdGL+l9bJQpRfq/wnXL0b7UsClM4Lm A==;
X-CSE-ConnectionGUID: 0jfdyQJ4RzCyb4z+CDfEcQ==
X-CSE-MsgGUID: ZUM6cuV8QeSMXlpFi9MdCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64300729"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="64300729"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 07:53:55 -0800
X-CSE-ConnectionGUID: tUsbsdf7RMO3c9qmhvYcmA==
X-CSE-MsgGUID: nFTQj0muQXeInqY+0F9RgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="186767618"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 07:53:54 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:53:53 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 07:53:53 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:53:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twTwztkIy0nPUbdw+SrdurYCdwO2lnD5TVwEnbjT/6iTOLGEEr7j8wLvs2HGpnO9gz888lTVIlfcPpVjCHpv9be3te4GWa+FJ6urfGgTnG/uYLj6CCEbAgIwevgFIcZXZFL3fRfD8JTzSa3RrxUlzLgCoug7sp0ZkIKPoqKZ1FVO1Y0BAgN/p7m8FHeibNesBwzLtKAWFPj65Qz1izJ3IUNOnICr+44E3dwBkQDRtcBy1+gcyCDdesVHc21Dpos0aCr6mgLWslg3RSUh0jGg/lZUsT84rE/71zXQ8yQ2Qjzg/fYq7B/Y/L4tRB8B/p2pCcNXuNyTfo6KB5eClvrP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gR7gxN0u1ADsu7awZuU4mve3SE1vFzgDJhQQhoTad0=;
 b=XpYISvSDpYjg/xSfJMNmnJ5Xl2nH0eugz7/XG+0LGCimjKDReM+y1E3I61CC+XYionNhz8DikWWnkd4ttDbUpIX4rXqxQ/ZbEPBN+WIdVi1tY4BoQ7rxhASXCYB4SEryNO/VgkBsWT2R2pfCLlFe9cO2kyB8sBcsTfq0pB5DePUgyaPzM87J8ZDlT9pCIR5byKwMV0tBqc9Y3k329behKhJD40vPbVJrr6PWwNn7EftxblJ6wpCRF+bmCTxWCRfdp7jfeM1du0CuL1E6HFc864r1aRjyuqDCCDUy7w7CpI/9EMocIL7NNODYZmLMZ27ttcXHFM5Dm6T9vTPqqVV/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9057.namprd11.prod.outlook.com (2603:10b6:208:55d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:53:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:53:50 +0000
Date: Mon, 3 Nov 2025 15:53:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH] doc: update documentation for ICE DCB and PFC features
Message-ID: <aQjQCcMPUL2FoHsU@bricha3-mobl1.ger.corp.intel.com>
References: <20251103150237.958606-1-vladimir.medvedkin@intel.com>
 <aQjF_6Gne1Wpk1OM@bricha3-mobl1.ger.corp.intel.com>
 <a208388a-4db1-44d3-8184-f2c3ea355a65@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a208388a-4db1-44d3-8184-f2c3ea355a65@intel.com>
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 8087da21-ecd0-45cd-c307-08de1af12e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YtiEbApAKyXhrDoFXOPEIzsLSzsq/zxRCpVpAQev24FUwsL67xnGhYZnts9C?=
 =?us-ascii?Q?mKPnQgNYFTwMcVVKwEmw7yUENWWvydbVTYDfeVah6mSeVIWmN09EFOLKWsnQ?=
 =?us-ascii?Q?q+QYJ2TttmlTqSGGazTZmIaI0mSvBxwDPg0C136uvEUcH/7E42d5G2QU8E6Q?=
 =?us-ascii?Q?C5NSH8SyaUNU4Aby4Aj+MDSQCM2OHhyqHpjydePiUFuYwmAn2TSKyRs3LCMa?=
 =?us-ascii?Q?CL1PwtagQzHL+3Aj+W+7KcgywZywGMQAsspXoz5giGN9y4mmu9vyqZCMvIhz?=
 =?us-ascii?Q?OFHDNt8aHVeXZp2noYKFDMIosM/eWHKynh+ojOAxIkIucQ4Wk0RLXaM1UfqB?=
 =?us-ascii?Q?SfUgR9JMbcWgP1b3tXDwfUp8l+JGExv/Kcb30dzRhGulxnl0BDB40RVrSpVE?=
 =?us-ascii?Q?KVN7L+9pVexaiZsXkefbOq+5vGVkxOhceFTIZ8t0EB5KBVsrwUrARPyqVd+Q?=
 =?us-ascii?Q?gYt+JJm8rkIgzTSTV7r1BPniNnpa0YBjGOCrsBun87PbCp5VLO+ICaVLmRwv?=
 =?us-ascii?Q?RXPqqQIy7o+YiRFKP40JKhNr+0gTXKP1lkQrDJap9sRHlFaP+o16AX+piTOk?=
 =?us-ascii?Q?Mm3C5AifZj9YClcOh6DCnaovS/l97F6oL2S+raBEfgVuCX5esxyEvLlsb14U?=
 =?us-ascii?Q?ifAp48H5C+sP3Ea5yOayu7JNWiKYeW3nsk7CRqwLV6ckajVsR2MGI1fyF/f/?=
 =?us-ascii?Q?435xu7Omwk+LzyM1dToJv+dJ3pO8xSWyHeoabPstnAgZSWjAsEJgR8qQzLZq?=
 =?us-ascii?Q?5O9x86P2C5mz962E7maAiKgNOphnm1r8WZ838UfDmDqwqxCD2xHWA1aiK9/7?=
 =?us-ascii?Q?cURbiouvjg0wgQQChjK54UAlf4vb6Tl8Wvs5QLny4chPzAUEaQtBYXPjBRwQ?=
 =?us-ascii?Q?7If41h0ZOOsB9EjiQMpe5+c5nH+q3HKqnhf28XiiE2SS+mkN0GHVNkPN3g3S?=
 =?us-ascii?Q?1Cs1Z1Xamy8BX8Xt3Sx7aFEr8Eg1FGr2rQWNohYWQnbmb1PhaCS817WbECZM?=
 =?us-ascii?Q?I7zU0jBv29VUQ7LAyqxg2u/P0PA6yHnuFLwTq7ostbZeLN24ZiCSrv9S7Kdv?=
 =?us-ascii?Q?xET0T16z19J8LKYMgoWBO0mV+XefCuku/2ze/ECDlK+DpJQeTlsK4bfIxtef?=
 =?us-ascii?Q?o+CT278gaHqWgPI1yzi3WrGpP2oXmCtXJOtmTUGvNQmwxDPkJ7eqUv7vtCMz?=
 =?us-ascii?Q?FBQzAiUxV2AU9lB8sj0J0aZXOurnbEeilnQIW2o1VNxll/ydol0Tn0jWQAzF?=
 =?us-ascii?Q?MKQZN2h6P8LVFJDx/5LdJt05amDH656YezyCE75sD/FqxfzK3RMivncDeRp1?=
 =?us-ascii?Q?4GF7Fj2c8FmmTAWsTdyME+r8lRjeC2BohMl/5Jmk0/tT3ZzJ6c08XjZMU8Ls?=
 =?us-ascii?Q?EBBW7BRHFdjfOfRY3bFj1EHtRkQc62g1w+jCbrV81/OWL1jbplfT8/JQDcgy?=
 =?us-ascii?Q?81z7TiCBesl/IEt/DbY3B3KvTkYzDHu6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQXse6kty2DEGVTGFR5jyOJWm4c69M+K7B5DJW/yQ9wHGeV92CGONtqncokS?=
 =?us-ascii?Q?tM0M8dFpBcduYYg2Q3BEJ/ev49ZPFkFNZH+yfpvBs+Jm035nSkUKsIDfPqCM?=
 =?us-ascii?Q?TruWijVwBIFRi+g2V/oIdXoKQOe+e1IlZS+CVrOT/PNITwc/EbDcY+vVNKCN?=
 =?us-ascii?Q?O1sbXd7FDt/uaBy4OQOeexT6rY30omElW9XFt1aJ8xfVfaWv4SxxKxLZpQrJ?=
 =?us-ascii?Q?wJtfkP3OVtpIV8eJdpqe23ibyiX7jVgdRraiK5hzW0RjdRaJCDq1I6sfxwW0?=
 =?us-ascii?Q?89I8kaYHkwaiqFH73wI+1Gz/Py7+SsvUJ+ZrEZwdv2HGVJfWMGYe37SEqdft?=
 =?us-ascii?Q?amkiBv0x5qZmPPDqKlb0hFjK8LL0iGYgO11TDHMwmH7LC5pmbEQMMyqgr7fq?=
 =?us-ascii?Q?Xp25CehNTKKNWMIgRwlCnYk2oIxgUNCDKsGE42JojoVlj2yP9WIC4jb2wl2d?=
 =?us-ascii?Q?HEM7morabkAZTTqHRaUZ8BA1Oq9yIXp/uRUtpDVBcuRdhml4QvlZohrScxpj?=
 =?us-ascii?Q?01iqeuQoVWuB3bFdLh4zLL+DJ7zFBIy7O4pXfilRyCL+A+Irq/jiFTWIOjYJ?=
 =?us-ascii?Q?6KQ9nQXFt902V8sVLSaris1gCtmwWBIIGa3H8+LZwnEnREJ5NuuumzdN4wj3?=
 =?us-ascii?Q?GEGQmLpbqGX8kNPh7TmTZiVZNWu7PzwHEjJcoJGgC/TDR9KzjAbGXMQN87bB?=
 =?us-ascii?Q?FaAgyZkIf9WnueFlgh1/mx7Q+Q0Q9e7mbvbvRkSHpRom6T1aGvE9Gjk5iiRM?=
 =?us-ascii?Q?JMv39b82sFquh9obQB48qvi22T1jl86g/VCrkJS8hPw5wTtFGGxihCWOlS2a?=
 =?us-ascii?Q?XbsgXx2asIZC2KUCURnXMUTTZN8FyJrdPa04wdqT98NhdEgVoxLYRlvw+G2R?=
 =?us-ascii?Q?WXR9NfVXCGqd6mY0ZB718IaO/izzwDJsifALKu4Mzsmwcis3tsmB65cbB70e?=
 =?us-ascii?Q?VYjq3PaZ94wF/iY2au5qOHUOO7xG6TiwiYNrPYBqsUDJGh9t0fLlMa6axTUC?=
 =?us-ascii?Q?tNdZbHkNHWrBoU7Od9gp5f6gYQ/wXLcNrHPp/UmG6KZdErT3gIgJX9Eumv4W?=
 =?us-ascii?Q?VwZHx5woayTlFTBKmxzYi+LdWTl+g9rtdBJ1utyZ/otjXF9p449GsgvV6rsC?=
 =?us-ascii?Q?KFbIUcBhlcDl5J9iKZ9RNCSUIPNVw7rq8n/I9NaiKUvCxQaKmnziN25wCo0C?=
 =?us-ascii?Q?iHdpycrgmB9hyM6CxyhzHNv6P9/CkV+PhpJs2pToY0jygO0u2I4PaUeH1VWh?=
 =?us-ascii?Q?TMXC04IImSiZ0A2pClQC02p74t8Dp/uYgdBgVODJpJCjFTV/xnSkmGOymL2o?=
 =?us-ascii?Q?ckeSUM+5OuZIL7axWDLCJBcguzMroGQvwi5MVvj6/U9ooUdU/1QlRxhygrYK?=
 =?us-ascii?Q?pqu1FttP0jF18a/xeh6L8irN2FONaWHQ2KB/TV+YZq59FxMamatiqIL1jEGm?=
 =?us-ascii?Q?kNL1+2r23D6peTExAhhFomuNrLNmEVh5OAtKsthHGvuez+QtuEMHN/mU/X+/?=
 =?us-ascii?Q?NgnW7cH2G0ZGsKEnw4qPHNsL0GuSFCkcukcuwqd32RxnCRqMeneINotJQ4c3?=
 =?us-ascii?Q?UXgtc5AHy3CUmLyuzqGaseVZRybwYozcsJt5jxg0ZT+31jDwe4/tMshBHOy9?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8087da21-ecd0-45cd-c307-08de1af12e5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:53:50.3117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pngk1W1QYkqCeJWKdXcegunmFNcvVBWsZZCjlmn1GBa36+wiUK30OOjMpT0+Qe0JZdoGXtx4gk5mgoj2JbTH96eZ6/QHkTDLKqnxbbfAG4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9057
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

On Mon, Nov 03, 2025 at 03:50:59PM +0000, Medvedkin, Vladimir wrote:
> Hi Bruce, thanks for reviewing, will send v2 addressing your comments
> 
> On 11/3/2025 3:10 PM, Bruce Richardson wrote:
> > On Mon, Nov 03, 2025 at 03:02:37PM +0000, Vladimir Medvedkin wrote:
> > > Add DCB and PFC documentation. Update feature matrix
> > > and release notes.
> > > 
> > > Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > > ---
> > >   doc/guides/nics/features/ice.ini       |  1 +
> > >   doc/guides/nics/ice.rst                | 74 ++++++++++++++++++++++++++
> > >   doc/guides/rel_notes/release_25_11.rst |  4 ++
> > >   3 files changed, 79 insertions(+)
> > > 
> > I should have noticed that this was all missing from the original patchset
> > and flagged it before merge! Sorry.
> > 
> > Anyway, thanks for doing this now - better late than never, as the saying
> > goes! Review comments inline below.
> > 
> > Thanks,
> > /Bruce
> > 
> <snip>
> > > +
> > > +PFC operates in VLAN-based mode and requires DCB to be configured first.
> > > +
> > So this means you need to call APIs in a specific order?
> 
> Yes, first we need to enable DCB with rte_eth_dev_configure(), then PFC can
> be configured on each individual TC. Generally speaking, PFC is a part of
> DCB standard so it should be obvious to configure DCB first.
> 

I wouldn't assume its obvious. Maybe have a combined C-code example in the
docs for configuring both.

/Bruce
