Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FBBC3ABBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 11:07:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A45984025D;
	Wed,  7 May 2025 13:07:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8960B4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 13:07:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746616022; x=1778152022;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=UxzHbyeewuBgZbReGz8hNfbj8xOpopUYAiXsQZQ9VB0=;
 b=C8hnvHYSa0aVzHseQPhUxlnbjP3Go+RD9wOwLCuGub/IUVdn3diFtYIm
 DT6Amo2fxy59ZdXpAGSbKVN0R6zVAzyIzYo/5LZbQb/wU9yumpGtPI8Z/
 TWEcBGljiMUNRIZg2jkkDPC6+5yPd56iG+VrULIsoKFXXP+dQUw13ZXPS
 pl0sQoqPHbzrJjQ+DNcc1dq3OtiPtMdR/ewQCGR2srLWsAtZVe2meOdGv
 hLmk0KEvxwT2Y0i7J1aa3JjMfTbfwMWgPDd+Y1dG+CGx28kU/38lhNIsz
 gj/E+doOXStuyuOsh2hencVnE643GZ8yBHOWhZTVHRWaNkg3J87PCYhN8 Q==;
X-CSE-ConnectionGUID: kMCY+zCJS1GKVZOhs1324A==
X-CSE-MsgGUID: kPRrhcujSJSbCopUX3ttJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="50985597"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="50985597"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 04:07:01 -0700
X-CSE-ConnectionGUID: PdC3kVmQQPuPXHgL0AxSCA==
X-CSE-MsgGUID: YAYF+3fZSSmqdov8ZM9lJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="136439621"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 04:07:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 04:07:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 04:07:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 04:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua2/ioDZVq9IYeFIH4hfUKvU72iPLfuivcAauG22YoNfUA0SToomg1JQyP7wVd0mbWHZ872Q5DmUuwpKrZcSYi0aOUb9Vp+5D1KyMI3bhpGbm2T2njlWzL128lSDVEtl+jGGcBEWPXsCN3acqjSij8ueE1tS9m4n/GC1qrvhi6CUN8cLXQAwrBhBXJvDkx5BMO97g0TURjdDjoApiqOxmgW3GjDfup0KilaCG3BI0lXAtGFzun32/RvgR3sJ0q9U1fdeuWEZe/iywzR6su6s1eODY0qGfDP6gb0/wGyjPuOxKz9PtdjzHKqaoPa1VYlI4EN/uN2mpi3G2/SMbK71xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y8kGzVPHqKIeAmiXvBsnyD19JLswsGDpHWFM/OMmmc=;
 b=Fe4rOxYT3ffDEYQMH6Xd5PIAXzydGpB8uMY2n7BCenMhCydZludEeII3hrOplCdEKqNrGTOWBMuCIbpRnAptba6CJSUlp5Bu8LMuNdVkaLDJfrBdBVsBbQiWdoIRdSzKgpMCK6ypUJFZT4U/1WUeCgBtV5PLV46AHMW0bpUFEjwALGqPPxkTM8OGhRH9wyuTd/yxIn/7K+DPV7aPewzjcDv2nEQS4Fk+kYR3jND2pHXQ0aYgWt1V3gQxSOh8fZYH7SnS/FhwfI9CbIhzlNqFzVhEmXK5VVzgzFrAjqRcQA4PmImuTSdtKFK3a/8NNChBZGQtJ3t8G1tJY9O5xACs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.36; Wed, 7 May
 2025 11:06:54 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Wed, 7 May 2025
 11:06:54 +0000
