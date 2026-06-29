Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3D6C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 15:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D88402B5;
	Mon, 29 Jun 2026 17:50:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id C6A1540299;
 Mon, 29 Jun 2026 17:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782748231; x=1814284231;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=38FD5Mc+mOLuMLouj8e2COZS2V6zq3DlNz852cfzRUk=;
 b=JflvE4GzL0xTieTZmKPh72O5YzSyh7M6uV8o7yVTRjCLLd/qSknp4UcW
 xLli/zpu4mkEZRc0N66iziU8XVN+4IvoIQ++iaY3he4qM3ftL0vpcoFFV
 rfxTx9Bf86lsZASEfGsLx+6o3VAHafqXj+WNth+OmWCZiaVkfBJCuNgzW
 7lGp8W7jD0ziqTaSwQu53PhIp/VdzbfikvOp+i2c2vA/Fy9OwyUlvy2eg
 X2WsVkCJonc8BsLT5CmwExAOuWrzfeaZHRlzkS3a7rg/x/UfslAyaesaJ
 p59PRHAnkD/l8zk+haRtSdwfFZs2mv2MPBOnQQEl9VScCixv+aXk5XFE7 A==;
X-CSE-ConnectionGUID: 0KktNGVoRAqE2JW4oBwezw==
X-CSE-MsgGUID: fVnrf1zTT2alBndm7swaEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94099642"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="94099642"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:50:30 -0700
X-CSE-ConnectionGUID: oesau26+TDSJ8hXsJM1oJg==
X-CSE-MsgGUID: 1iCVnqOqQ8mHY0H/QA9xPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="275221565"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:50:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 08:50:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 08:50:27 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 08:50:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbmuDcRJX92pqskZw/aUuS8XMYseGEFA1Y63KQHh/McVMoCLih2WKp33U7UT9SwOrb/UWC3DTVC9BPw4AZiHKIWm2qybSrs0tgAGTa8SdiWqQAIAYbPydBgYEST7VSCLMTLUzaJKAfNxOo8uCKMyE2Qu/dBcrfSBNQI+9fQlxReI+xpzdpaHj06+Pp6mADFmz4UtQHYxUOCPnNTRNC5Z0nQAR1/EfjGudyxChVD5AXvgCqO7fmRSzZ1vIp/Bx2O9DPJ0CLoMA9dRBMAZv/4boTOp0IcWmmNxDGpxRQWXIPFsolYqHNk7IEO3n9scdhJFPaJKnEeYla1bVRIvIqyOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it+1ZkLM4pN3zofVDxZ6s92+yxS0OuYIlRhJf5KuhAw=;
 b=QzUNA2r7P/eBCbf6ZuDQuDhQHBujG0JnPNw8+3PvrlC1pmdHnzVoB6ujeTFG7TqKXrSNXqTDodDI6Jz8rmAMmKfyOfv9hKyPTNqH/R0LT3LnLBKWfS00sgRfCwCXPZgMgZxUMIoLKlGjZYe2BYArEdRUU8rcKV4osEWDOUNpcbxc/Ez6nfY9yHhcDaeY+n/p2Jii3a318GImLN/gHuuoMc2HhTcQJMifu8pDzIV+TlV9RwEUWMSZ3ajLq2IAzqI+KOJ35f5KMU3pD+8ShnPP7jYNsCjfAMCKXkD89JNvaE/i+JGh/6kdXIptNqekBysYvy8YVumfupUcqmQO3cUqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA0PR11MB7935.namprd11.prod.outlook.com (2603:10b6:208:40e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:50:20 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 15:50:20 +0000
Date: Mon, 29 Jun 2026 16:50:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/2] net/e1000: fix igc RSS redirection table
Message-ID: <akKUN7EpKlMgzP7R@bricha3-mobl1.ger.corp.intel.com>
References: <20260629045511.473850-1-deadcafe.beef@gmail.com>
 <akKNdk8s7O17S9m1@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akKNdk8s7O17S9m1@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:10:234::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA0PR11MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc036eb-5afa-4841-cf2b-08ded5f61f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: NxED3IBH2b1AntOCUarLHKED7N3k83Vmi8rlGFVqejDw6x1UYkSb5jQyPz+OacIgJke4pGjrANINd1oXuJhQOwC0M2CdjC6zJpnm5j/JC5jCd+y1Uz4uugPGnZSmyjHtY0QUeh7jYaVt/RUUvoDtiEgy/Afb1p5/npt6xNZEBEQREPZ467vo+jzv1n9xaggtWT39GYHj0JJ0+eQqBl6CYRG76hwCuVzHkdEr9axCVwxYSrpyl89imDX2HkDzxBB/qhC/z2NX4YKJNKSxk20jCCQ4AvT9W5qS/HFrIZAxOKaYwZ4DoHTnlqiYA2DUP9yxZpD7jnsZCKKzGqf11HXX4+XxBEd2OfS+xtVJYoxXVszVCH378Zpfw4sCVfdRCuvPn4miMPx+qgWhlvDAyRhQKnq5TvX2baNcvqb7xMdFEsfsJ7cHOA6u9WsRXBQ3VGacMquJAkzu/ThxGKLZ/ji9CKXMAc/P42hSH5bdkAsjLSqKBbalr+Lhf2wE6YCRDIgfgXdzoufFDl2wrUq0W/J7B14mf7vmfCxCqQivnu9feswE8nFznSRJ1AJqOZbcPTm66QDpzvU8QnHyLhd4Y3Bv/87ePa7YHDSvhT3cGLI0iqXFNz1fw0+JqPBthOeshBir/hVfAc/IZVkMSG72JWsWKJ65CZOvSSyeqb2/YYvaIEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYNaFZRs7Cl1FaGBfIcomD4zXswmQwi3QA7baOOD4CVnPaIID7O0wi9F9aMw?=
 =?us-ascii?Q?UAOJMfAz+uHcfwvD9gGl+/CSygA71nPnOFd4gU3d2HsAqSYM8e6uqnI0FaAL?=
 =?us-ascii?Q?TU+bJDkQhg3kLrlMiOe1kXTORH5IGo/bdKUyETHwHUFXn3k+FCD4bllIzJ7e?=
 =?us-ascii?Q?e0FjWkpPlyYTqcA/BIp+sQ0zjvUcGI6aSrxX/cPJqC1x/MR88jUIdEAxN2rI?=
 =?us-ascii?Q?gKyi7j+GxJDDazsJgNyOrg5FpD52o8+BoBvH8KINIo2HgzVXco1COxJ+Z3pq?=
 =?us-ascii?Q?iN4uCQ6sQa7JspLabHNFwt01Z81LafK1ApeKHgnNwlD/iSHmG3oxiH7pR4q6?=
 =?us-ascii?Q?QvV+/GmsjqxjBiVOz4Le36GWSV+1+QuMImE7fUWFAz5hYUZ5GVbgUzfPQJLR?=
 =?us-ascii?Q?ByoChucbMECUGCgNO7eGawOTBtJmGtYoyCZ9dAh6z+logwsaeHtQq+RZ0PLZ?=
 =?us-ascii?Q?tHiKNY659LCq6b6miioj2PjLf+VpADxy0ergtKDauc1lRWSGDmDO81/h0e5h?=
 =?us-ascii?Q?H1UPrNX08al060FJIC5Xzrq6fv2+uG60Sx92lDyTS0JURhRYda8GqtdpJHju?=
 =?us-ascii?Q?A1Qy3GxzhDh62w+2HhieFjMV+xBnt7KLrTb1//hIeuFBigeNldpQxqMZFk2u?=
 =?us-ascii?Q?oJ3mS8cXIsjmBssWSsM24l07YW4CAZq/Y0bQWAnPfvgsXmCPl8k389IU2tWN?=
 =?us-ascii?Q?8JwgcdwyBtGJxn3q1Jhu85FGnP3VIrs4FdR3pSDN2NGwR6hhz3ACEQsmNS/V?=
 =?us-ascii?Q?9YscGAt8um10ZoxfJofwuMJjSQbjQrj/cWdOB7iJ5X6YEfB3iPmJbC5i7yYi?=
 =?us-ascii?Q?9ztDwRSmdL/hG2pJHPOkqvkN0x0fX03+29JD1LaSnLYPqRajzYIaRaXgOwF/?=
 =?us-ascii?Q?P/jykG/auU2jpCLjTMiA1W1kkEG0Ssvtrh5jKi3mI90zl+R5W2V51K2J2Oly?=
 =?us-ascii?Q?6E+A0nXVf28ePt0R9DyB1P2eV82FlKmbV02G7jLEjyJFw+0/xZGtUU54eBXX?=
 =?us-ascii?Q?TMLnVSf1PbZQXk5f5A/l1w9Y7f6abWt/jNaPihHOHjDIBrpjlnN/e1Q2Idsd?=
 =?us-ascii?Q?MUfWehnJBlpggJlx75a9yAyQjV2t3h34afhVtZQB6Z1Qg50GLUKrQtgBm9j1?=
 =?us-ascii?Q?RrUI21KtZVP/cAhFMvxzRnigb/wfYfjkeBsf1MQYWOGjc4I+t6Dhqh2x71YT?=
 =?us-ascii?Q?gVRALmLPDkftSibEvsA3mxW6WYv/nTBGaPidkiShlBr9RlQuyD68q1Z8AkUa?=
 =?us-ascii?Q?kJtfJCijYY/Z+l7rNd13jyVhMJKhsxSyuGG9noQFIeRVQFWOmpORNf7AK+eH?=
 =?us-ascii?Q?b1DsVOkJ5RYLL0RWNaMv+Ruerpgjtt495+1Ft372azLPLBD7Yno7+Wq+JQ2a?=
 =?us-ascii?Q?OCnJweBTAqymQYDrvWPo/EZn0MQarAoiAD3i8107TOOuRZcOY6DyhmR0ewC4?=
 =?us-ascii?Q?Y0lwD0oMhr1jpCwwOaSew6Ia4NsjXXXKtZ7oPnapM/AEjBuhZcEeTbw9Tl2A?=
 =?us-ascii?Q?Z65eumrCj+0XkXKeJuXVUvg6l7RNCLVIRVZwLpd64TlOCBcU3sCX+gx+1l0W?=
 =?us-ascii?Q?1HVt7CtNqk6lbm0AIjX54O5QbvxbSaTVcRHWGqVYl5sCoWBlG0vnI3n87quP?=
 =?us-ascii?Q?DD/22kBVgRdaKUB49OKjTHrxRuGF3eeq7O6TLsM9m78wwsjw3vD7jHjYGVVl?=
 =?us-ascii?Q?/xk9BvYKD1YO4ysdn9AElLA2t7RKRQ7JrZtuXaK+K8EKkjkealZQjetNq7ns?=
 =?us-ascii?Q?MuU9+vsoOgSKFPuVRuTEGA//irtQ2gQ=3D?=
