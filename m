Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2716EC5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 08:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47FA24025E;
	Mon,  2 Jun 2025 10:56:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9428F4025A;
 Mon,  2 Jun 2025 10:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748854607; x=1780390607;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6PNoifqvjtIYWByt4oHX1lAXx+JsWTBo6ndkkVfkGU4=;
 b=A6xr/EjavAUB+9C+lD9DMFRmzljW0VS/ogq23WUtlyD60pkJK1dVrCfJ
 VBybYFVrMusw+GDBChJBbWEEO6pw7lWFe2QvlixSFBIazRJzGxi7i2gA6
 RzEtPkSU6lerl9uNPMf9LFO3aNrlqgUUTzod+OA45M2zMwJJwUV0L+8CM
 kUfoxke+uAbZSpEryDbE7n/R5WBk06I9VS/MTRu8++wN57ABX2zkjapjL
 agWd04dUfj0zVTuGjzIw2Po4+1KqK85ca+EvY1htRd8yAimdg8qPbCYwc
 s3wgosKD2qIbUzBZ20ms61Pfkyo8k6fBl6uh9i7v4Y9aP3/a0TTwlzV3w w==;
X-CSE-ConnectionGUID: bHFBQ2p5QJqleQQgAb2GuQ==
X-CSE-MsgGUID: AIiZmYFpRwKNV1sO1FTk3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="61114710"
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; d="scan'208";a="61114710"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 01:56:43 -0700
X-CSE-ConnectionGUID: cDrXxfseSiCLup9M7xyfdw==
X-CSE-MsgGUID: eyNzSYKuRNezSfYUGtqBKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; d="scan'208";a="144933291"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 01:56:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 01:56:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 01:56:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.67)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 01:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql0mX1QJPgUv2F8BryAtByDV1eY3of86EH91D1c6JIDpU7/ikqTgWz0QTZ6UhUklTw+GnmSv4uGN5XTOqacJTqnDDJWcjLSHbCvwLgoRuBIppV2GYo24k+HnOABdjCOnVz5ypWWN/SoaxPBs5msyMT+9pK++djzfpFBLLvyZRDopi4JXXC2ov1xyFJduxstVDQK6RRlKvCDYQ5RqGP1wyw2Dn8im2U5dwl7Js7HtTTD0gekKe8oM8W9J5+MIs0v14JxYrAW/wM8YsCVAY7mX1KYF2WFaV094UD1P9YkQPelj+sQJBktR6DPUlUf8loyI79GKFsVAO2jKU+VRKZGojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERW9xlY2LC+i7GZveKyW6Y0tO/uMpe9qXT+Z+Vy8nr8=;
 b=AqqfAV6gwIVuwLvqWRI++5k9A5/W5IEfLhxPz/20d+R6aD0N/5qxsXirAX7agsqHNHNOAjtEa1XH7CFcC86+brAzO/Spgdp4pRTxkjglhTo0qEjOJkEbzeV1z+ZlVITIyaVIbzL+Qro+BB80gcAYppe505uxEYMsozRMjfZ8eJgIDVsDye2himuMvjRiaNguvethgkTLjzIFEOH6thaCGGOy/8wnHm8eD2jYF9whc42WrTy2c2SimV6A0c5cww9/jgWiN5vzplVpqT5JMft3pSkm1gKBfv88ZqeU6YYHyWqvSymVltNOZdzwOG/ZLo8f3D55WSfOwCLfzXFbnuvf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 2 Jun
 2025 08:55:42 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 08:55:42 +0000
Message-ID: <b88e3d58-0caa-4d83-b576-52f36228c302@intel.com>
Date: Mon, 2 Jun 2025 10:55:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] net/ice/base: fix integer overflow issue
To: Dhanya Pillai <dhanya.r.pillai@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>, Bruce Allan <bruce.w.allan@intel.com>, "Qi
 Zhang" <qi.z.zhang@intel.com>, Xiaolong Ye <xiaolong.ye@intel.com>
