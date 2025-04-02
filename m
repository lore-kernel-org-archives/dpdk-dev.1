Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DEFC36017
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 13:45:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FD7540273;
	Wed,  2 Apr 2025 15:45:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5496740261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 15:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743601502; x=1775137502;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Lul024qoTrt+Yg/5BxraKtyLveOuTckLJzvd2dasBIM=;
 b=Yqb7HcTsVcSYX54Zmp7VFCM4oEbMVuaEm4uyZCv4ypsUMkOcNJYEYOKv
 B+KNrdNWbmNIpu/l6VPJSr0R5l/ThT4tuaH9trl5Utfwkm7qfZ7qTAXMD
 zNuV8clZMvZg9kPKLEpp5SAeVM2qBnLKqKshjnM9Wt+Mr9pUOAuO0LUd2
 uMbVdFcakiBLbLi2UWOG7qr3LiXoFTqYpD2WZ6+yxIDEpWHRRewyI5q9g
 QwOrgfb0tJUN4Qes58gRF5YaJevfD81Ic2h+HQmRCo39atoGl7jc0oNfN
 uTjnTudm4Spt9fBFlfwiKgM3n01h7gPGhlJAkC25shV4+QgM4qMJbQ3hR Q==;
X-CSE-ConnectionGUID: 4FN/XkayQ9mgHO+TZY6nNg==
X-CSE-MsgGUID: CFcwQt3rQm2AKLDp5u+fOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55598121"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; d="scan'208";a="55598121"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2025 06:45:01 -0700
X-CSE-ConnectionGUID: 696O++W6S9uhTKpun4DMlw==
X-CSE-MsgGUID: ho79tuspTM2QWK5CUZZP1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; d="scan'208";a="126965912"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Apr 2025 06:45:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 06:45:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 06:45:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 06:44:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj/wh8jqpqvZk+Xl6KRzC9KZnbOep5Vtdf+7LbJiT2DQMenEwAvmmcDn016Mn2CDapJBZuqcUhXHWvmCpwxaDUOOMR4A7pAf4tx+9s7sePCE+R+BtlIrX+8kRd0oRIJxIZupxQvM9ytpetTj4lTLFgL/RVfHOgEvikPt/hChRAAoFNWtrgbbvEBBoaAYaXF4B1CjiCjLZhgHPogmi8FmO+vLNTpYg2RUkZeXOihRpRJklFSnrG6ztCNUdyZJKHPGvP1+2RjLErHlUsLQwMf+5pOA6Z9Wl1T4b8yeBMegemGQOVxVzYuMDaIYuJZWKQrvUfxBzXgwz3/cu94ZHZniew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCGD5y4y+W1otUnYtzTQAWBMgDfmTtwQ9NH+c68slxc=;
 b=wkc7cEAzVHbrXkpCqnHzoOEARRCXhM0viYRP2HasTUgYXGzZGnWafO09A+w0JNdQd1D5pJ1Wh0lqjfy//Asho9FZ4unT5erqILZ/OcJKUzdLeFS6q7z5s3JrSlK2Xi6ayfGNJJ3znvJ4N708Ss1Wt2B6p9qKNSF2M6DMdRZnt1/zK1nqNsu3/QPA+AiYAl0TXjdtCWoFrwDmRjL3FubLFsOG7HUNX0UTSPL9LNsKwoGuKqQsFXwfdco2KvSyr7yUBPXpSFRWZlQco9A+XdwjqadV8X+ti2RSSAg7hzhDtVvICAb+SZbc4waV/ORjNhmwWQ9QwJUk7PUJRaSK9UjuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB7112.namprd11.prod.outlook.com (2603:10b6:806:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 13:44:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 13:44:27 +0000
