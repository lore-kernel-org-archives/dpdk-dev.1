Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B2CC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 10:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E0AE40156;
	Tue,  4 Mar 2025 11:47:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id B405440041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 11:47:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741085266; x=1772621266;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UuruZgbHGli71K2bpL7sMR3JT8ZWkBoIP79AFOVQLe4=;
 b=Tl2YZWcXsNFjI3K/mg64Aqf4P2q5Gshtpkey8VwxOjnj53Gbf7zO7+94
 g33MIAkwp65dZbITw7rohPe3ovoV2HLZMCk6UGCc+ZA571kp5Ch4Xu5RZ
 0RD2LXE87KQLrEY1PvwFEgAHNLuWRlQSiMMRotWqbXTjrwdED+gznMlfS
 ek29EH0uOnjQvfQgIelN6DPoJa0fxHvsU1R04ytM7+tutjpVskEBRdqmZ
 xzWcRsVfyKuHK81Fg18KdUgZze75XRo2gL3B5zD+nlqOd50UHNgVCp6a9
 AhTk4X61uLFWu8WDXKL5BupgWM3ffeJmGC846Zf7JKhjSkW3eQ6GAwQwQ w==;
X-CSE-ConnectionGUID: WVSia4+XTD6F5xelzsB9eQ==
X-CSE-MsgGUID: zjPtLPHjSYS7CEp/OUtAPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53391336"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="53391336"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 02:47:43 -0800
X-CSE-ConnectionGUID: IJ6x5grXR4moQh/ydUpUcA==
X-CSE-MsgGUID: Tkz2pbW7Ro6CDiEHDjFHhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="119028594"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 02:47:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 02:47:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 02:47:40 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 02:47:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrL+1xtNK7xP2K/MxcorjglzexBUalNbT0NaDKwGT/wv2+lDI5EuHn8B8zDzxWTWB7nkKcPfHG4U8UJKRF1iLrivhZDjXMLNP6nF/zBIgNe5VNKGJ17X29QjrWKvPLTevUaPufzkmwZ8ZuQbiaouQXnPuaF7KlLf0dCyJqzbQJ5oWLjcjSA/qtYQPA2s/mFlg5XhWXeSzRKzrQj+0aWkhSr0v4+qXgLiu4w5MHHDt1+hmitfcZaqrqwfTdG5MiQXVayVSwX8YbGrmDQ4cdrwuvXq7HxgOQiKcI6MlOIAIc2nXM2Y5Iwv4f/HrcqGZicLe8DAFal1epwBauPlzlgQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tcDt/H8fTqPv0f0lvGjhvGJmT1VW4b3X+1/OKwsSzI=;
 b=bKtlAx1S0x05bMlwWeM798WqADshm6lIjsmpvQUt7SejmpXJ3gFFspwk32wxKrLrosf25fv4D33u6rrobaOcQ+iD4OFTDSoZA/qK13VvDd94O6nBVxbXzRfo6RrErgupdiCj/bI5wYisJb26pMVw+EJG1GxxAQmBMBe4a2Wey/tjoohQaQzMlBLAX3x5s1P1re8R0aB3bZV5vBXABhpdVN1et8VLKBmlfihNkVf+IP5K7kTrt//MfG6GbjMRiE/C+qW3FV74o8zx+hja6FEo7xv8FposRw2E0oFvDxzxzNnUB0/jctS2ykgtoaCXm41hiLsepzz6UQDEFa83p7AGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Tue, 4 Mar
 2025 10:47:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 10:47:32 +0000
Date: Tue, 4 Mar 2025 10:47:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3] lib/fib: remove warning about implicit 64-bit
 conversion
