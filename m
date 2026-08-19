Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAE9C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 06:09:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8DBA402DD;
	Wed, 19 Aug 2026 08:09:12 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013011.outbound.protection.outlook.com
 [52.101.83.11]) by mails.dpdk.org (Postfix) with ESMTP id 64ED240041
 for <dev@dpdk.org>; Wed, 19 Aug 2026 08:09:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7p2gZuC3NQTO+mMDXfaPuHPyYQFDEVNKha3piEucfD0Eiku9ErgAzH+iLlW1c56I78sm8serVvBABlvn+ekx4Kpbid2MnQrdz+zwteC1JslJEEmTQOQLVZnyJ/yoj79jSHOEU54VGK+f8/pow3whEFx2h/vJNGpH3e1U2JhdowhDwIHXXSuJ/jXvut1NB/SgCSFNyvHz0e4sAbxKUSxFoKWFLaDYISVJkh4hljmEJpPCG0nugC4KThgxKo54UzsXyF9X+PSl9jLTjncy5hp3OHNQ8YG1wTBX+HETt85FIlmxxH284nUhqf/5GwJ2ffUsKML135DsxYFuld+Wev6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6lJ00/ROTb652gaicikjCs6fwIVbXimd9TTPZw5uTY=;
 b=YoMT6VXx4x1pF6yRU6vhcj1NqRtQJQ++KJZIn7kp/3KJ3tO6b7Gr8EGqxSianv57l5XAnUEFYVqKn5vT8Yw82v7akHIcoby5wZhz5iZk59VNmYQrM6HaoqChbAF0caDw1jympyLIKQwWN+1uh4f9Y0Ce0DdGqfVjy+dqFaUXaL4czgHmXEQz75i2WnnW0KEW3wpWScMqrmFw2XGaXOlw+SmaGdWBwXyvMqBw+w6gKAtM8XblDYDCtZZQdLvX/TdjxSErMMaEYqObM3o+TP9pVuNyIB19KNabHHwKFop4FHV98yBbN+uktGGXRZLPYDHKCrlCnZR7RgNyzUP+6M10dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6lJ00/ROTb652gaicikjCs6fwIVbXimd9TTPZw5uTY=;
 b=jcMlsnb4MMKkw78kd2bFT3ZxsY5/nG0eTWkNXnCpChGPlZ3RMua0wPyprXXyg0M6FlyrT67Db1PeXX4kwjUCMi1v6B3RdmFzq8e+yPjfcL8s+w65ZUoxRs0SgFjQQTxGRlzVHV8wWLuTKM0Z1YIW42ukpN2FLPL2YcjfkUkmMDPZX52yFxwpq3VBBqg+qhC746ZC0TWGubg0L5VME4S7E2wxfXSh7QqcRfD+yQYqV8sddHzcEByi6YwD0IEijBOxUiB+3MwQ1Wg9pKB3IEzKs04kM0ywDO/du7jEnOqg2O2Hk/y9kF2qwvn606zc6ILaJ4wEeVEWRtBLWhNKSuInug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DU4PR04MB11816.eurprd04.prod.outlook.com
 (2603:10a6:10:626::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 06:09:07 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 06:09:07 +0000
Message-ID: <f0cdd072-4759-4610-9fc0-5ec9802bd6db@oss.nxp.com>
Date: Wed, 19 Aug 2026 11:38:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/26] net/dpaa: add Tx rate limiting API
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, stephen@networkplumber.org,
 thomas@monjalon.net, dev@dpdk.org
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-17-hemant.agrawal@nxp.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659F8@smartserver.smartshare.dk>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659F8@smartserver.smartshare.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|DU4PR04MB11816:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d03fff0-db74-4e18-7e40-08defdb86084
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|23010399003|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OcCFCjbwS5kMXdZDIx0BX5DQclAqzwO5gMbzBeqU3DDHis+96uyCQjbXtZ/1x8Zur/R/LRWG1alrOFXCdHu/NEHduIJnJU/JaldoeRc1ZY7E3NC7U5kR1ZtdgUM4HhcJGent/87lD36YuPg3Vc6s8AcSHg6RusADuy01r3OW2U+IG+IRNxwqsOSrGcb/uEwB4s4ggIgsRNPt3QzKT8sbwj+tXPar9OR0lI2fFRxhRiO7wDYXECa1ea8SDvhwVAX6LvokZ4+ZauposXZd5W3TPOa4Jn6cY8GaVv+52qb0trzyL4KE7X/AGL+SelItYdIKY9s0OFX0Mq44UhDwRukXyp2Sc1XEY416KrdCbMw7p/HAuGQNZr6IhwNi6BqPiLd1zLF6wFVYvneIiFg9kHH62P89ISRhq3KEHoq+yzxDwj0nCMtdycZTPD6Ys/fk6yZxYfbM/eBN3vmXd+0hqYTh+ff7sxJamPodmCn+JOS5eHht5iN4tqJpfAnHwI6KGJNn4dli1wgqawiHmIEX0EAdUIc+DHh8vYIKirC/lLA1ZwCFk+FwhZh1J5PMbedWJIZUjAnqWdCnwCkCKOH92D5H4Nct9EbUk4+kJckokGznSruEMpROmiX7c8YHfdsHgPUsow7m5oQ3R+55baGtD+CCj96+x1EclW3WHI0hJBq9Bxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFovUS9oZTVUZ0lmWTNmY1NRZjlOQzlDRzlLaEk0YS9HRWpSeTNqN0w2YW44?=
 =?utf-8?B?Z3lQUnBISEFMWXBhL0RINEtOSS8xN1ZHcXZJbFlaYjlkbEFpV0NGUzQ4Qnht?=
 =?utf-8?B?MlVFZ3RFZ3VHZmFMUVBWT2FZV3RzcjlwV041VVhVZFVTQ0NKbHRWSjZFLzNI?=
 =?utf-8?B?NkxKcEZobk05VUxrTmFoMWRaSGN4Vm9yUCtocXJLM2JHejhLYVdJc0UwYlNS?=
 =?utf-8?B?QldSVnZJTVpWWkxpbXZ1MkFoYUcySnVFSlFFWXo4QzlSNGcrS0lWSEVTVUJH?=
 =?utf-8?B?dWt2bzRKSTlPV0RrSzB6WkU0bmU0U2U1VDcxTVFGK2xFQUFuS1F2WGxZM25q?=
 =?utf-8?B?bXJjOURNSkRDNGtKZ3VLWWQrV0k4WEVJaUlZbnVRSG1zS0ZkaG5GM1VvczY0?=
 =?utf-8?B?OCtrcno3TlgwMndVWWxWaGxUcFRNVWtnKzdCV2toYUJKWkhjYVN6YTgrM1VR?=
 =?utf-8?B?K0p4alRCdmU4TlgyMnVGanpRMWk2RnR2NE1XM2NJU0s0MFNDK0VHZmE2UkY0?=
 =?utf-8?B?SUxaY0VnVThma0tUL25sS2VVM2w4bUVSa3k2Ly9PMVFvZHh4YmhZbys5cjI2?=
 =?utf-8?B?QnNEeHJUZUxGQ29GTTlselFzVkptTEYrdnYzZEdGTGVjYjdEcytLd09rQmJn?=
 =?utf-8?B?NDIxMklrZ3ZlUXJUVlJzN2c3SUkzQlZLSmthSUNmMVlId0VXdzcxUWVOaURV?=
 =?utf-8?B?bkxKcXlxMWN2UDJuVld0MjRaTVJRbzhVdmpWOXZKekxPNndUVGxCZkd6cVVU?=
 =?utf-8?B?bUFWVnBMeDZzV0RNUmdpcDErUE03L0x2ekt5Uld2VUR6L2RiUHFNT0pqejRp?=
 =?utf-8?B?UjJzWm5DQTRsTVJJd3RVeFVpRXRGWjhsekJyRUk0QUxBbHNBV2tweXZzYTNp?=
 =?utf-8?B?TWtMUlA1MGVXUDI3REZMTmh1ZDVtYVRVazZsSWQ3NDlXVTFHL3E4TU5vLy9K?=
 =?utf-8?B?YWIvR3RyWkdLWThoOCtxRi92R1JoUkkyRXljWWVRR2MwSCtSdTRkWVROTlVL?=
 =?utf-8?B?clo1OVNZcHA0ZWlRZDdSYk95b0ZwcDlPemdVQjIwZnNFYklqZnBtemNiaXJJ?=
 =?utf-8?B?d2w5NTU0OXkwaWFrNjBJZ1lVaEJtOVZsVVYvQjRlY3o0L3JNN3lUdkExYmVv?=
 =?utf-8?B?SlUzTm9LTCtDSURaY1BxMjk2akJkU0l5d1hDa3I5L0xwbjNheVJYaGVSRWMz?=
 =?utf-8?B?Qm84VFJYWnFQcG44NE44Y0tVM0g5QTJJZUVYZzFhTXJqSnhSQmlSeXc3Z3Na?=
 =?utf-8?B?L01JaFBER2c3Tno0Y3o3WTZObmt5ZFY5OXhpQXE0ajI2VVYzZEorcGpXZ08x?=
 =?utf-8?B?UVZpUGFucHh4dk9BVG5MMDJ4TkdLcFhUUnBSMWRQckhjQ2tBUEcwQ0lja0RJ?=
 =?utf-8?B?U1VrbFQ0dGZNRjVrZklxWXFsKzZaRHdPdlQ2eldudUtOUDlCalJjRXV3Rzkr?=
 =?utf-8?B?TDJwZXNsTlhLT3U4OEF5WXFZN3FTenVLTG1yTGJlQ0hsOStLN3NnN0FURkRr?=
 =?utf-8?B?NlF3akphY0xYbGNTMjhleDM1M2JBbktSWkNUVCtiRERwYkZVaTFZbGZjeE51?=
 =?utf-8?B?cTRHK3pOUDRaQ3RMeGl6VDBZU2VhYVVBVHE5L2Mya3N5SlhEUDdqaGg0TVgz?=
 =?utf-8?B?all0TDZsQm56TmxkY1RaVDk0dW0wOFpwazBsRE0vTEVMZGJEV0NzSXdTdzhy?=
 =?utf-8?B?bmI5RWhkL1kwNnJUMzdYa2piTmhQbDJYWjdlUXQrRkhGbTdVdlYzZGhGZHlJ?=
 =?utf-8?B?U0txcWM4bWFzYzZnT3ptY2lVVkdzeDRkVEVDczgwZjNzZzI3aTRSNlI3TGVw?=
 =?utf-8?B?SzBxaVdvdHR2Y0ZmRnNmeTAvUWs4akZTZkRrSTU5T0VnSC85UU5oWUt0UTlC?=
 =?utf-8?B?RU1WWjdMTFpKMzVRR0tlc29iMFRueHpjeCtUblB6cnE3c1ZVVDBpNHF5YnVW?=
 =?utf-8?B?Q0JMaEZtNXowYytrT1J5NGg2dnc5bG5ETzEwNkpkcU0rQkhEbyt6bHhFME1k?=
 =?utf-8?B?TkxOY3lmc2dIR2JNYzVCZlJLeHBVVm9WSUI3T29vM1NFZStjbE1ENUJDb01C?=
 =?utf-8?B?empUSmlYdVdPdllpdjZJUGlQZ0dtRU4zN0RFcEo4R2k1QzhkdUptWDFWdTVB?=
 =?utf-8?B?eEpWUFJ1YmJKMUhYTGhWcTVta3JTRTN2Q1hlQTRheGhMZHI1QWFXR2YvS3My?=
 =?utf-8?B?RVQ5VUtEUVdsS05kRlBTWUV2UVJWeGlUZ1VXVEtLNC85WmdISlQ1Q01HeVgy?=
 =?utf-8?B?K0YxQ1Q5UUZKai81ZjYvc1dBb0duTDhQRi9aUFFlM1FSeHJmWGpYMVBleTlB?=
 =?utf-8?B?L2ZpVnFteXp5d0I4ZFVHN2ZxUFFyeTljc0M5QmxMWGxPUDFzczJVS2ZDY3lN?=
 =?utf-8?Q?9mFpizo8tUFjDbGs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d03fff0-db74-4e18-7e40-08defdb86084
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 06:09:07.1917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCgLy263GkTtyMl1ZEMbFWXd5jwLf4c7WW12OCXIzHnX1mjLHvQFdP2iX9rFdtNlccxTkuk5Hz2CEg3gjDSRGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11816
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

