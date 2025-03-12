Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49EBC282EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 02:33:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81D4E40265;
	Wed, 12 Mar 2025 03:33:00 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11013022.outbound.protection.outlook.com [52.101.67.22])
 by mails.dpdk.org (Postfix) with ESMTP id 4FD3540264
 for <dev@dpdk.org>; Wed, 12 Mar 2025 03:32:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vki9Kfcq64YUoi3MiMo7tM4Rsf4bpSwAniAiX7gildsxCHfjiO6aP/ZC43g9XR7dDHjUBZ6KWcrCbmoYQLRvPLFNmaSn4H0OWgOSsbWo9SXW/mETgbsXN5yJX7kL1AamtIqMlgmvap9Dwn700rQfkaI/WA+T3aj68OdFahud9y4uy/CDi/KRW+DUTo/0bgvWKK/okhk+weryQsHVY23jJ2fq4B1N+Ih8C58+UbzIKmJz+G4WyWQ3QN0teD284J6CgaIRRdQJUC0R3MNSueFC8roUSGbd100fRPle01Hup2grme1bKFLpM7Gaep4NIBxrHnl9lk2ztIROvX9LVBdsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62v1l2MXtc58eIYfruW/0MFNmQNBRLV6mEnV3L7yIbM=;
 b=WOwnlfbcKEPayrTuWCPBm69JiVhrOfFC0y9Vko29gCwn+CcG5VC1X4DgY/ToafpKkfjp0AkWShpKZ1AcWZrusl/+KD2Ye/Q9eW/SYuB9W440x4HaLU7sRFulQqdaDss9COShEO/WdmfA7cH6BEPqUnJ8uLG+Rm+PU7ugyD8Y4Mq5sZf6h56R6/b8L9uGUINcbbYMvajBnJ+S0wdBdLrKPVaYH5F6/OeTnurnw2pn5O4eOj2EiQmJ6rWs11NIySDFdTGWweN4Js+YG1Sj2yF2h/FW8JWaoCJ9ogVaXICOZ1fqTBMIW8d9y8VpexWQzCXTbFUOC6uaVT/BrGtA4Md5ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62v1l2MXtc58eIYfruW/0MFNmQNBRLV6mEnV3L7yIbM=;
 b=Iw7q/+i3LhTNpv+llOUxYtXUPkV3WksLjIygt/G0WByETezQX5jCpRIS4UZi5cHyEGZZmT5EnpRMu2A+iHZi9a/t8vrU41dWOufy7nT5M4DkudhiOlzntCZxI+sqApLaTb6gBzD6DODMcCofYq2DDf2cHmEOLaAfQK3PCzcczz00Tim3REO5IrO7Npi1s+tIuxHO6gBVg6a3igq4fjFHAm34cieIZeOMzljYz4bwMJ0xHSx4EBRt1Db7Hle2wVJUc7n0XJzzVhns7dPh1Lsxtl1P/ZtsqRvynKRvgiXEu+uy6Hl6Su75sB+qoLdaCU4byTymZNgvjDF9GgZTkRgNFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AM9PR07MB7761.eurprd07.prod.outlook.com (2603:10a6:20b:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:32:58 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:32:58 +0000
Message-ID: <b415f31f-2816-4689-9294-fd385880ba9c@nokia-sbell.com>
Date: Wed, 12 Mar 2025 10:32:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 2/2] net/mlx5: improve log file path
To: Stephen Hemminger <stephen@networkplumber.org>,
 Bing Zhao <bingz@nvidia.com>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20241213092444.2987-2-ming.1.yang@nokia-sbell.com>
 <SN7PR12MB69096FB0FD4930E9CE8A8F80D0C82@SN7PR12MB6909.namprd12.prod.outlook.com>
 <20250310075948.56109517@hermes.local>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250310075948.56109517@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|AM9PR07MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: d980f573-9285-4560-4089-08dd610e3367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXBCT2dtbENUNUYzT3VCcUpJdzVvaXl1WW82bVpyMzVlZHc3c242aE1LSXpz?=
 =?utf-8?B?YUorN2lGdUFkK25Eend1dnV6Y0U0cFEvcGhUeDRxYkVJOFlxN3VuUVptUHBZ?=
 =?utf-8?B?cWtzc1JPZXduRUhraHlpWnU0T1NpaGllUU4xZGlLTTF2Yk1Zd1c5MDRtZERT?=
 =?utf-8?B?b1hic0syQlJPTHJxU2xXUnV3M08vWDcrTnZjcTI2V1A3VzJBQ2RRM05VQ2NM?=
 =?utf-8?B?VTl3NG1OZjViZlZDRjZMS3pLa3grQ213YWZTTmhTemZBYkZxa2UvZzNoTnJR?=
 =?utf-8?B?RktBOW9kMEhkWjZBWEljUEc1MVNLTUhxSG93TnNEYi84RnROakh1aVZPNENi?=
 =?utf-8?B?SnhaQzFaOFRIK1R4MFoxdTZyQ2RyV1UxVFJpM3IvSG5LMnNaSFp1T2E5V1RI?=
 =?utf-8?B?bVVNQ3JreE1VOGMwZFRPbXBiL0tnUEZ1ZkdDQzlPV0dnM0hwYUdiMXdYMXpX?=
 =?utf-8?B?aVZBaEc1c2NPMG93VlRwQStjd3pvQTh3aUtMa1JQd2F5ZkkzSWtQSzJWYUNP?=
 =?utf-8?B?dWorazFoUXpia0Nma0hsV2dPdXFhRll2dUtJMVJkaXI4SzBpUlJjRGpQYVBl?=
 =?utf-8?B?dEczNitZd1IraDhSWGRXbWRUT1pScmtFb3lXRCtoMkc5SmdqUkFjNlFBQ2Vk?=
 =?utf-8?B?Q3B3empuOGVoQUFIQzM3Nkh4RTMrby9ERHM2dHFCSkFqaENKeGhJVUwvTk0w?=
 =?utf-8?B?Q0lVTkJhZnBMVUd3YnArVzVlMnBKb3pJVWE2VkRlcDFVZno2bkpJWlBnRTc2?=
 =?utf-8?B?cTh1UDFVZG10NmRRY0x2Q1hiNFh2TnVtTzZzODdnc2ErSTdXenJWTVI1OTY2?=
 =?utf-8?B?V1JKV2o3TVU4VzNzM3lFN2x0UVpBdHVMeEJJY2pwOFBpZ3ltbkVIMHB5ZW1Y?=
 =?utf-8?B?bWdjQlBrSi9qVEZUVjZ4Z0FSZ2J1R0Vmc0FRUHVXZC8rN3dHREhiZWMwZzlt?=
 =?utf-8?B?TEQwYWtCcmkwMWVDTm1QTkUraCtUMks3NitPaitKREJFUzRtQ3dIMVY2cS90?=
 =?utf-8?B?VThJOE51ZmVvS0RpUGdEbk9UVGFSb1pxaExJT2lqSnIrNkdXMmhPT2o0Mjkv?=
 =?utf-8?B?RzQ1SFp5Rmt0cFdXU29jR2lGNGNocmNZcG1BUSsyM3gwbHFhbzl5WFRFNGdC?=
 =?utf-8?B?Z2x1RTlQL2NSdnlrK0ZzRHhyejdvQWJiWGN2Z0pzcVFnWlUrWEZFVzBtMU1M?=
 =?utf-8?B?NXdQcnVjVmVQZGMvdHNFa05GQVJWYlRkNkhhRjkveE40OGVVSll2UWQ0cmRl?=
 =?utf-8?B?OUdrUFRhMnJEY0ZtYWFBNkQxblJLcnRqT2xwZzBta2t1OFVIQm9KNkNTUUhK?=
 =?utf-8?B?SHFseklMOGhwKzE1NjVlU0VNeW9MK1hjbG9LZVJRbm5JeUFkbDBNQ3l2bUNT?=
 =?utf-8?B?VVhhaUdvbzdKMFlHWnNFdlc2YTNpRE1nTU9tOXlVSjRYMjRuRzFpd2dKVlkr?=
 =?utf-8?B?eFcrNExmRlZMQXY2YTczdTZLeXNTajkvdDNQeExuZnRFT0FZa0JoOUVST2ha?=
 =?utf-8?B?TGZPSnBqejZETVhxbmNsS1g4VVByb1Naekl1RzZURnRpMm5lOVV0TVYrZmJ1?=
 =?utf-8?B?OTd6dVBLS0VETFZYU3R2d25sMjRuWEpaRDdrUTVvcU5WNkVCYWdkczhyLzB3?=
 =?utf-8?B?QUVZdjRZbG1KeE9hcUxtL2NDR0NySDN2SHh5VjhINGxnNXQ0VU50SjZZQ05O?=
 =?utf-8?B?aENhL0tyVXp5eTlEMUxtQ05JQy9kV050Nk5hc3E3a2dRTEJSOUtxQnNiUmpl?=
 =?utf-8?B?bk5YN0FYUEJiRytLZFRkVG5UMnJrbXZBcTViOWNsZkpNQ0VNWVlmemlIR3Vm?=
 =?utf-8?B?MU1MWHZhT2dGODNyd0lTdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVSUW1WVi9EL3RPNE5XakNTTnd4UmNja0UyUThiRkl0Rlp2R0F0UkxrS0Fx?=
 =?utf-8?B?QkdwRVlPZ3NDMVhKMEhkNkpRUnNSV1BmeEI5TjNxZEV3TGRzeGovSjNDeXJY?=
 =?utf-8?B?MU5aVFp0eDMxS1NwSnZUOU1JQTBKOHdZN3EvUlErNENONjhvYU5pbVNqRW4v?=
 =?utf-8?B?SGVPRURMa1NBeFptS3l2eUt1eDk2dTdENWFlVXQvVUdIbWNRWFVvRUVGbHcx?=
 =?utf-8?B?Vm1BTWlKSzFHYURZSFhRR3drK1dBWjR3WTdMRVhsYi9ibnFJcENjMVBINlIx?=
 =?utf-8?B?OUsrWWtCMDV4K2FkcWdVNExVS0lJUFBaL2N1S0lmM1hmMi93V2gwTGkzRUJ6?=
 =?utf-8?B?dEdjSHhOVlM0QXFBeEZ0SjYvMm5PdFh0c0o3YytQaVhPSjdKcFdUZDlZWHlr?=
 =?utf-8?B?b2hLaDB1bU51RTdGR2hjRXkxV3QrME1LQVVIWVFCZWVBcFdhbThDTktwcE9x?=
 =?utf-8?B?VG55TVEzWk5vSWsxdFM3eHFPL2hFdTF0R3dLU0lrSnZ1NmU4MG5ZS0lxUHly?=
 =?utf-8?B?M3cvdDVvemVtd1BqdXFrTUxCQWdGWjdOc0FNKzUvYjRtWG1BWmpwbXZEOWtn?=
 =?utf-8?B?ZWJOZmpnR3ArSklUSFpOM2lBdjZrN0FMZmFna1plbTlwUkNKdmZRRnBUVjRG?=
 =?utf-8?B?b05uSWhyVWdNR2VHaFg1bmtvUUFDZi9VbUYzRVd6RG1iS3QvczNweE5Eb0Np?=
 =?utf-8?B?MG1BdXVYMHZySmYwWVZwQ1lUN0pXRFJKZEdGUGllQjJwVzdLYlRDb2xRR0FK?=
 =?utf-8?B?SXA4bXprTnhKMzF2eHlYVE5ONC9wNWF3aDFZbmRQVnc5OG01dUJnRUJnZUdl?=
 =?utf-8?B?VmVHL2tQY2srbCtCTVdaM0pOSTZTU2V3b2N0dWJZWjJJMDA1NjNKeGh2am5X?=
 =?utf-8?B?TlhIYm9xalpLRkJudnBRWU5VSmxZMk42TEc1eVArU0JDcHZ3QWRjejdDQmhQ?=
 =?utf-8?B?QlZscEF3UUw2NDdKOEdWbmlob2ZCeFVnQ3MvUXdXc09UaE1QNUVkamlsUllS?=
 =?utf-8?B?ZitzeG1QTlJmMzQ1MVI1YnA2Tzd6dVZNQmhwN2RTaUN5QjBIMjc1b1RwR0Zx?=
 =?utf-8?B?OXNNS2kzUVBnalZmaFhTRE5kQ2VPM0ZuSTU3UEt2d1pnYzBGVXlwemNpVHdk?=
 =?utf-8?B?alF5eDVJVThJSDhqSDdsVzJZdDNLUDFqVCthUGxzcjhFOGdOc0NWQUp6WGVo?=
 =?utf-8?B?WWNYTkNpYTUvMUZkOGljNmVRL09ENER6Mkd4Z3hLQXBaYkcxUGVFZVpHcWhn?=
 =?utf-8?B?RXM4VHNodThzamh2d3BGeW9iTXMyYVBoL2YrK2xXYngyOTNBblQ4cFdNQ0Ji?=
 =?utf-8?B?Z3ZWemZtaUFMMVRsNGhXaWRBd1ViSW5JMTE4SDFKOHFXK0g1SXhJRDFWQ0hC?=
 =?utf-8?B?Zld2VHljS3pKVVIxdFEvRUN4cXJMQVA1K21UM3lUZlRVT2ZpVXJyRVlVMjdz?=
 =?utf-8?B?ekRsd21LSjlnZEdqQ1FZcUxSejFoKzVMaFdKTzJtSTZpWlBDdUdpSFNIektH?=
 =?utf-8?B?bE5kdlk4WGNhUEcrQ2lJZE5pTjVVUWRCd1NaVU9odGJWYWNZSXI4Qjd2c01H?=
 =?utf-8?B?eEhNOTVLTjA2eEhUNFM4WitHcW9FakU4bkdxTWF6Wnk1aFRlZ09LekxUUjUv?=
 =?utf-8?B?SGlPdWZ4Q0lCNXZaZHp2ZGlRS3kzU0FJenpjbVdlVm1NRHBjbjhYRm1YMmN0?=
 =?utf-8?B?Z2JCeFl5cWh0VDlrc212Y3FkUGhnMFU4Y3FDeURWak1QNjZVbTNINk91Z1Nz?=
 =?utf-8?B?U0c3NXk5QzJoNWZaem5LcnZaTUVSZlZsaGNqYW5VUW4zam54QS93SlpnT1lZ?=
 =?utf-8?B?SVJvSjM0RmVCR3QyL1E0WDlrN0hreUkyRys5d0JwdG1FMWIyMWlwTkFBV1NR?=
 =?utf-8?B?dDh3RzJQMjVMRXNWK3h6Z2FlVGppZ1c1a1NMT3FQazR2dkJrbExkTkIrTWQ5?=
 =?utf-8?B?UHp6U1RsRVlFQm5jL3pKNnUwR2RwMUlwUmVIL2w2ZmliQjltbm5ObVk2VE0z?=
 =?utf-8?B?blFzZCtaUy9SZWtSbVExWGN5ZndVYk8xcjZNODNrMFAxV2MyNi9taWkrNzd0?=
 =?utf-8?B?MVNPR3BkWGcrVTdJQmZub2YyNklyV1N3NGlqM3lYT2N5TTBuZ25NVVUveHg4?=
 =?utf-8?B?VkpWSEgva1pqMkx6NHI3czZrWmJHTURENVNlSHQ4RlRpeE0zSklSV0dhQ0g3?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d980f573-9285-4560-4089-08dd610e3367
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:32:57.9551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2MLM1Q/ZOY0qCfgO3522hiv9DrGh26+qAd8euXx1D/xuDR2tHVqQoqL3hRLinmig+F6wbax4alDDGEtZjCN3bgHrIWUkKnP4Cr7Kxs/SJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7761
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


