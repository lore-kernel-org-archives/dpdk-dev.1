Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599E7C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:39:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5449040A8A;
	Mon,  7 Apr 2025 17:39:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 81D6540A89
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:39:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744040367; x=1775576367;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZRilVv5vj6hEBnyAij+sSaOqfuj4+gyTp2DozsmLqWQ=;
 b=V/PwUQFmmpH3hKaq2V7riB3WNjnwNhkcI5kX0bt3T/hyC/Rpi+bf+ABm
 YXhkwWYOe1REvNu+DEFjQPCKZmRInxHrwdJGTQmrph8d7R974zepWcUwy
 gi4JDC+wmf59JoxPiDgh5Y06W5ia3eB+ajBG/pGtfntyo9TxnM/Lg0XVz
 Qnv0NwknG6OpBogJCR+enw+ZGIs9P/V5nhfk/MhdXEcO7BB77g/GuB0XJ
 SIijXg44kdMLt5a+MgsLWvcVjnIOwk7CHtsefgIy8o8hI/pmGuAkpHdYz
 J1wksnSimB94S4HhY9tLHN4Frk6/RVRZnxMFI1yxO3D0R7o91chwto8SD Q==;
X-CSE-ConnectionGUID: dDhyM9OeQmW3kghjUu0sSw==
X-CSE-MsgGUID: NNz/HX1eQgqvO5PmTvB1rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70811609"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70811609"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:39:00 -0700
X-CSE-ConnectionGUID: jtkMilKUTU2m6vETkq3R5w==
X-CSE-MsgGUID: tr/j0bECSEKzHIa2A89qag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132129633"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:38:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 7 Apr 2025 08:38:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 7 Apr 2025 08:38:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 08:38:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmswQD82eHP5uXZGZmc5oTldedCG4dX7B/QMSDA3LhAmaIqfIDlW9i1s4UOX1/QEVKzOsACgbxG/H7pNqfFR9DUN3FbXjca930r9mkHoNiM6Bj71mEyQAK8k56UchQxu8llpuaHuWW1apfy10ZqccMku+3gTgGk9J/27XUqncoccalvoGIBYTymzu7e/fsqywquwpFQe0jQs4XFhB/8dtypsLUNiW1xHUss1FMhbIdbuCYQta/NrE920BNBUwPOishA884E0Ub0Jmd3sMGQbkCmDYYWdtXybmOz6QZhfj5L2GxkbXh/bcVJgZc36pGlfqayleM0EukEMHu3iL0ZUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDtihAJnh9r96W/wpE4JcpQlmgHipIMpLBePZLfQJlU=;
 b=CAOb6RfMp8vqcwbcRI5KyWj/uDmUSGVkgGECQBoPXntBaRn37KgSspNi1rWYSqYmC7zA1r2ABo8ybS6LWnUh3WYJy7ek2EsAxpAT74t7vsxJVccvkILOpU4M39dmStNnjT08c+VfWR1W+hVoxy9mdT14RB0ALjVMtr/EGs37lfKm7MvyHKh5eB/zWcJY7bJoJO44cZzJV0RfCmb8zY41DlQwdtO2BL4ih+PDiIn1GQMLiKlvnHJDX5Z7HwM13oMS1H/nM2DH6zFOD+eBs59rifSyWVgc/uY/wL6Y9Xyr1cxUc1EaFj6qgkBW4I68+Jz52FoxXyynNplY1TKIWFpX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB6889.namprd11.prod.outlook.com (2603:10b6:930:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Mon, 7 Apr
 2025 15:38:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 15:38:45 +0000
Date: Mon, 7 Apr 2025 16:38:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, "David
 Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] allow easier use of high lcore-ids
Message-ID: <Z_PxgFr1I15A2V4i@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
 <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zcFU_K0feJMK=YEouyxYxwURUPQq7EGcacJ++RxoTuEw@mail.gmail.com>
 <Z_Ofcb4ktAmn2RqJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB99@smartserver.smartshare.dk>
 <20250407081450.6a1e726c@hermes.local>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407081450.6a1e726c@hermes.local>
