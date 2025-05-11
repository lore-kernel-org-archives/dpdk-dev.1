Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFE2C3ABC5
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 May 2025 07:53:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3556B4026C;
	Sun, 11 May 2025 09:53:46 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by mails.dpdk.org (Postfix) with ESMTP id D501F4026A
 for <dev@dpdk.org>; Sun, 11 May 2025 09:53:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oov9V/K8kr6VfhkPvkh3HomdvHOVyGhlA7Ezd5ElyeRfoaksZj7NbrN1hga2d+yOZpkGdGuF8xRPNsCjM5+KGVBcRAdOUDvjkLNgJTQ121pAcsZPZwVC0nBka8aFu2GyyBh/HA8We6PYBhSDRFBnWY7EpdD7y1y/pRFZGTDi48EQu5moll3KPbVA1xe/lltguyLW5fsKkPir5CWynrpn2bu8CeEl3Ym6rymKxbHw+w8UXOUzWKAq6lx0Nwu3BIcg45R57AQ7kg4R+9A0Q30nTFu1ADXwHW8eJUhRL6DvNH+J9TVUmeJwj+QZMYqznVJYmlQ2uZU7IWFcVuxYmxbVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYuxtGFSI9Pi518GqGv2/E/zNt72si1nAvxWXIBwkQk=;
 b=ZT/Rbu/VTwI6Pq4y60hM2Kl6/2+8C6e3ssJlpSBYF4XQE9DFiiwzX2KNQatRc3RLlCxF907NpiovvXH9twCRWg9dvgxjUXJLDxxm4829lyBqa4Ueae2fZt9qeGrwFNR6qAbMIXDebVMCckHnUmeVsBNJuWg3q7zCwO1LbUdzKjnGsgMOmyqy2Zcqu0bxsN1ivzlruTQ0Kkq6LXNhsuMd1zfxqvY0ueKcgVvypVxy2RQfib7VbZLe3nIJbu0Ro9dKb6yGTOxftwojj0hkppDVA5ZJf2gTtI8GQyRPhALiB2JtYIJdBehWw8hh8bFuSA0KHfearyCiuSQFTZCkFHiGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYuxtGFSI9Pi518GqGv2/E/zNt72si1nAvxWXIBwkQk=;
 b=c+ixSJurhRS9BMVFXZZ+lELxGhhby2zCoFRSy2mXNG56DDE5sHGXUyD1Cfre0rzhW5CeBxT7DqCJNQD2TmzToXVWfSXB8cclcAuuOSFYXk4Ze9oIafrIVya4BxxsiRP0Y/pBlg8NCnEeiha9Tgz7ADbbA9uudwP7Kr2heGIVNR4JxVzTEsQszZZjgU0PolfOS3YC/yXbOlnd3KIfhVF2bydw+2ygcEt7qlrBeDIAz/OEzcg1EN3RLs/BoW58yAOaF+eFYP7F2HFkw0CHGZCERRnTytgN5xrpBLhldDcsVlU7z1Aq5PT8C1lj5yNigMcNSygwG0tp4Czze8WcbAyfpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sun, 11 May
 2025 07:53:39 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.024; Sun, 11 May 2025
 07:53:37 +0000
