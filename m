Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AFD109E521
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 21:54:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A14A1406BC;
	Wed, 25 Mar 2026 22:54:53 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by mails.dpdk.org (Postfix) with ESMTP id EF1014067B
 for <dev@dpdk.org>; Wed, 25 Mar 2026 22:54:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpzK+clxKvMUW1/hV+VV0Lm7kUemBso21rpTXJtpwoTENyBg6twnuPp9maT39v3nfCLl93LoF5cadzbKXrfz0hJi7OzBX9ocPjmtx820QepkGDVDOImQceKZPTiBMH6dq5Coi6wbF1MDSY1u5NsuyV5ASmZfsmw9TI7WW60e2c9B8z5U1uxi7ApELXHtM1f597+WjB8MQA+pMa4WIV2Zw7k3mhy9Re3s8iBZUG/NKI0UwLJz8pNgfFZSjh+G9Uu9Cz82ncZiKdolCSz5slWRUdxZO7dFAbyrEKRT6BXrWzVCWQ4Ul+CNd+KQ1bLiuYE9iYw0+/XT/GCiiV8wcpxc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb6yVY1fLGl4XKubzfZ9+nw37icwjsKm4rspk0KiG+o=;
 b=bEjXDLDRoZYrwG+uZtCTM54csfjzVQw4WepW3PO6k+o6KXmUt5wUIyeeUimDw2UCtsB+2FtYRCIIewjLBOervCK8S+iGOpSOo+2fkNeIFJtzQVYwzMbogGCXPOuVPedWGZH5pLW27gHXHrEMNnGEonEedMHBnbzH7520qoofajCv8gbAdcFV5/oWiO/B83ATEGeT8exfvV37KDbAXLyqcYVOJn5M5xhtG8IajqGAsplOgOg0auVWs94ZX8SXgcyP9vjDC9Ycs7caKUtS7790bVyEzzKLIfaPHPdA9p5EHfXWhUWF6aVhKqaB1Rit20x84v3bfjglxIQ3M5rfbXG8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb6yVY1fLGl4XKubzfZ9+nw37icwjsKm4rspk0KiG+o=;
 b=uX1K+srl676SVVekaUvgAN/MwfDNcA227C0/lgqJoAY3uzYN6dpRQpvfvY0rtGTMIzu6EtMQCtdTFb1Ixn7Pu9LoXsjYuE1RAjVtaVSHTwkt6jfbkB3+yT6CMJn29AFVhQ4nSkscsq0EKit4y4TPJR80o1FKtE+bmDLc38Qn7Z0YWyFVPWnc0BjghoKpSVdf3moHcBpUPVdHSpWHV+O9cZWkAYUnrZU/yLkn8NemPopdtfggh0LmDg7kWlAmFdabJHQH6CVZFgSayfvGlARJhmy/7oOjfKI3ChAMisrnMQRQCd4yUGkLumSzs9vGMWTZ99iz6Yioqh6974K5Jpqc0Q==
