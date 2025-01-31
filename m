Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C86AC0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:12:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6A204060C;
	Fri, 31 Jan 2025 14:12:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 006D340281
 for <dev@dpdk.org>; Fri, 31 Jan 2025 14:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738329119; x=1769865119;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=J1RtIByheI7OaF4nZgaYYIacTR6kX0Wvg83MITxq1A8=;
 b=OwusEE/tPAoYm8WHC9+QlT7e1ssy2FIQfrXHXNTZ6X5ocKLEh9TwQAGp
 y+AdKqBCbtn3FiMNXsJl316XpI8KhJtZ2FZ3Jss5xJYXVL6M762j9o9hZ
 vuaj+y+j0yq7g0Yuq/arnJG3SxjDcoM8IXNuQpCW0JmDKmB8UOYSGQWIk
 Y83dOEpe7swkEnhQ5VjP86QvivBsan78Sdk8AKx7Ogg+w3wP+nGVwjM86
 tRg0324dAXxlEUg1K+Jv48rwduO1EiO+nLyYjPnNdP2b5XEuTo6hFszvH
 0O6KfYaH4zXfN7q2CotIhU1FSBe4lzyEkfrNOYn56IFF23cfwS6h3uKXJ g==;
X-CSE-ConnectionGUID: py7+JAK2RQyJP9wADqPUpg==
X-CSE-MsgGUID: fjv4jtfIQLST4ZyUtD7VvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50316594"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50316594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 05:11:58 -0800
X-CSE-ConnectionGUID: 9e3xch5OQRC5sq+/w78lKg==
X-CSE-MsgGUID: gYWWN5mcQ5+s1yda4cAmOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="109482682"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Jan 2025 05:11:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 05:11:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 05:11:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 05:11:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQO342yvPoUZfP/ECwYQBJ0LPaC7B6czr/pTla7zoTnJ4GknaWHJtolH71iI7t2ZQr48LAr5ZEoYgta9Jd6pshTxbfnSRaijPGRuSawX/KEvKKFDS7UYoxXmRJZPl65BPJHKItGdzkZWzQDjW/6lvZ02eyc37RMu0xhiGa9PxN2BmZiDo+fUn2wxllc5yRYzQRRxo3q2BLlZ3NLBFRrw9MOh1jDBOqaS/kmW9zP8G2ciAivK1bCtsUba7o9swVQWCU2DViNrFubJMS+jun7t0kWc6o3UY/+RWJPRKBylOBtK9RHkqp8DI/i15B+nkjcNSnRBzR+LHQ+gKLVa91tnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cOyvEK8F9vOwjU2cLiOl5Q4elVMW3MKmVnQuw75Xe0=;
 b=AXqn1iZDWEj/9VjgkhdxSzXLSTVRuRltFkH5roW60nsVLCa0wsJjVc/9bENcxYru+bySPHSd+83naMHdR7ZTgkQbwQpWVXcZ14Gg/yDUlRLVlVFNLtxOVBoyNmq50kIYhVbPDOJRfyVN3iTBJACYjtDLpu/LUhIazf+oXNLT4zGJSERfqTlte8yLWcWh5h1Brr2mbCYBFjHfhnwQ8yfSifIBtURj/tU1yKnlpHT1Y6U8ptbztyz3AkdngxE3D4BwSy46zPjz/Y+gFy083ypJ72s8njJBZC+Q4QiGAEDdZl9L0ZbAUkazBsCh7yit+LhrWhZWbpF/wLGPA31VV4+1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 13:11:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.021; Fri, 31 Jan 2025
 13:11:54 +0000
Date: Fri, 31 Jan 2025 13:11:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 00/42] Merge Intel IGC and E1000 drivers, and update
 E1000 base code
