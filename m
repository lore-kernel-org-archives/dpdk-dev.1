Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B5ECDE000
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 07:17:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D66A4025E;
	Wed, 24 Jun 2026 09:17:38 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0477140150;
 Wed, 24 Jun 2026 09:17:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXni/xKyphR+QawDJgdtwjbXJWovpK3HVqrwTAOP6sMdoJQqN5MAPo1mXyN2VFe3itZuwq7jXIyu9WG0nd+j0G4Wj3GUvZlJfhdseLUqXUZok9hCkTLyAjHgGlPSjuGFCPfVbFLtRhpey2QlNmqWCftP0EPE0pOslywfcRK/FIdYv+k2iXOyMK7EqMOIOq5CGHQ+p14qGYO+9yn/sIysEsPlQnT51cTptphqFUHyjYKrcykCmAWok3fi38ESYipvPVi1oEkqyC+EcivzXFcqu8cerXamQKg9xmc/DTN+mq7hPMvq4ha3vzaWxywKmaTa8dlQK78q6O+VKqkRr37bVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlbMMiYD6kSEJlYOSOkXmYAXIlRM5UftvpjLc9IDvNE=;
 b=Toan21BCnsCDz0calBx/jqrrXuhYirJcz/yWyNZD8n42hI7rmBwZiWtDU9CXAAAx3qcSCavjLRHQ3IY+KMoj8YCiuedSJNXFyN24zUpDklmeH82qovhDt3UgtWi6ezMchPDAP2eHO2kMULHDXnRlW3O9nG8bEcVRM6bC1Jv/qyQjgm/gn7SNai8fqJvGVQyA1ONdtJGxfz7Otzowt+jGGUFSMSYkstw7OhM6PmNmNAMpfHyMfzarQ9nwi4Ge3Zljje0HDjIkdaay2SJGJqJDmPfR1eAn+YNPSsK0T9KiH2LPIS1J2sGIYb8jGj9ymf+VlyF2MyU5j3OdUIwTy/K7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlbMMiYD6kSEJlYOSOkXmYAXIlRM5UftvpjLc9IDvNE=;
 b=L2mMZVKrtQa3V0ka6ImAUf2sPvqSF/LuaWubncVkuQKNy28dBkLLE0KuAT3FknajdFwEPWDHnTgMo4HQ7pCVbxCnR33fb72mKsgHiW69I6WyKwzHXls25/gagCV7pNQP710Ke4uiZ4LWAWoOJxKosO8mk5XxhAl0QGbWlSltAndxM460nismy3XfhS9+3wjKUXCXoTkOv0AnnS4stTJX9lFdPYCEpclyrWQIPI2r/t8uQbpv0avyAtkQGjr0G7L0OXv4lK3P0J+dT6U76v3ipuZ/fJvE52ZlSWIUDyZvGLuiXWbs1XO+0hDOWOwkLE2RYFamxektX/M/k+QgLGOfvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by EAYPR12MB999179.namprd12.prod.outlook.com (2603:10b6:303:2bf::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 07:17:32 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 07:17:32 +0000
Message-ID: <8a2bf4bd-c9f1-4abd-aed9-9d3337152d6c@nvidia.com>
Date: Wed, 24 Jun 2026 10:17:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] net/mlx5: fix counter TAILQ race between free and
 query callback
