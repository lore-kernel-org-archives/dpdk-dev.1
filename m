Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63163C282EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 02:56:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7050C40265;
	Wed, 12 Mar 2025 03:56:06 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
 by mails.dpdk.org (Postfix) with ESMTP id 0632740264
 for <dev@dpdk.org>; Wed, 12 Mar 2025 03:56:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUHpGHprzKHWN7YGJQQKoJNEbUxjKky952FSPHvKbiUkXq/PLZmNFIJ36q7OsRSn2pDYv0FPNY93/3sj+OE7BoGpoKuRATSXVC+tYmS24hP0WzFU5eRTfFz+jgh9mOAv9p5xXRIOl8ajVY2V+ge6470Q2VrqJ68gUHy7SepyiwdD4CcaMYOm2e4qsmZEaZsDO18sWURRekOVNEWi0PjpZ0LTWQ8cn6XhzZNObxXSXxcaeYX4dmtfFyUbe13dwiTlcZ8qGr8H1rD2gtZJHvG++O1JHfughHbZAW0bB7S+M3mAED5uGuTaQyPZgTaroU5xE5P7WXSrwePlwc+/0x5BGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCdaYltGbsoobCZ5qmjIgNbWK1ZzKRy2zBK20cGofek=;
 b=RwtlAf8JWepWcO13LNhq0yasCsAX3DM5m1Ioi2fsRHCbPLOEpgqeZQPsKqH4aYLoq85pjfUUaRRtE6ByxXL78xuQuMy0P+2tjNGINqvuEV5rka+T+eTIkwfuoy14unCAVbxSyp4YSaC0v3aU2Na6o+59ka2KQ/q8IR2KNOLtJ6w1zYHlHLOPouVpp3X/zlsIeu4uJPkmR5yeNbUQySx1mVGdONhj40iBiMxSoKqm/ZaaPeTexAyTKsgVU5wOTHTnz+dOChxpbyMIfq/EcRX6ffQkE/dgEtGFy0DqHDYnQiQOtXzEwyXyOwhx84k5P8vYqPe//SveYlsYUtInPkvmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCdaYltGbsoobCZ5qmjIgNbWK1ZzKRy2zBK20cGofek=;
 b=VA3E4pP/eL7y3XGFveYka3wp0zzc4+e02DbXBc4gXZhky9rhsv1klfymPhkSfMswSsiLHH4+kMx8tDLqsc7ObPREeElV6BN3xc06eEmeHEPrJHvSLK/jc4tuLMlD4e/JGaKjpyH5sCpgXlPMynlLFkqYXUF6DUclrEcrKvEhCqcpFOCWT2wC2W3npUvnQyK5c100RJX3HYZf7/KMqrEYUEBc0VBksske1brpy/4CIPrVPz4e7b2OtFL/lPORSwFaN40eEYQDpxs2hpTYRvX01eDflOOOxc467PMDrjD4ApvAXcu+NphqvUqzB6ng+P7JK2YAfjG+kbMetbF//HhiBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by DU2PR07MB8077.eurprd07.prod.outlook.com (2603:10a6:10:2b6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:56:03 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:56:03 +0000
Content-Type: multipart/alternative;
 boundary="------------d03esiLCKTX0oqjybOJ3E0wC"
Message-ID: <47f4086f-b1eb-4d18-a433-e53593afceb4@nokia-sbell.com>
Date: Wed, 12 Mar 2025 10:55:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/mlx5: improve socket file path
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20241213091239.7934b8b4@hermes.local>
 <Z1xr5-FXBgEN4QM3@bricha3-mobl1.ger.corp.intel.com>
 <c941592f-f98d-42c7-9849-b48b6b8d8f5e@nokia-sbell.com>
