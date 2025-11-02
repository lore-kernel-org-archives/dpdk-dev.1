Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B04CCFA02
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 10:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2034C402D3;
	Sun,  2 Nov 2025 11:27:55 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60]) by mails.dpdk.org (Postfix) with ESMTP id AD8DF40261;
 Sun,  2 Nov 2025 11:27:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg53px5YajTn3xveDImX7rVfieLgChChSiuyFQy218sW2ic2+5vkBdrc8zSTOexZ0He6O+jUB4Gs+i9GgJzFH0gZDUU2g3Ex/vbg91OkgKEQ5n9amWMQCBOnxmNtLl7spUdZ9u9mxzPEU3bp9ASlfiX2Cm1bMFfQRE0xoGM6mfgVwymHh7Z2/R+UiM65k8UIK4/fnf72gay7llyZ6SVZacMO5EawKBtJCfI7jDodzbVvUvPT7NxnC6h3tlbxmg6kK/Jhr+yGL7qS9s/vf+bq6X9u3bqcwgQ5NGDn7JX4IP+wBrCd/6aHefurgWH1SWQnKmx6WUD/O//BCAgnNG8HQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDSPaiCBH4Ren4i/VLI/g4n2eTsnhzHQMLO4KXrTw9w=;
 b=uzCsNPwKmV8ZuqVoioQitvy80/47i22rJ+IoE48W/g/vyi4bagGXOCOwlB6XZ+sTIAm8DSw6AA1wMxo+JDUYNBVCVNBg/B2UY6k8MxDdog33iTIOsXfGuOcxEJm1vYAqjIwWLpwSAcRXsmWg59HAiVZrWDF7HR/M2oEdjeS7giVbre1kGMKVH1e76jxpydIzl0qcB/YB3vAurIPVADDBB0YHHs7U9PKwWd3w2jDRJsS+j7S750BLWDNdtxpL1Gf1rnXmTUiqGwDMwPAqPaiAGl+PIqDebpdE4oFU2PVL8J+7Q0malMe3W7z69cvIStIXQ5LV0eZGsrIPGE36E6DD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDSPaiCBH4Ren4i/VLI/g4n2eTsnhzHQMLO4KXrTw9w=;
 b=S93Is+1eCRS7HkXNokLstLi/iIE+Y3chA3rAuwq43yJGKRR3g/wycKbDzactQ5+KGa0jf24sHveR8OjYAJJkJ7yTijUWZXC0iJ32JFOpjO9n+LQzxPtpS6tY9MnWa26sHJG8hFHFySGsgVRUTEXoVV4FPxyoW1zqskxUHfkR2s7UUTGvPgU6pJYJLObVx70hpsLs+tYWOvdkBmzlxEwgEvQN8sltNHZpuxIGt+o8AuPesH2laYG78DtSWwG3iUIgVO2t8S20N7h33mmKy9r8fKnMe7RwPc2lQd9zmyjV7GLDDa52Mxz5Xy0BsWhXm8bQQdZCLtlsVQnfj4hom0s1iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 10:27:50 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 10:27:50 +0000
