Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A5CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 12:36:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 411B24028E;
	Mon,  5 Oct 2026 14:36:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id BD4E84028D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 14:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791203781; x=1822739781;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=K1rxSMlpuxtWlQmWDk2ENtscX6CbaZY4ZN9gCjykB5o=;
 b=I2XkPaEBooZ4yDP+bVjI/LnPRQUcM3twY8TvNNqTeaqyCUQhDJPpmdH8
 w/wiWgDQVnBL4UQdK9ZdAtbcI57VadFPtcE7SMtQapwXHXnQU2WFb2M4a
 Z8jN5LKiSDDHXVdlXJR7bSK+F1F14gwzJXa5u8ok1VcG1hGv9puKdpiMT
 oA7Gwu4t9oezxSLogSyDwri2mcz5Pz9w0mOl9v8KQyG8y3JMpmzqKDeSt
 FGg70WFW+DcIImCA8LhB+eqrSDvGNn+kenQY2CAC3cKoxHtx3pcuziFR+
 yqnGKc1qHOcjA6/5kt07oXVfqdmxhJGWEVRpvkAk9hwx3KWctZUd7R7wv g==;
X-CSE-ConnectionGUID: PhFUh4SWTfe2dbJ39riXMQ==
X-CSE-MsgGUID: bpE81kkPTDeChMOde+dgiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="91734758"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="91734758"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:36:20 -0700
X-CSE-ConnectionGUID: T3+HSoFqRga71vt5D6/dxQ==
X-CSE-MsgGUID: KJttTbS8RMCC3+m2/MWgCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="276937765"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:36:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 05:36:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 05:36:04 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 05:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIgtHRVNXN88xD7n6QqyFGldV3FNLE4ikybEralpsthZ2l+Iv56ryGm1psUFBKceh71XBTwJek4FzobzlGcXuhayJJmBasc9qJd5uGaRdOwY0d5EempLkYRDpxzDLICyZQ4QB8e/O4IqHIdPRGmNYCUO1jWjpn0j9ZbTSVhP/FaqusBhY+ZiYvzNUlmjtb/BCM1Ui2Y38iio8Nrnqesvsr57Ff/Ps6jv39kevuQPkYljB8cCWYlV3INcF1++TnlxukVj9w7aVK70d7IeBwmFMoU8fwTLBMSQcy+uGOeihy3hzA41dBAzgFACk/ajyFLfbwbLpofJIv0vO/VLaMyJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJtN05zBgkxVY/9fFUulm2FnhrNG128n8Gg5OWNlyrU=;
 b=LXqeeyRKZLd5QvqWx1Y5eCn7Sg9yLDcPLvbiTyciTmhzL8Yll5I9OmyhEoKy+no594dl9h/Blq4Aw4UHbjn0yWq4FNTR9tgIAW2MW0Oqh4pMkx5aQZ4e6E2TnT3c9039oySpbxKfuFoHDWfY9Iq+RvSZzPY8wj9c+KzTk1ESVl0zoqAv09Wn2Gv+SrH8nhO5750o6QZeD9lo3Lq2nZkaQGKBxHxtRaJyG85pQ+a5MpG+noN+gta88XEJb82yhKOJIhBce0d+But3RnJr63jXEpu2/Ika6ZC6F31cy7j1ESApV2uuZoQxe91RVqLY0vmBbAJxrle1DYjQ71shEGJhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 BN9PR11MB5258.namprd11.prod.outlook.com (2603:10b6:408:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 12:36:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 12:36:00 +0000
Message-ID: <6cb9e2d9-4799-45c9-8a7a-3d752b6cbb25@intel.com>
Date: Mon, 5 Oct 2026 14:35:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] net/ixgbe: reimplement hash parser
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
References: <cc6363a66e98e41defc05be3a4e63b4fc1e26674.1789560946.git.anatoly.burakov@intel.com>
 <dee838d3-36e9-48ea-aead-bc478b8bbf56@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <dee838d3-36e9-48ea-aead-bc478b8bbf56@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|BN9PR11MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca1560f-a106-4152-e343-08df22dd3651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 8Sg1lW1A8QpMUfr6x+G5b29nR94TFWmYxVzNgqQlmmgG3POAubLdyNYrIRa6jtFzYZe1CHGzL+BMAqsT9xerAPCOizX/n4v4JPhNbb/VdazNttduB1aSbcDCRHzaDY9714VcB3afpjHECoZflKsGIEkfiOkqmm0Qvh+aO4ztos/Vu8MtUMELq5ZOBS36P0ZW9qucNmyLMXoYCmK1imjHoByp3efVcEv011rnIMi/SM4NmqnWqWxn6EtF+UXbrZRG+5H7d+cgAl9LAWgQ5XhshJoD8VvoyAUPrQpRExlWvdengcfRvkel3XG7REolTkf98OGJKac9iM5OARiJrercXb6hPU2SGyQ2f0opGFUDaRS/Mwun1Elb78Py8rPcMAYatYRCgHSuiIwVDI/6nVvN86MnT0hJ9vMHPoAEcfiNPXHW/drhY/yQ5NAtxT8fdwFNkWqosvfMkD/rIoDwdEBABtMIY4WjjThIv8I9L7dUQ7re6pe02V1wX0SpOc2DeDLKQdh4FOzZ+oiwcLEpYR0ZWcFUX+zqxjiYndHPYJ/FI50+cJjQQbcrTbqSfGI4T2FAbPiKgTM4ddjG18piosxvXFk4GvXz+Ex+ew5sopv/yLWRRrpRGnWvDaaMyqSADLfpFt0usDEMeqpvNe0DE9pj1GbOEtT4Jvi8LlLe+I6NmYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGVPRWREN2N4NTh3bGpNSTZCYkRoa05ieU9QVExTditDNVdwRjVTeTQ2QmRB?=
 =?utf-8?B?MnBUaVpFM29DRXdDUUtwT25YbVl3a0o2cXF6WDZtQkhGWllSdHd5UXlGUDVa?=
 =?utf-8?B?cC9iaUFMd2tLTGs0bFNvaXozUzRGbG8rOWVCTllzbnNjd0dvdnVhYks1Snhv?=
 =?utf-8?B?d0Z4aisyRkxWcVIvYlE1WWFzdzdEK0pCTlpMME16aFhLQ3FVa3ZRaFdOUWNX?=
 =?utf-8?B?YlRQZVhDMnZucXVBUjFvSFAveDBzckRWc1ZONkt1enRrYzlVY2FIajVmK05B?=
 =?utf-8?B?cDNnWmh0b0xNelpudXR3cENUOXduTGRPazVwd0ZPM0FwQ0NvSUFVYWxmeXdi?=
 =?utf-8?B?QzdZUkkwNDlFWGdDUUx6eGhzTzhRcTFJa2tvRWl1WElTdklVU012c2xmNXRP?=
 =?utf-8?B?RTVrYmRDTG1xQXRYNFBuZ3lnZ2hlemJDU2NIUUM3NDd0ZldqZzJUTEV2SW5M?=
 =?utf-8?B?UXlNN2Y0U1VrcFpBNTcrbXc1SE5UMU9nU1lHRVhiZTJhRnN3aklWRndTbFlM?=
 =?utf-8?B?RmUxMmh1b3JHS1ZKMWgybUJNenIwSk15cmtoOTNUWE84VnRDM0E3NklLSm9S?=
 =?utf-8?B?RWdmaVBTT2oyamphQTdqcExBSWJMcWJOczBoRUVnSUlRUUVMb2I5SzNIb2tv?=
 =?utf-8?B?ZXZGK1htdTZMbWlja3Zaa044RVNTZEFac1Rxa3hSUVVhcmZHak1EQUVLTHc4?=
 =?utf-8?B?Y3Y0bUd5WEUwZDgzUlNqMHhZQm9VY3pQenNvaVBoNWV4aVJ2ZUdKTDZCTXBC?=
 =?utf-8?B?RUttdnA3ZWlmK2F6Y2tuZ2lNcjNVdmIvN0luck5adjBaM2NkY1p6QUprWE9u?=
 =?utf-8?B?WFdVdTRsdk9sSHpWK1J1RkdtdzJCZmgwSThLQ3F6NE9scTFEVDdVTlpUd2FB?=
 =?utf-8?B?RTQ3cWZEelRFWlZNbjB2VTAyOVZpZVUxWmd2amt0UjFzOFVEanBZK2FVSk5Q?=
 =?utf-8?B?Rjd2M2ZLVzZVUm9PT3pxcjZzUUd6alFMSWdKYTNrOUtJN3IwTXlOZzVWenVx?=
 =?utf-8?B?bzFRb3RlUEZXRGdYNUUwTzVSdjJkclZLK0Vjenk1bkdyeTNScENxZUoxRlpv?=
 =?utf-8?B?c3B6NE5hOGNsUXluMXcwTUVPbzBVVDNTMG5MSDFiLy9QY3ROMG9WUU9peVNu?=
 =?utf-8?B?anU0Y1lGZGtHb3ZNR01UaFpvMjZaL2VQNjFXWmkzV21tTFNjazdRY3FTT1dY?=
 =?utf-8?B?Vm50MWhHWUZCQmpVOVdtd3cwMFdvQ01vRGpkTDdUSXBtb05TR25lWjVKRnlM?=
 =?utf-8?B?d1ArZFlmZjVod2pQMFF5T0Zydm5mamdIUjliSWtsTExzSXpQV0RNOXJEbHo2?=
 =?utf-8?B?YTNqdlBaYTdkTysrUERKWmtaZDVYTGdaK05KaGM4elRXdmx2ZVdXaTAyUFBo?=
 =?utf-8?B?M2J4VU4xeVBUYldxdDhyMGtENXpnUVdTRnlIb3NBQ01UU3BBQldKUloxemta?=
 =?utf-8?B?SnRCbnY5VGk0NEJXSCsrOG03Nkl1VklpZmN4aXpENElNV0JxbzV6NXdEbFBE?=
 =?utf-8?B?akprenZzd293TUdObTVkWmYwdTQ4WWhibXFOYk8zb1RPV09uekhxVmVhNDVP?=
 =?utf-8?B?dlRFQ0dYVnpFY2xDZkVDQUVCbXh4aE9yMXg3SERza2tOMCsvTFJLS3JHV1pC?=
 =?utf-8?B?cHRmQnA0TTJUYjJxc2sxcUh3TVF5WjRyUzBkNGpLSXFEaWh0ZFBkNUJFN0o2?=
 =?utf-8?B?aEQzV1paUUdNbjNtU0l0K1BoRzZPS1FwUG5MVlM2WG9ncFRSaXNWRGFYRyt6?=
 =?utf-8?B?Q2Q2djQvZEl1VVlTY3krZVVlanJkcmtrUlRYdDdBMjFnb3pVMnNWcGNJNm94?=
 =?utf-8?B?dFZyeC9iNkFaTGR3VzFHdFV1STgzUUJhUDA0b29PTkNPbDVxRDloak45eU5k?=
 =?utf-8?B?YjRqT0UyWVl6bU5XdS94Z2IyR3RMTTl4dnduMnM2ZEFUVDFTYTlHR1pGQUNi?=
 =?utf-8?B?SmYwSitON3FLWnlFMU1IR3ZJV2I3TkJKcHF3SmplVkFrWmZtaE5SektVaWJu?=
 =?utf-8?B?SXhoM2JIemZPTGpGUVhTSVNKLy8vRVpYK3RmTUNwbUlwcitxakZ6TFFaekhY?=
 =?utf-8?B?V0ZuS09yeUpQYWNjQ2U2OGRDTHU0TnRpc2xyNFZWcXo0WGpaUVJVMVB2bkQ2?=
 =?utf-8?B?U0xWOUdMNHprZkdUblVBbS9lNUd2Zno0NFNJNGs1NE5JVlE4MzM0MXpjRzlT?=
 =?utf-8?B?d054WXIvUklmNjJiSHovcmZNNkRMQkpkdVIyV214SGRZUmllZ3lmRzc5UzZt?=
 =?utf-8?B?Y0tEdmYzQU5sMzBkQVk4NkZLalFvYWZLU0U0TkRMREM5dktySWJ1T291NXY0?=
 =?utf-8?B?Z2JiRHVEZnEzNEdzYmdMcU85M0ZFNzRHZEdaYktLeVVLNG12REg5QTV5Sjl5?=
 =?utf-8?Q?mXb/ALAJfjOH9QfM=3D?=