Content-Language: en-US
In-Reply-To: <c941592f-f98d-42c7-9849-b48b6b8d8f5e@nokia-sbell.com>
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|DU2PR07MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef0667d-5eac-4009-228c-08dd61116cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGEwaHlDejFNbXpkS2V4Y3R1MEJJTUNYcSttSjRsZUNQSDlBenUxZ1V6eDlQ?=
 =?utf-8?B?UUx3aFljTUJjL2I5MXZCL0JPLy9acVZsL2ZyOVFqdmpaSlpxNS9IZ2FxN1k2?=
 =?utf-8?B?V250bjRwZldhWlJWbitYV2FuUmVmdjk2a3FBMXV4d0FHL2h2M0R1NUJXZ1Fy?=
 =?utf-8?B?NElyVTVIeE0vbTUrT2lXTU5ZblJPTGVaQVBhUHdJQit1SWZtTEhsTDE5bGVw?=
 =?utf-8?B?ZURpSlU1UXEzaDhJWmNpRHNBL0NpK25JOG12c1VIUitkeGdJY0RyWSs4Tkw4?=
 =?utf-8?B?RTBxbnZmb3BYZmp1STlnVkxWeTdoWHpIU0FLdVNsbjFyQmtZY0lOSkpMeDBq?=
 =?utf-8?B?VFhBWEdDdk9KNTc4OUxPc1J1SHRnNVJpMzZpVHhYY2FIbFR5di9LdnduU052?=
 =?utf-8?B?UXBhcWoxY3RvNTVSVmpwL1htUUU1eGVURnFFWnU0S05OdWZiRmdvYU9HcWJh?=
 =?utf-8?B?WS9lUUpYQjRJb3BxWE9zQStNMXNWbDM0U1ptenlHWk5ETkpkdzV1QXA1bnNk?=
 =?utf-8?B?b0pLclUwcjROYUhPQkpGMlJLNUZmSlhvbmVvM1RDTkVIS3dYczJsck1FQ0px?=
 =?utf-8?B?T1NDZ0duamZCRHk3SWxPTlBYUXkyLzdKNDNkcHhQeUNqY2o3ZjVCUjg3SzA4?=
 =?utf-8?B?OElleHJFWFVKdzhlcnhJOTdkNkM4YjJXeUt1dVh4VVNDWnY0NzNidjlxb3Rm?=
 =?utf-8?B?OFZJcnI3cEgzb2d1SCs0YVpUdE1ycGVueFJCemtlVkZuRVlpOHhXbVlPZ203?=
 =?utf-8?B?VzdxS1JRVGdqNUVUU0hBTGowYXF3ZHl1Q0VGandhcTVnS2hIWVhwYjNjcS9u?=
 =?utf-8?B?SkdMdXF0K3NWNHE1TmVMYzFyeFdBRDNvTnFNQ1B2eklUaFhnZzI1MFk1M3ZC?=
 =?utf-8?B?WTJHVXBQd0FIdDVsaEoxL0lBVFptckZqaXFCeHJ6UzhkV2ZnTjU5bTI3dWs4?=
 =?utf-8?B?aHhZNDJIVmZTb1NCOWxlUEZLOVJJSHZsbXJ5OWltK3c5a0ZFa0tWZnBlbTN3?=
 =?utf-8?B?WW4zQkF4cFFkdXZUa3Y0VlpnVnpmN09MVTlBUWY5Rmd3ZkJTN0FWY1YzQTRM?=
 =?utf-8?B?YkRnWnFnRmJPNEVrR2U3L1hJc295NWZ0S0x2L3kxRW5la0grMGxrMUVmKy8x?=
 =?utf-8?B?VVhkK09Ma0JSYit3eTBIUVRiYjNSVVJRTlBkK3h4SFZKaTRQUlU4WDBoRUFz?=
 =?utf-8?B?TnBJblBUcVlaOFp0TVJ6VFV5V28rTmRoTjlYY1k4NDdDUUdjRGROTFhQNzVE?=
 =?utf-8?B?Y1VYYjBiMkZoZU5wckNtcVAxRzV2RVZPc3Q3Ky9pMDhPcmNVNkZLMXJwcnRP?=
 =?utf-8?B?bjl6dFJ4R01VMWRZSUsyN2RteUMrSXJNbE5TUlZReWtiYlBzRDM2elE0WkdH?=
 =?utf-8?B?M3dLNDdVazdsRmJxS1hMMkkxdVVUdEh0NzNEMWZHOGl5aHBiREdLLzdHcThv?=
 =?utf-8?B?MFBueFpxckhEc1hnc0hHNFVKaDV1R2xmTmRUaHVyUEdpZWkrQ3ZqT25PWkpw?=
 =?utf-8?B?YnRwUmJSOHNxb0N3ZS9Na0UvUjRXK1JhaVJOS09ZaCtjTmZSZHg5dVVGZVBk?=
 =?utf-8?B?aXlvTHhhRHpUQW5CcUM4N2FVS05obzNpK0NuY1MxWWlXdEdOTDN0R2EwMFB2?=
 =?utf-8?B?aitueXpZSlI5WlhldU4vUHEvVmdoUXNlZjJheHo4NzB6N1R5WmZJcytlYW1Y?=
 =?utf-8?B?QVhJSnRibGJQODNpSkcwT1YvenFKOExSdjdMSDU1LzNqdm1hOHMrN2tRSDRt?=
 =?utf-8?B?ZDJyS09kNlNPTTVac3VSOVlMT2lOelB3Z1BpOFRyQlYwTWZUdHZhQ2FXbnd2?=
 =?utf-8?B?Y3NuRXd6TnMvdG5OTjMrTGoxWkZrVnFjUWViQlJiNjZzM09ubHlLQVZDMTc4?=
 =?utf-8?Q?yv3R7LaQ/RzOD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxpR1NvTXlRN1NlNkNaWGlXaDdoR2lHcEdiVjg4blJBQjkxM2grT3haZGZs?=
 =?utf-8?B?TUFEVkJuUDE4NVZRbHpoSWsyYkhsbjBrdnpqMzdCOUMvTW5TS2tvY1dIWmlz?=
 =?utf-8?B?aklGQTNvNGpmbklZT2VMbS9NaXVkeXpOTjNvbG9Sb0xUQkN3czVFT0M5bHV1?=
 =?utf-8?B?YjY5NXNLam1Vb2ZxNmw1Uzc5cmx5NEkvMG9HMTJpWGtaeGtlM003RFVWQ2lu?=
 =?utf-8?B?MXRKejJyTnN6bzk1dE1RamJzSGJ6Ulc5SUEwNGRYU3MwN1ZzemRZL0hRMUIr?=
 =?utf-8?B?WDNBU2JiL2tMWFBqSEhtdjFYL0tsOFN1R1F5ZFEzajl1dHkyVVRDTk1NdlFr?=
 =?utf-8?B?UkpGNU1GL3pkQXBaT3lVclJQc1p5SFJHanRuWlFVS2NiQXFEK0RxR0F2c0Yz?=
 =?utf-8?B?dFRGSFdHWGVqOGlFU2FtRXU2dUMzKzl3Q1VKcThqRDB0T3BJVDhjWkZKT3VP?=
 =?utf-8?B?b3krVTA5ejFtbEhML2lSRjlzM3Qxc2NaUk42a3RWMGJHV0xFVnZrS1M2V2lK?=
 =?utf-8?B?M2MyQlNWb1ovNWdjZUlxdCs2VWdTTzZmL04rVldERE5vOW9Kalk2WUhHYkJU?=
 =?utf-8?B?T2pCbVk0cDVBdERWcTZ6YjJkbzNiVEhLd0VUVFBpUU5Bb3EwcGdyRE53R0xy?=
 =?utf-8?B?SERVTHQreE1KQ25XRUhZRGhyOVUyNUpobWxialBSUXhBbGZFQzZDeTlhdVU3?=
 =?utf-8?B?SWFsVEwzL2xPTlJJckQ4YUdncFh3aWd3aUVJTVN2Q0pla3IwSi9CYzRCNmRB?=
 =?utf-8?B?ZnNIZWx0bWE3U1YyRjJmSmFEL2hOUUZKenFoWWlyWDlvaTRsU2xqbHVwMURJ?=
 =?utf-8?B?TXpTN25JM1Zjd3c4emp3Nm0xZUNWSUlxemxzTE00VXZiNm5wWDU5ZFJpeHZC?=
 =?utf-8?B?dmU3VlBRU0RhMC9TYTYvZFMwNklTNXRLNWFqeWRKbGxJNStDeWptYTFDdlJx?=
 =?utf-8?B?MGNjSjdkeU9KdWJEUUpOTFdFTWg5TlBrcTNSaWFybUNaZFJkMkpMcktjMW1o?=
 =?utf-8?B?ejZOR0UzWklmTWNUbVhMS0NrMWt1MlBhSnI5bXYyTDA4QktvdFV4SW5VRldm?=
 =?utf-8?B?ZFVDRENpdHFIazJscjZRZ1ZvMzVsdGgyeHhodTNIenQrRU1QanNQckJvSEZs?=
 =?utf-8?B?UVIzQkJnWlY3RmpVVlBEY2lmZ3FTRWVURXBBY3BrUjU3TkVkTnBxTlYyTGww?=
 =?utf-8?B?UnZlWkhOUDUwWkQ0bnVNS2QramdNQUJKcDRBSXNZVkpsUHY3MUV5L2VUMHRy?=
 =?utf-8?B?eWYxUmZkYTFtTENoenRMckRvQXQ2UVcrb2ltMitvelBaYzhLOERVQkdKS2o2?=
 =?utf-8?B?UzliMUQydkp0Y0dkZjh3V3RvMHl4Y0szRTROM0RYQTNjK0drWkZacE5TMGxR?=
 =?utf-8?B?Z0dIWm80Z2wyeHlHRUtVN2ExWHVQem1PNWpUTDlOL0JhYnNWcFlCbWp6SzJS?=
 =?utf-8?B?MnFpZm9NbTFjSHI2U092ODBGVThVRW1hcWpBdDFHMHJZYzZBRzNpNHJHRkFx?=
 =?utf-8?B?TUsyd3R6Yk9tQlVXRy9PTER0RytWdm5YUWR2NWUxRVN1cWphakR6K0cyMGdi?=
 =?utf-8?B?STRMb0Y4NDlZNEVaZkZCU1UzNG9NbklpUlpLV2cvcFJrRmZRTmp1Q056TzJv?=
 =?utf-8?B?akJLYzI3OEpPd216YmdhZTEyM2tGczZzRmFYZEo5MUdaelEydFRVTzE0blI3?=
 =?utf-8?B?VXYvMkpOVUFZVE1wVEllZzBuTkw2THhpcnlKY1JzS2JWUWZ0Zk1aTGF4VVc2?=
 =?utf-8?B?REsybGZqamttYjVmZUdRblFMMGJocEtnazFZeUxxaWkyMC8vOWpJNnN5Qnpt?=
 =?utf-8?B?bmVsdnFRTHgzdHdMckpKMWFHOE5vVGt6cGV2VmJJeldUMklXZnljRTNFUnhm?=
 =?utf-8?B?TTJBKzZJTmFvVTRKT0VlWGdRQThzT01FN1prR2RIeTU2TC9NckpxQXJUTW5k?=
 =?utf-8?B?WFVBWmh4czlScFpia0Zkb3N6Tml0UFlyd3RZaitJK0RoUlc3ejZ0VHJqSWdF?=
 =?utf-8?B?cjlpQkRDMU1hVUdwNUNSMUZHSFc2dXBzVWJZZ3Y5VGQ4eFZuTzFDSVF2VDdQ?=
 =?utf-8?B?YzVWY3l0WmdVK3F1SUIrNDBmall3N1hnWkhORndpejdnVmZqSXBYanh4QXFF?=
 =?utf-8?B?ZWl0MmZjVHhnL3UxYnhVY2ZaTXVLbUVDZFU5YThlci9BbEdIaW9WZDI5cEtI?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef0667d-5eac-4009-228c-08dd61116cf9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:56:02.9838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJ3tpTxnzEcx/yxjZ2lYvZGJBeoggk3B5ZLdBsm3DGBt0ZGlPxfHcZTbVwcjtn4qx1WUAMV6Cyx+X46fheiaKDd43Ts0L7go79gZT3aYm8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8077
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

