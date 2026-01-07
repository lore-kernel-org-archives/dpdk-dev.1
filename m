Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F936CD5854
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 11:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D025402F1;
	Wed,  7 Jan 2026 12:00:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 398D2402D6
 for <dev@dpdk.org>; Wed,  7 Jan 2026 12:00:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767783625; x=1799319625;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=f7LP7oYJyD0qWxCJqf0thh49sAqFvIUEmKqBMQgemiM=;
 b=a9IXpoA4kWf5Xo31hJ3r+yQt46AMXCjpPCMUObs/41Z6W5s+J4e/Faiq
 My8NZsRp4sX9ZTnTbktDBhLcOc9ptW+DRKm7UBFDEZ8ejYNBcYciAohaD
 S0va9r/AgMqFlGyxBFwgm9WbRCPR5DLoHtdRt6246xqKaTomv0awxUma9
 khe4iyc1S/Xigwuv3CDJ/ApfkS5xg9L+Bo5Hec16vhFOPzy1e5afO2vPh
 Uat9Sdkh2m8J5bNupXS/pugttlLYQeJv8cnmSIWdvxXQgW+ZGL4bhpDU2
 UZMrWue4frrvQ3kYhd2mqHEc/99uTMoxlRthFE1BtrJVbTRAjetM5fWda w==;
X-CSE-ConnectionGUID: qvT7g678Sh2gzz33mJtAPQ==
X-CSE-MsgGUID: 5VDtw+z1Q3CH8w3ynYyYdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="56711867"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="56711867"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 03:00:24 -0800
X-CSE-ConnectionGUID: G9/nmY4NS1afFXXfShgp2Q==
X-CSE-MsgGUID: RuxxvJbPSG+1f50leSFwrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="203160405"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 03:00:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 03:00:07 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 03:00:07 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 03:00:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK2ny1kiTAlEGFhliKx+l6zKRzQKjY6KpZgqV7Ko/f3EZZt3fT4pj2Nki66Ijwln+wl4XSfPjrtr7ut2I99UegkB/eSHyGo/2gjm4vYqsEOd+SAKsH2yoSwRW20HU5/X9e6fTsHH+DkQ7JzFm2y64nianDaIg4cD3Ru5R0q42HAbGx12WatkHwsgFR1TFhOecQC+f6LPnZa1QaFJx1rnR7mN8fMon2HxaFqwHbj1Rfqq7Ivki0G7/o30Fem0efqbQz7YVjOTSJxPZlnKPU3U2acEz6ck2Rfyy12vawVn4fHvxZ4XM9rC3HkHV/9PK+E0feZDGAnlfz8ZAv9L64+ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tthJjIjzbc8TNyIVvrUTFqSySMg426B17wwMRE8lrLQ=;
 b=IFJY9GPgqO85XF/I3fGZo/w9e/e3eSB/k2U9DN/x0UJCbGjgN2SdGZq132zeEglvt78JtES5dFDmhVY3o6BzpTqo4bst6Ym7b0utcJs9lXOiGanicWAvDQWajqsjcN8bdTaAWg0f2ELVg6/CqBljWaB7Vi3ZALFZRfFKXaV5pMJEadlS6WSNHQxdSwBOK+ohYse4To2i3wTmksaOZ9478QSTaaj9TcpJ/7kzKMJLEqk+UL5b+eNQydQBPC3zePkt3W3SmjYZOmQJlybZFgF62EoFFtw72rmagVYHCWV02arZM6597icwc2VD4vkXI5W3zNF48o7pciqmL/uGLiMIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 10:59:59 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 10:59:59 +0000
Message-ID: <cbc7a917-c7b8-4110-86b3-f1a73bcd727c@intel.com>
Date: Wed, 7 Jan 2026 10:59:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cryptodev: add SNOW5G spec
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, <dev@dpdk.org>
CC: <anoobj@marvell.com>, <ktejasree@marvell.com>, <gakhil@marvell.com>,
 <kai.ji@intel.com>
