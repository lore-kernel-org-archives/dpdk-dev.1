Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB91AC282D3
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 03:21:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E15E40156;
	Wed,  5 Mar 2025 04:21:04 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
 by mails.dpdk.org (Postfix) with ESMTP id D23E4400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 04:21:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB5rIGWxriSu1hWyagtISfJ20zNd9L1MozZMal2O8R3izv5ICp3IgAEf9t71mfMEJNhTF0bK+BYjW8D0E6izSHEOx1es8OwiLbcSbElvKboKVoNfoEGbqSsA88/ySTeZwtilB1LNLr7CdC+U1sZO4NoDo5eTS2kiL2BzXkO2mQ6dHGG529Ig1m7Ec008oVHtZSckISFFnd1mtrlP/fbEoDo6E5R/9Vamqpm1j5LMgmSE1RGlFOeDvXLLQQJxsmG0HUWEVJtfCA43XlVABiJAA6sRKV0l3HjOlnl++3LvMk8nGli3xRRNwRKs/5Mu3jnjkVqm4Vh1kWnhHJoDH7diiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBUTE6qKs9VkEkrxjQYN4sJpIlcZLN+VIDXAI0mfOYc=;
 b=hB1iU+KVPvlIJ2tDbs3W2TpGmOeGnQ+603UD2OEUy7C+rY/7RfTBe9ZeczXaelz3I+Q046J7LNYR4sRZo2t21V0PwzWojoZc4gdUE1TKMt71QFjFnOIoDbWWKyTuhn1TLJe2dqPHxZPIiIITjOWl5WmQZcU8A6sHUW4vw6rfa6JGESkgmEpo1J8ucPI6qiSkTkcXNa1/MwrG5H0sM41bxCFdwtm9U/NubXyeRrfXwuDHEXU5O9P4NDQEtzN8yzSDSwyDBE2AHeqUIA2aNNcJM0jMqC260szeVi4FTIaSzpubiRiVKV4wZE9hqBvy/Hs+ORPkjxXGCX/PWqvddw3BEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBUTE6qKs9VkEkrxjQYN4sJpIlcZLN+VIDXAI0mfOYc=;
 b=oCEhBlsISSfG1vM52rCWhUlhi3hpiMKDWvCu2BlsAM15l9jFySlJ6qQVLG89Fam9+TJsawYPPruiCMtQlyVz8viLb73OG68C9J9vXagfF4D+l63TFJh5cr3yM5uX+rKRBjXugHYg+63eoVBeihQMK30HbSd3968LYOxt2r8BHDA3AaqYy65O3xXYpqjTtq9v+lsKiovmtEZwrFd0Zj2i7ssx2Up8XgiwMzRX2nBVh2EKRR3etJnYYaDBObb9uNpL5i7IOB2OwpisB2Ake9k/dDlzv6YDCho1Rg86utG5LW39m6dBqotkBrk+SsrkIzjQJafwRCGcz6H65b0HoOvXQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AS8PR07MB9159.eurprd07.prod.outlook.com (2603:10a6:20b:567::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 03:21:01 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 03:21:01 +0000
Message-ID: <46f13214-ec40-4f01-b5f6-0909de856b42@nokia-sbell.com>
Date: Wed, 5 Mar 2025 11:20:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/mlx5: improve log file path
To: Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20241213092444.2987-2-ming.1.yang@nokia-sbell.com>
 <SN7PR12MB69096FB0FD4930E9CE8A8F80D0C82@SN7PR12MB6909.namprd12.prod.outlook.com>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <SN7PR12MB69096FB0FD4930E9CE8A8F80D0C82@SN7PR12MB6909.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|AS8PR07MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: edc3742b-667c-4220-2015-08dd5b94c0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akYyYXN2NXl4UDMyRmkyU1Z0WFB4RzloVjJaOVJUQUR2ck1sM25EbzhYRkZx?=
 =?utf-8?B?Rm1MM2ZWM0RlWHNJOFNCcDM0QVIxOWQ1anlXVUlBa05OSXYvWmdlb3NwR1NM?=
 =?utf-8?B?Wm9vaXZwbkVGcy81OTQwTjM4b1o5ZVNjUjVlaTlHOWNnemttYjdWMTRESDBD?=
 =?utf-8?B?ZFVELzQ1L0xvWWhqOFZnUWQzelBsWCtOKzJPMDNkaFlrZXRqd2hqUnJ6d3Vh?=
 =?utf-8?B?OVZ1eU5nUHViSHBqK3NiZlBuT0NSMGlXQTRRazZzaGxpWGdKc0laTVdZMTVr?=
 =?utf-8?B?Y3JlR3NUSkpLQWU0VGdlaTRpTTdUMjNqU1pYVEh6aEVlRGNOLzMwc1hSTjFS?=
 =?utf-8?B?L1MzeE9hWGtFTHBuTWQyZ0Q3WDdZWGllRSttRE1JT3dBdjM5OFNtQjNQTXNS?=
 =?utf-8?B?Um9ldlp1aHBrWkxxZTdJTUcydVQzSVNJaDNLTjNDN1R6ZzRCRHFpWDc5Y3dh?=
 =?utf-8?B?dVY3MExEUmlqK3ZaNGxyVEhXMDd6MVN3V1h0bys1WHdLRDhSMXNpb1IrZm5I?=
 =?utf-8?B?Z3UvNldiUkQxbnV6REpod2UrR2RGTXlWUTNRYnlad1gwZ3k2Nld3N2FGclpJ?=
 =?utf-8?B?OXhib1ZvMlRwMUppbFQvZEpJNGlGUWlkVXRKZFVPWHdZMnlTRXRGT1o5T29n?=
 =?utf-8?B?Z0NKR1NmTWdFL2NmU0R1ekNsK0xucHd2RktQTU9GN25iM3AxNCtTdmx6SlFx?=
 =?utf-8?B?clZiaTN3dHFMaEdvcU52SjVuYVBiRU1Vb2V6Z0p4TkZKN0l6amMyY3ArQ3Rj?=
 =?utf-8?B?T0VBNDgrS2VWVWFNNEZoQ2xRZWwxaTFsRmZQSXhDUE5tMnJkdEw1NkZXVVRh?=
 =?utf-8?B?cldtRy9LYm1FMlJWU2llTE5RQk8zTUVZTjJWeS9Xa2JqNUluTmxFWU9NSFdO?=
 =?utf-8?B?SEJINnl0S3oycXZMaGtTSzdtUmNjK3dDbUhnTXRRRHZtZFVsczVGcnBMamQr?=
 =?utf-8?B?SFdaL2VmeFRhTTlvUEJ2alRqdFZRQytpVk0zUkptaDJ6d0FZSkNPUzY5cmFO?=
 =?utf-8?B?KzdjU21IbDFJNkdFM3VRaERiaEdrVCs0UEdFUGtPZXlNSnFiVS9rcWNBQmw1?=
 =?utf-8?B?YXduZW9nWVNubWtCVDBsaDhwaUVBMDc3ZVJiMzhycjBBa2ZBcDJiZEZGRXY2?=
 =?utf-8?B?d0o4NWRkV0VrVFdsTE55TjlvZU1IdXJXOE1COUFndElBZi9SekxkY1NWdi91?=
 =?utf-8?B?K0JGWnFRS0ZZQ2NuZTZlMG9BSmhZK1RPVkw0bEt4RWFpRnk3UFRnWDJCdWlE?=
 =?utf-8?B?VXJEOXUrY3U2a1FTU1pjNlJMMm1KdVl6V2xXM280dzdZNFdPUElDcDB0Y1RY?=
 =?utf-8?B?aHUreGdmODhWNVNJc2tZU3J6TnNtV1RQYUtRNlp4alUwajFqM1BLanZYcXhI?=
 =?utf-8?B?bDBmNmJEYTZnZmtSWnlxTjMrY29LT21yTkM0ZG96YzJ2azRmMlpPMXVkZEVm?=
 =?utf-8?B?bXduWXJ0N3pWQ0FWNGp3TS8veWV4RCtRK3cvenJWNEs2UGtjWjVpSnhnaGxK?=
 =?utf-8?B?L1hMelFITEdqQWt2VVNaR0dZaG1CK3BWemhoeFlvNVIyWDdUT2xTcTFEWE05?=
 =?utf-8?B?OG5ackZQNTJlNnRPQy9qTFVkYUFDNEpibGppdC80YjlOZlBRbktBcGpHTlE1?=
 =?utf-8?B?VnB3UjBwR3Izd3Jta0JOVFNaczdrc3NuWkMxb05vdENFQjZVQjNHSzBRTEhv?=
 =?utf-8?B?MnhBTnlwSTBuT3BWaCt6QUVyK1g1NXRSL1VhU0NRVTJMcTJZVHNtM1F0RHp3?=
 =?utf-8?B?S1l0T3FJcDQvU09ibXFxU2UxN0h0K0NLNUNnU004bmVXYnczN2ZNejE1Vmk3?=
 =?utf-8?B?S2VHbUFXNmpFVk9IQ2o2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldEc2RUWVQ5ZHhFdEdHYmRRTk0rTmFEVDFBY2diYWZxUHYwRklWeUo4RW5y?=
 =?utf-8?B?aEZ0MG1JSng2VkhRSHZUVkJDaUFJVUNBcUlNeDBSL05zcWRzNnB5c2xQVTFN?=
 =?utf-8?B?dWpob2w3NjArTGMyNG9WQ1hmdGZaOS9tdldzUzN2aThibHRROSs1c2llU2hS?=
 =?utf-8?B?UnRxclBXait0TEcyS2dxcFhlWXBKUmJETXplaEVyNnpSaGZxMFhrdFZYYzVR?=
 =?utf-8?B?ZmJweVdkejZ3SEtka3hzbm96R20xV0NYKzZ0N3pKdlhoV0xwVWRPUE0yMlht?=
 =?utf-8?B?ZTRtRExjcnZxbEpwQlFTTjdEYmV3UWZoQkFnTEpiZDUyb1lHMTlZaWpDRWRy?=
 =?utf-8?B?MnpsZ01PWWgzekdXc295NmJkMjBIK2lXeWlJVGVEUkpWc290RnM2bmtPNU81?=
 =?utf-8?B?bFVzenZlemZqVEtGL1lHbUhvMFFwd1BqaTRjM3NVY040K1RXcGRyekloVTNM?=
 =?utf-8?B?RGRuSFVhVVg2N1FlQmhYN0NiaWZKKzdxenB5Z1JtTEwxOWtvUzVXTmxCTDlr?=
 =?utf-8?B?bGdsVW5Qazc0S3p6UjJjRk1MVW1nMmdGTWduWVFIK3JhZG1VZlA4VmY1b1Rn?=
 =?utf-8?B?YnpZVzhkb0Z3Vjg4dG05bDdzNTdpZVh0V0l0REllUzkzNXlDMzhHSExIeDBW?=
 =?utf-8?B?aXdGK3IxYVpvb3NwRWFpMmxWNlN4QTBhRUljeE9vdklGWHlrdXozeUo0MStX?=
 =?utf-8?B?RWtBNTUzU2VRRE9tbHFiNGcvN3hkUDNGTENlZnl1TTc1MjlvSmZianIrMmF1?=
 =?utf-8?B?eXhQZ0RkL0ZEem1QMkkrd01KcmtkRzA4ZmxjaUsraS9Lb0hHUDNMc2ZWbmxW?=
 =?utf-8?B?dXlBNnRjQWx4TkJCaXkwZTNTUjRGcWVIanZqSW43cUUzRjJXSFVPSlJyaDdZ?=
 =?utf-8?B?V2x6ZE1aZVVTV2Y5VktHRTNJK3Y3U3pUT3VwTDlhWFlLSFRjeG5yQlFaTFVF?=
 =?utf-8?B?U0t5czZySDh4WjMvY0p1aU1jWmMvTU1Jbm5HNW9HRzJqWVV2WVlpR1ZPdFlK?=
 =?utf-8?B?cjF2MEcxNGxuWWhjMlZaV2xIS2l2K0dMRHluSDlEZVBDMUhWVXduM3huZjdL?=
 =?utf-8?B?T1FYNzlaaVg3NUhvci9FTEc2MGdOWVE4QVJucmowdk9aaHVsR2JkbVFqcktE?=
 =?utf-8?B?aERDc1ZQWXg0cHJ3VjkzeXpQM0crNXBhWFpmQ1kyQzVmczNtWlpUNnV2QlJm?=
 =?utf-8?B?Y0EwQXJjOURyeklheit0SEdrOTFvbWdtTVR1L3BpdnNuK0dzUlRMWFVIdDlY?=
 =?utf-8?B?VzljNElmbTcyNmJuMXovbjNXNG1TeE1EdU9TVUUraVBuTXdsR0lNSWFrQWwx?=
 =?utf-8?B?K1lPTkFEZFpjdmY3aHdCQzVMTmw5QW4yem5Ec0FVSUppYm5kMXlMRVBUVGRi?=
 =?utf-8?B?NCtmVWQyNThLU1I0ODZpenJ5WGp4b3pLUktLVWtzVm02bktWL05RSEh3cnhT?=
 =?utf-8?B?VU9BTG91emErYWhFV3IrZTlPREJPOE45T1NUZ2VRditXbW9Rb3BIQUMxQjZ2?=
 =?utf-8?B?NHBFSEZPcnFSNTROeDFidzJmdlc3dmZBZ0t2L2ZxNGtzMGtMMi92L1lHMjRx?=
 =?utf-8?B?d1NMT0pzZ2hPeFd6Ni9FaGRxUFZWNlVQdXIrWW1ieFNPY0MzcDA4SHhreWVq?=
 =?utf-8?B?WWNsN1dmbmxyMTNmT2U1ZThMdmF1aytFcUFka2F3U2dNUVM4TlZBNzNBRGd3?=
 =?utf-8?B?eENjakdQZUtucGhEMmRzZWtabzNVOXFSS2dUcFhWVjBFcXpIRis1RDROVlRM?=
 =?utf-8?B?QnoyNVBhdUFCUG02VWZxYzczUGtORkU2T1pZNkZWRFppdXhDc3VsVFIwRGhm?=
 =?utf-8?B?RmNLL3RlK2dKa2VYc0JlazQzRWFYcSs0dUcva1lQWDg0ZElpdUMrNUpzZVkz?=
 =?utf-8?B?ODNkMFJOekI2T1hTdnQvS0RlQmVHcURxN3hwbE1mQnd6cmJvZFB5WGVEV09r?=
 =?utf-8?B?dHNaWU14TGRCK2J6V25VMEdIcTFRYjRVMnFsRGIzalpab1BTZnd6U09mUzdD?=
 =?utf-8?B?WEh1Z1drS2o4T0EzT0pHQmxJV0FkM3EzVEJnUlVEZ0k1R0tsQzlQdWxDcERP?=
 =?utf-8?B?bHNSbEhrRzJ3dUlMU1ZEd2pmSTZjaU5EclpFWEhWMUtyaE92LzVveUpzL2FL?=
 =?utf-8?B?Lzg4MVJzV0hwSFQwYTdMMVBaZ3owRlViUXk2dFJVQkp2RE1UZDZVZFR1Z1Jr?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc3742b-667c-4220-2015-08dd5b94c0eb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:21:00.9274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkiUqihrXpMFkXEoa1OZltcTQ2tstEgWI0KyVK2q6w6b0dlX3ptnGvq+xThTsrplwdOrfs1Ib+P1+FCJjr8PeLbg9gOZoKRF8lFfCGgr36o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9159
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


On 2025/3/4 14:23, Bing Zhao wrote:
> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>
> Hi Ming,
>
>> -----Original Message-----
>> From: Yang Ming <ming.1.yang@nokia-sbell.com>
>> Sent: Friday, December 13, 2024 5:25 PM
>> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
>> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
>> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
>> <matan@nvidia.com>
>> Cc: dev@dpdk.org; Yang Ming <ming.1.yang@nokia-sbell.com>
>> Subject: [PATCH 2/2] net/mlx5: improve log file path
>>
>> External email: Use caution opening links or attachments
>>
>>
>> 1. /var/log is hard code which is not a good coding style.
>> 2. /var/log may be not allowed to be written via container's read-only
>> mode.
>>
>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
>> ---
>>   drivers/net/mlx5/mlx5_rxtx.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
>> index eadadcdffb..a0da73c9c3 100644
>> --- a/drivers/net/mlx5/mlx5_rxtx.c
>> +++ b/drivers/net/mlx5/mlx5_rxtx.c
>> @@ -12,6 +12,7 @@
>>   #include <rte_prefetch.h>
>>   #include <rte_common.h>
>>   #include <rte_branch_prediction.h>
>> +#include <rte_eal.h>
>>   #include <rte_ether.h>
>>   #include <rte_cycles.h>
>>   #include <rte_flow.h>
>> @@ -311,7 +312,7 @@ mlx5_set_swp_types_table(void)
>>          }
>>   }
>>
>> -#define MLX5_SYSTEM_LOG_DIR "/var/log"
>> +#define MLX5_SYSTEM_LOG_DIR rte_eal_get_runtime_dir()
> I agree that using the fixed PATH is not a good practice. Can you ensure that the runtime DIR is with RW+ permissions?
>
>>   /**
>>    * Dump debug information to log file.
>>    *
>> --
>> 2.34.1

Hi Bing,

Thanks for your comments.

Yes. Read-write (RW) permissions must be applied to this
directory because DPDK needs to write runtime information
to this directory such as config file, socket file etc.
Additionally, within the function stack, the
`eal_create_runtime_dir()` function includes the command
`mkdir(run_dir, 0700)`, indicating that the owner should
have read, write, and execute permissions.

Brs,
Yang Ming


