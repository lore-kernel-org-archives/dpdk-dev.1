Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B994ACA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:58:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EE2440E44;
	Tue,  6 Oct 2026 12:58:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 692F0402A2;
 Tue,  6 Oct 2026 12:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791284287; x=1822820287;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/Tf2pZTxBB81cJo0XezXkuR+c/b7vWGbygB6+KZWkXQ=;
 b=iA1cO2zaahTUo+325qGUOh2ziNDgvM1buCuZLFvlQK8DX4NLZFbpjh64
 aYFyd5ZW5TFlQ+rfL6m+xKTqUykiGeb+VWuSGDz3tVBTEOHf85lCl884B
 wzWP5Bws/Bp934+UknAA7GIuL0umIvFsaeVDmiiLxl83hT9TTM2MEC7GX
 fHQD5qCeGLp77BZk5X/0CKjWGkz1kHSEyBfDN+kxnVzy1vfD8TkNBJilb
 ztWlltawkPS1hw/MyfuChOXvVKzjlawEgx8TzGvYhx6QLof6++mdGYJzK
 zU3wmanBGOW3ALlcq1SUuRi2btz0BJazonjRH1I6mbqfL02ceiWuFKdaP g==;
X-CSE-ConnectionGUID: F0qFq6FeS0i4rEjM8d4NAQ==
X-CSE-MsgGUID: o2Roo2tySGKalIUZjQ5qeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="8515"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="8515"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:58:06 -0700
X-CSE-ConnectionGUID: 4SAhzAscSEmaBc6Ut3rrRA==
X-CSE-MsgGUID: +1xeSMiuSY27ohcsQsyUpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276652968"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:58:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:58:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 03:58:05 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFWho7TYmfLFG1KKyiXBDHZN7CGp7Ji3E+kQv8XcoJFlHflLrmzcj8jFtbWFg8p0lt0QRDvuEk0hRQTm3UTwxJf2zftwUWgVWmxnQCPkIn5SW+QpNpah9GftGd10ZMrjnVDa74J12IHBduqKLyjTWGRIU7bHjFGBqZ45cb3rwx6rbdQd8Y7W6Ex20+9q9YTNWTRqHch7URUcpuhcCeCFr27jPZJHjauKFyYHAPURsd4qJthVIExqCvdQUWsru1UQbUb6ocC5DI0ee5hnMQnSAJvr4mng6GAfPCdmIa2s47Im0CKHYXKeJZOeGnfG1l1l2vD3317jwQVJSPwpYACW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILGtRyn6xX8sZv9alQdiu7pRYE/3OfqQLwJ63DrfRJI=;
 b=vA5DDquWqJwgA0wMksGljcYA0PQLvZr1SglF1asU782fasWSkgJxeGW8k25vaBexCJr1TzEwbXQWTTdC5y+AELA88h3mU7D9kH4o9ZJLdLh4hTVvLft8dF9yAFr0T8Ta9uwqOV9Am+Zqwt6wEeOzWFXHIirHocsRoLgh4/nth9qPv7Gi9N6ufkN8Y8nZUEG55HGzvwErMB/cLuXezuT5IJ1PAhCDiFonf6lp+m90Skbu+IVuowo8JK0MUBnwoiKT8Bhqc6L4iBuWwRgQs/VzDH9egEgIodV9tFjONnHO1Ij89h3ClzA9kMNvS/1j4CMkos7SDWf0Edvz7ifw4sLs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 LV4PPFA6977791B.namprd11.prod.outlook.com (2603:10b6:40f:fc02::22b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 10:58:03 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 10:58:03 +0000
Message-ID: <ceeb7468-d1b6-49cf-8c42-197bd6af81bd@intel.com>
Date: Tue, 6 Oct 2026 11:57:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto/ipsec_mb: fix Null ptr dereference in
 set_mb_job_params()
To: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>, Kai Ji
 <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>, "Declan
 Doherty" <declan.doherty@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <sdl.dpdk@linuxtesting.org>, <dev@dpdk.org>, <stable@dpdk.org>,
 <roy.fan.zhang@intel.com>
References: <20261002112046.601087-1-Alexander.Konyukhov@kaspersky.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20261002112046.601087-1-Alexander.Konyukhov@kaspersky.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0229.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::24) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|LV4PPFA6977791B:EE_
X-MS-Office365-Filtering-Correlation-Id: abd2327a-2971-4039-12dc-08df2398b112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /5gwEtuDI/40BZWUs5AcfN5f8B0FNGp5SDm3fswiGNEfUme0DcRSYI/jmQTzWtgbhd7KSZJGgbALEJLJugjOUir7RYpd6wE0d7Fjz904zdnZCvTv6nYTj0XM6y/+7dlg69FmWXkTIfjj2sQSo63Ck09XwK7VkpFyo4WABz3CHcRFRBCIAj5ihj0AoKRuowfepf7hjAcHuyZmuclEp4O9Y6JKtc8ffYgibHbjti8GSpxBxUbyGPJM6EgwZF8cGROrv+6ubINKaBQXWDCBhnmEkSUDA3U+9RLXPLIqOK1+Cvdq3i5YFessLh+zgbX59buWQb4ImQzUljgSujlsGl4KDjjmJE4cMuKtf7VLvCUE9HncTBP59XeyRyfRp4LVuQ/UfIulj8l3zQBRTjCYUUkTlJzgDEuwTWizzv2UcZjc3K6aNUajQbu/l/vHY5LjdOtIYjSzTL9sxmKAGjwgyG/4UdS+aF4epQlVTdCf9SFui2sFXvrlQmT9Ir4gPITULLDCTcyLFgjZfT8DySoTWt9CfPqVau4n/RJUduf+PJe09vn/Mt2gBwIt73KkbBaLMM7vXjWicn/aEMMzC01+NqlS39etd4IuB5g4kiSe1IcOZMN/XdFmEWHDpJlNfARMD9y22DnAtq4yd+uVq6KFT7Cw6y96OQsG0OMF31oXWuEBrqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dMWXZLcm1mNmVXNHNSZzRCZ09WWWxhWGVQS3ZjclRiTTN6a1Z6Ym9vdXRT?=
 =?utf-8?B?RGxvNm95N1Z3ZENxN0V1b1BqanBQaXlVQWkzUnBkYkdOSnExVlVNTXRyU1VD?=
 =?utf-8?B?SWcwdHlmTHhhSi9JYWpsbUNlWFQvUGtzUG1MSnN1dWRSUGFrQzFpSWdiWFRx?=
 =?utf-8?B?dGhkbEFLZWpFZWZ2a0ZEUFBZWHNXaEFnUkVJMGhYMDFDVzdCYUlsYzY1aGJm?=
 =?utf-8?B?MWZSRTlobUJaS1ArWkZ1MWdlN3VrNWpZczRyR1BBRGVkdW94cXBzSXY4U1lN?=
 =?utf-8?B?WjZGZ1ZJdEl2VGtVby9XOVpPb2xZZUJHWmY3bmlXOW9MY1lQcWQ5Y0Y1VVdl?=
 =?utf-8?B?eVBxN2tqSXoxdVVTTFF5ZVNNM0czNHFtSThoS2o5aDQvY281MUlZUmY0Mkhy?=
 =?utf-8?B?blh0bHBONW9uanhpVGNhaEhnc2x4TEZjTEVlSUZwcksreVkyT2FHU2ptNWlq?=
 =?utf-8?B?bStRRVpYSExHZXpiQWtPeHRZVTN0MTNrMFFaMFBjcGNrVEJySHZwSTRCQkkz?=
 =?utf-8?B?Z1NSQUFsMXU0TmRMeTRyL0VFdmtQNVBzYjduQlNENFhROG1qR3RUb3hGcmxn?=
 =?utf-8?B?dlNUR2hBNTF0U3BrakNoRVZJUEUrT2RoQ3ZjL3hKc1d6QUFiTGVhM0QyaEZI?=
 =?utf-8?B?ZW1oMFBYTVJjdWhzOWFxRmJSWnlQY0ZZWHM2Z1lSODhRMjFtSzRUV1ZsUDlp?=
 =?utf-8?B?V0h3Wkpxb29sdkUvZm9iNDNlREV6OCt1Nmo0WkExWkZ6RzFLVEd6OU1KdGZx?=
 =?utf-8?B?ZzFldkVtaTR5bGFoNlZNZ1QyWDJDVWxoQ05Ta0UzZmtYWDhDOXRsaDU3MjN2?=
 =?utf-8?B?a0ZSRUw1V0s3TElqaUFmTFNVZ0dXTmN0Wm41RDk4UGY2R05zQSs4U01yaHpm?=
 =?utf-8?B?Qjk4QjBWbHRHNE93UkZNSTNEN1hVUmMvVVdraGlVd3kxVTZoNytNYmp3dWwy?=
 =?utf-8?B?dWs2dnA5eWJMS0xrUmM1dzdpN2dKQTJxeFZNMXdVcTFURnB2WHhycFdkRnR6?=
 =?utf-8?B?L3N4Z1RDa0ZkVTFNNnF0QjArQmROblNlTEpNbDh4bUpoQ3lkWk1meVZxSUhs?=
 =?utf-8?B?VkxVbmlLaVVZZThMZ1VhbE5oOVE0cWlsZWQ2a0dvNFNmSENuMlBjYWpadXp4?=
 =?utf-8?B?NWFIbVQ3VkxiejZGUGFLQzBuQTFvNHZZMHlOR3VobkdFMGFSTWlOelhyMEZv?=
 =?utf-8?B?M1VCek5rcXhnYzdaNW5PZ2RiNzhXaXRkZlM5STMzZDNVWVl5ZFcweXpkYkN0?=
 =?utf-8?B?Ty9IZUF3a3Z1TGRHd2V3anN3TXhkNFpwSDBwbVpBS0Y1RmcxUFpVNlNJMkNn?=
 =?utf-8?B?cnJ4SllIbmQ2Z0lvSXNycGN2V01ldzRycEZBQ2Z4TzhNUzJrdmliTTlOQ2pu?=
 =?utf-8?B?MWNKbm9GeU53ZjhmeU1WRU5aeG5kZkNQelBCNzI1WVEzQ1ViSjZCejFkK0hM?=
 =?utf-8?B?enArc1dtc3RsUUIxcDBWRWozNVdMVUhBZUU3dFNrOStzcXZPNVZGRkZPTG9h?=
 =?utf-8?B?R0RnN2k3T3d6c1FncitSNzl3dWp0RXlVOVRESkhKRHJvUUN3aVlrVktjY3V6?=
 =?utf-8?B?bGg1K2RKU2s0bGZOSCsxMmlRdEMvU1YvU08rTHJYeDY0UVhENHNSbG5pelZZ?=
 =?utf-8?B?dlc0MjNxdzhDOEFYaFl4eGdaRlRNTWhublduYXlXUDZxcnFwbEVKK3ZlRCty?=
 =?utf-8?B?TDN6TUJsNW15T1o2VVdtWjB0QzBFa21lNm9uKzdzOUZ5TlhoT3hBaHlMdjZh?=
 =?utf-8?B?VHdMTmozS3JTb0FBakRESUxJWlpvSGQ4am9WTmVQS1NKSU5SMi9mYU1ueHRs?=
 =?utf-8?B?eldnTUQwU0VINytEdVFON2FYV005dTBWRW5ONFdzTlI4aSs0dklRS3ZtdHFD?=
 =?utf-8?B?eU8zSytaTGxiTndvK0JVbS9LRDcvei9RMUdwOUEvSldReDB0czFxVjNHdFZu?=
 =?utf-8?B?U3c3RHdlUnZuQkpZcTBZRDBaVGRBYlllR2dKK2x5WnEzVXU0dlYrVUlzTFpC?=
 =?utf-8?B?RXpKUEpYUEdndm55bXJQbG95ODIrMlhxOEprNmJaQ2dDZEtXa1FtZEpFMHAz?=
 =?utf-8?B?YlZ2TEF6d0o1ODZOeFIzZzhNcXFBa3VtRFVRcXNzRkFyL1RLeUozQ3hUR1pJ?=
 =?utf-8?B?YlJITkhIY3BheUQrOWI4dEltVmZZWnhiamc2TGwyS2lEMVp1TVU1NkE1WFFD?=
 =?utf-8?B?dGFFY0lyandWQ29wRHhrQjcySVVLL2NrZFFIbGhVdU96bGU5UkMwaHdFazlL?=
 =?utf-8?B?NjJJSEdMQjBxQVVQMm1IQlhseEwrbWVtNlgrUFgvTFFHSlpWNCtrdHp2aVpD?=
 =?utf-8?B?ckJSdkpJZCt2RUdUdXRxN0JVMVF3ZjhrYkRWRFZjc0RNT2J2T1lUZz09?=
