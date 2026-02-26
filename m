Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE27BFCE07B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1C48402E4;
	Thu, 26 Feb 2026 14:28:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id C549E4021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772112490; x=1803648490;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1SEA7eYSMj7v8YWHAh1eq8fUjYktV3t34OOeup7PLBg=;
 b=PqGUsJDJc0XmrnlCiEpCOeI7bQdSQAnmy80qs//RKqSQzu5UlhCGIbNB
 ljlUYj7NK/Dwmi5rdWSv4Zo5iyP+ESrZ3XhODSkBHugGctg7fGo628E6f
 Cig97hvlgdEaLYgtIbGrVY/jlwgwkADqoAUQfhIm73v/2YFJfVrsrZ+xJ
 7y9rHbwlkkQCMG3rO1Ryo67GM408yhSMlX2R/w+YSa6wRk/rV9UlgNVTy
 7lXLx39dLwE9QUqQfBUya/Ya5PEQpyk2ewlBEN9/ZChCzsPHiuX3Ab4em
 jAgfIF7SodV51PHZSOafzO2EkEO0zRFL7iMsEH9njJwSGtSnar/YTsK7l w==;
X-CSE-ConnectionGUID: oyuyz8ZtQgKqyp7olcbx/A==
X-CSE-MsgGUID: jRfA8fMNRHmv42k6QZRyCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="95788967"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="95788967"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 05:28:09 -0800
X-CSE-ConnectionGUID: FAfNvaWeR+KOgKhiXFfsrg==
X-CSE-MsgGUID: ue9PLpoaRk6kVmKO3O9dbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="239555902"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 05:28:08 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 05:28:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 05:28:08 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 05:28:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uouISsCdULkP+fAdeccc8jokFBqalzlldNDiZktO79+BpIdlBMX7cdM+Hie4ad5zkBZQY/Ss4Y+kvY+yphsOyWsTrAs9pm6vFUtwHcE7fxV9Z+0Q2kDEza0QGyPu3ue5Z5dcUtibLNsaqr6P6mcgGJ84YhVBs/lgd8gf+C/F0JtLg3uK5X1bnUV1bE/xqtufd4Qi2NdoAj6cv1rO/wmhU6SNP1YibaOtSFbUWChe93cVUETYQs1/j1e+htfPsXdEc4ifGnn4MAyNgcKEcCt7WEq2meLY05pg3Tkyft3b84OCBUg1VVd/m2briQ4Swn6Kbz3L5zOvuV8/0UiHIz1Aag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+Q3XFOF0RJIqJWAzf62jB9po/tHgjNvox+m8+7hqN8=;
 b=kbymOvHsZiCYQdBruJsYoMSL25wzuQJDT30KKivjBR8WbFXmjHAlhIimxuB/UgQfUPqe4iw0Bj3gQ0TI7yWtL/mcsMM6GQiWbN5GTlW9FqytEnntTgP+/0j5CjTA9tyAaa94sGa4c4oc/Fp96aGBbYRyoXmUtsM9wjCXe3LQsR6WkPzEPCJjh9rePIzjSMaUe00wLrGk9pRm9ZzkZ2dC+KA0HTtbB3hFQ0NVFks1XSnKiUeQQQHd0IZLGMa5JgBfrjRPgzEpzTgT9LolvRsoOh2EzjNGwRpQ6zNUsxbMMkU1qDWiYhbDzElGJzM18nIDkruWdxrPFRDx+0P62x20rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.15; Thu, 26 Feb 2026 13:28:05 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:28:05 +0000
