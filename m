Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B9C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C7F440684;
	Sat, 19 Sep 2026 18:09:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id E5E7040272
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834186; x=1821370186;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=nhaq1oz7KQvQDeP69JlCrF/GDDrD+mpRZ9hTn3dl0l0=;
 b=LnQqoF7zRdOI2fH1EBM5Eey+9HaHre23eLH1kBsbDEKICsgGywAi6pGd
 3o5xgb2yk/tjVhPgZgR7Y3KZKEZ8IrUGTo6HSW3G6f+9fE5egfId/GAvj
 nHhjWemiEfBgZdMFD88YecM6rQUgj1Mi+32T+2XJT24b5OD/TJiFjDFcI
 UEVtoky3Eux7Tp5E+GoqfDZcyW4Dqx8+oO2BdqMT8j/2AT/F38WqdXBS0
 pl29hiQJKsAZ1NWkV6C5yrWAnD6IBFt2yzg6qvBsJXnDvJhLEcbz0/6ce
 bbHK9HDkSFw5tBUch6fvGPY7lE4WKMjssC4GCX0Kc2blk4JlI7ftAExtP w==;
X-CSE-ConnectionGUID: xud666F/RG+p4W40IyqVxA==
X-CSE-MsgGUID: vWyfOPLcT4WqfsE0xQxUSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="89490777"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="89490777"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:09:45 -0700
X-CSE-ConnectionGUID: wIeQfoshSm6+QNcSU5zl3g==
X-CSE-MsgGUID: OPC1BUQVQyeMEGlgxUq/ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="268545008"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:09:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:09:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:09:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:09:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doykWHsVFmINYh7OuGQSVOfo/aPxcmf4/YgjWqzL9A9qyjpCramg9riqijCk8On9wuiQOeKqq+sPDJi7z/Ds+skOus4/ktM0kzYfBEIIdqAoc1IKfjOCV8ZqGosEw0cYWPGyYb/GXPpftrKdwHKIatJeR6czTVv/HP4AMsgP9G7uvZcKc7YfRH1TiVlR3c6TkUemwtENEg+4XKvR5LGeoxDd6FsRmU5ioO7BpSapeBVSCGX6xd7pDe5H5B3q9UbaP997p8/bAg228pruxe4IUzR4Kmfy8JLbaYHppchvphvNHI4m+ediK2dE2ICZDL5H0Qd6uGQ6emSk+Lj8gDFZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2OaRD+GNzl3a9ocDdcM/BH02YxfDc9m1qdAW6G7hRs=;
 b=RFSGxuvDpXCQEi08mDDluE2qxoIzp+3ZwA74m5JePqXdJeE4nBVGT9RCAQvRFoTzExPAbUM3iC+JgV5/LiGI8k/WOZuJ5Zw69Yyp+0JpY7wrmnMfdCtLP/8t2SYiahrC9sGD42xJYN0teo+zSL6iDAywn9GiNDHTeU7RoK53ieln8Nk/lx8YxtGCQdBjQA0mG4xR9x0oolmSThPYFHoRgFkumAzJih1Xn82SdP+S2g/WwwnUMYdv1IwFsp83qS4b5ekhIoJ9ScDCNFOwqbKoWP6JMuIAyngfQjl6RimGXRTuxYpQOMdPg4WGiZyv8AkuwAVW1l20xR85k03jZd+m5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:09:42 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:09:42 +0000