Date: Wed, 2 Apr 2025 14:44:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: Re: [PATCH 00/10] centralise base code handling for drivers
Message-ID: <Z-0_N8RU-JccT-sW@bricha3-mobl1.ger.corp.intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <CAJFAV8w3uth7PNR8e9gD0vOhmdd29TdaLtcT0mE2Y2D6eRV9Ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8w3uth7PNR8e9gD0vOhmdd29TdaLtcT0mE2Y2D6eRV9Ag@mail.gmail.com>
X-ClientProxiedBy: DB9PR05CA0008.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 2667c30f-5357-4375-a04f-08dd71ec7cca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHl2cFRPQUxieEpKQ3BQZUV1ZUNOeEUrQ1htQi80MDF2Q0FGMmtzdlZKNUVR?=
 =?utf-8?B?WUVRcGNDdkVuL1JDQ0tBRDd2UnVGaUFmK1BKNmdZUWQ5enFoWXo5WDRZRHFn?=
 =?utf-8?B?aDZQOU4weUlnQ3Z1bEEvcjNscDVnMEdYZXFDRWlsa2lJQ3JBZ0ZGeDg0VExm?=
 =?utf-8?B?Y3ZjeklpMmE3V2ZBUFo0ZUNGMXF0bDlNT2t2djVydEcveGxiaXM5enYzKzdB?=
 =?utf-8?B?OXBtUGdZKzFBQ0VoQnpUTXBlUitiVUswWlB5Z2dBN052TXVxTVJYUGtKWG0r?=
 =?utf-8?B?Nmg2bVhrZUN0R2QwcTZHODZZejI4SEhjWkxyVGM2VXYyVGpRQVBUcFNYY2Iy?=
 =?utf-8?B?RXUyMk9CVTJOeXBmRjhsNXZTbkFPeHpOczhTM01JdFljZGdtWW5vb2JwRDdl?=
 =?utf-8?B?Vi9nSWN6NVpZQ0M4NDZaRTFZNk8rKzdaWEJYSkEyR1ZvQm9uaXZ0UUxpOXNS?=
 =?utf-8?B?V29FYWNvL0tRWXFwSEVYN3k1a3MyU1plRitVVkpjb3BJbDlVNllkZ3d6OVhp?=
 =?utf-8?B?NFVyejgwSjVZUGM1YU5meG1lWkZpMTUxUWdMRU9mV0R4V2lsMTN0b040NUhV?=
 =?utf-8?B?UmJXWE92YitVZUZNT2lMcG5BZVJrQmxVMzFNU0N4Z2pmajlJMTdYcFU0NjAv?=
 =?utf-8?B?R1hwbE4rYXR4dVNPTHR2bUZJOVl5K1R2cjl2ZytJNUVFVTA4RFE3bG9SYnJv?=
 =?utf-8?B?TkxTRytsV3RDSHlFbXVuSVB1K216VFZUMFBLUHQveWUwbGI2SU1tVlBlZWZN?=
 =?utf-8?B?d0I1MVl2VzNVL1lGTEVCd2paY2hjY1kwbTllQ0s2ek5BSnlzbmZpZXBZTlFI?=
 =?utf-8?B?MTlESUxUOTI3aEZnTEFZeFZuSWdGbHNYeGp6T2ZjVUNtbVB6ZzQ1ZmhQVFE1?=
 =?utf-8?B?Zmdnd1hFc0IrWmwyNUE4UlZEd09DTjRBUEJjd1B3R1FJOUdtTTNYYWxzeHVu?=
 =?utf-8?B?NDlNUHRyK2N6ZXJJUmJ2NE1lVVcvSVVNdlFNb0VhZElmK1ZINVRDTzVDYnJo?=
 =?utf-8?B?NzlOWFVoSnFpa1lzWTRySUdZNFJpWnpnM1BtTWhIaXROOGl3Z05YaXluUDNv?=
 =?utf-8?B?aXI5WnZudHpuTnV0OUE3NE9ZVFV5VWNGMk10d0hrOXdsTGI4c0JPUzRPcFdM?=
 =?utf-8?B?Q0pORjlYUmRKSFIzbzNtMURGa0s4L09jQkpjUTJHTE5yR1RST3VNa0hrRHhy?=
 =?utf-8?B?cDd4NGhQL3NuK2NiY0FpUVJLUDBjN2JTVEhaZFJ4RHBDdC90Q21WcllPSXBG?=
 =?utf-8?B?b0JIYmFhVkZOYmRhVzhOSjUvOEhiQ0ZacXdtZVhENTkrRTQ4UjltaUQzdDlE?=
 =?utf-8?B?N1BsSE0yMDZVamlxT0F3Yy9BQlZybEhoam9vallMTXRsSDN0NXZYd0NZNzVh?=
 =?utf-8?B?WXMxZVM2OTVYSW5zeHh3ZWxoRUFmRlNyUElOQTllNkZ5aEd2bkl4TDJjTjVK?=
 =?utf-8?B?cVVDT3BrMC9ENnRXUGJKQjBYZktkTGVJMUt0M2R4M1ByTm85OVJSbHdJYUE0?=
 =?utf-8?B?cGd2MGxUa2JLK1lpLzhhT2xqSXVqamp5QXE1QmhhS0VHMXZZR2IzQXpIbDlu?=
 =?utf-8?B?d1VzVm1BNkRmdHdLbXdnMG1pQ2wvZU54bnJUT2FVZUZuVUhzaEhoVStJcTla?=
 =?utf-8?B?a2tkVTNnbjVXaktmOGlFK3RZVDFPY28zenFNY3VCc2FPVk5CeVBLMWNxL3Y1?=
 =?utf-8?B?dFVNZm9HV09lL3QvOEJHMHBVekY5Tks1QTRML1dmVTJkNGovZFpqbEV5WjZh?=
 =?utf-8?B?OUlJbVRWYS9QYlJnS1VySnlpU0lkQjVoaDZkZmNYYUpwRlcwTHFSaXpkS0hk?=
 =?utf-8?B?T29DMFd6c2FSMjAwLzloQzFQQUkxYzJhZmJNYnVxcE1kcmQ2emxJeCs1TUhu?=
 =?utf-8?Q?O+5J7exM2rWPJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Vybmo3Vy83Wm1EdGE1NHpYTHp2TGJ4Y2JRVGl4MWJrd1RWUU0vTTNrb3ln?=
 =?utf-8?B?ZGkzampSS3BhcXhhOW1XaSttYXNzWUpYNUV1VEU3clloNDhzU0dNWUhKekVJ?=
 =?utf-8?B?a1FVRFNuMmxvK1RRVzFGV2kxSHJYRTJKQUlVREwvWVlneDJ5QmlvbnRhTEIr?=
 =?utf-8?B?UkRRTXlBQldYOWlaalFEMnk1RURPbDlmamRvUGxlSU9JUVR4ZzR4bVRmOWtI?=
 =?utf-8?B?K1RWemxiMHpxNmxFN3BLZFdyNTBQaHM0QjZaUlBveGZvS2FiM3VZTUJXc25Y?=
 =?utf-8?B?eTZqaFVFYzlsOXBtSUJUa2dhMTY2S3ZEeDEvczRpRTlBenVKN296MSthZTVG?=
 =?utf-8?B?eXV4UGFUeFk3YjZNcjhoL2J5Mk91ZGFobmIyUVhESFdrcFNaZCtkS2tXWncw?=
 =?utf-8?B?NVZBbnhuajc1dSs4aXJWVmxBelp0eDFWUWVKZXZ6UHNYV2VJR0dOTWo0eldu?=
 =?utf-8?B?elo1cVFnMHl4TksyTy9PeEQ0QnZMR2NOUmdDS29LMVQ2M3o5MW1MSXdQMXFL?=
 =?utf-8?B?czRjTXlKODA1OWxtd2J1ZTNRMnUxUFBBTEh5MVd1bzl6YzJYUEY3K2lObDE4?=
 =?utf-8?B?OW8yOWhtWkVaRjVvSkZBQ0RnVWFIYWp2NmNmeVRheUpPcHdlUzlVV2FRN0dq?=
 =?utf-8?B?SnpsZWdBcVphU3U4d29OQUlmU2ttN0xuem1wVUNEenhmY0FHZmZNTkFqK0V1?=
 =?utf-8?B?djhYMk41ekxZK0NHMHVGZHhLZThjTHlISEJXbHJ3ZkdDVDhJKzdBc2FmMXdI?=
 =?utf-8?B?MlBqaWtDckpEdE9JZEpsalpWSnloOG5sYTU4a0YweTZiSlJJSnBLZ1ZJOUZa?=
 =?utf-8?B?UVcrblFlblg0c1dwZ0RyNWd1ZTh0YkZwN3F1TWluT1BmZWFMcnlScHhiSnQr?=
 =?utf-8?B?TzY1YVZXSjA5aGhMSnJHVVRVNnc3dTkwS29oUy84Y0drR0dUR2NneURpYWdq?=
 =?utf-8?B?YythQ2t1TGQ1OWZ4NlBCdmRHNUpqSjVEMlRhQU9obkpNL0pyQldRblpRUWhl?=
 =?utf-8?B?akM0ZUwzR3JjeTZOZCtsVk1zSUpOaDhhclFCbXljajY4SGxCUmJBVUtsd05X?=
 =?utf-8?B?czJpVEdlTW1nNC9qcnp0VGplUkhIZW1VQUlVUmRrQlBQU0gxcGd3SGxNS3hF?=
 =?utf-8?B?MjhaS3VmMGdjaTZiT2hNcmVVSHVzUVNzN2R4UlVScm8vdjdzb0VkWnJEWW9o?=
 =?utf-8?B?Y0Vjckc3WXZkN2hEVHM1N0lJUUx3bFI1c1dkVEZDRlBOZ2lNb05vTGw2NkY2?=
 =?utf-8?B?SStkTWNWYVZXVFRDUGFqUDVYR0gyeXJqWUt3OGl4RGFYYWtHOTQ5cXdrbDNM?=
 =?utf-8?B?d3lhWmxyRUN0RUxaWEp4OXZib0J2ZFZObjU2azEzZkhyUi9sNUd6cDFZdldi?=
 =?utf-8?B?ZE05cDBoUktySi9iTkhYREcxbXE3ZEthUHluUGRDUkJ1NndQckxaTkwrZjkw?=
 =?utf-8?B?a0lybmNQeWJ5QlBtKzhGLzhNMU9Xa2JiaWFaWlMzSWh6U2ZQZTVsUFFxZWZh?=
 =?utf-8?B?b0M2dk9nVzFvRWVad1BIWjFFS29wVjdrNXQzbnlGenlIdEZMUkRoR05ISnRL?=
 =?utf-8?B?Q3BQVUxKaGduL25KNVd3bTRVTklpOCtOR0U1dFdtS0pHUGl5dHE4bVU2WS9W?=
 =?utf-8?B?NDZMZWF2MXFPOTNOUGRUWHpzQXBxWlpiN0V2UENDTVVFTTRTQTJXa1hLVWdG?=
 =?utf-8?B?bE5SUmRSQ3hzUjdDL01teGRpNWZtak5DWXVyeUx0VWVORmZQUnc5eWdUTWlT?=
 =?utf-8?B?TUFiaEsvMllYakJSVVhISkx6RDJiL2cxcEhRUXNJdWU3Z2gxdmpQV0dXODdp?=
 =?utf-8?B?YWwzbCtyRGJvcmNtclpmSi9KbjlyTzJ2YmRYT1J5SXZEK2M4a2VlNGN0TWFn?=
 =?utf-8?B?Q0xBTE15dVBPRGJZUFBQczhBcFlTMGRaNEpFckFFclZIZ0xoK3lWdXp1a1NW?=
 =?utf-8?B?QUYvYlBUb3NLLy8wcVl6cU1SVHdQSklkT3lrVVpDYkwrTHh6VzlNblBrRjJ1?=
 =?utf-8?B?amhCY29sWHl1QVBoblVWQ0ZSNTU5RlhuK3RLZ0tBTmV6b0VYbzNEeXN3Qnd0?=
 =?utf-8?B?b1dCaUhsOVNYUnpFeFY2WWRSc01SZXBPcCsxVGUrY2ZqM1V5bTBHclVDdWlm?=
 =?utf-8?B?N00wTmkyeVlhbzd5VFUwWERMc2VCRlJ2OGFmVTZzeUZUSHhwYTlScjNLRXVu?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2667c30f-5357-4375-a04f-08dd71ec7cca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:44:27.8896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eilR1fNL4ezvvLZled/eDcWKerJJMJnvhe/QOxf6rQa1KUO1HXdXgUCm+mT3tMJQpRGMERPcvxf3aGY6sOqYQ+hrzA4VNNxbsXz2g5CfZPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7112
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

