Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94709C021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 10:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 603A240A7D;
	Thu, 27 Feb 2025 11:45:57 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by mails.dpdk.org (Postfix) with ESMTP id 9A7574064F;
 Thu, 27 Feb 2025 11:45:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBUJlUR7K/rvFxqccfPKClzOwegcL5xi6hTWqfCRNyPAjRcGK9FzQiE+D0XL9kjU5d9N6j+iV6vCJX8NvJm7pid4+zx9MVCtwFPWLElIiyzPBImhB81l/UdEI/uualQuFvyDwBAgTNPEi1sbDHMQuI+ffpbutSsa6ieQ1wZLcfNfPOKkB6xVCXsaBr+n9HqwaXapAbVsX288Ez5vvPMu9C1grtARCF3qnhFchJd2NdqU0j7vCOkCntN9uQ1xCq8UhCSUqyzB6iSxBXj4fcE6MblM+5tnitG26r49mEK7HNMdyPmIMgtywMhOyyiKPgP+cSFcS3rDZI68o1eMzH6z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/OHUckvP9luLAbDpg9xLcHyTWgPLLV15Uzej64nwyo=;
 b=rzdJ7srs/d4el0Y1t2zGxnZYLwDKbwe7MbSQLb1tVEfF/CWNqu9Pag3FyuDNV6uOHhT6GFfQC1YV/h0ZPicN8rL6gvtZQqkQA4mGghs3XnhxeuiP3bMZaHjpocgZQ/Yfe/6qId/lHmNPx1fvplmbxL7f6AL5AxfDu8t6Dni9DU3S/hphT8x2jJb5klTrGHF4pjkjBW33oVT4qyK6WJPRlSNhIsWkn4EAvi17ZazZDjWQvHsES+QR5AaHWYckuPfznkv5SqecjJmMxmaHOAJ/lzEgsI9W2gY+pVTbqHRZ6QqW7JlcFjGD/NzKUxUGu+OfG2sayMYik4JkNiqfTFiQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/OHUckvP9luLAbDpg9xLcHyTWgPLLV15Uzej64nwyo=;
 b=Q0DXWStcF6o38RKaDYofqk6KQuf0W0N7TPz8Jkr3dLMrMrZDFNbUmqXadaTgtvReDZgXlQ6lq/wUcxaX7XYoeryhrVjE1Kx+L/NHEeAet5xXJH4oFHPGWsUzEAijvuyPYmQ0JTr4XF8nscVOytRDCHxJNL8VFU0gFqdsbjapaYAQiulxWATgIfdtm5JNSFzA6MRuJfcPREcrlh3PDh36mgljEr3MAVIepwGXuiDMWHRB1Ii+gf6Z7A05TUv39uOOSLE6+6uMjynTAyC468+i1RMDEkHJeK+LsRFWpKNDWjsv4sF6chFLpgtxGjkLeyI5smqKFJPcigXzUER6J/H2jg==
