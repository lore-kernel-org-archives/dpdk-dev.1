Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3999EDF158
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 12:38:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81D9E402C0;
	Fri, 13 Feb 2026 13:38:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D58C240287;
 Fri, 13 Feb 2026 13:37:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770986280; x=1802522280;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=E1ZSa58fDrSHA9Is44xTOZwt8KAQCSpOaHFi3BKP5hw=;
 b=VzSyGw5eEGHaeaAchBFmamAHndlGfXXhWaeZbQKXctKU9wh0IfWPhEiA
 K+dlvmjsdvPTnmwtz1Utasexp7MKtBIqXjrPUGnZKX43l89J9lm3lcqH1
 GiSTHORFzeed3o9WjbOq4yj8qGoZN7FjXobjkhW42dKhppHpC7JX7+SmT
 60ZUYQ0+WpWv3T161gbZO0hPvJTAdq55rN3mkl8uT/WmcRxG1u7s58/jR
 jK+RLtDNch1X7CJBJzxN+HfEjrJ+qPN1aV7+Y6Oo9dMcXbSmkTRpsS4vm
 npKNZ6DbeeLJMvWDOenaQHNLP9vE4ExKeCBVm/0tp22DKygMMRn/8TeXx A==;
X-CSE-ConnectionGUID: OWuNFgdWSJiEEe8EHfG4IA==
X-CSE-MsgGUID: Yo6m7o3iS7C/W67ifd0bYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="71882057"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="71882057"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 04:37:59 -0800
X-CSE-ConnectionGUID: 64g3+H3xSbGmSSL9T896hA==
X-CSE-MsgGUID: g3RsJk6gT++Uhxy6hw28aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="212940623"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 04:37:59 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 04:37:58 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 04:37:58 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 04:37:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toCTsO71lgBvpZS03CcwrjH/4EEkTv70IJZ3n2BcxFyOzErwNqC8/fL/+yJdiX3yyyFr2dErR5pnlaYvPEeHipDDSt8KxY7Tzt884jKLlvuWF/zKGwc5ACKfMlA/TA/BysJaS/RGKN4fv9CLu/YUHH0xmsgkaKxSQmSipAy6/u8RbAPKPNDb0N07dFmqEA/DHya21UMAZl7O+hltId03JzSSEgZvES5quuCVLbswQ5ZSjM7hdiJRs0k7VNIn+8vO++s+QSUYrzRpbvOuMf2cbpAzXzl4OzNuMGTeLtEMU8cY7YoeAJp7kVptiQ6uuUbFRbjv+vIfEc9HuRfwHK5PMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOk2Xyc/ZU1ifyuaQ6oXdHu1lFDEt2vfx9QA8IoEp08=;
 b=X62Hhq8S6iwWmleLhsPECmKkzWlzb6FYZTIQXGK0Z2jrs+alQdugzbmjkWvIC/XPnOfTTmhAnzWc1fgtKQ0yCYR/2REOFFYFVr756DiDLJIGUqb23IvfjXOQI8kwp4EYiCztDnJpvVEYZK0cSFvy3+VHe9H3c76sHWtj34/29xTZN34glkoKUFU4FYWYr+D081BrCj7jWNpGfYxPjSbVTQ3MJ5GdmiqIvgejapaV6dVSKB/vJezL8NqTjeYQ2XQZq8OMsc5vVQW6G4XdsdEZIWh3mjKVvu/LROH2wQTymUD99Icbb9BToE3U7Zr9yodIUA/BCnPFqrDJoELhiDWoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV2PR11MB6021.namprd11.prod.outlook.com (2603:10b6:408:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 12:37:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 12:37:55 +0000
Date: Fri, 13 Feb 2026 12:37:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Venkatesh Vemula <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/intel: changes to avoid comma operator misuse
 warnings
Message-ID: <aY8bHYULOs-DTmLN@bricha3-mobl1.ger.corp.intel.com>
References: <20251106082354.1534181-1-venkatesh.vemula@intel.com>
 <20260120064156.420244-1-venkatesh.vemula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120064156.420244-1-venkatesh.vemula@intel.com>
X-ClientProxiedBy: DU2PR04CA0013.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV2PR11MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 382f554b-270c-4554-020e-08de6afcb5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCAPf0/+29HhOfRI8w5h1Xc8j1Dy+V9zVLsbgYZkC389hk5/YSRq2bSBPh1M?=
 =?us-ascii?Q?kqBy9AF3t57lLIYKr0OT0E2YhrqukK7hoVGDxALn1DF94Mvu2kQXCJVDHjJw?=
 =?us-ascii?Q?rEGTBU50DvBfWlflW16/awMqo5X6JRmPmVBx7LeCEx8W+SDbmZv+E9SxeQE6?=
 =?us-ascii?Q?oB3IRr3ukNnctRyqKFPCjr95s3kd8gpytvBAdvl291uRuZnyEWFbqw9T8HPS?=
 =?us-ascii?Q?8RM5haNTT0V22gommCV4rfkeuVd+mrLfT7EFLvkQ9I/xEfJg55aap4SoVHTf?=
 =?us-ascii?Q?mwGpORkLxqiFgZ2OVvVZrs064Jtnh8/7tQFFRdbzjefXARzCgM0xZZaERIJP?=
 =?us-ascii?Q?GEp4CCPHeqKS7VKKNxN/RUjUulIXKeancpl8b+ZeSf8epl6rvS4Oqo+S5Wra?=
 =?us-ascii?Q?rUaod7Q7BtcO4gg7Evu95BhKF2SsaYQGUYsFuNj+4v/ZXrNRVxiCxJR2G0eb?=
 =?us-ascii?Q?NpOXox3Lcjum6R+KBNgqjwaumXPhhjH72IL7A+Kt+DmfdEQ26idYaYD8pFjw?=
 =?us-ascii?Q?t0HxBjnu8Mbu/YV5uOcAAbPjn0C5e2esSRibXMwZdVX6QDBsOpDMsLhJxSE8?=
 =?us-ascii?Q?CIfetReC18aocaW6CkPG7uKIVLI6f9zagqUd2/1cVzRyQJiu2zIzgAYHMT/s?=
 =?us-ascii?Q?RGIYei9wdoxyrwQZBQCZ9prQUq+1aMjQKJ/lvdNgwgLWQr3PbMdw3KpOvjBO?=
 =?us-ascii?Q?UFPJKQyOgvh+TjU09wpUpLme2N2gY8PV6jB1s2JlLd1zLzkAR5pirQAELB00?=
 =?us-ascii?Q?2HGVXpD7SL04nmyvlj8RgWWM/58+yiO5aEF5VBgxUE9sT0xGtbrJSLqQ2R6q?=
 =?us-ascii?Q?B3rCrS1qPYmgDeLMZUyTm11QFyNdc19xHH/8yZUghtnNmwgE4Wr2Fz4clOh6?=
 =?us-ascii?Q?J2vdu+x7xQp9Nk8ef+5NMf3i/fY1f3a6KxlYke5FMWzocleJGe6lJNMCpfrU?=
 =?us-ascii?Q?k7kaHjWexGVfb4QYz3Z8PLOFbeu5xnoa6RBynOlvYMbbiDTREqPfxon7ZhsM?=
 =?us-ascii?Q?VNx5yFwv9R1jTBScLhjhO+RqY4nAO3gFi576suGHmlvZCsvvrf7MERQ/aOm8?=
 =?us-ascii?Q?HrGVCC+HT8r111fL2A36kjJ57SsAvW+SBfHh2po8tYq4v/MFsgEJW2oln42f?=
 =?us-ascii?Q?R7EUO69YJtY+DiinW+HAmuvdzQ8VvEZew8rb1qSfBSZ2F/AgeNbzrux33Q/Z?=
 =?us-ascii?Q?yT+QgvcjBjyEu7vh9BPJrPVeCASufppjMZO4wkOJNdB4tTOhh2vFMF3MRssC?=
 =?us-ascii?Q?srmyZmBF49A6n3/WJse3QP4zAQO8H+tMFbOJSucZZ43wLYZ/z8QbOvGqPeWL?=
 =?us-ascii?Q?QozsJyZ0Qb09fWZl3zVY/PZ+JF6JgIPzTCV5zk1V457YM6xLr2y4hf2QX4lW?=
 =?us-ascii?Q?qxEy7f+vIUXyx8GZ33rHTH1QMKyz5EEeh4hNPYHd89RC+2+0gFnTKPNU+8LL?=
 =?us-ascii?Q?7p6iumR3fKKNou6Z7aqH/+uOo9f44B0s4375GmQxrX+IzeAQrEHWXFJ0DXZC?=
 =?us-ascii?Q?e/ovAA+w0255gutMJGAIm2z8cF8pix4QOqays7M0cdNNXIE17zrBKeQoxXYv?=
 =?us-ascii?Q?iLuxGCgMsX9YMxp+zzo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KrbRz+i7XZE3EyhZBsi5HakaaCnTyFTalWRbARF3mUHShGtzwW7x5ZGPK36D?=
 =?us-ascii?Q?Hd+WWW5+znWqiNq1eHix1kvb7Ue7tYRSVRJgq4ppMh2612MBXoystpmhxnvJ?=
 =?us-ascii?Q?SGtxorz9TCrWA2GuXYIVBRfR4Rc21ew1No+CJFGKt4GjNLITpLaOSSQmZgRd?=
 =?us-ascii?Q?iP7eBU8m7kxJjbdX/FPbW3YY4xy0xPR5cYEMJ680WKKac+1eDihmqkRyYJIO?=
 =?us-ascii?Q?daDuFa8e73faDBTnk3ZQhlhQ+i7fWcK/bWiSQw/hRO5dQ/IhsVxNZMuPS1l1?=
 =?us-ascii?Q?R8vhVj7G9+CRS/eQR2ZuECsEguWlAYEMSFJCoQZ/uR10ap9Mfqq2Q8wnFuSi?=
 =?us-ascii?Q?oiV7e5IAChe71CG9ZKr+5l78X5FN+K97qWZl9i7ujwqvhrcihXZA1TPwYkJ7?=
 =?us-ascii?Q?5OyjLoPORWAxIzxc09MsRH2tEan7p8CzgByhq541/3ymOgHlRdcNqbe8ZheW?=
 =?us-ascii?Q?Tz9u4iGB6bvQni7CGL3Abwpm/wCly85YwdOWTOkLTUSvt4QJwlfm+u3G4O3k?=
 =?us-ascii?Q?vtKGFK4zixnV5XHcryPFDcen/yQS8oydYRRMvBl+zsK6BHBG2WGCtA1nrmVh?=
 =?us-ascii?Q?BAIJ7ywErnj7BBM73EsRcGUCUtOWYgCROHxNcqN9Vdtcj2+0n65ZJLb11/r0?=
 =?us-ascii?Q?Ho8FNGjyr54I+4UnlY1/SMeK8DR4cIUirY8Abi0u9rkbhgFDmuLtu2mPL5Nm?=
 =?us-ascii?Q?6WaMPBI8PSbx7B5VLSTmC8LruBpFRte4gKPHFcSIAwCUR8npkhC75zOhtSn0?=
 =?us-ascii?Q?Ro1FgRk1dDqreB9MeEneE8zzpUUgOb+L/fw2GG+zY5HHAH6h0q/8EWSsViuv?=
 =?us-ascii?Q?2YplZ8eiAbWyZue1NcWG/C8VDDHP1uZ1w3w/f9zYwuynmPdctDvN8r3BIaI/?=
 =?us-ascii?Q?nrjn8h4rCBHIZQw6HUG3ev+PLLOefYiP7GvZ/5g0uJnCy/hWMOj6ncfKb4iP?=
 =?us-ascii?Q?U+czcAWs0L78JkEOgYWOul4UHwok4XhoGmYcs4h/KoD8zwY4t9Dl1ECozyzt?=
 =?us-ascii?Q?c2CJ52UehgkwzhEfoHZ3Sa5NDWlMrsJwuDWH5Nwl1dHmTTxPO7++4ZS9N8dg?=
 =?us-ascii?Q?9jr7qseYzR4+czZbZcJNq/9NvZ+ahrEtWcABrOCDQsimyMjOm/FPwBr3tOSt?=
 =?us-ascii?Q?t9WgoHdF3SLT+kUflBoMhofBu3GPSGjJXQnI9cGVo0EXx9UKa6oIBYSXh1jg?=
 =?us-ascii?Q?082v/xm1i1TUFjHcaFeOB+OtuuV9RfWccvsOSZzN5fi7ww39n3qFInk5jx7l?=
 =?us-ascii?Q?h2Vom2BwWJlJe/Wb+vUTvaO9pEU7iQSPM0POR8grVY+mJJiVyyhsUioi/SC8?=
 =?us-ascii?Q?eeV6bB+2jwutVlT9Q6zC3guy/t6GPepD/C58QPcrjxIBGlo5/U8hyuWbeYeU?=
 =?us-ascii?Q?9LadDhUUp7tClGLgt86DXGuzvlug9/BO1qYeIyp3qJOgp1IlNaPS0bSm9GlU?=
 =?us-ascii?Q?YhGGE6IwZpBgpuSySQ9K41xKe2IRkNrWwN/W9mCKMiyo2l9bGjS9DNN/UAIl?=
 =?us-ascii?Q?7FzW3px/RNjfTRN3AYyU70tGM0hbBkYgEktnSe1n/UUJGRaEEjjjRlv2G5v3?=
 =?us-ascii?Q?QE97T4ti8GgY1sfvKD9KfWSL3uylmcTYvHEhsLyND3dDQ6/AhZmP3IqM9zSf?=
 =?us-ascii?Q?gfpO7SEE3v8CxglHJem53tvomPZ3ssEH1VsGkbRqgAn+FF7JZdApRIUBoKHk?=
 =?us-ascii?Q?92DSzSgvjtopQ/yNlwBY8ijygjQqDGtalY/20Ya+8d+YOfbtkcUSx8QCWGwJ?=
 =?us-ascii?Q?w63HY4vNv0u52w3Fcd3pMYQizZk8VDc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 382f554b-270c-4554-020e-08de6afcb5d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 12:37:55.1356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp7nypeDdUOlNCZua7dwKDbm7Wryj4/6Dl1gOxobaJooEhypyO0VRLUZr972tLqHKgrdKvusI2ndcZWwMBmMN0jHLI3Fwtpmn4zXNV+8pgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6021
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

On Tue, Jan 20, 2026 at 06:41:56AM +0000, Venkatesh Vemula wrote:
> fixed comma operator misuse warnings with clang compiler
> for intel PMDs when -Wcomma enabled.
> 
> Bugzilla ID: 1809
> Fixes: b3fa893d84d6 ("i40e: fix using memory after free")
> Fixes: aed68d5b0e81 ("net/i40e: add AVX2 Tx function")
> Fixes: e6a6a138919f ("net/i40e: add AVX512 vector path")
> Fixes: af0c246a3800 ("net/iavf: enable AVX2 for iavf")
> Fixes: 9ab9514c150e ("net/iavf: enable AVX512 for Tx")
> Fixes: f9cf4f864150 ("net/ice: support device initialization")
> Fixes: 2d5f6953d56d ("net/ice: support vector AVX2 in Tx")
> Fixes: 7f85d5ebcfe1 ("net/ice: add AVX512 vector path")
> Fixes: afac6261461f ("common/idpf: enable AVX2 for single queue Tx")
> Fixes: 5bf87b45b2c8 ("net/idpf: add AVX512 data path for single queue model")
> Fixes: e528d7c74819 ("common/idpf: add AVX512 data path for split queue model")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c             | 10 ++++------
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c      |  4 ++--
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c    |  2 +-
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c      |  4 ++--
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c    |  6 +++---
>  drivers/net/intel/ice/ice_ethdev.c               | 10 ++++------
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c        |  4 ++--
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c      |  2 +-
>  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   |  4 ++--
>  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  8 ++++----
>  10 files changed, 25 insertions(+), 29 deletions(-)
> 
For changes, so far as they go:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

However, there is little point in this fix right now because the warnings
are disabled at a global driver level. I think if we do this, we need to
re-enable the warnings for these drivers to prevent new issues from
creeping in.

