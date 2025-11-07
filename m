Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5599ECCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 17:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7190D402BE;
	Fri,  7 Nov 2025 18:59:57 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10]) by mails.dpdk.org (Postfix) with ESMTP id 4D6944021F;
 Fri,  7 Nov 2025 18:59:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+J78+cZklT8fDLV7ztCtH12zhtmD9NDJYCj7uJVkvXu1aKAP60H639ONN0Xv4csxnp/0AvMDSx7JXJRM0YWrE8jBEjqUj5MUkSB/6WQaL537q9dEZ3gORbR6VUcgdZOflGPFRfYHXBR/yl2LVhf+fbMImmX/s7OQqVMywrRoIieO2YozEj3RSL7Y/Ohwh+T/joIQFm4bfTy+FrQSUWa9XrJo8iQZhUrm4yGNMpNPXCyIlvwSpYcJXSXNyZhh1FQ0Y7Sfy2Rwv6djKTMYPqPibpNbENc3AHSip6NTxKTc1HbiV5ReBlPNq30M2+qNBPKEW93rQM6XiZy6+z783tE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvjB+3jmd1bQyEQ/sDZlvDfjgcaK8ty3DZgpIPD91tw=;
 b=GAY1pn0sdd///X4geARGMyWXX4t7sN+KvkowLNCdd+GBZ1CJilR9HIdSpFxfTMNKrUfER1UuqLxkKgp1ejAJ2OKRO8XxCawyTGvNxYDP/KWH9xJivznak1CGN9PzkHqPRol+9viW+tPEElpfWZGuITsdmVJvAIoMp3gJn2WTmnhkzQ31/VXmx6ASgq2srkI+r02CUR7kj8f6egfUfEjTE8mz6umUFWebLJEuKWNjvAwa0QCL67HOE+SVufiwA9jVU6tvmrJD5uCU3yp1cEV31TJ/JWsEXbIVop2d9yqBBtZU/1Z4HWtfwsXqa0xKs52cmq08kO9r/c3qRkXEEhS9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvjB+3jmd1bQyEQ/sDZlvDfjgcaK8ty3DZgpIPD91tw=;
 b=hqpG+ayV6wIQDBVnzgGJ4mFyXkI0HZpJpNqoN7z68TuIEgceZtPabs48Zq9Qc2jbG4oA/N81lbjc4VMj4iBVc6GAtGP2eNhIpxd3wz985Wh/oc6O0f1Ohyd/1D4ZuBwAIeUPYQLJhJ+MR+quM56UUtBUJDDDPpU+9IlO2sq2RVc55Q9UllEVeVNlsQ85oTADZwrwco7AYOXWzOu7BUeJ/I6qzd90GxTiA0HC6AtujvX0bYnlUsN9g27KWLtOVJY51aFeVvmCIZx1F8UKasxJMm5ZmMPEpnQIk5FOSLSv+n1b05ihr/xMurDZrKdIgi9yW1OZtqwqjfzHyuA9seVFHw==
