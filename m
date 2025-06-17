Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DD5C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C486C42686;
	Tue, 17 Jun 2025 17:43:30 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by mails.dpdk.org (Postfix) with ESMTP id A109341611
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:43:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcupy0XNOQZ/bCwmFscsQVVRkyoGUvGBho5GE3/FmPHeZBblvp5tOV/4nGq40WbXUimDQnTnN8p1HrB4TKMaRResCUJB/jLsEpIjV4NAoqmGuVIxvgPmFKgm2B6MGLXaaiP7zSYckeTbhq5jzWetVUugJJTkItKuhtqv0JBNlBOSk/nSQKW1huGmBiLuqfv8o1IkDQtuyBTBIgfOKnHbvKq23mD96n7pHy5E22ylFFMLikAJqSLJV0u3y6BwIwUAfqLlfSyNZlCOMYmJM4B52YlUANwkK9SBRVMXOx3HqLXy7D7hqS5ZvWh9/qkoBZ8NiU2GHYUWBeEZJtBMWjNRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzbrprIh+q1xeVbx8P1c7gI1LNJCxkL70j6hpm4j2IY=;
 b=Ex+HG5v7pUXZkL20rdj9insXfMzsdNlDCSSPb5wirsx9fI6C9lwnH8BNcarpK3H2Uw/jjAdCyBvmXX072ou6JNlOJJhe+voy0E/n5V8K/gINlj418iqwELhpErIOSUoTxxetMpVMBMuGeeTTHCMp69GMtXsdk5cyMXhE1TolWo5bm76ron2cVXJjGxTmSFxUwOwQstDBoUFLhPFiDwwTnX9MQfeibAxr+IsnKY4Ogr0+Vatt71fV5GxduHvlPfQIBAyqG+yBZus21NY8DtJbThVqtZ5HLCpCk8A5+M21KtSfjR+bWBP0mdbKLNI0IvfxKDHVhqvGsJT1u4u2Px5pDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzbrprIh+q1xeVbx8P1c7gI1LNJCxkL70j6hpm4j2IY=;
 b=Sl2eZ8DXNAuG0L91bc9X55w1J3bVFaRWGgaJTUGxG8PfdYdYZ5I4n6fsc/piVWfx1tKuKxfesaifN4oNx1GrGMiZjv70JEHpnUjk/VUsfqKDD/Yww7k1s5X7hBgGWMS2+EdUcl6jWVRCxS9Yjb1jQd+x2SrBhJx+w1BBbKKXWqzuxoyYDlgQHKaAtIAhaJwLTFai7JZxBq/Kqu3L/t4xXyryYSDnHPVPyMChALz87RpA9qeD6oFYwcXwyMsm3DYBut8yjc+0b6m35Lxnp20y/qaDBHoamhPn5sUQG3Xu+vrI5BB2BFsf+a8UfPSMX2k9/CvPQ4dPbv+vgyeI9OpYXw==
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Tue, 17 Jun
 2025 15:43:26 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::7d) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 15:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 15:43:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 08:43:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 08:43:09 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 17 Jun 2025 08:43:08 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Jiayu Hu <hujiayu.hu@foxmail.com>
