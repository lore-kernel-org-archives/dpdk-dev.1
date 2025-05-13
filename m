Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CAAC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 06:28:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8493D4026C;
	Tue, 13 May 2025 08:28:02 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by mails.dpdk.org (Postfix) with ESMTP id 613614025F;
 Tue, 13 May 2025 08:28:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVtEdK+xPweoDHTawMMDl3lcg/UVdE+hYTXJv1i1x8sLs7ajvjtd9A/R2MeiPEe7/coq8/w1xadEydPWDe5zr42/Oq42iTPu0Vmqer2rlHaECMScUC9KnzAPhCsjD0rGyc+mIxhkwZSVRajvKmIE+dQz0C9/CPZkrtibCubgvLsL4qkG91SijNMSCbUJac2mbyToaSTLKEU0qbfHE8hKxJUP3vNf7rupkbBiDiOxZIqAIamqSRianKnXbqvMoZcrunpK0v9D46RGB3AUH2e+x3mSv8c3v1fU+Egv7OD2zquQxlHM/2uRI9kHffR6kJzw21bWhvI6yy0eLVNlPSWa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6/qWEvBpApxT5l0tow6tQO0Zt0hyOTKEDLz+2jH5FY=;
 b=vqeVDzZIP4pIZiuunOqfTSvQWxCWN/H2njgQru9uwyndQTBsRDvrHkHj4W4BHMNtUbk6wjuKrRhw1bmTu3cm3WCreWJ7P6yQPWLXz2otBHxyZyazNoQ/HnFV+dzXfhkAmXP4YQ0c0W6KkIG9JGnn2O+V3Iq1W9E3NIRt7C6jTmXM2RQmbjZBcXsz3Qxs/tH5JiQKfX3ozKUVLEGGCp+QLBUh4E/YPSd7nrPOY8MyvKES6Zn7FFdwn+QJ2EyitiD0KTu51H0ieQJeYgC+AENn6kA0dqya1J1GAj9wp81DTtpq/qg667tMHGDDrk/GtyxfxdawQfHUemF4dGQhKpLxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6/qWEvBpApxT5l0tow6tQO0Zt0hyOTKEDLz+2jH5FY=;
 b=prUacvuaoY9gDRW2w6GhmaL79Jky8WvdNwdGwjoU6dnmffsQHiAlFcf+N63JgS6z5X3FTGbtEc+oSHVq411inLM6dDlx8DPtLh4KYeWtNNmMGWGx9pEHZf+7uocNW7eDwtKBTTp5TPzS2/NJ1o82+R9j3DRZgvAzhyHsAZYw0L9tN1lhPy3+O+pa9z2duqj0SjQu+30TvOB58U98yX3s+YXtlcktKnSHG/HutImWv8fQMHkEuEvpUgDklaGsiec+GMGsDYaamPsdI3wQqZTAYwiQ0VR6iYvUmYzyilBWoF3FSo21XjWxp4UDh717BQgn2XxM81rPkf9xfhfELJFpDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Tue, 13 May
 2025 06:27:58 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:27:58 +0000
