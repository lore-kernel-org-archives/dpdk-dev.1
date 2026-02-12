Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41960EE36AC
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:18:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C9ED4025F;
	Thu, 12 Feb 2026 18:18:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 705A440041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916702; x=1802452702;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=gVKIf6hMUQDIvP8MIPh9biNS1IbfQsZ2e7rvayokoOA=;
 b=SALfGsSDylHeq9oNBtC02MTU1+SxUltiQsC4b/2hEHUDnPyd2m69gMTl
 mQH0r96SmxLfzHDUbMUxlCm4BgP8ulk01P30SYt+qSVpgHGjGensyKt52
 dmZlPC/IEIRuJH0dtfFhZfaMRuSglo5tG+zGf6im6TBaK69YvEQf9Ju/y
 YCOqeo/ZV9FkZ+PO1/ywpf3AcD1cV1C+YBkMATj0S1Yb9FXtMoo7Yi06T
 ev7qG++U2Ct6PWXqR7B66WuKwvXvhYPYvLWiRm1Z3uG7ODqzlS5u/LlEm
 7VjG+mCH6HsxrsWC2HBNfNSnTrY9COL7sTNMKhDkq7W1a3VjmCGN6GmnC w==;
X-CSE-ConnectionGUID: Lbk+JVbrR0W4oARt4+t38w==
X-CSE-MsgGUID: t4wmfIthSnO0d3o0No0gvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82734584"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="82734584"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:18:21 -0800
X-CSE-ConnectionGUID: lu4RqwVcSWS00JOZv1jyqA==
X-CSE-MsgGUID: k/Mmvle5RmmcsM9DSMoAAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="250344853"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:18:20 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:18:20 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:18:20 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:18:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r599p2fDwv5x2r6AeWk6piG0fyqC+52XGlWHuPTbA2W0QWj6yyypg7Mqth2OyEnPujJfBM9lIvTnModkq3BISP20K8pJB9fHbSOpYbanT6ypXVJou5jKtvn0xc0zBJmW3wJDf2ErDM6x8UZfACvn9ltoD9laf/R7ecgkyOqnwKL6EVsAT6GhOGrzncghhl5XfYgWDtPaGSHdsv52sR0dbE/YsXN3QPiFXLaVKKjriiCuE09nk7GqjpcVuIYrvMpSTzHJU+e8B836D6tMtoiF/YsT0q9Tn43DZY6rTAtdYlKcZd3qMwH32mxklNi520w7TfbgZmoplmCY8jqZnN674Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVKIf6hMUQDIvP8MIPh9biNS1IbfQsZ2e7rvayokoOA=;
 b=WEfF8rnuriZQmiMvYb+sW0mbZLlW/S9hMVUMT3OtzQWpmlMIvxUyKOTA8cvHbcA2L01TOWV3qglBOH//lmgoW9PER2Jk5TgiWcWZHm0qyzqbdcZUKV78+SVLvaYbmHiJR8Y6zcqqP3n1ejGlUUTOCuZX6xDA6X5EP9Ixz6D7htD9+jzkf8Qf0wgoadeyz0rrgjqhOQPL4Aqw0y0Wx0Qc6/8s4CDSEGZvFC0AxJ4BrOcgjNvbgJODcLxtsJPnI82M0nCt04LBjuOPtTxWYKTYuOSGoyq3OhQwHRCBRkp1WDwsxPO2EmOjs+PtFeNscxviYnOIT5QZkVfAdsv+rlRX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 17:18:15 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 17:18:15 +0000
Message-ID: <c6d2cf24-e1b0-44c6-a829-81f97b55f3eb@intel.com>
Date: Thu, 12 Feb 2026 17:18:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] net/ixgbe: fix wrong pointer handling in IPsec
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Declan Doherty
 <declan.doherty@intel.com>
