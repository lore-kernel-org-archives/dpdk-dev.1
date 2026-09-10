Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0431DC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:38:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15BDC40F1A;
	Thu, 10 Sep 2026 14:38:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id E6A2B4028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789043913; x=1820579913;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NjTM1ChFak1RcraTwFt7Ahs6iiz9RMgaQ/9qEhBPh2I=;
 b=d8B7w+y8DYoBIE+qdvznyATD3g+tA+WlD7UQGhfjPeV0JMxk5MUj/fq0
 EvEOZkirPhRNEbREu6EQsAH26aoNZMi/Rsz+yfZ3DExheHyCiUddUhyvc
 xZXxFuSwaVPhz0tlI72xFPLmNKTHOdSaXY4whV8MYwHfxRWB3HVpiyLag
 3WHP5QJJJyPlJY69QD+9yiKKtgdhbO/oG3T62lYKSq1W8foUY8vXV7Ld5
 a4H5SVvrp2K0GZIeXIJ16Z05fArhhk5LEi68VHWN5uzDexQvRiI7jT3ss
 8red2JHI5BwG2YXUZe9SBoMqRVWtUEyUAzXBLLJFTlYs306rnRHezrExo w==;
X-CSE-ConnectionGUID: PyRtfLhoTP2Hvd8PTbX7VA==
X-CSE-MsgGUID: tssp4UKbTZKpvUtyj9geMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89531793"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89531793"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:38:32 -0700
X-CSE-ConnectionGUID: OxFeuNH9QR+lbVgKp7MIlw==
X-CSE-MsgGUID: rpVxp25rTtWyjiUifZ+a7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="275395948"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:38:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 05:38:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 05:38:31 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.38)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 05:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErdaKKAAP2RJPFr2CucTQh8SY2+sdVajN8LXU1YypiTYE67/VD6nkJCCOdkwA48sLPctV7hDUHvCQd0o5Zc1E2LKSfuG74eCZ0YbZY5WtAZKKU+en9ltEBSLgzoM2aHPR4t9WlVGVe/in2JqlcSNLyuU6xUHdERgShe5bl2tz7veBVnhWd7rXaPhvm2NKugpbojy7m4Wcu2kByczEbbcKkXGmKrhEfwclSjsLlwFgHry9Da/Mcziw7SAmYAFIr48DpLnjzzcJSd/XLGQGGJq/UywE1PZ/PKwW0aOgmFRmXDBvQloDehruKTCLN83bT2QFQz+a1ZouBQ/Z9RCjxdIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkA1fTbL28kPCI8YnfAqSCC3Hi9BIR6n6W8VXkTMB5c=;
 b=auMkylYBqJ21dKZ7BODP26L+TDGSSZ7SjDTYs5Tr6C5Z8llqQuFKwNgjwJiPznVPYbS1vbDSwuGi7HX6ZXnXKUVzvwBOsEQDSMSma6F5ELIo1gXO/jPI5BZLdvGBqUGY0rXDZEoBH0uymvk2EK5poQ7pKSf3InypAizqm6upuk1SHoIKNvsHTqOLfcPgu01XDRuhtWBb05Ds2u5zRJtdlr29+MkaD0PkwSNdFUgeQsWw/InieNokBWYIzsUBPdlUMEjMwjrsiDbqi6CqqHtodpYSKrFSLgauv+bhyUqxLwe3OLKErPCAS082qp5QRRI9ILcPEn33b447i6gj2mwQGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS3PR11MB9669.namprd11.prod.outlook.com (2603:10b6:8:38c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Thu, 10 Sep 2026 12:38:29 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 12:38:29 +0000
Message-ID: <b0990db2-3429-4b0c-bd77-3daea494ff83@intel.com>
Date: Thu, 10 Sep 2026 14:38:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] net/iavf: accept up to 32k unicast MAC addresses
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
 <115329f1-ef86-4330-a198-2471cf3d69f5@intel.com>
 <632cdb2b-3df4-47f0-9405-5a164bd82dd6@intel.com>
 <CAJFAV8z2SwkPkn=nL7CFa4SW4P5ghbVGz6P=J2=xtFJMogUTAw@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8z2SwkPkn=nL7CFa4SW4P5ghbVGz6P=J2=xtFJMogUTAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0137.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS3PR11MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: fb755111-d639-4e54-9bf0-08df0f386ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: M7m9/pofVZxEVcWth3RO29W1CL13sN2t7rwZp6CyhHnjfMEPOR5yJSFIJEXauZLPjdEa9eG03PVlDMqkawiA9OrU11jcEG3rtLwhN2a+vdLuWTiTY/7mnHTWdy9FuJubQPm2ktUtzlMHS8NEd8bklY2LlXib0apI3HSNM7NuMMkji2D7Ki7W8IihoM6JS+djXcjBbU1kdH/nC0FONh+4QkupalpAJilBSiLJnB7yrZXG3bIR/kZ1iCT4AqYl/qiufON82uxebNICeAxDLSrSk6NeuIY+ch27Aq5JYBVRiKDkVXy6PViVYFcjiCEQtikcKSn6WOiuFKV8fsqMqWL6qEaZN7JKXvjCx0eLm7GhNN6xvO3Csys9yG3/yxGz6K4fL7s+SivrrtmtPN0ZDEtw+6cEDfjCXQCQS8bfCsj9TRT9ohoVlgBresdUCWcc2M6uWNU2+E8eYaGxXcStSZhZ+0s1Pi/S8z1u1Pw870YghionaWzHXdFfaLE/9QUugzIf+qj/wf+N+qxAUUpMT+G5zStM8UcPECQsKimddCED9RCNWo8bWQ3bXUY5+imAswlVCSEWouAJJJwOyCn9QvCME/m++gLGxcM1i1OdNNMnO+uxh703I6y5+96/ZWR4kbRbRDDi485KkOVik/TkOnu9RvfLpdu5X4jYCgH3XjTIZN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCtUTnR0eUpqbWxidHQ0VU9nN0lyZDFLOHBSYXhzRnZPWHliM1BZTXpZYkx2?=
 =?utf-8?B?Q0FZUkpqQjBrUE5OL3J4WW01MFgvV2JwcmVmbXNtSnN6MFZiU25uTFFlRndQ?=
 =?utf-8?B?eXd6M0ZWUEFwQ2dIVko4WXh3cUtKZlRwdWRVM1JHRW9IY25OVmI0MXQ3cTgv?=
 =?utf-8?B?anlaUytCazlBcURvWnRIaFZGeThER1NJbXEwQUR5RHlIRGlSd2JGMkNObWQx?=
 =?utf-8?B?Ry9ZT0tRSHp6K2Yrd2hmdFFocXhqMnRRcjBsNjNubStSUEJ3MEJGZ0luMjRi?=
 =?utf-8?B?Y0gyU0ZVZmxtNi9aNllkU21MOVpRZ0t0cW1acjZaV1ZUYTNaUnFHUlJ1R1Jt?=
 =?utf-8?B?VlJBT3Z0RGpxVE40ZnIzZHluYkY1amF6ZmlZQVNMeWFEdGsxRzBZV1lIbHJO?=
 =?utf-8?B?TjVXenBQMlZpMmRqRW8vTlByaFFzby9OcVprVUtoWWI2aUJjdjRQekllWklF?=
 =?utf-8?B?Wlk3R21VOHNVeE01MG5yZHFESG94OE5RbnNDaitMYmxXMXFMRlFLVlV5MW5X?=
 =?utf-8?B?YjR0WXIzb0FNK0Fhb1Q1eURnaG1vcVJXeDZUS1JQajg5YXBYR0xOSlJsT3dK?=
 =?utf-8?B?T2czNjdwNmJJcFFXdEpkbm4zb1ZIbEVndDNodTJWd3FwUCtsQzEwenJYemtZ?=
 =?utf-8?B?UVgwZzFKaFdteDJ0dytKclZVajQrV3YyMlQ0a0JhQTl4a2RING52RG1ydzNS?=
 =?utf-8?B?dndBYWE0R204Nk9lUWpYc1lWL0lYKzdINGRMaVdudkhPZ05kU01rL2FTUHMz?=
 =?utf-8?B?TlNVejNrWVZrMy9ZZ3MySk1TSVJDRzlVNGNqa2hUWmxVZjFEZW8yNG15YmZF?=
 =?utf-8?B?VWg1WlQ1TlgzU1V4WmdWaE0zTHNVa3ExajlMNG5lTUN0SC8yR1QzcjFsSjN5?=
 =?utf-8?B?S3YvYk1LN1ovcEMzSWJNaUYzb29XeXQrTFRZclZnTFVFaGZHVWlzRVVoRG9J?=
 =?utf-8?B?WEl4K28xdkZSS0RteXFoZUFTNnFpdHJTZzFsNVdRcXZZV3ZJc040TUFXMU1v?=
 =?utf-8?B?ajNIZnk3QVU1M0tNbUpIaklqK0NQZDlMNEVLR1RFS3c2dVdXUktxK3JJV21H?=
 =?utf-8?B?eEtvclI2eXl4M2JHbzcwZS9hZ3pFYUdITkNCWC9POHhqM1ZxOXF2OXlURysz?=
 =?utf-8?B?RmxpK2hCeCtEQWZZKzIrV3hnUXlUdjdZOFpWVis3V29UTzNlL1p0V3ZlaG5w?=
 =?utf-8?B?Z1EvNE85c1I3eDhveFFNMDFVN1haTFhkKy9lTW5MdmN4cm8rbXdxNDNtbGlX?=
 =?utf-8?B?M0orMkNONTNyWHdPOUhPNC9aeGtpaU5ZdG03czJJK0JOaUtiU2d2NzZNNEVT?=
 =?utf-8?B?bTJKMmlXZ1VoTXNqWnVCQVZ1blRqTjBHOFR0SnFUUHVBSHJtTU1Rb0dzOXls?=
 =?utf-8?B?ZTRLQXN5SWFWeDUvVTVldFVCVzBqcTJMd2luMUN0ZndlNDU0UU1MWXp1V2Rm?=
 =?utf-8?B?b3J6L0Y1aDMycm43WDVQY21HS045WmtPQTdDRU9MdE5UUGZvWUtGV25yRWF3?=
 =?utf-8?B?cnZoK2ZnMGxsL29SbWM0azF4QThmYXlWT2JYVFdJTFYxQ3FLR2tPZXMzV3JK?=
 =?utf-8?B?WXZvRGxiTFdMeEk4SUVzSWkzejlaY0o3cHNHN0RoZGRVWEEzWkpCaEZQZzZk?=
 =?utf-8?B?NU5pc2JPanpVdlQvU0l5Z1B2TVdPVFpKcUlsMVVTS0Y0Y0hYdk5SeVNhcUdw?=
 =?utf-8?B?QU9VSHdaeG9GcjdRWDA2N1ZxbFloSXlzajNNdUgzQnNKN29rdGNIbS85anVk?=
 =?utf-8?B?SWgzWCthVzdSUUZKZDdobEpUTnlrZGNMa1ZsNHJwWVArM01XcXFMbkRtM1Nt?=
 =?utf-8?B?cWY4cDM1dE5ieHd3bUtLcWdDUGk3cXpMWHhMWjhWakpPMTU2UytJb2FDQTJL?=
 =?utf-8?B?QU94Q2wxQmpqSkVqNlFkaUQyZWFmNXVncTZGbDU5UEhhK2RSYkRWd2FIY1dP?=
 =?utf-8?B?T1V3ck95czR3end1OVNPUExGS1dmbUJiVEs0MkFGZFVma2Y3VFRmUGxMdXJW?=
 =?utf-8?B?c2V3S1hQK3BmNjJGdTR3NVF4SmdNNXpPNHdpQzlFRzV3MEpWQ284L0xKbGFC?=
 =?utf-8?B?L2lWRlQ2VHlXOE1US0FTTFhhbkdKRnZ0b0xNWUUxWkRBTFVkdFBUNDZWSEJ5?=
 =?utf-8?B?Q3d6WWZvSEUyWUhBdFIzc0dvQTROdWJNVThMYkRtbk14Um9ZRWdLTkJFa2c5?=
 =?utf-8?B?VXE0aW52dndFVktMUU5DSFRqM0swN2ZwcWZHZGUvQzFyWGZVeFV2cnNGQUhK?=
 =?utf-8?B?ek51UVNNRjdZbkRWQjd6TStqa2pEVkROOEw2RElmT2E5REVYSU1ocnNpU1gr?=
 =?utf-8?B?OUdkek9CY052dXh3RXg1RGxpQ1BaTUxzWFpLQWttTE9qczZORnFHckRuNEhV?=
 =?utf-8?Q?pBF2+/lZcOo7BXc8=3D?=
