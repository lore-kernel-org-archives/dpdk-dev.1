Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427B5C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 03:13:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEA2E40664;
	Wed, 12 Mar 2025 04:13:37 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
 by mails.dpdk.org (Postfix) with ESMTP id 4E5D740264;
 Wed, 12 Mar 2025 04:13:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1m4pZztE9j7ohPTeD0Ky/9E2wtlrXqGjc2cnh1+AYXWECUpRdPXQTIvAiui+ZLtBGjqsEYDTZMNkdG3bv+pSzxvNdRRvcpYvGk/4fmGP2LmtLeo51QobRuUqk4D3uHZsqBWgMLbC/wibGc0i5E9mDXDu5s5sNXFGexgxHfFXqmJcVJH3UPDnMZ+B81CSwzDnT/c5ax3eZj+/Rh35UVWB/6c1kLoWJsNL2EjA+yzJql0iHtkA5ffcjvhSkjr0WcAfz5LZyPC9qUGORpA+LkajzibcPCkufRDWQaGQ9Gzt3J6NANB+4FDrR7R9TySh9XpR3oLEWwZCHXN7Y3LTcIIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1YjWbjm8IfOtgrTjQGWXKCWdw86LdBQRtjlL7RCEvs=;
 b=CXV2sfulCyruewNdfRuJwcsbEaRMT0PAwVKhHkFvcy1UZNlHQb3GB+H9dq2/AgFb2Qgue2bI80v1XknMWVMWbfYPGf4OSMOqBzXfGncUIbcZjtRpIMxZBYIHDYwiaRs5R1QPARlvtMYxEcbflr2hD3wN9sLJtpEi6pvZBCQbAZy9wV1UEvLDIjQUObpeXI8NFWEGFMQTJkoVroLX0cFw1gIT30UuWB96CY+OHUs/2uJlQrJ9uldi3Y0WfWyQJddLDwTLDYjV7WYBNEXS0JrsCBqm2/YctROUCou2xjQPo80GW4YV3STnurnbcmVGt1TQXx609yqbtyyJnwhZ6YPBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1YjWbjm8IfOtgrTjQGWXKCWdw86LdBQRtjlL7RCEvs=;
 b=PDkA/YUZjtDj2+ONEcCrmk93FCkLTvivw1A0h+CG2EEgnqd8ETjAKZWY5GI/vslNNYHoFlB+tZF+qARFlkkYXFP2mpidiSLPeRvsGvkCQwDLs8rYH58nIA+8m05zQmx/Nx/AxwABuPj53C0A8Df42nFBEOTs78uVqxnQlKf0rll4YCKdGJ/yC+2aTxlPbfso/+X/DWZ1qf721HTwpOqMaNT+X98QfEYcNhxt2eNA+N8F+bbmTN+S46BGLRDVtkkudzW+LTjFQxDtYvxsjKPGQR9AxwiI+NC/lvImr7eAnZt0p0cFhUCIO6fCdC9g3VqoUNr7kz4hiFW/bgQySTnACg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by DB9PR07MB7868.eurprd07.prod.outlook.com (2603:10a6:10:2a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 03:13:34 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 03:13:34 +0000
Message-ID: <82920758-20eb-442c-a62b-a3babb65bfa7@nokia-sbell.com>
Date: Wed, 12 Mar 2025 11:13:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal/linux: enhance ASLR verification
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org, stable@dpdk.org
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
 <20250310144310.70ba71e6@hermes.local>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250310144310.70ba71e6@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|DB9PR07MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: d9841786-f58d-4db9-1b60-08dd6113dfc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXBtaC9ma1dib0puSVB3VURzMVRJWWRtdVlqYTBrVVMwU2R4dlVwRlJUL0RF?=
 =?utf-8?B?UEZuZ1NZdWxGeFRNc25FUzdHbkV2b2NGSXRUcHRwRXVqM1lFZlhiWFVGOGda?=
 =?utf-8?B?Rk9naTFMc1pxYmY4WC9mT0FWeE5BazdpeTR6UmlPT1k5ZVdFWFMzY3Jkb1JG?=
 =?utf-8?B?dHRBTUJhN3d4eWg0amFHdk5tWGNUNVNOU0ZtUlUwSSthMnFwQkd4Uit6VXYy?=
 =?utf-8?B?Mnpzd3NzQmZyTDJ3WTJjRW0vY2NTOWNjcEJvYzg5TGhVYTBLSmtodFFuakMr?=
 =?utf-8?B?OEMyNDd6cDdzc1JITWJlbHlWbzVzL1p6SXR5aWl3OHk0Ykh4QlVzcTZ6VDY1?=
 =?utf-8?B?cTFtNzU1cG93WHFKYitGZTJUa3dpcWsvcjdBckIwYllJNUpkTFAvaEJaU01o?=
 =?utf-8?B?aHU4UFBOOFdxN2wyRE14ZllFU0wweFhNcXpOZHFRdlVGRVdwR1lWWFAxWFRJ?=
 =?utf-8?B?RE5kUk0vd3hiejlhK2E5UTI2RDJ3Ri90bkNmS015SVl0WlNNUkVqU21LZ0NM?=
 =?utf-8?B?Sm5kdThwTGFFK1JQc1hpaGE3NTUxSEozMGk2d2ZkRzJ3NjNJd2ZIS0xodlF5?=
 =?utf-8?B?RjZjOEJ0VExmVnlQWWd3RU1tdkgwZVJFREl4ampkbGRtMUo3QWE1NEhqQnln?=
 =?utf-8?B?ZStjeXpnSTE0azBNRVNXOGJ1elYwVnBPYTd1cm91SGpxckJORytocis2TVI3?=
 =?utf-8?B?SkRpSEN2bjBaTEoyUHBzV3hRZDF4SHpSalZmbVJRVmJyYTdyTjkwcTUyUlNu?=
 =?utf-8?B?SXl5OW51a3RtSWcrVUFSVmNOaWFEVW4vVW5OZTNNMElmams0bTNkNFlXaUtz?=
 =?utf-8?B?N2pBM2dFdkZnMUFEdnJqemxxcXkwclFDV3QyUzFUVlRHeGszb3c0MktWQWRV?=
 =?utf-8?B?K3V0cHZ3MzROQ3lsRWFlUFpqaUM5Sjk5WncvbTMvSlFsdy91cENSMVF4Wk9r?=
 =?utf-8?B?NldBQU01RnJHcUJ2TThtcENjMVpLRXI3dmEvQkk5MlVQR09SczMzNHY4Tk9Y?=
 =?utf-8?B?ZU1odGZkNDdMeG0wL2t0a2VlcXpVeW43aHQxVE9jZXVRcUZQeEdwbTh3Tm9R?=
 =?utf-8?B?VFAxMGVBUkZRTG5IOGFxTEpITDh1cFp6eVRWQnVvamo3cWRad1didWUyR0c4?=
 =?utf-8?B?S29OS01yVDhZYmNJS3lzT3M0UFdjanZEaEYrdlZ6SjQrR2JDRTY5Z2xuTzBZ?=
 =?utf-8?B?LzVZNDBDWi9BbUpGaDk5c1hodkRQd2lOY29EdXdNT2V2NkxLMTliaHd1UVFW?=
 =?utf-8?B?L2I1RnYrRXNxd1NhQjRpWnV5eCtLeWNHdEtBa2VtR25teDBVK050QWJFRHFM?=
 =?utf-8?B?YzU4VFU1THlLTHNjRnlvb25ablU3dVZOQUw5Mk9ybEV6a200OUxlK0UwUWdq?=
 =?utf-8?B?VFRjTHVXNXhJYStiOFA2QmQzWi9yZWlGWUNkcm9XWUV6SHpjSGFvSlNLSkgy?=
 =?utf-8?B?RzIyelZicU9WZ3V2YlYzbFJNUldwQ1ZHdXk3eFg2M3hraGVLNG9TSTl6Mk5H?=
 =?utf-8?B?WWZzMkJpRlNnQ1FiY05mVzU5bStPL2RSeEh6a2NXdFl3ZVNsR09jbExSVFp2?=
 =?utf-8?B?Rmw1aHdFSk5MbnB3cFpWcmhwTUI3b1BIZGNJd28yMmFBQ0wya1Y1aGpOTnpN?=
 =?utf-8?B?QitYU0lJemNXbGdRZFI2SkZSUlN1NGVRU1NEVGE1MVExNENkSUFtTGcydEhx?=
 =?utf-8?B?cFpJWGo4M1pFWGlpUk5lMUNORkx1aDNyUFVKV2NYbkdGQ2Nxc0hXVDJyNWZu?=
 =?utf-8?B?akJ4WkJ3OE9xOVphSy9sT1JFc3U1SVVFQWduRmtjQTFhOEpuWC9MUTBqbTA0?=
 =?utf-8?B?OHh3ejFXdUFHaU0vOEFjUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFMekE1UVpBbThEVFZOVHFzYldYY1hBVGZ3RExuRXJnbEpodXNyajdSQ05i?=
 =?utf-8?B?eTZYKzRHZGh6ZG5xY3RuNGcxcXN2OFlwUHhiZjhiUENzeFBPNHg0WEs4Tm0y?=
 =?utf-8?B?bEJtZnIyakxlQUsxWTlzbExRZ1dZdlpUTURqbFlQTytvYnVtUm9WbVRqWFBJ?=
 =?utf-8?B?cUdDN25jNVlmbHIxK2hhcVRmRGhDbXgrcmZiUUxWampTZ25CZytLWm1wK0xM?=
 =?utf-8?B?VGJjL3pvcWRsdFJjK3l0aHdtK2hYeDA4VTZ3QnZEc2FCcU9ZZ1V4NHg3MkZN?=
 =?utf-8?B?Ym9lNDFYc2hYM0dZUC9qeXRvSGZ1aWpUZzNHOXVmNzRORVdheURqcHBUQzdq?=
 =?utf-8?B?TkhGOUU1YTNyeHRKR3U5bmlCYlgzR1ZZaHNTZmZINEd5Z0kraUN2bVpjc3cw?=
 =?utf-8?B?VGxVT2xEUFl4bHhUUUVXRTRxZU9KVnR3K0k2bVhjTEVuWXV5b2Y5cWUrTG1x?=
 =?utf-8?B?cmJpWTB5aFNZdlVzNHdsUUFLUHNMWm80aGVvd2E2YkIyUkVweVU5T3hWNzRm?=
 =?utf-8?B?blRZQXJKNzlaSldGOUl4cldieWNjQWtDM2xoTXBndGV4UnVHbG1UNXVrWTBm?=
 =?utf-8?B?VEZBd21POG12NHVPR3FYWXRlQ1Fqc29heU1lZWplVHIzVTNhT0hCNjZWS1p0?=
 =?utf-8?B?KzU4U3p4aHFZakRWbFIvd0hPR0R0YTVXYTkxNUVkMVpPSUNXOUdleXdRcUk0?=
 =?utf-8?B?NTlWVU81UVZyTjdYaUhqWnBhalVuMnY4UWZjUmYyVnI5R1ZxUTk3VzZEREFw?=
 =?utf-8?B?M3VMaW9NSVl4M3BjWWNHekVGeVZhaGgwdExOYnBXNkJLdmNOQW9qTnE4TTg5?=
 =?utf-8?B?NEpOcUx6c3pXWGNZcG1sT3lXd0RENHVsV0w0RUN6b2pWL29uaHdRNzBQVkU3?=
 =?utf-8?B?dis3L1UrTUZ4SFhkcUt3TjljK1RyQUFPUnVJK0RMcWJ4elM4dzBqalZHc1pC?=
 =?utf-8?B?d2I4djhhN0dPS3VOUlZSWlA2OVZPc0ZxaXl2R0xsNlN5WE1SUVpnMXFMZ01O?=
 =?utf-8?B?UFVnaGFBSTJyalM4VHJJUVd5VFJjSVVkejBLMlRRSmw4UmpBMHhzTUNuaCtP?=
 =?utf-8?B?Q0xrNXpmZFZrODVyNGpCakhRVFBvM01sRTlSbThrVkdzMkp5dDB6eUlZNGxt?=
 =?utf-8?B?aWZObDl6WVBNc3Uva1JxTzFFd08xV2NmTmFvQ2laeE5KVjRLN1ArcG5LMXM0?=
 =?utf-8?B?Yk1oeDl2dWhlZEttbVBPbWN5endBYnI2cVJVSVlJS0c4Rm1aNjhDMTdCSXB5?=
 =?utf-8?B?K00rTkE4OU9nTEQ0cjJvM3pZSytJNDR1L0VBdWZZSGJZL0RUcmtrWGM3aGNy?=
 =?utf-8?B?R2F3YTNTY0RpRUwwY0pWT2Y0VmxLeDdyUmYzTEZkK2dMRU1uTExuZ2hpRmh6?=
 =?utf-8?B?bDNZS3BpeHpsN09icHdQTElyWmVoSE1XVWVZMUo1emMyQTJCVGlGSDFzOTBC?=
 =?utf-8?B?RWtJNTBoVWdRanFkL3ZYbDVET1l4aVBzN3RTZmFDZGRVZ3BYVExvS3UzN29F?=
 =?utf-8?B?M2RWb2lWa21ZRzlyUC9peWhnSWNEMFpGV1dhR3JUeExxbXlHclpocmczbFNF?=
 =?utf-8?B?TSswZW0wWkU2dG50Y2w5b1kvL1M3Vy9nSEtMa1pGOVVPTkRQWWhLWXdFZzhV?=
 =?utf-8?B?eUdzY0FzenlHZHIvako5NFJLcWxyV0RGd0hDQUpDWTgwVlhiWUZIRVliNkVB?=
 =?utf-8?B?V2JjVVVxZFpJME5sdkt5bDFzNElRYnE5bVo1QW9LK3hnNXEwVC80bk83cDJk?=
 =?utf-8?B?dXBQZmJNYy8zTFZucG1FL2RIYmJ4d2xVbmcrcXdjUmFVMlJQRXhMUmlIYXAw?=
 =?utf-8?B?dGd0UGdwWnk5aEFNVEl3RXJFWUlSdWhiUTNkbTJYYlRuaE9vUFJzK2tncGtm?=
 =?utf-8?B?c0lRY3U3TWczTXhXN3lWT0RCa1R6QzJPeWVkelMvZ3Vnb1ZQNUZiOE1YSU01?=
 =?utf-8?B?dXo0OEJSeGV4Q2xTd2w3bG01bU1XdUZQdWx4K3ZXcHdtWHJld1FTTXlhZWlE?=
 =?utf-8?B?dzZlTThRazVER1ExRjNqUDFMS2kzQjA5V0FLMXNJVFdqSk5LSG0rdk1wa3dt?=
 =?utf-8?B?VWp2aVR5eGhxYWVQZ04xM1Rjd1Z4VWRHVEV4bHZXbCtNdmZKb3dMcW50N3Zw?=
 =?utf-8?B?M3B3MW9XYTdOYkxmcW5jcWdLWDVFc1cwc0V2bUdEOWV1VlFCYUp6UEJEQnR5?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9841786-f58d-4db9-1b60-08dd6113dfc3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 03:13:34.5498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpDQtZxqRDypUOUstJBniLAoUdnaIaa43dOOQlAMTnqWxlA7fQKmFeivVs4IMzTpTN7hGyveVlj3Vy08u0sCWp1L9zk7UtQrC+u13XemGDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7868
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


On 2025/3/11 05:43, Stephen Hemminger wrote:
> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>
> On Fri, 28 Feb 2025 17:44:04 +0800
> Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>
>> This change ensures that the current process is checked for
>> being run with 'setarch' before verifying the value of
>> '/proc/sys/kernel/randomize_va_space'. The '-R' or
>> '--addr-no-randomize' parameter of the 'setarch' command is used
>> to disable the randomization of the virtual address space.
>>
>> Fixes: af75078fece3 ("first public release")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> Looks good, I wonder if the personality() check can supersede the need
> to reference sysfs here?
>
Hi Stephen,

Thank you for your feedback. The personality() check is indeed a useful 
addition to determine if the current process is executed with the 
ADDR_NO_RANDOMIZE flag set, which can disable ASLR (Address Space Layout 
Randomization).

However, relying solely on the personality() check may not be sufficient 
in all scenarios. The personality() function checks the attributes of 
the current process, but it does not provide information about the 
system-wide ASLR settings, which are typically controlled via sysfs 
(/proc/sys/kernel/randomize_va_space). The sysfs file 
RANDOMIZE_VA_SPACE_FILE indicates the global ASLR setting for the entire 
system, which can affect all processes.

By including both checks, we ensure comprehensive coverage:
1. The personality() check verifies if the current process has ASLR 
disabled.
2. The sysfs reference checks the global ASLR setting, which affects all 
processes.

Therefore, while the personality() check is valuable, it does not 
entirely supersede the need to reference sysfs. Both checks together 
provide a more robust determination of ASLR status.


Brs,
Yang Ming