On Wed, Apr 02, 2025 at 03:08:45PM +0200, David Marchand wrote:
> On Mon, Mar 31, 2025 at 6:10 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Many DPDK drivers use the same pattern for base code handling, having
> > a meson.build file in the base code directory which optionally defines
> > some custom cflags for the base code build, then builds the code as a
> > static library and extracts the objects from it. (The reason behind this
> > is that, in meson, cflags apply per-object, so we need to have a
> > separate build object for the base code to use custom flags)
> >
> > This patchset deduplicates this logic by putting it into the
> > drivers/meson.build file, and allowing individual drivers to then just
> > specify values for "base_sources" and "base_cflags".
> 
> In general, this series lgtm.
> 
> > Depends-on: Series-34946 ("net/intel: clean up base code build")
> 
> This dependency is a bit problematic, as this series is already merged
> in next-net-intel.
> There will be some merge conflict to resolve.
> Instead, it would have been better if next-net-intel relied on this new series.
> 

Maybe so, however, this was the order in which the work was done, and when
doing the next-net work I wasn't sure I'd be doing this set in this
release!

> 
> After this series, the only remaining special case is for SVE stuff in
> net/hns3 and we would have all source compiling handled by
> drivers/meson.build.
> Do you plan to clean it too?
> 
I wasn't aware of it, but I can take a look, hopefully soon.

/Bruce
