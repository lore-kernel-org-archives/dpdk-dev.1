Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3B606A335
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mKytKweO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C22E40299;
	Wed,  4 Nov 2026 17:57:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 2BA7940281
 for <dev@dpdk.org>; Wed,  4 Nov 2026 17:57:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793811473; x=1825347473;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bNkIVagq1Rm+mZj9Wq5oJZbk0GeVMOYDteeelscgDO4=;
 b=mKytKweOtktzRXla/7Uo5wkaJjd1qXoEVMSA+kLBZgypzNQwT+VKKI0a
 lMthLRLU3ieb3H5gpf3hzd/1O8Kj1P25FnrpblSk+UG0R3GnNAO+opDa8
 owBlw2gNGRVCHwLaZ5HSYGtxKsuKbgM0OA4g4FFDNb0gH+oIQyZBaHKiq
 akDWzzaVKppaxv/6K/gQ9fGMFeZ8QVbXUj5hWuPcmbx8RcvMHi5DdH72C
 JuoAfpO5s91u9REwO1Xo/M2XWLEzrXTJoqB9BqTprX/AH85skMVOFWzGV
 Uv410BBYvs286Pg2KPzgvmTWNN/2xks8YrcchQ4gnl+6Vav2jSDJf6zXW A==;
X-CSE-ConnectionGUID: zW9zx543Sky9RvOIcA6Uig==
X-CSE-MsgGUID: mXeSOcnaT7SN+lwWsL0wQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2448279"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2448279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:57:51 -0800
X-CSE-ConnectionGUID: V8GPYfVSRF6fsDo3ztLFtg==
X-CSE-MsgGUID: xREaHGbARiqWXhFTgd6ZVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6821135"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:57:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:57:50 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 08:57:50 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:57:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6ShOHe3BAFsRXzv/AdMkc+80xODAzdH5mWFQnQKcDIeDainQrduNrsEw0+hwXa0wHws4xK78oIt2KT8h+1KfVvQ85L3S0+dVzQr9R2+ug7JyrcOcg4GEjMLYsBhPN1MohFPlFh7vQJ+aJNfCfql+h74hA51ye/pYDdDXJOjwg8FtAoLnE6pwNw773M6EHak3FLuMmlp6g8NEv9IOD6e5LVPq2ktHd0wJv9UTGEa3kl/FplskfyzrRjGQiO1zsVgEeFqCXEVAfUOjZkTLHCYS1FUsctMUkZEGCisyv8ZLpYPdhWw+TuPrt2vvPhrRrXW7a2Bn+eIahzspB5SnmoW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIz9DTWeniAZ7tem0nDH5s9gYkvBpRtTnqRcPJQIw4c=;
 b=Us74UPEGin5UQ+lTu2aws9v/ThkQlerncJu1o1OPG5m9H4pgi0rmFuVve2E0ymxqiVFWzv6rsH86hQYVWcpLI0cH6sq2RqFd3nXlD/JcG8941qKNshuQTie8DcJuEyf9jwtIetPGp5hUt3NEImj08dagBzyovT/3lIoff1LXN6WQvYzc8J01OYrNeFO2XwAyKjb/rSAUDhyytKSRk7jmQPO1KcBiVm5odn/PryOcKXJ9e+b4v0NDZB3oCJeXkinOf9grPUdEsjqY9aXgKi8wninG2BAgRvXfYPlLGeqSbHZg2PVwfWTt4DXYN5LIzSRP3VcODWRAOk0tYtC6AsqdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB6982.namprd11.prod.outlook.com (2603:10b6:303:228::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 16:55:41 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:55:40 +0000
Date: Wed, 4 Nov 2026 16:55:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 0/7] net/ice: fix memory leaks
Message-ID: <autjh68pEuYrCeiT@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
 <cover.1793605751.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1793605751.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DB8P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::29) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ac2d11-3994-40c5-98e9-08df3a947512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|4143699003|56012099006|11063799006|261022105027099003|261022113327099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: od3CsytUDWFinW4So1VOQScKVSgb2MOubukAWa36+vqekPsgpgcp2g2etHvg3WCvvPdKiF4w2POpVBeW4kP9ZRzphZdzLiK/YPvx3ktYugM4rxEvnXOrhcLwLyzPWnuovuwxmR9G6OI//8IGKZbBD9RWvH/b5L9GF3kGGHqR8BdH21WgiNfDzPdILYIkGLat6CsIWxHznw8aZxDhgQwN1STj3pAKdbmAgexsQtfiwkpETqKQSKvCj0MA3wUuzfLe6A+r4kWR70UXkcm2Npn4UxkDLTvnTGUud3sjDkGRvrW+hds2en6avR9BbRHT/IvAqgXbGuLQr9SzqTI3djPxe5lp1f/OhfOQWstng+XpbHZpIlEmObnCrSeOfTNRcFgYjBkEoUcwR44yQfuHW2aoiAsv1uHenU1KSSPLKP9h3FRortQypnocMPAM0TFRYSwQxaUVx+hUeu1bAJPTvrWjOLmgnGglx0mfXoklQYdPH8yVAXzKJTw7aFf1wSgArDrU7OGuqEwkpY4LADk6/vxkv8581TjX2L8g73QMp34KYVPeok/hdbHjFdtEZ5lY6dclLmSY6Tq5O9xrJkc5tuQkwpOLBe3INWQG9VzwFdwmBH4Mes4ttrlSoJ3+O/EW8ufug6PLmNeKV8bPbJ70mp8CXjfPdoff/MK5Jq/5kroaR5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261022113327099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6x3wo+SKF1cJpDTu6RxCr0N0E/FMOn8SsuuZ8gdo/NXq1Fv9XO97bN0vp9B1?=
 =?us-ascii?Q?Vy5sshde7LYJ/ouN1A1cNuQUsk0TK6xXAnV2xXo8uwKYB4P0G1wasxB7H/xi?=
 =?us-ascii?Q?ZNPEs0Wv4lz5zMJbcr3ePgmqcqKz35YkDcTuNO6BG0HjtZPMHxFI0sctZhKT?=
 =?us-ascii?Q?qCgfLQJB9zG9AiL1dShx0MRcKKcm89bEGdvB314FIdl5+GJ73svvwYs//oub?=
 =?us-ascii?Q?sd0F1v/GPMyo8iNUxdv85WIvdThNnatTq1YXas9acBXON7uUVM+/l7pIzwjR?=
 =?us-ascii?Q?QhxezGW9etTW+19W/N6EIOekJh65fRnrSqWi1JOkStQqlVdi3ZlgsiPrchTC?=
 =?us-ascii?Q?XbOKZKerGgkG7Btiuzs0yy4TS7gi6QxIgL20SozHpszHKTWP7zeOJ5/q1NwX?=
 =?us-ascii?Q?zktSY4V7UypaE3ad98EBz/O7Ur/svoJuhv4Jh/OgJhmL1gOMKKepBeqVqR1z?=
 =?us-ascii?Q?GXZsy20NDCT15pezdozfBIzSpMeDda3npW9X07we6qBoJ3YPCfYNIvDEwkO1?=
 =?us-ascii?Q?JJDCxnFmC23989m+6QKnOKJAEMxjs4dCfFVsWG+x3g3yxFeeiGOFV9dGOaN6?=
 =?us-ascii?Q?75PBPT3H6ncJ7xHgkNri/i2e2xh5zs07qfhnBA0KTxjl4bD79tFAqNGt32Wz?=
 =?us-ascii?Q?VYDnawr34kAj87DMhVvedQyk+5I9jRHldgPDpb6ryM2vziiqMkvgQB/p9Xyr?=
 =?us-ascii?Q?8WuiEdp7gx2oKWSVNnXCPmhRKAEsWBq+id0IFtnIrTNHW7TD9Je0z9Gr78Uf?=
 =?us-ascii?Q?ssl5C7f84KgN9qb1wm0GGLPXgXbj3hxhYVhJSsl31GYpa9ngEPzd4lbeZHqK?=
 =?us-ascii?Q?S8B0vOSNUPF5GST6zmEH6d2v8lXSNVmtSrIlMW/FUUSCYgQsTF4FRWKsaVNp?=
 =?us-ascii?Q?Y0DZ8pn0BK79GeoztJVavvbLyo38Hhnx96Xb7eGYTdSCvpk+/hBfva2nD0Hv?=
 =?us-ascii?Q?khPtsUWoNdcDBRjfQE3jGVKCZrDKOA0WcjCArPQIvTMzdoLVQYbPqdM9xUC5?=
 =?us-ascii?Q?BmHT7eJRPEPe2egHLlwfGUzMo/ekJKBANl6LeSZuEyy7Cs8duHJCmnHj/NAh?=
 =?us-ascii?Q?q2GqEu0D29x+ESp/X8pFks1aU40b1xbBblelIkMqvbwi0seJe/+gQujYxAnb?=
 =?us-ascii?Q?uhw5qHBO7mSMrwvOk3KiK+lIenfSuzOo0mGjfeNTULiGN7vdNDd1xTJNPnGS?=
 =?us-ascii?Q?do4qlMKgznz62gwoYINzGZV3UdrOjfZChHXww4JATDQ6DJnCvQeoi7kOBRMo?=
 =?us-ascii?Q?tBdFTordbORzkoAFyM6z47grrMhZZPLaASjWAEJjwSfU9LzvI9YPVz49rPwX?=
 =?us-ascii?Q?dUtCBAgRPaR/MWR72v/bP5tTVvZmHkUxi+FFFlZLOvGKubRYYQ6GNQUw+S5D?=
 =?us-ascii?Q?jJ3NFfIOpMEJ0bnXFEbNu6JzlBkdcjFNvbFSyvzVz48gNzTwTdBWe900DO2T?=
 =?us-ascii?Q?rEP6/r/ckc7dGx87FzV803J1jsSEUhjVMgxjMLPpqvdp8LZricYM4DB1XADF?=
 =?us-ascii?Q?EiWM9bGvIf+M4anXY7JFL1AHdP0J1cNRBJbUQ7vQW24PCi1KpI7zwL4cC45A?=
 =?us-ascii?Q?uYeEQ+UdODhOVlF1hNcOD/YOukjlgPxBhAFH/sOk81/1oRZ/GJ6bznmtb4XH?=
 =?us-ascii?Q?yetfAkgu3tnmvZScgXjPNkN6yHs6GA+Hpi9a4ITynuimwfWdRbde7/634dpe?=
 =?us-ascii?Q?ZxdYu9J7aJS6YPr9laM65mCmBkfYQXRMsIti4xMHHM4nBp7M+so0XeBuF8hW?=
 =?us-ascii?Q?kVAh7y3IOU5sh1dFLuPpN9oCiUe3+xU=3D?=