X-Exchange-RoutingPolicyChecked: qFq+lMZPLLVwuWw8oQGquloM+EP5CGZlrIPlOXocwgq8vmW6E/dMtHQImy7xAK/9nkWPm8uTIAtk3Sdc3gi52bH5WDrolGbHegbAz/nZivwDB7y7cdJko+lKhKE8lc2HpbunxqvNDEJOY9R740AJSL5hmf30o9cznVKdjD705XGbbWYQklx8Cj7MGInJ02JhlzGjct/d37lucgU9eKfVJ8z4QZVjD4ZVwJzyQeM+tHPbhIpwGcLUWNnqQXMp8Q2/quRxaw1yoDosLV6bMSystacstFQIX/uOnrUKz09Eh5SOnfhtOzluJV6z7EBft3bNEGeXDciQB8JJYqdl0R0s8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: abd2327a-2971-4039-12dc-08df2398b112
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:58:02.9592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PApHkRvY7w71iS2eQAtV2L5k7nkggrUJci5RXGBTgbOjpu9QX60eEw7oRNxcKUOX6wWWpoGr3rFHFSsmnlCF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPFA6977791B
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


On 02-Oct-26 12:20 PM, Konyukhov Aleksandr wrote:
> In function set_mb_job_params pmd_aesni_mb.c:1742 check
> (cipher_mode == IMB_CIPHER_NULL && oop)
> is not enath to garanteed job->dst != 0, which in turn could lead to
> NULL ptr dereference.
>
> Add new check for (sgl == 0) to be shure that job->dst
> was set in pmd_aesni_mb.c:1610
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 03944ff5e3df ("crypto/ipsec_mb: support null auth/cipher for aesni_mb")
> Cc: roy.fan.zhang@intel.com
>
> Signed-off-by: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>
> ---

Hi, I send a patch that is basically your first fix and a comment and 
CC'd stable dpdk mailing list - the NULL SGL OOP case was actually 
handled by the existing code, your initial fix was fine, thanks for 
taking the time.

I also added test cases to verify the fix and cover this case.

