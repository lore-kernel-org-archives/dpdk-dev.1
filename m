Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468A6CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:10:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6253440262;
	Fri, 29 May 2026 17:10:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B64F64021E
 for <dev@dpdk.org>; Fri, 29 May 2026 17:10:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780067428; x=1811603428;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ScOgvFqnlthzFzKvl+DsqBaP0B/DOOHsLE4rFNdCxcw=;
 b=kZ2h5CFoND6C2T8E02XR01fwETlJ0uvZjAdsEj2rpJJiaV4S5QgkxE+C
 7F5kwF+eqhib+JXt/D62hPJqbbLexlSpY2VuglI7jJfus8gN0nz7Ufi2w
 Y+5SFnptgiOWNWcWATPcb8+KLLaJy+Bylk6q3W2BOdZbAFpTK03gGkXT8
 SIm9hEgG3eViEnYWqVBsympNeHui4JzzQiIGhIR/lclzZ7PHfScD9h5jf
 YntHYYjVRexghETiJrsRDmaP/qU9YXT5Wdia6599nK7XvcPp4Dyq+ePgU
 xlPiEgrT3kPzyrjp4RjtvHfj7E1coOExE26kDoVvQLCe1dkmMzW5k02eL Q==;
X-CSE-ConnectionGUID: /5OpIXbWR2u3TfsoYZ6HRA==
X-CSE-MsgGUID: hmx1QBZrTgCe9qd/CXa6pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="98337306"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="98337306"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:10:26 -0700
X-CSE-ConnectionGUID: kqht4+PiTV200HKnzpR/nA==
X-CSE-MsgGUID: st7PeO2jS063LQckQ3P8fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="266501678"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:10:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:10:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 08:10:24 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:10:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/v9jcBTCLvDGTyZ5mqqSWe7Eno5v8rVEr8ImTA0tx3f6d2Np12ma3alWGdLojNqkNbVoV7kusKRDOBsho5slAB+KCSjWxvBcjRleN99C3553Bl2iQI0BSQAAfvbSM5YbOcTsoT8E/UgOx4xYnNRiJqSnrqUsi2zS3kUlTzaAPB5v4mPXEi4qwQBVwUSIBmzBYTMqvvZdcpvTCqmIVJmsxVZMF7+ABJvPbPCTNC6TK38cNafOyqK8x7ubLXdFftou9SEbq2EmBJOl9DbKxnbuGmIJfmepLTVYGAdQO26nQtwbGAX2vSoOOud431KQA7wJLt7dz5aGkiYgwNaYjiScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO1o1Gtr81J0wLGgwhaQ+GvliVLYcxKy6J1+51kLW10=;
 b=s4h431pRSyCkU2MyqAcUHTRCeoQ+QksKU3/asiyPIgKvLcfJljs+628Tsr4NzYn7TGIoO3echUlH7BsnZ7yeqYkhbW0m3FPsgpStG2sLzzBzm3ZdLl/80dHZfqLU6nn7HveDkhLnj0+T8cb584B06MlmL/g2P8bKwe1yyobQmnrVCoOkl4Obxaua+AaPCtWp+STybzG4WuPKjAMlIcE/xbLpUm1+5y/o5ErOb3bQyRz08+Ilw0Zw0U7RDhU1vGezes/xX34fEEwhthTml+1bSs8SUFsYUYXlKiqDvuLgVn9GAueMXvDwa4MajuCdl/SZ5yY10/Vk+ZM2uJKvZxiAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA4PR11MB9277.namprd11.prod.outlook.com (2603:10b6:208:55d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 15:10:22 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 15:10:22 +0000
Message-ID: <6549b404-6c05-4abb-8978-f84d50511038@intel.com>
Date: Fri, 29 May 2026 17:10:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] eal: fix async IPC resource leaks on partial
 failure
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Jianfeng Tan <jianfeng.tan@intel.com>
References: <af8325076295d7f5400d6ff19451ea54828b63e9.1773936429.git.anatoly.burakov@intel.com>
 <3K0aB9xhSMWITv5e_T4_Ig@monjalon.net>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <3K0aB9xhSMWITv5e_T4_Ig@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0027.eurprd06.prod.outlook.com (2603:10a6:8:1::40)
 To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA4PR11MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 522266b4-2b51-4ff9-2020-08debd946741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: X2XV64wzhXDVK59ZataAfytrbksAREgtg324s5/Tg+rK+IVsDuoc/VmezvzYQaohv6/XeHn1Md4JnNz8164fqC6tELFdwwHsofSojos8nJ2jQYNFrlBURj4J/9uTgFpWyrSiNrcvd7Jds6PommwdvHWVWmd0H9SJQtRdry41aeJ5rXabZHsbQUowu7xzJVuBGz6uEBg6lvYIEpRqAUGdyj8xyT9MeHe9ZIyR+4J8ZnBcoiCeRFZQzK28HZopyMOlrw+wT59wH3KPy55ncfJ0PBjwsy/8U7IwtoycO/uZS3NKtU8wIso++b+N6TlJqFXePCx6eWuCUwMpsUAwKWa/A9c/X+E8RkwwPyL38UOIBkjgjLXL1D6cJXsNQtf9ZnkszOzQAUp3gi9DHsIYpycojM834SJ18zxNzmME+O1jzBXWv1MLqoqxyG+dLc+EvGIWNx1Pgj9MIOr0RXtBpQIT9Aapnq8cWm0vdRuGE1St89bznGBkMNfaQH2JXPHxh8YbOWxVodFjJh+c5rPy1dAQn0JsQuA1cc9CBrg0Of2X2Wbk/nNBayORt3C/Z3ZQPHgLaXLcRu/RC6n1bCMMqPVuSARY9MUueyd2Al6wzhHDvDFDEpdHz9m0GYq9uOv0uLDk4RqwE7JADoV1l6nSiq+OZef6UaN8/D5T6AqFU3+6TbncChMg/sLH6v20KX+Qgy4p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1AzZGFkSStncUtqSTQvNDc4aEZNU3BxUFpmLzg0L2NEL3BURTF5THNXdDQy?=
 =?utf-8?B?VXhmRTVuUUJUZWtpRmVTcG0xM3kzc0h0ZXJoUjNaSm9iQnU1SjAycE9US3dU?=
 =?utf-8?B?cktBZXRabVY3cjNHbC9TcEVNOXNreFpUOGpFbERLU0FQMEtMOFRQN3VzZ1pE?=
 =?utf-8?B?bjdrekRQMU51cnd1RnBjZG1oVVVnalJSNERCRHVWb2RTcFVZMHJPWHVxY0JQ?=
 =?utf-8?B?ZnBqeXVJb0U3N0pUTXcwTk5UdkRpdHgzMkNIMHFNQzNxb29XTHVWemFpTnF6?=
 =?utf-8?B?Nm9vWFQxa3ZWblgvVmJrL2dQVzJWUFd3Y3ZoWTcvMzY3Z0Z5ZzFZZDY0eFFL?=
 =?utf-8?B?ak5xRXNjU0lsT0d3NmtpRXZ5dWVkekd0R21mSVpRNWtDSG1reU5sRWI4dGto?=
 =?utf-8?B?dHJjU1VKaW9valB6Rkp2TTdJaUNlNmpiRXd6NWFGWUJxc0JMamt0QTRnMjJo?=
 =?utf-8?B?ZjhVNW8vY2JTcENPdC9lNlJ4Y2VHNXpENDFVWTM2OFE3K2NNNVBkL3d0K0Mv?=
 =?utf-8?B?Z0tjalRoQ2VXcXBNNWZYREFINXVLUVpkRHp0VmlsbEtmdHpmUG9ocnBkWUlT?=
 =?utf-8?B?a0NhOTVWc0VEL09SVGZ4cUJGQzlCZFU1M1ZYTVJ3QjAzbDhNMHdBR3ZxOFBK?=
 =?utf-8?B?M2xtemc0dU9UUFU2Y1JDMVM4SWEzeDV4Mk1qUjR5TlgyeGZBN3VNZ0JvM3hO?=
 =?utf-8?B?VE5DNDI4YWl4VW1KRFlUMC9GRkpTZTlHbGtKeExxRWhNS0d4RGlVYWtyckc4?=
 =?utf-8?B?SzJNb0tjMVZvMlYveHhVc2NZYjRaN2ZFQlk1QWVadlVRSDJVSmJwSmlYdlBu?=
 =?utf-8?B?MHlEalI4cXIwSS9rTDNQTnlQcUY0RWhLcjFCbHUyYUIyZ0YrUldUcG50dVRP?=
 =?utf-8?B?a0Mzb0FXaEF6N1oreWxzNVBONFRJMVVEWmROVGlENkVCS1drTUN5U3dtbk9q?=
 =?utf-8?B?V0poaFNDZHViSDc2WU5pV2huRlhZN0ZSNFNpNzFLd2JULzRWcVBFV1lTbmpa?=
 =?utf-8?B?c2NTWXRLbGlTU0hIbFNKdDJzT1dTczVtNUQvR3YzMFdSRStMRWhGd0Y0cHZJ?=
 =?utf-8?B?VWYrUGU0eVBOamZ6TnRKTWFLOThmZkcyUkV3cTkrVzZ3NDNYTm95Mmpzc0pz?=
 =?utf-8?B?OVgwek9ZT1JMRjZyRmlleTMrTDg0b3B2ek43V0tXbmFIRWFUdko3NU1SdUJo?=
 =?utf-8?B?MUgvc2lmWndhWHAwY0tTUm5YR0Y4S0FIU2krbG9hV2RoaHhXVERKUm4veHRr?=
 =?utf-8?B?R3dLUDVxNnpFNDFabzk5Y2xsSE9EelpIbmE5c1BicDdaVGxjYjE3eWZwWGh4?=
 =?utf-8?B?UzI4Qkw5QzJYWURrL1NQTHdtSzdZNGhxbldEWmxONXVqVHNzY2Y1MFdoNzlC?=
 =?utf-8?B?VkxpUGovMVRRaVZjcCt2UzZGbllIU3JVTk4vWEN4eHRBVDE2aWRKeVRnL0RB?=
 =?utf-8?B?RDhTQmJ5L0h5RENFZWhIcVByNEF5VUwvTEVNV1h1a0Y2UTBGaW51UlhpR3Fo?=
 =?utf-8?B?V3BTeURrSmRxUGt6YTZvR0VObmpqcjRHbndmbTBUR0F0K0d6UEZYNGVnaXpz?=
 =?utf-8?B?R1FubVdjRjJTbjZrbE13cy80MTk2L0RlcFJrL0ZDSmtlMTkrcHVvYzAxWkZa?=
 =?utf-8?B?MFJrOHBFSnR5NkxvSnB3VXcrRDBZckd3ZTJLK0RXa3NoM2tRNC9aamZZYzkv?=
 =?utf-8?B?REdXeVNHQVBKWXJUY3IzREN1Q0lsVnIvU1pJQ2xEdlBCZHl5Ulp1Z0RBcTZj?=
 =?utf-8?B?aExzbTJINytUMTZyaytQTEJlSVkxeElPOGk1V1p5RlVjdm05VlFoV3RlWmhs?=
 =?utf-8?B?SmxIbE9vUTJjNVFDMGNWTHp2c1psL296Z3ZYVDlpZ3A4T2J4YzIxU0JIb2hL?=
 =?utf-8?B?bGZtZURWV3lkS3h3c3hiYURqTmhiVy9ESWpWUm1NVFd0UnRZLzd4NnlYaVh2?=
 =?utf-8?B?VTMxSitvNUhFTFhvTS9WZUs2d0dxUGhuZnAxSVRKcDByc0psc0RxdFJFbUFC?=
 =?utf-8?B?UU1jTXhZL1d0SXVBS1FCaFlVdW50VXF3bDQ4ZDdxYjdNVDN0dGx5VFJXT2Zi?=
 =?utf-8?B?akhrK0UvaE9jVGp0WmEydk5vbWhNcCt4NlIrODF1UjBvZlFmaitQOWNkaWdk?=
 =?utf-8?B?UzhUZHJXT3hqRmVVemc0M2ZXb2QyUjNTdFVyMmdFcHpzS0ZTRThGeVZaME5W?=
 =?utf-8?B?R1hJTk9rTkN3U2NkSUtSN1dzSGo1ODJsaHV0YWpzTzYwaFlBS1VGRU90NUdV?=
 =?utf-8?B?bVp1dStOK1JTcjFNSFNjTnFqVSsyem9nQlVrTk82SG0rVEVyemVVVkJkbUpD?=
 =?utf-8?B?Z25qaDVid1pjU1Z6MEc2QUcxK2hKRVoybTdHNGdLMlZISzEvRk5iWmlEb2RT?=
 =?utf-8?Q?Y6XUsVmvkOmYQGx8=3D?=
