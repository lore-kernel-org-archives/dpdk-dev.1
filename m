Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4391EC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 06:15:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39E9C402D3;
	Thu,  6 Aug 2026 08:15:40 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
 by mails.dpdk.org (Postfix) with ESMTP id 80FF64027E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 08:15:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSosWoCqA6nPd/h1XohXbaKqpfRoTJq66/HqxyuAghJ3T9T61tjOJyJrLmJgcqtFBtQ3dvl9u4ZqwTnwkb9RptZgcBfly4sx/zvWL1NBpzt3GCVv93KWvLG/b+g+0FzvdNr+P/Byj9C3FVz4j0oIkxHPP9rU/2QKpN6VJgZFSjrOIZcitE+iZMIi+ufRURls24+9A8AyagIeOkkcnxBcvu51huZlNUIzK0kV+uxgOvrkb+2iuCcEefbMyZZmS9HUJZ/rZTjGfZuAiF0VXPN6tXz7zOiBs3JRGMJ/oOxTPk7ipPKRE6jLEApuFQYIuFIDEU4ahopa744er2jpSZd1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYxN4vgrc67aGMSaDBHgclhXeUX4oQCRfuyGUPxz+XM=;
 b=d18cy1yBoMcJVO8K/QeIwmp/unOf+zgWSyJSb8+Vtb3dzByyzBFi40KK9/v7UXx+WCCFHh54yaOfFJMHpjGFk4y3TbvTqZwq9oIRqMTsj5NnXQOYQWN19PpbTR1/CSvJ2bdq+o9Gfot+qYAL8l84YRHBMVA0Jfc5cV2WumViX6rZGfQirnN93eRwmyTH/BtXHTNS662mVKFlDJBZQ9Q9zHItIcV6dS4/8FxqUKDAC2qRtJ2JUVR2RgPvZhkqrf1QFl9AqN7TgSs01+xa56JWMCG6n/m/Zihdl1giUvsHZXliVabJRxXHE7OfSOJtBB7jwu2+O8V5Q3RuGGmJbal+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYxN4vgrc67aGMSaDBHgclhXeUX4oQCRfuyGUPxz+XM=;
 b=K1HIiQW0HBEzZK3HWARd2H+MFKXJ5LvKKZOL33FcVtF91m53PtSsvV+NzzZKVkODJ882BCCk0ay/kWqAKd3NdbJiScrwwNEAJt7mCJP0LvSjioQHml/7/XazBISqcUqycvSJkb1PDedtLiWfnxBPAVRsLzTjA0DhBioy9jJ1OAHpqTaQC+CYQEQYYoKAQVOA/Zvtm2lfG7VVwS7aCHrjD5UmVyIHntA+CGqdTONtVPi7aBEMMwDn+WlMRE3dxQBt1A4ru8mpKuV0YlmRvgDnw/HTNrwcqq1F9gLa15CDDzeIFmaO8mng0H1vTRgkEZ9ArzEGID6eZI/WAzCpn1olew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM0PR04MB6979.eurprd04.prod.outlook.com
 (2603:10a6:208:18b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 06:15:37 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 06:15:37 +0000
Message-ID: <825834b9-f4f3-42d6-af64-cb4d020c0601@oss.nxp.com>
Date: Thu, 6 Aug 2026 11:45:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/24] bus/fslmc: replace rte_atomic32 with stdatomic
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
 <20260806032544.21337-18-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260806032544.21337-18-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:990:77::25) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AM0PR04MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b284e50-60e8-4935-e444-08def38221f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|23010399003|376014|1800799024|22082099003|4143699003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3qddfA+TB5+YrUfV8YtjWVjdMIpxoYxKPodD3In6H+nOVE/A/HWdH1evaTTyw7W71hX3vA7em6j9edPKCM7t5W3H3LXTw4hein7zE0ETE3QjnoR2tiqpgh+oZzA1DSbowc1SpvtkfPyWbpY2E3T8GF4qPoQ/TONQfc1KwjkMq10/0twr5lTbkwVXT+54cQXqw66nwPu+VqTG+0i9N/VAmC//RDUrHh/397KmRJBhqneBz91Vpre0Ri0siGMbzxMrEVe0wbjZUEiNnr75qOKuohaU6XOEanEnPINbj9SiTi1eB/hTe21jkQD0yqcR7vMXzF5BxPThtvECG37TnfNL39qgbzr3O2XzwZzx+8IVUuxHvPEfDJa4rj1MYyg7P/z7ndXQ7QjVIgl2AopozykvMxIwVobmRv6Wu3BZikCNHIF5HChhy0305waYP51H2yEzijWG3txMQWz1WlhvDJ14fbmAsXAD9SDVaypV04oJHdD3sbsN1jCai+OKfWZmOXewwtF9Eafnarf7ugoLzOwDLdmdzJvSGFAW4qOOHbt1eYeaVBn8k0TG+tZh9Q4gAG8+rnfYV295g3jckkdYQe37iJcdwum9uCLmUKAJoWFsMhmJYXh/Emf+3LWHwmMSZWpA7g1t/NW9np3TzTo1H3U6pkTxnRn+Scz3CjVL2is4hqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(1800799024)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2hsNm1aNFR4cWhSemNFM1V1ZHhyWXdIYW5vcVJVcXNOczhkS0p4ZUJJWWpF?=
 =?utf-8?B?UXNRUng0ZStyeGdhQjBZQTg1NExwWlRjbWtadEM2VnNORitUZ2dyM0FwR1dY?=
 =?utf-8?B?bExEdWh3RE0yVy92UzB2RCtmUGR5TWNaMHJNSTdyV002anVodWpobjlXZUVk?=
 =?utf-8?B?bXdqZWY0ZVZSR0s4endZdzM2YWJPKzFoYmk3WWRqQWdvRUphdlI5YXZpRUIv?=
 =?utf-8?B?NXVMZ2FaNmpadTZ1QVpqdzJWRjViT0U3RmdIN0JnSytsZERRTC80T1VhZFpv?=
 =?utf-8?B?NHROSFNsOGxGQWNsVEtlTmtOVWhkQUkza1dsR0ZaU1hoZk5YblEyeFB4Mnpo?=
 =?utf-8?B?M1Z1OG5HeWVHOU1Wc2JKZ0NsQ3hPZzZDaktmWVZWcnNaYVAwMU4yQzVYc3o1?=
 =?utf-8?B?NGNBdWkwUEZteWpJeXluelkzd1l0NzhsSXdlZ3VqUGxOQUx4Y2ZUTXdWTjFS?=
 =?utf-8?B?aG5yTTllbjhmeHZURENHbjVqNG5tRWFmWHRaVkdUYlZkcnV0VFVycmY0MlFB?=
 =?utf-8?B?OStnNk9rWk43em1DOHlGTTNzem10c1FOUVovZEN1Mmt6M3Qyc1RuNkZoMm1N?=
 =?utf-8?B?djdycENDeGE0ZUJ5eTR3clYwOFhIZlB2N3hNRXFOT1Y0VUVzamtzUHZTSnNE?=
 =?utf-8?B?WmQ3NjByUTQvbDlLNXc4Z1MvOUFTUlloWVVWK0JuVmZVN0w0cklsOVd0cVZq?=
 =?utf-8?B?dTFPLzF2NHJtNld4MU5HR1Fuc3VkR1VoVnlHNUx6Q0RmbVhMS3ZZd1hDNDAw?=
 =?utf-8?B?Z2g2aUF0M2hvZk1nK05heTNMTGU4WG1hYWk3Z0JhaEhhTzdoano5WGFrQ1Va?=
 =?utf-8?B?eGkveERKbEV1Y20wai9ra2pZTXBoSXVRZDZFQitnTXVMZzc1QjRDc1BWVWxG?=
 =?utf-8?B?cFAwei90S3BnL3ZKSzVKRDR3dVpyTHZZejFXQ2pYL3RDd04rZnNTR2R4a2Fa?=
 =?utf-8?B?enp3cWNQaDNUSDRibTZ1aFZEcHNmS0k1KzFiUUpMK1hCTERKcEhnMnRtQzVJ?=
 =?utf-8?B?TGhOUDRzcXZhekJLVmg4MERyTlYzbHFJWTJ3VEF5Mmh2dEtoSmdsUFFFTElX?=
 =?utf-8?B?RzkxYkNEZHZSQUpCcitaK0phMmV2YkhCWlNVNzJFaGQ0eWowRDk3WlpDdjNP?=
 =?utf-8?B?KzI4cU1jbWdJdFgyYmlRWEQycjFvV21FaWhvOUk5a3N5bTJ2eTBNaDJnQzFC?=
 =?utf-8?B?aHRqN2R6czhRa3M1SU5VQ2IzMHhVci9XNi9UTktHS1FKbENCRGtTTWZES3pB?=
 =?utf-8?B?UVVYV1pFVWxybVV4cG54WENaVWJiV1R2dy9LQnNqZFBNeTRoMmNTa0c5aWV2?=
 =?utf-8?B?eW00aFp6V0FLSjRTNU5YUWR0V1RVK3gvelpjTEVMeHB6MXR4bmdJYWs4L2pE?=
 =?utf-8?B?UXJTZXRWMW4zUExaNUFkdzZhSTcxWC9GbWxQcS9jNDRLWnp6aVZTV3Zzdlps?=
 =?utf-8?B?bmNoWWxMVnBLTnAwRGVZYm00VUUxMXpmTmZ2YVNkTDJkV0F1L2YybkZmak1U?=
 =?utf-8?B?MDFLKzRjZTdJM3BsQjBLbUZ2QUFxOFFsYVNZSzRuOWV6THdhb2E0dTMyZVJv?=
 =?utf-8?B?SytGekNqdC9rMnllRUo3dkd5RFBVc3gzbVZ6VXoxUmVyQzBuUWFyUXJKQ045?=
 =?utf-8?B?S1RrZVM3Z2RKeHo1bGgxajBsR29CU1JQY0Z4WGl0NWh2VjB1MDdzZmcwZ0du?=
 =?utf-8?B?QUF2VFNIOGJQN0J4VmRNNnI0cjh1N2ZnZ2RYSkxkVHJvM0gxN2ZhM3pTZ05D?=
 =?utf-8?B?TERjdW1STk5nb0dMWGFTZG5NSk9YL2hvTFFWcUxKZGtvTG9WUXFrUUVMMTBV?=
 =?utf-8?B?WTNRSm1SOFhPOXhZWUFzR2lnSmtkbDVjV2d5UkZLR3VSRDBweFN4WUh5Y1h5?=
 =?utf-8?B?S2U5TmZZdUpwYncxS3g4RXQ1ODU5cUtoQjhvL3FtZlpqSE9NYjFOUXNWUnBT?=
 =?utf-8?B?VW9uOEc5ejhNcTJWQjVSN2NCaXk0d0EvSStlTWFNRkZnVzV3eU5OQ3FralFt?=
 =?utf-8?B?a2hIczNibUZaeE1pMmE4Qm10cjBFR0VJUlMrbHRXZWx3R1pLSk4rN0RMU21h?=
 =?utf-8?B?SGFlM3pmV2RtZTI5eHo2QW81dEtkSzdmRGVBeW1GSzExei9ndmFJZmlhZkI0?=
 =?utf-8?B?YjY0TVZpbkhhRHNiWDB3Tk81RXk4VTNLaGpHN1AxS1B1UjI3TFlaWWQ1OVk0?=
 =?utf-8?B?OVlDTlFlTTRVSS81YmRHV2xJRE5MQzlmYjZXTUprRURYVG43OGNNVkl1RkNM?=
 =?utf-8?B?TjViYmVHUGVBS2ZkczdnZGc1NWRjcGlSdlJQNGkzaE1TcDUvKy9uZWRVSmVv?=
 =?utf-8?B?YmV2MDRDbFZ3MFVpRjd2NndGSkFBOTVKVE1yZHRlMnd5T2RmTjVNQ1BmWS9X?=
 =?utf-8?Q?aQjnBkQd3iSUzfmc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b284e50-60e8-4935-e444-08def38221f2
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:15:37.7692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG/3qpfz9E8bmpFbQQrSsgnOJaBP8jOsyzo11kKYt4Z3n2UZrap7eNGJDmxoM4BVdb22bDcrxklRFlNVDUEViw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979
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


On 06-08-2026 08:53, Stephen Hemminger wrote:
> The atomic wrappers here are easily converted to stdatomic.
> Drop any unused macros.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