References: <20260106104357.2452583-1-nkaithakadan@marvell.com>
 <20260106112357.2454990-1-nkaithakadan@marvell.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260106112357.2454990-1-nkaithakadan@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::12) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c11c9f-d120-4e6d-50dd-08de4ddbe631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0FjQkZoT3pWL3kwblZCT0xnTm1wWUR0c3BBbGNiREtQWFptd1o5dWRXMXVT?=
 =?utf-8?B?cVpkOWFyNDZwY1NWM1l5RGE0R2J0dlpUblNFQ3JLWW8xcFlIb21BeU15dGh4?=
 =?utf-8?B?dXp4aW9xMGpScjl0bmFkazZOelU3QUJIN3k4VHZqeWh6enVUTU12RklrazJ2?=
 =?utf-8?B?MnFPY2I5dURsZnRxck13MTFrYnBIN0pkZnIvcTFDcitBanpMR1pTWlhPaGtL?=
 =?utf-8?B?SmhJYnI3MjBKNVRjODkwcVRWcktmUVNuNFNhVUFVRXJlNmFnejZTVVBMWG5R?=
 =?utf-8?B?T283ZWRCQXNRVVZjaFFQRTJjTTcrSDNXZ2FiTDVFamlJTG50ZHAwamVhcWIv?=
 =?utf-8?B?QTBiWVJkUC9QdFkza2U3dkxBd1M1aGVTTllEcjBaSG1lNG9iZzlCSlBMdWwz?=
 =?utf-8?B?endZbnZ0TXpUQVpzV2pDcnlnSEwra3k5MDRzeUJCUE12SVBzMDdNcy9DajNj?=
 =?utf-8?B?RHhDK0pBZzhNY0hzTmkyTkM2eEVCb3FSZjBmM2xqaGVmdlhtVVQ2eDJiNytM?=
 =?utf-8?B?QVZiY3lLQzNXWDNqU1pza3lzMmJwcTNJSWNoUFVBQ3J1VXZuRk1sKzlQRG56?=
 =?utf-8?B?cTBvS1RFc1NneUlibHJMYVpYRjc1elBReU9iejRBYmpMdzBKRm9SOURIN2pW?=
 =?utf-8?B?UWJQeFRpbGdITks0TDNhZzA5K3B1bnVFVC9CZmV1Mjg4bi9Ga1RxUk1DM0c3?=
 =?utf-8?B?ejdOZ1llNzFvOE4xRkhrdCtHVG56WmFody95c1ROZ0gvMnFvQlZLK1ZBWDNN?=
 =?utf-8?B?NVg5Z0VFWXRFeitQbjN1TXM1SGUxK2orVzdFb05Zb050SEcwWlkrV3lQSms2?=
 =?utf-8?B?Z3BpWGEwdlZqL1JWdTlNN1V3OGFJbWt2YVhYQ3BXNlpIYUZUYW54cjRmOUZ5?=
 =?utf-8?B?R3NiZjMzV2prdlBSRTF5dzBZTmdZWE9BRUNkYnNaSy9GWE81T2kzZUhFWUw1?=
 =?utf-8?B?TS9DcGRFbXoxa0FkQmIvNzJNbTBHL29mdU16R25RMStHbFFwalQ3cWxXOEtu?=
 =?utf-8?B?c1pyQTR6NktuUXdmeDQ1ZDFicWx1Kzd6WEhtR1I3d0ZLR00xQWJKVVhKdzNS?=
 =?utf-8?B?U1BrR3V2cTRJT21BdnhPTFJDWThlZytZZ1p5Smp1RjVMT2VEb20zV09oajB6?=
 =?utf-8?B?WHAvd245TG5remRtRVlWU2xlNnFlekVUeXRxQ3BBbnc3d2JuWWlOY2tXSW5C?=
 =?utf-8?B?NHB4aWY0dEVBUUtmeXBuSE8rWlN2STR6cFhCSEZlYlBlT3UybHUvekRKaldh?=
 =?utf-8?B?d0Z5NCtreEZVMlN5Y1cwT3hjaTlweEhMVWlGNk9HSzdTSzB4cmNVNTdYdG1F?=
 =?utf-8?B?VWVvVjRMOGlmUzR6MTVZUzQ2TXRZWmxhMHpZbkFEQmhVNFNnTmhVclRyTTA4?=
 =?utf-8?B?aWlkZFZHejFpbjRNa2J6dlB5VXBwZTY0OFd5d2NXYnd6YngwQ1k5dytYcUJa?=
 =?utf-8?B?ZWtNVVRNZ3JxbUxuVnBFMmkrUlBzYmNoNWJpQ29tZWNveUxNQWExSW1XQjRU?=
 =?utf-8?B?ZHF4ejU1T01ETnB4T2dmM2tYT2dSdG1MQnVVRDExbU9nSitOcGpMbkJsNExv?=
 =?utf-8?B?SjhUWWdrU3crb3dyVFZXeHJYYjlkTHN3aG96c05vbzFtdFh1Smc4dU45cmJS?=
 =?utf-8?B?dXFyK3gwT25WdXR6WXlNS25rNkFKeDhGM2RqVU5BTDd3MXViV090WE9PaUxo?=
 =?utf-8?B?T01IWUZZZWNnY3NEYzI3ZmZtZ0hJVHp5NWpMTytXRWJYMDVXQk5hbjJrZjh3?=
 =?utf-8?B?bnNTUmo1SmJnL0RCbGZSazd2bXlyVFFTOUMvVnVFVHpNK05PWExRamJyeHVS?=
 =?utf-8?B?ZTJEZ1Z3dkRhV0hsQXdZbmpSS0dCamwwM2ltOWlZRVNwWC83RXBMUnI0V0VW?=
 =?utf-8?B?WkxrbzZRbE00WHJUcU1HcEdLc1luOE5lWENyYWNsbVVGMTBzMXIyZVFUb3pU?=
 =?utf-8?B?MEZ3N09KNFNsMWFiNzAyWTF3emU2MWIwTlBES2NYWUEwRjBXdkZBZmp2cDUv?=
 =?utf-8?B?TlhnZnFXVGZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NytDSnJNdmt3Ynk1QkJtc1QrRFNtUDRKZVFTWi93NkZxdWNrZ1pNOEZhNDBC?=
 =?utf-8?B?bFdpRDdCb1U3TDFZSU1kOUhFTS9GMG1GTzdKRlJWK0tSc2hYRVhHaGtKeGlv?=
 =?utf-8?B?Qy95OXBBemZ3eVloaFVYSUtxUDY5RCtVNUxpbS9DdEdpZjFsWDIrcEpNd053?=
 =?utf-8?B?dzVTM0JSbjk1a0ZQV0xuQjRUWlYvWStQL0ZSd2RuZGJHOEZXZThvckZtZHEr?=
 =?utf-8?B?aU03RlJ2YW10NFk2UmhYa2hjeFVlTEcyajBPeWlibWJQbWR1SlJUc3hoRld2?=
 =?utf-8?B?SmgrV1FHWmZQekJ0SkNzcWFDL2pZNWJwTGsrWXhRbFJaSGVyOUdudE1sM3Nr?=
 =?utf-8?B?RDdmWUxneXBzWU9PdVZ1SWFWaDBwYmI4dWQvMk96YWRvREZWNWNud1hnT1Bw?=
 =?utf-8?B?NTIyeElxME5ZR2lIYXN4WGN2RnVqbUJicGs3L083TmtMc05tRkgrb2FqWjVx?=
 =?utf-8?B?MTBBUUtJL1FuWU5RZlFzMWFRbEhDcXE1TU9Ea05CM1JCUjJvQ3NTZTZYbDNK?=
 =?utf-8?B?UVBiaUJ4UWhYNEdCSHpJdTIySkZMelFjZVhsR1FkcW90T3VnVFV1ekJKa3Iy?=
 =?utf-8?B?QmhPZnFZODJSNWdIb2ZwQ3lLc0l6MG5OVm9FRS9RQ0FHSVNFUFZzWUt5aGRN?=
 =?utf-8?B?WnovNEVxa3F6UG9WajdhTHpTNzFMUVkrVitZeWZ0ZVZweHd3RW04dmI1WkdF?=
 =?utf-8?B?QmhrUksxMiswOFVwNzFRVEhCT0ljcTU2a1RsQUNRMVpPY2pnaGsyaGtRTWpQ?=
 =?utf-8?B?UjhFcTVsSElIdDRnZVRsUGVvdVJaZTFObUNYSm5iRG1WbEFwVmg5b0Y4bFk4?=
 =?utf-8?B?ck1NWlFtMDF4QUdtUzE4WXVYNk1MKzNQbDdYSGhqWTJqMlR0OWtsU1pNNW9k?=
 =?utf-8?B?eGR4R3pVK1RLV2N6V0RqeE9TM1QzNGhOdVdtNW02aEF4Y24renJWaC9jdEE4?=
 =?utf-8?B?VFJpNzY2U3JJOW9wR2gzd0tvLzJBdFY1bGM3UEp4MndxOVRDd1grZzFMUUFT?=
 =?utf-8?B?a0dSVSsyUFJGWTE3bE02c0lsWGwrc3ZQbWNsRStucTMzTUJjS2phWllVM01I?=
 =?utf-8?B?RXRWbDgrYVhMaFQ3VzlUaDBoRnJlMzR4QVdvTDdpYmF6TXJOcHZ2ZzhsaUwr?=
 =?utf-8?B?OEVBMHh3bEEyanBEd3ZpZXlsZDhjdXFoZ1hraXhJbXBlek9mL0hISEgyMzNY?=
 =?utf-8?B?ZnhuZzZNdTlnREdiUWprVWRZSCtkVVdVU0tRZ2pVYXBuNVlzRXI2VnRwOWp4?=
 =?utf-8?B?UXE4OXlBOVhvT1ZPSWZLSVJ5OWx0V2JlNFNpN3ZqVFNLeS9ZMElZVUptclZ3?=
 =?utf-8?B?VDlYcHl2SkQ4ZVB5VlVCMWpnK2NSbzJhaWlZUEhYR3pvdGl5V0xpZ2RiclZk?=
 =?utf-8?B?K1NZWFhkK2NLOTdzZFRGYXV2ZGxZc0J0Z1NFOFo4alp6QllVbi9TRXZYMDM3?=
 =?utf-8?B?MUpKTmp1TzNXVkRNSFk1TldvZzNBQVhLM0xKRWhRT3M5amV1eVYzYXBQcjlk?=
 =?utf-8?B?S2NzWmYweDgyQ2RhZVRRamFZdGdkYVlqRlBKZDBIRDZNRE1Ba1ZkTlZOZy9O?=
 =?utf-8?B?SXVLd3dTbE91blhLcFpKazY0cjJ4SzNVRVpUOTAwWHdpcFBpVWM0MGxlQVRY?=
 =?utf-8?B?ckZhQlhCajVUWlBiL0NCK2pXNTJWckFFditRczd3RHZZSEYzekJNb3FkcTF4?=
 =?utf-8?B?aUxnMStUdXlrUjRmS0xtcHZHK3FzNnJmMlhiQzUvVDVOelk3Qnlla0tIMG1Y?=
 =?utf-8?B?Uy9Ga2hFelpsU3pudExxWXNpOXNGUENlU2NXVGVXVjMwdk1BYzkxVGI3SDBU?=
 =?utf-8?B?M0cwYzdDb0ZQeWx2NFovTDAwK2ZkVzdwRWNIQXA1UDRWcGs4S3pmK2RMdmhZ?=
 =?utf-8?B?MUdRUUFCeWVPbUZjeWxQaVlYM2RocmtPbE1lK0EvZWp5VWpHbzhHRnVYS2o5?=
 =?utf-8?B?cExZNitVU0JkYVQ0c1FXcStqRGh0blhkR0d5WUg5dEsxdHQwVE5qd3kvVjRj?=
 =?utf-8?B?RE9jVnVrZld5bkVSbnNLaFVNL0U0OXRldUVlUXkzVS9EKzZoUXZDOU9ZNmtL?=
 =?utf-8?B?NzF4S2VETHltYVpuQkJWeG04VFVvRkN2WmJMRE84WTlYMWh3Ujh6QnJzWjVN?=
 =?utf-8?B?WnlIWkZ2OTduVDgzY3lEN1JybTFVZnl1a0IrV3Q1Ump0UTZqSUhXT2NSdVFV?=
 =?utf-8?B?K2lONTF5SlZNZzlPb283OGNpRmYzRUlXc1BsZE8yTjIvRzluYXpRK1Y4bDRH?=
 =?utf-8?B?cEE2S04xK1RVMFlJakNGMk1NSWRsMFBSandHMXltRnZGSDhBL1A0UlVNbVlW?=
 =?utf-8?B?UVB0ZTIvYlFCcCs2WFAyb0RlVGsxcFBrdTlEdG9xenE2UzVwT1JYQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c11c9f-d120-4e6d-50dd-08de4ddbe631
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 10:59:59.2470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYpqsENCN2ZPfpR8fGZqMDVEnggsXGkDFk+bY6BGAtHYWiYzZ1UC0RkCzYAwMpDFUFqeAij4v+W6bAmNcqBbjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
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


On 06-Jan-26 11:23 AM, Nithinsen Kaithakadan wrote:
> Add specification for SNOW5G cipher and auth.
>
> Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
> ---

Hi Nithinsen, we were also working on enabling these new Wireless 
algorithms, I just uploaded a patchset that enables the whole set, and 
also adds unit tests / test vectors.

Please have a look: https://patches.dpdk.org/project/dpdk/list/?series=36979

