Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F55CFD7F90
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 10:46:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0C634027F;
	Fri, 27 Feb 2026 11:46:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 68CCB4003C
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772189201; x=1803725201;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cmiFS4OGYBOnRFVh1QLpb8EFQN9URw4IYmwmcrC1w5g=;
 b=J5Y7OwmWWL6imCezcNBG1IbV5W0DgI8hhC9c5ZYBwmmLKiOONrFcfHLL
 JA4t9OhmiKdAPAM+zrG5gU6K4wCtmbKqKqz1tdZncjoMfRbW+gA3/4M7K
 6ZV28wDuI4LXP8k4gvM5KYKOiIpjOXD9/23Ux8avdFvU+/by0t8Qw1Aqd
 97EjLKbh03t1haQJTnzpD3Da8AvDl60TtLbqHyI8Ws9nA/hPDJM83K7Ce
 s5rnFLZwyhmYaX7FM4jhRO15gXR4qizK9XXy2Kw5hlsf5u6GLFEqe42gk
 ipVQzsEDZ683iSI6iasNYB50lkZ6s+RxXzY9ND7V81MMtSIdWCSn4JafI Q==;
X-CSE-ConnectionGUID: XT7WnVAORO6RvquHtythuw==
X-CSE-MsgGUID: fcnipPGLT8aoGirV5TG6xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83976765"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="83976765"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 02:46:37 -0800
X-CSE-ConnectionGUID: d+RRROiQQdWofkwaj+oYAw==
X-CSE-MsgGUID: wnvwN/XvQVeT5XbETVxTCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="254642685"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 02:46:37 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 02:46:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 02:46:36 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 02:46:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4lGa2owt2jUM8ob9BcBWXLoil6nAp5uDPNaxaPxcCWyJfNJNmdagJuh3ul0jUET5h9RlyyYD8bLV/Z0P1MMfKeDIet7K/iWEfz7WYmhFbA3wvpcE7IXeaAUaJyJXxcdFb7ODb+Rqe3hiYbHmRcRS570UuQx3jPkNDKXLLF6y/AU3lZFSQ/7rwlnJXb3G5KJAIkAqCdZnhCF84ik4ew/wd2DCcxPSOl14Ft2YUOHiOPwpnNEG02gxRAUP1D22FPGTYkxCzHZrqfrEDuoQlw5/pQWsRx+aXJe+C/wJoRkartO4yAMQ0JwDlHVk77zNABn9Sk8AVVwZdL91sr3oKmk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNCGNr0Y82LS/moVvqaj/0KV3OpCmZalQgBvIs5uCrw=;
 b=wU3xb77WLaDcDFu5feODdWALABPmELJKXB5ej8M6KWc4t20ri0MY4+fcSaHDQEssnMabWBLC863oqSWbtS9IsICnTR1WzxT7o9chQCmSQNTft5W7ra1OZe6CbQbruqnPqLj9Bibv+I5+Zz0b5iOQ4CYVUd9GYMsuFaAtWH48GDTIF1+EsICR9NmlEOtRsER6a5O54oEAMr/W3F6L9a7r2ouchD4Y0cAnIJtriNe0EhJVJdY1pxBzcqbVeT+zNkFRv1vRO8fpJFI6xO6H0CrkDr5WzNz6R666+znxKTBY+jBZoaOyqGpDDDC/TYtdFW+An8w2C0yN7FPM9JcP0uw67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 BN9PR11MB5321.namprd11.prod.outlook.com (2603:10b6:408:136::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Fri, 27 Feb 2026 10:46:33 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 10:46:33 +0000
Message-ID: <a270d0a3-1eec-4485-8824-86555890a40d@intel.com>
Date: Fri, 27 Feb 2026 11:46:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/3] cmdline: use C standard library as number parser
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
 <aaCBr2xw0PBAJz7S@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aaCBr2xw0PBAJz7S@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|BN9PR11MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 71aef632-1401-49af-35d8-08de75ed793e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: lc6PEaCBlGW2balOB17GeNDYx2SH75+52UPi5GA16vZTP/AOyTICJta3JceePv1W7ooTzGU3nALCHit6up44r2BZXfCt7kE/8mnUtbtHzzoj4Z4+1gF6hWJ2HMzocJpUp5RXnT+Un4NTxSOfZ8d6F7D2LI4sYLQabauADu5CRwGaZEy++1eTH1xY8W0mQtvPDUMTT6UqxDFlBpsqaDoYli2RVD6cvQ4CE+KSXd4/OBHSKFFA8l2qxVJbr+QlvLzNM6QVD/kcpmEvKABtCcdMKTKM3EemHXZ/VHHYj91fUwXYdoMBzgVmmZoLMS6A4WU9FFf5N499UtXxBdNf1gSNA5dUfxdI0siSiaNzLDlALLbULbu2qrNcnCUe2ID6Bs393y7K4KlBA+47HwQFbTZ6gVfSpaluU8B3dfeLQ1ZZ1yYvFv1JBYgrWQ4CvWkkdFEDeBpVf0NfK/2zlxzQiUk+c0t/N6DtlEBU7PL5QcyDOlUz6VwWjy9M+jKNmfcsFlR08izHN9Ds7FgOXfbGlQZKIztUrLR/CzU8cQKXm2fHvcqILuz3V7xGkZm2DEYmyzfk54XFYur88sd66DcAm+hK8VnvygFBpKMD7OukpCVDjYPFPJxGR3D9BXRYH01WtqxXesasibf4dtNNA4Fv9ddZxjUDej78nWf82x31AmfIy3U0n4MdDZT4jZ+MLA1pT0BLm3voK1y9DXWGKRSUbDLN++JpORitQFYOWmlpbS4mb5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBtTlpQcStXLytrWjJlSlg1Z0hCMmNORnFFS25TeUl4TGpTbmNjK2FMLzFK?=
 =?utf-8?B?SnBaNnZvVHhnbzQ0L2M0aFllaDcwbk1PdGVQTUZEQ3JhNnZhWHh0K2hEb3BT?=
 =?utf-8?B?U1pzbVBRaUZUbk94OHcwMW56NEpyckpoL25PQnVlbzhVN1NvbDhJU0ZtTzNn?=
 =?utf-8?B?TWY1bUpaYjMvdE5iSi9qdFpOdDBPdDRNVzl0cjV6RUNkTldDVjFVS3ZzNTIx?=
 =?utf-8?B?WE5QeE4xZXhoM2VwUVplL2NCUFM4STRTLysrVC8zQW9CTkdGNzcySnhGTWtF?=
 =?utf-8?B?bmhKQmI2ZlF4UGhNSUs3WWZjUUhEWlRpWGVEcUMvREtLeVFsVE9Sa0lGeGs4?=
 =?utf-8?B?aGwyTTlrWlY1R2RZVFRkZFFrWFZRUjJ3QkJJck1TT1RWQVhwZDAzWFN4Smlm?=
 =?utf-8?B?RkFhL2VheHJTMW9JOWpkV2VGSTlqTkRmVGg3d1NSaFJmeEhoSVdUYXBJSjNE?=
 =?utf-8?B?U25la2wwYkdsc0VYK2pkM1lKOVZSd1NaUTZVK094dnBKdEpYK0xxbWVDV2Fw?=
 =?utf-8?B?SjNjOE1lbjNLWDFIMHpYYVluZU8yMlVVYzgxWWNMaGZFWnVpdThOS25ZMUV1?=
 =?utf-8?B?aEZmWW5odFlsaXJJK2JvNFVNRFpTUXhOS3pnaFNTWTZSYzNVWkJFZjhuTTZD?=
 =?utf-8?B?V0NoSEdERjN0YWlTZ0dUUGVIS1V6MDhOKzlNVmVHZ1kwRS8xUzUvUXl4MGxE?=
 =?utf-8?B?UGNSU1hSOHZFaEJVQlpGUXFsVkgveDFmelcyclJDamhCNnRYcGg2VFovWEND?=
 =?utf-8?B?N2JHcXRJekFrSGYrNUMyVkwxdlZUU21Bc3ZhQ3hvY0tIZ2YrTDgycDR6WDZE?=
 =?utf-8?B?Y0NodU83cEV4VlVGS2R5bk5IUTZEVHBnZ1ZWS1VxSHBYZ3NIMUNEOHltYzlK?=
 =?utf-8?B?aGhabkhUbm4ycXl2bjRzOUVtakh5b2cra3NmVTZoejQ1MEFUN2IyUExXUzVG?=
 =?utf-8?B?cGh0aXNkUGwzeEFydk1MOUhobzNZcGRTUnNsNkl0bHVIOVBMcUI2L2FWemVI?=
 =?utf-8?B?Q1pSQnNoeVEvTFo3eHZoeEN2aU5PbkJOdEtxUGRjQnIwcU5pcy9hejZEV2Y2?=
 =?utf-8?B?L3BCL3oxTE9nR0FMZFRRbTlTNEVGNU9tejEzZ2I4RUJkMEp4U3NRa0RNTGk1?=
 =?utf-8?B?TnIrbHFxTGdibXpaV3Y5V0VOR20veVVRb2ZpTWZyL2tQVWZLanFQbnhheXBh?=
 =?utf-8?B?NHBOYlFJQ1hVS2RsTjN5dFpLbDIwaVo1SGFzMzFjWStQZEpocGxTanJWbXBU?=
 =?utf-8?B?V1BrdzgzS2I5SXFjWUdvdGNuZHRFMHpCYVE2Q0hqcmVzMnRGVGRUTGE3Y1Fq?=
 =?utf-8?B?UWdiMWZKRndQK0xuWlRCRjBNT3p0SGlMRE5sTmFRTytVdnZUYkNuU01kRUxB?=
 =?utf-8?B?YTRsUFlFcHVseWtCU3cvTFdiOC9aNHdjeTU1ekxjbnladEsyZk5ZZmozd1Va?=
 =?utf-8?B?YStDdDBYU3hXUnV6OEdweldZeXA4aGc0NW9vRlNxWkhGak1iUGxWejg1YldS?=
 =?utf-8?B?RTJzRkFqTjF3V3NKYnJ5L2dXS2NmNDFmTVVSOWRvMHNvQjlUbE9IWFF6T2tP?=
 =?utf-8?B?R0t2dU1xSlBsN3FGYVpuYUl4d3BjYkx6d3N4RENFdE54OWd1T1ZqZzlReWFW?=
 =?utf-8?B?RHYvTDUvMHh4K2RBZFZuNWxaM1lobWNKUkhNQ3A3YXVsbjY5dFNSSjhMNFNn?=
 =?utf-8?B?d3RINC9lL2NscjJNNmU4VElLcmFuK0xkeURNR1p1TzN2cE1yMmlrb3dOSDVz?=
 =?utf-8?B?djB4amxNN1k3NVAya1dzc3BvMTZxVHFrZS9GbGp6T3ZWdXhSenNuMkFQRk9j?=
 =?utf-8?B?YjVOWUJYTzlTUU9vQlp3RFpET3g5ZmlDTVp2eTFwYktZRjY2dGFEbWpPS1RE?=
 =?utf-8?B?QzZvUUxGS3hmd3VEdWZ1YWpGdjNKVUtSQk9PR0Z0aDhQY3d0cHIwelAyQWxa?=
 =?utf-8?B?c3hWOCtmb3RRVGY3OEJNMEVFYkg4TFZ1QnpzQlpEczBNNHg0YlpnUG1vYkUx?=
 =?utf-8?B?dk5TT2J5T29tTlFwVk5NYjFMSUJpQzdMWmJPb1RORkVQclhrcmwraTBUR3FZ?=
 =?utf-8?B?L1hGUlhqTGQ0VUFVcEY3WDFXMHcyUTAyRHBkNTNSTnQ1eXJNc0xiSTlCU21w?=
 =?utf-8?B?Z0R5bmFJaDVvMWMwVUtHUUtDdVFaRzNlUHNEeE9zRHE3V1FQUFpydnZPamkz?=
 =?utf-8?B?SHZKaXdRaVdtNXFYNVF0cHZiQU8vQithc2QvVWhJSkVoamQ1NUg1a2s3K2s5?=
 =?utf-8?B?TjJoSVdtYnJTUmI0TGxVQWQvV25GNE96Q1VJYjVzMjhUdWF0V2VlVVY3MjRY?=
 =?utf-8?B?WnJoWTJSVjc4VENBc1RNS1EyZEduZ0xoSTZNY1MvNWZZZ2VZNVQxSzgwQ05h?=
 =?utf-8?Q?Sq3eVXEsiY/KW4Sg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aef632-1401-49af-35d8-08de75ed793e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:46:33.7534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQnJH3yhd229wJP3gry1xGtsFHMpZM9Wu/QCKIdFsJKdpH6j+acNGa1YDqEFnA8RSGMD9ahZ8tdQ4WoFqWjvEl3uAQvNIOyTF91kiI/pVfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5321
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

