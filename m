Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3CF606A32E
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nth946ZA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A899040283;
	Tue, 10 Nov 2026 10:05:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTPS id B33C34027C;
 Tue, 10 Nov 2026 10:05:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794301554; x=1825837554;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NIz3eIPNdm4tVtTs1aDg+8Jaj+3eWF+lZmKgPk0qNug=;
 b=Nth946ZAUTbrefAy7Y8lkwxsqtkdaiqYgMI7SZnjDsHjP1abRKnE6SWr
 rTJIM8hrMSg0918H10AZr0cghPXXymQoZGP/V/w2XVTAi3uVgGzO+IAyu
 HgSAWpPVtPgwV3vVXdRD8w7Fx8jNZLkv9PoDHLSz/ZbkAZYyaQJgGTcQU
 5S4KpNA0jd8z4XxP4mjYiMFMO5/RNAxuLhRieO2hizGEl2cgCqGHOxo8N
 HJMogKDVOEwTp4XzGYi01pcRrwCNRsqpqz/1diqMXPCbgFICO909nuHJh
 3P8RwkiTkOt/mvfxxoTsTDVBvfE8JfC9a+Ez6d2f+jrW8YnNAexafNSCk w==;
X-CSE-ConnectionGUID: YlYZA5oNTgO132FkMMsQzg==
X-CSE-MsgGUID: Cm7cWVC5SpGx2oRm0CVO6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3038811"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3038811"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 01:05:50 -0800
X-CSE-ConnectionGUID: T5Ojc4WUR4iUmkdolZ1DBA==
X-CSE-MsgGUID: wyXlIsuYTRmcUxwesLwtEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7959708"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 01:05:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 01:05:49 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 01:05:49 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 01:05:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMEmzTR2TQHGm5lyQOhOBtBDHfJg2Grs73cmBGnI27k8PUATj9zTGSw81DEnCosxS7aQ+LyEFXv6ssWRIG9QKGp9KENzpUujR2nOHWrNWXGC6q/vUgcZSU/PyrJl1LV2UHy6gKBZ7s7z4n2nDsT2bCl+6eiLdQ/74gYfm/1BvZaj6XOzZoGsA5GncHcXvEtuMoaJn1pvORTUzNFQGOIYTYJ6TGAHIbudliHMHZh1BvG1wh9z+Bm4plK0HFcLlOpaXz0IGUdv/0XjQFtoW7g85UDJCH7+JR4cmvezhFX2xKImv6Y6iewQvTMfqaQSheH6St7F++AzIJ7Ummxu01LizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYde3afvrLhCqhEdOWgFjF3hxAqabC2O8ouHiqddivI=;
 b=fCl/SSD+KLZvNaycBUh3PgxNorB1KrWum9YRfsG+KZ9lZWDYgSg57gRUgNJsaM5CrLwEfwAHebPtoTuvM57vLmR3yLkJojoT1PJqHbXVLciQSJtIjTxZvp9tLGu77mYEQG7fXkkHaOt315oAbVEgDMLxzelgvpglGq4Skz9rdL8HsJb3Cf8wEBE9dUwUdyBy8Unx3x56CNqh1ODIuqTzzyeyy32a6YYBIU3eIWzdSN109jwSM0lDuZ8bHdL68FYaEVY/6NJZRIwSPSDlPdXr175wIE1d6QubuYmyZFvpSqci++qfn72aUs0aMH2eLHzw7kCkx9JGTpgST70OcGoyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SN7PR11MB7638.namprd11.prod.outlook.com (2603:10b6:806:34b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 09:05:47 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 09:05:46 +0000
Date: Tue, 10 Nov 2026 09:05:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Michal Jastrzebski
 <michalx.k.jastrzebski@intel.com>
Subject: Re: [PATCH] examples/qos_sched: fix build with LTO
Message-ID: <avLeZMkDhOH9Hxk2@bricha3-mobl1.ger.corp.intel.com>
References: <20261110020403.419111-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261110020403.419111-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0271.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::27) To BY1PR11MB8080.namprd11.prod.outlook.com
 (2603:10b6:a03:528::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SN7PR11MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: d953a059-e746-4d87-b7be-08df3f09ce2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|56012099006|261028144727099003|10067099003|11063799006|261102123227099003|261022105027099003|261021121427099003|261026140227099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 5571qvyEPHBgVqp+yity/k7h/1ZfAfJJ9Rurv/9dELdVcvKxkdjXSbsPl/W4L3SRZ6KVXZeeUUpbgnTFnW9EiYpuHyhDyrNhcMU6cpF6pj6Xw5Y+bkW07q19Ea5ce5OIdp22WKSFQKwZplt8EbyJ8O2C9mtJ/302t5Vg4TuTpbRUxMrryznZhUqwMLBZv5CmTTzjqWfiT0MzyrSbEzYS/Hjkv3nyxRRp2FWE4laDeaLX9KaOltyWEGcujgZvuvUoRyBcNdiCVNwCEn5TNr4LdmRzr1NqJWHoaJmh9km1vTxlgaJJANO8M8SDYHLljnosNLAigF11NQ586nMXY5TrbjM+4Q87+EFzOpTQYLFCZxD94/yX+K1SliX1pp8y4zaq7z1X8uI36R1d+s36VrKsRzva82cBAYgj+wJncu0aDZNl9876vwEWM/G7Mu8uHfOpcU6jlwaB6J7meGp9uENSiSBWoc0wqGv1G2j0kxD4QwEst9f9FrdSm6yHij12xyHXs0PsGm/omCizweeZk8uQgFkYlGLrIgPr2AGy6acurYX+j7Dir1zcMY/IZoaBZQjzXxs3OQa/yFCs4eklLXUu7fciR0I080faTKogll55ZgIGqPZ3nedWTZ+7biFYWSVRp3kAq9nRsqXFxxcWeJRmPiF8SAja4y5XLpuXBbw/n58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(261028144727099003)(10067099003)(11063799006)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SrXuIcrNLyfV9s8RuBkBlSISmIFQaSreeCQvjhZlyBmi/5QwH4CqLIVCwRFP?=
 =?us-ascii?Q?AolQ7p7UprfWBOIgGCf/Y7Q2dh+qYDAQNOaR4CGDMKyobGOoq/eXI96Xf1AK?=
 =?us-ascii?Q?B7yM598P9ok96w9MCEP+QgRZirIWH0dZb1+VYiBirVlV4EbbXJgqCdMCekxS?=
 =?us-ascii?Q?gDENu2zXv4hvp9WpuVnQTDgK0UjKghhoAfZsN4IuyGi8VP96ivxI6A00xU1y?=
 =?us-ascii?Q?flkpEiW9zwaEUG5f4ZISKk08l20soFVWlcEl4SViiuNFJLa32nMunZDIyvZ6?=
 =?us-ascii?Q?Hw/GBiFO/dvsxlJo/QnvuAImK9LoDmz4LBg53cbSPgOcj3WoH09/MGyoyv7p?=
 =?us-ascii?Q?bigvhXJ9cAzkNwpECRvoVw6nbemp+8YuDRFemSOrNXsZn1Z8LG4jooqK6Zec?=
 =?us-ascii?Q?v1odLTC2LTOU+Frzujyza0TU1FILvkkDsaMTQOCrZvI2cvJyM7E4pxKe6b9x?=
 =?us-ascii?Q?XuksEkvOmLT1R7ycSsmV/ZYreVUZ8uGNSJ7qqtYPUvyEVwVkv2xTIWj7gbiU?=
 =?us-ascii?Q?Fi1OSgn8ffzJmEDVz6QHkF0z5FPVSlZlv2Exr0WtjNbczdjLR9oPyjFuenpd?=
 =?us-ascii?Q?TThCC8pbC7B7KUBKJgAWVPuxGSkbIBuJoR04HILErbbHgWCSNkUiN7+ZfD2Q?=
 =?us-ascii?Q?tIis6rWktrMZi5Fi4bOcPA66wt6wYr8o6CsjShicqD56bxZ6xOAyKRKE2Val?=
 =?us-ascii?Q?gi+uzLV45DF0Hn0BKS8h8wlNd0q3eCLWjgUGdimZrn069JqdjGavamnuROyK?=
 =?us-ascii?Q?hwogN/maQxBWrQpqyspNFosJmRdfJNA+fE9J/xIUsDyjWVKDk7f9afBs3fN3?=
 =?us-ascii?Q?zFYt0hAEx1hnDDROenIMI4hUplL6lwOV1aGyF5q9Ge5zGIjHT0idfh0nMcEq?=
 =?us-ascii?Q?IcdelBjariLxtKB5YnS+FllqhEw4t0L9Jtit5ZBxejzq6dJ5Crp3O8M76Lv1?=
 =?us-ascii?Q?OL/hCmd7XZopeqxXIbwBMH7T6qqR3NAYS0JJ0FkHBX6DSxTmk6IIpsH4BF+N?=
 =?us-ascii?Q?lscPflWJHosaQHKMafN2zeGAmsScLXkwiMBLyyHt4j+twqwfXUHNDiwg9XAI?=
 =?us-ascii?Q?V0vHLAW1Hle2zxgb6EVOQ33CNZ8z9KZJyRsQ7IIhvJlEuMxyQG/q2r9kCh2e?=
 =?us-ascii?Q?pLHmGWt3D6KKmEFNPBKBIDHRZt5FDJ8zhLz0AVD6IS0w5VEUZ3edFqYB1xMu?=
 =?us-ascii?Q?uCCPK0DndX1P79rpfWZIzKWhZ9+edIKpRcqsolvwB2alsTjqmnjocJbbZq6U?=
 =?us-ascii?Q?tGgLDNuSbU8cTlApPbN/JjcfVZMZfwwJDFk/p4leJCL6E02y06jc3eZ8rbDE?=
 =?us-ascii?Q?MQabHiC3nyvgI/AtOOnRxgPCuiP0ggJgQfIStcQc6NKj+N3lEncwvne2Lkym?=
 =?us-ascii?Q?cQH9uZXlhjpBhxzXY+S45nc3ncB1G0YPxePJFB6ob3s0DSWkMhnkLLOqm+1a?=
 =?us-ascii?Q?9c1dHyImBZYU/Pih0i8K4IZVbPvansRyoqQ7ZkuZWiZDMZfD8kHlLg7m+Lgk?=
 =?us-ascii?Q?LIzZgcOccgb+7O1qU8LfHEeMEYet+7d5ULjEfJmgbD2gggmCoGf0GUbFxVxM?=
 =?us-ascii?Q?fNh4C6Z61zhqmeVlnXys5y3ekeYvgt4Jzu8BUeCZpTGksQWMowL5C9pjb61O?=
 =?us-ascii?Q?aaUYn4G23zU8msXblvdzgh34T3th/FhDrTxeUu7UKQfVoE1ge5n7enCxjj2h?=
 =?us-ascii?Q?rIhXPG/Oda07kChVR/4XmUMbPBF4+wydSqE6tLTcZHhDaAmvoQXTtbNTB7a2?=
 =?us-ascii?Q?6fhidZtxH8M5kVDk1WqEuUGwyuXXuas=3D?=
X-Exchange-RoutingPolicyChecked: csn9G71qd4OrI0V5HznpC8RYI7+7wIucavHQM3in0yyO7WD7jIjhtjrpa6UklOSTDlam2uDv0qN69Pfx6jGeBMz0t0RfT7/GfXLpdasg6BqJGsQDgUy+HNP8h1zTSK6FRbFBEhUhk2VUbce0UebjQLiAjps3Jpx+td6y+aWuvtzt6BSmb+MGhW299QWz3rElezIT9Rqn2Ostt6YfmKOrXLHiNgc22/SqDrOP5/h7KmbIMIlyRnp0ezv/nFjKj2eVTE3zYX+oyFuwhjfHbYhjH3Zn+f+n9SoD1/OKrMX6fXw2KFIqk2mpC2m/fCuI2C90LQF/rKkO0zRnhjHmklvQ/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d953a059-e746-4d87-b7be-08df3f09ce2c
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8080.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:05:46.2560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYVn0HASlypE6IyPHvMH+pmxU7Ewg9802UUZpaomyoXDgvgNf3Z697D1lH6wRE3xu6rLM6Y8ghK3TxEuaLR+5nmsngZenj6vLf3yS66Arec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7638
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

On Mon, Nov 09, 2026 at 06:04:03PM -0800, Stephen Hemminger wrote:
> rte_cfgfile_section_num_entries() returns -1 on error, which is used
> unchecked as a VLA size. With LTO gcc inlines the library call, sees
> the -1 path and fails with -Wvla-larger-than.
> 
> Return error if the entry count is negative.
> 
> Fixes: db935d0171dd ("examples/qos_sched: use librte_cfgfile")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  examples/qos_sched/cfg_file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/examples/qos_sched/cfg_file.c b/examples/qos_sched/cfg_file.c
> index 3ca06c2ff9..e73d9f7cdd 100644
> --- a/examples/qos_sched/cfg_file.c
> +++ b/examples/qos_sched/cfg_file.c
> @@ -438,6 +438,9 @@ cfg_load_subport(struct rte_cfgfile *cfg)
>  			}
>  
>  			int n_entries = rte_cfgfile_section_num_entries(cfg, sec_name);
> +			if (n_entries < 0)
> +				return -1;
> +
>  			struct rte_cfgfile_entry entries[n_entries];

In practice I don't think that error case can occur, since an earlier check
verifies that the section exists. However, the check is harmless and not on
a fast-path.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

