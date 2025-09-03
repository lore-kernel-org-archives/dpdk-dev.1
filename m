Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F3CA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 09:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 129BA402BC;
	Wed,  3 Sep 2025 11:27:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9EFA040261;
 Wed,  3 Sep 2025 11:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756891667; x=1788427667;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bXrEBDy6YYPfrmO0b7hS5wyh95rjCshd/5ldtpyaPUI=;
 b=k3beR016fgU179oLek9v0dKx2WJKbfeAzp/D22MFghOlK1DEaOg7fdUa
 9kdX/jZzU/1usDx9WJOCWf/FRkXBgSqV3JoqU6vNpxaW4954CwmTZiqyZ
 HgswoRBVC7OM5LLp7o9XJiPI5V4HIm6QbL0ZNwFd0Iekzb8NShXqTdSTq
 GOV14uYnCFhAWbacgij340RH+CNHi3BO3qWj5zYaBAE8MEKdQcjkded40
 ER6Hk6ynLAm5Avd8NK+bXMW7RD/OWLOk3GwY4QVGCzcWkwTm7MQJOMgq5
 iWKpPmm9CZhQniM8o8d/uwPtOLEbHpDVcaWc5A4Ag1aOrpc7vslmML2aH w==;
X-CSE-ConnectionGUID: q8QPjHaGQYaioukIk4gHLg==
X-CSE-MsgGUID: Z1AFdUi/R7mlPGgVkHCo7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="62841530"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="62841530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 02:27:46 -0700
X-CSE-ConnectionGUID: HascOhJyTcCWehVguPYPiA==
X-CSE-MsgGUID: 0EsJPOqCRdyRoL8L7ehjuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171504208"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 02:27:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 02:27:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 02:27:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.61)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 02:27:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvV0LxwfMW28miu78d22BgeulUplO8IrP28FCyDZParPGA9vbsZZdRBF6Z+/iQW8e5NJnaehMfsomuLaa3gF0Op2SNcx0gdVHUtCYG5FkYc3MV8qcNKoYlCDGVSQR+U94vnUOrNurq44Hdd5KOzzs1r2pSGsvf8BxzgXGQ6JlKKBauqHGQQud07r/MS2y1cX8LywGRMbFp4vE+c2C0xw0hhcF2QAeKEEooQ+gPuWsh5oOSppcYaWRQbLRLwPBxHgsSxtafONtQq9q4VBauTCnrpUJXcVcbGzKW16Hl2IkRW2j+OHVb35i/caFZ6Qlt0Velms3uvXaE82KIto0bZ0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6lNowFrQQRZyAUOej4zDcMbZ5CXv7EtiTPHO4N4ONA=;
 b=rwUoQS/HtarYUB3s89vXJA90PiBLXHJX0pLHKEJych3Dis6Eqh6zkKKdYlljwayTrucW8ejjo1XB63Y8yUXHnDWnhkbKpoB4yyLxh5aS5Y6m8KhcY9i3n0kktERij9bmBLmdGB/jFi7hBcqWN86tc93J2hNy05M3AjpwnfA5EL8JxfGaOMHHp9msHNf72Rqnosm1Gr7oCpmM2FokxSVas4Qk7g9lJM+Y+datJUnSenhHE9WGMceTnNCqr2svMKxMLemHPEjyThM94csAKEWeEXMZYHc1judeZ2PG8/kQf2m4X158hTDZn+iwNHt9bXHvcn7Yth/QcO7jbXt3Z8V2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:27:42 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:27:40 +0000
