Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39301606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NVb0nLd/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7DC140297;
	Fri,  6 Nov 2026 09:50:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 4FD3E4026A
 for <dev@dpdk.org>; Fri,  6 Nov 2026 09:50:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793955014; x=1825491014;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iG3rY8GM/P682myxvl8Dj5DsSxbIXFqnSnr1WycxJMg=;
 b=NVb0nLd/fV9OLsKtpJ0kYtsnzqod1E8oKc60pNkda/uNnk0WTJqooafz
 2yatYFvWFjCf2jkbKWg9Qxe71OAnGvnimiU06VtzA6Sj/GCbkisBCx1Bl
 ywVi5OPboQzXuxe1lhZGIQaj/2m1GWU++GUU6CifltgYx0o3Tia/AeKgH
 hQpay1p+qi5auqK86cJlXYjS0jOTVfOLVskQdq/aYtURzSl9A8PMt8UMw
 VTqrvS53y+F7NNCcIfdE6NP1o866gS33LEaJ1uIHJnphZfOpKNy1iwyvS
 1jQrv4sirUOxtfztiiIUgOYFz6IfK1dESZm06iNj1A14HwSbZPuHNfBcp w==;
X-CSE-ConnectionGUID: srs3bR/bQGCbTHZ8PfNLeg==
X-CSE-MsgGUID: nhqNuo0yQSCqtY7ejH+Oog==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2650076"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2650076"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 00:50:12 -0800
X-CSE-ConnectionGUID: gWEnbFRDTM6pe11bWI5b6w==
X-CSE-MsgGUID: njZSxxLwSiK3Qrg0eOmmQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7346031"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 00:50:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 00:50:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 00:50:12 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 00:50:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHLY/PmX6WVB9Ly6N3Uof3k4Mz2EK51LNlZSpZay8QQSbbOU9lACJAgGKLxi0i9rpD20S/0W2OoHr3u0T7z8KV2svLpccqfSIztp1u2Eb4eBLinLfkDUZEwtRdwZiTiFgUoWwc/oL4A+coUnX0mKpzg30Rr28VXLHfdR7gp94Z2hDs8/Im44O4c8TK64RKvVjXihKtcinRA3nYjW4+VFORBP6SOJQLp3zLEaZhrJwuFwOMzk0Fqq5JmcjF29R6xGIysEcXlggLWpyXa+iyfdEJ+VENZtdi8r4vIZUCyzJbSpgngBxWPumwQK5UcO25WbZ4s/DdDKsPJ128YuiYS6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39lP+54BGKHCADVHIf+Ox9MLXCcWonp1LTJtHo3s1NE=;
 b=yeDPFip2b8vOOFCCj2/eDSt2inlkchVozWgxs4dNfc0SMxhFhnqzeXPa7IHf8nBjCBFAclEFwhK7x+wtuy8SwFHgY1n/lonzcPbfb+EJ+sxIXPsrlOUH5K31EVpM89X1RR7sDdx2rVeoPbfkziRDx8ZwbJHAbd1J7yy2CEZO5EsUStw+s7O1yOLh+NH1na2oPcU9/GQBShye0v5MZn5eHW3bCz7WPpwVoo1R5tWJ/Av8BmitiLB/dqaHJoNMGPCBpwJGwedYg2VHYBt4h8n/voLVhBo9MfTqycEchapvDyAMA9eLHawVj0KjnFBm6TVPz7NbqDhIPasrk9bDl+iZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SAWPR11MB9733.namprd11.prod.outlook.com (2603:10b6:806:4ca::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 08:50:10 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 08:50:10 +0000
Date: Fri, 6 Nov 2026 08:50:05 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Chengwen Feng <chengwen.feng@linux.dev>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 0/2] use NUMA node terminology
Message-ID: <au2UvV4uBfsAHHSU@bricha3-mobl1.ger.corp.intel.com>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <20261106061438.392492-1-chengwen.feng@linux.dev>
 <au2T6IClba6Ggpwg@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <au2T6IClba6Ggpwg@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB9PR06CA0017.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::22) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SAWPR11MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2e7965-da43-4a26-dd96-08df3be2f6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261021121427099003|261026130827099003|261022075727099003|261021130227099003|56012099006|261022105027099003|261021123027099003|261022115727099003|261022113327099003|261021135927099003|261009223027099003|261028144727099003|261026140227099003|4143699003|261026121527099003|11063799006|10067099003|18002099003|22082099003|6133799003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 2C8mnHgCi4JSaAlM5vZ8st2Em59G/kVNMjCd32ro+FbwmsUIQleETqHVKkBZFtP9JQoPBxsknO0UetvanBxAT/cSjMkMTDGpBH+tFaLDtteWRH5+pgkm1E2p2UQT4vgsXEBahFnDKmF/sgBch53EaJgWToq7cOBAaWPyJvtAYsxilHUviwRj7gYgLArywfnJ0uQqYk+bJEkw4PVB6xFKU1fdkAfPsrC4HDYVLpSlbCSBQRKMAlu3dw7y3jcahFVazsr+PiNMb5WEvAMk0UdrgzkTLP/uW22FQzcqslbsw54zxWXWnMoMXzNqeDo/3pQYXfNnFIK+mPpPc+Q71eFwhZVS5ATv6ZeexND+h3BW3FYpups4/W97ladFvP7Hcx8brk6SLwqfdOzDtzSEwt9k6G41anKznYkaUiI+ugYewFemQqDubnDm/jI+Ck4RLWgOeyczMeXZhcUQlNgMLx/tIQEtM1fi2o9QVb3MGQVDAp171s/GCAPI/awwVvrtyQd/T0tfdc2pEVHbLk5XvJ8utZLTGxChdN6vi/wFwJHDoql+40udEiHP3iVdvjAFVLL2J7Bi7m04q4zp4dTnUrrMF0X6Rf4tttGaUPuYUcG1xI92uP4/xg2JNUtB5pNcyWM0HzbwBZRc4FRM1YktfZkR16mw71HEWUrHrnkCHaSKiHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261021121427099003)(261026130827099003)(261022075727099003)(261021130227099003)(56012099006)(261022105027099003)(261021123027099003)(261022115727099003)(261022113327099003)(261021135927099003)(261009223027099003)(261028144727099003)(261026140227099003)(4143699003)(261026121527099003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRAXQU1//BjRiJ148c6+xqSObu/jhNQ6Yv1Nnh5dEm11PbUwyT8P/WXCmYfx?=
 =?us-ascii?Q?j8Ewa2N6sSsdQtWdssIkoiWVR/GQU/AmIjQ8thTYnPcO5Q8aN8fZmPU1chr3?=
 =?us-ascii?Q?vkWOidfC1algtPFnk3GfNlaAqK/6OYDFOPCAW0/MNuxGl0T76bhL//8+h+FX?=
 =?us-ascii?Q?q7Z33N0mhoOF4ROIhmFiSZmH41ol0de1c0Gl48U3YsQup14sy7NruxswbF73?=
 =?us-ascii?Q?fvSSlsRyFcpKVKvCHw5pohQJzsJTun+MG1KVogU93dEY/8NG8RnDV4xY20pC?=
 =?us-ascii?Q?2M2vDipjNfq6hXJ3qE+IGZ5nr/1pUPy4zNqa9Iq1EpDW10gyncyrQ0bcTXgz?=
 =?us-ascii?Q?kksk4wSjTbj+Fxpi+WrvKvGcTALpOJBzdrN/BppPPuSBs3UP44ow3oZBACA8?=
 =?us-ascii?Q?jMX7906kkvj02TTMIelMTHzzZETC9D4aHJti7pMvumH3PJgOjmuZGjhkl7eM?=
 =?us-ascii?Q?vv20EDxlxte8QMCKuM6FMNKRcDy6jAMa/IEA5wHynxBhgwOGlj6iIVTvQllH?=
 =?us-ascii?Q?9/ygQMBdw0sRWD43qDteMgSgjzXBALALKed/n7fHCybedviwLqEoDK03it86?=
 =?us-ascii?Q?wrmTFJ/A5nDbta5yTsqstM4ivVdT6hjLo4E+7hnw1IPcrKgtrAF/bPkbFXPq?=
 =?us-ascii?Q?W0aW2eDhq8VV3oP2mjWzugx9EHeNv6pMAVIF+Y4m+G+gwvxWe9IC+Usa2qLZ?=
 =?us-ascii?Q?DnQoKIhYPmr0ErzES3Eihv/jlIcka5goD5ikW8+61lK1Y8Lh9gjaZlMobWoL?=
 =?us-ascii?Q?EsjlAJElKmz1t5M2tolEoUv6WS16J2D/kJeyCjzGlM9TnYU8ENne9DsPPd6t?=
 =?us-ascii?Q?lcxElQV3mCcCkAuRtBpegGkTz6Wibp5eAmhEXeg1aEpnUPHcvInzwNrHg5Aq?=
 =?us-ascii?Q?PmjMt4kePqnLkBc/48HTJ8WEZVa2oui6zjdeZCqs1D5neQ4DIJoYYrWzRaJ7?=
 =?us-ascii?Q?vIKfFsuChIiU0+wQOUstUJmqtLf3vZgR8WTaAgqpC/TKHahLHkZ6dU9ob2Wh?=
 =?us-ascii?Q?rXIDtLxYIpFoM3OfZcZlaIABDv0wkpgywJp+BtbvSnjN4gxwc1bbUitD3Lnr?=
 =?us-ascii?Q?rOSccdDHxbNIId4qTDw77JRK6BvESOMS3TN5yCUoTI1pvOhy25kxNkaiT2AM?=
 =?us-ascii?Q?R2ZJtcqcOspkIuvnHa3qJF7Fwb666sYxjGsST3Zjjp8qCxpR8JBZIawrwWZ/?=
 =?us-ascii?Q?twKPOICdmitucOwjE7+WJMBXs9up+WUiDXbMozbsgi7SsMmOToCKJe8aAqvK?=
 =?us-ascii?Q?1hhrvwEjiHsCD4DywuHRUEjatyewCiSZxYVr95jlkjeZXWo8amXU1XOoCQlJ?=
 =?us-ascii?Q?geGmoj87KQd6c7pm+zbR/JEt8Vk5jxsqyLL4OAOKGO3gSYMDcnf6ZTpjqhY6?=
 =?us-ascii?Q?dEB+oAqQTly+FzFuGbt+vSP0o/k7n+Yysotsf+XW5vo80DKmb4422TH0IoNj?=
 =?us-ascii?Q?P1ivyBOKb08pQ9+NGn/p3EBQxuwczx9noxtq1SR6dkNY24yCj7SvFbJR6+Bs?=
 =?us-ascii?Q?r/kfPBj+/2mmI7HmDR0IodO+uvHl+uW1MNoindQqiw+ZrtBeIjxt9kp3TY3g?=
 =?us-ascii?Q?3IsYs4ZDkH68IuLLN+Sq0pESMyei18nD5AZo/wkFtpstKoi97DAbwKJbaGV6?=
 =?us-ascii?Q?UVRLVUEcWyKAkFKerSrvftnda8tfciDSzvEo+c8jjaDjVZJgPfNTpWNDRZUL?=
 =?us-ascii?Q?TfH4FQCrwm5fxfEUm3mXuPp0IJUFbAirMqxZaUoKZMBC2wN2Jk48EhvuQo91?=
 =?us-ascii?Q?qWJr+3awHR2IT0cDq2M+Wimtbl0O4ao=3D?=
X-Exchange-RoutingPolicyChecked: BQathFpCwHMXS47loXXGE4jhxGLeVU0JRNaDVlr4Hxi8ZVsANVMl183hLWdSLTdMABkpKqu9hfm8ZJYLySb2dKXZGvcH4qLVBUEZMpEzqBIK8VJVa+qXsnAd0yFFoYkZzmWgENElcfBfPCwrZt5AUTma+2CuX+d+QqRAN6XzN4Q5kcGPfE6oP1XKCOZds41R9CTT1FSgIsKkyggUn5ZrgYITXUofie+bxQotfT+UC0haUfWaC4ibqr0XO6yrYf5SfdriB1ncTVEOOlx3JDWDEb7fNEydTWbdN0NXkn93yByi4lrMNUw3Z4oST2foQRFSltF01DsHZs/kPW0+RNarDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2e7965-da43-4a26-dd96-08df3be2f6fe
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:50:10.4189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hun/E/mwMCTnzr9G36LU503S1Kf5LXHB/HoyaH5yYjLKrycU/p75usR5vkI7AlKgpI0v8biKp4TCpFlcpSpS/iVqRCXl6vLU0bng81JtqT0=
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

On Fri, Nov 06, 2026 at 08:46:32AM +0000, Bruce Richardson wrote:
> On Fri, Nov 06, 2026 at 02:14:36PM +0800, Chengwen Feng wrote:
> > From: Chengwen Feng <fengchengwen@huawei.com>
> > 
> > This is a new version of the "use NUMA node terminology" series,
> > which converted the whole tree to the NUMA node terminology
> > (about 227 patches).
> > 
> > Following the review feedback, this version takes a staged
> > approach. This series only contains the groundwork, there is no
> > tree-wide replacement patch:
> > 
> > 1/2 doc: deprecate socket terminology in favor of NUMA node
> > 2/2 cocci: add script for NUMA node terminology renames
> > 
> > The deprecation notice announces the socket_id to numa_node field
> > renames of the public structures and the deprecation of the
> > socket-named functions, the rte_malloc_socket_stats structure and
> > the SOCKET_ID_ANY macro. The old names are kept as deprecated
> > aliases for one release, giving applications a full release
> > window to migrate.
> > 
> > Once the notice has completed a release cycle, the coccinelle
> > script will be used to generate a single tree-wide conversion
> > patch, instead of the previous large series of small patches
> > which overloaded the CI.
> > 
> > The script covers the mechanical source renames: API function
> > call sites, macros, the rte_malloc_socket_stats structure, and
> > socket_id member accesses. Coccinelle cannot express every
> > needed change: designated initializers, union field declarations,
> > documentation and string literals require manual adjustments; it
> > also silently skips functions whose signature carries attribute
> > macros it does not know (e.g. __rte_unused). The same applies to
> > the fields named "socket" in rte_graph and rte_bbdev_queue_conf,
> > where a generic rename rule would over-match.
> > 
> > The replacement names follow the libnuma node semantics while
> > keeping the existing DPDK memory allocation model: bare node
> > getters (rte_numa_node(), rte_numa_node_count(),
> > rte_numa_node_by_idx(), rte_cpu_numa_node(),
> > rte_lcore_to_numa_node()), an rte_malloc_onnode() allocation
> > family shaped after libnuma's numa_alloc_onnode(), and
> > rte_malloc_heap_get_numa_node().
> > 
> > Series-changes: 2
> > - only the deprecation notice and the coccinelle script, the
> >   tree-wide conversion patch will be submitted after the notice
> >   completes a release cycle
> > - keep old names as deprecated aliases for one release window
> > - cover the full rename set in the script (malloc family,
> >   rte_cpu_socket_id, rte_cryptodev_socket_id,
> >   rte_ml_dev_socket_id, rte_malloc_socket_stats)
> > - use a "Terminology change" tag in the deprecation notice as
> >   the rename spans several libraries
> > - name the replacements after libnuma semantics
> >   (rte_numa_node(), rte_malloc_onnode(), ...)
> > 
> > Chengwen Feng (2):
> >   doc: deprecate socket terminology in favor of NUMA node
> >   cocci: add script for NUMA node terminology renames
> > 
> I worry a bit about the churn and compatibilty issues such a widespread
> rename sould cause. These are some very widely used, common APIs that have
> been around since the earliest days of DPDK. At minimum I think we need to
> keep the old functions around for well longer than just one release window
> after deprecation - a multi-year deprecation and removal plan would be
> better to avoid suddenly breaking every  DPDK end-application out there.
>

Might an alternative solution be to just document that DPDK historically
uses "socket" as a synonym for numa node, even though such a term is
inaccurate. Just accept the less-than-optimal naming as a historical
oddity?

/Bruce
