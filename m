Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61183C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78CBC40292;
	Mon, 16 Jun 2025 09:29:38 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by mails.dpdk.org (Postfix) with ESMTP id B05C74027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:29:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFnxNpIsnVwUHf1hrVTSg9m5sjlDDhBeYpTJ4quw42n/563BZ4qsIjuSkc9ln1eAoX59yP5XxilzaIiLHv6/sYJKbSjZmB22NwfoklpdaURXHVPLVEeKHO1VTKTy8cPyhzx1KUWRNOJSm0izamzaGrHvTx6F+GCS1LqMO4/p8yyQ4LlkC+McZ85zTvXTBC5CZytoM5ARR4vPduIpJnh5strDXMIpxvZxxPBOzXhjY2dh4Ad8hajrVsa2DZkdNpoWVLa2dVbHmtwDxoCbgpUymbxY4bIJ0RkccJOXjNhZFixnvTma5UWhhWyow7iLUn98j5N5GzQFawl/CKbVcdQB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk8/VcpWL59Ik5/ZFDinDCsXlKJKDIl+GymvUdsQEWA=;
 b=d2BlrvM1FJPkOFLHCv1xQZ7rlP4xaA1JBmq6PZ2BYvQkPrMBfBfWBAph8NgQf/JdUzfeODvVryr2xBXsUWVcdGJHqx5I/wL8CPvn5OjTrTKc8P+z4PqkDbSxzdSIEyLyZg4XoGeSTunbAzVazE0akzj/AKzbZdeP0o3/EdeyUhpbu+De+66wr4bBWiT0m2H8OSA4D8M9DNJ5PWuSBs+WXAgRVc1cTy9f6fI26gqCZJiUDuCqfRQp5CPNxCWi1LCfKE9yOy8Rs1GQguFGFGSA+wwYeVlX/1JaduCfjCw1b4v751L2gT/Mvqli6jEa5FKXnC/dy2r61uWZsscsN8KXnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk8/VcpWL59Ik5/ZFDinDCsXlKJKDIl+GymvUdsQEWA=;
 b=SKBIdWy6r8IL4Jkr3mZyu1NsLQ9XLLV+SVM7ic5T3NJXDiH8uz0ijUUutoLPcL14XGcpm8RaJ0ZE3wwphi1VyqXzwodW98oyjtbOuVplrXph6S/IHnwtCjLQtAxibQpN8PUQDDKGWHKlOy+ADH5Vt6RayvR/hZdqLvNmm5HJPMdHdKvzcKFhjO3EkK04z/6JlRMw2W04QDCsThDTTJJNNfqIUo3VgW21f33lF8WLtm0SiE+zcpo/xIQvrrctg/3t6trT+wDat4QHs2Woa+tPbUcls7n2R25cBAQyBt3latRFVUg+pSrBFCReVgOKDg0rEEAoSBmbht8qv50R140AZQ==
