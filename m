Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E01C28B30
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 15:50:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D559A4029E;
	Wed, 12 Mar 2025 16:50:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4033040265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:50:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741794613; x=1773330613;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=UJXZKcbF0s3Wpg5kXtjkAp9OMbM7M0hYWuGl87+hELc=;
 b=UfJ7YJ9RXME1B75NWbyyb2IAUCyKB7JPw4kculAwAWxgRBQqeAxkIBgA
 MAEEcJF60cq6r7UJvpG2c2h24XxEBk5mqSkLHhAY0gyVPPlnxZiLKxNrF
 MRWY1pMIQ3Dzd211XZe09Z7VMHrvzHF1nXtkzFTqQ3ymwtiKaqlIfT+OP
 1S6pnNS9dKqgizsWMrCmYCDbSshh/Zslz6YUtCrCPxaFXfOzEUYOp2x2p
 xJGtfBU9o/0GI4ZPkSgtSXUF2UtVsdbxXwg4c4PV89bt3KUIX1oeDUDvP
 +qRtJuMFUtTRrJZyI7L+CDn4EDT7uxuCUAtvHplOU2uo81CP187wA7XE/ Q==;
X-CSE-ConnectionGUID: /62V6ksASL6ijqh7vavkJA==
X-CSE-MsgGUID: fNVkg1vmT2eMRo3XazKa6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43061903"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="43061903"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 08:50:12 -0700
X-CSE-ConnectionGUID: WNxaAWKbTxeV/1Ebjbm6lg==
X-CSE-MsgGUID: sfttFrQgSDutqrX64bXfTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="120635524"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Mar 2025 08:50:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 08:50:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 08:50:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 08:50:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/+kmx26yeK6Io/cVLX5CvALM/pBKmIVKVNKluloBHifah92mhH3nQqy2cawQvqGwpKOSSgjQgV5tAUTgO5C1zKXjeBMp+dlHHw3nCBInnPr2oSO7E0/0sMMDtSfO3yJ28P8N7nfI8ysjYOk3Q6AAC1wQbLaWnK6WH6RDe3FRZl7DH0TYr97q6Gbwb+Jq+1x3Ix9NOhEMOWG+8mV5xitJplEBT95MWUbk7wbn2jNQCzf/C1CjzstBacf8/YbPxUBE0i5wNBevNBeF/hcAx9mlZgIoQO02VPQ6s91xSw/2zXB91t+2dBvYiHaISyyUFUQ6E3oQ/aZXg+70iw/y7oOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyUKY8QYNRAc77KylKhVjGF/gCaFqIhkBbAssbkwwx4=;
 b=VPxYxPoTwMw1Xxc3gfWT1t1rn1ncx/H9lUBcfj8QsqRJGVs/geclGciqTY0SPZU4JaMNBP1QlllFgWsVGaGxOOsycZjIKy1KTNDme4Vh61nxuRmGFn6mIKswjD9U7G9hblOhFlLbBT2971pP3RxA7ratA8FJuKRZcEADdFsNgH0yn4OV1OUHaovasilfAjQGFHAkswcWqKfUlgLeMqKIfMAJ8Jl0yTL1QcRniZWHJLo0XI7+dOIx2+4Ja8V5XGEGVNt7fmGN0mhdhL96YLCWYqTdSFNG8SAmm5pTKjNmO/VRFAUW7tEOCKZxkgHJ1pmu/B5v4mx9IENzAapgdM0xDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6200.namprd11.prod.outlook.com (2603:10b6:8:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 15:49:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:49:51 +0000
Date: Wed, 12 Mar 2025 15:49:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Andre Muezerie <andremue@linux.microsoft.com>, Ian Stokes
 <ian.stokes@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] drivers: remove invalid options for MSVC
Message-ID: <Z9GtGdLfqniTF4pB@bricha3-mobl1.ger.corp.intel.com>
References: <1741745636-20165-1-git-send-email-andremue@linux.microsoft.com>
 <Z9Glyi4qOjAFBHTG@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yS=Lfcv=q0JwrU2+57z=jMz5K2grAsYTU2omOxR62Xww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yS=Lfcv=q0JwrU2+57z=jMz5K2grAsYTU2omOxR62Xww@mail.gmail.com>
