Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F28E9D3EB
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:04:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84A36402F2;
	Wed,  4 Feb 2026 16:04:22 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by mails.dpdk.org (Postfix) with ESMTP id 80D75402E1;
 Wed,  4 Feb 2026 16:04:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysuRw1XNYWqVP0P3/lNKGUg/aE4RMuE1DtiLsABSLv/ye9DFIkFuZMrh1qmUkmZbFziEnGDbbMhymEpmaFCauVGFooyg/EBITpnySPLTr30TuxJwfGoo8cmZn+8BNsg+9PzdKM+A7wjTV5oA6CFc6CFDzz9UMF3cQXQ4T8dUDxj/y7SFBZiS+JdQJpL4SBj+GrkosurUheK+RadRYDLM5AcXhfxanz3N7wdU420fYJjZei9XjN4ICBRD6xsZBSVN5Sv8E71tXMvBoEaBB6f6/ybGxyrVKicB9WwwSh/RN8T80eyQwQHaZMYY1qbee013li/4xcS1K0gv1N80ImdnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNhoC61h15z6JgAz7jF6904YzFFaTE1U7GykpQMCAM0=;
 b=Z6WjplsWl+hqwz4ePXxGNZl9bYQ13XvDLB3xT4o/GEMxWhywPFVnIXhHJBjcL+Vl0sO2JCZ8bxelrLDQK1gP8MUc6a+gqKbUoRQrRjU8jMZC3WT55Hps7vq/ibUCqJNLtcHvFctakViWMPkN5rAqDCgeLpZ3TWsBQzXZMEXpzHBfkr0d8ig3YB5kLqNMcIRvsiEDSzJ2dfKg2S7sQBf76NAS4vWfknHtz9ge5s4TJA1KoLUSSVE2egHHIOstjn0IJWMllT+8J7r8KGNQ84NOk2bvwbIMLERx5w8R88mwfXkWUOiwWdgr7WbXUPuWltk9LSnPbynn3ZgKhdSStGQJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNhoC61h15z6JgAz7jF6904YzFFaTE1U7GykpQMCAM0=;
 b=rTKXqeqv6idczLb0rz16c1llqV01x6fOUuLvuyRJ3OGYOCn1veYzySAdae2Q/aPN13qOBcbvtcu8wahJl/ccsoepB0JhI9xIl/L/LAes1p2jWcmRm2lFvPq3p29aJ+GmNj7OVkgA87RZn/hpTECOcXM/M8IZW4mWW9CX0zYZs1s936hwus4s1zt7fYN0OEwILJiwR/KKNP6ZdcYRhUcGSxa/N60jki5fsQFmd7jbd+TmA7/hl/wwjla7SnyeFuzoSwf0jl50OLBJ2tLlvNo//WNpjtPxOK3j16NzBqh0Y/o8brBfSjpUX+41oVNoOubc76HyaKaNn/1jmpi+h0fS/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 15:04:18 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 15:04:18 +0000
