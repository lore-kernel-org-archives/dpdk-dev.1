Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDECA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:36:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA46D4065B;
	Mon, 18 Aug 2025 08:36:49 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by mails.dpdk.org (Postfix) with ESMTP id 3D14A40267;
 Mon, 18 Aug 2025 08:36:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8zMM5XPCuzQJ1yU3VjA2yB/c9e2OEuh37jEDKYcL/Tkj950sGnYaFLaWC9BjmjszL1rPMWtGr/I+PkYCXe/6CYH1uqruK7qwXJeoMgUnZmicowRd1eMTIOi3fe4gJi+p16FvAPrOh8FIvor+sNtKvv7P6XZyYsO+Tf5f/slhsFux+wb133eRNlxxQgntjOdtEbzCyCraIFwuxL22ZBMKRV6VNRkE7DIi7/fqLlEJ5qAeOLUTF0QUXqJWUSqbpE9f/CzP2BAn/2TQ+SoZotZgVe4I+xbdlLR295rRCs+8UxhNQ0hwFBOSlRw7ltXPER5e3HPHlvjBfI2OclosTigvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ccm9I8zeXaV3QUbLJqFbPRN07TUH1BEDxVt6pgOdUBo=;
 b=YhuMGI4kHvCGJjvsGwNlxLmFdXO1H4XCexOeoyvfoXs/aAaWiKFoVj71CBBbLRgivwXy6pR3fipl/h0PqvwHyWxMjbj9VhePXKLMQ2IC5qi5S0LCTwzWGULMZ5DQx+bEcizeSj28AO2Rtu44XvLE4pJ+ILCIM13ctDMcQeUxFxeH7VvjVYAEj1cBlgzNcyI1srBCOMVkdgYNHjagn8efCSp/sJeyJx1VsV+RQtYlZkN58n45+2mC2rBgb0kfZ0OUJ6LcsSD+fCzRJrSrOmPFa/X74E3H0pkrvsuYtFY4bVixXXZHYg/mpDcceD5IzMEcD/HT5KckYvITnmji6eSPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ccm9I8zeXaV3QUbLJqFbPRN07TUH1BEDxVt6pgOdUBo=;
 b=l+WwMdRQnhZ4UpPKLIz+mmy9DOABNX0d4D+FtQRadx8N1jKfE/eJfzI9u4SkQWJ3uz6zrfF51CRG8bifAjbkUJR6qAPgV6GAWJ8sVZTQJ1WCiHgbDFKQKLIW6bdTaw/rHNmB/vRb0BY6OdH7MGFBUxClQ215/4s3gc6UyFQ1TwlTbI6dAgQhMZmIgHlwT6UTF9TAsoUbA5/qqlugWTEz5SprEEuGUXtdhicIhSFajG0B24fM9JiURBxlDZUlv5SMojzXxOKhaHqqgKuTMQaZcMEi/6Gso9exdd1P/eO8aWQCSESAd26YAQipTUZEHTB3NZN0X+lh0KFuPNfNu2rUOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:36:46 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:36:46 +0000