--------------d03esiLCKTX0oqjybOJ3E0wC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025/1/3 10:51, Ming 1. Yang (NSB) wrote:
>
>
> On 2024/12/14 01:16, Bruce Richardson wrote:
>> On Fri, Dec 13, 2024 at 09:12:39AM -0800, Stephen Hemminger wrote:
>>> On Fri, 13 Dec 2024 17:24:42 +0800
>>> Yang Ming<ming.1.yang@nokia-sbell.com>  wrote:
>>>
>>>> 1. /var/tmp is hard code which is not a good style
>>>> 2. /var/tmp may be not allowed to be written via container's
>>>> read only mode.
>>>>
>>>> Signed-off-by: Yang Ming<ming.1.yang@nokia-sbell.com>
>>> Since this is a unix domain socket, why not use abstract socket
>>> that doesn't have to be associated with filesystem?
>> In general, I think we should avoid abstract sockets in DPDK. Primary
>> reason is that they are linux-specific. Last time I checked other unixes,
>> like BSD, don't support them. A secondary concern is that having a
>> filesystem path allows permission checks, so for e.g. telemetry sockets,
>> only users with appropriate permissions can connect. With an abstract socket
>> we'd have to open up the area of user authentication.
>>
>> /Bruce
>>
> Hi Stephen & Bruce,
>
> I'm not sure whether abstract socket is a good idea. Maybe it can be improved further or step by step. But we don't need to discuss it for this commit.
> We do this improvement because "/var/tmp" and "/var/log" can't be write in Readonly mode of container except that we add /var/ specfic for DPDK application in container's setting. But nearly all DPDK modules have already used common runtime path returned from `rte_eal_get_runtime_dir()`. Why not we apply this common path for Mellanox NIC?
>
>
>
Hi Stephen,

