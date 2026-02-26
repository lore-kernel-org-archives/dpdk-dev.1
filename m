Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258A2FD8FD7
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:43:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 533CD40611;
	Thu, 26 Feb 2026 17:43:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id F3D54402E4;
 Thu, 26 Feb 2026 17:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772124217; x=1803660217;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KDQvuXo3J+MvOzJAZKo+PCWimeSgvbCrM/o7soRupSg=;
 b=ACfL3J/qQ3qpM6zbeedGUqbgxzW1Hd15ebOxKFa+iAKf4EJUC2fdXTaV
 4UJwn1CLDSx7pj9mjU+GhuQKyMAZrxM1SON+MmAEKNQeq7B1PD+BEBY7P
 ObNnwd9nQ7dd2JdEDjLMWl7YQeOzycN9JiC9evnaJItmOKQDdQmKuoinB
 fE+988gFuUaKQz++kFJIucrzBhROHniQQbpM/bG6UBRisopI0p3jA2N7V
 gY1rNyzh23hKRgsuVzCASD+0fQtPS6yIrzra4QnXR7D0lhW3Z6jKt/nDL
 jUfyKjY6X3tylVyeDU4X51Lc/oa+U5OjN41WMmQWkCJvSnFpdJPriLbCr A==;
X-CSE-ConnectionGUID: l4YUoGc0S++SIX283KiZRQ==
X-CSE-MsgGUID: y83a7R90QLW5IUUIc/EmJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="60765648"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="60765648"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:43:36 -0800
X-CSE-ConnectionGUID: xw59YYC4RSehw3DJKXdz4Q==
X-CSE-MsgGUID: cfmRT7VBSkG0dmzWa5r4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="221135170"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:43:36 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:43:35 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 08:43:35 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.39)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:43:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtIxajYVx1u5Guyp0M+oV/q3uhpfZA8rN7f8L5RyDMLR9GUB7legW79tzUW+5UOt6fnTTeuFA3N4Vf2kYygbR0UaIQlH+oxh5h1S7p6uS4J7Pla+OmTPS51t/p2tbJZsqgxWyFatWwRlLgbL6rd7vThJ6AcC+ltIJDzdPfYV/35THXSr95jaQGC7eXLHx4Mx6PiqliO8XBpjTwFo1qcsHeAoH/2lYHZMpatFfc8iAgiyZJH4ek+OqsYaU44U0QVHXO/ek6qCJsC036L+Z1t/j4XCZsqnXMrLWdXqNSEycrXDG13A5JzGzhH838+DHBfOOBwmPHk5cLfSFmyHIOvo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UhU92jwDwIHi0Yrk8br4kdIlZPHbGUzwaf5d32/daM=;
 b=IyRdSaW9+udVuCUG8s2Uvy6gkZIId8WS753pomIijvh2ip/Tn/31OhOtnLtmHVMgeogVwz3hJK63/5UAp9FbaxbsIPOS74U33O9Mrp7An9j1mDCKB72oNQ3iIdnbKh1JABPywKDQYPUSimltxFDITrnpuiTMP2eyufy7/m4HP/AxO627EggFkR9YB2Appj6i56DabNHeUX/+leEDnETcpkYnuYxvAzjWxUnlDeiZJ2ycSSDivpujigE0Bzxe6owqSxmBycnhJzc8oUKedeizI0PRCi+OcUizWlHRAur6dMsx0SOhFiaRCvgp98VZaETbuvQBNFU4AwM8ZYzokTz05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Thu, 26 Feb 2026 16:43:31 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:43:31 +0000
Message-ID: <b28a0e99-8642-499d-95a8-a6ed30f939d4@intel.com>
Date: Thu, 26 Feb 2026 16:43:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hash: fix pointer alignment
To: Marat Khalili <marat.khalili@huawei.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, Yipeng Wang <yipeng1.wang@intel.com>, "Sameh
 Gobriel" <sameh.gobriel@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Yerden Zhumabekov <e_zhumabekov@sts.kz>,
 "dev@dpdk.org" <dev@dpdk.org>
