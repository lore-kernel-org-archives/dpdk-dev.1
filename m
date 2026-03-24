Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D8EF532D7
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 05:17:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6D9A402CE;
	Tue, 24 Mar 2026 06:17:20 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011069.outbound.protection.outlook.com
 [40.107.130.69]) by mails.dpdk.org (Postfix) with ESMTP id AD9774025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 06:17:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtbsYYeMgEMs38yuUm7DwX4iRd7UX6/I22DeHo8GB5D8o4KNrrYfS79VyqfUhjACxVr844Ak8ET0vU0YxLve7e+6lLBCIkVkSLIbtM2CrMoXXiD+cvqQTBrFj1sDEBQslbMDCH/7rsgyeIE7RJuLojEyREag31YdCcYMVnVnR/WhVnKwpp7uAtEByk3ZgaziLPAXHugPBRc8ktPHfVJWmVRWmBpBk17PjhuGIH5RDPA9viORv13xt6gRZhpVwjupX/WeRVGZrnv4AUu3TZU0jVZz3WhLTWDnyct+GOL/EWurryFOyB51SVnSrpabY2N4jnLWmlwvD8Yyg8LCC90Fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPCsOMiVaWsAt5aCI3JdLjWMTsA5TEVIbb6lsQX76Mc=;
 b=Mf+C70uBDDIW6/awy/bE+3wbv/c1Xxp/RqVuJVC5M8VEeXa8EYVu25ibxO/sFZUT7g5yjN4XeGKGigB9m50cVBak8sAG4S4rmb/eYlqY6FrZmRLDlC3wtA+Rj6suvPTOx5v5Ez/UNFd3SHWvKAm+cUoVnCsOUXUYlUdZNYufQprpQCGYqhL0NqZR9kJYN/hJXxWk/ZiysrF5iRqvBvXCh/2BtU0K5L2cdIjz8n0yF6qyV9gCSxmE/VoMVp2UbqNRKmrt6/mF5tVJ/WaT7CYzZIY5SLk4qfgOrWdciZRxLRYfy7pAUDbWpLFisYBu593cBywMbvDUKclAL/hW7CZ8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPCsOMiVaWsAt5aCI3JdLjWMTsA5TEVIbb6lsQX76Mc=;
 b=lj51iGO5zR7oWW8m9ckpF7IzQNiDryHtNDJnWy/tKwrFQ2Lf17mOXUkgUB4v9aNqJX+JHquY1bV/glnMWui1OO6NuxrQVN+LobqMC2HWBPJUXm3gy3RqJcRgGy8YQ16P/NRbJ31erM096ooehGPn5QETemR6HobTRBKHJ2lJhCOTSt/nygleOY3iNNImD70rHaSuoDeWkd9LwpYRZL/d2G7tY4g9fuF1JwEaf4+PvmLtN+g9weKZ9nyOpaf8XC3ceOoTYl73u3M9iKb6QZf4EPlBk2l1+yQDemKH6aiorj9H8yeAK5a1JCCYIqNzC6JZMQWzhuI0FjzfnSFmTXEPkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 05:17:14 +0000
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7]) by PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 05:17:16 +0000
Message-ID: <ebba9079-020a-41cf-9cf3-b31f617cc1ea@oss.nxp.com>
Date: Tue, 24 Mar 2026 10:47:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Rework device probing
To: dev@dpdk.org
References: <20260323105306.1531689-1-david.marchand@redhat.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260323105306.1531689-1-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To PA1PR04MB10770.eurprd04.prod.outlook.com
 (2603:10a6:102:492::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB10770:EE_|DBBPR04MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9a1002-ffdd-433b-ce2f-08de89649d70
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ukTMmh9QQzVSWrNPQgjjv2bxBMZIgA60ynm9b5S03VZSqMS0ixKxOcB7MbMf6DcIa2szENYq4I9TIYl7DihNtglImBRQEzu2QouNO65f3TEgMNUlgzIJDCoQzG1HWQdVvQ8NFr+rFYciy16+EsKVlJaqgmOigfwJeuBiTU5z8UWr7bgLJ4I4RPc+GP1bKdTkJLIN5NPJJx7KK5Hin3/TNOTAJUqpwxN2aHUyOhFc58HWkQA95X54L9W9hoxxNGCrncUJfpTgRDNeH8LTRIM0R2J32kO/jCgQEl6nIpNsuySiLV2zCBTXozNAgcjqx4+krxXRBwdY/p0XIakBfvHiHMyfivBhJHareKAHFTq9TVSV1slFdVqTZsKNNyHJ1OneU8hGNul2GlOLAqZtYKbHLTlhVlcU+aVlUfG9mn9ArSGmNZyZEuzTEWf6+4lw3zFhgPl2v5YxZmpBR+84trMFiGhiZ8YTqUGoVlg6ny8XFGwewrzNAzhTGWBtRUi/C6YYlt5EqnUbUiw+S1xvifyOTPHqAfIuik04Yn+Evb3O2KdXmaVCNFoGkmjbWN4eNjuqowUDWspcF9WBxa8hLizvO8QX0mPiAcu3akdmQODON32PKTQ8Ic9eSk4Rw0766NxrX139TVDZFasVrZt2+/Y7GmvZRcpfdaSa3u6RhdlApd3fXZBAeylHkSa1JSDJdT/AQLx4j418SKY762cKOxTbnJAjsJZz5TUkt4k+7g78lWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1PR04MB10770.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdNcVBxMm5GbHgrYkFYUDRtSnBMdUdEVmg3V21xa0NqTE9DK3l0WWZMaHcz?=
 =?utf-8?B?SUNna1hGTzZKUjdheFpnL0Q0NWRia3dBMXFhdWk1WkZIRTc1UGxHODNGa2JG?=
 =?utf-8?B?Q0Z6OXhnL05acHlieEN3WThhdEdKNmhQTGttemVsMUM1bVNJTTNrb3l4bFdu?=
 =?utf-8?B?Y3diMWxvY3paZ2xxcFI2dndzTVdPY1FvT0xrdXY4TWJURTZRWElxVEkzUUdC?=
 =?utf-8?B?YlRhVk1oZkR6cnA0eFNYTUNwbWpldXM2cUZiL01aM2JJam16N2tpRzFjV1Zy?=
 =?utf-8?B?Rkh0WGRlNlAvRjZCYTRwZGtLMmNVQTFBazFRL2JpUGFPYWdzWmtxdi9yN2p6?=
 =?utf-8?B?S1FCSEVVaVNxTzRPR0xPTUZtVzhmOU5rMGYzbFFoQUdXT2FMcWYreDJMQ2Q1?=
 =?utf-8?B?YmRpeCtRWnMzdlpoa1ZCemNUckpxSndvem9HcnFBMWMrVmRiZGdJYnEyZHdQ?=
 =?utf-8?B?MUk1bDBJcXRQdFlpTUt1cyt1d0hMekszbUFBRzh0cUI5RjFDL0hvVEwrcjFY?=
 =?utf-8?B?SGdqTmZIMHZidWFJUG5IZGY0SE84QllvNDFWMFJsTzNsVy9nV3pEY3hJNExa?=
 =?utf-8?B?OXY1U1JMT1BuMG1UbHBmYzhZTzJ2bUVSSTN0YThFSDNoM0I0WWRCNFdoSm1S?=
 =?utf-8?B?Q2EvYWQ5andTTThYd1BuYW40dmJXenppUEV1NDFOT2NtYjVMWmF0ZVpYeXFs?=
 =?utf-8?B?cjEzUW56UmNXYUdIeFNSZUxtQTMxbmdqRnRuNys3R2JpODNCMDc3RHVIUURa?=
 =?utf-8?B?Y1cvcVNsUUFpKzFzQTBtcGJUeGRrQWtDVllLVVV0TTNQVjhMVCtqK1ZoTWZ3?=
 =?utf-8?B?SEd6d0pIcktrMUVGZy9hK0gyTzJ3aHRwbG1mVWVzRFdhSEVOMnczanBsSHFX?=
 =?utf-8?B?ZEVZdm5BTHE5ZGdYTEcvL1lEZTdVS3ZyMjFGVW9DWkE3SnFDWXF4WjFLbXZx?=
 =?utf-8?B?dGJZZWRTbEVzWE5yT1V6Vk9CaXJONHo2WHJpSS9ENDU0MDF3Y3pUeEZVYjQ5?=
 =?utf-8?B?WjNrNm9lR2EzYkJzREtCYUYzeG41OXoxaW5QTGljZlVZRlE4K0ZoNU9GdHlF?=
 =?utf-8?B?bjhkN1ZSTWNEQkxyZlZtYWgycnFzazB5Qi9NRWFvUUw0K1kyT2VTTDJWd3dM?=
 =?utf-8?B?cUpZQzBrNGlTWXdUaWkrbHl5WnBEbUt1MGkwdjRxVjZaUnhaTHl3MXRydkVO?=
 =?utf-8?B?V1F5ckVWRWZZZjYxY0hpck52d0t4eERQdW4rMWtlK1B4YzhWNTI3WGVHblhw?=
 =?utf-8?B?aklpUEs2bkxJNERWWlFXQ2xoVHZudDBoM0pDTUE0YnEvd2N1WmYxKy9BR1dL?=
 =?utf-8?B?NWZ6S2VJRWY4dlZKL0VZZFpkU1dFNWp1aEdsQ0Rvc29TY3d3eGp0Q1VxZ1c4?=
 =?utf-8?B?T005bDZ6UnRXWWRFb1BORWY3U1VpQ0RCQVBzbmkwUVBMVTYvR2F3Z2dmSFBL?=
 =?utf-8?B?L0NzNFVRditOaStHTndIb0ZIQ0diYlUzVko2QW1EWjJRM2ZiRUxJdnpQNGMx?=
 =?utf-8?B?TSt0TkwzVFA0OURwMjUrbnBxUEJpSUJMQXNaOTJ1T0JUbmFFREY4KzJiRlFh?=
 =?utf-8?B?ZTdqVXA0WU5nRklnYTRpZlRQbld4SUZteU9Ya2NCeUR6U0hSTTFwbzRDMklQ?=
 =?utf-8?B?RWNwaWN3Nk55YTllUUd3ZDZGc3ZGb0VLSS9CTFVjOS95elZtYWZmaVRNTGxN?=
 =?utf-8?B?OElCZm9pSlhKY2VGMXhWaWZOVzFTSEZvRG5ITTVoUWRBRVE4bDJJMUVIc2FF?=
 =?utf-8?B?UGszV2R0aEFnZXVDTGx0Njc0THllTzZ6RmZNaHdlV05OMTBwMmFrZ3JPbXdL?=
 =?utf-8?B?RmV5OTFzNFFuSkIwZTZ3eXhhMkpxeGRhS3krS0ZUNkw1SWUzR1BZMzkwdTVP?=
 =?utf-8?B?OERlcDBsc0Ftdm5rNFVqUkY5RmxGNktuRHN5L2FubVdPNm9vNTRaSGVJSjBF?=
 =?utf-8?B?UWtEN0U3ZlhRVFBFbmZUa2F5WE9hSkVocXF3eTNOcVdIUFErSVhkSVhUQ1NV?=
 =?utf-8?B?Qmk1b2doc3pLY05DZVZrdU1lSVdkclorZFFBaDNiSVp4NExEMWt1eU9uUHds?=
 =?utf-8?B?WjFscG01bEt2aE9HSmV6ejhpL0hGTkpHWkJpSHVKbUFqTElma0szNEplYStI?=
 =?utf-8?B?RzFsdnpEWkVwUFNOWXowYUg5SEwrTjlvdGNuOXRXQm1yMlpiWlV6dlo3bzlX?=
 =?utf-8?B?RVJURjdhU2RkR2N5ejFWenY1M2lLRERTdUtJYnRDanZoQ3Q1Q2ZwR2xiay9S?=
 =?utf-8?B?ak1vZXo5eFpCM2NoeHk1OFZ3TDVvVW9Tb20yYUE0TGwxMlVQOU95ak0wS2Qz?=
 =?utf-8?B?SC9XeDhjWTh3K3Y3cUJ5WmZxUzZCbFVBWDVIaXBiMlFiQ1JaUFpPQmhUdzNW?=
 =?utf-8?Q?3L06fVuZJwhPyRGc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9a1002-ffdd-433b-ce2f-08de89649d70
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB10770.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 05:17:16.7178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r20Fcb/egSAvT9whIjMwOvFyB85PT75LOjtUfS6ZWmS2wn56vQ5rnhpzOpGAylXSxzqD+0STL1th+XMTVNRhfg==
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


On 23-03-2026 16:22, David Marchand wrote:
> Applications relying on device hotplug don't work well with the default
> probing of all available resources.
> This series proposes to change this behavior via a new EAL option.
>

Series-

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

