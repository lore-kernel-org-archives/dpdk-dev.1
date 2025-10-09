Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3404CCD187
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 09:49:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6A614064F;
	Thu,  9 Oct 2025 11:49:27 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
 by mails.dpdk.org (Postfix) with ESMTP id 0D44440277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 11:49:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIp1b5EACxFqfjiaLaktjWZfMZ9YHTG+UBC9EB0qkPYkzUTheV3vmaZp0a2SnVkVR4vw9GSXAA/b/LIio+6gyRSVCwa/CZ2xnescj6bxvSLOfhzUuDqygDP0MQ2rjsz/ms9hN1pwD90kXKsXAUZl9bKiVsp0PTJq5+GDFrOgb0V9iX528fHpJZWVE/TTGH809BM2LCe7u/8UHhtxTNdNT6a2cozst/XUMb92v3CXfozi46i9SagEzstndk4ZV0tNnRwLqrcrv9icCiWX5VTEIVQn0BICE4lzlO6B+G6o7JezEff5QZIgBAUVa7eQWdq14eCgETnW8hnmS5m0lff5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw8VnAhuWoWaNOcltGF+gtGvePOtgjrzu0+mNOpYttU=;
 b=qCskwJHRsX9hokZqE7f84JS92SE/1U/lzuYkH7hGfg+VRBwlBgmH/7Ef/LcnBqIP3TnUmhQycqlsU2Knc4plMmhEWT+mWdef82qXCoozfntzUKxPejCX+4IiTV4J/li8UpJBVnxzp4L3WQBFoJITZGovk3/2V+cTo6ogw78Y6A4dwl66z38Jczdo+ytCOGAyq0DU5ybrgLPMvoFTQr9wlUZY2ZeFpYBtfwjPun3Flo3nreI1VoS63YE+BNvVK+35LMYAfvkabSGytVvSi9MNYYT2vZ++9EB9ZU0xMwBlNz2EFX9SI2LCuEdNaHy0+9ToPPo0d6ymlwkHbH9RnQXSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw8VnAhuWoWaNOcltGF+gtGvePOtgjrzu0+mNOpYttU=;
 b=HDPbJ0kV4A2vRpnhU3sdrLTA/ENgCeV6/O+CGiSnHePj2cm5kc5LgrYYptAeAidtKsgZ85J+Ql1AEcT7rbKEZDNWWN+wS4jYJhTCexi3nRcHJFBb08X3nDPUqZu1+ilOGfcGnyG1lXItTY0UK2QAyVTjBcrLk7Ru6CfrzEZ36eanbyU5AeyyT1/UouzqT8t3EzpDRVZpVyFrNrQt2nuDQXIzdPtWaCeErHGP4l3Qr/sqfA2NJebkj8CutotIe6c6BG3rKpw+MpADgkWRxdTYr7WOOnpc1HiGf5UgsB2b7eUsyQc8MAw7rjq5PcmmKlSGfXZYdtrfOcpJ4eN7ensmaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7748.eurprd04.prod.outlook.com (2603:10a6:20b:243::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 09:49:24 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 09:49:24 +0000
Message-ID: <87aaf909-e17c-47c7-a83e-acf61d2fdb03@oss.nxp.com>
Date: Thu, 9 Oct 2025 15:19:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] net/dpaa: Fix coverity issue
To: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
 <20251008043519.2461707-1-g.singh@nxp.com>
 <20251008043519.2461707-6-g.singh@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251008043519.2461707-6-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fe6998-39c0-4b33-5744-08de071920dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2hEeVJXNzk0UjJpOFNMMVBDM2FPNjVCQ3o2Q05WWVA4Vk1SdDZ2THc2Wk5E?=
 =?utf-8?B?VDZQYnlUQTRvSVRWd1dyMCtmbTRDeGZGdVB2bjBUb1JCaWpRaVNlc3pQa0c3?=
 =?utf-8?B?Y0VXVDA4WkNTT05qdGlwVmtBYWNGRi84L2Y2WTVQZTIzVW9CMCtVQ2REZUZV?=
 =?utf-8?B?T3hPeU83ZzJBNDZITTA4N0xUMllMZjFML3VKNUtkdU5JQnpienZUUmE4Ui80?=
 =?utf-8?B?V3NTU3BFSkQ0TktkQklPbGdoZkpVYy9iSjFkVDhyc1pQNzhiaFU2YkhYSW0r?=
 =?utf-8?B?UzdicGtqWFlMeThuSFRwQjNRUHFUVmRUNlRreHNVT0pLY0hsME9BdDJLbXJE?=
 =?utf-8?B?TzdlejZPekRzUWVyWWJpYUhuZXdqKzQyV3BTdlZLYkFNazhWcnRjUncwVG1w?=
 =?utf-8?B?TitGZDNNNThCK1JRR0lqSkFJWGVBeGVxTzNKYUZKRzN2azJBckViSTU5bFNH?=
 =?utf-8?B?UU04U0taMTFoK2l1YURTK2hKdHBmTkpuaXppRDdpWW9ZK2pyTGtaTFRGSk5R?=
 =?utf-8?B?bGlIL3RaNWw1dyt4dUJFTktOTDNtTHI1SDIrZ3F4a2dFOFgvTXVNV29yQUpp?=
 =?utf-8?B?WUo3bFh3bi9OaWloM2dwWXRIWFVaL0NmWXJ2SWdUcnNZc1V4aXZrUHJadVU3?=
 =?utf-8?B?RWl6YjZaL1hVN1g2L0R5Y2ZkWkVPRStCTmk3OTYvMlYxbE1zWDRGdXlvUjY1?=
 =?utf-8?B?R29DbHp4TWRYOGN0enBTMmxCVmh4VjVZUmE5TVZ0SVRmRUdBR3pGMG5obFZI?=
 =?utf-8?B?ZXZsRzFyS0tkaGVFaFRJZDdsMlJMeUNhUzBSdEZRZFRDcHZhUkNEZXRyeHlr?=
 =?utf-8?B?NkducjltMENBWS81aVRCeS9JNEVaektEbTJDT21aeGJSMENkRFJMQWFpaU9X?=
 =?utf-8?B?S3N0dDMxVHlDTTZXenc4eVE0YmFNVHErNG92WnNyVkJZOWJ2S1IzSlZXQlJE?=
 =?utf-8?B?VkFFNFA1a2J4WGFoNlByQ1pCZmVkTEorME1MZFNCdlIzcmN0RlRKZ0J2d3Bp?=
 =?utf-8?B?bHVuT3I3eW5rQVNWek5MK0x5aDBYZnpieWZZLzBuU1NieEY5OVZKL080TjZo?=
 =?utf-8?B?N2FFbmdiQnFTbUxzNTlSeWs4SnFaVXlVeWllR1cxM3J5ZXptcTQ0NjlmaHFx?=
 =?utf-8?B?NG8yTG5va01KcW9ZM3BXNXM3U1ptanEzUi9WV0JLUjZqamlKMkxoamNFUXJk?=
 =?utf-8?B?VnVuQkVFQkhhK2d1U1NFRUtBS2s0dTNGdFRXNmF2ZTR3QnlzbmhRSElJRkhU?=
 =?utf-8?B?RTNtRVJaSHlZS2tyL20zK2cxU2Y0anBXVmxxZE12NnF3V2pPVFVOdGRPM2dW?=
 =?utf-8?B?TTZOakJzTVdIVzdtTnhJSERBTkl6cWZQSCtYWUVuTXY3L3RraUVZbHNoMXQv?=
 =?utf-8?B?dnlXYnRwQXVCQisybHp3VzZYVnNLckxjRExxRDhVOEM5bnNxZTR6K0lYUHRr?=
 =?utf-8?B?VCtYQk9tNmN5dnBCekxIeFNxdzg3YXhZcDNKZUhiVzhXdnRvU251c3F4U1hh?=
 =?utf-8?B?UjIrYTVrR2x0UWM4aWthWEkvWXIvZXVUMnFlTHZZYWs1SHNmemw2NDNUZFl0?=
 =?utf-8?B?ZnJKQlRJd0VWUGtoa21DVUdVd09iYTJZRHhEbjE1SVlBNk5NM3p1ckNVK0t6?=
 =?utf-8?B?aGdmSVBvMFlwbzE5VkczeDA5TjJpUkdGeTRxUVlPdnNmWExaVDBZNEhRVUhn?=
 =?utf-8?B?Vm5DWUV2anpVRGx0L1dhRUI5blZ0S0p6QjRzVHRjUkc1WHJtQnZVbzI4Y2lW?=
 =?utf-8?B?clcyRTNXelZBZ2MyNzB5eWxoUVprREhtVHhvcUVIam1XL21Lb0IvMm9ZT3pp?=
 =?utf-8?B?VWZCSUVneDBidi9FYlBXeE4xTjc1MGh0RU9oSXRkdHB0SUQ1ZTJVTVNaU1Bj?=
 =?utf-8?B?TCtyODNCOHBFdVNabWVUQmRNY1AxblJuV0c5YWlCbUpHQVUwaEFPbXQ5QWgv?=
 =?utf-8?Q?n1YDTAHXhxIvS8x76ujm+mi86yO6ass/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXFEdGhaZU1iUStISkkyMVlxQWU1NDFybDNzOE4zdFM1b25tT3hnYVA3OFRr?=
 =?utf-8?B?dEJyd0V0Y05JL3hSckNhWGREU2pRV2pEc2RpaUxEc2Z0UkpPc20rRnB0d1hT?=
 =?utf-8?B?QWUwSWt4dFZiaFo5d1BvQjhqSytkQ3g0bHplN2dDZ0FlRmtaU2RSRXgrTWJI?=
 =?utf-8?B?aWdpcjdXWnVrRlB1RjltZGt1dVU0VmpvNjViREZ3eDJlZjYwQUdSOElLOXUz?=
 =?utf-8?B?VVRTTlREY1Z3eUpxZDNVM0gwZnU3SGxYVCs4dFJENHIxOXZja05lcmxsNjBz?=
 =?utf-8?B?Q0d4WVYvM1dQWXlFbm1FYVVpbGdXejJMY29TUEQrNHlVcVRJdURCRkdQdmU5?=
 =?utf-8?B?MUtQMXFEQzY1dlliMi96MkZhQnJDY0ptRm9aN2FBQ0x2ZzVwWkN1MnNLSmx4?=
 =?utf-8?B?dWtJV3RaMzhRL2tqaHc2MEtjdEFkdk9Ubng5QXdFRG01dkR3WlVQdlRpYXpn?=
 =?utf-8?B?ZDluaG0rcVg4TWFwendHNmRqcEJEcVZ5ZTMrNnpaZ3lBNHVTcFFVdEkrZWRT?=
 =?utf-8?B?VlhubVBNOGt0bmNFT0hCd2p5c3lCN1J3QThJN3o3Umw2VXVrbFUzeTZodHV0?=
 =?utf-8?B?cjB5dHlvMXhyY2dNQlZiSCtyRnVqWEZYQzdDeEw1Rm1pdk1KUndjQ1ZqbWNr?=
 =?utf-8?B?eDg3d3A1SCt1NEFQaXd5aXBGS0hKaG9BUjZ0QTJ3VFBqZDJZUzFNc09NdXV0?=
 =?utf-8?B?QnhOcEpEaHplUnRKODRsMGlwUXJpcU1KRFJxTE1zeENqU05vbjFZWEduUFlJ?=
 =?utf-8?B?bE93UGJHU1VJRG1VR2VCQ2V2cHZvajI3Q2EzT2tDNzBXS29tMzFDSmhheEVI?=
 =?utf-8?B?bzQ1R2hNSTNEbTlOLzZIYVVZWGdMQnlmQ1hlM0l1bEFCa0x1cmN6TmFrbnpk?=
 =?utf-8?B?eCszVmV3NDEzM25RL0xmVlNITFFqUFpPT3hGdGtjZVdmRnRpVWF1U2VsM01k?=
 =?utf-8?B?ZlhxRUtNRDdEQy9Tbm9hcG9yeHU0V0ZCTU1LOW1tVVlzeFIvWkU2b1FLc1c2?=
 =?utf-8?B?dlVDdXBHNUVneC9WcUdlMTBKVlBreVBIeUZES2F4cVQrV2ZWNVkybGYzUDdL?=
 =?utf-8?B?UHdhMmhaWnVhZ2pTZ2ZoLzl0Mnh0aldvaUkvWDlsNTdtR2lFTFdvR2RRZE1w?=
 =?utf-8?B?d2VzalNaZkI3WEtiRjFldzNmcEpZVUxYc0lyWjNJem41bUhaUHU4cVNRNGxI?=
 =?utf-8?B?WUpTMm5teHkyVC84M253V296L3pkbk54aXhLK2gvZzJjLzVGOVBoWDNSVTcr?=
 =?utf-8?B?Z2g2akxoSHF6ek45NEFqaWVZalE2dnY4TCtYdEtjdnZiV0JteFpTbk45VEph?=
 =?utf-8?B?bnZHWk1pTHNHSDhlS1VmNm4wRnp2Vml2ZmNYbld2cnM0LzU4M0wyZlRJUms4?=
 =?utf-8?B?ZDJtK2s2WUJ1UzdNYVFqVHFITERleUt4QTNVR0FxS3hQUFhZRjNhN05iQ2hH?=
 =?utf-8?B?QWtVS3ZtUXBMSjNkV2JoS3Z3ZU5pV2ovaUxHRExkUlRHOS91c3l4dFlQMlN0?=
 =?utf-8?B?Q0k3K0pjM3JTMU1HVzJJRWJtMFBSeWVUcGVxajdidzVTd3ZsZkFoYmMxa3dZ?=
 =?utf-8?B?YVQ1MDNUYjJhR3c4bkFrVzVuZHdaZ0hQOGk4S3pyalJlWmpEN1BMTE5pVkVT?=
 =?utf-8?B?YzVCNm52M3l4S2I2c3liNzVaMTYxaGRrVEVDUGRjOENPSVNtY2N3eGR2NE5l?=
 =?utf-8?B?MnJkVGVBdCsyVStPZU84T1d1dFVSSzFjR3MwRnBKbWpnWTRBaHFXbDJKeGYv?=
 =?utf-8?B?b3JEZlU5NXZGNmphL1A3ZTdaUU5RVWtlR3VIZ1NIS1JXMjNRSjNlUHhmaFpL?=
 =?utf-8?B?aW5BZXdVQk5JZWk3ZWNvUGNka255RGRGM0NxbUprZjNQTnEwVGlhdmJMWllX?=
 =?utf-8?B?OEh2VjBCQ1ppb2NtSlQ4Y1dqVzBPUks0dzdJclU4M2V2bjBiQzJGN0plTkpT?=
 =?utf-8?B?RFA0N1o3NElJWmNDb0JwV0RNVnloUXluTXc1VVNJcjJmdGsrUU9nQjFIa2pl?=
 =?utf-8?B?ZjlEeEJnYk9KUDRZQXJYQVpISlJkZ1lJMVM1NDNVRERsYi9FcjBFUUhqSHdG?=
 =?utf-8?B?eEhmaTBqWHJsNC9pV3huSWh0RlM0Z2w0TmcveUpvOGRBL2RZRnVaUSthU3dJ?=
 =?utf-8?B?VXdNclRNclg1WFY0cFBrU09jN2JUK29jNjdqVmRoVU9FNDB4a2NGTGRYT3RI?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fe6998-39c0-4b33-5744-08de071920dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 09:49:24.4280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWSLWu0ELpzs/1tRBB1qK/J2YN/wCDQAlTjZxKw1+UXX6sRI0rCA1BzUdFE5XWq5D8Qj5si0UDRzBNdx0XF9cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7748
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


On 08-10-2025 10:05, Gagandeep Singh wrote:
> From: Vanshika Shukla <vanshika.shukla@nxp.com>
>
> Fix Resource leak CID:362787 issue reported by external coverity tool.

This is internal NXP coverity issue?  can you also add details about the 
issue here?


>
> Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
> ---
>   drivers/net/dpaa/dpaa_flow.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
> index 2a22b23c8f..417b9b6fbb 100644
> --- a/drivers/net/dpaa/dpaa_flow.c
> +++ b/drivers/net/dpaa/dpaa_flow.c
> @@ -1,5 +1,5 @@
>   /* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright 2017-2019,2021-2024 NXP
> + * Copyright 2017-2019,2021-2025 NXP
>    */
>   
>   /* System headers */
> @@ -889,9 +889,9 @@ int dpaa_fm_init(void)
>   	/* FM PCD Enable */
>   	ret = fm_pcd_enable(pcd_handle);
>   	if (ret) {
> -		fm_close(fman_handle);
> -		fm_pcd_close(pcd_handle);
>   		DPAA_PMD_ERR("fm_pcd_enable: Failed");
> +		fm_pcd_close(pcd_handle);
> +		fm_close(fman_handle);
>   		return -1;
>   	}
>   
