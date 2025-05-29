Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C836EC54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 15:57:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 200114278E;
	Thu, 29 May 2025 17:57:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id E50AB402C1
 for <dev@dpdk.org>; Thu, 29 May 2025 17:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748534269; x=1780070269;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OiUTo3qSLFrs8WzfrM+NgzhE+5KF+5ZSQhLaFYQtTQ0=;
 b=fpARZTm9SqJ8PCrANvV8WD25hGizgAJWRM516xqy/Fi/yBHsxHSOGuJh
 KYclNcT1tkhHqZPnsHAOOXo8lFwMb9DTCPuoGlm5hCQ7ozC7PtIdydEPy
 eEYzGzdWRJf4kAd/GQCpHc3F9L++qPVVKcgRU0tx6LjcTDEl2MSG66ZXL
 Im/llkFvLBSdqVgLmcMBa6zhUfwuM7qbo3cjr6p4esJD28KAl8pKjM2wY
 lyeK47t1q0i66DfjRRFDCvnqp7fmMFrInZ8L2U2D0fxB2KA2jtkJwSDmY
 7y9d51Y7tlssgkDtgnZqjMouZJEKfUis4LBChTEHTwSDZR2t2NF0uQVgB Q==;
X-CSE-ConnectionGUID: WRvmOcLYSa2cRr8jJLkdYA==
X-CSE-MsgGUID: jgIpu1+zQpC0vqqc9ZI7BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="53227454"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; d="scan'208";a="53227454"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 08:57:39 -0700
X-CSE-ConnectionGUID: 2WF5KOsmSmeslIesBUnlDQ==
X-CSE-MsgGUID: mouGM1gKQuOYvSqg4clFyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; d="scan'208";a="144589859"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 08:57:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 08:57:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 08:57:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.61)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 08:57:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/dSnxuuZHUwk26Qh1Y/t1LxDJ58x4q35sj5nhXsmC/iyeVBGF2u5kq6ePPEKlY1uTiywrrCqaVMA4ZuxmIqGCQ/9KpwF/+ItTzoixGz95Zx7BcQUlQ4nDql13bXeH77Pjvtseaqug4U350AY1vhg4TFsiyJcOF/33dNYcsC4QoKs/9c4OLFcPiuDwx9BSgdG3nSWUEP7CRbXbwVyRDSKRuOfdwDg0mBSXgfoM96ExGzGxthEzdL7Fl/1peou/gybtMuJDgJb6+SvFXXA60XWOSh9+gUtuGrGs7DgesYMSiiNJo5/feEbMvlk0QnYQ8p//BSc2cFUh26jOQXZiersQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqfcV9P6Ua9Se/lQwdZpc+3E+6aSD0n4KQt6fDrcFHY=;
 b=fa/i14nkRj84sAfO2vg3lizjuoBaplHm20EfXhBE3NgNKE3weiDHvYqXrEQTdfaXF+9mCxy9p5CbBPrzMJWYeJL2t1e4yy2nlzG0VFItMgefqKvk2YbIHK2rB1nS8GNoK5aKBNnkTxSnRprDyzfZZ6meC0QJ8QOPFDo4u9DtAgqgbNqjNvMqlJZ9w3k1wQ2kMO+nhq4Cts8W2HYrSxxMqbc7fZW06DxKeh7X6ZGGF55Fj2+9Iw/YRtY/Vf6hzloYsUZI8D048i7iO7sjMJ3xK4pUGrVX8eJyCTk9d6HsffDbET+PWGMp5TdzqyIEHRDT2kjaO0c9z6bwpECr7XB8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 15:57:34 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 15:57:34 +0000
Message-ID: <403c2595-c803-40a4-9a27-7e750bc82a6a@intel.com>
Date: Thu, 29 May 2025 17:57:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] app/testpmd: harmonize case in help strings
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, "Cristian
 Dumitrescu" <cristian.dumitrescu@intel.com>
