Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB36CAC587
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 06:29:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CDA5402EA;
	Tue,  9 Sep 2025 08:29:46 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by mails.dpdk.org (Postfix) with ESMTP id 6B34640652;
 Tue,  9 Sep 2025 08:29:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFiu8Il0l4baCQU7IXxEi+UTWsJS9eruav+3YVQpRwjab07ycj4g3FTOI6K0mYdnkY8lFQrtCAVoQ/c+PdrvtL+HXvzcZBjgVD4UzQT7DeUg2Uyy8hNRr3TXHGmNB1vTqw71f4VJewm4c6CZo2XK+CLMJteprkBUJeQ8k2vWlA5gPViqNcrbXLBx7UAcTqNFpPCvoqkqMhBWi8Lt0DyPyep6eCDkSvU6+GGJmakpgfXHJg4UCMhfzI7riFePTVih3V1OpHi8st7f+lIcWuwnBL9kieeROM9pkpr2caomXRuduaeyGJwx52/7kvOwtoR0pwLSRNj/7r9f/wHzWXaDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzn9H6aXr3E+XprexS7VA+1dnPxty47XAdlqXgHfXQE=;
 b=K2c5FqW+zwQGxoJCO/Jl7r0a+h9eVLSrf1MpLrg8ZM8kJUrixQV7NLrSd84Wy0Frz7qNmtdH6UnMjC1nGgrf1kdzaEqupcOKNvOKBALU5Wnasypku69pwgxuyaB4Bu08oImQSgVFTQirH8stofrmMd4oLhyNMq1RFHJt3yMhlkOZF1Nt0tXseiVAcx76VSfCgOPgFaCDV9ShKa0krGmo0ZMHqrZow9mqpQ/JeY02IYe5mQbB8NAbUNUCpm8d80/AbM0uMIRJpis5ipLqqkzOUm5lTgtB0QYcH+FM+V3DN7SxD0SGO9qx1o/vN7B4ZK3X5aPI0dzmA4TM6+N2JOYSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzn9H6aXr3E+XprexS7VA+1dnPxty47XAdlqXgHfXQE=;
 b=rVyCknkweEej1IlGrByZ/OAxhksIVyygF7toEkEos32CY1DnEYsjrh7F4LW9TOpmPWztUz7LuLMQz8snubydTIKamnMOuPNtSL9f4STsAa0y9wQHt/xMlCgoWhfheaHfPtP9Fi9G60SDLq431tosLocqUN0suDrcmxaQhC9b/z19fvxVEzkVGhX7JB95vn9zpRob+CsdrGPtjD8w/CtL/lNRx5l1fKrb1yDXxiXc6gc9GtUX2HEKh73eMcuKCqeHmr2SiU7nL2A9CVJurUvtEHHV08c3wAcSRAcKbZz/AwKEMnjk/YMUe1E2RMxCCAFwYCQZt4PjK0PCOBJh1rBbFA==