Received: from SJ0PR03CA0287.namprd03.prod.outlook.com (2603:10b6:a03:39e::22)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 07:29:31 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::a5) by SJ0PR03CA0287.outlook.office365.com
 (2603:10b6:a03:39e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 07:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.0 via Frontend Transport; Mon, 16 Jun 2025 07:29:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 00:29:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 00:29:15 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 00:29:14 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>
Subject: [RFC PATCH 0/5] Introduce mempool object new debug capabilities
Date: Mon, 16 Jun 2025 10:29:05 +0300
Message-ID: <20250616072910.113042-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa3c3a6-d0b2-4826-0c16-08ddaca788b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?apuKMeJ1h07XNoad3qxfVuwAQfwP+7pcBKH08JdRMqydCHWzHQE3VT8If3JJ?=
 =?us-ascii?Q?0Adnic4Z7ByvH1TvzEQdaz4t86dcK4ipWXKMoCk9EWnKGjq7rXW52J4kZ+Zn?=
 =?us-ascii?Q?xJQiD3tq5I+jloWa+1cf21dKLGvx+XjtPTomO5Np+Lvmaz1ra2TSjcNFzU2V?=
 =?us-ascii?Q?d9+UN1xIOQdpkIjZBnb1iwFk6vVemJa6hQXguZn5X6i7Z//Nzb6XnuZcxS4k?=
 =?us-ascii?Q?Lhdnc5BMFJ3+AsANMtb63ws8JfbLbMSYgbzr+6tcNB45zkjoHVZOdLXqENEg?=
 =?us-ascii?Q?YwFAzDL42e0u638QGxc0BuJzs+D9kN3Q8/To22aWe1BqgpShRZ5UPw9D6eoA?=
 =?us-ascii?Q?pmbAlloJzJswjWcAgwoKdJ0OHHuPTrYM4z+xC3XFU0pEZTQL6rFMsFFRD2Lg?=
 =?us-ascii?Q?DrUalc5jC7d4vBbIe+MifUwSn4F8Gmb9hnX11FMB4RWY3avpCsS+bkgS34n4?=
 =?us-ascii?Q?tP31W2FM2czvL1/7AJ6BmyydmBZcxk+bqAC8AUDg77xASDn4XHhuIkLM28eC?=
 =?us-ascii?Q?um8kPzM/HRu1uDFCdIze36u8JjWxecfHyiaasYf6CS3C4CE7uS1f1B8YcX1Q?=
 =?us-ascii?Q?/ocpzKRW0OHy50oPQb+jUG+9Q2UA5AsteT6wmdO3C/sZDSDZZl4v3PAWTyu6?=
 =?us-ascii?Q?6s2FQwoXpj2NFzWma7q42qVun6CENIIjY7YEqRCnd1ub4u42s0RJoCp5ej2h?=
 =?us-ascii?Q?pf4PsToSf4EbLr3b2kozBBIrUegC+vDGi3rvCmM1YD+Pv7BSOvyQVhZQXrxs?=
 =?us-ascii?Q?WKzmI4FvBa+TdT9Mbk8mLUS/YlPWQoTSotBNqHYxqURmIdSJPDs/LugTULAY?=
 =?us-ascii?Q?ZEwIaGjmDLNyvZh3dXr3sLER2Aed6YA9G3ZegJF1lvFKIYJsmPwSWZBwwBGB?=
 =?us-ascii?Q?TfDVZiWAt0RUtRaFYagehJbwf4T8GgvB6T1Dd5/hHxfNeqGUs8z9Ij7qjHN+?=
 =?us-ascii?Q?T5yQaYPlO1Z5XxkgHoh5BbD5DiRw6qMeyts0IVRtfo+0X4nTh3gsacok64Bd?=
 =?us-ascii?Q?StT2Ua3LzahlnktJYvAGs0cXkNkc99eKPb9tKSGBBzpZCNFblOMwT8dEuBvy?=
 =?us-ascii?Q?tBa4rvpaQhKCPF5cqGoD6k+kMm+TBIPqhma309HBDGlDS7tvQhfZch0mVpdF?=
 =?us-ascii?Q?D5wt/xReMnfD4KWJIa8PHajL3A8Kk2oidGDs3zcBATAJa3Fbdz7YyKUPkax5?=
 =?us-ascii?Q?FtRxfxA1r+ba5UbqMahcMeiQRqYn/b7meQlT2pA5MrpvrYSGiIflQrLoIxwR?=
 =?us-ascii?Q?oXV1mqFXrAqtlEq22++BOEbouB+D+DQt6TBu0WhHjKmzNYYsv1I4CMf2bCLw?=
 =?us-ascii?Q?4uDLDBqfkRKaDtMTS+juHWEZKkYCj57UcxqB9LojBVNjTx7VPeoJBRU+7eyz?=
 =?us-ascii?Q?C39iNqpwAi6fkYyvtRLOZuLips3UryplG6OUezapgwWcwvahU6ePqkVsBzfi?=
 =?us-ascii?Q?4jeBXBUpQZQQsA2owaIn/vD9P3PYnJAOLtErwjReLcRe55WhyjWgCp/sbckK?=
 =?us-ascii?Q?WO9whOZFjsJFA09ThJOMQ+1bZyN/dFC7JH7P?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:29:30.7624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa3c3a6-d0b2-4826-0c16-08ddaca788b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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

This feature is designed to monitor the lifecycle of mempool objects
as they move between the application and the PMD.

It will allow us to track the operations and transitions of each mempool
object throughout the system, helping in debugging and understanding objects flow.

The implementation include several key components:
1. Added a bitmap to mempool's header (rte_mempool_objhdr)
   that represent the operations history.
2. Added functions that allow marking operations on an
   mempool objects.
3. Dumps the history to a file or the console
   (rte_mempool_objects_dump).
4. Added python script that can parse, analyze the data and
   present it in an human readable format.
5. Added compilation flag to enable the feature.

Shani Peretz (5):
  mempool: record mempool objects operations history
  drivers: add mempool history compilation flag
  net/mlx5: mark an operation in mempool object's history
  app/testpmd: add testpmd command to dump mempool history
  usertool: add a script to parse mempool history dump

 app/test-pmd/cmdline.c                        |  59 +++++++-
 config/meson.build                            |   1 +
 drivers/meson.build                           |   7 +
 drivers/net/af_packet/meson.build             |   1 +
 drivers/net/af_xdp/meson.build                |   1 +
 drivers/net/ark/meson.build                   |   2 +
 drivers/net/atlantic/meson.build              |   2 +
 drivers/net/avp/meson.build                   |   2 +
 drivers/net/axgbe/meson.build                 |   2 +
 drivers/net/bnx2x/meson.build                 |   1 +
 drivers/net/bnxt/meson.build                  |   2 +
 drivers/net/bonding/meson.build               |   1 +
 drivers/net/cnxk/meson.build                  |   1 +
 drivers/net/cxgbe/meson.build                 |   2 +
 drivers/net/dpaa/meson.build                  |   2 +
 drivers/net/dpaa2/meson.build                 |   2 +
 drivers/net/ena/meson.build                   |   2 +
 drivers/net/enetc/meson.build                 |   2 +
 drivers/net/enetfec/meson.build               |   2 +
 drivers/net/enic/meson.build                  |   2 +
 drivers/net/failsafe/meson.build              |   1 +
 drivers/net/gve/meson.build                   |   2 +
 drivers/net/hinic/meson.build                 |   2 +
 drivers/net/hns3/meson.build                  |   1 +
 drivers/net/intel/cpfl/meson.build            |   2 +
 drivers/net/intel/e1000/meson.build           |   2 +
 drivers/net/intel/fm10k/meson.build           |   2 +
 drivers/net/intel/i40e/meson.build            |   2 +
 drivers/net/intel/iavf/meson.build            |   2 +
 drivers/net/intel/ice/meson.build             |   1 +
 drivers/net/intel/idpf/meson.build            |   2 +
 drivers/net/intel/ixgbe/meson.build           |   2 +
 drivers/net/ionic/meson.build                 |   2 +
 drivers/net/mana/meson.build                  |   2 +
 drivers/net/memif/meson.build                 |   1 +
 drivers/net/mlx4/meson.build                  |   2 +
 drivers/net/mlx5/meson.build                  |   1 +
 drivers/net/mlx5/mlx5_rx.c                    |   9 ++
 drivers/net/mlx5/mlx5_rx.h                    |   2 +
 drivers/net/mlx5/mlx5_rxq.c                   |   9 +-
 drivers/net/mlx5/mlx5_rxtx_vec.c              |   6 +
 drivers/net/mlx5/mlx5_tx.h                    |   7 +
 drivers/net/mlx5/mlx5_txq.c                   |   1 +
 drivers/net/mvneta/meson.build                |   2 +
 drivers/net/mvpp2/meson.build                 |   2 +
 drivers/net/netvsc/meson.build                |   2 +
 drivers/net/nfb/meson.build                   |   2 +
 drivers/net/nfp/meson.build                   |   2 +
 drivers/net/ngbe/meson.build                  |   2 +
 drivers/net/ntnic/meson.build                 |   4 +
 drivers/net/null/meson.build                  |   1 +
 drivers/net/octeon_ep/meson.build             |   2 +
 drivers/net/octeontx/meson.build              |   2 +
 drivers/net/pcap/meson.build                  |   1 +
 drivers/net/pfe/meson.build                   |   2 +
 drivers/net/qede/meson.build                  |   2 +
 drivers/net/r8169/meson.build                 |   4 +-
 drivers/net/ring/meson.build                  |   1 +
 drivers/net/sfc/meson.build                   |   2 +
 drivers/net/softnic/meson.build               |   2 +
 drivers/net/tap/meson.build                   |   1 +
 drivers/net/thunderx/meson.build              |   2 +
 drivers/net/txgbe/meson.build                 |   2 +
 drivers/net/vdev_netvsc/meson.build           |   2 +
 drivers/net/vhost/meson.build                 |   2 +
 drivers/net/virtio/meson.build                |   2 +
 drivers/net/vmxnet3/meson.build               |   2 +
 drivers/net/xsc/meson.build                   |   2 +
 drivers/net/zxdh/meson.build                  |   4 +
 lib/ethdev/rte_ethdev.h                       |  14 ++
 lib/mempool/rte_mempool.c                     | 111 +++++++++++++++
 lib/mempool/rte_mempool.h                     | 106 ++++++++++++++
 meson_options.txt                             |   2 +
 .../dpdk-mempool_object_history_parser.py     | 129 ++++++++++++++++++
 74 files changed, 571 insertions(+), 4 deletions(-)
 create mode 100755 usertools/dpdk-mempool_object_history_parser.py

-- 
2.34.1

