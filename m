Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1BDC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:17:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42102402ED;
	Thu, 12 Jun 2025 13:17:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id AF6C3402ED
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749727048; x=1781263048;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8O4vflMAwHSZt1sf7LFvwEq+UrgNN5XzW9WO6b/Tj80=;
 b=CpbovqkElxuzHHjulGaY+rpAzZuYskk1QTffwWITIF1y29tZG7DbyBJz
 usqxVJ4z+s/WCj76WvVxiaAt/ioNJ7Z2E/kmgmQPqzIDH1GKbToecIcFm
 uCPIr1AIK/fq0PuUy5J5XVF3sRAEcdrSPMJpJkyLCBjmWWWa5gQM6qVpt
 L7u8tiHF2RkGE/UIllr89G/9jWLvoEm4r9PM9+p9wGGrqCn4bfRXDTgP3
 5Z5zHCR2XqbQDAjkeKTNbZ1EQSrmR+wr9EeDS1U/7rTyct1GbzU+/l9KJ
 6DgOga6JowDU4+zyVw3POqLtNp6NDQYnjwxRCz/v82DFCoyGp8MJH3MY3 A==;
X-CSE-ConnectionGUID: pW/9MbsmR7WBfHPTpi4Zzg==
X-CSE-MsgGUID: c/SYdfj2Qg2YZOaTt3TETw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51817638"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="51817638"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:17:27 -0700
X-CSE-ConnectionGUID: O/FI88KYQC+979wFayMXhA==
X-CSE-MsgGUID: JwjLFwh4RCyVci8ym+BS3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="152480322"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:17:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 04:17:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 04:17:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.73)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 04:17:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQNOVKV3nYsxa0x1l+4XWAfEge98HZxTayT22f2V9Nk0QpudAi5Rh+W2n/9j3TWbkVeVoYooRgJK4ZfM83hkSKkODxkD+y7Zis0oTgUC44SaNgGbzPGcwiSwfXyDTNUHkEtmMRpCtwxPv8hgyf/E/63Voj6ybOBtYeGS8YfH1sOCKNIApmBotBuqhd15KieFUbENg7WLkRjXmgzUpwfQXstqd5Jx1Zie4LCkQsbl6a3/mTFN8sh1iAPAf/c+FwpY4OCOpjhcUB+VXfLrX3KTO5VCuHqcEN6FKQ4jFzKTdBofO5FW9LM4sHTUCkFwYh8wU4/acZmnHIgeDbTZMmdX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKLd3rmBSdTF5+XegVTBIX/vk+ylaH2o03wr4cYJ0yk=;
 b=Mop+w0itbmRI/8V+Qst4AyO02EOPn1l8BhemV0pTi5UxO42GNKu4bnBBSS3Y7FV9BCt9ZLZ3d2ulrkJLEOLUoODUv8a1V+AeUgT7NPCwCi+KMT7m/3UA+3p01euFHkkKxW4jEENmZi2SVnDZSgs0KdxOenYBjCMq0+NmRxFSajSqukXXkokv7I30FVzHtbqntOVQ2tcqZWaR39mtee2kVUwiAwSvBOLqQ0L0JaBACvRgeVjAnUVcr2hAe/4u5MoP25s3+uBwBNtCbf+9fLJjpiDYfDQ+NcPdDQ5XIUZjoo7GrhiBY683lJvcr9MoS8gsfFBWG9hhLyOlQiFX6Qbvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Thu, 12 Jun
 2025 11:17:22 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30%5]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 11:17:22 +0000
