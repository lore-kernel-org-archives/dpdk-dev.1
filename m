Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B19CEDD93
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 14:30:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FF7840265;
	Tue, 18 Nov 2025 15:30:11 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by mails.dpdk.org (Postfix) with ESMTP id A919F40150;
 Tue, 18 Nov 2025 15:30:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRZSofiISixxsn/Z9qGCOiyEjl+ovEGz642s6fbjpAAdx4NSy2w3tbTS4MYK+kbo+y5vLSmD1UM5edjLBJPFLzmqP2raTz9CvP/2tHZ185eIzanU9MwEUTHLhxXee1/nfDJcshNTM4RtfidMGqq8QPKeqVGt/cuaKV3aw4VfvGimAkHyOKbZyuqkUcidJ0lqr5+MLBS4iRWhGbTPmm0Pqd73zOaD0raPNHGY6X62jebL3oamXtXsz1143uWYw/w1ARCIoJ9uEKpNkVId88BfRdxpO6CWtzqfFIQ96Kuq4GvzdSXIOTWu2cra1Pjh7Rtd1Ue8QSuT7CPSskcqAmGpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCLHhBVQsHTdioH2KZmLDsfOvpoMgftSGAMB/q2reBM=;
 b=ClKOLnOn5iXUPd5unsh5EDGqFCo1GPLmHBCiC+3hcSyB68S3Px0t2DgxlK99S8e4AFm0vHRuxCEuFCCajFxn/oI77t58g4Q/tfJI7zUXi5tl1Wyf8mySeP+KNeSEfMziuNUZ+68nLR7MuRpTVSqO5fOm0+s/sEWMNA6d01KKnAJ//HXHOPNsrpw/NV5JmST9nQnCblYWFcV5/mahdxg4IGDea0KRjGaG1JseVhjPH8zwcESoaToKOPBMjYWp31D1aP6P3DdEfReNnW8l6XIvovdrssbaR4ixWuxBJnxfRQg8g04EOss+jz4vLhtjlew3oooLkMDB4L9XKMnkAcu/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCLHhBVQsHTdioH2KZmLDsfOvpoMgftSGAMB/q2reBM=;
 b=eu/3loaR9EViJxGGEsrpBKzOa0DHR1SKBJUGiCFfANRkFlh6Sem78UPFvQgZMW02wnBOXIKGs6wuFlaoGg/3hm8oOsVA8upHdWozDwgb9Iob2EFBSRWR85NWw7CHRlfvBoBfUKP3janj2Di/CYf1jgwMrtcfXwFYru/BOaSsqY64xxal2Y0Wc3gH1AII3C5UzsvhzhtIRSOPLCsloFOiVqSzv3xYvRgzg5itB1jDPb0QOvrkc7R8bV1e8/XvSrGOvEHows6hkonoQTeOXvOgEFjMNeT9BzXGhs0O0L2ENYj57Rv9auVQf2HIXiRyvpqawhSrmbuYbskq9gtQHpco+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 14:30:05 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 14:30:05 +0000