Message-ID: <Z5zMFBv4M8NNb3en@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR06CA0008.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::13) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 2daec6df-a47f-4400-d548-08dd41f8d50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6fv+d5pAlgqGEfuqyFlpOljM63MiZ+QwieIiHLSm+/QG5v+hUPkxNn4hJsUR?=
 =?us-ascii?Q?yAALP5xITuZ/9yxG5bfbJNORk76iqD8l++Iv1DzoBkTLmXrjyCh51cJpPclm?=
 =?us-ascii?Q?XtUHGBSd7i9HQJ0iqYJxqmjKu94AzSx46z1Ug5oAOL1TtDD2S6+uKEpT2XiU?=
 =?us-ascii?Q?WttCHa3W94IQdlZwsUYrlMrE28J3LQvK8Jr1rWkmsOmlFYNFuwp+eF1VYk+P?=
 =?us-ascii?Q?ww7YIFDo3wrMf++mDCJs122QOYyMu8QYFglprchU5T6NWjHtu3bSo/zjpAdo?=
 =?us-ascii?Q?rfaT7kmsfbH45GfIztjRrguh2ite/ZZ4C9sHT6gpGcvKTdpjU8QutLJPYl7q?=
 =?us-ascii?Q?LkIICZqvPu/QYg/SLihHWtniPVoOpWmTGjdrHFZawBNGCn3he/8TdLoE3Ezs?=
 =?us-ascii?Q?kBD6usm0Ys7gmSvTsC65iN8Yo8c7OKZfgHdC0NmsykG1kogJBZfIp6VhGmBK?=
 =?us-ascii?Q?LTYD5+j6JZ2Rt798XuoW1f3VBvDqK3HgfeQi/D7A0xFFqTC9u2n6QONuCrIH?=
 =?us-ascii?Q?N572ZFqOueu+yN77kgZMzzTwU2sGY0B1YKlPHK0gii+hvK6UclP6dBc4nXsF?=
 =?us-ascii?Q?LHqL2l1pA9Jk+EfpAElF5+NJ6Mt3/RnIQVhxzpJMuBYuynryWKzmNNULig1H?=
 =?us-ascii?Q?m9DNbYeDQ7GfcAa6rtr++aVzntAb31xJCcFo+BrxT/LryJ7C1Kda68JMu8ls?=
 =?us-ascii?Q?MHSBMx99w+ygkyAiK+JU9/zJM3Wb9w7BHM5Z/4289dk94X8KKb02olMtvu9X?=
 =?us-ascii?Q?kjgS0qHQ9SrpxgUC6ASBi1aJNpWOOF/8bvyqycSBVnNmzQHD3BFpCRDCnK0l?=
 =?us-ascii?Q?nvcX+tmnWp8SyoyziIaqGWwPxGvrmuiTjpx+A6xKabN5mC4CAPuYZzTk1aBU?=
 =?us-ascii?Q?2o+K80vFV2pg4FsQaVAAGIHGxaUnykklCitntEhWLVwYDbtlDKT+DYbaERbL?=
 =?us-ascii?Q?FY6tbeMUauGAbeboZAX8l+prbY04KJeEUBJuDKsbZW+/NfvdQED3LL3lsUhU?=
 =?us-ascii?Q?AvWQgFMGBttngkV9ozcMSS9M+baqUXLG0GbAdyXnh2WnfW+6iYv50vyF/ree?=
 =?us-ascii?Q?YCmSwQUZ2d1fZdZNhNTBTUrLE5Pg2BFlM61ijLyUyYNe8IzjSP2cX7xa3zWO?=
 =?us-ascii?Q?8j50WntuCTnZIvVOxk84achQEsyNqTdlfhz7DwKc2UaQRf3TRd64IRzM7jGN?=
 =?us-ascii?Q?yIG9aFwBheSgEp882qDMLLNGnCgiYpcyY27mA8Kg9qDuc1QK322yVUT64ya4?=
 =?us-ascii?Q?tWf5X5G96zDXX0W5MwkqQvpiti8VmrKPd5dtfaVddXpxCbtCH9wk/9ONC/mZ?=
 =?us-ascii?Q?2v6PHBn3JWRkaQah0kdJblx/WTX72U0l39DIdozxxrhfKmXK6iPRPPFnMvEK?=
 =?us-ascii?Q?xMIhe3m8I/Oz8fryIiVYiXB0/Lig?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kpYZmNxklKPlUmEyZDvQpu+B4kwUnsx7qPfteJZmqrmVIxxM2Vyq8O6Sjdw8?=
 =?us-ascii?Q?j377ePyuDHdtB5UEtkKG8rym8J19EjCnBJ+Q8RWMYegJ6/3Eexg8sLcIxq4e?=
 =?us-ascii?Q?WYq9pAr2BG1s5u6SYpDhTYOgXMF7gob/5za8PIxgsUlLMXgc6Qlm+1lc6OU7?=
 =?us-ascii?Q?L2Yzdr3Rcyb/xrtKADLt6D5+tE5gU8lwbKowR/wiCXiJAjjNMlodNgfgXqE1?=
 =?us-ascii?Q?XKGO8Ebs47NmuZXy1H9w0pAlMSayyiify/VJM7HcFhjkfX0kXp7hhIEe8K06?=
 =?us-ascii?Q?1F5Y7aQwgeBBb/nkH9HTqndMyBhOAO/uN2LxqGDcGTmsY+U+4zWJtQlHLzhj?=
 =?us-ascii?Q?+9y9k2xhBt25+6uTgEQZByasIyPvsSIFTcrrhszjk2+FLpL5/dh1Q0/J47Xi?=
 =?us-ascii?Q?6t4BNgaGy8tJxEdwObzghFXWCP7HsMHuAdYMaW+F2xsIcJyB1EbOWhOXlXIp?=
 =?us-ascii?Q?t7xnPz6EXFgVjHOK3nPk0+WXU/jrUZviyD+GBHfkfwtRFrcuOQjAHfXw9eZ4?=
 =?us-ascii?Q?R4LnhTZLZ0QHNzqTez7g6HW/hezX31kesyrqQ5cI1ojMfnlShCFfsd8UbmEr?=
 =?us-ascii?Q?S1sX+dIsNAjPpwqMUM2OcUuHTCyTkgolS26dDJMOwMLhhKJRPC/Ls1LnF853?=
 =?us-ascii?Q?DruvdXCW//8WCSvTC43yAEnogx4gp1Gweg/AXhe+QAJ02cvYF6j2mXvYE+qf?=
 =?us-ascii?Q?CH4zxrWizKozqciIVCoR3tCQ6Vu478221jkeX5QKLIY++9vWgPruITO3b80Y?=
 =?us-ascii?Q?PFHckFIkURQjxrm2AOsL6hmXcKX6a/tFAN9TCUh7Ktfmt2WoltxSkTXC1NeT?=
 =?us-ascii?Q?V5VWOScCAc3DxaO5Vw2isUsyH39TmoOu/O6bIoCSKi9O5h+dB6xdxIi5G+Eu?=
 =?us-ascii?Q?owDKrKjADOA6g8F9u6Gt+GMv//WSqfjaBof6GsrEmGt1OJKRq0NvDe1smIIC?=
 =?us-ascii?Q?QCIHVu6CXH8hiQv+B45UQuus2MVvsf1PrNJ1sGJFDiyf0GDLy+3KNrr6kc4C?=
 =?us-ascii?Q?TYYtoUba4rt4+R5i67lQkDSFFBHM8zgFZ5km6hSxyv0cWsP0K8ThiyCvcOSI?=
 =?us-ascii?Q?Bk3IkLLjjZ0epR4dskQG2z6MEF6/iK5zTLlIvWeqUo/UiDtRDWlKmnnr56vg?=
 =?us-ascii?Q?OHJtxzwf1//chVRTgw1xIyNKkhuyNQE/pqjT9h3+HUKHrfMcr3WQt7Fi4/iK?=
 =?us-ascii?Q?SFvClgvwid2iaMFaU7e4428yygiSUSObPZEd+uUoMINqpMBLJLD5igGVtM0S?=
 =?us-ascii?Q?9bI1Aaouh1by8jZ5i15QNXP6RN9jsqOT+ACp85nLcNNt9VePZRzE9heBhY9x?=
 =?us-ascii?Q?A2LicMgo7ZfHNvJ+rSfpWLLJfK8cADiQ1ONxtN+RZevvQ37t1tZ6p0uwKtdD?=
 =?us-ascii?Q?yrWFWrYg6wCUfhl3jGIGDLYV0quO6hPGVIiRL4MoLYUWTh1i3qV2UyFWveJp?=
 =?us-ascii?Q?RD6hAZII9EzIjmdr55uCmFQqUke9wDuximbV50XqK+QMt2oxIagyiGxgZY3F?=
 =?us-ascii?Q?VpheKUgUVVKVSrDUMJAZI95XNZgYEZDqYqumGNkrntEYHlFCKlb4AAs+5YJW?=
 =?us-ascii?Q?G4VrgZb0PpTfLc5N2hXUX8OQRO6C4rGmVS8fnpWpwGtlGM1t9qhjPHT7TaoP?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daec6df-a47f-4400-d548-08dd41f8d50c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 13:11:54.3197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u55aN2hZsVUI3nPVFe09K2um9zC+uRRQQk5lcrSa/3fl8cf5h7U8q+QOf4BxbDYrx4mhUxefJjyklsYb29Fu2hQtJ/Eyg2tFAK/tgEzj+VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
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

