Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB972CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 18:43:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEC5640280;
	Mon, 25 May 2026 20:43:11 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013047.outbound.protection.outlook.com
 [40.107.201.47]) by mails.dpdk.org (Postfix) with ESMTP id 145AD40144
 for <dev@dpdk.org>; Mon, 25 May 2026 20:43:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6QypsZzWsVq74kKyl9FAY6P7hIshqmR/VEeBlO6WLcFNkeAMn9ABsiBo4Wum4xD2e2BY+II2WTxkSOErHo99k8csR5M2SOQu2g4WCvEA4iHJcvrQ9m2YfQHgUZdzuEqvjE240GQIL/7o1nlo7CtCmxiwmOSfydzEIBZO/1gxtd7YkzBiM6e/yWIBUmp9wjjp5o0QySTkIvUdJMZ/zym5diY3s0oYDgE+EGKxKvWP/yczjdLS2U0NwAwG7qRa8ES1mxyI/VZk0fiGmZSJF076l+pkUJQgUUoCA4PPeI4bwr636NaRht1Eog24XkVLQ0P+3t7TSS70Y8GPzGTosj12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM6mutvzOKBbJpI+wgdrcxXqlYDjKdhv81d41on5LXU=;
 b=Iy7jQMSRlDveIxPpUwB4OwEawKB6gqcjD5egpBkVxd8ZA5DIJKWunKLpAX2yvYkAzIRbBjA2JlYR1vxYxUVq/N5J4JbC2txTRdsMf/Q3QqZNrqyzhJmECYkj471jFVc4fmHKNUo6OnSEooQcyFc3tlJpTImpOHH5Na/+FcwCNwTBS69zvA2K04Hu7TH5yl0RiNDzK5CgB8JxJt4XIPMCQFTFjmq0+LckNyp7q0LQSAgrNnmA5eBxH6Za1ffM2INGnDRIz9e4sczvxeC/+BIhxhOMTdqeb79rvnU0CO1DEel5+hYYMbccDj5M5TE6wCGkRVaMwnSwmuOpGC39t3ggIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM6mutvzOKBbJpI+wgdrcxXqlYDjKdhv81d41on5LXU=;
 b=geHx+f5nxlBHyRVekB9Vw7Tq7/TxYE45MGEnY37q8UbhNkkH3D/rbZbAJdoL3qN6e6inPd7GQ5AFE+KafVWgtXqzw6SbFfpsVyAos/I1I6PzDx3QRLCOesxVXK16RCXo4lhcZ6tfkzgQVz0YP3mdylTlpuvLwkL+z/Md7abPXh0=
Received: from DS7PR03CA0181.namprd03.prod.outlook.com (2603:10b6:5:3b6::6) by
 MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 18:43:06 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::8e) by DS7PR03CA0181.outlook.office365.com
 (2603:10b6:5:3b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:43:06 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 13:43:03 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 <Selwin.Sebastian@amd.com>, <david.marchand@redhat.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v2 0/3] dma/ae4dma: add AMD AE4DMA DMA PMD
Date: Tue, 26 May 2026 00:12:41 +0530
Message-ID: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fede7cf-f82c-43a5-d1a8-08deba8d75b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|6133799003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: rDdJTK1edyd0tD3V2hwWU2PQcw1bYcaE7yyIoomI9Gfd15kTWSpPsIru7S28ePbIIO/UGMcpe1AsjEN+9TOrC60ALDLfdzHvpsnq8obzhTfYc+CTOFEeH/A2a+GTZEjI4Ef/K55oDkqW3ONjfAMs2HHcajm72rOVVUHjh2q65fyCcDCD409dZqEToVx+6pATcJu3nmaHSQhXr1w6hLLkvRRsNHGwpy0uizP2L0H4c5VnST+cF8HFOv3vOcb1sICh8mEWWiPF7Hv86B1+3t6CI2ntDM1TMPk4Wf7v+NbSQx2IvVs7WZDi1v2fod3D/6YQKlbG14pJa0JJ0n257R0tQcmhcj40tO5pQgnalP+s1cHNX5sPI3xI0NQb+y4FZRzwc9My0hFD7ee9hwVoC3g1UjzBr1qAkRbQCJIt6RZ0WUxLa4bwUZL+TuZiDxcfYovQpcKYOJuiV7vjkld8DOVBPGV1UR6Ptk12FgebSmFCkcw2MSPpfmryoh1djaDSVZn3F05tWYvQktkkiL/xmqA7sGiMxA2pej2DTdLJwMc+iWloMrKL+V0P+Fn6/eAa7i/HWtxImKMyeH3RPGxQ+3PodiSmX4/ET4Qf4jVHKRO3n3vH/hFn4ungg+yu2dHzaS9YaiQ1xV4e3HyQP0nYS1iFudF2lp0o653eIZ90YlprI4+usbaAqJyHrqbr3O3Qf0oOehB+gIE/KI7oOASVZ9URASXnXAUyMMRrRN8KbT3AfGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(6133799003)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KGOCvK5nDu2PKz6RD9exFIttRLG60W1K6Ze7uyl2eBjdb7h2ZVvYO2X5sC8CUanmfkCO0qu2u7Kc5w3qXUzpvtg5x0YChremZ5eCPHJljXr6n7TLcPur7INEKGvwRr/mZi35zzPYv+UvCy6sr78mUA0/Mjw3W7Tyb2cvxvwE5tVoE2NmD8FG/dV4SBs9ruqjrBf7VmT9gmmAmfscIjZrEmJtLZknLPD4j/iN+XpSsP0hkKLvfzhZJNzcqoiKUwq/M8gu4dwm+iTvRwv7X1rCdtTDxKpafcO3eXEBB04g5dE/6CSE0wIERFRWUypJZp2a9f+3JLtiYMyVHbY1hqVGnIg8OC0vCn0eewvSSYb2kGxjRTWq34DFeIVnVpexYq3nvLg5imeWjadX8lx/Zi4p5k2E/0dNE8SI3ItTc3lF4AaH9jYXymIpffIpJYsafNFn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:43:06.0403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fede7cf-f82c-43a5-d1a8-08deba8d75b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
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

