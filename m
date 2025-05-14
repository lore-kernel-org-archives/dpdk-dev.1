Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2CBC3ABCC
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 13:26:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8106F402E5;
	Wed, 14 May 2025 15:26:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id DDE47402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 15:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747229208; x=1778765208;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lkqTYTKdbAYn5T+yUR9FWnCMZp+/R8MbQ8FQxngh8Bs=;
 b=TUtIwWgJJU+4CZXpwxdq4syrFeaCxPLpKgcOJARRwS0N5ATfjiXrSSPn
 2qUNi0bdbT1BGmjGdOnWa/2ftLvHE1FwAWzmVTCif45lzxZtDVAQTsQYK
 vuxtacBe8oB1TR8iznWFzpmaX3InZK8SysjN6WdWSENSd24U9bl6QZR6N
 RETrdMVQvZ/LgSOBb2m6QSvBcTtpvk+aLwlnt9uFmWF3fTEQe5FtE6t5O
 RmcMHU19ksIHB1byl2sg0dOiCfC91EY2P7rhQ+1XIRMPT+eXYnLq2xBwn
 twwgr+U6bnSOF2I3awDD6GBv6HtizHYvwaH9r8CTg2qgeRlM/J8cRzWuL g==;
X-CSE-ConnectionGUID: MK/IsW4vQ1G2J+rTb7CakQ==
X-CSE-MsgGUID: Gufru4mDTB2yIwJXZhD5TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="71629579"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="71629579"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 06:26:46 -0700
X-CSE-ConnectionGUID: V0moFveoTUmidzsxnyDPFQ==
X-CSE-MsgGUID: Yq4h1A5QTT6/Q54TGxSNkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="137926115"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 06:26:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 06:26:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 06:26:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 06:26:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3cw0il2QrgAddHKAL3T9CymkAWXU6sJlxiVnmnGNSgd/8ta8kLty6MPeruFb/TLKbIpoMYKOkdu2QNeBkmNHxpkK0+AZFNblBZyzT87k8DEn1RKTz6CU7BGwO0j/3N6rjh4dEvvnDE6OIgAE/6wrIzg575i6hjE0XPP72HucwBt9l07vtmFFhW5J5li0WPudNsGpydWWppwWtLxldPwsoBZosA0jcNqlqljbb5fh0ZtiywinWigaJjqN8nSMyPHSNj4KYpowOpX+VguSDPZ04HzjR7IF6IJPyfmDpxBM1wxELxrZl+oQLein6cVXERyP/wrBPZUkPIRmCu2Loi63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxQwi0g1+VnWrr/SJSEXp24kQGS1QVGGiaaH9lEQZj4=;
 b=enGMunxqzO5rM28WmtcO/Nv0MYaVtVf5bNC4LF30rfhK/qE8OIiwvsRiMI3D9VYP95qhifL+s8TlJdaMFgXUe6vTyV+FDXgzbMUAT/F1mfr7pDGTUF1ak1qy/IwKJ7gAVtBVomYAxrzALjnzhIv0WsvdslXyu6eqDEb3IcVQ9Qv7CNgWq2Lzju7q31gdRxiJi7aIgN4RQ6Xrh/tlorOhGoQkXodLBkKkAwgvLkZCXezv6+hnn7t8PwnRTK65cJKgtyLpM18bTSWHxVwud7Jn4jPEQx69zJdxHVsquE2GUGvKhX0v6NDCrDEqjz5fduCNMBchrzoxzr7mL4ivZYWf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 13:26:43 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 13:26:43 +0000
Date: Wed, 14 May 2025 14:26:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, "Cristian
 Dumitrescu" <cristian.dumitrescu@intel.com>
