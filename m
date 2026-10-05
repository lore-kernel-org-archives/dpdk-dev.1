Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BADCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 08:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 171B2402B5;
	Mon,  5 Oct 2026 10:35:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3CED540290
 for <dev@dpdk.org>; Mon,  5 Oct 2026 10:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791189339; x=1822725339;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=q5l4iLxqMOhYqFjk9JkYXmA0OYfnQ/vA7s4MDWiF8Jo=;
 b=gJ/Zv/K4nOOaOWiOtjfDM6aH3Ditz19aGRzy2Pa7JqHjgcg8Fzr5Oc2k
 ShbdOMnr9LVib/XPXD8bOhRJyaePtKjiq59TeU+OzDvsrMDY51rGcXlAU
 0Me0mtzgLEEI+rTxKAyxlxxz5dVIggkb2XM72ij2PBqfoq8xFfuJsnFPk
 SF2Idj0om996t/iSvsY4ZXG2XB80hcdP7nyNAy11ZgTKFIbux3EK2dBo7
 +3vEEhu3NNTLljcNABkI4By2hAr9cYea4a3lxeNYAVjELK5TPmpbX8P6/
 ozqMcFkxMREHTpVaC+bbJBQxNEdZYcKYDX39UXcIXctJx80h00pPJQVRI w==;