Message-ID: <142c9203-11ee-4310-adfc-7657fc8e224d@intel.com>
Date: Wed, 7 May 2025 13:06:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cmdline: add floating point support
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <e8234c26b5dd91aaa9e7b1e38887b1d6fdb2d053.1746612074.git.anatoly.burakov@intel.com>
 <73248ba4775b4b95b117890851b8257e@huawei.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <73248ba4775b4b95b117890851b8257e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0279.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::28) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: 2919d671-6563-49b9-40c0-08dd8d574671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTYyblRjOHVKQkxyOFlEWG9FSUhuL2o0VkFIVE1namdCWEozNWdCQ1l0eUg3?=
 =?utf-8?B?VlFyTE9qblJYOVQrcVdCc1RkTkJRVnZkZHRCMklXY0lYZkpjV3c4R3oyWjJT?=
 =?utf-8?B?YWFlVTZwVFdXRVFjRUJyZmt1VVdXWEExcGE0QXdQZHZSUXN6Q0xBUXJLdGNi?=
 =?utf-8?B?SmVwWUUyNXN6RlZaNnQ4dXRSRFlhWFZqR0Y2a1VEZHU4SWNtd3NOV0pIZURY?=
 =?utf-8?B?WFJrdVdzMU1PZGxJd1dIbFVmNUcxWkF3SU1zRnpmQTJhZDFNQXFKQlhvVkFM?=
 =?utf-8?B?TXpSU1hzNTU2ZUlWbkVtS0E1U2pjaVlvdzNiRktBSjArakM3RXg0TkVON2tq?=
 =?utf-8?B?RVdzV3lGRnhsVGQvME5XdlFnU3pCVDdkcDR4cEVtUEpiYXRHZkdsWjB3LytJ?=
 =?utf-8?B?R1R1bk1PWTdEUXl3MTg4b1poRHFJSHRIK0ZhbTBoYW96L3I4OTZaVjBUZWxT?=
 =?utf-8?B?OWdEeG5ET1ZDait1ay9kRHBsZUlFRVhURCtGRXNTaXpGODdURmZrcHFXb290?=
 =?utf-8?B?WmtxWTBZanFOUXR3TEp3WnhZT01ubnZ5eUJuWnc5MGtaQld4ZVEzQSttYk9P?=
 =?utf-8?B?azNMRU54Y29VUncxWjNmeHZIQUQ2QUFmMHZXK2krQ0RVMFVvTUNaZ2xlTlNh?=
 =?utf-8?B?bnVRNlB0M2NQM1R3RUtlNVpybTdmaWZXNkI0WjFnbzlxaEF5RnU1TFN5WVFt?=
 =?utf-8?B?c2dYQ09ObjNBei9qNWF3UlVBSUVOdklVVlRKd1BLeE8wWFJCREVEMTNpL0k3?=
 =?utf-8?B?eXRZU2cxcGRtYjZWNjE2QUxCQlRwSHQxeUN3VGROdEd5TE1LdnNDZml6L3hE?=
 =?utf-8?B?cDBSQ3VJY0k0Vll2SExxcUlYRmNBdFVYY0w1UTd6dE1vZDRjR04xNlBxQVFJ?=
 =?utf-8?B?NVplMDVhWmNBeWQzMjQ2UU5yVEN0UlBYYkx6bFROVU5ETFlQd0djSG9CYkI0?=
 =?utf-8?B?c1FoaytjRzRJdWNWVGhTOXNFMkFrOFlwM2JRaU1qS0pHM3gvdWhZTmF1TzJ0?=
 =?utf-8?B?YU5HTnN3LzU0QTRpem9VaUZDNUIxM3M0N2ZhRE1pNXJKWitzb2Z0VUtDU3FP?=
 =?utf-8?B?WFArOG1oNTBEcXBnZTZDMmE3a01UZGd5dXhjSkR2NklLU0dPd0x0QlRuR2NP?=
 =?utf-8?B?OFd4M00xYTVYVExmYklKZC9JYzRaMmt1UEV5a1dsWmlnYS9aNEN0SWNFM1dV?=
 =?utf-8?B?K1NEUWl5R2IvRU1NOVlsV1cvL3dtL0xpdUEzTzByRjVXN1ZodWo0ZWthaTZD?=
 =?utf-8?B?Mk5LRWF1cGtUTHc1MVdIUGR3K3FUUjFPbXN4LzlGMDB5ZTRvSUwwWURIWThS?=
 =?utf-8?B?YWlMdzlFZy8wZ09OZEJNS2VWa25sRVkrTnNzTlZrTDdMUUdlai95QXFuZ2JD?=
 =?utf-8?B?MzVZLzZDQmpSVStoOEoxQmRObEx0L3p0MWdHWm9SVDZ2bUFHazBWbGE1UDJ5?=
 =?utf-8?B?enovNWxOaW1oeEJNZkFvZGw5NlNuL28rNUJEZEVjMVVhazdKdU1waUpPMVY4?=
 =?utf-8?B?VHBqYU90dTBMNlhhN3lyNVIxMEVIcE1RV3VoSFhlWFhQQnpHdkVGMkxIME9j?=
 =?utf-8?B?WFY1aHkvQUFqRWtzZGVTZko2RnU0djg2SXhGK20rRy9yZWRWOGc0V1NKNXZR?=
 =?utf-8?B?Rk02VGIybGNNUVBRdnVsR2ptU0thYmVUNnN1a3ZKVTdCZ3paWDhJclFYTlJJ?=
 =?utf-8?B?YlIrT0JkTXJad1dKQzhmdGZ3d0dNVVpyaFdMMFg0VWlGZ1g2N2lST2M4dURS?=
 =?utf-8?B?TlFJMHl2b28xb210L21tUUg2ckcvZkxFVHlqQ2JodURSOVp0Ky96eWcySDlD?=
 =?utf-8?B?VWszY0VFSXhWVERrYVE2Y1BOTCtVMFdWblk1dy82R1dNQUtWVUw3YWY0UWFh?=
 =?utf-8?B?VGNBNWRKVGlLNUNhdkRydjJKQ0M1NUFoODJ6cEEvN0JrQlFpUVMvb2JQVEJW?=
 =?utf-8?Q?YFneYKtLC84=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkswd09sc3lwZk0rUy80dDR3OFRvOGloUkFkOWRrQXFNcDlKT3FGY3dLR2tV?=
 =?utf-8?B?YWFjVGNrU3VDNmtScCtPQWZPR1J6Yy91ZTFnOG9kcFo4aXZmN0Nwbjd5TnVP?=
 =?utf-8?B?UkR0dmhsY0NGenovKzdPaklQYlZYeE14NWtWakdHRlFFYWFRWEZMdDFFNmFR?=
 =?utf-8?B?UnUyQjZUK1JlQVQ2L1J4a3cwVzlWVW4zTWtCWlV5a3oxYTh4bncrZi91RU9T?=
 =?utf-8?B?YlVxY3FWRlpXbjc5a1JlcjVCbGY5eGE3Vjh1R2c3OTlSQlp0WTVPMGhFdTJR?=
 =?utf-8?B?U3ptMGVzUXJIcTBLMW9UYk92RWx3eVlaVWxlRndwazBGV1NvVmtLbnpPVFRt?=
 =?utf-8?B?WEQ5djczNHZCcGwwK0FWUGhuQWxWR04rWXFSTzBya1F1Z1VsNE5ZMElGck5W?=
 =?utf-8?B?QitHd1BlekpLQ0ZvNGhNdTUzM1VBQ0xGcHhxdjhYWUFvMVRlUTJqenlMSFZE?=
 =?utf-8?B?TzI5NEtuMUoxOVVlenVDL3p4cnpjYktPdks2NE8vOUtSdFVCNDdSOXJNaFQz?=
 =?utf-8?B?SWo3cVgrQWpMYVVNZmNwanllcTNTd2h4NTZiQVZrYVkxdS9qWDFlWlp3R1A1?=
 =?utf-8?B?cTRpWGczWkdJY1V6aVJrV1FWYkdCS0NSMFhRVXNLajJhaXlpYTNDK3MyTi9q?=
 =?utf-8?B?ZmVQYXdNNGM0L1FIbXU1aXZ1RXFyUGVHMUFpQy9xb3haNStZM09aZTJOazAw?=
 =?utf-8?B?cXJXZGJoS0hpOStHWmR6U2d5ZlNxVjE1QlhmKzhtVndwbFVyakxNTHVkQmlS?=
 =?utf-8?B?Q09tend1Ym55THRmWGtaeUFLK1U5UE1EeWFCdXhsd3ltaGc2cFNPdXNsUUtn?=
 =?utf-8?B?NjUyTTZSYm1SeEJjSzlpNURwREVqay9MY1VNbk1qQzJ2K3JTVEVKTU16NGVV?=
 =?utf-8?B?ZXp0OW1jWFhlVXBoS0VVK3NxOHNscEFnOXJZZktHaG95T2VpYjFVWm9YaTk0?=
 =?utf-8?B?K3d2UHp4TVE3Uk5rdk9jdVdBUk1yZm8wV2p5eWZnQkpSR1QzVHFmYUpFUHhD?=
 =?utf-8?B?M1hXM0VDRW9uQXFrR1d5cjlLZUQ1T3NtUzFMNW1sdnI3a3VOb2J6TVdOZmx1?=
 =?utf-8?B?VnlHdlltdTNmOUdqMUFib29ZQU5KcGVSaXNNNkxTc3dwOEVVcEU0MVZBY3dP?=
 =?utf-8?B?VTRKcHpxWmpOTTM0Y2xTWUlMbnJRRHlxWlQ5cnlJTXhWZHNtK21oWmtEVkJt?=
 =?utf-8?B?OXVFVkRzZ1ZZKzNyN1dsMzRmdjlhWUZhTzQyRnFiK3RWNjNKbGZ1M25XVWlM?=
 =?utf-8?B?TVgyYnpSaWxZMHdEVzR2eTRrVlY2T1dIbUUzWk80Y2ViT0dvZzlkbGY3bEdN?=
 =?utf-8?B?QnZnM1VEeUMwWnJwU05LaUJkUC90ck1FUUxHTXFFdk5uSmRtOXZpZEVtb1dB?=
 =?utf-8?B?UTYyemJCL1dmVDhFcFpiTjRIRE03UGRuSHc1bEc0SVNKYVRPa2QrOWR4UndN?=
 =?utf-8?B?NEpacTIzZXVVOTJybzhLbzB2TFhuQ0RsN1pjTnk4Y3F0S2JPYmRzcEpjSFlh?=
 =?utf-8?B?UHdYRzR4ajV2cHB2Ny81VmNQQ255b1F5YlBHRWxaWlJIZkdrUGhxT244TTdB?=
 =?utf-8?B?bkJxSDdUUmdTT2NscCttOEFEaWk4VEwrSUFLTTIvN0VEVzFsb25xNk9sTXI4?=
 =?utf-8?B?WXBnRkloaUVBNXIvYjdtdDFsZUFjb2YrNi9Pelo1d09qam1qaHpqTGViV2No?=
 =?utf-8?B?bTRpVTRtS3BzS0ZkNmxDTWI0REdvaC96NEZQcDVudjdwd2V5QS8wM3Bnck9V?=
 =?utf-8?B?WlpzcWN5L0dUUXczSEQ5T2ZFbUhrc3hrU2pyT0lWYTE4bVJBQUgzRlY1VHNW?=
 =?utf-8?B?Z2dydzVBSHBVMXNaNHVqRDdTb25XRkREOUs1ZmF5dWQ3c0RtYXVJNjFNeU43?=
 =?utf-8?B?aUx6YlRlQkVhS2lGNWRGemtSKy9hNE01Q0s3NnR4b01wdlM2Tk9wdWtMbVJZ?=
 =?utf-8?B?Mk9lRHllYUJtYlJxUzREdk9GYkdjZ0tlU1BmOE5DUUhUbERnZWVvVGtwWG15?=
 =?utf-8?B?YmdhV1hqQ0gyNVhSVDVwZS8rb1k0RjJ3a2trdmg2Y3hkUFNBeVQ2OFRSLyty?=
 =?utf-8?B?eCtUaEQ3c2tMaWxLcjVBd3FOb3gvdi92VjhqTWFtMVA5cGVxOXZ2ZDVzWnN6?=
 =?utf-8?B?YVZIOUh2VDVDb2JmZFVVakNrd3NmeTQ0YkJzVndpTUVLZUhNYlFCaWZOWXNt?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2919d671-6563-49b9-40c0-08dd8d574671
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:06:54.2223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWlZ+aBTPuctie50zkWXE5SNd0FNqUmWmHepFtZPvPvWIhAv+xzK2MHfRnjf9pbMj6KJY3lfrzV4735D37hrvqcKThY2i3ko82ydXs1WjoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
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

On 5/7/2025 12:35 PM, Konstantin Ananyev wrote:
> 
> 
>> Add support for parsing floating point numbers in cmdline library, as well
>> as unit tests for the new functionality. The parser supports single and
>> double precision floats, and will understand decimal fractions as well as
>> scientific notation.
> 
> There are standard functions for that: strtod/strtof - can't we simply use them?

I can ask the same question of the entire existence of this part of the 
library: there are strtoull-type functions that should be available to 
all targets, so if we're going to use them for floating point parsing, 
we might as well remove the number parsing part of the library entirely. 
Either way is fine by me.

-- 
Thanks,
Anatoly
