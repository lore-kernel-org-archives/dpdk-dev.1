Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC682606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MQLq/JUl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B62740297;
	Fri,  6 Nov 2026 09:46:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id D63694026A
 for <dev@dpdk.org>; Fri,  6 Nov 2026 09:46:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793954808; x=1825490808;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=esIWzQsTTFmaUxc8KI8ZIp6eoZ/zwpcVLeErhZogjks=;
 b=MQLq/JUlz03S7nDPQzA8RQK2djnB+Q9nQZ8/eIyEq70+nE7MNrsWMfyM
 ZnybX+5GOtshFX3CqkwmDXejCFd+T+O6OIZqmeZHubgKW04aCniWSJHzT
 RLyaVOoa6RAtD+x1dhme5GmO/4TkNzKTKwFNIDemuylx/ezwfVrdGa946
 39XGcO3RC8lpJlsCBsGWcLPwOx66oD6MR5/sBTI8lrJLV4zpymCgE3jMG
 wR2vnbiKVVEGxt6cO8SEnaJn95XNhXjeENHNZSqX5QMhEuiDlqnF+1YFW
 3IlVXY0x/fbODRMnqvM6H4NQyn8jpJ/T1AgUx3Aiq/dSLmHxjl3aio+gN w==;
X-CSE-ConnectionGUID: ptZFAr/5Tc2drSNSA0akKg==
X-CSE-MsgGUID: 5Fri6yt/RYeCbrFGsoLW5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2791261"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2791261"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 00:46:46 -0800
X-CSE-ConnectionGUID: UNqM3hmPTG6rmHFbg/LDlw==
X-CSE-MsgGUID: NNmdxoGRTGSUkhgwpANDsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7395758"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 00:46:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 00:46:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 00:46:45 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.12)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 00:46:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpJGy4r3nQKEjZOWIHrTgYt8/aAaLcyDkmC7C0rwCzCoB5wIMwSRKCx3Nrkwxc1nIy05vhsoWFBkIg7w2Hz9fTwbSzWAz5EMYnYtVA2/vjJ4npkwVDVy6pEdpStv6jxP8sHHw6ZWRNBzzMLyV+i1+ZAJnLK7UUogcqSkq3vEZLE1ijKZV357di0eeVmTYlYAeI0QJVKCwxnG13eTqH4zGG90VXjqGbO+sMTyFB0R5sARtrROB3eikIutKscDg3iq/jSreMAaJSR1k3Kw2DvTSesratgsJyqPgSScXhoz2W+MLJGaLmnC2H9lDBVhnRhHTK2rTjmvCVxaajkiUg7vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoyvBFE7XeII3tA0RHplBFNC+/E5JaF02+0pVP3PavE=;
 b=Wke+X1PagSN2k8nq9Px0qSf4Db21UOANVsU6tX0fjPhAItOVPdOig4prDrT4EhHK4FzY5yP09FeaJL8TsK5bbl2G21iVBvpkg7KozmfGs44fmRgVPdWtstpwycr0sQ9OOg2GRvjnrrX0hmHXs2PdI47T1lXWguhnak+DfOGROhVqIekuip7ohRKFtDSA3BRPtJmuu1TRhJame+i085q4t9gbQS7W1i7X6rgas/6lF4i4uiWy1k1wG8C9K2ub7NKiwIuWP9gAdbGd7/tX3flwB409s07iBAT01Cm/j9XbdAW6d9/Sf5ukT4FAkKzzF32h5vHOdGWWjX6zrBJLFY6WpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SAWPR11MB9733.namprd11.prod.outlook.com (2603:10b6:806:4ca::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 08:46:38 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 08:46:38 +0000
Date: Fri, 6 Nov 2026 08:46:32 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Chengwen Feng <chengwen.feng@linux.dev>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 0/2] use NUMA node terminology
Message-ID: <au2T6IClba6Ggpwg@bricha3-mobl1.ger.corp.intel.com>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <20261106061438.392492-1-chengwen.feng@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106061438.392492-1-chengwen.feng@linux.dev>
X-ClientProxiedBy: DU2PR04CA0224.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SAWPR11MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: bae877ed-85f6-48eb-a7b3-08df3be27862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261021121427099003|261026130827099003|261022075727099003|261021130227099003|56012099006|261022105027099003|261021123027099003|261022115727099003|261022113327099003|261021135927099003|261009223027099003|261028144727099003|261026140227099003|4143699003|261026121527099003|11063799006|10067099003|18002099003|22082099003|6133799003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 7sXtesu6BrHiq9zzJdncBT1aNA9ztue0kehwS22at+CSTxd/1/OiGBdKcsesdnhicH8YOqYMOY45il1pOVPKoEKAiqDbIOBAHxkm2Roq/QD0hlKUkNoUSBCjDzczFM9gmBrp3JV+thmX2YtdLGYOgrakBqhTP7JiMOBbhnBM9WNHJcMYxbxP0AozU1Rn9tkGR0ZtUwxKXgwPV/gkGGhJXldGpqmZEx7WsmnAAHMUtumSUQ/c/jVx4y/43banHFvoyNn3jYdZUB2PQPRXp9pl1uw/vYkp6EAwE4qsrQYCRep82EIPOy6eSpy9gObxBwL+AgaZE4VSLnRxVG5Tj84QoLyLh4QGC7ONHZ/0C3Dg4lToLITR0KaALpRaVTfOfy4eqt//zPeTSk6M5JzmRSFvB4y0/4T25S+K3VR/mlv3n0u2JRjSazaMgCrDuYynEQjZwu4IGUjDdtN4G5PtLTcsMeAfp/YXP2ukhP90mjvMhbWRXA0MAaTg5WK5dj56SrUcM8a9qezq4ECJglO4VlNi/1Hdj/HERXU+1x5sMxgjfldaiOOfHjToujTjDCfkE/c/qnAl+Vic+UrKQxj8QXPeCXCz3d6AEJXdflw57F2s/0XNf6kc7+lTgh724In0mQfVWHAYGbkwBDsYz25ML+P4OAb1AGz77wNNNBEBE5GYdOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261021121427099003)(261026130827099003)(261022075727099003)(261021130227099003)(56012099006)(261022105027099003)(261021123027099003)(261022115727099003)(261022113327099003)(261021135927099003)(261009223027099003)(261028144727099003)(261026140227099003)(4143699003)(261026121527099003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bCnHg3vpy8EZIzRQapidbTuAMuq4tnmi5w8lr/HFrPUYZ0o7Bqou7g5EX6Qy?=
 =?us-ascii?Q?40S04NNJEmkKe8OOIFNqC5IBZREhI6DXW/8GTgCGvXKfJqN8QPCYZJZ4sjNU?=
 =?us-ascii?Q?lifMQJZhcBiVDid+mOBHUYZZFbAGImIS6PnpI+b4tZ/u0MtUlSitia3lszOU?=
 =?us-ascii?Q?zLBMKxxOJKJ/R2ZsQKV0fLQfZwf9Km3X8ZZFwz+GLpaJrA1q9OuaVAG4hgh0?=
 =?us-ascii?Q?TfD0/WjT2HNPeulwdD4FC3WCZGcmPK00VcGOrAgR3Rvri/ZULfSWjyciNss7?=
 =?us-ascii?Q?KCuhKo6EIqvrHnkZf9IVOioBUzCcBYLCQRRkFLYa2OMVdjMNYwUdYDjbuMbH?=
 =?us-ascii?Q?hHeZwosmYqGcbPC4Ug4My7EJKjbLhx+BjNhV735KUETS0eyN5yGYxsZhzMP0?=
 =?us-ascii?Q?Fhyq+rc8/tHM4vMEq00Sj6pciLirFYnTckdkwOiKHvexfR9ENb1mKwloRXMi?=
 =?us-ascii?Q?eTfxvJ40MIMQjiYfErBsWURHr7F7pzD55ylbepWqL/8XpkXusUnE361ykfNh?=
 =?us-ascii?Q?ARhfDTYA7v5h20pgW19YG1cllINKlnhAkIAs55GJn7rvxdFiv3CTzDjKNlAG?=
 =?us-ascii?Q?CH6ZfU3Z0x4+e9sWuM/X2xqHpfTTm50xncohlnBpW2kwugPzvfqWH+ukX/4L?=
 =?us-ascii?Q?vKz5tt6g7OdYCgidRsrzQQ8LSxkAs8t5lFKF8ssYI1WdEh5i5ejXK7xX5xYz?=
 =?us-ascii?Q?YYrlyMpRbxyi0oQQwszFEn+2PHbld4fDNKIKPuZMmnru+Rx1Gy8usKU3TxOe?=
 =?us-ascii?Q?UUK0ruz6xzI6tFDrKjary4L3cLnf2Q6ZiKafIxM1RH689YW/0L5I2Fv/siiT?=
 =?us-ascii?Q?I0fvJQbgS5bNvxy1vizkSm7axZono927DVmBqi45EIlrl+sYfyvak1K9kDWT?=
 =?us-ascii?Q?WZyLGYrO+Nl/vrnRP4oHvgpVBsHXTYzb29/6Zz2pO7bjFQ6jR100LzkjD23z?=
 =?us-ascii?Q?cOMfMGJZi+Iz+LoEsq7ewtxWZlvONT+puLvGKBMC+GXtptoN8m+Gqa2mROoc?=
 =?us-ascii?Q?gV1/ABMlVlhQINXhkvZpul0XtXShPErqjaoJ97sIs4tntDkKnkXaRJ2jR1ue?=
 =?us-ascii?Q?mNVQOSc7/lV1/xcqVUJVDpkTIBEZlX+G9um7PA2jijsMcJK0KytNGPuk02Mr?=
 =?us-ascii?Q?Lv0tAiC8hRoAsocLy+b9rq8Uijrl68xqztX8ODDWA6Pbz3Ege1BSOZCBwfo0?=
 =?us-ascii?Q?9hoDO+6XGnz8wSeAg4Bzfms12AEXXonvd3m0uwGd32EeWSUteUUchi6QLOnM?=
 =?us-ascii?Q?VPNLYGvqQheWA+VJd7c+eNtFtih2N7FJ0CWh4e2O78e366rYZ2ydD4kvMLzy?=
 =?us-ascii?Q?zAQXPu4Iatm+5d2dE5DCOK6Y+z1WmzJWx4Ib+b7s4vXAPEIXQQW0gJ/3/NPs?=
 =?us-ascii?Q?pO07TpFmcta1stPTNco/w3Tw68mE+Wd2oiISs9coSfzjjSsQsa2r2kaTJD0f?=
 =?us-ascii?Q?xVOrcW3cqL9vp5U+L0blq/IFo4oGYW1EmHzhW9vZaQwntS0K2KXjNPHI0iD3?=
 =?us-ascii?Q?GFSy7f8EESnxDPHIr8agjvYYLOIBOfyPX74vaFIW9jwzt26Un7F+L3rbspEz?=
 =?us-ascii?Q?BwSB2dRsfBmNXZ3MmoPWXBzzXNmduezFy3EOZMnCBQtZcwI9Po8LHyXHAxY3?=
 =?us-ascii?Q?FOYLyUgcz/Kc7iQX3ESShnImHmIrCdYWuwBYRHCaBGULGHIyvsPe0hOtsc5F?=
 =?us-ascii?Q?7wDjyEqHYQq7YfbdCOEXoNJbHcQ0K03cATIImqp18XcqVRgEQN3CCvDOcDKx?=
 =?us-ascii?Q?QQVYwMa9fbMvQZv2Fqlkb7R6bIvD7uk=3D?=
