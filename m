Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F68ECAC587
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 06:29:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2302E402F1;
	Tue,  9 Sep 2025 08:29:39 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by mails.dpdk.org (Postfix) with ESMTP id 871D640270;
 Tue,  9 Sep 2025 08:29:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqs/HljDdWb4TnbLeSn8cWizpI9MfuvZCYF8/rkks2iGQQWdimfB98lm9ZN+2wB8UYc4Pebe6PjI/LOBk8Z5Id30LT1GpHauQ5xDLkGBx1pr5nowOj8r/IWs8GEwiDhgZXc54FEKlO5Bxt5sd4S+UDCslqps6xjIGfzGUcwuK+Ezn6cycte5+m3aO3R+zXS2jmlhQ3jUAG+/iivTnscJJEddgVWMDk2c8RLfDfFY8QE94Vz33K6c9fIs/YYsV2HDJtX8+uYwNxwhnIAtEI1IzDWvn2sAt/gL8GL5QkMBXXniHa8VyRuyYAI1fQQcsaMvXnbVe35DTnkkcswKCFfTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT9kQCosz/6SsX9YuJVvUXjDvJrwswaIbLEGITNIyRE=;
 b=ETIdLvXywadGoymIo1n9RTRDVCuhwCKU64bDMS0Gdx4Xtrcgam1kq3e0JU6QKxJEilBr4dNa/fEkUWntd5ZuvCE0ZPaO2ROpw9Y/GDy+xAU9dzmrDVz3/8GqaLHAv11j6zIfRnPy4ZlFQfbX048tJWjgUA4vhk0W7uRuAo48IerewleNnYBnjlqkFtpwUUar6qOCvIz0iDQYfOvQJ3Dq8v2uCwxPbJVBut9ekE1YyeDsfmoQTMDpwhv/ZsSVZ98jzxOTfC9taTxdGQLA7dE6xuMhzXIzvQ2rpQFOLml/oUrycUEDXvE7z2tW5RoLkooro8CNeFdeO/7NjGMnM/M17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT9kQCosz/6SsX9YuJVvUXjDvJrwswaIbLEGITNIyRE=;
 b=mNiyw6RTDclncNL2eybKQbfNgSmJcthdFJSIlK6Gu76FhfzsJK4Uml8ypZI1AAg7UidLWnFNB7X+5BfCCQ76HkHi0RqWz922k/zNw5QCEQPyaj51lA3cp0F16cJlqAghZCx0O+6UDNiArQSvStowiOucf+N+/zWo/KsxJV24knK2GscVIq2qaP28oljYSa/Pi2uDmSGZ9RcFKAtpw/68s02QKNlUadhFOAbceP0FJl6/zfM5ZAFvieTEPNHyY2sjinauB2jTZMVRdfGeY0rKyKtCEblJhCs1sELpxUH6M+s3D4IA/qJ/+HllpPrZkw6mZj16vIxQ1C61OkrJwDwmNQ==
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:29:32 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ed) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Tue,
 9 Sep 2025 06:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 06:29:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 23:29:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 23:29:07 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 23:29:04 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, <stable@dpdk.org>, Matan Azrad
 <matan@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Raja Zidane <rzidane@nvidia.com>