Received: from SJ0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:a03:39e::29)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 10:45:51 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::7) by SJ0PR03CA0294.outlook.office365.com
 (2603:10b6:a03:39e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 10:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:45:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 02:45:41 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 02:45:40 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 02:45:38 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: [PATCH 1/2] net/mlx5: fix non template set VLAN VID
Date: Thu, 27 Feb 2025 12:45:27 +0200
Message-ID: <20250227104531.93668-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5526c41a-21b3-4aee-db54-08dd571be73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QsTv1nTtE6j23Ot68e1QjGAZwlH4NvyKmrUGWwX3F0NcRWEq/5P72Au362QI?=
 =?us-ascii?Q?+91Oj1CHqYgVUuqnuDlxecpR6GZKekErF1WKPch3ykmmWgrNv+Kfse/l6iM7?=
 =?us-ascii?Q?YITWdDRU+jMlCM3E6vAqvneqJXi3UeXSmzWEckJ+fuLR2LDSAurMKMG0teku?=
 =?us-ascii?Q?ovjlOYSCbwYN0oFZ10ZKQwdrotnkFhwaUhHyC7bLLLVTqRjyZGOUN3h9Fson?=
 =?us-ascii?Q?njd7VmQHxkTjct+IxyQykbM0M8dk2fUCeHanmTQsO5VpEpMEZzy8bzuZs80R?=
 =?us-ascii?Q?rpSnMXGKKzRXv1zYc+oB4Zx263u25RXxmKQSh8uHwY0ZeuUcviz1YzLiyF5I?=
 =?us-ascii?Q?rM9NGjYTZ8xSCjYoP69ZWBmF1UtpL9M/hT8V1CZtSBrO3Fez05Q5bJDUn1bz?=
 =?us-ascii?Q?EOaGEULdom57+zgRTA5l/seyvk/PC+ekBLXcOpwPNN4SH1seaLFAgc66vd/j?=
 =?us-ascii?Q?744At5w4+uEs3bE8huxqUyBt18ML0+b7XsZfrLYkjHyTVa0INpsuq6SrzpZE?=
 =?us-ascii?Q?KzS23q4hqRv6JzHyj/ZJH0V08+1Z7T8iRgLEUsatHulovWqqL/OGoyrN82c/?=
 =?us-ascii?Q?3RDNCP5AWj1Hzszcr7MZFq3bPfBN8GOzP+iCehp40WZUtGtdS8yXt7+3kuwx?=
 =?us-ascii?Q?W6V1l74x2SVMmoOSMsN2HPTwAeE33L1aAii/lMN8aB+jhZmfyVr11QaOGc5V?=
 =?us-ascii?Q?v19ky1/3tUL/wyN47PMXe88RnnBjRqVCVlld0FrIPq8glw2XccQ/OAJdi6na?=
 =?us-ascii?Q?wSXWk6vEp+G4e6MFwtzY5D3RyiRbC5mv/8wNJyqM6F2okQ+3D3UJZ9Xs1OxP?=
 =?us-ascii?Q?LjEGFXV+puMAMm6zH2vkiwpB98AGajikY1B1o90jH45aTuDyOkdPBrD0Tlhz?=
 =?us-ascii?Q?pv6AK5F06dP1iI4Xy6wGZHKo/YBiGcF978cdIMmvUyLHsNJxdRqVYwB4eQHM?=
 =?us-ascii?Q?UmjdiGGLGmwQ9hridA4TeInhk8ZNK49bYFc8+2igGLNL52yymE8oWFjPGOku?=
 =?us-ascii?Q?tU0uma9EuSxc50doHqAHKzGMgw0NASptwqDz+zJVB4sG0JcwFdsIrGLvPPdh?=
 =?us-ascii?Q?KhTVPj0ITJzqPIvUijGipTPGY4Te2++YmcRe1yU4awMLRQZ+aD6PbdGe0btR?=
 =?us-ascii?Q?rObEltsLXOltZxMHiWt9ot7I71QAKu133JTsNajv+4FjaqgWdD5Itcm+nrLl?=
 =?us-ascii?Q?t/gGSCDMcAWyAKn1XAKmADpqWAWNlBqXZPsrVKf4EVQLi+0/1bnLxD3tUrDL?=
 =?us-ascii?Q?frIYbv4Zr2YlJZf3tqYsxyzfAamtPa1X7v8AvUpRudEnZJ+2nd5Ia6FNHcJJ?=
 =?us-ascii?Q?vuKokigcUpnduFNf2visQu0g2K/xA2VJ9P47RwUvPwfa6UlL5T/y2iZizmye?=
 =?us-ascii?Q?2g8muMeEqOuIseAseGy4Zui8T5DSajvKum2ymJTz2Q7BmyGmgqUuae4etygy?=
 =?us-ascii?Q?py5sDAdBKUZeXW8/5Jyf9LJxhCLj7TUAdeBddVA/vmbOBW568Q/QsMUZma7T?=
 =?us-ascii?Q?vVLwU3PpyvPFgBI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:45:51.1515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5526c41a-21b3-4aee-db54-08dd571be73b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093
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

Support set vlan vid in non template on top of HWS.
Update relevant return errors in the relevant functions to avoid crash.
Mask the vlan vid action in non template mode
such that the action template create will use the vid value.

Fixes: 00a0a6b80674 ("net/mlx5: support indirect actions in non-template setup")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 3bfb2f35c12..ec047e855e3 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -714,6 +714,9 @@ flow_hw_action_flags_get(const struct rte_flow_action actions[],
 		case RTE_FLOW_ACTION_TYPE_OF_POP_VLAN:
 			action_flags |= MLX5_FLOW_ACTION_OF_POP_VLAN;
 			break;
+		case RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_VID:
+			action_flags |= MLX5_FLOW_ACTION_OF_SET_VLAN_VID;
+			break;
 		case RTE_FLOW_ACTION_TYPE_JUMP:
 			action_flags |= MLX5_FLOW_ACTION_JUMP;
 			break;
@@ -7811,22 +7814,23 @@ flow_hw_parse_flow_actions_to_dr_actions(struct rte_eth_dev *dev,
 	return -EINVAL;
 }
 
-static void
+static int
 flow_hw_set_vlan_vid(struct rte_eth_dev *dev,
 		     struct rte_flow_action *ra,
 		     struct rte_flow_action *rm,
 		     struct rte_flow_action_modify_field *spec,
 		     struct rte_flow_action_modify_field *mask,
-		     int set_vlan_vid_ix)
+		     int set_vlan_vid_ix,
+		     struct rte_flow_error *error)
 {
-	struct rte_flow_error error;
 	const bool masked = rm[set_vlan_vid_ix].conf &&
 		(((const struct rte_flow_action_of_set_vlan_vid *)
 			rm[set_vlan_vid_ix].conf)->vlan_vid != 0);
 	const struct rte_flow_action_of_set_vlan_vid *conf =
 		ra[set_vlan_vid_ix].conf;
 	int width = mlx5_flow_item_field_width(dev, RTE_FLOW_FIELD_VLAN_ID, 0,
-					       NULL, &error);
+					       NULL, error);
+	MLX5_ASSERT(width);
 	*spec = (typeof(*spec)) {
 		.operation = RTE_FLOW_MODIFY_SET,
 		.dst = {
@@ -7859,6 +7863,7 @@ flow_hw_set_vlan_vid(struct rte_eth_dev *dev,
 	ra[set_vlan_vid_ix].conf = spec;
 	rm[set_vlan_vid_ix].type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD;
 	rm[set_vlan_vid_ix].conf = mask;
+	return 0;
 }
 
 static __rte_always_inline int
@@ -8104,9 +8109,11 @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
 								   tmp_mask,
 								   &ra, &rm,
 								   act_num);
-		flow_hw_set_vlan_vid(dev, ra, rm,
-				     &set_vlan_vid_spec, &set_vlan_vid_mask,
-				     set_vlan_vid_ix);
+		ret = flow_hw_set_vlan_vid(dev, ra, rm,
+					   &set_vlan_vid_spec, &set_vlan_vid_mask,
+					   set_vlan_vid_ix, error);
+		if (ret)
+			goto error;
 		action_flags |= MLX5_FLOW_ACTION_MODIFY_FIELD;
 	}
 	if (action_flags & MLX5_FLOW_ACTION_QUOTA) {
@@ -13744,6 +13751,10 @@ flow_nta_build_template_mask(const struct rte_flow_action actions[],
 					action->conf)->definition;
 			mask->conf = conf;
 			break;
+		case RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_VID:
+			memset(conf, 0xff, sizeof(struct rte_flow_action_of_set_vlan_vid));
+			mask->conf = conf;
+			break;
 		default:
 			break;
 		}
-- 
2.21.0