X-CSE-ConnectionGUID: fAABWzSBQrKGJ1Mox2cnhQ==
X-CSE-MsgGUID: wJD6FlxqSe+5fZ787GKp2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="91960374"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="91960374"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 01:35:37 -0700
X-CSE-ConnectionGUID: X2E7souGQBaqKoAI2DIDtQ==
X-CSE-MsgGUID: JDokl4CDSa6dpx+rfEo2xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="284840530"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 01:35:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 01:35:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 01:35:36 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 01:35:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3xXys8rcVv68MkIVMwKcvQr97pSxZ9AYormSUTkCIfXX1HEuJ/Il3v0ocLFNLfm2MORc3QzRgfJeYW2AmK9zwJfYADCc/vbVRwvk0oHHVd08LU81e75WAJykO24Ydd3f6r+GfWIx0ckSyZYIJRoC5LC4nH723nTCkEDbkmKAcR0pn65h0XtahBV6doiZgbQwk1GkGI5DldZycKN4wjGZrJs3TIgTjggUysnyeLAAnfZm7bCr1y/AwS1yw2Zksj/sb+8VIwcJUvp3eyBt02svUH1GtzOAhvZXi4VfA6m/CzZZRKbrVIAuTv0f7ZAvesJET9FbLRBgmyancgm7nYjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95Q7Jix/+LQXWWf433IYYPdKvj4bA9rJBImE6hwT5pE=;
 b=UZ8NY8t+KZZE9Z8hdgkBWhrcpTkSfffht+uk6WYlYvugOa7ZTIH16stAHe6DRgOv/0oRBb0Lc+HyRxoqNzrLhfvwkEZGuaaucR5Moe2sNgR9WsZZmbrJigog4SQWE6D0ERv4T8w/Bk308cT0pKG9n1vpWWekzImSbmIjUs/RjyCUkgJWyGgupPDfZkR/I5wC2+SCuAPksV/yUCPcef2Xm6HySEHC9Zn+EVl6czL7tU0CVgjzcU4xuEY8zY0L2MaAP3ZIn8ZPLlK4BMGR1KkUbM7EqwP9HtRUvS+sx+f7MOvBt4BVTKrYnjE/UhJag9lKk1qvSe/StpWEsFFrq6AKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM3PR11MB8759.namprd11.prod.outlook.com (2603:10b6:8:1ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Mon, 5 Oct 2026 08:35:34 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 08:35:34 +0000
Message-ID: <8632ddeb-72a3-40d7-9ba4-cda241838253@intel.com>
Date: Mon, 5 Oct 2026 10:35:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/19] net/ixgbe: reimplement syn parser
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
References: <4daf67ef6722dac1f9a42d736e2b3cc05fd6c537.1789560945.git.anatoly.burakov@intel.com>
 <9ff39b98-de48-44fd-9d71-d2de44e1ac0c@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <9ff39b98-de48-44fd-9d71-d2de44e1ac0c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM3PR11MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df5116e-d13f-4c37-0f1b-08df22bb9f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: a/PTz8IGB5IlOVPeo95BGpqCC0Q4VuFBYuZ5c9qqz5JOoRLO1PND37OywRIeAkNQsxnH/S2ZDEFJV/EhsFpy0SNH3mdUQXwe49P7OcXAhxMaoTf5ZrA0LZ/Q/xEG66Eh/SRhh9Lw0EKfarNUqYgUzJBSyyErDg1vFPMLADF9cpl4JLOqlHdVFfYTbLzHozfkyr1bRhTXcMBiufcAlx2QqA1g8Knd0CLR1HSgHx7jIZunMqiq8jYb2hDKsBR2g+WYPL42OOeE5/wCdR/ASH25TuOSM34dUQWhWEi+00n9S1yshSaZX5kKvDN9HXyvFLY0CHFE5DawFmKDuOz3VVGNosa9184W/vywAtH3g4B3YFnO8ypPECbePYKy2vU5iEdlx+GlDwiPnP9W6XyyHG1KjlDdQVHWQUIxog5SejG9abCNWIWiu/eyzQm0Ujbe1H6sLLiq0SHNlo5K9l3lYAEXYjQmiROFJ7GObC0ram45y2nKZKrsXefE8LCHxWQZ0y8fyoZa7veB23vi0dl6FWImu7EVqu+HhCA34islMuxYvsz00ipaNX7Bs1Pk948reOfFpsupxTmB0WIWrNmEoKxKMIR9V/jgMQYdHJT1KExEZQjp/+ChvbtRvztERcu1aEEWu0HZ+rYomW+8cw/kbpbj7JNaogw2IR6HX2agZrgwdeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWVidGhjNDcvSDBSRys3a0JIczI2ZGRyZ05hRHpSblAyOC94MnYwbUdidTc0?=
 =?utf-8?B?L0huclpPdFNpOTA0UUdRWE9KN0EvR092d2ZHT3NyQUt3cXhKT2I5RjZIUHph?=
 =?utf-8?B?WDZtNTJCb1FTMjUvb1lHQy80NFBhMFJTVTA4QkR0R3JySTBURkk5cTdCK3U2?=
 =?utf-8?B?clRRbHpjbFZiMG5qSjNXOFVwb0R1WDVnLy9tVnlTekRNZENXYXEwT1pseFVI?=
 =?utf-8?B?dGo0bkdvQUhWYm9LNUJYZmVHTERrRHFOUXV5bHdtZW85cnIxTlVXYUdEeFJL?=
 =?utf-8?B?VGhxUmtrTDRWTHZSY3pvQUpkbWpSQ0xFcGxCUnNzMm5nV1BRMm4vWkRoRXhW?=
 =?utf-8?B?bFRWTTM1Q205bjQ4SC9rR0xOVWFVMGphcEdkRTE3SjB3bzgvK1ZFakhtclVJ?=
 =?utf-8?B?bHBvaStLQmU0S0p3c0V1ZWx4MmxkdThxMlhGeFlxb1JETkx6SXowcnlLWHY0?=
 =?utf-8?B?Z1NHR08veFd2eW1WKzQvbnFrNTJ3bmkvSStzSEtTQUpwS0RzWnJqYUk5VVVj?=
 =?utf-8?B?RFRqaUhzM0dZZWQwaUpVamJTNUxsa0FacTR2cDV1dHN1MEIySkdhUmJBdk54?=
 =?utf-8?B?ZDNjaVc5Z3VTMlowRE53OXkvMmlPWXJQMFFBcm0xQnB5YVJ0dzRKalJKbjl6?=
 =?utf-8?B?YWNheEtCZ2cxVUlyMCt6aVliSGNtVE9BelpGWkhHMzdONnIvSVFoczRCMXNK?=
 =?utf-8?B?QUtkM1p5ZkVwOGV1OVhOSkhUejlkdjRTSm1HLzc3dklWT2RjVHZmTmErS0kx?=
 =?utf-8?B?TXdLRDFLNHNyYW1rd0ZYVW5hTHJwQlFvNVAwWk0wU1k3dmVkUGVidjYwQXdp?=
 =?utf-8?B?SVdwVUJIS0FQOHlxRTlTN3MydlJpcW5hM0pXQUFSUi80c3FCVnRNZERYVHVl?=
 =?utf-8?B?bWpuSnp1d3pnYXBDMzFWMWRXb1NadHFZTS9RTTFnTEk5TU16b2I4cXQ5NTBo?=
 =?utf-8?B?THFSTThHL0Y5RlVneDB1cXFCUGw2TkN1ditib3g3Qmd6WjFPMVQ1dit0UXFq?=
 =?utf-8?B?K2RjTVlGNTFOenA4clFTd0gvdHZLYUlJSEsyQWpkSnRESENqSTZYK2hFYWlV?=
 =?utf-8?B?MXpIZTgvUXhNNE16S3BIZy9SZHFLZVNDUDJBQW9ndlc2WXZVK3IySE5OT1dF?=
 =?utf-8?B?eXQzdGZUS2c1ak15VzBxUHlIOG9ZdUJHNm9XcVdhSGFLZVJaL05BWStxbmw5?=
 =?utf-8?B?Y0tESnpYeXNKOGE5YmZSVXZTd1pVdUQvVlBaWDIrMHBXUVV6L1VZTDJuMHN3?=
 =?utf-8?B?bDZrcmtLTVRheWdtdHZCR3V4UjJJYm1wY2RjVmlEaElXRVRmZGxZTFBFaDVQ?=
 =?utf-8?B?V1hPR3RBTWhLcGlNeTBJZjNveUt5WjcwWWJsc29Jc1l0QzNQcFZkZHBaSU5p?=
 =?utf-8?B?Mm10cEVGMG4rWkxIRHdITmh6cFJtMVZvQXY3UERtU29iTlRiMmlDbDNsWklk?=
 =?utf-8?B?RERPSEljdmo2QjY1VHJXMzVDWURnalM4OUxoOHFWdUpacFR4Z2JmMFB2VGp1?=
 =?utf-8?B?bVN1cUljdXNscFY2aGdZU1VNUEE5NlUwOG9qSVVSYUs1YyszSFI0VmgrZWI3?=
 =?utf-8?B?QmJmeHRIUTRLUG5xUHRTOHBVQ3QrRWJWWGJKMEVaYlFEWnBONERidUJ3bVpz?=
 =?utf-8?B?VFI2Mlc3ME50ZmVReU1zVEpwaFFkTU90WkFXQjF1NCtiVVduV0VlT1RwYk9l?=
 =?utf-8?B?VEEzV2JMWmNNZTlXVmZBQWlnNUZjRDlNVnJYRm0wUUhMcDFrZTc0ZGQ3ZVBz?=
 =?utf-8?B?M09ZV1V4L29kWTJWbkc3ejVsZ3QwU1RBTjE3UWFpT1hjaFU4RmhIV0pYNThL?=
 =?utf-8?B?MFdMNnpsRm5LakVGNnhWQ3lBTnZwS1pWR2lKdFlEVzhXczBhSU1BWVUvUDRv?=
 =?utf-8?B?cVdsQ09CYnZxS0R1aFBUMEJ6cmk1b2tkTlpJcUNFclhja0RLcjhwckhqcmZk?=
 =?utf-8?B?QjZ4RkQ0SDY5M3JOZ1JMRkNWRFBrRU9tN2dNb2sxQzl0VUJqTnZzeks4c0Mr?=
 =?utf-8?B?dFRnVHp3ZFFyNzJPMzVkVnVCQ3lYK3l1NFZRR3VnZTRUYm9TNFdOTVRQbHkz?=
 =?utf-8?B?UzJqNkhrNGlucFpFYVhMbGVhcFd6ZkNQaUtzdzFWSTc2T1pBcml3Sm10Y3Ar?=
 =?utf-8?B?UVdsaW5GWnh5QVJmWnZJS0pLUjk4MHM2VUxNWE14M0pFTkNmYU9EUmRZZk15?=
 =?utf-8?B?YTNsNEpoQVRmNFlyd0NGajJKSVYrcHhKSE5pNi9kQjg2WDgwZktrMXhoWnhW?=
 =?utf-8?B?UVVJMkxZYVRWeVVuSXEzaG5yWGNzTGZ4WkFIMlJLdEd4VFRSRzE0N1NrVFha?=
 =?utf-8?B?cFEvZTNIRW5pUFBDbFNHU3lxWDB0dldieEs1RWRqbFpjRjJZV1NMaWlQbkNJ?=
 =?utf-8?Q?AnZny7ujhXo/dktE=3D?=
