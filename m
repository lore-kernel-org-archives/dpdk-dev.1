Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A439EFCD82
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 10:29:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E19240281;
	Mon,  9 Mar 2026 11:29:19 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9CEF440261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 11:29:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNW8NerIORBctYpwVd3ZKgqkibHlBGa1IgX9dRP3V/dHwcK7CWfnsQkA35Hj5d7aBGdIe07I2NEUjElYeF88g/haF7ZFZUMLky9twZo9RFTHpggg/mDcBJoLPHfeGezo515gllTuUFGnJBHT2wK7NhxVvyxTklWZneVAFIM3AmQGsX586NQ+hxN+agxksPZksWLY2Pw/F7FY0XKJSSvCX0YufEYCDsJNwWZjtFHXjee/q/HjrxKM6tteuWVLGGCTCWEgmDdcqQdmSF4z9rS0FmcXOB2ZCIc4KeOnufN+Boa5pFgvU09uWOwHybos4IdG02VXO63F0X81gMv2i6M6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCGR+NhLyAC7KOsmMZn61/HbVWsDBxsFp3mduweRA3w=;
 b=hVmTSHvBAfvhWQEaPclNnjT0Ndmam4BU3zGYJr5pb4qAT1HnWdlBkfyhhK6MLimjyC/YCecF4d+y3SIYrszgmINk/au93BTRq+3q8oTMuiHGKAq8ejAUMmihTofWw7UsMrTWpzgNU/g3UbZ+RzS9Hdpb7DeNJyIdjVBWMyiEjh7FW0BuRKSqgnD7Wt4ZWAe97/DiV//+aaiim1/GLMU4n9V3vTmuVapjwFylGwcYucOkSTFA50nFGxyB7t+NMvkb7Flqb9C+UZ/xkxbi8NXvJebnBD1CZAIMRAZLHymx8TYqbs827nKhCtrLDzwc1bWqv7EAb15EitKDTAv/h3Qxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCGR+NhLyAC7KOsmMZn61/HbVWsDBxsFp3mduweRA3w=;
 b=qZyhhqcLYlUiDVq/ehlL2Eq7cL+y/OhPO39vkBPFKs34THSIFbGcLKaNJ8u3YB9pQ/cMXGa1V6HZHVKtloqkx48GnClgCtWCrvuiaHqfKIGIjjwFJIZAPxIsLopHskZhVgFTB0s6b694MVpkOTnbV5G2kFz7SNvSGxqcRC9uLpsO8IYsniSL+i4OUDBHtuk8Na/l8dcOfi09u4k7IzFcBAZ1fYfGDEfRZWAF9z4sq80dwsz/KJCbBgPDchnc9ntYZwR30SutuIsM62WlQtMPhcGAlX7sj/SXW6VRQiitDc1lfo/uR2OGpfz8HR2ZBcHD36hPV0EvHxPWl0MLZZfIvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS8PR04MB8388.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 10:29:16 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 10:29:16 +0000
