Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7C1C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 10:31:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A95342EBD;
	Fri, 20 Jun 2025 12:31:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D6309400D7
 for <dev@dpdk.org>; Fri, 20 Jun 2025 12:31:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750415515; x=1781951515;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=R9MC14vZwloIzr0iOS9WsLZADOihv1XJ2lAIkdvidWU=;
 b=Y8wbsbs81p5XA+3bqoTBreRZuM/Ry/jNlVZZ5a2XcF+5e49RC32LgpFA
 SF4+f5XbHd1r32VIMHKA3cKiAuDb4Q8IW4KFBqnhzXlQor1TELmCLnoFr
 R7I91/kQC6STowGjYb2Cq660oTI3Hti31lUxfB0CCVq9U/23Z4XgADoKy
 Vmka1eWnoABJEb6qNPLOaBCdmb3B/ZQ+UlsHBqQdL7KaFT8wEwel+ufyW
 3bXHo5nPU0VH3jRR2GPzGwNJQGirnrvZqGb6eN3oY4avmO6OuNsxlmxhl
 RwTnjHL2VetQ5nTRzMh0q9p4Mtc5PJKqDbl7ALpWNCwE67/atIm3ZFj3f A==;
X-CSE-ConnectionGUID: g+KGQqodRUyQ3gJns0H6Yw==
X-CSE-MsgGUID: XXIs30LQTxS3f9f+BQN3rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63363888"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="63363888"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 03:31:54 -0700
X-CSE-ConnectionGUID: 694uYs+ERKGwuAj24OI7Ng==
X-CSE-MsgGUID: 0JKjPPqaS/GVrkBBTbkEpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="151420902"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 03:31:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 03:31:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 03:31:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 03:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGAY7avu9q5fwq3s72Tl2aGmLEdu+3RbMdVybjoZ91wVW6jhSM1JuL+P2npydRp4szOPScrgv9Dfex4x3B/MT60ce/zjRd1Ehrho1l1178FjrmUMY1rmsr18uyQvk1dmTdiH2GTY2OaF2gdYNP78T8Ff/7KHuffLuBwinwBvsty6L8aeybPreGfHUDGUhYDMI3GlANHSENYHSzukreZOwuKm+Se0Pe7/5nNF7GbGianXUhRCkbuLz/PUtsiWZxSW3YA6lT8D6fEs4Ko+b8526glhDPPuHA1BcbWa7Mn6P4uoNsok6ZwiAF3BMiJWNcU88vto3Fhco+cMmZgSIXv/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8zkbHeiQ+ReiWyIofi93a7H+OGZJ282llet3j1FoVo=;
 b=NKcPJ07mVLtW8994xTh6Gq65VKJct8Wx/k8+u+UeZZBraSXkexW2XriV+ok8yDk9GGIX6KHnPbbXcLTqoB5nJTIl9cwyBLGvgI9PlKIvQY8t5Tz8gJ5mN31f0WNL4UC5SXsfYEl/CkWhfR68kjX5kONHpo/2dJlJG5FK0uuLOuxbW/ixp1YxzPIUWD/NxaC+LWI/nQR3SO4wAkaVzkcm7C4lNNymwTIFtXaGnOAsEGgbB1htUcaxMik49vTKWelCTBPuAyMi/Kua3gePTIAlsyqHJzGyQpqFEK3XfrjQIzNjXqrR4RSFoQkd+9e7r5HfvY83wD92s6pdJUHlgHssjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 10:31:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Fri, 20 Jun 2025
 10:31:50 +0000
