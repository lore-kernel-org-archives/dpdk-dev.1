Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC4ECA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 09:30:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B894402BC;
	Wed,  3 Sep 2025 11:30:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4488240261
 for <dev@dpdk.org>; Wed,  3 Sep 2025 11:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756891804; x=1788427804;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RDAXKVwQVHU2hihru/iOhZ+iMGgvCl500k72sSjrMgY=;
 b=JRSbwT2q0fPXyuE1D8j1gf3VSQZYPLq7UKDRjTHounPwS1assiavVbsr
 iBNLE6KmOCF6NfnLl8HG2Jwpi3uqyvlWtLbhqMcYVGC8slG1wvDzdAy2E
 GCSPi8txLWVdY4db/xUbcHB/Hp5cP9KZ0t2EfLj7YWETTEkQaIrRTbgmw
 bmE/VIZw/laguNgGCpi8k+WZSjqTqLVeIrKJeo89pNFlzS+mccUCmc6Mc
 WQRPe4vkOGKLmaWgG9G5pBigg+7cZ1OQA9D8u0EBokMzpmQuDg57/SGoG
 8pX7WkxxhKxVOSLBfBK4ZzzqCaOfpjsy9/jEnyauMQa9EeieGHjlru8bG A==;
X-CSE-ConnectionGUID: 56AU1dYbTriCfd+EL5zX8g==
X-CSE-MsgGUID: jk/kKfYhT3qqcj2GZQ7hkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69901269"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69901269"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 02:30:03 -0700
X-CSE-ConnectionGUID: 0RFIyWhdSnGZxAewV9GX8A==
X-CSE-MsgGUID: v2cLqH6URcmPoUNqUutsag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="176823706"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 02:30:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 02:30:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 02:30:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 02:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVHWBzTLce6Ku//QPGHdkV77fFnYAkqrG5x3C+4XyWCLdxZP/K//DkTHzioa3TeYNdwYIFjsHtapVZLqkdxsnRluwiACynqYZ4DTYtkbjdJ4x3lyqpN9zI/nOdGG24/nj83xq2vc6qJlV5rW5yPXzEHM7zFdCIE1Rt1FlmM+J/V3Neqx5JpvaiXfl3ge2YUA3w9qyBfBi8fEK63jc8Mu09YOpIVkSy0XmkJGizS8dolHeIsHB3vWhf0YU7UFn9G5V5foLVH172mRpj4ZYXmbw0iBC4J8bK4U62m28Ro6IeJk44ECVr5AX5i/9vhIdVcP3aZOQIBsKaQyeC+6UFAy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF+BPjZgVpy5Eu7f65vG6HYs+cIz0k+PP4icJb7x/3I=;
 b=s+cLpazfcUbWz/Mf+OMQdkAYXKvcdyIQV5WQLZ79SMTJTg4QYlvetuiIs0keNQEh01dKIG2mXsoc0wYKSTCeUN0E4+5A6/ivlR+85pTKKbIgvJU0TixJjNovJRvBn4WbWTDZmsakoSQH7z65EDfWl9x4qiQdogDwE96Eau+UmQBi30Nv5DtEoWSEk7RBthPGVbb6tAfbIdvZmzhwrgJTHmXgJujHyfIVllnw9I5pPER5InuqXvVGFzLJga3Rzog7hlsC4pWMhlJtRHSHhZVLPnK3/UuRc1xjvXrLSR1Ll8JOLgUFLk3FVqHtE/c5iFs+zUpYZ1cZHV1API7tnO5wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:29:57 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:29:57 +0000
