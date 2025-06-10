Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1675BC5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 13:19:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49A1642EDA;
	Tue, 10 Jun 2025 15:19:43 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by mails.dpdk.org (Postfix) with ESMTP id 0BBE74026D;
 Tue, 10 Jun 2025 15:19:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4T7FBjMviUnvEP6KqFETg0DK0Gxw35RuRxjz3YMW/Ow9kK6x9+pX+WDPbPuPTOXZW4EzynMk6E4t/2Z5T6LmA1ILNa9h7jwP8DtLt/W/JYo1QJkv6GWzWJHCDI7+YdZciXaAuxtdChyZmZE//7SWK6pSKRxubgcXCHCrgOS+tH5+RQlob/z5Ifam6CzYEWJ8QNaHVeUQeB6wcT4Qwkcz+zPYSsuFJ5h7Ijk/PApqImicHMMOYwzWImJyGVUmBQpXHGOR4yBMv+STf85JyykIVptugd3P24AD3Ws5R+yXDJ2VejhMPYeNWrBtwLCFQpmMovOMw+hTwS6WtdCjlMzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ft75JV54Fv6s9rj/hEO2C/GuLtkZfoNeYvfvNRBk7s=;
 b=S6gb09PKpYRZyGygurXl3x3wRLBW0yUko72Ep3EQ/gFyOF8ySkFbzbbCTd9QUOxEYR5oXe2uSxPVL2HtVr5snfJOWjkyASeH8UQhNn3AVxYA/206DDXy7Mt0u1N8xwy9cSF5Jfumf73yQ3AypDO0iyRj2PXqUpqrcylDHSrC7WxrRUyaZn2T4Zy4sfJBykGOLjX1PUcdn8xpmte7kNd3z3CIV4QEzkuDRMvdSYO2KoT8EeeEoItz5nhfDeuVDy6iBcckBb2XOtuoc1Qwi8zQyXF6nxan8Mo1vuvA3uvSu8YA/S0yCS6HbwAihP666mQgPqbiIV/NLYKulN84mpprzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ft75JV54Fv6s9rj/hEO2C/GuLtkZfoNeYvfvNRBk7s=;
 b=p2HD62R9EA7UrqKt3g8Vq3PD8KkoRu58tuhzzFzpqZtoc7INvD3QYN4s3BJuXwdDjsM4Ztrf/LSVx8jRLRdNBfNcleEB4fzQ35+SuDqAfnZbf0sbLUqu2mPcxgLkJ4YjWHVFsBGMmLDlJoNIQ9gUW3sTvRwbXVn/hPi1Dx2eBsYxhNdGaVmF7FGqxonD5KonhVwCgjynJHFGnH1C4OYUUCTOQHQlH3jWhhRVVyx3wLpdrTPdcXjdOb9abDxP7vrYtw09xaRmJuvu5AjNA2hA2ZOkGb3Cpkqc2wUtIMpcwbXlSVRfUnRhDiuKdFIM8Uuo4hHgD7D+mA+1sBxYR3rDLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 13:19:39 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 13:19:39 +0000
