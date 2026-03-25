Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D2B109C022
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 14:29:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B287540ED6;
	Wed, 25 Mar 2026 15:29:04 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by mails.dpdk.org (Postfix) with ESMTP id D874040612
 for <dev@dpdk.org>; Wed, 25 Mar 2026 15:29:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXdWzuXnwKLFpuuP8A/961uqRBcb6tKuuJaLq/ki2UYvDtO95y42VnQOnNFgFcQS34JD7kD9xkj7JwOYBayxWqc/mi8LehktaMAsYkpV+JSXRoB6Z3lkfuLj9W77XArE8M3JqZjSDrRVf20IIPAy0a7yU79M4uzoOpng6JSqN7LXrZZK3Y45ynSh0O+soHfuPkKUX48ZNXoGnf81+YiaR6+LKe0ESTrnPM6XKXpp+vRDS2aYcPUv+iq/iM3oe7T9ALojIUqpZz4RU9jeaRsAYjSfzUJDB2jp5s1QwGI7HH976aVM4IbY6Aq75iJS8aGOZZtCLRnMIkR7S4baB13oUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJl85IZuydksMSQ1kuwmzRlDDm68E76JzmVltoDSCLs=;
 b=kL4MYlmK7SimR+X2CW2Nnm7FRPPj3QAwloR6f3BFjvBQPaWXyLSMqTJoWLfKgo4Gefans3UcoZ2XxVo/kO3gx28OoGXFE3DnlSATr/55XPos+GGKMhVccURwC3+1KKS4KL7OSZmSkXgdUW5ViGmSHLFGEAjnhSYvbugIs7k5JW8WxrUnWLGcfaIMSQC94strc76wA4u5J8B6H4+I4FWyFuL5+2+kmRD41Gfdv1n657UuyUGWr5kEr6w74i4+NuZDbLusZLifQ3y+Z1xOjqOeL/tpVGbj8bTPrvL2cVETRuuggQyYMYMpdGX3XmAZNf6bxdz72jfAWjCyHUm0iIDy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJl85IZuydksMSQ1kuwmzRlDDm68E76JzmVltoDSCLs=;
 b=csguzdWTonptwKnF0xEFIRr4LSTE1gFVFHB0s2rNttTluL+zEjKZd5rduDRnJd5/g8P7Xo6EpbHbs4PyEBgRhcvpu4f6wbK1gsPGhT9Mb8yqsX50jDe2Fz9OQxyIu8uxYdr9mQ5c8l/jGh3z+mhtpEglcJJ6n16GWqot1p9h7PRftMbZBooVpyYqN/AGzlUk/P+7HpA7sOYDQ3fOQV1iS1ax9hhXJhT8fWiozVYLfv5KVR1O0Jj0RH5LVf01cqpLo0d5h1Hvt8UAyzisSIwbaVFB9YZcPTvJSsyYG9Fjevvh8oyBdPoRAnV7PaaCoDruR1gCcuUEJ/MX+DuBt5mpIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:29:00 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 14:29:00 +0000
