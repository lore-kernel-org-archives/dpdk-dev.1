Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFC6C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 06:26:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26203402F1;
	Mon, 12 May 2025 08:26:35 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by mails.dpdk.org (Postfix) with ESMTP id 087FC4026A;
 Mon, 12 May 2025 08:26:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJRCHfxBKYhC2HDWJINDU04ZY5Havk6MXeUs49q5g6vsDsIKZnVWuAbzVPMyKA3R6Cy1GS188G3KohXRDKypS5JMX9ALsOQ+bXpiXe1InnGRlw3taSrZJhqYVosfQOLrd6zsg/eVoDST/BBLsYowONlgUyCDzuU3L2I9hT7N1xLzzpt0TVFjv9YjzPGzeYXvYQ+T7Rvql41Zpv+Qw7BrTfpBni2HIt51dYQeb5i4AzTs2Ks5l9tRjXlev2nPSYsfytgtRwuFM74ScZcr8QmjTqKYVgGDlVacu0K4cvlaeM6Yxz6wfNlGkbT+tx4gpdLpZKDhQEDgO62ThlIvQRGlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0YIur9VF0oYJe6z0r8zrdoNZJ5RFE7qUz7nZy9dZrI=;
 b=AXTdogYfACm13hYnxZMMGxEzKQafqA2Dx7QTKZIhGupp47yabH9nTaeObg9N19hkuWteIprniUlJ7mVjRu/io1z3ts0gXQeeFaNj69OlqrAgIsCGxGzn2y+HZ5xxaPOIK2FRQj+RlYGki21+dMJOQI4S9bOjxYbzbJ0dyjXgIYv4ZtJwMhoY7EO86ajFTAk5dUybm5A7ncpxvOziHIH2Fc5abgbbzSQZO1t/sKR6vMgWdHnLKQSCqXl6mEUngguxJ1TOFj7VmC6DuJ5XBobxoCpT8NbSGEZuh8IaP00Kuyb29+EkHM0ioo0tz7a0G7ESouaEthq1BeYqPI+beu4iFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0YIur9VF0oYJe6z0r8zrdoNZJ5RFE7qUz7nZy9dZrI=;
 b=cWiabquj2+AOjdDEl+bvZpBioXTELeQequhIt1CaIIrpIB8wc3gtgICnEWtW+tIXPvv4TY3Im/W68r5zOGmLpogv21VyohQ+8CGkrmBr2FTCnj6jkq9jsyA76aVmGYIhch2EiGBjO/H1mWWf/WckZW812hHcT5lRaM5mfmem3yzwsXLXKhimSpWZ56w1OHh3LelYUavx4Rk9Y6ipAuqted3M1THpmjn1w2BmTYQ/7anKoPI4/5XgWNQ22cxmcHxv716+sSUiHbSvvIyDV2t2jzeKzJ+4Xa7vhQhMdAgaE6BVhEEmL4jS8vKBDYJZfDxJkV+0cNBVDrPPZBbHdPq39Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 06:26:31 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:26:31 +0000