Received: from CH0PR03CA0266.namprd03.prod.outlook.com (2603:10b6:610:e5::31)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 17:59:49 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::7) by CH0PR03CA0266.outlook.office365.com
 (2603:10b6:610:e5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 17:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 17:59:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 09:59:38 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 09:59:37 -0800
Date: Fri, 7 Nov 2025 18:59:36 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, Alexander Kozyrev
 <akozyrev@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>
CC: <jerinj@marvell.com>, <kirankumark@marvell.com>,
 <ndabilpuram@marvell.com>, <yanzhirun_163@163.com>,
 <david.marchand@redhat.com>, <ktraynor@redhat.com>, <thomas@monjalon.net>,
 <konstantin.ananyev@huawei.com>, <konstantin.v.ananyev@yandex.ru>,
 <bruce.richardson@intel.com>, <maxime.coquelin@redhat.com>,
 <anatoly.burakov@intel.com>, <aconole@redhat.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Message-ID: <20251107175936.4yr2quzngd5gnp2l@ds-vm-debian.local>
References: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f84b28-2998-48fa-03d3-08de1e277186
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wzONKRR6hont6abIH+v9DWuEQfvmCDXY/PIniONfz+koQwnLb/IWHx6csJUk?=
 =?us-ascii?Q?xZQLzDvrY8BTMUdaJr9+VitgZ/FIOFxVRUeTgLC6Ows9WTWMZXlvu1TkapNw?=
 =?us-ascii?Q?pL1iiH3NZyTVra1y1Sxy8s8uGxr5KYqsRKIcuokgH26Pj9Zt5zqdBC5hecmi?=
 =?us-ascii?Q?ixtnn5MyzzF7IRyfVcfShrTMku17G3K8cM725+JAAr5MTt0DRArcoGMIfJ8B?=
 =?us-ascii?Q?HDUIsRsFqCrbUmMIYJqQjWZyyw6OpfojXNxX7MyImWFwg0SUM5JHnp1pUiNm?=
 =?us-ascii?Q?S+jCBo7oMqeKdA/poZa+TjGIG5lEJK6+7G3umZ3YDcdjpjh9jELQ+1WGb0ir?=
 =?us-ascii?Q?QrumdsKZvBauZN4weArBI5gGXY9ZVU85LfwTOFgY9+jVaBTPBx5eCYMtC3yw?=
 =?us-ascii?Q?XJsXNayfIXJHWBCv7kybXNJsNQ07gfoHwDxvpEuOv2rAFGZtB3+WVJc6hJw5?=
 =?us-ascii?Q?+9kEBtQj0pH+N0GC8pBPR7nv9EdlnJKOAoGxL6zQGo0L6bvjXMQ0O3fO9vfS?=
 =?us-ascii?Q?0MuVMFhyuwmNPQ09GI4Ha7dFCTRsPvzRGo9myxVRInDnr6fLOmftmPTA3rIZ?=
 =?us-ascii?Q?EP76VE5xwYHLuf+Sis+qQx9eVl9JC1sjao6h+IQcCvwuRclMKrO//Cu7OshH?=
 =?us-ascii?Q?Mwo3HqLvCXzktsZTGYAmKcJJcXFiDUeQqUk7DVAEUDZOHEraiK9Z2eTrtn38?=
 =?us-ascii?Q?dpNY8SZFqHw8o1L4xOAEOGrGk+tO+AijdYx7P+ZXL3WY9S8CznK6mKyzyehW?=
 =?us-ascii?Q?zKHsXqHEvEsy95DloYabssIK1rSA3NagMxEIhNAk20+rY9Ujq8Q1OJ7DDHKE?=
 =?us-ascii?Q?dIuqdRM83QjAQ4/295ltbR/4nc6I8lgEJPLvu3Z1QGAj5B9k4ue0PT4Q8+Um?=
 =?us-ascii?Q?OSbeX9ATqu2B1RUl//sLizY4drLvOHcG7uEap8/yt06DTRjmJN2eQdEF/oPS?=
 =?us-ascii?Q?lmW/R3mupiM24ggBVp8KYn7QmJfE8BdNu3bW2YTocDGUl+sqxBbJEd7tQjpT?=
 =?us-ascii?Q?S464o28z7lR5ETJY7tbA8RNiPgOQG0O9Rd8rSpeNIikDBs5kJsNQNSU0uiOS?=
 =?us-ascii?Q?nGbpNC0003vwa3/ztYVzYoFBApCrdwhkcbEHkXtdmVkrR4SRlKLd8EKUcq8G?=
 =?us-ascii?Q?3SNcm66cWAXFzwQMyusekDnf44zUYzUxE9ienNhep5KGQCzULOCFl1lep+gb?=
 =?us-ascii?Q?t9dUSapEEYFszORMPJJAdIGalFZIZ/Q0Do4wBY3yL29a99bs4mPOhhAexW+0?=
 =?us-ascii?Q?apRU9tEYIlEAW2TdjJj4vnlzaVzP5w1vJ5cTS1UTFrZhQtpGPlh8HkhyDl+i?=
 =?us-ascii?Q?es8gmCF4A42kzFrtFx/RsgN0Fy/7P/08Pkpzec2YfB/ljnvA8LqtodPZcl1V?=
 =?us-ascii?Q?XasYNe8g4G5zqVJOACZw8WCtXCtLDxDXq3JreWmdqgjlKK97pYJ1A15on2LO?=
 =?us-ascii?Q?foL+vf0NhDIWT4dLaGHMFaL6/lw1ipHwPQzy+/VSVVUk9GNzNMtn+o6Vi8bB?=
 =?us-ascii?Q?ySYgvZV6HpDbaBqIn9zWooqLAo93qBBlaFfeiNeGByiogrhneE13/WYDPapD?=
 =?us-ascii?Q?/YaMQVeaT0SVwzRb7Gw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 17:59:48.8068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f84b28-2998-48fa-03d3-08de1e277186
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
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

Thank you for the contribution. Please see comments below.

On Wed, Oct 15, 2025 at 01:39:57PM +0000, Sivaprasad Tummala wrote:
> Previously, the PMD used a common monitor callback to determine
> CQE ownership for power-aware polling. However, when a CQE contained
> an invalid opcode(MLX5_CQE_INVALID), ownership bit was not reliable.
> As a result, the monitor condition could falsely indicate CQE
> availability and cause the CPU to wake up unnecessarily during
> low traffic periods.
> 
> This resulted in spurious wakeups in monitor-wait mode and reduced
> the expected power savings, as cores exited the sleep state even
> when no valid CQEs were available.
> 
> This patch introduces a dedicated callback that skips invalid CQEs
> and optimizes power efficiency by preventing false wakeups caused
> by hardware-owned or invalid entries.
> 
> Fixes: a8f0df6bf98d ("net/mlx5: support power monitoring")
> Cc: akozyrev@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> ---
>  drivers/net/mlx5/mlx5_rx.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
> index 420a03068d..2765b4b730 100644
> --- a/drivers/net/mlx5/mlx5_rx.c
> +++ b/drivers/net/mlx5/mlx5_rx.c
> @@ -295,6 +295,20 @@ mlx5_monitor_callback(const uint64_t value,
>  	return (value & m) == v ? -1 : 0;
>  }
>  
> +static int
> +mlx5_monitor_cqe_own_callback(const uint64_t value,
> +		const uint64_t opaque[RTE_POWER_MONITOR_OPAQUE_SZ])
> +{
> +	const uint64_t m = opaque[CLB_MSK_IDX];
> +	const uint64_t v = opaque[CLB_VAL_IDX];
> +	const uint64_t match = ((value & m) == v);

Could you please rename "match" variable to "sw_owned"?
This name would better relay the meaning of the checked condition that
CQE owner bit value signifies that CQE is SW owned.

> +	const uint64_t opcode = MLX5_CQE_OPCODE(value);
> +	const uint64_t valid_op = (opcode ^ MLX5_CQE_INVALID);

IMO the usage of bit operations here (although logic is correct) is a bit confusing.
Could you rewrite it in terms of logical operations so it's easier to
follow? For example like this:

	const uint64_t valid_op = opcode != MLX5_CQE_INVALID

	return (sw_owned && valid_op) ? -1 : 0;

This also would properly describe in code the required condition:
CQE can be parsed by SW if and only if owner bit is "SW owned" and CQE
opcode is valid.

> +
> +	/* ownership bit is not valid for invalid opcode; CQE is HW owned */
> +	return -(match & valid_op);
> +}
> +
>  int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
>  {
>  	struct mlx5_rxq_data *rxq = rx_queue;
> @@ -312,12 +326,13 @@ int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
>  		pmc->addr = &cqe->validity_iteration_count;
>  		pmc->opaque[CLB_VAL_IDX] = vic;
>  		pmc->opaque[CLB_MSK_IDX] = MLX5_CQE_VIC_INIT;
> +		pmc->fn = mlx5_monitor_callback;

Alex, Slava: Just to double check - in case of enhanced CQE compression
layout, should both CQE opcode and vic be checked?
Right now only vic is checked in power monitor callback for that case.
In Rx datapath both are checked to determine CQE ownership:
https://github.com/DPDK/dpdk/blob/main/drivers/common/mlx5/mlx5_common.h#L277

>  	} else {
>  		pmc->addr = &cqe->op_own;
>  		pmc->opaque[CLB_VAL_IDX] = !!idx;
>  		pmc->opaque[CLB_MSK_IDX] = MLX5_CQE_OWNER_MASK;
> +		pmc->fn = mlx5_monitor_cqe_own_callback;
>  	}
> -	pmc->fn = mlx5_monitor_callback;
>  	pmc->size = sizeof(uint8_t);
>  	return 0;
>  }
> -- 
> 2.43.0
> 

Best regards,
Dariusz Sosnowski