Message-ID: <ff5a85a7-eb13-4131-864a-114a87578248@nvidia.com>
Date: Tue, 10 Jun 2025 16:19:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix flag non-template rule cleanup
Content-Language: en-US
To: Junfeng Guo <junfengg@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, dsosnowski@nvidia.com, viacheslavo@nvidia.com,
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
References: <20250605100734.35936-1-junfengg@nvidia.com>
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250605100734.35936-1-junfengg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: eb589d8a-a647-42c2-2c03-08dda82173ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVhXZ3d1elM3UEQwdEhibDJhMnROSWlMV0YzWmpNOW9BdENmenFycVRoVm8x?=
 =?utf-8?B?QnZ1SzJscUNFT001ZmhGRWlFQ3BUdUJXWTRhU09yNkQ1QWEzZEVuRVNpME9s?=
 =?utf-8?B?UWlqN21mWGQrQ1ZvNW9qdTl0RHZRa0pxTE1CRnVHSHVtZlN2K0I1cGNxVHpR?=
 =?utf-8?B?eWtKNjNULzFlbUZ2ZjNxSWQ5TGx2a1BpdnJvaHlHK2xOcDNnbVNZQnowS25k?=
 =?utf-8?B?b0pGb21BbS9TSTFBRHBaRkp6ZXlKY2ZVYlZxZVpEWHlTZndPN3oyVHhYdTdH?=
 =?utf-8?B?OTRoN3RyUUtFemlETDdiNXFadHNWOHUzem1jU0liMEk0Q2V5bC9zcHRzTk5P?=
 =?utf-8?B?ZHJDcjIzbC9VUFFXYXNKb05UZEFsL3pUTGNpUE91UEs4eVIxcERHN2svek9I?=
 =?utf-8?B?Vy9nZStGVng1R3NiTENMYkUvb0c4dFFHWXR6QW1Hdk5SMlpyRlpOTXR0S3cz?=
 =?utf-8?B?dS9lbVRVSnAzWFpueXdGS3oyTGQwbGdIYTNQd1BwUFVCWCtLVkltOXFTRzhP?=
 =?utf-8?B?UFQvaEw1WXJISTZGWmZCZEZSQWJXdFNyRzN6WFpCY1R0UzBlVDllMis0eitm?=
 =?utf-8?B?Z0lSc2x1b01zWjlheXJoQytQL3h3K3FHTGYyNEgwcWFlWDU4WkZ1L0Z5TGZq?=
 =?utf-8?B?cmNnQjRUaXd0UUNYSGJkQS9jU1BVdExWUng4M3NNTzljaCtNZnA2ZDZsdlh3?=
 =?utf-8?B?ZDN6ODFCRlR4T0xndVRDaFNLWlpkZi9FSnlFOXdHNk9ieVJwMjhFSXRobUJs?=
 =?utf-8?B?RitlUURMcEc3Z0w0WEJoR1ZTN3dMYzBObkNINyt0SkU3YUlPQnlNRVhqNmR6?=
 =?utf-8?B?dHEwN2xqZWN4aWp6c1IwM0tGaE5wQWRIdW5tcnFNcjdNeUMwYjN3UWRlNmxJ?=
 =?utf-8?B?NlQzUytDZ3Fkb2JHZVFjMzEzWHVQUXZGK1M3VlIrU295TFhFNTRwcmNTc29n?=
 =?utf-8?B?YUZwL0g5S3VJalR5STdaVnBmS1BVcVlLY0NBa1Q1VGRTM2dZL1B4NElEVkd1?=
 =?utf-8?B?MHYzR2UwNmFMT3JDOXFua2Q5V3NGZnlpTU1qOUVqMG0wbjBmaSsyR2Y4MjUw?=
 =?utf-8?B?QTY0aVhzZHY3Q3I0RS9VTlZYbDdGNzk3RHBzeENwWFJwZ3pDMUJVS0sxMFoz?=
 =?utf-8?B?N3JhT2puUXY1UGE5OE9XeXpiZnRxbk1icVZqV3k4OXk1RXBoK3ZzcTNCeWVL?=
 =?utf-8?B?Uzd2S0IzeitGdG1VdGEyRXJyUzM3b0FTTkVqTVVKdE5zT01NWlVKT0dGQXFm?=
 =?utf-8?B?Tzg1U3NPZDJUc2RrdDFuUUtkSTdJY3RmaWhEMTlsclVlN2RaZ3k2bHJuT3Bj?=
 =?utf-8?B?NmY1cmd4dDRXVjd6eGlmMUJFcGlMMHF4Rjl3OUJUUm9SUGJCT29LU1BoekM1?=
 =?utf-8?B?QU9UTWhzY0t0Y0hGWXN2czlWWjdiNW9pelBUdXMvUlF2aVphYmw0TnE5YU5J?=
 =?utf-8?B?SzhDYk5IaW5kNGFuZGd5ZjE1cHlFQmZVOTVhZW81bzhacmhjVXhIa3JTbS9C?=
 =?utf-8?B?cldNd2V1R0NmRDQxRTl0eGw4M0w2SFJheEp5QmRuUkRIbjU0TmNtVThnMk55?=
 =?utf-8?B?emVIcnpndVQwMy9yaVZqK1N0RzhMVWo5eENuUlJvTnF1S295TGFQSGlocGor?=
 =?utf-8?B?THdGbUJlNG40LzdXQUFQcUJqV2tPSmVTeE1PQ2RvMjlKVmtDQ1VBTjZrakEr?=
 =?utf-8?B?K2xydHZOSmJnTFhxc0R0eWkxSkE1bm4wejl2Y2hGRDVFKzhJRHlMeGN2bDZi?=
 =?utf-8?B?KzJLZlNsZ3pPcDNGd1BSeTNyZHNsbEV0RFo0ZGtlTGRoOE0ybDhwQjB5ZWV5?=
 =?utf-8?B?UFIxam16a1ZCQlFaTXgwQUh3V2RhSmluaXlKYm9kUlpmRlEzN1I0b0NSbFR5?=
 =?utf-8?B?MEdEejFsNm8yTCs3NWxxdnBLYUt2MzVNcGQ2OGJ0SFkvSmNEdnNhN2tubGZx?=
 =?utf-8?Q?B+jUEsuavhY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmU4R1gvQ0JGVXJhaERvdjNieUtJRXp6TCt3cVRzN1ZGcDZ5bWJuakJZOVBT?=
 =?utf-8?B?RTBoVzdabnd5U1JZUFBzMllCOW9jZ2l5Si8vLzdXR2thM0IzUnVwTHE2Ui9E?=
 =?utf-8?B?Umc5a1NvMW9paWRjdVQxaVh0UlJuYngvZFZxM1JtLzBTKzM1WGdaZzR5bHhy?=
 =?utf-8?B?TW1HTEw5TmkyWm9TRUhmWDJNYTRlaGUzQ1lDK1RnSUVQemlWT0lnb3dMcHRU?=
 =?utf-8?B?TlYyQlJLR1ByZnVsYzhhR3VuNk5GYXMxVmpUcGRGT3JxRWlxbHVCQXVFRUZI?=
 =?utf-8?B?RGZ6ODhnaVBRdjlmSWNjUzduMjB2RnljeGZnclBGa21RNFVHYWhrUmEzUUty?=
 =?utf-8?B?QTFVRjQzcEErWi93dG1CYlN1ODlkSXJoZGNUZGYyZFIvOWhrT1laaDB0eVRH?=
 =?utf-8?B?YUNpWTlrNHFxN3pIZFBvaGpDUEEwOWM2enkxMkRGT2Q3SGZ1eER4ekdxejRn?=
 =?utf-8?B?eEpIbWRCbkROeGNBZGh3RTdycGNnSk04OW9rRGJGYVIwUmxIWUQzb0ZiS0lK?=
 =?utf-8?B?NHlHL3ZVMXpzanc4UGZFdGhQeUxvQU1WNnF6NWpQeE1xUTBUVDM4VDZTd0tL?=
 =?utf-8?B?aTdYdTdKUmx0R2VKZ2V3SG5hdE11N3AweHcrSkFDTXVqYlc2WElVQnh6WjRS?=
 =?utf-8?B?OU9nbCtVQU5DM2ZRMDlPSmx3UHFtUVVwR1EwT21xZHZlb3Z5ZytpYk9Ed3NT?=
 =?utf-8?B?S0lTeld5eW9VS0tuQU45OHdDWmUvYSs2MDYwLytxZTEySTBOMkFWVTNrY29U?=
 =?utf-8?B?azA4eUFtWkJPajF4Q2JTa21rNnpkK1l5WDMxc1I4Q0FlU2d4bkpBcXNUMWE5?=
 =?utf-8?B?VkdkMFpCcnJKOUx2TFdTQWxOdTJnVDVYdXdXUUQ0eTllcnhlQUZCQWhkcW5F?=
 =?utf-8?B?U1BpVUVuTjhFbVlhZkJOeEkzam9ZWFNtSmprZnZrYzdYQnpsQTlXQ1FDbyt0?=
 =?utf-8?B?SUo4NXcwblA3c2o0NzRTR08yRjUweEVyQ3hGQTFYMVRYSC9YbG1UWjh3dDkz?=
 =?utf-8?B?a21IWFlYN1dIY1Z3RUdWcW5DamRzUHNKU3NvdzhlUWZOZEdpeEJhUkRML2F5?=
 =?utf-8?B?TUNlZCtHV1RwZ1RXbUY1N3NxYkcrREZOajdBeUFYVlFEdlRzWUtZY2JBbzlh?=
 =?utf-8?B?RmxiYnRVNWFwUnp2Tlo1Z2h1bi9kQ2R1d0lMcTY5bnE1dzJ2dnk5c2U1WTY1?=
 =?utf-8?B?UStOQndSVmpiUm9ITGhqbEkwRXFrZlFCZDlWSEt3cG9XaVQvM3lpdFE0ZnZa?=
 =?utf-8?B?TGM0aDFYWThSdXpuZ3dSVTdYTUVBYXJoKzJQbTcrZGJTV056bmRjNWFhcDdH?=
 =?utf-8?B?V3hWYXhaSVJMdlVVRDRidkkwek5SRjhKYUpuSGViOUEyRFFMTkthc1NITWlZ?=
 =?utf-8?B?ZUhhSEJkQXplRVEzWWRRTEh1WFBucDd2d2JXa2ZhMEJQNmJCc3ZGK0lKeE5Z?=
 =?utf-8?B?RUdxRDc0Z243dllySVJKNm9uVHhjcE5KV0pTNFJ4bjRWWHM0MGd6LzJZdk5Q?=
 =?utf-8?B?S3dINzNKYThWZkhlUHNCczI0ekFLNmRxN2Z3R0F2VWlIWUl5S2g2NGFOdDl1?=
 =?utf-8?B?clhIS1Ftb21naVprdkVtdWNuN3lkNVlnSGJCM1BSQUgzaXBlYmJsYjdxNzEw?=
 =?utf-8?B?WXBtdzM3c0twZVYydjhUd0dydUVFcDNLYlcxZlJGREpjY0EwSWlwa2FJNUVU?=
 =?utf-8?B?em1HYW9wSTFLOWdOSU16OVQ0cm9uVjgvVVIwaXdHRmN3QnN0R0dBazNJYTlh?=
 =?utf-8?B?aWlhYmNxdFRyNS9mdHNNM0tqTVgvZzUwV01hWTViTitPUHVlT1N5dmtSeFdT?=
 =?utf-8?B?ZXFoTXk5Ulc3WXhDR2F4UnVSSEJkUDhnVFFNK2Rzbnd4WWRiSVh0enFtc0xC?=
 =?utf-8?B?ZWgvS2RiUjZCQnl6WHNocS8xUzhVV0g5OHRRVTluZHlzM2xYbHpzY2FOcm1F?=
 =?utf-8?B?bU1nYldBQmNtSUIrRDFqVENYQUs4dzI0SjljTnpZSUI1QVlxRlhTa25lU205?=
 =?utf-8?B?RWFxVVBaK1ZRN1h5WktrMnEvZzlHZFVMN2diQU9EWlUxWDZpSGZtd01zb3Bs?=
 =?utf-8?B?Qi9DcE5pVGNvaUNSRXlBdHJlVkdNSDBjZlNpRmM4emsrZ3ZNaTJiYjVZNkN4?=
 =?utf-8?Q?RoF0XXlobfUnedhBaCmIdL3f/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb589d8a-a647-42c2-2c03-08dda82173ec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:19:39.1482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJCpqEMS7NU0fF9CSs1RlT1IrVefpBlX/auRuUvrk7wOm3UGMHPUKugUPd0nXdNbxA5Ls0VDaNp8BAMz9IUFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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


On 05/06/2025 1:07 PM, Junfeng Guo wrote:
> Set the flag nt_rule to be FALSE whenever the flow rule is created
> through template API. This would ensure that this flow is always
> treated as template API flow after mlx5_ipool_malloc without being
> zeroing via memset.
> 
> Otherwise, some tables or template actions may be still in use for
> port init stage when attaching a port for template or non-template
> rule, in scenarios where the uninitialized memory nt_rule happens
> to contain a TRUE value.
> 
> Fixes: 2fda185a8c1c ("net/mlx5: reuse flow fields")
> Fixes: 63296851fadb ("net/mlx5: support flow rule update")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Junfeng Guo <junfengg@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