Subject: [PATCH v2 2/3] net/mlx5: fix ESP item validation to match on seqnum
Date: Tue, 9 Sep 2025 09:28:52 +0300
Message-ID: <20250909062853.60592-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250909062853.60592-1-mkashani@nvidia.com>
References: <20250804050514.244896-1-viacheslavo@nvidia.com>
 <20250909062853.60592-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cbbc53-260d-45df-1319-08ddef6a3c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VAOZLmu3hdyUmsz3XD6zbVAdiOu5id93J1NhDUDPdFJ2luoWVerIfWd6Paq4?=
 =?us-ascii?Q?h5EuLmYuL7amCjesVtEbqk0tIzdv/OHvzXSVgeGwzi+2YPkRIABaX3vuZjDs?=
 =?us-ascii?Q?7vR05Eb1N4XJ/bvmnWK0OsbiZR6MZDddufHaZNRKOa02d8tamkbvgr1zAM1c?=
 =?us-ascii?Q?Up7k7f7Gwt67yjk19j60nbD3Kh7u79hLeLBtRnWJKfMyVtLx5+Va97SBmYQ9?=
 =?us-ascii?Q?wGNjiocKXAlGf3bgp+VQYGpX3HmN2YAgpBT8O66BPD609toI+KIJXZCj9xnv?=
 =?us-ascii?Q?3QD4M+jK/9kmRP8O96dWqS4ryAwMkEsETJE4q7AbKDB72HCNhHCAIE2s4S2L?=
 =?us-ascii?Q?HLNZcrIxvBkA9cXRCy10/RUiowrwp0Nxi2xl35yAwcd56a8XSyjDslp65h4C?=
 =?us-ascii?Q?prwk7BeHyAr1nw3QzWBR1o8mjpNS1P2R+IfDEjh3x8IsWkc9bsSMmWE7btYb?=
 =?us-ascii?Q?Kwu4Q4lvpGzGnaJhBRbdeJ+//8QcWi18hFr0fy1cUD8QvHIuUolaaMrv/wMQ?=
 =?us-ascii?Q?RV9ajx+wg44ciOIURtSPdxHapCY0px8+nu7ifocFbe+1umoojUwRBkGG1xi8?=
 =?us-ascii?Q?8JeahkLL3yFxD1uaLEvNWfwxcFC8KHT7Wk0Wwpd/qwkDMTKWEoHDSuODfXR7?=
 =?us-ascii?Q?7CFGshrBCmb+ZuGlrfO/YvsCWbYMpZacLbq4btHBQzIkEjIte7MX3Bzljrzi?=
 =?us-ascii?Q?w0qIQa0uV84jS2iG3MBxi2mCqnPQ+W9prQjEl9weVftWnZt3KAEyw870wE2h?=
 =?us-ascii?Q?lJhcNbO31l0l08VaM4ZMV3APYYrGicKlCGVFOuMgNZI7FJgXz6M0gS80Tsn3?=
 =?us-ascii?Q?Gn0MaAez2RBMFN+ngPXIKTMY8wp9+taJ5UpblWLxnMqMIAiJGi1V3MpQeaAY?=
 =?us-ascii?Q?z6DFJGJ1Oj1+AJSRfWbgI7inqTybAW2Q79z84XadNDe+lBVlKEzX5PeFQZ8/?=
 =?us-ascii?Q?m9hAEyOG0PwAwhd57PWElZRBls3774a5/oHAg+fX5/5lBUPrVq2eBOAtSKea?=
 =?us-ascii?Q?idcEhviHZtQKc8cCKMC9Hf30Tt+GD00H+W4TqWFCfsiz2XgiuO9sKhj4zlC2?=
 =?us-ascii?Q?lPN8UgZ/Y3UdFOUOjjPXhQMzZixWPp4wmnB9VLPTGTaIM1NFyGq3mWGeBMoi?=
 =?us-ascii?Q?/+sTV6Rs0CFMkbL/UIs52nuM06Sfupx04++DCEBhOxswMaJ7LWVMfYe2pGP2?=
 =?us-ascii?Q?8QRl5f8S7e+NqnpTozS7tAvqE9vbwC/NhIT4oDiAmTw7dnLIjYFw+HMYIVIo?=
 =?us-ascii?Q?/F1UsmD7kVjWDDOv11a79aHUIbyLohyXQOAjqHrvDNMwSt6pekU57x6ljXul?=
 =?us-ascii?Q?r8zAOXZXZYVb65pXVG5Uqzf5XUP4r114pQxOukHmGnfOCfd54+KD236HRTJ9?=
 =?us-ascii?Q?Phr4vebp68StFnncsSg5CFVdm0K53LmiXSVhDXWEKUQlZAjF8XSmoFyb7HmJ?=
 =?us-ascii?Q?1ysu+42VbWHysx05yXr/ggecyVb0qDBgVRpmf0XfWwWnvuioUNYfC3oQP4DL?=
 =?us-ascii?Q?f7ZKmYUsOdF6ZPAr5vtgR06FsKygoDubM49a?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:29:31.4433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cbbc53-260d-45df-1319-08ddef6a3c68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
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

From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

The match on ESP sequence number is supported by hardware
steering implementation but was rejected in validation
routine shared by all steering engines.

This patch allows validation to pass with requested match on
ESP sequence number for hardware steering engine.