On 2025/3/10 22:59, Stephen Hemminger wrote:
> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>
> On Tue, 4 Mar 2025 06:23:06 +0000
> Bing Zhao <bingz@nvidia.com> wrote:
>
>> Hi Ming,
>>
>>> -----Original Message-----
>>> From: Yang Ming <ming.1.yang@nokia-sbell.com>
>>> Sent: Friday, December 13, 2024 5:25 PM
>>> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
>>> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
>>> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
>>> <matan@nvidia.com>
>>> Cc: dev@dpdk.org; Yang Ming <ming.1.yang@nokia-sbell.com>
>>> Subject: [PATCH 2/2] net/mlx5: improve log file path
>>>
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 1. /var/log is hard code which is not a good coding style.
>>> 2. /var/log may be not allowed to be written via container's read-only
>>> mode.
>>>
>>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
>>> ---
>>>   drivers/net/mlx5/mlx5_rxtx.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
>>> index eadadcdffb..a0da73c9c3 100644
>>> --- a/drivers/net/mlx5/mlx5_rxtx.c
>>> +++ b/drivers/net/mlx5/mlx5_rxtx.c
>>> @@ -12,6 +12,7 @@
>>>   #include <rte_prefetch.h>
>>>   #include <rte_common.h>
>>>   #include <rte_branch_prediction.h>
>>> +#include <rte_eal.h>
>>>   #include <rte_ether.h>
>>>   #include <rte_cycles.h>
>>>   #include <rte_flow.h>
>>> @@ -311,7 +312,7 @@ mlx5_set_swp_types_table(void)
>>>          }
>>>   }
>>>
>>> -#define MLX5_SYSTEM_LOG_DIR "/var/log"
>>> +#define MLX5_SYSTEM_LOG_DIR rte_eal_get_runtime_dir()
>> I agree that using the fixed PATH is not a good practice. Can you ensure that the runtime DIR is with RW+ permissions?
> Drivers doing any kind of custom logging is bad practice.
> This should be handled by EAL logging, not private fprintf's
>
>
>
Hi Stephen,

Yes, I completely agree with you. The DPDK driver should utilize EAL 
logging instead of fprintf. We have recently addressed an issue where 
DPDK was applied in a container with a read-only file system mode. In 
this mode, the /var/log directory is read-only. However, when DPDK is 
running, the directory specified by rte_eal_get_runtime_dir() must be 
configured with read-write permissions. Therefore, we have made this 
minor improvement.

Please note that we are not the developers of the Mellanox CX4/CX5 NIC, 
nor are we affiliated with the manufacturer of these NICs. As such, we 
are unable to make the improvements you described.

Brs,
Yang Ming