X-Exchange-RoutingPolicyChecked: cPKFupYFH1f4hZuRhWZZp4qLEMbpJ2Q5XtrQFCttnvHj4KbSgteRVsruKve1H0CuH6ocp4CpRvKT4aStHjwk3F3M7u8YjvchgQApPJ0X899b6MI6k0LNRnkZoPfSxrVdnU5Fo+4RV0trZF68oetbReyNRd2+Sfo6HuEl973VtQRaa0nEtZyNryZeLpyhMKnT9GDtQmIC8YTDAfZvNpZ5/8JJ6O8NglhNfc9QhStRT3YPcSEQq1YJgic89EUdw2Y7GfnX3TG9H7DJFc2f3JuZ9209aLpQWBt4uc7gZ0CCsJGmFEBcDId7NKfSgbPImE2YZsy/lMN11YMxGIerRvflyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 522266b4-2b51-4ff9-2020-08debd946741
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:10:22.0390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbJmwXW5VvQcCLxD0m6LX4AdOOtYxnxwe/e1qcTX5sS6sej6WdFD78VQ/qicsXnr9sEKIZNk8Qrm9G6AtKZZMvKboiagXuFCRjw1mTMWyP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9277
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

On 5/28/2026 4:24 PM, Thomas Monjalon wrote:
> Hello Anatoly,
> 
> 19/03/2026 17:07, Anatoly Burakov:
>> Use a numeric request ID for alarm callback lookup so stale callbacks
>> from rolled-back requests become harmless no-ops.
> 
> It seems you forgot to convert 2 calls to rte_eal_alarm_set().
> 
> [...]
>>   struct pending_request {
>>   	TAILQ_ENTRY(pending_request) next;
>> +	unsigned long id;
> [...]
>> +static struct pending_request *
>> +find_pending_request_by_id(unsigned long id)
>> +{
>> +	struct pending_request *r;
>> +
>> +	TAILQ_FOREACH(r, &pending_requests.requests, next) {
>> +		if (r->id == id)
>> +			return r;
>> +	}
>> +
>> +	return NULL;
>> +}
> [...]
>>   async_reply_handle(void *arg)
>>   {
>>   	struct pending_request *req;
>> +	/* alarm arg carries the request ID packed into a void * via uintptr_t */
> 
> No, that's wrong.
> The pointer passed in some rte_eal_alarm_set() from patch 2
> is a struct pending_request.
> 
>> +	unsigned long id = (uintptr_t)arg;
> 
> Either you get the id field from arg,
> or you pass dummy->id to rte_eal_alarm_set().

The intent was to do the latter, good catch. Thanks!

> 
>>   	pthread_mutex_lock(&pending_requests.lock);
>> -	req = async_reply_handle_thread_unsafe(arg);
>> +	req = find_pending_request_by_id(id);
>> +	if (req != NULL)
>> +		req = async_reply_handle_thread_unsafe(req);
>>   	pthread_mutex_unlock(&pending_requests.lock);
> 
> 
> 


-- 
Thanks,
Anatoly
