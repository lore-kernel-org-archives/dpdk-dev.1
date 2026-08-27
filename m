Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64120C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 16:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8121B4042C;
	Thu, 27 Aug 2026 18:02:40 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
 by mails.dpdk.org (Postfix) with ESMTP id 216BF40150
 for <dev@dpdk.org>; Thu, 27 Aug 2026 18:02:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtYZmhymE8n8fA6Zrw4ugC0GyVlY6z3CvJGT0lGzx1AKU7reXuRCYz5c1bAFm8L+FyqdieJXsCE5Y+9KlXEZY7HIAHrbI5xl2u0VUis4AHIucdnIpG3XcEt93gcnoa53ehffr6zf6mJtujuwkolLxmokqx2WgeLVLoudpaKg1wX2G9Ypvt+KYeHzcb5iwzDZqfDSp4ra8sUPNlDCBnaAM9xIpXawtAVqekUI9Y7HhrSR44Jo3w53urWbUXQ6bc/KI7HnPy0haA+cinViaDljsz+5qDQHL7E4hmsk9pv5gB3MnY0L4Qi+fNqvQz5OFowdTvgpcQAT6k7NFkd/kBNJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMynzZE8iSaIQb8+gb9bnVnhZ84+mDRgzNWZDCbzMMw=;
 b=LMbPmWO5GnIpgqAImwbNMy2vlR2TDPYvMMYp94IIZH/pdroYgFuX0jAXJVCN9ZdkFOt5RR/Nzpm/RAkKE4pdr36e2cxtaH6/fomiO9Zo31ysV6OzcGGkzsBU0mzoTa3h9yH9tmp6BTCwJ0FFQ3QWU5v74/VetwTsb7lLj+aLfMpyLNNhxVDpzJF78xAPjFWNpuUSRgYosKVZVCWYX9lPwNTR+nd/ez8nKHP/PEF7YbhqiaFjZJF/LuRwbKBG0YJ3leoKN8BzPldKU1TmqoVFGWJli8sZirRSMV32VD0ctoKxE4cw6IcLnhECeGlRafK/Dd42D11ZjSC4GY2wO6QebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMynzZE8iSaIQb8+gb9bnVnhZ84+mDRgzNWZDCbzMMw=;
 b=mgbZ4mUrznibQTe6uRBsggKXdFBQj248OYkL4DV3vpG86rdm0xoG+W3XeiO8h1ZzZG+Jl2ZbkYDQ2HYheRknl+mC/DKEjJUcjvatxVcsyq0nQGzvi0eDs+j9i3q+bFwyC89Br1MSUlBqK7UEo5K4wPoais/XnzToARieN14JlM3bPwE5V5osbCY/KoLlg28KHWuXztHkcUL61+eKMH9FplNXrc/v6ZGBIC7gvfPTeYm7zLdEdauPvqDRsztV2oD0JV33gRPOWrqEqBlmhzbLRYsVeSAKM80uRxTLGfqj6P0BqgRnCYiD4/3/4fuIQBT5Fv3JqUqZYj/Ac5y9HLM/2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS8PR04MB8947.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 16:02:37 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 16:02:37 +0000
Message-ID: <0a6a1dff-1bee-49aa-bee3-946e13d80daf@oss.nxp.com>
Date: Thu, 27 Aug 2026 21:32:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus/dpaa: defer bus initialization to probe
To: David Marchand <david.marchand@redhat.com>,
 Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: stephen@networkplumber.org, hemant.agrawal@nxp.com, dev@dpdk.org
