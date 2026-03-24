Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923A7E9A77B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:22:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90164402BE;
	Tue, 24 Mar 2026 13:22:29 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by mails.dpdk.org (Postfix) with ESMTP id 393654025F;
 Tue, 24 Mar 2026 13:22:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdWGKCXn0Nyr2IcVdi0FfcsJE3B6Sb8I7DkYbSgNiSVD3vpygYS+oVYTQYcAUNPKXLG2dt+P0409mnnw1iSnZsXgj4H4xhIdGuVJRzXd/T83bLpKKU9pxIBZ21h8BilmRJIx0z1BZiXYjEU+B/aBKMCUM+N2YJ2AeOp94NX1LPzPpEGvdZGSNe4NPJfg0CYA3TzxtGRXWHxE8u2JzwftPIu5P2fewSuqCEBBPZRWtEtQKfcbN+NLd4MRUcd9/wpwDZdA8ORdaWZJaxNYadIWaaAi5ok6c3ps9RJ82rGKS5q1atdrFKCDP8IqdCTw5BgcJO2Yp4i0jjJVYA2bXNLdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0Oyhx0HdjQfhJWFIv7aQ2/kLFm8aIVQnnwVMt8jEAs=;
 b=ykA1vrSFCJKVfrD6mM+RAQD9C9oNwDrgznJl46RcnNDT5mVzzq4rygQXvyToAZWcPzNwf/FHgqY/E33KbMFEdcjIz5FqzDD+AHm+Z2aE3+rcyfVGbCxbG70/d7ytILBKmS8PPjFxz56qZHC59Nb8kSnpRmlcln2a8NfC5OU9iji4Elnd9s8PlYcwD5W8ZXNnx90t0Tut/uRlWZ8ZcOM365B5PXsWv9o71+OQRYcOON8AT0897RoAt0+Od5h0z1pKmdmmSexL7woqo5Sm3kB7hv0K+fUSn+MMPwuAHp3DzJoE0gxC9z5Ut1+MksMLvP9YiKeo4G315A9PRe3QybT9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0Oyhx0HdjQfhJWFIv7aQ2/kLFm8aIVQnnwVMt8jEAs=;
 b=ZlXEtImyGxKMevyK3eDpN0lOuhk+FbfRxQIghau0fDzWZ+6flkjOT70K8g1GP+PmfWbTqj1nJxtI6kINHI1vGKq2SqBxAit0cvu9sQ9Mm8A0DbPngBQGz6FhCeEMX8avvivri72FbYBbwZz7fmZaTohHHZ3Nib116IMCCrJetXqKoUDr5vOx+kCiF9kbvV2LzyeGbNRS8GfYpUTSeDUph2+wQPBQKT4rlvyn+S/LK866OkX5h9zF8jrnvUcCQLbRdOS/U+LhbkMGFH17+rOn0eD0QFDru5c5I4boKafT5JfFnszuVK/gB+i6jAZv7sbbyqTZtnRcedO2RvgUQFypGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:22:21 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:22:21 +0000