To: Linhu Li <lilinhu618@gmail.com>, dev@dpdk.org
Cc: stable@dpdk.org, dsosnowski@nvidia.com
References: <20260604101112.72177-1-lilinhu618@gmail.com>
 <20260618091450.19204-1-lilinhu618@gmail.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260618091450.19204-1-lilinhu618@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0281.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::14) To PH8PR12MB6747.namprd12.prod.outlook.com
 (2603:10b6:510:1c3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|EAYPR12MB999179:EE_
X-MS-Office365-Filtering-Correlation-Id: 39942721-6aa8-440c-2165-08ded1c0a847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: D9MluNkFyj3uD1yvtMEsYKejRJSLIakjCQnwvIgtNi7dCQ7hCwStK00etQK3G38ZPaY2TjynU07yQlMKo+LdtGudnU7Cn6Wja6JfrtPLxdhPJx51AuSrakr6mNhtuln9RebOPZBINhSrnCBnLlAOlqJmmGlRKmo3HrYxgzbeOm1LUWoyET5ZoHuITj7YuFJQfxb+udEs5JMo++CPaEVYN59yESB3dK0kTpO3Al1EaUGseiMUAJ5de4cNgPayobKeFknE3EZCvNiz9bXTfCuMz5Qy76idfzao1zaTwm5jcB7tBUj5VbJJGkaHzlIOCJIIszN/Mh1ilj4eMnplth/z8XicCAbRJACCoYQ54kMQxDi8aElTZE0IBwTvo0J9U7w2r//eYRk7QNP2z/9f3nar+bo739ioriQkcACjDtFeKhLQA1LIOmRZ+TbQ086/M5HGBf4DX5lR/lcwLtiMkELM3K6ak0xkdFKT+jCJTr0ar2YMsJUscGmG3kfdJXpi0IWeFIV4dpfUG/HqLWO/RkWJKnBNJPXXFZB4E4fwO6baTQUdB2/P6UJoTSZJAQ19S9g77IM0xpKEuBxcXIznmd9+07LUyzGT1jzZ5XRLoqJabywyDlUxN/Tl9r+/+pKryxOF4tLNywaSaY5qWrNGhr8Jl2X+g6QMgCkfiiv9pKIUeD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JGNDVBS0doQjEvRDQ2Wk1odVVUTWNDTVRiU0t2Ym5VTmI3SlhLNkJ2b2VG?=
 =?utf-8?B?c3RkaFVpbWdJek9sdlNlU2tOK3JHV3ppM1Vjbm80dWk5VWg1QlpKUUErUFpL?=
 =?utf-8?B?VWg0QjM0Rm9rRFE0azVYOTFmYXBJeGI1azBpQmNBd2l6M0xBdXJ4RjdiVnFq?=
 =?utf-8?B?RGdWUk9HVTN1RjdHUHpadkdyUU5UUGY4RVdVeFV3Nk5CVC91ajFaQXdQNnhV?=
 =?utf-8?B?M2FXRml6anZnT2Z1SlRiRkZaNG5GTlEyUlRBVkR2TUZTMGg3OEdFdC9rUUZO?=
 =?utf-8?B?SyswbzV6NldRV0lzWU5KWEFwdkRDOGxhN3lEbWo2dmExNlFxbWp0d0puT0p4?=
 =?utf-8?B?OHpEMHVaZ0U4RkVSVTBwOVJ4ZUh6RHYxQlIxa0R6c3hmYlNtOGp5QjlSWW9S?=
 =?utf-8?B?Y1g3blZWS1RQOXBmY1RGaXUvekc2d1p0QnNVVmRVanZJQXBoTk12T1BaV1ov?=
 =?utf-8?B?TitoUWtTQlFmMTRtdEZuVnVuS2h6ZHVEcXlIek9TWkl2V0d3M1ZhSW9idzdm?=
 =?utf-8?B?MzBRNlp2NGIyRGsyQytORlZocTdZY1dMRGVxNGlLcEdYUXpQOFpkVmlDU2hX?=
 =?utf-8?B?dXgvUXdQSXhBMzMwZFpGRWlpcy9NM1M1OUhEbU5QRmxDMTVHSWhBa2VFNTl1?=
 =?utf-8?B?ajFidHhlOWtaaGtGcHQ0SjJhdGFVcVFBMWtUMG1sTElCTDBuNDJ4N2lyRDAz?=
 =?utf-8?B?SzNaR3RSMHJIZ1hKWXFleHJSbmhHNUJQTVdKRSsyNS9GLzdVR3hHR1hDSkg3?=
 =?utf-8?B?NVpZM3RadVVvc2t1MXRZV2V0RUk5SzRzUzVIK1dKUDFzbndqc1g1eHovemtW?=
 =?utf-8?B?RDh1azJiUGRFeGhpb0lkWUpGMnBlM3QwSDNMRGJHcnB2SmFDQkVBWGt1MTIw?=
 =?utf-8?B?TUtkcnhjcmtMNnVhV0UrZkZRMmlId2dUVEhVNHhpMHpBQVlibnU4VktVYjlI?=
 =?utf-8?B?ZjVvSkIyTVVwaTRoekR6UzU2NysxZWRGRWhxT0Q1WEdKM1pibmdqaUFTVHNJ?=
 =?utf-8?B?bjlrNzRtZFhOaXQxRExaeXhPNHV4TmFRSlcwOWVHcmZYS0RTLzd5cnowOFFI?=
 =?utf-8?B?QndGZ29LZDJBRnhSRnlGUlRSSEt5NVVvU0pTRGZ2QmxZd0cxYTBjS1Y3S2hY?=
 =?utf-8?B?S0trOHBxeFpCbmhXNTUwM3FBcVcvR1BCUUE3ZmZDc1R1ZGVyT2JEeDVwcE0x?=
 =?utf-8?B?cm1EekxUZEtrNFFGWmtGVTY3V3pCYnpReWkyS3F0NlVNU0c4L2dwRlFBTExX?=
 =?utf-8?B?N2c2bWRKOEhqVWFqOXVzZXFGREdVZTNhQVIrUGxPcUtWRUJqeFVIbGNsRkha?=
 =?utf-8?B?OE8vK212M05BMXg1anlrdnM2aDh0MXdJRVBmM0VzRWtKZHF6dTVpdzBJeHNF?=
 =?utf-8?B?Tmd6eFdGT1NvRkdtM2wwc0JLbjNiUWlrL0swaHNBdUMwQXFrWkJacERpeGVk?=
 =?utf-8?B?SlpldHFjNVp6LzVTUTRRVmEzU0NZMVV1WUpraVdDdHE5MWd6cFR4d1ZaaWFL?=
 =?utf-8?B?aHVmdmVzUy9oN2lNZ0d1Z2hiNVpoUkN6bjZLZldqaTdtN001UVN3aFYwTWJM?=
 =?utf-8?B?RGRzS2FoMkRJQlhjc1AyWGpjQ2JBT2lNTDlnYVMvWkpJM1BmbVNNOHE0OFkz?=
 =?utf-8?B?S3RNU1JFVjRITVIvYVFuKzRpeDc5cTJaUDJ2SUZ4U3NULy9BWWFWZXc2dmdj?=
 =?utf-8?B?aWxhTkJJemFTYUhTeStIWTJUYUZCZmtWVEhZUEMxempVUitKVkVMUXdTWW1l?=
 =?utf-8?B?MFBYbEc5SUlQbXJiZTFFYlZKM3ZPWjJMWWVBSERGWjJESTV3bTA4eDFaK3Ni?=
 =?utf-8?B?cWZEaVNhcTJsQ3A0S0JmUktCRzFUUVpicHhZUnhxemg2QWpNbHJvekx4Q2pZ?=
 =?utf-8?B?L0tnZjgwOFZRa2ZSdzQvU0FRUG55d2hUeFdBMFJhZlpYZnJ3ZlBSdjlMMWxi?=
 =?utf-8?B?OGlOYXVBVXVYKzJVMThEYnJ2cFdFZ3lBRkUvUklyYmhla2ZldUtzLy92S2Fz?=
 =?utf-8?B?TVNrQ0FFL01vZlIyTnl3N2ZKSUY2NGR0eWQvZEl0cnE4dVo5WEszU2txeCtu?=
 =?utf-8?B?MmpVdUVwT3dHV0o4YS9LMWUvV3U3QjJ4QUl2OTBZQksvZVlCS2lLanRuVThL?=
 =?utf-8?B?OTVTM3l2SGlQdEppUnFmeWVNS1U3b3hYSXg3WVZiWkE5VnpaSHh3eG9DMmpx?=
 =?utf-8?B?ekVhNzdIeGFjUUNxbDNFYkx0S2FkV0doeTZtQWpuMSt6QXZkZk9JN2VnSEVJ?=
 =?utf-8?B?Q0VzMThGL2hVeW1VaXpld1NYNWFkLzJTWTJQODNhZHE4dkhpNVc5Kzg3akw0?=
 =?utf-8?Q?mF1QpAVhHy2nxrudj9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39942721-6aa8-440c-2165-08ded1c0a847
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6747.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:17:32.6564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAf3CXHAlG3Hz9fSdR8u9a79YxlJMsNbWZ+MPyCDXQ/KHaEUcDZSrugCSEdtHTFR7GCGVf4b3Gxsc9BK51cLAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999179
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


On 18/06/2026 12:14 PM, Linhu Li wrote:
> flow_dv_counter_free() inserts counters into
> pool->counters[pool->query_gen] under pool->csl. Meanwhile,
> mlx5_flow_async_pool_query_handle() moves counters from
> pool->counters[query_gen ^ 1] to the global free list via
> TAILQ_CONCAT while holding only cmng->csl, not pool->csl.
> 
> The comment in flow_dv_counter_free() claims the lock is not needed
> because the query callback and the release function operate on
> different lists. That holds only if the free path always observes
> the up-to-date query_gen. It can be violated:
> 
> 1. A counter free thread (non-PMD, e.g. OVS offload thread) reads
>     pool->query_gen == 0 and is about to insert into counters[0].
> 2. The free thread is preempted by the OS scheduler; it is a regular
>     pthread, not pinned to a core.
> 3. The eal-intr-thread alarm fires: query_gen++ (now 1) and the async
>     query is sent.
> 4. Hardware completes the query and the callback runs TAILQ_CONCAT on
>     counters[0] (= query_gen ^ 1).
> 5. The free thread resumes and runs TAILQ_INSERT_TAIL on counters[0]
>     concurrently with step 4 on another core.
> 
> Because the two paths take different locks, TAILQ_INSERT_TAIL and
> TAILQ_CONCAT run concurrently on the same list with no synchronization
> and corrupt it: the pool-local list ends up with a NULL head but a
> dangling tqh_last, and the global free list tail no longer points to
> the real tail. The just-freed counter and every counter inserted
> afterwards become unreachable and are leaked.
> 
> Non-PMD threads can be preempted for hundreds of microseconds under
> CPU pressure, which is well within the async query round-trip time,
> so the window is reachable in practice.
> 
> Fix it by taking pool->csl in the query completion callback before
> operating on pool->counters[query_gen], serializing the CONCAT with
> any concurrent INSERT. The lock is taken once per pool per query
> completion in the eal-intr-thread context, not on the datapath, so
> the cost is negligible. Lock order is pool->csl then cmng->csl,
> matching all other sites.
> 
> Also handle the error path: previously the counters accumulated in
> pool->counters[query_gen] were abandoned when a query failed. Move
> them back to the global free list to avoid a leak on persistent
> query failures.
> 
> Additionally, fix a second independent race in flow_dv_counter_free():
> TAILQ_INSERT_TAIL is passed &pool->counters[pool->query_gen] directly,
> but the macro evaluates its head argument multiple times. Since
> pool->query_gen is a volatile bit-field, if mlx5_flow_query_alarm()
> increments query_gen between two evaluations of the macro, the same
> insertion can operate on two different lists: the earlier steps update
> counters[0] while the later steps update counters[1], leaving both
> lists with inconsistent metadata and leaking the counter. Fix by
> caching pool->query_gen into a local variable before calling the macro.
> 
> Fixes: ac79183dc6f7 ("net/mlx5: optimize free counter lookup")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Linhu Li <lilinhu618@gmail.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

