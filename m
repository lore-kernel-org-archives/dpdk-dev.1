Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241F2C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 06:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70E74402DC;
	Mon, 12 May 2025 08:24:57 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by mails.dpdk.org (Postfix) with ESMTP id CA6524026A;
 Mon, 12 May 2025 08:24:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzbwRLGQCVbm0GFqkMYgyVfXNbodjzQ0U8EmCYiehzZB/P96Brj2jZS5KkwEVzaMRxytTIrwSBPaP47vci5LAFQgC59HZVpfKU/in1a+2cRNHuSsChkNLEUUZEku0i6wYk7UrahPAoMJCljro8lTM3SQTYXOEBIXxTi7Q+Yo8PCgI8htDUCprlw4k6iIsV7QsllM1xkcYpltoORT/pzkWM+mbiu5aNXyTJmBPpr0FJz/nTkWxTGyvR4Bg7tFhME1Cud+IUXWzLtuJ8eouOA005Qkp3y2Cjcf2oTju1cN3cglqLoTJChIL5FifRtw3qUhnYT7vXmkcYPoVF9GDM0Ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZzmz6zh6Zdx4SSV3v8mreZQGA6wle0bbu+UdlKDFM0=;
 b=BaQy05zUOT1gTjVCuECjd5QpgMK158aiD4gLbFqik+SSCoGJYIhrwWINeWft4BCvy2EBk58ITybYswIMDeVVS2VGqP16bc3sTcVJQf5UJHuP9uwsTnXkBq/f32ZVtPoLIXvQt/+OUENGZsV7l0Ts0/7DAjpgT85xTPFtpEoYs9LA78XlpvkPovNBsZxmgdh92SrIRxADQEEjkpx6NLJ1j29wSTCOId0SWrqaWGUkQYx8w0N6JgXuEGV73nHZQFUslHb1fNJNzYFO9GjIH9iYKQ3vbY0kxWdVFgFfx2up/Kr2fDWXZwIsPTp+iwKtxR5PlZhK2fXp2bCxSRg5YdTejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZzmz6zh6Zdx4SSV3v8mreZQGA6wle0bbu+UdlKDFM0=;
 b=SNJMDH8/A9IsCYzV88cjOFmJPr99KTezN6qiwXu55yUmluFC1P/DZOPrVP60ioVm7YBa0noZWh+2SVBcsxua96PXzWpf/iLX30NFPuO4L9XT6l6OLFpB3wk7Jo7yf/qta0WpQV+gNYMQCP5MVjfrqpn+3np+PoZXH8Cr6Jj0dBF0Pz+1Wf7yqvzySENk4tdLLzG1D1MF5Mq8m6BgyUtGVen5MC3/Bbgj+0aosutGD6BEaSSMLXCsIK9+HC2GvmZh0pfzjs9yFZeGlHaLuaezc0m/aGlD5GBCcd5oaqkJxTpZP+2jxp9UP3g3PaSuMGQX5KRgfnmcabfqCkpyi8yCbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 06:24:53 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:24:53 +0000
