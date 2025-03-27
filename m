Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A722C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 08:02:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FA4A40661;
	Thu, 27 Mar 2025 09:02:23 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
 by mails.dpdk.org (Postfix) with ESMTP id D9D0B40261;
 Thu, 27 Mar 2025 09:02:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/utzdd2TwuqjzV8g51VKiGI5C7/duh80i5BxhuHEpLbGY4zESpUE7D2nIpLzdQ0OrQfLrj7iPh0LkMDgzRP7DRtn00jg7w3OkQZ3RYRbzyK0jfCScpapKPk0zzsVRG4pK6DKODnnwx24oKS9ELvBh9wwEwulHQwoyF2NbKaSyeDaXovF4jcukrZ02ofmvLl20pfXxUwGh3y7UfJiP2ZymF0ya3VxRslp27DUL3pVPycHBAV7XaIlJImiG11RvqZf87BAP3KMJhKzE62ZkC97qUXyhrgCHtMrSKE824gjI9al7eCzZuLYxgkOe9+QOVBDk0kypIUlhPkb2wAlrCASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgqKuA4W4FPfh0SGfEmf8UL7GiZm7A4GEK+WkFMoI8I=;
 b=aMvHoYDSz5yQjSfxmyYkRlwQryLBJevE7Hup4KpEF4Mif+M8YIq/2g2U/rA16WpSBoPd5FhH24dkYEJyhBruXc7ejDb1NUrIQLTivR9SADhqLxGgUZ6gvLwv7HeGx+fWaa6rPE7fTAn8EVJfjpu6IYoyHNQKmRfIQ44vYZiD685dNakscUbK/amDuKes9EwqBs6us+7Lz1ZpetAnf0Q5A0usU8gqjkRCIltG8JlBHe395Rf4pwo7mBPT0c1dFrMm6JGevnyxUfH3VYwkowPqg1po42FxUd0NPenY5mi2MTZChWWOP8Fjn1VZYEIjrKMzCJMvfyyhsYN79gHXEkP1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgqKuA4W4FPfh0SGfEmf8UL7GiZm7A4GEK+WkFMoI8I=;
 b=GIOOVKRyhS6tQYnJYdZ0IRs3USgUVPsMJf1mTT0p2ee+odYusA7a2bO1jfz81bkQnEy2BKQv1PmQttWkaEvxsxgAzsGGQxWAdbuPCtIfUUop/icHvIz8ZdyGWXhon9nwMicK5lqUw6LGfJaORWlUG34HecnsGuL5TYGZXKVtYZx4hXcdEbkO9GPaDv1e5KN32wpbUrnD3ynkbWDsi0XNiL6/QMyXvd8z8DN0vXxAFQamZCBxb+gqbkFFDtfUAWlBoecxDYNbp3tyE1GCAPNLY5VmT/VXXn57RQ+ff6gl37C4GzYk26dGZ4wDreaOCTRZ3ijiXGy7d8kq/12+cYkxEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by VI1PR0701MB6765.eurprd07.prod.outlook.com (2603:10a6:800:192::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:02:19 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 08:02:19 +0000
Message-ID: <9fa6a076-e187-461f-9899-a53e891efb21@nokia-sbell.com>
Date: Thu, 27 Mar 2025 16:02:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2] eal/linux: improve ASLR check
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
 <20250313061904.1466-1-ming.1.yang@nokia-sbell.com>
 <20250313083733.203d132c@hermes.local>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250313083733.203d132c@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|VI1PR0701MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd02942-4271-44c7-c726-08dd6d05b26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG5GUUorU3hHUjRacFBpZUJtcEtYZ0E5OHJuKzdsWGFqYS90b3VnL3lnODc3?=
 =?utf-8?B?Tk1MNSt3VlkyN1psZTgyM2RyK0hsQjNBT25Pck9iZVBtTUlyUjZELzVlWjlH?=
 =?utf-8?B?dHdYeVRTR1dEVnJSR1VDV1JXSFVVUkpVKy8vWEc5b2lXSnZvVTRJOEhIT0sw?=
 =?utf-8?B?SHdrWWxrU0lYc3FWSXROZ1BIek1UYVI3OHRDZXNlaHhoK3M5YmtkbGY1RXZi?=
 =?utf-8?B?VnJjb2ZqRm9pSmpUdm1jdGRxWHRsN1oxazZHZTZ3cnVpNURCeHNudVl4bjYv?=
 =?utf-8?B?WmhjYjY1TXByQ1Fpa1hpVk9xQ2xsejZGSFBucUw1cFRNcUxPL2NGMDlUQ1hi?=
 =?utf-8?B?YlNjOXllRzNnWnlEU2dlZ1c4YWhMUGxqamJXNFJUQk43Y2Q5K3R5V3hTRXhN?=
 =?utf-8?B?RDRQSGZBaTlXQmk0dXR1NkV3MGFGYklKUHJzenoySi9PMlNWS2ZRRy85b1RR?=
 =?utf-8?B?aWVYZ0s5c2pXbjNLampxUjdQY0pUZzN4UnU5MkcveVdSc1BSamVYQS9JL3NZ?=
 =?utf-8?B?K0tYaDVRUkkzM05ZY3JkVHNhT2UvK1RyZGRieTU3MStBbURyRDNkVWR1UjY2?=
 =?utf-8?B?NVNMcXhMdFVxYmFrbHowSUlDYXNDMG1BMG1KT3NYSVEwaFhoZnl1SGIrZ1NY?=
 =?utf-8?B?dmFjMnoyak5IeFBWd0hidDUxa3YrdGJDemtoUDBaYW1XZ2U2c3dsbXVTMCtX?=
 =?utf-8?B?d0xkKy9jVFU5TER1Qm9QeWVrbk5UMy9RdE1wdm5SVEl6NGREK0N0S0xraHRY?=
 =?utf-8?B?eTdmTnVpSW5uays3bmlRZmFZY2c2ZUIzcEc5aERRYWY5QThMRmlEMGhnVEU0?=
 =?utf-8?B?bGxvMXYzSmFZbWN4NHdRN3dMM2JxOHFONURPbWg2NlhaL1o1VXRDRnN1ektZ?=
 =?utf-8?B?N2FEV2NyZGRFUXZNNGJTVkJpNkg0bjZhU1ZEYmpsZE1pR241UGdWam9RYzVF?=
 =?utf-8?B?eldOaDZUVGx6WjM5NlBlODFic3NlVksxam5seXpuZS9HeEh6MUpUa3YvSFFv?=
 =?utf-8?B?czNKa1o0Y2JYcHY3bnRtRkRncERVNndtK2RuYytSdkU0Qi9ndW5nYmdUcFFz?=
 =?utf-8?B?WTJYanZhaVRYUUFXbUozSkV1NDJjSXI5WGlPVCtRU21KbFEwaEl4eTNUT0pV?=
 =?utf-8?B?bHZBQ2hTWVA5bDdUdENVZVNGWkxrZjRlanBRTkx4cFIvOTQvVTBna3ppcjRP?=
 =?utf-8?B?a2lqL25maDdjelVjYUhkQjg4S3I5UlFtdkNPVTRFTlRDMXplOUVvZmM2eDJa?=
 =?utf-8?B?V1FiaCtIRGJSZTQ5WExsb0F4OHJjWXIzaTIwWVBhMkxWbEd2aCtnZXpLTE1k?=
 =?utf-8?B?RUU3c1oyUjhqRW9haVlIekl0cXRsVTUxeXh1cDBIV2hyNis4MHNZWStTQ1hG?=
 =?utf-8?B?TnNFcHE3VEFocEdzRkw4ZmZidXU1RHZmOFk5Z29JN3hHVklHd3lFQ0M1bEtW?=
 =?utf-8?B?bkVrS2FZblZBZjU2dm9FR1luSkhMUXk0ZytheEZ2WW93WjlyQXl6NmVQZUZN?=
 =?utf-8?B?cW9tdjdOSUhGQk5NT2h2YWRCUXhwcTBkWUJKc3pzMk5Zcm4zQVEvOWNIWGx6?=
 =?utf-8?B?eE4vcitJbEl2YVJaY1RuTStWbUVuT3ZiRmpRbVBWb1gzM2s5K3k1RHlSRDd1?=
 =?utf-8?B?Vklaa3E4Nzg3T05tdDMrMk9tbEg1cXVsSmxJOHVCaloreDlMRWpiOUY5eU9C?=
 =?utf-8?B?VDNJK1VxMzRQOWZYWXpyUi9pZFcwT1lzNEU2TFhwMFJ0ZmV5eW5hQzNvemxu?=
 =?utf-8?B?NVMwcUQwVStNR1NRYTJoRnk2WlFvYjUrdUpBL2FNRWswZkg3b3VzS2JodDAz?=
 =?utf-8?B?dW1nK2RzYlk2Mkh3VWp5R1RYaHZoTStOL25iVmNFWVRvUnFpa2V3VmoyS1JU?=
 =?utf-8?B?ek1HUHQrdkx2U3VSVHhmaE9ycUpIWUwrS3dLWHhLTmMvTS9ENWEvZFEwZXZs?=
 =?utf-8?Q?A/WSCKn595s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnd4K3duZlNuRmZRck1ubVZpZVk0NWx3SW5tejYzb3pVaWtjVGh1YUlVc3Ny?=
 =?utf-8?B?Rms5MTRHaG1IQ2RxQTVTQVViSzY0anRVZ3dQbDZBaEFRdXFNTDBVbENkMGdz?=
 =?utf-8?B?R01IT1doazBvcjREbmhSMW5uanI3YnF5K29vaHlXRmpnM0dYcW5SUGhOelVE?=
 =?utf-8?B?OUN0bE8zdnREQlNSOHg4aDQ5SFlKb3JtVmFZTHMwNDA2YUZ2K1BRbXBvN2tG?=
 =?utf-8?B?eFNpWnRraXA2TUV4elNXa0tCODV1emp1TVY1UTdWRGdXT0JkbFVvOTFLd0VR?=
 =?utf-8?B?S3B0b2Nld0dMOGpWbTgyMVk3ZDFzQ3lNNUJvaFFIZUkvYklQWEZSaGhsUHBX?=
 =?utf-8?B?OE9lN0U0VTc1Z0dVS0NreWlITDFobHEzejJ2aHlPRWtyeUc3bm1oNmF4bU92?=
 =?utf-8?B?d0lSbkR3a0NTYUFVZnU4SzltWUpRdGh2b2RrWG9XTDFlVEdMZkpiZUlxYWRv?=
 =?utf-8?B?S2Q2TUg0QjNHQU1aSmVZRm9PbXZzbFlDalVEZ1lFMlFBL0NaY0NCckpmOVJl?=
 =?utf-8?B?aW5CSzhybmNWRWZuNnl2bUdGZnh0bGYxWXZJZlV6MnNwVmJ5N0lJNkFNL3dI?=
 =?utf-8?B?d3J2NXRUcHd2QVhrRlNkc0E4VFNoZWc1aktIZnhSbmFBQlRmUHM2ZldPV3NT?=
 =?utf-8?B?djM1bUtWaDRua2F3NElJcWM0QUtKT2NKS3phbGxoL2tzNXdZQkdBZEpvY2F2?=
 =?utf-8?B?azc1SnlSRnZyM29FbFoxa1NyK0xOdzdiRDJBYmxaZ1p0T05jZXo5VHJHK2Ux?=
 =?utf-8?B?TVhPdmV1YzFmZTZRRXQ0T09yRXd4MThKM1J2dnloMGg3RU1kaG03RGp3a2w0?=
 =?utf-8?B?MVFLenFSTkhORUdlNGFNNmJWOWREdUFpY0tuUkJ2bjM2QWRCREdneTZielVz?=
 =?utf-8?B?TDhlMmxGbHNZN2ZuTHQ2R1ZWS1FjQmxEN044enNqVjJhY0RJOEo4SWZiQnhh?=
 =?utf-8?B?NmVtWTRiT2JuVTFlQ290cUhudXhZZm00QW9KU1RORGxFVzVSLzBRd0pUWDlD?=
 =?utf-8?B?eTVXR05XbmU3K2k5REdWUVRtNENYcHpneFg4T3Zad1hjM05idEk5aURJRDJS?=
 =?utf-8?B?SERmdWU4bWRrUTY3NHRoWmFiM1dLQTZobjRyZ1d2K2dwUmtWS0hvaVpIelF0?=
 =?utf-8?B?akF2VVlRN1EwSm9wdmxMMStXbEJSQ1ZEUHZDYU9ZcndzTHl0Q2lHTGRFTzB6?=
 =?utf-8?B?a0VIKzVQSlREOU5uZjd5SjZ6Z2l5WXFUdCtxYmR3R3JNKzJtUnM2V0xFMHcz?=
 =?utf-8?B?QmVOMkM1cGZsZi90TzFNUHc1TEkxNTJ5OUxGRWQ0WDluWnlFemJURzZEUjVp?=
 =?utf-8?B?bmYyVHJOQXlGYk5tSHdGK3ZoenMxY2JZUEFxOGtZZkIrUWpFWjZMYXlySFZi?=
 =?utf-8?B?andSWnd6cTd2WUFkVzIrWnp2K1JPSzg4N085eG1rU084TkFJQ1RIdXpSM0Ex?=
 =?utf-8?B?MC9GdlMvUXhTVXgrekhJUHBoVFBaSXI3ZTdjU0lWRFp3dDRObDU5V3JIbjQ5?=
 =?utf-8?B?eWFEd1ZsVkpNWGFWUW9ES2tTZlZtL1AyelJYMjFwTDFvSEJscmZQcW83bi9J?=
 =?utf-8?B?UVM1L0ljR0pwbm16WW5HSEgycU9wNXUxZFlabjVTS0t3NHNWdzI3SnZEUVRS?=
 =?utf-8?B?R1lkWFJzNElidU1KQ3AvT2ZRN3pzYzcxdHExTzZiSnNEa01Gak9PMzNDcXlD?=
 =?utf-8?B?R3l1MkZSV2d3cnViS1pLUng3dzVMNjhBYjJCTWs4NEVrbVhZOG5vbUl4T3VB?=
 =?utf-8?B?N2k4REpXTDRDZHkyNGVLSnoyRUxxanBSTXRGWW1IbGxCOUhxQjJSWGJQRUM0?=
 =?utf-8?B?R2sxZVVBUjBDQ3htenhRc21pRGZFZ1djajJMUUlyMUkrYjdCTndGVi9LWUsw?=
 =?utf-8?B?WmtYZUJQWVZ4WWNtVGUyUWdDVzBxVHZTdEZIR29MeTVmbWZtclpuMjVOOGRZ?=
 =?utf-8?B?RW9sYVV1OEtRcDg4WWVIN3RmK2RWWGVZdVVUMlRJYmlUaGFQdnJ6YnhnUXQ3?=
 =?utf-8?B?MGVIVkxtUUkydEVBKy9Jc2Z3NGNManorejd5dWxxN1U2NVJFK0ZiRmk3akZD?=
 =?utf-8?B?SVdqdlNHRVZYdGJxalhBM2ZueFZVR3ZKbUVWMmRsMVhxdTNoSm1RRThNYm41?=
 =?utf-8?B?NmdONDcvaW5jcWpVeWpBcmpMNmkvYkVyeks0SUlQYTNTczRuR0lVaFFqTUM5?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd02942-4271-44c7-c726-08dd6d05b26f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 08:02:19.5625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Thx1RFN5HIDM3QkVDAC6K5PzuG1CZcCdt2t0RiDXtoU+Pko8n/YHDZbX3wQg53w9E4OTH4eJl/2z46n1UA+RE2WU9VipfJGGj9pUgJWEQDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6765
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


On 2025/3/13 23:37, Stephen Hemminger wrote:
> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>
> On Thu, 13 Mar 2025 14:19:03 +0800
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
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
>
Hi Experts,

is there any chance to review and accept this patch?

Brs,

Yang Ming