Received: from BYAPR21CA0012.namprd21.prod.outlook.com (2603:10b6:a03:114::22)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 21:54:45 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::4b) by BYAPR21CA0012.outlook.office365.com
 (2603:10b6:a03:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.6 via Frontend Transport; Wed,
 25 Mar 2026 21:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 21:54:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 14:54:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 14:54:32 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 14:54:30 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: improve error when group table type mismatch
Date: Wed, 25 Mar 2026 23:54:25 +0200
Message-ID: <20260325215426.9519-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eebbb60-e631-4296-4b94-08de8ab92073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ncUOWluKSttMhHuHtG2oC53di/381gDxOJJZS7pE7rkCeA19BwSRGDcyZLH4F6YfeRpCx5yfDb3dEpB6o4c48X7GZSjMlaFUULEGg/8nCjbbwhpd+f+PLZ6kiWc93uvrACW50Cd7Dyt+NRlsBfkTFzLe3NvmqzpG8s1oOhJZyXPWb6vPKnPPkGZQfL2Xgu9mbkr8KAaLoIipxiJSESgzxFStseZIlFAlFv67NKfWwVX4tZFm/LttMqyWhzggJpOYdXWbzXtnwQ+6OUIss1i0aca4SGjaItXfHevYzLVTWOJ3vb5DGycmgsdLaiKi33/h73xW8cMd9EEr1k5zXw7Y5BQczgiaG4ehRdsSj1hi1RJNoranwK7f6p+U/dMikyfwWW2y/old5ZpK56iYpH4zLGSH+xPfg71L9nVd+utuI9NJjF3eT9qZs+pZL6TEABy7PPU1jT/BjgWqJ7sX/kVHZEgyUgJsBd0ZsZsGZu5SHdvBOAZ9S64k56/LYRbH9Dz2WD974b+tqMpljcEmw8b+WeWrSJliZwJELBkRjW2zFle1P7PRtaUkjTQenSA1UI5R29ZIq4cF8xgMDjDWsgBhlwk0CAL7GBEWMf3RQ8AyCzFKD12BjiUhIgtt2ekWqv2z1PlwrCighYkSDHT9cEFMdjjsw4mPJWOqTx99C9t1Q9sbvU3yoyvp4uQrtd4F+mpEThsLE3+hiMJVh/xeNyOMbxjVvNvfCpK/27Jpa3EIlOJksttAVOIP27B/eNoFo4bLBmxguP52dGHegoz9M/akLQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XtIlZs93VP9KIkXMiBF05xIOYErrBrue97HW267jE2hvMIcjouWQeHlaxivTEPBu5lbSUIZpjEmAlU14RXhpRULmIr+2ulGCGqCkZxNaUIgD66P1kTK8CxODO52PHg8qzh01U4x3ajBJCNrVSDX58b5LUfcTBCi5R65QYAFR0ImVo078xNAsa2AcICJ0tynAaVTrsnCbGM+UWtcLllyWupC5QSrWHXjDgO6SM5b7PCy/j0xJKjrzBCkQiJJIROcCaeSsEa25JYN2t3M7EDvCQgWBY8FYXQuWk3qhQE0YNLrBqEUY6szr5QyxrqwPSXUZvkSxCefBJ/2DXifm/naWsRADuCUOsYATFtthFnZlQowdTqWxMKqOtgCEEewb1VdD1whuAs66lWuJkrWOhOkkpT1kBaxiVsTfZA6IMoAN1ML7KVBAuOTDyoelrZz7NevK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:54:45.0215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eebbb60-e631-4296-4b94-08de8ab92073
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
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

HWS fixes a flow group's DR table type (FDB_UNIFIED,
FDB_RX, FDB_TX, etc.) on first use.
If a later table uses the same group with a different domain
(e.g. transfer wire_orig) the driver returns a generic type mismatch.

- Add mlx5dr_table_type_name() to map table type enum to readable strings
(e.g. FDB_RX(wire_orig), FDB_UNIFIED).

This makes it easier to fix ordering issues
(e.g. create wire_origtable before the table that jumps to the group).

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst        |  4 ++++
 drivers/net/mlx5/mlx5_flow_hw.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 9dcc93cc235..a350fdaa160 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -2493,6 +2493,10 @@ DPDK       24.11
 Limitations
 ^^^^^^^^^^^
 
+#. With the async template API, the target table must be pre-created
+   before adding a jump action that redirects to a specialized table.
+   The jump will fail if the destination table does not exist yet.
+
 #. With the async template API, jumping to a template table
    with ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG`` specialization
    from a template table with a different specialization
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 041066a94f7..a341cdd34d4 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -322,6 +322,21 @@ get_mlx5dr_table_type(const struct rte_flow_attr *attr, uint32_t specialize,
 	return type;
 }
 
+/** Human-readable name for mlx5dr_table_type (for error messages). */
+static inline const char *
+mlx5dr_table_type_name(enum mlx5dr_table_type type)
+{
+	switch (type) {
+	case MLX5DR_TABLE_TYPE_NIC_RX: return "NIC_RX";
+	case MLX5DR_TABLE_TYPE_NIC_TX: return "NIC_TX";
+	case MLX5DR_TABLE_TYPE_FDB: return "FDB";
+	case MLX5DR_TABLE_TYPE_FDB_RX: return "FDB_RX(wire_orig)";
+	case MLX5DR_TABLE_TYPE_FDB_TX: return "FDB_TX(vf_orig)";
+	case MLX5DR_TABLE_TYPE_FDB_UNIFIED: return "FDB_UNIFIED";
+	default: return "unknown";
+	}
+}
+
 /* Non template default queue size used for inner ctrl queue. */
 #define MLX5_NT_DEFAULT_QUEUE_SIZE 32
 
@@ -5312,8 +5327,17 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 	/* Verify unified fdb sub domains consistency */
 	table_type = get_mlx5dr_table_type(&flow_attr, specialize, unified_fdb);
 	if (table_type != grp->type) {
-		DRV_LOG(ERR, "Table type (%u) does not match group id (%u) type (%u)",
-			table_type, grp->group_id, grp->type);
+		DRV_LOG(ERR,
+			"Group %u table type mismatch: group type is fixed on first use. "
+			"This table requires %s but group was first used as %s. "
+			"Create tables with transfer wire_orig or vf_orig before tables jumping to it.",
+			grp->group_id,
+			mlx5dr_table_type_name(table_type),
+			mlx5dr_table_type_name(grp->type));
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_GROUP,
+				   NULL,
+				   "group table type mismatch: type is fixed on first use; "
+				   "create transfer wire_orig/vf_orig tables before tables jumping to it");
 		rte_errno = EINVAL;
 		goto error;
 	}
-- 
2.21.0