Message-ID: <7b0c3d84-626c-4c95-8731-5de1e245468b@intel.com>
Date: Sat, 19 Sep 2026 17:09:39 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 03/19] net/intel/common: add utility functions
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <6f960051c1dbc0c9361ceec0d7a060398131f559.1789560945.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <6f960051c1dbc0c9361ceec0d7a060398131f559.1789560945.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::18) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bfbee6-715f-48dc-21f8-08df16686a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: fSPtdOaDJZOt1dljf95VrjuFzIK8DcKrk4hj3dIccJ+fECLPHSVYjLmqtPmvwatAhaWDz3TV46P6QA4Q3l65zWrC/5jHwroHo9akhFyn8EowWVeyprjEKPLuhJ+k9U8oRyvOKikrot3DhIePq2AfbCrQr5Z9oRI2d8YRGH9qH0e/ikJFQUdkPzaPCaHt4+zqSxUBv4OhJ+vx87nswCzfpx5ep9gZRnmdGJMIjI86EhauxKZOq6SESqI+Kdepc0JgM5SiYC5ZWCSeaGgbSeg3JCK9TEboYf5wei2krEJjjYXRvoaw7g3jQBKpk4kBSADXRWdjti7RF2wGjkVyG0C0LwkooO8clacri3Dc6KOMv66MmdEVBBp4eaFD44Nff9nsK40nZTj6Z9SBb0UtJ0bSmS5mbhTSU+5vV4ZnPpRaGrUDxW/IoqlgjP7/jGPvgil0RkDmXl0jVVaC/pVUBEAWTxk7bJn9he7lCSI8NTMD8R8r0JKGhgQ1rmtEhSQ9+1J49286pVBNHO6Yo2RKuNP9C3Klj0Nx2BY+b1GUVlZfMlVDxW3Osij7D3kEzxJ4/PChFBLb5jDnYEIKKJnr96LeMxryBwUxIpNC1C8aO/rBF1fXeM4osihyD0jescVu4V5Tw8R5tfxXffQDPVMlvG35b56sARtRsfzQ0gPoA5LPVTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1I0WFMvQU5hTWdOTFlQcnpKTTFVMHVXR29Zai9oTEh3K0cxVytKUlEzYm91?=
 =?utf-8?B?N3BXVjBERlE1OFJPMTNTWU9PUUdvaElSeDBuYUdwSnA5MUh5RjMzQk1zWlFG?=
 =?utf-8?B?aFpQbC9aak85ZHFLR2R3WXJtZDU5RVkwTFBJeHZIV1g3YTR0U1NzR201ZEN5?=
 =?utf-8?B?d29ITFNRWGdEVnZ2NkRYR05BUy9RMC83Q2wvYXVRbWJmR1JjeDNxZTduVTl6?=
 =?utf-8?B?VFlvUzdxeWhYZ3VSeW9sK1BhOXZUTTNkTUFWQS9XR0tsTjYrMWI5OU5HT0F3?=
 =?utf-8?B?NHV2clR4RTBKZWZhc0xJTlRjZjRqTFBiQmlMM0R5QTJRay8yeWNHVDc1OWxK?=
 =?utf-8?B?eVQycUVxK3BnUEJ4bWs5WEMvR3JnRmY2TVkrU0YzQ3F0bXVURm1pSkJkVHQw?=
 =?utf-8?B?R1VwM0hoUzliY0EwUWNjdU54WXZCRFZhWHlOZkJwaythZy9WSXJGZlNzUlNY?=
 =?utf-8?B?MDEvblJoc2p6VVBXbFhXRmdWRTlEenBsUTZvcnJ1a0FpeVF1UjdsakQ0cmhR?=
 =?utf-8?B?d2FQYUxNOFFzbytvWHpHSWdGcDZjejMra3hDVGlIV0V3S3BRQmdhTkl2cnhs?=
 =?utf-8?B?VzJhNkN5S0ZIMUV6UzBzZzdoQkptYjFWTFRRZGJXMUh2c3ViZDhsaHdVekJ4?=
 =?utf-8?B?bnZsdjN3TGRhVzVDOGx4UktnMVlBTlJBQkFIQ0pLYTdnb2R1L0E2akF2QU5p?=
 =?utf-8?B?S24zWG13c21Rbm1pSXJLcGo5cm5sT1JLUHZLK29SRU9ORGFYWHYveEpsV3BI?=
 =?utf-8?B?bTRwTTdESGs5UEdOcTJ4RDB4bzd2bXk4TG5vdlZFZzhxZUhtS2pxR0dpVW01?=
 =?utf-8?B?RWtMd1pTSXRFYnZVS1dpNDhXYWFjR3ZjT2F2aFQ4MUtoQWhBRnc0NFZpQ3JE?=
 =?utf-8?B?TXdiYnRjajVMbjJQSUY0ZHZhbDFTeTEwcHl4aGU5TFliUVlQQ0lLT2orNXhO?=
 =?utf-8?B?RnYvQjNHeUdqYmpMUU5TQlg2cGhhZUZ2VVNTa3BRZVBtdFF5SEtNM0I4b0hz?=
 =?utf-8?B?cFdqanVsY0FLcTU2UnNJd0svWUs1RjVRVzZTakR0UnJ3MHdwY2JyNDJUcEwv?=
 =?utf-8?B?d3ZpdTlPVHhPdVFkeWZIK0JJcnZodU5hZFlucEVxN1pTazR4V0ZhQlR5UFk1?=
 =?utf-8?B?RlVIa2hBejN6bFgwdG0wZjFtcFU4UXh0em1MWjU3S0E0dUFMaXgxaEVadmxC?=
 =?utf-8?B?QXZLR1NMMFNzRlFwWktNMEdDQ1BZcFVZUThYRC9VS2IrYVRObW00aVFOQWR2?=
 =?utf-8?B?ZnJKcHI5ZzFlSlloMk9hM2l0Yk0rODV3emVXbndXVzlOcjlxNElvMVAvakVl?=
 =?utf-8?B?dVBHNlRwSjBsSmVBbEpLWWhNYXFPL2wrNWswUzBOQ055ZVNlQSt5S3pDRkk5?=
 =?utf-8?B?eDN3dVV4bkNkbkpHOThITXZ1RHJ0empFNzNSbVhJZ1c3akRrZmtIRjNEZ3Nq?=
 =?utf-8?B?blRYaFA1UGlRRjBoNnJzRUdUa0hRcm02cFdhVjVRenNXaldNT3k1L1d3UjFW?=
 =?utf-8?B?blg0RDY5aGpxbGUyT0NqT2Voa2NTRHR0bnhocVpUczVTQytic2hpWm5rMHF3?=
 =?utf-8?B?alh2TW03RGZEaWVTMitGbHVKTDBIOExYVmEyUzQrSzNUS0FaYVgrSFl6TUhq?=
 =?utf-8?B?b0ZWbG01YXY4Szc1dGRsWVhFK3FjdGJmTFlJY0dpdGZRZ1l4SGE3eWowQTRw?=
 =?utf-8?B?U1gvSm5xelVEL0ZQaU5aK0FBUDNDUlR0NjlWeWxXWXhVM0NxWEVzcERDWU5m?=
 =?utf-8?B?U09WMkY4SWxRSG9zckFnUDdtMWpkUUExNFljWWlLYjYyZWF6VHZKUkNMWWdO?=
 =?utf-8?B?b0hwbkRXOVplTVRmU0V5SmpnS1B4M3lLbjlSZTFDS1FwUU1ZSTFLVzdNV21q?=
 =?utf-8?B?NXZOWkZXMk95ZlZ5bncvNEwvazZXb1p5MTE3Y0orcUhCa2RFaTBSTUxpZmF6?=
 =?utf-8?B?T0pzeTZ6cVJrZ1oydGpiZnVSRktWSTdJaE9kNlpxdVBBMUMzcEhkQVc5L0FG?=
 =?utf-8?B?cmJFbEhWTzhMc0tVL1AzVElnU0hhbXRwYW1WWlAva1R4OEJKbHhqU1JGUHVW?=
 =?utf-8?B?ZndYMTRWcTRjb0xvZ0JKZTh4WUpUUkhodzN3SXNJUUZvY2NhMHBlK3JkMW9C?=
 =?utf-8?B?WHU3b3RPMGFPR0JJQmhPbVJkQ1ZMWlpsZlpHVWs1TGN4UUp3ZTByMnJXRndm?=
 =?utf-8?B?OGFCMVZSK3dYeG5qNlZTSGdIMHFEd2EycGJFRC9ISnNxamtxZHNSRk04cjhm?=
 =?utf-8?B?VHNSZWphck0vaXdWRk0vT1AyWVRmYTUvRkcvcHNSSWRETnhndngrY0t0NVkw?=
 =?utf-8?B?c1VBL3paYktiSzFVUStBQkxWOHloNUxGb2NEL05Nc0V1Z2NKWld5N0tiVFl0?=
 =?utf-8?Q?sdTJcCT3IbGfIyRM=3D?=
