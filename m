Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A175C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 13:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6807042ECD;
	Tue, 10 Jun 2025 15:16:43 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by mails.dpdk.org (Postfix) with ESMTP id 6060C4026D;
 Tue, 10 Jun 2025 15:16:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/GEbcn0z9LYqYEeYKV3nU6bHkl/x5CXCkIUpQfTDuQpOMFZiag2X6S+mg233pfE485u6Pqf/TqR6xApiZwtXIhnVhB1o8rOe9X/udKY8hQsfYcSoyxzevGJweYWjYhAsxh/aG5anNmXiXKfGtozI+n0FVTRkRZgEr0DejHHX43n6jOdg2FEEuEuyq6m13gt5nTjEsW1HkOVseL5vHCMAT5Iav0gFnIjH/x1E7iwQIqF9lHRFGw8kEIihjb+Xd8XfpFLcBFlD3ZFZld/jsfRr8xl7yfgnGo6sDRyituvWDUdAd/d697YKwjxhmES6Cl/xL7iUo+EAD30OrmlcT1lTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3pZoqhKfnhqi1XkQ1DsnfFrjbMgiwgByEyOHjWlWQI=;
 b=NqTxy3f21qcUd/+uXPfSuXoIKJhNOZWVIZv9trTAisTiJPX/AO5LT6c4+hZg97A91UcZ/2vuYGlHP+nX/M/wIdh7ez24IbZza6nWNIq3rVET5DF7511Itrt7uGUv18/dhmwj3EK9AClf9y7uI+K6Dhr/LkD95NebbRDdGb83K31wWVQpAaEO8EaxD+9xOzpcxdsPS9tk4ouF15xBAh/ff2C0FsqoQ5oG1Q5yHERiz0RyIfeqqc2kMvtcp9S+6SUovR+uNZbppVyomnhVOKni6kilzqh6lYY6yR1zmuiqkRpYdkc+x9Y4T47QBwUlhtnAWvLloblxbg5YiYQpmDHMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3pZoqhKfnhqi1XkQ1DsnfFrjbMgiwgByEyOHjWlWQI=;
 b=EfgqdpZFxEU/iwwMg0/yXu/1/F2Dh2HsScYy8BqdLJSGESOeFtn1W8OiZcLfAI8F3XBvJZIVgiWhtC11tvJwjr8Z4BImu3zAshXKrnKL3m5u7wWSfUkCf5meQjEyECMImj1DSzRX2CRXEnXAldbUsQi9zghEtxGGxqWSnktlJ1rdP9n7fub7OsF/gclU1tXWy54iRb6dzvSjng1bk5QnfcW348ljQ/uSzp2S5j+zL1Tbplj4T3J/Fbpio9i0YyuYEQfNJhgK3vdKj9h9y0bdP4QMIwGnuSHdfobbk4UfFvQHzC2MpqFeSq48RD870ZvLBhriPyM74Bn/zK+MGJfLqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 10 Jun
 2025 13:16:39 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 13:16:39 +0000
