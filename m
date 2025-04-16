Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB78C369B1
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 09:35:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54B2840BA2;
	Wed, 16 Apr 2025 11:35:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6C8BB406B8
 for <dev@dpdk.org>; Wed, 16 Apr 2025 11:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744796133; x=1776332133;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aQelldHu5tOxzi0j4XSXogbz5zab0lSzAIK7RPMJyS4=;
 b=CTe6icRbnnD7LeYhzZDx6GCXUmtwVlm0zk3McoGXJ2NEnz6SM+rPAemz
 Y/qZhANkyHa8D09qRd1ZAXx+ChY8IwwZPnUtNDnPVjM+bA/rI3ZcB9+1h
 Mw6rLinSEUQtypcShpyUEQExfySyhATKI50VTJUeE6qQPQJM0qxp5aqNy
 xycMIMDgTV9Y3+1K5i2U4Q/fZysUTx8Ja0rjYbUnPvQqbX23b1qAUf60a
 Y9tFO8pNCZswrYH3bjkpGz90dwixwvN5lovvSX/R17lcj/SssmGV70xi9
 ebQT75hMPmKs2IOI756PG2Yjtb+74B5q9IejDwPM/qAj5tbuCbzV2NNoW A==;
X-CSE-ConnectionGUID: 78g7+FBGS5maqPCtOC9BLQ==
X-CSE-MsgGUID: FSg1MRZDQvWI5Se68a7Wqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63741115"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="63741115"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 02:35:31 -0700
X-CSE-ConnectionGUID: cRvCOpmJRh6jrHfFYbBMTQ==
X-CSE-MsgGUID: lPufAcbwQoCclWSeSZNvgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="131320100"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 02:35:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 02:35:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 02:35:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 02:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwYdaXWy2CL48j6QEIYmoyvpPCjGVTZawuFc/wVEJPKW6R1A4K494wfsKlU0SJotCf2FoBBDr8pYhOYhkYLbHS/vdPgUl86NT0o/0gV9eArXAc+AhupX9KlhHxY+fxaHXctfxW0hJiOZ9mjG7sIpfy8/8YE49nx3HRFqcOZrRf22DYCvr2bJx3B0JlMDqjEKoH10mlyciFsKp4zARa5p3JRcBC+q1QYY3E1B6HCbaXpiTXZeDq8KXTXM7uNYgM+H5p41oyZx/eBobieJQ9WAKUjtZQD7CLBGA47198F8PPmVJQ755v19WWoCKr0CefD1q5kEGw7qnpGgPG297S/Kpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY9QiX2ibo2vk7p15it8RZkzvdideknPO0DwmfcmuKU=;
 b=TsOD/sxIPOXcPjZobBdRIrQM8VwF+bfuoQQZpPnYzy9NyT08eVyufAoDoMG8Tl12GL9mC27F469sfyyXFRD1sbb9NX1+IfhQUZYVYOd+C1soFr1L91JfD5aOUZ01u/p7ks5YAW3miWRVvuY+uueuI+URWU4ccNMwvBCp5MdO2LRifeZ0OJIAIloL3VBiHC7LFxMJxMdFGdYpGwFVeZR9hRxhleA7g2/x5ClHMmKW9V93bjuKbna+3OK+JaSl0W7Xd/krpXT8NifZZVNL8nQCK0NBe4xL/8Fi6z23qVL7iHiAMgnj1IJADB1U1cB2rnA8atu6zzG9SjToWTbwXd+pkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by MN0PR11MB6033.namprd11.prod.outlook.com (2603:10b6:208:374::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 09:34:48 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8655.022; Wed, 16 Apr 2025
 09:34:48 +0000
Message-ID: <13084ebf-0a1c-4d12-ba98-802494e00e21@intel.com>
Date: Wed, 16 Apr 2025 10:34:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/12] node: add IP4 lookup FIB node
To: Ankur Dwivedi <adwivedi@marvell.com>, <dev@dpdk.org>
CC: <jerinj@marvell.com>, <ndabilpuram@marvell.com>,
 <pbhagavatula@marvell.com>, <skori@marvell.com>, <rkudurumalla@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250415121052.1497155-3-adwivedi@marvell.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250415121052.1497155-3-adwivedi@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::25) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|MN0PR11MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3a97a0-7d18-4235-c7eb-08dd7cc9ee4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk9KcVpvZVIzWE9XTUJ5amhlb2cxRXRMbmE5YndYeDB1TkJKa0ZsbVZOZFZL?=
 =?utf-8?B?SG9yODZmSWZBV2dxWTJyeHRUamJBbndkaE1iVGQxSDBnczMzempQOFp4aVZP?=
 =?utf-8?B?dDdTR00zQi81alV5RDMrTmREUE9zS05HT0F0TVFRZ1ozc2ZVMThUQjNwVnNW?=
 =?utf-8?B?L3YvMlRwazhBc0hxSDN6S3YwL1lJUWNBL0hNSHFuTDdKQVVsV05uMnkvbHVt?=
 =?utf-8?B?V0hUaTJlK2tBU3h5bkl3WUlRSHhYMHZHclBqb0lZdTdVMUZKeXR5dTFjV1pq?=
 =?utf-8?B?SkZUcHNOYVRrd01ZVkhvckdGVUs4UFEyVEg5YkxRWjVUYTZHMTJBdkg5b0pG?=
 =?utf-8?B?V0N0QTZIK1ZuU2c5bDQ3cHo4QmhxdTFJVnZ5bTB0ZjdKK3E4YkhoSlVLZ0Ir?=
 =?utf-8?B?emtWbU8zN2huL2x6aXcrQWFWNjZXQ1hwOVpzQ3ZET09XL3JrTVhvSDRVUUdR?=
 =?utf-8?B?aW54QmQyM1VQQmZ3Z2ZOZmV4RDhXMk9WdDNjcm1wWUFNb0NuS0RGeGdyYTBx?=
 =?utf-8?B?WHBwOW8xZWdGMXFaUk01Y3dNTzg4Rytmemo0SHNRWk8xZGZXdENIVVdERTd1?=
 =?utf-8?B?YklrWGw2bFNxQjdUeFFjeHlJcnV1YnVjZ3AzeitlbUhYbmU2dUhmaUx5ZUNp?=
 =?utf-8?B?VFFLaGVRZnA4dXp2Z0ZzS3U0ZTBubnFBL2ZMVEllTm43aE1EbFJCekpkN1J2?=
 =?utf-8?B?bTFaTUJzS3hETG91RkN3bVBCaG1OU3ZqTWxKd2ltTnR5M3grK3ljMU93RVcy?=
 =?utf-8?B?US9YYVNQKzF2UWR2QUE5eEtMeldSRXJhcmIvVUkvRmpWK1JBNHRGWXlPZEFs?=
 =?utf-8?B?aHdNb0l2eWN5c1k5RlZWUUFlRGlHSnVCRHJCbmpoUWxKZDM0WkRKRTRpaFEv?=
 =?utf-8?B?Vk14TGQzZ3NGcmRzdzRITDVnck5NRnhDNkk4U0x1YVVpREw3MjVpT0NQbUpV?=
 =?utf-8?B?ODg2bXNOWEwxQVNETkpZTzBhaXVOTnBlbzJtUkNFZm1YcW5kd2RjUThwK3Vk?=
 =?utf-8?B?NjdibXJrTHRydjBFaGRRT05zWW1PL0lGNkR1ZXE5aUJZM25HK3pYZlNpd29l?=
 =?utf-8?B?SGg5Wk0wU0pscGxPL0xqQndaanI2NmM4aUJkV3dkQ0YxRU1HaVFDK29uc0xk?=
 =?utf-8?B?Q0FLMUxjZ0NZMG9hMFZOR0xyS3oyYytWUmpQZ3RCR1l0a25ydVpnL2RiN0Jw?=
 =?utf-8?B?NGZSeGNjMWNySG83MFhjcFBXQmFVMXE3YzhibFpZK2lxcEZRMFlXK0plVnlq?=
 =?utf-8?B?UlFZMFVWUUQvSEd4SDNwWW1nTFQrR3hnWU0vRzJ2akc2VHdaWEd0ODRtVDZq?=
 =?utf-8?B?ZnBNQ0Q0VHV1WC9UNXQvTXlaN2x3TnNVeERNMTA5NFhiY0Zhdys1cFM1eGI0?=
 =?utf-8?B?THpmc3N2bXZ4azhmNGk4NGoxTXhnZTdUKzdmK2JkSy9NYytVYzQ3d0htL3k4?=
 =?utf-8?B?NlZ6WHAvenE2eTBUNncvSFJXRkljeWZlSFBCaVl0OE9QOTJLR0pOZHc2MnBj?=
 =?utf-8?B?YWtGMUNXeDZERVJ3NXM4UndJM3RRMWFoSmJKU3lWL3EybnZnTlZvZEZIV3NL?=
 =?utf-8?B?TmRhN0tjUk1uQXZZa3MrVW5LTG81VmhBRDBiaHBjWWFvQVFMajd3aklXVTQw?=
 =?utf-8?B?T2FGbjNyRDFPcjNDQzY0ZXNpbCtGOFQ1NTJJUTFkZWRkdHhLc014WWRBV1pH?=
 =?utf-8?B?cHhqZFVxTHl0Q2dBWnE5d0Q5V2llNndMVkN4SzBKN3FkZmppZVppbE9VVm1o?=
 =?utf-8?B?ZXgzREhVeGk5T2FRRnlkSk1yNGtraStxRE9Wd1BsUUQ2a3IzNEVuY2QraTMv?=
 =?utf-8?B?MXhzVFVxRFdCaXR1eHdmMlhzYzdCcW15NURUZ3hmZ3FxNzlnVG16L0dnVjFS?=
 =?utf-8?B?bGljUFFlTG83cERNZXFrelpad2loblVFRGpWbVN0Wk1rdCtVREdNb1hINThj?=
 =?utf-8?Q?EQrLWZIBJfU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3ovc0g0YlN5QmRLaStqRWlPUU5NRytMTEFTb3YvaGNBYi9yZks1V0IyalBF?=
 =?utf-8?B?Qk1FaHBxTU9DNklObjQ4dklYUWhmV3JVOEZ5RENuSkd0U0VvOGh1dzVhUy9h?=
 =?utf-8?B?cm9lUy9nSEM3SmtZZDVXOElYbnhYZkUxMnpUUkU2cml4UlROVHNVbjkwdG5q?=
 =?utf-8?B?YXBhUnR5VlZxMmVnTDhEYWxJQzk3R1FiZkN1ZkJ1cjBTSkI1dHpjTUU0dTBB?=
 =?utf-8?B?OXdNRjBKTVVDZUUxZ1dueC84S09CUGdyZE9yVVkyd1A5eWovWG54b09yRzZO?=
 =?utf-8?B?b0t5Q2VjNVk1M2Y3WDJYMTZOMTVtODNqQzF0R1dEUWpGcjlaT3F2YTFPbDBL?=
 =?utf-8?B?YmwvZzFIUXpieUV6MTViajRQbEhlVzI4UklRWXFIWmxiOVQ4NmFJNDZjaTdD?=
 =?utf-8?B?aWlsL05PRWU5K0MrV2JEYlF2L3Ridnc4NUFRa0lGV0ovY25iT2lJb1g0T2I5?=
 =?utf-8?B?QlhqaVlxNGFHemVEVGRFWVlUakhObld5akYxdnc5VkNWZVpwMWtESFF0MnVU?=
 =?utf-8?B?OE4xVW5ZTk4wMnJocHJuNXJpYTkrejZZVlE0QTd4NnFNMWNXa1VyK2I3am41?=
 =?utf-8?B?Wk1KWlU2SGRxWGFvbmFXaDN1MEtoaFJQUE1LV0RJNXZpK3o3UWNrYlNLVkw1?=
 =?utf-8?B?N3l3MjFwRXBsck1KSnVtM05RVjVYYW0yWTRoN2NUaGFGWXhYL1RjRi9TNGNv?=
 =?utf-8?B?QjlOTGoyanFBbjlGdnB4TVZxV1JLUWRLMWYzWlVUOEp4QWg4My9pNUI2UnNC?=
 =?utf-8?B?bzNFNmJMODFTZDIxVkprdzZxaEFSOGx2VGc5YzE4R3BnRm0wZmNidk1RUlBW?=
 =?utf-8?B?NldCVDFtdndoUnBhckd5d2lTL3NsbjArTDd0eHdQUnRobEhqaFlIeXZhUFJ5?=
 =?utf-8?B?Y092TER2OE03VXQrNUkwb01xVmVXVFhxVXVrVjJTci94ajNFMjBqRzNPY0Jy?=
 =?utf-8?B?MmlyOXNHOXdnVnRnZXVrdDdNZTRjMjEyMHJLT3NGU2k0cXRpbzZ1YWwwRG5q?=
 =?utf-8?B?RTAwam1pclF3dmI1clo4a29CeUQ0RnNVekpqODZVQlNmL2FJbkxGcmh2aUNw?=
 =?utf-8?B?NG0zYVM4Mlo5OVhFUkRqZ0MwWUpIY2ROaWZvcjlKNVB2ZTljVHdWanp5YXNh?=
 =?utf-8?B?dWhjbG5uOTh3OW1FVVZDMVBLem5pcVpXVWdsbmNVWWZHaTdMMWR2Uk1HNXlN?=
 =?utf-8?B?S0JqZ0RQV1c3WC9RZEJsRlZuWXhjMElZNnF0cmZ5NGx2aVFMamZLUHlVb2Vv?=
 =?utf-8?B?aDMyK1h4MDg0SmI3aXlWQ05tS1dRWDEvMFl2c0MrWC9PdXdrdHNtRnd4UExO?=
 =?utf-8?B?MmVHeHpxV1huV1RVQzE1T2hjWTBMMmwzazFWaGRCT1dRWEppTW14NjJNRFFX?=
 =?utf-8?B?MFRvWmVlTWlMbERNL05PbnZxSkhVeUQwR0IxVGtyRm94NU5lR09heXVaY2Fr?=
 =?utf-8?B?dTNMNUV6R1YvY0I1amxKNlFLR3lFdk5LaW01YkMrc1FodHBJVmlkUUJoM3hv?=
 =?utf-8?B?UnY0TzFIRU92aVlrYmxKMFUvTDV0T0VBWkwxU1RJRlFVUHVEY3dUcksvY2xX?=
 =?utf-8?B?R3IxSnBQYjZMa1ZleU00djZtMUFHMHlGd1pvb1NmS0VIQ2dFem5kS3hPNGtR?=
 =?utf-8?B?dEE3aWpKZmpMOThVSkdrK0ZQbEsxckgwZks0Nk1QY2lqSDhvbWxGMFlIdmIw?=
 =?utf-8?B?aVNCdlBBMXJoa3JxOUE1LzR6Q1hPRFBlaGlNMnI3TjRYVGN6MVI5ZU5JZDhP?=
 =?utf-8?B?NFFsVlJORDVETndjZjlaU28vRm5QSWlqOTJFSThqRHcvWXBRSnBzYmxoQXhF?=
 =?utf-8?B?TWtkQmQ2K3RkUkh0TlNuM0xQMTVqejI0cXZxbDFvMzNUSG9hUUVtNDQ5RHp1?=
 =?utf-8?B?blBidVJyM2tza1RWdUN2MHBGUVo0UElsYnNYdFEyUGp0Ymx4MDZyZkhDY0py?=
 =?utf-8?B?MkJsUjFVT3hnZ1NJRkJkcWxMUno2SmdqTzByY1hzb3F5MnhVMTM2UTkxYk9s?=
 =?utf-8?B?ZWUyRDByZW4wM3lWVndlVC9MMElLeTNFTTlsSzhJc05Eby9rM1ZaYXgxdnRF?=
 =?utf-8?B?QXRVVk9LTzlxc1I0cDMzY0xFMThhY2NHNXhSL1N3WGFhWHpHbW9RY1NlR2pZ?=
 =?utf-8?B?bmNFN0k2Ry91TVc4MEVGeUNHK3JUQUdNVTBHODNvSVFBQk5Scnd3dDJWTzM3?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3a97a0-7d18-4235-c7eb-08dd7cc9ee4f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 09:34:48.7613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnLZ/Sm0CbjCy1UfpAU+fYJ9lUJmLzohQUA44l3uBjGxXdpI5qKhgx6Kz+XMSa+2dXNZ/KmNzIdFN+p61pN9OhBCW6ZlBeW2goGY4vFvKbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6033
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

