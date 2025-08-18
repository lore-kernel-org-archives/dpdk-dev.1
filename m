Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D079CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB1174026A;
	Mon, 18 Aug 2025 08:34:14 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by mails.dpdk.org (Postfix) with ESMTP id 8564540267;
 Mon, 18 Aug 2025 08:34:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Clsh7JqX0k9sb9r09UymefHqcpqCr/ys7qwxn+wODDoaUZKvqsYmAYy6aVFlQcLCp+UN1h05ECA2zeSzMi+0bObJ/XONo44Cpk1KnuLNQ9bJK15Xvap++Zuj5yYGoe1Wmz8eY9R6VTvnTgUU/AfbSnGAmiEmLmh8z2BL07HMxu5TogW9uOlY0hIQvUA7zqvOtEEVQ3OCxkfoQfKHHS8Egg0Q45s4FAS18JSegYY0mrHN6q5dEMbj4YFKAOsbfKtTFwLdPTwpmxo3InhZL1L+FZmG4G8C9jk+mepro92hn9wqI35xgo5dzqzuy0iRLTpb/dhR/m5zX7y9krmWz++f4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4yzwNyzVPg39cV9TparWqsh3w1/KrE+YBmW/OzCCZ8=;
 b=ZKEV81kUacuL3EESMToPNdMpvfRss7aeBM5XxJ0pI4i/LnjPDUp9R/Xh+zGkscI2lwEiQyGZaTli6lQTKqdG+wBRaLp16FUjJ/JWotle0ETcvjCul79W5tbnnEMhg434aI2m0uV4m3YS6PVcqCMjq6fe9uZ2gg47eTMqh+5kP5yjQzG0ruoHcekNoargl00fGqu7r3D3c5AXnZK2njRyH3dlY2wZQqQLFA7P4E2Ew7sGwFvxvaL+HTvdLMaBu3OdZYGdELdNNiwerc7T8zIQRPdpSv44WZNGf4rGcitpglEGNt6DfOlBTyg0Atwx4hArm/yNuoPOaOMcE0EyHKJZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4yzwNyzVPg39cV9TparWqsh3w1/KrE+YBmW/OzCCZ8=;
 b=NEQ8KEAUWZdWqO5/cLPlREMdJIAC+PrVDDUtRcmPv/2Bwczi6yjctvqTSar80a+/kVKPguB55ph4J6Db2hGnlCHja3DYehvDiqHrbevCxdqrkMw9hONVt+/4XFaA/CQkJiDmq5lQ+9hkPW3r+tM3450dRpkhO3qvTqKYrL9AFH5H83+bK/7Brlf078fjjL8lgvOjl3xzhfMOpsmx9xo74ksmrrzEvd2UZaf/+udCEZWOlb9sz+LZb80YyVGCWma17YO5Sv243sJgdYSTiGugdq+OOfNDXgM50bNVaw2e8nM7jrt4IivWxD2OWaLZmdG0320OWLmrXdLwp692YCpRWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:34:11 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:34:11 +0000