X-Exchange-RoutingPolicyChecked: BZLb01/xw7Sfc+bJooW4bI5LPibuexiGhrYrjnffbMEA6tQDGN7C3GtiVJC7OnorAGQAJL+/aUx4ckcko4RbgMvCa2LLGBBsiO92VXyPHiA/lmKRVajZh7O4hX1dJeRDWvKj3dc2UAruQN94oBnhrmh9FSYjoa/PgTzjHbbEX5P1bmbup+fwtg3OA1HANpwtflC+ky8odykqeAE/TviC6ip7nvFvV6aTv210iiODiFtRqwJbytW1VTa/iReCFGvPCfl4iWSMuYcOkAyDMBsh9Lnx0OUftJlGWfmujvfpb5MQgfYKNlINaTtQpOoV1tbPvXc7FvzPeKt+RRlJstR5jw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bae877ed-85f6-48eb-a7b3-08df3be27862
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:46:38.0155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0RE5UQPCbVAI0M1zsa1RzftfrxDL9vwj/uCYDsocSHP60Yqo7r+40QNyh/AevV9zjEvDK8+emKlFsSJCGrWxoXo+XqbIw496a4/KH1LW3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9733
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

On Fri, Nov 06, 2026 at 02:14:36PM +0800, Chengwen Feng wrote:
> From: Chengwen Feng <fengchengwen@huawei.com>
> 
> This is a new version of the "use NUMA node terminology" series,
> which converted the whole tree to the NUMA node terminology
> (about 227 patches).
> 
> Following the review feedback, this version takes a staged
> approach. This series only contains the groundwork, there is no
> tree-wide replacement patch:
> 
> 1/2 doc: deprecate socket terminology in favor of NUMA node
> 2/2 cocci: add script for NUMA node terminology renames
> 
> The deprecation notice announces the socket_id to numa_node field
> renames of the public structures and the deprecation of the
> socket-named functions, the rte_malloc_socket_stats structure and
> the SOCKET_ID_ANY macro. The old names are kept as deprecated
> aliases for one release, giving applications a full release
> window to migrate.
> 
> Once the notice has completed a release cycle, the coccinelle
> script will be used to generate a single tree-wide conversion
> patch, instead of the previous large series of small patches
> which overloaded the CI.
> 
> The script covers the mechanical source renames: API function
> call sites, macros, the rte_malloc_socket_stats structure, and
> socket_id member accesses. Coccinelle cannot express every
> needed change: designated initializers, union field declarations,
> documentation and string literals require manual adjustments; it
> also silently skips functions whose signature carries attribute
> macros it does not know (e.g. __rte_unused). The same applies to
> the fields named "socket" in rte_graph and rte_bbdev_queue_conf,
> where a generic rename rule would over-match.
> 
> The replacement names follow the libnuma node semantics while
> keeping the existing DPDK memory allocation model: bare node
> getters (rte_numa_node(), rte_numa_node_count(),
> rte_numa_node_by_idx(), rte_cpu_numa_node(),
> rte_lcore_to_numa_node()), an rte_malloc_onnode() allocation
> family shaped after libnuma's numa_alloc_onnode(), and
> rte_malloc_heap_get_numa_node().
> 
> Series-changes: 2
> - only the deprecation notice and the coccinelle script, the
>   tree-wide conversion patch will be submitted after the notice
>   completes a release cycle
> - keep old names as deprecated aliases for one release window
> - cover the full rename set in the script (malloc family,
>   rte_cpu_socket_id, rte_cryptodev_socket_id,
>   rte_ml_dev_socket_id, rte_malloc_socket_stats)
> - use a "Terminology change" tag in the deprecation notice as
>   the rename spans several libraries
> - name the replacements after libnuma semantics
>   (rte_numa_node(), rte_malloc_onnode(), ...)
> 
> Chengwen Feng (2):
>   doc: deprecate socket terminology in favor of NUMA node
>   cocci: add script for NUMA node terminology renames
> 
I worry a bit about the churn and compatibilty issues such a widespread
rename sould cause. These are some very widely used, common APIs that have
been around since the earliest days of DPDK. At minimum I think we need to
keep the old functions around for well longer than just one release window
after deprecation - a multi-year deprecation and removal plan would be
better to avoid suddenly breaking every  DPDK end-application out there.

/Bruce
