Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5130ECD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 07:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A475402EB;
	Wed, 20 May 2026 09:45:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 675B640276
 for <dev@dpdk.org>; Wed, 20 May 2026 09:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779263109; x=1810799109;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nZyLVIFOihTlM6dymrlcZtePOtu45wF/vCV050U5wGY=;
 b=B5/VUWfTaH9Y/UlLXhwc3BYts59rEo/l9ayhqUZwO9uCguSR3GezQWfM
 0MgkGhd04Kz0z085LpBSYBwChSoKHDAxX7VcLhdDb6pe/rb2KD4OzZuaM
 hdAlAyDoUpkIDunK9KtiTNDKLS604TsaPCOquFrKDa18jDZH/GdII+kfD
 WgOBQpic4MZKpERZJicCfESAfYnrq0QYJA/tRVxY47+o2K5F1b/BR99i7
 Efy/7IKVKKpKjqc7AP/tXWVzLM3ITMYrdkzIQyaSANdgAXSMHDHzFKIoE
 KfspOttAlrwqeCIeotFBHfuuIICYi8mDJY6cYu8xSOSspM712iaswJrD6 Q==;
X-CSE-ConnectionGUID: mzVi/LBTRsGjWH158N0rLA==
X-CSE-MsgGUID: 9qUx63SrTuy8WpWb/EsKjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90452490"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="90452490"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 00:45:08 -0700
X-CSE-ConnectionGUID: 6L37tY0vRk2IdDCGfCzAaQ==
X-CSE-MsgGUID: PIqwKnW+Q++979SuX8bjiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="245065232"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 00:45:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:45:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:45:07 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5IWb0L4uU0ni9GbUTHG9UCB2pjYoeydZD/JIIEuHbJcoe6DoB2fHEQSTpJgNqZknMiGm2Cs7FZKfnOjQXkfX0OeHnGhzh9OSWqdmQr9xFf3krI47oNCnRMkFWVfclXxRrlsrUNmsbz0BLzPAa+2VeCLIaV6YRHXD+MvCiqOaEuIxqI0xZ3yqxo+kV2pZQ76CAWUty2inDBHIm610lJf75w9Tw9Gqdf88tIQeVYMYz5hSOtVVT8Qxp0WfRo748Lim5qPg7Cw02mUNrTjDN+KBeUiFwUC/c+bmDRxLtfTUbhcZ6lzk1X9/NCxJrd3hHVMUoGSSG/o3Hul62pcZ640bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlB1b2ZTpG+4KyKA5uiBWz2J0X3ARwCkXXDoe+Y/SQA=;
 b=cM4uANiy/tPVr3GGQUhsxV4daNit5e3GYcKf7ZW3rJfcv3Qsgmbw7FAIwynCbvoY623GU2HymIonmdr4fJrrvvRwWfOzfbrGBq9EFH+aXiS8gX5mEKLT196B+yjW4nBbzRs1EkLsnoVzEzg9brx3SeUjGawa44+z+vVjUahhMvO+9VaKJxa/3+t5jUdRkjdBA4aRVjPk9CfYwE25NMrf0t2mCUdb9QInJ192L2JNIpIV889fxgWHIc22ooC4ZabHlVKWlDCrQJZiOaEjf1I44eFtQ6ChvUN30Uofj4vZ3CuDaUBo6yygsVmjZnJ6nbbmtGIPjKaVFbg/VjubHW5GbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LVXPR11MB9755.namprd11.prod.outlook.com (2603:10b6:408:389::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 07:45:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:45:04 +0000
Date: Wed, 20 May 2026 08:44:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Message-ID: <ag1me_1XSByq3p9V@bricha3-mobl1.ger.corp.intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
 <20260519124332.5e68fd8f@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519124332.5e68fd8f@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0194.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LVXPR11MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: 97371d01-1e1e-4af5-73e6-08deb643b46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: vTK1yEGcvOjBjyOA2W1eB7DT6VNg4BpvxrZlOTxJiPr4ZDL86YnsVjf5NdXJYLXCvksDal1clEBptjJH46wU95RPoA/AKBwGvlDbe2Zpft47MR1mLgCk89+8OW4D68xQ1I5Gwma2q5OuENQB4VIyf3gFfYdHvR4jSim4zfX+R/7hSzFEjnJ1MN9alj1pNGSiF7DVKv/b25lOn0LYHKoZpqqJhg6hNYcJ/3ut7CAtnaZjjQArTCJ7kGD+LNUBa3VNz/ntfIM77lgww3oH/0ZHiqXta0xjCowHKrFZKTwQZxzqH+/XZynvL/BXRv8oGu54TZBGq/IQz/AhBjFJVLGaSarRX5vfC50MWuOWSAmIfRKmOOanU5fny7EY8W6hCLFy1v+bpXx5wOJ/FCQw1E1Qgzmc0KVVW3ehzt2tV9LQKgmnnTfE1hymzTC8wFgg7DGyf+o5bPrRQvtK4OOwzPlcYoUA7XUbXOODtWsRX4caONBn7/Pr9hsgE+6GDaWrzzZaJJmssGK+dOLbuOyEi4klzks3vH5AGo6Sc7uuz5umgJsPw7CBRhqIglkiTgP5lKWpW2U2yO3Va3fS1R9bxZVM4SJP/FPd+mNKLuOKgX/TUepoHBLzUaqQ/feUISZHM/C/djHpk5m7yopF72Fjx6FG+KfAGS66fn00KAqpnqLOBfyMheXmhWEsSAh2rMS5LsRg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WbC1lUAbXV+//whcyzggAXb+ytkzPucodo7YE7PK+xrabg2FA0RXrNCzYdmR?=
 =?us-ascii?Q?2RPWi2noQeoVty8/T7CNyypsrJbq2zONBmGlqjVMhp3SMICUy8KMLSz8ubQm?=
 =?us-ascii?Q?fyOJvKYMwMXeIdgvj4P8E06v4Jzy6ITzelSAnRy8kSbcn44/2ecT2aDdFpH2?=
 =?us-ascii?Q?MEV8Ls6eLZWT8FHxPq1Hf7C3CzObv2QuPFvn+gu4S7oK1M5Dc5KuUSvkJZPD?=
 =?us-ascii?Q?TgyA1GHGxfCEfFmi/rH5In/98Tycj78hrYHgpkV/woKEk+rjCLjPS9YZD1jI?=
 =?us-ascii?Q?GTbBg8h3aTbsFX2qm2b3Il8TIexFmhfZ700NkBJkpVd0xKSIXMjN2iFyMAKB?=
 =?us-ascii?Q?M3EcLOr8kPJDHI7IVDTdRiNB64MlKaCtmyG5BrJzgej5DTgXL1Whf/STujyM?=
 =?us-ascii?Q?kMXuPsKCspeJSu8CgugnBGYmvCNgPgNHOreLGPmeRjH2Epe9exEsAaGG4aMM?=
 =?us-ascii?Q?0H6kMEBReJeAiFWQVxFRVubb+/al21AC7DpUfGizD7dj7HT8vvSC7NUnxzUi?=
 =?us-ascii?Q?Qp+AH7yMqgc4aO0Cr7KOvSZYAfEXtxDMbCdACay6h4N6mUGA3m4+dr28EbE9?=
 =?us-ascii?Q?b4TbT3HrwAtE+ZofQBEd0Wn9FpTqcA8cnf7Gq9GjH74I49n2hEKDdpKJh/xS?=
 =?us-ascii?Q?D3dxyhxltwP6o5K1bEDuaByOFR40KZf2v6SPPNIZPvaQJCAkbFhOcPur9DID?=
 =?us-ascii?Q?6vnZlxpbhYovaE0MRwCNOWzAFWWp9OcVvDiMzaBlCnzYDVQWZQYr8djl65oJ?=
 =?us-ascii?Q?aR7hki0tRlCasD1Ock5l/64mJXI/tY3AtWsBPxPHH04p02e0Kd6Lu8S/OgCD?=
 =?us-ascii?Q?tEt8GT5ndZH4UbonSD9UmDLYH1bHa6okmTuJLSvhnVAXeeLPP+sHNmiQhOO3?=
 =?us-ascii?Q?tgA6vKC4vTylNOR3gOTRVlS+kC+RaEjLWLqbTTdEJinHcAt0vLj9eDVlByPj?=
 =?us-ascii?Q?HyS5eHiozb+p3BS1SjLBVOH50K2z3PT0FViCYWHf+vKC7+RnM8gbTk3HBoKB?=
 =?us-ascii?Q?x0DR692W15lRmMpBKfwBMrwBO0Bsiz1wFht0cqahY4r+xQXbmjYjcQX/IE8i?=
 =?us-ascii?Q?ZFhIvpKiz83XL5jfA2SszFVnIOiQbTXJyr4xQ6vjoZTLQun6BxBm2z1bqe4w?=
 =?us-ascii?Q?L1NS8I7kdrHqtjtZydV2h32I94dotAbO8GXDilg9PWLwX7zmEDwzpSFqSm0B?=
 =?us-ascii?Q?V0kefMmUTlGS/Eclfzs6iukT60AhxRLrP5RZk58kxfEbXBAOtKQPGmYF0Rmp?=
 =?us-ascii?Q?iBUxYSTHmGbh/YD0FfB9pmnlB2IWcWyrH2PGm5mRXcn+ZMVgleesXp290kgX?=
 =?us-ascii?Q?ZFBGS4xbVT8WrjASzAqxNOeXJzuNtpsK3dzSmTE1J8NpL3FX70H7T+xsRZgA?=
 =?us-ascii?Q?UR9dezaAfIBY+XkeRvNx9v7FPvBkd6ygt/4xU3v8o0ybSE4JBtI1K5cO4EsN?=
 =?us-ascii?Q?rY19RSIXkP0dOxZxCEcSMg0var0fWNgcUiteQfqdGqL6T3b9Yv3UHUp2gs00?=
 =?us-ascii?Q?SYZSWFvGPnMDfyW6sulVjHGZmae/kYyAPd4ZAmv7ONoJWv48e2VIDMxVbvqa?=
 =?us-ascii?Q?bQi+YjSXhA4HsdHJo8XArl8Nz/+Vzk85sZbVSch+ttEtebDEulDWd13UWqjw?=
 =?us-ascii?Q?Y3WXCF4UwLoFHi77mNeWuoYf+SZHtAUWJCTYEtmXc5jnqZrm42nqbgGefPPs?=
 =?us-ascii?Q?tBQ8kWP029b5S5gXMnvU2zlRqp1Xx4SRe7MXP7GA3Go8ic5JU5qzzEXgvmg9?=
 =?us-ascii?Q?LIO2DjtrcX0jdemcaYLK7eelTigX0D8=3D?=
X-Exchange-RoutingPolicyChecked: QxHd6zGsMeZI6eulCxJ07egSil+90FkXSY6KP5INkC+fCBM5c6NhVqULkHIXfeLJ497OO+Vry9nk7CQehk00SN9EFor//6HZIFb1JYzvP/Uece4JNlXNEtORALPlW3LrCEmMdrEXPo5YTJlEQSBkByYI1uofHyt2FL0opoPaMtWr10CkMvookZBl3CThhR0XGMJAucC1owms01jLtZLTDozy/2VhY+M4TiWiT0L+0GZ9Osyz9u3G3cqIKBaWljNFG4jnWHWZq6e087C3PoT61kjD+MYMFFWKA6aIsU7MLZZWg+acsf8pQGojbE21SqDjLIRs1b73SvTdncTiKDn5NA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97371d01-1e1e-4af5-73e6-08deb643b46c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:45:04.0933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uq11ZmDfUWTYETAW6FvHol9xL1juaaz/MoWmrzkTmDlV4k+O1mfu1id6E8zoCo/x8JSr7aRk1FYZ4Nv8pFUVOTNFspDP8nOeTThkgMjOo5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9755
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

On Tue, May 19, 2026 at 12:43:32PM -0700, Stephen Hemminger wrote:
> On Tue, 19 May 2026 16:05:57 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > This RFC proposed to replace all instances of rte_memcpy in Intel
> > (and former-Intel) net drivers with just regular memcpy. This is
> > done on the basis that the memcpy use is not datapath, but is used
> > for flow configuration, virt-channel (to firmware or PF) messaging
> > and other control path functions.
> 
> Makes sense. You might also want to look for where structure
> assignment can be used instead of memcpy. Keeping data types
> is a good thing.

Yes, it would be nice to use in places. However, it's not a mechanical
change so I've not taken the time to do the analysis. Just a quick set of
sed replacements for this RFC.

/Bruce