X-Exchange-RoutingPolicyChecked: 4GWkIeh/yMFeyZL+oNoCpY+dkO03T2DrTlcfNhM1LXOZnOKqqyM/5Bp6og2Vlb067/FpCgmasR49MZZ5bfq5n8so8cXs2N5l3LrmDciqcPBojPPQwHFn2sWp8qt7UVIZM34ouywzbL3AtuWQDcD44UJJ19nSWQXD81SRxGp9zkJdfqs3Qyy5t3b2Xn5qXA3VF21JCuGV6iPhDx1/OXMkG0oOilOUQ1SGc/kmOlWhndW2UHMMryRoiddpQcrJxA16qQkWomVO2fro4AS2JQVoxTB48uyHHtlrlIsktGVoxQGpIgqwn58pVIUAc+Gue+GQ5BSREnowWjTmoQstKoq4CQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df5116e-d13f-4c37-0f1b-08df22bb9f53
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 08:35:34.1095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NnvxgU7GahOlpmc9jdzUXB28YsJDj7T7qxgLiq15xDT5Yj92mcSc33t1Z5T+HbeJycTFqinX4zFObvBCJg49PiPZ7JMXof0CPbuTl/mKlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8759
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

On 9/19/2026 6:10 PM, Medvedkin, Vladimir wrote:
> 
> On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
>> Use the new flow graph API and the common parsing framework to implement
>> flow parser for SYN.
>>
>> As a result of this migration, queue index validation has changed:
>>
>> - queue is now validated at parse time against the configured number 
>> of Rx
>>    queues (nb_rx_queues), rather than at install time against the 
>> hardware
>>    maximum (IXGBE_MAX_RX_QUEUE_NUM)
>> - the per-function queue bound check in ixgbe_syn_filter_set() has been
>>    removed as it is no longer needed
>>
>> The syn filter tracking infrastructure is moved completely inside the new
>> engine and is removed from the rest of the driver.
>>
>> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
>> ---
> <snip>
>> -
>> -    /* Support 2 priorities, the lowest or highest. */
>> -    if (!attr->priority) {
>> -        filter->hig_pri = 0;
>> -    } else if (attr->priority == (uint32_t)~0U) {
>> -        filter->hig_pri = 1;
>> -    } else {
>> -        memset(filter, 0, sizeof(struct rte_eth_syn_filter));
>> -        rte_flow_error_set(error, EINVAL,
>> -            RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
>> -            attr, "Priority can be 0 or 0xFFFFFFFF");
>> -        return -rte_errno;
>> -    }
>> -
>> -    return 0;
>> -}
> <snip>
>> +
>> +    /* check priority */
>> +    if (attr->priority != 0 && attr->priority != (uint32_t)~0U) {
>> +        return rte_flow_error_set(error, EINVAL,
>> +            RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
>> +            attr, "Priority can be 0 or 0xFFFFFFFF");
>> +    }
>> +
>> +    /* parse requested actions */
>> +    ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, 
>> error);
>> +    if (ret)
>> +        return ret;
>> +
>> +    q_act = parsed_actions.actions[0]->conf;
>> +
>> +    syn_ctx->syn.queue = q_act->index;
>> +
>> +    /* Support 2 priorities. rte_flow priority 0 is highest */
>> +    syn_ctx->syn.hig_pri = attr->priority == 0;
> seems like inverting priority with the previous implementation

Yes. I am not sure what to do about this, because the previous priority 
is technically wrong, and my current code is correct as far as rte_flow 
API semantics goes. Should this perhaps be a separate fix before the 
refactor? To be perfectly blunt, I don't think many people use syn flows 
so perhaps breaking backwards compatibility won't be a big issue.

>> +
>> +    return 0;
>> +}
> <snip>
> 


-- 
Thanks,
Anatoly