On 2/26/2026 6:23 PM, Bruce Richardson wrote:
> On Thu, Feb 26, 2026 at 04:44:48PM +0000, Anatoly Burakov wrote:
>> Remove custom number parser and use C standard library instead. In order to
>> keep compatibility with earlier versions of the parser, we have to take
>> into account a couple of quirks:
>>
>> - We did not consider "negative" numbers to be valid for anything other
>>    than base-10 numbers, whereas C standard library does. Adjust the tests
>>    to match the new behavior.
>> - We did not consider numbers such as "+4" to be valid, whereas C
>>    standard library does. Adjust the tests to match the new behavior.
>> - C standard library's strtoull does not do range checks on negative
>>    numbers, so we have to parse knowingly-negative numbers as signed.
>> - Some C standard library versions do not support binary numbers, so we
>>    keep around the relevant parts of the custom parser in place to support
>>    them. However, since those libc versions that do support them also
>>    support them being negative, allow negative binary in our parser as well.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>
>> Notes:
>>      v10 -> v11:
>>      - Fixed all checkpatch warnings
>>      
>>      v9 -> v10:
>>      - Fixed commit message not reflecting changes for v9
>>      - Reworked enum range check to avoid compile issues on some platforms
>>      
>>      v8 -> v9:
>>      - glibc 2.38 supports binary formats (0bxxxx and -0bxxxx) under certain conditions,
>>        so in order to ensure the same functionality on all glic versions, add support for
>>        positive and negative binary formats, and adjust tests accordingly
>>      
>>      v7 -> v8:
>>      - Added the commented-out out-of-bounds check back
>>      - Replaced debug print messages to ensure they don't attempt to
>>        index the num_help[] array (should fix compile errors)
>>      
>>      v5 -> v6:
>>      - Allowed more negative numbers (such as negative octals or hex)
>>      - Updated unit tests to check new cases
>>      - Small refactoring of code to reduce amount of noise
>>      - More verbose debug output
>>      
>>      v4 -> v5:
>>      - Added this commit
>>
>>   app/test/test_cmdline_num.c     |  34 ++-
>>   lib/cmdline/cmdline_parse_num.c | 421 ++++++++++++++++----------------
>>   2 files changed, 248 insertions(+), 207 deletions(-)
>>
> 
> While I realise there is some additional test content here, I'm surprised
> that replacing a custom number parser with the standard one doesn't
> actually result in any code saving. The code is as long as before!

We could've, if we didn't have to support binary numbers - most of the 
parser is left intact because not all libc versions support binary 
numbers. I mean, glibc 2.38 was released in 2023 so it's not even safe 
to assume every LTS distribution is on it, but more importantly other 
libc implementations (e.g. musl) don't support binary numbers, which is 
why we still need the binary parser.

> 
> However, code size is no reason not to accept this, so:
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 


-- 
Thanks,
Anatoly
