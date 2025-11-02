Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B1CCFA02
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 07:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A4A40261;
	Sun,  2 Nov 2025 08:31:22 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by mails.dpdk.org (Postfix) with ESMTP id 0EE804021F;
 Sun,  2 Nov 2025 08:31:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wevH/xOtLuv+UWivFH2a7tq8cB6N2kkiCF+nz6v0Bngl0VPmIoX+z8dev6PHfDWoieVDa3yX0L09P2dIxcBP5LZUdCAfPijWHl04Qz9Ccn6voc4zGpULcCJ5JMkOJ+57lK2KbYlqhLWXWkP242ocHhzItI0BZ4/CV8uDtx/lYGbu6my5r+aJ17YG1LhkeRhCwCrwND17CWL7grmltRUgh793VPMqaAYSZjYPXme/KHsj9NaU5Vs9fXJ/9SS9vsWifrhwUkUSghssPU5ZRZlCQz/W4Z4APfU2hUNr7UchF8XqMy6zsNiPwVmCimPNE4uSlaonqZMbytP0ltysM+yMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnLVpKQod27f25anY9YjpZFr+3HIEF63WkrPBcdYwtU=;
 b=apSxrUB9EUOJnZkqT+2hlGG+q6rSSzW/U6bj67zdGsAsGrbWSEx1YMgIoAMl3lO6yFk9K7LFb/LEcXK3uTdognccOL1iB7026pZRpSgfon4ewXA80XSBc+EDOWTgpAsy3EpZIDmUYQWHtHamJ56EYQSyyrt/kQNZhWJ7El/g5t94+E4JMfezWdgja1GpeohbzvjcvyZOYQcSE0Zrs5jKTYgjivqo6Fg2qsfZppp7wcRl+BpCyXIq4jVa5xzHn/oQ6HJs/zLwy7kZDoXRC1wTHsC7uDjqNI0V2ZkWjtZnmp+PALQ8pB1FADWiNdkW6bElrhnsHvLg+q3fnIdxRsBtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnLVpKQod27f25anY9YjpZFr+3HIEF63WkrPBcdYwtU=;
 b=rnIH06vqlCUQI3qSwNsYF8IxdG/ttL4K4WxQSkzJNTFG62EHA2MycUN/r3KSJUjYD3ij+3ZdusEPhg4W4XkLohSh0JUA38mgmCivjriii4Kgw6g0CfXN35lfNi9YoChZXFzEtGVHZgqzTtYC3X71EJJA8KoNdQeBGVp/xotspPEkRXau7zuy1ON4/jVY+upSu1SQIGZ4Rrx2ewvr61Xvv+6CzkiyksKn30BOlvIg3XOnfKRVqdZmV3WxT6MFiBsnSh5qTe+0alCHlW8x03gl0NC6te1LXvMS5UP12Ozc2ZpQyJ54FeGJqsYsxhvHZo+ZvKVH/+Zf7P1bobSt5kt5Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 07:31:18 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 07:31:18 +0000