X-Exchange-RoutingPolicyChecked: z+gdvLcEvvluETxUUkaMjvRldWY5BgeqQwhloYltjUyyAxD7XDKN/i+jSnW9qSquorN3JCl8iwgqFOvB1gCHgY+yUYqc1DNUcNw2bRy5cV8H0AZwmsrtxmv8DJCZbxwhTv6vMckFV5pGqZbVHTm2f8onnpElP2m9drMckaDLiAqzq2Y8O7L/5ibBIcAlpWzHW/5lZWrB031Z/5M4BQD2gPfIkomhai0QzfsfQxGvY5r4gvjA2o9pQw6YLzK4N609WgmvkmzeNOWD+jSQrMNT1brWXmIprydAIbBScG7pWpEYD3Yk2p5prA3RuD4q7CkXKaqYdfZdRjJ+YQQnaDtz3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bfbee6-715f-48dc-21f8-08df16686a27
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:09:42.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enEUDOzT7jBAWRkC+IWC+sBC10gMWRw4ATxzDyYpIjTZp296XzIUqcF6EgTSNr1MWS0ecqOvVdTdznIpkvGryB8T93DKlGgm2Vj8H8GQwlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
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


On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> A lot of parsers will rely on doing the same things over and over, so
> create a header with utility functions to aid in writing parsers.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> +
> +/**
> + * Check if a value has no bits outside the mask, and within the mask is
> + * either all-zero or all-one.
> + *
> + * This is intended for bitfields e.g. VLAN_TCI. For byte-aligned fields,
> + * use CI_FIELD_IS_ZERO_OR_MASKED below.
> + *
> + * @param value
> + *   Data value to check.
> + * @param mask
> + *   Mask to compare against.
> + * @return
> + *   true if (value & ~mask) == 0 AND (value & mask) is 0 or mask,
> + *   false otherwise.
> + */
> +static inline bool
> +ci_is_zero_or_masked(uint64_t value, uint64_t mask)
> +{
> +	uint64_t masked = value & mask;
> +	uint64_t unmasked = value & ~mask;
> +
> +	return unmasked == 0 && (masked == 0 || masked == mask);

I think it can be done in a more simple way:

return value == 0 || value == mask

> +}
> +
<snip>
> +
> +#endif /* _INTEL_COMMON_FLOW_UTIL_H_ */
"_COMMON_INTEL_FLOW_UTIL_H_" I guess?

-- 
Regards,
Vladimir

