Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A3606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0Ey5zU0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BBC640B9F;
	Wed,  4 Nov 2026 17:45:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 3B00240281;
 Wed,  4 Nov 2026 17:45:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793810712; x=1825346712;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CO64nM27XCUs73ocASoSGITh8rCldvuEkF2yto9dIVA=;
 b=F0Ey5zU0LB9tlb3yeL9+zmLliDoxL++I3c6zO/F2ZXTdSOPORmgHnvA3
 pdCNAUkh6SRVrTPAfX3PC/enzQexYHrrtxtn0aIK34xUZCtYHZLZPr/Fw
 DvvzCnS+MHFZGaUTeQHyidf2TpGTFZHfIAifwGfRq/nkEhRymZEbaddma
 bdy75aLgGj2U/iNjkEsR9W3T/hp4J8U/0LKczXjc4YT6OiGEq3X84P9Ij
 KlRC4+1Lv3yNOCHFtexTpWYYDmqOPyAR+SO+3hONtnwqTFrKPwTPjXq+P
 ULMly+4KHYA3BpBmR0C9UalD2migWNplURSeD+hhiUWMHrr3Tpg/rXiQU w==;
X-CSE-ConnectionGUID: 8Q4P8pNHQouIiZ775bgfXg==
X-CSE-MsgGUID: NKlub8xjTWaF5+uCcjdetQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2453721"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2453721"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:45:09 -0800
X-CSE-ConnectionGUID: y0mLnZoSQpKH9nVnJoVAhg==
X-CSE-MsgGUID: lbUR7HUXTBWQmdq+3Bji8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7110750"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:45:09 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:45:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 08:45:08 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:45:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bClRKQMn0QC6fUrU+kbXK7xVsJde5OmQwJXgKlNvPKTZUt1pL3L6IBiwCCq8cXnHYEopnMDJTNl8xlZ82EVuM+LWx0cBhZ0J/D+WurzZC8oX8WAcbhfnwCVobiuUjOywuP7B/wQiCTo2dILNML6O6aVZqttR77EbKcLiAgT96xRORRuGtbQWjj/06NQCdFNzfZyee8unBj8KZ52wpZJMAhiT/uLpwvTo421ompP0s11xkOLx0KHVZuB9xzBsFuXo8qjcomoINsJvQ/d7BD9R5lECPReuGVQ3dp3u7yu6L6oLi3Rlg+Bkz+zI2aMVAsPssnChHCfCAGM20+HmkNHyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkd0VlqAOnFuo+tGS7D5ZKuVFeOF3axPJYlPfQYvWTc=;
 b=VNwet3825r/w4ZBEOGFTRyfdbqZfY63Y1zybyXkNGVhwvc3gnTkFgo1bvlpE0zOc4Sjn9HmASothoT02Oo7NvWDn0XliHDEXkXm3XGnk54yxirqe5pFQwmK3wUn5Z46Xd5kPmoWR89vX5dSkhfQqG+Mq8UB90ZfXRiLrlbJBaBV0sdmGB/rZ4pvrl37iQlbgyH0UD7Maia2X/C+AAfF9B19kbQwW5V1kdn6SBv1lNsmJi93etUncoWcnsvCVdemqYrlkGQMoNOdK9e9SKLrYFLFlaz7Jmc+5O0zZE3SYxwHCWIAl3nKMTgNm8Rktb02xLFZ0b/phdpRieoyatwxTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB9534.namprd11.prod.outlook.com (2603:10b6:510:39f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:45:06 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:45:05 +0000
Date: Wed, 4 Nov 2026 16:45:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 7/7] net/ice: fix ACL profile segment leak
Message-ID: <authDLlTqOsh5iqj@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793605751.git.anurag.mandal@intel.com>
 <cd2ce57505b7d39def1658b940a1087ae627aceb.1793605752.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd2ce57505b7d39def1658b940a1087ae627aceb.1793605752.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DB8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::35) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: 9015ba1c-dcb2-48f8-b635-08df3a92fa6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022113327099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: roBOMuLNoeF2/3yeF737t5i4iFpgE+gjRRcMSu7cFGfJiGfKy21BQM7a/9AYg1Un9wFci8wXAbwBiCy1D0XOWcj99UvJUa4FOe+M2VDCbv5esRJpEVDuDeMR9MvsLq5ld8tv+C+FZytssHwyAxT8yzYfQBTUbH5Dmd1uKbLs8iHmH0xfxqUWwng09O1SP74CplGIoVwHReam2cN/slneOG64Qtxkcg2/Z6BdyceYt1Z3AbO5+2b6tPkXu2eb4bOTkd6+0uQW71m2VP6PUJ/tRoV/wDju3KOEuDb7YsymZXFyfMLRD2sGKnNutlUIAD7sAz3y6gPQJRcGssoSGgAKl56uAmXdUabIKe5oE3pa8ZFf0vhEboIKD0Qo3W2CBheGMeasjYGW2fiI5sHfVC+UlL8YFcnuJcvTlWKk+Blo/vjF+HVWNUVybUb1/tMCJy9fYBGLHieRtNpo1vbDsBuIiR0Z4sT7ezktRrfaQgPh+P4RaABGYfJxvih94g5/UBJTPWCL9zTaPvVaGj8lbJafMR9RSbyvEWEU6Sn6vBtyNP58MJgOhW28OboNEDM3Luo2XxGPGsj8p06gJJv1WQNPR0rCH5fEw2UM5DJvjOwKUJ+EuHTBfoV4w19xSpVJK1NTTE6cA2jRlm5i8XYwFeQZH3BNBN1s+jZOmjevO35sVKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022113327099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xNQEDONPBNx+2sx8VyWnNV2Tx5LVrcljwVue7IfknC45otVQsqx05RhV2LFg?=
 =?us-ascii?Q?dNstFbYViBil8imv/f7hLuiScc8cnEqNNR6+qiVAn6xF3P+RVnEz/q8Xw9If?=
 =?us-ascii?Q?BBunA4HKW/qqPChk2FrLMjURKLn5TvIra7Ii7eVSwU+cq/t9Nqs/kq3B0/OE?=
 =?us-ascii?Q?hcleIlwQNuRI7yysQ0HGNpWYlXadcrltu/hu9+6PMirsKfJ/uk8KSQjulvD2?=
 =?us-ascii?Q?k1u9MxWABocZK0M08TPe7A+0osZqodfB63xjQZzzbE1MIvYNBvMuHHfez8GO?=
 =?us-ascii?Q?6sSBsgXzxdAOLblrTGItSXF6/8eTe+DkCxpm2ce/UgQhm0cXuyRywq1SjOR2?=
 =?us-ascii?Q?SLFAqqhV+vApsc0gjpWJz1dSCdNl1kiHSa6BnG+Rlbn1NfSlQGt+TW0/8BY7?=
 =?us-ascii?Q?HmYaSkHAFkOWgEPK+D0CRqNm9ST8L4JsCVuZ5SyVUjYF67IUTYPjyNbEtEbf?=
 =?us-ascii?Q?YHXbvaN5e5ogVsdInU1SMlJy3vQYK1BQNMp3QeMwz+E/fB+VPtp4rK3+Ualh?=
 =?us-ascii?Q?kLcFJzNGRLA1h+pmwbqA74F6SmhaF49cm4VWggYVxVadsJBLEnq//8Ua7Vd7?=
 =?us-ascii?Q?SwIW5eNzUTMUdkiNLVhokTs0Gtwz10tgksouNjf/jw3PDji6zhT1UYX56t93?=
 =?us-ascii?Q?Vw302VanWLnDRgqlNjzFb773ZNtSF2VlDgbnaG9IkNiHydHgSPPGRF+Woh77?=
 =?us-ascii?Q?Ze5L1dt0N9mTVRRx/eYLC3aRrqXYNg84gBwmmMDBUBZtUgxpfxjf7nkfJvk3?=
 =?us-ascii?Q?Ow44RKPAWn9CJfMyesungi7+6sO9FHLIEby+GxjYptxu61ja09fIGraW4Q//?=
 =?us-ascii?Q?59va/C7pTZcuz6upj9PFrDnlnn++6gg/1Kp8QQkT6u3sKLvGEDjaNGsbBUDc?=
 =?us-ascii?Q?r+Nwnhz+AuXfl/aFUeGaEyo436P14kz+1j0P/1xfQIcG3a7t2pnScFqRC80G?=
 =?us-ascii?Q?1Y6kIJjDNT2tfhSpHWqYDLycnVexkeIw/DjVpVoGOXW2sUXgPJ62L89rTP8d?=
 =?us-ascii?Q?ur7Azh0le4EEIscj+33Cn+lk2KFi55r3zOVChyPL92Fk8WsG+SsT4hapSmqn?=
 =?us-ascii?Q?U1aOgFQhggSB/gN2NNru6f3MFGEIVNUNsZ20tQ/zFF3pZlOk2aScxP+X5b+T?=
 =?us-ascii?Q?tO3KqpJvCcgrununfmJHlaA5aG4dywD2ZqFKojQbpB7vrF2fDThStmJe39EF?=
 =?us-ascii?Q?g/B6AfksV38f52Kv2NgTKc/+gTilzhQFBIcQtJatsxh9OxI5GQI3hlrCwivI?=
 =?us-ascii?Q?y7twzA93mQwHd/oaDyV/bw/egjUnwp2qiGL8er3JfsiOLe0H+pTpVW+QsSeg?=
 =?us-ascii?Q?Wf4Ud7WF3BCkMkGrV4/ETwrW8kXTDWCqu98Z7PzMOxlqa1XEE++KbJ3hW6iA?=
 =?us-ascii?Q?PCuQrLMGIn7phDIzdLvx4U0B7LT0/wshEIDbVws+/MtQ42ERVdPysGpWquLl?=
 =?us-ascii?Q?SdQZoAvnH3W7CP5OvHMpRwU2yL2QLz30jU+4R/7GO6Wwe0xLV+rXNObyNAd0?=
 =?us-ascii?Q?QhTtwnSVUo8SwwIqVpiqMM2ldb/6iz8Zad+fJJTNds7r/dOpP6FU6PztCjuz?=
 =?us-ascii?Q?sYIBloKzvHtXy5xBjgfIsLOVSqU4igpQdp4p34qUoiaEK2zakQO7axZV7WrD?=
 =?us-ascii?Q?BYmrYR1SG27P+DieveyIzOCv/R/Y/mhPPFS2Jx6YhT1Z0Ky109jIRStXkyOw?=
 =?us-ascii?Q?ReLMA8H4UkaOL7vT47P/JeYlonKxovu94mFvqJaV0HwkQoK7TAFQKljKlWqZ?=
 =?us-ascii?Q?80QBm109otfyiMhPksFVdaddyGPIsg8=3D?=