Message-ID: <2dae069f-2563-41b9-bdcc-d2b54cfe2fc0@nvidia.com>
Date: Sun, 2 Nov 2025 12:27:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix indirect RSS action hash fields calculation
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Xiaoyu Min <jackmin@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20251030172404.1100064-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251030172404.1100064-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b48e54-17c8-460e-f43a-08de19fa795f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnBHaFB0eW13akJHUjE1c05QTEpHRGlicW1ITlFkNDRhQ055VUhVTkhOMFE5?=
 =?utf-8?B?U3hoUGFuYnNFRVJKRTJ6VUNhMzFZbUtjNTZZZnRtMEd4K3dBQWNGNGpONUQw?=
 =?utf-8?B?Z1FRUU9yeXJZQWsvbHovL0plLzdlbVRNL2UwV2JSa2pXcUhSL2gwRlJZL0NY?=
 =?utf-8?B?M0dENkYxNGhlb3Q5QWdQRjAvWGJWOUxDV3pqSEJ3dWdHWExCS0FlTFRwSDZG?=
 =?utf-8?B?cGNYY3RyRG9yVTUxUFFFODJ4YzV3bUdRSEtuVFFZYjVOTkpuN3kwM1ZBYVEr?=
 =?utf-8?B?L3lyaHY0ZlhFOEdkT3IzMWd3aEo5anJIWHkvV3JUL2RVV1g4UkdpTEJHV2Nx?=
 =?utf-8?B?RE9PUUxFaVBreVdYMkE4SXFoKzUxcTZQQUR2dmlCd2Ztd2pKaktjZTJ0ZjBJ?=
 =?utf-8?B?WGFhci81N3FlbDI3N2xXWHlyZ3h4N1Z6US9kZGlMNWdaaHcrMzBSY2t0Ziti?=
 =?utf-8?B?Yy9LTlVGTEQ4WDk2R3FBMkRUSGxXMDYwNkw4YzRlU1lSU3pTU3B5WHB3elBx?=
 =?utf-8?B?WFlscVBEanpwVTN0dkxxWnlIOGF5bmxQZHZjMWtUd211d29ZNko2eGdXVnNO?=
 =?utf-8?B?NldnZWRUbjNyQnZkUCtDaU1vYVRxNUwzUEpSTkY5YktFU0l3cmp1MFVVVVd3?=
 =?utf-8?B?dzY3aHJXRG1aQVhBcHY2QUNZd1paRExKTkdVZVdZS0xCWkxFdG9VQVNMMGsy?=
 =?utf-8?B?S2tFcTFNN3ZnQjREb1J2bnlSMWpCcDNCVjFWSjZqaHg3SWhNVmtKVFB0d0xH?=
 =?utf-8?B?empQMDNIeHZJd0VlN1BOMU9BSnBkVmtZNXMwM3p5K2ZEWDJuTmpFWlpCRHlr?=
 =?utf-8?B?QTA4WC8rcDBJaERUbkNVWW13YzRxVjMrdW8zWk0wbE1qbEFIcmVmd1Z5dTNS?=
 =?utf-8?B?bHp0UVhXLzRxRkxrcEFZUVk5ZDZ3TkFrMU44MTl2cmpiZTJ5ZmlDMU1MeU9I?=
 =?utf-8?B?eG1OV1FjanZKUkdoT24wV3JsNlRoSlcrVGpiZUxKcy9ROXY5QWZiL0Zrc3JC?=
 =?utf-8?B?ZkhNT3I0d0VNd2pHM2ZqWEVRZFlpNGVEdmNIMnNiWXF1bDk3K2FWK1MzRDQx?=
 =?utf-8?B?bEtmNzlBaDh1UG1iemVxU2p3UU12MnR4RXc2ZllxRkkzYjJLU3MwMDRoN2FN?=
 =?utf-8?B?bjFsL3pNMW5xYkRIZHJEZk1sbXBRdWs2azlOS05IT0NlOWxsZldVQ3ZXMURn?=
 =?utf-8?B?NnFsWUhwMEJCb0orakduR2VNb1VGZzRCMUV5Wkk1SC9KemFIdnhOUFE1K2FS?=
 =?utf-8?B?N3QvWWQ3bHIrL2htQUVWemxDenJmWnJBYy9QeG5lT3R3cTk0OXlKc1Z3L2hZ?=
 =?utf-8?B?N1FwYllhQTcyUThSMm56VXA5c09JNk5HVDhubWRiUjFPbVZRQnBWOUQ4YSs1?=
 =?utf-8?B?T09ORXd0WVpJSlZvUm5zUkZ5NHhERDhjWlREZFN0QjZQRDYyalZnanZBNWxJ?=
 =?utf-8?B?UUMxSGdSNGkyMlQ2aEdvbzcwQ1lFZjMzMGk5YmtSYjUwZlR5b3c5djNhUkFN?=
 =?utf-8?B?TWU4bnN2UndlOVYzOWlOdEwzd1NTbG1VUWNNVnZmTm5jVUQwMDZqMVdkS2o1?=
 =?utf-8?B?d0RzdW9sdnRMZzI0ckNvOW9ORnQ3TFI1QWIrMHM5UW1HeEluTkRCWUkveHhV?=
 =?utf-8?B?Z1lHdVZ6TVJLRnhubEg2Z1FsT24vbmswRmxpd1F5Wk1nc1E3d0N5MjRHSG1m?=
 =?utf-8?B?bVRGdkxYVFNyeWFKU1o0aUdaRnJPWGRXUWh3WWpFRjM4U1l2SVdRMS9TTjdw?=
 =?utf-8?B?ZWwycXRsVmQrV1B0UlhkeGU2U2pSRGVOMURXSTNOZnVPMjZpZnU3Z3g0enpm?=
 =?utf-8?B?N3FJbFJ0SG0rNGtCclpVSEhRVThCVGhDQVpEM3d2a2N2ZlFNNlJHcmk5TFFH?=
 =?utf-8?B?d2kzREdDZXhsNEVUZnlLcHZod2xQWHdZZ1YvOE9wc1FnTDNQenR4OE9tcm10?=
 =?utf-8?Q?QkSy8lOk/kz17UpNyT8BQs6wJJ2Vnngs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2J1VEhkZTdQQTU5Wi9rS09iLzgrR0QyeHE2QWEzbStkczFFUXpDOG9meTJs?=
 =?utf-8?B?cndMcmpJYnIxdVg2bXVJQ2EveTh5V1VOaGlQdE43UHRqeHlTR1ArUUVXWUxu?=
 =?utf-8?B?UWJOdHFWYmFRczBJbzVhd0ZrL09GZVo3SEh0R1A1REFzQTdPK1NvR1U0bWJa?=
 =?utf-8?B?R1VFV1hJckhIcUxuNVdlMk5LRVVyM2FSOEVRVlIxN2tYZmpJZUdTWFp4Q1Jt?=
 =?utf-8?B?czYvbGo1YURIRE9hYWxQSkxGVXFJM09ubTRQbUJXais3eTdmZlNGSlFJZVht?=
 =?utf-8?B?NldyclFKcjRNcDhUNFR0cE16NnVSazVUVmYrYldGb2NyWFFEM2IrUTNrTlMv?=
 =?utf-8?B?UzF3dHU3MWtRNllFODdheFN2Yk5wcFY2d2Fha25CMHVyZmlmQU4xaFUxcXR5?=
 =?utf-8?B?V0pzdDFwSE5uVUFGc1kwb3hsUnY4SnBGZ3I0QzlZNkp6Ulh6NlBuWlk0bVBw?=
 =?utf-8?B?alhWcFJxUHJRMWtFYnNGZXZFMHVCOHdxZWJzajZ4V3NCRnpzNjFXaVVoRm5K?=
 =?utf-8?B?dzgwZEFZZVVqZlltUWxuTUtNVTQ5WUJRY3RyKzFTWTlwWGVBZjdpcmRKS0hx?=
 =?utf-8?B?V24zTm11MTUveTVvZFg4MU9DOUV5VjN6V29mallPM09MWm84bXRXRmphWGFK?=
 =?utf-8?B?QjlkMG0yc1hIaHdhL2RjRk5oSTNIU3RGa2NjME5jRzZtWVQ0L3lRdnF5WDJo?=
 =?utf-8?B?Uy9PVnFFTXI2RkJ5eS9VVVM1ZnpQQVN0VXVIRmxaR1ArWHkvUXJCdDlSekxK?=
 =?utf-8?B?U1ZLTnJHTE42YWplT1Z4NEErUjVDWVNXYWFXd1BuVTl1S1FoLzlQOXhqRkN4?=
 =?utf-8?B?WStKc1FHbHVqVjlua3dCd3BSalhBWGRvKzlVbE9kM3lQUFpSanVsYUpLS3Vx?=
 =?utf-8?B?NXZnb1RCeWozMVFLcG9BdkhjQ3FiWlZGMmk3VngxQXdEWkh0RjNxQWVPZWhD?=
 =?utf-8?B?SUo4N0xoOGtTdGJnbVR1cytLL1QvbzJ6eXh4eWNaRjFXZFZidmhDd0kwemMr?=
 =?utf-8?B?UEZaUkJhc3ZlSzg0eGh0ckNZV0REM2x4NWJYK3ZEVEs1V09NUTZIWFBqVTJE?=
 =?utf-8?B?OVBOK05NcElCeTc5RXpwdFF6d0tVT2JKT1F2MHNLcUhyb0RlWGIwSGxWcVl3?=
 =?utf-8?B?a2hMcUVwQ0swdlpNZlRkck9VUHJvbk55V1hIbVZLMHp0WkE4NXB0bi9KbU9r?=
 =?utf-8?B?aTlrR0tEeGpBV0FEb3QremJqZDBjQkhyTDhjaFVKbkExc3lHenVWZnpWb1F0?=
 =?utf-8?B?SWpUNStXVyt1SW5wNUdJRkRvb2ZGcjV3djQwRWMyMGkvT1NnYi94SkZwd1Vy?=
 =?utf-8?B?Ylh4OXRQS2xFZFJ5YTc0TXVGKzdYS3B6dndzV3ErbGlPUjF2YkRCb1EvOHlj?=
 =?utf-8?B?dWljcEJsRDl6aTBjRzNZeFBVNGJyOFVHdDlwN1loV3BxNHduRFFDWWtHVTNH?=
 =?utf-8?B?YWxneWhUa3pTbWVjS0htNHlmeU90Z0gxYVA2dlZJWENId1d5d3E2cGN4cXhw?=
 =?utf-8?B?WHZMZTFta3l3RGZHdnBpYy9zajZhakl1WERQUmR1N0xoTW51STNsNXdQb25W?=
 =?utf-8?B?TkEzV1hId2dsdmc4eklJc2pnMStISENOd1ZxWDhJRExWMmM5bG4wUkFNcHNq?=
 =?utf-8?B?QmNleEdsSG0waXNKZTgxbTREL3lGNDQ5cXMwblNxVm5XeU15UUVRRmVMQ2ZE?=
 =?utf-8?B?K056UUJ0VTd1QUxSZmExTE9FVUpjV3I3SVZmTWdhbmlhWkJtNWVqK1o4d2Vh?=
 =?utf-8?B?L0dvaGNzSFRrNDVMMVRoZXBGRUtWVEFLSE5DRWcyUy9FQjZNb2FUZmk2TU1s?=
 =?utf-8?B?dGl1eVZrTHkyb0ZyWVNlWnZ0Q2QrVnB1YWwyV0svK25PZ3BzamZFSXNqbGky?=
 =?utf-8?B?L2x5bSsxYUdFS25xV0FrQ3I5Vzk3QXRpeGpYNXdNMEkzSi9ubDdJTDNYa0Uy?=
 =?utf-8?B?MDhJZHhXY3lmU2t3SUE4UndYcUxDbVp0b2xwc1I5em9xL2J3a2JkQ2RScnRV?=
 =?utf-8?B?eEppS3AyUWJqNWg3WGptckt0QWVjV2xYK3RHWlhGVXp6MjR6aktQa0NINmJz?=
 =?utf-8?B?U21NUVpPQWdhL25wcEtFN3g0Q3FFSVJmRG1XWnN0YmJoMHpvSkhDamZ0c1J6?=
 =?utf-8?Q?0z/TEt4J5EDh1WnfN9049btEX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b48e54-17c8-460e-f43a-08de19fa795f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 10:27:50.4689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfP+NLAMFJElBMocvQIvzKiw17VuUneEeGOCSF5wPKd5HySID2jlWq7Vm3RTlM4rkbotwxbOslcearfaYCTQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
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


