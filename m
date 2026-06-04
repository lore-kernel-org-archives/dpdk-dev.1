Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DE6CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E9F840662;
	Thu,  4 Jun 2026 11:38:12 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by mails.dpdk.org (Postfix) with ESMTP id 6CE6140270
 for <dev@dpdk.org>; Thu,  4 Jun 2026 11:38:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubcTjIXb5enUDv5USOCy2XEYx/K2UpOAx6BWIOuhhjneRPHslSAHdQi5WPK9UGsBfrifez+BuGnUzfYSCqeK4v7KZ7VmwylCogFNBk51wq0M1OsT2eC3RgBupM5ZxmAWrezFerr824ELche8b5963PFh6uY97urI4+XZVEKExgauiO3eyojPq3sXmA0nUEqq5+j+9h57IsvsSi919pOFqIaLTf6DBO3rcMVP/QN+1+vDJtMKuzIiX6inq0DcR50x8fKCzwS4Xx9d277kwwv9obOjry/RyKwk7ntHgQOpwjVpng0iP+UDRBlgSy62cKllmdosjisE5Euqd6YkzIbZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QPg23oXawwIg1QyPI18gLpR+M8UHY1HWuXRmaC1esU=;
 b=H5hl3iPb3ALX1DQi13K/ifmgid9IxuEunbxzo6iOkpiA72tNdEnJcW6qB1AUzksVrqwdIQIN8p6OCtFtchlWJCos8k/opKYlEk+KBP1/B7EZD2U7aks+L9GKe1OLuf0c78FDL4VPueL5M9OVHr8LAd8cnc66slCZw115uOx5VCWfPg3lMk6cUPyALe5waWVKl6AqTOlUhP5rtBtRmEDKYEwxOGtIwZ+j/PgpWCpbD8IvkZ7UfnXfrKiFfa2mYgkQRDFWqAYXgLzk2oTzxo4WX5ZTK6Tw17uMrCP8G4gE4U29LRl8AUTD9gArCLH9o+02pi7Ws0SYYwSlMbct/XuFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QPg23oXawwIg1QyPI18gLpR+M8UHY1HWuXRmaC1esU=;
 b=XltUw+hOMMj3I2Kth87CT2Z4q0MM0N9AbEnZph9gam6fVQotY0HLHJeU8HYpah3I9MxweLp+yOQ+V3SvtAcewl3LL7lXmCbxoxBbr5hGh+HDUqlVPXUBrMQnbYxJXHNB617RhuAk58jAKU9mSTav4mGpGHTlW7Len6YNmnfxqn+EDkO20/4BhTgqOMv/rtZl6NAV/njeQ84bCFhDtNpd9muB3GGAVKrWtHaQ5qNfMxVTITmFYNGGWf8MDeXYParRAd7ONPeKXAKcMHc7kyLPJFeWENAf/K17jaPuwZ+9qwCkdJoue97C6jnQjtafpaBYxxZdyZGgEx58jwnAMrEZgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 09:38:07 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:38:07 +0000
