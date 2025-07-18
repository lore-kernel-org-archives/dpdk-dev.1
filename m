Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245C0C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 08:23:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE2A14014F;
	Fri, 18 Jul 2025 10:23:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 28B704013F;
 Fri, 18 Jul 2025 10:23:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752827026; x=1784363026;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pgyFd6W128jjSN3g/iwTSYKDEMyYf+BcLIqcEsLutsQ=;
 b=YBCIfvOEMzHKe081sFDbesQYLlsUbu+RMCaUvnKU2EwtC6zjEGQD5CIp
 YjJ7f9fdPeQcpfzqTSeTH00bsInOl73KA/x13fHPA4vejXk6TRySSJnXD
 oC2olmISRF915VFrcnFccX9ukqxalPeIbdpPRO6oIlS8E9+mow8tsKMup
 LRgsYMRigKjsF2uzdN54o6FCLH/yh5XfdeK1ZCm+PU43y1pmzcbyXA0Di
 lte9wAB2N7aRopDiERFfqnHMwTVPpBDT9DcQjAEGVKmCv1bA8xLvwyfJr
 kBkZP0PmgcFzJacToYk2vSSAKA1qrKJf+fiaLop91y3GM1VpoORhDADOT w==;
X-CSE-ConnectionGUID: q7fVXuaaSrisLGVoh6kM5g==
X-CSE-MsgGUID: wBRrT2UUSIa7d5iE81m0dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="58780541"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="58780541"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 01:23:37 -0700
X-CSE-ConnectionGUID: v1DT2JFBQEmIPy6YPHXUFw==
X-CSE-MsgGUID: 5KYTbJrXSPWQXAtDsMGBRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="158082694"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 01:23:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 01:23:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 01:23:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 01:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKVSLEWQMBorBFWUppvG9MfRar57LwNqsb/htUda0GYFKkE18ypV/8ypQF2SIV8TtyoCizkmwhuXoxfexITvr0hznYh3m/6TETptJLihIChWy1c4BEFsu/LTEiLtybd+iCDJCxy6xvpKTQF8W7k8Ldmrc7Ocf7RCV+xY33JnypTJ8Ub8wWEZ3OnlQjaicz1m5/fWExdchE+Os3n1rhYRvq+BEC26EbKJggojIFuuPpD3YW+JdEsyHjAL7UEid87Iw9otPXmKUP8xioZxB2kxCnWTlq3XDadnbN2Hm03zp3kTDd5NFf949oNlQ5ezVzRl3mvb2BTYFAETwnn8r5vZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFtqpjkb9gvOj9pqGajPYXHAq2Hpm7TWxj7K9F+HlGU=;
 b=czRPCnDSvCXu/g6SHS85ekZCduSW15jlA9s113BBKc953bsbhYN5AuaOFZOQ4kmd+soe0ZcX9p2MEVjSztwC54ZTRf4XSXDGP7qCACIjo1arw7JCq88YHXyOyvYSyPrDXZcVVtg0WbKe3IKzPBKO0x391vOJzNJn+uPSs283SIYMKHMVWYK2715FFGm0wu2ucEzd0hSw54YpAc1LDjJPVR2PTSh+18CF+cVgSCDUqSlGE+Wu9vCeDgcC1+BlYEP+vF0Q9AA0UHMw+3Ly41OA9DHfc5NWyVpe1j9q29me8x1HwPqnq8uPJTJrMBwDi6atCDn9wgWrr9r4Z6Rynj5QGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 18 Jul
 2025 08:22:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 08:22:48 +0000