X-Exchange-RoutingPolicyChecked: i0gV+3uehQy32gghP8fwnO9mEGYs9kctuAWiGCYhbwVLag180x3+gXx5zPJsGXa8y85JyPjqoBJ1/I/X3rNvCKBYaimDUY7TK/CIxX+to5iDzj0YQN0KN/bf6K0HsrkXX/BD5oLz3RSLMQ+JQS7EVD6snxkSwdX8notKd7WWr+vpR/Uqyh8nfwx3WM0taO7qUBZZlPNz2uevsCd0tAXjI+dHcagbSh+m0snmRXRviVXwpmKIE1bYMCJAUQwt1+Mf6gyjLGFSMNsekUmm/2qMn1+MqvbJFwA6tkz0VeyU6bnWAPkeOYaD5MDsH9FYqW0thYuLoR57BQZU6S0IfhwI+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9015ba1c-dcb2-48f8-b635-08df3a92fa6a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:45:05.5522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59xCf2b3J0poEst6ktmf2kJ1dNw3V+LyAufia42rPLgO5iRI5srsao6/+l22df78FLYZMygcBPsiQ+yXj6qsmTKa2Odyru3joxuH4UCFkZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9534
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 08:10:37AM +0000, Anurag Mandal wrote:
> ice_acl_prof_init() allocates a flow segment to add the ACL profiles,
> but only frees it on the error path, so it leaks on every ACL engine
> init.
> 
> ice_flow_add_prof() copies the segments, so the buffer is only needed
> while adding the profiles.
> 
> Allocate it on the stack instead, which removes the need to free it.
> 
> Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_acl_filter.c | 46 +++++++++++---------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
