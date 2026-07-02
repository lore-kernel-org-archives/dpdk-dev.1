Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48707C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 13:08:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F1A240653;
	Thu,  2 Jul 2026 15:08:09 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36]) by mails.dpdk.org (Postfix) with ESMTP id 7C4C640265;
 Thu,  2 Jul 2026 15:08:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSHysGjsoMUVP/icmxtr42QUaMTDX+MogT2aX+o2eS8/cLdN9S5D86E3lpQYB/vQy4m9X1Qe1QpqPWghTixLjEKdxG7pMwpYy1/v+1EXBIyMtNIQsUh4BfbN/D+PbBFGQHZka/eg12Ep7l0hLQ4sAyVLC7Hez3XmGucXQXvVf+aoplVvDv0phJjcXXJ67mgpizFe48gtdNtvftiVmxKLpRfqcxlsqOY4VDQv/JIQ9vv3NDxbJOfhaUi5tr07tevtCv8n2z5PAUR+7YmHTV0c39w4SOkJ9LE22mFLVg+UcrXNuzAcTwUVUY3W5ps04++NxwPI7aRBX5Pndi20LI/RZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caJy4Qi22XuHsC92deTjJ6XP3wlbAVZOw1abRc5SqJQ=;
 b=La0zKDOe8fc1kaPln1Y4z2B59ljXYD4LHxAVuzvdy4o6SaMU/9uh7gIKdV86OVDl+yCa13yPswjYfZA4+meoGfZCh4UcC1pxKjYQxXBySR9u1xv08azcNwsu8A6KBoeaqwHJuy1Ot596NyKtKgYShY7U23YGMZiZoAA4QwtMNq3w+/gI7xkfAvrlwRCNuMLt9c2TOzoeKRDRoUQEVjf5Lc2ECrn22z9PY3NcLVHAC0aHn4w+Zu7jPtOf+TQdw8zfAA2z7RcJ1meT1UbSBaWSWDQbsd94rspaQ8SIGrK/0ZXJ8Zp9XAi2MZ484mChai44gAmilMoYeoraxCUwtdCTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caJy4Qi22XuHsC92deTjJ6XP3wlbAVZOw1abRc5SqJQ=;
 b=HE+RcPJsY4xa4+6utp/29OM/JRSZ8xDPUjw/cwDRca1PEJoDgiImdjQtiJVCBgeucldilFZHlgLn8TXFbfA96Ok1MxqR1N8UwsJ5rRLBco6blPJShc2ZbwJOgVy83MxMEYLKJ5zx9Ie+yFKhc9BjAdNdFS/MuLKlYX6Jt7IwoKEfVeav3rV0Xtb+BZSADUeePQiy2IJ4bfeKHXwFWXVreKVpFejZnNOw6yVkS6xCOFaakdrRgKlPJFIJmOTNIcksMk+pqxEWXvV2si5EAgHcJYEvviEMqEQuj5EtVrGvdW0BbYKm4Q1/o830vm4HrXr2GrrecexE4vnKdA6VIspJeg==
Received: from DS2PEPF00004565.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::506) by BL1PR12MB5708.namprd12.prod.outlook.com
 (2603:10b6:208:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 13:07:59 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::37a) by DS2PEPF00004565.outlook.office365.com
 (2603:10b6:f:fc00::506) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.4 via Frontend Transport; Thu, 2
 Jul 2026 13:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Thu, 2 Jul 2026 13:07:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 06:07:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 06:07:34 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 06:07:32 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Aman Singh
 <aman.deep.singh@intel.com>, Thomas Monjalon <thomas@monjalon.net>,
 "Gregory Etelson" <getelson@nvidia.com>