X-Exchange-RoutingPolicyChecked: VJFzk+whFPPcyGyHHAvixaE1KHu0PaglABYrDqNFIoSxtpaLSr1xApNrmNL5/v5ZcR0UGp4LBWanZsTkWNi/cr0AlrQb0IG5hYsk2IZ8Tn/pIIxna44SFE8geMwS36lzAJWVwnhXrmLhqaDv6jglLad7StjkefSHQ/SYKabB6HIe309Qv7o/LGxFX4WeKB82dMl0UgjepvgpPUfL0WbNCqfQjePWNo2PYPKzbh1c5Lei1fk/jspqj1OG5wFOx0sA9A1yA689/XDy4wGllvhd13+XdHsnwvSyHr+V36j4i07DslQOmrqzccl91TS1qmmLQH0bqPHA6MexiZB9dqxxbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fb755111-d639-4e54-9bf0-08df0f386ad6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 12:38:29.7099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RjBcjTihVmO1C4OPQZ5N7hOXoDiEWLnykwUavNWg6yh6uBqZQTL7bfF3TZxkX1E9RMbQS8cjRAPyWsApXAQ9Dg4cvQ36O2upq/7RNzYq+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9669
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

On 9/10/2026 2:30 PM, David Marchand wrote:
> On Thu, 10 Sept 2026 at 14:20, Burakov, Anatoly
> <anatoly.burakov@intel.com> wrote:
>>
>> On 9/10/2026 2:13 PM, Burakov, Anatoly wrote:
>>> On 9/4/2026 2:28 PM, David Marchand wrote:
>>>> E810 hardware provides 32k switch lookups.
>>>> Thanks to this, it is possible to allow a lot more secondary mac
>>>> addresses than what is possible today.
>>>>
>>>> In practice, the maximum number of macs available per port may be lower
>>>> and depends on usage by other (trusted?) VFs on the same PF.
>>>> There is no way to figure out this limit but to try adding a mac address
>>>> and get an error from the PF driver.
>>>>
>>>> Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
>>>> accordingly.
>>>>
>>>> Signed-off-by: David Marchand <david.marchand@redhat.com>
>>>> ---
>>>
>>> On another note, I don't think this is even compatible with ethdev API.
>>>
>>> In `ethdev_driver.h`:
>>>
>>> struct __rte_cache_aligned rte_eth_dev_data {
>>>       ...
>>>       /**
>>>        * Device Ethernet link addresses.
>>>        * All entries are unique.
>>>        * The first entry (index zero) is the default address.
>>>        */
>>>       struct rte_ether_addr *mac_addrs;
>>>       /** Bitmap associating MAC addresses to pools */
>>>       uint64_t mac_pool_sel[RTE_ETH_NUM_RECEIVE_MAC_ADDR];
>>>       ...
>>> }
>>>
>>> example of this bitmap in rte_eth_dev_mac_addr_remove:
>>>
>>>       /* Update NIC */
>>>       dev->dev_ops->mac_addr_remove(dev, index);
>>>
>>>       /* Update address in NIC data structure */
>>>       rte_ether_addr_copy(&null_mac_addr, &dev->data->mac_addrs[index]);
>>>
>>>       /* reset pool bitmap */
>>>       dev->data->mac_pool_sel[index] = 0;
>>>
>>>       rte_ethdev_trace_mac_addr_remove(port_id, addr);
>>>
>>> meaning, the mac_addrs array and the mac_pool_sel have the same
>>> limitation because they are indexed by the same index.
>>>
>>> RTE_ETH_NUM_RECEIVE_MAC_ADDR is defined as 128, so correct me if I'm
>>> wrong here, but according to ethdev API one cannot have more than 128
>>> MAC addresses?
>>>
>>
>> I would even go as far as to suggest that ethdev API should probably
>> check max MAC addrs number to make sure it doesn't exceed the size of
>> RTE_ETH_NUM_RECEIVE_MAC_ADDR, because otherwise that's a latent
>> potential buffer overrun?
> 
> This limit is something that was put in place for VMDq.
> 
> I removed it in next-net (it did not hit main yet).
> https://git.dpdk.org/next/dpdk-next-net/commit?id=f9ddb36e00655e38c115502d5ee180d4fda633c0
> https://git.dpdk.org/next/dpdk-next-net/commit?id=31ea14ef354c8664482af27039ecd3c6130254b1
> 
> There may be some check missing in case a driver announces a
> max_mac_addrs larger than RTE_ETH_NUM_RECEIVE_MAC_ADDR with VMDq
> enabled.
> 
> 

OK, in that case I'll send AI to dig around ixgbe and see if we can 
tighten enforcement of this limit :)

-- 
Thanks,
Anatoly
