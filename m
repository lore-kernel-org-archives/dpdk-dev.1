Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1F6FCEE91
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:00:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 247834021E;
	Wed, 25 Feb 2026 13:00:09 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71]) by mails.dpdk.org (Postfix) with ESMTP id 0DF89400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylclIyBmYHb9FcIlBDpBgqoaouVAcxGApobvaKV7yWeh+rLCT0fiGaBYitEOPqYDTX8Q9TNcjIK6BLn0tifhvvG3cKTEM0GhphDdHaOef3ceOY1mz6gRSaJG6hsp1rR3vXmA4/lhHHgqzOZ4JYVu32rnGDL70UB7Sap37lmpZEzB6kb+n5zbgA9G28Fg+dHjJOjlygXPOb7rG95o5KIYQ+Vc8LKjhxF+wdFMsgW1BsERkCA1ukRbN8X4kjU/1YnaaICUlZcwP+XteLSeXXfbegIQ+Z6ZLDca1hZddyHMoEqUPtSCSPd4WNNL1C3deo7Mv/79w9DUpD+OPnCiMAgB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfwLGGziIZKUD3yS0/qlw1FH0b/djwgGfuWXaj7+0q4=;
 b=X4j1aJTs6zIjPNGrRooE9O5/MC3jYNvf5sXaNow72fIsejp+TRsGtLeXm1ujWrLANPxo38Ssy6ksJCOD1Qrdw5i974e6ezj60q47UhC0PFZfhX1Jd+WiaNv82ByYkrM97/tWBv4wbQpaPG3NsPsdAyBy14aeZvSGxftnQ3ccA2Qwz+gr0DUlaqXmBXnXcEoZmGOGO3FNtJ7STr0hQWpbZZn+XnteqDTtFpldInCKoKyMTuFTX79tKLcY5SfCJW15yWl9djSqEdjbM0N2+cWCjWD7j3i/OR/VuCf06jGzkLG5mV1GBWsOlI27vsNGSakbKEEbtCWPBLo7JHS6Qy+kQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfwLGGziIZKUD3yS0/qlw1FH0b/djwgGfuWXaj7+0q4=;
 b=laQdQ7JXUC3ChpIJ5K5lq55nQm4HaQB0PMH+XpljhfsZUbvqN5tst0MjZT+/cd2AyxAVjPDUAb3VgXAP7CjXOF2cXtzVlOvIna9gkNvMSOZ7jKJHCPq1vg1LDH30rYufO6TKjqXezVe1Hj8CorzvkQvqm/668nitYducbYkmV+pITkuCYTvb7wCH9EezJzFFM5No5We6xAnm/RtaIw7CJf2g1iDrI9wLoxI3BqH4Ku/8Z8eCNPcyhoG1cYNfTYSeqH3sY7RqysDMBti4cRtNpMfpsBKve1zdgaOA1bo7WIpeMnbHLzmj2lb6dEHhMnl6Rf8SBWmgfhD63MRRi2cGyg==
Received: from BL1PR13CA0313.namprd13.prod.outlook.com (2603:10b6:208:2c1::18)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 12:00:03 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::26) by BL1PR13CA0313.outlook.office365.com
 (2603:10b6:208:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 12:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:00:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:48 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:46 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 0/9] net/mlx5: lazily allocate HWS actions
