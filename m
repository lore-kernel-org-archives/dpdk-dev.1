Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9063C3ABC5
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 08:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C8CD4025D;
	Wed,  7 May 2025 10:56:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 8AE2D4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 10:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746608172; x=1778144172;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=50qvw8Y/NHhZRDnRxBRjcPUMpt06hZOFj5txUuda+Xg=;
 b=ZSlwwApb0gNktKamKg+4pP1lBOFZD8s4E/SPeB2VjgXtBdF0Vj/L7ttn
 QOcBk0az+3zdqd9U81GlpDbiAUnhnt/UGmhlB79uBXWFyCdxOMrDqGPQe
 6uQK3ykpFO90zYg2JWTz+mZCX3r91N4cTQcsJLu39SCM4p77VbWTuC7xM
 txw3spZ772KH6rzJd8yJnCN14NkEGfnDVCQM6cSdG5u1Qyaud8ZaOOUJu
 vP3ZWOSSLKFIpGLY1OIOqm3jD9/we7dWYYP8pvon/TXEhEt7TqpJq9LdF
 1eX6Vwyc0TK9YH+d+HBlJe6xbqDSe/B5WhKksam8QnHyeBvvcXgHSKrhi g==;
X-CSE-ConnectionGUID: u2iBv0hlRmCONlsgyC2uIg==
X-CSE-MsgGUID: WFMaNMltSwSdB0VzN/j+Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48037115"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208,217";a="48037115"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 01:56:11 -0700
X-CSE-ConnectionGUID: g57licSjTziZo/okuHsPxA==
X-CSE-MsgGUID: uZ13YbgHThCZyNHFBCUzhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
 d="scan'208,217";a="173092017"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 01:56:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 01:56:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 01:56:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 01:56:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeONN0JSZf4DJYhezozfzA0e8Jekynqcv9Rt7Js2lOg+KUDWjheVKeyUl+zc4DFjfgU4CWY4dZ7RL5tFOj1VHWOtl5aKwk+Xl1Z6q7Ovk5I8f6v19I1C0DeV+uMovtAQCiMdLnrdE9c+iKkL+SOajtiv1nPthX6kwvRMC4XxfJBzu8Tk/abPu7YyxoBvYpOAtSWFjrjeGk/ROMWH2rkzLsPcBqgsCk4TtYCW3tKwt8tD8w0+7t/M4Li/LnXNuKJLES6J6TwJ9aQHx7gqBQ6pUIsb1gBzR03HvsWjXyYt+Uku7deKeLfifpcl1wk5tty2FIM/s03zfeZPDk4auEgrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgZLW2F0giqd0IBA/UBrjQnoHM+NHI9v367jHmfzRZ8=;
 b=EPA306BuXQxMuJ96T+vKahrSQlY7UPIgqVqHMyQEpmLNXOwMrDH5ZnijemNeEvCz+RO0zcW3FTvdNKQOh7rhjVa+qFJtY2TMG32v7HZdgHvfqjuLVYmgPeY1RUDTsc9LXvNnIUEscp0mJzzxhLP3JRqwSEfjXxYGW1i4j8lKR7RspfYyQJ00ZU8DBFWjTgQWJRMqpdSeJvW95ksupvcOZkmn4YF1A4hsU2j2l4hLBKCc1QOrpRAGfHLslsbqCNfUuWuiUhdzWO2Ox0rUog4j2PqdRbTKVtiU4ISC4MhJVM0wicHrRjiw7QpPwnM25u+k4pOaV6CyHpayBXQgnYIYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SJ5PPFC0624F2CA.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::850)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 7 May
 2025 08:56:04 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 08:56:04 +0000
Content-Type: multipart/alternative;
 boundary="------------ogktu029hMiRABR43xVyi9nv"
Message-ID: <11d55a2e-d745-49d7-83a6-bf9f39a0654e@intel.com>
Date: Wed, 7 May 2025 09:56:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dpdk-dev v1] app/test-crypto-perf: remove decrypt test case from
 perf
