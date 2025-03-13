Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D39C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 05:52:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F066440DFD;
	Thu, 13 Mar 2025 06:52:17 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012068.outbound.protection.outlook.com [52.101.71.68])
 by mails.dpdk.org (Postfix) with ESMTP id CD00940B94;
 Thu, 13 Mar 2025 06:52:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOpJ4cmOvC9rsNxCyNYHC8rS2SgDnOCWGAYFyD1/fmMBRtvKWCXbfghoc433BGceBF9Y84e1Yi77ORj+SpNeQtUQ4XlbgN/Jf/ULN/YC0HMiKm7I9uN82oi0V4Yj81blfUWEImUfPLNcGUW95Il0jXHdLwi1Uz9yrdW0GGfYXRyRDJF9PY3aWpCwq2fW8iFXykbW1lgQrd8ELswMqyttckRbkN4DlD2rfWtgMZBMW+ch7OOc9xUT5MfDHApbTlusLOcYcRb/XsC3C4nra0t3iS6t6KSQ4W/gWPGlaM+jeryGFkCUu+5utwcRqEjQsj8IWa5CvJfPA4J0KI9ni8HQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkTLYpstfVDaLga7zE/CCoQTaVU74CEBgoAbzlR/5UQ=;
 b=b+4Ixjar05MAYOVhBBq2QmgG+sScLSCrXS1jkAdrmxcSdkTAc1oZwt0FPdzOwjGZIqli6GTENlYOv+YwldWEv7QyXKcRWExi4U5xBRjWhFx96xOk1gqKVQl0riV6oBGyVWJ8jGRZZ0PrGPyndiZxekpcjTbntfzX2lMMpsXURtfAZ1yKg4DNq9PFLQayF9ECuzr+JUjgp84ofWr3oZ0EhC2xaJJu7DduyW3M90BWIPdHHfsuONPiiWkyoHSHvhotJgAyJMIdBreelU4vx+AyMFJG/MF1YYcvU8Ix8hMxr9+T9RTtLZybcoUjeFNpacatX7bQJRyQFDWHqGKNy3L3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkTLYpstfVDaLga7zE/CCoQTaVU74CEBgoAbzlR/5UQ=;
 b=b+7ihcxM7u2+5ipn38P5/uVLhT7c2Y8NY2sW+i/AwU+BxcNLZ8C/2vwrxxjWzyJwd03N80BN2G9qPIlMuoEsFn87r0tui7WxdYhNxf507cAJq9KSYCIg1WaviIzwVYnfc4zO6uIvbGBiwUToi3Xu9wpL3HBhiASeAm79os0tjzCjgkhBq5vZ6+Pih2K6jWskc4/U/Lb57zjaKDmdlabKxvrr4tlM+e+S8Zlqrmj+eO6Wkh17RTnUG0dHzqiRDUhySWEKPM+SlwNJ1Q6WvXa5Rz3qhh4mNN8kwOD5WXuekNYMkfyaGAZK+TlNjBX4dov8BIhIncDpMtQ3UqriYt2sjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AS8PR07MB8943.eurprd07.prod.outlook.com (2603:10a6:20b:53d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 05:52:15 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 05:52:15 +0000
Message-ID: <a2fdc1c4-8284-4403-97bf-967bd84ec387@nokia-sbell.com>
Date: Thu, 13 Mar 2025 13:52:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] eal/linux: enhance ASLR verification
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org, stable@dpdk.org
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
 <20250310144310.70ba71e6@hermes.local>
 <82920758-20eb-442c-a62b-a3babb65bfa7@nokia-sbell.com>
 <20250312092922.32412cd7@hermes.local>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250312092922.32412cd7@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|AS8PR07MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d4427e-6eeb-47bb-ac44-08dd61f33528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q25CRXM3UEVvNmVUK3lyL1RLQXhoWFh4SGxKaCt2azFra2JqSUUvVkd6WVBQ?=
 =?utf-8?B?dHFQTytJS1ltZ2F1b2hIV0lzbGl2UHhQdDJBaW1GaHJMM21OakR0RGRYNWVB?=
 =?utf-8?B?NVk0ZFRqeGFMeWJaWVBkZCtIQzJ5U0ZRdnkxNkhHckhZUndmeTJMM0w1bVpr?=
 =?utf-8?B?STdnc3pLRGM3OE1zWWpHeEVoaVFTTWpVZS9JRlJqdnJCQU11dEJIRDB6bjNj?=
 =?utf-8?B?d0ExOGNPWUd5cklRZzhvMkw1VHRNdHNSYk1STFBKUXl5V1dNMkVqR1pqZ3BN?=
 =?utf-8?B?b1ZCTU1ZY082RHl6bmlNcXlDeEFiSndOQmhpb1djeUlqSWI1SVBCeDRULzlV?=
 =?utf-8?B?d2Z1V2RqL2V5R3ZTWkNENUsrOGZsb2J3RjRsU215K09FMVNobXFOdHRRUE9Y?=
 =?utf-8?B?TzViZEZ5SkFSdEEwc0NNYnkyZzBYODBWUnJrYSsxbjlSVlVhS0t5WFpxMGlY?=
 =?utf-8?B?L1hRdUg0bjcydVVNeTZqbVFJUGlPYUkrbmdYSGZ0ZjdSeFhkaEFtclFuVGNy?=
 =?utf-8?B?amlQdjZ5Z3d6eGhKM0pGQzVnZXBFanU4dGYrZGVVb21qeHJ0LzhkMkxBSktU?=
 =?utf-8?B?S3FiSnZxSDRWTWJaTG52Vm1oU2htaVJLbkxFc24raTN2T01iQ3k3R3lNNEpZ?=
 =?utf-8?B?MUtBRTFtcVNYVExpWVh0RVFIZHNQZVMxV0Y2K3ZXaVNGZEdGYjhqOUpPcERT?=
 =?utf-8?B?anhWWlJrSDNFeStSWk1iZEh0TitDTHlaMmtBRFNYcFhyRy95ZTBWVU00WGlC?=
 =?utf-8?B?NlZrSUhvVDcxd21zYXQybnhsT1p4WVEvcUMzQVpJYmtJY0M5NWlBVERrQklP?=
 =?utf-8?B?a1VlRUIveGZqRTlTMjVOTXFLVDZZWnBCaWQzNzJ2U1lUb1JzaVRZMkR5bEtz?=
 =?utf-8?B?cVVMMGphbVRYRUZwSTFscis1Q2V3SWFvOElpV09PZmlFZHdMeWxwNTZ6MDBh?=
 =?utf-8?B?c3NYalB2dWZraFhOVVRJUnhaSGk2cUNFZWppZGI4Q0UzdUJKNlMyNk9GcTcw?=
 =?utf-8?B?dXBmRHhzU1ViMWdGY0lvUzlZUmhqbVZEbm93OFk1bVdCc0pQQy83YUtRRHhU?=
 =?utf-8?B?QjR0b0UyQ2E3SC9kMW9aeWxCd3lHVnN5MVUwVm02SUtta1N2R01BYWF6Q3N1?=
 =?utf-8?B?MVlUam9TbkdBQUZ3VzF4WWtBcGZXMUp2VXE0ZTJrUU02ZUY2MTY2OXA1YkJI?=
 =?utf-8?B?QXRQTmJtWGptaFFWY0FHSHhKZ2pPOTRZa2ZqSSsxT3JvbUk2ZUg1R2dBT1J5?=
 =?utf-8?B?S2pXNHRyYlR5dHZyU1dOTzVXWmY1aU9nSGxka21XME9nR3EwSHVacWd3OE5C?=
 =?utf-8?B?SDlIYTFhTEJRbnY5UHVFWCs2RG02bDFsbGtCYVloMnR4YXYxZ09Mak4zT3Fh?=
 =?utf-8?B?MDh6Rm1PSGM0OXBrNmpmSk4zbFNGUjAwUHZYb0t4VHFGdzZDK0gvTWhuL0cz?=
 =?utf-8?B?dk4wamp1RGdkVnlvV2dVSTNuR3FMYUp4M2V6QTVnREprUlR6Wmdvc1M5VTJl?=
 =?utf-8?B?ZG9pSjZQVUtpK1N5QVNUcmtEVUZQYjE1VmtUblluM0xCUGlRbVFxaEkzTmUv?=
 =?utf-8?B?S1hWOU12bUxFV2UybkRGSlV0VEh1WkNNNU5iTmRqM2I4UUd5SkFwY1Vwd2sr?=
 =?utf-8?B?UERQN3NFYVNSajZodnpiVnpwV1AxaStqdlR2UHpObE8yemVETmZkWWJsY2VH?=
 =?utf-8?B?eXNEdTJadTRnaE9uVStnRXNFTGd1b2tKYmlMVkg5ZU53a3NiQ0FGL1kwRkxF?=
 =?utf-8?B?eWdYVDhkS3hVZnhxV2FKeC9WNnFqSUs0Y2VNaThCS21EdGxOcUtCWWFucHNw?=
 =?utf-8?B?SnFEZ0JyV0E4Sko4a1d6MDUwQzZsY25pV2d5WWJuNjc2WXZiODRaMGJJZ0k2?=
 =?utf-8?Q?CdrWCwTd8Xd12?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0twZG1mZHJiU0pwVEtvUSthYzlNWldtOTNGQVEyT1I2ZnFkdXNWNnA3Um5o?=
 =?utf-8?B?dUJoRVJpekVGbDA0VlBDNXFTTGNBNU5xQjJvdzAvank5WFBkdDhrQ2xhWGFo?=
 =?utf-8?B?UmxZRjNPVTNqWEhqb1ZYc01NanJRSm5lVk9VQ0ptVk1jdWtaRWpDSmdYWUVu?=
 =?utf-8?B?WE5sUGFrZHcrU09LWWdVTVNWVndQalVWL2hJTFMxbStGSi90OTdHTjRCMGtp?=
 =?utf-8?B?QWJidFprR0owSkFuRFZ0VTRSN21GR0NMbElmd2NjVmZDZk00d0RadDJsdmln?=
 =?utf-8?B?bVhvWW9NTFkyWjhVVkJNVmlIOU1PVnVRUzN1RFVHckpucERVTU5UeldhMnRL?=
 =?utf-8?B?d2NPcGY1TnhFQ1h2VGFqSG1jSmZDcDRNcWNlWURXMDFmSGJFN0Y3SkZpNFNq?=
 =?utf-8?B?L29YcGRqeUU1SXZmWXprRlRndzdqMXI3Z2Q5RStyZlFtamZSMmx5VUdSWkpY?=
 =?utf-8?B?ZU9FM2NPcTBTVzlKK1RLZmZYenhCR09nU0FubkJnOWZub3FiZ3pQbkJ5Y0V3?=
 =?utf-8?B?QjdFd2Nra3NnZXBZOXBVSmFrYUNaZGdFUUl3STFBL3ZheEd3MkpPWVBQVlZ0?=
 =?utf-8?B?elVkYnBUV1l5VXdLUXpZWWxJVGxtMFd2dHZ1WVNPQ09tdHAxaHorTFhlSjZ2?=
 =?utf-8?B?WlBHVmJBTWx0a2UrNFVraVpBWjVlak9TMUFOTURySTYwOW83NlhHcU5LMHdp?=
 =?utf-8?B?OHVwOFEzVzVYRFRuS0ViWVMzQk5QNUtQQ1lBVlQ0OVpQa2RvYVVJaHB6aEJX?=
 =?utf-8?B?NnV4Vk5xUW4yVm85TXdUVVBVenlJTWRpODN4cm8wM3pENTg3a2RxM0s5NW81?=
 =?utf-8?B?TGpFNnd4UEpXQ3A5UVcyRXpoZkZRblVpSXFVSnlyV1dPRFdDdnA1SVdIakZ5?=
 =?utf-8?B?eCt1RGMyekR5bHFZdWRvbmRJTGpDN1BmRTFSRFA0MWhPRG4vNjVJVC9xM2I4?=
 =?utf-8?B?TlB6TGdaQlhHK1dHOFFQaHpWYVF5U2cvNmU4TjBFQ0RJTzdrTVoyR1pLcVhE?=
 =?utf-8?B?a3dNZVdMQ0dibSt6bmxPMjM5R0sxSEdSQ3ZuMnhyMUdBY0FKRElidFBTTDc2?=
 =?utf-8?B?TEFLTlVxRzJQUi9vdHZ0YVZ3bzAwSVFpbHdJaGRkZ3RjKzAzaW1vRWlDWkxk?=
 =?utf-8?B?OEFiWk9jWXlEVmpNQ1RFdGMzcG5ZVlZuTWcwYjNXeFl2c0ZIMDk2QXp6SU53?=
 =?utf-8?B?ZmRIbkc4TUNGU3BGUHdyMmxGamdQR3FERzJoTXNUQ3llMzR0c05FVzYyaWtG?=
 =?utf-8?B?ZzE3eVh6ZkpidVFKVVA5STdySkgxRmpnRGVaWGdYT0FOOENWSVBvQkhHbnlS?=
 =?utf-8?B?a2hXY0U1ZWFSV3FzR0lKMWVhejFueUdTa0RLQUd6R3BkUWcrVEN2cUNvbzcv?=
 =?utf-8?B?cko0UnVjMnJjWkw1SlJkRkxRUmdQNEZXWE4wSmVhZEozM2ZiR2ZUQW5DbzUx?=
 =?utf-8?B?VHN5MCtOS1lyN2FPeGpnRnozemZOYTBaT3dla09rRWN1MDRlVGV0cDZEaU5E?=
 =?utf-8?B?Z0FsNkpNRmVwUVhMZkV2UzBVNVcrUFdUN1pBQ3BxOGxHQ2xNRm52RTFFMzNM?=
 =?utf-8?B?ZHJrNDBabHpUTXVDOE8zTENMSEJpOEZZdkUyZFRGc29qWkgyQzJhUERFcEJp?=
 =?utf-8?B?d1NZN3I3YjY3akluVU16SmhKR2RNZ2FJS2phbjVMWVlUaUJNVW9aT1dKSDh0?=
 =?utf-8?B?TUtqRGUvOXNLemh0eHhmTnFHOXUzaXk4d1grb3UwS01DRkxNSXVJbkRvTnJL?=
 =?utf-8?B?Nm9VZDhaQ2orQ0VWVG9wb3IyRktkRWlKcVYvVWlpYVB2d0dWNU1aWTZHV2Vq?=
 =?utf-8?B?ZlU2U2VzU1NlclB1eFhmVDZmM0ZKWUZoRGFGQUpPSGxMQlNsMzJXamErZmZ5?=
 =?utf-8?B?VnpTUytYbVQyNHhrVmo5NFYrMERuemRRYUxWZTFkdVE3M2FmOTluejFTdUhh?=
 =?utf-8?B?amlmVVB0MHlBVUIzSjNjbkEzNFgzRERqK3FmOExLL3VPd3U5MHBDUE1xT1VK?=
 =?utf-8?B?dHI1Y3luT3B6dStNZ0NINGpBZjkxUlN2eExPbHJhaG1jZnhhc20ydFR6cTNl?=
 =?utf-8?B?S1BJTWMwenpxbTQyVFl2YjZqVE9icU5vSWE3S1RQcHIrMjREVmFmQ2FySXlJ?=
 =?utf-8?B?cEFpUTZHb1FGMzN4RzY2QlZPeEVUbSsyQUw4YS90c2JTbmVMLzNsN1JBWGIx?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d4427e-6eeb-47bb-ac44-08dd61f33528
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 05:52:15.6013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZGic3rIoJ6IeFO4nU4yQ4eByArBfRW3JnOyakM+MKa7x+qJzRny2Ee7Dm4Tm3sBvsUbAl3cbMx280Z+zM7nycpy7oOWKhJWsQmV4TrJjc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8943
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