Message-ID: <7f5d3795-79fd-4438-b982-e8264433ed09@nvidia.com>
Date: Sun, 2 Nov 2025 09:31:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/mlx4: fix unnecessary comma compilation warnings
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, stable@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Moti Haimovsky <motih@mellanox.com>
References: <20251029095505.100582-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251029095505.100582-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0d52b9-ab7f-4c57-5b34-08de19e1cfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVVVUlRWWmdyenNIV290RGJRY3lKTlBhQ0hEL3VjWTlTaXRhWHdJSk8rQnJG?=
 =?utf-8?B?YW5yTWlnQTBQbTkyUWhya1lpd1Q5N3JJTXhyWldhdTRFeTB2ekRYN2dOeXk3?=
 =?utf-8?B?K09yRUVyaUtBdFJGVHlpYWIrTk85MFdJeW5qUlBiS2x4eXZUKy9qMWR0RW5p?=
 =?utf-8?B?NElYU2FSdmpwZVFDcTNPTkFCbW44RjViSzE2N1ZDQTF4UTdEaXhGa29wT0Vs?=
 =?utf-8?B?OGVKT0pTV0dRZDBuQlpQV05oSGIrL3ZobkR5aHRaMVBxUkNEKzVoM0xidGty?=
 =?utf-8?B?RmQybjNYV2h1SG5hZElTSFpvM3ZIdmU4NUQrbnZrczJxazYyOUNjWldXVndy?=
 =?utf-8?B?TWkyS2N3RFJoZlhab1FjK3F6U1c4ZDRnWFBXVS9xRDlZS2lzeFpOTnpOREE1?=
 =?utf-8?B?cmdDeEF5ZDBmRUVaMlRNRUJQaEd0MEFoN0w5UGR2MWMzUUFuTEF1TGZ4QXMz?=
 =?utf-8?B?a1VrYjVKZ0N3NWxmNFJBa2pOdG5HQ0VZSzhGczliSldudXFlWXZhVHpISytG?=
 =?utf-8?B?YTBRaTNjNkIrdnB6ZjdsellpbGxWZ3Z5dFMxeGxVekczall0ZGhXblR6aHc3?=
 =?utf-8?B?MVJVNU03eUJRbDFBZkw0YTVCeGtPTjArdDNaK1l6RnN0b0diY0wvZmx5dm9T?=
 =?utf-8?B?UzVuZFV5SVFzYkJWKzk1VEtHb3VmK0ttcGJJaXlQU3AvM05HR0RrQnFzb3Ax?=
 =?utf-8?B?WnVmendQcEs5NUliQmdiSkI4NlZxcnovaW5reFo1RVYwZlhOdUIzNnVuRjRR?=
 =?utf-8?B?a2dmOWhIN2NBVkxmazhlbjBDZ09rdGJBcER2N0NQSmlCQzJiYk45bkJjN3U0?=
 =?utf-8?B?NGFBWC8xUWdBT0hjeDVZMno5c2tmOTQ1YjdWT2VFazg4NkwrcmxQMTJLdlRR?=
 =?utf-8?B?SE9YN0ZzUlFRNDViek50YU5LUklycEJVY1phMmJqMVIySklmeTRPb1VpYnFP?=
 =?utf-8?B?bEljeWRLRlRYMlU1N0ZqbWlLeW16YkNzV0ozWGk3RHRldFlybTl6dE55M2lx?=
 =?utf-8?B?U1Y3QVJMd1R1b3dlRHBQM0N5aXNnQVR4VnBiM2s2dGVWWDQ1MktKOFk3eVpu?=
 =?utf-8?B?TWYrZU05azZyZVljdnFGeGdKNzBEQzVJVDdIYU13K3ladkJjNks0dzJWd3pY?=
 =?utf-8?B?T2FzZnNOQzBKMFQ3Q2xxZ1J3L2N2c1pQY3NIMDdlUStkRElHaWdVdk8yYUs1?=
 =?utf-8?B?ZE1lN2h1dDBpR1lOQ2tIZXc3SC91S2tpcU0rUmhjdEMzNFRXMUNleEhCWWlo?=
 =?utf-8?B?MDl3WEJLcVp0ZkcxNW01UW1QNVhiTUxIU2p3OGx2blM2UDFObmdsZ1p2bmFB?=
 =?utf-8?B?VXpwUFh5NnBWczdKTTVzTjUzRGFVOCt5TUlweFpJVWR0NVR1YjBDL3RuSXFC?=
 =?utf-8?B?NkxyUDhxT1BROWlacU5mNFdCTHJJVUlOdGhwWExiWkxwMUh2MFNBZGl6UkZh?=
 =?utf-8?B?TmxtRmxOMWdTVExURTYxRHgzano2czRtOVRFNFEvWFBFZmpUbmVqNGhrbDhM?=
 =?utf-8?B?UnMyeEdVRHBwTTdTRnJRdVVYUXBuVDFIVG4wRTA2M0QzL0FaYjJtakFhOXFt?=
 =?utf-8?B?Uk1uaThraTFIOVFxQloxOWJURi85M0Y1NzY3L3RtMS9yelB6dU14N0lVd2g3?=
 =?utf-8?B?UXE3UUZ3SEFCdmEwWXJWditjaWVCekFNdk9JNDZobHVnaHNwRXd5enNiVWw2?=
 =?utf-8?B?eU9zRUx6ZUsrLzdDeGJUWjg4N1Rxd0NGYms3blJ0TGgvUnVLa0dVMHNFN3I0?=
 =?utf-8?B?T3FqQUtJNDRMdE9pMWxqc0IyM1lDR3VXdTVoMTNkZ2pKR1JCRHFjcHZlMWMz?=
 =?utf-8?B?bDZTdmxNdFhpRGI2SWc3UEdQcW5iczB0VG5GSWVzM1JPY0xiemtvT3BXQ01y?=
 =?utf-8?B?T0lQRk5xSTFEU1pPOUJrSStzQW0raDdCRDJOajQ5azRVQ3JPaklBYUd2WXB5?=
 =?utf-8?Q?/I/5vGv+aAsC4r5Wo3lb2Z2aeubpkp4s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnBoaDN5OW5uOUk2RDBjQTMzQ1ovTnRpVUtmOXhxc3JKQ3EwWUNJR2U4Z1RR?=
 =?utf-8?B?ZS9nMm9KN1RkbzVXdEpFcWJFcTBVZnBIMS9TNGtFZWt5czA5Y3JqZjIwS2NS?=
 =?utf-8?B?UFE3OUtXVnVxWnRRbS94aG04YWs3cXdKK0NidzdiZnlnQlBlNVpuMVl4aXNm?=
 =?utf-8?B?eW5IVGlJdlhnNlllVUk1UitGRkxRUGtlL3M1cXU3azFyNzl5ZVcwczNhajdH?=
 =?utf-8?B?NDhHNXRFQ2xxRE5GRjBYOEJGNTNNd2JkTjA3SWI1YzBROUkyM1VBTDlBdkJ0?=
 =?utf-8?B?N3dHYzAxeFZTKzBpN3VvOXNneVFEY3haYk9rWkFibTBkYzBDVEFWcGllVGcr?=
 =?utf-8?B?T01YSDNCNW9QVVhidnptRm82YkwyM1NPVWtBZVJzQUhtZDVDNkJUOEFOVGJw?=
 =?utf-8?B?UGdCdFBoSTRhNGhrVHhFaGg1QjdKbWhEOVlJSG1VdktMdGx3eXpGdXFTSm9I?=
 =?utf-8?B?LzdKZEF3QTF6aWZ4ZjhscS9GL09UUCswTlAreEJVODRXaXVTcHNjdHplVGxN?=
 =?utf-8?B?eEFVSDNTanhCTTZLRmtwbkpCODBRcEQwVWZHQ2lOZTAxa0pXNDF0MExRTVVk?=
 =?utf-8?B?b0drVWdqc0VpVStoMlkwR2VUdkdhc25tQmUvRnpQYThlMnNIUVVXU3haSGFl?=
 =?utf-8?B?L0NiQ3ZoY0RrYjhkUnNJNXI0dnNSODRVSHBUOWhtT3Q5b0tPbGM0V04zZXF0?=
 =?utf-8?B?UTRzT3ZaWktiR3BaQU1oY09hTUlONCtHTFFnWk9ZbnlFeG1oRUk2Y1poNXNY?=
 =?utf-8?B?T3RadE9mY29IT0k0YnJVdjlyOTVOc2pqakVVWEtJUnFuRjVRN21hRFkrZmpu?=
 =?utf-8?B?Z2RNK1FZY1N5aU15dVllRmtDa2ZhMmp6MG9xakY1SS9uMWV5N21IRkQrZC9N?=
 =?utf-8?B?MG1udFh0YTYxSzlIdGZIK3hscWlaK3BDRlBYd2RwLzA4WllCZmJVMFdBUXgw?=
 =?utf-8?B?QVlGZFYrWGZ0Q1dzY21hR0ZnYk9qR0ZSQUw0S0VSTmEvcTVYa2o1a1BHTUZy?=
 =?utf-8?B?MVlQb2xMT3ZtMU5WV05WT25JV0dkN0ltcUJWcnllVUsvZGEyMXVRRDNWM3Vu?=
 =?utf-8?B?RW1sSDRXT1VjRjlZZUQ5aGdRSHZleWVDNVBUbkE0anRsNHZrRDRyZWdXWk0z?=
 =?utf-8?B?TTR3OGd6N3lZSXp1LzVtYlBwUXFBb1M0Tjh0emxmcTRraEEvakNRcXE1U0VS?=
 =?utf-8?B?T3dkTU1URXEvakowTnEyZ0xCeUdxWWZVckZpNm5HTDVqWktLbUd6NzJnMXNZ?=
 =?utf-8?B?Ti8vTVp3eVppbVBLb2Ziazlvc0hVYWtzWTMvVHU1ckdMTWFlU0JpS3VsZjNi?=
 =?utf-8?B?S1pGTHR1ZE1qNHVrdkdyNUI1K3VzeDFwWEFPWmRRejdHMjdTT0RPeERjRXEr?=
 =?utf-8?B?SVROUXRmRC9FdVIzQSszS1crS0tNUHVoTExFb1FPTWFSbFd3eW5sVnlHelNJ?=
 =?utf-8?B?Tjg3cU5ORTFwVVRXK0lJUnYraWFYN0w4elNxNm9Jdk9vdDhXWWJyRlIybUs1?=
 =?utf-8?B?WWxXd05rWkNsUVVTU3p4MlN0cDJqWEJtOE9ROStNZHFObkJITGZvNzZYWkdH?=
 =?utf-8?B?K2pyOG5YeXdwNTR2NHpJVDRUNzQ1b0JXdXV3WEpOVVRObmlYTWNFSVFXdWN0?=
 =?utf-8?B?eUEwcVZOT0RFZUE5b2NIeUVXQ2UzdTdvNm5EMDB6RTJZUWF6RmxGK1V5ZUdp?=
 =?utf-8?B?MzBnUVBBK1F2L0pDQlBBbHp0bmpldjRHSXpnOFRISlBHR3A4VEpqQUxMcnlU?=
 =?utf-8?B?dmNRRkFSNlFhaHFXemNOaFVUTStaSHB5NWozdWdwRkU2YTNnMm9pU092WHRv?=
 =?utf-8?B?VU9xS3p3aU5YNS92OE9Rcm9qcEV1YnY1WTR3ei94TjcrL0pMZVUzSGtpK0Jz?=
 =?utf-8?B?UE1jREdCVDh3cFIxY3lpTnQwVHhXUm9TaGR3RjRjZXBWa0pDek8vRzU3WSth?=
 =?utf-8?B?NlRRakQ1WVFYVkhweEpqdTBUNEx1Y2s5VWVwdm5sSXo2c0d0aEtRWDNINzlI?=
 =?utf-8?B?VjBxNEgrb3FyYTBKRzR1NjBjMVN0Z2xDbEhLSU1wREdQUWtCZzdrRFdrbkh5?=
 =?utf-8?B?WGxnY0MzN1l3Mm00S1dEck9Ock56cU91bUJBcnZ5elBnT0RqaHdVN3lBZTRK?=
 =?utf-8?Q?cGS0nLrj304PoMkMIp3NbfVl3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0d52b9-ab7f-4c57-5b34-08de19e1cfd5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 07:31:18.1411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wHG1M5tHpOPFS33rjDzl8dgZoYoNgWJ/Lww+MQwvej0cfzVhuxYYCFebhaNcyX8FgD1JvTs9wuXks8U/ONX6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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

Hi

On 29/10/2025 11:55 AM, Gregory Etelson wrote:
> The patch fixes compilation warnings produced by clang -Wcomma option.
> 
> Bugzilla ID: 1810
> Fixes: ba576975a89b ("net/mlx4: support hardware TSO")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

