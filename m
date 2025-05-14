Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92815C3ABD9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 09:23:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F3DA4064F;
	Wed, 14 May 2025 11:23:03 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by mails.dpdk.org (Postfix) with ESMTP id 3E711402C8;
 Wed, 14 May 2025 11:23:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwJjf1KJtSEXMEWLwIRi1fLcU1ObMxrau5bwneEPsjqNlaea3y+QwudJlL/LQM1Z85A9m9kVECM1iuKMQH0q4WkA6/cxiQEAccFp4b0eyUoZCv/eFcU/jzbEp1YO0v7Un4u++9Phq4a5asr4QSb0ctHkmeWqz8Xvv1dKGAD1gQL3D4eotTAMcbIkSiiX5scKBwc0enmqt0AN9Rh7hRvRRl87ZqzA9RfjDS5WuJWwcfrPWZwlod9/QNi/ozIjTNk6rVBf8LDuqjzII/6s+UFElSKdvd6j630sF2ZUr7VVUurDlkwtqX/+d50+Th+j2UuFj8pXdn/Dabui6JtUkOaK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xElqg42w/mS2irtTn3JhHCdldPoUsYhUlOIpUUyCAMA=;
 b=Zq/XroOUZ1J/vAdIDjTDbETWZtNRSCPqdfmB3RQmSbRiOacNijUlrROn7zE9daFCIuAoj4gRxyabkpxSZSTfV6zHKmVPENXQKxD8BtPIX6ElPDsnsQNcQ++ZrQbVAt2MYIOpvPJkUXHJJz4DNlm7Ua/4w3QlLM3tkXjqO+7CK0IdK6XGo5vi//mlf0QzON4T9zIyrPxdKB1oe0RS3KzvuHpVBv9r5sjZur0I9025GYzWr018y9DnsJuBkiXz4SxKsGpevs75DUZFe4NvMSEaT0J30FpPBgjKjuXFCipfabU6KLq1nSVXmStnnpzMy49MvtSl64zsZdTpG/gl4CmQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xElqg42w/mS2irtTn3JhHCdldPoUsYhUlOIpUUyCAMA=;
 b=IcsBq5urq0yWi1MZuqbMSOx/jxLRfKDiybha7giDZ7bY0+X4j0zYjooVHO+cJKN5toxkfTRvcrxx+OYVdU4y8txvrvcMUiNpgshLxKWRyifgoeJmtDFuF22ulK7GVEgPHpe3zCZlJutSaLEUwTMgX71hupsT7+h+b2wEG+lHsr08qR9czwCI2jGr/4Vul70i4bC59Ia205/aIUZNJQWLV6vwNeqItO3bQeyNZcO2s3vN/gEQQGz6Bsn5qQd8UHebf9tVCYaL843cCwmNcvdDrwh7kJW5p9orV5o/+tQV87XT/BwFo5ddMew2Uk+hr+Od/0LH9wuRp2wbR+GmrmVeVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 09:22:58 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 09:22:57 +0000
Message-ID: <31fd7752-11c7-4f74-a4a7-79991214609d@nvidia.com>
Date: Wed, 14 May 2025 12:22:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: fix the maximal queue size query
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, stable@dpdk.org,
 Edwin Brossette <edwin.brossette@6wind.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