Date: Fri, 20 Jun 2025 11:31:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: RTE_ETH_RSS_IP support by Intel NIC drivers
Message-ID: <aFU4kWSK5mn4XPmS@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD17@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD17@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0174.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca08e7b-fbd7-4051-60e5-08ddafe5aabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?XwpSUTcs+gN/QAI9YGK7eRDfE295C5abgkmTtUxREzM+pdKM/hGx+ZOIYO?=
 =?iso-8859-1?Q?KWmbLvU0dgEBLC9k26D6H4rb/TFlN19IA7MH8qUWG2TknWvoViyLjyboan?=
 =?iso-8859-1?Q?3enGf7NrT7WS/DcF9GuLmgeKMQAILuXbHtS/QerBO+unIKdhCTHnmvjWfe?=
 =?iso-8859-1?Q?3zrjsFwQlw3PY5xKLEe7ZdT/fIs0FIOvI6PDAAjWNr5Swr3BysGZJnOEXA?=
 =?iso-8859-1?Q?W3l0nj3DojkK943WMuai9WMEXokFcSPAZ2Q4lMQKK8ZlJrIE+8TZc4wUou?=
 =?iso-8859-1?Q?5xkS3hcuPflu2B4AxvzA18gMU/EK1SzIPNW3tFLr1PgwOSIS4bLEmGqf0U?=
 =?iso-8859-1?Q?tp3fl31T4/5GS66sCMiQtpvDaclfDAK4DNctSLeu9k7rr53U4mBykJrjOx?=
 =?iso-8859-1?Q?S7iLQ0s77dM+W3zvF2hh09av4Fei/fGO4fupR2CY728aZ+dqImmxI/2V8T?=
 =?iso-8859-1?Q?5z4TBEzu7bNViwigdZ28P1Lr1G1sqbK0nXbxqSWRq3W+9KkixBYXLvr98j?=
 =?iso-8859-1?Q?GrNv+38dB/CYQ5CsWs1H5cClYQfixCohGH9/1mQLwaiosSvoNa4lbFX2lH?=
 =?iso-8859-1?Q?RyNCisAZEyVcS3PxhSxqIsmy2lQWVDk1gt7KrresGwUjSSE5bIAnaSUUIw?=
 =?iso-8859-1?Q?O3qbPaTecg62Z6iVawfDrESUKdTwFB4wlLErKxwb/ET5XN2Qld9AFygODC?=
 =?iso-8859-1?Q?cYj35Co9Tq5wkxx01NZzLwuzGxMzuvJGGTMT02gmnW8XrOC7ARexJHsrcc?=
 =?iso-8859-1?Q?/h2KXacFkLx9hISbOOyWYO1p3ML8tZRpyMTHFjFbXMGmtvedBjr2W6Lslt?=
 =?iso-8859-1?Q?3md0SQpIGa5rweyCnNiGlmFpIQn4x/cqC2fE8lZ/9s3wRfvL4CWBjHjBds?=
 =?iso-8859-1?Q?Hy2d2Gi1UP6IO89WRi9dvntMK9d2UPiC9rUKKOzjWgjtGLvaxCjVy8Oph6?=
 =?iso-8859-1?Q?uneoruXHZaHr9i3xsFM94w1ypqvwBzJtBnR0EYM8zeH4nRTSX0lhfbATkV?=
 =?iso-8859-1?Q?tOXnAd4sOT/vUKmzKMO57yqU/po1LlXpY+ptveNUUmzFJFpTB1Pc+UGVvo?=
 =?iso-8859-1?Q?N/h99f4WS/Qo7/p1xkzJWjVj/lL4O6LSUNwD7g+p18U4/m1yCWFpHBX8fL?=
 =?iso-8859-1?Q?07R13JBOIpwnytrYfnqgYZ4mMDCuwKQVyNEkcfeM9+WkZlzkBkSNyNwu0n?=
 =?iso-8859-1?Q?z9VTodjoro36i+9ANUfs/E0EahvrEi7qKT2fw00f6r81LvDISqH7vO09SW?=
 =?iso-8859-1?Q?WC+Zt7t3Wbjj3oxWIeC/vGw5TSYqpFl4wt9eMuV5beW6QGyMZWFw3aF1YQ?=
 =?iso-8859-1?Q?Mn8ktZRSJhJTJi2uBkSMRfK+4Gln6RN7ohrc06EpVfHmTOzAS+RAWAU2e1?=
 =?iso-8859-1?Q?vhyDZF4JvmgbddvFRA9xLHL+pxGvEe+TE01q4Aseh3t5PShNKDpEM4q1BC?=
 =?iso-8859-1?Q?nfx92r0KDjsEHFsS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?W9b/8tt686HNLsOidjJt328Cz0oFt9GTQBXr/k/g12orqmIeRRIXaHfHcI?=
 =?iso-8859-1?Q?8+k93hik1OlKTkfZjwhph0Wv8h3Q3lmjCMgj3UiEckDLaY+jC8s0frYMiG?=
 =?iso-8859-1?Q?/aZbYp4IY0Bcil+rATg+YU856aJpLkZyEefgHDrbZx4/m7nlatOWoI0ccX?=
 =?iso-8859-1?Q?KBfleZfCwUwRDkyUIX0X19jamOhM08pVsOICzRirMbMo9qYw2q5VmJJezn?=
 =?iso-8859-1?Q?nK+6lajRgQkblujKjZ8Te8+4vWUHadwvxndi1Ko3vdFk+2i1qdT08q9wQ6?=
 =?iso-8859-1?Q?nAgFh9uDUgP1WDNsr3x97W0zeaitnCWW4tFx5AOYMraNtfffWqT/i6vtJU?=
 =?iso-8859-1?Q?iSYwPjKTBkiDIWjms7strcCieoinLoHY5OUnu1z17suouxnPYrYZrqqCkj?=
 =?iso-8859-1?Q?YP059zeQD2s29nlqQt9ezyfMPYMgY546KCN8ocN4qOxrODstmFjadKULUy?=
 =?iso-8859-1?Q?C/BH9gQhKkVbIoOKIOPEK91Es5/9xwJqwqX6w7yvkAHuKr7mWDsquGcW4J?=
 =?iso-8859-1?Q?ZtSFATicFJ3oExgSrlhADiKSIWK0LBXHBaGH46W0ljewKFXFFAwC/3zVUM?=
 =?iso-8859-1?Q?SnkIZWFpWYyPKh0kChAGvlHqKrOhF1/YThRiMtfJ2b7o86qmQWej/ndTbK?=
 =?iso-8859-1?Q?6QPt7QTYhl6wVZEvkUm+UZIkQlmTpxcXAjIIVQcNYeDrFLTmjyDizkiBCb?=
 =?iso-8859-1?Q?BvuQPxw24jQuCL07rglfFVw/DhWQ35gDxR4EunRz3AJIrBmi+bhJYHn5io?=
 =?iso-8859-1?Q?ahvxcGvESnstpoZ+bKAyydteaUAjIxRJ7qfmoNW7IqvyGZkXJ8YHGxo6EB?=
 =?iso-8859-1?Q?Wa//so+CLqLIfj1l+qEONRUz/eB1sHi8TBy1lVY2R/keDo/Kb0iJc0s8W4?=
 =?iso-8859-1?Q?6xlyX3GLM425F3lfWhepGyWDkJb3YD6Z9RIHI3G/+kqw/oGG0iOZYfsLys?=
 =?iso-8859-1?Q?CPgqEdtdw7IlJwfyBD5LiccgFY1KkCtzWfcqVYX3GbBgJIWScqYpxOUHca?=
 =?iso-8859-1?Q?F8V3Fgu0aXBHvX52MZq5dGTKGlXwbDKHT9pC7E06bSIFhQgQkYJOP74A2k?=
 =?iso-8859-1?Q?BDqBZWUwTnIQOwPVYaTQqr7XnKnyWoG4+wwtM3QA8HZPx0O6iS46UynA9s?=
 =?iso-8859-1?Q?dC+pxyzh96HNmjsW8zVwpxHjIbmQwR5hsY+QdGqoK+Lue8lAoKf4vg30yY?=
 =?iso-8859-1?Q?T+TcuBw8ms+9sRvw5wDE3n3nd8mbXQzykuPm1noSvLSugDCaTequQziL06?=
 =?iso-8859-1?Q?FBDLRzQpcJaW2iDLXN0JJYAAbhuGi3DkhpnKO+rCY2FZeIrUzfq06IMpYH?=
 =?iso-8859-1?Q?yppy2w6nOi9teIVKZ3NMPsgwbAunKyn6xUU0IRACmHJKCZRgN9WU4zq6e4?=
 =?iso-8859-1?Q?y450INjpK+0ePzwt/UmwPeXlekEuvVl3vpPhuo3oW7yXTxGqwTz1ZIKEN0?=
 =?iso-8859-1?Q?CCfqxHuQZG6ocl7Hh3ri+j1aWbWbst5S0QTrXqtXzOORH/9T+43CcMGuWa?=
 =?iso-8859-1?Q?EL936yET/Jtgb1ZeY946ptWcLjnFaAIvtEeLPMaE8/W7cjxXiko6acV0OB?=
 =?iso-8859-1?Q?XN/nYKS19zPMcxxrKd21YQ7unHP7cuCJgMZvzYD+ZmBroxEe/URXMoHKD3?=
 =?iso-8859-1?Q?V7nNkOYJH2FBAPIHyeuLFtadk9rD2pdEJtkSVyhHuW4MSknRcmcNRjAw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca08e7b-fbd7-4051-60e5-08ddafe5aabc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:31:50.5427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fiWGPfWTOgx+cSUUlIc2j4X2tCus0dE26zFm1ZfrokbdzRsyQTKQxjruH8h0LE2qji5g+GrHrjyI9gIBxwnf9xzteqHYDc0NITaddSBtKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
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