Message-ID: <Z8baQLYFo9Fev_HG@bricha3-mobl1.ger.corp.intel.com>
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1741042492-6700-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741042492-6700-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DUZPR01CA0207.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN6PR11MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: ff721378-fed3-4ede-9000-08dd5b09f77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ToLZ6pE8MUaHpY0KPg4QnhoHvUMlkqXkLoxcmktZvnGVu220ycZ7hI6gdJ6?=
 =?us-ascii?Q?Dl2ZIwOq3H5yResWWmTVfpmlP1tFI7z+1ZBf5Io176L5Tm+Y33QImd4Hf+ol?=
 =?us-ascii?Q?Wio2hEMJ+Vh36SY0c8we1zoHc/AYNMZOaGBdr23WpktdmwJAMuE/v+776ikF?=
 =?us-ascii?Q?DQYi7p9e3s+x3/gFQ5CoDv4g5g8/n3ZTXMKdibqv2V+Za56Jce2JWmSk/TyM?=
 =?us-ascii?Q?IqqP2/6XiyxVQ4WXru3PU68xy0D3SiCKld0teBK3QZ/xNzXWE3gdah0yrizM?=
 =?us-ascii?Q?aB0KgcR0Yeo2jxm3CyKeW1XFeOCncYHMZSHVsG9KalnpXEFta0L6CFI2eRdt?=
 =?us-ascii?Q?jnQL8cXenoDLlCr+z9D7LJJWP6ltU3Aeo3yNnAh1EwyvxupSY201JOY8E1JY?=
 =?us-ascii?Q?MeTzKq7GEjpaIDkfY4tODGZRrNep89XWGVlE2nBP5t+yBKHHN9axgqheeq5B?=
 =?us-ascii?Q?TmDtWhU0ust5TtuUAaotIZ1znL6WC83pJNcMorNK/z84CIBFbHj/8NiMjoIc?=
 =?us-ascii?Q?RZGUmb7hhZcmMPce9Upm/ktIdjmtyRSN6GLl1/ur1nhwjCZMNLEveCKWcrUi?=
 =?us-ascii?Q?5Jl3E4VUDUE1g1Eo2tVQP2UG0AlxPjnZGR2/Ssa2XQZfg7+5QXQh9Le7NTeH?=
 =?us-ascii?Q?CG+gESlrB28vv+QgN5ExSAf5n3O0c7JFHdbYjt41Q5Awyk1hIchFYBW7XTo9?=
 =?us-ascii?Q?hRMo0xPBC70+vmhSUYs4Ugn7O5Q4aJPUKoq5r+qliIon1EeX12RsO3Fpff29?=
 =?us-ascii?Q?wloxg0HQ0HzwarS6mvhh7mr1fMY5iXSJ5hPWh++CMhM8ssU8VvXflNF3tHKj?=
 =?us-ascii?Q?fb7gIKs36gjQv7cD2ASrmLWDv7AyqYvHSNWD78a3DI2wWSbPnFT73ZwETC9u?=
 =?us-ascii?Q?G8QMA42nYZceevzFIbN1eRsKL+vkeDew0vVwuvhyBWqggGlzqTk1gFBqhJ/F?=
 =?us-ascii?Q?v/ldzhTOWiPdOn+eacssYSw7nRFBIjfGnxlN9E/5cR/u7JCpy1N6u/vkEq05?=
 =?us-ascii?Q?WhF/AySRaIJHoAVfDmEehXzlonbGlD9mGLrs5fWTg35pEXqP2m+IFK4EfNA0?=
 =?us-ascii?Q?kgIeaKL+RGd+EvYI9XJQ9S4YuzQOuHdTD7nEbYnbwCXV7osms+vbHN72EGic?=
 =?us-ascii?Q?MPUgQ/Kq+YRt4UN+o8XlQMKwRRJfq5g9VDwrnuuzhN7d4A8nvYmhXDjNkF1o?=
 =?us-ascii?Q?Rx6LVMNgVaAMxPCYuttES3jAaPKMGPc0PxbdEDLiSlmWjNzsXvI1nDtxIPBW?=
 =?us-ascii?Q?37Scbkp7y+lUuENVZgpHM7lz8pujip7z6zA/DJPcV/Q+ZGRcZvOpxlvu/37W?=
 =?us-ascii?Q?PMnFu2uNT9are2V6kBtOThWMBXserSWijuZ3fGI8giEBw6VK+boT66A4lpC7?=
 =?us-ascii?Q?3Z6sU2ga5+P8rWWXKd8c5YdwgH/p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rQzl+sSWebhBU+F8eg7+9l1BxEeIilYS9CL0q2W0E6sRshP5o6WeX3iI+xnQ?=
 =?us-ascii?Q?rGSRZilB3VNZ1u09mp1gW4WlilugHS84rSiqs8TiZ2qvjkPTwroQV2Z3Qe+9?=
 =?us-ascii?Q?kJttJrpRPAglQhjOSwQcNWcF+ZEtE95b6UJSw+kR9wOYCJq56rgP5u5Mq+Al?=
 =?us-ascii?Q?RstXPkDZQ/laH7Vrh2EckEFDLNvJw01vwA2trMGo3SXGDX1kP/tgxZc/5n/i?=
 =?us-ascii?Q?aAOVDkwMsQub2VvAFcM9xpyyMlRUfvLcTsf8eSydeqj1bDjrdBEB4yhvkyUy?=
 =?us-ascii?Q?ZYETgfJhPvqIvAE8AWVAfbvbOhnSzdO2ddTlootrHBD1p9bxo0ATUuX+S2k4?=
 =?us-ascii?Q?jnVg2/9lpkHzo7ktbiV9XwvhVlrbII1qMUKZUzZxP1DUrjORhqvRwguFFM/q?=
 =?us-ascii?Q?b6fjywD6Y7Zavik0liCfLC1SvBCtO4/JaXaKPdQsHAD4mm+2yUcKTHQCTaNU?=
 =?us-ascii?Q?oxd69FvhaV1YDZU9Z3SXDUisBmMseFD6PaIK/LnGJoNiAJ2LfIK6EggYDliJ?=
 =?us-ascii?Q?5E7gNLphr5sSgJ9Yl+zV81Me11fUQxsQ0OuBsUH1xYFmd3Xx/cQuH5ps9Ofl?=
 =?us-ascii?Q?DiSybIuBorkLfeKyH3ijzOWj/VRDoimrVTEj7tB8Z92SDQWLysYLHKexA24h?=
 =?us-ascii?Q?mrj3HYocgoBGHdda2krOQn54gybc7H5GSXw8EXYvcqAANvT5feGYIpxSkTH8?=
 =?us-ascii?Q?z6tBhw7JPkuX7S+4ko5dlFEaY1BptUDxeoPPIKPE2lQJCg0R3SQyQfzoUz6U?=
 =?us-ascii?Q?bzhsSPkEFyKQoIIp8tqw0y16qNpZTkqoCcQWTogqO/xy5n1FqaSvomAW1ZCi?=
 =?us-ascii?Q?Wzi9GMEHCUBSIxXpuTxHraI6P1jnVBYdQi0uRt6SdRiA3IMfIgR8OSUyvYXl?=
 =?us-ascii?Q?92aF1pgQUYuMDU9OgrVQ2a59yB6wUdsbDtyhIHR9VB1/QCS2L4p5SB31dHdD?=
 =?us-ascii?Q?Aagjg8rcLv7Xf++daOIeU+AU9jPpcWBBFZrA4ARV4l15fqxohoDM4eA934IQ?=
 =?us-ascii?Q?SMOCW2RwSWYmdS+ZUc/b2uIbQe9Alvt7SGSAbwsn+v5Fsk6Enf/FZr1QSiVE?=
 =?us-ascii?Q?T1PQLF9HExsJCIlTOqs12Qjq2GgEiUItoXLHN/70p3XLWNjRrZMxUJmIbrWx?=
 =?us-ascii?Q?xP3mJeLmgTvBpbgL7oHrf2vg6WQI5xiXbq+KpAGyAW883ngIpLbrPV6BXdRf?=
 =?us-ascii?Q?fb2XL+v4lKcLuzuIQVIUKtD6ctsOLLTtLspscpsFmcNOBQivnUdRGXmekICP?=
 =?us-ascii?Q?R0DB6P/N4mlv//nyIBDMXhJN19CzuoFKKtAUuv0mzrELNuccUxdbWcVI9lW5?=
 =?us-ascii?Q?pBen4zP3OZt+4xMIuiBp91zGeSHXZSnyyKIL7OHj7okCBjuyrIzd+5fEdutE?=
 =?us-ascii?Q?8x2rhXk0sCTdKknbNCmBwJguEV5WPf3pKxhWYMkWqsNufYuTMmYPPreUNMzl?=
 =?us-ascii?Q?shbGaUUStbs89sbsumm4YrwyNyZcqhF1AwR8PL0tsAk67EYWxL2yTmacuabA?=
 =?us-ascii?Q?7HFpsdYvq9fHLqchrwIWSerm1mJNHhkhzllHHGQPEgdBYsh4CRzwj3R/e4u4?=
 =?us-ascii?Q?FuUYT33Myj850UvOCS4MHJXLm92JA9T+FHh9vvIULJsT/GWTViQ78zI3HZLL?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff721378-fed3-4ede-9000-08dd5b09f77a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:47:32.2276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1OoPrIIQd4rRhXdsyVySoHv5B2rU+P0yk6p+N5hY5H2oO8Es/kHD6VYsdaFDRHPZC0x6zf0DmuFSWG7Q6R9tFOe2PKD5JTK4LQl3+qilGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
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

On Mon, Mar 03, 2025 at 02:54:52PM -0800, Andre Muezerie wrote:
> MSVC issues the warning below:
> 
> ../lib/fib/trie.c(341): warning C4334: '<<':
> result of 32-bit shift implicitly converted to 64 bits
> (was 64-bit shift intended?)
> 
> The fix is to cast the result explicitly to uintptr_t since it is used
> in pointer arithmetic.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/fib/trie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/fib/trie.c b/lib/fib/trie.c
> index 4893f6c636..bf9f63eaa2 100644
> --- a/lib/fib/trie.c
> +++ b/lib/fib/trie.c
> @@ -338,7 +338,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
>  		if (ret < 0)
>  			return ret;
>  		if (edge == LEDGE) {
> -			write_to_dp((uint8_t *)p + (1 << dp->nh_sz),
> +			write_to_dp((uint8_t *)p + (uintptr_t)(1 << dp->nh_sz),

Might be worth considering using the RTE_PTR_ADD macro too for this line.

/Bruce