Message-ID: <12005597-ea5d-4d73-9b63-748894f64f6e@nvidia.com>
Date: Mon, 18 Aug 2025 09:34:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix ASan issue in RSS flow creation
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
References: <20250805132058.50966-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250805132058.50966-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afb8fac-8156-44fd-18f7-08ddde213e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGVna09vVVJHbTY4THRQaXIrOFFiN2xuQmx6RFlKMHppTWFjWnAvdk5naS9P?=
 =?utf-8?B?YVFlekFva2E4VGhWZCtqblZ5Wm1RaGdHOTllVlMxNmpmb1hUdlFnNTB3OC9U?=
 =?utf-8?B?UmZhbzF5RWlYQTVqTDNwVDAwSmU0QmlBelBoV0ZPdDJKVnBwdTRsSTg0MVQ0?=
 =?utf-8?B?SCsrVE5EVE5YTkF1WENwTVQ4RTMzV09QTlRhcldEQWZSU044NmFWRm54NkxK?=
 =?utf-8?B?NkgzRkNwampsOGZMcExqYkE2TlJlakRRNkFvNytkcStuZi9uOUhnM0YvdnRv?=
 =?utf-8?B?VzY5dkhnQUN5YXJ5ODlPZkFybFJpNlVONnRONkZxclU4eXFIelNJdUlnTVRZ?=
 =?utf-8?B?bytFdVRJVUNqTFgwMmdQWG9IZjhoVTRoVWJVcHA4Z3ZaSmpGS3VDQ2Y3L2lM?=
 =?utf-8?B?UkJIeGY2WmE3MGFMSFZod3pCTHljTkhDTGJqMnJDU1dEczh6R0JQeEJtNkpB?=
 =?utf-8?B?OFhWRzhJcVp3TndEdUlIRXJyUURTbi9LbWNxdndnU21naXVjeTRNVG0zaDdU?=
 =?utf-8?B?c1Jkd0ZPUlRqaldVMDR0alRTMER0d2hxdUNTS0hiSmR1TmVyUXdMNlA2Ymdw?=
 =?utf-8?B?eFg2WjJEcHQ5QkVZKzNwZWxyc01OU1pVZy9EVTg4bWkxeGx6S2hIR2Y3OEZD?=
 =?utf-8?B?ZEtDV0dzenVtYU56QWZ5Rzl3Ty82T3BIWUZIN3VoSkJNNVFGeGNmRHlrWCtD?=
 =?utf-8?B?a052aWRHVUtUdXFEK1hEeWtUNFJyVWw1T2tpWXJraTVRNmxhK1FmTFZtcHlT?=
 =?utf-8?B?T2Z0ekZJNzFWOGNienhzRUpGblM5M0EzaWg3MlovZEhqakppcFRlNy9rTTh0?=
 =?utf-8?B?WDZwVVp0Z1RUL0R5OVJuUUllblNSRUJBV2ZQQjZxNHY0MXFnL3ZRMUNwbTRL?=
 =?utf-8?B?WDhGNHZYWFpCTitkT05xT1JpUnQ5RGhUM0ZtMmVFb01ETkQ2cmYxdWlGSm5F?=
 =?utf-8?B?S3Zsc0w5QVFVNFpCS1ZjZmJyOFVBSnVqZEU5SE1RSVNFcEg1ZXdqQzJDTTgx?=
 =?utf-8?B?RHhBM3h1V3ZObEpXVDN1ZkI0VCtuZGN2emdWUWN2VWtZSHh4V056ZURFR1ls?=
 =?utf-8?B?KzFtV2tTZ2w4enZEOE9tRzF4Q0lmNEpoMTZGdklnbnBRelhBeG8rSGpZbVBF?=
 =?utf-8?B?Wnk1bGdBbkVEQ2FUVkQ3RDZsOXdCYytqUnRtNWE0ZWVJdVJjRis1c2hYeFAy?=
 =?utf-8?B?WUJOWXkvamRVSXhrc0hrTVlETldrUWdJSmg4NjZjeUVMOHpPODR3QjV2S2kv?=
 =?utf-8?B?dTRRZzh6aSs5NS96ZmRYWTJyR2JIZDhHdG1jWk5SU2t1aWVGdk90QmRVMi9p?=
 =?utf-8?B?RVlHaFp1bXdXaWt4RXg4a09kSDlxbGRqWVRIbGtmdzhtSEVoM2pZZElBbnNk?=
 =?utf-8?B?anRtY1d1TmJDbG5FanJITndPRFFnZUVsUC9iQ0lvcklWdDNtN1FQV1ZwYWRj?=
 =?utf-8?B?K1JzN2NuK21telUxUDhXem40aWZJNkJCZUhyME1TQ09QazZ1blBuWjlMRlFo?=
 =?utf-8?B?eUdpR2RkUjlSSzN1SnlSVC9ObnM0UEVyY3FYOGZOT3NkU0J2cG5HWkFHbFFs?=
 =?utf-8?B?Z3VDZXlBcDhDZWgwYVdRS2h5alBDcnl1ODF4UEVwb1kwcUVxUkRjSHVwREZN?=
 =?utf-8?B?OXN0R1pZak9sanlEbjQxdEYwSnhLeWxXcjRISjQzUE5mWlVua1RlMk1OSFhs?=
 =?utf-8?B?blB5bFE1M0RNeU9xb3FtNnRaM05xTTZpZEVLelZTNm1zeW0xNVlIa3krN2Rj?=
 =?utf-8?B?MXA1elBRUUVGRWg2NU1oT2piRnZuS2x0SjRnNHVaR0c4cGsrTWxPN29ld2E4?=
 =?utf-8?B?WFd1L1BRekVZQUlueFQ5Z3NSYXVXdVVGdHFYNEJaS29yaUJ5QU11UWxMU21q?=
 =?utf-8?B?UlhIMDhsdWFCcFBINjJxTWc1TlpxTmcvYkd2TSs1QUgzWTgrZDJYeENCaEVv?=
 =?utf-8?Q?48jwEsnoF/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFVTRi9MSUl1YTR6dDVFUXhHczlKc1F2UjZDUEtDdVlDeWsxdVF3cWxZT1g4?=
 =?utf-8?B?N2VQWGRibFRHSEFGbit2YzErMG9QSEtTdDlaaStENXdSaUd3ajcxcHE5UWJ3?=
 =?utf-8?B?RHZ6V2JrTlRQa2xtT3ozclJ5Z1l6akNZYWlzalNBN1BLUWs5cG9yU0x4QVVS?=
 =?utf-8?B?ZXBMZTlQQitmMWdIUGEzQS8zTEw4U2tXTXNVR3FpR3UxbG1OUEExVVZxSW5w?=
 =?utf-8?B?MXBSL0M2OTUrZzBObU5uREtQZmNQRkZqWXhZQnh2Ym8vQUlWeGcvR0hFTlV6?=
 =?utf-8?B?VldUdGhsVEEyd1ZBdVV6T1FIWmcyRlk2dGc2TjBPM0dlY0RxL2gyWDlsTWFw?=
 =?utf-8?B?bFBlNzQ1S01BUmw5aUp5aWxSOWkzbURrQnFRK3pTSUhuQkVicU5ZWEg3aWtO?=
 =?utf-8?B?aVFSRDJmcVNJT0x4cTNaVkRsajQrMkZQVE0rNmVCbW5BU0dzNDJGM2pjQkph?=
 =?utf-8?B?Y1RzaUlQVExsZXovQ0k3MGdTSWtJYUFaZ2JmNHJXb3E3RGZkc21pT3VHS0hD?=
 =?utf-8?B?NytjaEF0cURvbElxY21zekE0NEcyRUdpNFUvaHhZOGlCZW1xbWhxY00yWW93?=
 =?utf-8?B?UzJwRFJQYTFHdDJqS1ZBWitweEtzalBscVFUcmhsLzRCUG12UDVLMXkwdHJt?=
 =?utf-8?B?SmNkLzd4dDgyc29ZQVJaRlBQYkorQkV1NnIzMjJNZ1QwWjJlc0JZZTJHS3Er?=
 =?utf-8?B?L0Iwcklla0EyWTBjWE5kV09FY3ZUT1BPejQvU2NmcHJRdnBnRFkyWFdRM0dn?=
 =?utf-8?B?TUlOMUNKd0dtY0pqTmhaR3kyNHVmUjhpUS81OTQ1dHFsWTNha09RUGdMNTVU?=
 =?utf-8?B?a0NObkFpSnc4SFNyTzlkSUQ2R0wzb0g5dXdPT1JpZUVDVkZCdlNCYnZ0cVZB?=
 =?utf-8?B?QXNyS2J2V1VhWmVHTUh6VHdnQUdOamJnd291UllJRENkWUFOQm5CcXE0VHNa?=
 =?utf-8?B?enFPWk1GdjdtUkdjTEpvUEcxZTcrazV4bmRwUDRZUGtSN3VySUMwYU9jNmJ6?=
 =?utf-8?B?dzFxTklBcktpdE41SHZsSURsb1Z5YmVzOHhSTjJSd1JMaFVyVW96ZzI5eXFH?=
 =?utf-8?B?ZE1ic2FlMENmenlRalNvRVZZb3BiS08wS1JqU0FwWEhiMk5HNXZBU1pxeHh2?=
 =?utf-8?B?TTFvU2ZQT2VEMSszeGZ6ak80UGZsNUllOGVyb01LTkdLRW5ITkNBZklrbkZC?=
 =?utf-8?B?NHlxMW1TMUVUUmVDL1B1WUlQanNsdTZtZ09KK09TaW1jc2Rab1oxVENBWXpU?=
 =?utf-8?B?KzFqZ2FwL0ZqRUlvMGEyS2pCREZpWitRUDBDbS9aZjcvSDFJcDhOdDZoTWlC?=
 =?utf-8?B?eXQxK3JkTWJha3lWVnZOZEhQSW54Ryt0WVJHMWFBSTI3SkpXUXE4TEQ5cnZ5?=
 =?utf-8?B?U1YyS2pTaFBBS3crZ25zaUw5ZVdHdlhKc2VDQTZjS3NleUdGVFNMZUdNdC9X?=
 =?utf-8?B?VG1ETnRQSjJ4NXZmVXpZZ3dzZzRlQnVxZGpRemRvZk5LbkpIV2s2cXMyRVFS?=
 =?utf-8?B?d3RSNU5yeDR4bi92dkZzeUo2aHN0Y0hHTFY4aHhRenI0M1AvWmppUVY4Rlda?=
 =?utf-8?B?R2x0VHlFSEFyTWxackRGcXZ2TnpWZXNlbjA4NFk1VG9JWHRYSDB4WG5RVkx0?=
 =?utf-8?B?a0hJRElNYzZWMzhsMUxWN3FpeUVPcUhydHlyYjM5eGxjQkhRMUhRMkFsSjZ3?=
 =?utf-8?B?dkJuM091eEZCQ3A1cDVRY2JVR0p0cFo3RFlzRUx3MWRLam5MNzFWVVRyVkl4?=
 =?utf-8?B?cnN2U1l4ejkwb1pFQ05pRUl0bXZuRWh5R1pCd3kvbTl6TjNkS0pWUk9BUjVq?=
 =?utf-8?B?ak1RRHo3aGFBdTRXR3BibjdZQW5OM0RhVk9JMCtrZ3dFVUZuYklFZU5vQ1Mv?=
 =?utf-8?B?VnpoeTRQYmJTYWJyTDIxYklUay9YVDlvSDlzQ3V5Vks4YUNZSUY5MUVwR3Yy?=
 =?utf-8?B?R2hDUjRmUFFOdHBrVHNCWGVZTit1eGlsdG5DN2grREcvZDRrUmdpekYwQlJF?=
 =?utf-8?B?ZTMwKyt4M3ZHMGpKRjBiZW0rWWx5Q1RXa2tFVnBpbkVVcG53UDZkekxMczR2?=
 =?utf-8?B?ajNqaWhRQnBGcGpQSks0enA4UGY5Y1dOR2VxQ0szL2hCUCtMaFVFb2dleWZT?=
 =?utf-8?Q?9lh1D8L2E8Wi62UYP9v8ZoT5a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afb8fac-8156-44fd-18f7-08ddde213e26
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:34:11.7182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWbk823NcCWSdabP5wDhebjDJt73pOy0tuVRiRv8lJI2XX09QKaIqmXdEun8v45dDJVtSpeL4EuXqSz5RYvBEw==
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


On 05/08/2025 4:20 PM, Maayan Kashani wrote:
> This patch addresses AddressSanitizer (ASan) stack-use-after-scope
> issues occurring during RSS flow creation in the MLX5 driver.
> The root cause stemmed from the use of compound literals to
> initialize flow action configurations, which could result in
> pointers to temporary stack memory being retained in flow structures.
> When these pointers were later accessed during flow conversion,
> the underlying stack memory was no longer valid,
> leading to ASAN-detected errors.
> 
> Modifications:
> In mlx5_hw_rss_ptype_create_base_flow(),
> the struct rte_flow_action_jump is now constructed
> at the start of the function, rather than within the do statement.
> This ensures a persistent stack allocation for the structure,
> preventing use-after-scope situations.
> 
> This change eliminates the following ASan errors:
> stack-use-after-scope reported in rte_flow_conv_copy
> 
> Fixes: ae67e3c43dd5 ("net/mlx5: support RSS expansion in non-template HWS setup")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