Hi Ankur,

On 15/04/2025 13:10, Ankur Dwivedi wrote:
> Adds a lookup FIB node for IP4.
>
> Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
> ---
>   lib/node/ip4_lookup_fib.c | 127 ++++++++++++++++++++++++++++++++++++++
>   lib/node/meson.build      |   3 +-
>   2 files changed, 129 insertions(+), 1 deletion(-)
>   create mode 100644 lib/node/ip4_lookup_fib.c
>
> diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
> new file mode 100644
> index 0000000000..9c71610718
> --- /dev/null
> +++ b/lib/node/ip4_lookup_fib.c
> @@ -0,0 +1,127 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell.
> + */
> +
> +#include <rte_errno.h>
> +#include <rte_ether.h>
> +#include <rte_fib.h>
> +#include <rte_graph.h>
> +#include <rte_graph_worker.h>
> +#include <rte_ip.h>
> +
> +#include "rte_node_ip4_api.h"
> +
> +#include "node_private.h"
> +
> +/* IP4 Lookup global data struct */
> +struct ip4_lookup_fib_node_main {
> +	struct rte_fib *fib[RTE_MAX_NUMA_NODES];
> +};
> +
> +struct ip4_lookup_fib_node_ctx {
> +	/* Socket's FIB */
> +	struct rte_fib *fib;
> +	/* Dynamic offset to mbuf priv1 */
> +	int mbuf_priv1_off;
> +};
> +
> +static struct ip4_lookup_fib_node_main ip4_lookup_fib_nm;
> +
> +#define FIB_MAX_ROUTES (1 << 16)
why only 64k routes? Modern BGP full view has about 1M prefixes
> +#define FIB_NUM_TBL8   (1 << 15)
> +#define FIB_DEFAULT_NH 999
why this particular value? It is ok to use magic values in examples, but 
not for libs. Consider something like 0 or UINT{8,16,32,64}MAX or some 
meaningful value within graph infra
> +
> +#define IP4_LOOKUP_NODE_FIB(ctx) \
> +	(((struct ip4_lookup_fib_node_ctx *)ctx)->fib)
> +
> +#define IP4_LOOKUP_NODE_PRIV1_OFF(ctx) \
> +	(((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
> +
> +static int
> +setup_fib(unsigned int socket)
> +{
> +	struct ip4_lookup_fib_node_main *nm = &ip4_lookup_fib_nm;
> +	struct rte_fib_conf conf;
> +	char s[RTE_FIB_NAMESIZE];
> +
> +	/* One fib per socket */
> +	if (nm->fib[socket])
> +		return 0;
> +
> +	conf.type = RTE_FIB_DIR24_8;
> +	conf.default_nh = FIB_DEFAULT_NH;
> +	conf.max_routes = FIB_MAX_ROUTES;
> +	conf.rib_ext_sz = 0;
> +	conf.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
> +	conf.dir24_8.num_tbl8 = FIB_NUM_TBL8;
> +	conf.flags = 0;
> +	snprintf(s, sizeof(s), "IPV4_LOOKUP_FIB_%d", socket);
> +	nm->fib[socket] = rte_fib_create(s, socket, &conf);
> +	if (nm->fib[socket] == NULL)
> +		return -rte_errno;
> +
> +	return 0;
> +}
> +
> +static int
> +ip4_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node *node)
> +{
> +	static uint8_t init_once;
> +	unsigned int socket;
> +	uint16_t lcore_id;
> +	int rc;
> +
> +	RTE_BUILD_BUG_ON(sizeof(struct ip4_lookup_fib_node_ctx) > RTE_NODE_CTX_SZ);
> +
> +	if (!init_once) {
> +		node_mbuf_priv1_dynfield_offset = rte_mbuf_dynfield_register(
> +				&node_mbuf_priv1_dynfield_desc);
> +		if (node_mbuf_priv1_dynfield_offset < 0)
> +			return -rte_errno;
> +
> +		/* Setup FIB for all sockets */
> +		RTE_LCORE_FOREACH(lcore_id)
> +		{
> +			socket = rte_lcore_to_socket_id(lcore_id);
> +			rc = setup_fib(socket);
> +			if (rc) {
> +				node_err("ip4_lookup_fib",
> +					 "Failed to setup fib for sock %u, rc=%d",
> +					 socket, rc);
> +				return rc;
> +			}
> +		}
> +		init_once = 1;
> +	}
> +
> +	/* Update socket's FIB and mbuf dyn priv1 offset in node ctx */
> +	IP4_LOOKUP_NODE_FIB(node->ctx) = ip4_lookup_fib_nm.fib[graph->socket];
> +	IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
> +
> +	node_dbg("ip4_lookup_fib", "Initialized ip4_lookup_fib node");
> +
> +	return 0;
> +}
> +
> +static struct rte_node_xstats ip4_lookup_fib_xstats = {
> +	.nb_xstats = 1,
> +	.xstat_desc = {
> +		[0] = "ip4_lookup_fib_error",
> +	},
> +};
> +
> +static struct rte_node_register ip4_lookup_fib_node = {
> +	.name = "ip4_lookup_fib",
> +
> +	.init = ip4_lookup_fib_node_init,
> +	.xstats = &ip4_lookup_fib_xstats,
> +
> +	.nb_edges = RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP + 1,
> +	.next_nodes = {
> +		[RTE_NODE_IP4_LOOKUP_NEXT_IP4_LOCAL] = "ip4_local",
> +		[RTE_NODE_IP4_LOOKUP_NEXT_REWRITE] = "ip4_rewrite",
> +		[RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP] = "pkt_drop",
> +	},
> +};
> +
> +RTE_NODE_REGISTER(ip4_lookup_fib_node);
> diff --git a/lib/node/meson.build b/lib/node/meson.build
> index 0bed97a96c..d2011c8f56 100644
> --- a/lib/node/meson.build
> +++ b/lib/node/meson.build
> @@ -13,6 +13,7 @@ sources = files(
>           'ethdev_tx.c',
>           'ip4_local.c',
>           'ip4_lookup.c',
> +        'ip4_lookup_fib.c',
>           'ip4_reassembly.c',
>           'ip4_rewrite.c',
>           'ip6_lookup.c',
> @@ -34,4 +35,4 @@ headers = files(
>   
>   # Strict-aliasing rules are violated by uint8_t[] to context size casts.
>   cflags += '-fno-strict-aliasing'
> -deps += ['graph', 'mbuf', 'lpm', 'ethdev', 'mempool', 'cryptodev', 'ip_frag']
> +deps += ['graph', 'mbuf', 'lpm', 'ethdev', 'mempool', 'cryptodev', 'ip_frag', 'fib']

-- 
Regards,
Vladimir

