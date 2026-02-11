Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D166EA8125
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 09:20:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED959402B5;
	Wed, 11 Feb 2026 10:20:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 219594026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 10:20:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770801655; x=1802337655;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vjApKN2kC2CTFdDEyEVEHcjP/SRTeQD44KYUhN6FkXg=;
 b=Z8MZrJaNMOvYtbXg+jWx30226n4/vK/rZPbX+0mTc2Z/ETa/t+EUdn0h
 dPvym87t7RgYWhJks+IaeD9qyI+paXqYDksE0vkYrinYpNzAGuhwFl07f
 akHhMDRkwPEDnAxN5WYfmAa5YpOBSWLnTgFtK+cHj6zHINdQRSKzrrduj
 Xtn8VKbV2H3YRgbOJlbglKJqn5AWtoLl+GQ4S2v7a4Wbs6mzeCeKhoPMN
 vYugFk6/R63GfnmEmsg8cqu16t1Tmdp3RLqx8oMy8BPyxmQNn4p6i1myu
 6gDs5XNRVAtV219fu/ynUF4FsqdKmhLhbMEDBCNetJdLISNFFSyEEZgaV A==;
X-CSE-ConnectionGUID: cnijmfRFQqyCmQzCKB4TAw==
X-CSE-MsgGUID: N4paELsiRKuRt0wqLUHrDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75569975"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75569975"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:20:54 -0800
X-CSE-ConnectionGUID: AJiWJfBURmCnpSk62+Yv9A==
X-CSE-MsgGUID: bPvglzr7T4SBx1uIVIcUYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216701673"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:20:54 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:20:53 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 01:20:53 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:20:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o00QUzTD+XHhHbSmj+73Dq1LW0e2Gx8RdjrPlL06N0w9lol0pc1BHH06cGmY3sU2+KjR70mVP4kMpWajTGqM6zXqnKjYHpdpagY3DhztP4Kzhb5Z18oiddbWIW3mmUdoqoPuus/CvHZDQX1O0LIIHYdk75/0kMyk85JxdhNCOumGAe6/LqVuQwa/slfwysZMGp+7WVMTHa2WWkDXhY2at80uoXn5dzyVVA3KI00n1/DiSgD4/d1rxwtTKV52lJeezUfpFRvqO9MdwlrJwGw8UhbrvE4V5Am2NqLP5T8L4u4i/Sy/VFSpwZbYoMNITBY/xTmnsLwXhM1rMLZO52jIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbH2u4R2w1trCtwHdDUgZqap5fL0pNEt68he/ax4Svc=;
 b=Kzpcsk9sBoWmjt9KR8YtuGq8DtP+d57DsbgY5IaH4CddvMQjvCWHKWBeQPKVrVULv60w4YAPZfNJDAIA2tnOjmX8oJ6xuK1YSrPaJhw43kIIrgbH5tgj6XP2BwjaaLIY5h88jFkxqRdC3y8Vdd7d40qm1EJpImM6cFafqJG34K5pPy2hsPKAipw1cSgKdNspOEazCeW0BY+5GPYt11yr98EqnTXjEgDTYIVSx518BF5rbUIEZWg0ZyHaSM3DlMRXDnhLpa+pxvNFUdbxV6sy0KcQnwIiM+b+5QtiHhihjICXJDFovqcIlfXNqh2n9a82YJpyomi6xBps+CoBM/x8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 09:20:46 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 09:20:46 +0000