Message-ID: <e08e6b4d-737b-4254-b8a6-16613f67eab2@intel.com>
Date: Wed, 3 Sep 2025 11:29:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/8] Cleanup VFIO API and import Linux uAPI header
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <maxime.coquelin@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250903072826.1727004-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0198.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::23) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dde8756-ce38-4330-6f9c-08ddeacc728d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MCtoUDdZK2dvVDlvQXQ1a2N6Nk5EMFRVY3hGMWtlWFlvMWRZeWIrc2g1T2JK?=
 =?utf-8?B?NHpLaWFhc05wMTU0SUFVQUhkTFJjMGVTZlEvcVpnTENhTWM0Qk1UdWVLZmJl?=
 =?utf-8?B?NGxIRkF6RVIvZTI1ZUo1WWFZM3BYR015QjBxUmRBd3NnUFViT0hQeXBjOWVa?=
 =?utf-8?B?VkplRjI1T1JweHhrTCs0VmI1R051TjR5Nm50c2IyaXIzc0l4TDEySE96KzlG?=
 =?utf-8?B?VGlxaVcxOWhKQXJ1ZDRDQXVxaTFKa1huZnNxNXR5OGRXYzNLZjQySGNoV2tw?=
 =?utf-8?B?M3FOZ1U0cGdtRHJ2R1NZVmZLaTlRV2RCY3V6eWJQZWdWdElXdFI3TGtNWTlT?=
 =?utf-8?B?V3UrWFVQM1R6aHFXeHl2SUd1bjRYRHhvazJibkVET0RiUER0d1R6SnlmYlJp?=
 =?utf-8?B?eU93UThqM2EzK1B3eVZadnZ4VHdpNU1OQlN5dzg1N0N0Q2VOaXpneWJwKzA3?=
 =?utf-8?B?Sjd0REdBekU2dFpzOUI1bXc3em9nR0MwVDJocGVSSXZhbzZ6MmRrZkhxLzZT?=
 =?utf-8?B?WDc2VnFtdnd1eTIvTmV5bkJ6VnpRODk2aVZTMURoMlF1aXhTZ3J4ZWYxalI3?=
 =?utf-8?B?a1ZOYnhHcGZWd05ZMEtPL3RpUTlWemJpK1VDVUM1MjVhMkk0K2hvUlRlM2pw?=
 =?utf-8?B?ZmNKSVQxWk9DQ05PSU9KZFpRTENibW5md1QrUHFETW1RdGFWOGsvaU40YVRM?=
 =?utf-8?B?ZGtDSWVUd0RpMUx6bHN6cERlV0lLVnhocm0xbDBRNEkyamUwMEtUSlR4b3FO?=
 =?utf-8?B?UGFhNkxFNGRsZE1uMSs3b3ZjN0VFRFEya2FFaE5EdDdLSnNqdS91WjgvY0RB?=
 =?utf-8?B?MG1jbkxiV0ZXQklpeHUyVk5oTWFnT3RldE1PYVdqTEU5QnB1K2sreklLMHR3?=
 =?utf-8?B?N2NpYThsWmlDWHl2QXpwK3FWeE5TT2RDTFQreWtuRXc5dmFYMlRDT3hza0FB?=
 =?utf-8?B?K05IV2xvWGVRaGdOTEhhdUtlRFoxRDdzaURNcjJHWEhjSERIbG84bWE1R3NP?=
 =?utf-8?B?eFFPZUJpUDg4VkFGUmdPUVZzZGE3ZVpkeXdqTEFzNUx5UjJlN2lLcXdwRzR5?=
 =?utf-8?B?K3FDN2o0THVlazJVZzRHaTZ5TVBqUEtadzlJMnQ0eWFnSTdkTUlVSFhQRjJq?=
 =?utf-8?B?VmFCandKZGNwbjl1VEJXVHVCR2JxTGc2L3JxZWxndUFhLzJiV2trM0hXRTF4?=
 =?utf-8?B?aVVYU1hYSy9sYXlseVRwVk8xR3VQS2V6UlZrd0U4UTI0ZFQ3V1FjaWttdGt6?=
 =?utf-8?B?MXNxcHgxN1IwL01Vc2ZrNzFrVzM4aUxPUVU1VFQ0a2xUMk8wdjREcHBVbi8r?=
 =?utf-8?B?RmJBRjU3KzlHZzIxMktuUHFoeFJtTzlQbUc5dnA5dGx3cG1GVUtaNDBtcTZG?=
 =?utf-8?B?VEZxaTQ1Umd0NlJ0NUkzaEYzdXV1ZjdTM25KcW1OVmFhZy8vUDh2ZFR1TTRv?=
 =?utf-8?B?dy9NME9BcHlvWUtUT1d6bzcwdTBXOE82akFpSFFOL2pZTVhsenZpUmJkc1dh?=
 =?utf-8?B?ZmtIQjZZNTR2WlJwZkZ6RWR0djNVUEdmZnhhUkhmdENFMlJLSS95bGlnbFNw?=
 =?utf-8?B?d2t6WkFOZEFQZERwN09BK1lRR0NxanUxck5NaEdmaHUxM0txRzF6UW9jUmth?=
 =?utf-8?B?SnN3czJPK2E2bERoU2NTL2Y1bzJEaU0vbzlwQzh5VUlKNnVlYzBQWE1uSk1U?=
 =?utf-8?B?SFg1d3dGSFFPc3BxNVJvZkN2dVgzMVlZbk1IMUZHeDhwamk5MGxCS0ZjZXg3?=
 =?utf-8?B?WERBTE9GRXpLOHVWanQvY2VkdXhYNmF2ZHRWNWYrSWV1d2IyNWxseVhZTzBN?=
 =?utf-8?B?YS9wYzhnajJtdlBZUlhpYzBDWjlsck95NTBhZDZheitZZ0pVeXBhNUU0L2R0?=
 =?utf-8?B?ajlYcFFHakVBT3RQRmZScnBoamczcXkrZFAycG1FT3REYXQxVXRCVzJ5NnBK?=
 =?utf-8?Q?DJB2fBPd77Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVhaGhCTzJPV2h0QTFJQUpONzlPZy9pVlpvVm5LYVI0MFdGOHlKZmJwZVVq?=
 =?utf-8?B?ZW1DUjRWQVM3cVhPL1JhS3g4TnhjOHFaSjNGZnNKL1pnQUFXbEk2QVQxd0w5?=
 =?utf-8?B?U2tFN290WWNlNUFUV0M5U0VJd2svaTVFMXN2M1hPc2Qyak96OWRLZDVPbW05?=
 =?utf-8?B?YXV0c3JlaVpyVE5iTDR0ZDJsM2h2UVVlcHZXclFSTThGL00xWnloTXpySGR3?=
 =?utf-8?B?c0JrV2tCaEcyai9xdTFTNEJHZEFoVDNnUFUxeFNQVnJkOE9jMWpaeWFtWkc1?=
 =?utf-8?B?eEtmT2lsci9GUVNZa1IvcXRDeGIxeDZDeEZUMXlEdzV1bU5LbzI1SG9PUXdY?=
 =?utf-8?B?V2RkSitJWUVjZStPWFZSL2E1OThmOU1WQ09qL1Z2WmdrNWgwRkdnbWFRQUsz?=
 =?utf-8?B?L05SWE9vOW5JRnNWSTV4ZnVEdHVNNEpHL0ZWZzUvb0FkMmN1QXMwYnNmbVRD?=
 =?utf-8?B?STcwY3BHM0RSNDNOaEFyUG1IL0xhWDJhSDRERmg2RzlJeTU0TFJCWG90WTk3?=
 =?utf-8?B?ZnFER2ZlbUtZcDNOSndMUzNhYlA5WW1aS2hFUjJRbkRmMkRaSk5FaWJRTWxK?=
 =?utf-8?B?TXMxK3k3UHJZNFlSb2dhUGU2d3EvT3RkTEx5M1pWbG9wMVJtZ01HUE12VENB?=
 =?utf-8?B?dFdKYkE3Vm9HTEVFNWVJK3ZSanllY2lUMDlDWWpIemtibWNWMjRJOUxJbFZs?=
 =?utf-8?B?ZEJoTWYyMDVKYTNuRFg2anhHS1lVVWY4N3I0THVXRm05T3BOUFBGZ0xzZW5K?=
 =?utf-8?B?V2d3Z1FWM2dJNEtRdHBVbWlHNW51OHpOK3Bwc2ZYek5iZFdTa011WTYxbnRF?=
 =?utf-8?B?bTFpdmxFRXhXaVc5MXFLc3loaC9vZmg4aUNrRzZBNE12MWVWaURhWEFLRURj?=
 =?utf-8?B?YlJCSFh4eFBVRzdpeTRmSVgvTllrWDFaUUZOME04eVdYbDVyWmNHUEdJckh1?=
 =?utf-8?B?Tlh3ZDE0dUdOT0gzR0VkUmkrWW9SR0E1ODc4ZVFPaWFTUFN4ZU5ZVHgxbThS?=
 =?utf-8?B?RGdHcmZhRU9yQXoyeWVYL1dNZUJ6eTJsY05NWHkzL05IS0lWQkYrby9NV2or?=
 =?utf-8?B?eFNzemJFRzdQZkFkRmp3U2tQbjluUzhNeW9IaEtSOHhMSTN5YkN5YnRlL25X?=
 =?utf-8?B?ZE5IcVFvR1ZqcXJMbG8xYVRZSmpwK2FtaGRZOUlBdHhpYzRzRDlIdUY0SW5s?=
 =?utf-8?B?VEllZ3FBVDMwYlJxa1hkbEpRRTlCNlc5VUNqMjlHdG5tdzFPR3hmL2JtaFhw?=
 =?utf-8?B?V1JWNk5WRnFZUk82MW9PVnJpSGZvSUhJUWJ5U0hKa2R2VCtzRVVBWk4yZVh6?=
 =?utf-8?B?MEwybVBpUmtBM0xYVndmNXZ5T000QnN4V2RFTFpsV2pUUS81MWRFakRNdTRi?=
 =?utf-8?B?bHArSEgwM3JxcEgyVW54b3M4eXo3eHJGdWN2STJDQ0pXbkxPa0NSNWg3aUVv?=
 =?utf-8?B?dVJOcmhGclVLdm44SGZCaG5Mcmp6L3R1SkVyeUdITU9xRzB2M0QzRjlhcVdW?=
 =?utf-8?B?T1czN3J6TGlUN0huRkcyMDJmUG0rV3pITXp6c3JlaXFjVytaYzJlb2dycHN5?=
 =?utf-8?B?WDl2VjFoM3AzSWx2d3dwdHdUZm43U1Vtd1B6Qkl0TDRUQVRwVWgvSXI2RjQz?=
 =?utf-8?B?NmE1WG5GNStrWFg4Ymx6RG1TbnZ1eUlPNFRhbDZTTWdTTkxjY3g3a0pGWFlD?=
 =?utf-8?B?eFFzNlV1UkFMbThQZXNJUnNCMGNvUVpOK3I2Y01WdnljMTZRbGo3ZzIvTzht?=
 =?utf-8?B?TUR5OVBjK2QxdzVKQVFuS0ZoLzhQOWNVcVRtTVFwNFM5QUdZTzE1Z0pyeE83?=
 =?utf-8?B?dDhyR2RzVEFSMy9zdmpKeCtkczdlV1JMUWlJMG1DNXBJU3JQRTVwTVEya0dU?=
 =?utf-8?B?ck5lY1JiT2QyWnN3Ykl5UHpDcUtlK2pDckhHNzRQaG16c1kyT3VTRkZuUGNW?=
 =?utf-8?B?Yy96U0gyTXdNeEp5QTVRdUM3Q2Vvb1d4ZEg4TDgyTzd4cVJYL2dsUHRjcURU?=
 =?utf-8?B?MEVFcEp6ejVnT09wUXNVMjFERGdSTGdVdkFUTDY3cVM1SjdlVkIyZHZjQ1NE?=
 =?utf-8?B?QXJCS2ZYZzllMVdOTTk5clU0ck5BS3MrUDY5RldxTDNCWXFDS2o2eUlZTVIw?=
 =?utf-8?B?VEZ5dzVLRTlnR0Z3SkZPR1hnWVF5ZndZeEc3dFhGcld3YS82R2VlaHdmT1Vk?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dde8756-ce38-4330-6f9c-08ddeacc728d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:29:57.4340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuHA0b8ltHz29FkL2tYRQVyn0YS0jguNAFqvUMyMyc4dUskQK43o+LWs7ZkGpoOKoiBQ4v/1yjq1vjqfdZn/nSeCeNVeRhAJzV4uSrjGITs=
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

On 9/3/2025 9:28 AM, David Marchand wrote:
> The VFIO headers have a number of issues:
> - showing to the world a lot of internal considerations,
> - defining macros with the VFIO_ namespace (confusing, and a source of
>    conflicts with the VFIO official uAPI),
> - wrapping around VFIO uAPI in case the kernel headers do not contain the
>    expected API (putting the burden on DPDK developers to find the right
>    way to detect the presence of a VFIO feature),
> - (somehow related to the previous point) supporting old version of the
>    Linux kernel while DPDK now requires a v5.4 Linux kernel at least,
> 
> This series proposes to cleanup those headers by hiding as much as
> possible internal macros and structures, then removing the explicit
> inclusion of linux/vfio.h from rte_vfio.h (pushing this inclusion to the
> application which may want to do some funny stuff with VFIO and should
> already include this header on its own) and finally importing the VFIO
> uAPI header from Linux v6.15 for internal consumption by DPDK
> components.
> 
> 

I've been working on something like this myself, so it'll be interesting 
to compare notes! I too found that refactoring VFIO is a nightmare due 
to how much stuff is exposed to external headers.

-- 
Thanks,
Anatoly