Message-ID: <9861f51f-dbeb-40b7-81ae-d42973ff798f@nvidia.com>
Date: Tue, 24 Mar 2026 14:22:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix meter ASO action leak on release to pool
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Li Zhang <lizh@nvidia.com>
References: <20260315083636.93386-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260315083636.93386-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::12) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8d536e-343c-4570-3cc3-08de899ffefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: IFhDSDJN/CM8IY4so6xQc9/TKUDRuzUgB/KJLfAtyR9x0Q4X3Zxd+Wl3yfvJhcfuZ00hFPtSxu9cQHZK3IqP2WNehI4bV6I/XiZDguTm0WbRpxHV8S2NVu2fQJBoWpZMbfwCQ9vgDvtX+uxONZFr5y/9m+xQPYE7Xdw9DbtiyzR8X8owi3Zi0tcf5Xx9Prvzwm9jnOZYPV319UxB7QjatTzqCmt2v7efV9wTvOqUT3X4rDNllsFgMFmNMwXNu99nTHFFb+cLiGPZZ5c7I35+5mm4XvHY+4QK6j10wobTECUu3qz33VpJDYzmEg5XM4QCP21xCJOcP1vHvE/snEebsGVqrA2yZ1m0poCCc03M0YXjBpjrQ2JRH5tDb5fHCw9gI4ysKH+C333NIOQxtAumw0iufk9dfU8gRUA0G4yde/BkYlGmv9IU+P1iXi+DJE3Z+7Xs/UiIVwlfeOh/prI7gnA53cnflKyOJsRhH7qt+nOOW90Re9UEmGbx07AGhLM0FhSAaalBKAaF/rnabxFNdDUGEA1u5EH38HIFYwnf+FanXuO66Q7uoorbbKiMoBbm0kQRMAKVwquMkmueq2Mq/hxNqitUfC+KdABaCmIDCgqf7mwQRz+o1LA81RCSuNb5KF7Xjaj174jQ/EurmJlGZKMdS3Gj4HlIk4DUcAjeE7LilCjpKkxtaSno6UQxMi35ox23NXdLR+lkE0Eauao8Ek62ddC6H9v7B3/kVbdGrno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VERuY0djV2hOOWs4RVUyNHF4VVFyNmxFUGhidmhEVkZEYXJhZk81Y3MvcmtM?=
 =?utf-8?B?dEJBL0tHL3FxdGdremZTZ0RiM01GVHpJMFBJL1N4WHprK1ZQLzBFQUR5NC9k?=
 =?utf-8?B?Q3JraGZ0MTVWSm5JQkd6YXdZUzVUZFczK3B0dGFxc1lvVFJyc05nSzQ2VTI5?=
 =?utf-8?B?a3djc21HVFgyMEtKaDNiYjg2WEpzbUM5RnJySE5kZHVOV3M0YU1WbVF4SGdu?=
 =?utf-8?B?elNvNUNvL1lhMitBZGNRRlJ2YVdoRjBwU1A2NTkyWlo5YlA2TlZ1MDd2VGdN?=
 =?utf-8?B?SlVNVyt1NTQvZDdIRW9sb1dnS0FqNzBCN3k0NWMxMmVHWFlHdUF5bjRPckJV?=
 =?utf-8?B?NFN1aUZ5V2FITFlJcVJqRDI3d1NyRXpLaURrYjBTZzNmc2twTXhuZHRLTHc4?=
 =?utf-8?B?TDhCK1U3cVNjeVRxMFpOR0lHOC9xNnZyZ2hCZXJ5OHYyVHI5bElidFdBRjhD?=
 =?utf-8?B?NXZhdlh2NmlmWGl6RUJKcmV2U3VqNHo2MEY3STc1TnlBNElhVkJMcE9GM0Rp?=
 =?utf-8?B?MVdDc1hzOWw2UTFhdHNZanphb2VINXYxSDMwN0lYZnhKOFRxOXhnWVhMdzFB?=
 =?utf-8?B?Y2YwY2E5c3dnczlvbEZaWkFCU2FySXB0enliZ0tlcGZDZ09ReW1hTVRDUzR6?=
 =?utf-8?B?MWNGN2g1V2FVaUNGL3dJVjBIQW56UEUwYTVLUDN5YWxiQUp1YnpLV3JKYVJE?=
 =?utf-8?B?OVFmak9TRXBZaW56Zyt0cGJhREdwMFA5SnFwdTRYOTFRaHR6VFVuNnhEaHdr?=
 =?utf-8?B?dWJuRy9GV09WVzRYRktNSnoyeHZvY0s1VUY4Mms4bFhxYTU0b04vWjAyK3o3?=
 =?utf-8?B?V1A0bzd3aFFpOGsxY1ArQUhFcmZVbzZHNnZxRVAydzg5YzZsdEE2V00yb0Q0?=
 =?utf-8?B?SDl5eGpsUkVvb0RFRHpBK2JLWVJKdWJCNDRHWThwR2F0bzZGQk5MS0hXSFg4?=
 =?utf-8?B?R3hYYkZpUWNKL0xVT1QxU3F6MjBxNUtBTktuaE1vdmlFblo2S2tabTY3d0li?=
 =?utf-8?B?VWlpV0JaY2ZtVjRFSWRLcGc1Q0J0aWRpSmc3dkYrci82UC9Id1hRQmRRUGhT?=
 =?utf-8?B?UUFOTzdZYUd2TGNLU2RhcVBJMTNmMlBiNTdKbFNBbjJmVTU3T0hMWHpjM05M?=
 =?utf-8?B?SStOSjAvRlZKak9tamM4RklkTEkzTE9zQTZHeG96T3VlZmpWM3FmSWg5VUVC?=
 =?utf-8?B?Y2ZQWlV5NGdLU3FUSUhVVCtPNkVRRDd0SkVxWTNDYXQ4RUVDSnVUSkhmU2I1?=
 =?utf-8?B?VXB6V2pMUGFGeDRlN21DT1QyZVoxZDBsd05jMkVKUjV5UEVkbVRZR2pDZHZp?=
 =?utf-8?B?TjJXeDU4RXdWdEYrNWxmVjUzK2VsVDJyOHZaQ29rY3ZkZWdwSGVhdVVGOUh2?=
 =?utf-8?B?b2tKWXgrTjF1YjhVcThFSVk3TlIxbUJQOUEzbmlrQS9WSzN2cUcvN1JwN0Fw?=
 =?utf-8?B?UDhtRFFDU0ZmZU05UUhnTVpWb3lQeXRZbEhHQUx6K0FpMWV6dGVEQkkwYlUz?=
 =?utf-8?B?SnNUeXdDYnJ0WUNBSFpuUDJxZDRSQ3huMGgxcXRPQlVUWVZVSTNhMmhmdTky?=
 =?utf-8?B?UjREdkxDZlQvcG10b2l1M1liQkpIWEl3M0k1d2lGTnd4Y2p2WlQ0R2JrRUhS?=
 =?utf-8?B?WVdnTFFEenpYSWtyUFZ2c0U0a3Mva1F0ZnRkK3QwZFJxeGwrWGEzNE54Rm45?=
 =?utf-8?B?aFhrdDcvMVVJbG1oWmdwNFBOVzJaZ3VCNTFYS2VJMFB6SitwNy9qYUJpNXVu?=
 =?utf-8?B?LzIxcnhiSk5keVR0YnN6dFF1aEZSaW9BSU14Qkwva3lpNFZuMDR2V3ZHUVJr?=
 =?utf-8?B?L1NTTHExSThQdVlucVZLTnd1WlZCVTd2U0J2akVhUTFKYUVzWmVKT3VTOFVl?=
 =?utf-8?B?U29MQUZqeUV3RGVVMU1MTmFiNllhWHNtZ2wxbzFkRnNmZFBNelQwNGw1dWZw?=
 =?utf-8?B?WHNEMzJHeXhNWUJzMW1ZRWo2TE9MWWtLdUEvQnFkaXU1c2xYcVFFRTBJb0ZS?=
 =?utf-8?B?dVNrQ1lrQ0NVQlNFNCtDZUZESkhtc3NrVzNYUTIxazU1d0ltbU9VYlBiVlZZ?=
 =?utf-8?B?UDJVVG9ZS0I0eWJRWmc0WHpBK2MzTExKVDRJTGZ4ZHYvMDNKbkRUbHEvOE81?=
 =?utf-8?B?WnN6NU1sYTlqYktpdUt3UlBMOHh0YlFkYzM2aTNGQ3ZYc1MyVGRHZGVEWlZa?=
 =?utf-8?B?Wk4vV0lRY3RJTDFFU0h2Wkk2cEtkQUdvZ3pTVEEyTDFHTUROSnRPM3FuYS9I?=
 =?utf-8?B?dkVJUm5pVkpFVXNrYjM5NXNIbEg1UnFDQWxmaFpVVDVtWURQditaQ3drL3lB?=
 =?utf-8?B?VUYxbEhWM3V1OStWelJ6MTRLM0pzeTR0ZWk4eVlvQ1kvSWE2WXY1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8d536e-343c-4570-3cc3-08de899ffefc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:22:20.8143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elplA0cBsgMytLoe4tCrbblnJVg0ZabZYJ8nfBHVX5wtb8kUxVuaCrS64WgxHUgs3NFQ/jp7c7G9qwn7iBWQdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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


On 15/03/2026 10:36 AM, Shani Peretz wrote:
> flow_dv_aso_mtr_release_to_pool() uses memset to zero the entire
> mlx5_flow_meter_info struct when returning a meter to the free pool.
> This erases the meter_action_g and meter_action_y pointers without
> calling destroy_flow_action on the underlying DR ASO actions.
> 
> The leak compounds on repeated meter create/destroy cycles because
> the caching check in flow_dv_mtr_alloc() — if (!fm.meter_action_g) —
> always sees NULL and allocates a new action every time instead of
> reusing the existing one.
> At shutdown, mlx5_aso_flow_mtrs_mng_close() also skips destruction
> since the pointers are already NULL.
> 
> Fixed by saving and restoring meter_action_g and meter_action_y across
> the memset so the cached actions survive pool recycling and are
> properly destroyed only at shutdown.
> 
> Fixes: e6100c7b6226 ("net/mlx5: add flow meter pool to manage meter object")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