I'm not entirely sure whether using an abstract socket is the best 
approach. It might be possible to improve it further or incrementally. 
However, we don't need to discuss this for the current commit.
We made this improvement because the directories "/var/tmp" and 
"/var/log" cannot be written to in a container with read-only mode, 
unless we specifically configure the /var/ directory for the DPDK 
application in the container's settings. Nearly all DPDK modules already 
use the common runtime path returned by rte_eal_get_runtime_dir(). 
Therefore, it makes sense to apply this common path for the Mellanox NIC 
as well.
Actually, the objective of this patch series is to prevent the DPDK 
Mellanox driver from crashing when attempting to access the read-only 
directories "/var/" in a container.

Brs,
Yang Ming
--------------d03esiLCKTX0oqjybOJ3E0wC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025/1/3 10:51, Ming 1. Yang (NSB)
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c941592f-f98d-42c7-9849-b48b6b8d8f5e@nokia-sbell.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2024/12/14 01:16, Bruce Richardson
        wrote:<span style="white-space: pre-wrap">
</span></div>
      <blockquote type="cite" cite="mid:Z1xr5-FXBgEN4QM3@bricha3-mobl1.ger.corp.intel.com">
        <pre class="moz-quote-pre" wrap="">On Fri, Dec 13, 2024 at 09:12:39AM -0800, Stephen Hemminger wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Fri, 13 Dec 2024 17:24:42 +0800
