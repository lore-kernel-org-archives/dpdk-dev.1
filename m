Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAC1C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 19:49:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6674D40613;
	Fri, 25 Apr 2025 21:49:53 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by mails.dpdk.org (Postfix) with ESMTP id 030AB4025E;
 Fri, 25 Apr 2025 21:49:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRMoZ0kEIFFh33g6NRGwB8EmRXE6y112KKElPhNoyWMAIylcxArsci3eHqOsaGFOGLC1VbZWH12Lm2lI2AnCwiwTGZwZukyWhvmE1a3LDwRMGqZ+rfxbIrV5yZAmhDFX3o5o4udG5+kzI0Ob9Pjyd1IQ3zYO6QcRXffhIPIb1JQntWxcEOuN5odaGFh21qvmLUJqvwkkPp56XorOri+o/06bLneIN8LnhzlhxTxi8pp4p+uLmfNaFGNtovT8Gh9VjixAYg+J+2OPp2RrEseir/R6f4NPpx87Mvao0brZzSCSMI6IiQSmhxed8up6PZr/Foank4sSQZynbUKQI5qw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o558/jXqymkMrs7XnBROdr2ehbm2YFk3HrWECy2OcPs=;
 b=fnsbx2iS6GAYVmJ2VdrbSwu4xpOEfiKKYeVJpQkza9z9cd3dO8SGA0OPd0kjB1JDeBBMxW2inIZ+lGsh2kbLenUuEQz//h86jgICzYmTU/W5wGpiVH5Fdd6nux/yXRIrX19HYOFQt2WnYhOAmpelxeNHjg9elEyuxvxre1LeF4DSsGJsCpANbJaiXOuK618f6pqgul11UJUsrtQLvDx0on2IZSrgYeGquGXU7uF/YkK0HMnv84lmQ/9O9++UONaCelfLQVy9XZeP7jVj6WWCD6hECDgGwY5bMW6hDCQ53S7HWW+GsMyRk6MaaRmE/YDBCBXvEcZdBJDdhDJGF21YVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o558/jXqymkMrs7XnBROdr2ehbm2YFk3HrWECy2OcPs=;
 b=rw+AY5tS9WOIVQz7dwprJBMU/kiYasNRKYgV/pIsp1KrcF+cvGWM3DKsliU9wU9ySXb6JKCrn5iC+sjzoUtIdhx532Hqm28n0e9ahbITAjbsqNR8TfNl4vuWZkSUv8ZqVgT+mXn2ZimBz9/rCn1Lf9y8aEa0Sfg5/3UUf0w66yuB3U/m7fAXm/o+YI+LffvDewSoQyAqpc5fU9kfrWEo4MlNcleu8CYsFXmOxSfHyxexHsyenFWd0sGSq7HV4c0S4xphQbq7zGI32Z/AwXZaLksB3NaZVbqb8ALLk9HBbCcu1xhBXfnjN5ibN6TXkCDfx3KQOAQtU3D7WweY5Sf5aw==