References: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
 <84ed4f7e118e8003cc00826f605555212ec07781.1747996555.git.anatoly.burakov@intel.com>
 <20250526075243.20d0b358@hermes.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250526075243.20d0b358@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7dab61-2d4d-4b43-a5fe-08dd9ec98673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THg1VG03SS9Ob0lKWVV4NDYwd2k5K1FZRjVMVktaRkE5U0RXWHFTOEc4MWxU?=
 =?utf-8?B?ckhxYUdGVkMyeUZDZXRIaWd0TnVyOWUzL0tLQ2ZoZVMzNUhheENpdHJMNlBk?=
 =?utf-8?B?bGlHb0t0SnJOWTFkclNjQkcva2VrOWN3TkZPS1IrdEVIZ25qMFFUbkZ4cmsv?=
 =?utf-8?B?eUpybUwvdlZMZU5FSzhObXMvSVQwUHdVd3lYem42aHFFTVVkRllITUl1MjlZ?=
 =?utf-8?B?V2ZadlNtTTFNcjB6K0RrY2djNUVwRUhpbEJrbmh0SEZ2bDI5OXNBUEtqNGtF?=
 =?utf-8?B?ZnZlVUIraWFXWTQxbzBmU3VIS3dZMyt1STcxdGo5SjZYa1pBRTVaazNTUnZO?=
 =?utf-8?B?SnQ2SWx2ZlRvLzI0U0lITTZwTlVIQzl6eGNtNm84WS9qNWc2cGdScEVKNXJD?=
 =?utf-8?B?UlZDeEZmUGVMSmVYM2FjU3BqMFNkcXQ0N3c2a1lESTl4MnlXam52L2FJc2hS?=
 =?utf-8?B?S3FLNlFsTUlaWkczUlU0SUJmWGRaSFAwQUZSdVM1S2Y4TjNNY0ptMURJVEJa?=
 =?utf-8?B?Q2hYTy9KMHhwVWxaNEJuWEk5Znpwejdab3JaRXhNNGVnemF5eFladkpkalZ4?=
 =?utf-8?B?M2I5OTUwQzNjTThVNGZDY0NFVDg4emZNRUltWjdFSVhVSW5kRFlMQ2g5SWJz?=
 =?utf-8?B?clEyZWhyNTZORTAzOU1raTRSZlgxRk43QTk1aGQrQWhQRTNiNTlWVWtBS2RD?=
 =?utf-8?B?VHJGZS9wL0MzVm9pODltUHpVRmtsazhidlVjSldFM1B0dllDS3ZuK0FJYjIy?=
 =?utf-8?B?ZHFkVHlFUlJCRnBCb3RkbUVQVHRuMkVybDNjSWxEMk4xMmdSR3dwSmcwRUNk?=
 =?utf-8?B?cG1GNDl1aWU5dGFaamxnT2dYaTN4Z1VyMzd2Nm9rNEExLytMZW1zL3hQbXZY?=
 =?utf-8?B?N3V1a2JUelV6Uk8rRmtFNWpCSU9yNHJkYjdua1dMbit2c2w3SUlHTGovU3Qr?=
 =?utf-8?B?Um5raFhQNWkyNEU5RFBYWmpCRzlERTR6bHJKUkNKcWFOcmlva2h3dzV4NnlN?=
 =?utf-8?B?WjRnVFhPRHFCMytVOExnQm5KaVNvalpROG4rUi9na3NYTDVYTUowZVVNUEkv?=
 =?utf-8?B?UjBOKy9VSSs0OVhFT05sZDlESjlkWDZZTjhmbEYrRVFNNm1yUWNrMVFGZHVU?=
 =?utf-8?B?MnhYTnFLQStGTmNYNnowd28wVTBlTG5VbWRVbzlNeWpCUzhkR0V1bGdMYUU1?=
 =?utf-8?B?MDlzWGNTTEtsTmF5YVhXR0s1VlgyRkVvTkw4TWFTVUFRYjlxMTl5Qm5vaWc5?=
 =?utf-8?B?OG8xYkRDYThHVkRUR2RwbEFlQTdVZGVzOGhZSXR2QlFhU2hYTzdUS3FsbFpz?=
 =?utf-8?B?MkVJcEpTT3daOUZyR1p0dmdYRzlQSitqak44N3pydzZFS3hMU0lIVHJvYkcw?=
 =?utf-8?B?WFFITzlPNHNHZG9vOUVzOGc2L1pmdFIvTDNhSkJ3czRhTDFncmVIM2VVclRa?=
 =?utf-8?B?VE5LQ0tBcXMrKzF0cDBvVmlHQTJwQW9YRk9nTEEzOXFwdFd2QTZoc2w4YXFV?=
 =?utf-8?B?QUFLdEdHWGRNNXFlc3pEQmN4UE5YNU41QkR3OHAvekI4Y3dZNFdWTGxxNGs5?=
 =?utf-8?B?TzdpOXFZVk9kK1BONm9XeTNHVEpWY09WTFp4UFZjMGp4YlVYUTVwUHVTaEp5?=
 =?utf-8?B?Q0VNTnNaY2hsK29XcmZxVCtHR1JURlVhMkxRWW1YUHpjWkRTOTY5eWZFRFFZ?=
 =?utf-8?B?MDRIWVUwR2xvcUJoclJzbTFzRXVIZkYzVGVtc2tnOFQ3anQyZEZuMzIrMVl6?=
 =?utf-8?B?dmVWZEdWdGF4L1NwOTRwWE1pTThDSVZ1cytDaU9BdXBLcDR1eEovZVREZFdN?=
 =?utf-8?B?NDFxWHdVWHJDTUsvSEYzRUxQQTBoN3FPWUovQ3BXN1lXNFVpTmFkWHRHN0ox?=
 =?utf-8?B?N1dIMU1PWHhMa0hlc0l6d0djNHY1cUpEd2pkRnhTRTdJMjJaZXVIcTQ1SXVN?=
 =?utf-8?Q?2pGxSKU2NKg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhpRmhqTnh6Tk5WRjBMajBOdGw5ZjFMeCtFY2VVdWNGdzJ5K2dQZ1V1dVA3?=
 =?utf-8?B?VHlkOTlacWI2aTNISjRYWWo2cmltL0N6L2lSUk9ibFpPa1dyS0lXT3FpaXlR?=
 =?utf-8?B?aHIzV1N4NGNUczh2RXVrNlE4MXZUSlpUR0NGU0VDR2hZeGU1M2JPbXRzdnVr?=
 =?utf-8?B?UlpyYVZqWjBEV0tRRWErZ2ZLdDNtQjY0VEgvL21qUkc0bzFNcmNwODZoSW5q?=
 =?utf-8?B?dlh4VW5LcDVvM3NWQ1QzK3NwbkVabkJ4eDJxNHpFeXlJbm5LMDJVWTh6NVdX?=
 =?utf-8?B?NWZ4T3JCQThpT3I2NGdtc2NUQ21jUGkvYmRBSytFY0c4eE5YcGk5cVhVN2tH?=
 =?utf-8?B?TE11MWZlSGRnMHJ0UlBMY2xvZ1JSN2FJNEplUnIvaE5zY3huRllWanhpZFFK?=
 =?utf-8?B?QzROUVM1QWoxNjVqVGVwbzNkRG1DYUZ2cVkxaE9UOXRRK0dkaHFPYkVoMGNR?=
 =?utf-8?B?WElJYlAzTVprMldnSHdoVEVNdWswYk9scXVKU3B3WVZzenZNTjlUZkxXQWRM?=
 =?utf-8?B?YTdjWVpubWRrNm5MKzJFVDgxZm5ic3hJMEtJM1dFbkNwbXJxdzR2ZVhvTnNw?=
 =?utf-8?B?OGg5VEpSMEVKRStnc21uMC9XZk1TSWJCVVdVY21SZ2xVSk9tSWppWGdQOHdt?=
 =?utf-8?B?T1VzY3p0aUg2dTFKVEJadHF1RjNuS1ZkS0hweG0xQnArQk0yeDZmeXY0NjZx?=
 =?utf-8?B?N3IvSmQxYWI4NWVJQnBZNjhuaE53SmI4VXlJdzhZUlVuRzlsUUxoSDFWOXRV?=
 =?utf-8?B?cFdDN3M2S1Rya0JPNXBydjN5L1ppejBYeGpWc25SKzZVWjVraHZlK1czK2Jj?=
 =?utf-8?B?SVpxaW9TeUNvMkZZQ1BONVQ2UEttakpGd2x4OUlBSmE4Z2p6SDBZMEtWMjk4?=
 =?utf-8?B?Ym9MdngrSkZXZGtrMEJpaVA3MHRHMWhxYTBzNVh1TGcvUkhzd1FYeUhOUlVa?=
 =?utf-8?B?VkF4eDN5RGxKbWdRcE1mQ3hwd1I3Q01JN3l1Qy8vS3R3c0FGT2NCVTlsVE4r?=
 =?utf-8?B?OW5ZRFE3VGVMZCtqOHJXYkRmYzkvemppVTBxOVUraTNOYlhmQWUzbW05bmNj?=
 =?utf-8?B?Vk5WbTgwbnkyYmVhcnRCOUY5djdUMzNOanptZjloYTlvU1FoZC9HWDhYd2Ro?=
 =?utf-8?B?VzB3VkxRZG9CaDQ2K3YzU1ZsUjFaRVJjbVkrSGtrNTdHT0wzVUJTVUh0QlRH?=
 =?utf-8?B?SEk1SjBKenlYNVMxYVlIR1ZTZWhjZzkydWVJNGg5cERUb25zL3RrQWdmLzBH?=
 =?utf-8?B?L0tuWExRYmM4cmR2YWJ4L0pxRElMY1lITzFqT09UdkYrblhOV09Ock03WDY2?=
 =?utf-8?B?eHgxV0c4YktJbHdhYjVCTS9SOGFOd0NMQkxuV0czUzlDR25vcm9MT2NEcEJt?=
 =?utf-8?B?ZHpkS3lMdHE0Sk5tK2tVaHRGZElhZTc2eVc1UFZEcFI3d25vOWF4aFV5UVZR?=
 =?utf-8?B?VzMwRERPNjU5T2Q3eTljTys1NmhGVTRwODFsMXFMR2ZjMXYzTUo1YTZnOHgz?=
 =?utf-8?B?TnZ2OXVjVmRQOCtlM0hyNTlVS2xkK3N5VXVhSENGZStSNUNGVnkxdW9MMHdi?=
 =?utf-8?B?bXVVRFQ1Z0JkSGh0TkM1RGFsWUVlempldXdDRU40ZTRRTVZaTk1vK0k0S2ww?=
 =?utf-8?B?R2FDblg2MzAyL1JQVG9WanRicS9paFJFTExtWEVLczNsVWprdDNlbVVFbmpY?=
 =?utf-8?B?RjRzMDE1RmtzOUJJeGpwRi9JTVVSTUVRRnV1Tno4Zm9vdllYaTkyT2hjZHRO?=
 =?utf-8?B?a2VGSkJlVHF0a1drK2N5RTRBaUJDQ3l6ZkRWT0lrTlRTZW9OVVJXbmgrLzQ1?=
 =?utf-8?B?VHkrdEM0dzJGRGMxRE1MbHJOcWxrQWRFTTlTSVpuNmxXdWxSM2wvZDdEYnRR?=
 =?utf-8?B?anV5U1dzS2NyTFNjTkpQQUZjdUVybzF4RUMwVmNidmRWRlE0NGtuWDRvVjdi?=
 =?utf-8?B?L0oxMkZjZFMvSTJlcG5qT2R3V3VZQmttOUZvZlZaOVdpaFV0WGM2bm5CTWZ2?=
 =?utf-8?B?V2ptNWNDM1VhQmxtSEd0RG5iT2pQclA3NUlhZm83TVU0dVhzTm9Wb1BJZ3p2?=
 =?utf-8?B?UUtHTEpWdGpLVE9VQzdHeTNibXQxUGRmTWV2c1pYYk5OTEtrS3hOWkorRzMz?=
 =?utf-8?B?UmYrVDRUd2lKL2p5VDBwdFU2ZXo4a1J0WHhPd09pSFdCdytRZnVOczlGL1dC?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7dab61-2d4d-4b43-a5fe-08dd9ec98673
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 15:57:34.2044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3T7BCGQVU0ay8AmxiMQLR2C5VwRu18Nj5dbEQubsJZQSSQQcAT25tCqnIp5RvTb1C6cNJcptNckhBIsn/MY6+JeO5Euw2s2NUf0i1LsIKv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
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

