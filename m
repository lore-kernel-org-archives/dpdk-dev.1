Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9236CD6E6B
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0368C40430;
	Thu,  4 Jun 2026 11:37:13 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1DD5D40270;
 Thu,  4 Jun 2026 11:37:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqGU90kn3kDv9ZnKQtuAcedMnUXykr/P1fB7W9YAhUwxE8k55zpO4qATyjc0odZCyGOgC8H3BjvuurH1ZQci4jpLwZ8eAJmWU97O0oaHi2LH2F59QRLI3TGUOFoKTv1h4Rgv57Br8Z9ReGKtQd9WIvrmrMgcNpwgU1VuILioKhscR2wOCzZ5fzDUVDfSVRZw3vNTIejpsgvteIYZ5VFxS1ZJAzIeZ8YMkf+mTRZBbwzYkFs1Q7HtD+CBP5Kcb6EDJMKSa6Bng9BXU5QNzlYTD5erzOWyZ3J8hf6AaTPbJkJvl9Ckn79VVcNqc0ZWq7IAJd4T5l1b6Yp32bHK8trJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swGXJU3IGAlmMIFqIeovuhIlPOMNND7onS9Lb9XCImY=;
 b=DkxHAucxdGA6jPV4tVm8ijeNU4A/l0w7n4qkai5MrontWn24DoHt9gXHgA8SJWAcLYc2ATVuDk+260+htv/bCv5om7JTnCh6Z0nw9A6J29RfkFB0NArGmth0HgJLmRu8WkghTqkGbo0STIT/PnCs8sFZMbNPiRMUTnNh2kNgjKwaaM3nFFYcRJYWlvC6VZHfMxy/P/M9cV/U81ISE19An9Dxgvg266dTY9t7QalF4tXL/En4A+GVW8KRoxX2R2tTGjrD3369KFXvq+QxriMbHjaAdr19ms32kG//AWmnEizzMbw+eJm9PnFsTMwmkmms1I1UEbKdx0+aoYpRq1k80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swGXJU3IGAlmMIFqIeovuhIlPOMNND7onS9Lb9XCImY=;
 b=TSQpWId55jAGsPgILlEm5gxCa8kuy+baRkHdXMYQ1wy31sun24uzlVKRdW7ECD6EQKAbV+Ve6dafx4SX1DIgkeTTHjPvCquigX7XK9DR5ePtCxE4uofNU1so3K1GDzq2TB37q2mSyNhatZAPVUK0Ux/21rwPNWPA3ygnSC74UNtj3BSVASD6bGYN5f12btMTpyrECGhAqBkxyGsO6qXKIa2jN5cvYvGl4ral0Lw0t6rlI5DhwP8d/D7eV/iBHbXlhCGM9RrGi3dDmYwFg1XYmM2tqUS5RMW+cKBDr5GsCFbcLFlEWhF33suZO8VWCJgHKwV3a0gOH3XztnNF5UJMeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 09:37:02 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:37:02 +0000