On Fri, Jan 31, 2025 at 12:58:13PM +0000, Anatoly Burakov wrote:
> Intel IGC and E1000 drivers are distinct, but they are actually generated
> from the same base code. This patchset will merge together all e1000-derived
> drivers into one common base, with three different ethdev driver
> frontends (EM, IGB, and IGC).
> 
> After the merge is done, base code is also updated to latest snapshot.
> 
<snip> 
>  drivers/net/intel/e1000/base/README           |    8 +-
>  .../net/intel/e1000/base/e1000_80003es2lan.c  |   10 +-
>  drivers/net/intel/e1000/base/e1000_82571.c    |    4 +-
<snip>
>  drivers/net/intel/igc/base/igc_phy.c          | 4420 -----------------
>  drivers/net/intel/igc/base/igc_phy.h          |  337 --
>  drivers/net/intel/igc/base/igc_regs.h         |  732 ---
>  drivers/net/intel/igc/base/meson.build        |   19 -
>  drivers/net/intel/igc/igc_logs.h              |   43 -
>  drivers/net/intel/igc/meson.build             |   21 -
>  drivers/net/meson.build                       |    1 -
>  64 files changed, 3300 insertions(+), 18218 deletions(-)

And I thought my deduplication patchset was good, cutting the codebase down
by 1000 lines! Shame you couldn't quite get it to a 15000 line even
reduction - 14,918 lines just doesn't have that same ring about it! :-)

More seriously, though: thanks, Anatoly. I'll start reviewing this patchset
next week.

/Bruce