References: <20260226142206.860737-1-radu.nicolau@intel.com>
 <cc3138af2b6d4f4ebb806db04affd487@huawei.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <cc3138af2b6d4f4ebb806db04affd487@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::10) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|IA1PR11MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: befd8d43-cced-4d7c-2a93-08de75562c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: 03b0fmvsOgOk57VebNQQmHWSo8NRSKsGFCUUUdwPF3LJ5PS9jAIS7HG7CFkyClQJUgVe85NCWjbElXrmXSft9qRRHL99Q5/vLfTOwORgIKXlY98Z2kzWhLja2TT6brx68az0yWZjDjO1BjFbc/qM1qhI0sFykLZAHJ1Uk9NmT3So71cczzJE/jIwU0HboVIO4ZGPRPsLWlxwwKfny2QsF4YI43CwkF27Ubw5n9vWv8y9C9NFxaqVb2dJgyohu1BAYiAYBpTq8FaHPYNneSUtry7YCtjWhmi2fqw6Kybxu80lGOrLQXS12sxc5DMWuzGxUvVBkxeFLMUtrUNIIJExcoAJ2XtRP1wylDay4kOytltG9015lh6HcRVIHBMNuoAmk+fgjY2z0pYPE4DFAobCO2kAluZLdv88zbScuxSoWpQze16Y0EGsUi9ecaRSQVPPkBDx9Fys1+wGDu7xHFq5Pf+AGFXUb6yjSKhFLtMf7OxgV29u420P9WScSyw4Ms9kaljhKvBEFWf6g+4PyCljjdclG+7KvIMBwi8I7OekmYfgWhZrMHW40NrLs5A9w3kzxjXQM5VyM5QMWmK3x7Fqt8wHrSIbfSlF7c8QS1e/QIW/0bPCtrEDqaavIFkQuYOYK9gLEs0kloSRo2bLyhVRvfbXg+U7wzdgPIiVYnzNGkAEiEbYcsq4uy3nHbo+HNwB8hUWNeHyvysXvGzEThpb+yQx7NDbYnOcmyaNT2JzgFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFB6c0ZRR1dhbEMzY3krS3IyYWNOVnNqSklpNEh6Yy9xMWsxcVFRSzhJRkgx?=
 =?utf-8?B?YTJ6L1Y3bUNjMWJRbmxvc0M3ZWtZQ3NpZ1hvOFdtQUJVMVpmd00rMXFFaFJE?=
 =?utf-8?B?aFFMS3FZZ09uS3dXNUtOWHBiMXgvY3VuOG9qT0hZTjRpd2xweHpXMUlQRTFy?=
 =?utf-8?B?eGNLTmhxY0gwdzFUOHlmVkJCWUVGRllja0hGTCtmVUhValZYZW43dkoxMEtE?=
 =?utf-8?B?UnV0WlhkaTlDT09pVDl0Tm90amRjQkdpQkZjWkZ3STJtWHFvcFR5TFZ3dmxC?=
 =?utf-8?B?MmRsbiszTlE0SE9XZUlWUmxLcVhCTFNQSVg1bHBmblFzNGdwZ2FkZzhqVll6?=
 =?utf-8?B?SUI4aG9BUzRWMlU1VUwzQUdkeTVlOVlrc2dnT3NyR3lmK0c1ZUhJRk1sb3dv?=
 =?utf-8?B?eHRyK3lNdFZpSVdDS0R5ZSs5ZlVORzhWa1NoTUNFQ0ZESHlPQ0hQMjdXUm5J?=
 =?utf-8?B?TjJidW9aUE9tTDVuQTFKN25YY0NPZzVzNFRjenZJYWp5U2MvRDZnSEkyQzhK?=
 =?utf-8?B?REVwL0N0cEh1MHVHdnY5UnVidlluM3l1MVF1bEloRlRmRHFITFdqY3psNjlN?=
 =?utf-8?B?bXdUbjl0dXZ6dy9hS3pyU2NaRXNXYjdUUGo4U0w4MnZLUlQyNlNtSm5INjFp?=
 =?utf-8?B?Ym9EWGtKNmhYbXY0Tk1kcjg0RXJ2ZHRLZ2Flc2dLMkhwVVFoUkoveHFlVThR?=
 =?utf-8?B?YzlQdHBNQkVCcGUxZVhWNjl0L1BERSs1eFZBUFIvOVA2cDdITG1NZHlJZUpt?=
 =?utf-8?B?M0ZBWnRmVHpSUTJCTDhUdkpTbERGUzlXZEs0QURtUWdtVG0ydld6Z1JWQWVm?=
 =?utf-8?B?YXF3SVVMT3dCa3FDemZRbUNsSzBPNFJRNmZrVE9YdmZzZExHWEVvZ0daV1Vj?=
 =?utf-8?B?N2U1c3ZKSXF2YSszRExFSVdiRWhtMllER0ZQUjE2NEIyYTZBSm50WUk3SHd3?=
 =?utf-8?B?V0pQVzFEb2xGbFYvaG1oZHNLSUVhU01yMElWYkE4dDk3M1BUKy9TQ0t1QUk5?=
 =?utf-8?B?R056TU5KV1paMFZSN2VyejZwUHRlU1ljekJLTk95VmdGczZVMVdwbm1ZK2VG?=
 =?utf-8?B?UG1jd056UXgzbE9HSWh0d1hMbzF4aHg2clVaWTVGV1lkcWFFUjZLTHhZQXA3?=
 =?utf-8?B?Q3Vwakw0eW84ZDROeGRWUW1VQzlpeE9mQmtJSm5uQjZWd1dDMVNadTdTZHNu?=
 =?utf-8?B?amRMNjhaN0x6SFg4WXRiSlB3RWtkczFiNUc5WVkwNlh1N2tmUS9sTXpRRE9Z?=
 =?utf-8?B?RHFwOXBmMUZIb3BGUnBXT29sOVVDOXVLZ1Uvc2RmUEkrTnUyem1yaFo0V0Zl?=
 =?utf-8?B?N2ExMjEwZDNYcEtLWkRZOHcrS0FqRGdYNlZyTkcvL1BUSjlsNXovdUVQRDJs?=
 =?utf-8?B?aGx4ODhUODZmK1lVNlNkSUNZQlBMYlBOcStjOExteVFnN3dpRHUyb1E1N2hJ?=
 =?utf-8?B?ajkybU9CaXExWmRmdURlL2xXV3ptYityR1pTNi92aUVJcFZFcUNRMHN0MW96?=
 =?utf-8?B?S2E2S2ExRFgvMVNCZjNiemNuaTFFZ0R1dCtxS3AzWGRDQWpIYkphWFp4QXFD?=
 =?utf-8?B?M2VjT3dObzk5cHhIdTA2WGNHNmxNcG1sYXZVQmlTY0VpYy9xQWFKZFZpaktH?=
 =?utf-8?B?NW1VL3JEeHlheHBFMzlTK1Iwc3hnWjRWQ25LaUlGMURXaXZrMDd6Slh1TktO?=
 =?utf-8?B?Q1BhZVhaVXh5YXlCZE1jUDdaS0lwRTRLRWFnWmJZc0RhK0psQ3BQQU8vUHRI?=
 =?utf-8?B?UnV1SjgrTnFGdkhMWnJBVlhrWFJWdlVTUUZUUVZtL3NuVmZrY3QwRDJ4UjhS?=
 =?utf-8?B?U1dLUVRiNnpOR0l6aTkvTDQyZXgyWURFVHdITS9qb2J2T2NUZUNXUDIwN3hZ?=
 =?utf-8?B?RTNwNU04K0dKQjNKQm0rZkh1WEV1MklKVEx1amtjL3pNVlNpK1hSM1UvcmZD?=
 =?utf-8?B?cml4QXJjV1JSdC9UazVDSTlibENvblY0U2hRSVNtL09QcnYrOFprUlhUekhu?=
 =?utf-8?B?bHNaOUM4LzRsV29JSVJtdXpDdFB6TklNVDIxUFRwVzZWaDR1ellkVU5hNmI1?=
 =?utf-8?B?cjE5UVE5MENQVmltVjhHaDk4WGJrcE9wRy9YNHZOMEsyK3pPbmI4UEhWRmdh?=
 =?utf-8?B?VVZvbGVuU2Exa2hzdi81eDB4UXlQSXVNbnRPc0hWV0VjRE9kNWxKU3F2a3hX?=
 =?utf-8?B?azhHRXp6ckdMN0JUZWV5SFRFeTdiUWZkUEo3NUNMMmUvWTBFSXNmeGFoSkky?=
 =?utf-8?B?d1pKaW5nT2xsQnJ6VTl2cG82QlgzTXBkaktTWFV3YkEzOW9ENGo3aDY2dWcz?=
 =?utf-8?B?N0lrcW94WnBDZm4wdFNXU2xJVDJDQ2xUS2o3aHdYOGlhTnpzUitsZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: befd8d43-cced-4d7c-2a93-08de75562c62
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:43:30.9626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZQ1AUSym7XrJpBSFQe0oDwt5XAqsB4qrOyCHRFLc0iQh/Z0BIAYVvBQMhTymDfoVFRvJseZAD1yepO8mc7WeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
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