References: <134252a49d330111781e4cb1baba470474091853.1770900758.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <134252a49d330111781e4cb1baba470474091853.1770900758.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0351.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::12) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|MN2PR11MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: 8755ee6f-90d7-422d-cf7b-08de6a5ab542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1JGSVQ1bkt5VTQxcGdWcU5CaFhicE9aZi9pSDFqbEtuUjRLaHpEQzkxM2Ri?=
 =?utf-8?B?d3R3TEFlMnZwd2hiQ09CRUJKcnFwQmlVSXZwbmt0VGMrbEV2M1JOV24wSHUy?=
 =?utf-8?B?TzNqT3cwQ0FxejIyZnhCaFF3UVBtUFh1Z2Z2czdyaEVwTkEwY2t4MGtwWFAw?=
 =?utf-8?B?ZHQ2VlVXOGlGZ2NsRllVUVcySllNa2pGeC9kdnB0ZDZyeVVVWVRIYkUwVlZn?=
 =?utf-8?B?WGF2cDl6ejhHS085VUFUNUwvajdwR21RclZ6bEdxaVBSUjF4MTdXK3lGeVR3?=
 =?utf-8?B?NW1ESVpqM1I3N3JpenhIVmJJU1J6RDk0OXMyb2VadW1kNkJuODlnRUVTem9h?=
 =?utf-8?B?RHRod0cxRjNiQUxIeWVzaENJN0lWWWg4VFpvWk8xV3M4aDhuc3JsU1M4aE5H?=
 =?utf-8?B?Q2ZLcXRxd2JpZHErb1VWY2o5ZkpQVmpxS2tYc21ucW1uZ1BjU3dlZlRYUTc2?=
 =?utf-8?B?eXdhazVrSDdFazBMSG40NFFNcGhmYWR2ZUJBUURVUC9zbnZ1bkNzN1ZqaXN4?=
 =?utf-8?B?RWQ0UjBVQm9ka2VBU2hSamk1enlLTExpeit1ckJlRmdxMmtmdnNyNDlhVk9w?=
 =?utf-8?B?dHhNNCsrTG1QYUU1QXQ2KytpYkJwRE15WjAwWkxjU3NHVTZTN2ZRaXFwV05Z?=
 =?utf-8?B?WFFjbi9pcllBdHNHdVpPQi9rUFBIaHlTaHp3TVNFMnNnSXdTazNlZXg0d0JI?=
 =?utf-8?B?aW43R203VGg1UlpIUjNkL0F0SHMzUzl0a2lkRWtpcFYyc3gwc3JPY0NHay84?=
 =?utf-8?B?ZTZGRE54YU1GL3dTelJBUm1rS3QvclhNdTRlM2dKRjU1RGFmUGFqSUpJdGRT?=
 =?utf-8?B?ZnBrSHpmdzFGb3lGNUU2Q2g5T28yZXVNbFR3S08reEF5QzlBRWpzR3JBTXEy?=
 =?utf-8?B?Z29QSnZiR0F4dVNTY2drRGdyRi9VNklSMmRjMS9UTG1JcDk2MGVLYm44LzVO?=
 =?utf-8?B?Z21hTFRMTjJCdnhQWEU0ZlBmYU54RW9ZR0IwVzliMmYwbkV6VHlrTGQ2UnF5?=
 =?utf-8?B?OUhlVlljVzY4WFdJVTlyVHoxM3hvb3hyQVdOZCtXTWw4cGxvT1hReEIrRVpY?=
 =?utf-8?B?WjVCY0xpSlF4dDY3ZkFlY21qMUVBSXBMMllGNThIVTdTVFhMcU04RTIyU3kx?=
 =?utf-8?B?WVpYcjVnR2d3Nzh3bkFjQXBRQTM4SHJoTThGN3dRYUFVZDhaRlQxdWxQMHZ2?=
 =?utf-8?B?YXE1bmZ2WDZHTDQ3MFBZQVZqQkRycXpYd1BxS2pQOEhldnI3QllKdzFod2ps?=
 =?utf-8?B?czI4U05NYUwxTEYzbzUycEl5VnpSU2cvTXprRU55YUcyUGx2U09OeFBzSlV6?=
 =?utf-8?B?cWc1a2J3N09YMDJCa0hGcWRaQSt0VmU0T2FuWkM3UFhVaHkwd0E5SUhOYU1F?=
 =?utf-8?B?eVhPZWJ0U2loMjMwUGhzb2duMFVpRHoxRjJxQVo0RSs3YlBNSDdOQVlEcFFF?=
 =?utf-8?B?bWtFeFdhWjZuYmNMcTE0ZEZGYSs3K040VVJ5bEFSaTExeVRnalh0cE1KZkZa?=
 =?utf-8?B?Ti90bmFLaUU1c0ZqaTBaNWFoRDJENzJuRzBrMTdMdjRFbzNXTy9ZUUYrekdG?=
 =?utf-8?B?SXhiNmgyN0ZLdG5qRWRXeXIrL0Q3enBYdW13UTJJTGIxUGdTbWg4bGhjVU9a?=
 =?utf-8?B?cGd3Qld2MmpsQlBELzRVV3JXbUhnZlpYRGJ4cTYvd1UwQXlZVkZYQk9ESGFt?=
 =?utf-8?B?V2xYa1MwQlEzbGdSRkduYTVYVzBJczA3MWtBTWNYWjRqbEFwVHBrQ3RvdWVG?=
 =?utf-8?B?RzZ1MFEzUHl6S0t2bmFjUWNldDFpVlZRMDN0aHJxMDJqKzM1Q0xXcWNmMUQw?=
 =?utf-8?B?ZmN1YU0yQzhZckxuSmQvTW5CcmtKRW02KzU4M3dKS00rbUNYTlE1cEt2MmdF?=
 =?utf-8?B?aUxZT0diaWVWNHRkMmVzdGxkcDZicWZDZUp3MWQ2MTVBWVJNUjU5RmtneW9Z?=
 =?utf-8?B?QjdybVZkTkdBczd3UUlpRjN0alNZdjdBZmVxL3VHdzY0UDVjbVZKeVZvdzBU?=
 =?utf-8?B?VUcxNmVuYkwwRnQ2T0hNZ00xQk9ua2JQcFVZTE5TUm4vYXZIWGM4Znd1K3Rx?=
 =?utf-8?B?amtjUW9IU2owOWxicjBaWWlocDdFZ29QenRzWnBZRDVyTE40Y2hKVFFqc0pn?=
 =?utf-8?Q?cyeM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWpZT0l1clJZQ3cyVGJCaFloZjhCblM4R2gwWXk4dDlvbE1PbUl6Wk9BV1la?=
 =?utf-8?B?bmpiUzZoRFNvemszZmtuUDBScTBlMFRiVEk1amhtS0o5OGV4TCs2aSsvY3F5?=
 =?utf-8?B?QTlwK1VseHF0S0tJSlN0ZWE1NVBmN2FJd1h3bGlBLzhWa3diaytHcWtFbDNF?=
 =?utf-8?B?aXdTQzNNOHIvbWR0enhFUGZZRmR2eDVWUGtZU1BRaDAwanZ5ZWM3Q2hXKzJr?=
 =?utf-8?B?d2pyV0JQNVhzY3V3SnJwc1JiSjNselRuc2MwQzlpRXZqT0lGNGdNTFJYY3h2?=
 =?utf-8?B?SDVRa3gvU1NmR0Y5TU5uNHJ0WjhWSWhJb2JmVjluZUJha0pWaW83bDBxT1ZY?=
 =?utf-8?B?VUpGK3BlQUI1NEJyWERjNkEyakF2RWlFaklkbXoveWFWd0xrQWd1MjF5b2I0?=
 =?utf-8?B?Zk9tSjczQlB0Wkp4QW1EQVRoOGU3eEhZRUsvN1djRU5RQjQ5T0NFQnlFQ1Zh?=
 =?utf-8?B?N1JSeE5zTWZFM0NLTEZKbXR5ZkNBdU5XUE13SWpHaFRPd0Z6ZlI0WDZHMUdX?=
 =?utf-8?B?YnozdlBvV0FMLzFMRVdMa2JLUnV6amFvKzNuOWtjeXJrYUtua0FJWDA5R0ZI?=
 =?utf-8?B?UzZNY2pGWGdQQkhyTTJnNk5Fc0lkaDFDdWhGZWc1VzJTT0tEMmlYRzF3Z1JL?=
 =?utf-8?B?dm52T3BpelMxd1hMeXVzdW95UitpSTFBNlV3b1gxdzNKY3hsTi9mbSttNWlG?=
 =?utf-8?B?eGpvOU0rTFdBTkJiNzVQWHlYeU0xYVdrUnRaaHJxdk45RldWYTA4aFpCNFUy?=
 =?utf-8?B?TmpEZVhZUUNUSjN2MFFjZER1MlhwYW9jREdmSHpCZkpVZFc5b1hwWkdnNDJD?=
 =?utf-8?B?Yjd4QXlCTnlTU1hnZ2UzSVJQUTl1dzNFQzRPeUpjYzhZb0ZoU0RiSU1RaWVY?=
 =?utf-8?B?Q2hGU0hpY2xmYVFoUGozTGp0NldoS0ducUtxSVRwWU45cm9abENqSHBiQkxR?=
 =?utf-8?B?ekl2ejRNejFoRWNrNlZ4ZHdsNkc3cEhQbUpNNFNpZ0htZjNCcTJMbDE3aFdI?=
 =?utf-8?B?b3JjTzF6VHFUUGRwZEo2LzJZSGhKbjJyYjNHTWhCNnQzWk9MMW9zaXZSbzFm?=
 =?utf-8?B?MU9hUkpiRmN5dU52azhHM3YwYXRUV2JNZklXUUpLbmNaTkhrZG1MN0xZaFda?=
 =?utf-8?B?dDBua255eCt5dzBueGRIYnRUanROK014N09tUjdHckFSTUNZWkJEY0xMODVT?=
 =?utf-8?B?cHU5L0RyaDVBb3RMN3JYbXVDVWY2eUVVZ1NqSnhpczdYYStFT3hTcUFsTWI5?=
 =?utf-8?B?dVdvUGxvdDA4ODMvTXZ3Skg5alQxYkdpVlptN0Y4dHFTYXFyVjR5Tzl4eW80?=
 =?utf-8?B?d0JHekJ0S1B5UmNVRDlmM2xwQmF3dG81ZEdCME5oSG5tUjdOQkszOEt0Y2lO?=
 =?utf-8?B?M0N1MDJhSUJhZE1ITVBmOEJLcDErUU1teGFrT2tZUnduZ0EyY2JlTVFDQ1Nz?=
 =?utf-8?B?ZTRyUXJ3OCtoV28xdkYrNzN2aVZobXZoYW5NZVBSWWM2cnhxS21SaE1sZFBa?=
 =?utf-8?B?ZHh0VXh5TktENGpKZ1c3NUdGKzN1eEgyMEo5a3Bja24zWXNQOFlVQm5wM01z?=
 =?utf-8?B?dnJmOG9QWUFBMzc0VzkzLzV6NzlidVZJWUE1L1p4dExiTVpWb1NjVWtRcDdm?=
 =?utf-8?B?blcxcDZHbUFSLzU5RDgvd0pYV0dSOUJqSHo3T0JGelhUQzl0ZGpnSWh1alB5?=
 =?utf-8?B?V0RQaG9rWG5zcE9JbnNmNnVxRFRIRWxHOC9QTFd0RHlTMjhTcTNlQTYweWdM?=
 =?utf-8?B?QjYwMGVWS1BZaHJVVEZlYURoaHpVVkFTazRUQUw5WXpySVlOTWluTmxsNDBR?=
 =?utf-8?B?bGpOSVpLWDlwQm8vUjdDY2R5SWlpQUpaRTNMdHNHbnozUmk4QWtIcUt6T3Nz?=
 =?utf-8?B?TkVrWXFrOUFIM0VlVSthU2VSK1F6QUMwc3lJa2xWUDR6NmZjYzVmL2lNcit0?=
 =?utf-8?B?MWJKL3dVMTFlS3I1eU1MNzd6WThaQzBxSUYrVkI3RS9oYXVkQ0VDaHBNMzIx?=
 =?utf-8?B?ZUZXMVgrRDJ5OWxPTyt4dHlDaTE0Szh5NWRrTXZZa2JqNkxONExjTnFUbDdm?=
 =?utf-8?B?NWhPcGc5TklETWlKblVySnUyMnlvV0FrQkNacUVNbFd1QnAvWU9MYkFFa2Zu?=
 =?utf-8?B?YmNnZnNnUUREdlM5REhyUjZKN2VYY3FlaXZmbVJ1ZmdMT0xuZkNpU2xsR3Bq?=
 =?utf-8?B?NVRGT1NSa0UvN3c2U0tYSTAvRExHTGFhcTZLeFJraFhuNTZEek1pQmpqNytH?=
 =?utf-8?B?T3o2NndxSVZCWm5wZXpUVlZsRTR2aERnVU9ydFhldVlaVE9jL3VRVDU2cURs?=
 =?utf-8?B?QVdRSnIvTkdWV3RqN2gyVE5TWjloZ0REM3BZNUg0RW1zWTZ2QnQrZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8755ee6f-90d7-422d-cf7b-08de6a5ab542
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:18:15.6945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xFpeAZR1ehgxRyFLNh6NKSmFiYOwuF1yCmiQKSzpREnfNpp8Enkdn+yuE1QN4hYM3RQGxHS9cPuqGdFZppYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
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


On 12-Feb-26 12:53 PM, Anatoly Burakov wrote:
> The original IPsec "add SA from flow" function expected a void* pointer to
> security session as its first argument. However, the actual code was not
> passing that, instead it passed `rte_flow_action_security` which was a
> *container* for security session pointer.
>
> Fix it by passing correct pointer type, as well as make typing more
> explicit to let compiler catch such bugs in the future.
>
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
