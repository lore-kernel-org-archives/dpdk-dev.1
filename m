Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC2EC83F03
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Jul 2025 14:16:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9CA6402CE;
	Sun,  6 Jul 2025 16:16:35 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by mails.dpdk.org (Postfix) with ESMTP id 7E380402CD
 for <dev@dpdk.org>; Sun,  6 Jul 2025 16:16:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puef6yL6j9/H7B39AjxA5RpqHFCEWITxlbeAqHV6PKfE7OXBmE2nsJC8zPQ9mzaISqlCGDl4YsIxtGfzL79W2imdoFgwY9Ceeu6BzGU1X926TB/RNJWZ0Rt6NhsJLveBeH3PZem3LHbMXdT/S7GjS9XPJdMTrXPYmQHHJ8q/XmEwt9mRJRDTT18DfMXqF7aZbVnI4yTemSXFZmf48UCyXf80Z20ZCwaflpTB5Xp16FSQJcyHQ8hHmHwrH59XOSuATtMIOsy4WDPh9cNwOc3k9ITRBAfFsls3syVk03FBQeJwPwXcYXatFZX0+wyzAtxdiTFw/NsrUv7Sdakox8nmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXJb5RYBxzNyM3nd2QJT/X/yQWNHxR0/ZCRw1MxwWc8=;
 b=Dbx+YfIoDqa8cGw2aivHl3LAdSxk0/I5H8A1Tn1xmS4kgkYMewZnHdxPZI/Vy/Dp0O+y5o0Qb+gdUks2t0nTPmmSLM9Q94FVevN1eLOel8BpYqn1SSW5AnLZSnIUnC8GV7dE4SaJTACdKONeHExXvs7YIT1r3crcFuMwPtw4VnAjbg0eoQmb8JvJPafuuhfZeKxUBT/4ibRa6D0yxUwYBgjANj4bukK+exc+7jwub/eCSdfdqhzYAoGFKQwR2M1VRtStdGj0A4KMbA29qe1+U5gYUcWxDzH0/OOlmw2oUaI0tuVA4EyUTJqixbLQz3aNaUAvPOfRwhtTPQwdvjnUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXJb5RYBxzNyM3nd2QJT/X/yQWNHxR0/ZCRw1MxwWc8=;
 b=Yq632xN9NNQwRaAmTYy8+dlFslG8op5X3RfUUSfZTwqzwq0H65WJcByrdPzOw3k6oLqcBhI5yvgogZok5+TvNt4H/9vN3KKgW06eVzid/CGrQxsPdYWLy2GhtOEmpxhu2+hVNabUftjSRN1RF/6lox3Pz8vf9q88GRWQegoXWlW0mHRgyvvlJEcAOvqX6RUWLQoGBuDd00f/w5p9wtPxIA6Cyg8q7vHLvsTArUYOabWIjlxGboVuYYU7e0fODj03uAys3O+axVsZOMZGVxeKqP+/Fdr0FLqsV8Wrxz6jBV9O2tX5sIcP+EogHBgxvGWm2ACl0wNURivmxW4HUmtNOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Sun, 6 Jul
 2025 14:16:31 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8901.021; Sun, 6 Jul 2025
 14:16:31 +0000