Date: Fri, 18 Jul 2025 09:22:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dean Marx <dmarx@iol.unh.edu>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, Dengdui Huang <huangdengdui@huawei.com>, Vladimir Medvedkin
 <medvedkinv@gmail.com>, <techboard@dpdk.org>, Patrick Robb
 <probb@iol.unh.edu>, fengchengwen <fengchengwen@huawei.com>,
 <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aHoEUmesrg9Y8qtM@bricha3-mobl1.ger.corp.intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
 <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
 <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
 <CABD7UXPccao=o1O=SessoAdEKUyA-dXP6HG5mnkpFSVNL_3dxw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABD7UXPccao=o1O=SessoAdEKUyA-dXP6HG5mnkpFSVNL_3dxw@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c06b3fb-dce6-4bf1-8992-08ddc5d447bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HznNp4Z9kxJcJlKbOXtsMm7Jd1AEPPP//gRiUPib3T5zUWWRgYkzPuu4hCo+?=
 =?us-ascii?Q?y673w/Qe5sFNJKGIkXcFZFl4+WRKPZUGWYV8sv0xP04k2yXVXWsINkjbvKpG?=
 =?us-ascii?Q?+02/aBtsK+vc3XXX8M9imT9KMSEQ1kj5+s47jjmbIl6QV+73FnlbD96y/txT?=
 =?us-ascii?Q?VYgkmcvuYWwGHAkknMG4tgBOQtTP9aAVUZirNcz//rJc6nq8Qqy9Uqrqnj7+?=
 =?us-ascii?Q?0Vjr79zmpcGZpIIDgOStJMO7YDcOtqnKoNXvHsJSNC9RO6tluCIpdXbgopa9?=
 =?us-ascii?Q?SVEQbZSwGt4s3cH/39Bs5FnPOTQ3B4aD8LgiKwEVU4LOWzb15NUPT6Vpotlb?=
 =?us-ascii?Q?yq+3CPGuxh2LT7GDftCSKZJuMGQ+2Uh0hIzdd1xSucadZkBlfh9e4awQJNPP?=
 =?us-ascii?Q?CbdRmD57xma6qMKGfGH6bzCjIOO/GcgeQkDzwkoe8TNo3B7VmlDoTgcpcWN5?=
 =?us-ascii?Q?eq6UZSBmQSzdc3rEMlLyMTB0rdK+QdlGC4+EConQoTArrgJHvTVrJO55V4Lx?=
 =?us-ascii?Q?YW6JorCY0rOIGa2J6hmvt5oeBvTTOeiypsK0f2cDjeIQa/Ziz1PnlTk9Ziri?=
 =?us-ascii?Q?Whi+J+dTiUzDlQYO1BHFOIM4bmvc6SLwJ9LMlDDkBN+DSwh9TUzn9c2emQxN?=
 =?us-ascii?Q?wuAR7MwkqK95tsHtIk4yj7HY9ygEtT9Tn4a/XDp561EVioBGJJxr2OaN9U17?=
 =?us-ascii?Q?vjg0zIYajiByjDA1bmWqR8609wk+9ba/OnLrtoHmzfCwWeSEAb5JAOT6FgVS?=
 =?us-ascii?Q?gQ4R4s1ygVdicBRotS4G7u09ULSDcaqE8RM08GvLln8nWYLwzG2HzUz9jqRj?=
 =?us-ascii?Q?Ovl2Uc/AT/DEWjNwr/W0tfF2RTykZCPIP4SGANBzt/AcMYdw2Lg9+auDYwIc?=
 =?us-ascii?Q?9LSOYNpvnSFs3Dw6kMRc7YmDJZMga5mICvIZgUJRVLGWMqrOp8qqU1Cb9f25?=
 =?us-ascii?Q?u4N/hoeC8ZqWd++yg4SapTKFlgmrOGNh/3CWW1WwjuhpWpodEtSTtKJLiylJ?=
 =?us-ascii?Q?ZsEir8AF+9LtB2/vBJ/5afD+psFd2Q+wHweRHzah01TVvT0QMvhDkajtVylm?=
 =?us-ascii?Q?UmfupQIfxYivU7NSa1o0v110Jhtmlnk9UPqmGGQju0J7bh0IzPpvFKk6enl1?=
 =?us-ascii?Q?7yIBecwbvXekDpiX1Ch3sfAX4HqtPmtQF2+s5ZQGNFCUoZJc5Kc1YPnuoxie?=
 =?us-ascii?Q?IlzGPGLDnTSoKiXa4nD7frh2JdX+PG0kBj0Zp34zLTFZHR1fa7Us3FVgcj6H?=
 =?us-ascii?Q?ixYq5eOLQ58biQjsk5Jjt5pz0HGj3TWEcovvg3VLwYG3vI7JgGwzsx5QwPaD?=
 =?us-ascii?Q?eWMdD5O8qcoWv/Ni07HqJWwl/CsuaiAwMHql7nLMycyQG/38o9Yz60z/uPZV?=
 =?us-ascii?Q?yZtaiMwRLzxTwhQUQR4i6OEOcfReKoIHwSZYmK5mluG0RT478PVOW8SNF3uB?=
 =?us-ascii?Q?wxSB4t3r17I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SAFZKBrRQ5L1ovhJyQ/xb4zmyZIWllefT7K2Lqm/ySy477nIacJRx/9Wb6hu?=
 =?us-ascii?Q?Srrvi6Qt7xOjt1qPGkt0wzcuit0VYlt3zRk4bNTmDpSgoolvSj9WuL19kc4d?=
 =?us-ascii?Q?XxABiucthgzaVRhhVCq5zox9o6S9+JrLho1sLFnP1Qb87sqgksmlCvA1DA/p?=
 =?us-ascii?Q?/sasQlolcqZqw2kxn+TXLRbKojC6/1G6SUPO/Uj7VbahnuHGR3fqxmOcAhMT?=
 =?us-ascii?Q?Pev9n6pLPeDldDp3qgB8+r7hoeerYZkY57WxvPpwKdlzZY+ws/tjnFT3kpfd?=
 =?us-ascii?Q?IfDF2Q81pXhCB4oQmGQHqcveWBs6y+FOekhozDOHqSuK+QygPyFCvcaBsLYo?=
 =?us-ascii?Q?bOyOPMDOU1OirmpOL+LzxC0evA4p0eUWTHE+WzRzDUIF5XG3Sg4Ut/USYv5U?=
 =?us-ascii?Q?WHv01lWwNnBckg5Zb7t7qIhaXGr6h960fRF/cIQUQ6JxpcCkhnoH4zFINf71?=
 =?us-ascii?Q?vD0lKs3QwALqar4fKUAFnylbdIrGoWrj4acKI2efs6uGzz0L3pSERFHlC/fG?=
 =?us-ascii?Q?XTc6xk5dWeHe2XsMaqbJ29lswN3MVeHqDd6bLG34opIF7AwF3zNplmwzt6c8?=
 =?us-ascii?Q?oIb9ob4fE7+M7hCuN3e7RAe06Pxr3NsgnqOEx9CmLHt+N0zEH2HNhWgoYEyU?=
 =?us-ascii?Q?I1WDn43TY8Hkq6eeLQRNl9By/U79LJT2vzY+jH7XHYnzJuGc1gvg6wUg0xcO?=
 =?us-ascii?Q?aH0/Im/F/FqHwCBUW/Utl3cxIPaBTOhQOejJ0Qlqcge+q9PPyi2K0EdOhjVl?=
 =?us-ascii?Q?VW/5gOGtewCKXMF+jykt0ezzoggQfGbqwVJQC/5bQicpMKE/ja27Cg/lyRUx?=
 =?us-ascii?Q?K09yXjbQw+XC+b+N90DKzIPHsssZC6I8bhZ7L6ucjQXbRNBvjaUjgcmxszPz?=
 =?us-ascii?Q?R0FJ0+CSC9PwaDae24CfNRqE6LGXO4kEByCPkmKq5DEtTDF80xoLpE0pv/vo?=
 =?us-ascii?Q?SNJZKssZ4Aj+Et5iOAgqkBuGPBDNWPTK8iqulzy2wAP4FuEbPAs2ogwWGAhK?=
 =?us-ascii?Q?C1i9pAR4kjoxDDFt14iJgVFLWm4xYY6tPiWfv5HDCP0xpOzhjs5+VDBOwL4c?=
 =?us-ascii?Q?NNI50KARqCtKVf7ZqSvCj75kyKp4oA2lUtVZulRCEZ/o+DGAeE+cuLqvip8U?=
 =?us-ascii?Q?PaMFkxFT+PmNAXtIiRWGIye36OjwNhGmeVMYgCG63SXtrUJ3/rR/U8t7qejg?=
 =?us-ascii?Q?yo3i03IMR7kA7+JfBQmCxZ7Xe+5q30fu8peilbVCTmNyfF1kLuSCdkqE/RXH?=
 =?us-ascii?Q?YMST1YuB/R/WhC4xKnZqx0Clg3QTEOSn/dprIMjTVL6Wzocg3xlG4ew2Znkg?=
 =?us-ascii?Q?nnmb2N3hqKgSADpcZJ+lM1ktZV1+6PkNRc0E7U7hsIqIgwGYVB6Voi5qlwO3?=
 =?us-ascii?Q?BtGg8uKAnt3sX6gfUDNN14JzfGdwo8KXluwPFsmUv83q8SGLidISSn+cZGJZ?=
 =?us-ascii?Q?8ydkYucwQghj8onpecffzCb11NvAJpLE8k7cZpI6InbnbttLeVnPipdAfmCK?=
 =?us-ascii?Q?TNJX7Lz1kM+Pr174E1pMICb1kB+yXyQDaLWPl7cJwfn8ygQPaucLavvKiVfS?=
 =?us-ascii?Q?LMwKV57L7z3tqPvfta+PLQuh+Im8nHpJZGcDHUD+BXKzZTT2L79OIghHwzjo?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c06b3fb-dce6-4bf1-8992-08ddc5d447bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:22:48.5141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0iXOx1A6ALgY1DTU3hN517eZ764SopcrQENgGKPNyNGL808Vec8DMd8fKt/roLYm10BaAe+bwgmrDWWSQ9W4dosam3R+YUyoFWQdprNfUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
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

