Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA0CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 13:40:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA226402DB;
	Wed, 15 Oct 2025 15:40:16 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by mails.dpdk.org (Postfix) with ESMTP id 10C6140273;
 Wed, 15 Oct 2025 15:40:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6U+5VusvihjAdfOVbKRqwmT/17VvGAd+D1HVD702QRL6B9fYYkViKfQ3NuYhU65L9PV8lgwn0vypIkOppaY8uiO5CvxsTK/xTfroVqoLlDjhQbhkvZ1Z1+x7fHfeXrKy0olIw71l5raDVXdaensn2hhTqX3Sc0GeDFaqHuXEQ//07d4XPby8HirOosxGo+3HG8w30zg5EfoyfXH+JazqcMgLUFXQs0u2ztIhZR2nlTw217Ty4rKaxBdTC3XFucMVW2mT/SAK0WVnDVJbGpJkcNk0FUzRIT2UOnt17g+6X2DV+ljGIh6LpN4ja7C5yQ8oxAgL3Lt1w60WV0DbhtLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s25Htk2HMR0/H/7BKkEpfzu//QVVqL41435qHBOjIk=;
 b=XnUbCxPf32RH0vnB+0TLQTMCLVB4qB3A1nzE8NLjMbDcNcq+4tWdx9W0Z93RC9LHNfT8JdAmRiFeS6GlXehic4CUBim9NuoqJj6oLluqOQpPIWJ2pRt7LMYTXfnpY1JBHQ32vBrKSJc2w/g1sa1jMHPVr/infyfpG9dYBDUPKe0xCS8NDd8n1BHk9T519QK7xWmJZpewV7mjBX4keMurYz1xEdM9DoQRvtVtv953Vpi5bZp80H4sHskJ+qQ37jMbJPtlnWEfE+pN7r01QNzZmAfa9libvvExWBtWQ7Etri+vHluIDTTX3ZubOlL1n49gsSmtf8zbJVpS361SoKbM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=marvell.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s25Htk2HMR0/H/7BKkEpfzu//QVVqL41435qHBOjIk=;
 b=0chM8qUrKCXExWp8VJHi7AtWim0l70HQxrldJwDQ/RSJD0ZZ656W47cjxr3cCcZzgxWIqtQH/IBSPczBNNRDnee6h3hnAUAOoPbE0X0OP8Mm9j1vzAsKbQPlBXBRqAN4sZGvFc/kzpDvPkxs4JU2Yfr48z4Wq2fA52D5Oz8jVaU=
