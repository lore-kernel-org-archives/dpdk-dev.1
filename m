Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B412FCEE8A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 131FA402E4;
	Wed, 25 Feb 2026 13:00:13 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010057.outbound.protection.outlook.com
 [52.101.193.57]) by mails.dpdk.org (Postfix) with ESMTP id 459D3402E4
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVNkmNN7CPBCQB3jWZtsrzHVPc935hQBM9Al4kFRcr9ctvBquRsZFSjCAnKi9cDI5Sxi3Lmi9Sk2IAgnimPdaKhJRWLMMH5DVAhJ0fSNaVXXjzhYY5+rHQ4HFb2Q9TCQX6/AFRLueNkMMKd26nGvgQZpHOXJD8os5pPRhQQyMTswyEvM1tjonNFH+8yp+a9jGU+64wEu/PKmmskdvR4SglBvBp1AfVoPLYsTTpPY51sUTbhHXWLsd3qi9BVG1qNMBKE4uIKdmYsyHs2IBCmW7Sk9sFy2H5TUYMXRCMkI5eb5fuA++lJVx+tDFkiYyKx0jkN4IlijnBkh23MV7CtrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4/1LJCI6Knu6r1F39Slg5VD+x/PAw8cC4dIGXHu9e4=;
 b=IAnC1aNGlom+Hjfq3IGPOZ557yrg3zSmUoT20a0tRGbwDgCprTc1WnX1kMhPaFld5103ZniNAqHgYP5IbinS65O90ebGMpb4iRO5wrLsA4zgbJ6iv1TJq60RGX3lXs78BdIxkXm+F1zBtlex4HM+PuhDaXPLdH2l09QWzchVk8FKbLGiNQQ+wqmh40YhWSSSlrEaPoPPfXgmhqJWFwnTqFiODhUANw8vLQHJDphkLwcbjymZ84bDkHYUPeGnkMIjgCR14OB69Xc5pA1fIc61b7L2YJz/kaEEIPeyDw+MvGckwzknQLCHeLUwnGgDRuDqlBesz5VtZGMpgvrDMsy5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4/1LJCI6Knu6r1F39Slg5VD+x/PAw8cC4dIGXHu9e4=;
 b=msvM4N8p5ycB0JGYt213BkESi5n/ppjn0UVZvDSqqTkM9yFUWT/DHjQgggAFQ42Kv2wuNcgQ6GmzqonkCUeCwNoc1BTMcEliD4vY+q2bzI7uclO2ZXUgasKc7m3GR7meztatx6mbCWXGYHO3dpyGgF1YrZ7ccDEZ33AF3wlAGEsFL739oQgw7CLIbYMvIxb9mQs2o96wRH+O8rgxkP1pPGSj9sGgr3WBXFBFu1nJ8SRGPyAK02GjBz3PvBzl+Kn57efFZYmw4iJdaE7wjeg+mAYppRX4AjJeU1BPkB8vn77NAeHJxCyvu4Vs69eYOM7NFHsOcmWANkYUKM0nMPF8Mw==
Received: from BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::10)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:00:07 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::83) by BL1P222CA0005.outlook.office365.com
 (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Wed,
 25 Feb 2026 12:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 25 Feb 2026 12:00:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:53 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:51 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 2/9] net/mlx5/hws: add table type to action flags conversion
Date: Wed, 25 Feb 2026 12:59:10 +0100
Message-ID: <20260225115918.233843-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225115918.233843-1-dsosnowski@nvidia.com>
References: <20260225115918.233843-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: b33eab9c-a6c0-401d-4042-08de74656aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: /CfHEPAhHjp1uMyw/EKlBLlh4kzr2sxhN5fFi77mTXQm3MAIF0cN/odm04otweWx03VcPONbhVkpMyO8Y/SemfvClDuzJZ/2R8nF6KTKfSTzQHVgPnOyn4rR1IkztFWt8WLygipEtEDfH8LeFv4XqjUEHLBw2fV4is+JlJ4UMPKVhxUlkBvfpT3WdseC09U/0NzRqkjwdIZ8XAT9sX5jOaRit9/vP3cYjuTwIOrc7SP1NEz3DBALMB99DUl0SQQksPDdUavocm92NAnKKicKBjNJPKeBCpZZIDgU4K3Fq5SOOT/Gkm8chFKSw9adGozzhE6mL3Ia/30/BcRgod7638RlHC0rh3IM8liGbuoDXV5MKjEvlNLR8Suq4ZTfcAnUPTCvZm+nvFyPD514lylJPTPXheNiQwgHS8APmdtI5NWNG1ndBnEaCavxd0v6QRzbkS+aE4GoEPJkavOzRYor2uZ5eWFR/FMw2vNJDLGolbmfSU1OywoVCUEa5hiBxJPB2fXC64iEtLPuvFDzMfh2bbcxVELa2Km/XLzqWgepbj/OR5PhpBstbiSTwV7JmjPr5dAnpJTg9w6A+NZBHZLgvR8jS8OwSwUpOqqjPOZqu3mjLxo5wUrq9I+g+6oEqFUeniBysHqgpwcgk/wtxIWVU75XDGzEyXDjD6St+Q8HiTVgC1bSOfOsx2CYxcU71UCm2IekkfKKAoIE04BAf4vjmOWMfwxRJwSFefdyG28+HuXrFUixXa7mlKZn2grlowSDgbFLi+AwDXxApAY8rcuDXaFXplEVCwwJ6OkboHU8+AtMxvnbmfBdzeKnPJgcFMGwMMuK7UpMz8FRHtAq30CRng==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UrSWVPPgYMB4nMLcDj9zP0Hsqi9K50GDkCn6MUElUradaM/iZw+IV5BQubKAOekpmVeqqMXtslELzPa3WNZpGovN8iPQH1G7Uu2fR1rR7b09xxaMU68kYHvh6qQlpUyxmFnDg+Z4YdQUdj1vsLRNKMsxrxz2XX3z5dQgzk/9QtLGitVLWjnTqWwZ58XkTHRSZGd2RrENMURxECGLf7Ajo5uRD44tx+tDYHUwsfasOBQIGYjEt20+5Jv4UgT4O4c7H47sFdeS9DwTfTWfFPoC/NsNcV1K5HovkHyRvYcYhFRgVRSIV+3Mx+7SgeBEb62otodrOCVsEGQURi1mPsB+I7H6Xlyaxos3HHD8XgNyPOHN0rQcOg8FvALaMqzhHKvreuumpJEHakQ89gv7GClUjo+ajRJ0EPrgKNFyU7Uz9qYwbmlsPzXCc+8QUFDZ1ao5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:06.5582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33eab9c-a6c0-401d-4042-08de74656aeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