X-Exchange-RoutingPolicyChecked: dOOVk8k5/4pRegVoO6tibvEuKoZlWJRueTnynCRgloMjuHR4Y1ltJrV8WG9ENlJiBycG8MmEPhlbawRRTd52Wjf5pelUANdpqLIkcfkl5rQPy79xxVUZ7nGI10J5uP04FUeLyDd9Zvj9+S1g53ZcYcHUCIyDSZfJJIZxz/k1PeCzm3KpYfuo7hAtkmvWRbYzYCzKmU+Lz47B/YgsvfMc+u+hmDD+F6x8sxQ6Ownzd9/Hk5Oe6IiwWxmty7p6eTOkncmusFs1mKS+pfQNXefZsj9mF/oNvbXncprMLoMQb6Fgxh8IizMevexdMan9b/2JccAnv10lPaZ57vT25No4Xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc036eb-5afa-4841-cf2b-08ded5f61f83
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:50:20.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrwT7YHSHh0MYps1KMYr/kw0ooDlrLgHiYJjsgiQJ8VWcorXihRtLQUE9UmVLaMtj3p/TWt5FnOLKvq6fWMoltZ1Rw5ZObJnFqRkfNXEJoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7935
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

On Mon, Jun 29, 2026 at 04:21:26PM +0100, Bruce Richardson wrote:
> On Mon, Jun 29, 2026 at 01:51:13PM +0900, Shuzo Ichiyoshi wrote:
> > The IGC RETA register stores four 8-bit queue indexes.
> > igc_rss_configure() and igc_add_rss_filter() used a fresh
> > uninitialized union for each table entry and wrote the register only
> > every fourth entry. As a result, three bytes of each RETA register
> > came from stack garbage.
> > 
> > Build the register a word at a time and initialize all four queue
> > indexes before writing it.
> > 
> > Fixes: a5aeb2b9e225 ("net/igc: support Rx and Tx")
> > Fixes: 746664d546fb ("net/igc: support flow API")
> > Cc: stable@dpdk.org
> > Signed-off-by: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