X-ClientProxiedBy: DB9PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 0960bd64-46f9-453f-d5f5-08dd75ea4835
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTV0b1ZLK0NCZU9RdkRnUjVxcHBJNGZTWDZ1WktFQll6dGdmQWFoT1BsdWxJ?=
 =?utf-8?B?S3QxT3NRNnZsajJnbDhwOGxvU1ZOdmlnUzNpQ0NmSDRLaTQyMWNQbU9YcGJG?=
 =?utf-8?B?ZEkxR2llUjJ4SGxsTXZYbGFHN09ITUZ2YnJPeEI3T2lwMGEzSEdvYmNuKzJG?=
 =?utf-8?B?RWNUTmZ3dG03S21NeVlHY004WXZZM0J6UnRRV0NxeVpZTG1ERW8rMHRIYjJX?=
 =?utf-8?B?N1R2MjVSV3dqUHhWdHcrZWZOekJrUkNVK2pnU0VhWlZDd1F6RWJRTE1UMjlX?=
 =?utf-8?B?bTNKU1VQQ0NFYlpIWmFxVGd4RTY2VGJKSnBibmVPTjMzcnNER1hBSnM2ZENz?=
 =?utf-8?B?S01HTDF1OU5QVm1IN2lnME9wVlF6Q1N2bzVud3U4VG5WODlZdGxCUVU2ck8r?=
 =?utf-8?B?WGdNWnNMZUVlNU9mTWNOZnkzMFR3cU56S1BuZUw3UUdib3FmN1BUalFiQmt1?=
 =?utf-8?B?bVUzTXV4bjZxMXpOYlRVd1Nsc0xhQk9jRDlNNWE2WVVpQittbFJvNFlKeFQx?=
 =?utf-8?B?R0JUWTFhNTUwdzd0eWI2NGE1a2lYa0hnOU4wNXhEeCtQMXBCM29vSEUzN3R1?=
 =?utf-8?B?NFpyKytXT1RxdlRoMWRqODJOMlNCVnB6M1BRUU5ITVN6MllpZXVqOUNZemJ2?=
 =?utf-8?B?NW1oU1U3ZVpFdHh1QW1QekRmbmVMbUJKc0Z0Q2VMTkdOa3FyMVhHTGNrL2hy?=
 =?utf-8?B?OXhMU1dud2NOL3p0ZUtFQnc3RTFoa20reVZhS29JZVhHeCtaaFkzdEhFTUNK?=
 =?utf-8?B?TEdlRmxTOFUwWjJmMVNiNlp5dWxxZkVBYkphZDk4N2lUYVV2cVNvbHhVK0F5?=
 =?utf-8?B?NldmbGRacjRMc3JHQmN5dHN6b2h1R0JZV0cvZDhiK0VidURFemxaSElzc3I3?=
 =?utf-8?B?SGFyd0FqR2xnMjdFOFpCZE8xbzhQb0FYNExRVXB0K0ZpZWY5bkgyUENYK0Rm?=
 =?utf-8?B?aVZvSk9sVTVvSXVKVUFsWmlGZEZyTmlWSWtpbzNyUGRJSXRIUDJ4bDFVSWhi?=
 =?utf-8?B?eUZjSUZoRUdJL1BRZ2NWVmVKbGRPdWJybVRhMUNGZ3FWMkNJUXF6OTFubWNN?=
 =?utf-8?B?ZEFDUGpuZ0l0am52dTVrREsxYWNyUU9DVTIrUjh4Rklvc0xzM0NVR3FMYnlR?=
 =?utf-8?B?QmxSVWRVVkp4dDlmNy9JSUIrNFdBbm90U0U3NkI1TTB4QkhNNjlGaGw3bWlB?=
 =?utf-8?B?Ymg3THIvQ0tBQXNPTjRaZWlwU2F4a3hqOEFvR0hzZEpGSFBFZi9VMFNsMDc0?=
 =?utf-8?B?bXYyTy9JUlVNZHBOZTZTNW9DQzNhZkI1RUw0aWtXOVplQjBIcTR4eDArK3VL?=
 =?utf-8?B?VDJQTUtIazdyZ0lKSHdLbWQ1d214UUQ1QXI5ZHJUNGFGS0xxQVYrTXc3YmR6?=
 =?utf-8?B?L1VwbGJNWXlHZUZHMlNiR1NGR1ROVWJZMGZTNCtFUEZrbHJnWDJaY1VuSDZ3?=
 =?utf-8?B?cXVmdzd1OFlGZ2d5TGx5NFRidnJWMzVxRDFLS2FJVzAzdHQ5L0llemRsaENi?=
 =?utf-8?B?bHhyV2IvR0lMRkZLd0FNTHlsNkwvKzV3WW1TYmgrc3VVNDVwRW1ieUNORWFr?=
 =?utf-8?B?czUxVFF5ZVFwTHMzT0J6OXFuZkRQSW1lekMvU25jZnNmYnYyTFZLTzBtZkNI?=
 =?utf-8?B?NGY1Q2UyeXlETFJDVHpDZWt1K1BLbFlXdHB1bUlib0YwL2IrelVSSmh4WG5N?=
 =?utf-8?B?M2wvMThCWWZVT1pnV3VJdFN5UVZKMUJ4TXNaMXkxQlVqWmxyQTJ3aFMyWGhF?=
 =?utf-8?B?K0g0RlFicFU3Nk02TE1ydU9VbTdZNFRHOFN2Z1NGbkRvdDBMOG1OQU9GaVNk?=
 =?utf-8?B?VzBGMldDUEtyTXMyVSs1cDBjYU5xL2I2dDc0TXRNT0NQUzNUYzIvWEdtVHpr?=
 =?utf-8?Q?gSI3sVfaFGNll?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFU2OEVjNS9CRkdYVlhyL1FieEdZSnd1NDFBeTNNY05hK2hEb29QeDJzODll?=
 =?utf-8?B?SHFJZG1kczRkZTVTbWQ1OHBoeU5ZM3RseExhcmpXVnFhQmRKaWFlQ2NOQ2RK?=
 =?utf-8?B?Ym5ycVNEQi9iYTUyM3YzeE9RVDB0bmYxbU82RlNHby84UnZBSFhNZnNOUith?=
 =?utf-8?B?UVo0UzBnRjFGb2tLMmVCZDIweFpBMEUvL011aWJmY3M5d04xRlZVVXNnb0ZK?=
 =?utf-8?B?LzVFVU9ESWgzRFRQT3MxQ3IwbzBvdjUrZnhlY3J4a25lSnM4VS96eUd2RjVL?=
 =?utf-8?B?b3B3SWR5ckYwRm9ScUtJR1pSclZlemRUcUZTc2xtWkI3QnJ1V2hSRnNPQ0wy?=
 =?utf-8?B?YTVYNHQrWGxiYlNVL2kyeXpvb244WTZRTHQ4UXpOQWppYUN0amdvbTl1SU9F?=
 =?utf-8?B?SDBVVlFWQ2ltdHpXNmxPdkJOUVBlKzFOOU9BOGZuS0lhSGJZYkh1THRGamsy?=
 =?utf-8?B?Yitoa0R0eFZOOG1JZ1YrZEJZWUpYUkNicmNYLzluTDBUanZzbzRDS1B4K1hC?=
 =?utf-8?B?R1JNelhSWWcvWHFLM0lyTHJxU2lmTEVBaUw4VlNhUjNPMlpqWGtTdHRyWFdl?=
 =?utf-8?B?Um13amlhQW4vbDNHcEowS21SSGxZYmVpNmdLcHlKazNybGJtSmdET2JEd3U2?=
 =?utf-8?B?aHlrMHNtb2pFOE9NVXFTRUM1U3p0MjQ3SGhFdEZZeEQ3Tm9XNjN6U0p1aGtP?=
 =?utf-8?B?Sm84Vld3NDdtQUVpY2VyY1d6R3BJZHpUd2tVNGU5VVVmYTgzME5ZaGY2eG9q?=
 =?utf-8?B?VkpycTZKbkw3QkVFUjJGL0VMOGkzbE12VTlRNnF1Z0E2SWI0MHFrc2p0dSsr?=
 =?utf-8?B?RXpjMFVQTGVqUzBVREw4UU8zUHZ5TklKL2xGdVBsM0hZY1NwcWNYMzZBNDVm?=
 =?utf-8?B?bUJ6SjlKNks3clJiMW5wZlpFU0JENk9rNVIvWkhyRlNNVkwvRDhDRUo2czZ6?=
 =?utf-8?B?OWJac2pQNllUVlZwVDVBS3VlZ3c1bUtaNDBSZmVaMDJHbFZuU0lSR1hGRnNo?=
 =?utf-8?B?NVBFSk9DZVJFUmhnWlVkY3B3MWozWW9OWm5MMVNYbGlXdFhsVERsOXlYV2or?=
 =?utf-8?B?Umx0K0lBc2h1bTNxZ01EZURnNVdRN0xGNm45Mm03SFAxMnFXcmd3RjhoSjVT?=
 =?utf-8?B?Qm1oc0pIajB0MGVFMytTNng4ZHE0aVJqZS9FOHZIcktLREFMWERsa29MS1BL?=
 =?utf-8?B?c0hHYXdvWG8rbjh2cmRjOU45cU1OQTBqQjdPRzZJV0NrY0k3L3RON0V3NlJn?=
 =?utf-8?B?YUxFN2MzVmhaQkhuUWJQa1p6V2lzei84SEw3VXZKWXcxeWFIcWExTE9sSG53?=
 =?utf-8?B?RDQrWGpDQnAxdHRzZXJNdCtsUURLbWhJZHFvUjd2SEpweTc3QU51YmRpWmxB?=
 =?utf-8?B?Rm1ydFNYM0E1S1VtVXJWNVU0VURHL2R3akZqd0ZDZkthbHNHQjRIVm9rQ3dr?=
 =?utf-8?B?cUFEU0NQMHNLdEdnK1ErcGlFM2d3c3l4bDB0dUdLVm5ZaGhoOWp1WWpaKzBV?=
 =?utf-8?B?Q2UzRG94aVpLVjB6RTRiMUZLRUV4cGp6M0cvVTVxY1J5OHRyVDFEajBWNmJa?=
 =?utf-8?B?THN1UkxCSkI4ZHhWRjQ3dzZSNWVNWC9tcTN3Z1dqVkduQlAvb0V2VEIvVUR5?=
 =?utf-8?B?b0hTMzk0SnVNNHdSeEpJMjFuZUgvZE5hREdOMHA5UzRZb09GVHU3RStBVEh1?=
 =?utf-8?B?dTZNNHFNS0QxQytrL3ZWeDlaR0s2UWNGTVVDSm5rZE42cTFJck1CcVJnNE9t?=
 =?utf-8?B?WTZnSTBmN1NBRSt3WHBsZHA0a1V1Y0ZWSkJRSmJ5OG1DNXgvWWc3Y2pIbFZv?=
 =?utf-8?B?L3B6UFdwWTl2WUlYb2diazQxeVJTY0d5MDZRa0xOdEh6aDRML2RGbW9KMzJj?=
 =?utf-8?B?OTM2UmxGOEYrY1k0OURXYVFyQXdkWGQwSzhuaU5ZYWxHenc3S0ZLUFZXN3lM?=
 =?utf-8?B?OGdzamVST1FieUJOdVhwMyt5UFJ0KzJJNkVCcjQraXgxR0ozTW5KU3JIZy81?=
 =?utf-8?B?ZkRuYTZ2d3BKOHIyZkxaOUFKK2xjL3F2V3I1MFlxN2dPcTMzRndYdmhUcGxw?=
 =?utf-8?B?NVJORGZUN2RjQlJvREI3VE01dEVheTJzbThMYi9FcUd0OEhHQTRXV2hMSm1V?=
 =?utf-8?B?SXpJVzZveDBsd0JuYVA2aWdYNkQyNDZOS1RVTTIrR1ZBUEJqVUE0ZWhnV055?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0960bd64-46f9-453f-d5f5-08dd75ea4835
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:38:45.3281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8g5HOZlSoEXmSrBLkfQtMB7sbLJcgS29HDHv6UKvOUuKZn8sNMhr2rGgNEwPJL0ro+w4MT7CmwhAQhCRAkebGvnHbnjszR3AgYuOTPEWdJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6889
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

