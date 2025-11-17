Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218A7CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 04:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24DA8402DD;
	Mon, 17 Nov 2025 05:14:30 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9A045402AA;
 Mon, 17 Nov 2025 05:14:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmLNR88ke9RqcLQwVuBo5lbKaF7G0zbtPqLQWt1Lsz2PecYUPnBXwRalG7A7yJfr9qjARwxZmbwjoG49vZDvoaM/0ZzMrJlQ/zR2HKC+/nHQwZ3/l4eErQmLnAqIOi4N6dcVXJxEn84u69dRpWfsIlXcQ0j3EoPoui6BV0I7e1xrOvG+66/z3tjiXqr4p1s42RIYHSB5xrL8KXWfrCXHVmNsosHZpJWSUKXQb6S77VHgZPsCM1ZyUn0CtSisj5CK1pJ1K8QX2cT0AwHjSx3MJatIH2d0Z0wBnBunh7tEJxfDqAg/TJP6vThCwNWC0FfHnSkIDmPXTmWQ3+BP6oAh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4oGqRJTRChpX0QUA7wHQBFl2CqNP0/rPP2bGx2VuZo=;
 b=ERDHnxbYZkkgQ+kckyL6ZH2tY7WXJGtaqdlkRegx6/kY48gkuEMfvAb2IsdeYNEqS/D8VmOdFbMwjUTSOQaCigNNqMeL0RCNS18wPltQVFI+S0CZ5tTUMAfvR7lOUJ6wrwcbsYpPGAns/in1F236yvar2eLlLzRYSwi2k/fZExW2uG8M9BfKSHHQGyyfnHFrv8DgnIIUilUuThnhB6poojzB6i5ngYB0SCfyiBwelLX3pi8EvU27spnvM7HPX5k5bdgbbMIWjxGGqgQzfCLyGIC+wLa/zTBlaa9poduiipASR21X5KnKvXVkVemhmf8eZgWH//bXWScwqByuLbpwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4oGqRJTRChpX0QUA7wHQBFl2CqNP0/rPP2bGx2VuZo=;
 b=I1JMF6wxAMvCRv1I8Lxz1GGex9gzw1X7SZ+ugNQQVmCww6cAz7GWdQdgleJXWWem/dCIupnV9kboNIA65O7kGv2TadOyayvFeK97JoQsvdkOK0bnX0Buzygf8/3mvCGIDblbe1hrf3AFdmfW7C6m0EODPCm2UdDyTixevE3SNHLXw8djPU1hgiPkHl4kcTF5pg6DRIwgVLuuwWXx1oMb4Ka2LH8cy6IiKKtH0jm6aOB2cbsW68t9eJlGRrg/4WLvFK5m3aHumGC0pis5RgB1Sk1jwd+D6MJabSys8ZiNFMmwHVI9OFLpPH1Pkw7DtcU/hP6IQfjH3ifVyE1Y4TobVA==