Subject: [PATCH] app/testpmd: fix multi-pool Rx setup with --no-NUMA
Date: Thu, 2 Jul 2026 16:07:28 +0300
Message-ID: <20260702130729.26577-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: dc28aa56-9e61-444a-1b02-08ded83af0bf
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: pjQGxuXqQV6yegQG0Ptzgf2ZLhksssWyZ2wdY6Owyvq7zsznME+tqHyPVCKO3HWoXKePv/JS58j6qmFIicJlEpU1KGNlnywDK7TXNbWlLEAb2e3BgUA+TD3ZSqYzXopKhKEs0D6byv6GdpiDQNahIq4D2IqAmx2JVeUHiG7V4gMM1gHvUYgwJpR1FJNhE/FHX5gnvIFXY9PXb4lcvQXjBCVlQNiFFN5c/yBqu8MO/bkcR2ZRXLmBK2g2f6MfjvaEuXHGHC1jHcr7jv9C95YpH/D4cTnuPv2jhvvbRCvc65XrduSlo+eNgkQLGvR27HrlDxhXSg4mFswVL4gub51HeNp0UXZlz7nRujKEf6gI+Yb9fyvQ9pW7gqwc449ZZltsOGREA4T4+J/2xUiFF9Qgbx6eR+upVbUSXatV3+TriXwMaonG8/PG0t2DnKSkoXiZr2/wH3APiLC4Vd2Ec9Dh324hV/Ynx0H7+bI4fVJUGDUl82/wUMErzBZmW/TP93DBex+kG5cjYrFP+W3eNXhyAE6UVveYDivsVycvRgpo4LcGshQ5mf+tDH3Je0j739n9cDkH4IByzgeddfrHs0v1IAImVs90Ut17sOUP6gpNbTjVBJA4+CArzueIel6W9t0e7GPNxngSj9cpjxOawrFHV18bXw6QLatUeHH7TrMXd8DVU2G31o3Ga81OY2GcRGI7X7cB0FT1z0gAObjqL1zQAQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9WDwN/7eU1FO2oMslEcjxzgzMZmBbAW4Ohkv2lhh0MbNM44MTUo6QJiGz6dL03WdxWHTl4qIH7JMGbNzNbIwUuxZ1CDgwU3FbHlWm8gft362iKGtIgzUtRcvHLwGM0VT3h0wFI1itm99bWShuerFZVTMzO9Uk/Uv7T38P00+CpNSbZ8sWUo5mO2FxDRESWP1pbJXjmFxg2nKmsAXoThIFmGb3S9se0qzSKRTy6QotQVZwLXJIxonwWglMxYYAY0oWx33Sh498uggN9duuvnJxoYPg/J/J+sJO+q+X09XA2DBZxB/GXb0J1sp8VTAVkyPopeVH6QgRBHTN1yHYL/Vo8h6KWftftJZz/Tt82Dq4zjFItjf738od0fbdvQplc6bcNJwsjmT/TX3+Uf3CtsaC6Ey8d+ixn6PzvkhAm+QyDtglq9F3uATyPMVcAdN0Vla
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 13:07:59.0355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc28aa56-9e61-444a-1b02-08ded83af0bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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

When NUMA is disabled, mbuf pools are allocated on SOCKET_ID_ANY,
but rx_queue_setup() looked them up using port->socket_id. Per-segment
pool lookup failed and all segments fell back to the first pool,
causing Rx queue setup to fail when a later segment needed a larger
mbuf (e.g. --mbuf-size=314,978 --rxpkts=186,978).

Check numa_support inside mbuf_pool_find() and drop the duplicate
NUMA socket remapping from start_port().

Fixes: 0be0ad196b52 ("app/testpmd: support selective Rx")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 app/test-pmd/testpmd.c | 3 +--
 app/test-pmd/testpmd.h | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index fcd8a909670..9a85657840a 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3153,8 +3153,7 @@ start_port(portid_t pid)
 				} else {
 					struct rte_mempool *mp =
 						mbuf_pool_find_first
-							((numa_support ? port->socket_id :
-							(unsigned int)SOCKET_ID_ANY));
+							(port->socket_id);
 					if (mp == NULL) {
 						fprintf(stderr,
 							"Failed to setup RX queue: No mempool allocation on the socket %d\n",
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 3d4b36d6683..c1f3650f484 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -891,6 +891,9 @@ mbuf_pool_find(unsigned int sock_id, uint16_t idx)
 {
 	char pool_name[RTE_MEMPOOL_NAMESIZE];
 
+	if (!numa_support)
+		sock_id = (unsigned int)SOCKET_ID_ANY;
+
 	mbuf_poolname_build(sock_id, pool_name, sizeof(pool_name), idx);
 	return rte_mempool_lookup((const char *)pool_name);
 }
-- 
2.21.0