On 5/26/2025 4:52 PM, Stephen Hemminger wrote:
> On Fri, 23 May 2025 11:36:04 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> Most testpmd help strings are lower case. Amend those that aren't.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> Why does DPDK not follow the convention used for years by the Unix
> man pages and commands? The Unix command description style is to use
> upper case for items in command that are variables.
> 
> 	.help_str = "port PORT_ID enable|disable COUNTER_NAME",
> 
> These strings should match what is in the documentation for examples.
> 
> $ ls --help
> Usage: ls [OPTION]... [FILE]...
> ...
>    -F, --classify[=WHEN]      append indicator (one of */=>@|) to entries WHEN
>        --file-type            likewise, except do not append '*'
>        --format=WORD          across,horizontal (-x), commas (-m), long (-l),
>                               single-column (-1), verbose (-l), vertical (-C)

With respect, this is an entirely different issue that we can address 
separately, that has nothing whatsoever to do with this patchset. The 
only reason I adjusted these strings is because their inconsistent 
casing was screwing up the ordering because strcmp is case sensitive, 
and this patch addresses that issue. After this patch, whatever their 
specific flavor of wrongness, at least strings are consistent and order 
themselves correctly.

I can submit further reworks on this front, but it will have to be a 
separate patchset.

-- 
Thanks,
Anatoly