Subject: [PATCH 2/3] gro: cross NUMA support
Date: Tue, 17 Jun 2025 18:42:53 +0300
Message-ID: <20250617154255.190093-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250617154255.190093-1-mkashani@nvidia.com>
References: <20250617154255.190093-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5f2c62-000b-4f87-e882-08ddadb5b33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nfcinxd9RaupaxT6Nk0g4D1vaLvY3gP9yphoYyGwLc/5wBubFnumWw/3vtv/?=
 =?us-ascii?Q?U6wN3HL3DDp4zkp2PQE0peJ4rGGcYyomdgQa7zpkksVe0JSaEMUbneU0RyA7?=
 =?us-ascii?Q?JY+MnKOLVm1lePbRJFBhMccAlkDIIzoCURwVHIXD2H3fE7ez4CVIrEjO/qt6?=
 =?us-ascii?Q?dfio8SqDHNxR6fGA0Uo2qvz6ystSILazgZqt8ZeS3foDDbJCg1P3KRfJBeJD?=
 =?us-ascii?Q?5Z8Bxr0dT6c58mBvxOfCWMRH7QEFQH6ikiydXKIITj4l9T7Avle7WXcOw+rN?=
 =?us-ascii?Q?fvg387QbbzLbfZcDoPCatd6kur+txk2imM71f4k1E1pHkRokMevt2uw3JuC1?=
 =?us-ascii?Q?0d12EkhZsSmG/AQ8aYoanK7xaYnrycEDLKK56C9KgmEUuLs2z1Yg+uCQhCk6?=
 =?us-ascii?Q?K8lm4r/HNhfssPd51sGHz7+aMhqm8b9+KcZ2lp88lBFg2U0vTuPpHPkDO2qw?=
 =?us-ascii?Q?evzPfdxmeWGU5QqQgQA66ofQwI65I3p6Qx7cpMyBgWfVnRYrtSXKFaOCdv0v?=
 =?us-ascii?Q?DenAfsXIa5Lt96Lq94wL6zhuYy2QvtStxVXBDmz+gdRaXUM2nvBILsuf1qLI?=
 =?us-ascii?Q?GMbB+KOBxlmon5SjPubxOFpq47am51mJpwysmv0k3V/8BbzbgxKcTeEIq2ff?=
 =?us-ascii?Q?1d3F03lI1vA25I9mVVcoZ1VYXGREQNrMU6Azfl/aQVCyvYJZoEr+B4wQ4Lvq?=
 =?us-ascii?Q?a6CL+KLODTNit064EP74+zvvnY/HntFRM9gyUgtRoCHXfUPTxCzbPwG73K7e?=
 =?us-ascii?Q?wZFO50JdCThPHBEj/zs/XfWCVLMPxHqe9mQ71mlkFAJURzB/Umvft4VXB1Hq?=
 =?us-ascii?Q?3Gi2FxT9SiPYxB74iGDgjOeE99rgHxZ/NNW4EuRKR8iJamU0mR7KOZ/7InEi?=
 =?us-ascii?Q?or0qxo7U6JIzjqnO8gC9oLF3Wn3F2pcu8oa1ME1dw17hF300oHiA6+5G3G4C?=
 =?us-ascii?Q?dmJArhYOyOV5yukkIzifI/Bn8c2bI3C/9XY7DfMjUZ6GcHokP6Tf6sS8VNXA?=
 =?us-ascii?Q?lpEN9WhLQjLBbyOf5GqfLK/YZRjd8so49QukVVZsA4k3lLaXnuPwMdVtpZ4l?=
 =?us-ascii?Q?JWqK+bWDGPencqdybpslLzyn/wETYgLZbjKYTiuaW8uVc+bN/WT3Ybgc7xn9?=
 =?us-ascii?Q?MsRA+9TcGm/HNo18qFoD6/sw50U1C7UZr8YyTEBX3xA4vYWK6dzUQsCIvD7r?=
 =?us-ascii?Q?5covI7hS6cvlL5wEqWoPh5DASSF8ZFVhESShPXonhCZKP5lPeTQQhGSE8fyi?=
 =?us-ascii?Q?9WAMtvp+GClwNpNSs2Z8m8kOfFpVqBUjbhp50QeogL7e1YNMnMKv15exh3nm?=
 =?us-ascii?Q?8larjEdJ802wtAaCrJj2Rmal42ovKGrCg7UpdT+TNrZKiegIMctrhctGw/Sa?=
 =?us-ascii?Q?pAZTRVMZFDkughpjS1Fr2r8lwhI5mpYWRk0KmbhEqJSwYZYFatZZRjzwziMR?=
 =?us-ascii?Q?FZbZYDk/EQJRExR4hxiKTb/3NbSrAPEk4VRxi7v6R6n8yu9hlHTOCU5yLIoe?=
 =?us-ascii?Q?dY+ZJBwg4Yzd6yOIEFsk1dC14sRJyCeUXakF?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 15:43:26.2952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5f2c62-000b-4f87-e882-08ddadb5b33e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
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

when using --no-numa option,
gro should be initiated with SOCKET_ID_ANY
to allow using cross NUMA.

Changed socket_id field in struct rte_gro_param from uint16 to
int32 to support negative value -1 (== SOCKET_ID_ANY).

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 lib/gro/gro_tcp4.c       | 2 +-
 lib/gro/gro_tcp4.h       | 2 +-
 lib/gro/gro_tcp6.c       | 2 +-
 lib/gro/gro_tcp6.h       | 2 +-
 lib/gro/gro_udp4.c       | 2 +-
 lib/gro/gro_udp4.h       | 2 +-
 lib/gro/gro_vxlan_tcp4.c | 2 +-
 lib/gro/gro_vxlan_tcp4.h | 2 +-
 lib/gro/gro_vxlan_udp4.c | 2 +-
 lib/gro/gro_vxlan_udp4.h | 2 +-
 lib/gro/rte_gro.c        | 2 +-
 lib/gro/rte_gro.h        | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/gro/gro_tcp4.c b/lib/gro/gro_tcp4.c
index 855cc7a71d3..2352e2d9e64 100644
--- a/lib/gro/gro_tcp4.c
+++ b/lib/gro/gro_tcp4.c
@@ -10,7 +10,7 @@
 #include "gro_tcp_internal.h"
 
 void *