Yang Ming <a class="moz-txt-link-rfc2396E" href="mailto:ming.1.yang@nokia-sbell.com" moz-do-not-send="true">&lt;ming.1.yang@nokia-sbell.com&gt;</a> wrote:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">1. /var/tmp is hard code which is not a good style
2. /var/tmp may be not allowed to be written via container's
read only mode.

Signed-off-by: Yang Ming <a class="moz-txt-link-rfc2396E" href="mailto:ming.1.yang@nokia-sbell.com" moz-do-not-send="true">&lt;ming.1.yang@nokia-sbell.com&gt;</a>
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Since this is a unix domain socket, why not use abstract socket
that doesn't have to be associated with filesystem?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">In general, I think we should avoid abstract sockets in DPDK. Primary
reason is that they are linux-specific. Last time I checked other unixes,
like BSD, don't support them. A secondary concern is that having a
filesystem path allows permission checks, so for e.g. telemetry sockets,
only users with appropriate permissions can connect. With an abstract socket
we'd have to open up the area of user authentication.

/Bruce

</pre>
      </blockquote>
      <p>Hi <span style="white-space: pre-wrap">Stephen &amp; Bruce,</span></p>
      <pre class="moz-quote-pre" wrap="">I'm not sure whether abstract socket is a good idea. Maybe it can be improved further or step by step. But we don't need to discuss it for this commit. 
We do this improvement because &quot;/var/tmp&quot; and &quot;/var/log&quot; can't be write in Readonly mode of container except that we add /var/ specfic for DPDK application in container's setting. But nearly all DPDK modules have already used common runtime path returned from `rte_eal_get_runtime_dir()`. Why not we apply this common path for Mellanox NIC?


</pre>
      <p><br>
      </p>
    </blockquote>
    Hi Stephen,<br>
    <br>
    I'm not entirely sure whether using an abstract socket is the best
    approach. It might be possible to improve it further or
    incrementally. However, we don't need to discuss this for the
    current commit.<br>
    We made this improvement because the directories &quot;/var/tmp&quot; and
    &quot;/var/log&quot; cannot be written to in a container with read-only mode,
    unless we specifically configure the /var/ directory for the DPDK
    application in the container's settings. Nearly all DPDK modules
    already use the common runtime path returned by
    rte_eal_get_runtime_dir(). Therefore, it makes sense to apply this
    common path for the Mellanox NIC as well.<br>
    Actually, the objective of this patch series is to prevent the DPDK
    Mellanox driver from crashing when attempting to access the
    read-only directories &quot;/var/&quot; in a container.<br>
    <br>
    Brs,<br>
    Yang Ming<br>
  </body>
</html>

--------------d03esiLCKTX0oqjybOJ3E0wC--
