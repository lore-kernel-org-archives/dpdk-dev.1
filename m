Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCCFCEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 13:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71F8240262;
	Mon, 17 Nov 2025 14:43:37 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by mails.dpdk.org (Postfix) with ESMTP id 8AF744025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 14:43:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5I/zwlASbaHQi+ram97pH+CHEPnvBXdU9gA/DEUPcBg7fRP476BHUq8Xss6K++WAQYkmwGAjjqx68Ru4o+n8krOA7tZNUJzfdCIj355aF+E2IOq2/92ikSTVmIlxck0cEyo3AYUji7pra9vVTnT8p7I08BehMZLfUnjR0PDpUog++rdHGLYMwJ3BeOUTLgpx2Ri10uHUfabZo4Ex/dwfigREQNOic+t9A0EIUdiGglYRNw9URpwiTSpqs6jQMdVNaWUuORxqQ4Le0ehPwvIUakKOFWj0oIeq8bhurV91cgVCDvJrC9DFcWyupHSDdGTcmpFnAuPCgNu0EUkd6OMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojpKijete+F8LRaKMTD8t2kQirOe3+kTvsTmybVRdaw=;
 b=I8EgxyYjw3ZHFbjczfX+HITSIWHMfuCOMGOuaMVTfZQBq6DFcfvtDGJKWeHro0vvNOQEl+P7Nk6C2KCw/ZtfajDjohjtHVEFA1tkmu+LaO7JFCgQkshR1SmID2qXSdDWNTuj49xDc+ULjrn9FwTLLr11z8zrVjztCtxFPZqxv+jrCpsJo1c2Ps1xi3gcU3AoKQ3tKvQDZBdrNqnrepn6cSJIgzMFmDw+ser5YvVb3amNeKxVeJLj/DIOU3mBWepCFpCsxhxvBQezMjtuqlxYDwg5oJZHzsMdgt3EdRns47KVCLjUbN/oCWmYAE7MY9rm66mhjc06wc1Bcq5cu2WQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojpKijete+F8LRaKMTD8t2kQirOe3+kTvsTmybVRdaw=;
 b=GbGK/qS0EbrJUNZZ2m4qDl+x2Ob23TDknGeigarIpOozstuTYPcwXqlhewbfuzkllZZDPw8q1NLA+oAKDhu/ECpZFTMD1ezO8WYJX4gjlMx06DhhqkXGEUtfecFtlc3mPlRn/nv1+ttKve9jz858rMm8HTv1J+TqU+PGrIOS0bB2SGvVbPQYhgF6QyqJOQQrTOa3Kt5IKouf0pCXxiOmwjNVxQbRXDtX14SFuAktSVC8CmF6eIdFV8OxSvy/wdma7Zq29pYkFe9+Ww4s4fk32m1a/Kv+kW5rYFu5QElX6xb8m715JCDxblYfcx7ulxerRCOotSWnQoJsLB5YSc+D5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 13:43:32 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 13:43:32 +0000
