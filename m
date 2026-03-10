Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ECFFCC9A6
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 08:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B8A94069F;
	Tue, 10 Mar 2026 09:16:31 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38]) by mails.dpdk.org (Postfix) with ESMTP id 115054069F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:16:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTDRwxlM5xCKn6kayb3Ezd4+8Xr/p+QiCYIciav+xGVxcNhwPK9iCG6Hi2sXW7TUfXUpjgjUf3FoeZmW83SKPyCQYIKzZle/7jZvKp3JWVFW6HBrSAK/daaOolIhI1r5veDgXqAvGTJvIzJwrbGR5HS9kmw+z0D60eVAqTry+j+LAMRQzERr+MDwUcyYcZBmVPzOL6rDkWnKAevG6Sob4mgcCajCEqQdKKb8CRmTdwoUP7iugbSVKZ8hrux4BZNQP3dHcvjg5tCNWlEdTu5T8LNmGj1R4h/9MPZd0rMc+mXyIX6SmZJg1EQGFbVpCCgN87eO6bGZcjcLvC/Bq5EXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjbOx35QwUMF2dO7aoUJjoYYBJBMQuFvxqtn7L9VBus=;
 b=KI5AAC2kBvHshyvUZ7LEvEMJSN9+lMz30AnYy1Bz8XG7ve9DKSGTI7b8HbSKYgnX+9itSmX4ZBIoGCrQRwTccPhUxQXLl2Q2Oax9Pce/lck7+h5sj60YT975zda3VvqtY0ghvY2cGeK9ltX7DYE0GHbqlEEuOq/95QPj3D3zPO/M46FoP2JGCpANTZAE8P/eVmjVKJsnCo5Cy/O1BFV37jaPzC5J3Du0gntfxWvJo2/PzEdm33YNMIsgv5ImNTXgXcv5DAjFTR7rl0DuzRDMKXy3uLMcvfUPJ6vTSyddMKYWc9MX4C2Mn2hywh33Mgl+5F6X4xGe/GY/+aLxLWhaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjbOx35QwUMF2dO7aoUJjoYYBJBMQuFvxqtn7L9VBus=;
 b=Lo5OM2XyPqLcEHWgMvxUgdN7Tw+7/FFezjjv4cHeVe8KxBLRTKFxZQIHGH+fq8nPzQm+bAHJ3/vlR0XnvfH7S1jtea0bMmk/W1LP24BJATF0+uYIP8E2jLbfFymyaTq2ZEsf4UaTe+s66ZnG0wvky3Lnv0EqTZo9zVEoZbXbnkAkNZCKWC26Ft1F78PJkM8odvVRYJlfk94CI4H5qBrAcXfD095cgJ/IPMxEIdGzjOMMTiQkOnrP3JIyyrHY1ZKxi9SHn5G8FuF/wsDYkY5CKOtRee4kst6vgyHyNpyPMibOTU2V9sRQGtqrybvhfsyUu4e8j1NEOP8HXa0aH6vmAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 08:16:27 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 08:16:27 +0000
