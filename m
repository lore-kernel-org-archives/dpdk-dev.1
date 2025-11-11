Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93259CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 03:41:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7087B4026D;
	Tue, 11 Nov 2025 04:41:19 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
 by mails.dpdk.org (Postfix) with ESMTP id AC6B04026A;
 Tue, 11 Nov 2025 04:41:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E614Ez/2l9m+KSTcnGEspJFFRnYKO/My6q9hVGAU605uVzXUD5avTB/weZ53V+YLOvDhf2cQupYZKzvcFVHtYuUA1TZdNJCB1f4QRgws8x+un0w8ZALei+RwH9ml1QUPgCNxh5k3D9bCuo8jG5kERXNbtJkoFIVl1YJDUlf+Fe2QpGPcm4b11e9AntO1ZEja9yLq9FNOsVeMV8esD2+Pdc57oEKLF6kJBRSOlvExOYaBNQszvVkWYoI4LtGUpsx6uuruOJH7DbLZUew9RL79UJze5Rr8qwZxO0ZB0pKDc2wcB+u+Zr0LWriDENm1RNhqyCmyykKvj1rnR+0xtlazpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnWI+13rOlHkYP19C6V4iJ9GaH1RdRSxqJ6TXP0NTow=;
 b=GpAPluqPuKuw5OiyNk7WgHP32srZ0EH2y6kgle/KUoJErJ7vhMJi8LdLHJjSNYSN4fg5H/viYAdMC98IU/EbRp+yo0kd6LM7V0e7yPYs8T3L1FTXHwPUDKgOdiY/e3EINV4LWSp+S8eX/V6nXefGgwtfupwTVqve7Z/AERs3Ein+Cb2lA6JZAdLC9DpvpWxTFIrjFTFbVAvcsboqS4p4B5MUYwKBVx6yGnJxTNWJUbkUDm3L/t8Shmey7k3aZwbih2LiO0/4YnE5XDXb1InZX1s1CdSOhhmARwnqBTrbL8wS2/pzn/xQMH2WzSo73J0qrjx/Ur7F4woC6dGZDDmMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnWI+13rOlHkYP19C6V4iJ9GaH1RdRSxqJ6TXP0NTow=;
 b=OIN6GtCtw/TiN4afTLoq/SOy0uEzuwSUYMGpbI01D6DxwRiXdP4wxcCtC6cB1LBsy6gd0BU9kHuRuxX+RljQts8YzB2z5VUgm/7gdBuGQIOc7oYuBcR2fkwwsV2EybG0fDMJsMnflEgf4wwScYgVBXXIetEGCdmeqHcXY95Tjy8=