Message-ID: <5b92ed28-11e0-4daa-8f66-3bf1326d3d5e@nvidia.com>
Date: Wed, 4 Feb 2026 17:04:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix IP tunnel detection for IPIP and IPv6 ENCAP
To: Junfeng Guo <junfengg@nvidia.com>, dev@dpdk.org, stable@dpdk.org
Cc: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
References: <20251119103554.44203-1-junfengg@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251119103554.44203-1-junfengg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 453d1cf5-6ab3-4d8b-2116-08de63feab1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEpIc1N4dlZIdjhLVEhoUGVVMEVYTzlsNm90cE9BdVh3cm14bGVSbTdaR3Jv?=
 =?utf-8?B?RjNZcjJpUUxKOVVhYlNuUnJ2VXYvbzBsR2dleGQzR2MzSUlaV01janVmcGJt?=
 =?utf-8?B?bWVVbDExc3ZsOHZXUXlJeEVqbXRweTA1OGMvdXk4QmdlcmZBZVhWNFRnSWZG?=
 =?utf-8?B?WkxrUGF6a1JrSklkYjMzUWE0bng3MGdUM3RnR1V3N3FTMGJpRWExdWFVRzEv?=
 =?utf-8?B?MFB0NDRoeTlrRUpBalE4Q3M3cHpBUERMUXhoLzNZTTFoRitYMzlqeEZnSStz?=
 =?utf-8?B?MU1yUkdOWGhPTklpMUx2Yi92c1R2aFBKWHJZUTQzeUdCWU1Xd1V3ZDFQbnVS?=
 =?utf-8?B?bmFPT1hLYUxZS2ZCRU5TY01BUFQxYXp6bjk2RitBK0YzajZsVzlySW5YU0ZP?=
 =?utf-8?B?RXAzelpUUnBWUG9Ka1I2NGpaK2xUTnFCMXZLTHhPZEczUFkxSlNCbjlYVHkr?=
 =?utf-8?B?TERGZVlxYW9iL2dhR1JVQUZDcDZtTGNvZC9ybVRzU3VWT3dYMi9zSXMvazFM?=
 =?utf-8?B?UUxzVVo1cS9NRXljZ0krcHB6STJpdzZYRVZucVJMUmt2QlFEZDQ1RWd0ckRH?=
 =?utf-8?B?R0pKeWVwaVFXS2UwYmZwZStiQVVnTzhtMUtWdDFjR051ejV5WW1EaGpBaGZL?=
 =?utf-8?B?S0o2dWJoNzFoZ1d2dVRwUGllK1pYRVFzazNCckxZclhsbkllTnhKY3BTOUI4?=
 =?utf-8?B?OHJJK3NXeXkzNnppZTZKZTU2V2lQa3h0ZTMwUGpza2tnb3Mydm9vRWRPWFBC?=
 =?utf-8?B?bmlja0wxYldjemJKU0EvREN0NXc0NXVkNFRKSEtLSmtUTlJpQ2ZwWWRoL2xQ?=
 =?utf-8?B?bjhpYXYxK0RYVUczclZOWlAxUzV1YkRPTTJBMWhKV2FjOERoUXlTTmxNdnJY?=
 =?utf-8?B?K1FIOW55SVJvdERpZ3dWU2Z3TkU0ZFd6enAvNW92K0E4L1lrWmI0cG55MjJK?=
 =?utf-8?B?UEd6dXlHd0JRYXVzVSs4OThTZTRWeVNyNDdiN25lSFpzMmRQTDcvNzRiS2lF?=
 =?utf-8?B?UjNYQVFRd05pd1BIRFZyWERqQ2wwbFBDZDdjSXh2WnRwNkM3S2Mvbmt2WTkz?=
 =?utf-8?B?QURUczF6ZmhKdUZmNVhHUFJreFAvaFRZdHVQZ0VFWGRyTkJvY29KWnVaTzIx?=
 =?utf-8?B?c3N1RTU4MGd4MDdqc21sWmZDU3JnVit6WHZyRGNJZUxMNkJPTFpramZabkho?=
 =?utf-8?B?SGVSaEVRODFaWmprL0xWY0tudVRneElNUExDRTNlbHhOUythRk9xTng0WDI0?=
 =?utf-8?B?SWd2eDdsY2ZzYmJyRHpwaTIzOU1JMG5zMTNKT05lN0d0a091MGplWmpzeEJw?=
 =?utf-8?B?VHAvMXY0aks4azRid1hobGN1T0Z6QXY5TU1xT1czb211Mzl1djJtNTVlajFi?=
 =?utf-8?B?aXJEWktlK2xjekNEZlRjMDVMZG9hVU5CeU5nMXlUUkNicjY2SUZZazloL3Vw?=
 =?utf-8?B?akROaXJORVlsZFE3YTVkelhLWklwK3dRbFdxU3Y1REZ5elg5c2tOdmExODlm?=
 =?utf-8?B?YVYwUGlxR2pDUXVPYWVkM21VZ1plaWRsa3BCOHdmVkdHb1ZVM0gvakt5V0pt?=
 =?utf-8?B?MmYyQWttVjc5RGMzeHh1OUVheGwvVmlEaVJBU1paNG9reWxiTVlJM2R2eDIz?=
 =?utf-8?B?cnhQMHRmMDVERnFQQkZlbE1FSHczQk1yN1VERm01Qm42N0ZoeUl1YzVnNGJH?=
 =?utf-8?B?SG0wbEoxbGQyNWxIeTlVeXBqQ05iOXpwejhUK1E2aDI2T2NLSTc0Q0lQU2pC?=
 =?utf-8?B?RjBnZnp5WkpNWVVnbWoxTlVzSW1mZHhya2VYVXlhWFZZQjJrMDNKcS82dzA2?=
 =?utf-8?B?MUFKZlRwNEw4RlFDM3grZE5tL2FMUFM0MWVySVRIRXVEdlNkUFNsQ2NQYXhr?=
 =?utf-8?B?UlFFSEtoWUhYOWN3Q0FuckhZQ3ViZ2FLSVpvWXlZSzV4OHB1TFh4WDB3eGd5?=
 =?utf-8?B?a3B5b29tbDdhKzJSZW9MZXRGVmV6OC9nZUZXTGNVTSs5WncycTVNb0l0eUwv?=
 =?utf-8?B?VkVkU3ZrU09jV09oUmY2d1hGakQxSlZuZWVKSzhLYmZGWi9Ea2ttb0drbGtZ?=
 =?utf-8?B?M3ArdFN6Wi84T2FSVmxwNGRHNmdZbng3QUlxdWpIZU8vd25WVGFGQnBqdEZn?=
 =?utf-8?Q?7XGQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9kQzhxWUhUQnYvV2JRdEplbVltZ2ZDVGl3Y2ZsV01aS05PSVVCTDlZUGow?=
 =?utf-8?B?Y0tqVUwxMWlLNk5CZjN4RlFKL29YbTRKZ2pnQk1LOE1kc2V1SGxubmp3cElH?=
 =?utf-8?B?Z0dZUWNaa25MUFNKRmZzL000cTU0TDI0MFVkdVBid3BubUhxYUJFelVIREhD?=
 =?utf-8?B?bE1zUDFrVVVLREQzT0tmMWs1dmVwaC9zQWNKUFkrK3ZxQkM4QWJFQjI0N096?=
 =?utf-8?B?Mi80QldEbWZqMytFTWxxZVJYZnJsQnR0ZExkZ3BHUndvN2RTYXJKTjN1NjFq?=
 =?utf-8?B?bVRoajdVb1NRQVVRZFd5a3RNWUJwMGJOT3hnblJSTnpLY2VjWU9QMmdDc0ZK?=
 =?utf-8?B?V2VVOVBodnJNUERPVU5pRTIxMVR0NFhWVVo2aGg4YkpOanBRMXVGdWpRak5H?=
 =?utf-8?B?R0pwMjRjeXUxanJqOVRsRHRCQ1Fqakt1bnlNd1NPS0lJcEtSYzY4ei81cmR1?=
 =?utf-8?B?akxVZFJRQ01XbnljMy94ZXNkTGxmMVRYQUllNFRzOWZ6ZHJwOFB5aTFGWWRZ?=
 =?utf-8?B?WnpteEJPRWdNYUl5NXFnejA2d215dko4eWVmMXRwM1BvemUwNDlXUkFpb0JS?=
 =?utf-8?B?cjNDU3cwbTJCdTZBT3llNitNMnNLUlE1QmUwZEtYYXNhUUh5T2dRNm16R3RU?=
 =?utf-8?B?REo3QmRZcThWWUZqYWxtejVhVW4vZ09Ea3YzRlFZS1RwbzU3SmNKaEs5blFw?=
 =?utf-8?B?eTdLbXBnTVh6OHdYME80V2tLYUpUbG9QYlRkNkxKQ0xIQmxWdk9xWHpzblZG?=
 =?utf-8?B?Zlk4Yms1WVZubEh2NHJmejJETEVHV1RwUjN2cGZETElzWDNkTTRNRnhvWEhm?=
 =?utf-8?B?d3VvNHE5b3VpUzVnVTUxK3F3VDhmSnN6eHBkcGJhdVZURXZYdGozMkJzUXp0?=
 =?utf-8?B?d1VVeXFXZXZwWk9vR2RxajdUcDdlWnlYWG9oejFnaHI3cjlrc3A5RXBPRXhy?=
 =?utf-8?B?djZGNFkxSS9SN3RsZ1M2aXVQc3kzQytuZ05qK0tVSVRBRFMwYS9zWGkvVy9Q?=
 =?utf-8?B?WDk5anVFRXZ0eVVYcktwZGQ4UHE0eEtMYy80NzM3dnRBNGhaRm9BQ0J4YUlG?=
 =?utf-8?B?SzZPZklhTFdJM2s5Kyt1NHJYY0JIWE5IZ3JIVThhWkIxdWI3dGswT2VIc0Zq?=
 =?utf-8?B?U0s1Sk03RTk0Wk9MSHdNT09FaU9wZ0lzVzA0MkF3R3N3ZWZKN0tzSzdxMDZz?=
 =?utf-8?B?RURkN1hva2tvNUR2YWVHcW52MTE3TWJ5S3dWS0pyMkhPamxlSkVpMzErYUxV?=
 =?utf-8?B?MG1KeENVWmNYbzhhK2xNaTJHUU5vNWRSQkRNek5sdDdLN2dqWWJrMzdrTTJt?=
 =?utf-8?B?WTZDdUZFRGdtbU5BVlhqeVRYNlY2ZTRHMjNkZHlETW94RFdJaWxpTktpTXBs?=
 =?utf-8?B?OTVyM2F4bVpLM3lVbDJiTVJUYzBNSG5FZE1VajR4YVNwMEQzREhpV1RKdity?=
 =?utf-8?B?S2kyWmhXQTNFY1pubVptK2JCK1RoMUhyeVQ1NkhlRVVzZkk2aGRaYzFWMTM3?=
 =?utf-8?B?QWQ3RmJTc1FwVlNpcXhFeGM1ZXlOSkN6ajRKNWtBQncrZjAzd0FNV1pjZHd6?=
 =?utf-8?B?OEFvVzN2ckVYSERqb3l1SWFuMEZNd0RwUjZ6Nk9PVFAzdDUyUk1maHFabTFk?=
 =?utf-8?B?R2M1OGRRRWVTZ1JkN3Rqem5uMmtZbkhGaW5pUFdZQTFER3BzeWphUFc5Vmhp?=
 =?utf-8?B?MHlRKzByd1BaRVU2bUZnN2xHekxsK3pDVHU3NmVhZHRNNWhYMmIxeTBsTTBn?=
 =?utf-8?B?MDdYaDFpUEdsNEkxdmpxZnppZnJHK2c4T21GQlUwS2NaMXN2bVBiN0h2S1lw?=
 =?utf-8?B?cW1mUUp4YlRZdTJqZi9saHptMFJJTTU0QUhvSGhrZzJ6elhhS2kwc3g0L2d3?=
 =?utf-8?B?SmEzRzRYQmlEVTJlbmlaSnNybXdOMmtTQzdtTE5EaXh0ek1oWHc4YTd0cWNl?=
 =?utf-8?B?azVLeHdQWU1oajQraFE0czRoVXFIUy9RYVVqNEhYTmJ1Y3NOcTRmbzJhVEND?=
 =?utf-8?B?ckk3TlcydHB0cDM4Y3JHOGIzdjVVYWFzSm1tTHlwT1drZVFoOW55ZG1BR0to?=
 =?utf-8?B?eFB4dEF4R2VyM1MrbWIyajFkTDZhbmZLL1NvRjJiN2JCNXM2RFlsdnNTSm5a?=
 =?utf-8?B?czZsTGhqOGdkcGY0ZUMwanhiQ01EVVRMOG9RMHBaZzU3Q3BJenBuNW8yMWVt?=
 =?utf-8?B?NmUvazlyVDZweFdLbHNicTBnMmxTbUlVYzZkSTcyVU1uMGxWM2FPdklIWDdX?=
 =?utf-8?B?OVhXOXNUL2xLWWxyLzExWVU5UVM4Tzl0Q1JOOHR3ODlNN1NFOXBkbC9CS1ZO?=
 =?utf-8?B?NU5nRjNxRlBuY1RSakc1YTV6d0ZTRnM2Y0Z2Z0RhdWpSMVExbXZIdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453d1cf5-6ab3-4d8b-2116-08de63feab1f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:04:18.1137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZL8EjVkcUXYNSDigMtztSEQ2b4k1ZFJF3pYsHcIEcf/8nDWO7Y9jwxJF6WgRgKILWtgauy7f9KtEijeYTN3/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
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

