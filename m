Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250ECD1D480
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 16:12:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33AB3402D3;
	Thu,  8 Jan 2026 17:12:37 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15]) by mails.dpdk.org (Postfix) with ESMTP id 62B1C4027A
 for <dev@dpdk.org>; Thu,  8 Jan 2026 17:12:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7x1V3FHshX3ZxRlhj/5TJ6Lu4/EO507Qb7/crpol9n7MlnvzzstAEGimzDrcmz/XaWVY+IiOLgKA1qR9HHJ+6Q+Ef4Mst/TmKQe5EWrL1GcTTqHw8E6Z277o6DzJGkeTDfRHgnuV4VtiwcCPpGnINDZse6Y5utpq5I/DJKKG0tWzM3mL52jj/+PfGXBfBnY7YDh2tAZEjBfL8BY7SMPd4A5i8eCbzym6PhQSubbcNn6esSNadMdN/g570ixyLpNPpwFSjS/xEuK3X16o75d1SwQHLc4f331eYIWLLntIrRyNWRHAypnq+9GPenzEiIj2fBj9vAiNF+ga49e84YPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVzt1trUNz7aWZafiPr7DlTgcevjr8fU88Cw4d1Dgek=;
 b=Tx0sfrK2CbbVeKQS0By5wZFhZIxOaZ0IQ4LDF3Z6okfJUViHgeHsoc2rhTST1mRox7nLLoFUsfhc0nf0NjO3yfhMiqzetam1FHovPp5u+ZS1OXj+/p+gBqSTe8PRGp37pXnxJQQxPYLe8Omd4DmiOeWxWl8XNiJg6ev4CQMtfvk5sDsOfMs8R3ULUF8f0y0YL1GIQE9jkM8pClYCfPfAfrD4WXExy98/XBC+6N9jplMsMl03NoLX39dYYmXSqg4CFyH9coRJU5P9l+k60V3r4GRlQyuwfqXne+S3OyBIfXA2/uVqv6ZF69UQln4rTzL0QHScLO5aiNLn0egohKFXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVzt1trUNz7aWZafiPr7DlTgcevjr8fU88Cw4d1Dgek=;
 b=gPHf8WRMt3SJYfRaGv1DPLv/z3U7Ny4fHkNTcrlw6jr/A3oP13Bu6h+70T8z9AkJt59DpDN5yRhkwTQzZ69WyTIlzbveVkW5A4Hsd0HdJDQhZKYLYn/BQeN97/xhNbmKDyGMoG9EI8QVyLGXAzZu9Sqeu8TK1NkfAz4cudw6kroEIR6DJ9CMwoaGWgD9v3bm+rJKmBvV8YJDmWymVwRLzbI+2pJQp+IvDM15rJJXhcHqFhzaC5RNjVRztUPZp6BRJTG36utpDQf2MkuyGNk4IQfXt8fqNs8N8QZjUSVAdSvrt99BtkuMDTMZg3R9s6b3ENmgPAgDgZRCOSodcfovyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:12:31 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::f900:8332:ba16:af99]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::f900:8332:ba16:af99%3]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 16:12:30 +0000
