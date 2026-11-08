Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDD606A31C
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OZN1SXMd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEB8540264;
	Sun,  8 Nov 2026 09:38:14 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 2D29F4003C;
 Sun,  8 Nov 2026 09:38:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwrElTnmMr2y5P8Gc4wy9E7ehkuYeq8ajAc75cVHxE/fIgBBBeRtNeeE7tQZQZwVALOqMjowDPS+tbApuLBHtNtjRnO1l181yjSSuGmMx3mcjwuJ/5XwliHDWKrXuD3HYZ+lHOCR2drrerBafrhQ5f1mI6CPc+RFH/4vng5jGJtxtlvlwbo/sZL1A9mfRpYVIa4HwmS2Y3YxNosW3MI1LDRpD2NTNO80YLREbCsmtDmONvcN8TrG7MykGocoklh4B13hHqpRrZi/akUnEmAX1LuvdCGlARDkDMH+xP5dA68fk57lQFQ/dXK6wN5NyNUDohbV6bJ6j9fitpmcUQFjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaMpJLHi0q9SqSO5YdOJfSBmZVQ4I5T8xX90u0HJNw4=;
 b=ZBQlU6ZE1uVf5NFD+Z/5ojS27X/LOJqOjwp1XxKyawV+1CY88aMixnIx0fX9kAsg6fI0DcBB0+jh97HsK2cNjDyduBgLKYZ0xXlX0HGTEEKWxIpCYPdgsiKNdUayVdsQz6TUIGGTlzY5qYeJD5+fn00rHwrMSZ+b+5AjHmyiwgKA6I69Tr/iA01QcueyPZOzBDIkBjrT9Y5x7ZJ/9q+Lxav0LjJ4sNoUqSHyYQIxKwLGMvNGXlgzmjc4/ozX56kttv6oh7Efqn6dvglJHKadcSnO9u3XKtCa5a5tiShHl0vWoUCfYg63J5gDhhPE0C4PyRvTjLWnxZ9pBDxDTAG6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaMpJLHi0q9SqSO5YdOJfSBmZVQ4I5T8xX90u0HJNw4=;
 b=OZN1SXMdVF+cFSqp6jTcRDr7bZlqEQcizRCzh0Hbgob+hudZ6pgAQi4k5EzPFyRW/pk/Wtp43x56vSmQxNvNxn1IUeMCAGo+iSHK8xubZaT9F5lc0CWts97W821NjFFpvYeRsMIajqCp900AwDGgCKKuGQEeNM0RJz62tx8bbC0uUcPjYUAI2A9IAefMDBxKoc9aPVg14umzbWKIDywak1bSwpecWWbBXT6UM++eDWYrTxpq6vFvxgZFzYO8yso9XKi999DYqnc+HlHGR5sXxjcOKA4kYWXDVFbbkM7bcTrSZbXfgA9uVeL9RwcoI4WV4E7gmT3QToiiNHJmYh13XA==