Message-ID: <b30b45a5-1a23-465f-9787-2d85559d2593@nvidia.com>
Date: Tue, 10 Mar 2026 10:16:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] net/mlx5: net/mlx5: fix probing to allow BlueField
 Socket Direct
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <20260302113443.16648-1-dsosnowski@nvidia.com>
 <20260304105718.93412-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260304105718.93412-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c1b584-7bb9-4023-f6a4-08de7e7d5359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: CLn+eSSQmMP/+XaMc4RHbiAHbPGyyJJGWNemumPy4tyBdcx3/YuYN9Cdk/5gfj0wRO7rQ+5fTrsoMqna2Kc66CZdqYK35s5PWekGHyFNnmCkYOxKytKpIEUreRWa/hq0a/hyqeAQqOc0/ioNR+R8RZlijU8xPDf2MZbj9wrWUGg4NGNYO+Lhi67tqKQQwEyspWkspg85uiUpdXrAjBwyFmCe3OFzma2EJLCENvB37+1swHOwRAjglPQ1gCWw79lYEWb5RRAP5Zcf3YX//CK/Uw4oSLs1zSpQwWgk+6X9umrJC4ZxXXVeUW4ULrd06ZesrAkYvDA2oN6NKYBnIsMnplmuMqnr8RU8SnChcq2PwzaNuMJURMuWkqwoBNaiLy7RNyE9H0z2bvn1kxePVxodwO23Tm70rcG4DXqT/F5efsKMQRoXes3ek0Go1OgRXO0LnqWwY8HRjzJjGwvTlo+GO60N59dHaJ39A+qhNzFyk1x3THtoQ+6EdLpnJIfLnA86XrAMunCrgwb7/I2lndEIMwxZ7wtd3ZiOCG8E/dFyaKLSXWgiGD4rqmqKWetZq1nugwWMBLr1C/JSsA0SVXu25sfNN6pmYIZHJDPTIDzislgeJs/VUjStMIBf9hxxh3yR/NdXCA8GtCiCi8VgpIzn0IIBdnlgors4JecvIvolBBWHQAGZDowGdxr9ssKE8DhmQeWhnD7OQWeXn5AnbGpSBUHaQ2Jt0wXvA9OYU2oWvWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXEyK2VEQ05kZWFSTFB2di9LRmFTRmlPTUthYmVhSzlqNS9mc2FzSXo3Mkx2?=
 =?utf-8?B?SDN2QWJpaTF6ZHBJSjZ1a0pRM1VhNEFIeEdPcFU4YWF4NjEzVWhVK2c0RmxF?=
 =?utf-8?B?TGdvNll6emxqWnJTR1hBK0x2NDFrcVdLZmRnTm5NcUZFeTRiZkpBUm9jRE4v?=
 =?utf-8?B?NExMOVZBY3padmp3MzFld1J4Tzc3ZGhhVGFzL290YjZjSFJCSTZCdU9tSVVy?=
 =?utf-8?B?czJjOVBkN3J5eEkvdCtaYW0yK0pXdzh6aGhiVlFjSmxQSGdnUUpReUZxMTlo?=
 =?utf-8?B?U2IzT1ZNdzRUM0hoVUFReFp0dnhhdHJ1QjRxYS9qVkFVQ2ZZRjRZZmNjL3lO?=
 =?utf-8?B?U0Y4Rlhva2MxWTFsVks0em5zUjdtRUdEbTRiWHYveXI0UHQ3Y3hFU1FRZ3k1?=
 =?utf-8?B?blZLRkt3M3RWdDBWQVZpNXd1NXpBK0toK3k2Y3hXd3lmOTJOTEJKYTAya20v?=
 =?utf-8?B?c1VuMHFSSzlPZStXMlVXcHdvOEM3cHRRS1N4SHVBTURXVE5MaHdzNWhhdmtG?=
 =?utf-8?B?MmRvTERUVnZCb1RIaHNSSGozekpYQVVoVG5TS21JbFJTbG9ORWM2ZEFsV09h?=
 =?utf-8?B?eVh5cWF3VGRJOUdqN0Y5VG9TTGVnZmNUWHE1a0ovSndKQ25sRDlXRzNZS04w?=
 =?utf-8?B?WGc5VnBnZCswdENkSUFYSWtXeUo1bGY5bHQzV042Rm5lSGVTYWI3dXd5SXd4?=
 =?utf-8?B?YW9vS0gvY2lpdyswUXdEVDRyK3VrYW9lREFrV091V05RUWNuRTBzZTBRdFhl?=
 =?utf-8?B?QVVUbG03RThPM2kzS3Mzb1FIU0RUbVZOZGZscngyOEpaMkRUTGdVWXRva3Ex?=
 =?utf-8?B?NTQ2cWJjVVFRblJMTG9DdDZlRDNadndXcXJ4UkJxaWxMT2Y0ZStvMkp2SXhh?=
 =?utf-8?B?ZHB1WTV5eUxtak1FT2tqdU5wb1gzSm1UcFpURktUay95eW9kM0x0NENmbXR6?=
 =?utf-8?B?V29CZkNLQ0ovbGluOUwyZ21BMGxXMS81WFAxMTAzYkRVOE56USt2eXQyYjFk?=
 =?utf-8?B?NGdvN3RNb2VLT29QYlFTK1JlRmt0ak04SVRWTWlTRUJjZnUyTFJyWkh3a2dE?=
 =?utf-8?B?dUdSMVZJSHY3ZUt0R1FhK3ZBd1IxREpQdHViMlU3WFNkdjRHRHorODZVOW44?=
 =?utf-8?B?bDJHYVhOUFJIY2UxZVhCaUl4d05zL1U0aUdXT25QUU16MmpYbmFXeHhEYTFV?=
 =?utf-8?B?eU8zcHhQQWU3Uk4ySGpWQURKNmxKM21Sb21JQThPSXkyU2tqam1DaFFpTklo?=
 =?utf-8?B?c3lwTlFmOHdwUVNNclRFVHRjSzhMdnRvL0tWYUZVWHh3S3NpVURXeTU5clV4?=
 =?utf-8?B?K1N5dUt6bjRJdTdidjJKMDBqa294aHhvU2s5ek5pOHRwUTUyNjZBOExmWUxs?=
 =?utf-8?B?UEdyZUVTb0xkck52N3cxSy84ZkZLVERQNEJGcGZ5TGVySVRDSUVUQ1FqMWtH?=
 =?utf-8?B?bUZnZEs3S0orSFJnZW1NajY4RHZwakJiMzN5aFpPaGVBdmkrOFk5Zk52SWpM?=
 =?utf-8?B?SFd3RTBTL2ZHZUhZanZhRjVnOUg0Nkc2eVNpNEtFbTJwMjJrRWtLalRtcWRR?=
 =?utf-8?B?czEwOXlyeDU0NjJjQXFDakdyY1h0UmFQNCtYVlEyRSt0bnJmM2prYUJQYVJz?=
 =?utf-8?B?LzJsOEFMUkc2RlJoZHUyeXRkUGMzMDBzWjlwLzhDUDNDQ1B2SWRlU2R0dThM?=
 =?utf-8?B?L2FTSXV5RExkT2JVSVNKVjBTMkNBc2J4eFI5MGZxTDJRa1ZGYk1vL2NXbG05?=
 =?utf-8?B?dHRyeitEQW96V1dQK1hnWEF3aUQvNU1OaElGMUpuWm5taEw3WjZ4WWZ5TXUz?=
 =?utf-8?B?M0trRmR3SUNJOFBpQktpeW1QVHZkQmpta0dMQ3ZiTmpKbUJnTlFGTzlkUmhY?=
 =?utf-8?B?Q1ZxRlloTm1EMnBTUjU5SkJSZC9oaXVseW5DdTJ6U29iRm9lSEdCeEdiYm9U?=
 =?utf-8?B?ZDhJWjFrMUVQUjBZZkpKYXlQUGxtdG40QjFJSVdKL0VTR2puOE1PN0NLK3F3?=
 =?utf-8?B?cytMRENtc28wUkRUM2tKclNmbVEvZFNXRFlEZitvTEFLcWdRZEdobVkzd2d5?=
 =?utf-8?B?dUd6aFRMblNzNG5LeUVuZHUremZHZ3FzT2p5VGIzbGhyT3ZtMVlvTzYvOGw4?=
 =?utf-8?B?ZHNXY3FDUG9Pd09WdENleDBRek16aGVmNysyL3pTMzNIaFVYTDlnWFRycWhV?=
 =?utf-8?B?OTI1eDlNdkh3OUgwUGgrcUNWVnBKcDUvOVlrdVVjWkQ4SWdzaHVtM21vWG1z?=
 =?utf-8?B?WDUxZkpJUk5NS1gyMWw5N0phMFRhQjV1OFNLSzBrNUx4MjJjdU1WOGR5WVZp?=
 =?utf-8?Q?BdZfprmP+bxh5XgtyI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c1b584-7bb9-4023-f6a4-08de7e7d5359
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 08:16:26.9512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIWjoK3N42vVaTkHr/HzEuKPos8oZOjEjbMriLlkH/1R6GprpsnAVhcAmoUq1DeMcL9JhPAVVJkokLWgy4GmpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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