Fixes: fb96caa56aab ("net/mlx5: support ESP item on Windows")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_flow_os.c   | 10 +++++++++-
 drivers/net/mlx5/linux/mlx5_flow_os.h   |  3 +++
 drivers/net/mlx5/mlx5_flow_dv.c         |  6 ++----
 drivers/net/mlx5/mlx5_flow_hw.c         |  5 ++---
 drivers/net/mlx5/mlx5_flow_verbs.c      |  6 ++----
 drivers/net/mlx5/windows/mlx5_flow_os.c | 10 +++++++++-
 drivers/net/mlx5/windows/mlx5_flow_os.h |  3 +++
 7 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_flow_os.c b/drivers/net/mlx5/linux/mlx5_flow_os.c
index af8c02c38b8..777125e9a87 100644
--- a/drivers/net/mlx5/linux/mlx5_flow_os.c
+++ b/drivers/net/mlx5/linux/mlx5_flow_os.c
@@ -18,6 +18,7 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 			       const struct rte_flow_item *item,
 			       uint64_t item_flags,
 			       uint8_t target_protocol,
+			       bool allow_seq,
 			       struct rte_flow_error *error)
 {
 	const struct rte_flow_item_esp *mask = item->mask;
@@ -26,6 +27,12 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 				      MLX5_FLOW_LAYER_OUTER_L3;
 	const uint64_t l4m = tunnel ? MLX5_FLOW_LAYER_INNER_L4 :
 				      MLX5_FLOW_LAYER_OUTER_L4;
+	static const struct rte_flow_item_esp mlx5_flow_item_esp_mask = {
+		.hdr = {
+			.spi = RTE_BE32(0xffffffff),
+			.seq = RTE_BE32(0xffffffff),
+		},
+	};
 	int ret;
 
 	if (!mlx5_hws_active(dev)) {
@@ -47,7 +54,8 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 		mask = &rte_flow_item_esp_mask;
 	ret = mlx5_flow_item_acceptable
 		(dev, item, (const uint8_t *)mask,
-		 (const uint8_t *)&rte_flow_item_esp_mask,
+		 allow_seq ? (const uint8_t *)&mlx5_flow_item_esp_mask :
+			     (const uint8_t *)&rte_flow_item_esp_mask,
 		 sizeof(struct rte_flow_item_esp), MLX5_ITEM_RANGE_NOT_ACCEPTED,
 		 error);
 	if (ret < 0)
diff --git a/drivers/net/mlx5/linux/mlx5_flow_os.h b/drivers/net/mlx5/linux/mlx5_flow_os.h
index 35b5871ab91..21a2ed5bec0 100644
--- a/drivers/net/mlx5/linux/mlx5_flow_os.h
+++ b/drivers/net/mlx5/linux/mlx5_flow_os.h
@@ -514,6 +514,8 @@ mlx5_os_flow_dr_sync_domain(void *domain, uint32_t flags)
  *   Bit-fields that holds the items detected until now.
  * @param[in] target_protocol
  *   The next protocol in the previous item.
+ * @param[in] allow_seq
+ *   The match on sequence number is supported.
  * @param[out] error
  *   Pointer to error structure.
  *
@@ -525,6 +527,7 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 			       const struct rte_flow_item *item,
 			       uint64_t item_flags,
 			       uint8_t target_protocol,
+			       bool allow_seq,
 			       struct rte_flow_error *error);
 
 /**
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index abfd54da1a9..18d0d293770 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -7859,10 +7859,8 @@ flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 		case RTE_FLOW_ITEM_TYPE_VOID:
 			break;
 		case RTE_FLOW_ITEM_TYPE_ESP:
-			ret = mlx5_flow_os_validate_item_esp(dev, items,
-							     item_flags,
-							     next_protocol,
-							     error);
+			ret = mlx5_flow_os_validate_item_esp(dev, items, item_flags,
+							     next_protocol, false, error);
 			if (ret < 0)
 				return ret;
 			last_item = MLX5_FLOW_ITEM_ESP;
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index c84ae726a74..2ca40b41465 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -8818,9 +8818,8 @@ __flow_hw_pattern_validate(struct rte_eth_dev *dev,
 			last_item = MLX5_FLOW_ITEM_QUOTA;
 			break;
 		case RTE_FLOW_ITEM_TYPE_ESP:
-			ret = mlx5_flow_os_validate_item_esp(dev, item,
-							     *item_flags, 0xff,
-							     error);
+			ret = mlx5_flow_os_validate_item_esp(dev, item, *item_flags,
+							     0xff, true, error);
 			if (ret < 0)
 				return ret;
 			last_item = MLX5_FLOW_ITEM_ESP;
diff --git a/drivers/net/mlx5/mlx5_flow_verbs.c b/drivers/net/mlx5/mlx5_flow_verbs.c
index 5b4a4eda3bb..67d199ce15e 100644
--- a/drivers/net/mlx5/mlx5_flow_verbs.c
+++ b/drivers/net/mlx5/mlx5_flow_verbs.c
@@ -1332,10 +1332,8 @@ flow_verbs_validate(struct rte_eth_dev *dev,
 		switch (items->type) {
 #ifdef HAVE_IBV_FLOW_SPEC_ESP
 		case RTE_FLOW_ITEM_TYPE_ESP:
-			ret = mlx5_flow_os_validate_item_esp(dev, items,
-							     item_flags,
-							     next_protocol,
-							     error);
+			ret = mlx5_flow_os_validate_item_esp(dev, items, item_flags,
+							     next_protocol, false, error);
 			if (ret < 0)
 				return ret;
 			last_item = MLX5_FLOW_ITEM_ESP;
diff --git a/drivers/net/mlx5/windows/mlx5_flow_os.c b/drivers/net/mlx5/windows/mlx5_flow_os.c
index bf93da9f1e1..7a625fb880a 100644
--- a/drivers/net/mlx5/windows/mlx5_flow_os.c
+++ b/drivers/net/mlx5/windows/mlx5_flow_os.c
@@ -428,6 +428,7 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 			    const struct rte_flow_item *item,
 			    uint64_t item_flags,
 			    uint8_t target_protocol,
+			    bool allow_seq,
 			    struct rte_flow_error *error)
 {
 	const struct rte_flow_item_esp *mask = item->mask;
@@ -437,6 +438,12 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 				      MLX5_FLOW_LAYER_OUTER_L3;
 	const uint64_t l4m = tunnel ? MLX5_FLOW_LAYER_INNER_L4 :
 				      MLX5_FLOW_LAYER_OUTER_L4;
+	static const struct rte_flow_item_esp mlx5_flow_item_esp_mask = {
+		.hdr = {
+			.spi = RTE_BE32(0xffffffff),
+			.seq = RTE_BE32(0xffffffff),
+		},
+	};
 	int ret;
 
 	if (!(item_flags & l3m))
@@ -461,7 +468,8 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 					  " supported on Windows");
 	ret = mlx5_flow_item_acceptable
 		(dev, item, (const uint8_t *)mask,
-		 (const uint8_t *)&rte_flow_item_esp_mask,
+		 allow_seq ? (const uint8_t *)&mlx5_flow_item_esp_mask :
+			     (const uint8_t *)&rte_flow_item_esp_mask,
 		 sizeof(struct rte_flow_item_esp), MLX5_ITEM_RANGE_NOT_ACCEPTED,
 		 error);
 	if (ret < 0)
diff --git a/drivers/net/mlx5/windows/mlx5_flow_os.h b/drivers/net/mlx5/windows/mlx5_flow_os.h
index 36edc3d5328..2cd4e953256 100644
--- a/drivers/net/mlx5/windows/mlx5_flow_os.h
+++ b/drivers/net/mlx5/windows/mlx5_flow_os.h
@@ -461,6 +461,8 @@ int mlx5_flow_os_destroy_flow(void *drv_flow_ptr);
  *   Bit-fields that holds the items detected until now.
  * @param[in] target_protocol
  *   The next protocol in the previous item.
+ * @param[in] allow_seq
+ *   The match on sequence number is supported.
  * @param[out] error
  *   Pointer to error structure.
  *
@@ -472,6 +474,7 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 			       const struct rte_flow_item *item,
 			       uint64_t item_flags,
 			       uint8_t target_protocol,
+			       bool allow_seq,
 			       struct rte_flow_error *error);
 
 /**
-- 
2.21.0

