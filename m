Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C3F532D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 05:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2360F402CE;
	Tue, 24 Mar 2026 06:19:40 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
 by mails.dpdk.org (Postfix) with ESMTP id B970F4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 06:19:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXiE+Zq7a/uIU7N3dnlK1lDY10KYJOySU9+rF/3NgGeOtae3b4Ey8MjpVtB0dfc3thM5KHWGz3k5qmJR9Raw+Ba/C7T4MyA4/PoU7+cE6OHw4U44K2D5QNgRJu3qzGeMRbZQlYPjdcQRO/clCCmZocK/hTb/hf5tMvN18gQvFnTBE2y8lOzmy/9f9y6cQHHnpr6ldKHNm5CMieKfy/EajQtlMdKYQgulzjl0x8k3F5T8ID9SK+giCAhtoQzPqENxRh6hdyMoV7isIZ71f1rsv39mOtMEQSDXPcA+KrSkq/TNp9fhuk7wVOwqq4lBpnCWwu7nEYS/7NlZUDQnbbDCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2WPtdbTK4l42xdn8shcde43KCtVsm/SIgfoOAhDjCI=;
 b=hrPBRMi1OYzq3dXq5Z9bjBIsB1Phkb5pBX9md+99EJTr9CdO/nUhhMuhzzHORqwdKqncDvNaFjZvgMqIVf53ySr4iq9AYUhzML8ezecbE2LrEH+H2AP5wfDOgIv3VDZKgnKfNPPu/+yuXg8LkFdz7vaq4Lw79xtP8qmjnyeKXTTjlJ5TGeR4aKu0Q9iCSL911jIuESB+GS5N4bL4bCkdqsLiA1jMRlF6buHx9WKEWdM7Z/m+3zx1isrONnOX0B/Y56xW0GHvOXgGrZHQyEfgY8aIAl+p8Zh8KmM+8y33HFEOqNXDmJ0ivoO+RUPYfw8QfQx9i3kQBJr9GiV8MbNFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2WPtdbTK4l42xdn8shcde43KCtVsm/SIgfoOAhDjCI=;
 b=sWcGYzHnzk1hfvGNR+yxgWZYmKjr62jtxUhQsw/EUvQHxN4gmMvxv9czZMjGAlUXNP0dKQHSqULQvftALTrokdWQGRrvvJr0UAw31vYDlzoUA7/CBoglOgJt0Ca4ecYDeKfveh0wWRCP/XKvq4O1RU0gCYcfwizR6TC8wIQCqfM2oW1vVDOrjkjPES2Q5xg2LxHO6OffekO3cQ1xLsC2BNJ7L27mZ3/GDNMU+oOVhVAjOHNslgbsb8QsBv0PlwP5R2ZOj2KiwC25yqoje66fHxOWAcGisq/bxdpbjt9wp8F2rzMhI4SKkxqsUt+9QbdLz+JUkj4QHhXZOW4BSAGA6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 05:19:31 +0000
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7]) by PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 05:19:34 +0000
Message-ID: <a3b584c9-4bba-4f93-8910-ecf0cbfc46d4@oss.nxp.com>
Date: Tue, 24 Mar 2026 10:49:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] net/dpaa2: fixes and improvements
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
To: Maxime Leroy <maxime@leroys.fr>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, david.marchand@redhat.com,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260226143341.282188-1-maxime@leroys.fr>
 <20260306133035.179709-1-maxime@leroys.fr>
 <20260306105112.46d8d0c2@phoenix.local>
 <CAHHRULUkhOg0m7H496aiQ8hnC6PfbLw5xZSDpHfRX2Tsmrqf4w@mail.gmail.com>
 <0230105f-c6a3-4022-aa07-1c002f3d5008@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <0230105f-c6a3-4022-aa07-1c002f3d5008@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::6) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB10770:EE_|DBBPR04MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cd656b-541d-40b9-7543-08de8964df3c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zMSGm7wQQZWQPqhf+MZHx+PX+wHEhp6Qx+03qezDW1uyz3I5Za6+KGZx6juDjwGE4AU2nkhjAqUdT4TKFHrEBFZFIN0wzcbtrMUF3S67DF/+2ZZdhlP+H/jh3+tf8F674Jo/RW3g90VYxb361xfUbTd3Mwe6V7BensUceAsv9Ngvyqt0WhfhrjY2VQ0UfQQO7DJ/L+y6D+G2ygHPlKyX4AKfaWrStr8tDh51ZNSeRmajlZsqYcDW/fXSfgNfdkhy68FQNe/kf7IccR+LUwX4NTzBV0eL/7iXV09pG3OgGzjfdpImSuURhgWcCfF24JF4Mlqk7+LPWvL9ot7nqKFFuOvvwzzgTOyk/TJSVtxO9WzJbLqaWnmJlH4GsAsU1VGiy/Ciui5wwyElY7O12isIQ3t5WwjaNHOQkEuh6AMHu4DuwMf/n7ficjMluM+GSVrDpJSGpBtcL7UdVLpuVNz1X1Jk3hIVbY5Jd0dX5wRmTAHLvOLuF7NU5imuf63r9Et35f0EOWNSTXmymWsD45wtSTYsANXaQuDje66RvyB8GLjX02+GSDoMeLyp1C1lxV5P/uU0+ME26PIe03QKOWR/OY/DDZxBrH7Okgq8m65x6PuhtZ+Spo/isLLwkBJ7FckN4VSJdrAjV72e7vTmd1JxJ8KfRGHAZPjI2wsYZmgqjwbb8q0kPKyyLWL5yMQ282xYnhMBLJSEv+cJD4KMtt41ZtnFpmlwb3hzwrHndb5opds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1PR04MB10770.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHNXN1BMUnhvTnpRb3kyL1RacjFZbzZ4UmVHYWp5SjJSY0haQlNUUW5TOEt1?=
 =?utf-8?B?S0FtdXlHVm9Tc25FUmVlUnZ2a0dPUkRzeVZFRjh2L0FLUmpyb2VHYkFwM2lj?=
 =?utf-8?B?L21iNGhxbXBYT1Q4VVZFUnpaTFpFYUNTNkxLZVlqajZFcUtoVFJEbGhOay95?=
 =?utf-8?B?WHVseTNPeTlHUktja296S0prQlcrRWdwNnNOODdkTmE2L2Vsbm92SFMxWW9i?=
 =?utf-8?B?ME56Yk5jSkhtQjE1THlHRlh5TnZOV0ZOOXlydzArSTBMbHhSUkRkYWNwWDFH?=
 =?utf-8?B?azFzdXFYVWg2dUhXTmUxSVV0YnZGblJmYlowSHZnUEs1dkVvcG5yUUpXeTNk?=
 =?utf-8?B?QWdGL2t2bUtueWdQMWxwVG9Fem5BdHcyWVBxQTN1Z3dRRFUzcytOZEZEZUR5?=
 =?utf-8?B?TGV4Q0lTdUZhTHhXaXhIZG1xelBaK3lqdVRQSDQvR1NidW45V0JyNEJLeG9x?=
 =?utf-8?B?d2h5dG5FVnBzanNCSVIyVWU5UnAyZGFWNmdHWUxvV1FIRXJHOC9uZm5hM1Jy?=
 =?utf-8?B?NUZZQnpTYlpnVkQ3cGdSQ0MvSWFJbjk4cDh3M3pMNGpyeWRLdWpaVUZQRVZG?=
 =?utf-8?B?dytlTDJGZ2NJSHkxckoyaTczNmQzS0VMVlk3S0VoUm5RYnlSS1FsUkdyRnNW?=
 =?utf-8?B?VWRNeHYwRVd6VVZvTDAvTktiZEd5QTZMd1hDM3IvRVNGcG94RkxrNUpiRnk0?=
 =?utf-8?B?cEpVc29XRjZIb21YZ1VtRzhSUGY3Y2JEdGxQMzJuRit5S1NrZTdHVkNLK0Zu?=
 =?utf-8?B?dTFvWkdzZVNycGsvQUhSbnp0OHdFUXhKS1dJVFZGN2Z4V29lTmdaemVTZnBO?=
 =?utf-8?B?T2kwek9Ibkd2Mm41SkdqUCtHZVo2bnBZWUtlbEUwT1NLa0tTKy9hQ25vdDNo?=
 =?utf-8?B?KzMvbUZLeGJGbEo4aFptb1pEK1RxYThhMTN6dzFNeUVwZ1RzZU9zUTdHNmRO?=
 =?utf-8?B?VDRVd2dvWE5pRkk1blpoSHJQY25DVXh3SmU5Unc1cTRtcURzODVZZEJCL3JQ?=
 =?utf-8?B?R2VTVzQ3b3VyZmR4cmhHcTFGamw5Y01RT05Mc0tCQjdwM3dPRkI0Mm9RRHlS?=
 =?utf-8?B?cVhTYjB2cVBWRkMyaUJFZE5rdWZvQzd0QUZ4V3lraUEwVERDQUZpd2JDR1ZF?=
 =?utf-8?B?d2FPUWJaVnowemlhOVArelVNaXorRi9VUXJ4ZW9TbFU1OEM5L0RnYVNZTEJJ?=
 =?utf-8?B?a0czcGFKNTBGNEZnUlBWQ3g4aXlYZ2FiY09IZXVlZ1cxY3VrSnQzZ2xCVG1P?=
 =?utf-8?B?SmwweDNSUzJnM3RJc2VRS0tOUmt4eUpHTkh0bUhYV3lhUDA5bEtKMk5QWnRx?=
 =?utf-8?B?UHgwT3pKd1lIMUFFSU1LRHRHbE00d04yMzRuZ3hocUoxUDgxSnFmZGtwN1h1?=
 =?utf-8?B?L3lhZzVGZ3dFZWlrUkFCQXhTTFpvMVNpd3VyaFFocmx3c0k0aStzYllJOTRr?=
 =?utf-8?B?UlRQMHR2enJvVXFJcTRrRWNOUklMa0VOdDlvZ1NRRUN6VUFQOEZNNDZQVlB1?=
 =?utf-8?B?aThpTjdWV2hybWQrcmdOLytac0FaQkRHN2Zic05idnNJampQVjJXa1JYSnVi?=
 =?utf-8?B?ci9waXRCcDMxdVZ0bnpJZ1poK3ZiZHdkSmtOdDE2Umh2bTNXZWE2UFljRSt4?=
 =?utf-8?B?L3hwMmtyL0RwRUxTV3hRUXg4bHpVbzdjNnJOVzA5ZFJGWE5JZzRMUnlZdGVn?=
 =?utf-8?B?Si96ZHlSaHVuZnpOS2FRY0NiMHo4cjZ0c3RSaUxNcGVkYmN6T1BwWDZ5RGxp?=
 =?utf-8?B?MlZPMlV5UTZhWSs3elA3d0djTnh1WnRCZHJFRk1yWjNlbThIZGZSZi9QZFEw?=
 =?utf-8?B?VnRLQmZCOU5lbmgwSGE3QWEyOGd6YVlpaUdRZkhvcjM3NUFkN0g3a294L1ZQ?=
 =?utf-8?B?Vlg0ZGhqWXVqelFPZ0RMQytUMnNhcGU5dXE2UU05K3hodGVHNXJJREdUbHEz?=
 =?utf-8?B?WWlkSTF5UElwS0xyanVVa0pCUUxaN21VQTBQZG9GbzBLYklxaXQrSUVJNjlG?=
 =?utf-8?B?bCtzRittZWRnQm1oSzdkNzJuLzJDUVN5MHZPQlVoUWFneXhoSEsyRktMMmRs?=
 =?utf-8?B?OXFOSXhnZ2JiQVJtMkd4TWh2anB3WXdQZFNjZHN3Wm53ZzloY3REK2NDeTZD?=
 =?utf-8?B?c3E0T1RhM1dJMnVHSEVNZ0hrcnphWjZyb2ZTNDhRdW4xZGRJTmU2Qk1IMVRI?=
 =?utf-8?B?Mm8rN3Z3bi9yRWdvNUlSYVdrZlUwU2RuMENCVGhiL0dsMWVoVHlhMDVhMExq?=
 =?utf-8?B?Mko0RkFEalA2TTJpZGJLTU81WlZFREpNSnpPaGhvS0lkcHppOWx1Z2pmdm85?=
 =?utf-8?B?VUQrR2EzUzlCUDBwZ0ZxYlQ2ZjdDUkFrN1ZrWW5CdDFDdVkvRWVlSEpRZG9z?=
 =?utf-8?Q?ZbcQpBZJM8qssM3s=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cd656b-541d-40b9-7543-08de8964df3c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 05:19:34.2241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyKMT0hJV7EB+0BgRvgMFKVBMa4dQQyJNQpxUtsBeE5DCywfsEOg+CXQmHoBLNYRZXUsAIBl0+zL3+i/Ej8KPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499
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