On 04/03/2026 12:57 PM, Dariusz Sosnowski wrote:
> Goal of this patchset is to fix probing logic in mlx5 networking PMD
> to allow support of BlueField DPUs with Socket Direct.
> In such use case, BlueField DPU will be connected through PCI
> to 2 different CPUs on the host.
> Each host CPU sees 2 PFs.
> Each PF is connected to one of the physical ports.
> 
>      +--------+               +--------+
>      |CPU 0   |               |CPU 1   |
>      |        |               |        |
>      |    pf0 |               |    pf0 |
>      |        |               |        |
>      |    pf1 |               |    pf1 |
>      |        |               |        |
>      +---+----+               +-+------+
>          |                      |
>          |                      |
>          |                      |
>          +----+           +-----+
>               |           |
>               |           |
>               |           |
>           +---+-----------+----+
>           |BF3 DPU             |
>           |                    |
>           | pf0hpf      pf1hpf |
>           |                    |
>           | pf2hpf      pf3hpf |
>           |                    |
>           |  p0          p1    |
>           +------+------+------+
>           | phy0 |      | phy1 |
>           +------+      +------+
> 
> On BlueField DPU ARM Linux netdevs map to PFs/ports as follows:
> 
> - p0 and p1 to physical ports 0 and 1 respectively,
> - pf0hpf and pf2hpf to CPU0 pf0 and CPU1 pf0 respectively,
> - pf1hpf and pf3hpf to CPU0 pf1 and CPU1 pf1 respectively.
> 
> There are several possible ways to use such a setup:
> 
> - Single E-Switch (embedded switch) per each CPU PF to
>    physical port connection.
> - Shared E-Switch for related CPU PFs:
>      - For example, both pf0hpf and pf2hpf are in the same E-Switch.
> - Multiport E-Switch.
> 
> Existing probing logic in mlx5 PMD did not support case (2).
> In this case there is one physical port (uplink in mlx5 naming)
> and 2 host PFs.
> On such a setup mlx5 generated port names with the following syntax:
> 
>      03:00.0_representor_vfX
> 
> Port name syntax was selected based on specific setup type.
> Since setup was not recognized as neither bond nor MPESW,
> mlx5 selected the default name without PF index.
> Since BlueField with Socket Direct would have 2 host PFs,
> such probing logic caused DPDK port name collisions
> on the attempt to probe 2 host PFs at the same time.
> 
> More over there were some false positives during probing on systems
> with or without specific udev rules which change mlx5 IB device
> name to include "bond" in the name.
> 
> This patchset addresses the above:
> 
> - Patch 1 and 2 - Fixes bond detection logic.
>    Previously mlx5 PMD relied on "bond" appearing in IB device name
>    which is not always the case. Moved to sysfs checks.
> - Patch 3 - Fixed uplink and host PF probing logic.
>    Previously mlx5 PMD relied on specific setup type.
>    With this patch probing is more generic and based on
>    types and number of available ports on the E-Switch.
> 
> With this patchset, a DPDK application run on BlueField ARM is able to
> probe all the relevant representors (corresponding to available netdevs).
> Using testpmd syntax users will be able to do the following:
> 
>      # Probe both physical ports
>      port attach 03:00.0,dv_flow_en=2,representor=pf0-1
> 
>      # Probe both host PF 0 from CPU 0
>      # (VF representor index -1 is special encoding for host PF)
>      port attach 03:00.0,dv_flow_en=2,representor=pf0vf65535
>      # or with explicit controller index
>      port attach 03:00.0,dv_flow_en=2,representor=c1pf0vf65535
> 
>      # Probe both host PF 0 from CPU 1
>      port attach 03:00.0,dv_flow_en=2,representor=pf2vf65535
>      # or with explicit controller index
>      port attach 03:00.0,dv_flow_en=2,representor=c2pf2vf65535
> 
> v1: https://patches.dpdk.org/project/dpdk/cover/20260302113443.16648-1-dsosnowski@nvidia.com/
> 
> v1->v2:
> - Squash patches 3-5 and add Fixes tag,
>    since these patches fix existing probing logic.
> 
> Dariusz Sosnowski (3):
>    common/mlx5: fix bond check
>    net/mlx5: fix bond check
>    net/mlx5: fix probing to allow BlueField Socket Direct
> 
>   drivers/common/mlx5/linux/mlx5_common_os.c |  86 ++++-
>   drivers/common/mlx5/linux/mlx5_common_os.h |   9 +
>   drivers/net/mlx5/linux/mlx5_os.c           | 356 ++++++++++++++-------
>   drivers/net/mlx5/mlx5.h                    |   2 +
>   4 files changed, 338 insertions(+), 115 deletions(-)
> 
> --
> 2.47.3
> 


Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