X-ClientProxiedBy: AM6P194CA0057.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 11991fcc-c3eb-4588-569a-08dd617d8691
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjBPdWdoZ3p2aGFoVkFTd3dybXlrcEkyamtPaHZXTXR4UWc5M3JUeGhVdkFs?=
 =?utf-8?B?ckxpSTM1WWN3S2dHQlIrOTQwV21qNk93M3RXaVh6ZEViVXljTWhVNDVhaWRR?=
 =?utf-8?B?V1ZCNHJJSHk3eHJOUXdibjl1M01OMGxBMTdsQVNYbjZaT0RuSU1EZG1XK1NG?=
 =?utf-8?B?bGM3bEZ0anUvTEZSSHVva3pPZWdDSHltT2NuYVJYT3FMTzBhTjA2bktKUmV4?=
 =?utf-8?B?R3FQc2ZCRC9PcXhLTDdPWjNWc3FZWU14bG05VFdBMzI3TzlIK2lBMjVncGtm?=
 =?utf-8?B?UU8zMnV2TkFXN0M0c25ubVBsSGVPMlcraTRyM3JxYThZSW9oTTNOTG50OEtX?=
 =?utf-8?B?N2xhWWlEWU1VWURtUkZRQTNoMFp6YkwyNXNtUVBVMnJDbGM4bC9DQkhiWXBS?=
 =?utf-8?B?elVKcGQ4cEFMK25pNXp1UFgxWldUUi9RTXJaaWpKUWRaUWRxdWJtbFBPQ0Vs?=
 =?utf-8?B?Um9jWEswSEQrbWtYUjRtUkgrem5DZmdoSFB0eGxzdTlYUVNsaWhrVnhTN1JM?=
 =?utf-8?B?aVc2NkhIbk9Nc2pQZVRSeU1DM216Ty9saE5GcS9xOGhNTVZITW9MMW9wY3dU?=
 =?utf-8?B?cW43NjZiVm51bm5qN3VZY2lvc3Ewbkp6cmNoNCtuVXNuMGpqQmFMRDBMbVJP?=
 =?utf-8?B?KzVuck1tNmYwbmsrOGg0ajNzQUJid0tsbUllWE85b21FeXlheldTdnJyR2FC?=
 =?utf-8?B?cU5kdUpVZGFJNGpQU3MydEJ2V0gzR3NLS2xSbHA2ekhmMWpHZzRvanZFMkpI?=
 =?utf-8?B?RnJCdnVxZGJldmV5ZUlXUkRVS0VKRkROOXU5YS92ay9aMHVIZE43cDZTQXNG?=
 =?utf-8?B?SitTS0pzdC9Zd01tdFNwVW5LRG1zOVNTbWRYMUx0cC9BOFI4U1lvSktVUFMr?=
 =?utf-8?B?Wi93TFBjblVCenNsQzNjZWEyVzhudzNlSldBM3YrN3NIQTBNMHJPc2JrKzJw?=
 =?utf-8?B?L3NNVjJnQk1kdEdsbWlDZWhYQWNUekRhazZVbU9uS1J3U2lyVHl5WEh1NUxT?=
 =?utf-8?B?dmJraEJ5YTFwa3RjQkhpelQ3ck5xd3JUdUw5dWFrczIzYXQvSTJ4WWsySHBQ?=
 =?utf-8?B?OHBNd1FxNS9RTGZYRVpGaUFWdEhVNzZyUVhBZjdhWU5OclVHTGw3WEZIR1pn?=
 =?utf-8?B?Y2VWYkdBVHkra3phR0Zkdk5ITy95U1M2c2ZGZHF4M2JwSW81MTJxZVo5eE9T?=
 =?utf-8?B?Y2g3cVZqSWcxRlI3aEl3QnZkR1dOY1NoYzU3SlFsMDMxQ1NoVm9TZWtocy9i?=
 =?utf-8?B?enhWdUNsTS94MzU5VUMweDk3S3VEZFFoZTBzRXJSS3FGYlQ1UVFTcElJTDgx?=
 =?utf-8?B?dFpzTE1TQmhReUF1WHBBWGo3NnlQeE9ZR2M0QlVMd09VSGJBMkY2WUtGcFMy?=
 =?utf-8?B?OUlaZjI4ZTFucG5VWTlQRGZWYUx5QUU0WVdUQ25Zc0doVkVVMEErd25CWFl3?=
 =?utf-8?B?dlcwRXBFMlZVQnFXeVNEMHR2RGg5aDZPaTlNVmtWVjhCTjducDFTOVlQY3lR?=
 =?utf-8?B?TGo5UGRJTzR6VDd2dHN2bnJaWU84UjVWZVo5WXhpb0pOTi9FaksyQVUweldO?=
 =?utf-8?B?STdBZkt3QXNOYjdJb0VHQkMySHcra0ZkZitCb3VXYzZ5bmFRUTdKY09kQmJU?=
 =?utf-8?B?cjRLakI4cnNzbEZPMFJHSUYySXpHc1NOTVJkcHpYRWd6R1pvSVMzTFdQekhL?=
 =?utf-8?B?Q1g3SkFQUTRIaUZ2cDUyLzZDK2JnV1Fwa0tMTWlqZFRKSTB3WFdURXkvQUdS?=
 =?utf-8?B?RHlFT0lGOC8zK2xUNlVXd2lPbmJmbjNaaDNpZXgrL0lyM0NwRnhHWWNvbFRH?=
 =?utf-8?B?OVRpek9lUDV3VS9ZYmdYUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlJqRzE1UEZzYzlFQmN3aklMUHBuZVJmVHh5ejJ6V2pwODgvblJKMUh1cnpj?=
 =?utf-8?B?akZBREZocVFWdDQ4aFJsVnNoRkl3NDkyRU85cU5aNzl5QndYNDVwb3h5YUN6?=
 =?utf-8?B?WDZUbnI4aFpBS0FOSTZuSmpaOGF5aVZiWkhpN2QzMDU5b3NsUFV5WGlrUHdu?=
 =?utf-8?B?SUdWTFFaVGNiTzlLck0wUUxvbndKbDVJTE9IczdNV2lqZE9Va2pRZzdOUHdB?=
 =?utf-8?B?aUVuU01hVk9QZklWSnc1aHFQYy9xdTFWUHVCZVdDbUJMYldzRVVqeXpaNklP?=
 =?utf-8?B?YjhvVjRJLzYzNGNha3pkNkFxRnBUTVRBOCs3MmczdnFMY09oLzhGT3hISGc4?=
 =?utf-8?B?dzdwOFRKZmVZd1RjVXVReXU2akNGUGVpN1BYdXpVZnM2NGRYK2hGUUpVVmY1?=
 =?utf-8?B?ZlBIOTduSm9acGFCVjg5WE9nNVBrMHNxUmFUSTdtbWhmRVZWRWF1RzRrQm4w?=
 =?utf-8?B?aXQ5WHhBSWZyMVpLQjh1aHo1cTNCaWRvRExiSjkreXRheTJnN1NiODdDMW5m?=
 =?utf-8?B?OVBQbTZEUTc5T3pMekNOUE1HWno2TndVUzh3eXhwSFJFQjMzMStNN3JLcWNM?=
 =?utf-8?B?cm4zR0VpV1dNNTl1VmF6N3pXM2RGUGRMVGs5NUNSVFRWdmdoVm9jUkx6b3Zs?=
 =?utf-8?B?RnM1Qk56dWhZeFBNWkt1YjVwd2NUSWZMclVjS0t1ejg5aExmN0RBWk5Majc3?=
 =?utf-8?B?OEZjV2ZSck4xL1hnaXpRclR4d0FTdGRpQk9ham0rUHhuNTVURXEvNFJPMXdo?=
 =?utf-8?B?WHc1M0VRM0kxZE5ZRGNLaHg2VmduTEp5a2NFN0Zac1BUVE5jM1pIVFhoSUln?=
 =?utf-8?B?RjVZYStERWpMbTRldzlHbThIUTRBVEJic1NTZGlyK085VGI4Q0xQRnp4S0Uy?=
 =?utf-8?B?YVNzaWJMYUZNUmZIMCs0WmhtSXQ5cDRnaFZCUTk4QmpJNkt3dG16OXBRYVJt?=
 =?utf-8?B?elUwZFd4K3ErOHFkelh0TXc1U2dNTXdEVld4SEhCS29UTjVwUFlhb2N0Zk9L?=
 =?utf-8?B?dUFRNG9qaFVPT3luOEpUZEg1ZjRmSDlRMlJWNTFEWWVlWG5oMWtxbjR0SUsr?=
 =?utf-8?B?SHdUT3dqS0xrOTF3MU8rYmhvYWJqejBKdHlsL3lrTXdrNW4xZlBsWFVsSUF3?=
 =?utf-8?B?a3ZYT2w4b01Id3dVNG1OMVRnRFhXd1V2R1lvcmtWNjFKTXRjVDhDYXA4MTBX?=
 =?utf-8?B?UmJMWStqOTRXcTExbzlRZDVFSDdjdklmTWxNM1pjakc4bGNZeWVmN2g3OTdw?=
 =?utf-8?B?NzVWL0d2b0l0WlcwRGFxNEZjaUR6WTlBZDVsS0FZbWF5WlRkM0tiL1F0T3Y3?=
 =?utf-8?B?U0QyWkszWlZPa2N1NjFuUEU0UFhBMVFyM2xock11MVJIK2VLZ292bFAwU0hl?=
 =?utf-8?B?TFFIdlJxNTVIazdOM2xSeWlnaWVQaWlFdXNGbWYrdWhUcEh6dVRpRUtRZ2c2?=
 =?utf-8?B?eGg0WW5WTmx0SGF6RzRydWJ3cFhXQUlhYkRBR3F6RFZVVEdWQWd3Mi9ONzBY?=
 =?utf-8?B?SVB4b3I2d2tyTXZUQUNJZnZ2cXFYZjFQdGtjeUlhS2ZsTmpWTW1LWXJIOUxD?=
 =?utf-8?B?empqL3RIN0pEZnYvU0FXSnBNUC9hM2J6LzJHL0dKb2R1ejRUdk1INDdPVE84?=
 =?utf-8?B?a2g2Y3Q0bXNLdDFGTWt1ckpFQmFCZVdrcVkzakhPb0JLejExNTBwdzJLdG0v?=
 =?utf-8?B?azZDM0JVZ2RxR0diOVlTZktnOGswREE1SzhQSk5SdVkxd3BUTEZwbTNUL1N6?=
 =?utf-8?B?cGpQb0Rmc0dQVGVFeHBEMEdEYmtKZlBFOTlCQ2NBenRBcVEwQUNlTEVrQmI2?=
 =?utf-8?B?OXg2cTMxdnpQbW85aElLYmxMTkRXVHZneWxvOUNHZllNSFRpUitiNzAzY1NO?=
 =?utf-8?B?alBrenZuSVNON3JqT0YvTnUyamZ3dVR6anhXUnEyZWtDQXM0WHdrWlhzUWI1?=
 =?utf-8?B?RXhwS2krYytrUkVZOGk0dysvYU5nR3VOSTRzNnNJY3dVR0hBbTluQThsTUlK?=
 =?utf-8?B?VW9mUGl0QzdndGZSeEhWdmJtb1dCcnlOWTZlNzZ0NVFtQ2E4eG5TM0ZXRWgr?=
 =?utf-8?B?Q0lZMTVoNUF3eGgvb0QzYlhGbFJhVm9tQzJLUHhGOG4zRVhUWkpEb3JwWkNG?=
 =?utf-8?B?NlZKbUpuMkJtWDBaL1BmSXQyc25uMEMwWURRT2hxQjJod1p3RTUwMG5DTHlJ?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11991fcc-c3eb-4588-569a-08dd617d8691
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:49:51.5736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5woy++omuBj9YjAWVu7qeUSUuYuFDIVeYiDc1aermCGWmyfBwWAG/0VP7PPfvKdC3mJ7/FvVjIdeMvRd41SsKTHElVnKJDTUlJDoyaINu8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6200
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