Message-ID: <0230105f-c6a3-4022-aa07-1c002f3d5008@oss.nxp.com>
Date: Mon, 9 Mar 2026 15:59:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] net/dpaa2: fixes and improvements
To: Maxime Leroy <maxime@leroys.fr>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, david.marchand@redhat.com,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260226143341.282188-1-maxime@leroys.fr>
 <20260306133035.179709-1-maxime@leroys.fr>
 <20260306105112.46d8d0c2@phoenix.local>
 <CAHHRULUkhOg0m7H496aiQ8hnC6PfbLw5xZSDpHfRX2Tsmrqf4w@mail.gmail.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <CAHHRULUkhOg0m7H496aiQ8hnC6PfbLw5xZSDpHfRX2Tsmrqf4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AS8PR04MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 60014443-b8c7-411f-94e7-08de7dc6b73a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: GCLcBZ9cIk/N12/0Y15WLYLSWh+FMERw3jDyGGiNMHxf3sQqtYBAFWjmYE8fI5pcudKirMnxzgnOwEJT5aZEN+hEIWFRPhFRTh2Zhatzn6w6fejhbA7U2gs0MWA0D0ZycE98b3ptdijYgi6SKa7qfQhdEr6WfbOJWJuU9AjKjsPdLLGb61Z0/u4FxwdN6fVC/meZ2WSchi6uLaEvQtzIiZjTaM+SKpM4m9XLba8hCV12jpI/4Sn4vUtX1VQ1TD8N8ZSGp/sDsV6qkfyQEWatNu5Hu5yCcDjmUYdMmGuRBqEbj51+ARWw1k0DFgpGb8p8gc2G+sDoANgp7WnQX7Jz7SKUKmL/0/PU7K9gwazHVCGlXt5cIzuw97fm6l2mwFpZC7vCYW8+duSbmHBsCx3YwLWTHyjUPzIxaQPZDb4OkijjPzFfs5ojJ7YaLEnm0l5dPpBLe8+TkboAwgcECSFURM69o/BdhZJXyjS0lhgCqWLCga/3SYP9ZHutNRBQrcXpX03sTsSNJPvU/WZYjd87E9b3cNbRD8bIHLJeg9pXjoadGv8p2LGE+mw2OQFntSLfG6FGOL5+n28Ndk60OhFCAhMo9a8FO5xMP/6dltbkm3OIIJNE2LJZ5NI7uKRrTTaC1JVkNEka1Po2LtZq7higzN9IFFJVMlWcJNOLXQfxjAGN37HoSdm6lzw2YEE1K38BqlJMiQxpZDiItS8ol+EzBXZhXxlgH0hdfOdsVmVQaYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFVyWDBqNnRTVVUvNnhxVlg5dHVBQjV4Vms4amVXV3Q0Vzl5OHZtYzRHWXFE?=
 =?utf-8?B?WlVQekEyNktKOTBkVE1RdnJkelZMZDhOSFVUOVNGcEIyYllhQm9DM1czL3BS?=
 =?utf-8?B?dEF5RFhBQnlwdzczMFd3Wml2SXY4YmgyQmlUZW5wcmFlK1F1UDBwR1BZWWVK?=
 =?utf-8?B?T3NkWmVIbDY4cG9RZ2M4WlRhemdOMkdzOW4rUzhBYkJCbHBPSXl2WXQva3Nt?=
 =?utf-8?B?UEJRN2N3NER4UlRBelBOemxnamZhS0JJVFF6T3hLSDRTTENaMVlpZFB0RUZQ?=
 =?utf-8?B?cEQwSHZ3TFFZYS9LcDhTdFptczBtdTdld3R6d0xBM2lvU2ZGaytkaG8xbWlh?=
 =?utf-8?B?cldYT281SEU3NVdvc2c3Vy9LZHpTZHp5cUZ4N2NocHhwam5rc25Pam1iMWVr?=
 =?utf-8?B?K3RhV1RxSGlETmFEcGxRcFY1OTlXa3U4S01mQkw0aTV3bDdQdFNSenpBeGxO?=
 =?utf-8?B?RjJiQXJ3ZmRBT1N6YU5lemlQS3MyTmtRbml2RmJNNzVBZjZQaW44cnFHOTJ3?=
 =?utf-8?B?VnR5OE5lZ2tGaytpMmF3cHFlNUMvREMzN2YxMTZSaVpXd01aZWczeWdnclE1?=
 =?utf-8?B?cHFxc1A4UWxrcmkxaWc3b1BLOExzYXlLa2x4b2NONklsbU1ubkdJUE56ODly?=
 =?utf-8?B?Z3NKK0wvZnl6b3d5RTdReXNnR1BoSlQxeVRnb2JsVWdZay9xcjZlU3hYYWh1?=
 =?utf-8?B?L1pvWGpzcSs0VnlOTFFKMEFLZGdqMXdXckw2RGtmVkRqTXpWNVE3UStiSmtt?=
 =?utf-8?B?UjQvR3ZBdkt5d3piRHJLTGJQVEFpRVZueWpWbUd1LzZ6b3pOa25sNVZLYWFL?=
 =?utf-8?B?eHZnbGVqb2ttU0dpOUdkUVJoMjBPcGp4clVQbHJoRFo5WUZMOFIvQUR3TnpD?=
 =?utf-8?B?V2hjVDFSMDhiUkFIZmY3WjVPNmI4R043YWhTMkVjR2ZWUFlvZkhsQklOakhT?=
 =?utf-8?B?dzNOMnlLNS9MQlgzR2dNeHkzUlpFL3kwWmM4Q1hKblJYYW5tUk9GSXUyZENT?=
 =?utf-8?B?RTdZdEhKTFNTcktsZGZUaTFjZlhBSUNmcG1wK2tPV3RmMVFXclN0c0FvMTQ5?=
 =?utf-8?B?OStjQVJVblkvbEpnUjg0OHZub1BNQThvaWpiVVkyTE5LaEVTWDUxaDNUcFRT?=
 =?utf-8?B?cjVCS2FHL3pWNklDb01SUWpDYmUwdXpOSTgvdTkvUnFxcnQ1Y25rUU9LNzdD?=
 =?utf-8?B?K01JS2M4Y3NoT1RwSEtkeFlxUWdnU3JsNytNVEtUd0s4SW1tS25GSHNCSlNF?=
 =?utf-8?B?MHBtdDExalFZNi9SYTd0L0pha3BQMVVNbWVITEpYVzRORXVwRHhBa2FOQ2RO?=
 =?utf-8?B?TVJyTnlJRW0rMUJHOXJOTTJzNkZSVEJCM2lTNnJpblM4anVpS01EaU52c2Iz?=
 =?utf-8?B?cW5xTGNVWUxJcFJibDIxRkZPL3duaDZKY0R1aUp2MmxRbk5leHEyQTNncmZh?=
 =?utf-8?B?amtQb1ZWZWdlS0w4MEJEQlVsT3l6VXYxOVVsMEY2a1k4UWhRU3hkU0phSE1N?=
 =?utf-8?B?YmNnQUtDdEdXYUxUQ0pjTGwyVjVLRWgvSGIyY3NLL0xFS3NRK1cxWEFQQ2Fo?=
 =?utf-8?B?S1ZRUUlhWEtUWmlpenhuNEhLeVJSN0p3RWxlRWgrRXJNVnNwb2kyZ0NyaThQ?=
 =?utf-8?B?MGpyUGsxcU83cEhSdy9PUWNHa0p5V0I2bDNUNHlsZE9UQzRyZTJhYkk4MVd3?=
 =?utf-8?B?eXJEZFpnTlhpRWtNODB3MGZ4dDBiMTlKUnYrSlZzbUR0alV6UU5jNGEwNDhV?=
 =?utf-8?B?WFFKZGVFdEVoNkxGVVh3dUlZSFFsL2MyTHY2Nnp0T0lMZ3phbGovTTN4RkVL?=
 =?utf-8?B?Z2Q4RFJ1NnBSeXFseEVsSzdXM0tRMVpaRUhVbW4rWjZ1S1h1LzJKQ0IycVQz?=
 =?utf-8?B?MnhrYXc4Sml3VmxGcHJFLzBzdHpac0RFOG1TZGg5NlNDdW5RaU9YaWJrTk9Y?=
 =?utf-8?B?Ti9GNWJZTWhjMWFUM3Z0VlMxZmduWW44NmlaZmg3QzlYWkcvZjJDSzdMKzd5?=
 =?utf-8?B?ZllXWDRUcHdnYjV5bkJVeFZaN25PMmVvdUhHQkk2L21pNHFyZVNSTHIxbkJq?=
 =?utf-8?B?Z3lWeDdWeGphNG5BZjJuS0VFRG5DTTAvL0gveEUxOENaTWV3ZlZaUTRYUXpF?=
 =?utf-8?B?bHpsZXc5cnY0bHcwbVdDcmJxMmdwN1NNN1d2a2UvWGwzbGN5QzA1aUJseXJY?=
 =?utf-8?B?ZCtwSThUTzdiNytKanE1YVM5d2UzZGpxdlJVcmFWc2FzbWU1RjNMTGV0OXZR?=
 =?utf-8?B?aWRVckxDeHJEVGt1Q0Z2RDJTTTdOa0F4ZE9zZXRaeWxTR2hvdGRMdlNrNDJE?=
 =?utf-8?B?TGlMVWQxUUpoTC9CMFV0K0VWaEFpZVNreVdBWVBnMnFKZm5BNVdoa2ZWc0N2?=
 =?utf-8?Q?W4lBESK/ov71P4Wk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60014443-b8c7-411f-94e7-08de7dc6b73a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 10:29:16.8226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XA2SVatX6omGo/vpMjNpRhhYsPnTJL4p/yfpccJGjsCaRBxEyA4NFbnlAzJPq8oxg+olm2l06t+LlZL6E/YX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8388
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