-gro_tcp4_tbl_create(uint16_t socket_id,
+gro_tcp4_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
diff --git a/lib/gro/gro_tcp4.h b/lib/gro/gro_tcp4.h
index 245e5da4861..0b695f1e906 100644
--- a/lib/gro/gro_tcp4.h
+++ b/lib/gro/gro_tcp4.h
@@ -57,7 +57,7 @@ struct gro_tcp4_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_tcp4_tbl_create(uint16_t socket_id,
+void *gro_tcp4_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/gro_tcp6.c b/lib/gro/gro_tcp6.c
index ab4cd6c68bf..10e97b006db 100644
--- a/lib/gro/gro_tcp6.c
+++ b/lib/gro/gro_tcp6.c
@@ -10,7 +10,7 @@
 #include "gro_tcp_internal.h"
 
 void *
-gro_tcp6_tbl_create(uint16_t socket_id,
+gro_tcp6_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
diff --git a/lib/gro/gro_tcp6.h b/lib/gro/gro_tcp6.h
index acf3971bb6e..1be01db9194 100644
--- a/lib/gro/gro_tcp6.h
+++ b/lib/gro/gro_tcp6.h
@@ -60,7 +60,7 @@ struct gro_tcp6_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_tcp6_tbl_create(uint16_t socket_id,
+void *gro_tcp6_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/gro_udp4.c b/lib/gro/gro_udp4.c
index 019e05bcdea..ed738f60ece 100644
--- a/lib/gro/gro_udp4.c
+++ b/lib/gro/gro_udp4.c
@@ -9,7 +9,7 @@
 #include "gro_udp4.h"
 
 void *
-gro_udp4_tbl_create(uint16_t socket_id,
+gro_udp4_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
diff --git a/lib/gro/gro_udp4.h b/lib/gro/gro_udp4.h
index 6467d7bc3b8..ad423731d50 100644
--- a/lib/gro/gro_udp4.h
+++ b/lib/gro/gro_udp4.h
@@ -98,7 +98,7 @@ struct gro_udp4_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_udp4_tbl_create(uint16_t socket_id,
+void *gro_udp4_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/gro_vxlan_tcp4.c b/lib/gro/gro_vxlan_tcp4.c
index 29d4a2e13d5..d258cdc8561 100644
--- a/lib/gro/gro_vxlan_tcp4.c
+++ b/lib/gro/gro_vxlan_tcp4.c
@@ -10,7 +10,7 @@
 #include "gro_vxlan_tcp4.h"
 
 void *
-gro_vxlan_tcp4_tbl_create(uint16_t socket_id,
+gro_vxlan_tcp4_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
diff --git a/lib/gro/gro_vxlan_tcp4.h b/lib/gro/gro_vxlan_tcp4.h
index 662db01a88d..beac866b5a1 100644
--- a/lib/gro/gro_vxlan_tcp4.h
+++ b/lib/gro/gro_vxlan_tcp4.h
@@ -77,7 +77,7 @@ struct gro_vxlan_tcp4_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_vxlan_tcp4_tbl_create(uint16_t socket_id,
+void *gro_vxlan_tcp4_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/gro_vxlan_udp4.c b/lib/gro/gro_vxlan_udp4.c
index ca8cee270d3..13e69ec904b 100644
--- a/lib/gro/gro_vxlan_udp4.c
+++ b/lib/gro/gro_vxlan_udp4.c
@@ -10,7 +10,7 @@
 #include "gro_vxlan_udp4.h"
 
 void *
-gro_vxlan_udp4_tbl_create(uint16_t socket_id,
+gro_vxlan_udp4_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
diff --git a/lib/gro/gro_vxlan_udp4.h b/lib/gro/gro_vxlan_udp4.h
index d0452212430..a412a23fd1f 100644
--- a/lib/gro/gro_vxlan_udp4.h
+++ b/lib/gro/gro_vxlan_udp4.h
@@ -78,7 +78,7 @@ struct gro_vxlan_udp4_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_vxlan_udp4_tbl_create(uint16_t socket_id,
+void *gro_vxlan_udp4_tbl_create(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index 578cc9b8010..776a553d5bb 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -14,7 +14,7 @@
 #include "gro_vxlan_tcp4.h"
 #include "gro_vxlan_udp4.h"
 
-typedef void *(*gro_tbl_create_fn)(uint16_t socket_id,
+typedef void *(*gro_tbl_create_fn)(int32_t socket_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 typedef void (*gro_tbl_destroy_fn)(void *tbl);
diff --git a/lib/gro/rte_gro.h b/lib/gro/rte_gro.h
index c83dfd9ad14..572b41bf6fd 100644
--- a/lib/gro/rte_gro.h
+++ b/lib/gro/rte_gro.h
@@ -53,7 +53,7 @@ struct rte_gro_param {
 	/**< max flow number */
 	uint16_t max_item_per_flow;
 	/**< max packet number per flow */
-	uint16_t socket_id;
+	int32_t socket_id;
 	/**< socket index for allocating GRO related data structures,
 	 * like reassembly tables. When use rte_gro_reassemble_burst(),
 	 * applications don't need to set this value.
-- 
2.21.0

