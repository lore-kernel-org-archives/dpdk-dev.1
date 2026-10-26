Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7B606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MGRv6SSP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D136440659;
	Mon, 26 Oct 2026 17:28:05 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by mails.dpdk.org (Postfix) with ESMTPS id 35A2F40695
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:28:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTL+NJNbJj7xCD4n6eUjv+zNiTQIz66x0k88PvID9OKIIeBn9jc/4L2iu4t4oa3LWUnrp15i7ZdYE2+wLqjNinP4rFgM3bT7cIQuX0tcauKEXXq+SP0YxI93YQf07P6YNXNm7PX94ACUMX9XkrfuN/GCuuA8EIIzeZwscL4YZw6gb1BqkX6l2D9zxQvwEO/6KQHGxdLdFinZdOOC2+7RGhmBOtu8xwXYkCGe+ViSCFxEcRtpYB1xJ8U6bcPXX+Z5+PBjtk4qkVU0NjZ4RH4iW+K1hlvovyzCMmwQGEWvrCoP5DMluikMUK9i5EbnIVqxP64bDP4FtdsvgUm2r9Ctxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6HDCvbnzOHrFm98fUYD/KTR1w7bnFQkz3Xfu5daVo0=;
 b=XNFEj14pxMPLZ7VcacDCi46O71Iq/hPKHMt9AHQmCnhfo4h5lUC2ZArvZ8Z0URMx9scBshF1j++OXwnjmNu3QPzyoEYtLLgVthyTvwso8yDtWpSbnNEuT8G6y1U6zH3DvyjFjhnooQAS/CCqx6byWpcu3uACMUT4PoF2GTYtZXBRFWk6Ol+mLeGuTKDMVWYxcOe1c/M9i9UzDEjdVvNbSJERkvhQibbrsPJftsB8G19WZxGn2R2Oc3vqRvlq7CO7F3bEBXpMBAel25Vj0nNHnKSWt2sYBLPR3gxE+u41/L8y8rcf5WVInNO1dh2jCSokkgTQZLXRyAoe1U5UMHO92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6HDCvbnzOHrFm98fUYD/KTR1w7bnFQkz3Xfu5daVo0=;
 b=MGRv6SSPayJsBog8XZOIcI+2bOZO/BHoEthLi+1NIs8SB087LZuXlsxxN6D9HKINvRtkKbP2GuizKlAxBLFlP2TXvavuKCd+UMeG7GhfkGN89Qw3CEMY7MhAGbmZCESJUcIzy92zcQOXYIdi3FDpczM9v+BeGi9POXM0cIu2JwhRZXi3PpNbq05dt5VfFdd0/JWoTB8VxB2IxnJd0OTFIFFeKPidPM9wikCqIec7/M3dyXl4V4r4dq7IVsppv8ACbFp8ldtiGmqMUUSzWtPSYNuM3+FWfj2Sznm20ntf7hQ0g04k4MYZViF/GDi8A4wKUlwL3LnFYDGp4yN1ZA9/kQ==
Received: from DS1PR02CA0014.namprd02.prod.outlook.com (2603:10b6:8:452::17)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 26 Oct
 2026 16:27:54 +0000