Message-ID: <7bd48e1f-fc2d-4572-8897-b8b099a23c63@nvidia.com>
Date: Tue, 18 Nov 2025 16:30:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5/windows: fix match criteria in flow creation
To: Itai Sharoni <isharoni@nvidia.com>, dev@dpdk.org
Cc: thomas@monjalon.net, bingz@nvidia.com, stable@dpdk.org
References: <11095513.IZOipudI63@thomas>
 <20251117084500.1276-1-isharoni@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251117084500.1276-1-isharoni@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d279e4b-99b6-434c-ceac-08de26aef789
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmF1clVFWjVWVG16a0N3MTZkTm9sZURDb2owKy9NR1RwKzdxbjhEZmd0VElR?=
 =?utf-8?B?Y2FDcU5sZGNIY1RacFBCU3Y1WUs4SnNubFNrSmswOTBaRTd1SzZsWDNJa2N1?=
 =?utf-8?B?UHBTMTdteUZOOUEyKzlOYjhVWHJwbnhJY3ZhNmFSUjBNZ1I0VnJvbDB3VjRi?=
 =?utf-8?B?eFg2RFRjeGlxWDV2QVV2K0QvNTE1RnB5bUhMdG1EWUR5a3NvakdZVFJkQmRi?=
 =?utf-8?B?Q0xKYVZqcytJSmM2aFE5WXhXM3JMK00xTktHVDlITGg3dllYa3N1M3cxNGpV?=
 =?utf-8?B?aEp2dEdPOG96bDJDSU1aeHMzRXJWY1lheHpBOHpmNmIyOEV3VzVIcXphMFFm?=
 =?utf-8?B?YXA5Q3JRdnBCN3k3Y3RNQ3ZiSlJsR2l6OGsxSzg3VkpCeUs0MG1GY25kOTkz?=
 =?utf-8?B?VjdsODFLWHlNeGExd3prZ3dZcmhoaUhrVndVaWtlQTY2ODhaUGxvejFtZllp?=
 =?utf-8?B?NnQzREM5K2wyV25tSElSckJqa3YwRnFxUG5VTjZJNnVkcXdpUWU4aWwveUMz?=
 =?utf-8?B?dUdnYURQUUJyQ1kwWmxjSHN5K0lpZk1TcFRDZ0VzTTZ3Ui9vbEVSLy9hM3Iz?=
 =?utf-8?B?Umw2czRrT3NuRWFveGx5LzlScDlzcnJDcmtkU0lCaVRGYlU2Sy8xNnpRMnVD?=
 =?utf-8?B?d3cxWHd0Q3o2SC9sYUxoWk1iL29rUmFYMlNJbTFJVE91RnBRTlA2TWJMa2R6?=
 =?utf-8?B?bHA3QTVyaHVmZGJwMEdldEErdVpoVTBxWXlpeWdMNURhM2UzZGZiOGxFL1hT?=
 =?utf-8?B?eTQvMFBBNjRsNy91Q2NmTWpTSlR5bmswZ2hvOFQ0NTZjSzYyeVBlUmxCSmxx?=
 =?utf-8?B?U1gwRFlSYTkxRnp6ck1HUVRyMUQ2WXF3ZE4yN0FJayt3UHZKUG9pZWprRndC?=
 =?utf-8?B?bk5tK2JGMklleGR0TTNtMGVja2UyUU5nUldVVG5wOVdWNTFlQWdDUVdIWHhi?=
 =?utf-8?B?V2FVUkRpNE40WG5Za1Rqd1pka1dkZDNXSXBPMGlLYmtIUVNUUTRRb2srbkg2?=
 =?utf-8?B?L09hc2dKMXNySFJqeVdYTDlndG1XaEZPNVh5c1NseGdBcFFXRkY3cFdsOXpJ?=
 =?utf-8?B?V2lrOENnbUIzbGhTRkk1NElBYVhFK3Z6eVMrY1RhclFZY1F5MU1Fb2VaU0Ry?=
 =?utf-8?B?amIydEU5QmcwUEtSdlpKTFhNMmlvWHNLS2xwSXNYVjVzVTRZalNIRHU2aWU0?=
 =?utf-8?B?U3U3bXhwWEhsd2JHRlpNdXE3OXFobHgybW50NTNBajYwZ0lHbWpKQ3dMTDRi?=
 =?utf-8?B?WEJ5bHozZjlUZU15L2NQaU5haTZ0VlRNejBWZXVBNWdRTitmRnpML01OeUg4?=
 =?utf-8?B?Q1ZFTEJXKzdnMmYvU3M0QWZUTUczakNnWG0rVDhxSkMwNTF5NXhhZWY1ODZ0?=
 =?utf-8?B?VWc4ZG92a0VsQ2tBQ2cxWUQvWXliWnVFbkNxQzlqMnhoaXVzUWVzZkdXU0dr?=
 =?utf-8?B?OGdVZlQ1WGlqYnRKQkRRWUJwaFg5UkVWOVIrRmljbEZNOXFNQmI3VnQzUlo1?=
 =?utf-8?B?SFFZZzlGdFdnS2ZrYmN3S2dWWk5qZXcrb21YYVFSdkkzODBjZHdkTkJCN0c1?=
 =?utf-8?B?ZWtTTjRwSitKY2pIZjdwTDJkb1JJMG1lMTFpNjFZTTl3c0ZCZFFyalB6VFF2?=
 =?utf-8?B?QnUyQmhZdnlkTW1EZHNEV1Y3V3RzeEFjQ1VuV3A0OHh1WFVBMVlrenptRHNF?=
 =?utf-8?B?U3dFWG5GdmFkZzN2V3luQjhrOFkyM3VVTE5xQzEwTURGYVQ5aTZOUVd0Mk16?=
 =?utf-8?B?R0dwWDJ1eldPZkd0WTZoNkZVQ2hUVWZXOS8wU3B4NFZXRE5kd2JBVisvRkFB?=
 =?utf-8?B?aitZbXZadDFGWkRmM2xXS2haMkhwRzhHRVh5bjJBTjFQMFRKZ0JpaUpyRmt1?=
 =?utf-8?B?L3BmSjZpTnUwRG5rZFg2WnVKK1M2aHJiRGlMRXpBZTRaTEZPei85T1hNR0U5?=
 =?utf-8?Q?yaTEiSpLjWvkoisdx0JwlAkS5WDOVVoW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkc3dDhDeHFrOU0xZkhMSTB2SHQrb0RvVkJ6VmtPUmlhcytpRVRXSDhNYURh?=
 =?utf-8?B?WkpYM2lKOUpCU0ZVZXFtaUFkWjd5eU9GcTBmcFROVEVJYXRzTW5xb1I0cjZo?=
 =?utf-8?B?eVpISFlkMGF5czRzZXlmSE9xMGo4bEh5cUFiTExSMGNWcjQ0ZHdOQ3h0Zkto?=
 =?utf-8?B?elZ5OVcvL2NRSlhWekRlOGRDamVacDZudkpvd0FUT09taGF2emZvZy82L1F5?=
 =?utf-8?B?Z1R6QmFnczZ4WXAzTkdBd3ZoS1lyZUdKU0pFSnpTVWhHZTN5cy9GbGsydHBj?=
 =?utf-8?B?SHRLYXJIWnJJc1Z0UGhrbnlKMUhnYmQyOHJxTDJMSHFsaE82N0R5S08xQ2Zt?=
 =?utf-8?B?SVVZVHpKcUkvQWQ4QnpGYkhwaHdGSXlXRHYrRjE5MnNhRHlrN2k5em5IamxE?=
 =?utf-8?B?VFBHMStETFZBbkdGaFRKY0lZd2IzTGhHbG8vWmdBbXJoNkJDWUUzT0FFNGdS?=
 =?utf-8?B?eExzWVo0YWNVaU5BZHJrNkVaNFhWTVpyd3NIVkI1WHNhNzZXT3VxN2kwbnE3?=
 =?utf-8?B?OUlwY2IxSTlMMlFWNEtpbGlyYUV1NGZ4TGM4a1hMMDhxSCtObjBURnZ0MmUv?=
 =?utf-8?B?M3hpZXhsSnEzNDN4d24vSmx1YnNQL3VjRFNCRG5FY1N2QVdKYlpCdUJ2Yk9M?=
 =?utf-8?B?VFZ6SEFQMmZXbFNONDFVckdXUFVkNUFuOFhkcTlEYzZiK0xvN2I0L3ZYbm5Y?=
 =?utf-8?B?ejNlZ21lT04wQkx2RnppeDdiV2xQc0wvRnI4b3FscUlENy8wMkFBdW9acGF6?=
 =?utf-8?B?ZjhYSFI0WnhaTEFlV2NEb0dlNWN5a1M0VUFxZzRrbVBDK0ZpUmErK2s3U0Y5?=
 =?utf-8?B?a3ByaWxGenZqcXhvU2YyNTFmYnZVK2s3blh2VkMrSC9FQXRWS0pyTDVSL2xh?=
 =?utf-8?B?dmR2cmlJdjBBbWN2RzBtLzFjUlRKdERYb0xoY3NmSkdBMGFZK0sveG1NNURL?=
 =?utf-8?B?dE9XbVJhc0tiYkdEbUdvNmpldzlNRGpzeDhtNjVJeDEzRlFKN0lRRDY4cm5R?=
 =?utf-8?B?LzFHUGtraFZVcERPbmNjVXN0ckVNZUZNaDlZMW1UdS9JMThidGpRVzhVK05S?=
 =?utf-8?B?dTN3cGNvM2JDMTNXWjB6QTJ3aWlLQUZHZ1lwVndHUExLZTR6aDdnMmFDT09j?=
 =?utf-8?B?c0krL3poN3JUN2pHekFscnVWS0E3Y3VvUE5VcE9JMkYwbnR5ZXdoRy9tZ0xx?=
 =?utf-8?B?TUlRbThKR0RSTllaaERwOHZyZ0I0a0dDazh4eVl1ZnlJa1VSbmtjOVJRUGVN?=
 =?utf-8?B?UHE1RG9SZGc4NE5lZEJSWk5KMjhmZ3VVUVdhS2dNN3RQY25oR1JFL0k0Y2Vj?=
 =?utf-8?B?VkZBQSswL3JWMEExNGluem5xdEJMdGhlSkRQeFIvb24vb3grS3ZIclVqRXJF?=
 =?utf-8?B?ZkFpQkJraWhUMUJhaDBIYllJNmRnTWdHQkluU1FNSVhobUpIUU13TUJtSjBS?=
 =?utf-8?B?NnlSaDdOMHlKdmdrbGNVd0lEK0pLQzk5dm5NUE9tMnp5UDBJdUhJUXhLcmhX?=
 =?utf-8?B?MXBjWXFyblo4OTlpTVlrckhwRjJkK2RGYUhNKzBaeW5SaHJ3SW1YL2thS1Rw?=
 =?utf-8?B?NVVoTFkvMVNsK0Z3aytnb0lOVGZsMlY0KzNZMHdEYldSU0YyakhLVDk2LzNO?=
 =?utf-8?B?MlgvOFpKVUcyKzJxVEJVT1Nhems3RG5kdGVGREUxVlRPbUtHMjJjV2JxMlFQ?=
 =?utf-8?B?c0dlYmpLbGx5RDdzdmloMFZMQUtMeSsrejFtNGFLeEdZMVRWTnA1MzRwZ3hI?=
 =?utf-8?B?NW5SWE04YTBsRVFxWVlNOFVLSjRuZUFKOStCQUZMU1hIQnBSV2JlTHFENnk2?=
 =?utf-8?B?Z3UzQTBWNEZxaHFmTk5YQlQyaUE1amsxN3pMOUwzcUNvZDVFazc5NXY5dEsx?=
 =?utf-8?B?Y2EzbXdNYzQvdDIwY3hLSlhxWnR0UVhwL0F2b21oZnlxUE5salhGUjVZV3g5?=
 =?utf-8?B?WUlqUTJTb3Q5VmZMc3J3RTJEQmJwV2lVc0dnY2t6dnV5L0FPNmJRMDlySk1P?=
 =?utf-8?B?QksxMFQvWUhQZmtRRlh3YkRMTytZWFV1TW1wZVVCNG8xY3luRXdtOERLZWlz?=
 =?utf-8?B?bUM4ZzZSeWpNUm9DSmJoSDZVVXFJazNWZ2dGYVJqSVJWeTdEY29FRC9iTGk2?=
 =?utf-8?Q?EI65uo31NwwK72QMPqK2r3ISM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d279e4b-99b6-434c-ceac-08de26aef789
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:30:05.5394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dta4i2eQUgtWGTItxAcNb3v0QXq80Ns5zl5kA02+x0NZrXLxL02A5/5ls95ZZG2eUdgRYDq+V8vlclBMeWud8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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


On 17/11/2025 10:45 AM, Itai Sharoni wrote:
> Currently the Windows implementation hardcodes match criteria to
> MLX5_MATCH_OUTER_HEADERS when creating flow rules, which prevents
> matching on inner headers and other criteria types like NVGRE.
> 
> The fix uses the matcher's match_criteria_enable attribute instead
> of hardcoding OUTER_HEADERS, and moves the assignment outside the
> action switch block to apply to all cases.
> 
> NVGRE item type is also added to the supported items list.
> 
> Fixes: 1d194496b9d1 ("net/mlx5: create flow rule on Windows")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Itai Sharoni <isharoni@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> ---
> v2:
> - Added documentation for NVGRE tunnel support on Windows
> - Noted requirement for DevX dynamic insertion mode
> 

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