Subject: Re: [PATCH v1 1/2] app/testpmd: harmonize case in help strings
Message-ID: <aCSZ-IqhbldWR_it@bricha3-mobl1.ger.corp.intel.com>
References: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0133.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 673fbf2b-173c-43d8-5c56-08dd92eaece4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0GkQP0Rv3JjwTwXL/8bqEWrzcXNPSFTH2mpUFItFqGIidCD6yGAczmC7+kRL?=
 =?us-ascii?Q?NQihpQRVu4nOPNaDfkAd2EAnc9TKuiBqRr5AcY4aCSgLmIP7u6LlEbs6NIhV?=
 =?us-ascii?Q?rfWOgzi/GAxAO76sMXEGBo++NJYNAGzhFFlaWCyugm44dv1pVN+EFF9P16Rv?=
 =?us-ascii?Q?T5DmQJ0eliES1r8vl9B11S5MqT93dStNPkJ5nbqnhpEmT1se2piW3EiubW/A?=
 =?us-ascii?Q?xpUywwN9INX+0nhG8nCvrOK8kkLZuhheVr39+e8vfXnb8AKsKRJ2ETCAz9SW?=
 =?us-ascii?Q?CIVdN4rcHXC40o4o/nNW1Jgi70y+p6xzoVw0zG9MBYh95PGLn9UT84tfyMq9?=
 =?us-ascii?Q?Dgk7M/4ZFz+dLGO2vnCTfsi3REhC26PUhHLLKIYEiObaowKnIuh6zAJ8yEGR?=
 =?us-ascii?Q?W4LiMYj0ElGJkEHeXbqk8Azzmrjtsi1HRqSLZSrECjgQuJ08W+lPnedm834J?=
 =?us-ascii?Q?90vrLLEzqwnYxKwyET9jk9FJHuunOw4LHfzkx8YlzamxA1Epy1uAAQCvfCEi?=
 =?us-ascii?Q?WaXbE8UBe/CCEqrJUr6wgC/Nu/LCBdho9tRqKnpii4s6fkr6vsz/w+gJux7p?=
 =?us-ascii?Q?lcFsspxL1+12uLgsHGhrSycKhDtScTqxMR8KLyBLRTMWT2DqEY8/OYkdafDW?=
 =?us-ascii?Q?QV7oFChPDch7/XayoJV9yW1ziS0vB+yy4yeLtf2w4ZjBclszrnCj3hCZoxNj?=
 =?us-ascii?Q?Lb7q9lxRXP1dbqOwXcSBvht2Hpep+0fSLJwo42edf00wwwAIkEXPSrPaWN8M?=
 =?us-ascii?Q?11WGpRmM4Bz7JrLNVUL2eyt5jp6HUjAHodE41WknpD0oAyvSAKMI8tOzUuvu?=
 =?us-ascii?Q?5ED0kjjgXFh6rXUkiUEYgzMSFITxPi/HiYf+Di+0GdUVsSfhfpgzcjn0fCG9?=
 =?us-ascii?Q?jKqakzHCgrKeoiVxBy98O/Fi/HSiEvcFcwxuHzIwIzkFLZHm2E+kfiKlfFw1?=
 =?us-ascii?Q?uZoFGOf9Zh7as8bplr1Je7MeQdy+rccC5uw8sZfNRyTn57qcnWlBC+ft865P?=
 =?us-ascii?Q?UGHMuzfh4tS0Ozr/+cZ+ag4q5PX/SIJj1woxJutHHooS1xgESzujwLAIKFJB?=
 =?us-ascii?Q?Mqk+tcmRq77PzyEmTesojD9MwDTkRWBkPU/WrSPCZgSKlbbGHjB4XAWtR50w?=
 =?us-ascii?Q?O61uVwbDGaHhCrFDw47NW9nCDJHXE1F1Lc+MBOQ3glSM6KxZBnDJWiG6oXAw?=
 =?us-ascii?Q?nGOlwx5YAnK2dcFqfYe8sQoACYEqzWBr6Aw7d1aCZsfyqxxj6uJI3jFobn3F?=
 =?us-ascii?Q?7+bi4a3FuEb/4wtYzdmJ4vdpc38L+OO6BMZdpU7jdCrkdoMnhUTm1MP/IPjr?=
 =?us-ascii?Q?IXzrOgl9kbxpzuWJvLUOGtpUJUvhW0GotBbj9mVK/cV/Wr0GNfiB4qs/Gdek?=
 =?us-ascii?Q?110o7ucO0743h2y04C3nlH5N+aLLcvB/5qjX0lBWYvk3EfDnjFfMtgEw350O?=
 =?us-ascii?Q?vQ3r9DCk2+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1KTsvjZoSCft2jZqq7XcceBjClmc5ATcogUVGjmC9NwRo9tcWgBiqCYX4AhC?=
 =?us-ascii?Q?/MD+i3UycIBTaYRFTkGK7O/TprG6vRuh8b8xud5dPQkWVd4XMbUsYsHzq/W0?=
 =?us-ascii?Q?8HnHL/SZIjdbczHhCD5vU7hvQ8gK56xKZOePFEcKu7w4/i2nDxu7SWCY+ETb?=
 =?us-ascii?Q?/GA/RfQc63nGpy2QsnWOwE/rbkCc45EGQ7PHs/OLnOt/oj9T+KnES8+uHy+K?=
 =?us-ascii?Q?/yYQw5m68YVkMszj/npaF5076vt+kiQj+aJNbFFfahCsjGqBcmYR+nW3fGTr?=
 =?us-ascii?Q?OiIc0Y97P5OzBd+kxAC6VxqqIOyVDLfAdKOgZUu5pJbHG9LOCAEbyMG3RQRT?=
 =?us-ascii?Q?tuW0ljhEQBZwRH6nCvwa2Rthf82Xwls9dTMS0JacRMv4ppOGmXSZAMsOhBlw?=
 =?us-ascii?Q?IrID1WyEizBTKWrTSKiOZdkc18wKOJrBPSeCvgxVQRkjbwFoN9FWucEhlUiW?=
 =?us-ascii?Q?dyNz83c8jcKAwuAVh5PAQ0FJrnFFQd05zSp2P14KTzcrUO2NrwxHmE1FAG3U?=
 =?us-ascii?Q?6Q4Ixj2eWKiiRtSRPScCEiO682IX0ju1eacRAAYSd23ivhseeYzc/HAOaMqX?=
 =?us-ascii?Q?xyKJGB5ST11MOPurEoQRsBfAiwdLwPfYiC0WtV/eBCVIpww4tX4ucQIMcuJ1?=
 =?us-ascii?Q?APGbI2o5mFxzG6WI0JEnfKcUJRJWol0aMiuGhgMftde8OZg1lvmBwatawtxK?=
 =?us-ascii?Q?VZOKUb8q28pclz2Sr5wbI+iXXFuWp6l0hxMhWXDBNDldCvcZKSwCiB9A0c1A?=
 =?us-ascii?Q?F29GhzLDorEEV/KQLBJOsuH2g9UC7r0IMGTcsFY1GMrnD3baDC8IX+2Rw8/A?=
 =?us-ascii?Q?r+bRJhO1KEkHCiGXD0Wat6Kq613TtD/XBioT56yX1JONZUhlN0SUyP1IV1cV?=
 =?us-ascii?Q?xSh278sShYVB4w5/a8J0wI8taJYYdiD8QolqgvNysbq/QvqN+18P9++uedbc?=
 =?us-ascii?Q?+9EQogbKMb90jkho3MzkSE8+wcnTMQYb087Iqz1Hbrv5VgdKKJ56Dd3Tkt24?=
 =?us-ascii?Q?mX26jBD9EvE28bPuxwVn92emtm0+8RZanB4AptEuSFKsttEgD7ATdT7GIWb9?=
 =?us-ascii?Q?XGhDZQ2BsHlJoulLiNvibFrPZTnpv2fmbYmxR9BA037CrpOO2Z0x8x3szYqG?=
 =?us-ascii?Q?nmzXHfC9Xq6fidrJYxxzBtCm/RH+Ke9YTsAt6av+//f57KiFIxWyQ39XL1Ke?=
 =?us-ascii?Q?tgxPupDBPiJPDM7fKj701PWzaRMavuEPVxWyrLUxAF3gf/NFGLsrcH2Co9ky?=
 =?us-ascii?Q?ZBhcXug+/0rbs4bkJYZYaZY0yjhcEc0oIbD+A7lmX5UBI9XAOcJp0/KR8IuN?=
 =?us-ascii?Q?JVTnlhHjvU/iB+1X92eoCbKJ1Ep2xLbKiBtttxZdJK34i5LgmIDwe5cjKhii?=
 =?us-ascii?Q?vUa/svJcF3MkpfA9d1uCn3+22cATvYSmyfBeC6p7CNzr0R1lTDfQIOxmrMPC?=
 =?us-ascii?Q?aY+RD2YEg8NbRbMNmDZrvyd4VMZCkKrFEXTgB7bOjTv6b3+YQrvqDMZqfBrF?=
 =?us-ascii?Q?NkRsd53EfoFIGQNfw+8qkgygqv6VPkZiHbG6EgIIMJGmHsvT1teQxEXjBvXI?=
 =?us-ascii?Q?f7auqs18oB8lFmCY23m5vK9MVlbDnby+QkoPEv60AE6KG6b8JBUaxeDVxTmX?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 673fbf2b-173c-43d8-5c56-08dd92eaece4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:26:43.2109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC7yrraHhCcmA/Oi+g9vXv8D/gkdqtbpg9vt5+nPDznpBzDrWRVjbumEjXMOun08JbIeM1HwrgNlzVKBa3vzBO0OqSdISLJw0KuqfKAviiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
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