X-Exchange-RoutingPolicyChecked: QMtyz67nPHCabfvPnnnZLrTu2SOHviGZnKcrIXucWKd1yY7qSocQ2BHtky2SuTO48OWzM6017NUBFCMUFczQ00aYXVRrjS8pOM/Ur3dox94A+LEcVeCuURS0FumVC55bKfG056MYP8l9/L//3ZhYwcTzbvfBOyNsohJAxukKAOD1I+CSeD3Sudl8n9+obx8AXLFhtUp2aW5UyaPfTvO240SveyCKqNL2AAdUrI3Y2SjINxb+3SPIWdTm2zjwmO8byj7Za0IuC1CnBGFU6yNZNfD3nM1a0QF5pzK8rD38bWTrRc4Dcpt+aAvF93pgLDggSvLsB8xMsHQ/zq/3JgiSCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca1560f-a106-4152-e343-08df22dd3651
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 12:36:00.6980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pfV2nZI70dS8aRbDgXxwgAik45Cznix9WlJ9ej/vQs0dZTLTzucECcwLl7AoIswzb1VFLJ91frbZFspTNdb2Ygr0kMA6ppYmdzCkfhwOzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5258
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

On 9/19/2026 6:11 PM, Medvedkin, Vladimir wrote:
> 
> On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
>> Use the new flow graph API and the common parsing framework to implement
>> flow parser for RSS configuration.
>>
>> RSS flow parser doesn't really parse any "flows", it was completely
>> ignoring the flow patterns and was only looking at actions. It will
>> therefore not specify a pattern graph and will match NULL pattern, empty
>> patterns (START -> END), and ANY patterns (START -> ANY -> END).
>>
>> RSS was the last engine using "filter list", so that is now removed. The
>> RSS engine filter tracking was also moved completely into the new engine,
>> and all of the "filter list" infrastructure is removed for good.
>>
>> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
>> ---
> <snip>
>> +
>> +static int
>> +ixgbe_flow_hash_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
>> +        struct ci_flow *flow,
>> +        struct rte_flow_error *error __rte_unused)
>> +{
>> +    const struct ixgbe_hash_ctx *hash_ctx = (const struct 
>> ixgbe_hash_ctx *)ctx;
>> +    struct ixgbe_hash_flow *hash_flow = (struct ixgbe_hash_flow *)flow;
>> +
>> +    hash_flow->rss_conf = hash_ctx->rss_conf;
> We cannot just copy this structure, as it contains self-referential 
> fields. For example, hash_ctx->rss_conf.conf.key points to hash_ctx- 
>  >rss_conf.key within the same structure. You may use ixgbe_rss_conf_init()

I'd rather get rid of the struct embedding same way I did in i40e :) 
this footgun should not exist.

-- 
Thanks,
Anatoly