References: <CANDF9xANRqeTnkvAk61y=2TCd2fsWDQQ4YoTFdpL-RW8ksDDGQ@mail.gmail.com>
 <20250514075530.419423-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250514075530.419423-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc1d295-078f-4fe8-8b43-08dd92c8e9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWRwY2tNNi9VYnhGWjNiQUR4NjBiMTk5M3BzbXVVeGo0emk0MjhIY2ptV0JP?=
 =?utf-8?B?QThvRk4zdzNiY0JHUVlaMmloTitDb2Vpd2dpaDVKUDVWazFNMXdINzlHMGt1?=
 =?utf-8?B?aDdBZGdjRFlNMnh5UzZJZkk0T2h4ZU56TWxRM2Y4NktPQmZXWDE1eThyb1ds?=
 =?utf-8?B?VENnZWRMWUFoKytaVG9GeDNWazloWlFkK0l5T09TeldvdTY0QThpeENYMEpH?=
 =?utf-8?B?NHFPeXVKRHE5UDNuUUY1L1FQdGFkNTFPTndzQ0Jvd0JOUDIrVCt2eStNKys2?=
 =?utf-8?B?N08wNUFiTUJiMXJOV3FuemZxQmRzZ1FzZVh0QUhCSmZiZ3RKRm54RkhJNXJZ?=
 =?utf-8?B?bnZVNGF0YjJOTkRhWjNxYXgycmtKQ05CSDhNSzFYN0dCT0hZdXFmWE5xRC8x?=
 =?utf-8?B?Tjg4dW0rTXBRanMrR0ZaUnZzR3NQWk14MHdCUzQ4dmZ4cEFBVW84b29sdkpF?=
 =?utf-8?B?WlZIYzI4QUdQNVZxRlRtaWI3ZmdyOGFBdzB5WmRCQkFxa2VRaXhrSUZLbHNH?=
 =?utf-8?B?eWg5Zm1FdFVzRkhTR0h6YjJoRW9OdmR1VGlVdzN3a2N0Z0YycG5wd3pQcFRp?=
 =?utf-8?B?elZhMEdlcEw5ZXEzcjJ2aDg2VEYrMVpMOHY4S1R1dGhGQlNNZURlVlFQWWZa?=
 =?utf-8?B?NlVyUWpZb0R5YkRqbDR2eHFvOGpQb0dXaVN6TS9HYkx2RVpjNmJmd0dwcEJy?=
 =?utf-8?B?MWlmbjFudDRmTlduUVFnUmtiaFg1bUV1UHl0TWJlbDQwVUQzTDRhY0VueGZh?=
 =?utf-8?B?NU1EcEQ4WW5NeWF0L1BxSGdQOHd5VFpObGg3QUMrdzJFRTdEcWpXK1Y5RURr?=
 =?utf-8?B?ZWxYcFoxNTBZekFiZVRKWXA3a05aZFd3b0V4VUxWSlN4cUZBdktlaHhPaGh5?=
 =?utf-8?B?MXh5Y0VveDJUWWJUSTNFQ2R1TUg5bE9yN21PZFp0NSs0UzVDRGQ5RitmNVRo?=
 =?utf-8?B?UVF4bHEwVDhNUjB1bXFiWnlaZnZWNGVTT3k3SzcwSUNsNzhIUUltNTdwYWdk?=
 =?utf-8?B?bEtEWlJZa3hsQUhvMExFNEhWVUxMdFdTMXdPZzRINWRxTGpqcnNiU2ZLNkli?=
 =?utf-8?B?b2w3QTBNa0grOERCOE12dEkyOHVhNGNYL2RkL3R3c0NhZ084RjNUV2FZaTMw?=
 =?utf-8?B?R0NzdCtoenNPb05GeHpBdjkySTZ4MGU1TnI2cHVxbEQ3TS9hWkUxZmlvcVA5?=
 =?utf-8?B?KzJSQ0RmV3FlMDJCTkNMblNTQ01JUEZqbk1PMGZHdTlablNIckFhVUdrU3NY?=
 =?utf-8?B?MVM0VjFmNTJZaytOZ2hUTGFJSXNsd0VMTnVDV2k0VXJtaytWYzhCcXdTZURU?=
 =?utf-8?B?Q2lEMHhCUmVLYllGUlJ4aUhBcGFwbDNRbHVZV0ZRREV4N1V2Y1o3cW5KeGVz?=
 =?utf-8?B?MnZBNmJiOGdJNG44azFLWjNkRlk2OTlYOFY5N1dsTTVhMnk3VmM1alhWUE1Y?=
 =?utf-8?B?dU9ycjgwdktCYjZjRWxsRGVOMVNyM0QrSzVScUpRNS9hWGMwcy9KK3ZSQk1s?=
 =?utf-8?B?enpNMkx3M0c1TTVrK2NEbFJzcjA3YVdMZ3dPL0twMTNhUk9JYmVpQkNXV0x1?=
 =?utf-8?B?b3IyV0JnenJsb2lMRVBzWVZxb1lDUU1aUDBRVUxmclRscnNGMkhQUlZjQlFZ?=
 =?utf-8?B?ZUxjZmc4WTNZUW1pK3FGNlBvaE5nYktFb3pwRkt3RDJoWVdWWDIwS1dNaUxC?=
 =?utf-8?B?Mk13Qjl2QzNhTTlYbUhYbXI4ekRsaXlmSlhDblBUTWs2UThNMVFGVHdsL3o4?=
 =?utf-8?B?c0ZWTTRvTWdwWWh2Y2JsMjhJN1dCVHRRRmZ2TTNlVFpmeEE2MVlBM2EzdEhs?=
 =?utf-8?B?Ym9lL3lPTHlVMDkzcDZxMDBHRGZYWitMM2h5QmZ1UlBZNG1zVVZVdXJVRlM1?=
 =?utf-8?B?WUR1UUZTZHNuWklCQ284enl6MnMxRDNWTmtZVFREc3VBOXQwbHFUU3pkd3pZ?=
 =?utf-8?Q?fT68dR6P7H4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEtWNlVwdFJ2aG1DeUIxZzQwdTgxR3h3dStvZEZnS2tzL2dja3M1VE5vUnVO?=
 =?utf-8?B?T2UyY1dzQ09qRzdwTkxURXFmNHJMdTJJVU1wM2x4SEVScHArNWxVd25CdERs?=
 =?utf-8?B?SWI5Y0wwb0lpWmEzVGFFNWRBNXRYMTB4QUdGTW9zaUI5aTkxT0NPbVhjREQz?=
 =?utf-8?B?VUhmRzFlQ3JOUTVQWVlwU0ZvQXBVaU96K21YTWs2ZWJrYnI2OGsyZy90WGpI?=
 =?utf-8?B?dTUrNHlHVnVUY3I1UDFIbUtXa0ZZRHNqZFpOSVJoOGZUc0x3d2JUNS93SU5l?=
 =?utf-8?B?L0hrYXBOODZiQVNIQ1F1ZUxWb0dENHYwL01ZM2VwRGxackdXUG8wWVB4U29z?=
 =?utf-8?B?a20rNHI5SnhreG5DaTRtRWRFa2l2RjF3RHZtYk9RbVVudUt5L2E4T1FoN2Y4?=
 =?utf-8?B?NGJoK2FkZGVZN2V4TlpoQWZXUmx4MERyYTd0dmZmR2IzZ2IrcjBvRThxbEhi?=
 =?utf-8?B?RUVDQjNsZ1FXN3o4bTRGYzM2MjVJNThta05SbWxmNGF3UnRyL2d4Y055ZVNy?=
 =?utf-8?B?VUdYMWswYUpYMXhpM2ljcDd6dlVzRTR0YzNoUlJKVEZqWWRMem82ME9nUkVM?=
 =?utf-8?B?NHY5cmxrclZ1ZnY1RysvVVFwY2JmK0ZqTFlBYTVDM0FvT0Y3U0psOTBPQjV1?=
 =?utf-8?B?aHplVWRtdTR0djhGUHh6TldZZ1JEQ2dpWHJtSjlRbTVsREtqRVhpT3dOblhh?=
 =?utf-8?B?OW93UGtIN1FxV2N4OE1RazB3VjRSYnpUNzRXQjJFaWNPa0JsYUxRdjZjL0xR?=
 =?utf-8?B?eDdjamVFZ05RaXVKZ25jSUNEeUJFeElSTm9SMVBJajFNZklvaUZGZjJnd3Jh?=
 =?utf-8?B?c2tCZkM2WkNMZjNEa0F3end2eEFJYVlHK0VrRDdubFUwK29iQldIK1BYV3Bw?=
 =?utf-8?B?cFY1SFNMU3dBeXI5M1dQcUtDWERVMW1CbUZoZ01ZTkVxT3NnckdDZ1Z6MmRR?=
 =?utf-8?B?aEZyYXFGN3pyVExsc3J3RU1JS3FqaGVGbUJyQUFmY2NnK3A5ZDBPT0l0dFVJ?=
 =?utf-8?B?NXdnVDlNREt0V2MydlFTaFpVcTlYQ3RacWxXYUxQYno3QUErMFh0RXdQTGFM?=
 =?utf-8?B?TFppaWZxdlAzaVk1dGh1MVpxd3pUTFQ1NlY3b1JWYnkvc2xNYmpZYm9kUkMz?=
 =?utf-8?B?Q0Y1MzJvV1VjVVlqL3BpV3ovUC9PYWFqOU5OUEMzQzNTNXBwN3lEMDFZSHhk?=
 =?utf-8?B?U2c2bXdsVUhIL3dSUnVJRStzMmpTSk5TNU1HUkZCRTdNU0d2dkl1MlFmemFk?=
 =?utf-8?B?TUMwbE5hZFV4SG94M0tDTS9sbTQ4UmJ2anJOaTdYWUVySmRQU3RHeUgxbGxB?=
 =?utf-8?B?dk1XUVNQZUtoTmVsRDlHTmVCRXVBYThoMXkzZG1pWUt6bXdwRnVPOEtscWpr?=
 =?utf-8?B?WmFENGFMNjV6cE9QdWYySk5KYUlsYXNtYzNDSmpvN2JEaDlEQUJ3am02SmVU?=
 =?utf-8?B?aWJvajJGU0J4L1lNQ2J2TG5mS2VveDgxNWFIS2dCU2lPNG8yaXVLZkN3OERB?=
 =?utf-8?B?YkRtWE5KL00vQVN5YmF5T0JoQnF5VThxczNLckZFazRyZVJ2emlUWEhkWEhI?=
 =?utf-8?B?aE5GVDBxMUkrOEU5NFREeityYjByVTNsRjBnaXYyTVd6cURtUEV4ajFEUEFu?=
 =?utf-8?B?Tm5Na1BnalM3ODAzNnBOUjZFYzJYVEF1VUF6K2Frc0JLVFUxMDdLdXZ2SFUx?=
 =?utf-8?B?NTA0Y1ZXRDVPUE9BM3l0M0JOYXZUeDJzbGFEQVUxS2RLM014Z053SXlqY1Vz?=
 =?utf-8?B?REYxMFlBeFNXTzhiQm5jWEppTHNiK0hBR0FCRloyd0pidzhPMnVQeWRIUUM3?=
 =?utf-8?B?aTJIRktTRm4yeXcxQzZaNTBUNzVGSlowaUFvTUN3VGxrQUt1UnZwdloyS3FH?=
 =?utf-8?B?clhITEE0dVpiNlluSTNXTXFtQmRMU0VxRnBsbjRqRVFxK2FUTHYyZHZYdWZj?=
 =?utf-8?B?V0c5V0ZHK204ZHpJM2wvTUVGTVFqTzFJTFFWSThJS3lGNzVITDVEVFpmV3RR?=
 =?utf-8?B?YnF6c3NkR2I3VzAvQXY2OGtnVGZITlhCNzNTV0NuYURkRDQvWjVQM29vb3NC?=
 =?utf-8?B?Nk1UaGRLL1RPMmFmYXNhQjl5SUVLdUFPRm5qYTN4Wnh3NktoOHNIN2tNUU1a?=
 =?utf-8?Q?lu8HqvOCWmg9lljHzQ3IJUx8I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc1d295-078f-4fe8-8b43-08dd92c8e9fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 09:22:57.7114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jbHigR5eWQ+ydc/LmRNSKDqLY77M6+cRGGKkPVyCxcLjP+kh7L5KC7+Dxj196eqe93UpitE7+XLdRDdXfdZ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
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


On 14/05/2025 10:55 AM, Viacheslav Ovsiienko wrote:
> The mlx5 PMD manages the device using two modes: the Verbs API
> and the DevX API. Each API offers its own method for querying
> the maximum work queue size (in descriptors).
> 
> The corrected patch enhanced the rte_eth_dev_info_get() API
> support in mlx5 PMD to return the true maximum number of descriptors.
> It also implemented a limit check during queue creation, but this
> was applied only to "DevX mode." Consequently, the "Verbs mode"
> was overlooked, leading to malfunction on legacy NICs that do
> not support DevX.
> 
> This patch adds support for Verbs mode, and all limit checks are
> updated accordingly.
> 
> Fixes: 4c3d7961d900 ("net/mlx5: fix reported Rx/Tx descriptor limits")
> Cc: stable@dpdk.org
> 
> Reported-by: Edwin Brossette <edwin.brossette@6wind.com>
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 
> ---
> v2 - minor fix for signed/unsigned comparison in debug assert

Patch applied to next-net-mlx,


-- 
Kindest regards
Raslan Darawsheh