Message-ID: <9e8d6747-a447-43d8-a5c6-a5b8d3a815f2@nvidia.com>
Date: Sun, 6 Jul 2025 17:16:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix inline data size adjustment for Verbs API
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20250702093459.102142-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250702093459.102142-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: f51c0981-e11a-426e-de19-08ddbc97b4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UThnNmY5ellBRnRPS3ZZNkFpT0RTdmhmRHgyRzZuR0kvRXF3VWxyYXYzS0FW?=
 =?utf-8?B?bU1DR2VqVTBJY21NeVI3MWNjQWNVekI4TlJFVXUvRlB0S0QweGYzWHJyZXZ5?=
 =?utf-8?B?N1JqY0lPd0hOUUFkTngrdS9YdzNCVlBOYkR0S0JabzRQOStZM1RuRkFWQmNp?=
 =?utf-8?B?c2ZYNlFUUHdjS2JsY0U0WHNZMy91cmo2bzdVOHBYNEQvTUNSOTFNQmRLMVo1?=
 =?utf-8?B?TFFicmIrUXRSUnVvNXQxeGJSVG9LaVhtcDZtNEQ3UForMVh1bDFOUGZaT2Rm?=
 =?utf-8?B?WUFWUC9lNTMxQndORFVKaUhROUhWQmlaZVo0cVp1bnZOTUxLdlNxMndJNlc2?=
 =?utf-8?B?cGRyR2p0MkN5NGZVSmRPWEpKeDNXL2RTdWFPYkpOeG5QMHl5SytsZ2FGU0xT?=
 =?utf-8?B?WnBGSGZHQ1NjZEhxbktFQzQ3SUpNWnhVYkV4bzFzVDNrZ3lzMEpNRjZwSHVz?=
 =?utf-8?B?MVlzYzQxYVd3UU1tU0hPNUNpNEVnamJvSmNOVVYyQ0lEa1hsd3RMNnB4dFFr?=
 =?utf-8?B?NFl0dk5TMFpIWGNUeTNpcHB5cnhvUVFzMGI1TW5wTDIrRXBjZzVxZUtER3pL?=
 =?utf-8?B?TE43VDlCKzlwRGJjdFVZaGdiUmViWlFDVjVuOXVwLzVIR3hKdzVwaHRVZGVZ?=
 =?utf-8?B?alFUb2tyWnVhUlpwNlNOYVVLZVA2aW9aZmh0bkZBcVI4R0N0NlNUSzdrMmNZ?=
 =?utf-8?B?RTVxOVhwc2VDaGxWRWdTUU5kMmQ3dnVpREhSWitHaVFSajUvR0JkVWhZT1Fx?=
 =?utf-8?B?ZFNTck9IMnBKREd4d0tQb0M1QWJUWEFFcXZvVm9ZVTF3SUFtS0x1MFpQVEJs?=
 =?utf-8?B?cjlBYU0rbnhLS2dqaVpxYzFhTkl1UGJiWDZyL213Qll3Tm1pdERUYkk3cTJa?=
 =?utf-8?B?SjdZWVBqM2xFdEcxNGxCeUY3eVgyKytLQUk0ODZTeC9LTG1xK3BSWmtlb1pW?=
 =?utf-8?B?clAxUlNvY1FzNURINXBsNmxQU2EramRCZ1l2L3RzWVB0MjJFUmtvbWc4bHJ6?=
 =?utf-8?B?K3hQSm1udzhTWHAzcXJqMlM2OFFjczh6ZmppWmhNanRQd3Q0QjArQk9VQjRk?=
 =?utf-8?B?Zzh0VlJtU2JTSUgzV2FYOHpIQWV4Qk8vcVo5bExKbnVlYTBhbmNiZS9TL1Nl?=
 =?utf-8?B?bHJ6WjJCdFA4Vmg5OFdnbWIxK0RoUS9YTHVaYUNaRGlpbzVhMFpSTFMvbGhn?=
 =?utf-8?B?Q00zQmlXam9wWEJUN3lvTFBncXkxY1c3V1pNTUdPTXZEdzFyMkQ4WVE4M0dI?=
 =?utf-8?B?VGlwejVIY2pCV2Q2TDlRZXQvajRVdUwvT1FTQUhZU25HSC9nZ2s5TzA3N2RH?=
 =?utf-8?B?cUdQaUZ5RGd4UWNPUGlzQTBMWmVtRWdzUXJ3Z1BGNkFRaG1IZXBDSTBnR2pm?=
 =?utf-8?B?WWdDd0hhRHV1aEhsQWpxUHZSUkdVY1V2ZFNNNGtmdE1QaFgxa3BKbFRHajVh?=
 =?utf-8?B?amp1b3lMVS9zdThGUEFiMWNhakw3ZjBudGFwRllmalY0Ukwra3hRV0lRV3lY?=
 =?utf-8?B?YldBNXNCVURBQmxlQnhvQzI3R1liVEtMNnJvcjkvdHpyelVZenBiNXYxd1FW?=
 =?utf-8?B?ZHhYdEpwYktsNFYzWW1uK0UwWVg5SGVRSDJ5U3ZzSTc2QnhuUk55cjJLeWYy?=
 =?utf-8?B?MDExaXZUUjNTMlpjOFA3KzlLaS82SDZ0S0lCcUxjRmtDZ3JkOUY4QU1DelN6?=
 =?utf-8?B?QlNhUTVQeUN1bmp3U2RxZXJ5d1VTcU04KzFOYkFtOFFtU1VyRUdqaEV3R3hH?=
 =?utf-8?B?Z3NzdER0MHEwSG4rVlAyTWs2ODZucDFlZzJERFpJNEJ1eFdPcHRiVUVwRWh5?=
 =?utf-8?B?SERSaFoybFpHdDZCcDJiNUlGY0lLY2h6aFBQaW5CT0xuanlRY2FCamVXTWdS?=
 =?utf-8?B?RkUwQ1p0TjFoMnM4eVpndDhGTC9YeExLRVFlb0hIQWlCZDhTZGV0cHJ4NDB6?=
 =?utf-8?Q?d5A2mSF+nrI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRqakR2SEhETEpPcEVWTW5wWGFoeWo5Q1Z2MWVVTWg5ZU84eWtOMFNkVW1Y?=
 =?utf-8?B?dXF1cW5seWVkZTAvR1g0akJJc2NrSWc2RVVzRE05RFdJZDN0NTczOUJRSUF5?=
 =?utf-8?B?OGhMZDJod2dCYmZldFJRUG5Tc0kwRUJLVVB4UlhZYkVGNHl1bm1ZQXNXK0dh?=
 =?utf-8?B?Y0ppY29VTm5NWjdTS0hNVzZTOFFNS0JDSENmYm5wOVdWcEwzQXdxcXREUEF0?=
 =?utf-8?B?ejQ4aXJoMmFuK2N3dm9BL3BxSjBBVzBTb0l6SkVUWnI3aW9wVTFTeU9Na2ho?=
 =?utf-8?B?V2tjalpVdTA2Z3NodzRPZ3I4L2ZmRnhrQnZQcHpIRzcxSnBJbkFQeFdhRk9K?=
 =?utf-8?B?a2VSeWQ0OUZZNzFNZ3o2VWFwN0pwdG9RbVdPUEJzaE9Ya3ppcEh2UmR4ZHVL?=
 =?utf-8?B?RXBkaUZOYUN0MnN2K3BOY2tNVmI4cTZiZ0hacDk3TEVFNExMWkJ0cGx6U3hU?=
 =?utf-8?B?R2dPa1lGM0EvaG91TUlNNElZemtqWGoyNXpuUW9UeXpwT3Z3NXk0U2FPaHVR?=
 =?utf-8?B?eGlVWCtMMHc5TTFaTk83TVkrdE9LcHVUNU5oOTl2USs3eWhFcklNcVJPUXpS?=
 =?utf-8?B?QjMrNVg1SGhuQXh3QjRESjQwNnZ3VHFSMTlYZ2RjRFdDQmdFRkJJUEg0SUZF?=
 =?utf-8?B?dk5qNlM5TlJGV1VFby8wOG56N3lOYmlLT09rNTNLR0orK21tV3BXOUNGclR3?=
 =?utf-8?B?Q3Q4Z3JUSVRCR1lMSHkvVlpGQnRLK093N1laOWluTHlzczEvclhVRmd5eHIv?=
 =?utf-8?B?RkVBNE9sTmM4VGpzR3lCR1NybVJZRk9PdEFWRjlzYTVERGJMd2YxL3BFdFVN?=
 =?utf-8?B?akIvWGp4WTU3dFdUSVlRTWprRFBrWE9WVFl1ZmkxQlhoVytIUStrazByeVo2?=
 =?utf-8?B?V2lBd1R6ZEdBNXBOaFMxanhHN0lqSS9Cd0NqVXVjN1JaenhJMC9YWDJyMnVY?=
 =?utf-8?B?ZzlZcXF4eXJRUFhhMXNKdUN3emlSR2pxbjl5UDdvMzlBaXpJMkNqbTQ5c2NY?=
 =?utf-8?B?NEN4SEd0eEoxTkVERUV5MnNyanN0b1o2am1zcHhxT0Iyd3Q0anZqbzBnUmYv?=
 =?utf-8?B?Tm5aYmhHUmI3cHBESFBBY3U1NG94bzVPY05sUUxqQ05qdXJHMTJGNkZYMU5p?=
 =?utf-8?B?WDB0NjZ5emg2SHpSQTZNZWxRYndyb2xrODg4eFhkdVJUdkh5VzdxWlpDY2w2?=
 =?utf-8?B?WE1VZGdDUEFGaHRWOGlKaldqbXY0TzFCa2ZMaG9yOTdROUI0UlI3bnJVZ2R6?=
 =?utf-8?B?aTgzMVUrMHF5dHArSzdPL3NLd0ZWYXFZaFNLWUVMbHNuYjdUazNMbWI3U3lk?=
 =?utf-8?B?WGVyaGxSR0RpKzVzTlNDbjNxMVM5bXNOeTlFZVR5cy9SaDRYNFZtM05aVmY1?=
 =?utf-8?B?c0N0bGt3VGZsdkRPay9YQTQ1UDBiTDhwcTZrazBZQ3pvUGZwYWk4L09YWDdU?=
 =?utf-8?B?a1FVWEtMVFd1WEE0Zjg0R0tHdGcwWW5MWVF3UGZRYUVLdHJGcHB4RURuK2pJ?=
 =?utf-8?B?ZkppVkhKVE5pUjdTeWM4bnlUY2RGbys4MVZReFhycWJua0NYdmZSeGRqeThS?=
 =?utf-8?B?NEhRYVR5UjN0MEY3WWZFOWQ0enB6a1JVQThrRzg5OEtUSmR5MHYxdlhkajUw?=
 =?utf-8?B?eFU3c3A2Y28xNWxSNDlrZFp1alRWeWRvYzcwdjFseDA0d0szZ050YVJITSs1?=
 =?utf-8?B?bGx3dnRTSGR1Zk9HQ2J2MHVJN0Z0REZKWCt0VVpxcStSMXZtTktZS2wwaklK?=
 =?utf-8?B?bnJwWGxBSnlmNFloTDdPd1paN0JFVXB2N3RDOW1VNUdrOWtYblpnbVk2NHNW?=
 =?utf-8?B?K3dZVEoxbnFzRHRJK29CdlZQR1hLNFROTzNGNHRLNUEyZXdNWkt4M2lTNC8r?=
 =?utf-8?B?VHhEUDY2R05qSVgrYXFKUHZWKyt2Zm0zR2ViWWNmQjJWRGRiYndZNXBtOE43?=
 =?utf-8?B?OTdqeU1aU09pVHRPbjJSUGovcFpBUjVtVGZQTVR2MmozbnY3SC8wNURvNnJr?=
 =?utf-8?B?bVR4SzVYb1lsbXVLalc0eWlEdXRuUmxXMGR2WVErNWMxUGxDSWV2ZTliK0Qw?=
 =?utf-8?B?TkpJaG9iR1UzZTRvZ3N2V3BkWHpaZm15NTlvcWhXdjd0VExUZHZQZjgrQUxi?=
 =?utf-8?Q?1UC+sGB9pIfxBOe1QrrV954QH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51c0981-e11a-426e-de19-08ddbc97b4b0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 14:16:31.6956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B08zOq2XoOtnnpTmLj+OkIxnM6NyqTBR3tjhpmxGQdJvXOdxFeGlWBuvBA+UVnFiodwBL7cP90LPEuZmYEKjgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
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


On 02/07/2025 12:34 PM, Shani Peretz wrote:
> This fix ensures that when using Verbs for queue creation,
> the maximum inline data size is adjusted to prevent rejection
> in mlx5_calc_send_wqe() from the rdma_core library.
> The adjustment is achieved by reducing the Ethernet minimal inline
> size and adding the data minimal inline size,
> there for decreasing the maximum inline data size to fit within
> acceptable limits.
> 
> Fixes: 0c2f7837c673 ("net/mlx5: mitigate Tx queue parameter adjustment")
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

