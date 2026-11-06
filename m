Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFE606A332
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c+8BUhwN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B9D3402D8;
	Fri,  6 Nov 2026 10:44:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 56E83402D8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 10:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793958272; x=1825494272;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AjRG5FRGAQPFdCCfLZ4aSBSygTlyH++3qhWKk0d20yg=;
 b=c+8BUhwNXNj8khyE6ZIeFu5HxkGXdvuDxGDXNmun4lhiGPUdwzbBc7+P
 NW4YeLmWFpURzmB0C8g3DGxmPEEPD5qmjhHM9v11Ay6xupqmC5xZlFLb/
 KymbkucIIum5LtVYOK+LS97+tH2ZkL2Zuts+KPL5LkJwncYrvvhqmU3II
 ACg94x35/ksPZptryAEYX8w5t24H+H2FXqCaU+WvH27mXVEgFA84OhaWd
 T5w62lItyqkSPtk90cuun2I+GweGQyebFINMxASJfPwpCb9SNWQDeY7RB
 dL/+NI6c0PrSQBqBscdcR+ScpuOu3fyUS5CrXAADqEKY/cU8rxQHv3dTB w==;
X-CSE-ConnectionGUID: jy347jjcQhyOUAwqDV6YsA==
X-CSE-MsgGUID: HLHpIgvDTHOHdHOJs7sGPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2867812"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2867812"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 01:44:22 -0800
X-CSE-ConnectionGUID: UNDz6c2GSPGZeS4CbjKkqQ==
X-CSE-MsgGUID: 1Rvhr4WCS2agPsBetYDunA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8986898"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 01:44:23 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 01:44:22 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 01:44:22 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 01:44:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S67v62FdOZPHb1GRFR9oAvXXG1TsaPPNCd8Yic8nQgtQDkP7WPC+y/kNIxSQnY5anFt2MMyNQR7TPQj1gUORR8IbrHaFkLjiPThNY6jN70Otu62HGFZSuBUmU5uCELfb8sYfoIfwFPA0K6x0M1xlzivvC7VjzrJtctJSzgJa0KYiZ9QET/L4i+BeJeSYzbsFT0RyaLb3XVHvTpRi6jK3qzVa9rVhOqyyy44o1+Lr5w7JLVDaBYv7pILZqDg9rbEZM0WMWGPl4l1+iknTMBWn7TAz2/FVZmYXkT0tdfxBXpowN3zuCeT6XlBUhbAff9RIp6GI0yIk00UtmcE7YoM8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n31xrmsrq6uyWvctvLFERsibd/8fc+fBDEA9a56Ssc=;
 b=r16BpEuqIcuoeGCvJHMwslazZaEynJg2IzRvV9KxUSlhpX2HHoxNLoukAV1SbMryfTz9SrlVrP4ZxfQzaejUycEvoa002E+wVLWoWd87kSA5oIK3PlOkQt5o6jdlxxjQtZfj4v4ipcSIum/VJ2qwCxqZh9NhVtuHV0VBcBlB299Pm13A4gUQv+74gxti9NGf/QEBY4Ij5sD03DHSBwW9AzirA0YdryeBXsGU1PNfam2t4BjgiB3///ldVY+VKiiTDeUl9uPtBHswAIqb+DWvmyLHq+bmHIEHvVoxVjMJi7nSQaAwaDlok4rqJfyGRIuGYKIiQbsMTkT5664eKC/1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH0PR11MB8192.namprd11.prod.outlook.com (2603:10b6:610:191::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 09:44:20 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:44:19 +0000
Date: Fri, 6 Nov 2026 09:44:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: fengchengwen <fengchengwen@huawei.com>
CC: Chengwen Feng <chengwen.feng@linux.dev>, <thomas@monjalon.net>,
 <dev@dpdk.org>
Subject: Re: [PATCH v2 0/2] use NUMA node terminology
Message-ID: <au2hboa9DBgYg3iP@bricha3-mobl1.ger.corp.intel.com>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <20261106061438.392492-1-chengwen.feng@linux.dev>
 <au2T6IClba6Ggpwg@bricha3-mobl1.ger.corp.intel.com>
 <au2UvV4uBfsAHHSU@bricha3-mobl1.ger.corp.intel.com>
 <36c8f004-36e2-46fe-904c-eab9bb28c89f@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36c8f004-36e2-46fe-904c-eab9bb28c89f@huawei.com>