On 30/10/2025 7:24 PM, Dariusz Sosnowski wrote:
> Whenever indirect RSS flow action is created,
> mlx5 PMD creates an hrxq object (abstraction over HW object
> used to configure RSS hashing),
> for all possible and supported protocols combinations.
> For each combination, the hrxq configuration is adjusted
> based on RSS hash types provided by the user
> (e.g. hash on source L3 address is removed if user passed
> RTE_ETH_RSS_L3_SRC_ONLY in hash types).
> 
> Function used for adjustment, flow_dv_action_rss_l34_hash_adjust(),
> had a bug. If user requested, for example, hashing over both UDP ports
> and only IPv6 source address, then RSS hashing was configured
> to hash both IPv6 addresses. Adjustment for RTE_ETH_RSS_L3_SRC_ONLY
> was skipped.
> 
> In HW Steering mode, this resulted in failures to use such indirect
> RSS flow action in flow rules created through template flow API.
> In this mode, only a single hrxq object is selected during flow rule
> creation, based on actual configuration of RSS hash types
> in flow action.
> Since hrxq was created without applying RTE_ETH_RSS_L3_SRC_ONLY
> adjustment and RSS hash types contained RTE_ETH_RSS_L3_SRC_ONLY,
> then no matching hrxq could be found, resulting in rule creation failure.
> 
> This issue is addressed by the following:
> 
> - Missing adjustments are added to flow_dv_action_rss_l34_hash_adjust()
>    function.
>    This function is reworked to check each protocol type separately,
>    instead of using switch case over all combinations.
> - Code for setting/looking up hrxq objects based on RSS hash types
>    is reworked. Separate switch cases for possible combinations in each
>    function are replaced with a single one.
>    Additional logging and assertions are added to flag any invalid
>    or missing combinations.
> 
> Beside that, the existing set of protocols combinations set
> did not cover RSS hashing only over UDP or TCP ports,
> which is a valid configuration.
> These combinations are added in this patch
> (new elements in mlx5_rss_hash_fields array).
> 
> Fixes: 212d17b6a650 ("net/mlx5: fix missing shared RSS hash types")
> Cc: jackmin@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,


Kindest regards
Raslan Darawsheh