Received: from DM6PR14CA0070.namprd14.prod.outlook.com (2603:10b6:5:18f::47)
 by LV9PR12MB9808.namprd12.prod.outlook.com (2603:10b6:408:2e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 04:14:25 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::71) by DM6PR14CA0070.outlook.office365.com
 (2603:10b6:5:18f::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 04:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 04:14:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 20:14:09 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 20:14:05 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <stable@dpdk.org>,
 <valex@nvidia.com>
Subject: [PATCH 1/2] net/mlx5/hws: mlx5dr, fix the tag items handling
Date: Mon, 17 Nov 2025 06:13:52 +0200
Message-ID: <20251117041352.8136-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|LV9PR12MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8307aa-6fec-48a9-f2f1-08de258fcacd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sE9DxY2s90dF9bO8pWbEhEcmY26IoKvlJ0iVD3JUcA8+tjUlUOBTwPEDyhAO?=
 =?us-ascii?Q?Or4RC0Qpzf7b7EMcKzKRiAp6XRFuUxYkxX0hwXuQNRTGgDrrfSiC/ouDZdCN?=
 =?us-ascii?Q?vQXXNqYuKmggbYFE6g13zn5BSpcFJroG/ORJuavX6DibMci4zryEjw5tlwcM?=
 =?us-ascii?Q?vHUy6Z/3ahzcmprij0LvgFHwzV5+a8dT3It57yYHEXcPf/jyISf/x2CR6bd+?=
 =?us-ascii?Q?su4drTurKmS0k2GOeI9HqUA1XEZj3nz5RhvC+Jq+iRq3pk/8CaokzZ2zAlF/?=
 =?us-ascii?Q?ZLqtk7KXyajkILgSCSOrmFeVrjEvYRX+Vkd+1uGKYHXNsmKSKTGZdnBfbnbB?=
 =?us-ascii?Q?pW9s9skymPR8uLLT5QYrM/WrmnZTmvzZwLdIShzOgWibDUicjjcdsOB+NOze?=
 =?us-ascii?Q?cGMq/SSzDpNrOb8SVg1KNH1XIXA0GblIWywfDG94rlX62dcimnHaQocTR7X1?=
 =?us-ascii?Q?J7CURgEHKBb5wfkbevKgUbygRwN4/8XxYZdBQHyzG7PJcGa8qt4s8PVGtfNj?=
 =?us-ascii?Q?J+pmFoLML+1qb6IkzXc0jHPM3x9gDf3R4cmcx8f2cfkgDOsRa/iggIE6HYcm?=
 =?us-ascii?Q?vi9T3VYaAiphZEusl9Pdv3s/ffEolmY+b6+GTpio7K4i4fxjlqBKQWWEieZL?=
 =?us-ascii?Q?bmstPWRoVOrHCl6YdCE2oZ3E3QpoA2kS2qdnVzsV8uGCzcEECqw+59Ygjfl8?=
 =?us-ascii?Q?6Z1IP70uzvs5piOBMYw1ypnXFlmKGVNlgZuWLR8ho5Vz6G7vpU3BEtqZhwFF?=
 =?us-ascii?Q?vrc4XY//RcukVfV/YXxuVEqDX0OSYpyA2plHEZ81Ra65wDoGUC3En32YR5Oq?=
 =?us-ascii?Q?7lJ0nCujyimpieJfmj+ww986UqIqee3E9ulDT4H+OCbXiHs5gPWKZlMNZnbi?=
 =?us-ascii?Q?qa4pcYSZUCoiR8h1IPTFoqVWfzFNZcm47f6SlBkEf/HO616TxVuKO1gFUZjs?=
 =?us-ascii?Q?wm4atnzhNIkoLcmKhjEdBkfcrqx+RB+qJYbTaiPs5ZNi+poM8IgqiZQFqUBs?=
 =?us-ascii?Q?DHznLsETkgHRxh7tS9Fq7AXSUqzt6SHAmr/m3YrtkIoxv+QAbQyt+RjMG8fn?=
 =?us-ascii?Q?arr03j5S9+ZV8xHKsofD61L9KADDpD4DBpMbHxACB0XYloagrGLOqAFegY8J?=
 =?us-ascii?Q?cJui8NShwAQEwUif+p5LYHl3x/gA6Zh//FKEa3w5jNWv5jRBHrrl60cguKR+?=
 =?us-ascii?Q?KULQCzuQhhTTxKrstznmSrKVMEZb52QnMhe2Nja7QeFy8RtodSWLjCBn2yuh?=
 =?us-ascii?Q?xOlb3+tCkkXGXlJooc4zso9Zo4/D85tge+9TQVkOY9YZZCcZkV4vL3QUbYpJ?=
 =?us-ascii?Q?caPnl+2JZPeUJ6T5tusIg7+N8mlX4ALeLqBm59o+YEoagVauyLEquAKiJtwe?=
 =?us-ascii?Q?B8DHd0Xv6N/JdzRH/qLIobgCVeZApLbt0mfjp1CXpVVfkJg6vKh4MmbosIT0?=
 =?us-ascii?Q?TH8lz5/J1FNMJj4RQpj3vweIM2pRoLthallRDW9z0v6siM34Nxejptss+7Te?=
 =?us-ascii?Q?jePUWfq9rb98AE3clGZIaU/Zm9LfOAxwVjlYLrJETIkcLy8+2em+ARdtzQjY?=
 =?us-ascii?Q?cLi+Wz90M1j1hiQiH4A=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 04:14:24.4770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8307aa-6fec-48a9-f2f1-08de258fcacd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9808
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

The structure definitions of "rte_flow_item_tag" and internal
"mlx5_rte_flow_item_tag" are different. The handling of them should
be split even in one function.

It will check the type and then convert to the proper structure.

Fixes: c55c2bf35333 ("net/mlx5/hws: add definer layer")
Cc: valex@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 32 ++++++++++++++++++---------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index afa70bf793..010952eb20 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -213,6 +213,7 @@ struct mlx5dr_definer_conv_data {
 	X(SET,		mpls_udp_port,		UDP_PORT_MPLS,		rte_flow_item_mpls) \
 	X(SET,		source_qp,		v->queue,		mlx5_rte_flow_item_sq) \
 	X(SET,		tag,			v->data,		rte_flow_item_tag) \
+	X(SET,		mlx5_tag,		v->data,		mlx5_rte_flow_item_tag) \
 	X(SET,		metadata,		v->data,		rte_flow_item_meta) \
 	X(SET_BE16,	geneve_protocol,	v->protocol,		rte_flow_item_geneve) \
 	X(SET,		geneve_udp_port,	UDP_GENEVE_PORT,	rte_flow_item_geneve) \
@@ -1796,22 +1797,26 @@ mlx5dr_definer_conv_item_tag(struct mlx5dr_definer_conv_data *cd,
 			     struct rte_flow_item *item,
 			     int item_idx)
 {
-	const struct rte_flow_item_tag *m = item->mask;
-	const struct rte_flow_item_tag *v = item->spec;
-	const struct rte_flow_item_tag *l = item->last;
+	const struct rte_flow_item_tag *ev;
+	const struct rte_flow_item_tag *el;
+	const struct mlx5_rte_flow_item_tag *iv;
+	const struct mlx5_rte_flow_item_tag *il;
 	struct mlx5dr_definer_fc *fc;
 	int reg;
 
-	if (!m || !v)
+	if (!item->mask || !item->spec)
 		return 0;
 
-	if (item->type == RTE_FLOW_ITEM_TYPE_TAG)
+	if (item->type == RTE_FLOW_ITEM_TYPE_TAG) {
+		ev = item->spec;
 		reg = flow_hw_get_reg_id_from_ctx(cd->ctx,
 						  RTE_FLOW_ITEM_TYPE_TAG,
 						  cd->table_type,
-						  v->index);
-	else
-		reg = (int)v->index;
+						  ev->index);
+	} else {
+		iv = item->spec;
+		reg = (int)iv->id;
+	}
 
 	if (reg <= 0) {
 		DR_LOG(ERR, "Invalid register for item tag");
@@ -1824,8 +1829,15 @@ mlx5dr_definer_conv_item_tag(struct mlx5dr_definer_conv_data *cd,
 		return rte_errno;
 
 	fc->item_idx = item_idx;
-	fc->is_range = l && l->index;
-	fc->tag_set = &mlx5dr_definer_tag_set;
+	if (item->type == RTE_FLOW_ITEM_TYPE_TAG) {
+		el = item->last;
+		fc->is_range = el && el->data;
+		c->tag_set = &mlx5dr_definer_tag_set;
+	} else {
+		il = item->last;
+		fc->is_range = il && il->data;
+		fc->tag_set = &mlx5dr_definer_mlx5_tag_set;
+	}
 
 	return 0;
 }
-- 
2.34.1