X-ClientProxiedBy: DB8PR06CA0051.eurprd06.prod.outlook.com
 (2603:10a6:10:120::25) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH0PR11MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d1233d-090f-4e2d-b78d-08df3bea8789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261022115727099003|4143699003|11063799006|56012099006|261009223027099003|261102123227099003|261021135927099003|261026121527099003|261021121427099003|261028144727099003|261022075727099003|261021130227099003|261022105027099003|261022113327099003|261026140227099003|261026130827099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: SU4zFd2O8c/Od/rhE+DNdUYC8JV7sSXLAxt3NGNR0gaZd29nboZce43kqlvWr71WSDhI/+EhubLelEV12p9VlO1Fy5lxpJr76ON7OO3cN8w1dE1FeOA5FLGdpApuAHIwQ4FL1AiXaQZRWEFz78677ijsf03ruebLqjYhMpyUkwQPNLIX2MWjqHVk60uwwy8N/UuQqNIY247KAXmugU2jUs5xIX4X2jB7Cgh+pYzHVhbzaIcNV0hgVYZJeb8FNBUSGXKPqxdBOsvQkIxXCiF8HgC3I3Sd33asb4eM5HNmY0VXMVB0STIKTcbZYI8dcT+SDeEO4E+3WqZXOR/6k6IMddSss0Z043M7RHI6Dq5BcKopenDa0icSXJyJlBOWZwbCy3YL8EpZm6Z8DnM72RIzs0pIP6eAAf+BIe7kN/av0Mj7hw+MDLlcdzJ3jONGiPbtInRSFFMzDq/w9ZauxDGSlttuEayCMsgk5xFc5li5C+NPqUWmp4pSV9eWfn80l+LO+YS6BAFGcR1V1eZc6rYFaFgScaxYEz4c3K+CUJw4hhZGdcs+LeQCUVIt2TB0gBnh4uUDIMH9C77gBKz6VDmF/U81eky1esTxc4EHFnDedMq5LhWByaDYx1G0vks5ULqEHzuHKMQhjlWmIp2FEfC7JPGMjDynh3B2GnnTbDVq8Kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261022115727099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021135927099003)(261026121527099003)(261021121427099003)(261028144727099003)(261022075727099003)(261021130227099003)(261022105027099003)(261022113327099003)(261026140227099003)(261026130827099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xJGVUkcJeiKTeWSJXEMBaOndHoekMK3OYWfFpTzsvTfkBeXt4ctHC54NzaJ?=
 =?us-ascii?Q?g83ZQXW/Rlejb32aCaUw+Ls89vfd/rw98CVKFfDNTQh6cyEkCu3yhG/2cfOp?=
 =?us-ascii?Q?g4tNFs1GEfCCo/XvPN7ZHje7cU+AuZfvByRNABwXfJRYiC+sy3wnGkglN5vv?=
 =?us-ascii?Q?oo9qBLPUaUnrOFb/7AW/FMLnDQ7gtL96KlojKmJxctnPh+tPrFxzJz9cooaJ?=
 =?us-ascii?Q?v66VLgdEXbpP1eoxTqn8lCXP6c7icfJhGp6Lt/zqieEWCx528HSaO7zENeMF?=
 =?us-ascii?Q?vMB2NCtUqdLPxoEJhW0swVNYLMgr1eGRafBuYGBGCrJH5/v4vh0aC6MZCL4J?=
 =?us-ascii?Q?omw1phGHtuk+gcyXCsH5exgnhDB9WkcU/HzjDCQpVqeka84qxz4GD227WY4C?=
 =?us-ascii?Q?2RBXVjywuWBZwnGJRNm13s/FEtO8/ylY7ChXo3sSEEfZLNDXZ96FhZ/z/TDU?=
 =?us-ascii?Q?HWzl/l1J4E3jFE11JlJ9D2QTz5VfGdf1CE1Echvoi2WMb2RWSZEGsLgD0tDA?=
 =?us-ascii?Q?08H3ZdQ//V42QmGm6gMhox6y34wSAv9iP8hOtWm7luKnWEuwlpfVeOPA3oLz?=
 =?us-ascii?Q?UxqS38YFJwWEEgb9g9DgiyMFhiTpK1k+gtDYNSECysQbq18weqbJeQwrAHvQ?=
 =?us-ascii?Q?gmE31O5NZ3ozcre3FOR1wDUqzlyqxL2iqCeq1OBAQrnETZJ39zBAhjhwGxTm?=
 =?us-ascii?Q?f/E9iEQtpb/xqZpTmkHLEHnBqDhDQEpA8qSZoEjbXNxZgZli6ZzMVKTttCKG?=
 =?us-ascii?Q?dJi8spyfed6VH3oOJkehqgx9H2d4n78Gy/tpFKyoqq3SM6+w9BzaK5/iR4d4?=
 =?us-ascii?Q?uIZAqTcTtnHDxDNtCaHgG5NRpDxL0FzdEy6U5A2qMmJ7Trmf+NHLV7u9sIuA?=
 =?us-ascii?Q?xH5BaN/Xx/knWWhnJOp6I8Hbh9SStb/iz31Cmy9ORMZNpmneVMGQY3jW14j+?=
 =?us-ascii?Q?7oAS1u3IFa589s8DzQENPXltZH4aWjlb5MFh0R1/SPzE8uz2xuf83PfaT0s/?=
 =?us-ascii?Q?B0sm2B2ogZW9PJ+lYOZ3Qq4P2rRGk97F8oJlt1fSkPh2OEAUguJg8yF7C57a?=
 =?us-ascii?Q?vYkf+Vwc5Lk2nOzlgnI+kYICO9W9hfCrV1WH/58mePHkWJQVit+ogIiHlEEN?=
 =?us-ascii?Q?lfew2lZbCCR8Q6BMb6Vm0u5wJ2eXHuFo7AOoqq+7mCB6vX5OLhMTBEICDRVF?=
 =?us-ascii?Q?aBBt7SkimShBSwI/MUCyWpfg6+9musBnA4/loaQk3Gz9jVL6VO7QiEI6NzHM?=
 =?us-ascii?Q?uUxF9POOy+moP5sYbtWBnV9hOySJWU6qpiF6EC0oWZqpxoESz6oB8QuF15Ae?=
 =?us-ascii?Q?i02QXW/+eNSRQd1kjT0gRDS+VegK++MNqH5auTcZAl96b2tcRn+jNNDYfoD/?=
 =?us-ascii?Q?LvVZ7zYgK0WaQwoN8IncT2zhU8xEH2eD/Uz++8piiMnwqiKg+WS3KRGDQYb9?=
 =?us-ascii?Q?ndQlG02NSR0DyEAutztP0IU3/XP2Ru0CFuGbKSUKW82GFSYSOOdEwz77G28P?=
 =?us-ascii?Q?7W0fkfUtGj+eFoxyKU1YqVLM2c4ie286/UqmlPpTr7AXEPLMeemir4jgp1PL?=
 =?us-ascii?Q?Cw5iU0gkKAnKogtidnNYlf0Rd6PBTR4X8c3bkeh6iG510BlkUE84zqw7w/M0?=
 =?us-ascii?Q?w49ocUlewQUPcrTWgUNxVDWZL92RHzNeZhmzX34lBd8TEyMK3YknyrABA5tA?=
 =?us-ascii?Q?KFFWy1SqXJt4Y3xwyKf/rg0Txl9T0komzjjCnFabE94FLpw0DeVf3l9LuJgj?=
 =?us-ascii?Q?S2xwV/7Bww=3D=3D?=
X-Exchange-RoutingPolicyChecked: l9AS4autm3bpU9hBzk793AOihAaeeTd1pDeQkT17u2WZcdsawa7QZXRd5IF3KZmzOdBF2pdE8HJ6xzZg7RqrYKiuQA7f2VFz/glFlmsNN9OlH6d5tFoAek5SqaYMfSGRwC4iHWVPhsTPtzdqw7CBorkphsisCzutAv0++4Lp4sK4hHuEJ4kDVj0BC7G/H66Y7iOZghEyAYAvQZj5jRlJkpaebsy1kIy3wnStUWF0fp+6/zUtnFDfk+f4ck0rZC4WtSLMeW62BDZ4b1JQhiHJwHlODS1X2iHMrwitI3Tc+wPsY5oPbkfxiy2sj0p1l8N8vw+Go8KhTQ8HIpK/cH+kYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d1233d-090f-4e2d-b78d-08df3bea8789
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:44:19.4290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQliEIC3DSSn+JXdNpR12ebuFzC/sGXW2NWIXPPzHjodKmiiGypryotP6f0+lDZz5cy4rr4oiNLsxLYPr+HQTRCAqSAKObU+OJCpZ8QDom0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8192
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

On Fri, Nov 06, 2026 at 05:32:51PM +0800, fengchengwen wrote:
> On 11/6/2026 4:50 PM, Bruce Richardson wrote:
> > On Fri, Nov 06, 2026 at 08:46:32AM +0000, Bruce Richardson wrote:
> >> On Fri, Nov 06, 2026 at 02:14:36PM +0800, Chengwen Feng wrote:
> >>> From: Chengwen Feng <fengchengwen@huawei.com>
> >>>
> >>> This is a new version of the "use NUMA node terminology" series,
> >>> which converted the whole tree to the NUMA node terminology
> >>> (about 227 patches).
> >>>
> >>> Following the review feedback, this version takes a staged
> >>> approach. This series only contains the groundwork, there is no
> >>> tree-wide replacement patch:
> >>>
> >>> 1/2 doc: deprecate socket terminology in favor of NUMA node
> >>> 2/2 cocci: add script for NUMA node terminology renames
> >>>
> >>> The deprecation notice announces the socket_id to numa_node field
> >>> renames of the public structures and the deprecation of the
> >>> socket-named functions, the rte_malloc_socket_stats structure and
> >>> the SOCKET_ID_ANY macro. The old names are kept as deprecated
> >>> aliases for one release, giving applications a full release
> >>> window to migrate.
> >>>
> >>> Once the notice has completed a release cycle, the coccinelle
> >>> script will be used to generate a single tree-wide conversion
> >>> patch, instead of the previous large series of small patches
> >>> which overloaded the CI.
> >>>
> >>> The script covers the mechanical source renames: API function
> >>> call sites, macros, the rte_malloc_socket_stats structure, and
> >>> socket_id member accesses. Coccinelle cannot express every
> >>> needed change: designated initializers, union field declarations,
> >>> documentation and string literals require manual adjustments; it
> >>> also silently skips functions whose signature carries attribute
> >>> macros it does not know (e.g. __rte_unused). The same applies to
> >>> the fields named "socket" in rte_graph and rte_bbdev_queue_conf,
> >>> where a generic rename rule would over-match.
> >>>
> >>> The replacement names follow the libnuma node semantics while
> >>> keeping the existing DPDK memory allocation model: bare node
> >>> getters (rte_numa_node(), rte_numa_node_count(),
> >>> rte_numa_node_by_idx(), rte_cpu_numa_node(),
> >>> rte_lcore_to_numa_node()), an rte_malloc_onnode() allocation
> >>> family shaped after libnuma's numa_alloc_onnode(), and
> >>> rte_malloc_heap_get_numa_node().
> >>>
> >>> Series-changes: 2
> >>> - only the deprecation notice and the coccinelle script, the
> >>>   tree-wide conversion patch will be submitted after the notice
> >>>   completes a release cycle
> >>> - keep old names as deprecated aliases for one release window
> >>> - cover the full rename set in the script (malloc family,
> >>>   rte_cpu_socket_id, rte_cryptodev_socket_id,
> >>>   rte_ml_dev_socket_id, rte_malloc_socket_stats)
> >>> - use a "Terminology change" tag in the deprecation notice as
> >>>   the rename spans several libraries
> >>> - name the replacements after libnuma semantics
> >>>   (rte_numa_node(), rte_malloc_onnode(), ...)
> >>>
> >>> Chengwen Feng (2):
> >>>   doc: deprecate socket terminology in favor of NUMA node
> >>>   cocci: add script for NUMA node terminology renames
> >>>
> >> I worry a bit about the churn and compatibilty issues such a widespread
> >> rename sould cause. These are some very widely used, common APIs that have
> >> been around since the earliest days of DPDK. At minimum I think we need to
> >> keep the old functions around for well longer than just one release window
> >> after deprecation - a multi-year deprecation and removal plan would be
> >> better to avoid suddenly breaking every  DPDK end-application out there.
> >>
> > 
> > Might an alternative solution be to just document that DPDK historically
> > uses "socket" as a synonym for numa node, even though such a term is
> > inaccurate. Just accept the less-than-optimal naming as a historical
> > oddity?
> 
> I share the concern about compatibility impact given how ubiquitous these APIs are.
> It is important to separate two steps:
> 1) Updating DPDK internal code to use the new NUMA naming via the cocci script
> 2) Removing the deprecated socket-named aliases for applications
> 
> The first step only cleans the in-tree codebase. The old aliases can stay present
> for applications for a multi-year period, and their removal can be scheduled
> independently, not immediately after one release cycle.
> 
> Keeping the existing names and only updating documentation is a pragmatic option,
> but it does not resolve the recurring confusion between CPU socket and NUMA node.
> This mismatch still misleads new developers and triggers topology-related bugs.
> 
> I am willing to follow community consensus on the deprecation timeline and
> the overall approach.
>

Yes, good point about the first option being entirely safe, and only the
second affecting compatibility. Therefore, I'm ok with adding the new
versions of the functions/macros etc. with the new names.

/Bruce