On Mon, Apr 07, 2025 at 08:14:50AM -0700, Stephen Hemminger wrote:
> On Mon, 7 Apr 2025 12:15:13 +0200
> Morten Brørup <mb@smartsharesystems.com> wrote:
> 
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Monday, 7 April 2025 11.49
> > > 
> > > On Mon, Apr 07, 2025 at 09:04:05AM +0200, David Marchand wrote:  
> > > > Hello Bruce,
> > > >
> > > > On Tue, Apr 1, 2025 at 4:08 PM Bruce Richardson
> > > > <bruce.richardson@intel.com> wrote:  
> > > > >
> > > > > On Mon, Mar 24, 2025 at 05:30:26PM +0000, Bruce Richardson wrote:  
> > > > > > Traditionally, DPDK has had a direct mapping of internal lcore-  
> > > ids, to  
> > > > > > the actual core numbers in use. With higher core count servers  
> > > becoming  
> > > > > > more prevalent the issue becomes one of increasing memory  
> > > footprint when  
> > > > > > using such a scheme, due to the need to have all arrays  
> > > dimensioned for  
> > > > > > all cores on the system, whether or not those cores are in use by  
> > > the  
> > > > > > app.
> > > > > >
> > > > > > Therefore, the decision was made in the past to not expand the
> > > > > > build-time RTE_MAX_LCORE value beyond 128. Instead, it was  
> > > recommended  
> > > > > > that users use the "--lcores" EAL parameter to take the high-  
> > > numbered  
> > > > > > cores they wish to use and map them to lcore-ids within the 0 -  
> > > 128  
> > > > > > range. While this works, this is a little clunky as it means that
> > > > > > instead of just passing, for example, "-l 130-139", the user must
> > > > > > instead pass "--lcores 0@130,1@131,2@132,3@133,...."
> > > > > >
> > > > > > This patchset attempts to simplify the situation by adding a new  
> > > flag to  
> > > > > > do this mapping automatically. To use cores 130-139 and map them  
> > > to ids  
> > > > > > 0-9 internally, the EAL args now become: "-l 130-139 --map-lcore-  
> > > ids",  
> > > > > > or using the shorter "-M" version of the flag: "-Ml 130-139".
> > > > > >
> > > > > > Adding this new parameter required some rework of the existing  
> > > arg  
> > > > > > parsing code, because in current DPDK the args are parsed and  
> > > checked in  
> > > > > > the order they appear on the commandline. This means that using  
> > > the  
> > > > > > example above, the core parameter 130-139 will be rejected  
> > > immediately  
> > > > > > before the "map-lcore-ids" parameter is seen. To work around  
> > > this, the  
> > > > > > core (and service core) parameters are not parsed when seen,  
> > > instead  
> > > > > > they are only saved off and parsed after all arguments are  
> > > parsed. The  
> > > > > > "-l" and "-c" parameters are converted into "--lcores" arguments,  
> > > so all  
> > > > > > assigning of lcore ids is done there in all cases.
> > > > > >
> > > > > > RFC->v2:
> > > > > > * converted printf to DEBUG log
> > > > > > * added "-M" as shorter version of flag
> > > > > > * added documentation
> > > > > > * renamed internal API that was changed to avoid any potential  
> > > hidden  
> > > > > >   runtime issues.
> > > > > >
> > > > > > Bruce Richardson (3):
> > > > > >   eal: centralize core parameter parsing
> > > > > >   eal: convert core masks and lists to core sets
> > > > > >   eal: allow automatic mapping of high lcore ids
> > > > > >  
> > > > > Ping for review.
> > > > >
> > > > > At a high level, does this feature seem useful to users?  
> > > >
> > > > This seems useful, though I am not I would touch the existing  
> > > options.  
> > > > I would have gone with a simple -L option (taking the same kind of
> > > > input than -l but with new behavior), and not combine a flag with
> > > > existing options.
> > > >  
> > > 
> > > That would be an easier patchset to do up. However, it would then mean
> > > that
> > > we have no less than 4 different ways to specify the cores to use: "-
> > > c",
> > > "-l", "-L", "--lcores" - and therefore need 4 different sets of parsing
> > > options for them, and more checks to ensure we have only one of the 4
> > > specified in any run. That's why I chose the modifier option, and to
> > > try
> > > and consolidate the core setup a bit.
> > > 
> > > However, if having a completely new option is preferred, I am happy
> > > enough
> > > to do up a different patchset for that.
> > >   
> > > > I scanned through the series, not much to say.
> > > > Maybe add a unit test for new cmdline option.
> > > >  
> > > Sure. Once it's decided what approach (if any) to take, I'll do up a
> > > new
> > > patchset, taking into account any relevant feedback on this set.
> > > 
> > > /Bruce  
> > 
> > Changing the EAL parameter parser to a "two pass parser" makes sense.
> > I think checking for existence of more than one lcore specification options should suffice; we don't need to accept multiple lcore specification options and check for conflicts.
> 
> There already is a first pass to catch log parameters, could the offset arg be handled there?
> 
It could, but I'd rather not get into further handling of args in a
two-pass setup. If we go that way, we might be better to do a completely
"delayed-parsing" setup, where we use getopt to put all arguments into a
structure with named pointers for each arg type. Thereafter we do the
actual processing of args from the structure itself, allowing us to do all
arg processing in a fixed/known order. Unfortunately, that would be a
significant change in how things are done.

Also, from the discussion on this thread, there seems to be some support
for having a completely new cmdline arg that takes the core list and always
remaps them, rather than using a modifier to existing args. Your opinions
on the relative benefits/drawbacks of the two approaches are welcome! :-)

/Bruce
