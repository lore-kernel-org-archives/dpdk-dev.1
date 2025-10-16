Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9A6CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 05:20:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E325640E22;
	Thu, 16 Oct 2025 07:20:04 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013012.outbound.protection.outlook.com
 [40.107.162.12]) by mails.dpdk.org (Postfix) with ESMTP id 3F65040269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 07:20:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arrBCg9zqPKqix8H6nl9OCIk3ZG+N8bYDEY/FM+cElVTYETLNwOLNl6CQJQYa3D9qvaU6NAmovbs5vqrcvd9YS0AKgNm+O3qfgjecvAUneyApEhp0AgJawHdu6t0RMWqt1xuWOp8jcl4kcvcwRes9elEbxF3IEIphyMxSncH3WV9LSoRrdguoeePm4h+CVtpGzJkapYQ/LUQCNS+wYCvRRiPDHURJWBOcZg2h32BRjO1Qs6asBGdKvq8WebQKwegVhZEfxmC97wFIoBxzIFr+0TnHjT48hiGl5Pz+zM/K9Io6X/Ceuwz7JfwhVXmEmJKN68b0NKdMlbXErqR684/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h3GQTIiMYW+KLAD1tCVK0ck9RxFRhEyfSPomo6GTls=;
 b=xMnFxuS/AU7fbo65l6n5DbQYRfUw42GG+6AceOIIcspT6H7BHA2cdcyeyu/sEpvQ5lh2HvryDTv4tXqV2lssvQ2C7gWBFFIXzVwHarPiZJJdyruqEev6gnFSKygcaV1kujP0I48ZUoj6EwVG9EZfUqApwKiyr6t3y5uh9uJqjp4zV6QdG1i1Z22JP/RX92jzAC4v/3TcjISvASrEF/AaqoY84y6wyCLKPas4RBvDS9lc3D/toEI9e9jDSDy7nhwEhaEXQhyMSVsqaNCWZMsNanF1Gfzi8CtK+ectw9joc1P42LQOFXa28fvOt5kgyAbTtR6jBDsZChUKayQI+1/hEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h3GQTIiMYW+KLAD1tCVK0ck9RxFRhEyfSPomo6GTls=;
 b=vCfqs16cESXbcSH88+bapncUtm+ithczRLsHkBeawZMWhow3D+XSF00EpPkkZ59wEb+xVXdI6JYm5M8Xtt6ALorcjx2782C033k4AX/d5vszH9zhQJWTi9brprLo4cCdqmtiY+00Zx/jfG3n9RQ2tBu2f0RVk6yd04BLsHAB+yao8D9Mjigh7W5iPVIz0yddHLph4b9q89K8GrXWnhhnzSVzo9z19/UixLwDUnvtAjqkqhUXN60LsmZGQO4R0dV4dCN8JDEF2TnCPS3IpcMy8N6b1giXYkYfXYUdlOvVxHFg1pxhMMhr/vjiYtfI3TcDB7WMDmPYOlWnxPIBuNUmMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PR3PR04MB7482.eurprd04.prod.outlook.com (2603:10a6:102:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 05:20:01 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 05:20:01 +0000
Message-ID: <83c39699-6d83-4bc7-b015-b2bcc16b3f92@oss.nxp.com>
Date: Thu, 16 Oct 2025 10:49:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT 1/3] net/dpaa2: remove unused frame array
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20251015230933.875860-1-stephen@networkplumber.org>
 <20251015230933.875860-2-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251015230933.875860-2-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PR3PR04MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 8473236d-40c3-4d50-874c-08de0c73a7bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTIrc0tIUnRqekNqeVFyTWE0N0JxTC92N1pSd2s5c3RsbmYvdG1QYUlYUDF6?=
 =?utf-8?B?ZGxsS0QwMUpFTkpBMDhPRjlYVlNWOGhlMW03a1J1aS95WG0zNXhqQ0RENUJL?=
 =?utf-8?B?eHZaN0c4eXhuYm1ocFk3S0h0RFhyakJKOCtLdHhzaktTdjRGUEpzNFlyTmdr?=
 =?utf-8?B?OTFNVkN0cnMyOERHNmlVNk52c2pIREpYZTYzeVp3NDZGZU95ck9Qb1ZwVHdB?=
 =?utf-8?B?Yk8yUlRCYjhMREJwdWJRVFdwYlpKTnAxQkMwZzluNVBxNkdlR2Mrd3ExVWpj?=
 =?utf-8?B?cEg5YmNHSTQ1N1BsWFRQWHNBY1FsTnVPSW1sRlpiREovN3NPUHRsTUUvRXps?=
 =?utf-8?B?eSs2MnNrNUVSUFhGRzJaSjN2UGlyQjhtZjhKUTQwR3dCa0tVM1dmU3ducnht?=
 =?utf-8?B?QXpYWWZ2Y0I5MVlibFZhNUtYQ3d6TGFyS09FSTQ0bERndXRiS2tVT3JReWta?=
 =?utf-8?B?Wk83dnpjMGtxSHJ1VVlQdkJvcEZQeElueEZpNE4rYlNjcUxuVlFBVGxDN3VH?=
 =?utf-8?B?aGZqU3lLRW1uaFVoanh1QjNXK2k5UlZQRGNTR1VFaGpzeTRlRk9GWEtaU1Fh?=
 =?utf-8?B?VmhWTVhYS2h2TUNaaDlCUm91WHBOVWJkUjlWY3NwQ0x5VTRYS29DK3pKazdZ?=
 =?utf-8?B?S2NqZUM1QTA2OW5sSDAzUWlqSUVtdE9CVlJOREZ4VC9JOWZTN1crdkxPTU40?=
 =?utf-8?B?alIvaStjbi9Ma0VOZ0puTDhaNnh6MVRCTEhVRUpabFVIVG0zN3FVZC9wZ1ZB?=
 =?utf-8?B?U2J0VDc2cGp6WUgrbEQ0UWw4VHJBRjJwS2FzdTlLNWlJYU1PUHpXYkwrek1r?=
 =?utf-8?B?VnJlS0xkZlhQd0RzZ3ZrRlNlYTJWR01XcmRRcWhrNlV3dHMycUNrNThzMkRF?=
 =?utf-8?B?Nkp1cmpXaWxKaGxaMEVzbEYzenQ5eEVOd1Rtdkowd0VmRHdTQTlUOWhXQ2Rt?=
 =?utf-8?B?OEpJaU1BT25GWmhnaHNocW04U2xCWVZvelEwcjBtQm9PWFd4cHRWdVhRbUdG?=
 =?utf-8?B?bG5oQ2Fudmk5V0ZydTdaTWpJTGMybDdFOXZJcjRkT1AvT08rTnpTU3B0Q2Uw?=
 =?utf-8?B?NmN3Y0JIUnNVYmN6aHJYWFgwQi8wSjFNMEtvTU5lbGdKL1FXVnU3YUIzcHJI?=
 =?utf-8?B?RmRDMVVob1MvTWZ2WHA2d2pDQ1Ayck9rT1g2UDdGWkxsYlFmRWdOajhhN0hh?=
 =?utf-8?B?WWY3MzBrc1paRUFrWDBpUVBXaTRDbDdUeWpsVVAydUs5VmVnS1daaGFIVUd5?=
 =?utf-8?B?eDN0YTdzaFV2My85VkVOa0VFMXJYNnkzUHl5cnR3b1NPWEFCa0xOWVJBSFph?=
 =?utf-8?B?WXRvNTZpTDNDdUxKYnlzakFGclZ0KzMvUjhsczdiMnB3QUdqeEZkckt0Wm5N?=
 =?utf-8?B?b1ZYR3cvQS9UWHZ5Vmp5OVd5dW84TlNCMUxtZERQQjcxSStZOGduQkVDOEpa?=
 =?utf-8?B?ekF4TXd5ZThsa0Q3TS9GYUR2S0s5Sk1nSjAwTTVUZDJxeFd2WUJsMS83SDcx?=
 =?utf-8?B?SlpFQmcxNy9wRzJMUXJheUlDU0ppb0J5Y0tRM3lsTFVHVUpkL29FZEY4SXgw?=
 =?utf-8?B?WitQeGF3aHBjcEpQSW53WmlDMzdOUmFoem1WSE93UmsrVmJBcFZZQ2JISzFh?=
 =?utf-8?B?dm9SSmIzbHJEUS9vSllyQ1hncjM3OS93bjlCKzRSNktFei8vak9WZmp0Qkhx?=
 =?utf-8?B?M3lCbFB3T1RkWEJWVkk5VGlHdXF4VzBnd0lWQTNXNWtDZDNIY2hpUkdXQWYv?=
 =?utf-8?B?SjhYVmpWS3Z4Y1ZZRlJFMEFCSkd4NFdSYzg3K3RsVGVOeFFTaWpjT1ZkMEI3?=
 =?utf-8?B?cThzR1BHS0M5U3ovMUlzalpmM2FoZVBrY2FCTTdwQm52UW16NDZPYmhWbWdj?=
 =?utf-8?B?Q2VaM1B6TitlY2VqWE1pbmZNSDlTb0cvTXdQTDRsbVh3YWJNTHJYT0VGNDNG?=
 =?utf-8?Q?DPCtc1R10alXdfOeghvQYtaQScICnwsq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5WN0lZN0lGTVgxSzdYZ2R4UHVKVzcrTTdUT3FFdGxSR2dzOTJCa3pIUnZp?=
 =?utf-8?B?M1lxNDhVZzU3NEh2dW1KdHlWSHBDUXpvaGlKR0JNbGcxV25jZkxaSXBXLzhW?=
 =?utf-8?B?UkY1V1RTcGpnTmRma2tFWXUvRDgrK1drbFVtWGNpVnE5Nzh5ek5tcTdBUUZU?=
 =?utf-8?B?dm9OUzk4ZVArdGF6bnNYcWUwQktEYm92ZDRzQmQxV2JlMUt6cnI2VWVvdTkw?=
 =?utf-8?B?b2VpOEhNbWdPZnhWc2UyUlZzZ3NveVQ3N08zN3h6dFpMYzRTOURtNlZzM2xn?=
 =?utf-8?B?RDNTNXF1QjRtVDBCSDR6TGdad1NKZ0RtcWl3MWtySGlRU3doV2FScjgrYzhz?=
 =?utf-8?B?Zk55RUhua2IyQngrSFE2WEk5OTBaSmZodm1sbnhES2EyR2IvRE5ZWTUrU3BR?=
 =?utf-8?B?bWRzM2lqSU9OTTRRQVljVVZwWDdsKyt5TzZEazlKeXYvU2VTazMzZTZpWnhB?=
 =?utf-8?B?ak5nZzRHd2lMOWl4azZNSnJnRHhUZEZZSnNZRFc4dXVQVEdUYzg0RnVEU3F3?=
 =?utf-8?B?eGsyKzR3dFErbzM1bjRIUVlLQ3NjODdSMUZuNFRHTXNPWDdwUEY2SW1BSHZa?=
 =?utf-8?B?SVoyeWdRZFF6SkswUDAyd2djVEVOTnlLVGpLdkJRL2t5Zmk2TjBBeFZXRXN3?=
 =?utf-8?B?bU12NEROdWRhTUtCQUgxR09FQk1iK3dna2dTRVFhZWg5b0U0MU02MlBYV3JD?=
 =?utf-8?B?Y2hlT0dWY3FnOUNla3JKTCtZUklGeWNiRWNhakhNSlBZUy90aFlQVUR6THox?=
 =?utf-8?B?b1V4b3oydklsUXI0VE5zOTRRd1RPSnErLzJlWHRWdkdBejRvNTBqcjBzZ0Jm?=
 =?utf-8?B?TC9vTU0rUFo1Mk9vVWhBa3NmRmN4aDkxTVZhMHE5Y0cwV1EvSTU2NmlwTWhw?=
 =?utf-8?B?RVNqMExpaWh4eXIxV0tsb2JEek8xVVdkZ1g5QjA5NEdSRDRYOHA1K3JMKytq?=
 =?utf-8?B?UzFNeWR0RXUzSkxITURrWThNK2I1K1NIWTl2ZURFejk1ZkVzRDhnTGFWWk8r?=
 =?utf-8?B?VTgwMGorYzZhRzlIRElmbmp0K05xaVZGd0ptTFg4ZEpXVFRuWitVd1dTSG0r?=
 =?utf-8?B?dkdtb3Z3TDhMM2laNXZIc3labG5WR1E1UEZERWxHK0FYUkJQNEc4c0hmL2dR?=
 =?utf-8?B?b2VqdStJeW55L2lhS0lGeVArUkxyU3VNTzlXSm9lUFNjRU1KQXIwSUt2Nis1?=
 =?utf-8?B?Z0p2UlQ3NWR6U0lIcGJKQ1kxYzErSEZnd0wyendham5EMUxGSDFLeW14TVZp?=
 =?utf-8?B?aHBRVTVHYWx4NHdOalhkOHc0ak14M0QxZ1A1WVZwUUVQM1N2bWVOby82Nlla?=
 =?utf-8?B?WkVnbEtIdDRHYlJNZ0xpUVdUU1lnSGsrTmtzb0Z4ZVBjOXBvSGdQVDltRFg3?=
 =?utf-8?B?NDZQNUdSRTJjenpFZFZCQWtTRm1vS1RTSnpjMXJwQzROT2dmbmlEQkppei82?=
 =?utf-8?B?T1hERHFKcFlFbU5qc21GMWFzVjRVSm93MTNPVWFlaFlBLzNyOHdFT2lTOW1X?=
 =?utf-8?B?ZXZDMmhHbHIyU3paV3krN1hiYmF2NU5PYko2VlJiRHk5cnZjOXdmM1F6MzE4?=
 =?utf-8?B?T2ljNnl3TEtLVEFHUFQySkVGcmsrK0lieWZUZHZIOXp4cVhrUjdqZVptMFBQ?=
 =?utf-8?B?RDd3NVBvTS9jUEUrK0JMNHZPc3ZpZ0VWV3kyUU5vSDRBa2o0Y2ZLM0owYjdD?=
 =?utf-8?B?cHliUWlJV2pZOFhoQ0ZJSnVsTU8vMXVXaHNPT1h4Vis3TVZmOEU0U2VETXov?=
 =?utf-8?B?NUFSV0hpUXpIVmJBemR6YmdpZmZwcWxITEhWRmozeEVKaHNSM1JNNnlPa2Y0?=
 =?utf-8?B?L1AzWTdDU05HUzZEbjZYTW9UZHh2b0R4di9ETlhndHFaZHgxL205YURGYTU1?=
 =?utf-8?B?REtoZTg4dmh5UE5OOGhyOTM5bHZOeTRGczBqVGNmTFBHNTU2enV2OXdWT2do?=
 =?utf-8?B?TjM5SmEyaXJUd1o0YnZmVStwVnNjRUg3L2plckZWaXQ2eDRaUHhqUzFWaEJF?=
 =?utf-8?B?aktIMGRoeStkYkloS3lOY1RSOUZrNlNUcFl1QmFTY2k5SitGZ3F4TXYydUZs?=
 =?utf-8?B?NWNrcTIwSFJDa3JQckpiVm5obG4xWjkxYkVWZ1dHMmNKWFBNVkNUTGdEajNJ?=
 =?utf-8?B?MXk2aHN1ZDBPTFhwTWhwM1JrTXl1SUdQY0pxY0RkZ2xaNldlN2p5dHZkNUc1?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8473236d-40c3-4d50-874c-08de0c73a7bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:20:01.1413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdjjM+qH5TvklX1rantYrJoYCxDEjjBecSyHMQX0LUqoL5vwoWOjJNqqx1GWAuSN8FwZq8ceqGPcZQRosj9hjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7482
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


On 16-10-2025 04:37, Stephen Hemminger wrote:
> The frame attribute variables were global but never used.
> Tried making them local, but then compiler flags as unused
> so remove them.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/net/dpaa2/dpaa2_sparser.c | 117 ------------------------------
>   1 file changed, 117 deletions(-)

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