Received: from BLAPR03CA0143.namprd03.prod.outlook.com (2603:10b6:208:32e::28)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 13:40:11 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::be) by BLAPR03CA0143.outlook.office365.com
 (2603:10b6:208:32e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 13:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 13:40:11 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Oct
 2025 06:40:08 -0700
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <jerinj@marvell.com>, <kirankumark@marvell.com>,
 <ndabilpuram@marvell.com>, <yanzhirun_163@163.com>,
 <david.marchand@redhat.com>, <ktraynor@redhat.com>, <thomas@monjalon.net>,
 <konstantin.ananyev@huawei.com>, <konstantin.v.ananyev@yandex.ru>,
 <bruce.richardson@intel.com>, <maxime.coquelin@redhat.com>,
 <anatoly.burakov@intel.com>, <aconole@redhat.com>
CC: <dev@dpdk.org>, <akozyrev@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Date: Wed, 15 Oct 2025 13:39:57 +0000
Message-ID: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adae726-97f9-45f2-77dd-08de0bf05d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9lz+tWNmk1f4puwtt5JGHrdzTmrAVvtToJMRnnsJrJ6XxP03eKp35ATTQmx9?=
 =?us-ascii?Q?7o+kn+nVMX93YgK+nS4i6WwIZMyFULt48OAZsXJb8DNNJJV0cIWXCDDZk0Ci?=
 =?us-ascii?Q?KZ9d9xxQc9i03uZ1kJ+omx2RFdRPRoCPRsvtOdOagD3Jb1oTl7ZPyF3xkG6z?=
 =?us-ascii?Q?towr7QTXGcPte0pXlQVLQwrHZGMTNOEoC2VFHBeHfi6VlSuRpzHQe3HCA7nm?=
 =?us-ascii?Q?JfPGcrV0vIKxQBOiu83ch+nX92hJiC+ZJCvbkjqIOHRwzqS83mmT/iuQfw6c?=
 =?us-ascii?Q?SEtR+QW+rFfo4GshBLX+DoAgZGYHmYDyGsuwjL/0YzR/FiwRq24ooPcgTsbD?=
 =?us-ascii?Q?Bfi6UubGRlj8BJt+xQNYGvMxzqBRboEtZFvVnE8DpJ0P/Lc5UINTsPp5Cjq7?=
 =?us-ascii?Q?kk4DUi+GrYn+eyEQdT4vy6JnBrFFJaGL0MWhA3nyk5xgY7AnlWHpsya3Eqyp?=
 =?us-ascii?Q?QsKyGRW+XGBqpN+qE98s3b2kVo/uvLgG/Fj0t1qCifpWAJDmIPXO8C5CWrR1?=
 =?us-ascii?Q?TTjpOc5yA3ueeoA5GybqtJJrTuc2WImtnTPdk9N7MGlLt77iVY4HnKFa/PK7?=
 =?us-ascii?Q?hdXhjzBfolmRMmKWfu8vqd+2VhBA53UhLnd7tD/ENbgRT/oYxGDLwNWbFdg+?=
 =?us-ascii?Q?Yh4PAq2a2bNyRvVrGrr0pGXM6GqbFU0H8i4VcSySk79WT0KXd/+H0FdWMkFA?=
 =?us-ascii?Q?kGpOuv2wnpQvBJ51AOywEtti/J4arxjeXu6RMENwsPs+eC2ko/qGRFlJ31Tr?=
 =?us-ascii?Q?bM+gGw1DXHIiy/I4LDFDJ8s3parnCh1vne86RrdCsNj1P6XGVh+FLpwpubt+?=
 =?us-ascii?Q?jPibzH6uVeqIPxuSBTrFAU/OJL4XMJty+0GdnVNBu6GphAF8P8bA1ASHav6h?=
 =?us-ascii?Q?xOmOaHDj82QTUsBWSDF+RrDq6zEPBV4xFXL6zMXW7LQxXVP3mRw//C0OgTV7?=
 =?us-ascii?Q?PCks10wsSZ299eFGsBkvt+Z0n7kVPzL1/vYnCSPh8ArTFeVPQBcK46V9nOqG?=
 =?us-ascii?Q?ZeMN2PNdv6EX8tYDqZn3unnOz7pOSiCEcnFoxWdiR7Qh8ffokqFsblbigGQx?=
 =?us-ascii?Q?WkBIAYc1V1QCZ3Q6M97NiK5YPuw9DJJNL5ZFmBytctFUHLia7SUczObUJQfU?=
 =?us-ascii?Q?zKA8NzgyGZ8YGNQsN7F/z/GfCVNBsCt98XzWwnUCUbi+LLsOBrez8YkXoNPN?=
 =?us-ascii?Q?fjsHZwjzu4FvaU/Qlhab0q3/St2wi2eT+5JQVSmQLUeMnNBGYgi1KYx2zz5m?=
 =?us-ascii?Q?MSnWA2Wb42s8EztQU3jliQzsxpxiP2T3167bvWw+YpOrJyeO8jb67/6sfkTY?=
 =?us-ascii?Q?rDgrjIS7qhjniFAzUmOPrXb9V10jEZAnfMPfbDM1ZdR7I8EWOM3LVneccn8E?=
 =?us-ascii?Q?SFSDvCduPK8xSO/C4WS4ygla69eGNygdUDa7U5YF2Tp3dVdqKXiwlKcVW2DF?=
 =?us-ascii?Q?JZxKymwaZdCb2g6JV93IUB6dU+t6zOJB/YerpWAJjhsqPXseliycxQX2a83N?=
 =?us-ascii?Q?HfcLNyhdW7WcD9gjB4rmH3ARSOzsPVexaFsCeTN9I4qbxqXmUHHwQbMJIhnw?=
 =?us-ascii?Q?Top4xYk6N5qVFocRKmV1drn2rTmy4yXK6IWZgzgD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 13:40:11.5299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adae726-97f9-45f2-77dd-08de0bf05d21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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

Previously, the PMD used a common monitor callback to determine
CQE ownership for power-aware polling. However, when a CQE contained
an invalid opcode(MLX5_CQE_INVALID), ownership bit was not reliable.
As a result, the monitor condition could falsely indicate CQE
availability and cause the CPU to wake up unnecessarily during
low traffic periods.

This resulted in spurious wakeups in monitor-wait mode and reduced
the expected power savings, as cores exited the sleep state even
when no valid CQEs were available.

This patch introduces a dedicated callback that skips invalid CQEs
and optimizes power efficiency by preventing false wakeups caused
by hardware-owned or invalid entries.

Fixes: a8f0df6bf98d ("net/mlx5: support power monitoring")
Cc: akozyrev@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 drivers/net/mlx5/mlx5_rx.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 420a03068d..2765b4b730 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -295,6 +295,20 @@ mlx5_monitor_callback(const uint64_t value,
 	return (value & m) == v ? -1 : 0;
 }
 
+static int
+mlx5_monitor_cqe_own_callback(const uint64_t value,
+		const uint64_t opaque[RTE_POWER_MONITOR_OPAQUE_SZ])
+{
+	const uint64_t m = opaque[CLB_MSK_IDX];
+	const uint64_t v = opaque[CLB_VAL_IDX];
+	const uint64_t match = ((value & m) == v);
+	const uint64_t opcode = MLX5_CQE_OPCODE(value);
+	const uint64_t valid_op = (opcode ^ MLX5_CQE_INVALID);
+
+	/* ownership bit is not valid for invalid opcode; CQE is HW owned */
+	return -(match & valid_op);
+}
+
 int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 {
 	struct mlx5_rxq_data *rxq = rx_queue;
@@ -312,12 +326,13 @@ int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 		pmc->addr = &cqe->validity_iteration_count;
 		pmc->opaque[CLB_VAL_IDX] = vic;
 		pmc->opaque[CLB_MSK_IDX] = MLX5_CQE_VIC_INIT;
+		pmc->fn = mlx5_monitor_callback;
 	} else {
 		pmc->addr = &cqe->op_own;
 		pmc->opaque[CLB_VAL_IDX] = !!idx;
 		pmc->opaque[CLB_MSK_IDX] = MLX5_CQE_OWNER_MASK;
+		pmc->fn = mlx5_monitor_cqe_own_callback;
 	}
-	pmc->fn = mlx5_monitor_callback;
 	pmc->size = sizeof(uint8_t);
 	return 0;
 }
-- 
2.43.0