Hi Maxime,

On 09-03-2026 15:59, Hemant Agrawal wrote:
>
> On 09-03-2026 15:15, Maxime Leroy wrote:
>> Le ven. 6 mars 2026 à 19:51, Stephen Hemminger
>> <stephen@networkplumber.org> a écrit :
>>> On Fri,  6 Mar 2026 14:30:18 +0100
>>> Maxime Leroy <maxime@leroys.fr> wrote:
>>>
>>>> Various fixes and improvements for the dpaa2 net driver and fslmc bus.
>>>>
>>>> Patches 1-6 fix resource leaks on port close, error paths, link status
>>>> and devargs propagation on hotplug.
>>>>
>>>> Patches 7-14 fix additional bugs: spurious VLAN insertion, error 
>>>> packet
>>>> dump crash, packet type classification, checksum offload flags, 
>>>> software
>>>> taildrop buffer access, burst mode info reporting, SG table walk 
>>>> bounds,
>>>> and MAC stats DMA allocation.
>>>>
>>>> Patch 15 is a minor cleanup in the link status area.
>>>>
>>>> Patches 16-17 add devargs alternatives for getenv-based configuration
>>>> of taildrop and data stashing options.
>>>>
>>>> Changes since v2:
>>>> - Fix checkpatch warnings: short SHA in Fixes tag (patch 14),
>>>>    long line in commit message (patch 10)
>>>> - Fix check-git-log warnings: shorten headlines (patches 3, 9, 12, 
>>>> 14),
>>>>    fix tag order Fixes/Cc (patches 10, 11), fix wrong Fixes reference
>>>>    (patch 8), remove colon after function name in commit body 
>>>> (patch 8),
>>>>    lowercase macro name in headline (patch 15)
>>>>
>>>> Changes since v1:
>>>> - Add Cc: stable@dpdk.org on patches with Fixes: tags (Stephen)
>>>> - Reorder series: fixes first, then improvements (Stephen)
>>>> - Patch 2: squash with former patch 4 (Hemant)
>>>> - Patch 6: move devargs refresh from plug to scan rescan path (David)
>>>> - Patch 17: keep getenv for backward compatibility, add devargs as
>>>>    alternative instead of replacement
>>>> - Drop former patch 11 (bus/fslmc: remove dead blocklist check) to
>>>>    avoid disaligning with other buses (David)
>>>> - New patches 8, 11-14 fixing issues reported by Stephen
>>>> - New patches 7, 9-10 fixing VLAN insertion and packet classification
>>>>    issues
>>>>
>>>> Maxime Leroy (17):
>>>>    net/dpaa2: fix queue block memory leak on port close
>>>>    net/dpaa2: fix Rx error queue memory leaks
>>>>    net/dpaa2: warn on Rx descriptor limit in high perf mode
>>>>    net/dpaa2: fix resource leak on softparser failure
>>>>    net/dpaa2: fix link not up after port stop/start
>>>>    bus/fslmc: fix devargs not propagated on hotplug
>>>>    net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
>>>>    net/dpaa2: fix error packet dump crash and memory leak
>>>>    net/dpaa2: fix L4 packet type in slow parse path
>>>>    net/dpaa2: fix L3/L4 checksum offload flags
>>>>    net/dpaa2: fix software taildrop buffer access
>>>>    net/dpaa2: fix burst mode info report
>>>>    net/dpaa2: add SG table walk upper bound in Rx path
>>>>    net/dpaa2: fix MAC stats DMA alloc per xstats call
>>>>    net/dpaa2: use check interval macro in link down path
>>>>    net/dpaa2: add devargs to disable Rx taildrop
>>>>    net/dpaa2: add devargs alternative for data stashing getenv
>>>>
>>>>   drivers/bus/fslmc/fslmc_bus.c           |   4 +
>>>>   drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |  16 +-
>>>>   drivers/net/dpaa2/dpaa2_ethdev.c        | 211 
>>>> ++++++++++++------------
>>>>   drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +
>>>>   drivers/net/dpaa2/dpaa2_rxtx.c          |  85 +++++-----
>>>>   drivers/net/dpaa2/mc/fsl_dpni.h         |   6 +
>>>>   6 files changed, 164 insertions(+), 161 deletions(-)
>>>>
>>> Applied to next-net, minor edits to first commit message to fix
>>> the reference commit; problem reported by checkpatches
>> Hi Stephen,
>>
>> Thanks for the merge. However, I was not expecting the series to be
>> merged without an ACK from NXP maintainers.
>> Many of the issues were found through code review only and marked as
>> “not tested”, with only minimal runtime checks on my side. I would
>> feel more comfortable with an ACK from NXP.
>>
>> Hemant, could you please take a look at the series when you have a 
>> chance?
> Yes, we will be testing it soon.
Once you address my other comment, you can add my ack to the series.

Series-

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

>> Thanks,
>>
>> Maxime