On Thu, Jul 17, 2025 at 05:03:13PM -0400, Dean Marx wrote:
> I've created a v1 of a QinQ test suite around the set of test cases
> discussed earlier (which is not set in stone, and I expect it to
> change significantly across many future versions.) The PASS/FAIL
> values can be mostly disregarded in the context of this conversation,
> but I've added logging to explain which packets are sent, and what
> happened upon reception, which I hope will be more informative. After
> running on mlx5/i40e drivers, I got the following results:
> 
> test_vlan_strip: QinQ strip OFF and VLAN strip ON
> test_qinq_strip: QinQ strip ON and VLAN strip ON
> 
> i40e:
>     test_qinq_strip (sent packet: Single VLAN): FAIL
>       reason: VLAN tags found in packet when should have been
> stripped: Ether / Dot1Q / 802.1q (0x1c) vlan 1280 / LLC / Raw /
> Padding
>     test_qinq_strip (sent packet: Stacked VLAN): FAIL
>       reason: Expected one VLAN tag but found 2: Ether / Dot1Q / Dot1Q
> / 802.1q (0x1c) vlan 1280 / LLC / Raw / Padding
>     test_qinq_strip (sent packet: Single S-VLAN): FAIL
>       reason: VLAN tags found in packet when should have been
> stripped: Ether / Dot1Q / 802.1q (??) vlan ?? / LLC / Raw / Padding
>     test_qinq_strip (sent packet: QinQ): FAIL
>       reason: VLAN tags found in packet when should have been
> stripped: Ether / Dot1Q / Dot1AD / 802.1q (0x1c) vlan 1280 / LLC / Raw
> / Padding
>     test_vlan_strip (sent packet: Single VLAN): PASS
>       reason: VLAN tag stripped from packet
>     test_vlan_strip (sent packet: Stacked VLAN): PASS
>       reason: Received packet had outer VLAN stripped, with inner VLAN intact
>     test_vlan_strip (sent packet: Single S-VLAN): PASS
>       reason: S-VLAN tag stripped from packet
>     test_vlan_strip (sent packet: QinQ): FAIL
>       reason: Neither tag stripped
>

Can you confirm exactly what is being sent in each case for the ethertype
of the VLAN tag? When you say single and stacked VLANs, that is VLANs with
0x8100 type, correct? Is single S-VLAN a tag with ethertype 0x88a8, and
QinQ packet a packet with one 0x88a8 and one 0x8100? No other type options,
e.g. 0x9100 were checked, right?

/Bruce
