Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619D4C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:57:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D11F40E64;
	Tue,  3 Jun 2025 18:57:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id F31AB40E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748969856; x=1780505856;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SWYurcF5+drkCDVJTB74Uc3uhzZT6mN3WAobvz0wvGA=;
 b=i1PNJ09V2PU2RLb596d65HXN9VyPZNkbWvWkZY+U4Ec6xvhyYNcAhNOs
 kKV09ZW86FNTrYYcf0FvtJqD8lFLasE+ZMpiLp/RONcHcmQe5JFs/QMj1
 hplxpGvl4jaBplZMEjtbwkqTNaLYrPlEh8P7JdIX9PpMZC6odsgSvVjA/
 iZyZgMhZS0fB5uZmfOOMedq5qsJrtDU+HU6tnw33F1xtUUhUQJ+n9TrdT
 mfBDHo6HiymWo+Fst9FI4OtrlyV85EQgsYskiJheaLSd2ifztesSFsEG/
 TZpkLwsfXv9bjcq6TGDPGTYWA/nDCqn/fa0scR16It/u2H/wyWhpXoI4Y g==;
X-CSE-ConnectionGUID: whyyfz7wRZmwUOgKQu7bNw==
X-CSE-MsgGUID: 1+yq8ECoRayJh4fgWu7MnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68575966"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68575966"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:57:35 -0700
X-CSE-ConnectionGUID: ffevb4k9QlGRPO31FP1rCg==
X-CSE-MsgGUID: Jx58AIlVQqOmHm7iqPUsPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="149803075"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:57:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:57:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 09:57:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 09:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0Lsrd/g3eUpL4aK8ss30gj/bfvD9oF3artQ8sgnrbPpz+NdQ0l57i/hg1lnRKdoV3m7EvlXR6wg3LlM0l4T0k1NjFf1Vwfe9hffsWc7W7Qs3DPIL82TkYllUgRksGiVMOqLk7OyqYRlXVCEa3n4Q/FV4WekQsm4sBRBrUOsFUCfvgBHOufUumleBnVa8wf/mhdMVk93aX7uTv3vfxOFLBUDKCuLjWFaRzdPOnFVBxAYE9v5s428dTP5VdoMjZ34248rt6v962VQZUVI9VNnegNfrq8jIb2QeT6rWZxOfQD62Oou/V7qNpbiC+O5YbJzfF1m3n8b7fCQ0a+NQjUhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuIKZ7pn2nkqkE3a6O/A546q665ncwxi/WqAxuF7FjU=;
 b=KCdTjWGgKFlE5lskZd+OsEet9s1HArxQ7MgxonVAqCddtzPorPCvh7L3sloZTNsHpr82LZ7aYrgHNKuzWmRCzBEGfweGzrwBUOh54tW5QfrOjUUSULAMt6CfDdKMP2HuHLBWHcVZI5SoGZ9lX+Ug0MiOUQetDblZ7KNbfyLooWvjFfzdIuqHGMVoqVnuQWI4ozqb2thNDemAkcgUKJRWy1EmdoKY/T1x0Y7khr90GKlys24heI7t4rjPxjnnsDKEMKHUkKhUfpzYzgYlBAEbL1HtXFQ4BEzVfsxLtg3Ma8P9+R3HLAzZ++qfOK3UAshL+vhYHElRMu3G1vbuJV9kvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF75D68BA1B.namprd11.prod.outlook.com (2603:10b6:f:fc02::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 3 Jun
 2025 16:57:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 16:57:17 +0000
Date: Tue, 3 Jun 2025 17:57:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>
Subject: Re: [PATCH v4 16/25] net/i40e: use the common Rx queue structure
Message-ID: <aD8paF4DRs6A0rEk@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <0e882f98f178731da776d58d3b286868b70cee47.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e882f98f178731da776d58d3b286868b70cee47.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P194CA0021.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF75D68BA1B:EE_
X-MS-Office365-Filtering-Correlation-Id: eb20285c-796e-43d7-c549-08dda2bfb26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ty6D0erne/IfBBFWfEyiYqPanAXzzeTnt5NKU7qNx8b3WsHP7LQHgkqFCCeT?=
 =?us-ascii?Q?PmlwwZGGNJKg986jD4sXx8bpyZT+4qU652VzwrE0cLQ8kOrqm2pd41OWWRY0?=
 =?us-ascii?Q?OQ/zWUruTxsHDnwOTYld9WRmybky9UjiM4CoQBltRVCbcDiYhJSsme1fvxSv?=
 =?us-ascii?Q?NOCjUNqqWe7bhPhPuS7fcQmK3xYteKdsa+9w1vm8ZRfTgC1or3oMP7I857Ep?=
 =?us-ascii?Q?mW9aJdwRVUdPsBDPcaiquGrsLfaAK7bxxJU47KY0OwSBQTBFsztXikFI3TBj?=
 =?us-ascii?Q?Uzjt5jxXkQPB+WUciy1Wd4urVSKNL1ZkWwGH3uRcK1SxguZqPSiW84miW61X?=
 =?us-ascii?Q?N9sSAXvNJBpQVLzhm+9IOHdJwYQANANp7NJRA5NvrSBmd+6/q3EU7/N9HjEj?=
 =?us-ascii?Q?L88nQwlT2FajoTK2EOxz4ogh3rWUy0YPRzNmS9OKpZ+6qd4Z9ViLdBA0uIUN?=
 =?us-ascii?Q?wO/YdPabCHYDdUIjHbaYDL7VDbV2kWlxvmCYN2Qe9wtM3zt+JFFTX5Z+WAcY?=
 =?us-ascii?Q?T65amyJ2AJAvROOb4o3aQ8xkSWEyUeezGnWIM+14se8eTraQkvmiVKtCrvNv?=
 =?us-ascii?Q?CJhMUngYcHrtVGZwJSTA1DNTr1Yzt1bmJfbTjgeGnQ1v6eRsnJDUuohw1/xZ?=
 =?us-ascii?Q?/dDkhihKoFKsXOZriWyWfEWb7CmshjOCEHuzpIdav7UFcBLHQeuIfHdR/a94?=
 =?us-ascii?Q?IiQbL07rHBRfvLRhDpkH4MxRLeeNbtG4bYdu3VGLGM62gajDNHOR7luer721?=
 =?us-ascii?Q?+BO7npVj3iPDklKVxaGO0kUoh5SFxEg1to2cUhL3Je6xwHdnPgxIuCsPODOe?=
 =?us-ascii?Q?WJdH8JKlkyc5ZQpu6BJcrkwWiyu2phiwEsSg0TcVDUFf5kJciJc3BmEe/Zzo?=
 =?us-ascii?Q?mX/yZmxFd3DCfud/ZjhAPHGs5JKZW9+qvf5oFc3hpjNE41n3TN3P6F6FT2RM?=
 =?us-ascii?Q?N7v4g5A0TlmzvVbn2ydGMy5ddXRkYmP+oY4jXVo9yTcBKikS7HKliRrDNXCQ?=
 =?us-ascii?Q?tfrWxh7r0drd2W+JluxKSpTmf1lbFV8YU1QmHYpBt9lzvdnezuiJAgfUnX0C?=
 =?us-ascii?Q?vKAeZgMl+hetPHUkwVXt23+HLFl5kpaVniBLTgNIyf/ISgtZKM5z+jpNYio/?=
 =?us-ascii?Q?zh617u0FLCB+cwWHg50EhowhTVXT92fHFtsg09lIXmHNGqT7qxBQncH2ruL6?=
 =?us-ascii?Q?gv8PhtfT4ixhSNe/U1UZW2d7EkiatRsR5deJMLafUzBmG+qgFRnetutmfxF1?=
 =?us-ascii?Q?smGkqpUFOhp+2xOX8CQQyHS8gjWMKxxyNDhtgZP5gmbRaZXI0KR7s12A2S6T?=
 =?us-ascii?Q?MlULAwFzCMXxDLoHabEON2/NoJ3icTEGClaXPvH3jczjs9ZFGXECaGcwweBs?=
 =?us-ascii?Q?MSNzc8gVneh7CDvhnAFzquq5xMBMNiXnBlrWyDZi3kDngDvlwRVmh1e1P8F6?=
 =?us-ascii?Q?HowfBZHLHt4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UOlfFcio03DKzQYyeLQjopPofeEkiKBBv3G/TP/qHCU/h+Dr+qZBjvRpSVtF?=
 =?us-ascii?Q?LoJb4CLpqiE/pkj6rJyBotA59F1cARDsJUYy9AJH1ZdMdGOCzWAlQUTBsA1g?=
 =?us-ascii?Q?dkO4dZZ8Umw14bjoKwMEt2krs4QjdMqNV8Y/Gn0jqMvmu2+AaG4ZvzGHqPag?=
 =?us-ascii?Q?vQ9ewDFxjLdw7combrzQJJPGlZV0FznK5vVhqV4y1j+knRTgck1BexnwImho?=
 =?us-ascii?Q?8WXHG5KOnQ091OrdLS1rWEV2sYr086UxCtIjNQErf+aitRycqVCI7whSCQVm?=
 =?us-ascii?Q?dD+OCj0vF8Pb7xAWm+ydG4wBiy1XacaHAfkhjRfAJJcMKzWvmVwJPgBwHdPF?=
 =?us-ascii?Q?aX4bwKG35CjlyooMtV4Ayk7Zc+dgnZWEwri5HRjDaQbK03JpQo+sZhqC2+Vk?=
 =?us-ascii?Q?8tJ2W0rAe1AsZCeWzxnbCqgMYMIWoqGJ6v57sbndpAHrBv3rJ5LmuZWnUrFF?=
 =?us-ascii?Q?s7RpN8959SGfQJWrZeUU6E7LSIeDPpnONmLhfhSmB5skw0stntJPKLF2UBVt?=
 =?us-ascii?Q?3szeb1cvB1HlqVn+YJ74DDgvjpiES0gwMzDsJ7KARAxNxYKc3ZkyD+uub7YL?=
 =?us-ascii?Q?Pk2ijmmxsyIPSdHshXSjaqK9cy6LM693dQq8bI/0YJboYl7Zz5jTypigfyFS?=
 =?us-ascii?Q?R/Bf9D4YsQVc6IUakZYl1fOkZseE9HagsR1t9gd/Wnu+KvyNI5XEVf2JbciD?=
 =?us-ascii?Q?Qy4vjGZC+4ut8oCV7n+ifY8puYIRblBlZHrgKAAGwg4iYtHjS9A5G1L6mrOO?=
 =?us-ascii?Q?y14k5d196vPB5RBsLFBEPYeZNoyVO3gluYU8y+oyvsxRdzyTjoJjI5FoyPry?=
 =?us-ascii?Q?isN6jUKsqd+7eEjC4QMOae218dOSCAzhD6sfo3rMqN3Bw16xn9lexdU2fWei?=
 =?us-ascii?Q?7KIPn147D3Pz4fk1WygM1PcY8yR11zNrIfXVtMA2UM/VVIddSDx2HNlp4/fl?=
 =?us-ascii?Q?X5T+QI4d3WvESIGqyn1ObJlkrodP/OPGsKBCsKKIFT6mJGWR61jLFNWB79oF?=
 =?us-ascii?Q?w+BJJQqihg26xYrRGC3T3aTQI4dJuoaVWVymmQJl8u6EzT+IFyJJgU4ZmXQl?=
 =?us-ascii?Q?OXwbADTZcpxpu3UYTGPJsGubpcc1CPFfkmJaP1XN3n9JJKv04xPOtv3ssjfi?=
 =?us-ascii?Q?/P6XlAXTBymvaVva8ZD9xjMJwS8V95yMtqbs36N0KLPVEffngcJC1eYGxdX+?=
 =?us-ascii?Q?y2LnjM4hVELOobScxY5LS2EEzSi2lfvv3dppBhocI9xYAUeNAv2tssYKE2ew?=
 =?us-ascii?Q?lsw4TvZ2dqgPuvadpbSxT2Z3etwhh9aAvACxghUUnVJWW2iVcTXbeo4JGs/9?=
 =?us-ascii?Q?jerGbeW0oWPgFtxh+BsUMWVXwIGoMg6ey9MjFg6nhRmie9ppVEVXHcGopjiW?=
 =?us-ascii?Q?JnFaZKzKxZi2Qk+HcdkbUPzsGC0tchToLEyoy4j1nJtJuJyus9zOAQUuMNbk?=
 =?us-ascii?Q?Gr+tgdHAU0tpJ/P/WHMrBrTrgWBB4EUUKbeosUtJFO/WqPm5fdhnmCkenhAR?=
 =?us-ascii?Q?dfEKpCJSXZvMrLFvYKR2h6oo2FjiJuBZvKnvH2nvtGwDhktWoa3NNC1AYW1U?=
 =?us-ascii?Q?9jDWOjSHHk8d43xUxjqw8CTuGEAw0JZHGIGZbTsGzXCbvRxorUeRXeetI+o7?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb20285c-796e-43d7-c549-08dda2bfb26f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:57:17.4807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ohqAYXqgmt5HzS8elmV+ZrU0kgyI44u1ii+b7l+XNN2vfbxwcTFHz/JhyZqhVz1YYChOwg2YFPiMdptYwcPGCM7navEVNV9Yt5esCCs9s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF75D68BA1B
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

On Fri, May 30, 2025 at 02:57:12PM +0100, Anatoly Burakov wrote:
> Make the i40e driver use the new common Rx queue structure.
> 
> The i40e driver supports 16-byte and 32-byte Rx descriptor formats, which
> is shared by other drivers. To have fewer driver-specific definitions in
> common structures, add a header file defining shared descriptor formats,
> and switch between 16-byte and 32-byte formats by way of the existing
> RTE_NET_INTEL_USE_16BYTE_DESC define.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