Hi Morten,

On 18-08-2026 17:40, Morten Brørup wrote:
>> From: Hemant Agrawal [mailto:hemant.agrawal@nxp.com]
>> Sent: Tuesday, 18 August 2026 13.17
>> To: stephen@networkplumber.org; thomas@monjalon.net; dev@dpdk.org
>> Subject: [PATCH v12 16/26] net/dpaa: add Tx rate limiting API
>>
>> Add a DPAA PMD API to configure the transmit rate limit (rate and
>> burst) on a DPAA port, using the FMAN port rate limiter.
>>
>> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
>> ---
>> diff --git a/drivers/net/dpaa/rte_pmd_dpaa.h
>> b/drivers/net/dpaa/rte_pmd_dpaa.h
>> index 0a57e2097a..680ff387f8 100644
>> --- a/drivers/net/dpaa/rte_pmd_dpaa.h
>> +++ b/drivers/net/dpaa/rte_pmd_dpaa.h
>> @@ -1,11 +1,12 @@
>>   /* SPDX-License-Identifier: BSD-3-Clause
>> - * Copyright 2018 NXP
>> + * Copyright 2018,2022 NXP
>>    */
>>
>>   #ifndef _PMD_DPAA_H_
>>   #define _PMD_DPAA_H_
>>
>>   #include <stdint.h>
>> +#include <rte_compat.h>
>>
>>   /**
>>    * @file rte_pmd_dpaa.h
>> @@ -33,4 +34,24 @@
>>   int
>>   rte_pmd_dpaa_set_tx_loopback(uint16_t port, uint8_t on);
>>
>> +/**
>> + * Set TX rate limit
>> + *
>> + * @param port_id
>> + *    The port identifier of the Ethernet device.
>> + * @param burst
>> + *    Max burst size(KBytes) of the Ethernet device.
>> + *    0 - Disable TX rate limit.
>> + * @param rate
>> + *    Max rate(Kb/sec) of the Ethernet device.
>> + *    0 - Disable TX rate limit.
>> + * @return
>> + *    0 - if successful.
>> + *    <0 - if failed, with proper error code.
>> + */
>> +__rte_experimental
>> +int
>> +rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
>> +				 uint32_t rate);
>> +
>>   #endif /* _PMD_DPAA_H_ */
>> --
>> 2.25.1
> We already have a generic API for per-queue TX rate limit: rte_eth_set_queue_rate_limit().
>
> Let's have a generic API for per-port TX rate limit, instead of a device-specific API.
>
> The per-queue API doesn't support burst size, but the per-port API could.
> It could be noted in the API description that if a port doesn't support burst capacity, the "burst" parameter will be ignored.

Yes, that is good idea. i will remove this patch from this series and 
submit it separately with per-port rate limit API introduction in ethdev.


>