Message-ID: <f349106b-0b9f-4566-90e6-cb85f514bef5@intel.com>
Date: Thu, 12 Jun 2025 13:17:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/33] net/ixgbe: add a desc done function
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <bruce.richardson@intel.com>
References: <732c030dfd90c360c425c6bf3252fffd035ce85e.1749726639.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <732c030dfd90c360c425c6bf3252fffd035ce85e.1749726639.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|MN0PR11MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 93abc5bb-9d4c-4407-e4b5-08dda9a2b3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGM0TnNlY2JBOExVdG1qSFpmWlh5MXljZHBYb2Fxb0pWVGJsWnhZZldFZUdy?=
 =?utf-8?B?TzB2VkxjcTBXWUVpRzIrbGhXQlFySjlFK0JsR0pPcDRXNE1OUEVvYTRxOVh4?=
 =?utf-8?B?aE0vLzliRSs0bkQwZytBdXNUcm15dndNRVZ5Yjh3clllVUlYNWxQVXg5dTQw?=
 =?utf-8?B?OUx2dHVwOW5md3Nwa0RsbHliMFdURFZEZmpXS1JmWkx3dHlIQjZpc3pZbTZh?=
 =?utf-8?B?TG5oK1NyMHg1ekJOM2hSUm9MdkVMallOS21GaWs1WnJiUGRxU0s2b2JZYi9U?=
 =?utf-8?B?b1prL0NqK0J0Kys2V0sxeUQ4T1A1elVtWGRSWExkeC8vVTdxaTZ0UURKQk5P?=
 =?utf-8?B?NUNMd3VQVlhpZklFV203YURIaHpSdWhQczg4MEdmeGM0WFZhT3ppZEc0dFFJ?=
 =?utf-8?B?QjJPWWpkd2Q0b0g2N0xQREpDVEN2Y25SYUxYTEpxeWM3K0xYV2V5bEdiNmx1?=
 =?utf-8?B?Nzlabm95V3pvTWxoTm5RYXZtekF6am9BTUtodk5yNGdXUnJwUVdpem9Pa2xP?=
 =?utf-8?B?SFZUTWk0ZVV2VkJLbnBSSjJhYXF6WlpHdkdRVjkvQm9MVW9ERnBXYXBrOFdM?=
 =?utf-8?B?WDJORWRwNm5jeGlDcmQ1VGkwUTFyNUlERVVOU3d5bVoxR0p5WnJLNG8zbG1K?=
 =?utf-8?B?Z2RBclkzL3hSMTY4Mk8wMkQvME5uOG9sYVVXWnpqRDd1SGpzQVZDYXV4NW1t?=
 =?utf-8?B?OHpuUkUzNkNKNUJOMGttN2JPVmtIOWltQkxET1MrMU9XMjhPdGJLbVRMYjBL?=
 =?utf-8?B?eSt0MWJzdEZsSXYyK0haMHpVRDUvRS84ajdNRzlBMEhJTVd5cDZCeDIwOXpk?=
 =?utf-8?B?RHRGM3JqOVM1a1dlSjl1K2NBQi9nWEY5MmgyT0czT1I4SVZiV25ISlhySFY4?=
 =?utf-8?B?VU9CMzl6a2ExL2RpSnVweFJOSzFEbUN2VzZDekJTcjMrVldhUi9qQUVvYXRO?=
 =?utf-8?B?UTIzU05JOXh6ZHpJMG9jdUFMWUp5TVZxVzIyTW1Ca2JyOGdENkdWY1I1Qzc2?=
 =?utf-8?B?TVNod1lUUG5reDh3Z3JNUFJuSEJ0K21GSDZQUkZ1VExKTnBhMU1wWmszWUJw?=
 =?utf-8?B?aWR2dnM2ZHJqbXJuVys4T0xUU09jRm84WHBtNUplTWpRaHZRcjA1bzlBTU1n?=
 =?utf-8?B?bUlsT0tsTk1OL2Z5ZFcyMitqemJxeksyWXdyZEVNTUF1Q3ozN1NULzV6NHpK?=
 =?utf-8?B?OWdheG85eVI5UzR2SHNaT3JqMkd2UUI1dkYrQi83NHNnbE44ekZ6Zjg2NDNv?=
 =?utf-8?B?U2FhY2Rwa2JjTEhOOEhndXNlYzNCL29LS0hVZUNzRU5la1hJei9mWmpFMFRM?=
 =?utf-8?B?dHNaMDR3SlBpWjlLTnZWeUJyUTdIcEY0aW52eGFFRldaS21qdFlzTWpMajBY?=
 =?utf-8?B?OThxYjgzZktoWW51N2U5VkE0WWVFZmRlWmszTGxabjJFWW5OKzVwRjNyeDlt?=
 =?utf-8?B?OVFIQlVIMWpkNm4xWHVOMkp1Zit6aGpHOFFtWUx2NExIcWdmY29TM0Z6a1Rr?=
 =?utf-8?B?R3NUK1pELzcxbTNRTGwrMDAvUGh4TUNjcmxMZTM4MHp3eXJxQ3g2NG1ocUpi?=
 =?utf-8?B?L29xL2I4OWd6dzlBRGFSZFBtVjQvTCtTVHRaMTROT1pDTmdLS1JoYkptZncy?=
 =?utf-8?B?eUpRNHlRdlZTSUxvcnRSV2k1V2dFVkdoaXZGTGk3U0tEa3FwZ3BEZFJUM3Fv?=
 =?utf-8?B?NnJqV24xTjVIOVBRd3NVRXBVaUZ5V1dXSmkzSCtOUUVIOEVZcUhGQ3l0WUFF?=
 =?utf-8?B?a1ZVR1NQeTRTVEhlLzF1Qms4QkM2WmJ1bHZBUlUrNVh3UVRzVk9PdDF5Mlc4?=
 =?utf-8?B?MFhKOGlsdHdEQzgvWGJ2enJIVUNXSFE1K0RsVW5NZUxOU2wwMFlDSExCNk1k?=
 =?utf-8?B?bWVPdVhRMy9uQmtVNlZwdW9WYWdZN3JqVTUxcHlyT3A3WEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBwNFVVK0lTdUc3YnFMUU94ZVJMVGd4bkM3UnVicVQ4VnF3VHg4S0hhMDBX?=
 =?utf-8?B?WUdDZmVMbFVrY2RWVFc1WHdDRUUzSFZFS2pqSVMwRk9zNEpFWVk2SkVwN21S?=
 =?utf-8?B?ZTkxSzh0cHdVMFA2UElZMnZsejhVRU1OYldsMzd4VXBoeDZpUXRDY2s4Yisw?=
 =?utf-8?B?Z1h6UjFFRmxkL0xhQkswR3ZDOHRsa0lsKzNBU2R3YTNnMEJzRFk3VUNLbU5O?=
 =?utf-8?B?bEZBSTE3Mk8yUkREN2NhZEMzQ2dvMWlNOHBqdnphdEFzNFdLMTBZcGVzUEJC?=
 =?utf-8?B?Z3hxb2N2MmR1ODgwS2F0SlhDamJaSkd5L2hxUGVPK0dmTzNoVWRNWlJxL3Q5?=
 =?utf-8?B?YU95QWl5emg0cUJwcCtYU014aFRBTFBZcU9PTkZCZGtPYWxBampCMXBoajQr?=
 =?utf-8?B?TFE5NTdwOFJBUXppQ2hwRGVQQUhldFVVeXF5RDcvQUp5WkV2TndwWlRTa3A2?=
 =?utf-8?B?OUhqbEY2MWdqYmtYYzV2RUJHQzRUbnRnRDVielh4eE84UVpWSzA5dkVoTk1n?=
 =?utf-8?B?a25xTmxpWHZFTlBobURNaWs0T0o4c2dRV3BQVzNKTmZSSXd0NEI3cmdOdVY1?=
 =?utf-8?B?QzF4ZFoyRnlnREVpUnArS0ZJWlJvRjBpb1MwREhRbjVtZXVCamx2VDEvUW1V?=
 =?utf-8?B?R3hQNitKeDlUVEwwTTREVjBwVldhUC9XeTVUZGI3ZVI3NEgxK0NoZ0pvdk1X?=
 =?utf-8?B?NFdmYngrSDYvcnhzeUlCMWRzSnBRQngvdlJ4V2ZiVjNLYlMxZWx5YkJMdlJE?=
 =?utf-8?B?Kyt4NU5COTlVSlVHWkgxZ2k2UTdMRWRDczFINjVWSnZIN3JFYlhZazZiR3NV?=
 =?utf-8?B?N0R4bmtCY0VEQkMvYTRkWUdOcG93Q1k2L0tBdkkzZnRUSEdXaTdDOHM4R3pL?=
 =?utf-8?B?MHBlN1JPeTRUVEQxYm5IakYyY0FzeFVzSGZHcjhtUERVZ1lSVHYxSmlpSVJD?=
 =?utf-8?B?SG5yK2cyald2VzZJSGc5Tzd2djFIdlpyNEw4dlh0QllseFE4c3V1TUF3SHVR?=
 =?utf-8?B?UVNUVEg5VTdrNWJWcXp3MGhQb1RaSHpFQ0dYaFhqMElPalc2Qm96amNZR0tw?=
 =?utf-8?B?VVA2TmNTS3JDVU16Z3hxQ2wvTU8ycG55UlUyVGVSTGxDVEgwN29QMnM0bllt?=
 =?utf-8?B?WXhLZlJlTWhNQnBWUkl0azJjU3M4RXlXSE9nalpOT3RtV2FwUHlweVJqWnl2?=
 =?utf-8?B?T0Z4aGFXSktlREpTRDlscVJ1K0ZQejZJMDFMdlllMDR0emFmdnYzREhHSlRO?=
 =?utf-8?B?R01vZk5MYm9jOWcvVHVhV0p6QzdiNkhlMVB6aGh5RjlXQnMxWXNPUXQwR2FT?=
 =?utf-8?B?Mm1hd0QwRWM0OVVDZENGOFdrR2JINFpGMUx2S29rVUJZdHdiUkNEQkVkdDlC?=
 =?utf-8?B?V0N4alRURFFoR3RzMFJJMVNoOHFkYThxanhrb05XK29nd3phNE9VQXdPODVs?=
 =?utf-8?B?WGFXdGZCa0gxL3Qzblg1dUJFa2xHMUdSa25EamVFMDgyNThYRzFyK0VodmRa?=
 =?utf-8?B?dlRWQTBUbzRSSWZFL2IwMVNVMlhNRzNrbXRPVTlnMXV2c0JNUlNLZmdCdzJk?=
 =?utf-8?B?U3lmRGJ0Ykg2RFNocmtHSlRoZENVdEVDOW5DaitBNzNMOERUTUQ3OUpqRDVk?=
 =?utf-8?B?U1hiQzlOSnlnZGFJNU81OTd4OW9MTXptUjQybkNWeWV5RzZXdWJOME5rdlRi?=
 =?utf-8?B?QTFNTVYyVmFYNlpxaGVSTTI1clRpdkxSZWx5VWJnb1B5RDdVMHBKRC8xdmtP?=
 =?utf-8?B?THoxRWVMQVcyZk9nNGdFWDNaZ0JvQmU4Lzk5bmVuZ0J3NnN1WE95eUt2ZEV5?=
 =?utf-8?B?Uy91T0hYMTFGcFNOZ3Zzb1B5c3ZPbHRvdFpIcjdLT3BvTVhhU0F4bTZVaFpx?=
 =?utf-8?B?WFhiblBwemk0U09hN3pmbkFRMmswSUsyOE1ZdnhqeTJNamxVUzhvREZaT2Zw?=
 =?utf-8?B?ODJLaWlZcE8xMUFWTEx5VVBmN1dsN1lNL0p3T1NQWWorak9helU3YjlLeU4y?=
 =?utf-8?B?eE95ZURmN3BaYU5PUlJ6UHhCTDFFL2F2emFud3BvWFY0MjlkSS9ZRHk2V0Jv?=
 =?utf-8?B?cytoYXZuOXd1TTZCRCt6cGdKMmZaMTBJZHd0RG11VGtsaTBVQitjTzRZU0Q3?=
 =?utf-8?B?Nm9sVUhwQVNVN1hwWnJkMTZOYlZrQy9WWEtDNjIzMkQvemwxdStZSzlBd3Q4?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93abc5bb-9d4c-4407-e4b5-08dda9a2b3b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 11:17:22.7486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2EsPncU8jBcRdb6Bnt69+OWHeZcJJGmmeHW7gYEdP/P9aFEOw2NkAiEJekVgo0mN5ZW/nsJtqgYRV24uFvaWtkxwu59r+xtMCNjv+qi4BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
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

On 6/12/2025 1:11 PM, Anatoly Burakov wrote:
> Add a function to check DD bit status, and use it everywhere we do these
> checks.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Missed Bruce's ack from v5 and v6:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

-- 
Thanks,
Anatoly