Received: from CY6PEPF0000004B.namprd03.prod.outlook.com
 (2603:10b6:8:452:cafe::24) by DS1PR02CA0014.outlook.office365.com
 (2603:10b6:8:452::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:27:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY6PEPF0000004B.mail.protection.outlook.com (10.167.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:27:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:32 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:30 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 04/13] common/mlx5: query parent device over Netlink
Date: Mon, 26 Oct 2026 17:27:00 +0100
Message-ID: <20261026162709.1292958-5-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026162709.1292958-1-dsosnowski@nvidia.com>
References: <20261026162709.1292958-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004B:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee894dc-be9d-472c-7d3d-08df337e1642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|261026135527099003|18002099003|22082099003|261026140227099003|261026130827099003|261022115727099003|261022113327099003|261026121527099003|261022105027099003|11063799006|261021133027099003|261021121427099003|261021135927099003|10067099003|261021123027099003|261009223027099003|56012099006|261022075727099003|261021130227099003;
X-Microsoft-Antispam-Message-Info: mj/VjJgPmRGUNGHUpYrOJE2h7h6JYtlwJIiP2qi9JBCuc+eVQy9UxklA3ko3rwKqZtS2D+phtqM7iILjFIP77nS2TpTwPsxVwS/pbCDg9jCGdqOSxJcuD//NjeQRgB0sCy3WR036MxdK94ZRz/BYFeYvDFDOMCd7GCxBb4mix/dK4MO90GsAHVtjYVriVKHN4I1jSINIT2ONliEfvuJrHqPwz1GHM882VSTdqxb50i2ycMwG29cvZN2MbvVylwPZIlA3JZMSJiLx214yW57IYqcpRW5UIbGmypMF1jsDHxVQ0be6p8kzCKGGV3rugWdEAWxFZaOtsQ9knY/gtFPo23emOr7kYv7NmAHP7l3in6I2G4/5p/GLYWHqT0hEod+lcJnVpZBptnj+XIDp6aaPkgC3N48MF8SG8Hz2Pd04XdefqYvAHwpw+MuEXJj2vsSUx9to1tWnX1Gzj8ZdnhW6rsBqw0dTUJ5fJxr5bbggRzB5qCRhAo2rOytUdODh4r/Y2EY2lt015ZjBLl8zc/h9S8tY40kE9p0V/QYEi5qDYqhg7cJmIf4LAn1QKlr08+2MVHNqcseA13LCLj58oVxc+b6CmmNlrW5+vGenjaQObUHXsADe8iniyLsCL7lCubuiFo308T/zSYNxcHuYamggmyt/Lpp8Ot/UiH6vISXfTilVxam49pgiNwf8An/R9n0EbH3eHX54FE5x7NQhwiNK3g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(261026135527099003)(18002099003)(22082099003)(261026140227099003)(261026130827099003)(261022115727099003)(261022113327099003)(261026121527099003)(261022105027099003)(11063799006)(261021133027099003)(261021121427099003)(261021135927099003)(10067099003)(261021123027099003)(261009223027099003)(56012099006)(261022075727099003)(261021130227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /lyIoMBBSbBNqCfWTbLWsJM5NXmrLwAwsRqqQhaO8igvfkyko+ctcGYVwQK5bpRMOU/kqhx12XsWBEcG7lEO8UhgnOMZPUlBrJI3sI/6e2BEibUW0+JPh/RDD9U6Kfk/qWxxBDVrSNh9eGw0Wtg9/jYBs/RIvdcOb7PU1nt1P11kz1W6eWpiJlaMjnvxS/96Xd6f1apzkezlTUVAe/thKWEXKLMQZIwFP5C/X/fWoC6aWMIL9XitkPGurZj9AS7Y+aG9cpWujDVYPOFauWZSFKBWcDx+JZVTk3p0sOA8E4lRrVYS6UZWgVai2quMTi+4Q1ovjoK2GotRetLklDsCpSfLTrpwViTMtjsRUNx1CR2G283Up6UeenV6RST/E8h3md0ffoI3OtPPH6fl6wLOKFJYQvA9aUvUoZWHSKuKWUmL1FyeikNfs2ssRrDk/KTY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:27:54.1097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee894dc-be9d-472c-7d3d-08df337e1642
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend mlx5_nl_netdev_info_get() to gather Linux netdev's
parent device and bus name. This will be used in follow up patches
to match probed additional rte_device related to
single mlx5 common device.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/meson.build |  4 ++++
 drivers/common/mlx5/linux/mlx5_nl.c   | 24 ++++++++++++++++++++++++
 drivers/common/mlx5/linux/mlx5_nl.h   | 10 ++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/common/mlx5/linux/meson.build b/drivers/common/mlx5/linux/meson.build
index 3767e7a69b..1b2104b48e 100644
--- a/drivers/common/mlx5/linux/meson.build
+++ b/drivers/common/mlx5/linux/meson.build
@@ -154,6 +154,10 @@ has_sym_args = [
             'IFLA_PHYS_SWITCH_ID' ],
         [ 'HAVE_IFLA_PHYS_PORT_NAME', 'linux/if_link.h',
             'IFLA_PHYS_PORT_NAME' ],
+        [ 'HAVE_IFLA_PARENT_DEV_NAME', 'linux/if_link.h',
+            'IFLA_PARENT_DEV_NAME' ],
+        [ 'HAVE_IFLA_PARENT_DEV_BUS_NAME', 'linux/if_link.h',
+            'IFLA_PARENT_DEV_BUS_NAME' ],
         [ 'HAVE_RDMA_NL_NLDEV', 'rdma/rdma_netlink.h',
             'RDMA_NL_NLDEV' ],
         [ 'HAVE_RDMA_NLDEV_CMD_GET', 'rdma/rdma_netlink.h',
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index eafae78883..4eebec5223 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -113,6 +113,12 @@
 #ifndef HAVE_IFLA_PHYS_PORT_NAME
 #define IFLA_PHYS_PORT_NAME 38
 #endif
+#ifndef HAVE_IFLA_PARENT_DEV_NAME
+#define IFLA_PARENT_DEV_NAME 56
+#endif
+#ifndef HAVE_IFLA_PARENT_DEV_BUS_NAME
+#define IFLA_PARENT_DEV_BUS_NAME 57
+#endif
 
 /*
  * Some Devlink defines may be missed in old kernel versions,
@@ -1427,6 +1433,24 @@ mlx5_nl_netdev_info_cb(struct nlmsghdr *nh, void *arg)
 			}
 			info.flags |= MLX5_NETDEV_INFO_FLAG_PHYS_SWITCH_ID;
 			break;
+		case IFLA_PARENT_DEV_NAME:
+			payload_len = RTA_PAYLOAD(ra);
+			/* Some kernels do not pad attributes with zero. */
+			if (payload_len > 0 && payload_len < MLX5_PARENT_DEV_NAME_MAX) {
+				memcpy(info.parent_dev_name, payload, payload_len);
+				info.parent_dev_name[payload_len] = '\0';
+				info.flags |= MLX5_NETDEV_INFO_FLAG_PARENT_DEV_NAME;
+			}
+			break;
+		case IFLA_PARENT_DEV_BUS_NAME:
+			payload_len = RTA_PAYLOAD(ra);
+			/* Some kernels do not pad attributes with zero. */
+			if (payload_len > 0 && payload_len < MLX5_PARENT_DEV_BUS_NAME_MAX) {
+				memcpy(info.parent_dev_bus_name, payload, payload_len);
+				info.parent_dev_bus_name[payload_len] = '\0';
+				info.flags |= MLX5_NETDEV_INFO_FLAG_PARENT_DEV_BUS_NAME;
+			}
+			break;
 		}
 	}
 	*out = info;
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 6446df1812..39691569bc 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -56,9 +56,17 @@ struct mlx5_nl_port_info {
 /* Maximal physical port name length. */
 #define MLX5_PHYS_PORT_NAME_MAX 128
 
+/* Maximum length of parent device name. */
+#define MLX5_PARENT_DEV_NAME_MAX 128
+
+/* Maximum length of parent device bus name. */
+#define MLX5_PARENT_DEV_BUS_NAME_MAX 128
+
 #define MLX5_NETDEV_INFO_FLAG_NUM_VF RTE_BIT32(0)
 #define MLX5_NETDEV_INFO_FLAG_PHYS_PORT_NAME RTE_BIT32(1)
 #define MLX5_NETDEV_INFO_FLAG_PHYS_SWITCH_ID RTE_BIT32(2)
+#define MLX5_NETDEV_INFO_FLAG_PARENT_DEV_NAME RTE_BIT32(3)
+#define MLX5_NETDEV_INFO_FLAG_PARENT_DEV_BUS_NAME RTE_BIT32(4)
 
 struct mlx5_netdev_info {
 	unsigned int ifindex; /* [in] */
@@ -66,6 +74,8 @@ struct mlx5_netdev_info {
 	uint32_t num_vf; /* [out] */
 	char phys_port_name[MLX5_PHYS_PORT_NAME_MAX]; /* [out] */
 	uint64_t phys_switch_id; /* [out] */
+	char parent_dev_name[MLX5_PARENT_DEV_NAME_MAX]; /* [out] */
+	char parent_dev_bus_name[MLX5_PARENT_DEV_BUS_NAME_MAX]; /* [out] */
 };
 
 __rte_internal
-- 
2.43.0

