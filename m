Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82951C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 06:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B191402D3;
	Thu,  6 Aug 2026 08:11:15 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013055.outbound.protection.outlook.com
 [40.107.162.55]) by mails.dpdk.org (Postfix) with ESMTP id 52C074027E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 08:11:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIgxtVEl53tgfCHQRttCymyyXtEivW4n2qP61WoOqE+ehVfJY+FasX+9Y46BGpFiN1QwKGjq4ZbxDyoG9J9TiXITUEVPxuPC/Hfvfy5hb//Bv744QmXBneWwNEeZAMcRQ9DZrjsZSAE/as87wI3AOZaBFXtTAOxAkZKojZgsAKuipp5GjPELwK4aKAVI82qFlUCOjxzWatibFKgAdq55bhWyxO7zZERLwll5saFWM85edyBF0B/0svYOwrsMAU/N/c3WDF54Cgsav9hCskL6bCOw1owyfvbWM+1+b/TS/lMefkGkIYPSY50EGrE69Cdc4+EU6f1Xk9qD8NGpNEHIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv+aQMIMuYLddeLsKiD+suYFHFrs5yv1oBM6m8AshlE=;
 b=IbLibDXKPpQBM8Me48kBIIrxoB2u0PLynmt/us1bU4O9H7R5aAhce/JJ1+PuERzJtNVKLwGGxSbfqdV/8FeAik7Lae4gQ2EnkX8O1ub0ersml/hf5+9gYTs2DmZOai8ZqoWz9KVHrRGPxAtElXapt7BfItCQm6KKjxP3Twp84Gl5rf2xvGeG+xKbEZ428W+9SeGV7/G+VZT+S5xE8aUEjsAq9z1vzm8oMx895bByAp50Pq+yyPc5DV/I0EHTMwdtHDgdSBuKgxYsSzlNmRzcnadZgP5hiz5DmfqbGb68rdivdbMSKzst474aK9ZrXO07WqjrT13PaNt+VDFoVPU/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv+aQMIMuYLddeLsKiD+suYFHFrs5yv1oBM6m8AshlE=;
 b=oLRXarAc3xVrrVO/A3CQUA1JqGpcv6yoKlbwxQrUaAKKXfHWiYDV5Gd5doCheXfP5EH2AWWFMNt8S8QjMGXek6U8pEkSVB/sdLtBij6vvBoSEu5pkRE26kOkqA/IzwqzVyFeP3/a2CJE+z/JqjKtgVeNn4vB0iXvRRMgPWQ72vM53v7AbMgIbVh7NF3uvC7ZCGpxbtfHasnJ07GWe5neC36szA6hN6X1/9+7FeLm2TVfrf5puJFLa5xpqMDSjz3lYkGFTCCOnpdhkRGN5Xp7PF0fZ5MxF2emXpV/2laEXESJy7/4UztuPJB7n/oqS01WCPrUufBwPDhf9qjmOn4L5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM7PR04MB7110.eurprd04.prod.outlook.com
 (2603:10a6:20b:119::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 06:11:11 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 06:11:10 +0000
Message-ID: <44026834-caf6-4b8d-9621-f5f6261f6f2d@oss.nxp.com>
Date: Thu, 6 Aug 2026 11:40:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 09/32] crypto_caam_jr: replace rte_smp_rmb
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-10-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260729175715.165120-10-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: e555bf53-307a-4ee6-c9f1-08def38182a2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|1800799024|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BHTcNESaOuNvOtZv4mDnweFD4uzMa2xRKh03ijQJTv0mwF+pd/fDIpxPnNRxTXYB/3W1DOzHhbFcipcPZBdwB+BmBIvq6cvxdZaKrp7rlH7IPOY8mrNtVJ65yQrNxW2jyS2TTZ90OxkZuzrvelK2icpXNhOlOLRyKtY6Gjg8KKI9dXhCZJCcj/Wd9yS4b/VuZZb8mr7Dd/k4QeFOc0nxE2qLpCFpukjNqerVNpdCge57nV8ytCMB9yqVUW/RFNbyxdJk9gApEK2XuWk/fujGleTQuneKOAInlqgGd5KtCuWnIlXO0s/1rI1WLV76sT6G0ADJs8lcM6rHw486r+TkmguvfLY5tNLiOa9NnG6O9C6NCWVU7MsKQzvTUFl5+wj5k15HKWWiD4ejv/PIInBcbX/yO1NqIJ3BddIHIMaHJcoICrXytUe9ojvdM7shw5pk/mS9LmQApZMxumOkC1WPlYai3nk3tIg4VUKDOh0zRQJfVIbifoDlt5E+H4+mykXL3O3hGMp1bAXTC4i77r0TLeGDu+i6F9AGEhPydDlx9/ST7gXv6wYbpFKLFAyBloPY3FaQ8Q3VO/EGOdPODRKplI8nLdSTTZUwdrzKhygZEYEKF6+jZMRrP8IZcfQav/FxVLK3h73D891Y2zshfGA5HlykW3s8EcC06AQjESLr1eQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3IxZUdwem1QMjFpdlFkQTRKRFF2OVpDc0VyYjNhbmNzbUJXZkdRKzZYTVRa?=
 =?utf-8?B?Sm5pSlIxaHBsbG44UUF1V0ZTWkFVenB0OTQrNStOd1VOWmRxRXQxYWNmamVr?=
 =?utf-8?B?eURuL2J5c1NNelYvdmh0WWZianl5Ujc3T0dUb2IzWnkwRWdaK1JTUjVnN3Jv?=
 =?utf-8?B?NFNOZ3NTVDVaNFdoTzR3UGlRQitBT0syQTNKMFhHdnlFR0NCK0pQVzdLWVZ6?=
 =?utf-8?B?RHgzOU1tMTEwRXdXSGdsVkVDV3VJNCtFNnhtLzFBaWcvc09sME5QWTA2VVU2?=
 =?utf-8?B?ejN6cVVOZ2c5Q2h4S1dNRUY0TXl0N3JwY3FWakZ2eVpZTVRkQWRXUFB4RmZu?=
 =?utf-8?B?Mkc1MXBWNTY0VWRYa0dQc0lnSmM2SWh3RHUvTGxnclNLd3RIb3Yzcm9iMGN4?=
 =?utf-8?B?SGViNVkzWDlwTW9FeWNjK0ZVZ20wVGhLeWFrcmpSSXVXOGtCNkNZejJvdFYv?=
 =?utf-8?B?M3FnRWk4TGJZbkNiNkxpKzRIU1RqV3JvbC82NHY5UDMraFlIdU9iUit2cER1?=
 =?utf-8?B?WDFnZi9MWTFnSXNxOWRzUzdIZnRxRUxDUm0vb0FtNEVKdE9MaWMvZEp0Q2Yy?=
 =?utf-8?B?SUdTN0ZsMy9ZVDFSNm5RZVlybWZROElFbnh2RzdYQXdEODBrdGxmMVhWWnoz?=
 =?utf-8?B?N2NNWTBSN0lFQ0V2eXhRZjJiNzRXQTJxblBNeVA3Qmg2Nzc1K1BGaDZtQndP?=
 =?utf-8?B?Uy9udm1iRGhpcnJyUmdvb1V6cUJPc01vNkg2OE5tVmV6b1RVWENMS3o3OXpq?=
 =?utf-8?B?N014cittbllwNmsvK2tZa0hQb1JmQnFlQmVqVDBYVHpZTFJoc0FvekF1MG0x?=
 =?utf-8?B?NXRTY3E4NXA2R2ZacUZrQjFiQ2ZaVU4raGF2Z09rUkN6MlRCYjZSL3JIMHRr?=
 =?utf-8?B?cVhpVGVxaG5uZkJCODM2YjBCL2laNGZ1ZElnWWZ4OVlLOU45TDh1Sm81Y3hx?=
 =?utf-8?B?L2prd1hvMS9XQklaQjZGWHRWU3BHVVIwdEQ4MkV1Tk1QeG5jSWUza2lHb2U2?=
 =?utf-8?B?YVc4TmJRd0lpeVVwTmlqcm4zVkl3emtSbCtlRzE4MUtzcmMzZWliSjFubVJ2?=
 =?utf-8?B?U3RIM1Z0eHVBVzhWaTF0MVJ5M0gvYnc5dVFyZE5LOEJOZ0MrT1NBYUx4M0JC?=
 =?utf-8?B?UDRKK0lacisxcWxQeDY2dnJFNFFleE03SWpxTnIzSXQzR29wRjlGOTFUYWVp?=
 =?utf-8?B?cEdPNncvd2Q5dGM1UFJPdFRWOVAzREl4L1l4RnNSR3pTUWxtTkVNYVorUWNl?=
 =?utf-8?B?VFJTcGVTUWdkRHdyRHVOYW1xM0t5SGRNNUUwNmdzWnI5dzNLNTNWbUtZcjly?=
 =?utf-8?B?TWZIeVgvQWdMUkpnQ2pRT1VWcDl6NmxOR21RQkgyTFpacmhoNlI1YnN5cDNV?=
 =?utf-8?B?VFhsUDgxN3N1K0s1cGhBWHJHclQzOU1xZ1NFTnFXOFpxbklacjlpZnYyeHox?=
 =?utf-8?B?UXdzNmc4d3VJQVhGT3pXK0ZIMjhNTGtoZDd0bHRRbEVWMHVtWEgxNDBWYzFt?=
 =?utf-8?B?eVgxOXBPNUNSNmd2TmhtRDMzY3dyYUpzUTNMUkJ2ZmhUSlFuRnVRWXVnTmw2?=
 =?utf-8?B?anQ2aXo0djIrSEk1S0pRcDBuQWhEZ2lFZDFKVmVBdjJRQ0hGYzR0Vmpyd09l?=
 =?utf-8?B?U0RpY3doZGNCMWFRZjl3TlRRYWFyWllpeVJJYVpjdUgzN3pkVkJHN200eWVG?=
 =?utf-8?B?RUdHTStpOGQ3RHRwb1ExdzZ4QzNZQ0h5ZjQwZm94WFhZS3BpTzdoOVd3Um8w?=
 =?utf-8?B?Y3ZUWEp3ZGdWbXhVZERUaG8wMzZmSzdYRjFvbklMVDg2dVhvdFhuYjNVamlN?=
 =?utf-8?B?bm5TVEtFekMydG9Kc2hYMXl6VmQ4ZTJLVzdYeEoyZ05uZ29yVmpHaGZzcUpK?=
 =?utf-8?B?dFZPODYrZHpBOERtU1gwclBPS1ExeDNRQ1J0T0pHbnpkdlVrQzRSdENwRndH?=
 =?utf-8?B?bWFXa092Sk1oaHRKME9NOWdUWWlJRjFXNWxkMWdyVTlEbXExaS96eUxUMnBM?=
 =?utf-8?B?QzBJUkhIcmRXWjJwSmk3cUFYSnZJVXR4WmcvRDdDQWNHbWJyelJEdTlSaWFJ?=
 =?utf-8?B?dVJKTVVhazBVKzRuOHF2QUdmVGY2ZDRlZmdaMCtFcGYvUGNwWm02ckFScXg4?=
 =?utf-8?B?RlBRUkxNVU9WV05CY21yZlF6N1czU3dmS1dzSWViWExVYTcxVkZGNVdXMm0x?=
 =?utf-8?B?QWxYZ01oY1kwTzZ6aVRpVGdkdWJYT0RrNjN5dEtMMTZrSlVrRW9tdHcxaDhq?=
 =?utf-8?B?MDczWUQvQTlidTBtd3Qrcjlac3hkUFVGa0hIWEU1SDVnYVJSNEJFaTV0aEFm?=
 =?utf-8?B?eURPWGJ0cmtaQzNEcEtLc1N4Mjdkckt2eC9Sd0ZXZ045MWNtQlZib0dSQ0dk?=
 =?utf-8?Q?HGZuLnJSpkqGIlAQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e555bf53-307a-4ee6-c9f1-08def38182a2
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:11:10.6045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaQ/ZxdKS8wsS9jO+vT3FFPUTB50d8slK1GrydpADBLPOc1DHAEPTIsnosYkp3kQrySpQ8gjT8yLQ0VbPW77cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110
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


On 29-07-2026 23:24, Stephen Hemminger wrote:
> Replace rte_smp_rmb with equivalent
> rte_atomic_thread_fence(rte_memory_order_acquire).
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
>   drivers/crypto/caam_jr/caam_jr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
> index a57dc56b80..1f97e72337 100644
> --- a/drivers/crypto/caam_jr/caam_jr.c
> +++ b/drivers/crypto/caam_jr/caam_jr.c
> @@ -572,7 +572,7 @@ hw_poll_job_ring(struct sec_job_ring_t *job_ring,
>   		job_ring, job_ring->pidx, job_ring->cidx,
>   		limit, number_of_jobs_available, jobs_no_to_notify);
>   
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>   
>   	while (jobs_no_to_notify > notified_descs_no) {
>   		static uint64_t false_alarm;