Message-ID: <80a9a922-f183-4dfc-bc57-ebff8295504f@nvidia.com>
Date: Thu, 4 Jun 2026 12:38:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: promote private API to stable
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <20260527103357.633429-1-dsosnowski@nvidia.com>
 <20260529073255.689808-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260529073255.689808-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e3870e-575b-4975-0a8a-08dec21cfb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: cxUJxz+38rpq4uLh1lfsbJ2aWhzYIgt/HqVHkHBqkitgJYT4clnXXyGlb4J+yM/HVvzogm03uy7G524WYaOkiPkiPIUmucJI9QIr/MLLIOmFiaYoSFh2OYg13giFF2ekrFPowiEQ097rTOUfhONcgYcmbs1FENAIWtsBeV8CucYTNMOKeKmyFrJbL9RRfEaaQ35c2KDWY2noVcmi0GMetOu4o45qooMULZOGAG/+ZJQ8lBqmbcMMwARF6IyF8ORtL/vndK1l01Lo+DDLc72zLr57zPQRIvALoXFcuFa6HRKXe52fDxSBPDgPMikTj+tUjQKUrptK6BEwKzZEMGhLLEp8lVRvwAuJ4RoApM+zQja7i8rEBJTBQZ91ld3ScFQi563vIuvEzs/n4bRbfzRqubqk2CPOg1MXY9He3LR3ITLz9eB2OcX52k6pDhQBJI8pvzQc+Ii6GL8jjQi+ztUH6Bs+NLx9schzJcZhVMiMIGDwVqrdOQ2SVtG5i0bmc8dkkufdLYOLmaeJZ4J9rROu2zsvcnVN1yCiM/eTmHylRDbiUNCRkfvrH83QI9qoJtOSIo/e1l07WB1oANHls91jPBwFUn+xoPwWCtkgeAmebz20e7jNKM4RFGhl//SLxVXMzVsQI7PaeCZFhMbrtfqLUWZZn+w1Spj5JmsclpDVS1KIxWb5JYauNP+oX0fN4wJq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGxKVC9iamk5YVBKYVBKZG5CNDJUZmFmV1VoMS9pM1NudEFDNlBsWVdnL2lJ?=
 =?utf-8?B?cTg1UWNmQ3VYZElLcXFTRXI0dkpKcG5QS044dEl6aWtGZDdhaTFzVnJWbDdw?=
 =?utf-8?B?a0VoMzFaM052anVueVpBTGhlOTkrbkRsUlpmd0NYbzJoelBPT25qYXY4ZHdl?=
 =?utf-8?B?WmIyMitqMVZqbVQvaStONG5STjlCZ2c0bkZScnlqd0dkK0plR1VVYTJ1SW9r?=
 =?utf-8?B?aHVGZ3hqcUhSamRJeFhhSHpOcmtYTDk3ZTZWYndBM0pMMjA2WkVkM05Rb2hW?=
 =?utf-8?B?WjdTOEJXbVZxRDBtL3hJUTZmYWE1K0JlTGxubWlldXVKanJVN3pnWVlHZXBZ?=
 =?utf-8?B?ZTNGdkdNR0ozQ09od1ZsSCsxMjl4MHYveUVRQ2E3Zlg3a2RWY0VMRTdsSkV5?=
 =?utf-8?B?OHAwVllqYUdtNlVmT0M1bS9XbGg5UHVJeE1iekpsSWhOUy96bFp3dkozaEhk?=
 =?utf-8?B?NnZVSlV3SlZhYmFoTklzUi9xdXA5dE9HT1YyTGhxOExRQ0QxeUZML2xUQmVK?=
 =?utf-8?B?TkhrQkZZQUdKbW5GM3Fialk1dVJ5bkRoV0ZkWTVvYVlYeFY0UmgwNUc5MndL?=
 =?utf-8?B?azdzamVPbnkxZE9sTDJRU3BtNzcwRWlJTzVEZEJTVzlPY1NkR1dBUG1ibGxK?=
 =?utf-8?B?aVBFVHR6MXNtdVR2MkNlbjhpNDNMMmhiMTBUZHB3M1g1a3FwUHYzczJJbU9P?=
 =?utf-8?B?STRqSkdYQjQ0R1ZoYmFCNGk0dEN1TVlnR3lGd0JaNS9JdXRqZjZLRy95NXJ0?=
 =?utf-8?B?ajM2eTBnWnFVTmJicVJlSVFUazRwd2YrQ29UU1lPY0x6K0RFZHJudndUa0Rp?=
 =?utf-8?B?bGx1UUhibmNBS1VuYVNpV2prODlsTklFSTNIdkdrYkMrRWE1eVVhaVlEYTYx?=
 =?utf-8?B?MSticmJ0enovZ3RFTTFRR3pycUpod09ac2grc2FRS0NRc2Y1ZmVMMlNGTDFy?=
 =?utf-8?B?Y1VzK3poYWovSTN6ZXoxY1pRT1VvRHBYT29TT1FERXpUc2ZJZThBNkp1cVQ3?=
 =?utf-8?B?ZDAxcnFrcUg4RHNkbnZ1b2lMSmhDY0pFZ0hJdUJraVBJRlcwVVBlaDNaSUNx?=
 =?utf-8?B?V1h2aE1JOUYxdlhzV3FscGt0Q0lsdHpwVGFSM3pEQ0NaaTNkOG1IWm9MZTBp?=
 =?utf-8?B?bm5ESkNvOUVVc21pRGFzeW1TQ052ckZNWWoyaThUMEpsejk5NkZZcmZDSjY5?=
 =?utf-8?B?M0VjQlNtTXkwdmxlZzEwVDJlTWpHbmtCbEt2Zm9QYlJzMFR3cXRidUxxc2Ew?=
 =?utf-8?B?cHd5S1B3WExLQWRjL1RlckwwQlUzVVJ0dDA3akZyVi9VZnZyOHFwcHluVDVl?=
 =?utf-8?B?VlhTcnRTaGhvRlF0VEtFRDRIQzhGTzdlQ1pOZlk2eVdXem9lWG1Fem0wQjRM?=
 =?utf-8?B?WlFLWjRIQ2FYNHVGTk1Yay8zMHRhejlhS3pPaDVrZ1VZVFBZMVB1WURSMWk0?=
 =?utf-8?B?VHdObFVGdUc0Z21DeUlTOWE2RDNMUkdJWThKemNwbHBqQmJXTGdFaVhTYWhs?=
 =?utf-8?B?U0xrWWtDZ2JxT3ZiQnlTVXdKWW1KNFhMWFdwL0JGY1YyQnFkbklIWm9PcEd6?=
 =?utf-8?B?a05RNXhycDZGS3pja2ZwZzNuMkpMSWo1YVJNVzFlMkFpZytuQjRSN1d0dW9T?=
 =?utf-8?B?bHhJcTFWV216RUZWVDZnOU5lUUNsL1diY1psZ0VZbVFVOG1kZG1iMit0S1JK?=
 =?utf-8?B?ZnpPcjYvSDFPUGlCZy93Rm9BNmR3VVRiL2k5N2R4NlRvM2NxSStEWXVDWGFk?=
 =?utf-8?B?ekY2MnRucUpjMURwdDY2QUZyRnVOQitGcmNRaHFWTEtaRWNKdklCWTFlSlpo?=
 =?utf-8?B?ZzYwZldnb3d0a1NNT0QzYUZXd05TNUlENmNvL2lxT3pGSmNRak9GSmQ4N2s3?=
 =?utf-8?B?WHA3b3ZlV2hVS1dqNjlTcTNiVnBFMnJvNjhqWnhlWFJwbmExRDVHemNpRXRH?=
 =?utf-8?B?VVRlaDMzN1Q2TFZDNUdTM0JrcXFZRjRNcTdHWFRKZzNiZjlZb2N6S0pLOEky?=
 =?utf-8?B?RmdyUzA0aE9YQW1PZDREMGdYUXdoQU5TY0Mvd1I4WkxSNGdOV3d0WDJDOSs5?=
 =?utf-8?B?eGk5elFvMVZEOEZVR2IrbkFDbW8ybjFNODBYQVlPVnYyOW11NzR5SnB0cFQ3?=
 =?utf-8?B?WnRmOWxkOFZTUFBaOFQ1aTVwcFFsbDI1SWJnVlNDdWF4WWt4Z3crZWk1YnVv?=
 =?utf-8?B?Y3lHalcwQXJja0YrcW5NaFVBWm5QL3ZtM0dwRGR1aFJ3ZWFOSlZwNGNRdDI0?=
 =?utf-8?B?djZmQi9FZFp1aTkyenZJKzZUaFhMSEJLQm5mTG5CcUlVQW5xeDBkUVBPUGRK?=
 =?utf-8?Q?fg+3y0rqoyXqk9Yr2f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e3870e-575b-4975-0a8a-08dec21cfb86
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:38:06.9584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce+len2Wr74Swf/ZpOmRgW+F7UpkHexvOJgkZ//HCIBJgK8R6TbadAx7Xr3HfmFaj29gDnDRgMez1jgZr7RvRw==
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