Message-ID: <c13ff67b-a887-40a3-a245-9004396d56df@nvidia.com>
Date: Mon, 18 Aug 2025 09:36:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix panic for non template age rules flush
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
References: <20250810064732.74932-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250810064732.74932-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: d29543d2-161a-4ea9-e5e8-08ddde219a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azlTU0tpVW4vc1pYbHJXUE9pV2NVdkx5WEh3Q2Vzb0JaWHpKdXhYVVAvRENI?=
 =?utf-8?B?WkZBZEFsVTFocnU5M2lPQzRmM0VXL01NWUxPMDRhNVRQcmJNOFd6eGdBQnVv?=
 =?utf-8?B?LzY0RE5lMXZQVTAySzlGemppRythT1NGR2o0SjNaZlJKb1JDVmNza05mMitv?=
 =?utf-8?B?c3Z1NmN2aWIyYThsMExOKy9PRzhOd3J0K0pHZWhOR1orSENtcE43R25qYmhs?=
 =?utf-8?B?V0JjUEFWSUZsclFEOGk0Um9aWWNreVdlSjZoRk9wWFQxa0JqMEJqdnNkUEQ3?=
 =?utf-8?B?My9NN3JwZHYyRXdWdEJBL3M0UHFnNE42aXd3aTFmVXlvVEQ0NUZ2OTgyQ1hX?=
 =?utf-8?B?YStWRUtIeW1TK0FZOHlPNGhBcDBLQk92K0ZCZGtGRDIrZWxVTFpSUWJIeUxv?=
 =?utf-8?B?TzBYNk5pM1J6aEszUUdNb0FiTzY2OHdTZXFoNG5PU00rVlY5WllweTUrTHgx?=
 =?utf-8?B?dEJLaDZUaDZoN0MyMUVTTXdIbkJWcUFqYmhXK3pkbUNTaFV3ZmxzUWQzTGt5?=
 =?utf-8?B?b0N6NlpQbmRuRDF6RllFYVlBWVNBQ2FiTXFNU2Y0aFhteTBQeEk1NDkvemkz?=
 =?utf-8?B?QlJ6N3VHZktqY3hIU1NYaU9LakRlMFFnV2VmTEJKWldDOXp6NXplWlVONnFR?=
 =?utf-8?B?REhYRThoSExhTS8zU2E1L0hFYkl4NkZXTGx2bHhnOU9BS2NpTkh5WFdvZmo1?=
 =?utf-8?B?WlM5bE9tSVQvcW45czhOQWlYZmFLaXlWM2Zib3JWaXBCMncxWTFmQXRVd0o2?=
 =?utf-8?B?VjFuWThLanQ1SGhPUmh6S0NmZmw1UklSVHcvKzEzTG5EZTI1ODh0eGNSUXp5?=
 =?utf-8?B?a0RNSUpoaGREWWNPKzN3NnNZWHRzcXo1b0Zqbmc4aEJRREFIVm1DY1N6blBF?=
 =?utf-8?B?ZEtoT2NhK3d4d2ttaGUreFRqMGZLSGxONVVZUHRWUUZURDZnamlEY0MvS0xV?=
 =?utf-8?B?Yy9YanNXcldQb1NwMHJCZGZFV3R4enhpMU1UNkJCQVlLTVNGNFNacGNGR3dZ?=
 =?utf-8?B?d0Y2UFVpWXhFQXQ4WnlleXZad2ZjL0VNOWJOVXFjWkJBRDQ2V05QdzdWSHJo?=
 =?utf-8?B?OE1EMjVEWE5tazBBOUlnSGFRbVp4WCtaWXhKUFdPL2V3Q2hjWnBsM2xMcUZs?=
 =?utf-8?B?MVhpOTlDZkhhTmhPL3lLZ3Z3SzlZZUh6NS9KL2kwM1VlQzRDQ2hmeHJHN1J3?=
 =?utf-8?B?RmczR3VDdWFIOWsvcUc2RUxXQ1FBSkttOWhDTEx1U3YrQ2wyMkk0MEIxbDNz?=
 =?utf-8?B?WlVMcU5IWDk0M2J3UTZYcVZOUFpOc202OW9pN3hxZ2Rnb3M5TVFGQ1pSYU1w?=
 =?utf-8?B?OWdtaDJwUnJnOU4vUlppWU5GeEl2RytQZE9jZUhoWDVyaks5WmhpSUpmbm9t?=
 =?utf-8?B?cTh1TStibk5WVTdzbHJ6eHVpNDhDUmhUcnk4WlZrV3hCT1hSbmJuSXMyS1d1?=
 =?utf-8?B?NWdZQWRoOWVDd3VtdThZbVlla2RWTUZKN25GMXBLZ05kRkUwZWFqVUUwTVhH?=
 =?utf-8?B?dFgvNW15Q3VlY0FlSWFHWEs4ZlNraUZzT1ZLV1VKQ1hRNmN6YTk2Zkd3Ylo0?=
 =?utf-8?B?eHVJMFRGcy8xaDdNL2V5N3dGTGdxdmNlY0hyVnp2VCtWVjB3Yk45dFhHU0l5?=
 =?utf-8?B?dFJPa3BDbEdEYXhoZVNZS3FEck92TlJNeXFXcmd1b21IeGhnbWdlZDB4ejhC?=
 =?utf-8?B?dCtON0YvTFFIc2podlE0ZjhlQnd5Wk1qSXJZZWVTaVpvT0xTUjFBZGY4eGRa?=
 =?utf-8?B?RGxqRGJUNzcrWFBjejBkVlA2eExRNDl6bkhBaFR2d1diTndKNWhzYXlMZ3lH?=
 =?utf-8?B?ZnNYTjhoOHdaRUNpMnlwNHZRbnduRGdmc0ZnVUxVaWtlTXI5ZUJkZjZLR0pZ?=
 =?utf-8?B?Q3JoSnhZbzlnTmZJWXlmT3Q1ZmJvMW41cEx6enVsT2JJVnNHdnJRNk1FVkVm?=
 =?utf-8?Q?aYkg+C1bzeY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEVLUy9XZ2FteTJsMytLS3FuQzgxdTRHYnhKbXdaQSsrOWM4M0dHUXNaZ3ND?=
 =?utf-8?B?RWlCNW1kZkYxL0M4R244YjFabitMbkdseUNWaDNkaUs5ZC9FVmpZeTI4UkFx?=
 =?utf-8?B?czZHMzhObUVkVEFFdlFqRWJncUtFQ1lidHgrckZGZ2lLOEt4bXVxN1dEN2h1?=
 =?utf-8?B?V2lvbzY0WlNkUEtXdER2TU1ocmVJYVBubDl0MXhMWE82bnN6Y0Q4bzkySFNM?=
 =?utf-8?B?LzY5TCs0b001a2ZyaktidmFQc1k0YXQxZ3VrV2hwbzQ4WGsybnpZQkdaYmFr?=
 =?utf-8?B?TS9rMjF4cGlvV2VHMkxlQXI5NjIyMHczeHRoU0ZOS21XWDZ6THgvWTVYWk1O?=
 =?utf-8?B?N2pZUllTMnhqNFNNRVpLaDNBMm01aUVPelNRdEVWczBmSXgzYzVEUFZGVHly?=
 =?utf-8?B?TkJlRkl5bnRseEw4azBPS0JsUTZBdStzQkNSNzhidG5LT0VRUzhXeDg2R0dO?=
 =?utf-8?B?NHM1STFsN1hpSVNOY0JKYWptQStiblJsbFFCWDR6UUFtQXlBUnVFbHh0ZHMy?=
 =?utf-8?B?K1J3S1VLeldsMzNGVEdEOEhTUWo0Vis3ZXZLdTduWUNrTEFMU2FHR01CNEtP?=
 =?utf-8?B?alhxQ0t2eUtjQzdXNkhKY2pzSnFUWm9ZMFFTOGM3SmJTaGo4TXU3VHp2N25n?=
 =?utf-8?B?bTlteGtGc3BqK0hWNXFaQ2FMblRvcXZvOFRpQnRGWEcyRUpLb3MwZlZSR0ZO?=
 =?utf-8?B?bkZ6N3FmcUFiTnN6RjJEUDRMcEQ1MzVyWlNBdGNkRXhhV0pEQ2U2UEZVYlcy?=
 =?utf-8?B?aXd4eDg0RURVTU9vVnBBSE0rR2NMNFUxN05yZWFZS1YzdERaMi9uem41dHJ6?=
 =?utf-8?B?b1k0M004UGVLbjZzeE8vQUUyTkd6UnM2SlhNVHF4NHlxWC93dEp3SWFRelBB?=
 =?utf-8?B?b2k5akNCK3VXa0VIMXp3WXU0LzNDQ3JEWGNyM1o3ZHlCanhHSlZ5Q2NKTkNI?=
 =?utf-8?B?dmhDRzQxM2oreUQwT0hLT0JiMVBTRTZ4UmFsek4wbEw4SEJtT1dWTkpWcHhm?=
 =?utf-8?B?eW9WOFNVU0pXdkYxelNMa04yYi9FSnRkdjAwUDg1VkxmeUNrS2c0SWw0cDk1?=
 =?utf-8?B?OE1yMFdxNFZjcjUrRWxwNTk2Q3ExOXByUUZlb2Y4NzV1RVh3bzFvNkJCVWl6?=
 =?utf-8?B?dTI5cy9VNTAyZkJxVjZzQWtoMXp4dkJVV0Z6RG5ZUFZHTDRacUZHWGV4U2Vv?=
 =?utf-8?B?aVFLWDdFQm1qTTk1UVRsZ1dreGhLMjYvNzFTNjFWUWdPYXJWREthZ0xHeXZt?=
 =?utf-8?B?N1VsWk5mQWI2SEo4M2dZaUluMXp6cGxPM2I5Sk5TcUQvb29ISXc1c1ByeWVX?=
 =?utf-8?B?WVhUOWlWQUx3ZlFPbDFWdDNyMS90aE5SQUhkZG5oL1dMdStWT2dKdnU1MTNX?=
 =?utf-8?B?V1RwZHJ5R25jbVU4QjlRTWhXU2hRYWFscFNyd1ZiMy9oMTdsR1dkelFGeEtw?=
 =?utf-8?B?eFlWOVovTElwNmdEQWVVdVM4T1VaelBUbmpnL21ZdVBvK2ZIVGR2TStLdDU4?=
 =?utf-8?B?aUIwOEIrTVhjSnpNVnBCampBcGhQdTVqQVlGNThaSndrRFZ0c0ZnTDJsd2oz?=
 =?utf-8?B?TE92eDFLOVcrRFM2ZXZUVy9nTkJlUUFtSTBxdTNkU0tQRmdBcElubWRDVUcv?=
 =?utf-8?B?YTJhN0hnSHp4cnU4NWIwOGNSOU45WndnZXZKcUl1M3B0ajFKZkZSbmYrbmF6?=
 =?utf-8?B?K202QkFZaVNSWmVLbzExL0Q3VlFRNmF0bFFiYitBaVZvcHFiMXQ1akw5RjlE?=
 =?utf-8?B?WlJSdEtNZnhLWWROL1o0Vy9mbkl2Y2lxZmR1U0pTMUt0VnJXY1VMSlpoRW1P?=
 =?utf-8?B?YVVGWlkzelNVY0hNbFg2eTdhUkNtZ0JCSEpHMjZNdUgraE5aOU5OK0pNeERa?=
 =?utf-8?B?MENpNVdsODB4MXdSeXRmTG55bzVsc1RuQlM5WDhZSkhEM0tQOUJickU4S2VC?=
 =?utf-8?B?SzR4MXcyRGw2TkVXclQvalhHeHE3WGNjSTZ0eDc2OEJuN3VVRG9PMGx5eDl4?=
 =?utf-8?B?RXBzUkRNU05FNlBBOHZwWW1qWDFoZXNUM1dVZGNmbFZib0JTSTQvdWVnTGxs?=
 =?utf-8?B?S2ZxcEtGWEVMOGRHdzdaUWFXK29XTTlGNlhiaS9JYm54MzA3SFBIZlVLRDFj?=
 =?utf-8?Q?dKukt11j336+jLVz0B0P1NcFA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29543d2-161a-4ea9-e5e8-08ddde219a45
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:36:46.2769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3dhrCIW0GSU9jGviHxs273zsEGufjSZiA0iFgOH1jsj8rBOnk/S+V7UmjH2XPHsLDYxrBnWnNGbWxMg1aOJXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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


On 10/08/2025 9:47 AM, Maayan Kashani wrote:
> When a user creates a non-template rule with both age and counter actions,
> both actions share the same counter.
> If a flow flush occurs, the rule is destroyed and the counter is released.
> However, the age sampling callback may still access the age/counter during
> the free, leading to a panic on assertion in debug mode.
> 
> This creates a race condition: one thread samples the age while another
> releases the age/counter info used by the age action.
> The fix is to ignore this case where the age is
> free and counter not freed yet,
> or the counter was freed during the age check.
> 
> Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