Message-ID: <82eea0d0-81c4-4623-984e-02ad11bdde59@intel.com>
Date: Wed, 3 Sep 2025 11:27:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] crypto/ipsec_mb: fix QP release in secondary
To: Yang Ming <mosesyyoung@gmail.com>, <dev@dpdk.org>
CC: <kai.ji@intel.com>, <stable@dpdk.org>
References: <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250719153227.1980-1-mosesyyoung@gmail.com>
 <20250719153227.1980-2-mosesyyoung@gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250719153227.1980-2-mosesyyoung@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 49459a8a-ba20-4636-7dc9-08ddeacc20b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmYyZE1WR0U0MEJjT1UySlFkL2tlU0xxNjc2SERlajBhZ0JGMHJNdk9MS2Vk?=
 =?utf-8?B?dzFCanlVY0htT2xSbmFRRnFWRUc3THdxNUZORFBxak05M3ZLTUxhUGFPU29J?=
 =?utf-8?B?eXdvTlFodGNwZVFKR203TEdyYmg3Z0tKYlphTVZKT2wvaUxCYXQyWTE0anVq?=
 =?utf-8?B?M3NpMTlEaDFzdGRZUEF4b0R1bit1WFN0dGplNTB5d0U2SWJkWm43V2JGenlE?=
 =?utf-8?B?U2JUcmhPUEJML2FuU2RIRjlhTkNKWFN4R3V5eVMyUENaQVR1SFBRRUphTGtl?=
 =?utf-8?B?WXFKLzVYbVAvZGFhUmZmVll3dDJqazBhU2RxZEsxOTJSeWN5TXNobVBJN05R?=
 =?utf-8?B?d1VNRVdUMFA0ekYrTUR0QmwrdHA4aWVXZnIxL3Zob2VncEh4U0NTa1RIV2ZB?=
 =?utf-8?B?Qi8zaWZxTmNsT01pbGYyTVRkKzZpS09GR3hxNHVVRU9KY291cFcrd0xwTVpQ?=
 =?utf-8?B?UUZnVWk2L285L25yN2dYVVhKMGE4Q0s1MUFhQ3dOS2NMM1Fsa0EwSVNpamVC?=
 =?utf-8?B?SUZKczhic25iczNnS3RjSjZ3MWZIT0oxTnB5TUYrTWQ3UjZyY1cwNmhJK2ZR?=
 =?utf-8?B?cnhDQW4vNmVBeEhFNjZVdXYxZldXT0hXQ0R4cXRFTGhwY1hFTjc0TnZzUXFO?=
 =?utf-8?B?UCtNWG4zZzRYMSt1d01jWjFPYTNPT1ZHREl0c0tFNVBtK2E4UTA1S0MySGc4?=
 =?utf-8?B?dlpKVmc2ekFTUlNkc0pLd1ljNDNvKzFrR2VKNHpGYUx0MEFLYWpjUjY2ZzRk?=
 =?utf-8?B?Nzc2SytBMTA5NG1pd2kyVmoyWGhRalRoOXVQM1AwWDRYRWhRZzVMZEVtR29X?=
 =?utf-8?B?aW5xZWNKVEFDcDd6Vm9yOFdtaTdlaHpZUzgrQUU5Sm83SWZHVnBtRGlBMkJs?=
 =?utf-8?B?b1gvWFRVZy9iS3RIbHVtMThPK2U0M2Rzd1FYYW1xYmdDamR1UUpnaDZTdHhn?=
 =?utf-8?B?b3IxdWM0Z1JHNFBqSUFPVWlOS04xTk1jNmtPVUtsS3BYa3hMbnZUeGRrc1Bt?=
 =?utf-8?B?aVBOTVc2aWFjblZvV0dpbWpHWE11Q2Ezei8vSENPQTMrZk5aNjZYa3BnTjhu?=
 =?utf-8?B?QTVOeWw0cHozNHdEb3I3eTNiWUZIKy9Wb0phcmc0d3h2cmZUeHB6byttSXJG?=
 =?utf-8?B?b29PTmVySko2cTBObmp5Nk9Ub1lndkQxYXd1OWJGT2hYRlhoTlJsc0kvZjcx?=
 =?utf-8?B?YVlYZkZIdFJ4VTlyOHRmVFZDUFUxbE1QSzlwOGtNeXhsRkIxUWZJVkkwQ2dW?=
 =?utf-8?B?RFh0bkE0YXFLNEEvTU9BeHNKS2VCS0FwT0pVU25XS1NSbFZQR0tVYlhhNThQ?=
 =?utf-8?B?VGFwMEdQYmY4Z1lPYlJ2dFkzeHNKb3Vrd2FIOURRSEtVZnI2NGl1d095Unh4?=
 =?utf-8?B?RjlUNkIrNFArMnZHL1ZwNFd0UHVtcnpjN25YWnJYV1A4cE5mbFJ5VEtRQXRa?=
 =?utf-8?B?SzVKSGpKTDMvMHBrYXZvQzBMOTZ4ZDgyRGRlZmhlakJYZFVaUlN4bDFRKytK?=
 =?utf-8?B?Nnp1dW96SE14VXlyR0J0N1RPM3J2QWFUT3dVd29wVWZYMGxOSTRWRlRNL0hl?=
 =?utf-8?B?bGZ4b3NOUE83cUlvKzMzWjAxMGJ3R2JwTTFvOERHaW5JV2N3TjJJYjdFcUE0?=
 =?utf-8?B?SDgvS0hadE5EamcvRW9iQmlhUDE5by8vMlZabGdJdmxCek9PaFRVcjNLaTRF?=
 =?utf-8?B?MFpiL0dDRFRRUGVVaDZSek1DUEc1VE9DZkcvS0l4WTQyV2VrYUJLVEZXRUsz?=
 =?utf-8?B?QTBHeUJNSFp0Z2ptVjJmUGwrL29ibU5IT2VCYStPOFkvMm1pNlU1ZytBMUw1?=
 =?utf-8?B?V2Vrd2JXcE1oYlRBVEN1MXM3cTZmV1ZFMDFEVXZhVkppTUdXTzNaNU1kU0w4?=
 =?utf-8?B?VVZ0elJXNjFzcTN4Z21LSzB2bFVWaE5zUlZybGcrcjdiT2dnQmczaEpRN2wr?=
 =?utf-8?Q?92unDuLDzv0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDB6dG53TmpUTFdIelAxZnZuT3BEZ1hkQlA1ZU40Yk5vNW4zZ0Z0TVBzN3FR?=
 =?utf-8?B?dVZlbzIxbE03ZS8xSUFEQ056dGVJZXF6NzNsQk95MFc1UVNxcncwWnIxWktD?=
 =?utf-8?B?QTVsS1JQbFVGU3IvWTRVT3Bod3ZBU1hLZXI5bElORUNBTGhGdmtIVlZZZ2Ny?=
 =?utf-8?B?UFQ4cm1GQlpBWkljeHNhU3RqOWV3VldDaFlRaFlXanFKYzA4TWFjRmNxd3Mw?=
 =?utf-8?B?SzRPSk43bjJ0VW56QmtoaEFtZUJuQk1YbUVtK2txZDhyeFZ0RmdNYkF4M1Vz?=
 =?utf-8?B?M24yOGtrNlZpbzZ5N3lrSGdoTEl5aEczQ0F5Z2MyUUplTmxhZDdQRm5rZ2l0?=
 =?utf-8?B?SThFWGdlc1Awcjhyelp0NDFLR2M4MmRveGJXVUZmaCtnWDZocWp2eGc4TENG?=
 =?utf-8?B?aHNwVmEwdEFDZEc0R0hIU0NDZFpjRU5JaTl0THhqOXdCelhvYzJ3dzM0WWxM?=
 =?utf-8?B?cytFeWcxZmhqZ1NKY0JFYTR6OWhHMW9YQVEwNVpHS3RMVS9BdkJXYkt2Mitx?=
 =?utf-8?B?NWI1YVQ2UDJBVDNwMVZweitibkw1bW5KRzRyRFJOUytHejdhd1BpbStleVZa?=
 =?utf-8?B?MmF4bmF4c1pOSTFqQW5HOTlHVnZ1TTJzeTNQK2xpdmVxVXdkWUY0WWVtYTFT?=
 =?utf-8?B?QURvUmxKVDQ4cUZOMUtQNEtvVHZ0SXhjZmRHNFF1b1ZIWXBhc0VQTFdUYXk3?=
 =?utf-8?B?eE02ZlBrRDlBQkdWYlpUNjlmQlpDZThzc2g5OTJKaEtkQi9aR0hDRlptU1Uz?=
 =?utf-8?B?OUtvWHRlQURVQWYxZTdKRFZRUWJQZmFYUVd0ZXdESDh0QjlRT252V0ppSWZY?=
 =?utf-8?B?MlBtV3M4UDNIWWIvZHN2eVVqa0pmV2pvNFhicEVGWFJaNVFha0tvc1o5VXpB?=
 =?utf-8?B?Z0wyTDF5dTI3T1NyVkhvNkFyK2crN3l2SXZlU3hZUVE4VHlJOEhlZjlPY1Bs?=
 =?utf-8?B?SkhBRmo4ZXJ4U2RFMzZMdkR4dDhNN1NMdW1Tb3RZYkJ4UHNaWlkxMi91Ymsv?=
 =?utf-8?B?WTJ4eUR0Y2gwTTBNdldFUTVUdGZvS3FQOG5IdFNGcUc4cnpBZ2NwdlZVVWNT?=
 =?utf-8?B?ZXhoMExlNFlwbWlQZllUakJWcEltYW5XVlhKS2JiakpBTHI5WU1oYjNVRnVV?=
 =?utf-8?B?SXU2d0FtY0FmMWFJME1tUjVOWjAxLzkyb0k0czZyZ0txSlY1NFJLaDM0enow?=
 =?utf-8?B?b2pRay9KSXdENHc1MDdRRDdLN3NOMkRiWW5ocGZFb0ZPa29VWmtDREFHYVhG?=
 =?utf-8?B?Y0hZRExYV1U1TkR3RE5xcktRMkFxS09HK3VpZFgvQ0FRTWE3dEVZKzhpZHdl?=
 =?utf-8?B?ZDJmK0c4VlFOcU9xR1kyQ1hJOWxLeFZjdjBva0c2QWJoM2pHNlJhQ3BkRm9s?=
 =?utf-8?B?L1U3SW55eHVPWllULzhLWUtoTGJ3ckZZUmlaeWhTbEhKbmVpK3lKa3VvTDU1?=
 =?utf-8?B?RDliODF3RFRZV1VjbTB0SmlPaitBQ0RJYjc2UjI5YTZRMFVLTW1hYUJvWFBK?=
 =?utf-8?B?alBsc0QwUnhoU3RVTkdEUHdtUm9hemVZZ0pyY2Y2dTIyY1ZTNTlIMm9zOFZY?=
 =?utf-8?B?SXRIbGV5TU5HMEkwOWdFUmFqaERTR2dsWG91NHhkajk3SkYydTY1RzIvelVE?=
 =?utf-8?B?VEMzL2lpS3pKVTgyTDlBa1FDOVNkSU13QVY5M0hyVDArOGowenJmWnBVRDJr?=
 =?utf-8?B?aXkzNEUwRkd4dnpYR29XZHdqMCtnUG1hK3Bybk9NTmxqRVdoaFNXclVCN2tJ?=
 =?utf-8?B?eDdraThGekNJM2VQL3dUaXRVbVVia2tpRG1MbnphdVZTMmNVMEF3dDh0SWhV?=
 =?utf-8?B?b2l3aTg4R0owYUJMc3Zia3ByYkswa2pGZjZYNkV0V3hHNWIyYmxHdE1Gcmg5?=
 =?utf-8?B?QjBRemRPWVBjYlFHUGZENlpoV2FsYncxb3RHb25KQk9kTXF2SkxUT2txRGps?=
 =?utf-8?B?VVdubkNpNVo1ZldpZjc3b2crT1NZMjhDc0hMQ2o3QXdCc1UxVmozcGU5RmRK?=
 =?utf-8?B?eGdWNUFFekhlc1lIR2RMcnlpV2k3ako1SktUajdXYkN3bE1VVnNtK0wyK2F2?=
 =?utf-8?B?S2Q1Yi9MamIyY1M2cWhZL2htTzFqZVRCWkdpVDBmLzB0bXFsYUFuV1NPQzNC?=
 =?utf-8?B?SHVpcFp1UldIVW1NUEJJVHdxdmdLUktsM2RpQnRuTFZhWWJtQmJFOFp6Rlds?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49459a8a-ba20-4636-7dc9-08ddeacc20b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:27:40.5246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ClnaZi8M2p/QbIyimB5wTIyOIh8vq3ZIcd3pvVqfs6Rn5MNLm+RQA9f1vWUa/kngQTLVPHyH6LhAHnJkFOwjKzwUxMjx0N1TvhfxFho6GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6655
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

