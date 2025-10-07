Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9337ACCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 12:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEF0D402DD;
	Tue,  7 Oct 2025 14:47:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9D9204013F
 for <dev@dpdk.org>; Tue,  7 Oct 2025 14:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759841229; x=1791377229;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=cqk/crYK8fz8aT8EYYS4bEfAY3Nk86lbW6jtBRXeJfg=;
 b=ZdR4AQJK3kzzvKCMNHKlw3Jk+Yx/+s+OAe9dFMuUX4WgCl+NMJ/YQnRX
 +eQuaCCDAJipWsfKZCh8VKbJaBAauGIs3UfDXFQcnGZprEx9VJFLfWcYO
 wDhK610y80AOCMdo9+rg5pi12gqL7TUkoQfPkuAyQr0sw5LwtsKYOj37E
 ndKc6/1vs9bor45Z/5PgjpKj0B705ZzxLUYHN5j70cRMTindjAnQr+TQX
 JsNLp2Z4m839R3SDDOTvRoOf/AkSA6WMcrSgQye1MuDwlen8ayWtJKmyQ
 UYUwg9K17dN/LKG0L43W7tF3r6ZkXLs8XS9o+yMV4nFbINc4YLCZyhHW/ Q==;
X-CSE-ConnectionGUID: 1DGs0aSvTZ6Zhgr+EN/+cA==
X-CSE-MsgGUID: 0fCrPCIqTB+anuSeeZPTtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72696570"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="72696570"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 05:47:08 -0700
X-CSE-ConnectionGUID: LgjINr7LRSSygM2PipGp1A==
X-CSE-MsgGUID: Vjh6w50sQaai+R/fV8bmlg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 05:47:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 05:47:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 05:47:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 05:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y32EOOtTZ8AKv0ZP81nXzBW/t9nHgfXs1wWz8bq5vWrq5uaqwvCxu4YMrBvybQoWkC9i1Oin3RIDyH956Gg8+wZo8MMNexOy9RC3XN2vZthihJnMq83DwwfdiDJGTbC6yuG7BWGgC5TlHrxPVmntvn6aCFuOs562Ycc+iqYoQr2J9o4DbEPVAsLA/V5Q8InEQFz9m9aVuwb7/zcr/S5jWyyDYulB70wZOYvO50tBj2XrfN9+mQS0BjQsdGSUY65lbkloKUQ6aI5HY3TixCfOYHs/EXPy3ozh+jL9cLOdJAaWEbkRUuYjdb2i4GyrG+tixyT+QP4L8xPRNkuQJa62ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVu8OYku9AJSQgFUXku1j+LhP2vCh4ZVfDNoM9hka50=;
 b=auanUL2AYYEtZYHsTTDGfv8xQv4RYn0pzC1Ofofk0jzy+Gg54wdkvilYwsmGWecj/WKkdyUccLjiR+Jbwvn/OW4JbF3OqScNDE1rZ2HRslEo5Ty34xmGJPUIEkDVMZzIWVj0uZZf27XSXCY+RRnofvbNRETlgQQFT3mAjMof1kEefbFoBpEgtwMQh8Z8eWX8sx8sLP23J2Y5RY+zmghai8yzZsO6LxCTACY6qwW1pDOOjBTaRwDyzTc/LHoaY0prE1M18cibEI9Luvt0cVBqxdR/9bXSvjPGJkUqb0K6jX3w9D/TL46JRQSTwnMuo/RwHQJobKAGw264xUTdSCyUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH0PR11MB5281.namprd11.prod.outlook.com (2603:10b6:610:bc::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.18; Tue, 7 Oct 2025 12:47:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 12:47:03 +0000
Message-ID: <d3f25952-7ab8-401d-8543-c6edaeeccb9f@intel.com>
Date: Tue, 7 Oct 2025 14:46:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/idpf: correct the enum constant name typo
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20251007040436.2924355-1-shaiq.wani@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20251007040436.2924355-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::27) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH0PR11MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: e97cd867-47d0-4e4b-d8b4-08de059f9c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzRBRlAzdk80b3AwMm1FbEtySmtYNHJ3SmVUb0VJRjAybWhjOVBKZjV4WDQ2?=
 =?utf-8?B?bzI4L1krbDluL2NEREZHRjluQ3NhZUQySjZsaldmOStMR09WT0NwOWlnSk1X?=
 =?utf-8?B?MU9acWgySnc5TVNVTzBXbUk3dUVCQS9aOVFoUjBDWmVGbzRtWFVsMFpNZzl1?=
 =?utf-8?B?SFpIUmR4Rnp2aDYzZG84NmlqM3BERm1Jb1U5TjVTQ3oxYVBPYXFrR1VxbThP?=
 =?utf-8?B?TVdTY2xiWWVrMGN2R2VLdHJEVzFZd29CejR2bllPODR1SVhScFBBYlN6OE96?=
 =?utf-8?B?NVVTNXNaL3BscFM3TVg4YmtOTHh6eENlMUJqekFkUWdxaklvM3NTNEtldUFB?=
 =?utf-8?B?ajBzSytkQ2JkU2pudFNENUNyOHlKUlBLTkRHc2tEVDhWYzg1Ui9ONmlYc1VT?=
 =?utf-8?B?cTUzUEhxQWkrUEZUc1hGOTFob2pqVFRRL2FWTXloWDNwQjMrWUMvUlRTTU5v?=
 =?utf-8?B?VXcxQkxjb3NLd0pkcGNQUWdyeis2MkdLeDNOamYraGd4eDE3blRESWFCNm1v?=
 =?utf-8?B?QW9rWEErTHptRGg5cHlOV2xBd1A3eGR4LzJmSHhKTFdXd3Zwc2grRGYvUjds?=
 =?utf-8?B?dkx0Um9EZmR1N2l6Y2Zrc2dlSElPVytWTmRCZHd4ME1ROXVHYThPekQzU25V?=
 =?utf-8?B?TXJhRVV0Y0hJbWdMVG85V1VnWVBmd0FmSnd4Z3k3Wmd2WUZGV3VGWU5QcWhu?=
 =?utf-8?B?ekQ2elRiMlVqNERtQktMVkNLN0h5eTEyUEs4dEl0RWJTeE1pc0R1SktZOXU0?=
 =?utf-8?B?SldnOGVJYmpCN20xNXBHNEpIQk0zbUY1YUZaeUluR1FUeE13VjFYNlJ0Y2lR?=
 =?utf-8?B?d0RCL2xwY3FIY2diYXZDVGdiUHN3UEkxUUMyQTR2WlJIL0VzY1BpRCttcnVz?=
 =?utf-8?B?QnUyZlBDOHVMQzBGbysxdlF0dk1raFY1aE5IL2RUSGFMRGQ0REIyK3A2c1ZH?=
 =?utf-8?B?bUR2TXRWYnlDT0NKWTJrazk3WDl4UDFQT2tLQWRBODFDSEdxWjd5VStBREY2?=
 =?utf-8?B?THcvczFRQkNCTWhkd0xPMmZnUyswVHprb2lVelcybnJXOER5bVczcGkxL0JW?=
 =?utf-8?B?UEI1SjRCb2IwcjhWbFNoOWR2MktaSWg1STJCbHgyeVZZYmZucEROTlA4M042?=
 =?utf-8?B?OFFIUlF2VzNyWXViSlBlcVUyYVdzM1h3TDZ6b081YjkwTnZwbERQSWNBZk04?=
 =?utf-8?B?WDFSc3BUQW9GS1Zvb3lEdFZOSVhaTlAySVo4WlVFZCtGTEZlQjlWbWZNa1VE?=
 =?utf-8?B?MVBqL25rVzdKZVJuQUpEUmNCL3FjUWZVVGJEVDRXRjc1UHRvdFpGY2U3V1VB?=
 =?utf-8?B?RjA3M2txV2lRZzhnb0FwL2xYQW5DTzJKTmxoRU9XaUJmTTZEWkZyUDhIcTZI?=
 =?utf-8?B?cWVlbjhocGlwVWpUa3hqYkgxdUpXdXRRaFZsY2d4Q3hSYXVhMURLaSsyaFcy?=
 =?utf-8?B?ZGNTSCtzWm1FTUovN0tiUnJCR0N2cWFRYUFKdTJqck1uaDJHS1NGcDdxVHpQ?=
 =?utf-8?B?cFMyem0rdFN5OGFqVi9UczgrSmlkZXM5Sk9HMktKRGd2cnZROFQxNjEyczFT?=
 =?utf-8?B?SDdoamZwcVRDSzhKTjlyajQ5ZngvSTZ6amQ4aXJkR0hQd255NjRtSmdNVVQv?=
 =?utf-8?B?bzZqL3MvdlhOVWQ1S2hiQUtQNXJ5b3lHci8rLzAyQlkvSEFFNHJOaU1iSWV1?=
 =?utf-8?B?MEJWMUJzWmhqeFBBVU8yVVdEVUNlZlE2c1R5MFZDVmdkQ0JidTZlSkNRTVVL?=
 =?utf-8?B?R0p3RXJuaExqWWhMbzZaUklEQzNubmtvSTF3dGZEWnF5Q2c5OWM5ZFhaNXBP?=
 =?utf-8?B?NEtMK2pDTzBzK0RZY1pRWDRwUEw1REVidm4vK3JQTkREUktqbmdaMm4rT3dZ?=
 =?utf-8?B?ZFJPZWlvdS9remJoR1Jod1RyRnp5eHQrWnp6alJnSnVTcndQTGRlRFFwbU9q?=
 =?utf-8?Q?YVKVmpXVp1OcMcrgUqJSF2TtSjybgALf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdRc3lnVUs1UzB4blJMRU5Zamo3bW1mdndqTzlZYmZ6eVF5M3laTXVkTGtX?=
 =?utf-8?B?dDdINThHcDVJMENXVnNDYWp1WFBzUzFLdGdpNVQ0L01GdUxZTEhGSGFmQnRw?=
 =?utf-8?B?Mnd5R29uSUlBMVhFK2hyVUdWUmZZaG1BVFFhSGgreGdDZ3RJUElyV05Gdnhi?=
 =?utf-8?B?TlpzMFc0bHYrR0J5WkRHUGljK21tS3pJZGsyS0JtQlJOS0htdUFIUnpMcmNN?=
 =?utf-8?B?OUdSU3R5RncrMXhQWmRERVV1eE00Wlc5ODZGeEg5TjdhVG5HM0ZWZy9ZV1hm?=
 =?utf-8?B?UjlFcHc5alJvZWhQRi90VGhBaHpsMTlacFIrV3NnM3V3MUgwRFJLejJkSGJY?=
 =?utf-8?B?enZaaFZ4NXowRUVMY0NhcjMzSWh1WXVubHUvTVlLd2ExcFVVUGJjT1hWSDdQ?=
 =?utf-8?B?U2N3VEFVcnBubUg4MkRvVG9HaVRObTlVYndkY3g0bTFYVkUxak5OY25NNWdy?=
 =?utf-8?B?NUZhRWt1aU5Qa1JweHJVNWZXNE5kTnQzQkJUZVFrd3pkWkxQejlUMEJRLzFa?=
 =?utf-8?B?SFl1R1RmS0tULzR2NmxTblovZmNlcmwvZmRYR0RVSUJuL1VVNGxRcGo0b2Nj?=
 =?utf-8?B?c3I3bFVjdXllRC9DNUY1UXBTU1BaZmhZcVJrV2RCZmdMaUtqWlNZRzlPMm5N?=
 =?utf-8?B?K0tQSms0MFd2a3RkUG56SW5adWJqNzdQV0tLL1FFcG1YL002NGl0WnNIZGpZ?=
 =?utf-8?B?cUd1bm80dUsyNXdLZFNDOGNsSkxCV2Y3bk4xcXlQZWZibzFYd20vRmlkam5N?=
 =?utf-8?B?UWhFQ1JZUjZQbHAwR2lBbU12MFdKQWRhaVoyb0ZRT0JQNFkvdFV2QmFHTXd3?=
 =?utf-8?B?REhiZW95WEErcHEvNjc5MGIxZ1AvQUlPVDNjbFBPNDVZRGcyMmhZNFRsOU9u?=
 =?utf-8?B?VzRZR1B4SmRtZG05VVY3eDh6M1VKVHdpZlBvdjc3V1Y5cVZuNVo2bU1LOWVO?=
 =?utf-8?B?N1dHYkNtdzByc3QyUUdCeU15YVdUZnNIUDl5S0I1YVJNcVcrQ3k3L1pzNk5m?=
 =?utf-8?B?OWNuS21MUXhTVjYxVGZjSzlZVlp2TCtjNVJoTFZocU5sNlU5ayt3cFRPSEhX?=
 =?utf-8?B?ekNRN1V0K044TmlLSnZKcXMvMi9VMGorc0dFU2plNWxjOGI4OXY4c1MvMzJY?=
 =?utf-8?B?akNVcExXTDMyVXVNSzFWZGZ3dDg4MkdlMFRyV0IwMkNJMDBubzVrSzdOVERh?=
 =?utf-8?B?QWhvRyt1N2FKRTk3VlpkTk1jbENKWXdhdURLM1BhZVZmNnA3eWl4a2lSTVFD?=
 =?utf-8?B?SGNIUWh0QUp6SVdHU3VuL1MxeFRJTDhRek1ZbDNqc0NyckNtamJEdzcvUkgx?=
 =?utf-8?B?aGhrT2ZxVDFvaERpNEVQbVVBYkxUYlBmeG1DbmtGTUVlMGZKbkFKWkp5azdk?=
 =?utf-8?B?UU8xU3Y0VjhWMFV5SjNmNkVEbkJnaTZ3ZTBnalpyb21abXN0Y1VkaUJVM2x4?=
 =?utf-8?B?Q0FuaTRVSlQ0RnhUemJVemFmTzJVdjBiMFlFWElmK2pZUW91bUE1ZVBoOStD?=
 =?utf-8?B?T0h3YWNUdm1vZ3Q5bHBBcmhhZ3crQ2NrRDN2S0EvNjZiMkh0dXlPaFhIZVBX?=
 =?utf-8?B?MmFnbHJWbXMyY3dDcndxOUZKaStlOGVwN0J4N2ZNMVFRTW5naWw5cVNRUXNp?=
 =?utf-8?B?N3YranFlWHJ4UUhBeE11V1A3UmpIRnJDVlRwUzQzSTk5M01ld2xIMDNIVXRH?=
 =?utf-8?B?bXFYLzlmMWxaV2lsYTZkUDJ3aTQ5ZFdYekdmRk5TeGJwYlduSFZ2aCtJdW1o?=
 =?utf-8?B?TDIycG5Vc2h1aEtyai9UODUzekcyZkJ3UzRwUHdKcVpoQ2Z0YjdMK0hGVFQ1?=
 =?utf-8?B?MFBuNTAxbkVwTWFNclBnSFd2VGQwRmlZNDNFQjY1U2VkbFFaaU1URmZ0UGJX?=
 =?utf-8?B?U1ovRjdiMHJaVVNUZk84WmhDZEk1U0hkRkZoemRMOVRMRVozMk10S1JsNGtx?=
 =?utf-8?B?RC92bGpLQ0QrRFFIYXRpbkZRU0hwdGluNWc4bXlZS0ZLMjkvRWdjalk2YThL?=
 =?utf-8?B?b3ZHaXE1cmlocDNqaUdXSjhuZ0x0T29sc0JLMlpzT0FONEJvKytlWE9qVjI3?=
 =?utf-8?B?TjBDSmVzQUsxS2wzNUpxVjNQZmFkcmg4NzZrbllNZVRTQzF1T1RwbEd0ZVNz?=
 =?utf-8?B?M1ZDTmw4NERoUGVKVFFTM01BSGpGQ2pnNHdRSUZqUktoanowU3FnbERTUzlB?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e97cd867-47d0-4e4b-d8b4-08de059f9c9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 12:47:03.3505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PepE6GPlBavwtDBZSjGlR+9JzJLHmza6qv+cOrWMO+ZN9q5r/sKfIA236+KQf5O5jou6MIovqAWhq3YDh+WouyLQ8Ns7qhIeu4Mg88dGtSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5281
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

On 10/7/2025 6:04 AM, Shaiq Wani wrote:
> Correct the typo in the idpf_rx_func_type enum by renaming
> IDPF_RX_SINGLQ_AVX512 to IDPF_RX_SINGLEQ_AVX512 for consistency
> and improved readability.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
