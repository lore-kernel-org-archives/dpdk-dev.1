Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B21C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 05:40:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D35FC402B6;
	Thu, 19 Jun 2025 07:40:26 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
 by mails.dpdk.org (Postfix) with ESMTP id 891F84025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 07:40:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIlr2rBpH8yMyRR7eCXYHuIPw/dnTR+0aK1MfKClFBx4PxXbQwogtZTI4ZDFHfk5jGdFKKMXvtYGBqTW+koleJPm74UvY485+M3b8iLQNkJzmj8vGalBmfpynlr0+nzifBJ/WCBxXsMc/HdMvLQ3IrBtq1V8WodEu7Sk9fLDYEpP6x3uYAGUmSdG8bbrMn9mlBs4dkVKA6sya0Y48goakXWpuwNGSM8y9KHG3+YFRjSaouSfbhjhHBQktOmJ5TKm03+Taxx8/2hesU5EdCH0iosoxZkPdK7y/PK1C6oEDtrkWxMdrwyXUHgwq3OJGOo++eT4steJgvnfTOT97ACRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVjNWFysVgTcTFOShyIsaBwWc6mh/fqE5AFAcOZxDug=;
 b=Jn3E+85tv9ztb/+C0boW2eM4YLg3pEtciU8I7f2S/SdiTZdNes4VrqWnTL1wTKFm0OncS7WNGJz5dryqqvM0UE5+9zOVld4ieyR19hyRyb1hH/kWfUqDzVQ7fSRWb+sptWQZFpWGENAQNbfqFIwhz7/nrigVqmhn1kqsXdBzM5AZOai5FQiPw79g6738PrpADXhFaTdFQCmhQk1b5NnhngjmnBDwaog96Fa3KxVI5v3gGgcSqXLKu3tVf9hDuEfGFNLbONFYU1xXRa/7LI9n2iMt93gyZ5yXbQ9fekn5bVN13AYYyhEYEQOzQOCCyl9rGcRiHYtkD2zyzb/yORTm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVjNWFysVgTcTFOShyIsaBwWc6mh/fqE5AFAcOZxDug=;
 b=e3eDf4fyjGddqxFTdtNbJxP2E1riRX/UpwWuFMMaed6m7/L5aoWnYihh6YK1wPN9Q6Vx4T2d8UU+Qn69FrXfUA5TpRmY115Gn6jPxb+dOEiBxh5ETa0Hpnh0W/PnXiY9jcRz7eEJPmhq6FDsRA+ElnCM467pFGCWQD1in/cOWb7rAIFLnIO5jEO2ucHMMVJRrdkjZDoezEAIVhudc90qGL7wlo3cyfRNM6wqgKPaWrU6ViWGVMScDbY32nTGzBrEwvfZWwcAkpaopoTB11KSsJxpMLDEFsXMMAqIDYAXcfgM/fcoHLld6Ti3EitfgrxHdn92p0gxFPHvUKfFQNRc/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 05:40:23 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%5]) with mapi id 15.20.8835.018; Thu, 19 Jun 2025
 05:40:23 +0000