X-Exchange-RoutingPolicyChecked: Td/e1rKPCI2vj76PE18nA1tyv68JJxy6n8BH0HcoU8zsAOc/vqDrwyfx0ekwdDFu5sqkmjM2bol9X9u0Okphx5NtkGIwTBB4t+Ptwf3Zty8/n4Dc1UZMTH9pbxMmLb4RdIHG7o8MSlZtdRHTbyEUL/dpmZ0iWNWJZp54vDqDWE3dvL3tAIDWuUT+Wh/b8msyFpVH8J+qrRyHBZv3OBRpEc7LLH2t/UuUypxDZ+qvKYBeT6shB8szy48kwX0duRGAGA+lqGMVZipm2xUGTqn2Id9JQxmMssr+pTZ506oBEUeRLuk95vkxCGLaMWJnF/XWES3yNycsxL87FqUicVKT6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ac2d11-3994-40c5-98e9-08df3a947512
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:55:40.8369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2ie0+thvuJ4I4kirxOxzR9HmpEruzsxBqhDjIHMiaBbYsg3adKIGafl/fEPv/gGqviB/eQjdqYeE1vtJIU2cgmzWoE1kP3J4FWDAMnZcW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6982
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 08:10:30AM +0000, Anurag Mandal wrote:
> V2-changes:
>  - Addressed Bruce Richardson's review comments.
>  - Added "Cc: stable@dpdk.org" in all patches.
>  - Use ice_deinit_hw() on close instead of open-coding it,
>    which also returns the FD counter block to firmware
>    on Patch-2.
>  - Declare the devarg handler argument as char ** so the
>    filename it points to is char * and can be freed without
>    a cast on Patch-3.
>  - use RTE_CAST_PTR when freeing the filename in ice_dev_init()
>    on Patch-3.
>  - allocate the flow segment on the stack instead of
>    freeing it on Patch-7.
> 
> This series fixes memory leaks, and one double free, in the ice PMD.
> 
> a. The DDP package copy was freed twice when hardware table
>    initialization failed during probe.
> 
> b. The switch filter management structures, the DDP package copy and
>    any remaining VSI contexts were never freed on port close or
>    reset.
> 
> c. The DDP filename devarg string leaked on probe failure, and when
>    the devarg was given more than once.
> 
> d. The main VSI leaked when probe failed after PF setup.
> 
> e. MAC and VLAN filter entries could stay allocated when a VSI was
>    released.
> 
> f. A failed flow director setup leaked the FDIR VSI, hash table, hash
>    map and counter pools.
> 
> g. The flow segment used to create the ACL profiles leaked on every
>    ACL engine init.
> 
> Anurag Mandal (7):
>   net/ice: fix DDP package double free on init failure
>   net/ice: fix resource leaks on port close
>   net/ice: fix DDP filename leak
>   net/ice: fix main VSI leak on init failure
>   net/ice: fix MAC and VLAN filter leak on VSI release
>   net/ice: fix FDIR resource leak on setup failure
>   net/ice: fix ACL profile segment leak
> 
Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
