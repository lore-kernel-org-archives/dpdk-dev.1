Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E7ECDE010
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 06:25:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E797240B8F;
	Fri, 14 Nov 2025 07:25:26 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
 by mails.dpdk.org (Postfix) with ESMTP id A2FEC40B8F;
 Fri, 14 Nov 2025 07:25:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otPKMC9VaXAQXa7zWYqZzCjkYMwzWbzbh/kCdsbyIfrncCfrddJWgPgpL4vq6iFBpgVjuoEzmo+5ehNCQePYq5xCFEnBBsEE46etqBg5nxqRgwu1e7OVWhdaWqViQn64nE9xYqv15cecujiUno/o/Ax2JRFeSkjJ+jbeJDCg/getVi3LJAA4pbQSFidQ4dAob7lvxYdGuUvlEh3EBYT07RtaINGutoLSh7ctSI8Ys1d4d4D2uQmNx1E7zsSykYsk7S9Fsavl+3wZdGYB3NSXHrO/qyZMaRCpg6KH+QBfMUAm8VIJcGipZZ5BltyiqRyZRua3eJu8Se60l5oN7OnfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0fQTH1K11bWcYZ4gExb3mH5Py4DXJ1UilxbLtZgo2w=;
 b=dvLBOSViEaox9Epq2X694oSkVb6JvP+qweNCRzsQJkaNz4wLVYL/2O/6RuRMeILWCEuHRd3WC3HLWbNN0qZc6cWXd2DGDDnWBYov87BqaE8413PuYtSb4FMlAgwiWp2KuOJ7LK5WjXT+f5pG58WhHjkyvfDBivAc+WTDYmKDQhSLctzCJiyWoyjb1zB/qJHY5F18N/9iMPTKB/rTZeHAYFtwueWdWFTIOmub2v9AZ7f9P7KwX9z9aKtXX0QQ5UsomMwmQ4MM3C4RI8a8wc8DYFyjoYOC7hhtKE9F4KC7fRGX04+aE0GvppyJ/wl3ZitxuuKWI1wei4KQ4RL5KegPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0fQTH1K11bWcYZ4gExb3mH5Py4DXJ1UilxbLtZgo2w=;
 b=UGWBa4F5UjLAYZdw6RuzDaQmWYAVnYoLkN69qnpF9je51CCq0Qv0vtrkYWcHWN5Wp6d/LO2YudUHnr6UkR2yFc0AW75r/vzwKWtb3pRJWKq8GLmkzaPIVSuna3inxCdVtuqWdfdwsZ7qlc8b78vywGDdwuQ2c1V0/rPuebnuAzZ9x5QJ/UcY9+vZ8NLo0IZOGHhoY+JRvLQZUkdpC95fczGArbS2LIuwKfjYvynjVGUX+cNR7LVgttNbu1xHpZ6yPYI8rjd2IfmmnzMUtDipcYkJuemzP/PtDrYo/nCp2d4Hko3ej7cuWt0L0AKeqNJeLG7H6ob408u43mzRXhidjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GVXPR04MB11067.eurprd04.prod.outlook.com (2603:10a6:150:21a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 06:25:10 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:25:10 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: sachin.saxena@nxp.com,
	stable@dpdk.org
Subject: [PATCH v5 1/4] net/dpaa2: fix duplicate calling of dpaa2 dev close
Date: Fri, 14 Nov 2025 11:54:51 +0530
Message-Id: <20251114062454.2731559-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
References: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|GVXPR04MB11067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6896e43e-a197-48d3-64f5-08de23468fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXJ3NHRNV3RCL2FadlFYZUNlMjR6VTNUTU5DVkhsQVc1S29RaGRDR2NxODdG?=
 =?utf-8?B?RUZQL0xQR2V0c2VQSXd3KzNpQUMvTWI1cmpZZEs0VnZWWDZ4QmRBbEZpb3Fx?=
 =?utf-8?B?eVh1VVlqZ3JJeS9yVUpucytSMGRTZlBRMHVYZTEwZjgwRWYvRG5kZjdEQnZP?=
 =?utf-8?B?NjZseUpUUEZORUw4elYwdDlIZWpESFo2blFqZHIwV29HOEZ1ZitrbENXV3hE?=
 =?utf-8?B?TjBWNjNlY2NoeE1iME0vSFNQZ0xhaTF5d05DODZFMTZmdEh0RTVvYk1IYWpz?=
 =?utf-8?B?akJUUlN4RkEwQk5DdmlPVDJ6SURma1FHYXppOHlpMTVtS2NIbE1UZmlyTUdT?=
 =?utf-8?B?S3cxY1pMVHhSbFcwczczQkJiMU1JZHJyVFd2K21QM1NGanBEOWNaN014dHhC?=
 =?utf-8?B?N2hUZjZFWVc4Mkt4a0FNNTFOS1QxbVdxOUp2NE5sSUNuQ1dyRmoxRWpXQzVz?=
 =?utf-8?B?QkhIL3dINDY0d3d5RXkvNzBaZi91R0JvaTM0S0dPb1AvSWxUdUcrR0YzRGFN?=
 =?utf-8?B?WnhpZ2VWMWpkZjlKREtMY09YOXVTRVBMdjZzTm9jb3M5OE1ZODJwODVrMlZ5?=
 =?utf-8?B?bHlSWTVvM2daclpGenlmMHRJUVdzL2xydjk5RFQxQzU3NmUxVDRPaGgzL1Fy?=
 =?utf-8?B?bUxzR2VVaDlFMUx4TlVGNnd2VDBPN3B4TXJEazM3RU0wa0Rvb2JIRnk3SlZj?=
 =?utf-8?B?SDZjRGtEbDczV1VHb3I0RE1sOEFHV056dVpZT0hSNEpZelNNOVJOQm1GL3Bx?=
 =?utf-8?B?R1k4VTZ3ZlUxRUZyR1hxU0hFM0NMejhQWUlNekVEUWhNYmVzZDZmYUpsdGk3?=
 =?utf-8?B?WjUrU1pZY0wva1M0UndqamVUUWFiRnN6d01BQ1lhOEJ2V09JWFpWWnF4ODZt?=
 =?utf-8?B?VnhkeDdSRmUvWmUxczZRYy84bWRxMGYzelR2RDdIWW5WZlVkcEtFVG5PcS9n?=
 =?utf-8?B?OG1tVkdobnVRRkNtMW95UWV4T0FtaExuU3FQRU1nY3NnK05TK2UwMkU2TlNC?=
 =?utf-8?B?UmppVm10ZUJNU3pmajhTNmJmeUYvZXRVd3c0MEQ4dWZzREp5TFdMbnQ0VUhR?=
 =?utf-8?B?RW03UkZFemFNZkIvUzZJbWgzSUNYeTE5ZkhWR1d3ZUVtZEtNWVNqdGNLTzNY?=
 =?utf-8?B?cktDZEc1TzN5ZzdkbWpBTlNYNkxiNFBiVlhpdG5IRDBSY1c1Zkc4ZC80SzRh?=
 =?utf-8?B?L0x1S2tWc3RPTXd6VjhrZFBKTjRtSU5HdmxaWFUwZUhTQ0JSaklKcHNnajE0?=
 =?utf-8?B?ZHduNTRpRk1qWTdyd1RiRG03VDBUMXk3NXpXSUs4Y3dFaTNvYzZHV0pGdTZI?=
 =?utf-8?B?dVhCemFQUTFLc1F4R1pvYkhHeUMvR3JiQmpDK01venNJbS9wRHZiNVUxRG5V?=
 =?utf-8?B?aXd1M3FsZnYwM1M3dkhrYzVJODI4TWhGMXBoTzZ5a09ETlpkeWdsSnNDMG8w?=
 =?utf-8?B?MU1NdytxamNqL0RpY0Z3cnBoaWdmMm5jeUkyQjFoLzdkMnkrczhFdUFIRUIv?=
 =?utf-8?B?RHIrMHNqTmo3eTRWdGxEemdHSERPTFhnUU5pWXlpSXpxZ1dnOW1uSlpoT2ZI?=
 =?utf-8?B?YURHdDlPT3M2eGpJRFpJQlFzN3dLVEVlbFRBRHk5R0tMWis0bThBVnFLMnk3?=
 =?utf-8?B?MGEzbzVDbHArdFJBMzJPM2M3T3Byd0xXSXQvMTMyTTZEY2xhbEhlOGtQN2ky?=
 =?utf-8?B?ckVnUVZMNXpnQklETkZ0VUhHcSs5L3djMmNGUjNqSDZ0TnJBRzJjc1JWdUs4?=
 =?utf-8?B?R1p1NW5uVDdLNXpiL3llSjkvdy9tckwxeGw0Y2h3RTlQN3hpUFU1Z0ZZZkFB?=
 =?utf-8?B?WHJINnk3TG1TOUVFdWNGbCtMaFB6MGppSDNZc3NSWld3ZFdpdGpaTGROclor?=
 =?utf-8?B?ZDdORWszZ3dmL3l5U1VLMlZYbUFYcVNVLzFSdHBwYWdHVEt1dWR1NVpmSnRj?=
 =?utf-8?B?d3FlZGlLakRIK3RPWVQ5WjhwZ2VxNm1YemxGRkpKbVlmZmU4UXFvRVJSbHFV?=
 =?utf-8?B?ZllIZStzNEN4a0gyRVJMUmd4K0thU2hycG9jTWRkS2pEZnNqMmpGV0UwSUxK?=
 =?utf-8?Q?DDzhbD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1hTT21yK3ZIa2RLc1I4eFNxWDdOeHppSzFPQVFTU0szckdoTmhMNFZkTUs2?=
 =?utf-8?B?SjgvZVJWR0NHOGx1dTQrQlNqbkhZakNTaStISDBLdWR2OEQ0SVUvK2tPcmRR?=
 =?utf-8?B?eVRLR0MrNTVFT1VNM0Q1UkFydFhvaVNoNmU3OUhwS1ZSR1ZFNVhyOGwyTkVR?=
 =?utf-8?B?OFIrZjUyYVI0Szg3Y1FTeUxub2VWQTR4MFJCUmFWNE1HYWRkL282RWdnTDQ5?=
 =?utf-8?B?MjFVQTlvVE1nNEMwR3dWYjRyZElOTG9DMFdyN3QwRE9YcFQyYzdtOFBpMDRt?=
 =?utf-8?B?b1YyT3BBMUlOR3psTEFHbGdTSGdySFBVcExEWWFQU0VCYTBvSTQyQmplUExF?=
 =?utf-8?B?aUhRRlBsZEpiWFBwRXRnLzhVb1dJbElGYWdTZ09YcFN0L2VaeUFvWjRzeHMv?=
 =?utf-8?B?eitjU1Y2NEtDOXdnNW56czVNZzU2Tlp2WGt2eWV2K0VsTHUxQjRvWkR6bFg0?=
 =?utf-8?B?Ni8rZHZ0L1F4cnJQMDgrZkIxRHdSVGdoaGs2WTd2NE9ZS3ZOL01vTnpockti?=
 =?utf-8?B?Ky96dGZzb2kzMGk4Z3NQTjlZL01SV3dZMWpHaHJ0ZTJGY2VCMjlJb2JnRU9w?=
 =?utf-8?B?WURZWVJ3UlBBeWIvb2dwcjFnLzBBY0grZ2lKdGI5RVlhYmovUlYybE9Yd05K?=
 =?utf-8?B?UGttZFVlL1J6THZwcW80VEkzY1RGZ1I2SzRuSEtvVnZUbGlxcGtYeEcycFFa?=
 =?utf-8?B?UEFIblNUNDJFL3l4QmVxL29mN1YwZkdXMmcvUFZKNWhaV2RNa3p5OHc5c29Z?=
 =?utf-8?B?SkxpY1RlUGFjSUFhdVF3bnRteGpDczBVRWxVeWd6c0NPS2U0alJETExzdHBK?=
 =?utf-8?B?OEoyQW85di9kTHcvMm12c1BvRTh6NUM2T2lVRUVQa2g0bm5MNUtPVEFBMDdt?=
 =?utf-8?B?UDRISFllTlA0WlBNeUFIUEVHamM4dDRGUlljUTdaN1JjbS9Sc25kcW5lNVY3?=
 =?utf-8?B?SGorWmQ3ZmdEL1JzNjAzaXh1OTgyOEVIQjZtdjZ1VnRCdW1iU1pDdldrTngz?=
 =?utf-8?B?bTkvSk1lSXlNdlVxL0pOcUR3a3pwVzFhUGxURUVFTjBobDRDU2taWUNnLzI5?=
 =?utf-8?B?N3k0dEtZSlVqSlR1ZDFBVGtSV3g5OXR2aDY0dG9YSEs2UWtYeE53VmVsaTBN?=
 =?utf-8?B?UTNpVkF3bjAvdUdRYzBRNll0dDY3VUw3MHBaYU1PWXMzbUVIRTlOZjlwMHpv?=
 =?utf-8?B?bEdtLzRwN3pqTlVkc3NoZWFOaFdOSmtqd1RPbUUrQnlwdWVab1hEb0VleVQ4?=
 =?utf-8?B?K202VE5WZkVYcDdpaGcwRjBuYnFZVlB6dFpVQS9Wc2JSdDNPMDZHYTg5dFlx?=
 =?utf-8?B?ZERBa3E5TTRLVHRWMWFwL0VFUEMrbEZCY1NoUkY4NEV1bTcyb3dWRkY3ZzAw?=
 =?utf-8?B?ZkxZcTRyMVZkMkZzZTRaaVMvQXFLdHlmcEFXdytvbGZBR2IzQW02WGVZbnZ1?=
 =?utf-8?B?YVorSzgyZ1U2blJVcmYwQS8vbHVsTUxjempiaGpYclZzdDhnZVVoWDYyNE50?=
 =?utf-8?B?NHZIMVhtS1RTWVMzRUVvVC9ocHc5YnpCVUtlaUtGY1pBVkdPSTgveW1RVW9I?=
 =?utf-8?B?UGp0c1I4ZS9TWk4wRVRMKzQ5eUpsZGM0WDIxS3ZSc0dDYWpQU1RVQVdqOEc4?=
 =?utf-8?B?QXdLZi8yNmN3YkRuL3A2V1psQ0dVZWhjYzU1cFVqaFI0b2JGR0F1VmtuMHFK?=
 =?utf-8?B?YW1PbXhiNTJNNlVyZXF1MUJWOVZlamJyemI0TERLMzBXRHBlZjU3QUUyWW0x?=
 =?utf-8?B?bUloQ0J0UVpLMkhiRDdFR3RTSEZaSUpwek1tTWhKS3IyWlZvbU9LeW1iK3Bv?=
 =?utf-8?B?TG9pN3h4NDZuTjlPWm90VW9CMGl4dS9FMmU3dWJ4UHl3QUNHcmFXTEJpN0VY?=
 =?utf-8?B?d3NPRG01UDJ1RnVqUGd5UjUra3Y5cGlyT3Q1S2NkL01ieTB6RmVqMlZOZk55?=
 =?utf-8?B?ekQ5bDVqUFQzeEdjbHR6M0xzdFAxT01KL2huWVlJVWdSVDdzdk9hRmcxZXI0?=
 =?utf-8?B?dnR0R2FsZFFaMkZzd0tIeW03WkdFQVhvRTI4ZkJLdklqc0h5blUrN05wK0hY?=
 =?utf-8?B?Rm5vS1RqUU9mVUlmcmxRYkF2UktEeVBYdHRnUDhic1E5bjRXbWczTTc1TUdy?=
 =?utf-8?B?enM5aGozWkxqcUVZRVpoS1ZDbWpRV2lxRnd2dnp2bklLbVZ0ZmVYdVB5UExE?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6896e43e-a197-48d3-64f5-08de23468fe6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:25:10.4537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxBwLbykrT18woWgWz8kGBYbGvY9BMfJUWMc7onzwZ7+ySlbGQuYTS1CP3dcLtnaQShCXKeZSW/pFk5REvav2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11067
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

When rte_eth_dev_close() is called, it performs the following actions:

Calls dev->dev_ops->dev_close(), which in this case is dpaa2_dev_close().
Then calls rte_eth_dev_release_port(), which releases all device data
and sets dev->data to NULL.

Later, when rte_dev_remove() is called, the FSLMC bus invokes
dev->remove() — that is, rte_dpaa2_remove().
However, rte_dpaa2_remove() calls dpaa2_dev_close() again. Since dev->data
was already set to NULL by the previous call, this second invocation
causes a crash.

Fixes: 5964d36a2904 ("net/dpaa2: release port upon close")
Cc: sachin.saxena@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Tested-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 7da32ce856..fcda267e0b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3347,14 +3347,22 @@ static int
 rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
 {
 	struct rte_eth_dev *eth_dev;
-	int ret;
+	int ret = 0;
+
+	eth_dev = rte_eth_dev_allocated(dpaa2_dev->device.name);
+	if (eth_dev) {
+		ret = dpaa2_dev_close(eth_dev);
+		if (ret)
+			DPAA2_PMD_ERR("dpaa2_dev_close ret= %d", ret);
+
+		ret = rte_eth_dev_release_port(eth_dev);
+	}
 
-	eth_dev = dpaa2_dev->eth_dev;
-	dpaa2_dev_close(eth_dev);
 	dpaa2_valid_dev--;
-	if (!dpaa2_valid_dev)
+	if (!dpaa2_valid_dev) {
 		rte_mempool_free(dpaa2_tx_sg_pool);
-	ret = rte_eth_dev_release_port(eth_dev);
+		dpaa2_tx_sg_pool = NULL;
+	}
 
 	return ret;
 }
-- 
2.25.1