Message-ID: <d1257137-ca00-4744-9617-e53a6e2b3a26@oss.nxp.com>
Date: Thu, 19 Jun 2025 11:10:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] NXP DPAA2 driver enhancements and fixes
To: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org
Cc: hemant.agrawal@nxp.com
References: <20250611105149.655144-1-g.singh@nxp.com>
 <20250613021125.790614-1-g.singh@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250613021125.790614-1-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::9) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AS8PR04MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be6e40b-2aca-4bf1-ca3e-08ddaef3c91f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVMrTzJEQ2xrWit2eTJVckpDQnU5R2RIL3NOZVIremNkamJzWStHWEJlMDc1?=
 =?utf-8?B?ZTZoUzNvRzRUbTk0TXdlQm5ITWFVdkMweVlyeEF5WDdpbU9sRVhwUWd4c0VQ?=
 =?utf-8?B?emQ4RjVXM3pzck0yTDYxS01IVHZmdzBSMDFTYS9CY0pxa1AyT2pyeEcwbC9Q?=
 =?utf-8?B?ZnloK2t1NWRNWFFhNWxnekc0cnlZRHFGaXdZZllDWW5heEtHeElDYWNvQ2Zz?=
 =?utf-8?B?Z09GQlh2ZFJsTFNaQlc4anhsUFRWU3k2LzFLY05uVThVa1ZJM2R2dzdQRTZK?=
 =?utf-8?B?UlM4ZDlzalRvUkhJSEZ0eTBEMUorZFR6UzVKd3hlb2FXaVpmZWFKTW1HdThX?=
 =?utf-8?B?eS9TaThwOEZIcFJHUWtndWludm1KWGo1UWFwb1Yya1NBcDBtd2d4MUFMRTc4?=
 =?utf-8?B?N2NnQXowQ2Y0U2dFendjMkxTYmRvRWtTZGYvQ3hOdmthc1UvTUhOZWo5cHU3?=
 =?utf-8?B?QnVKUVBzUFZuY1Z2cXZwbnBVSFFTRjdtdVRiT3VpZlkzU25DSlRkUm4xekh2?=
 =?utf-8?B?QXUrQmd6YndoVjFFM0JBSVNPTldXdHF3bVdpWDU5SHZoRVZEei9rRlUxdlJU?=
 =?utf-8?B?cGtRZG1OYVlVQXZ2UlFCUzJjZlFCNDdWYkxYNW5JbjVOWUVuSDREYnN5K1dp?=
 =?utf-8?B?RG5GZnVHZmlyRk5TbTkzRzZIR3AxODVqMEpoRU5wYXdSYTdKb0R2ZVVUS1hM?=
 =?utf-8?B?Y1ZRN2liNkpUVTNXeGlRLzlIS1JzNmEzTk9IbExtdTZkUTFValN5VzdTeHQ0?=
 =?utf-8?B?aDJyL1F2K2VxVE1OUllNTlA4NUx5UGpZOUZDOVkxZjhMbmlNTXJBREw2VTIy?=
 =?utf-8?B?dERxRzduY3JvYlBLNFludjI4UHV1UjFGT1UyU0lIN3FTM2pLZzNEaitsTFdh?=
 =?utf-8?B?d09kaXdOa2lDdjB3aS9kZ0MxanJKbnE5MlJOdUpYWHpTNHIyYTRxcjd3RTlP?=
 =?utf-8?B?MDkybDk1dFdvdGdMbUxaSCtCZ0tvVUlrV2lQQzZMbTRBcXVoMGtlZnRsajVD?=
 =?utf-8?B?elBKWWQwWERQbnB0QkpVNnA3Q04xV0ttN1BaUHZHWFFZT3U1Ym56enB0eGlD?=
 =?utf-8?B?QU4zYk9peEVDbEtLVzBydXFyNWxlS00vM0Q4ZFVlVXVVamlKQkx5ZjJBK29X?=
 =?utf-8?B?SldweXRZeUdQUWl3VXBqeGNnblh3cERFemNHbUFpOGxndEV3TlFyak54bVly?=
 =?utf-8?B?LzdhaUN1UktEWUsycUh4V1RuTHo4YXN3ckw5QU1UdnFTRmxpTXFvZU8yNkhz?=
 =?utf-8?B?dWtuVEwrME92UE1BMmhCSTZBdnNVTW1LQXM3Ukl3aXZmSCtYUVp0RWV0RUtk?=
 =?utf-8?B?ZFR0MjNvSGZ4amZFVVdGREFkdnpEMkVybG8wUy9lelhxU1hwK2xZdXZabk14?=
 =?utf-8?B?Si91YnZMZ1NpYW8rNU1xZU40TXpuM3VMMjYvYzJkT3hJOGFqYjRGRGhRYTdL?=
 =?utf-8?B?RlpVanFkdjRrY2dsMVhlWWUzWCtoMlp6QWFzMEVGVzROTmtpdHBqL1ROZ28r?=
 =?utf-8?B?d1J1REo2a3VBbFp6MkYxYlk3Y291cjc2S0JNcjA5V0dLTkEzbk1SZzhZRU91?=
 =?utf-8?B?ODdlTml6MUVQS05NbkJkS3ZhVDJoVlE3VmYvK3V2UTQrZFJ2RmRORkdvS0dO?=
 =?utf-8?B?Q2hRTElJKzhOQ0NBSDJNeCtxSTRKMldYK256M1ZvRWZqUnlxZlNWSm1jNXpI?=
 =?utf-8?B?VDFRM3ZkVHBxMlNsTTF4cUtUanJxVGtWM3ZUR1FrK0dIdXdsWEhBbWc4NUYw?=
 =?utf-8?B?L0h0RjRyTCt0OTZPcC9hRlFsUWszNXBxQURqUVkwcEJrRmFMWEpEZS9PQXor?=
 =?utf-8?B?QnFrMlN6MVlkcmVrZGQwb3JtWTlmK0QvblJIOU54bXF3R0ZyeGZsYTExVEZu?=
 =?utf-8?B?b0VVMXU0ZmRTaGZYbnFZWDREditoWXQ5aVZRQStjL3g3OENTZHd5ZDVoa01K?=
 =?utf-8?Q?SkkWeUVLwWA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21KVWY2R0hLUUhqdndHWUp0UW9CMHJCSk1IcDNueW1mKzFaOWs0N3JCZUFq?=
 =?utf-8?B?c1YwQ3hWaEVHOWRVc1JDSGhNcy9tZllyTUplTmZFRmJoWmRSR25Za3gyTG9B?=
 =?utf-8?B?R29wOTVzUmpRNHFjYS9LVlgxNitZc1dXYmRpUEMreTg1SzE1YVA1eFJpdXZJ?=
 =?utf-8?B?S25pOXFGREVla0VLcVlpdUFGdEJUSmYwOU9TSGlocTJzRmZiZ2RNTHV6a0g2?=
 =?utf-8?B?UG95MWZDSm1wb0h0NzFaT1Z3MFQ4WmFENlNlclVrNXRxWmV1R3drOXZoRW9M?=
 =?utf-8?B?ZERwWEZ3M2JWUjRNVGFML1JsNktMSytKN3VWQkhXajZ2YWdGSCt0UmUxR3dM?=
 =?utf-8?B?b2ViNWo0ZXdsd0I1bFlmbGw1eUM1OEl4VTBxNHlHWkZFR0drNERSeU9jd0ww?=
 =?utf-8?B?Nk4ya0ZVMU5TbW1lWWNXbnlPcUFZd0N6NENvaElXbGlpZWN6d3U3a2o4Vlpq?=
 =?utf-8?B?QmF3RTFnbkpWQi9VYmI5aklVV1BUV1MwMXg4MEMrY2VBcVFxVWFGdWlveld2?=
 =?utf-8?B?QldJRzc1aDFJRmU3bEhycnB6L1loZGgybzhNLzJtOW1HZGNMcUozclNiNzR6?=
 =?utf-8?B?VzV6OVN1ZXlCNml0UlVLczR1VDBiRTlteHVpY1R1clBXSmIxaHZ1Rjk5ZmZL?=
 =?utf-8?B?UVJPWkU0VVcxSGRyb1U1RGNCUHZIb1Y0Slo4SCtwMU5mTUttVzBMWmhIZXhk?=
 =?utf-8?B?TnhwSEtmTGRkdWVRcFFRckRvZXVDcHZQNm5SbTRxRVUvYWFwQVhrUUxGTHBo?=
 =?utf-8?B?TVdON0NTRFN5TDlJM2RlY2JXWjBvWEJIeUJ3YUpnbUg1aWdMU1hLb3l6K3Fa?=
 =?utf-8?B?Vmo2VkNKc3dLR3FLenlJTnhZZ1RwaXRybEpHMUFVYXZOalJHbG1QTGpSa2ww?=
 =?utf-8?B?eDlSaTYrZU1RRUZHTVA5a29NK1ZETk1kTjdWdG9mWENhaDdTTnBhRE1ldDQy?=
 =?utf-8?B?NU5sWXR0TTlOa3BiRXliZDIvRHgzSWM4NlFlN1BpWGswZmdEQ1l1WDNaQnFp?=
 =?utf-8?B?SHN2K0dsOTAzMEh4YmJZbWN0Q0o3dmJiNUdBajZ1c3NSODl5L0pYeVNSS3hP?=
 =?utf-8?B?NlB1elBxQ3JHdDgxby9RVytxZkNmVWxqQTBSSEpvTHM1OFNIem1BNy9NeUdv?=
 =?utf-8?B?OVhkUnl3SnJMVGNUZGVXNWhuQWhNczdJYkVPT3JYbEh1WjErdE14blBQalcy?=
 =?utf-8?B?YVJWUG1FVnJrclk5NGpUamw1bFBMWWJ2OWFjMHhJZ2xSRzNzckgyVjFwcWZu?=
 =?utf-8?B?VUxzK0lyWXNmcEdZOSs2MGxjQWYyWHdPWFl4Y0x0dmo5MHgvYlhlQlAveFBF?=
 =?utf-8?B?SzFJbi9adDFZMGRPRllDeXVqcVVkN3VuKzFWWVBidDYrWnRBVi9QQ1dybnhF?=
 =?utf-8?B?emIzZVhzNUFKK0s3RXc0TjA3VmVxdDNTRWN6aEJFU3VkZjdTOHVQbGxiR1Q4?=
 =?utf-8?B?RGFMVTdSNmlZakdURU1hT3lOUFJoZ0txZGlOSmRWeC95YURsOGNXbWxURXBo?=
 =?utf-8?B?SmNDVlhxNmk2QXU2Q3BTcjU5UXBqYWhDQTFKSUwybCtqYUd0SjljNERJUjdV?=
 =?utf-8?B?RnUwN0pnTVJ1NkZzYXlMS1R4Z1I3NCs3cEdIeXRNRVhya1BCbG5BbWRpWVJG?=
 =?utf-8?B?d25PdVYvd3BOWkhXbmJlcmFNOS8rckw0UElIYk1KUDVKMVhYOWtYcFdkanZi?=
 =?utf-8?B?QklPSnJiVERkSlNhVVVlOHJNRkpNWnl2alBFdHR1QmorMUNOM0ZYMWRuVnhE?=
 =?utf-8?B?MmZUVS9KeldxM1o5bWFyK0FFUG03eGYybHg5amJRdUZlaXRhNXkyejVSVlZN?=
 =?utf-8?B?KzVIYk0vSnF6QTFzc2ZvN0NYMXBiMndrOEp5NFg5RE5GV0FObEQwUHEwaXJI?=
 =?utf-8?B?TTQxUkRCYUQ0cUYxT2dMVU5qck8vNWEvZGROR20wMllEUEVubkU4V3lxb1RE?=
 =?utf-8?B?NEQweTVVcGUzYWE1UTNHUXFUTTJSbjBlWTA4em0vMDdNeSttMVFjK2paN0hJ?=
 =?utf-8?B?U2tYSExFbFZ6OVJSemVYWUorR2xtaFBCWTFMNFUwR01halBkeldXK0UvTDVS?=
 =?utf-8?B?YWxkVWFROEN0T2g5OWxYM1h6bXB0aEF5S0RYa1ZhRzZzdWxWNUdmQTE5eE5v?=
 =?utf-8?Q?TJ2uD46hVhZGKktuoT9tuMxoM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be6e40b-2aca-4bf1-ca3e-08ddaef3c91f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:40:23.4978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt7wNwHTNJrxhsVtx2bTw2T6CtfyFfMHH6BTXs0yG5uTTFXTA/RpKKT1tSnF0WYL+wU+C6yeHtTIiHx2ieugVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8008
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