Message-ID: <e468a4fd-4e3b-45be-a593-a030e5fe74ba@nvidia.com>
Date: Wed, 25 Mar 2026 16:28:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] net/mlx5: small debugging improvements
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <20260324171028.26727-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260324171028.26727-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5c4449-51bf-4ade-5c8d-08de8a7adb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: L/tECZKRJoJMGC5iCS8kiD/KgHAX7aexIs70LXtowL0qD7wjf3Im4mcbMxgLsECJsk83f1JjnIE6XjtYwPNut8vMfXohA73Lihwtei4DWU7AWJbvDM15VxY4h8nKO2TriN8fkx8qI760xtgjYPoi99FVBnPExgXEPnjV1ulUDGFKPxlIKR/0+Kqy2OxsjHfWd3qmUk4BJ2wl3AaYJTHN+euVdh/rHOG5+9CXyfTdcIHXjiwin+7RhjGQV0P8GONUHWSv83kSjJMqEP2EOIlZzhRBGmoQ53fCL+b7g4dBqeFzTjdUX7p6btM3Q8i/VwNt+cPXr9+6gJFnMZfOvxkVp8U1SHKnxJMQyowaKYiGkmgn3tRdxA0vANyqlWUgzHoWxYJCJ1+Tutahw5ZTzUdpH35bZjOm0eJuisyFU2t2H3TWqoFYBIVToTZGg2MxMSWf3paI/2O6xV/utX2MTjwnUlWRRwgBIVKj5pv8bwhs2fUOb663HkJ7no8URB/ghI4RBsjQUmqaGpx4vrAr4j8FcXmvVxlN2ykJoqwis3tsPusrh6cK+l4NWYd83v/9tGmjkZ8UDPBwrKqF9QdKvvzCH5DdTqy5duLfulr3gjST1rVIBnjGKeXMGQJgfOtCJqUAO8Y1u/vcewcp53nhAj7eIYKQxxUYjRZcCI/F4Pzi4oqZf+b6IhUPIs7iZmfux0MiPcWoRnnHqc7K0gwkGGqA+PAsfeNEbMRipnnK3NXYHss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVVbnh6SnhKelorTk1mZkVHSDVNbFRsUGgrVDkvSVRMWTYzNUZGWmR3NWx5?=
 =?utf-8?B?c1BNQ2h0QVc1Z056TVNBbmhUSndmc1JhVmdoTGxxYjFhckhBaWxYam90a0VU?=
 =?utf-8?B?eDBUQTh3TGxqakYzNkc2L1dZb0VlUE9Dd2Nta3crUWtaY2dGZHJjZXJaT0hB?=
 =?utf-8?B?VVFkdVBNRGxFWEM5R1Rta0pHSjkrT08vZTJFQm1wSG1XR0FLRnp3TkR6MHZv?=
 =?utf-8?B?cHpveWhNNng5TERiSEZuLzBZNzlMUVdzdmV0V3grNHM3aHZId21MSzZJaVhE?=
 =?utf-8?B?MTVTTHdCY1JvRE9DNkQvaXo4YXUwaXR3Wk5LbWlHTEgzZXlWRnhnbm5OSnh0?=
 =?utf-8?B?Vy90Y01mSndxbjZRdkZpRUlBYVlpcW5iQWpYeDhYQWNUTkJtamJmMEllMWxk?=
 =?utf-8?B?VWljcUgzTUJOYXo5WjdLbUZjV282dFR5Z0dUanJOLzJIeS93QmdzY2VkSXo1?=
 =?utf-8?B?U1NCVTFxdW9jV2tqY05oM0RQdkdFeGxKcUQ5TUI5Rk9XSS9jTkRoZHBSYWhE?=
 =?utf-8?B?NjBrOXZIdDZGbGY4aG1DVThmN0lJNUYrdzZwbUdmSy8rb2VjQnpSNTU2M1FG?=
 =?utf-8?B?UkpPdmxuSmIyUWNEVU1aZUVLeGoveFpVMGdrUXA3TEpYOUQzSUM0NjBSTEtx?=
 =?utf-8?B?QzR4bWRkalRNWmFNaStRWUFnNFdIR2NTZ1c3Qm8vTnhQRC9nRUZNMVZwa0pv?=
 =?utf-8?B?TS9vbWZlVTBDaGlHbzdsMmlzWnh1Q3J1a1hFRVptbm9mNEM4NHBXYnRrUDV0?=
 =?utf-8?B?Wk1KRHdJNkkxencwRTRpWjVWYWUxNmtZQmZ5RzU2R0w4RVFTQXd4cGxEc0hH?=
 =?utf-8?B?RlZOcmF5MkpFdjRpaWZ6bmNjYVJ1YUx6YmwzNjN4OXdmTUVGZlhWb08yZWtB?=
 =?utf-8?B?cEdqanlubnBCTERYSnJVREhsWXJ6M0JuVXVPemg3ZzJydXg2VDViQ2lFcTM5?=
 =?utf-8?B?elFJTVA5cjdBbHdLbHVqaDUxMk9RRTBjQjNjUCtzdGs5akhEQlhETlAvUTJt?=
 =?utf-8?B?MTJIR3g2VFd4cWoyMC82ckpyRWk1dDlyRjhEbVlxUjhFN3ZQSmFhSXNSVnNo?=
 =?utf-8?B?WEhvZXpvYlJEK2tva2lUVUN1cUlPNVZ6TFR3M095V2xMazB4Y2g3bXRKZksy?=
 =?utf-8?B?Wk1oK1N6UDhHUENES0pCcDZEcG9YRGFPOG1WME8xdU1KOHM4RGhwMTBHenVh?=
 =?utf-8?B?UzN5NXBZcEhwcDNrMkZaY1NKZ3ArKys2MGRzNTVSVGplZjA2RUlJVVoya1Qv?=
 =?utf-8?B?RzFoSjhHeUtIbVBpMklOY3UzU3Awb3pGMFYzMERGV2g1MnJ2Q1lKYjJiQ0or?=
 =?utf-8?B?Q3BtVi8zYTlYRDJVMnVFSGZqRkVJMm04QjBxWjBTb2NsSnkwZE5WTDVRK3l4?=
 =?utf-8?B?ZlRSWUJLRzc3MnJBMmRIYmt4bVRDeUg0V1NaUmZNTkh4L2Y5b3dPNnkvOEdt?=
 =?utf-8?B?RSt5VWdqT01tWGlPN2hobmJnVjEyTUpzZkJtSjFpNW01NWRrQTh1ZWZHSWpP?=
 =?utf-8?B?RUhZeEJRbzhTaUVqeDR5ZjR0di9FS2JKeGRkcVVZSnZPb3B2RW5SOXBtWEhX?=
 =?utf-8?B?bFdqTHNreXhkWUo3N2xVeTNYYXRSTHhwSlY5b0N5TmxGcjFPR3N2RWFzQ0U1?=
 =?utf-8?B?ekg3cWo3NDZ1dVZ0MmxtYndWeTRLNmVzazVBTGNVOEcxcjZYNm1iZjlNdC9N?=
 =?utf-8?B?UTA1OHVrREdRY09WcW1zSVVrNXN4YnZNcWpBdkU4d1E4ZlUyTmhnaU5HRlIw?=
 =?utf-8?B?SVpIdlQ1TzNvNTdjOEk2Zkk4ejk0ZFJIbW1MQis1ak1EZlhXTFFrZUs1TnVm?=
 =?utf-8?B?VnIwd2JoMHFuaWxzVklnMkhRWk1WZmxieGtFOEp5c1RpbEJvTyswZTdYN0R6?=
 =?utf-8?B?REw1eFc3dzFJRnFyNG9GVm9MaFl5bHN6Z3VhNW5SYVNQQVR1Q0trZzVzNmZG?=
 =?utf-8?B?K3ZYb3hOMWpUVkZqL1RZNDYrU0hoc3FMeXZPRzZxOWw3cVhwNnRnbDZzOGN1?=
 =?utf-8?B?TUNpMElZLzNIYTh2Y0k0ZU5VUm52SjZCU3drQXM3eWZZRTI3N1hXNmZpQVFt?=
 =?utf-8?B?dkZYYXIyUUxGVE5aZHlvRE5KcmJGQ256Y2FqT3NQNVA5WGIxK2ZqOUNWVi85?=
 =?utf-8?B?TVB3OCtuaWdxL2NMK0Y0ZzJvYm5UaE9JTmVqRlRXNXBQbnBDY2ZDeEZ4WXhM?=
 =?utf-8?B?ZUVKSGM2QndTQlU3RDVQT2U4RjJHa1pqYXZXRVYzWHlybTFxS1BUMXVPQ0xn?=
 =?utf-8?B?YzRBb0p1KzFlYXBYWHJGSC9WTGJXVWFFL0Q3R2lvYXRtbmZtMkhRbDJzanpl?=
 =?utf-8?Q?6wntPYurSxIxX/RNCj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5c4449-51bf-4ade-5c8d-08de8a7adb20
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:29:00.4844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRYnXxjTqouI8C0ShcilollUyP8azPc1yUe4Bmnhlnz3K8Xe4RiwhWx5HbV38Z8WbEf9a3VbP0u22lRcrqM1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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


On 24/03/2026 7:10 PM, Dariusz Sosnowski wrote:
> Small debugging improvements for mlx5 PMD:
> 
> - Fix error logs generated on failure to modify SQ and RQ,
>    so that verbose FW error is printed.
> - Add reporting share group and share queue ID
>    in mlx5 implementation of rte_eth_rx_queue_info_get().
> 
> Dariusz Sosnowski (2):
>    common/mlx5: fix error logging for queue modify
>    net/mlx5: report share group and queue ID
> 
>   drivers/common/mlx5/mlx5_devx_cmds.c | 19 ++++++++-----------
>   drivers/net/mlx5/mlx5_rx.c           |  4 ++++
>   2 files changed, 12 insertions(+), 11 deletions(-)
> 
> --
> 2.47.3
> 

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