Message-ID: <e3b045a4-5347-4240-84b4-8dcf96fc7409@nvidia.com>
Date: Mon, 12 May 2025 09:24:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix modify field action on group 0
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250425193258.38994-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250425193258.38994-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::9) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c110e1-777d-4ebe-2aa5-08dd911db51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUREZTRIUWp2SEplNXEvZk9zd0ZNeWZ0TnE5bUl2eEo5ZFQydk1hZWZLR0FT?=
 =?utf-8?B?MXNzY1JIVnZyVU1YeEkwUkdXeGduVy9yejlHOGtHalBYdDJIYUFpUjM0T1NR?=
 =?utf-8?B?MFBwVlhiVHdsQnZadUhPN1cwM2c1bWVQWS9MblY5NEtWSUFwU0gzdk1sZXFs?=
 =?utf-8?B?UlFDMEQzMXdOSGQvUDg2L212N3pRY1Bab1JJWlhySzdSTFV4eUlNSUhidUE1?=
 =?utf-8?B?QUljbjBNRVdnOTFXZW5JK3o1UzVlVkY4UWZDTVJUKzhUcUJpVXRVSnFEdlgv?=
 =?utf-8?B?K1Jvc1o5ck5nTUwxbTV2RHN2Z0NKSVdyeFlZdFZEWG9PeXM0ODBBMWxjQzZH?=
 =?utf-8?B?SlBwRndIVkRSdGZIVzJRMzQ0YTFFajVvVHNaUHYrSTlFZzJNS3I2Q3ZEbXVE?=
 =?utf-8?B?RlNFOXJDZTMrQi83bnJ0cjg1ZU1GSDFySU9CL1RpWmlWV2gzWWhtUXV5V3hZ?=
 =?utf-8?B?N1Ryb0NrMUUvY1lybWZzRWdYOGcxQnIwbTVaS08zdHFmUlBSQi9oSzhQcEll?=
 =?utf-8?B?cEVhV1ZVSjlybm9VSXZXRWJWYjRLc3VHMDAvbDY3OTAwTEFHVW9WQjAxVTU5?=
 =?utf-8?B?b2pBVWllNVRFUU9FUHU2SUtGTUtoSUxPbStvemcwaHd1dzV6aU9QZDh4UjBC?=
 =?utf-8?B?V01XUmR6Nm13S25QZCtUMnlwZTk3L1NhR3NheEpEeVJJSDFSa1RKczJtWWE5?=
 =?utf-8?B?Y2h1eXhVTGJMVlMyWVN3VDZYUCttZjhBcm5WYndOSWVJelJpL0xVa0tCY1JP?=
 =?utf-8?B?OU8yL05nYkFHb2sxZXQ3WVVFN3FlNGxKSzlnV1l0d2pucFdqeU5adVhRTElt?=
 =?utf-8?B?Q0NmVzJvR0E0elA3L3p5WjNBYlJkS3JZWUNoMVRWSmNHUlhCZTBpL2lKTExK?=
 =?utf-8?B?c01FNGFxNExFajUzWGFPaVpvZkw4anZlQ2JIRUQ0a0cxWFJjc1E0aVlrZktU?=
 =?utf-8?B?MEdERXoyMHF1a0pqYkt3dC9aQWFBRXkzY3ZxUHZpQXRwZEEzdnpHYVFtWUww?=
 =?utf-8?B?SlZsbjJDZzVWS1Jra1ptc0pBZWVteXJ1RjZZTlBkUGV1cGpUeXd6Qnk0eFZI?=
 =?utf-8?B?aUlqZk9BY2s5SDRmNTIycm9OT2JuSWRhTjdFYU5JOXdsR1YvaU40LzYrZ0dq?=
 =?utf-8?B?UURHS1VZLzAxc0FqWk9UaFBRK2E2eGY5NVdoNm41b1pzZ1Mwd0Q3RlRNamZF?=
 =?utf-8?B?ZUhvU2ZBRm9aVVNNZklBYnhDalJ5Q3Y2S3c0Mk9rbDdxRGZoZi9XZTBKbkVj?=
 =?utf-8?B?R0x2RFJJZTgydEhYRmpkQnp6YVZPTjlvSTVUMVk4N0tGcDBoWVI3NzZoMFhr?=
 =?utf-8?B?dTduRjRJb0FzNDEzTzc3ZEIvcXRXait2RnFlMUtGbW93Rk5SelNTZE9xSTZl?=
 =?utf-8?B?OWF4ZDdwL1puZVFrYWU1aGdGRU90eDl6NTBsTTJFaW0vSkV5YTJvaUVrcFkx?=
 =?utf-8?B?NlBNU1FQSzg1ekl2NkNkYTVLbWQ1cVdvWnA2Y2k4SUhidzJCN3A2b3NPd1V0?=
 =?utf-8?B?aHdUayt2eWVBTUJ6ZU5HSE43enRGMU1YdGlUOUVDOHFEbXJTTG1ld0dNNjRa?=
 =?utf-8?B?eExWaTNXalltaW1xUEVqdzByUitpTDBwY2lxc1hxYndiNVVzbHgxT25GRkpM?=
 =?utf-8?B?ZVdjM0lNY25YaTFkNzZIM01NakhBOXhxZkUrS0ZPYjhCSkZLWDJPYUc3NmRT?=
 =?utf-8?B?Q1dNeXhadTNNUmtERSsyM3E3dXQrMnN4ekNRNG5sZmtHY2ZEYUlIZnZaVGds?=
 =?utf-8?B?MXNjUVh1SnA0SDk5ejkwN1FJYk94ZHlZTjZsaVNWdW9RTitudXJ0U3c3VEFK?=
 =?utf-8?B?c3ZKWXpkck5DanpOd2V4eHN4ZW5hRmdPVFYxNEdscG9LREk2ZHNLM2E4aXRG?=
 =?utf-8?B?TUppUG9RWmIyM3ZxRTEwcjdpTlVtUTQzNDVDcEFQb2hVZHY5VXFtV042VldF?=
 =?utf-8?Q?JWCsq1/e7+4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlUeUk5VHI2aVhidHUrMDF5YXlaQ1VPdkExR2xSOWFEUy9oNXFWRktINjFr?=
 =?utf-8?B?eCtkWFM3VVl4b3c2RnJrRUV3NFdMdk1UdDBYNmphZENxZWtQVjRqNDJpZ0do?=
 =?utf-8?B?ZlJaODdrSWJIc2p1a2FTTnJzYUdEN1Z1VjVVL1l1Y0NuckN5K01HZE16S250?=
 =?utf-8?B?ZmYvNTVOVjNPYmRrZEduTWxVUTlJSzlHTEFQZzkvR2dxR0huQldQdFEvUkto?=
 =?utf-8?B?b0lSbmhWaGhkYnZGQXpEMDlsODBLdmN4aDNXNHpkZUs1ZFdiODFqRXV0VDd1?=
 =?utf-8?B?V1RGUkFqTUpUdVg0ZjhkS2lYRHErZi9xZ3VRdUM0cG1wSzgvMkRyRUNSRmVM?=
 =?utf-8?B?elVpenFBTHFCS2ZFWURidTVzM0RPMVljb082OWtzYml4dVpVRHFycXN6SlQy?=
 =?utf-8?B?L2g2MCtVM0d0bWFPdGtiOXN1TFFGWEltSUJUaU9BL0lXeXVxV3d2eWZnWWZs?=
 =?utf-8?B?QlZFQ0x1TXdZRmtlb0tPT1AzSnUwVjI5VDQyVnQrMXFqdVl2MmFsT2Vrb25E?=
 =?utf-8?B?a1N4ZFZ5cnJiUzhGQ0Y1YzFmTk5rMThqMmd1anNraTcwNmZocThsMVhaM3hC?=
 =?utf-8?B?ZFEvSXJFd09RSk55bW1WU2pjZmp2VXY2WUsyRUdKWHhpYUdJOVBTdm9JTzZV?=
 =?utf-8?B?T0g1M2xkaTZCbWRVeFR5NVRaS1VkVDdsa1dwczQ5NjVZOEZKRmNuTWFFZWwr?=
 =?utf-8?B?TmhsRGw0VnNqQTc1enhPcDR0YmJrbmdBbTFOTTdVeVpwNHcrUkNHSzVKbU5q?=
 =?utf-8?B?VjJNbyszT0VvNVVlVzZBNHRhYkVpZTVXNXI4YTFPY2tzSHdoM2hlZzVlTHJN?=
 =?utf-8?B?RXhFK0ZyOWZYY2J4ekxmaUpPMitmYlNtS3FhSE5NSXpzTm4xOFpuemtZa3RT?=
 =?utf-8?B?RENhQzkxMWcrakpyeVRHdXhNdWJuZkYxTkRjM2RaR1M5Q1UzaWNJMmt1RGpp?=
 =?utf-8?B?VTUwb2RVSGxZeG9USDdaREM0MlNqWkNyTGs2RU01eTUrRE82a2pKUUtUWnB0?=
 =?utf-8?B?Z1czYjJwNkUrYkxubXlMeHk4b0tCSkpjQkZYSjI2Y05PeFBMTHZkcHRIR2cw?=
 =?utf-8?B?UXNRWUt1dnErWVBWV04xMHJUWEJRd2syRkFKOXdvQzg3RGtjbEY2Z0l6bkRv?=
 =?utf-8?B?ZlNvYXZQNTVIQTlxTVQwM1VyQ2loWUNzZ2NJS1UzSHBrSFlBSmJTZ3lwbThF?=
 =?utf-8?B?L2pTMSttbW1sY1Y5Q1RMUTNJd0t0bHNJTlk4cjc0eHBwZDM3UHFBOUtSNEpx?=
 =?utf-8?B?cTdNeXh5S3c4ZGMxMUNGQWNicWV6OVFqR05lWWg1b3Y1NjNGbmJLZC8zZElJ?=
 =?utf-8?B?NUJ2TGIrUHpua2xuYWYvSEtQaEN4aWJRZFFnb2paQjdIeUVjQ2dtWkhsUHdI?=
 =?utf-8?B?RTkrZmYwZHU1cGtOaDlPSitFd2grSGxtWm5GdnlDNyt2WXVSNWRsQ3lxSzZB?=
 =?utf-8?B?N1RBd09XQTllVGVVZW81MkRYTnk5L0ZvZE1XcGV4c1c3d05STXpnUGhnM1JD?=
 =?utf-8?B?VElJZDRTNGJ2STZlQzlLR29OUUJZMDlueVBtZEV2R21JWkdUWkZSL2p4UUFT?=
 =?utf-8?B?cFdRTEM4VXJuN3h0c1I0czBOaERJRzBzdVMvMndtWTdoRlZCcCtIZGNpUHNV?=
 =?utf-8?B?THhvR2IzNXVTUHFJZEIwVHZWYzdMTjdiOEthQ1MvVGU2WlJ3c2ZJbFA4KzZv?=
 =?utf-8?B?RVpJVXRyblNXWVA5MkVBd2dENjE4V1JhZWtrd3QrVlFzejBkWEZrRkhXSzNM?=
 =?utf-8?B?VWJoUVNjZDdNeFMyNE9iZjJhVktNSUZjODFkOFVIcWFjMU1TZVVJS3FHc2JH?=
 =?utf-8?B?Ynl2b2wxdVBTbGhocnJVL01YQjU2QkVjb0Z0VCtQM0JSbFJyUHljaHhHZCsz?=
 =?utf-8?B?RkcxR3JtL1p6TlBtUmJZb3JGci9GbEFBcHRHQ3k3NjhGR002Wk9GMTdRU2g0?=
 =?utf-8?B?VkFCSzdtMGJ6NFdNNmtMRVYwYi95UDllNmwwT0NDQXUxQlFWYmdva3BSVUZn?=
 =?utf-8?B?ZStieG9qRkZsakxjbHc0T0l6UUg2Z0tpVEI5Z1BFMFhqRGlpNzdVMTErUGVw?=
 =?utf-8?B?bFZhM3R0UU9aeEcyaVV0Nm1idGp1dVZiMHRCV3dvWGt5YlVKaUhmSGJmZFRm?=
 =?utf-8?Q?9C+OkEFoGMLwlBQ3NMmZWVLhd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c110e1-777d-4ebe-2aa5-08dd911db51e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:24:53.7379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0VQlkqI6mgZ2SCCSCjPh5j1+7lw6dwHgwn21Fnn7psvIKHIhYqah4MTy/+F08MaEPCyILNnzWQNeYQl9tvTmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
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


On 25/04/2025 10:32 PM, Dariusz Sosnowski wrote:
> HW modify header commands generated for multiple modify field
> flow actions, which modify/access the same packet fields
> do not have to be separated by NOPs when used on group 0.
> This is because:
> 
> - On group > 0, HW uses Modify Header Pattern objects
>    which require NOP explicitly.
> - On group 0, modify field action is implemented using
>    Modify Header Context object managed by FW.
>    FW inserts requires NOPs internally.
> 
> mlx5 PMD inserted NOP always, which caused flow/table creation
> failures on group 0 flow rules.
> This patch addresses that.
> 
> Fixes: 0f4aa72b99da ("net/mlx5: support flow modify field with HWS")
> Cc: suanmingm@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
Patch applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