On 13-06-2025 07:41, Gagandeep Singh wrote:
> V1-logs:
> This patch series introduces enhancements and fixes to the
> NXP DPAA2 Ethernet driver.
> It includes support for
>   - software taildrop on ordered queues.
>   - setup speed capabilities.
>   - DPAA2 resource version.
>   - MAC level statistics.
>   - improve PA-VA conversion.
>   - add buffer pool depletion state configuration.
>   - fixes for shaper rate and buffer prepration.
>
> V2-Changes:
>   - Fix compilation issue on UB2404-32
>
> V3-Changes:
>   - Fix missing license information in fsl_dpmac.h
>
> V4-Changes:
>   - Rebased the series to main branch top.
>
> V5-Changes:
>   - Fix spelling error
>
> Apeksha Gupta (4):
>    net/dpaa2: add dpmac MC header file
>    net/dpaa2: support dpmac counters in stats
>    net/dpaa2: support dpmac Tx stats
>    net/dpaa2: support dpmac Tx stats in xstats
>
> Gagandeep Singh (2):
>    net/dpaa2: fix shaper rate
>    net/dpaa2: enable software taildrop for ordered queues
>
> Ioana Ciornei (2):
>    net/dpaa2: retrieve DPNI API version at init time
>    net/dpaa2: setup the speed cap based on the actual MAC
>
> Jun Yang (2):
>    net/dpaa2: fix issue of extract buffer preparation
>    mempool/dpaa2: use unified VA to IOVA conversion
>
> Vanshika Shukla (1):
>    bus/fslmc: add DPBP APIs for setting depletion thresholds
>
>   .mailmap                                  |   1 +
>   doc/guides/platform/dpaa2.rst             |   2 +-
>   drivers/bus/fslmc/mc/dpbp.c               |  78 +++-
>   drivers/bus/fslmc/mc/fsl_dpbp.h           |  41 +-
>   drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 248 ++++++----
>   drivers/mempool/dpaa2/dpaa2_hw_mempool.h  |   1 +
>   drivers/mempool/dpaa2/rte_dpaa2_mempool.h |  12 +
>   drivers/net/dpaa2/dpaa2_ethdev.c          | 276 +++++++++++-
>   drivers/net/dpaa2/dpaa2_ethdev.h          |  36 +-
>   drivers/net/dpaa2/dpaa2_rxtx.c            |  24 +-
>   drivers/net/dpaa2/dpaa2_tm.c              |  68 ++-
>   drivers/net/dpaa2/mc/dpni.c               |  50 +-
>   drivers/net/dpaa2/mc/fsl_dpmac.h          | 526 ++++++++++++++++++++++
>   drivers/net/dpaa2/mc/fsl_dpni.h           |   8 +-
>   drivers/net/dpaa2/mc/fsl_dpni_cmd.h       |  15 +-
>   15 files changed, 1238 insertions(+), 148 deletions(-)
>   create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h

Series-

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

