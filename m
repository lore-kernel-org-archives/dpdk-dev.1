Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A318BD4A60F
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 14:17:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96ABE42830;
	Fri, 16 Jan 2026 15:17:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 266814026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 15:17:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768573066; x=1800109066;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Da+BC0SUUVCSXe6KPsFVAugI+PE1K5rEtmupGFihphc=;
 b=dUzX9b56x59bvRAj0tg5fJLOJXWvcKxtva6yIqRvE36X9mKGShi2SNNH
 XCMDQXiWd0b8eD/Pxku08AMiqdQxP/+AUKT39LTKM40fEoqw4fm32b4Cm
 ZZerHdRjmmN6yOvhaYjRlMW7GZY1oy+7sOFqo2sx2K1omHf23dWN9koiR
 /sNtg8WI//c/6eXqVkn6L+jB7mKQ+aHTyBlQz00TmR82qnJgFKNmX5yQU
 1f5tA7UtLq8vZNoLQ3+qDGe5gwgx6YaUhlE4wa52kvLDOqUFoJbWx7VNs
 lukV7WeNrd5nxxS1MmWM8eodu5AT97mQ8I62eTT8irp3pe+6It+u2MQi5 Q==;
X-CSE-ConnectionGUID: xL0te9lKQV2s2rDC6OZ3Wg==
X-CSE-MsgGUID: NW3/VEjbQAu111WSrRnFAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="80608549"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; d="scan'208";a="80608549"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 06:17:45 -0800
X-CSE-ConnectionGUID: hIHC7vqXSbuiMCGf/24/rw==
X-CSE-MsgGUID: CerEiQaMTz+5CEJZWa4J0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; d="scan'208";a="205531438"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 06:17:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 06:17:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 06:17:44 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 06:17:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flA3fGPvRJWJNyTUcTuGOYlYz+FRAgPSFFbLZQkB3oMC1M61NjSb6nY6sdDjXF/l1p6GJkL45KNZh+SOtSjWB1useo1O7e6iRWMNeL7Lgl6mJG35ikCA4WtA/ONjbVeHwQBoUutHx1hDXBOAUuStAdvvIDikORK3nsnqvNBG3eSRnLW6YM/pK8G+5JXW8GGyymC2Of14lKUL/brW+SNwCSDZxLPDGHvI32LbQT1sBl9x4k5yoixUEK+/aLGcPdmLnei15fTKJeAXpL1dH1u2ySuPf+RwVZASgplJvQSQNArWK6HL9vBebPfuDiquJTKCVN9uB7VZT+XNDhpLabfgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc86/cQVQ/3JvvYP1emY5mUzzQUdIxhRnaw6tIuqYAw=;
 b=msbSqlFvbFHKpCFXtFdZJMP3erUc6iwCzZCLxfOhfntZjOLHvHhfZfoIaRINJo3TyTFAb5Gz5Tm4HBnVmwF/J1HI9B+06h6sRrarrlhg1+04mhnJNZft8qE9cbwqZtSPye3v/HFAZ/3QGysRG8+YQPWfjUA/D13PfLDBbLjrPxUf0owqgl0IscaM+nhkhLoysYQZ6eFFIc+O3y9M2vKbeSkUEWyDjpUqO1KB5RyBz8Xa/nevuh5mYAtrAiYlSNTkkYjNJsXh2+NLvNizinKpUs6udzOpzyROwZYS2KWBoxs4nb7iLI5z9etI/hIDMfbcPX+uj8UJFjhQswLqKobwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7837.namprd11.prod.outlook.com (2603:10b6:208:406::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.7; Fri, 16 Jan
 2026 14:17:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:17:42 +0000
Date: Fri, 16 Jan 2026 14:17:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/intel: check raw item spec/mask for null
Message-ID: <aWpIgEKUxGLOXAE3@bricha3-mobl1.ger.corp.intel.com>
References: <20260107075905.179912-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107075905.179912-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DBBPR09CA0047.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec4f1fb-c465-4e08-6927-08de550a02cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnVOVmtzeEZHcVZrS0tMaC9aS1d2bGJuRElMUi85Q2pwNENkT2NoeGJ2Sko5?=
 =?utf-8?B?OHhnSDVXSWk2MTlEVlhxQXlMV1RNdWYya1ZzclZwcjdQY3hselp0N3k1Z3hP?=
 =?utf-8?B?aWJTcytVYm41MERDL2JJSU93VkczTnVxV0ZiR1VSUmFyV0ZkZTlaeG41dXhh?=
 =?utf-8?B?bk42Sk5DQm1xZ1hLbkY2SmRUL1AyTnRsK3JidWk5Zzdnc0VVdXloTG9PK3F0?=
 =?utf-8?B?dDBhNFdUcUd3YXE4aWtrem9JSmU2a1ZQdGs4bWp6Q2srYUtKVHhjMUJWWHNJ?=
 =?utf-8?B?YnRUQ0FJcEc3K2VqQjNWM2Z6Z2NDK3l2RlF3Z2k1VTZnOFV2ZWh2VEtiVHBv?=
 =?utf-8?B?R2w1TXhLRzFHODZ0ay9LUGxLeWE0TUR5N0k5eDFoSXZaZ1hNTWVwejNNOVQ0?=
 =?utf-8?B?SHNFaGJFQ2NFeTJYSmNhUzE3UDNhQ1R3akV6bStkbFBEd2M5Zld5UkJFL0g4?=
 =?utf-8?B?TW5mVTZOc0Q3cGN5QTRtK04yN05ibXdSYlVlYnlLdkhZc2txYUpXYTBUcXQ1?=
 =?utf-8?B?T2RPZFNLVThsVHV1R1o4K2tYRjBYWnNaYkRHeldnZVRoVWljeVpIdHFMMjVS?=
 =?utf-8?B?eWgrSWE4dVV6dUFvekp1akw5RW9EVTFvZVNsUHRCYmF3U3pCd3JlRUVKendt?=
 =?utf-8?B?eGIvK011OENEa09HMXJ1Wm9YMHViVC90blU5QkNmNmwwRTVhNFRPK0NuZHkw?=
 =?utf-8?B?V0dnMUgwWGhTZEJMR1E1RmQ0YUI2N2ZxSDlaUTlSSFc0SmtGUnloZHM5cExN?=
 =?utf-8?B?RWxLdG5XQUxzK3ZHWnF6Qm5kTlhvQUJENnN5Skx5U2Nka2ZENTR0MUdSaXhE?=
 =?utf-8?B?TXFkT05KL0ZZOWRaRHJHVjczUVZ0d2VjWkJodTQwUWVnU2hJVmx1UUlyVVZL?=
 =?utf-8?B?dVVkL25ESjJyc0NhS3NZMk5pSmdZcFRYVjBVbFNvLzVCeFJLZ0lJT3ZSM3FN?=
 =?utf-8?B?UG9TMU1ueGh5dlN0ZHFrcEo2dkRMQmIvYjQ3Y0ZseUJNYlBYUS9LZ2x6VlN0?=
 =?utf-8?B?bTRpUlF6ZmZwYWhGeHhiQVVBODV3U1lmc3JtL2NIVSsram1QeThUNjJub0Z5?=
 =?utf-8?B?SVpmWDE3Vm1ZYzh4Qy9TdWMxMHh6WkN6T0VyakFVbE1qdjFvMk5mZ1pCdFZh?=
 =?utf-8?B?RWNON2c4Zk9lRjMvMjRKQitrUWtib29jN29tcWdKY3RuVjQvNHR2Tm9jV09h?=
 =?utf-8?B?aHNYVzh4MFEyTkd0bmhiQWxzNWlTcHdDMHZJZjdvVFNXTE5DVDdhS0NoRjBZ?=
 =?utf-8?B?THpaVkNuRHptTGtzMFpCMTJkY3dMd1FJcU50MTlGQkgxUzdCYnhmRDl0ZUpM?=
 =?utf-8?B?bUpHOG9SWWY1cTlZQ0RnZlc5Z2VCVm1LMkNlZEZGOGw3TTFSYVRFMnkxaFh4?=
 =?utf-8?B?KzFZVlNjdVNpNnYyeXN2Ylhwcmd5d2NWK2RBc0s0WHB5cDZzNE9PaXJjRkgr?=
 =?utf-8?B?ZVJBdXE4aDlYM0lGazJBMDlqSENva0ltMGN6eXdPU1RnblVCVjk0Z2FNNVVy?=
 =?utf-8?B?ZmovWlhoUzVxV01pd0pRRVpDbllRck9FeC92d0dRbk14U2N3Q0tYb0pEWFpU?=
 =?utf-8?B?d2VuN1FpVXpkTUYzYnA4Y3U2MkhTVFQvbElqRWVHYzY1Q0hRWXZCb3Z6NUYv?=
 =?utf-8?B?VE5vOFgxcFprM2RHQzZsNUJ4VnpOSGlubGNSb2wzLzJPTFFjNzRPa2RpRDFj?=
 =?utf-8?B?cGkveEVhZ0JBMVFrY1RSUFYxWDlsN0RzQlFrYm5mWkgydE9sMkpUdkE3UDRV?=
 =?utf-8?B?QUxrbWlLWXZldDVZb2dkbVpiWVFSbCsyQlo2STRjMlRaMmtUZXRmaDNPWUhF?=
 =?utf-8?B?T29YZzFDd2ptOEMxOWVVNURHZ0R3YXB4Q05ncUl4dWZvWFl3WGFXUitwYXd5?=
 =?utf-8?B?NEJ0NHRyLzJtNVpuaGlqTEJiVlY2MERCMStiVXRJTVNPRjRtLzk0bUZvUk56?=
 =?utf-8?B?WEJnR2pGekJXYllwZGMyN095YTVmRkt3SjB1TC81bVVrcExzVGgrcmlpVXVQ?=
 =?utf-8?B?NVBLQXlDTC8xY1NjUTVLMk9oaTFiUjR2dXU4aWdIREhMajh1MGNhbW81ZHRQ?=
 =?utf-8?B?byt0SVhlZktqV0VtYW91Si93VjBoQmFKM2IxODIra0JJelAyYXgvRUxZbDNW?=
 =?utf-8?Q?IcPc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clBQZUQ0eEtzR0g0cG5hSThyMGtXTVVKZGdwd0V4bFZiOTIwdGlScThxdmxt?=
 =?utf-8?B?cE1Wdmg4ckZyYitZYXhSZFRUTDVZUzVHcjdtYUNRK01yQ2FvdjJxTkd0RFo4?=
 =?utf-8?B?NW4vT1I3b3hwNVkwbmhqMjFsc3dSdlpyWCtGYjZIOFNLNVM2ZUhJOWxsZkRE?=
 =?utf-8?B?S0pURCtQYVUvNURKdzdya0UwR3hOdHV5bWZSeFlHTm01b1hGUjA4Q1NXQ0RH?=
 =?utf-8?B?V2R2N0tXZU9aazdnaWZwWG5yMVBycHdKaFVHSXNCSlljNlVoa3pka25YZ0Y5?=
 =?utf-8?B?NXNxMENNQTJkTjRGZWNRcEdYYS9RdVBlRUUreUZLZDlXM2pTa3hidmhHTW5J?=
 =?utf-8?B?VEVLVXlTTTBNSE5WNm5uWkpXbWExVWZ4UG5MbWUrOWI1VDNWMlVIVjJNeGpY?=
 =?utf-8?B?UGgyK0ZCUUhMWTQ4TzFvUFo1d2wxRVVMeFVkdXdBU2pia0FQMDNpSk84OEVk?=
 =?utf-8?B?cDl3SlEzNndkR2tlMEV5LzlwbnhEOEtKK3d2RkRUOE1sUnQvUGFQcnpWblZF?=
 =?utf-8?B?Q3R5YlA5ZnByUGFRZGtJQldOMGt2eUM4OTkzZUhTbHNvZm8xaGlLNEg4YkhW?=
 =?utf-8?B?bVp0ZUlWeDBDQXpUVmJMdXlWS1RpVDJqVU1BbVoyb0hRcE0vMmljMHkvWjl6?=
 =?utf-8?B?eURkNjJoZ09idm9TaytURGFsSXlQU3pNNEoyQ1ZmSUZQY1ZGM2pGNXBZUHh4?=
 =?utf-8?B?Z3JMR3EvdGlHb0JDdjloMHhpUlNDc1FkNmdtemU5eVA2ZitTV0ZCdVhkZTZz?=
 =?utf-8?B?SkhXdDc0RFVSdkJXYVoxREMrZW1IS2htSGVZRWNRUUpyTUVhYzBDUjBUNFFE?=
 =?utf-8?B?ZUNOOVpYSDBZZVdnUU1McmpoSTM2bktwSGF5Y2ppTWpXSHpGZjZRR2o5UG1H?=
 =?utf-8?B?OWhkNXIzQ0lTYW9pUjVoaGJ2RXpWZjM3bmFEM1NhNmROMXl0U3ZNalRiazNQ?=
 =?utf-8?B?THBxYnIrS2ErSmlDL3hkOU51ODZmdDFMcndibVB4T3FWMjZ5VUV6VUhKWVo1?=
 =?utf-8?B?c1Z0U2FJWDdreTBnRWwvYUhXOEo1R0lpTjRFeWIyUERWdDEzWVdXMDdTRnNa?=
 =?utf-8?B?Y0hIQXlGQUQvQWtOREh3V0xScnE2Tm9BTW8xOWdCOHB2YWthVm5wNnJ4Wlgz?=
 =?utf-8?B?ZCtpSnlVcmcwcUpGNHU4ekdWZ0FDWnkvdHRjYlJIcE9qUWtFR1VVbGpENXda?=
 =?utf-8?B?RG1PMmNiSnNXZnBESUVwa0tWUUVlRlFoZnZEQ21aMzFKVjk0QUVuY05QVjRG?=
 =?utf-8?B?OXJhOE9RRmQyakhIQnJYRzJNY0JRQ1pTMGxDNUtlQ21BaHNLbVZ5TkVHakYv?=
 =?utf-8?B?aVp5MzMwZGxZb2VDUjJqdXRPb1R6cFE2cFpWUjZKRG5hUE5sVmVNYk4wNk1x?=
 =?utf-8?B?SkNSTG5BeHJQNVlIR3JWNnNEa0Foc0hzb213eWEzWUxiWnNGT1ZZemIzNDNa?=
 =?utf-8?B?RytWOW9aWHowcHQ5YzlEdTRQSkZIcHFIdHZYbDQrdi9TWGFacmk2L3VDMVZJ?=
 =?utf-8?B?dWZRRklQcDRSZ2gxZmNxQ3B3bUdCZ2VOWGVTdnZjY2pOS203OTE1V3RWUXdD?=
 =?utf-8?B?UFE5a21SNzZtNjY1ZUtmZE1TeGtFcEdIQXpYd0Z6bENvZ0U3TmFqNmZaTUs5?=
 =?utf-8?B?bUkrNEZBR3RBZXRVdzYvRXZLcWp1b3duZ0FwamNTSDVEZkVVUWRWNU9pUmVx?=
 =?utf-8?B?TFZlMjJtRmNjTGJpNmRFNW1tK3ZnU0RPYXk0ZXpuOHIzK0ZmbkxJZUdlTXNM?=
 =?utf-8?B?ZnZMcU85Yms1NHM4aDU4bWhITUhZSGR6T0xmMkNoUExTQUtMZDZNRmVxSkJn?=
 =?utf-8?B?UHhGeU5RTWNNUHpKcEZ2ejQ0LzlnMkdrcWdaMkFiUW1VZ3MydnNIcEJBQXB2?=
 =?utf-8?B?b3QvaGl5M0xFbjFtRHdSVDRHUnlPNklOZGpJUlArQ25MM3JHWENOWTdXdVVR?=
 =?utf-8?B?UitLeVdWdlpZeXdBeWRaNWkxbWIxSjg2c0Vpa2o2SUpqdUtjTWU0bmFGQnpv?=
 =?utf-8?B?OEl4dkZ2RzhqMnI5WHVmN2Rpc0R2NmpxVzZtZmNMQjlCMmhwT0VkQUh4bnRM?=
 =?utf-8?B?YlJDZjVIa0JXWCsxYXVjcUZPRnU5VHJoWTRhMTlab09JMi8vSkNTU3JrOEVH?=
 =?utf-8?B?SGRxMmlKemFCQkVNYnNiVUF2VFlMZDBwRlRMeStxOGJ5a1pyMzhKRXZoYWVH?=
 =?utf-8?B?aC9iT21PRFFZOTIwWXRJN1BHYm0xZytMQjYyUWtIbjMwZkNxbWExQjd4YlNU?=
 =?utf-8?B?b0lTdVYvRUhBRUVVYjFVK1hsbGUrWldLeEVWTUREVlBGcFFPb1ZRNnAxZjkr?=
 =?utf-8?B?bkdpSEt0UkxDQlZsMjFjYS9nZnUwZ0hYQTNuaStGZE5uZy9yUlZISmdqVWVk?=
 =?utf-8?Q?U2gKd0FNUGz8Fozw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec4f1fb-c465-4e08-6927-08de550a02cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:17:42.0412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVMBDu3EE/P4H7taEfUkFW6Lys6NmOKtpGE4vnehBaf4OU7cD8ZTbzXbR9C95WO9VBJ9cinCAFyGhpLQ70NrcMJ5WTSqksKNSUAz0RBa5PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7837
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

On Wed, Jan 07, 2026 at 01:29:05PM +0530, Shaiq Wani wrote:
> adds explicit NULL pointer checks for the RAW flow item’s
> spec and mask fields in both the IAVF and ICE PMDs.
> This prevents potential null pointer dereferences
> and provides clearer error reporting to the user.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