Message-ID: <b37a3b28-7e5c-4276-83ca-d110d5a5af85@nvidia.com>
Date: Mon, 17 Nov 2025 15:43:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] net/mlx5: improve socket file path handling
To: Yang Ming <mosesyyoung@gmail.com>, dev@dpdk.org
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250829144954.2576-1-mosesyyoung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e37aaac-c620-4f11-dbc1-08de25df4c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVE0eEIxVEtpclg0MmZhdXRvcHJucGpJNm9mUnV4eFowK1BJK1AvUXZNQ3p2?=
 =?utf-8?B?dDBrUWk5RGpaMVdIbGhDZVRKOXFmSnF2S3ViUjFlZnN6WXpyczVGNGtIUG04?=
 =?utf-8?B?SzRwVEI2SHM0QnNuV3hjWlhGbUZkUk95cVBZdEpzRkpTS3dlUFp1TVBHL0FH?=
 =?utf-8?B?elV0ZG1GaTY5L0tBakVtQTdEMW1tR2I4akhEU0tnTFQ2eUdBZ1ozb3pOOHZ1?=
 =?utf-8?B?RkwwL0kvSzFSLy9xVXBLR1pQTUl0TlVPUGVXYnBERWFDdzNRalIzUWVQeHdk?=
 =?utf-8?B?U2ZqakthVDB5bU9namFzWitrU3FYRExZeTVXVFJVcE16RHhzWXB2amg3d0xK?=
 =?utf-8?B?cmxqd3I4TUVwZEdDc0c1cVMxTzIwWnRxY01GTEVsN1dVejR0QTJXN1BwS3U4?=
 =?utf-8?B?UENGaVNpYW1oQytMM3NBckFuaVVTVk1OellNN2JTcHluYnpkcjBIVVQzaFhN?=
 =?utf-8?B?UnkrWXR1S28zczNrV3BQS1dCVVFPVHY5cXNtc0tKalRVTEoyNHpDcnZMV3h3?=
 =?utf-8?B?cG01TVcrSkJqVExZblUxL0FWcDVpa2x0V0dKaDJLZ1NSSzdmWVRIVmZqU2tQ?=
 =?utf-8?B?YTZoYVlkN3lwVXlkVC9LVDVpZVZMdmFnenp3QnVtdER6M2V5WnR6Ujhrc0pl?=
 =?utf-8?B?Q2ZvcUFuUjFVUkxsNXdiZlUyNHNmODZHc1IyZHlsTUhTcXUydHhSMzVlcU9B?=
 =?utf-8?B?UjUyeUxGTGgrN2V3Q2JpR21hd0J4Vmlhdy83RFVQSUduQ1NiZ3VaSzdiN09n?=
 =?utf-8?B?VmpoaVExSHlTV1ZqSjd5R3ExTEthWW8zeGhuNHYvblMvR3lzTUU4VjVaMHhH?=
 =?utf-8?B?QURTaUdzSGt0VlcvNFk4TGR6em5sRTM2alBsNFQvaGNtajFqZnlZMGp6d2Vo?=
 =?utf-8?B?T2JpWVU0YlEvSWlhOVBFK2xjTDdkeS9rN3phNTVDbkp3ZjVrRFZHRlNTMWQ5?=
 =?utf-8?B?UUNVeUhraVNKWUZobnV6QmxIUnJ4ZUJjR1VRSVo3NGtxWGNGOGRrT2lTRW5u?=
 =?utf-8?B?M1lHZXBhc084SklaYUt0WFA2RnhGMWNFWkUrTkgyWDhvRlI4dHFQTFVHWDFq?=
 =?utf-8?B?Wm02NUxNa1hjNzI4bWloN2p1VVU3NE1mNFNyT0NnQmI1YVhCLzlMcVkxWUlk?=
 =?utf-8?B?Ym5iTUhuK2pFVTBFRkpsSnFhY3RqamtkWXFVOEVYVWUyNG0zczJxalhZOC9Y?=
 =?utf-8?B?OGVZYTdjbkpPSWVzZ3c1SDhNbXZkeHZpRkhKdnZiOHhlUmwySWwrU3RLRS9j?=
 =?utf-8?B?cW5iN2s1T2FUZmQ0K0Y5SVBzanFna28xMFpUQzF5T2plL2xXaVNXUVIxS3VD?=
 =?utf-8?B?azh3c1g1alRJRTlZbFZzVGRmOUxTeFpqeWplYTdqNEFuTDNFQjRmUUh1aGEx?=
 =?utf-8?B?VHUzSWZaNUo3YnpXUUNIaTNaKy9MTVM0YzFIekJ2VGtSbG1TMkd1ZU8wWCt0?=
 =?utf-8?B?eHZXNmhnN1pOd1Q2bkRUTG50MFpoZmFvM0ZuZmF4TlVrS0xmVzNoMnRWUkRX?=
 =?utf-8?B?Z2VtaEQ5Nm1mZXJJVEFvcG9DaUp1K0phN1JzRFVIbUNHeUUyYUsya1BxcE1R?=
 =?utf-8?B?bGNyMlhmVHZVd2t6Z3lLZjNpMzNkMkNobzZ1MmZPRGpQY3M4ek1OTGJxaWpC?=
 =?utf-8?B?TzRRWlFCV3QyNktvaS9jN29BUmlBNzNuaUV2eXlpb0thTDE1Nnc5Q0xxOUtN?=
 =?utf-8?B?SmY2ay9obXJoV3pqOG9Pam5MQWU0MG1hSjFaeFpJclBhMk5ISzlQZUh4c3U0?=
 =?utf-8?B?K3EzTGlodEhFdlkzRGJTbldxRURWNFZBZzhTM0dUdEZqVlVrVWE3WStwRno3?=
 =?utf-8?B?bmxDVUJJV3FDNmZaUUJpOHlqOHFuUkJMeWVnS2FOaEM1RVVCdWR2RGJNTWgw?=
 =?utf-8?B?WkxYeVBwbW0vVXpxRDV1ZEVmUnFMa1RNZXpFSmV4Y214Sjd1RFZ6Z3BiQnht?=
 =?utf-8?Q?0iUDPVuSfQUWg3B2ZCyXzHqtHn7MCXsO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ozaTd5WEI0bXU0dmtBbG43QlUyUUJEUTBDbmtVRDJVdXRjbHdVbmV6NHoz?=
 =?utf-8?B?emk4MHdHa1VOQkxFSHZqOFpFSm5KV2tSMXhWdlAveUw4M3gyQ3lyaE5RR0pv?=
 =?utf-8?B?aDFycVdCdnMrQ09CZW5oOVZ4Sm9tZGU3TTBCNjh0S1BRY1ZKTlpHQTVYQXhG?=
 =?utf-8?B?U1pyOVQrZlVqVDBrMTVTejJvc2NSRDNZVzFtYjNUNzdiOUhMeTV2dWFmTUNX?=
 =?utf-8?B?VmdGcDd6VzNIbHdjV1FnOUJtQXErdkJPZW95dlJkWnlKY0IwU0dqVG9DL0Z2?=
 =?utf-8?B?Ump1RU14bFBOSkszaWtGR0d6SHNFTnhKU0lVWjlxdXJMZ2pqc0RIcHozcjYw?=
 =?utf-8?B?SUYyeHNmQ1Q1dmdDOHo1clNCY0VITjVNZlk1SFM4VzdSOStlU2hMYnZoNGZs?=
 =?utf-8?B?Q20wU0JpRVVrb1oyQWtIaHZLUXpscTdPRDNyT05UeVFhVkFnNzRtV1RKQmcr?=
 =?utf-8?B?d0FQNnp4TitrTTVIQlBQZ3pwaVIyZFFkVlE3OW9WZytZYngvYmhBRHJ2VHNw?=
 =?utf-8?B?S1lpZEZPL1FsR09oVG00c2dkVHA0aXdObHJjcnVwbXVOWjlublhiUlQ5M3d3?=
 =?utf-8?B?c1BFMVUxVDMyR0xmbmt1NVA5emg0aTRwWWpSZ25pS1FwaHVSWmFvV3lWSmt5?=
 =?utf-8?B?QzNxa0F3ZUdVazhiaVIyTFdEaDZETHBjVzdObi9DTnA1N1lZMFdDdXRILzJK?=
 =?utf-8?B?QVZRU2NPNnpxMVRpazBmZnRoc2NCczF1VkowZFM0a1FIeGxOcFdQOWt5cmYy?=
 =?utf-8?B?ZVFsTEcxOWdPVHI2ZG9pNGJEL0JYZCsvMkZTL3o2ejRpM0FNMTBhaWt3dTNQ?=
 =?utf-8?B?ZlQwL3ZaTnpOOUlWVEVENTZLQnpoVXFFOTJmTjVUWlErbzRySmw5SnZhU0Rq?=
 =?utf-8?B?T3h1MkhFMy9UanI3WEJKQmY0QVpwaFMrR0M3V3JUdjY2UEtJaEhaR3JtcXc1?=
 =?utf-8?B?M1VNamxyMldDSnpkNXgxZkM2L09vcHpETWluNEdaR2JxSXliendnclJJTzBT?=
 =?utf-8?B?T0d4YXEwUlZqUE50M3NIS1JET3U1c21uQU5GOU9NbHpBOEdqNi8zYW5ZZU9r?=
 =?utf-8?B?YWljNEtvZ3BNU3V0dXpyZnUwY3IrK1JCZnY0NW5YY202WkJoYlNTRzdhQXFJ?=
 =?utf-8?B?ajJ0cFQ2TFFQNm5tQVAwMGlzS3hna2JQZ1FFY2xOTFlQZkRGb2MvblZKbWdv?=
 =?utf-8?B?ekNqRTg5UnRhdWVYRTVqTFV0TS9JSWV5Q0NxYWtjWHJMTjYvVG5EZ2N0ZEFS?=
 =?utf-8?B?SW1xM3cva3lMQk85V1NoNEZialhrQUYva2poVktUNGN2TXhZd2pYOEZQd1hL?=
 =?utf-8?B?WE4yNTRHSDF3QlEyMVJxN0JmTVVEd3ZNTE43b29wMkNJWTFtMDEvYjNrLzJS?=
 =?utf-8?B?cWw2QmJoZGJibkJPZ1E1WmRIZ2lEbDd4SlJXZDY0SjVCUmJVRHRQQk5wM0hE?=
 =?utf-8?B?MC9rRkVqS3U2RUhqRkNLRTY1Y1pIaGNvYjcwQldLZmxMM1pUVjZkV1RJeVhV?=
 =?utf-8?B?VnN2bVZBYUtlbWFsT3Rrc3IrM1hwNlRrMEI2a24wSERRUXJtdGV6R29lK2xk?=
 =?utf-8?B?MU5jVmxtL2daYlNGZTdFU041cUFiSTdhRkp6TCtUNk5EWXk3WTBzUTVyY2hu?=
 =?utf-8?B?QTBkNDdoV3VzK0dSV0tPTmxWc3Z2RmhHV2JYMkZuUEVlVGdsaFNzTVVKRW5S?=
 =?utf-8?B?cmNNeGRQOVprU2lYeDlkblYzcmZoQnRDd2dlZitISlhMV3lid04wY3pGeTNj?=
 =?utf-8?B?N08rYW13clhJK2RFd0hOWG1kVHdYMXhNQjJWZE9qZWFYeTE0UEQ5cFNTOGFx?=
 =?utf-8?B?TjlHclV5NktuOVkwbXk5SWFCajRoaVhDMGk4bnMwWnB3YUYyS0Z5MWUwSW13?=
 =?utf-8?B?a1N6UzJIYkZQZEJZYis0QUd5Q0dYRW1TOG5vcU1BcEhPbjlNWDFWUmFKenJy?=
 =?utf-8?B?Q0Y5bG1wY28rZS9KM1VDL3JTeGdBUmVkaWVmbVBpVFlleHpYVGNIK05lMCsv?=
 =?utf-8?B?MUpKenFWZjVpKzdZa2JJQ1gwWEJpb2VFKzRMMm9sbDNUVFl2QW9xTGdvQUVF?=
 =?utf-8?B?ejhvNVY1MTlRTjhoN1B6VnBCL2hEdzNJQUJhRzhKbWVqekRicytKOFFWblAx?=
 =?utf-8?Q?1bLWlwuWwSwp6EnO+ZyzfwW6C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e37aaac-c620-4f11-dbc1-08de25df4c3d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 13:43:32.2613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iCqBYPb2fcpZwrmHZn9WL/HuxyxHYkI4ZmEHZ1i4SmSAvH/RqgrI6aG9Nb+HkUB5+1RVQbhBY1k87LcEUi1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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


On 29/08/2025 5:49 PM, Yang Ming wrote:
> The current implementation hardcodes the socket file path to
> /var/tmp, which has two issues:
> 
> 1. Hardcoding absolute paths is not good practice.
> 2. /var/tmp may not be writable in containerized or restricted
>     environments (e.g. when the filesystem is mounted read-only).
> 
> This patch replaces the hardcoded path with a socket file name
> (MLX5_SOCKET_FNAME) located in the DPDK runtime directory
> returned by rte_eal_get_runtime_dir(). This ensures the socket
> file can be created in both normal and containerized
> environments, while maintaining uniqueness by appending the
> process ID.
> 
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 
> Signed-off-by: Yang Ming <mosesyyoung@gmail.com>

  Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