Message-ID: <d8c2a1d6-fa06-4a61-9ff6-a1574cddfd89@nvidia.com>
Date: Thu, 4 Jun 2026 12:36:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: use port index as representor index
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260522101933.540423-1-dsosnowski@nvidia.com>
 <20260525091733.558838-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260525091733.558838-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 802354a2-1ca2-404e-390c-08dec21cd4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 8rHvWgLH1wOeaiSRXdcnM9ZvcHJEzUeKBh5sQ7KRajY/+CnZsLFekg/2OUWybQCLOfgU2NCDP4KMkuWFgJrfXCtCD3Dy7LzkybiMWZYIvGiSfuS7AB6K/JRY2B69RKRVM7+dvfgMMb4odLpYsnsdNG8Mm3aF60ytRzXr7aDqNBhuNtICIGG/jcpeWW/OwDNOsc/83CfjgsLaYmaWeVRpwhnA6gPkuQYJX9qbBZuE6pjYBxnTY4+U1XjuIllkGbJerOXHBhvT3Lmav5s6qTaV8wbECgne6YIyAE2I3mBU072VzLn42HDZhTdKcLPBv4F6PJWgTaGvjh983ekmNMQlXffvw/S8EOrXsqQ75xseIafQinda4gALw1hwZDCekrY1StuycKWYWfhR9R5F9P8i1wLuDDst/2V9g7Fh35u2nxcWbTBU1Hvz07qy4pzGTXkKoepSmTKFwW9e8DtpUbPb2lPx+cZc4lGxmPqIR4Eel8xi58qjiEQkBEv0M35dV5abc2Iu1IAAONyqHbmZ8qLLB3wfhbw3OJTGb28EAj5e7wai0M+MUkfqvuJsy+cw+RfzO8j1Rc4Yv7WZX/VA/otaOobSq3V0+Eh23IBWVHgUBPDRYigoUsoBfCzs1R4tFz7KWz/n+db0gr1lMdnn1Tf3VOaWGhpzIBrCPWgtSqz+04r0k+nrVsCjdjtZd21uMvcy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1lXcndROC9MZHMzR08wM1NLbGxWSkZHa21hbm5LY1ZyR00wS3VjckJBTG9U?=
 =?utf-8?B?elRXRkRwejdhaU95RDFIUnlkQkFhelFHNnFFN3Q5VlRjNGsvc0FneUIzdVg3?=
 =?utf-8?B?R000NWRwNG9IcFd6NWZOVDdTUkFoMXZzVjJXWU9yaG04Y0prM3JNZUZCZEJK?=
 =?utf-8?B?UDJZcmtST3BFWjB1SmNNdzlTMUpSaFB5VE1tYXg4Mnh3YjdCaDBXZ0FCb21q?=
 =?utf-8?B?d1ZBTjlZamdNTTNSWFpQN3BWcm43aUR1TXhXSDJLNEFMSUZoTFJJSWVsZHdm?=
 =?utf-8?B?a0hydStNZHFJeFZNbm9WOXdTZkF0anhWSjRxNk1EQzI4S1FFN0ZoMVh4bWFT?=
 =?utf-8?B?TVFaT1laYTN1OUNTVGlpQ1duMFZxdjAydDJONFd5NEdqK2RtL1ErTFZKVkE5?=
 =?utf-8?B?REZpUFE3VjhCU1p6c3kwMmg5UEx5R0tiN1dhdnVpUVIvN1dEckkyOGMwMWlN?=
 =?utf-8?B?Yi94SmlpWUNzQWowWGZIR0pmSlM3dVc2d0NQS25vT2MvQS9zVm5sWFVZdi9S?=
 =?utf-8?B?Vy9iS24zYVNWdmxudkhlaEhQSFRFU0QzREdoVFJZd3h2U3JnaWkxV0YxU3lw?=
 =?utf-8?B?dTRja1k1WW1iMXU3YmdkWVNRdWFHbnIwbFhldWc4WnRJZmx2VDlQRVpmQm9z?=
 =?utf-8?B?WWdSMWVWSzB5YktHbUgrUVl4RXpVR1VKNFFMSmRkR21qTlg4MzhPcFJoTjA1?=
 =?utf-8?B?d0h5bUw4dW9naUxkZlhjRld6SXBHU2hpVGdYUkVHNFlyTEpwbG9vT0tWUGVD?=
 =?utf-8?B?Mm53b2x0RWNnbG12bDBaWTBzTDNESTlWaVh5Y3pNbStSSHZneE5LZHpKb2VF?=
 =?utf-8?B?cDFaZS91Tkk5bDdmSUtGZ3RNcmdGMGgwSnY2bWN3SlRpdmcraCtYTXB2M3Fz?=
 =?utf-8?B?OEFjWnZCTlF1UkRGQkRUQUliMW81N09FMEN1Wkl2ekU4T1RKbDNoSEJIRnNU?=
 =?utf-8?B?d3U2QTJhb1FYT3ZPT0lQTmlvekRNUWdUU2t1R1pZSGo5QTV5V0xhSHI4UkRz?=
 =?utf-8?B?UGZxcXBTMnJ1bVM1L0c3amEzTU9rMnA3THhIUjg4ZWdNMEhpY2hBV0JtbUNC?=
 =?utf-8?B?WlpFOVB1VExaYkxBbnFKSllTYlNmVVA5anJwdmN2aDNXbVVYQ0lwOHpBdGVR?=
 =?utf-8?B?ekU2b2Y3azRuSzFRc240OTladm4rckZwMStoTTc3U2ZCTjJqUlR6RkNDMGtS?=
 =?utf-8?B?dXBLZGhFQ3F2K2FzYWlSVEllRnVOVGlWdW41OEJTMHZweDdKRklmNklqQURi?=
 =?utf-8?B?SVNmNWtQUldob2cvQkhGdXVQcVplbnJFajFvMWs4QXAvcFNaSml3M0pRQklw?=
 =?utf-8?B?akNOMnlhZTY2cmZyYitEVnJ4ek1sczZraGZBckE4SDNSSWhiYmFJYXJjYmMv?=
 =?utf-8?B?dGdjbkEwbHRiVnZDRGN4QU5oYkZqY2d2TytmZVdrT1RoKytzMnBsMkdEWmdW?=
 =?utf-8?B?aXQrb2lRczJYQjk4ak5zMGcwRERHRW1rS05NTGd3c00vRGw1bXp2b0pvVkFp?=
 =?utf-8?B?MER4TnAwQ3NzTzU1R1BSVG9pY0Z1UnovSDRBaFFETGNSYTI5TExQUUVIL3BI?=
 =?utf-8?B?b3JianJsQXpaSHhUdDBkS2Y1UndNNURJZnpRajlBYnBmQXlDNWpiSlRsQUt4?=
 =?utf-8?B?dWNhaDNxVGhnU1h3Y3Y2djNCWGdlQVNUN3cxSVc4SnFXNWVJakw1MFhOMlcx?=
 =?utf-8?B?MWc4QXZwV0dxRDJtOUpKMmhJYWpKVE44OEx4OTU3dXN3Z3pkZGZCbHRpNzdr?=
 =?utf-8?B?UUxJQmMrTlBRcVdJakd1RWIzOGVrQkE5NTR4NDRaWFZDZWhJUDVuUDBpT0Iy?=
 =?utf-8?B?ZSs3SWhIR3MrbWVDazZqM2xRMWdqQWxiRmM4OFdKL085T0s3ZENzeUpWNFFn?=
 =?utf-8?B?SVlTdmM2cUFMK0gvQmJZSTI1aTZSeVVJQ2dVYWJtR1hHeU00bm84UWZLRDBI?=
 =?utf-8?B?SEViRXdXMW9QaUxFQ2IyRDIvS01YbXF6dXU5TlFLYng5UVNScFhobHRXNm9i?=
 =?utf-8?B?YVlJc1RHdWFaOVNmYlhudEx3eU1lNFc1R1ZWNzFTbE9UOVc3T1c0ZE93VjNk?=
 =?utf-8?B?MTNIelJlNTZEdFQ2OXIrMjIzVFozLzlYSlZxT0R3eTMrRXFrRkVKUVdDZEcz?=
 =?utf-8?B?T0w1MzV4YXkyaDNQaWZ2Zmk0M3JCaThUVDFlRk8zNFJyeis2V2hpZWZhRlkr?=
 =?utf-8?B?TUR1WERMYlBHSExReUplK0huSFBjRkdDaHNhalFIQ01oK1VqLzJCcEZVOC9C?=
 =?utf-8?B?M05CNWpQUnc3L05pUzJncElnSm9lakRnT1pIWGZrWXBMKyt5c0d3QXhhTzBV?=
 =?utf-8?Q?b4/0FuP4JDP2UopBNW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802354a2-1ca2-404e-390c-08dec21cd4da
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:37:02.3425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8L4n/Ol8ZLjD52bjvs+61L+zTJ7HGpZEHY67V+NjjDozw80oxA8OIZrPBkFsXCkFrzOoeGuX8oXqobGs/K66w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
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