On 09-03-2026 15:15, Maxime Leroy wrote:
> Le ven. 6 mars 2026 à 19:51, Stephen Hemminger
> <stephen@networkplumber.org> a écrit :
>> On Fri,  6 Mar 2026 14:30:18 +0100
>> Maxime Leroy <maxime@leroys.fr> wrote:
>>
>>> Various fixes and improvements for the dpaa2 net driver and fslmc bus.
>>>
>>> Patches 1-6 fix resource leaks on port close, error paths, link status
>>> and devargs propagation on hotplug.
>>>
>>> Patches 7-14 fix additional bugs: spurious VLAN insertion, error packet
>>> dump crash, packet type classification, checksum offload flags, software
>>> taildrop buffer access, burst mode info reporting, SG table walk bounds,
>>> and MAC stats DMA allocation.
>>>
>>> Patch 15 is a minor cleanup in the link status area.
>>>
>>> Patches 16-17 add devargs alternatives for getenv-based configuration
>>> of taildrop and data stashing options.
>>>
>>> Changes since v2:
>>> - Fix checkpatch warnings: short SHA in Fixes tag (patch 14),
>>>    long line in commit message (patch 10)
>>> - Fix check-git-log warnings: shorten headlines (patches 3, 9, 12, 14),
>>>    fix tag order Fixes/Cc (patches 10, 11), fix wrong Fixes reference
>>>    (patch 8), remove colon after function name in commit body (patch 8),
>>>    lowercase macro name in headline (patch 15)
>>>
>>> Changes since v1:
>>> - Add Cc: stable@dpdk.org on patches with Fixes: tags (Stephen)
>>> - Reorder series: fixes first, then improvements (Stephen)
>>> - Patch 2: squash with former patch 4 (Hemant)
>>> - Patch 6: move devargs refresh from plug to scan rescan path (David)
>>> - Patch 17: keep getenv for backward compatibility, add devargs as
>>>    alternative instead of replacement
>>> - Drop former patch 11 (bus/fslmc: remove dead blocklist check) to
>>>    avoid disaligning with other buses (David)
>>> - New patches 8, 11-14 fixing issues reported by Stephen
>>> - New patches 7, 9-10 fixing VLAN insertion and packet classification
>>>    issues
>>>
>>> Maxime Leroy (17):
>>>    net/dpaa2: fix queue block memory leak on port close
>>>    net/dpaa2: fix Rx error queue memory leaks
>>>    net/dpaa2: warn on Rx descriptor limit in high perf mode
>>>    net/dpaa2: fix resource leak on softparser failure
>>>    net/dpaa2: fix link not up after port stop/start
>>>    bus/fslmc: fix devargs not propagated on hotplug
>>>    net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
>>>    net/dpaa2: fix error packet dump crash and memory leak
>>>    net/dpaa2: fix L4 packet type in slow parse path
>>>    net/dpaa2: fix L3/L4 checksum offload flags
>>>    net/dpaa2: fix software taildrop buffer access
>>>    net/dpaa2: fix burst mode info report
>>>    net/dpaa2: add SG table walk upper bound in Rx path
>>>    net/dpaa2: fix MAC stats DMA alloc per xstats call
>>>    net/dpaa2: use check interval macro in link down path
>>>    net/dpaa2: add devargs to disable Rx taildrop
>>>    net/dpaa2: add devargs alternative for data stashing getenv
>>>
>>>   drivers/bus/fslmc/fslmc_bus.c           |   4 +
>>>   drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |  16 +-
>>>   drivers/net/dpaa2/dpaa2_ethdev.c        | 211 ++++++++++++------------
>>>   drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +
>>>   drivers/net/dpaa2/dpaa2_rxtx.c          |  85 +++++-----
>>>   drivers/net/dpaa2/mc/fsl_dpni.h         |   6 +
>>>   6 files changed, 164 insertions(+), 161 deletions(-)
>>>
>> Applied to next-net, minor edits to first commit message to fix
>> the reference commit; problem reported by checkpatches
> Hi Stephen,
>
> Thanks for the merge. However, I was not expecting the series to be
> merged without an ACK from NXP maintainers.
> Many of the issues were found through code review only and marked as
> “not tested”, with only minimal runtime checks on my side. I would
> feel more comfortable with an ACK from NXP.
>
> Hemant, could you please take a look at the series when you have a chance?
Yes, we will be testing it soon.
> Thanks,
>
> Maxime