CC: <dev@dpdk.org>, Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 <stable@dpdk.org>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
 <20250527131741.7606-4-dhanya.r.pillai@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250527131741.7606-4-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8d693e-9473-4acf-87bb-08dda1b340ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXkvN21rWlRjTm1QTHRpV0dDcVdwaWs5Z0pjWnd6K1lSSlV5eFZFdVo3NFU5?=
 =?utf-8?B?Ulk3WE43VG9qMndEaG5iWnJyZXdqZVhBdHFUNWF5dmZNazJQT1o4S3ZxSnVt?=
 =?utf-8?B?cG1ETzhUSS81RjBSYm9NaHplQmFuQ2lJMHFSNlhqcXIrWmJ0OXA0ckpkUlVE?=
 =?utf-8?B?Vy9OaVZlb21zaDU3akh3ODlYUnhsSU9rSlVoNkJXVFFkVFNNSVBvTkRuVEY5?=
 =?utf-8?B?OHZDWFF2Nm1PRnNodk1ma1FjR0pGUnJndmpnakFneEhudEVyZ2c4dE4yS05Z?=
 =?utf-8?B?TnlML2hVRGlIY3N4TG5xQ2oyck9wOFNVL3ZLQys3Qjhxa3NvOWRIQWJ5UTZX?=
 =?utf-8?B?ejJPUURMUzEzRnBHSTdxY3hiU1lhMnVKYVVDTDlGNEFnbEdMVmVSNHc2Vmxl?=
 =?utf-8?B?UEdhdjFBRkpmbGxtMFJ4aU1RQkQ3VURIZFpQUUdFM2J3N2syUUxFUTVsbkFt?=
 =?utf-8?B?ODNXekYwN25wRkN6WU1WVG1DdWRteldlWDFYcy9DYnBxdUtFWHYrTEpyRnhh?=
 =?utf-8?B?a3NGZ1ZoMW9VNlpoNkpTd254ZWZZTHA3TUl1L3RyOWRBN1llb1M5aWVKTDRR?=
 =?utf-8?B?c2R3OFRGS050UlhaSnMyV0dxeHI2SXJqd1lTVXEzQ0xINXp6RURnY29hNGhI?=
 =?utf-8?B?YUJkWG5sN2hSSEdJSkNFR3h4alkyQkd6VHA1bTk0MUhWcmZLeE5XWHNEMklp?=
 =?utf-8?B?dm1GbmNOMEM3S2FIcDRPbytuY0RScEZSQW1WbTVlVlJSZGZaQ2ZSTmNBU2h5?=
 =?utf-8?B?Y0F3RmlGNzBGVG8xMmpnRlgxQnpVVUdtL3hnWkt1M2pPa2g3K2ZoU0JoWVdO?=
 =?utf-8?B?LzdKTUtSenVhK2x1WFEvU0I4M2FNRTNkSzZNRDc3MzNrQWVBaHhUYlRjRnV4?=
 =?utf-8?B?L2t4OThpUyt2TUxiWDNLNFdBVjczaThYRHJQclpRVTk5c3UxTm5PeUhtdlFs?=
 =?utf-8?B?Mk5aWGJKL2F2bnduZ0NoTDlxM2x0blJ3UnN5OFB4aGgyZDhtN0tlQWROTStl?=
 =?utf-8?B?OFlLVjl5Y0c2RzB4Z3FKUmliVUxFMGpnaEJ4MWZTZDJEY3dKWlk3UEFVQTdj?=
 =?utf-8?B?WXVxcFBMRW5VcGVVTWhHZVpLOGg5Mng5YTAwcVRSSXpiZ3pERi9LTVpKa0l1?=
 =?utf-8?B?d3JOU092ZkxIT0kzS205K1pSSjdpOXY0WXk1YTlHOHBlUmhnem1yMkd4Mi94?=
 =?utf-8?B?K09DWlJhQ3pyZ3JLbUZoakxhZzF3M3FVOU5rbVEwNlBMRTdFbS92L0ZWNDBP?=
 =?utf-8?B?YTIxYzdvT0xaZ1d4Zm5tS1luR3NxWjlwQUt6ZDlrRW8xOGcyUEVYNGZCSjdR?=
 =?utf-8?B?UnJnenZTL05vTVE2YVJYVUVzdExJeGlMc1h6dzhnZnRiK3NLNGNNZG5aRUJS?=
 =?utf-8?B?T0NHWGNtbytvT2VrdUczeTA1Z0g3THNGMm0vV2hjQjBBdW1qdWVHUDFHbE9B?=
 =?utf-8?B?RTVWQ2U5OFY2SVJ5cG9qN21sME5pajZySjFnWlkxQWgzenV4aFUrK0VscGVQ?=
 =?utf-8?B?SmRZRnR6MHNsaVpJUjRKMTNKRkFLNXlCdGtrZWJxYm5iM0tkMmloSEpRSVJZ?=
 =?utf-8?B?NDRscHhVdkxoUDgyNGZ0UUNsOVYzdVZ4cFprdUppZ1pBZW9FZTZZZ2RhWUV4?=
 =?utf-8?B?WXI1U3A4eE4zRjJua3NNUEcxTk1KSkJSTWpUcE1mNEl5THdmZ0N6ZEhxV0kv?=
 =?utf-8?B?YlFUSUdCZTBWM1JubnV2ZzMxWHJ5VUd6Qkh0Y0dWdUxpMm9XVUJ6WDdMYWRN?=
 =?utf-8?B?RUpVZ0pQcTM4QUVoclBYZ0hUMnhCU25qR21jVE5lbzFqaFFlL21zenBJVGkz?=
 =?utf-8?B?VUVMNVpYVDc5MFRlTm1Ua2dVMi92bGhSVEZmZzdWMmVkeStYamVaTnRlZURC?=
 =?utf-8?B?QnFLN09CNnViMnZZOXN1L0NNSnZlazZMU2NZVGFrOStxOERxSkIzdmJxZisr?=
 =?utf-8?Q?TgVbO3gfYOs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RStQSW5pUnh1YncvT0U2akF2VERGL0pwZGZncWxUcjVnbGhKamlQZEZOZXRy?=
 =?utf-8?B?OFVNcVpGeVNkTzNQc1JKOU51VWlibTV3MmlISC9od2dlSW1uR3RaVWx2MjNB?=
 =?utf-8?B?YUIvTUFzOTZzMkFIMndpVTN6WEdqeHhraVhqZE52NWtNVy9IN0toTnpKS2lE?=
 =?utf-8?B?SXZ6TTNKY0pkd1JoUUFNdS9RMjRTd1dpU0twWEJ1NVNJUnJadGN1UllSNXFH?=
 =?utf-8?B?NjAwMWM3Qk5ZZ1RzVHlpWWJCVlFPeE92NGJOb05rbXo0L3IxNm5LdFRZdm55?=
 =?utf-8?B?UjJaV0x4OEY0dzNBc24zejhkVkZCRGxuSVd1dy95YmV6bzVsQzZMaTR3dW83?=
 =?utf-8?B?dXpyTmpCWjZ4RzNXWWY5S2I2R1Z0Rk9HYjBJbVdlL0o5MjFLdEhWS05UNWlR?=
 =?utf-8?B?VW9GNXpuV1pvSVVvc24vS0Z3RktFZWxkbVZOUGhBUGFSTUlNNkgxQk1McGZu?=
 =?utf-8?B?TlhONkNNaTllVG5FWHpKNXh3a0JkODJWWnhJZW5CSTkxZDdQY3dtMFRQckxJ?=
 =?utf-8?B?SGRmK1YwZ3FETjhKR1ZXNHBZblhGajErbktBVnJZa1BvSUFmQjNTSDFaMklP?=
 =?utf-8?B?aU9Eai9maGt0eWlSOW9nakwwaHdXQWJVSWlTdEppNkxpQ01ja3hJN2RENEgy?=
 =?utf-8?B?VENqVEcyN2ZpUEkwMFpEZi9JckdMdUtVeW5TczFoMDBpMGxGTkZkaG5CenJY?=
 =?utf-8?B?VGFRNGJkNXNRV3NYTGxJUFZ4azdhSWxFbE4yVkxnRWhHVmN2L20rdGFXVlNn?=
 =?utf-8?B?N2VVT2pxa0xHV1BUYlRPRTZxMzlvOUhrYWw0NFhUM1FDL3FBVkFGZTN1Z3Bu?=
 =?utf-8?B?OXNVaFdCeWc3QTh3MGJkNE9ZNFE2U0w3emdtVFA5YURNOFdkbUMrN3o3N3dT?=
 =?utf-8?B?aWZvUFh5cE9MOHBHQVVRT055b2ljeWN5cjV4UXN5bmFiYTNJWEZFNG9seHZM?=
 =?utf-8?B?ZzhzRkZQV0FqelowNkFwWWU5cW1XYkhCTnFMWkZMMDdRbEpxdnVHNmxpNE1v?=
 =?utf-8?B?WFlLSUU0NEY3YWtmM2pYT2J0dUtYZEI3WlRua0JoL3FyMXg1eG1NRWRDSXhO?=
 =?utf-8?B?WkRQcXFvVzd4ekxOcng4QnlmQ1BKdUFuRFk5QStRWHdlU3RhMUxZR3MzM1d1?=
 =?utf-8?B?U2REN09EVHhjem80Z2xlNXRHN2gxdE5BVEtYaG9OakZBZ1BZQ1p1SGovTTNq?=
 =?utf-8?B?dWhhWGhMU1d0YUx1OGNIRnFGdWVFcHhUL1FSaEJGUnM0cFhzcHpJWHBiR0Iz?=
 =?utf-8?B?Qis4eWJMdHFBS25rNXAwM3hXZTRnZnVkQ0NCRWlrRndBM3gvRWxOUDJXNklu?=
 =?utf-8?B?T2d1VlhaS29mOE9kcGd1a09GSDMyQTJOcHRWWk9jYVFaN1R2Mmw3eG9xUEdp?=
 =?utf-8?B?d3Y2NHVvZVlZSTErMktmVGVBVGwveU5Cai9IcmFGQi9VYk1Wa3FsVERxV1Qz?=
 =?utf-8?B?cGw3bm5HQVgxNEViMEoveW1OYmNZWk81ZG8vUHRXc05jeElzdG5GMDBRWjJL?=
 =?utf-8?B?RVcxbHlMY29tTFZ0ZFdUeHdBRk1JclYra0ZtVHB1MFh2cWdxM0hYNmptTFY0?=
 =?utf-8?B?bmgvOFBlWHZ4RkVxNldGekJ2UDlwWklsVmo4dFZrUVRRdXNRWDcrU1ZUZXpI?=
 =?utf-8?B?UFRHZTJPdnNqUHlxTWIrWXk2RUVZUGxVRk9Cek9zdWQvM290VUNFRE8xRzZn?=
 =?utf-8?B?OFVoTnFkdHpwRmNjN3J4bVQ4Q0ZRSE1pNE5WVFJPWUdsVFNVa2pRQlp5OWpP?=
 =?utf-8?B?aXQ1M2NEanU1OHRIYjlXVmt1UWhaTlY1UDRoQmxobEJOTmRxZFNMNVhscmYv?=
 =?utf-8?B?RW02ZmpuSTJvOXpNT0pheTJLMnhCVHEvd3luc25zV0s5cExPOHN0dUowZURJ?=
 =?utf-8?B?cFJuSzZuaWZua2xCZ3NDaDljOXNqS0MyWlE1RTUrNndyTmNXTXFPZGFOSVdt?=
 =?utf-8?B?c3l2c3ZwZTc2cGM1TGpTbk13VHQxQjBqbGxMZDJ3ZlY3N3lmQ2lXaGZiTWZj?=
 =?utf-8?B?bkd3M1lxUkxCYlF0MmZFTUNQa3BudVpUbCtTVjROL09aS3J4RjE2Vnk3ODBQ?=
 =?utf-8?B?Ly9POWdRbDZSNWlTSE9ubmFZa3NVVG5adG1yS2YxSmNUSU1KWVUxTFZtSURV?=
 =?utf-8?B?bWYwalkzU0QxM2FQUW1mRjRRL2Flclc1T1hidi9KV3hsS0FwcEg4SjlYNW1Q?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8d693e-9473-4acf-87bb-08dda1b340ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:55:41.9454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsJgv8ADjzAeM1MZiHjhoVUenG+6JgwEOE55HU4dVWuBnH4zBkjua/jW+HbOcDGyzrbJtTLW7ZbkzrNhLLBRxuFEsGMfogjcttnyep3iHDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282
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

On 5/27/2025 3:17 PM, Dhanya Pillai wrote:
> From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> 
> Fix issue related to INTEGER_OVERFLOW.

I would also suggest rewording the commit message. Even something like 
the following would be better:

Fix integer overflow issue in power of 2 calculation.

> 
> Fixes: f636f2888cec ("net/ice/base: move and add some help function and macros")
> Cc: stable@dpdk.org
> Signed-off-by: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
> ---
>   drivers/net/intel/ice/base/ice_type.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
> index 297a5ea890..ae3b944d6e 100644
> --- a/drivers/net/intel/ice/base/ice_type.h
> +++ b/drivers/net/intel/ice/base/ice_type.h
> @@ -25,7 +25,7 @@
>    */
>   static inline bool ice_is_pow2(u64 val)
>   {
> -	return (val && !(val & (val - 1)));
> +	return val != 0 && (val & (val - 1)) == 0;
>   }
>   
>   /**


-- 
Thanks,
Anatoly