This series adds a new dmadev poll-mode driver for the AMD AE4DMA
hardware DMA engine. An AE4DMA engine exposes 16 hardware command
queues, each with a 32-entry descriptor ring; the PMD maps each
hardware channel to its own dmadev with a single virtual channel,
so a PCI function appears as 16 dmadevs named "<pci-bdf>-ch0" ..
"<pci-bdf>-ch15".

Driver characteristics:

 - Memory-to-memory copy operations only (RTE_DMA_CAPA_MEM_TO_MEM).
 - Completion is detected via the hardware's per-queue read_idx
   register, which the engine advances as it processes descriptors.
   The descriptor status / err_code bytes are read only to classify
   each drained slot as success or failure.
 - vchan_status reports IDLE/ACTIVE based on HW read_idx vs write_idx
   and HALTED_ERROR when the queue is not enabled.
 - depends on bus_pci and dmadev.

The v1 was submitted as a single patch.  Per review feedback the
driver is now introduced in three logical patches, following the
pattern of the recent hisi_acc dmadev driver:

  1/3 - introduce driver (probe, remove, per-queue HW init)
  2/3 - add control path operations (dev_ops)
  3/3 - add data path operations (copy, submit, completion)
---
Changes in v2:
 - Split the monolithic v1 patch into three logical patches
   (introduce / control path / data path), mirroring the
   structure used by drivers/dma/hisi_acc.
 - Fix checkpatches.sh warnings in drivers/dma/ae4dma/ae4dma_internal.h:
     * Use RTE_LOG_LINE_PREFIX (with RTE_LOGTYPE_AE4DMA_PMD) instead
       of the deprecated rte_log() call form.
     * Replace the GCC variadic argument-pack extension ("args...")
       with C99 __VA_ARGS__ in the AE4DMA_PMD_{LOG,DEBUG,INFO,ERR,
       WARN} macros.
 - Move __rte_cache_aligned to the "struct" keyword position on
   struct ae4dma_cmd_queue, as required by checkpatches.sh.

v1:https://patches.dpdk.org/project/dpdk/patch/20260518181856.1228373-1-raghavendra.ningoji@amd.com/

Raghavendra Ningoji (3):
  dma/ae4dma: introduce AMD AE4DMA DMA PMD
  dma/ae4dma: add control path operations
  dma/ae4dma: add data path operations

 .mailmap                               |   1 +
 MAINTAINERS                            |   5 +
 doc/guides/dmadevs/ae4dma.rst          |  75 +++
 doc/guides/dmadevs/index.rst           |   1 +
 doc/guides/rel_notes/release_26_07.rst |   7 +
 drivers/dma/ae4dma/ae4dma_dmadev.c     | 738 +++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma_hw_defs.h    | 160 ++++++
 drivers/dma/ae4dma/ae4dma_internal.h   | 118 ++++
 drivers/dma/ae4dma/meson.build         |   7 +
 drivers/dma/meson.build                |   1 +
 usertools/dpdk-devbind.py              |   5 +-
 11 files changed, 1117 insertions(+), 1 deletion(-)
 create mode 100644 doc/guides/dmadevs/ae4dma.rst
 create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
 create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
 create mode 100644 drivers/dma/ae4dma/meson.build


base-commit: f724d1c0d1c1636b9c171c34db3f17c3defaa2f3
-- 
2.34.1