References: <20260827072854.1015059-1-prashant.gupta_3@nxp.com>
 <CAJFAV8yZBb7mQb+cEyuq_XnbQTaFxntTXz0sUm3NCMYsT0eDDg@mail.gmail.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <CAJFAV8yZBb7mQb+cEyuq_XnbQTaFxntTXz0sUm3NCMYsT0eDDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0199.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::12) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 766e26e8-8582-4eb8-c30e-08df04549d33
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cw/xLCDLyC93/uM7qr6dkiRzFMPkLrEWWk1EKKNVaIV4zlqX8BdoPtrLFCCa+XEMNOiWcefdGVGyB0cEyfTh3qN1ly9x3e9Dovo5KhaushrYemJ4gPbiY9I+RVo7DfdvUGFXTpmhX4V8MN1GdIge7o5IULQy3nBSfr6gDH1BRWeizwqwVLuiSGRQofH4eyb5wc/54NFik5YxgVpze3nu8vz7aHVp7bj0TZH8UrBjmFocqF9WRT5oYkedT6+oIV3MOSTd98UIdJ1s802u1rd3wXKSj1IlEC4jDNFW5jqPj2rLyFbGoxJRe4/icUNHqqPs8aj60GCVjEsC4UM3GKjWUpWHBjwrLsvnxq4/9yF/f4sZLJpvmHIGBqScyYnL0Efi30qAcOdWa+9UVnT8ZGXAxzB1Y77b0Pa4BKsXA1shNGfXdIl4T4zO4JVtXG7SURzw58820AKrcEzC+hX4jzVjQa8SIOEzQVej+wOWhU6iGwQGxJlLnYpQg8aXzgq/+F7s+e8ktEWkKHsVt5nu1Mqt7LCqZmYvTTsgBC9UsVfh0DSJ6PJXXitFmi8/ZnPFHNpdjbRkitCgJMYsUSySmRxC/hGT9QKN33KrZuk24Q4IcIDDsf5yCp+lr1D7+1DtcdJjGhbs+HlypP35EM9Rhr0+77Z1mmI0RfY33E3aV20JElk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2g0NE91SEM5SkNXUW1GcGF0YThJeXFqSitLN0RvYWJENXJLaHpzazcraVhB?=
 =?utf-8?B?aEZvUTZvaW80cDV4TVVrdTFXT241b2MzaVhaV0lja2xhVEdhY0FwanRwVmpl?=
 =?utf-8?B?NzNabmVWcHNURG9Mc0ozMTZaeWtpNnhLdVY3MEJiWEdBVmRCZTNvdlBFRkx6?=
 =?utf-8?B?YWlWRkhDZ0FxdDJoaU10UWhxQ2NOZUtkWFgyVDJ2aWhEaExyUGtwMkhCNEg5?=
 =?utf-8?B?U1htdU5FUlJRcXI3RE0zTW03a1NNZnFaZlZsMGczVm94TURSY0ZNMUY2Um5T?=
 =?utf-8?B?djNqVDF1TFBoS3pVeEFJczV4WTZ3SGJQYVYrdDNuZlpRckFaQlRZUzk1N0x0?=
 =?utf-8?B?QUtmSnFUUGY5N0VtZTdGZnlEaktxWmdDVWdrc0xSNjFMSzJRdXNpdEF4SWtq?=
 =?utf-8?B?N0phWHZxQnFQRTA2d1dwcDhwZlFGOURUOWlqRFRKbGlPUkFleW5kM25EUGNh?=
 =?utf-8?B?bEZkMVJTcm9vVzNsYW4yQWljNHNnc01EY1YzNXlpMWozYWFMTFNzWjExVzhR?=
 =?utf-8?B?bm9xcFdSZzVCeXpyTGpxcjhOVitVVGl1NTRmQk9tY0d6d1VVb2RRc1lubUM1?=
 =?utf-8?B?WWNKNzJOc3RSTHFBYnhuQitoRVBmd0twOEh4T2VMTFlUcXgxbkFBRzdwTE5z?=
 =?utf-8?B?M1pDSVExTWw3c1YvdmdhT1JsMmtqbnlHdDVyb1Rydi8raVRIZlJyb2pLNlBT?=
 =?utf-8?B?SGhRQUh6NGRWeGNVWlN3WFlWbENEQmFyaEg3WU0wa09ueVQ3WUxEYVZzSHpL?=
 =?utf-8?B?MlpUV09rWFpVY0daWGlvaVNpcTU0R05zamp1WjdxQTF3cGNNZHo4RGdjRWg0?=
 =?utf-8?B?WGMxZnFqVDlRdmFpc3NtaUJMMVIyQWZNVGNmUmZBam1nQ1EwazVqSktiZkNi?=
 =?utf-8?B?M01MWVEyWFRPK2pPVzBqbVBPR3hwOTFvWWpRNnRsTExBb25jMEptSXlFejNr?=
 =?utf-8?B?NUUrQWZPN3ZZMklOeUxtbkc0T3BVem8xdG11ZENmRGFsOWl0Tkt4SGhsNE1V?=
 =?utf-8?B?N3BIbmxFNWZYVXFrL1NHUUhUcDlrZjNZVUdEOG1YTFBraCttOGlJbjVNOGlk?=
 =?utf-8?B?SVJWZktTcnNOYVQzM2w4WVV0aGN2d2VWcGE5N25GZWYrcGlNcWRlcmFHVjlj?=
 =?utf-8?B?REhKUTdmN0ltdDdhTEpaekl3YUJZVHdEWDlLbDN0VnRBUFZFS05YTk5mcGVQ?=
 =?utf-8?B?WlI4NFpxL1N6S3Z3S0MwODQ3ZUxPN2F5amhWSE5SSnhwM0VuMm9sbGlFKzRH?=
 =?utf-8?B?OHIvamNuZzRPVHVxN0ZXVU00cmJRNFhOTUdaUDhpZzFITElSVzVaa1lNanhM?=
 =?utf-8?B?cUJXak1OclVSMVFXMG8zSENMN2U3bFlwbmRCU28wdm5LZVA0TXhjT1V0cjFw?=
 =?utf-8?B?WjhUcW1NZmtneFJydW5CSmR3d2hzcHVRazIrTFNlaC81NzFsaHdyQ0k1bmpK?=
 =?utf-8?B?L082SmR1VFA1aUd5cE1tVjg0NW84T0ZuN0lnYXBud3d2TUc0d0s0VGEwQnZC?=
 =?utf-8?B?cDBNM0wxSEgyL0E1RzdxSnc0Z0pHV1BjS2dwbnVGNnJXdGJzOEFncDY1ZHRv?=
 =?utf-8?B?ZnI2a2dHenZvc1pqMVp2N01Uc29Makdya1EwcFJjMnNReTNzNllJTjVuN085?=
 =?utf-8?B?S2ZoY1V5Z3RmQldLL0hVUjFVV042bUJ5RWlkVkptZk54R3VvN0VTNDJqWUw5?=
 =?utf-8?B?WXdDVWhkOGk3NUFUam4ra2RlVUVWQklsNm54dHpXSG1FUVM5bDVwTnFvaWFW?=
 =?utf-8?B?UHJiUE9ZVWR3NkFkR0Yxelk3NDlOOFF1RmlidFRISXBxZWVmUXlmYWdIc3BY?=
 =?utf-8?B?b1BTMWVFL1h4WklkZjE5SUl2OHNrYkF5S1pMVVJuSSt4ZStBS3VwRHd1M1A1?=
 =?utf-8?B?aG1uRFZnU045Y1VqYlZnSWJ5aTdxblFPb0FqVm5Td1p4L1hOcmxKMVZxa2h3?=
 =?utf-8?B?YU9MdnVaL0dteCtvVjFEcTg4Vi9ReDVxUGdPWDBwZzJQV0JSUWlaU1diVGVW?=
 =?utf-8?B?Rm9QcEJIdFUyd3U0bFJxbUFQQ3g0Z3M5WFJyR2ZjUE1WbzVUaEI1dTVJZnRi?=
 =?utf-8?B?ZEFlaXpaTi9pM3FwK2hrN3RJNmxxY0ZsWXVSR0NlRkxzbzJ1K0s1d3JhU2I4?=
 =?utf-8?B?VzFYbnIzVGFVV1JSSTVPb01KRFppbTFURzJCZnlZSDdDODNHNjlxanUvc29x?=
 =?utf-8?B?UWFKM1FZTllEYm85ZFNOTzE3Z0JZUmp3dGEyWUdENmgyUmx2YzNCcllDem1S?=
 =?utf-8?B?a1AxT1hkdTZOc1VTMTF6SUlnMEV2TXI4UnB3NUx0WDN3ZDFFZVFEQnZpb0xk?=
 =?utf-8?B?S2lxejhzSEIyczREQmF2ZTRVV01iQXRiNTVST2tocnUyOXp0aFJ6ZTR2YVhM?=
 =?utf-8?Q?cA3mewBzdRtavCdk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766e26e8-8582-4eb8-c30e-08df04549d33
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 16:02:37.3932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZIr50V1RIznDtBh/ny539Qr+UpGdO6xxYID1+kuR3FSgF6UlQEctnas1HQGClZnDlsOjMdW1SUJ5b8w/qmlgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947
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


On 27-08-2026 14:24, David Marchand wrote:
> Hello,
>
> On Thu, 27 Aug 2026 at 09:37, Prashant Gupta <prashant.gupta_3@nxp.com> wrote:
>> In the DPAA bus initialization: it builds the
>> device list, loads the QMAN/BMAN drivers, registers the platform mbuf
>> pool ops and populates the PA to VA translation table. All of it needs
>> the DPDK heap or a memzone for multi process scenarios.
>>
>> get_iommu_class() for this bus only checks two sysfs paths, so the
>> initialization is not needed in scan to report the IOVA mode. Move it
>> back to probe.
>>
>> Fixes: cdefd2e980bd ("drivers/bus: initialize NXP bus specifics in scan")
>>
>> Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
> While the change looks correct, I don't understand what is being fixed.
> Could you elaborate on the issue?
>
In my brief discussion about this issue, I was told that some of the 
these QMAN/BMAN related initialization should be done using 
shared/Hugepage memory for multi-process sharing;

Hugepages are not available during scan, they become available later.

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

>