On 2025/3/13 00:29, Stephen Hemminger wrote:
> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>
> On Wed, 12 Mar 2025 11:13:27 +0800
> Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>
>> On 2025/3/11 05:43, Stephen Hemminger wrote:
>>> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>>>
>>> On Fri, 28 Feb 2025 17:44:04 +0800
>>> Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>>>   
>>>> This change ensures that the current process is checked for
>>>> being run with 'setarch' before verifying the value of
>>>> '/proc/sys/kernel/randomize_va_space'. The '-R' or
>>>> '--addr-no-randomize' parameter of the 'setarch' command is used
>>>> to disable the randomization of the virtual address space.
>>>>
>>>> Fixes: af75078fece3 ("first public release")
>>>> Cc: stable@dpdk.org
>>>>
>>>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
>>> Looks good, I wonder if the personality() check can supersede the need
>>> to reference sysfs here?
>>>   
>> Hi Stephen,
>>
>> Thank you for your feedback. The personality() check is indeed a useful
>> addition to determine if the current process is executed with the
>> ADDR_NO_RANDOMIZE flag set, which can disable ASLR (Address Space Layout
>> Randomization).
>>
>> However, relying solely on the personality() check may not be sufficient
>> in all scenarios. The personality() function checks the attributes of
>> the current process, but it does not provide information about the
>> system-wide ASLR settings, which are typically controlled via sysfs
>> (/proc/sys/kernel/randomize_va_space). The sysfs file
>> RANDOMIZE_VA_SPACE_FILE indicates the global ASLR setting for the entire
>> system, which can affect all processes.
>>
>> By including both checks, we ensure comprehensive coverage:
>> 1. The personality() check verifies if the current process has ASLR
>> disabled.
>> 2. The sysfs reference checks the global ASLR setting, which affects all
>> processes.
>>
>> Therefore, while the personality() check is valuable, it does not
>> entirely supersede the need to reference sysfs. Both checks together
>> provide a more robust determination of ASLR status.
>>
>>
>> Brs,
>> Yang Ming
> I wonder if EAL should have --no-aslr flag and call personality itself?
> Maybe not since it would have to happen early before other areas are mapped.
>
Hi Stephen,

Thank you for your feedback.

Regarding the suggestion to add an --no-aslr flag to EAL and call 
personality() early in the process, I agree that this could be a useful 
feature. However, implementing this would require ensuring that the flag 
is processed very early in the initialization sequence, before any 
memory mappings occur. This might involve significant changes to the EAL 
initialization code to handle the flag appropriately.

For the current patch, the aslr_enabled() function aims to check the 
ASLR status without modifying the process's personality settings. The 
addition of the personality() check provides a way to detect if ASLR is 
disabled for the current process, complementing the sysfs check. This 
way also required to support the function of "setarch" command.

To improve the patch, we could add a comment explaining the rationale 
behind using both checks.

Additionally, I will restore the blank line between the #endif and 
#include <rte_errno.h> statements to maintain coding style and readability.

I will update this patch accordingly and send it for review shortly.

Brs,
Yang Ming