Message-ID: <4fd0c69b-0f11-4183-a661-f8325516e52f@nvidia.com>
Date: Tue, 10 Jun 2025 16:16:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: avoid setting kernel MTU if not needed
To: Maxime Coquelin <maxime.coquelin@redhat.com>, dev@dpdk.org,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, david.marchand@redhat.com
Cc: stable@dpdk.org
References: <20250528093644.2456221-1-maxime.coquelin@redhat.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250528093644.2456221-1-maxime.coquelin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: c5097ba6-9457-4e9b-626c-08dda82108b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkU2NTJ6S083cjZESFNCRTdCaXpJN2REb2FxZjNhSGhvdnBQNjcxTjJUUEwr?=
 =?utf-8?B?U0t3a09UdXZPUFBrT2t6NVZzZkJib2FLRDBnbnhCMHcvTXZITjY1OWxRUFpj?=
 =?utf-8?B?SWdFUmwxRnFjTDFGQTF6dEIxT1gySWc2TXkxanVvclliOGJsYVVCWTRwTFpU?=
 =?utf-8?B?QnM3ZXZ4RzJuN2tNQ1VxdjA5dmRoK3dVSGx6Mmo4YTh6MTdXVy9ueG5TeXFJ?=
 =?utf-8?B?NTZLeHJHa0VjRW1Pby9WVjhZTHRxOGp6UzQvVTllM3F0U2ZuZzlnMCtrTHpR?=
 =?utf-8?B?RUhwa0RjSnh5NmwraWx4cCs1dDRYN0hFbFpPN011YWZkZDRsTUZ2cERvYnc4?=
 =?utf-8?B?cGFnMU9uVGVvakhjSjRveitWaEhqRVNKL2RacXMxUmdsNEVBOW5TbjRGSWFl?=
 =?utf-8?B?MHJSRHZmL1NySVNrT2oyU1hvWUM2L0tPVVpxMWd4K2FDbTd2WWd2VjJoanpx?=
 =?utf-8?B?c2Naa0MrdmRoakl2YVdOL2lYWjFWc3BEQ0NqVUhZckNYdXZkZy9HU2xENjZE?=
 =?utf-8?B?elIvSVZuaUxOYUpHRmFiVWJpbjJVN2RGSVF0TVJYOXZEaElWY3A4N1NMQVpm?=
 =?utf-8?B?YUFSVTVGNzZRY2YzbVVsQVVTOUhDRXZFT3piTVRobXlpOGoxaTgzcHlnNnQr?=
 =?utf-8?B?Wi94MEMrUlBGZUJtK01mMmJnOElsNSszWSszOW03Y0lzNVZzNDNOcDlKU3h5?=
 =?utf-8?B?UzN0YVBkWVE2cXh5NE5GWlV3cVhhV3Nua3lXTC9MalJWR3NsRmljSWJXZE5Y?=
 =?utf-8?B?bWl1WUNPeGQ3SkI5MUZVZmszMXJLbHIwdXYvV2J4YmNaNEFadjFOYkZlUEcv?=
 =?utf-8?B?N0ZRN3h6NDRzelN6U1RZVkFYYnE4SXhQc0dsUUZzZklnR3ArVk9Ib2xZckwy?=
 =?utf-8?B?TVNoM21yY3RleVF4Z3diWlNtLy9ia2Nac2VZNHdZRkRvZEluZzRPK1F2US82?=
 =?utf-8?B?cy9ianBvZUdlV1kzSWhJNTlOSVlTak5oM0YzR3lIZThISzlNMVlhbWJKQWFj?=
 =?utf-8?B?OWtIQXFSKzJOL2txelRTbEJLeWdZZ1hLZ2Z3T3JXemNWaDhXUkY3U0VQVzhX?=
 =?utf-8?B?VURCNXRLWmtYMGk4QllUVmJNRWtjMTBIS29lbzVVdS8wTDZmUDNjbXZQR0Jm?=
 =?utf-8?B?SkdOeVZFcmNsaTYxY3o3a0FQV2FmMHd5N3pxUUZuYS8zWEIvWFNkNHB1Rmkv?=
 =?utf-8?B?a0hxa0Nla3BIMnVZVWhla0pLRnhKUEdnM0wxY3ozZGY0dCs3eDhsZ1BLOTl5?=
 =?utf-8?B?bFBpMDZCSmVjTGM2REU3V3RNOTJnRG1QZ1lidm1kYkdGczVYekd3MGp5Nk93?=
 =?utf-8?B?SFFkTnhEcTJraXZ1dEJwdjA4aXcvNUZJOE9qcGJkYU9mRTBrM2g4a0lucUNL?=
 =?utf-8?B?YTA4WlJtYndHZGRLZ1h1MzYrY0V6bVFRQjNUZUdPNStIWGRra1FLZ3M2eWJq?=
 =?utf-8?B?MDRRVUlUZk5iaC9LZGVqUm5MbHpkdnZ5cHlCRmNiSjJ3TkVrKzBKSU1UTmRO?=
 =?utf-8?B?T29NKzlZbjErcE5LUHFxeHBXdFN1dmdFU2tEcFRNTUpXTjBsbDR5RW5FWXJ4?=
 =?utf-8?B?N3hweXpTdG5xNEhZS1JWTFlyeHlYVXlVMzhEZWMyYm00YVhQR29lRm95cXdV?=
 =?utf-8?B?cVhlUHBKdzU4VXVzaDRiazJxZEhMMHdsZndOWlpYaGtvNWVuSTY5dG5RYTJN?=
 =?utf-8?B?Rmg2cVYwTHZwODUwK1NHOWdla0hmaFVac1U0U3lqMlhkUG53V2ozd2lpN3Br?=
 =?utf-8?B?V09Wck8yRm5iRldqeDhBZlh5aURHK1g3bmdqNGtyMDh4Q3ZZTktaSE5oQWxv?=
 =?utf-8?B?UFpCM1ErQU9RcmJBd2ZMUkFodVl3OFZBMlZBYVdtNW1BRWIrT2RNQnRST2tN?=
 =?utf-8?B?UTFYYWtQMGo2TFVHSXMvdXUvTFltVEI0NlhzVG82djlWRk1iRnRrY3JHYU5T?=
 =?utf-8?Q?fZZy34SFhH4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzVRcWx6QXdpb2ZjWUthVHdWNGRmWDVqSXVOUWlVM1gzcjNSaEJjVHJBM1ZQ?=
 =?utf-8?B?VGJjTEpnT09OZWQvR041NzY3cXFTZEhVMDVtWkZUMzdndk1Gd01VK0lMcWla?=
 =?utf-8?B?L2xhK21kS3p3VDdsT0VCbS9XckMxUkhlYXZmSzYzRFdTTkFmS2ppOEI5TUxj?=
 =?utf-8?B?Ni9aQVBrM0hnWEJndk9TUDhoZjlPZDQxVGJXUE54cFQwaFZ6bVNSVGJWZ0ZZ?=
 =?utf-8?B?bDBvWm96dFpvaDc2SSthcnl3MURuS2pSOE5IY29GVWdONUEzSzhwdnBsKzdK?=
 =?utf-8?B?bmlrUmlINjg2YlVnVkJOcndXOHVuQ08wKy82YklpTHp2amJtWDhIR1k4d1RO?=
 =?utf-8?B?WGc4N25KWGlnckZDc0xOUWdNTU00TGEwTGdHNHI3RUt0alYvZTc0M1VnY0ZG?=
 =?utf-8?B?Q1VNSTdWY1IwN3NiMVROWHNWK2JsZ1dRa01xQ2w2aDhXWGdEVEJWQWgxeVlG?=
 =?utf-8?B?RldadnZYQmc5ZDZUb2dzNzlWVGVzR3ZQdWNOTVNWczZKQ2w5QnBQNUtsZElw?=
 =?utf-8?B?bnBnUm16U0EwYUsvNDA2eXA2eUpjWi9CdGt2VnVWR0ZHUjNoM3NJMmhZTEVx?=
 =?utf-8?B?Z0JCSEdSenhSNENZMVU5Uld5OFBvWEVsWjVKbDRMK0hpTnpTSjBUL1lCcEVV?=
 =?utf-8?B?SDhqeVZUMXhvcDNDY2tEdWxKYzk2VGlJNUtiZHN2UVZqcjR1NjA4bXlKb2hp?=
 =?utf-8?B?QWJWNlVnSXVCY0IwcmJpNFFMQ3Q2VEpteDdlL3k4aVlNdENEVGhTQlJqUnZ2?=
 =?utf-8?B?UE8wa2F2TG9LS2NwWmlDbG44Z3ZiRG5hS2ZtazRMNHhTaWR1ekRLNkxSSUdl?=
 =?utf-8?B?a0xWUDdUaTZkbHpQVUk3OFhJLzdPWnhlWTlFNWhMK0JCc2M4bmNabC9sMTlz?=
 =?utf-8?B?dUN1TCt6QWhGc052Q0xwcFhHaE1QYkw1a1JXVWFlYnFTUytLcVFMelZ6UW1K?=
 =?utf-8?B?Mmp0Vk5LeFJ0a0Y4QU5PMW44K1ZXNXhLbU9FQUlmcm9PYW1uWlRGejVOSVM5?=
 =?utf-8?B?Nm91S0w4S3BrUmFwL2xPbWZZQytUVDlPVWNCOUtDNEpWVWp0OUswVk8zenFB?=
 =?utf-8?B?Vk9QaFBYQ01YcThMcUJDRmJGalBZQldFWTBoc2dZeWM1LzFycy9XVWdleGoy?=
 =?utf-8?B?Z213a2Y5OUxBR0w0VTk4T2x6WUw0V01wZHBUK0VjMmU1S0d1SUdhZzdSVFhH?=
 =?utf-8?B?QnZOQ0l4UUVON1V4aVNIOXNVU01jM09vR00xa0Y4NjN2Rk5lcFJuNitzY3J3?=
 =?utf-8?B?MlBkU3RFalZOOFBqZ1crQU14OG1ESVpsNGNPMVEvdUR0aklDRDcyMmJvTmVs?=
 =?utf-8?B?bU5JY0xLVVJzWEtoYWdXWnhCdTRuMzhMbnJmQ0RPcnBnYytITkxKeVNlODd5?=
 =?utf-8?B?V00zU1VEdDNSeVBmNzA5dlNKN1MvNzdZSmVRTDFpWmZqQ3c3WUUvRHBVMXEw?=
 =?utf-8?B?M0RRUzUrM1lKNlhZRjd6dUZLU0J1cktaQjFOWmswSldUVkljdWVMY0MvakM1?=
 =?utf-8?B?L09VWHU2Vmh0YS9nRWZpbnlHQjRwSEZRYWN5NTU1STJseTh2RDJRYitaWUlw?=
 =?utf-8?B?VlI1RklTZzVNQk5XRk1DY3U4SGZ0ZnlHQ1pZQ3R0cGJyZ1ZRejNKQ21wOVV4?=
 =?utf-8?B?MSt6NUVDQmR4aFJZaFNKS0xZZlVNa2FBVUJHWE1Ba0g3bTBBQVRjWGNreDJz?=
 =?utf-8?B?dHE0M1N5My9DeU9rd21LQjJqQitDaXZ3QjJSR09ZN0oyQk9XeFg3RER3K09Z?=
 =?utf-8?B?bmZzTzhDdFpEdHBJQ1ZDNlAxbnlrcEs0VVpZalhBamllVFZ3R05MQU8rNFlO?=
 =?utf-8?B?Zng0YWN0TWpZWS9rT2J4Snp5c2IrQTFNRHhyc21uZHdzS2MzUDc4akF1TzVM?=
 =?utf-8?B?Qy9SNU4vWWpqeEdXUUw0eWIxQ3cyak83NEdSUXdJaSthVW9TUXo2S0lzb1FH?=
 =?utf-8?B?bUcrNWFEeGptZzlWTnVHR2RuVWhaWEozNVVFcVY0dzhucFJleDlJRkYyYU5U?=
 =?utf-8?B?cGM0SnNLRUdycUxka2xaMjlpN2Rsb2ZEdzZCQmxzYnBmdXhVTGozMGE1UkxU?=
 =?utf-8?B?Sk5idjlCL3FrVzJVWDllRUtNRktLTnQrSG5WdHU4V0hRTU8xa0xtYjZUbXdY?=
 =?utf-8?Q?3bNhshMQh9nxccfTetireNDvT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5097ba6-9457-4e9b-626c-08dda82108b4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:16:39.2968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoItFvbNGRpzPAQ/XwGxNdA01Ht3S7B83rInupSfYUYsQwEUtxJ1c4JV3W29+Y9s7x+ZL1kUzqi8KnpcuIO5Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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


On 28/05/2025 12:36 PM, Maxime Coquelin wrote:
> This patch checks whether the Kernel MTU has the same value
> as the requested one at port configuration time, and skip
> setting it if it is the same.
> 
> Doing this, we can avoid the application to require
> NET_ADMIN capability, as in v23.11.
> 
> Fixes: 10859ecf09c4 ("net/mlx5: fix MTU configuration")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