Received: from MW4PR03CA0353.namprd03.prod.outlook.com (2603:10b6:303:dc::28)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 19:49:47 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:dc:cafe::ef) by MW4PR03CA0353.outlook.office365.com
 (2603:10b6:303:dc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Fri,
 25 Apr 2025 19:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.1 via Frontend Transport; Fri, 25 Apr 2025 19:49:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 12:49:34 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 12:49:32 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix VLAN stripping on hairpin queues
Date: Fri, 25 Apr 2025 21:49:13 +0200
Message-ID: <20250425194913.70742-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: b6816e3f-b0b4-4770-6759-08dd84325545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mUvIM7xR3Au9ihS/FbNLffDoAwk/jOtuuGNkbDo4fmSBvvD/Dzu6yWHkKwWo?=
 =?us-ascii?Q?rFmyKnp8FAFgS9LyFt8dtpBLPNmz/Xg/O1mwYmPj7JyJBzAzQyAPsatCyI9X?=
 =?us-ascii?Q?TC0hidU1CDX/ff5dJdXkeu3QnwmUiO6UTxt9kFCbQfMwii8Ch2rn5SfPqU79?=
 =?us-ascii?Q?NdSIrpMYQ7vcRQ8SYaORcfk+Yz/4u3ljbhF9fh+LX3QgKlP3lKPtuQouh6Qp?=
 =?us-ascii?Q?hY6oRB1/VjyB0iZG2xAHumzXS1B6HrWxQmMYkyTF0rp6YKkJ0Qkl+pWNb30N?=
 =?us-ascii?Q?Pt0Y2zVvTeJHx4tg1luicIDO3+5+p1qvCwujwmN9pR4WrEYmAfFvekoq6e+y?=
 =?us-ascii?Q?YBwpCGky7GFLHLELoqlMjdLjsjH8RUAmPYlsJrF90gI+nW0njYmReyNStngB?=
 =?us-ascii?Q?ervhCDBqXLo+j2+XNnCp8OlFMZfXd0gFazghqHAEppHol/dR3BptzU7Ek0+t?=
 =?us-ascii?Q?9Xg8RXa9u22yJ0LGolMQp1h273tzMIB/jhIyYeQQQURC5SY5D5isxPVLd7Pf?=
 =?us-ascii?Q?Di8PsjSR5Im7eMSNQa33HnsTl+cRv1Aaz6ggYT4QFtIpZhfN7HqgB+kl9OED?=
 =?us-ascii?Q?ncZHtrGkv/EyPBNw3SiL0tFceVF8WJtn2UhF6Pp5QvRyEtj5o1lXF1LLzP1m?=
 =?us-ascii?Q?P3eSm8q0uDZ2MW9UbEpzGe+eAeRmC2X9Ktlhie1YbFlocvp4gi+2VImfLm+A?=
 =?us-ascii?Q?4SSsfWo29LLbBeuw6LoYpYSWOlHyBu6syc3rtWcpr6OIE8plo2Ss3YAwAP08?=
 =?us-ascii?Q?F4Fefn7KLT7QzGD++oFNY1IprOvpP226dog6xsum+D64VujU8bYUeR/Bglgz?=
 =?us-ascii?Q?RGQUGrJvoHdZwJ3IUDKHgJsp4cH9Rgky1chSipZKh0sY4X3UcDbwNCPtSoOj?=
 =?us-ascii?Q?oLWeCb66hMPVbL0kky5MsoR6k2tOJ7zSjxcZaq1BUHZOnzAsqZVi6mUQBh79?=
 =?us-ascii?Q?mA/IJYaF6s6TxjUwxEvkroUghbbv2NfUEIjggtItMt+TJDL+6k5b7iDkhQOe?=
 =?us-ascii?Q?JRz45i7R+Nvo59ktCS0L8JqhCjhFu6F1FX6Rv/ba8eFkEpG2xxoiVt8OlCe5?=
 =?us-ascii?Q?ueTd6YO9KJxYb944utBRgmMq0jDtdoPdBXDunJfQRUObXfFG/NfAaDjnB3kr?=
 =?us-ascii?Q?zEXX1gCvjfjESFaVka5jFOEnoqBoJ7YHnVooyvNFVPM+Cv4EPKUwh/cNA5YO?=
 =?us-ascii?Q?4Q84iZxFacIGHxLWZyY4dQ0w4SWIhl385HPE0uUQoLtXD0GYV+Jp/X6Anmg6?=
 =?us-ascii?Q?r5+KMxwW++tAZRsW/9B8RxJLkIWlYgsS3NEDyKrw+y1f10VtckEq4yWOXoAy?=
 =?us-ascii?Q?iDWU17SRFl/gsIYAlVAtHGF53udMT54Zm31YogTPQ505Y5tQ+anD+VbsljBY?=
 =?us-ascii?Q?5DNVhBpNJPCG0GgyQTofE87HzSo15YqDtGWXOCfvl1T//shsD7DKJLN0xNgE?=
 =?us-ascii?Q?zLckRt6Rv07y6hyXD0yoN75GC63s80cZrSeZtTT3xuigyjoyVxmxxvTJBuIp?=
 =?us-ascii?Q?IC3Hp3aPsEW1dTd0T0ylJmR5lSdYGvs3HqjO?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 19:49:46.9950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6816e3f-b0b4-4770-6759-08dd84325545
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
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

Rx hairpin queues support VLAN stripping,
but if port was started and application attempted
to configure stripping on hairpin queue,
segfault was triggered because of NULL dereference.
Underlying function, which was updating the RQ was passing
wrong object handle for hairpin queues.
This patch fixes that.

Fixes: e79c9be91515 ("net/mlx5: support Rx hairpin queues")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_devx.c | 2 ++
 drivers/net/mlx5/mlx5_vlan.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index a12891a983..ed1826a612 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -88,6 +88,8 @@ mlx5_rxq_obj_modify_rq_vlan_strip(struct mlx5_rxq_priv *rxq, int on)
 	rq_attr.state = MLX5_RQC_STATE_RDY;
 	rq_attr.vsd = (on ? 0 : 1);
 	rq_attr.modify_bitmask = MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_VSD;
+	if (rxq->ctrl->is_hairpin)
+		return mlx5_devx_cmd_modify_rq(rxq->ctrl->obj->rq, &rq_attr);
 	return mlx5_devx_cmd_modify_rq(rxq->devx_rq.rq, &rq_attr);
 }
 
diff --git a/drivers/net/mlx5/mlx5_vlan.c b/drivers/net/mlx5/mlx5_vlan.c
index 43a314a679..7c7ac78dfe 100644
--- a/drivers/net/mlx5/mlx5_vlan.c
+++ b/drivers/net/mlx5/mlx5_vlan.c
@@ -107,7 +107,7 @@ mlx5_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
 			dev->data->port_id, queue);
 		return;
 	}
-	DRV_LOG(DEBUG, "port %u set VLAN stripping offloads %d for port %uqueue %d",
+	DRV_LOG(DEBUG, "port %u set VLAN stripping offloads %d for port %u queue %d",
 		dev->data->port_id, on, rxq_data->port_id, queue);
 	if (rxq->ctrl->obj == NULL) {
 		/* Update related bits in RX queue. */
-- 
2.39.5