On Wed, May 14, 2025 at 02:02:11PM +0100, Anatoly Burakov wrote:
> Most testpmd help strings are lower case. Amend those that aren't.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  app/test-pmd/cmdline.c    |  4 ++--
>  app/test-pmd/cmdline_tm.c | 36 ++++++++++++++++++------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index d4bb3ec998..a8f1b8ad67 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -8078,7 +8078,7 @@ static cmdline_parse_token_string_t cmd_operate_set_counter_name =
>  static cmdline_parse_inst_t cmd_operate_set_counter = {
>  	.f = cmd_operate_set_counter_parsed,
>  	.data = NULL,
> -	.help_str = "port (port_id) enable|disable <counter_name>",
> +	.help_str = "port <port_id> enable|disable <counter_name>",
>  	.tokens = {
>  		(void *)&cmd_operate_set_counter_port,
>  		(void *)&cmd_operate_set_counter_port_id,
> @@ -9034,7 +9034,7 @@ static cmdline_parse_token_string_t cmd_dump_dump =
>  static cmdline_parse_inst_t cmd_dump = {
>  	.f = cmd_dump_parsed,  /* function to call */
>  	.data = NULL,      /* 2nd arg of func */
> -	.help_str = "Dump status",
> +	.help_str = "dump status",
>  	.tokens = {        /* token list, NULL terminated */
>  		(void *)&cmd_dump_dump,
>  		NULL,
> diff --git a/app/test-pmd/cmdline_tm.c b/app/test-pmd/cmdline_tm.c
> index 7ade91549c..acf86c1ef0 100644
> --- a/app/test-pmd/cmdline_tm.c
> +++ b/app/test-pmd/cmdline_tm.c
> @@ -327,7 +327,7 @@ static void cmd_show_port_tm_cap_parsed(void *parsed_result,
>  cmdline_parse_inst_t cmd_show_port_tm_cap = {
>  	.f = cmd_show_port_tm_cap_parsed,
>  	.data = NULL,
> -	.help_str = "Show Port TM Capabilities",
> +	.help_str = "show port tm capabilities",

Not so certain about this change. Should acronyms like "TM" not be
capitalised, to make it clear they are not normal words?

/Bruce