Received: from DM6PR07CA0080.namprd07.prod.outlook.com (2603:10b6:5:337::13)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 03:41:13 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:337:cafe::43) by DM6PR07CA0080.outlook.office365.com
 (2603:10b6:5:337::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 03:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Tue, 11 Nov 2025 03:41:13 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 19:41:10 -0800
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Date: Tue, 11 Nov 2025 03:40:57 +0000
Message-ID: <20251111034057.3177641-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
References: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e4a184-f5f6-42a0-76a7-08de20d42955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0Q3SjNIbDVxSVlPZlIrTkY1OEdpRldSbDdaN1N5ZGx5VHZMNy82SG9RQmlG?=
 =?utf-8?B?cXFJU29pbDIxK0kxck5aSlJqMXl2eDVEWTBKYitIY1ZYTW1KYkJlckNKZFlL?=
 =?utf-8?B?NXFRNHRwb0pJYWlJZDQ4SWFmbk1kdXJDUzByc2FIRUhoampJRjBudSswTys5?=
 =?utf-8?B?WmhjdjdQSU4zTWNVRERYT3UwaUdoT1BlK0JlVmViRGtKenNwWlo1UGJySVg2?=
 =?utf-8?B?UzlEVnl0eGFyOUxRSGx1Nzk2amZiOVhQSXp4dXlBMVljRHpEOHNLa0VNRjZx?=
 =?utf-8?B?SHV5V2pyRVNuWjBpcW9zeG5BUm1PV3pUS1JpSklQMTlLVU9jZnRSaHc4QThJ?=
 =?utf-8?B?cWxWWmZZK0VPRlc0eThjQTJFQWVtckxiRHpySkh4OFlLajg1OFZkSjZ4ZTQ5?=
 =?utf-8?B?andFR2NWV3FkSENJeGtqUEdnZFRiZWZnbWlwcGhJbVFRMHViU2Z1VVdHUkIz?=
 =?utf-8?B?cnZ6ZW5EUVFocDRhM0Zxc0pHT1ZIOHcyVW1keWlVUGtMVmE5VlNMR0tsWEpl?=
 =?utf-8?B?RTZicTUvU0ozdnY0cThKVGM0R0QvOVE0cXFsOUFhT1FFVGxGOVFNbE5ZWHBU?=
 =?utf-8?B?eklSWG1oZWRxaVc0VzEwd2J4b0YydjhEUDIrUml3dDg1RjFjNlVJMkdCUVJm?=
 =?utf-8?B?NmxJOGxDQiszWGNEL09EK3NaZzlSdnZnSGRPc1hpU3BKemVXaHJJaGkrZkRP?=
 =?utf-8?B?UG9MRVF0RG80VHlvTVJhdTNqS25wKzBwcUNjQkVXcDV3TW85TzkxVkVxRk1v?=
 =?utf-8?B?YXZWdkxYdUNoNEJtcmlETWF6bExjaXF0SUZTNnMvd05kcnpQTldIZG9FVlNw?=
 =?utf-8?B?VmJ6aFU2SkdTcW1ieVVjaXZ5RmtYQmRxcGxHWU9JMjlxVVptdFRZM3ZFTXRF?=
 =?utf-8?B?aThnWWp1bnJ3c00wdHZxa2R0VWdVRGtBdEVVMWxBdDNndTNReUUrSXdUK3BW?=
 =?utf-8?B?Y1NZVzUzMTlDd0psQmFvTlhPd241NmlzOFpKZGN2dFRjb1hDVWlFd0dmSWN4?=
 =?utf-8?B?a2JtaXhPS3RBR21OK2lDQlVGSERQTzAyd24wMW5aenZKb2lLWGJmaXNyL3gx?=
 =?utf-8?B?MGdoRjRnZ0grS0c3OG1PUjZLMC9iSXFlUmlQZjhYczJyMXBCcm1LekZ6RHQx?=
 =?utf-8?B?WWllWStDdno0R2JjckR5VFluSS9yd3hZMHpVcXlhcWNQd2g0dUxiaWNHeGlL?=
 =?utf-8?B?UGFOc1pCZzNOSjA3MlR2ME5UMVNiN1ZuUVdZd0J6QmloRXFIVEV3REVScmY0?=
 =?utf-8?B?SG1RcXVXNXZkcE1EU1Q1RU5SWjNuVW1oeFJ4V2gvVFFaNGkrVUlPRCtrSTAw?=
 =?utf-8?B?c0w3V3FkelFvWGJJc1R3YnNnOGpXUXljT1I1b09wZnJaT2VtbGVRVHJUWnRS?=
 =?utf-8?B?OHVXc3d4V3FFRitxeHdVYW1IeVMweDVLM1ZxTFhNQjhVVzZYcmVGS25oQVZ3?=
 =?utf-8?B?ZWh2YVNRbTNhTU4wb05LTnEvUFp4R0pWd3A3K3g0c0ZNQ3hMM1Q3SnZwRFQz?=
 =?utf-8?B?eC91N09oZVpqRFl5MVpWMVpPZlVCbHlxSXFHMGVoOXRjd2NHYk5OcUMxUnB3?=
 =?utf-8?B?L3Q5ZXVaWmRXWkgydGpSbmhqbzVUZGRYZEJjN1FOamVWYkdGTm9KZ29EMEFL?=
 =?utf-8?B?RytFQ1BUdkJ4N1JwaWdXZXJvS1JCZ2hQWEhDV2ZVNXdJSmxtNllBY3Q2R3lr?=
 =?utf-8?B?SXZhcnl0Q3Q3SVpQMjQwYWtjK2FoQ0lyMnlyckdYc2tXNGl6VW5uNEQ2ZHlP?=
 =?utf-8?B?RlZFN2xCTlFrdHdRRm44dnJIV05sSUt4MXBkRVZ4M21LMGpqOUt0SFFybUow?=
 =?utf-8?B?bnJaY0ZaVGFZUVRKK2xMcHZwVFFlbUxRTWNTY3RsTVY2SFY5a2QxUXZTR0ZZ?=
 =?utf-8?B?YjQwS0JZTEdJclg2aEdjNnpiL1QvblgrU2RoS2UwZDhJYk1BcTlCYlo2bjZz?=
 =?utf-8?B?T3lsWWY3M3J0dVA2V1E0ekJ0ZVExQzRtSUFRdGdOQXZRRTRvNzYwaWNnaWF4?=
 =?utf-8?B?am9WbWJzcnFBOFNuaEQxN0VVcEgxdkF6RXRpM0kzVUtIQ0trUUFSbFQrdTVQ?=
 =?utf-8?B?ZGRmSDJVTG9Yalp5VVJZTEtZY1FHVElIYmhwRC9lYnlkOVhOTTlLMmRkVG9H?=
 =?utf-8?Q?81T8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 03:41:13.1266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e4a184-f5f6-42a0-76a7-08de20d42955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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

v2:
 - Updated CQE opcode check logic — replaced XOR with comparison
 - Renamed variable match to sw_owned for clarity
 - Updated CQE ownership check order
---
 drivers/net/mlx5/mlx5_rx.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 420a03068d..ac663a978e 100644
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
+	const uint64_t sw_owned = ((value & m) == v);
+	const uint64_t opcode = MLX5_CQE_OPCODE(value);
+	const uint64_t valid_op = (opcode != MLX5_CQE_INVALID);
+
+	/* ownership bit is not valid for invalid opcode; CQE is HW owned */
+	return -(valid_op & sw_owned);
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