On 7/19/2025 5:32 PM, Yang Ming wrote:
> When a secondary process tries to release a queue pair (QP) that
> does not belong to it, error logs occur:
> CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
> qp_id=0
> EAL: Message data is too long
> EAL: Fail to handle message: ipsec_mb_mp_msg
> EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
> ipsec_mb_mp_msg
> 
>  From the code path, cryptodev->data is allocated in the primary
> via rte_cryptodev_data_alloc() (inside
> ipsec_mb_create-->rte_cryptodev_pmd_create
> -->rte_cryptodev_pmd_allocate-->rte_cryptodev_data_alloc).
> This memory is placed in a shared memzone
> (rte_cryptodev_data_%u), so both primary and secondary processes
> reference the same cryptodev->data, including nb_queue_pairs and
> queue_pairs[].
> 
> As a result, when the secondary process exits, ipsec_mb_remove()
> is called (inside
> rte_eal_cleanup-->eal_bus_cleanup-->vdev_cleanup
> -->rte_vdev_driver-->ipsec_mb_remove-->ipsec_mb_qp_release
> -->ipsec_mb_secondary_qp_op) and it loops through all queue
> pairs using:
> for (qp_id = 0; qp_id < cryptodev->data->nb_queue_pairs; qp_id++)
>       ipsec_mb_qp_release(cryptodev, qp_id);
> 
> This causes the secondary to attempt releasing queue pairs it
> doesn't own, triggering the error logs mentioned above.
> 
> This patch ensures that a secondary process only frees a QP if
> it actually owns it, preventing conflicts and resolving the
> issue.
> 
> Fixes: b35848bc01f6 ("crypto/ipsec_mb: add multi-process IPC request handler")
> Cc: kai.ji@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
