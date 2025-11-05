Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE6CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 08:51:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A0DD40668;
	Wed,  5 Nov 2025 09:51:19 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1BA88400D7;
 Wed,  5 Nov 2025 09:51:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYYnXSQkxFMcCDEgdgK5xPBzDXWMBLL5RvwLKiX5BXY95dqDuQjgf5de2cmVGPkr5k/vnHg39l0qL8cyhxexgtO+Tfa4hqxJ5FvnHwvYxCbM/9nvOCFxVxDpaPxaAD/GxbhTPRA0uCtDUIa4YuYY6quhJTsrgdaagTu4cNcglwiDyYCXJ0oP6xBO5reQ1HIsdIiDKMA/uM3L+0cmH7G0bGit9w2dHdqiH26BrPbyHya09xU4A1uJjV8SeAJv1sAQ5wsh+7WHmltlruvvYR0CVPeW1vG2vi9SSXt3BfVYseylIFaDlFKTvjPqlMVnJjexAVPH0iX6zVdLx89x4hrumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfuzPRLamUwvh3AgOE+WMavndHhV3NtFwdxgk+jS+uE=;
 b=V72WnuN1jVv7gZwrdSA0RgTL8oMnGHCmVmtiWhyRSkVQSVJX/ugEJgN49+eUxMHl7qydm5DZnNauv764FRfF50rbfQ6WTvs2aQNZSxVWMFa0n/8z6pAXQq2sKxIymekfxAUkAk/STUIUoryd+y4ecfn+lCcD+64PFNxGQuy1lNzN5ZcSyxumpMS/3pnLIlt4RjAM/ChW1LPwjFaOAX1MPX0LYtQrMMJBc0qnvF+W7gVhUO40MAzNqQBfwCTCJQWZrS4QxKfqCr5ds/w50XUdwDWUbq2fN9bCI7YggT39Vv9Wzyskr7RoSBoO4KfSuhJLScZ8+P6cNv2GiFNTXqA4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfuzPRLamUwvh3AgOE+WMavndHhV3NtFwdxgk+jS+uE=;
 b=p9stu4wNr5FC1DKJuHAfb0XfAYzcEAoHWz9XSPAWMdsHkgAYCbDs50OFhHID1T8veLGq7X+VzPwKoZoN44LMTAtQkA+JgOTwJj4+Grr9W+nDn6K02/jo4ZdzqpLgD/hWQIoDHDirsr17ZSfTRd03qBcBf20fQJciIiGRRR5jZ1eLcPPI8lh4I4YT2Tnjr/H9crhzy8sLTpiqOpbLspuCFY64pNVl/oovsY+tqXac8nm1G91jt+iuelu0JSPXwX48uHLvKdCbedOFaMZHiXntFl9TPIITleF3wqB9LbFGllGzZaXsDqe8VVz0CpNP6bRJUMMDSLrHJz+L6ll7Iaq4vQ==
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 08:51:13 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::58) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 08:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 08:51:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 00:50:56 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 5 Nov 2025 00:50:55 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 00:50:52 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Subject: [PATCH] net/mlx5: fix modify field action operation restriction
Date: Wed, 5 Nov 2025 10:50:49 +0200
Message-ID: <20251105085049.110213-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f524242-e786-451c-0319-08de1c487905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jtZbRbLDvaEjTcgCuLJGaJQXVhQFedZJmStYKnOAUg23oJtstPvLbIIosWWO?=
 =?us-ascii?Q?7K/b3WyIlSOZ4wY/RIFwuHhbj0wZcrs3MLtHRwUrOI2HvslaZlZnTur+7Lrc?=
 =?us-ascii?Q?m1oiyYC+70AyzgBFMOtl1ET+jdgd9rXykL7SwvIR5EJujB4JgrlxE4R17kAt?=
 =?us-ascii?Q?5KBXS7RdI2WYTZJMnHrFD9QPWdUVu7CM3OBArUHKniexTrFs213EMzVztKdW?=
 =?us-ascii?Q?QtDIq2IoCVVxTzo0901DwdiNkmWd2FNKZ/ayOJDoJ+OZqj81XweV0E/wqCoW?=
 =?us-ascii?Q?2Hx0XyvKtpHRPvHAg5I6wUVeDdG/B9+yI9RCzfmDvMgFsh/CLEp+BVq3dy3I?=
 =?us-ascii?Q?jv565OpxYP78lCvSWeLus0JaPVD24M334Wrc2z/AEbSWF70J+gwPASCiwfDc?=
 =?us-ascii?Q?wcexZrtJ5Ko4Mq/KMBgtY6l/JLIfPC0HyKprzgv5nLro/RrGebG78LUXJYqF?=
 =?us-ascii?Q?OwLOhBnpHCkYMlzA3X29Lu0iHs0oNEgV41xETof9eLKmp0QYtEy+repUueVN?=
 =?us-ascii?Q?jzRrtSEnJ62l0egSVPzRx+jDnprp1Q0895/3sbDUpCdSSGuEmI5xNUXzi+bA?=
 =?us-ascii?Q?XICtX+J624CWDjDOLmhVhcJu5i3z1u9l4W1kxU/+yMdvejYYaiCXiRvC9vNh?=
 =?us-ascii?Q?ES/F7lmaymarWCglxOzjkEVi/RO5UWBkGfTCrHnUSZzC3ucd3ZxqKMspCIi1?=
 =?us-ascii?Q?y+1gKpxR0G6XxXDLpky4JOLXSC4OJnfUFIUc4uqx9tOcZL7PG2+hbUgUsMSw?=
 =?us-ascii?Q?teRCOP115vleFzDcUxrZb3BZcIPElNGduOqL21Bws30YJG7WAJhcr3aDq36n?=
 =?us-ascii?Q?hflzzti4ZK++ZbDMmLVNIC+3nournX30hiKFK7xLvforiVpTictNFW8YhzmV?=
 =?us-ascii?Q?4rbDz8sOv1Jx1A4CLTgdQvbmpuwAcpg4XNBe1N1aw+37aVpIMgsjpR15O2Ux?=
 =?us-ascii?Q?eOTYr6iFaKHCKm9H2zbyS3kbwmm/0AYKRMFSryrQ1L7VSdA3+XgYSJ2IzUQv?=
 =?us-ascii?Q?jKqPeGF/LmYMl9c6XR0BTDksuX4PlG2GguRPQlzeQCswkv74KPRcw4QQDbb1?=
 =?us-ascii?Q?ZFDXuRHt6gfxqw7qqTJOzCxrqac18Q772znGDxm3WXg3QaD7y9UxD1xuG7AG?=
 =?us-ascii?Q?m0H2VyymQ+r6rXS0S3lgJoyBBHx/YUQoXMpeBycy2VKDcrqMMuV8hTy6Z8BF?=
 =?us-ascii?Q?KCesIbRAlaRp+DfEc28natnWP/PC8mp7Hp4VJbttRQvHbqrgYj28s4YaFBtA?=
 =?us-ascii?Q?ZzA6ni7OxUpsA4gtQsQ06zoh2Js6yF2jd5rUuH8sryQeLKq8XJzNHVr/ysQc?=
 =?us-ascii?Q?+QKFSmhx1KrAtDmYjzUkIk1dWM7/IItckQtCS66UFwKrb5cT/mecZKTJlaGM?=
 =?us-ascii?Q?lTwjqqQI7UrbJ7zMg7h7cioEjXXxL4vNYv00KkfEReVcVVObWO2jI1wfL7Qw?=
 =?us-ascii?Q?+7JJA86mVGcMrItFdQiSzDlkz9jYploadjeBtL2xu/8exOLxgv7o7XbbQSwY?=
 =?us-ascii?Q?sRAQN2Kd1WfXpU6FkR/J9344Di5guIvR3s0ZihlBk33vBigFj13jZPkuVNCR?=
 =?us-ascii?Q?druYL4uqbhxlJHWcX+c=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:51:12.6566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f524242-e786-451c-0319-08de1c487905
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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