Message-ID: <2723c0d2-c58b-483b-a5b4-7e2dcd15d3e0@intel.com>
Date: Thu, 26 Feb 2026 14:28:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] doc: add device hotplug documentation
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <7430d193b05505bbb51a508725fd6f671183e132.1772020302.git.anatoly.burakov@intel.com>
 <5906353fe6b1e388ce9bc44bf600bc94d2006e9d.1772020302.git.anatoly.burakov@intel.com>
 <20260225082525.5fc3e0a2@phoenix.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260225082525.5fc3e0a2@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0199.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW3PR11MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 097117d6-7727-490d-7f60-08de753adfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 7xLCCkiqUi0hqCSHk9GlyD6KufKtPJgRh2EzATQSq14Orno5JO65rwAOZG8TWLn4IOfcKWRICQuGyhtCDS/76Ayf2/EFUVq/Cll7w06akz9ooSEECpTzGxBzIRwPnOOWwRq9+4Ic4rNuXg2FNy4E2PKOXq80/k+qVz2FzRKIBBngXHdWT29RbdI9OL5I6txj01HVW0u1B370byOGR66yqYzX0zQVFYizxFny+AOSC+CdDo/pg6W/eQ3lQsu95BQc3W+pxM4Vnkii4HvlZWK6D9KTp32MtfZqpTuyGWKiAIcXfTYi0d3z2/3kGldeLLDle50xX2s2l7iMbRuE7mwq+eI1zfKcalCTbyIBZrp/6kop5CL4+D8qJanQkchlaPkt3rruOr8/KproTo1ugzuB00nz26J6I6P5dpehATFYaw5XI6z1zNqDaLqquK5hRAL7h2vqhUFJpk5Ll+vAI2UExGfzeP+rq2lpXE4sZ8Gz0HEt0zxZcvVCCFWhzZqAn7J76eeTc1zmaMF3NycsWLqRSvdt+OCDcmsiHkH+el1fZHumekn7hM8rEhyBieiIqxYo4dAVDAi8F1jH3dharoZQPM07qO2Hak+gdmJueBNipwqmEMX3sbg+oE13/EBnpV1T0JexO2HJuhbnqoGXmTDn30bu2E2Yo9NQvgiNTK8ngVSg27leOT7VNUyICeRxaXsCiwV0FKpO1sgZ4LyE5FPYeT8rJAUHZJXr1hIMqqwFIkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0Jhb2dXOUk0cnRxSHZxK0hyVmY5V25ESmRGQU9FNnQ0VFE3ekdKYXZWYkZl?=
 =?utf-8?B?T0ZPTEw3Q0taODk3TTZad2k1ZDJuN3dXTUtJdU94Wlh2L0RkMnhqemUrcDRI?=
 =?utf-8?B?bUYzZTNWdjhLVlVNN291MFZJUDZ5REdGZG9tTkZaMHpnZkF4eTJOQjJxSUN1?=
 =?utf-8?B?dy9mME9wZWNMYUdRYmM0ZzdmQmZyWHp6ZGt3ZVdqMDcwZ2Joamh2ZW5La2s5?=
 =?utf-8?B?bUdaR1lVRVRXZUs3ZVRUUlM1U01sTThNTkRIMXhsalYzY3FhSmNFemNXRjZN?=
 =?utf-8?B?ZmtEcTE4RUxtL2lCYkxmWXEwQ3ErMTliU3p0aFVBTzUvTWJPNDRLVlJSbFlI?=
 =?utf-8?B?SmtYMzFhNUFjbGljWEtyV2tGcVhvbTN5eW90Rnp3YzdSSk1qYXkrRFNZMmZX?=
 =?utf-8?B?aDB1OW5mK091TGZFUngvc2hsZUdzb1VNQVNVTzRiNCtYVEZaWTErSUwxTVlp?=
 =?utf-8?B?VUw4TUw1N1ZQMHFQK3VuSDJLbzdPajJ3Mkp6OHVPcmI5bDYxS2I2QUVPRi9s?=
 =?utf-8?B?aXQ3S0Y0K2lTSE05T1RHdmF3N09Tem1oU2VqS28wZ2pwbG5BdFJYUzBHYnVh?=
 =?utf-8?B?dWhHeWliZXlCMjBoMTdUYTNWNUdkclZBaUJqUFpjV1EveUNmT3dpK25hQXVk?=
 =?utf-8?B?b00vajFlVlRwdVZXMC9ONUdhemxUNm1PM1h1c2FXVFJNME5Wa3VMVEVkbGtU?=
 =?utf-8?B?T24vQmowaHlZdUpGMDVQS3loR0ZPQ21odkJmK3NseE9Pd1FBWitNOHdySjE2?=
 =?utf-8?B?WWhzV0dIQkdlQ2hZMk9rMVhmeU5TR2V2OThQQnhTdXA2ZW1uY3RkeWV4UTND?=
 =?utf-8?B?WXJHTkg1K1ZXRjlGUHMzckJ4WWdja3M5cUFzZkNKS09GRWxOajFDSVczbVkw?=
 =?utf-8?B?VXVhNG1vK1kyeTlZTU40ZDZFK2trV3EzSExoWjRPUUR4bFF0Z3gyOGxzTFFq?=
 =?utf-8?B?L3Btbm5NM2NST29vU1FGeEp0N21XU0dJYk5XSnQ1NDBaQ0syK2ZETU5tVUdR?=
 =?utf-8?B?L2xEYW00QWEwVTU5YjNadlBMUG50dGVUWkZCdFI2SjVXc21HeFpGU2VDZjF5?=
 =?utf-8?B?M3pUelNvTzV3Uk5jM1A0Rzl5TUdSNnlISkp2VnZPdkppQmdOTDB4Vll2Rk5N?=
 =?utf-8?B?N1dFdUlIdHl0UzFPcTE4WTBBdnN1clp4dldtVzZVc0lPUTRRVzlQSTVhKzJi?=
 =?utf-8?B?bzRuQStaYnlnb0hLZ1hxRGw4dE9tSW9RaEJRU3FxUjVIZXZES0VQaDNrZi84?=
 =?utf-8?B?ZUJ5NjdoVUxHbCtSbjQwcGpqMnoxWGxjb3REYTBxaEV0Z0dHYnVFMkN3MStu?=
 =?utf-8?B?VGViekkxVTVxTjNXbmlvRGYwSDRrM09seTFYaU0wTnpaSzEwek9TcHFTODdh?=
 =?utf-8?B?SW5WQ1IzcDZjVllpVFNtd2YxUnFMRlArWWlyNVZIdG5vZ3lqYmV4Mk1zc1Jm?=
 =?utf-8?B?dXlJeXJCTzczeGpQY0lSeUYvUC9sVkxPWXdNYnU3SzRLRTJBWDZpUjhpdnp2?=
 =?utf-8?B?QXpoZlUzRWp5RWlwMW1kTVZpd3JCODQ1Nm5SQzlOeGg4cVlvU2dnem5Xa3Va?=
 =?utf-8?B?Y2UxNkxiQVBqcExpL0tUQk9PdGZFYitqSVczNE43aHk0YWVUOGYwb0ZFQldE?=
 =?utf-8?B?d1hrZDZQaEJHMTlhL1NTTm45elphUlV1T2MzYmQ0TnplL0pad2N2N1hUMkNm?=
 =?utf-8?B?OU5LamVBRi9RdDRBZDF2VFlKQ2lXL3JBN2xoeFJwb0FNdzVNRWxza1VaSTdq?=
 =?utf-8?B?bTFmdUxYMVJpbHVzTE5rTFA0RUV1RjRtb3RFT1dXeWkxeEk2T0krUnpLTGwv?=
 =?utf-8?B?TDIxMXdsbytJVVhuM3NwM1ZRcTZraWZMVjVEQWloTCtJR3E2eGRuVHJkc3ky?=
 =?utf-8?B?eHc0VVQ5NmRnQVpmeDFwUUp1YjlxeWprY2hDQjJHZXdFMEZyeEQ4WnppWkdw?=
 =?utf-8?B?QTExU0piQlF4RVRZTmg3L0JlSXdJeHNodXhYUXljZkY5clF2eUpyeE5CQkQv?=
 =?utf-8?B?K05MRFNOVno1bS9TSzNFOE5FRFJFTHlyTjdheExaTW50b0FNWHlobGUzNWxB?=
 =?utf-8?B?QTg0Tm5Gd2lGTXNuRzlORXpsQU1oM2FhcFFmODhmeldlc0hqY2xrUFZXK1lv?=
 =?utf-8?B?bDc0Qi9YYWR0b0pCbDJSVFF1RkFxeTV3WHFKWTI2WHEzRG1EVnVoVnNSbFAw?=
 =?utf-8?B?Y2JmWWptdDRkN3dHRFJKKzlDR2FzSm4xSEF5T3VLalFOcHRLVlVVMjYybnRC?=
 =?utf-8?B?R1ZUMFU1eW1SalNId0M5K2hvVEVOMFNtWkJ0cEtRYWFlV1FIQXBsbGlzSk9I?=
 =?utf-8?B?Y1d0YWIxc0RCQ3RFS3pSalVhZTMrWTVJbnE3emhWckpWeEVnOU9mN0ZNWHhs?=
 =?utf-8?Q?vLzTIZt5TvQ0vHzM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 097117d6-7727-490d-7f60-08de753adfb7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:28:05.6672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IUEsbdM+Ou6rfZksrYUbNL/9Eo2H5G5CdVg2KZI7IzjWKvtgbX5If3oxn0e0F/bsDYGBtjJC+npaTlM5PxK74Iy/G4njIwvJ+4lTr3rIgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
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

On 2/25/2026 5:25 PM, Stephen Hemminger wrote:
> On Wed, 25 Feb 2026 11:52:25 +0000
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> Currently, device hotplug is not documented except in API headers. Add
>> documentation for device hotplug, both for user facing side of it, and a
>> high level overview of its internal workings.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>
>> Notes:
>>      v2:
>>      - Removed "summary" section
>>
>>   doc/guides/prog_guide/dev_args.rst       |   3 +
>>   doc/guides/prog_guide/device_hotplug.rst | 286 +++++++++++++++++++++++
>>   doc/guides/prog_guide/index.rst          |   1 +
>>   3 files changed, 290 insertions(+)
>>   create mode 100644 doc/guides/prog_guide/device_hotplug.rst
> 
> 
> This is great to see. It would be the flow from kernel to udev/systemd was explained.

Strictly speaking this isn't DPDK scope, but I've added it to v4 anyway.

> If I remember right, mlx does this through another IB mechanism.
> Also mention this is Linux only.
> 

In the spirit of using AI for everything, since I have no idea how mlx 
works, I've offloaded writing this section to AI :P

-- 
Thanks,
Anatoly