To: Kai Ji <kai.ji@intel.com>, <dev@dpdk.org>
CC: <gakhil@marvell.com>
References: <20250502101226.1405274-1-kai.ji@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20250502101226.1405274-1-kai.ji@intel.com>
X-ClientProxiedBy: DUZPR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::17) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SJ5PPFC0624F2CA:EE_
X-MS-Office365-Filtering-Correlation-Id: 88787a14-0f67-4005-2ac0-08dd8d44ff20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekw1N0R6UjYzWlk2ZjlIUC81VHVOeUhndUk2TTJ5VUdyaDNJYVVMdUQ4Lyta?=
 =?utf-8?B?TmVJM3BDczYrVGF2TDB3K1ZYSkRQajVvU3ErU05QK0ZnbDJIWUI0TVRMb0xZ?=
 =?utf-8?B?d0p2eklhNFkrWVd0TEZvdHd6ekJDTitueVlVWGN2VnNrWmZmY0VzZlB0eDRj?=
 =?utf-8?B?T2RyYlArZFlYVWhtb3pTdldNZHFrM29USE5lTjREMUJ3ZnRiYzZFbExaZDJo?=
 =?utf-8?B?RXptNENuVmJjdFRtaXVLT3F6bFpIRFZ0UGtzSHcyQlZ4VUtiVTliZ0FqSC9L?=
 =?utf-8?B?NGpzZWRTSHlMZll1M3ZQRHNJY0ZnNGhsOHlDSkNkZ0crZzFSMzdJRFR3Z1lK?=
 =?utf-8?B?b3l4azBheThxOHk1NFVNazFRTWczOFE3ck91ZzhIckZoUWtCNlY2SjBESmJa?=
 =?utf-8?B?UWQ2d3BlM2xUYW8rVzJXajhTZlFhMm9RTU8rekNUZnpOYzJGZjJlL3JFemZM?=
 =?utf-8?B?Rm8rbTFGVS9HNmN2ZVpKNmtrM2QvbXV1bkdMWWw1MkJZSWN2cTk2RkNOckZ6?=
 =?utf-8?B?Y2xMVjRjOWxXVHdqSFFSSGdLSWxnQkJyWTFzN2hmb3h5UXhwdDYra1krUEpa?=
 =?utf-8?B?OTBsRjl2NjJXYkFjL3RFWDRZSGN1S21yMGdWejZOT2FKVTR1WlhzWTVrTGJu?=
 =?utf-8?B?K2VrcVlSS2Z5bmtCQXFhZ2taeWZVRlVjWmpwZVdQOUFvNGFKRmtwUEhuRDYv?=
 =?utf-8?B?Nk9ib3ZwaGNWSmFSa2ZNb3FMN1hGbktXL0ozT1lkcHRHbmdpZ0xlQnNCTFB5?=
 =?utf-8?B?VDZHNHlWK2JEcURCVXhIZGh5TnZTaG5xWXZTMTRqbTczZnJVdWpLbnd3RjJI?=
 =?utf-8?B?UDg0SUx2aFZlTXVqVkdFK0ptZlNzbG0wNm9LRmY2YUhiMG51OTJydWNpMXBT?=
 =?utf-8?B?SXNmQ3g4RHFjRDZ0Zk5NcXdJZy9MUVI3N0kxenh3TE5xcGF2WjdBaHkwZmNI?=
 =?utf-8?B?VEJKN2g1WmV6VWNiUEZpKy9HSEdBWDRyN2JUQ1BYbHlqV0FMNnMwZEZEWlNH?=
 =?utf-8?B?d0psZ2N6bHFWVHJDNEgxZXFsRTB1ekJwRFBIMlczaENkaVBQSFJpQk81M29k?=
 =?utf-8?B?dDcwbUcySTVYNFU5dmE1Q0Q4eVVqY3pCWE9BMi9SRXRBd1hPaG1tR1JXRUgx?=
 =?utf-8?B?UHpBb3pXdm45aVFMTlo4MHRFZ2Rzd3ZQT3ZySUkxbGZDU2hVc2RmNkpxU1Fy?=
 =?utf-8?B?WWw1VStFSm12bHc1Ky9ZYUh3SXdzcVdRUnNvU2UrNkNsYnE5ZURJN1FOci90?=
 =?utf-8?B?Y0d5UzU4UXlTeVBWZGpoeTFPdGN6VGpsV0RXKzBIcGVCU3V4QlBhVlhlZnBJ?=
 =?utf-8?B?VXQwRTF2aXMvQ2pna0w2RDM2eHVQZXR2NFhlTTNsZW4ySXhDVGRLWWVNZk5a?=
 =?utf-8?B?REo2Q0Q0ZGcxVHVnNUV3VkFZdkNXeDA1TE9UWWtHSjNSYlB2eFJLbXFqWlp3?=
 =?utf-8?B?eEJIdWp0WWR2a0VJN2doVm90MXVuelFLV1dVcnI1KzF6UG5TMUlnSHZ5UjFZ?=
 =?utf-8?B?MldNNVJteTBEblRGQ3FLVklKWTFQTDJtd1NLcUdiTUIrQXRHWmZ5allkcFRT?=
 =?utf-8?B?Z1p4U2JHc0NMT09CNDZPUUszK1JENDlMOWp5MXpjQnJlK1VFRkVyWng1ZDR1?=
 =?utf-8?B?aDhNT0wrTzh0MEtkek5yczdsaXFqaXQxM2VySDUwSjJUcUlSd0tYRFdvbVZE?=
 =?utf-8?B?S3lGa0xrWmRhcnliMVcxb1hnSkQrUmRhT0R1Q0tzVFNXQTR5RkpiMW56TFI1?=
 =?utf-8?B?dXR1V2JQbElNT1U4S1R6RG4vT2c1QzdhdTBQU3FVUUM3amFYR0x6dlF5NlVH?=
 =?utf-8?B?TmRXM3NaRlpDZ3NTYVJJa2x3a3hPNXJTRXRPME1lVENZVHgvWGhTRGw0K0c4?=
 =?utf-8?B?SXFXSFY5a3BoRTZZM0pYc0xraWJUMG1BVGVFVEFvMXl4Tmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXVPeHVqM0tJUmdKUW9kRXluS29aWUxac1g2ekJYS2ZWamRmUHo4M2Z2TldF?=
 =?utf-8?B?NUVKWklSREQ0Qmo5ZTFkWU54c1ZHai9iZlVNN1pINkFCUnJGRCtWTGorL2dB?=
 =?utf-8?B?ZmZkWUJFOURLM0xFdThjMEcxa3ZndDM5QjZSQmhkbEp1MmdWYUhyblBGaTlG?=
 =?utf-8?B?L2VUTUhadXVBQWs1RUpyNVloTU1GekZ6SlhqdTRvcFdNd3NqVFk0ek9UdjRS?=
 =?utf-8?B?MlRLdmlPdnRPSmdwbXFHdXBEUXIrd013U3VHbUIwbFZ0R2hKeGI3UGdNUHo4?=
 =?utf-8?B?ckl0QzlWalBxQm5kN0JIQVJ2dktCRkhvZ2JNY2Vjc3p3dUI4bDlUZ1crZTl1?=
 =?utf-8?B?M1U2MHl5THRXcEdCREVoUjVRV1Q4ZDk4eld1cWFNeW96U1NISnBLbXVwTVF2?=
 =?utf-8?B?bno3UnpQVHY4eW15d2MrSmpaU0V0ekFxcmFJRC9CckZyMjVJMEdGYjVLYy9K?=
 =?utf-8?B?cE1scjJGazJ1Lzk5QzAyZm5xbEcycEM3aDNINy8rUnpwRTlzL05zU0RWeHVh?=
 =?utf-8?B?RU5rL0tEK1A1c09RSXNLbmdBbjBGdlBXRmlYa011djkyajBRdjIzcjlvNCty?=
 =?utf-8?B?UkdRdjJTUFVaUlE0S1FaMVRUM01vWEtTclNJSEtOeFBvVStEUUhacDBYaE1U?=
 =?utf-8?B?eC9IVzlqZ2kyMC8rTnZaeWtVMnM0Q3FJcXZ3Rk5RenFZNzNnbFV3OW5BNHVm?=
 =?utf-8?B?b09MejR3dG5xWmI3VzVzVXU0bTB1dzcxMmVMYm41NjRTMm1KVyszV0cyWFBG?=
 =?utf-8?B?NGJyR2k0QmhmMEMvTmtEWjVCT090MDBpV0FsOXRBajl1T1hKVzVmL1NkOUhR?=
 =?utf-8?B?WnpkbEV6dFdiaTk2WFFYaG80R0l1U3EzbHdlNnlVMUZzZ0dyaWNXOGRNNXl4?=
 =?utf-8?B?RDMyL2pYYWJ2dnVtMmNiYmIyYXhzMVZVdDg5WXM2MWo5ZDl4TmZNUWhFeVdQ?=
 =?utf-8?B?bWFDRE9UaHh3dGxNVllOSVpIRTdoUDVZLzNDVll2RjNIZnE2S1llZ25tL1FZ?=
 =?utf-8?B?Tk41ZFJPTmROZ2w1cFNHRFUxQkdYT0J4bVFyRHh4ZVZXU0hLblRGN1FtVit3?=
 =?utf-8?B?SVQ5dlpKTkZIeGJKVlE3L0JsTzVmTG9tcjVnczNQWmkzZndKNE1wVmdkSnVC?=
 =?utf-8?B?RDRxbUZXUVBqSUljbTlKUmxHeGswQSthMm90S2VpL0R4NGZtSEVuNVZFN3ds?=
 =?utf-8?B?cmZWVWlzRGY1RDNHVGNyOW02SzVYZXk1ck1BVUU2MS9WUnF0U2M4b3lVQTJZ?=
 =?utf-8?B?aCtFUmNxTDRjSzNibFpkQ0M5Sk9kQi9BOXVuQWpQZXQrRlNmMFArRFlZbkpS?=
 =?utf-8?B?bDcxZTBVdGJ5cTllUFZzYXh5VTQwejBHWERTZGQ5eXJLa1FXbUZmWEh6dUt5?=
 =?utf-8?B?R00wRi80TmtSSnd1cG1rQzlIcW8wcXdQdkxzekFQckljZTI3SzRDWGVrb0VE?=
 =?utf-8?B?THE5azhpMG5wWkw4bXBYSVk3RTNQMkF4M2R3czEzN3pORUozcFY4NTVsQmxy?=
 =?utf-8?B?WTZCSkYxY1RBRkpXTDFjcUI1QUZDV1lkb29hUDdjL2hudnlxSlM0NlRNLy8r?=
 =?utf-8?B?SGR0YzFlc3ZVMWZFa3ZIYWZNTXZTcHdUbENLelRmSlBEMERwMUNFRGdMTVBO?=
 =?utf-8?B?UUxobGhBeUxtVW4rNldEcEh1UEltaExveDA5dzZ2M1dMdTNRRjliOUJNa3Bn?=
 =?utf-8?B?VmdnVDJCUVQzVGNEYzRUSWpLK3JrelJpQ1Y3R2hBbExiRUF2Y1FJTGxDbW96?=
 =?utf-8?B?T05tL0hPQ2FZMTB1WjRzd3RqK2lKSTBhTzNkbDZ1bVAyMlpFb0NLNmc2OVhP?=
 =?utf-8?B?bGVmMW1JSVB0R3IxVis0NVh6d0plakprVFFmOHdHSHE4d1FYMGNid25SV2Jt?=
 =?utf-8?B?K3NwNm9ZSGRZRnAvbXpaMWhpbzhqUGVFM01BZVNPdXBtT01wYnIydklQVDJl?=
 =?utf-8?B?ZE1YV0pVVm9ucFR5UGdMdW1PN1AzLzg5cExWVGxYNngvVzhibmxhWkR2Vlhk?=
 =?utf-8?B?V0F2am1PS3F1TTBlamxoVE1SbHp6YURLY3grWDJBUTZPNWxueDFGeWt0Uk03?=
 =?utf-8?B?MllYanh2RHUrcEZlUzZGb0pacVdqZWxjT0hKQTJqY0FRdnZVMHpKT2w2SWQ3?=
 =?utf-8?B?UTh6dmtXNXFndTJSZ3JSWjlBK0t1UFNBdllzeDlIYk44YXpRVngzdytpK3RK?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88787a14-0f67-4005-2ac0-08dd8d44ff20
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 08:56:04.2677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cW3NnGaqcnwPhCYA6Y9/EJ3o3fFsbE0+TcrspPo5r/0yec8i1Nom7Po3JHAGrGO1WzXXIV+Ojq11FX8VQDmxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC0624F2CA
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

--------------ogktu029hMiRABR43xVyi9nv
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 02-May-25 11:12 AM, Kai Ji wrote:
> Remove all decrypt test cases in aesni-mb throughput perf as the
> decrypt throughput testing only support OOP by dpdk-test-crypto-perf
>
> Signed-off-by: Kai Ji<kai.ji@intel.com>
> ---

Acked-by: Radu Nicolau <radu.nicolau@intel.com>

--------------ogktu029hMiRABR43xVyi9nv
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 02-May-25 11:12 AM, Kai Ji wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250502101226.1405274-1-kai.ji@intel.com">
      <pre wrap="" class="moz-quote-pre">Remove all decrypt test cases in aesni-mb throughput perf as the
decrypt throughput testing only support OOP by dpdk-test-crypto-perf

Signed-off-by: Kai Ji <a class="moz-txt-link-rfc2396E" href="mailto:kai.ji@intel.com">&lt;kai.ji@intel.com&gt;</a>
---</pre>
    </blockquote>
    <p>Acked-by: Radu Nicolau <a class="moz-txt-link-rfc2396E" href="mailto:radu.nicolau@intel.com">&lt;radu.nicolau@intel.com&gt;</a> <span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------ogktu029hMiRABR43xVyi9nv--
