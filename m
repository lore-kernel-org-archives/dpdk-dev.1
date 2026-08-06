Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1899C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 06:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C932D402D3;
	Thu,  6 Aug 2026 08:12:55 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
 by mails.dpdk.org (Postfix) with ESMTP id A732F4027E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 08:12:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNUDYqunATHlyxdedWma+dlswvubEflTnKFTM8WsV+epXOpDgyk8gqBrymDiSkZsRgAgKXChC8v1CS99FI3snAwCoHGzOsXbzNaUUObWiKXsploB0F77vGBA4v4P15dF3TTspmqrSKwkJvVbFV8EpbvbqPvEXIJnKictsVVED1Zdne1ZIsIbcSSWQJxpcGW9BwwDmdfTXWUf/mwpsWl+JoVSSpsankt8T218CMEfmECIfOOINArSCOBjb8+Dh1MDt2+JQJCZIXlDowoSd5+Wu4Q7zzLLmIU7S56GM+uobMOQxBofLo8/MQeyiZmHdsPV8UDHWTb5SgETjF2uAcVFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvkKSxucLNIu8tNX35E5luidElOVchWnQWv1x5cfuds=;
 b=wz38uUXLsN5wxKzM6bYJ9znmTPxmY5VhZRsWqrzzLwmKBws5LZJWXgy9hMzr7tqg9LNYLHleiGbkoir8bQccKuOjHZstcbzjCP9NqkFk6SWbC/JeUPiW+nu+W+UT1ZoUeXd6bwQhLJeHA1swuTaMy8S9FwXZDuWofyGmgnEwvULvQraTzNZhoPlsQF65skOG+4uaoxWTwRuNWXcrr/T5iYTvx8zC4aTOTozMXjEEQ+gXrqk+qu4MRTqNpcMQ2KhKdeOQacSYm3245LxcKQLUmmkSvsDCHVCW8vd9iU1wpJ0q1cYWFpfzZVvxcg8CHj/757o/yVC24bBYaNi7zPRmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvkKSxucLNIu8tNX35E5luidElOVchWnQWv1x5cfuds=;
 b=hQOE8qaCoZ4bqh9DFwZxny2I9E4ikGn98jBbW5OVzaQ2QOoUKIaSPpA47G6YLJ6b7bUx+g0x3KGbpAkDhXUjO7I57froKaftJLm5R1RH+b7ZNwxjoqrSp7Ho6bbtGfn6dCl+PW95+a0wJqDqqrh5IfS1St4WNbsy6y/t7owDXhE9lCDGXbTU6bGJd0nPD89bQangEn8r3g3ECX7D8SqkiLJJNDVNJpyqAUPnPoiWzENTvn3HwBPA1AAEGwMQD9AdR4xlosdNTR1Wyf7s1WOA/EVrmDXnDhm2c4Ry+bzuAvSGAgw2Hpsls8AZWfHUgGPUN5xZEjCmk6ojSRceLbjRVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM7PR04MB7110.eurprd04.prod.outlook.com
 (2603:10a6:20b:119::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 06:12:53 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 06:12:53 +0000
Message-ID: <4ed85706-e025-4db3-b4b3-bb3fc72af7a3@oss.nxp.com>
Date: Thu, 6 Aug 2026 11:42:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/23] crypto/dpaa_sec: include UDP header
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-10-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260806051004.166778-10-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: eae837d9-782b-46bd-2df3-08def381bfcd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|1800799024|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vlDQsfp4DM3F9MB6gOujfDKfSIDmAGpfMz+LjHf+JoXR1OSR990TR83mwX02Wgh+bdO77mW4HP+OxTXv2IVX4bQiRg8mrOnA6bTBkRA2MMiVdmKC2QOO2TK82cHTn7GezB1kmQiB/teuANhHDtCyA8nHxLaycAzccZhxdXaOzcQyV94gOfeVD6AzBTi36O9yaoFa92ehp2pfb49CzOVZJNezCA2INw2hQnkCJL4+B/WD0r+Sq2kcztmIYto+JNKvZygb8j5Vl3v4pWoCErN3OVBeLwwv36DsTd4fe2RJr67nDmlEBzjAZIUHIsztQY+HMvysrpx8jnZEwv3JmmSpTsS5mW6uMxX9ZwMuMnT5/YZOSnwGFTnVUS6YdLuV+Pje0wcFeQouclWka9A1s4Tl5085V4mW7XgqDxZuQPSD5T6RxhxBv68qYFaBilG+Leqi0cbHqXtZCmQOzS/CtybkmQIGAFuAd413aY6buz84uzLoizlifR5v7YH+ftWRSNLzvaHlfwvDHzyOlXYdz1yLmINB9DWwO0VVGUgCeFey+SdqdVCUlPlGet2ZlC1G+9Lsy658pENIbh1CqraQ+wsw8pczKqm5bSEE0aycqxqypaxRd9l59CssISTVB2lTa9jr51mi266I/+ciKDU8eSxLAj7WOBxyOg9aXUd+MN91y4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG5iaGJrVENLenpaZENvczB1UEFaWDRWdGkxdnZXSXZOd29sWkpLdCtJODN0?=
 =?utf-8?B?eVF4cktPK2hDbUNlSXFsM3ZiTG9GMEw0dmlteStjWkdKYnJ2V2E0M09KbVYy?=
 =?utf-8?B?cTJneEp0alVoWThqSlJiNllTL21reFJ5Y04wMU5tN2syZTNWVjZqQ0UrcmtN?=
 =?utf-8?B?WXk1bTUyN2pQT1k5cUN2NG1Zb1dIK3dEM3kySWNpbUhxRjNIU1d3OGhra1Nz?=
 =?utf-8?B?NkZUUUpOLzVyc0t1Q0pKWUhxUlZ6NUg1andJb0ZOMU1IVDRmcDZJRlB3OUov?=
 =?utf-8?B?ZUhaRVlTYk9pNGRpWDhvS2hFL1Y2SGg0VzNJaFprLzIzSEpUUGdRcG5OS2pJ?=
 =?utf-8?B?YkcyaGlwRnh6SkRFaEh2dHFYWk5XMXBESGc2aWp3S0tvemdOeG1qYnJVSlg1?=
 =?utf-8?B?YlRaSTViWVY1U08zY0FvREdpendPMnZyVXFSRUwvbzltV1creDlpY2x5SnA1?=
 =?utf-8?B?bWtTQmdrd2FMYkNmcTFqdUJuNm9kWkxsNG1WbmhzVG5RelQrYVl1d2tEUzR2?=
 =?utf-8?B?ajEra0ZUSDFPeUxqR3VmclkrWWdXQzhvSXJ1VkcrdmYxeFMwZkdOUTlIQXR0?=
 =?utf-8?B?NFpyNUJXQmxrWGhyTSs2R0tnYlBhWW14RVhUZXZrMy9HRXU4RVBzZVgrQWhV?=
 =?utf-8?B?MGJiUTZ2UEtJNlZHTEFkN1NQcEtEaklyOHJySWZ1U2kwUnhMTEVKT1BRWVJk?=
 =?utf-8?B?WkthS2pVZ0RVeFhYcFJKM0FEVjdWZVNKQWpwd0oyZUNYb3NJc3RkWm1TM1I0?=
 =?utf-8?B?MjdVY3hLYmhkbGJGSTFxdnpxdHZvVlZVbWVqSlBYaUJPV0RQNWdLRk5xbjU5?=
 =?utf-8?B?amxlS0FlQjBaU1ljeDhhb0dKRzZHa0VKZ2FoTkMzRGM3NGs5OHFiWjZheVNh?=
 =?utf-8?B?TEwrZmxOSm15OHJDRk9xd3dKWUhkR2RUcW15SEhwREx6c0U3TFRra1FrYUgz?=
 =?utf-8?B?YjZ4TjU5Ykp6WjVCUnQza0FhYnM0YVZQMldzZ2NLVFFmeS8vemU4UHhYOFpo?=
 =?utf-8?B?MFl3aTlNUGRCMTdPRlN1OVR0dmFhSS9tTHBVR1F0aFEzZDByOFhva0xORkdH?=
 =?utf-8?B?d3NIUVJWTEI5LzIyTGJCamFhZ3NIdUxSSFRBd2xhNVVGblFKUm9QNm1mOGtO?=
 =?utf-8?B?TFBNQWFxMit2Ni9WL2JibzZ3SnUrQWZEN3pWS3BQemJqYTZnaXcra0I3QzJG?=
 =?utf-8?B?TnVKK2M3QXRrdk9nbktJRy9EZjRkRlgvdVZxOUE3WHlVcUNJaStRUy9UQXV2?=
 =?utf-8?B?TGhQVW9hY2RlVUxzcWFqL1F4cWRLd09kMlluNzk1dkFsSXpHMFZxVllBU2Rp?=
 =?utf-8?B?UTJUQ3RKM2Q5b2NJb1daU25BT3ppS2RVd1dOdjhZYVE1ZjdGL0hjQi9KOXVj?=
 =?utf-8?B?NVYzcFhrclBKMExmWGV1QmRsQ2VBaE9LUUZra3RndUJYbXFJSTAwK25VcStX?=
 =?utf-8?B?S0lXbkd3eWs2RVdlY0NsK1k0Rm1WMFJTNlBaREc3SnBjUmpxTHh1VjNmZGRU?=
 =?utf-8?B?Z0RjZHRVbkh6ZTBxQ3NEZDBOM2p6MWVMQ2lpMncvMC96NUlTbm5SbjNDcGha?=
 =?utf-8?B?aHgwZlV4VVFoc2dkcWxUK1lMQzdJR0dmVWplUXA3K3djQjBscE9rc0dpWFE4?=
 =?utf-8?B?U2cvSCtWUW13RzlrVzJLUkpBUmc1dThYTjV0VHJjbWRBT3ZaNGYxQ3Ayc2ZF?=
 =?utf-8?B?Y3BhcTA0MkwzNVM0L2NvdVA1dnR0ZG50TG1laExGTWpKZUZGbmdTRzhmbGtL?=
 =?utf-8?B?S0hxR1VmMFRHYnp6cHJJUlYzeUhROXlxZHd6VmtibEgzMFB1N1E2Zi9sbnBD?=
 =?utf-8?B?R0VmUUdGOG8yUnpVcHhNeWovWm9MbEFtZTRjYXVCcTdmZjFtbnVVbmhTK0dX?=
 =?utf-8?B?cTVxMGV3Rkt0bTRvNWhMckpLTVpoQ0NpMllBa3cvWC9HWXlMNFh4czZyZGhY?=
 =?utf-8?B?WVZNQmF1TUdWUGtKaWd0azVJUnY4eUhsa3ZKa1cranFJUGg1aXFUY0hoMG5o?=
 =?utf-8?B?NTVwbU1jb1ExU2E4Rzkvd2hsU1NhWFNpN1VnUmhpeEVlN0ZHTzRGUWQ3SXNT?=
 =?utf-8?B?bzR4bEQ5VExnN0lYaHk1QVNhOGNiMkZpWHNOakloR205QS9mSHF0cXZoeUdv?=
 =?utf-8?B?azArTTN1V3Z5SzFubFdIc3F3RitKMDVsbHFHYzVNOW5KM29CZWE1T2NzdkdP?=
 =?utf-8?B?MjFHbUl3WDZ6ZkZxUUR2eXE4RDljYmMxeGlleWlXcDI3c1ZhR0M0eEhOdzVa?=
 =?utf-8?B?N3BHQjVmK3hoU1c2S0xNQkhaK2lHUjZzM0NMdUJHaTIycGNsc0tWMjlIR1NS?=
 =?utf-8?B?L0srZTh6QnU5L0ZOSWF2V1FVVUJsRnowYWMyWE16d2NIeHlSbUFBV3hYdDFS?=
 =?utf-8?Q?41yOZLGDEGET8kA8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae837d9-782b-46bd-2df3-08def381bfcd
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:12:53.0268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqP9kyiteyLd2kW8t51b4lPh3UO3Ajfb9uxHZz1Z/fcCHkrUdKGCGg8McQzyboDCgOrM2RDrX7pzCqr1AV5m6Q==
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


On 06-08-2026 10:39, Stephen Hemminger wrote:
> The driver was getting the UDP header definition indirectly via
> rte_ethdev.h. That will change, so include the header directly.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
>   drivers/crypto/dpaa_sec/dpaa_sec.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.h b/drivers/crypto/dpaa_sec/dpaa_sec.h
> index d78cad818a..bce60d9cb8 100644
> --- a/drivers/crypto/dpaa_sec/dpaa_sec.h
> +++ b/drivers/crypto/dpaa_sec/dpaa_sec.h
> @@ -7,6 +7,8 @@
>   #ifndef _DPAA_SEC_H_
>   #define _DPAA_SEC_H_
>   
> +#include <rte_udp.h>
> +
>   #define CRYPTODEV_NAME_DPAA_SEC_PMD	crypto_dpaa_sec
>   /**< NXP DPAA - SEC PMD device name */
>   