On 25/05/2026 12:17 PM, Dariusz Sosnowski wrote:
> Since the offending commit, mlx5 driver supports probing
> representors on BlueField DPUs with Socket Direct (SD).
> Such card can be connected to 2 different CPUs on the host system.
> On DPU, user would see the following network devices:
> 
> - p0 and p1 - physical ports
> - pf0hpf and pf2hpf - PF0 on CPU 0 and CPU 1 respectively
> - pf1hpf and pf3hpf - PF1 on CPU 0 and CPU 1 respectively
> 
> mlx5 driver finds the relevant netdev by matching information
> provided in representor devarg to phys_port_name
> reported by Linux kernel.
> For the above interfaces phys_port_name's would be reported
> and probed as:
> 
> - p0 -> p0, no need for representor devarg
> - p1 -> p1, with representor=pf1
> - pf0hpf -> c1pf0, with representor=c1pf0vf65535
> - pf1hpf -> c1pf1, with representor=c1pf1vf65535
> - pf2hpf -> c2pf0, with representor=c2pf0vf65535
> - pf3hpf -> c2pf1, with representor=c2pf1vf65535
> 
> Although hot-plugging all these representors is successful,
> RTE_ETH_FOREACH_MATCHING_DEV() macro would not find DPDK ports.
> This is caused missing information reported by mlx5 driver,
> through rte_eth_representor_info_get() API.
> Specifically, mlx5 driver did not report controller index for all
> representor ranges.
> 
> Until now mlx5 driver used static encoding for 16-bit representor_id:
> 
> - 2 bits for representor type
> - 2 bits for PF index
> - 12 bits for representor index (either VF or SF number)
> 
> Controller index was not encoded. This caused the mentioned issue
> and on top of that:
> 
> - limits the number of PFs
> - limits the number of SFs
> 
> This patch changes the mlx5 driver logic for
> rte_eth_representor_info_get().
> Instead of static encoding:
> 
> - representor_id's will be dynamically assigned
>    to each probed representor.
> - rte_eth_representor_info_get() will report N ranges:
>      - N == number of probed ports on single embedded switch
>      - Each range will define single representor_id
>        for given controller/PF/VF/SF.
> 
> Fixes: 2f7cdd821b1b ("net/mlx5: fix probing to allow BlueField Socket Direct")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> ---
> v2:
> - Added missing "not" in "RTE_ETH_FOREACH_MATCHING_DEV() macro would not find DPDK ports"
>    in the commit message.
> - Fixed typo in number of bits for representor index.
>    Should be 12, not 2.
> 
>   drivers/net/mlx5/linux/mlx5_os.c |   6 +-
>   drivers/net/mlx5/mlx5.h          |  19 +++
>   drivers/net/mlx5/mlx5_ethdev.c   | 284 +++++++++++++++++++------------
>   3 files changed, 199 insertions(+), 110 deletions(-)
> 
--

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