On Wed, Mar 12, 2025 at 04:29:40PM +0100, David Marchand wrote:
> On Wed, Mar 12, 2025 at 4:19 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > > diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
> > > index 0ae12dd5ff..3553b0ffe1 100644
> > > --- a/drivers/net/intel/ixgbe/meson.build
> > > +++ b/drivers/net/intel/ixgbe/meson.build
> > > @@ -27,7 +27,7 @@ deps += ['hash', 'security']
> > >  if arch_subdir == 'x86'
> > >      sources += files('ixgbe_rxtx_vec_sse.c')
> > >      sources += files('ixgbe_recycle_mbufs_vec_common.c')
> > > -    if is_windows and cc.get_id() != 'clang'
> > > +    if is_windows and cc.get_id() == 'gcc'
> > >          cflags += ['-fno-asynchronous-unwind-tables']
> > >      endif
> > >  elif arch_subdir == 'arm'
> >
> > Out of interest I've just tried compiling up DPDK builds without these
> > unwind-tables flag, and they all pass, including the mingw build. This is
> > using:
> >
> > $ x86_64-w64-mingw32-gcc --version
> > x86_64-w64-mingw32-gcc (GCC) 13-win32
> > Copyright (C) 2023 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There is NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> >
> > Therefore, I wonder if we can just remove all these flags completely for
> > mingw now? They may only be needed for historical versions.
> 
> Here is the original issue:
> https://inbox.dpdk.org/dev/CAJFAV8z3qFhT9Vv5xOpLhi74BYAht2YCfL2ffLrmei4hfSG5jg@mail.gmail.com/
> 
> It happened with mingw 8.1.0 apparently.
> 
Thanks.

Given how new and unpolished windows support is generally, I don't believe
we should need to support many old versions of the mingw compiler. This is
especially true given the native windows build support that is being worked
on.

Looking at some CI logs[1], I believe mingw v10 is what is being used in the
CI. I might try doing a patch to remove these flags and see what the CI
makes of it. I'm not sure how many CI jobs in the various places (IOL lab,
Intel, etc.) do mingw testing, to really know what our min version is.

/Bruce

[1] https://github.com/ovsrobot/dpdk/actions/runs/13802361658/job/38606948026