On Fri, Jun 20, 2025 at 12:24:24PM +0200, Morten Brørup wrote:
> Don't the Intel i40e and e1000 drivers support RSS on IP addresses [1]?
> It looks like they do, but don't report it.
> 
> For i40e:
> Accepted: 0x2288 FRAG_IPV4 NONFRAG_IPV4_OTHER FRAG_IPV6 NONFRAG_IPV6_OTHER
> Unsupported: 0x8104 IPV4 IPV6 IPV6_EX
> 

That looks like a miss on our part. I'll log an internal bug and we can
investigate.

> For e1000:
> Accepted: 0x8104 IPV4 IPV6 IPV6_EX
> Unsupported: 0x2288 FRAG_IPV4 NONFRAG_IPV4_OTHER FRAG_IPV6 NONFRAG_IPV6_OTHER
> 

The e1000 driver, is actually a small collection of slightly different, but
related drivers for 1G HW - some of which are quite basic. I'm not sure
what the specific capabilities of the various HW NICs are, but again, we'll
take a look and see if we are missing some things.

> The RSS offload types [2] have no descriptions, so it's hard to guess which alternatives would be viable.
> 
> [1]: https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/rte_ethdev.h#L783
> [2]: https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/rte_ethdev.h#L553
> 
> -Morten
> 