Add function for converting HWS table type to corresponding
HWS action flag for both root and non-root tables.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Ori Kam <orika@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr.h       | 16 ++++++
 drivers/net/mlx5/hws/mlx5dr_table.c | 75 +++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/net/mlx5/hws/mlx5dr.h b/drivers/net/mlx5/hws/mlx5dr.h
index d358178e5b..078740a530 100644
--- a/drivers/net/mlx5/hws/mlx5dr.h
+++ b/drivers/net/mlx5/hws/mlx5dr.h
@@ -369,6 +369,22 @@ mlx5dr_context_open(struct ibv_context *ibv_ctx,
  */
 int mlx5dr_context_close(struct mlx5dr_context *ctx);
 
+/**
+ * Convert given table type to corresponding action type.
+ *
+ * @param[in] table_type
+ *	Table type.
+ * @param[in] is_root
+ *	Whether table should be considered root or not.
+ * @param[out] action_flags
+ *	Corresponding action flags will be written here.
+ * @return
+ *	0 on success. Negative errno and rte_errno is set otherwise.
+ */
+int mlx5dr_table_type_to_action_flags(const enum mlx5dr_table_type table_type,
+				      const bool is_root,
+				      enum mlx5dr_action_flags *action_flags);
+
 /* Create a new direct rule table. Each table can contain multiple matchers.
  *
  * @param[in] ctx
diff --git a/drivers/net/mlx5/hws/mlx5dr_table.c b/drivers/net/mlx5/hws/mlx5dr_table.c
index c1c60b4e52..41ffaa19e3 100644
--- a/drivers/net/mlx5/hws/mlx5dr_table.c
+++ b/drivers/net/mlx5/hws/mlx5dr_table.c
@@ -4,6 +4,81 @@
 
 #include "mlx5dr_internal.h"
 
+static int
+table_type_to_root_action_flags(enum mlx5dr_table_type table_type,
+				enum mlx5dr_action_flags *out)
+{
+	switch (table_type) {
+	case MLX5DR_TABLE_TYPE_NIC_RX:
+		*out = MLX5DR_ACTION_FLAG_ROOT_RX;
+		break;
+	case MLX5DR_TABLE_TYPE_NIC_TX:
+		*out = MLX5DR_ACTION_FLAG_ROOT_TX;
+		break;
+	case MLX5DR_TABLE_TYPE_FDB:
+		*out = MLX5DR_ACTION_FLAG_ROOT_FDB;
+		break;
+	default:
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
+static int
+table_type_to_nonroot_action_flags(enum mlx5dr_table_type table_type,
+				   enum mlx5dr_action_flags *out)
+{
+	switch (table_type) {
+	case MLX5DR_TABLE_TYPE_NIC_RX:
+		*out = MLX5DR_ACTION_FLAG_HWS_RX;
+		break;
+	case MLX5DR_TABLE_TYPE_NIC_TX:
+		*out = MLX5DR_ACTION_FLAG_HWS_TX;
+		break;
+	case MLX5DR_TABLE_TYPE_FDB:
+		*out = MLX5DR_ACTION_FLAG_HWS_FDB;
+		break;
+	case MLX5DR_TABLE_TYPE_FDB_RX:
+		*out = MLX5DR_ACTION_FLAG_HWS_FDB_RX;
+		break;
+	case MLX5DR_TABLE_TYPE_FDB_TX:
+		*out = MLX5DR_ACTION_FLAG_HWS_FDB_TX;
+		break;
+	case MLX5DR_TABLE_TYPE_FDB_UNIFIED:
+		*out = MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED;
+		break;
+	default:
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
+int
+mlx5dr_table_type_to_action_flags(const enum mlx5dr_table_type table_type,
+				  const bool is_root,
+				  enum mlx5dr_action_flags *action_flags)
+{
+	int ret = 0;
+
+	if (is_root) {
+		ret = table_type_to_root_action_flags(table_type, action_flags);
+		if (ret < 0)
+			DR_LOG(ERR, "Cannot convert table type %d to action flags for root table",
+			       table_type);
+	} else {
+		ret = table_type_to_nonroot_action_flags(table_type, action_flags);
+		if (ret < 0)
+			DR_LOG(ERR, "Cannot convert table type %d to action flags for HWS table",
+			       table_type);
+	}
+
+	return ret;
+}
+
 static void mlx5dr_table_init_next_ft_attr(struct mlx5dr_table *tbl,
 					   struct mlx5dr_cmd_ft_create_attr *ft_attr)
 {
-- 
2.47.3