Received: from BL1P223CA0037.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::14)
 by CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 9 Sep
 2025 06:29:41 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::c0) by BL1P223CA0037.outlook.office365.com
 (2603:10b6:208:5b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 06:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 06:29:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 23:29:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 23:29:13 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 23:29:09 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, <stable@dpdk.org>, Matan Azrad
 <matan@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Raja Zidane <rzidane@nvidia.com>
Subject: [PATCH v2 3/3] net/mlx5: fix ESP header match after UDP for group 0
Date: Tue, 9 Sep 2025 09:28:53 +0300
Message-ID: <20250909062853.60592-3-mkashani@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9db592-44ed-4e86-3b50-08ddef6a41f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bcou8o9gJCgUpS4VWpnnVph7x3lfOZDCKv063fizWxDQr9nRyM5V1Ppdg74O?=
 =?us-ascii?Q?3XcpGqOyYGb6WJrfC6PLmCxiVe/JgZzxrB1fBC91DSpeAk0u3ymOBBv2soQC?=
 =?us-ascii?Q?jXgmX6cOaGT15e3NEtNJYhCEHwk4YcSKrwuofnIQ5oE8PUuwNkwQH6IhQMdy?=
 =?us-ascii?Q?TWMhRbp7NQBA3NjMSaXwMt/5y882VKgsH3itaG1mzK4SXp1uUb+BPjq9yU4P?=
 =?us-ascii?Q?ICIzP9GucstsMmNXjJ3VSyxxwFnlKZEQgea4BQhmQttkh2XINUfnzjo0Iekd?=
 =?us-ascii?Q?5slzNA0xaSmqK5+7jdHnt8ztj9qDakijALh8Von6FmCRDlpOP1DVio+1qEOl?=
 =?us-ascii?Q?PnkmVs8R5N13FfBExaNB6GoMYuidWYXZ71jIoV6dhV1SJ4iXgHelFxUI+BZn?=
 =?us-ascii?Q?z4OCOudHIWISpxDfk+7FKUoH2WhI/VIzm9Jm7Ch6gnJ4l8qN1PPGkRPQQNr7?=
 =?us-ascii?Q?45uDK3IfCzE3MnktuYRrRzfIPUT6U81Pdle2GaS0bds+EAZG9wh+Jh4/c5Z7?=
 =?us-ascii?Q?rc1kb80/RzHMDApyVvCnyOjyT76/mJgVTk+m+diHNP7TcOJ6u4ffs+bxdg5+?=
 =?us-ascii?Q?Js/wuAefot6vylQQDAXPKrGdAptLmcV/lMjZiDrCkEd6e4ibY8dxdExeRPKd?=
 =?us-ascii?Q?cErn2qtHmhI9cr2EuM+5mYHoXVpsq6q1n5Uecg9a7DYxyiEt2NyPux1Z35E0?=
 =?us-ascii?Q?1TQJi6oUYQjihzEQfjkcWWpwJ4Z4ku2eOXBjO8GzJZssIW9zvUFN5ZBNqlAk?=
 =?us-ascii?Q?DdQnziETpPBXOOY+tlMX0f355/B51FPR4wZPxz1IGnY7lI5T9q+gsfQceXOs?=
 =?us-ascii?Q?t2R9bSnEAtsWqQVTsgDBAGAdFhIdBRF0xHY3dFIABR58oulmkpi8fkm40MI7?=
 =?us-ascii?Q?LpteQQcOXw8CRuoSNupZV/qS1ram2Bexf2Qvgg84Nil1u3N26rG6e3QWnpdV?=
 =?us-ascii?Q?UNO6Azk2BApASc/DWjDfmvgUdm3RuvGhoc6bN0Symi70taTss9oy3OciZ3Ro?=
 =?us-ascii?Q?8ny9h4MSqfitIhnF+LgRXYC3ZXRy9FDAzkW9PjxpSSPD1idU0dnJi07zSEhq?=
 =?us-ascii?Q?qWjgvTxA0dbcGtUWZhTldQABQiHYFy3/u1QzMKi9ROHqaVQuBPwxSV2dvLci?=
 =?us-ascii?Q?REZYwWBprQZGAsn/gtBSlumfnBeF20loX1ed+xqHkkpJmmQ4SeFTNzPNTs1P?=
 =?us-ascii?Q?y6AqYlD8aBuwwFUdqcYpyh+AVTI6ZbwHrXIgDkbK0TZhNblgktbQdXm0OURv?=
 =?us-ascii?Q?NRSpJ8dy2Snuoek6/oW2k2PJwejg3eBglJtCnCMEanLPdE1MmbVqBEXOgiNh?=
 =?us-ascii?Q?ddAruBSvAEO4Mm3/S1MUMEDutXbas4wpOUG23ScOZVax6bRGFDz86wS3VQxh?=
 =?us-ascii?Q?JtOh/UQU3IdLqbT/8VZQHPvNY65mQeqF136ANWuyTdUYlD4i/joGyfyJCtLg?=
 =?us-ascii?Q?FULgWClolibRHETcQIJMPUR+XCUZcJ3q3wQ7xwQFBaRX2OyoY26XB4WN6YDz?=
 =?us-ascii?Q?72Y5FUKobd3x7LmYIb7nN5MHlwyKimcGw15g?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:29:40.7291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9db592-44ed-4e86-3b50-08ddef6a41f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744
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

The ESP item translation routine always forced the match
on IP next protocol to be 50 (ESP). This prevented on
matching ESP packets over UDP.

The patch checks if UDP header is expected, and also forces
match on UDP destination port 4500 if it is not set
by the caller yet.

Fixes: 18ca4a4ec73a ("net/mlx5: support ESP SPI match and RSS hash")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_flow_os.c |  6 -----
 drivers/net/mlx5/mlx5_flow.h          |  3 +++
 drivers/net/mlx5/mlx5_flow_dv.c       | 34 ++++++++++++++++-----------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_flow_os.c b/drivers/net/mlx5/linux/mlx5_flow_os.c
index 777125e9a87..f5eee46e44b 100644
--- a/drivers/net/mlx5/linux/mlx5_flow_os.c
+++ b/drivers/net/mlx5/linux/mlx5_flow_os.c
@@ -25,8 +25,6 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 	const int tunnel = !!(item_flags & MLX5_FLOW_LAYER_TUNNEL);
 	const uint64_t l3m = tunnel ? MLX5_FLOW_LAYER_INNER_L3 :
 				      MLX5_FLOW_LAYER_OUTER_L3;
-	const uint64_t l4m = tunnel ? MLX5_FLOW_LAYER_INNER_L4 :
-				      MLX5_FLOW_LAYER_OUTER_L4;
 	static const struct rte_flow_item_esp mlx5_flow_item_esp_mask = {
 		.hdr = {
 			.spi = RTE_BE32(0xffffffff),
@@ -41,10 +39,6 @@ mlx5_flow_os_validate_item_esp(const struct rte_eth_dev *dev,
 						  RTE_FLOW_ERROR_TYPE_ITEM,
 						  item, "L3 is mandatory to filter on L4");
 	}
-	if (item_flags & l4m)
-		return rte_flow_error_set(error, EINVAL,
-					  RTE_FLOW_ERROR_TYPE_ITEM, item,
-					  "multiple L4 layers not supported");
 	if (target_protocol != 0xff && target_protocol != IPPROTO_ESP)
 		return rte_flow_error_set(error, EINVAL,
 					  RTE_FLOW_ERROR_TYPE_ITEM, item,
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 367dacc2779..ff617060549 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -489,6 +489,9 @@ struct mlx5_mirror {
 /* UDP port numbers for GENEVE. */
 #define MLX5_UDP_PORT_GENEVE 6081
 
+/* UDP port numbers for ESP. */
+#define MLX5_UDP_PORT_ESP 4500
+
 /* Lowest priority indicator. */
 #define MLX5_FLOW_LOWEST_PRIO_INDICATOR ((uint32_t)-1)
 
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 18d0d293770..bcce1597e2d 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -9713,29 +9713,35 @@ flow_dv_translate_item_tcp(void *key, const struct rte_flow_item *item,
  */
 static void
 flow_dv_translate_item_esp(void *key, const struct rte_flow_item *item,
-			   int inner, uint32_t key_type)
+			   int inner, uint32_t key_type, uint64_t item_flags)
 {
 	const struct rte_flow_item_esp *esp_m;
 	const struct rte_flow_item_esp *esp_v;
 	void *headers_v;
 	char *spi_v;
+	bool over_udp = item_flags & (inner ? MLX5_FLOW_LAYER_INNER_L4_UDP :
+					      MLX5_FLOW_LAYER_OUTER_L4_UDP);
 
 	headers_v = inner ? MLX5_ADDR_OF(fte_match_param, key, inner_headers) :
-		MLX5_ADDR_OF(fte_match_param, key, outer_headers);
-	if (key_type & MLX5_SET_MATCHER_M)
-		MLX5_SET(fte_match_set_lyr_2_4, headers_v,
-			 ip_protocol, 0xff);
-	else
-		MLX5_SET(fte_match_set_lyr_2_4, headers_v,
-			 ip_protocol, IPPROTO_ESP);
+			    MLX5_ADDR_OF(fte_match_param, key, outer_headers);
+	if (key_type & MLX5_SET_MATCHER_M) {
+		MLX5_SET(fte_match_set_lyr_2_4, headers_v, ip_protocol, 0xff);
+		if (over_udp && !MLX5_GET16(fte_match_set_lyr_2_4, headers_v, udp_dport))
+			MLX5_SET(fte_match_set_lyr_2_4, headers_v, udp_dport, 0xFFFF);
+	} else {
+		if (!over_udp)
+			MLX5_SET(fte_match_set_lyr_2_4, headers_v, ip_protocol, IPPROTO_ESP);
+		else
+			if (!MLX5_GET16(fte_match_set_lyr_2_4, headers_v, udp_dport))
+				MLX5_SET(fte_match_set_lyr_2_4, headers_v, udp_dport,
+					 MLX5_UDP_PORT_ESP);
+	}
 	if (MLX5_ITEM_VALID(item, key_type))
 		return;
-	MLX5_ITEM_UPDATE(item, key_type, esp_v, esp_m,
-			 &rte_flow_item_esp_mask);
+	MLX5_ITEM_UPDATE(item, key_type, esp_v, esp_m, &rte_flow_item_esp_mask);
 	headers_v = MLX5_ADDR_OF(fte_match_param, key, misc_parameters);
-	spi_v = inner ? MLX5_ADDR_OF(fte_match_set_misc, headers_v,
-				inner_esp_spi) : MLX5_ADDR_OF(fte_match_set_misc
-				, headers_v, outer_esp_spi);
+	spi_v = inner ? MLX5_ADDR_OF(fte_match_set_misc, headers_v, inner_esp_spi) :
+			MLX5_ADDR_OF(fte_match_set_misc, headers_v, outer_esp_spi);
 	*(uint32_t *)spi_v = esp_m->hdr.spi & esp_v->hdr.spi;
 }
 
@@ -14224,7 +14230,7 @@ flow_dv_translate_items(struct rte_eth_dev *dev,
 
 	switch (item_type) {
 	case RTE_FLOW_ITEM_TYPE_ESP:
-		flow_dv_translate_item_esp(key, items, tunnel, key_type);
+		flow_dv_translate_item_esp(key, items, tunnel, key_type, wks->item_flags);
 		wks->priority = MLX5_PRIORITY_MAP_L4;
 		last_item = MLX5_FLOW_ITEM_ESP;
 		break;
-- 
2.21.0