Message-ID: <aa3f9a87-5a6e-41f8-a918-cc9cd53eb067@nvidia.com>
Date: Tue, 13 May 2025 09:27:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix flex tunnel validation
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250430110332.75903-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250430110332.75903-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::8) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: da5c1ca2-04ac-44f4-789e-08dd91e74da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTN5V0NjL01JU1lxY2hKRTJmMW5XSzZ4ZFkzQXdJd3AydTlma3JYeEMyblJq?=
 =?utf-8?B?RmJxcE1qNmlRdktzaHZLK2ZyRmlMRkE5TXlla004QXZIOUxSWm5EendWYWF4?=
 =?utf-8?B?NXZuaVppamZLeDU5R0RqczFZY3M5ZXZmbklxemtCSjlxMTVzaHFJYUZ5Q1hH?=
 =?utf-8?B?aU01S0JVejR5TjFIbUJ6ajlRMkpPYjE2enA3UGk1dnFmYjE2TU9xb0M2VHhC?=
 =?utf-8?B?MUVKdGtNSDBIMTRBSlNYZjIzMmhEWkZ4QzM1d3hvMC94WHUzZnk2d283eWRt?=
 =?utf-8?B?ck9IRDZzZG1hT2lGZk5kRmxaREdHTUZTeE5hUXdSdUxicUx3MHRsdG1BTEFk?=
 =?utf-8?B?SFNEeld4aGM1N3BXMnFndFgzMDdIZ2NZOEdwYVduWm5iWlV0SXhMOVZiOWlo?=
 =?utf-8?B?cURTRkNCUk05K0I1cDlXc3R4VEtvQVBnUDV6OXNPYUNIWDFqNU41RjRWRWhv?=
 =?utf-8?B?V256K0pNUVhwaEhuVmNGanRvclFXZmVQSUFiYVV6Umg0VmYzYU9WNW5ieExV?=
 =?utf-8?B?WXR6K0lmOFV4Z1lrZU5NL0Nsc1BSeEo2bDRRS3dYRVZINWtUMS82dE1raU5S?=
 =?utf-8?B?QVNOWEhMb2NDOVZrbVJPdEhFcGNGSi9uS3gxUy9ob2ZrdGlFL0d0ai9yQTgz?=
 =?utf-8?B?Z0t1ZnRYdG9wTis3UnhSaGREYjI0bnpWRlpNUDExck9PY3RWTkRqN0VpSFlw?=
 =?utf-8?B?T1FYVGU5eUczNUFBNG4xRlFqcnFBUHRqSHZrUVFKekdpdWxOeTZ1VWNjNVdN?=
 =?utf-8?B?aC9nQXpwdkZuUnFPQnUzNkQ3SnpKK0xPSDhubXdLRnJ1OExhTURBVEwrME4w?=
 =?utf-8?B?eVNBcVJVVWdvYXpYS0FCdEp1eUEreGlNYnVVQzlaSDFTanFXTFJNTGx4dkxP?=
 =?utf-8?B?aGxXMndIMTE2UGhxUG1DSXJidjN2dHVsOCtzRDd6THVIK0dhUXhabHA3WUR0?=
 =?utf-8?B?NlNtMTJGK1h1QjJuYWxFQjB1aUUyN3BJQlkrYzJqK0YrdFRHYmh3KzFmZ2RJ?=
 =?utf-8?B?dU5RTjhESTFySFpmQWtHU2s1dFdhNTYzdWZyNXBRMlgvSjBMQjR5V29FT1c5?=
 =?utf-8?B?UTdzc3k5TEJLdUR4RGNaOWZudnhxclJjMGVLSENUZkx3QW1uZ1RNK0FBdWtp?=
 =?utf-8?B?c2RqMWU3RnI0NUZzRkdqWjlLN2dLKzR1dGJPcUthYkxwcjZZV2tUa0laV2sr?=
 =?utf-8?B?cTNUa3hMZDNBL0dPNXFidFdGWVpEMGJqN0ZoR0Vmd3c1OTVHd3ZaWjN5N3JV?=
 =?utf-8?B?S2hHb3M5K1dkNWZyMm1wdUlTNldYT3NodjZ5dUVvOWR4MlYvdFJ5Ym9TT0s0?=
 =?utf-8?B?L2hJcDJ4VVdxUytLM20rMThaRGhCZElyMVcwWHk5VjVoVzVqWktsaE5NOGR3?=
 =?utf-8?B?TTVFanRtYlVieW12TFlyTGU1WmtoUmtwRm5DM0N5eklQaXQ5eXJLb3oxNUdi?=
 =?utf-8?B?cGFXUG1PcnRaUEhSaFJRMmtFM08wVUV1TnAxbUhUVEh0YVU5cGJ6S2lmakxo?=
 =?utf-8?B?aW45aFJTbHJqZ3N4MHRVZ1E2dWx0NnlocEFNMFlCQ2hoYWN1MFhRdU9qb3RP?=
 =?utf-8?B?YllvN2RpZDNaNDc4b3liallKV3Y1Q0FXeVkxbGk1YWFZRS8zd1lQTDFkdHBh?=
 =?utf-8?B?WDhibk1EQTlhYVA1bTVIU1dyZmdpckQ3a01aaUwvMzBleHpncnlReERrTEFB?=
 =?utf-8?B?WEpMaUFXU3ExM3hYZXBlS2p5OHNoRVk2NUJZTng4eGFIQ3BITUw4cWUzZlRS?=
 =?utf-8?B?aExGVTN5Q2dwc0ZPcndNKzRDMFJJRm1wRDYxSTBkNnNNcWkrY1d3bzcxYTdi?=
 =?utf-8?B?VjVOQmtrTktwVHJHTEhzVExaMnlUOTV1NWg2ZzY1UlUyNi9GSnlIQy8rVHVN?=
 =?utf-8?B?VlY5UFRKR0taSzNtNjUxckRFMHcyaTFXdG1pRitGMmhaUnJSS1FDTTZPTytv?=
 =?utf-8?Q?c/wd0l5+mMc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2xJblVqZTlCWGtVMFRQY3VNajJ6QUxUQ2xlcDNSVHBpa3ViY2RWMS9mNG9x?=
 =?utf-8?B?dWFXMWVaditLZXZZV3F6SS9ScFhEd0xOcys3Y2M0TWRMZ3FFYy9YTWNoR3Yw?=
 =?utf-8?B?SVhLQlFrTkNUWUlrbkFWUFBNSVVmdVFQaCtCK0FpZTJpU2hkMXNaMlJjS3Aw?=
 =?utf-8?B?RDRNTnp5aGdZWU5BUndkVWE2OE82OFRVWmU1a2Mra0R6RUxRQi85MHR6eTRl?=
 =?utf-8?B?U2d4dUpmMStXYmNxQmE4Qi8yVWpaOHNTTzFWVCtIVXFJaHFOMUEwYS9IbjBj?=
 =?utf-8?B?Z3ZRUUJ0YnBJMUhwcUJaVm5UdjRLcysveTRlZFROZjkveEw0TlZNMDlXdnVx?=
 =?utf-8?B?THdkMjljcHFyakVtWWZFeDZzNFJMUG1BVkg0V2pFeFQ2d3I3cFM5SURaMmd3?=
 =?utf-8?B?eEcvOUN6MlpveFFCOWNCaDduRm1MQm1LbVhXMTFkcDl4aXg0bTJydTI4SlVi?=
 =?utf-8?B?ZDBZNkFjMmpEN2g0OVRuSkQvejZPMEQxZThZencxOXkxZFYyeXZrODh0d0hB?=
 =?utf-8?B?VklDTzI0OFlsS1RXb0c0OXhEbWNKaVhDRTVLa2tPZlI2cDlpQ3M2TzZzdlZt?=
 =?utf-8?B?R2Jzd3B3YVZ2ODNXUFBsdGdkSW5uYzAvWjNjb2RXL0UrU0hkUkJxZHU0V0FR?=
 =?utf-8?B?SndIcVVsSzBndTYzQkcvZXM3M3h2ZWdka1FyQjd5S05pN1dGenJGbDhNTExq?=
 =?utf-8?B?eC9iUVFYRTZEY0Z4RE9RUE9PdjRXem1CdjhUUlFpemlPc0Nhd2Nwb1B2eWV3?=
 =?utf-8?B?bWdmQ0dqL2V5ZmhVVDI5WmFpV0hVVU41eDFnVkM1dWxrSEtnU2pyNk1BTGRw?=
 =?utf-8?B?L1FqNjFqZjVVdzRrK3UyTEdpcHBNWjRZbWZjTGZwUllvenJ2UWpYSWFEVUxB?=
 =?utf-8?B?cmJnL3l5NW1lQ0xPKzNyWFRmWjhrRytTUmhZU1YrLzFNcWY1OEZNQmpydWsw?=
 =?utf-8?B?WC9PKzBpZkxmVklDY29oQkVLYnp4WCtFbjRaYWVMdjJOQ3BTRFE2ZHNoMHcr?=
 =?utf-8?B?Tm9JUXY0Q2xtZ2FsNG1zRzRqQXdwdmEvbDJSb1BETzFzenZSa1NQTWQ3RlVN?=
 =?utf-8?B?V2tpTitSVHc0UytnNnY5aEhOSTk4Rjg3QUR4TXdsR1JiMFlMall1elQ0VHoy?=
 =?utf-8?B?b0hyWE5jOVNMZWo2THRxUHJnOThIQmFOL2RsdTZvU0syaEIyM3pvRDAvWlhQ?=
 =?utf-8?B?VzhoM0pEVE82SFh0Ry96b2NLNW5HWVRNVklvOTBoNlNmaVFvTndzcE4xQnR0?=
 =?utf-8?B?a2I1eGNUMkx6WlNLMXdOSEUveXJXQjZ1eDhCSWhUWW9iMzJGQm5WdmJVajdr?=
 =?utf-8?B?dFpRbXkyclk2WGVTYXJCU2NFeXlRWHJENk5MMnhwWWN1a1BJZHI5NG5LaDF0?=
 =?utf-8?B?QXI3Sjg1cmZ6Wmk2elAzVGRkbTZuMGdDV0kxK3VyT2dpQ0J2WS9jK2pNU1VH?=
 =?utf-8?B?TEwyR3JXM3IwVEVJRGlwekllZHZKR0hvK3phbnROUTJTajdHYzF3citBd3Y5?=
 =?utf-8?B?NDFzeDNXSmN3bzJBd2g1YVFhWGtrNkp6K3FBQnROSCswZmZaVlN5TkplWnoz?=
 =?utf-8?B?dzhsZ2VEdm5iUGQyeUtwT0gybGFYUWtqbEM4NGN6SzNBWVE3M2d6TDhuNFBR?=
 =?utf-8?B?RElFQTlGYUc5NC9KWFVkb0ZyQ2xZVkc3dW5YNjFlc2RyTGUvUktmWXgvOVlM?=
 =?utf-8?B?dmQyNTIwcDNkWkl1R3Urbk1pUFM5UVlFWW10ZEluS1ByQzRlZHArbGxXZUZq?=
 =?utf-8?B?c0NFTDVINklXcERTMFd1RnovVHNYdnlhZ0JpUDNkR0V0N2hGeTllMGJ1dzFG?=
 =?utf-8?B?RU0rMnRkMnVhZUdkc1N1djFYTVhmYW1ET0RGV1FoU3Q4RHliajFLUXNablUz?=
 =?utf-8?B?MlY1NVNVY2RrVlcvTXZJRjd4cGZrdk5Gdi9xczRDU3ZwQ0pwTXRzbmZTci9s?=
 =?utf-8?B?Qi82RkFRbE9Ma09PZGwzM0RHQmhybDdIei9BSjA1NjFMa0xnVm9ndXdBNjdL?=
 =?utf-8?B?TXFnV3pTSXpCUUx2YkNVTUI5RlhNWnpTa0J6eENaSGpMSnJMS015eEQwRnMw?=
 =?utf-8?B?VTNicHVOTmFuRHo3RUpITEUwZmFTNEU1TGI2dHExL2hpcW53a08xV1FjYjF5?=
 =?utf-8?Q?62awSt7y7PomrD1G8gBVjRQIK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5c1ca2-04ac-44f4-789e-08dd91e74da3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:27:58.5122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8BqEf5p4eN8BeZYgGDRYjPoA0/jPqJULL2CgcNiqLT957yLuz1Hl9hE18nda4hV+Dz81Rq6YD3I8ccBuBTqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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


On 30/04/2025 2:03 PM, Dariusz Sosnowski wrote:
> Pattern template validation did not take into account
> the configured tunnel mode of the flex item.
> This caused validation failures for templates with
> flex item registered as tunnel headers.
> Specifically, any item after such flex item was still considered
> as outer header, not an inner.
> 
> This patch fixes the flex item validation,
> by correctly updating recognized items bitmask depending
> on flex item mode.
> 
> Fixes: 80c676259a04 ("net/mlx5: validate HWS template items")
> Cc: getelson@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> ---
Patch applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