Message-ID: <6cf4baa7-8ef1-4092-b7b6-a6ef81b8ed36@nvidia.com>
Date: Mon, 12 May 2025 09:26:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] net/mlx5: flow counter pool fixes
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250425194105.39401-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250425194105.39401-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 8854349a-7097-4d7f-902f-08dd911def68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3VGWTVDQXd1OE4yMW1WNTBHQlJXRC83bDArV1M1MWg1enppeTVVK3N1ckFs?=
 =?utf-8?B?b3RZbFhEeEhsMmFYcEtHVlkrL096UkRLbFVBeFRQekI1RFVvbGRMelpzQlZC?=
 =?utf-8?B?d1RZYkNmNDFUdlR1NE9EUzlwME5CYnFoMDRRM0VabGJyT2tNZ3ZkbThKRmxk?=
 =?utf-8?B?ZkhuWmZSa01sMUNZZStMME5UV1BVbk5oc1AwSHV2bWdVVEl3NkZkbjByQWxL?=
 =?utf-8?B?bTNqWlRWNEZJWXZRN1hqY0tDZmRTcTMyNDNzOFpqZE8vUzIrbDhXNzQrc2dQ?=
 =?utf-8?B?WWxsMklScm1kYzlNVUhJOUhUcFMrNEJwN3dzRE4vbHJod0RlUHgwby9IVHZh?=
 =?utf-8?B?MFJwWGdzdldBOGZhbjAwK21XZmc1UlFSSlNMSlN1T005ekQ3eEVSbFp3WnRO?=
 =?utf-8?B?eWtDeXozc0N2ckEzV2hoUFFsRFpEUVdIK3hjSUc4WmcwZUszb0c1UHp0eEgv?=
 =?utf-8?B?aXBTNjZJcnVRa1FiczRTVkR0ODhnZHlkOGx0VDNsdGp3a05naXdFRlNNTGl1?=
 =?utf-8?B?VmhWQVdhNDRaL0tBN1gxQlZFRklmRmt5bFdoem5uSXdCM3cyaG90eVY0TFRW?=
 =?utf-8?B?Tzc1NnJFbzJvNkozRVJwRy9HM01ENkZ6VGt3NElramVRME1oWjlKdlI2TUY2?=
 =?utf-8?B?S2RBejd3THhyaytLQXRWd1N4ZnFmanZRS08yVlY3OTVUcFhlWVFFSzl0YytP?=
 =?utf-8?B?dU1yTUlDNStRYmlhai9CejJHYzdMSm1SRks2eW84SnZyWk1YRm9Jb3hCUFF4?=
 =?utf-8?B?RjByMkJlLzZHR3FqZzgwajRlLzRSU1FkRzNjNGplQjBYRC9sVzRQSFpTcmkv?=
 =?utf-8?B?YUZjdStVWTZmSlVMUFNiYkpYaTJuRVBoVmxMOTVraGZ4ZkNsZmJFSWZzclNM?=
 =?utf-8?B?ZXRSVEREMEpUV3JIZk9pWENVN1RjT2JXak1nWTdJWmUvenRIaHlhb1BvUCth?=
 =?utf-8?B?Zm9iVDdmR0V0V0NxSTJZWURrYUNhdDhrUzkzYTdlY1k0VXQ4cjRvUzlDQWFa?=
 =?utf-8?B?TlYyWHVUTW0vSUVOTml4Wk84MklLeUMvYjZteVN3UHhYTnl3Smk4ZkZQMFl1?=
 =?utf-8?B?NTJDK1djejFNQUNNMVhuZ09UOGw0OTFYNUVqZDA1YXpjZHltcE05c1JkblBQ?=
 =?utf-8?B?cDZnK05xZG9zVmFPVmVsMzRpWklBV21UelNtVTB4ZTFjNFFJbktTU2J1R1kv?=
 =?utf-8?B?Ny85ZndlZWNUZ0tEK3E0dG90Q3l2bzZmVFFyZUZLenFmanlBbWsxVXpQNllU?=
 =?utf-8?B?R1FtRWRjalQ2MmdOM3pFc25xL2lXZ2ZKOVVMMFVPc3hLVCtDMTFUdmRad1pR?=
 =?utf-8?B?dEVuM2FFM1MyZDdVenk5QlgzZ29VMDkya2lMalV2Ukk4c1VZVDA1bGNqaUNa?=
 =?utf-8?B?Mk5LcXQra2UrWEdHSjBjVWhyZ25TWTRhMWhXQ1kzdXpjYUFZSEZjRjR4RlYx?=
 =?utf-8?B?RFZtSFNveUFVQ3djY3Y2cWVqeG5FQVRaUFUzdS9ScWRoREhuc0U5RFhodkZQ?=
 =?utf-8?B?R3dPS2VvRGlIWUR6SkF4VTNFckF1cTlpU2JhR0ZPYXRRVnMwVk5VRkMwOUc2?=
 =?utf-8?B?bnEwaWRONC81cVdtbmZ4UDUvcWFsdW1RU0xpejc0YkRaTVRiYWRHVE90WGQz?=
 =?utf-8?B?SERDUytHWlJ4TEZyWjBoRnNhNTEyOUVPZVErZ3JkUzBKZDF4Sk9UVjZ6OE5y?=
 =?utf-8?B?eXhNV1UvT1l1TGZYZ2lnWWxDcDE2RUpTT1ZvVmV1N2ZEVC8rdzBsWVYzZVVu?=
 =?utf-8?B?YWRMU0Y1ZHpzM0ZaakRPemFCWWxEQ1dncEZnZnBZTjJINFo4b1JNMngrdGVZ?=
 =?utf-8?B?WXZ0ZlpXMVprZFhFTHNyT3c2eUIrSnh6M0FMVFlNKzJ3VzdyalBnZWhaYks1?=
 =?utf-8?B?RXpVd1ZmUTdpQi9PSGpIK3IzU2pTT25TeTdSTHF5OEhIaElzU1dEaTdzMHhF?=
 =?utf-8?Q?6eMhtavYYxg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjYxRUJ5ZFdxYldkOWJGZ3Z4d0MvWlhpZ2hrZjdmaWU3bytHaFUrVmJOeVZG?=
 =?utf-8?B?VlpCYTJVTkZlbHRDTzNSbU5tVWNWZ250cVc3Y0pEYSt5T3Bjb09JcmFLeGxh?=
 =?utf-8?B?dVhia3BUSWdCNVpQeFRVYnowSUxlY0srLzhQL09MN1dBd1Yvc0Z4U0hXL1pL?=
 =?utf-8?B?VFVlNFNhVXRkUUJKaTJ1K0dKR3hzR0JTTmtIbUhCMldkbFZNQmlnRzR2QUVt?=
 =?utf-8?B?Vm1rdk5zTFlIZ1lSUHdIVU42NlBiVmU4MjFranFLK3JJMHZiOGdRVGlJNWo2?=
 =?utf-8?B?U2pBeFY5ZWZlOUdZazFIQ2JON0tmdHR2amYwcCs5UjJ2OU5TRWxyVXQ1Ui9L?=
 =?utf-8?B?bStQNWh4QkVtL3dUbXJYb3hoNnkzOTJvUDk3dFkzaWN1N3BNUDJkU0o3eU1l?=
 =?utf-8?B?Z2NUWWlyazNiTTN1L3VxMkhEeE5NenJnTWpyN3dGcG9LVUJ0OGtvZzNBd2ti?=
 =?utf-8?B?YkRubDJQMDZnbU95Qmp6bU5jdU1IRXpINkh6Tnc0ZzlNOGJhdktlaWNhNHl4?=
 =?utf-8?B?Z29tRzJzWFVHUXhWVXE5T1ZlOEVuam5KU1BpcGVvaUhRSk1yNGtvU1pZYUVk?=
 =?utf-8?B?UXpiY1p0WVN5QTl4WkxBVDBpL201RlRKb1BZZjVscTF1QVpmK3F6NFNWWFgw?=
 =?utf-8?B?aDF1YndDSnRlajd5dXR6b3c1REJpUmFCaHo4U3FkYnNxZ2tjNCtkT28rdzJD?=
 =?utf-8?B?cDYrQ2JQNTZrc040NVNzK3RKTjdtQ2g2VkVMTnFVKzAralYrWVdybVpXaVVr?=
 =?utf-8?B?bDJzREs1azV3K0RGVGcwVWpRajlHVmU0MFp6NVU0S1p2MnRNVTJSZDBtTmpy?=
 =?utf-8?B?RTRLRWlGcy9tUDRDcXNJMHk5WnpEd00rQ2FqQjVLcU4ydTd0aHRpdDhiZVUr?=
 =?utf-8?B?SEFwQWF3QTF0MWxLQXRzMFZzL1E3WWtpNitpdkNIalRiR1V6VTdGU05aNzk2?=
 =?utf-8?B?Mit5YjNhdDN0NVdRVlA0bktIdVNiNHRaNlorcmtQMUp5bjdrYTFwVDdZOG9m?=
 =?utf-8?B?cS8xc2ZPSWw5ay9YVjRzUGt4U2ZyT0t5eHhKdmhFNXIyeDRIbFEveHhYNGlM?=
 =?utf-8?B?OFBXSkJjaHI2em9wVUUwVmFhTkxGaHlCRWZUM0NIcCtkdVhtZTRyYUR2Q2tM?=
 =?utf-8?B?Ni9uNS9VRjd5WWxPdERTSlptQ3pMVlNSbHk3Zithb0R6RURDdEpzczV6OTNG?=
 =?utf-8?B?ekVTUGJtenpSeE1ucmdselptVy9sbEc0WkhhOUEva251N2pHS2N4aTE1d1ZF?=
 =?utf-8?B?RXA3MU1xQmh6N2xGMXEvT01QTzF6WUhxdUFFOFFOM0trMTNkNkU0U1ZCOS9V?=
 =?utf-8?B?ZkllUDFCZC85WnIwZ2hXT1hEQ21MNEJWdHMrRThWM05Pd0Q1cFlhME9sd1VQ?=
 =?utf-8?B?Ky96MDBlRFpmWlVjY21IU1BqZHZuZC9VWWk2NEZtb3NValpXR3hVWERrazIz?=
 =?utf-8?B?Qm5IQ3J5MHlURUtVRmJMMmpUcGEvMzM5dkpuT3VEamhXeCtXY0s4Rkg1cFZF?=
 =?utf-8?B?WU53OHMzbWs3TUpkRm9zL2pDMzc5MWc2WTc2OUNTdHUrQ1NXNXFOR1NYUDh1?=
 =?utf-8?B?WFdmbVd0bjFuR0RYbGxVQlZMMDNqOHBpdEFlVFFYcjhjMEJOaGhJU0Nhajha?=
 =?utf-8?B?czNnNlJ1aW9FV3Q2VUlGMVVZNnBQcEFlaWZWNDErT0ZmU0p1Mm1VNFI3TXVH?=
 =?utf-8?B?bFFJNzYrVFREaVRuY0pqR3FGVytPV011eHN0dzlwM2o2N2pMeWhoL1JxSzBU?=
 =?utf-8?B?L3pZdkIrU05NWFlZZ0taaHdXUXc5TlZZWHQ1Mnc0WU9DN2xBTGl4SVB3MmFH?=
 =?utf-8?B?d2VTeVZLWnlVNkxrdi9PR3ErQTV1dHdOakk3ZDV4RlZtdURadSt1OGhjcXp2?=
 =?utf-8?B?d0Qzb21wRkFjU2ZmbnBGa2I4eGdoNWpZNXp3akUyWEJDWDBoYjk1Qkg1VlFR?=
 =?utf-8?B?U2VMUGZneU5EL1h4Zmd3NFUwQUdtTTd5ckFONEJ3aDVEMG5iS0crRVYwUENn?=
 =?utf-8?B?SDJLaHpkVW82MC9HS0ZCZ2dPaUE4a1hUcnRweEZ6M3FNMW4xVG5HS21CNkJv?=
 =?utf-8?B?TVBIODhtLzU2RTNJdE1sam9PVFRtOXJqVFg0Mm01RThKQ00ydldBWHlqMGls?=
 =?utf-8?Q?ha4hgFIk9nay/xC5lClqdZYV3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8854349a-7097-4d7f-902f-08dd911def68
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:26:31.5844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZBo6sgz5NGRl8Vzmdn7kws9NKNRwVOm0w5ocFvNyJXkrhW7Sv4Dns4XAvbnf01gAC2jBbloO1C+pDgLsB59VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
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


On 25/04/2025 10:41 PM, Dariusz Sosnowski wrote:
> This patch series includes several fixes for flow counter pool
> used with HW Steering flow engine.
> 
> Dariusz Sosnowski (2):
>    net/mlx5: fix counter pool init error propagation
>    net/mlx5: fix counter service thread init
> 
>   drivers/net/mlx5/mlx5_hws_cnt.c | 29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)
> 
> --
> 2.39.5
> 
Series applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