On 29/05/2026 10:32 AM, Dariusz Sosnowski wrote:
> Following experimental functions are exposed by mlx5 PMD
> since 25.11 release:
> 
> - rte_pmd_mlx5_driver_event_cb_register
> - rte_pmd_mlx5_driver_event_cb_unregister
> - rte_pmd_mlx5_enable_steering
> - rte_pmd_mlx5_disable_steering
> 
> First two are used to register callbacks for driver events
> (when Rx/Tx queues are created or destroyed).
> Other two are used to enable/disable flow steering in mlx5 PMD.
> No changes were made and no changes are planned to these symbols.
> 
> These are currently used by NVIDIA DOCA SDK since version 3.3,
> which started depending on upstream DPDK releases [1].
> Purpose of their use is to:
> 
> - expose HW identifiers of Rx/Tx mlx5 queues managed by DPDK and
> - allow flow steering to happen outside of DPDK.
> 
> Also, some of these symbols will be used by netdev-doca backend
> in Open vSwitch [2].
> Whenever a DOCA netdev would be added/removed in Open vSwitch,
> it will have to disable/enable steering for mlx5 driver.
> Stabilizing these symbols is required by current OVS policy
> to remove the need for ALLOW_EXPERIMENTAL_API [3].
> 
> This patch promotes aforementioned symbols to stable.
> 
> [1]: https://docs.nvidia.com/doca/sdk/customer-affecting-changes/index.html
> [2]: https://patchwork.ozlabs.org/project/openvswitch/list/?series=504726&state=%2A&archive=both
> [3]: https://mail.openvswitch.org/pipermail/ovs-dev/2026-May/432066.html
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
> v2:
> - Updated 26.07 release notes.
> 
>   doc/guides/rel_notes/release_26_07.rst | 9 +++++++++
>   drivers/net/mlx5/mlx5_driver_event.c   | 4 ++--
>   drivers/net/mlx5/mlx5_flow.c           | 4 ++--
>   drivers/net/mlx5/rte_pmd_mlx5.h        | 4 ----
>   4 files changed, 13 insertions(+), 8 deletions(-)
> 
--

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