Received: from CH2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:610:53::28)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sun, 8 Nov
 2026 08:38:00 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::3e) by CH2PR17CA0018.outlook.office365.com
 (2603:10b6:610:53::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Sun, 8
 Nov 2026 08:38:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 8 Nov 2026 08:38:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 8 Nov
 2026 00:37:43 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 8 Nov
 2026 00:37:41 -0800
From: Itai Sharoni <isharoni@nvidia.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <bingz@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH] net/mlx5: reject unsupported layers before GRE and NVGRE
Date: Sun, 8 Nov 2026 10:37:21 +0200
Message-ID: <20261108083721.3390082-1-isharoni@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7f6a96-6ee7-4935-7ceb-08df3d7398a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|18002099003|3023799007|56012099006|11063799006|261026140227099003|261021121427099003|261028144727099003|261009223027099003|261022105027099003|261102123227099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 4CwNnOgdbiqeRNgz3w5S9xVsgCh79ScfDPz9qGdfjlrHon9/VHCHUJhbv9e61oggjYMG3H1jM4aUMlMjHel3mPeUNVfZAbVlsfUKaUfUYKyfPkOP7aOd10LLYOZ4hSv7XadTk6xhUaBTWHjoRG8kX/mdoqv3bDPITHp0druLAwiFp7Zw8LMoykeoD5WUUb/B/0o2F4nyt/b/sJX+Ma6wMZEynY/Yq/imUwS5mHbfdodtI1/abgb0t8k56Z56bdjmFDjRB/NqSeDCX+1dXcm+k7THWAzHCbt5zGAh4CgrJqNnqGY0tRD1DrrMBYoO7ZXxbcvU3jiC0gKzG4bzFQGBEEt6eUz7eiUyIEH9JYvUOtr56qtX6aLsVrFF9LoDqfOjpUclg5lTd0z0mlfU1O0V2fTYnk7HarINXHHoI4mUc0Kr4biL++D6P6Z9x9jn25DJrF0uuaeCEjEHkBPpSGq1SsHVjDeim6v1Kpi0kNkwTg999t9cAztW+Gb1YT+YI31SB3uh1R0dY/txMoUrbuuMehaQvKqekZyCKIDqOBfjrzE7/c2f7v0losfaN9G6yEIdFI1q4SbkgBVesFHRIKHKBjuJ3VH5VKmnHBvnkzM8gAbCTQ9win6ZLJF0B7aaeOTwEwVUZCQf8IMhJI4MU360Zsqz/eriqfybLIgfDAN04lqur41oVV5Cufddw9DX30q+oepQYBG4P6zPA9MIqrNMFw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(3023799007)(56012099006)(11063799006)(261026140227099003)(261021121427099003)(261028144727099003)(261009223027099003)(261022105027099003)(261102123227099003)(261022075727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: raisVFQtrhcu8IxMsMxBhuZOQRETAyCcL3Temk8fAfK2LK2P/QyipS5Q+GsRKYku06wYp8uGpoIX+3ThKx69Q80yogVaKFULFJd6Yd1XCWIUj2XU4syQ66TEt8e6aWtJ0pnqYSbK+x5tKg0HEfWIE+rDlOzZobUWKD1O9a2c+QUD7SpQo5VwYo4ZEnbVojM/7P2BopqmgV91yYWkNtvpu4OtUP/zr18LwZLb28SjXzEmZdpL0/Z1OKQ3fzK74T2ZeFG+jPWDyZMSbKGnP/Cx+nmpc0J/0EyFizPUtXw3QiXy1L7SgEJAvBvmNI9NWbdkXxq72JGayE39IGOelCMtLHHXFeEmcr8sCuJ1gkIjIgEVBZWRYa+bGQLhvSEa5h2x/ks/4hknRvBtqPjn1nc2KBX/1DdCU/jlPqetXl35o5LCfqCuEWd+VSCkQFiZo/5f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 08:38:00.0063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7f6a96-6ee7-4935-7ceb-08df3d7398a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Flow patterns such as eth / ipv4 / udp / nvgre were accepted
silently because mlx5_flow_validate_item_gre and
mlx5_flow_validate_item_nvgre did not check which layers precede
the GRE item.

During translation the GRE handler overwrites the ip_protocol
field from UDP (17) to GRE (47), so the resulting firmware rule
matches plain NVGRE packets instead. This misleads users into
believing they created a UDP+NVGRE rule when the UDP item is
silently discarded. The same applies to TCP, ICMP, ICMPv6 and ESP.

GRE-in-UDP (RFC 8086) is a valid encapsulation that mlx5 does not
support, so reject an outer UDP item with ENOTSUP. GRE cannot be
carried over TCP, ICMP or ICMPv6, and cannot be matched inside an
encrypted ESP payload, so reject those with EINVAL.

The checks are unconditional so they cover both the DV and HWS
steering paths.

Fixes: f4b901a46aec ("net/mlx5: add flow GRE item")
Fixes: ea81c1b816f7 ("net/mlx5: fix NVGRE matching")
Cc: stable@dpdk.org

Signed-off-by: Itai Sharoni <isharoni@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 37654918b5..f20214857f 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -3519,6 +3519,16 @@ mlx5_flow_validate_item_gre(const struct rte_eth_dev *dev,
 					  RTE_FLOW_ERROR_TYPE_ITEM, item,
 					  "multiple tunnel layers not"
 					  " supported");
+	if (item_flags & MLX5_FLOW_LAYER_OUTER_L4_UDP)
+		return rte_flow_error_set(error, ENOTSUP,
+					  RTE_FLOW_ERROR_TYPE_ITEM, item,
+					  "GRE over UDP is not supported");
+	if (item_flags & (MLX5_FLOW_LAYER_OUTER_L4_TCP |
+			  MLX5_FLOW_LAYER_ICMP | MLX5_FLOW_LAYER_ICMP6 |
+			  MLX5_FLOW_ITEM_ESP))
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ITEM, item,
+					  "GRE cannot follow TCP, ICMP or ESP layer");
 	if (!mlx5_hws_active(dev)) {
 		if (!(item_flags & MLX5_FLOW_LAYER_OUTER_L3))
 			return rte_flow_error_set(error, ENOTSUP,
@@ -3894,6 +3904,16 @@ mlx5_flow_validate_item_nvgre(const struct rte_eth_dev *dev,
 					  RTE_FLOW_ERROR_TYPE_ITEM, item,
 					  "multiple tunnel layers not"
 					  " supported");
+	if (item_flags & MLX5_FLOW_LAYER_OUTER_L4_UDP)
+		return rte_flow_error_set(error, ENOTSUP,
+					  RTE_FLOW_ERROR_TYPE_ITEM, item,
+					  "NVGRE over UDP is not supported");
+	if (item_flags & (MLX5_FLOW_LAYER_OUTER_L4_TCP |
+			  MLX5_FLOW_LAYER_ICMP | MLX5_FLOW_LAYER_ICMP6 |
+			  MLX5_FLOW_ITEM_ESP))
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ITEM, item,
+					  "NVGRE cannot follow TCP, ICMP or ESP layer");
 	if (!mlx5_hws_active(dev)) {
 		if (!(item_flags & MLX5_FLOW_LAYER_OUTER_L3))
 			return rte_flow_error_set(error, ENOTSUP,
-- 
2.43.0

