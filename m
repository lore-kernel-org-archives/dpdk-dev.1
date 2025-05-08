Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7070C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 11:41:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7CBA4026C;
	Thu,  8 May 2025 13:41:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id DF0E94026B
 for <dev@dpdk.org>; Thu,  8 May 2025 13:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746704472; x=1778240472;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5a7wM6EuO7bKtmZlA/3jP33hL9rquDu46y4aBV28U7w=;
 b=bdwQ8qRFZGosMuGfa1zzcK7TK/oZTJUKnU0NbSNkWorpWZtQbNDzsSUB
 7GRRxa6hs7sdjaMuz+JEuPyiGrm/mCeeENGfdamJtAgOzTyvuKFZozUVP
 HnvHvrSyFWMtyDh4zGBL/p3tf0iaMf3V8N2xS9MYlFeiyOEap2tq7c9un
 xSkGEjm+oHKyHGnXDRQfcuz/OupoYdZ03h8FgKZDmGueIMPVneB35RMe7
 FjmvxfFGJEITn2helPYMCdx5jHicfIhMMrzlLF7N2ffNEQn146LVU4TlG
 pTWHr2exc2nl6bHXGEo7oZhzXi2QfNdFn/uVU7aKAJcN1EoDwvJlFsj43 w==;
X-CSE-ConnectionGUID: /9YY2mzAQsmGYpQmeSndTQ==
X-CSE-MsgGUID: +0epRil4SjWkAcNTIT9xbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48630451"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="48630451"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:41:10 -0700
X-CSE-ConnectionGUID: sudpEl3HR6ezxXFqE8qWsw==
X-CSE-MsgGUID: L2xU8JmVRoa49AGzj9kVUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141222535"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:41:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 04:41:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 04:41:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 04:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVg7klopH70GfAeDJVYTZ3qXelYaK3w+YIPLLjyxzgObWkF66lQg5/dc1lyobMk3bkF0WT/ksINEaS1QEGd1hWeeJFZg+m7W1VuuJKk+RLyv/YThx9+RD1cc6NaWA8i/f0Ojx3yQYKmDzryE9Lme5DVdxFm4pboiXBfnFkN2O42NE1fyeZRGD04oZMSmARtVyh54Acay2ZApno3GDPua6BHOk01CmGnyEJOox8Vx1E7bmuutGrEFU49orihn2sdo1AihwNPXZWNAH0TBTO/jZiJN2akvEyRshabI/h161nhyOVY33ucvQ0hwGOEfE4jd3vRvmo+HWbcCOrf7aeJyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1m6wqV9SOVuBcVfdwoaEsE1fzH05+zGtgIuRZnZpog=;
 b=cVbYPIGQmQPMZkfiqWHSnZCsI5BZ4wSzOFWJJk4umOWrqVdZb9/xwfsLxB8+qIuMK2VAAs6783B5bC7Lacn+qoT2jv9f6MhFhfkCYAc/qcRx+Yz8LIcU9fHllIWJmqnaHN8PtNRY+pZghOZQ0dUtiTzQeYgt/xDHf502wK8u8T2E9LmZCGuj2mlqD7KDjW7Z6MsgXlxl30XEHdFW7xlj8cmdzj79WL7b+zNmsIVBICLeCku3/DXeT3bax9fnv13qIF9cXTCaVXj6p7HfSt6/YT+JYz2KJqJDo6Y9n47kY0PCa8Id/wFtK+cn/Bbz408BkUAayMhoEEDIwR9RKF8eLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7285.namprd11.prod.outlook.com (2603:10b6:8:13d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Thu, 8 May 2025 11:40:26 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 11:40:26 +0000
Message-ID: <8d6e488f-a088-4c30-bc41-15ca4d4ccb47@intel.com>
Date: Thu, 8 May 2025 13:40:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mem: fix infinite loop
To: Dengdui Huang <huangdengdui@huawei.com>, <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <mb@smartsharesystems.com>,
 <dmitry.kozliuk@gmail.com>
References: <20250402124258.2299435-1-huangdengdui@huawei.com>
 <20250403025736.135846-1-huangdengdui@huawei.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250403025736.135846-1-huangdengdui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e488842-d8d2-450d-f12e-08dd8e252027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3Y2dkdWeU1tOHhXTXYrNyttclJFa0Q3UEFLMklEd3JpeUZCTkQrY0QrazJI?=
 =?utf-8?B?bVdUSlZ3UkRCRnRldzV5Z2hNQlpPM3VPQnd2MEVZbXZyN1pVZTMyaHI1OFRx?=
 =?utf-8?B?RkhqRDJsK2xxaTRqa1Z6aTkwNUttSXVSSERWeDAreGU0WGJEK0w4Z0lXRCtB?=
 =?utf-8?B?ZWVBRTBSMnVSdzgvREpBcnpzaHllODdDOG1YY2NsblpXWEF2TWdRa1lKSDFR?=
 =?utf-8?B?R0o2L3lKK01LQ1BSNTdYckNvM3VjZzRmd0N4WmVvenpjcDBiRmo5V2F2dHR2?=
 =?utf-8?B?RG9haEs5OHFFZHIzRlpYaU42cU5EU25RWHFJWXFJRVNMdEhqMVRIUHhzQmp6?=
 =?utf-8?B?dS8weCtuYk1Wd3diZFZuQmNXejQ0dWxSQUJRNmhocmFMakxBeEw4NXFtSkJ5?=
 =?utf-8?B?RWJXMGNPaXFhWUpZUlRCY3Q4U1R4bWJFUDBlY3creVVmY3k0VGZtaGVzaXg2?=
 =?utf-8?B?bHdHSUk2aFJuY3lPcHNNMDEwZERvdnlQaXdybWF6WFo1UHVtZm5iZmliL0th?=
 =?utf-8?B?OTRMblFFWXpSS0JlYkZyRlM1WVRmWHNOODlseTBlek5PL2szSXlqcUdMVkFh?=
 =?utf-8?B?Q1J2SjFJbkNPNUN0WklINU1hZkhqWUsvRmw1TFRNVkZDRWxtelhGNU5ya1VZ?=
 =?utf-8?B?MndVVENhNDVQMnRVZVB4V25XUDBpelZkU0lReGFqTWQwdXlubmVGYUp3eXJm?=
 =?utf-8?B?OGVlOHVsTFlTcWtyRzY2ZHlGRWRGazVYWjQ4TWluNElYR3c5UG13L1Y3a2tx?=
 =?utf-8?B?VVduNXdkdXlmaFp0QXNnZWRGQWJSQXM4aCtiZXZ6b21iNTFQdnROczZ6NWIr?=
 =?utf-8?B?M2dkOXNtMVRyQVF3bFlYZHZZNWpkaFZLM2hUbGJEdXFYT3NDbU1zbk5NaVNW?=
 =?utf-8?B?dERMRjdrdEZML1VRTWRobWtFVXlHS1JVRXJ0bEp3MTNSS3VUS2o3dHZlZy95?=
 =?utf-8?B?SndQTFZtQ3BsV2V4OWQ0NWJ3RVcyaDE4OUVkaVlrRjFpVTN4cTNXaWJWZkFI?=
 =?utf-8?B?eUdQTUVUbXY3UjlLVzFrWmtCb1pNUCtYdFBHaDJGSmdWWHFaa01JOWdtaDNN?=
 =?utf-8?B?UjYzbEs4QlJTOFM3SjNSUHYwYWlKcmJqWEZUdFVKdHk0VFZQbXAzaitWS2RD?=
 =?utf-8?B?K3ZGTlVTNmNYaUhTZ0x0TGZoZy9xRHAzTGNRVmZBTnhCb2hlZC83R0NONDJO?=
 =?utf-8?B?NGxicVBlanVlcE55cDhEVUVDQ2hzUWFzb1RHWlpEbklKdzRSbzArM00rbkJ4?=
 =?utf-8?B?YnU2eldsZVk4STNpTU0zNzVvMk9KOTNuOHJlbkJ1S1VTWXlwVWdGSGw5WkJC?=
 =?utf-8?B?dzA3U3E4VEhjMDNJUzFiNTRlUzNZZjFUcUZxY3k2MTZ0UGltdmdBTU50SmJy?=
 =?utf-8?B?aG11azk4WjVDYjFnU21FbGF5RDNBMEVRcEpzMVNsTzQyMHhQb1dLcHZzREhD?=
 =?utf-8?B?RGVTR1BIcXJ2a2g1VHNnT2s4THJOYldhdVZocXdjSmhQVVlxaDRvNnRsUFlu?=
 =?utf-8?B?MnJsa29rVFhDc3RKK3EwZC9ZdE5GcTNDeE9WaEdWME05aFJMMnpWbFAzSjdp?=
 =?utf-8?B?UDFzY1NmelVkaUxnMnJWNUZlRjVCc3BDa2pOOWVsdmFNZkNqcjNNMWEzaWdv?=
 =?utf-8?B?bkdLY0gwcmREbWtBZG1CVnk2Q3Y2R3hQdnpzY2Q2VnFucXhaS2FFL05qWnJF?=
 =?utf-8?B?RkdoaGxBWlhNZGxHUnJCck5XUmtUcjhONnJrNEJIYTFBNDc2NVdIUTlzekZy?=
 =?utf-8?B?YUFNdHdQMDdpdmpUOFlpZWc1dWhGWEtGZVV0YWVZT1VSREF1NkUwUFZqWFdP?=
 =?utf-8?B?S1lEWVluRmhhbWo0eVN1YU1zRG84MWdsOENZRWhtTWwvald1d05zZUdwditN?=
 =?utf-8?B?YjlZMW1nL21RRDRrNzN3VENyWlJ4VXRHSm9OajZFS202S3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3hTcXNkQyt4RjJCYm9yZE5DV3ZxRWM0YjF1RmdVaUZIYnprYm9lelZhWW9J?=
 =?utf-8?B?ajFzaGhOV2ZnWDRFS21WRDdtSFVnZkpoY1FpMUpVU2VJU3RTWGt0ZDM3RHlK?=
 =?utf-8?B?dHljMkFkK3R4WHdKcWpheWFWbXM4MTIrZTdUR2dkYXdTTkZGTVIxemp3bjJ6?=
 =?utf-8?B?VnpBd24vSjNTbmZFSUQ5aEwxVzltZS9pRU9VS1lNTFZQbkpyZG0vRDhZMmRs?=
 =?utf-8?B?YXFmMFlQOGNzMUdabEp5Q2JZMlB6d21Sdkh1NFhKQklaNnRUd0dpUjk1YStk?=
 =?utf-8?B?dlBCZitWQUJhbEg0bllsUFR4cy9RTjNXeW9pbm45UUgwakNGVkFFQmNOY29L?=
 =?utf-8?B?NGFTQkhCUm5CWjN1bUlzUVFNYytQY3RmaWdqM0EyTFNzWHB5MW1Lb25Oa21F?=
 =?utf-8?B?cTRyaFFVVDF3VnIzVlQwM1ZYU3hLSzFTRFVyUzJQcXowaG1rRUpGY05kdWth?=
 =?utf-8?B?NE9TSnpSQ0Z6R0FSUXNjNm14eE9TbktHMFlzT25USUNxL2FVZTRnOGxWWUdr?=
 =?utf-8?B?VFZjNHR0U0xDQ3ZtSnNBWUxSTDRWeWErYVJUbXZTemd6SkVCeHBLdUZWU3lv?=
 =?utf-8?B?L0dOWncwK3JtNnJYanUyd0RHUVNjbjByS3hVcURtRklZdytIc010cnY0VEVl?=
 =?utf-8?B?bkVPb1lKSGZ0RFp3ODlpRHB1eEhnSTRMK2xUSHgyQzc2VUd5OGl0NHBZQVh4?=
 =?utf-8?B?OEZVRUpiU3dvVTlXYkNQbmd6eFA1Tk1vdVNZOHo3eU9wV1V1L1VKeFRZbWRN?=
 =?utf-8?B?bWJIVlh1UWxKR3N3WG8rVEw0aGdaQjYwWGFQNENQNTJ4VVNtZ0xXemZyU3lS?=
 =?utf-8?B?cmNnNktuVnA0YmMzZlpiZ1lLc3ZxbVJCUFIweUJ1ZytYTXdNcVg2KzNqblU2?=
 =?utf-8?B?VTFPbFJYZUhwSmcxeWg1VFd4c3JzUDUrYjRXL1MyTThheVJwSXl0Z2tscVQ1?=
 =?utf-8?B?QVRjcXZXbWpJOEYwNVdqWElZa2tZOGs1K2FROGZwKzgvWk1VbWdNTWw0ZWNM?=
 =?utf-8?B?YjhpdmEzV2Z2SjZLUllFUktCUzFRaTZUajNLaWhCc2F6SUlCVjFrRC9QaGds?=
 =?utf-8?B?WjNrckNTS3E2RTFGWDRNaXU0ZGZLaXRjeWR0NHpMWVRXWkNaYnhUSjJJYTNK?=
 =?utf-8?B?WUdzOGtQWjIrWm1Ic1QyY2gwcDhPV2hyaktacldsOWlVV3NJWjJwQTZPdXh5?=
 =?utf-8?B?ZEhvaG1QUTNVMFF4cnp6cEFIbHZKRUhTeTcvb01DVFpaMUlxZlFMd1pFMVBJ?=
 =?utf-8?B?citQeHhnMFJQTzRqbi9tcTZtTWdFME5hVWpWampsT0JjdTluWWVUNkNVVEJ4?=
 =?utf-8?B?RmFaL1VqMHZ2aXBGVWRBRmR6N3N0aVNTTjRhL1pNNDRiQTA4a3lPODJNR2Vp?=
 =?utf-8?B?dWREa2ZsYTR6UXowSDhFaUlTc2FWUVlKYlluN2c0ckkvWVEwNXkxVDIvUmFq?=
 =?utf-8?B?ZzB1Sm5KYXl6dnU5RFRwVHZXQUY2VHZwUFhKUm15SVpObkxYdE1tZWVEekFQ?=
 =?utf-8?B?dGFqdk1oeEMxbnZyN1RKUzAxOHJVWFFjK2dLb0hNQjJKQktIRVM2NXhuQVlN?=
 =?utf-8?B?eW9qV3QvMDJVcmdnSkczdDFzL2JWQkZXbEpQR0c0ZUxzS2htMC9MZWtTNFpV?=
 =?utf-8?B?QnMvT045UzBBY0lzNUNsanhrMkkxWGtZVEc4c3BJbXNDQXlKVktaY3E4N3E3?=
 =?utf-8?B?WUVPWWRFdDdYdlRIY0tZUnNrakZwR3BVTGN4QmorT20wcCswa1ZydURxT1pV?=
 =?utf-8?B?ZmJobjBOMTZXY1VzYzlSN3l5bDY3dnN6Mm1POVZXR1RRNXZ5dE9QdnIxdDlz?=
 =?utf-8?B?RG83LzZFeTZveTd0amxobGxFVnh4clRrNy85R2lqQlFXbWFEQWVDam43ZlRK?=
 =?utf-8?B?OFBqaFRra2hvWjF3MWZlTjJoTFRVSThiMzBRc3ovTWluVk5PRVJTT21KN3E5?=
 =?utf-8?B?ODJzdFJ2ZlZkQS80SXdxQUI1dTlIL3pCdGYzSHFMT2g1TUxqU1dJNGJRY2o2?=
 =?utf-8?B?cU1EakZmZ1RXM0hranNRZ1BHQXg5cXZKT2lSUUhINTRiTE5uTm54UnBtb2hX?=
 =?utf-8?B?VTc0bmRhdm82bktCSkIrT2pDR3NzcE1jRFBuR3pZelJsTVpoN1ppNWJXdmlU?=
 =?utf-8?B?T2ZCWXE2N2VVeDlTbmlsdllUVC9sRXdmZDlkWFQ5cUJqNlpZcTVOakxTWDg3?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e488842-d8d2-450d-f12e-08dd8e252027
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:40:26.5609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq5ur1Vm2QEUGp1UCfHS+PQyez+Y51jS48qhNr0YQEcnks9A4xKf3f3PLaiZKY108B+/q77BblUQh483j//sRd1vP4/E6CPb51Qz6U9QAi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7285
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

On 4/3/2025 4:57 AM, Dengdui Huang wrote:
> When the process address space is insufficient,
> mmap will fail, which will cause an infinite loop.
> This patch stops attempting mmap if it fails and
> the requested size cannot be reduced.
> 
> Fixes: b7cc54187ea4 ("mem: move virtual area function in common directory")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
-- 
Thanks,
Anatoly