Message-ID: <2a1c0ecc-5792-48c1-936b-d03ce7874a7e@nvidia.com>
Date: Thu, 8 Jan 2026 18:12:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: add RSS TIR registration API
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20260108081232.5420-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260108081232.5420-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c8ffcc-932a-4dc6-738f-08de4ed0b989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1l4WmZFSThrZG1nZlB0a2dkT0FxczI4bnJYWnkyUEdIdDdvL1dVZjdWUndB?=
 =?utf-8?B?anlQRUMyWHM2NGh1UmRSSDl2VUUzZ05CZjNtUThHNE84U2NGQjZnQ1d5VzJP?=
 =?utf-8?B?STdqQjVTK2pvd2lnUU5jMzl6eCtaMmZreU1TYVl1VVh6cHJtWmg5ZEVWZWdm?=
 =?utf-8?B?ZHE4N2hNUlNWN3F0djROVnNUcUQrYWc4MVVnSE9HU0xmVklUS0FUdVpmTnpD?=
 =?utf-8?B?R0pnNXIzSXFOWi81TVNwcDVkVHBuSnhlcURDbjBiV3hLd0F5bTFlS29RdTB4?=
 =?utf-8?B?L29jTStQWThLWTNFbGZlb2RoMU84aU5CMm5oK09CWjk2YlBEVWRyYVNiRXZ4?=
 =?utf-8?B?SHcrNUxHYlJVTURsS0RScThONmpuNXNiM3JaaUxmUnNsQ3ZLQXhjSDYwRExp?=
 =?utf-8?B?MEV0TG9kOFMranRkcjBEYkE0MzNBK3h1Y1IwaXd1Q1ZDMFhlQVBjSnBXVEVk?=
 =?utf-8?B?T25Hd1dwQzNrOXQwa2Vkd29FKyt6bGZaWmhQcmJsYmc4bEkxSWhTMC9RaTh2?=
 =?utf-8?B?VlluT2hINmRzdUxqNWVPWGFIOWI1MDBzZXRTblNxanpwU1ZJK1JjZUZGMDR2?=
 =?utf-8?B?eHdwejBoOS8yaWg5NmZjU3B5dFRNZEVxcXRSOTVnM3ZzRk5XdjNGZHozYmtV?=
 =?utf-8?B?a3J5d2tJQ1RQVHRza2sycXB5dkpnSjl2UjhQc0U2RzRoRkVwYi9NcmdjSE4w?=
 =?utf-8?B?Y1lGN0dRVS9Xd1QvWkExSnluWEhBc29TWVphcVBJOGRpaU1Xdkg3YldQNHhs?=
 =?utf-8?B?amVZNjZMeE4rT3oybGpiNmNDZ0hrTnJWSERCQjQ5b3BmbmY2UDhWcHZreTFh?=
 =?utf-8?B?cWVtUCtoWDZ4MW1nWlhLN2ZJUC8zWU9MaUNKWTNMWUN1cUlYVzBNTDN0dUxB?=
 =?utf-8?B?ZVh6cS9UbWxBTnZhZ0k3L1ZLSnZQczhQZGljY0ZKVEg3R2k0b3BReDZVT0p5?=
 =?utf-8?B?cjFaYnF4RjRDMkVTY2lrOS90UUtmYTZVTUs5UFhRVmZUK0JtSzFwME13Ny9E?=
 =?utf-8?B?OElvSTNSUlpyUS9mdG9GcFoxeUQ4OUpkR1U5bDhMMlZpUHRpUnRnSEk0SlNJ?=
 =?utf-8?B?NldPNkg0WWR0dHBiUUIwV2tGWTJkM1lZRUtDUlhFcHJmTXlxaDBoT01JS2hI?=
 =?utf-8?B?dmtwOVBZWkVBNUE5SkJGV1NPOUwwQkxYNHJtZEVIU25MUGFhZ2N2d1IvT3ZU?=
 =?utf-8?B?OExoVGdGK3NOOHpobkZsdnc4K05jYlFiRzVzUDdtSS9pQ2ZwMTJRZW9Vd1Mv?=
 =?utf-8?B?c2tzT1RKWXg2RmhYeUgxMm9MOWJ4YlpJM2x0M0o0QmRJZ0RHMHpFdSt0a2o3?=
 =?utf-8?B?ZHNnWk5OelowZFB3eCtQdEVUaGpid2M5ZThabzdmcllzUlZhanovSUZqMnRS?=
 =?utf-8?B?T1NuMDZvRnJ6Ny95WHVVS2xlUUZMTUZlQXZhMmZScDRwYjlyNkpBQ0E5S3pr?=
 =?utf-8?B?UCttVmJ2eFkvckcyOUREYVJFVFFmYjJuc1FOOSt0MU5Ob1R2YXdRZUU0RTBV?=
 =?utf-8?B?MVdRWjB2dkJnZDFOTUh4WmdQaUVhdjlUTUw2eW92SHNQbW94RElGeGFHYjFq?=
 =?utf-8?B?b2NuK2xQTk4vcVdSWGY3a0M4Y3hqOG8wSEd4YmVyNlNFcWZwd0xFNTVWSm1s?=
 =?utf-8?B?cHF6NFJCeVhKUXpHNFJPNXpxZXQzVUVTM0VGSjFZSXYyZUJCWUFWVjAycTFu?=
 =?utf-8?B?dVh0ODZpc3JTTEpiamt4ckE0YXVwcm1tRFIrSGczWER2R0ZOQTdnM0hQbC9O?=
 =?utf-8?B?TE55cFZVaXVPeVRKekpMK3BLQmkrUnEwOUE4dEo0elhCR2UvWXB4TUl0Kyty?=
 =?utf-8?B?WGRuR3VVOHRDMGxlcC9uZWI2MWd0cFJmVEhKanB5SFRvMVhvcWRjTG1iTytm?=
 =?utf-8?B?Q1g1TUJHbmR5aEVINVhUdkpEbUxJdkQ1TjVzUXk1MWkreDVOS2xjVkdLT2Iz?=
 =?utf-8?Q?tBi00aicj7EWBakcsins9cLQMhIFhpj5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWFKaGZ2aTNUalhNVnJVdXA0NFhrRWJ4MGJWeWQveW1HSHR4YXpoc0R3elF3?=
 =?utf-8?B?d3VGMXMvNlIrTmtlL0dZY1pkaGt1cWJVQnYzK0NMRGh5eE1SMnZ4S28xMVRn?=
 =?utf-8?B?QnprMVlzRGRPdnppL2pRVXNrRURsU2ZvdUtLQkJiZ1EzMTlydVdkZjJSVUQ1?=
 =?utf-8?B?NlJGUlg2dE1GYjZJNU9UREJScnV0WElYdlZQcjZLMUZGTG80bWpmYUo4N3JU?=
 =?utf-8?B?Y1RSbER6RStiY1VjN1FQdlBZNGtHMWU5YnZRN3NldWtOcm5DNjdJWG1DaUIz?=
 =?utf-8?B?VEQ2S0p5eFV1Mm5ld05yK0drVTlDU21Pckp4L1dVNGI0VkRJRXhqT3M0UElJ?=
 =?utf-8?B?UGw4cFo2UjJlbEpaalgxdGt5eWpEdU9tZFp1TEZ0M0FzZXovVHZtRyt2NlRI?=
 =?utf-8?B?dWdrcU9oN2thRENaVkN2THRydFlMMWxsYkJCb2VIR083V0Y5bXRUaCs1akI3?=
 =?utf-8?B?UHFUZTFURlkzbEpZV2psUFlkSUY3VmhMMEg5NS9GdFpYSThKajVEOHl4RXNx?=
 =?utf-8?B?ZHplbVVreTZpVmtnSm5XQU1ORzd1ZkpSUWhzWkVvVENHMTBPeFhCbnBQSGNx?=
 =?utf-8?B?ekVJMHVNVllTQmZJbUhuQS9hU29UT25TS2x1RGJTTHFNSWZBeDZjeVVSY1d4?=
 =?utf-8?B?R3lWNm5md2VGWlZ2TGFiYk9qaVpDUlZEbW1yR3R6VUJhcjYrc1hZdTRONUN4?=
 =?utf-8?B?bllrRjRqRm1mdUxrejg3Z1hBeXhvdjRFVklzOEdoZlcxRWNPbGkvYUVnWU5i?=
 =?utf-8?B?WjdKZVFBZEVraVNSenFTMWJteTZVK3JzRDlxNFgwcnpDbENoekRwei9venlD?=
 =?utf-8?B?WVJ6ZkRubmZocWNJM3Vxb1pacWRlNExmRElXdkNEaHdhNU04Qy9UcEozNHEz?=
 =?utf-8?B?RXVLZ2kvczRHdzJPR1lIaEdQZnh5VVcrM1JJVCt3cWR4QmNJTHR4OFpyRWY2?=
 =?utf-8?B?VlZ1T3hBODRnb2QyOCswWnppdVN1UEpBUkt6c05GYnRjUjVhSWIxMVZvNnRP?=
 =?utf-8?B?d3hjZEZoaktFb3lSMUlpQTFJMFdiNHBGclBLcmNpanJFbTVvcGZSQUlSKzJt?=
 =?utf-8?B?eVErWEhGdGs5RGhReHFJLzNqYjA5WnJxVk9nTjFTRGNiVERycDAyRjR0RkFZ?=
 =?utf-8?B?R3p2NXBPZUEyRmQ2NWJDOWpJTUl6QlBhSW4zb0kreG55QmlKTFVyTVJnVVNa?=
 =?utf-8?B?SHBoaEVDU0IrZm41elJXWVR2MnVmemc5V3oxak95b2ljaUU2YURIS25BK0pX?=
 =?utf-8?B?RlRYWmR0RjAvRGF4bVpSREV0QlNsNHNRZkQ2QUNBQ3o3RS9ZKzBPc2ticHVV?=
 =?utf-8?B?SnZ3U0ZDa2wwb29hTExCMkszUXQ3VS83aDZucUYvQnB3ZURGRWVBVjJpbHI5?=
 =?utf-8?B?NWNtUjdaOE9vNFJSOTF2c1RGT3hVN0RPWmcxYlFscHB3UVRlM1BTZDZNQTQz?=
 =?utf-8?B?eXRBMDRrUFBxOUYyV1MxRE41R29UN0VXOFRlTnNvaUhxMmhLOXIvK1M2Wjcy?=
 =?utf-8?B?eEN3azdGbDFyakJHVUlBOHFrQmFnSGp2V1duMEdnT2tMZUh5ZXBwMDFVMHlD?=
 =?utf-8?B?Wmt5UWpSY0xUK1JXb01YeFZsU1EyQ2JGdE0rTUxydE91Z1UrSnN1aWMwZHg3?=
 =?utf-8?B?Q0haM2o1Qk5zTUg0VUtZQjRjY01jQy93SXZPSzY1eEk4ZkEwVnhXalFaZlFW?=
 =?utf-8?B?SzlUZG1WZGlNOW8zTjdLa2hUa3dPZGgyVVhOVDlnWVdwVmtwNER5UU40dmIv?=
 =?utf-8?B?M3hKL2lTV05scm5TaGhhNzUvRmRRcXU4cUhKQ3dOL3pkR3lObCtPTUFTdDJt?=
 =?utf-8?B?d2s4a3I1TWh3cU1RaUowOW84dmt4YjJlUHpyczJwM1lvSHNRMXJDYzZpd0RU?=
 =?utf-8?B?dWhqaXkzUTBQdmQ4N3ZSaEJxSHN5c28wKzQxaDRDUm56b1EwSVNKRWhXR3Rh?=
 =?utf-8?B?UlljMTJ4alg5dEI2TVFNWGMxSFhYK3BkNXBiN1hDQnFWd2c3TVhRZ1ZaNStT?=
 =?utf-8?B?VEJvTFZCRTFkajg0dkk5cWlXdjFSTytvYXZFUEJGUUl4R0hVVUozNGdsRjla?=
 =?utf-8?B?N0Q4Q1l6cVRRbEJFa0U2MklkNVMwZWxrbHpFbEVleWdoSy9acXJkSy91czlB?=
 =?utf-8?B?ZUl6K0p6dXJVZ0xweEdGNGZwck5RcVNZaEh1cFVrZnNDMGFuYTNGS2JNWTZ5?=
 =?utf-8?B?bmlSQ2MzY0dwQ3plU2pEblBtTVhGTld4R2thUi9qUWtRbnp4ejZkNzVNaDNW?=
 =?utf-8?B?NVp6ekhYRzJXaCtxaUs2S3ZUWWNvVEZ4SkFzR0pxVHlCeUhtdXArY0YwdDlv?=
 =?utf-8?B?UXJUd015TVNEbEwyazZhMUY4ZmhXT1VKUFNCeUt3NVlNeEdiSWgvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c8ffcc-932a-4dc6-738f-08de4ed0b989
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:12:30.8714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRsLE8svtNQt4cgR2jcu9zcI3JOtvt6oCpGegDgGjkQHZyFtfDKsR1L+n5auG9Br68H1hWf+GCob6k5EtE0k6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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


On 08/01/2026 10:12 AM, Shani Peretz wrote:
> mlx5 PMD is a bifurcated driver, which uses rdma-core APIs to
> communicate with HW instead of UIO or VFIO directly.
> 
> It is possible for external libraries built on rdma-core to steer
> traffic to DPDK-managed Rx queues using mlx5dv flow API. This
> requires access to TIR object handles.
> 
> TIR (Transport Interface Receive) is a hardware object that defines
> how incoming packets are distributed across Rx queues. It encodes
> the complete RSS configuration including the hash function type,
> hash key, set of destination queues, and which packet fields
> (IP addresses, ports, etc.) participate in the hash calculation.
> When a flow rule uses a TIR as its destination, the hardware applies
> this RSS configuration to matching packets.
> 
> Add the following functions to mlx5 PMD private API:
> 
> - rte_pmd_mlx5_rss_tir_register(): Create a TIR DevX object based on
>    the provided RSS configuration. The returned TIR handle can be used
>    as a destination action in mlx5dv flow steering APIs from rdma-core.
> 
> - rte_pmd_mlx5_rss_tir_unregister(): Release the TIR object when no
>    longer needed.
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