On 26-Feb-26 4:22 PM, Marat Khalili wrote:
>> diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
>> index fa07c97685..66f11fafcd 100644
>> --- a/lib/hash/rte_hash_crc.h
>> +++ b/lib/hash/rte_hash_crc.h
>> @@ -127,6 +127,24 @@ rte_hash_crc(const void *data, uint32_t data_len, uint32_t init_val)
>>   	unsigned i;
>>   	uintptr_t pd = (uintptr_t) data;
>>
>> +	/* align input to 8 byte boundary if needed */
>> +	if ((pd & 0x7) && data_len >= 8) {
> Perhaps the case data_len < 8 should also be included, with each of the if's below checking and correcting data_len individually?

No need to include this case; if data_len < 8 it will skip the for loop 
and fall through those 3 if's, and get processed there.


>
>> +		uintptr_t unaligned_bytes = 8 - (pd & 0x7);
>> +		data_len -= unaligned_bytes;
>> +		if (unaligned_bytes & 0x4) {
>> +			init_val = rte_hash_crc_4byte(*(const uint32_t *)pd, init_val);
>> +			pd += 4;
>> +		}
>> +		if (unaligned_bytes & 0x2) {
>> +			init_val = rte_hash_crc_2byte(*(const uint16_t *)pd, init_val);
>> +			pd += 2;
>> +		}
>> +		if (unaligned_bytes & 0x1) {
>> +			init_val = rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
>> +			pd += 1;
>> +		}
> Shouldn't the order be the opposite?
As long as we process the right number of bytes the order doesn't matter.
>
>> +	}
>> +
>>   	for (i = 0; i < data_len / 8; i++) {
>>   		init_val = rte_hash_crc_8byte(*(const uint64_t *)pd, init_val);
>>   		pd += 8;
>> --
>> 2.52.0