Message-ID: <f55b2ca4-99a9-4165-9b09-ab8d68a196da@nvidia.com>
Date: Sun, 11 May 2025 10:53:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] add debug capabilities to ipool
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
References: <20250324081825.231395-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250324081825.231395-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: d580d757-4678-4f37-5f24-08dd9060efba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um82QjB6dzFsY0VxUWo0YlgyVk1rMW9DZEJPQ2pnSVJ1OUZaQkFiQk5vOVJ3?=
 =?utf-8?B?TFpnVDlZNEorZ0JjbXU1OGtETHR3U3NzSi9Nd3VGTUtiN3ZxeG83TGxUenF6?=
 =?utf-8?B?dUhpRlRjSDM3cmZ4M3pweEZRNWRUbkxYL3N5Y3hyWlJxYUorSnRMZ1BDTzJr?=
 =?utf-8?B?L3BBTGQvUk9qV3BjU2JyNVdBdTN4MGpRNXh1dTZyWkdFOTFEV0JNeWlHT2c3?=
 =?utf-8?B?MTZWbnR0dlN5ZTB0bVh3UU5YdU85c0FPNDREWk1rTUN1YVBCSHVOb1VTL3BV?=
 =?utf-8?B?Z2UzWDFDOFFKZWZIM1BRcGZlTTgyeTZXUjg3UksrUkJaaWxHbXpyMWpaaWd6?=
 =?utf-8?B?cXpEaUkzSjdIZG9IUG1DakRTKyszcmtGMGNNNzNub1RGYlFqUzRWWkQ1dmFY?=
 =?utf-8?B?NXF6TEZKbzZZUnpNOHVVLzBLbk1wY2tkM016NDB6c2I5eWFlTHV0SEFRaE5J?=
 =?utf-8?B?NU5TWEdhenRib25UTWJVb0Zhdm8xYXYyTEIvYUZHS0x0QUZWRzVPVWlxTE51?=
 =?utf-8?B?OTBEcXNTK2xXSFdxYnlJSUwrSXl4VDlqdWppeGQ5VVZEUnZHWTR0azJqTE85?=
 =?utf-8?B?ZVBDcFQyZC8ybEJSY0lwSHNmbGp6SHlyNnJqYitOV0JCeWtGVE9lNElVQ2lr?=
 =?utf-8?B?NVJYNzNqZHZncnp2WmdGdzZXbnc4VS9YL1hoeW5oNkhYa05kcHNSM2s4L3Fl?=
 =?utf-8?B?SzZQc1d6NmJtaGgrVG9CZThYY2l3WGQ1ZkpieXRWU1pZL2xXOUQrTHNweGN5?=
 =?utf-8?B?TUgwUktxYUJOUmxvNEs4UVlJZEZxTFF2b1VLeEhTVU0yc2RkZEpLM1lTMUJP?=
 =?utf-8?B?TjZkU3ZLN2poTGZJblZZNUlhS09nL21YY0U1a2dIRGg0akp3dzQzV2N5OTdW?=
 =?utf-8?B?T0RNRVdUOHppZUoyay8wTHhzM3NBMVpIZnpxbFBuODVsZzUyWlFJQW9kNWZF?=
 =?utf-8?B?NWNJUVJDcXF1ZGVQckVtdzRGME1BQ0poUWhvblF6K01tZG1hU2NPTHpSRGxU?=
 =?utf-8?B?NWE5b0NRWWlWVGZLZDRVS3c5d3JVR2hXNlQ1OGpObmMrQXFmUDFhdGpNRmxT?=
 =?utf-8?B?WDBDcVd4aFRuZ3JKNUNkSHU1ZVl1a1MrRGVMelEvQjZ1VlN6OGpXbU1hTVBC?=
 =?utf-8?B?alZJSGUzdCs2VE92a08xWG1QRkp5QktvbTdJUmNnMHZHT3FaV0hoNzFMMkta?=
 =?utf-8?B?Z2MyZVBKSnl4Y1BlWEs0MVhscHNiRXdjMUh2SzFTUnRjajNydENKVEtueHUz?=
 =?utf-8?B?ek9PYlhPaG95WitNbVk5NUtrdEtiV0ZYc1NCcjZzMWhqa3FpZWltWkFlOElm?=
 =?utf-8?B?NWN2TEtqTGJRTlZzV21uRmJRZVZMY3ljalBhMnpraTdlU3U2YkFpeXk2RjEw?=
 =?utf-8?B?dVlYeWVlcUZKdlhEZjRrNnI4R3JxSTYyOGQ0UWxLbnZDc3p6bnBTWVpXcWJh?=
 =?utf-8?B?eXpHUlpGeUZxSy9yTmh4d2QzZ3dyMFhlcEkzNUZ5MXZrWjVQK2NYZUx6UmxI?=
 =?utf-8?B?MWtxaGFwNHd3TnMrVGY0UTgrUnlHcncySzdXRVQwMldob3FlS2RjSDlUeCtp?=
 =?utf-8?B?Rm1qWWJOaFlIRXZUQ3JQZEUyajdmWEJicm16U2dBTlFLRiszZ1hVMUJoVWxX?=
 =?utf-8?B?WGswSjdDMDhUdUE1aUlrU3cydDBwOFNJaGI4azVWOG4xTjhrWW42N2RIL1M5?=
 =?utf-8?B?NXVhZk5zalkwbWVuWXZxMFNpeFAvZStPVS90L1RwbWJLR0lRaUZVQWpTTEJY?=
 =?utf-8?B?VE40dEpZdENpUVZSaHlrTkIwTVhZRjNLSVUxTzdsYXpBYmN0S0l2aUxrKy91?=
 =?utf-8?B?b0tTa3ZlQ0JVd3c0dEtLWGlIa0NtMkZUZ2oydkJBM1RyeWJ0K3A1VmZteDcr?=
 =?utf-8?B?K01PeFd2a3poUnVJaW50cklWS0d3aDFMRlN6QVZmSmx1S3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXVOUmpFTEJ4eGRHbUh1cWFRMEhURTVxWkNlTldtNDhwZmMyQ2NzRGdZTyth?=
 =?utf-8?B?dFpFVy81NHY2MGkySFBqNWtkbzJ2N3hYN28ydjl4NHA3VzQ3aWpndUpjS296?=
 =?utf-8?B?bmdwS2FHdmNoaTE4STJSdDZFeEFidkViSHVDTXJhMlROS2FGZVlscXhQV0Yr?=
 =?utf-8?B?YjYrOXFHbHl1NXFnZUc0L0c4dENhcEN1QW1yRTRSWVRwMXdZd0Zvcko2d0RM?=
 =?utf-8?B?WW1nRndmMmZzREdrRU9NNjRzMnVHNjZkYmJUNnQvdlFSZjRFYnNwYVA2cDhL?=
 =?utf-8?B?UHBWdE1OZlZjTVFRa3JWMkcraFlIVFkwUXNLV3R5bmR3M2ZKdEFudDBFK0gz?=
 =?utf-8?B?cUdNaGNtUmxWRDMvQ3RJZmdQMldMYmxqTExpNHl1M3p2ek1NSmNjSWpBdnZ6?=
 =?utf-8?B?N2JTSUg2OVVoakRyd0RHRG15eU9aTUR1UUZEcjRrVWlZYXI1MmN4a0tUTVpP?=
 =?utf-8?B?S1dhRUpsbkp2T1R4UHJOdk5EVWlMM0tRbVM1NFF0cmVDa1Z2MWZUM2FOM2Vh?=
 =?utf-8?B?aVVDQ3hJVVQwNnh5bCtLbVRBcWRkZ3NuUGhnVUt4K3ZBRlVtYWFkb2JpeUdB?=
 =?utf-8?B?aytvNEl5Y2g5Kzg0TTU0bEJpRlJmYUI3bjdlVUFSUGtMNXNYRG5LTnJOalV3?=
 =?utf-8?B?eDZRRUo0VktFWC85eXZ0RU5Zb1l2emNCa0E2UlE1SGl3NmdZQ0hhTU5PYnR4?=
 =?utf-8?B?WURxRE1sbXJXSEgwL3dXY3VEZG81ZDJJQUNsSnI4Yy9aWVVaU1RxWjVmc2JJ?=
 =?utf-8?B?cTgzKzBDRnhKa1owbU1nS2tUbW9TcW9vbWpSYjNGaXI4NE83bHErYld5REtt?=
 =?utf-8?B?ZXZRL3VhbDBJQjJrMTdPR3FjWXFvbWRvenFnbnZCWUt1OW1zbUVrbTI1aERw?=
 =?utf-8?B?aWEzRHJSRjYzNDhFRW1qeXVSZkd5MlNjMzNmOXpRcDB1dTdoS3FNeHBRdnc4?=
 =?utf-8?B?aUZFQnQzNFRINkZvK09wSnpka1lJZFN1ekpqcCtLTnpacHMwZk5iYmFGaTE2?=
 =?utf-8?B?WHZUa0pmM1pqZVlLeFRsaTJSWUJ5dnF1T0NOdEdNQ3NFcGg2ZHU1V3RRWXdV?=
 =?utf-8?B?T0lVTzdpZXM0K3VuL1RSTXlzbUJXakk3cjNlL0M5L3dDajhuR1I0TGV2Y2w3?=
 =?utf-8?B?Znl6cEl5QVp6eUpER3pWdTcyRXh4dE4rbk0wWHRnWEJwTlM3dmJndkxyb202?=
 =?utf-8?B?TmxaQU12d1U0NTQwelpMb3lyMnYwTFRLR2pISGVoZWlnM0doRTM3M3ZyaEdi?=
 =?utf-8?B?Slo5QzZoSXdtS0VxUFRhZTBPMkdPUlNOeW0vZkk3MFJMUjVFb2xnZlVTSGFZ?=
 =?utf-8?B?VE0wRkowLytYR1luV0JKUjFrVnd2U3NFNUtDVElydmc4enE4bU45Ri9LUXhT?=
 =?utf-8?B?dUowVGd5aEpBUGlrWUxYdnVKb3lhVVV6TFRZTjFMUlVabDlMV21PYjhBbjVL?=
 =?utf-8?B?M0JoVWQwSzdkTVRRK280WmdIWGlHdE5yWWFMNWVGUjhHcWdQUy9qc3ovMWtv?=
 =?utf-8?B?a1ZiUUdaaUh1Umo5bytUUmVUQ1MxeWh3RnZKd1VpQzRlWXR5V2tWandJWThF?=
 =?utf-8?B?aldUbUZZS0hkNGdvc3JvYmFuWjFEcitNOHpYWlduRWh4VEpZUkprblEvb1FP?=
 =?utf-8?B?ak9RVk5jZVBlTjlzb0Q4Y1hhU09HMUplUjZLUlM5a2hoSnpRV2djbWFqcndn?=
 =?utf-8?B?WmF2VDk1WnRKaUg1K3RKN1ZqWG04d25CbTFEQ3FKZHVOd1Rlc3IxWDVPWnZp?=
 =?utf-8?B?MVY2L05XbWhRMHd0TEErUWtxMWw0S2RLeTVEQUV0YmhqSnBNQ3hrZFhMRVo1?=
 =?utf-8?B?cE1OeHdRbGkzTVJFQWpobmpoWCtVK1BtTE8rLzEwK3BjSHpWdE1aQ3ZQdUMv?=
 =?utf-8?B?eCs1NmVQK0RpK3lPTGNtT25VUGVJdXBaZzRmQi9MV3A2L29PRDdud1I0RWkx?=
 =?utf-8?B?ZG9FQWVIQkdGei9pdDI4YnYwai9mbEhRUmtxZGVscHZsejJvcGJKRStnellq?=
 =?utf-8?B?a0hscWZ5WXgzTHRCWVhnY3dKTld5SzhHOHl0K1Q4NmFlSmJUWWhvYkdwK0pk?=
 =?utf-8?B?SEM2cEZuSkI4QkNrbnp1TUd5WjdaQUZtbThvbWp0ZEc4WWF5Q0lBT296MGZW?=
 =?utf-8?Q?Sibh7ng3/WYVIAciJh2bXHKAR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d580d757-4678-4f37-5f24-08dd9060efba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 07:53:37.2505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y87Uucnkntg9HifylmeHRsEd1iYAz1sPNmrD+CmdtBBnECz+sj1FYifeMV3UAT5G5Tqf6gatx5+fMFF/iP1MGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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

On 24/03/2025 10:18 AM, Shani Peretz wrote:
> Enhanced ipool debugging: Added new log component and verbosity levels for operations.
> Introduced a bitmap in debug mode to track allocations/deallocations, preventing doubles in per-core cache mode.
> 
> Shani Peretz (2):
>    net/mlx5: add ipool debug capabilities
>    net/mlx5: added a bitmap that tracks ipool allocs and frees
> 
>   drivers/net/mlx5/mlx5_utils.c | 151 +++++++++++++++++++++++++++++++++-
>   drivers/net/mlx5/mlx5_utils.h |  21 +++++
>   2 files changed, 171 insertions(+), 1 deletion(-)
> 

Series applied to next-net-mlx,


Kindest regards
Raslan Darawsheh