Update DV flow engine modify field validation:
- Reject 'add' and 'sub' operations when source field is not VALUE
  or POINTER in DV flow engine.

Update documentation to clarify operation support:
- 'set' operation is supported in all modes
- 'add' operation with VALUE/POINTER source fields is
  supported in DV/HWS mode.
- Specify relevant HW supporting packet header as 'src' field.
- List supported 'dst' fields.

Fixes: 641dbe4fb053 ("net/mlx5: support modify field flow action")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst        | 23 ++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_flow_dv.c |  7 +++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index fde98ae9936..3c13e586dd9 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -3083,7 +3083,28 @@ DPDK       21.02
 Limitations
 ^^^^^^^^^^^
 
-#. Supports the 'set' and 'add' operations for ``RTE_FLOW_ACTION_TYPE_MODIFY_FIELD`` action.
+#. Supports the 'set' operation for ``RTE_FLOW_ACTION_TYPE_MODIFY_FIELD`` in all flow engines.
+
+#. Supports the 'add' operation with 'src' field of type
+   ``RTE_FLOW_FIELD_VALUE`` or ``RTE_FLOW_FIELD_POINTER`` with both :ref:`HW steering <mlx5_hws>`
+   and DV flow engine (``dv_flow_en=1``).
+
+   HW steering flow engine, starting with ConnectX-7 and BlueField-3,
+   supports packet header fields in 'src' field.
+
+   'dst' field can be any of the following:
+
+   - ``RTE_FLOW_FIELD_IPV4_TTL``
+   - ``RTE_FLOW_FIELD_IPV6_HOPLIMIT``
+   - ``RTE_FLOW_FIELD_TCP_SEQ_NUM``
+   - ``RTE_FLOW_FIELD_TCP_ACK_NUM``
+   - ``RTE_FLOW_FIELD_TAG``
+   - ``RTE_FLOW_FIELD_META``
+   - ``RTE_FLOW_FIELD_FLEX_ITEM``
+   - ``RTE_FLOW_FIELD_TCP_DATA_OFFSET``
+   - ``RTE_FLOW_FIELD_IPV4_IHL``
+   - ``RTE_FLOW_FIELD_IPV4_TOTAL_LEN``
+   - ``RTE_FLOW_FIELD_IPV6_PAYLOAD_LEN``
 
 #. In template tables of group 0, the modify action must be fully masked.
 
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index f765f941162..95ca57e8c46 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -5642,6 +5642,13 @@ flow_dv_validate_action_modify_field(struct rte_eth_dev *dev,
 	}
 	if (src_data->field != RTE_FLOW_FIELD_VALUE &&
 	    src_data->field != RTE_FLOW_FIELD_POINTER) {
+		if (conf->operation != RTE_FLOW_MODIFY_SET)
+			return rte_flow_error_set(error, ENOTSUP,
+						  RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+						  &conf->operation,
+						  "modify field action type add is not"
+						  " supported when src field type is"
+						  " not value/pointer");
 		if (root)
 			return rte_flow_error_set(error, ENOTSUP,
 					RTE_FLOW_ERROR_TYPE_ACTION, action,
-- 
2.21.0