Hi,


On 19/11/2025 12:35 PM, Junfeng Guo wrote:
> The HWS (Hardware Steering) IP tunnel detection implementation was not
> recognizing IPIP tunnel types based on the next protocol value in the
> outer IP header as specified by RFC 2003 (IP-in-IP) and RFC 2473
> (IPv6 Encapsulation).
> 
> The issue was that the code treated all combinations of [IPv4|6] / [IPv4|6]
> as IPIP tunnels, setting MLX5_FLOW_LAYER_IPIP flag regardless of the actual
> protocol. While this happened to work for simple cases due to the fallback
> classification, it violated RFC compliance and could cause issues with
> protocol validation.
> 
> The fix adds RFC-compliant tunnel detection by
> 1. Checking the protocol field (IPPROTO_IPIP=4 or IPPROTO_IPV6=41) in the
>     outer IP header to determine tunnel type
> 2. Adding protocol mismatch validation to ensure outer protocol matches
>     inner header type
> 3. Correctly setting MLX5_FLOW_LAYER_IPV6_ENCAP for IPv6 encapsulation
> 
> The expected tunnel patterns are now:
> - [ipv4 | ipv6] proto is 4 / ipv4 -> MLX5_FLOW_LAYER_IPIP
> - [ipv4 | ipv6] proto is 41 / ipv6 -> MLX5_FLOW_LAYER_IPV6_ENCAP
> 
> For cases without protocol specification, fallback classification based on
> inner header type is still supported.
> 
> Fixes: f66c7c3ab983 ("net/mlx5/hws: recognize IP-in-IP tunnel in definer layer")
> Fixes: 4b7044562f59 ("net/mlx5: support IP-in-IP tunnel for all combinations")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Junfeng Guo <junfengg@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