Message-ID: <f7c399fa-ac12-42fb-8961-020950e7c113@intel.com>
Date: Wed, 11 Feb 2026 10:20:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/35] net/i40e: refactor context descriptor handling
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-8-bruce.richardson@intel.com>
 <abad013f-0a13-490e-9443-0441233684c0@intel.com>
 <aYs8WvDxV84HohAu@bricha3-mobl1.ger.corp.intel.com>
 <648f5f1b-a19b-43b6-963d-3add913e1f93@intel.com>
 <aYtwuoRLGMISZkZk@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aYtwuoRLGMISZkZk@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f602b1-e42c-47d5-8aec-08de694ed6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm5vVytmVm9CZmhrdGIwVnQveGtXVTVkZlBMcW5HRDEwSjRVT3h0ZElmUGJX?=
 =?utf-8?B?YWZlSXNta1NzWGJjKzNQY25iTGVqRjE3WVRldnM2RWY0MEJMeEtkSjdQSHlU?=
 =?utf-8?B?MndNRCtIcmxKOWk3aUpQYTlzNEdGTzJ6cytHQ3VneTByd1prY2p4Z2d6Q3pz?=
 =?utf-8?B?bWF1L2l0d2JCb1R4WFlTaGpiTUI4UVdnemZQa1U0aUo0MzVOVDU1MEFnUW9Q?=
 =?utf-8?B?RnMxYm95bk95ME1mZWVHa3AyUkhtK2pEVXN4cUEzVjJuQm1TdTBCam1Rcngv?=
 =?utf-8?B?bGYwRlhmUEZmdWtUVkZpeEMrOWxxSlVvOGlIU1ZINXNVOEtCaUZ3WExSQjFm?=
 =?utf-8?B?dk9BMjZVRXRSNEpmZHUrQWU3SXJWM1BtZkhIOWN4UzZHSEdSbWZBSHJJd2h0?=
 =?utf-8?B?MVV5dkFpWUhSTEdKcWlJckpyamcyem1XNndpQXhxcmcwVDlQaHo4UFBTd24r?=
 =?utf-8?B?TENrbTBMcmwrWHNUNUJTMmozRVdIak93c3FuN3BoRDFWOFVxSWlZNzdGbU8w?=
 =?utf-8?B?SlBpdzN4YzkxQjF6OThQb1laY2Y5QnQyU3pYZGVsbjdVUnJOek1ZcDdoMXVB?=
 =?utf-8?B?d2h5cFNzKzlVdlBSVEIwb0t2THpBdFdiYlNwOVJ2cmE2emVkSFlTZXloSGdC?=
 =?utf-8?B?azRJeFR5ZDRzNWQxTUNJS2dzSXlPOWFHUGhiRm9FMFdvaWd2blNGUFVNTUxv?=
 =?utf-8?B?UVM4Y0VGS0xZNWU2dk9NbXMrT3RhQ21XTEJIV1U5blVpTjJYWkhEa3ZJbmJs?=
 =?utf-8?B?L0p6S2w3eG9qdGpZUjNraDlGMUl0K0tRV2E3c2owTWxxVXlqa0x3dnJuQytX?=
 =?utf-8?B?OGlCVmpSMTdUVFlhaVZpcytYY3VHMm1HdXU4ZFV1bXRjNXRuNDcxOW1zdU5O?=
 =?utf-8?B?ZTFHVHV3cFNhY0xMTjJSY3B1RWFiOG85dkMyZGNYYnZFOTNENzAvcjRSUmFh?=
 =?utf-8?B?K25hM3ZEQjZ4WmxmVlo1b1NVNWhHM0dGYWhueUhQb2R6cW5jcTFLRmdEWHB3?=
 =?utf-8?B?ZFpya281L0VWUTY2R2lLQ29uMVVnOXk5MUF5TEVHL2FBaCtNVzNuVWdXb2lV?=
 =?utf-8?B?aDUwOGk0NmFucEJib0hUektVWi9VV0YzN3lvL2ZmSWNiN3gvVFl5RnFVc2du?=
 =?utf-8?B?OE5zc2ljWmNIWG1tbnZlb2gveW53OG04dk5aazRoZWFtTnJHUXVLcW5iTzQ4?=
 =?utf-8?B?NUxZM2J0enRVN2dvMTlacmFSUFlwZFdGbDVWZzhoWnpCbHFHM2ZwOHNMNm9N?=
 =?utf-8?B?WDVOckJla01Ld2s2eC9OV3g1dXJJZEk2VEFYd1k4T2F4Z1ZaQW1LdHBzbHpJ?=
 =?utf-8?B?dVNqMUkvajhOMmgyU0MvSFlsQVA2S0ZmNnYrbDZ1YloxV2xiQ1JzZzdsdFRt?=
 =?utf-8?B?aG9BQkdMSEZFZUdqcE5HQWZLci9BeDNySXA3TXNXQmVpVGdTVzNNSHI4NjRM?=
 =?utf-8?B?bXd2TmIyRWZYNGFYZkdKSE1FVjc5MTAvSDRzOVJhZVNtSTJXYWVncnlLeDhS?=
 =?utf-8?B?U0VBbFpSbitFcm5acUxmSlBFSUlQSmNDWUpJcUpVUXVGaXZ1eDNENktRcGEx?=
 =?utf-8?B?QnpXOXF5aFBqNHBIOW90L2lFbWRFWXBYa2VQZ2lrMkpCUXl2eHpDeDZEVjVt?=
 =?utf-8?B?WFIvQ2duL2FEaG1XVllLT1dzWC9oUytuK0FZSHNDak1MUm1WYUpuNmZPMnJB?=
 =?utf-8?B?ck5SK2VmNDRUQkZSQmxvY21LM1lBSHRSNDRUMWpoTFIvMDFzek1ZYnM0bDl3?=
 =?utf-8?B?QTZMZ3k5MHJXYW4wZkExM2xScWVxTExHUEZxd2ZVMDV4WmpOSnBHUkhIdlg4?=
 =?utf-8?B?WU1HOUdYeXMxdU5VaFFZNHpaTFhoRVFSS09ibjVuZHUwOWJha2Q4dnpzS2tl?=
 =?utf-8?B?RWNBU2RqWFhKcDQ5bTE1bXl1OHB1Tzk5eTAxcDkyd09ReUgxRDYzZDhOcmxk?=
 =?utf-8?B?WTBrU2gyRUlHR0RLcjZrQm5pRm5LYVVBYzdCWjUzSlhJOUpSOFUzalR4SzhP?=
 =?utf-8?B?UnZFbzRsNENkR296a0ZtTEErTzN1ZGJEbTFTZk1ma3QxT0F4Z1NUaDdZVy9Z?=
 =?utf-8?B?ZWZ6Q3EvbEZWNUNKbjNtQ1VsRm9zS01seG1YL3lWT0lUanYrTkxZSm5NRFVz?=
 =?utf-8?Q?YFBA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldCWExkRTlUUjM1RHNBWXJxNjhDd0RPS2xGM0N5dDdEWEt2SUhOQ0xSQmN1?=
 =?utf-8?B?SnA5ZXJGajBXdkNDSlB2SjNMRjZFTld5VUsyWTZYUWdFZjFoZFNkSFRPaC9G?=
 =?utf-8?B?blg4V3FleThKc1hrakFNWWhaU2ZrN0VVSHJ6SWdxQmZIRjhzc2FoSW9reWQ1?=
 =?utf-8?B?ZW82MjRwbzhtbThQRnlpV2diOHJmZW1WNndQa2xiWEJLWElzNVNHQ2lpbzAz?=
 =?utf-8?B?MExhSHFFekVpRTNEcFAxT0xxNUZZWVdyZ0s5clBtMFBOcGhxOGJ6aEdYUGNu?=
 =?utf-8?B?TXNzeUE0eTlXWGVRLytDSUVvTFFLUC8yQ1FvRTdDU3lldTFUdmRsWDBIMzlv?=
 =?utf-8?B?d0xUdm5SS2tBZXl1YlladStnSG1NZXRYMlczWmU5TWRZeGRhdmt4UDNqWFhO?=
 =?utf-8?B?WGdyczBhd3VCbldta3ZQZ1FwNFU1bW1ZVUk2Y0RZaTJxa2RoMlU1N0U4SDBO?=
 =?utf-8?B?bjRvWnZ4UzdPMVJqZVhmemRzQ04zYWozRC9POXhwQmdmOFVaWWhXRThnMlFD?=
 =?utf-8?B?SzlaUXIzRE5ZNmRyQkhIQ2thY0tNdGRDc0dIUk85ZHhxb0JXNUJQSTVFWkZT?=
 =?utf-8?B?Rk13ZFhZdHdXWE5xeEg4Wi9ITGw0dndISGdXSkY3enkrdWYzQjFmcDAyNFox?=
 =?utf-8?B?czRCUVZlR3d0MWZCMysvSm5DZ2hBYUhPdC9LL255enlFbkNsL21GQ2tzVW1j?=
 =?utf-8?B?bUd0aEZxY3cxNlFnZ0xRdjVCT0ZxcWUrZW9oRmFPbGtXaUhiRitNOHIwNDhh?=
 =?utf-8?B?eWZlTk9wV1pKZVREYmlpbWx0M3VxRkFMNlhxSVcvQ1h6aFVGRThFTDBsS3Jp?=
 =?utf-8?B?TGZOQW5rb0tyNXU5UkdQclpGY1FCWExBdk9vLzlUMzgvUUpSeDFoOE1DMUtz?=
 =?utf-8?B?Ti9qUEdiMjAwZ29SWngxYy9EdXdGZEs5aFIvdUxUdVA2ZjYxUG50OHd1VUpU?=
 =?utf-8?B?SWh4ZWQ4eWtGS3h1RklOanZjSzQvRzlzcHFGM3ZMajJIT0VwMHRjLzRhOXFy?=
 =?utf-8?B?Sm9ObDV0ZXNMK3RUMzhrRVVWZVg2amt3ckZ3N05Bc3NweWZtd2d6Q3NTQ2tR?=
 =?utf-8?B?dkJSWDJyVVR6NkVBdEVaZjROWCtWcVlxZ2NTdHlsVlRONTRlRUNoZnNEenNq?=
 =?utf-8?B?ZjRNbFJINU1VaEdMeGZYNkJQcDVZOXp4ek10d0x6RU1icHJySU4xOE5uTStw?=
 =?utf-8?B?ajl3S1FlSzNlL3F3Nk9FeERMMHBEcXFpc0krQ25xL3daUFlLbUt2MU5Uc2ZH?=
 =?utf-8?B?WGwrNGg3K05naFQyaW9hU0J2dW9lZGxkK0lWVnhKSjJoZTJNaE9NR1ZmVkRB?=
 =?utf-8?B?dUZDVmViYWpjUWlxUWVaVWZxYlhPSkJYK1FMUWxVZE1rZHFvWE5qZk1COFUr?=
 =?utf-8?B?bkJXMlduaUNWZmVLL3J1LzJoZktCWHJNR2w5UjBUR0xWcnVYdWVKOW0wRVlG?=
 =?utf-8?B?dHE3Q1pud092SDJQOFBFdWxjOEtaM3pJTkIrajY3bHF3RERGa3BCeEY3K2Fm?=
 =?utf-8?B?U1NVaGJ5SGJ5RjVPVFRoT2Q3UmovOExjYlFVRmN3TURlenZmTndnbW1VOEJ3?=
 =?utf-8?B?ZC9JVkdyVGlZSnJ4dnl6aFVYcWhoMHNxTE1HWGcvcWRNdUphTUNLMUVIbUxj?=
 =?utf-8?B?Z1FQUWNOdTVYbml0aWtkYS9MRlROT0VNWGllWGFxZXNFZy92dEduSTFqZzFT?=
 =?utf-8?B?RXVVTUpLTGxjMDdnaDk5b0g1QzNHMC9QaW9BVkFnQ1B6c3dvNzk1N2RWbHlS?=
 =?utf-8?B?b2NjNU5wcE9yVll4ejZFMUpoUTFLSXlad3FxcXFHekVnSnhodGREaGFPTERW?=
 =?utf-8?B?dFFkRjA3VGVUejhVTFdLSHJKbGphMXRxS0dYWnM5OWdMdzBvNDlRRERSS0lo?=
 =?utf-8?B?bzJHK3hNZjBLcjRnbEJDVXR1aEhTc3c4NlJZR0p0Y3NGSGhuMXl6dm1aWXpX?=
 =?utf-8?B?ajBDak1mUFVWanlEZU1DcnBub09yMm5abVFtQldweXJoQUE1ZDFTdmRpbEhx?=
 =?utf-8?B?YUdtUEFkRFdSVjRIQ3pzREc0TDZOZGVIZlpuQUU1TUk4N01ubnJsOGtvR2Fw?=
 =?utf-8?B?UkZGMjNrVU45OVNwY3BIVnB1OXVOeS9kU0dNcTJSN2ZpY1FUK0lIcTJaN09w?=
 =?utf-8?B?K3N4V2piSHVWcFYySVlTbXR5NmRpY1MzQXVuMG1sYlo1SUhmSVRVMUlXRDJr?=
 =?utf-8?B?UFFIdERGUE9lMVhieFpYNmlHYWQrL2tkV2VFMnZBd1QrcGNhRzFnMDhjOVAx?=
 =?utf-8?B?TExzME1nN0Nsa3RtaWI2MElXQTFlOW1EeCtxbGU4RGNVVlU3eUNKRUtneGVC?=
 =?utf-8?B?V3dFempWdW8vS2dENlQzSjB0UU1PS3JLR2JmYWpkRUYzelI0MHNPRWlTT2tP?=
 =?utf-8?Q?hhOHrCIWvfiGFO+o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f602b1-e42c-47d5-8aec-08de694ed6a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:20:46.4997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syDxtKuwNnPu/NFvU8Jq40Oq/25wMs3L3Mb4X9YTnuj9FlLoLjXP/8i26/jD1VBh1CrACXmVfVL6nkflhUIcijZ2DSiaab5/J6YYzffQZM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
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