Date: Wed, 25 Feb 2026 12:59:08 +0100
Message-ID: <20260225115918.233843-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c5e0ef-aeb6-4019-c544-08de74656880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: pKfGBPgR28EfqqsjAytedByBkKFw9KsMyWbIXWQjy7GSUoK1NykxKbGvyBSdmHkRLRqZ+yqnEdbiN1RNqqFfsV0aidjDGKt5nBrLeWJQmr661ctcVGLMydLvmnpKwRAZyk7gqkRAkn98S8iW7QE3waI9NYmmw5DIfOdmOHZhJkawZrK9vHnNxFCYsIFve//Bmmh/xDlXViAF/ntPR2fqlqalwq2dj6bGdoohgiOj/nA1cy8SpiD/rG3VU+fBFZao1osArYs3jhbl6uDPAGDB+89OfxA9i5fpNTFHv7iIDnqWb03FFIp/6VJkgYT2Wpgfy4PD8PH2pqVO7TqdD2wk5c8LRbXVl3KzgyhRTyPEWE8HFE7sWYhCESLwtmFpITJZ+7yQdtIP1XQ/fHwwNkAmt/+r6XeWcvW1ZWTR3I8BlHd5KMeK7ed9QiEuV+woGRFR7RhkE8sROwncVpj9ra3xNvOg/kyD9rqvCrVPpkS5os5U8mXxEjDRgMaB39GnlpbN3yHyttf7Ybw+sD0SuMSWyGaYqXvfmuyDPEcS+oLHiUd4c5MDAMrKOSKZoWkPqD74woZQo/JcYyxcNoSxLGSk4x2hHvtP/Y1Mvxty7tJ2O1/ykH3/OMB6onKxvUybKgtDa7mW7QmVDXlhbi2lPqUWF7K3rPIdjrzBR5ntp+IfokWvmnPRaLT0wGmTQIXwfxAvm1YZ/jfD6db3mM7C6EFq/iqvbAuFZ7NkiXgVxODfbxT+hTmF5UJEMGygBq+WWhVJ7whbboS5T+IAB/kecL8RL7+m+Hw3q9tAg33SsDQxx+6PL7LhFs6A6Fek8jMX7HyGWqyeaTd2JbvH9k1nAi9JkA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0GCSZmY8IgOXxzP1NGCYftZXb6QS61dU6e5Y+54R/j0j1NLPMDWE5U/LQirLbMqtHO+Z52oVecEfRVxj3w35boTHbkSm1G4RYzmiPo7opuUXvciidw3Hj8K6AIqRTiSo8hRCv96+MlIBXjkqENXjyzC8fU7yCAXJZJiKnESPkANMpU58o8CCTzh6c+m73thHISpu7vbkaXHWpwFpkNiK2qajeQ2HpAw+FsnaPD+uJR+ArK2j4CHNQ+LnccAaKinVXe9WM3qAtBXsdV13j67e4uPsR89iig/5OyNqE2W6MlseuNfCXeANgv3vqRD22XwamTjX2GW/Ex3MDihp121cY99ILvDBtJh6EV/I1CRTw+fCQHyvRUZbMwzWTj21AyVG44Dl4PpK6jYKlrBEnE60hA+FU2grtRtKWoufCFU5WDuzorrOIYtpTMz6SNJizFtH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:02.5047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c5e0ef-aeb6-4019-c544-08de74656880
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
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

In mlx5 PMD, HWS flow engine is configured either:

- implicitly on port start or
- explicitly on rte_flow_configure().

As part of flow engine configuration, PMD allocates a set of global
HWS action objects. These are used to implement flow actions such as:

- DROP
- MARK and FLAG (HWS tag action)
- OF_PUSH_VLAN
- OF_POP_VLAN
- SEND_TO_KERNEL
- NAT64
- PORT_REPRESENTOR (HWS default miss action).

These actions can be allocated once, for each flow domain,
and parametrized on runtime.
Allocation of these actions requires allocation of STCs,
HW objects used to set up HW actions.
These STCs are allocated in bulk to reduce amount of syscalls needed.

In case of global actions listed above, these STCs were allocated always
even if none of the related flow actions were used by the application.
This caused unnecessary system memory usage which could reach 4 MB per port.
On systems with multiple VFs/SFs, memory usage could reach couple of GBs.

This patchset addresses that by introducing lazy allocation of these actions:

- Patch 1 - Redefines mlx5dr_action_mh_pattern to use rte_be64_t instead of __be64.
  This is to prevent compilation issues when mlx5dr.h is included in new files.
- Patch 2 - Add helpers for translating HWS flow table type to HWS action flags
  used on allocation to simplify logic added in follow up patches.
- Patch 3 - Introduces dedicated internal interface for lazily allocating
  HWS actions. Drop action is handled first.
- Patch 4-9 - Each patch adjusts one action type to use lazy allocation.

Dariusz Sosnowski (9):
  net/mlx5: use DPDK be64 type in modify header pattern
  net/mlx5/hws: add table type to action flags conversion
  net/mlx5: lazily allocate drop HWS action
  net/mlx5: lazily allocate tag HWS action
  net/mlx5: lazily allocate HWS pop VLAN action
  net/mlx5: lazily allocate HWS push VLAN action
  net/mlx5: lazily allocate HWS send to kernel action
  net/mlx5: lazily allocate HWS NAT64 action
  net/mlx5: lazily allocate HWS default miss action

 drivers/net/mlx5/hws/mlx5dr.h              |  19 +-
 drivers/net/mlx5/hws/mlx5dr_action.c       |  26 +-
 drivers/net/mlx5/hws/mlx5dr_pat_arg.c      |  20 +-
 drivers/net/mlx5/hws/mlx5dr_pat_arg.h      |   8 +-
 drivers/net/mlx5/hws/mlx5dr_table.c        |  75 +++
 drivers/net/mlx5/meson.build               |   1 +
 drivers/net/mlx5/mlx5.h                    |  21 +-
 drivers/net/mlx5/mlx5_flow.h               |   1 +
 drivers/net/mlx5/mlx5_flow_dv.c            |   2 +-
 drivers/net/mlx5/mlx5_flow_hw.c            | 557 ++++++---------------
 drivers/net/mlx5/mlx5_hws_global_actions.c | 273 ++++++++++
 drivers/net/mlx5/mlx5_hws_global_actions.h |  71 +++
 12 files changed, 611 insertions(+), 463 deletions(-)
 create mode 100644 drivers/net/mlx5/mlx5_hws_global_actions.c
 create mode 100644 drivers/net/mlx5/mlx5_hws_global_actions.h

--
2.47.3