On 2/10/2026 6:54 PM, Bruce Richardson wrote:
> On Tue, Feb 10, 2026 at 03:19:27PM +0100, Burakov, Anatoly wrote:
>> On 2/10/2026 3:10 PM, Bruce Richardson wrote:
>>> On Tue, Feb 10, 2026 at 01:48:20PM +0100, Burakov, Anatoly wrote:
>>>> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
>>>>> Move all context descriptor handling to a single function, as with
>>>>> the ice driver, and use the same function signature as that driver.
>>>>>
>>>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com> ---
>>>>
>>>> <snip>
>>>>
>>>>> +static __rte_always_inline uint16_t +get_context_desc(uint64_t
>>>>> ol_flags, const struct rte_mbuf *tx_pkt, +		 const
>>>>> union ci_tx_offload *tx_offload, +		 const struct
>>>>> ci_tx_queue *txq __rte_unused, +		 uint64_t *qw0,
>>>>> uint64_t *qw1) +{ +	uint16_t cd_l2tag2 = 0; +	uint64_t
>>>>> cd_type_cmd_tso_mss = I40E_TX_DESC_DTYPE_CONTEXT; +	uint32_t
>>>>> cd_tunneling_params = 0; + +	if
>>>>> (i40e_calc_context_desc(ol_flags) == 0) +		return 0; +
>>>>> +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) +
>>>>> i40e_parse_tunneling_params(ol_flags, *tx_offload,
>>>>> &cd_tunneling_params); + +	if (ol_flags &
>>>>> RTE_MBUF_F_TX_TCP_SEG) { +		cd_type_cmd_tso_mss |=
>>>>> i40e_set_tso_ctx(ol_flags, tx_pkt, *tx_offload); +	} else {
>>>>> +#ifdef RTE_LIBRTE_IEEE1588 +		if (ol_flags &
>>>>> RTE_MBUF_F_TX_IEEE1588_TMST) +			cd_type_cmd_tso_mss
>>>>> |= +				((uint64_t)I40E_TX_CTX_DESC_TSYN <<
>>>>> I40E_TXD_CTX_QW1_CMD_SHIFT); +#endif
>>>>
>>>> I couldn't find any places where we define this, it appears to be
>>>> some sort of legacy define, making this basically dead code?
>>>>
>>>
>>> It is legacy, and does need to be fixed, but across all of DPDK I
>>> think.  Testpmd, for example, has IEEE1588 ifdefs also.
>>>
>>> However, for this patch, it's probably harmless enough to remove the
>>> ifdef here and always allow this code path to execute.
>>>
>>> /Bruce
>>
>> Sure, but I would've preferred this to be a separate patch as it's
>> semantically different from what you're doing here. Perhaps it can be
>> fixed as one of the early patches in the series as "preparatory work" for
>> this one.
>>
> 
> I don't think it belongs in this series at all, actually. The IEEE1588
> define appears in multiple drivers, not just Intel ones, as well as testpmd
> (as I previously said). However, if you think it's worth patching it out
> just for i40e I can add the patch to do so to this set.
> 
> /Bruce

I don't have strong feelings about *when* to remove it, but if we are to 
remove it, IMO we should do it as a separate patch, not as a rolled-in 
change into this one. However, I don't think it's a big issue so if you 
think it's not worth the rework then that's fine.

-- 
Thanks,
Anatoly
