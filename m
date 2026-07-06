Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64041C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 11:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72D8B402C3;
	Mon,  6 Jul 2026 13:53:15 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by mails.dpdk.org (Postfix) with ESMTP id E264D4027B;
 Mon,  6 Jul 2026 13:53:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFw7nhkEuVqqswy249GkTPAzXGpVO5q5I6VidoLc+zdVukqmYqHaUyil37AwHf39IPocD2tU6Ppnl60mx35hZSZGcFOoAWM6A+Zr1cdlemZvlH4gDG3d9V6x+UFroH/zkbIicfJ63grewuNPc+/pFnLHa18YyhO/3ii4X0GygBPNGzY1vvKkTgyiNagAM7LbMhAJajIqd+bkss3KIT/B5okpfcmfse7btF1frZ3/XxGAcYZO+vsWx0eEs4gE/v856jU4ENEZTP+iEOWZCS/kkp02DxS7CRcahn2TieMiB2cuKqEG/7YYKyhgZ+GMM5ozxemI87a7LvYxSR+VGGVMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q0NkjYOWFQbgt1YQLVLZSBP5DtRiMPoO9NM3jugpHU=;
 b=w3BiU09dFfvglWeWCC81xzRbarW1wu188L7iL6LKs5LRiSMlhCPRKV1ONLRL7bhkmkxUWX4GEQPGP9t17HA1X5j7vGlGVVS5UtG6hyGYmONFXdfcQgdYmcj2yQd5LkmxEOY9JLJcJq/KkBIBMaKsb5eHogQAxErhzkkfktY9bPgpBLwJD0IFiu88gC89JtCmlyF3oMj6gqMHJqGy6gibjk5pXa2UPnKTuYYUzyWDhb+laFe9zw4tcZ63vrjnZNU27q7v4zai8t8r2m4YUKIAtrOZZjBWUR/zIl8CELDkLtWWkDkzLkkjigNMAkpEVfhDVarVdDQeHpzkjMqtK9A9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q0NkjYOWFQbgt1YQLVLZSBP5DtRiMPoO9NM3jugpHU=;
 b=abI0ny0RbI8pUI6I2LXACXsgMf8udc5I7k5xXb2DGxZXsgvRAYiO5KIA9pYwqGaiajj3+PUlfMWXGpxesPjOD/Pbu7c1aIOIqIl/l90OzOrYKHL+xzqPl+qbMeK44E14yMRJ42Mv8gu2j7DvMPLZrFlMOhEHCByArv56K4V8hWk2hJ+t1PMn+/OJ7MKOQi2a2KrlyBjV3JUFj0cY84lpXvK3vjzA4jnLCniGhwFOShiG/CWkjxlEWvRNF941nd/ZDHNOw9QXKNjgdFCQD5sV9gh0CKaA2cnFH1Y0bRm/gKbShwJ3s1DpsDmfjW2aHKCJvKcfXrZ3yFhrwzYnAfmEZg==
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by LV0PR12MB999094.namprd12.prod.outlook.com (2603:10b6:408:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 11:53:10 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::8) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 11:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 11:53:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 04:52:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 04:52:53 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Jul 2026 04:52:51 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Shani Peretz
 <shperetz@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH] app/testpmd: fix flow cfg double-free after reattach
Date: Mon, 6 Jul 2026 14:52:48 +0300
Message-ID: <20260706115248.188551-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|LV0PR12MB999094:EE_
X-MS-Office365-Filtering-Correlation-Id: 08137150-d0cd-45f1-9fb0-08dedb5526f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: MZrEUcB7GAlw/1qA7x5P/bgvxW13kbtVCDmfuPfw73hgnX6FdWiYjW/mSg7waUIrhfiaoaxXyH4nNisP3LYKLMf/ROY3fPxuvRQSdUbAUnIl7bJG4YPnKlr16lAX9KIrFZJo5Ylf9GgIMhIwrlQpK3zD05gFhg21Hpr0FZMpuLB05zWSbbGyocT/6zBg4h4QbR3oA4oThXZmSa/i37r3dx6dDrDFLeQO3/MCf317bpWhwmxzBvBdbu9M2Bi7VSlnc/eAl0FiAOLrdTktjzisCXMxifHqPWc3WQDM/4D1v6NW5C1lBn4xVFDPeDvBKHKkGgEWm9Dx70LRcrOokW9f72upeUSW25phol9MVrRsTzEUp+Y+B5/k0QTI1f7kLhSKhwS3MCHoiGQL7aw8wJtFkuSF3I419SGeu2KbGOPyXfQq+ybHMWGMk29yJvNkqRF8Z9br7XwUDIyXo5lb3xkdDAMvOmEN+YbxcYOtzBKuiiJk/WoPwgbigLaR2gP2vd9+SIdv+zxrE5xINa2JjwdzKBFhTsk4rwyqgR+jaMrnDl263VP0PKS5W4OcXcGnG+Du9GvK08YI75M29n83VKv4dCL00WTwcq2ZChQl0tCd8/USoyZRTKgVPUxPlUajivkTGeMHjn9YandAL2htx7hNumlCvj56VmGZgHNt26nmpzHywO+vS5bmjlK6M0oa4Ub76XO7v3Ro1KW8PLi+sqRTBA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jyrpFZx+RmyNkJqB3ze+AT8dXAvs52DBnkAS2uF9Fh/9c2xpeON3kQozTMjZm64V7RSgZwfWYkdaoUkqYuOAqBjl/makBRP04QcM4wYQ9VbEdJrdA81ycSSucDVjTQLX9O9iHHk2Fx+x0g+0n++cAJzaQQhhKOI0sOIObP9wb/s7TwzHr5HKVaDRmG0yXWoah9OhKLmc6C1bhg0AOuVAWN5m+mgEBwK28+jG1CwjMLTXpooIW7Tno2N//aXtKXxkoHm8qo5skp+EMuzv4skae3gRvxy2EsUtb+BtDCYygAY10XB6nprbXAp7UzG4UUBkkZsI/HkW06CX6GQrlN5NzlLFtNEZXXYdBirPqmOvHk0oArClFj9yhSJ4jmwI/J1kc5JTE+sviOm0GOXgB8o5Ahn9IcD/fANTUvIXYvrg04pGriW3gMJauWfYs/UGzYYJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:53:10.3483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08137150-d0cd-45f1-9fb0-08dedb5526f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999094
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

From: Shani Peretz <shperetz@nvidia.com>

When a port is closed via close_port(), port_free_job_list() frees the
job_list but does not NULL the pointer or reset queue_nb. If the port
is later reattached and "flow configure" is issued, port_flow_configure()
frees the dangling job_list pointer, causing a double-free.

Fix this by setting job_list to NULL and resetting queue_nb to zero in
port_free_job_list() after freeing.

Fixes: 7fadc8039588 ("app/testpmd: fix memory leak in port flow configure")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 app/test-pmd/testpmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 9a85657840a..ef337a4d144 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3358,6 +3358,8 @@ port_free_job_list(portid_t pi)
 {
 	struct rte_port *port = &ports[pi];
 	free(port->job_list);
+	port->job_list = NULL;
+	port->queue_nb = 0;
 }
 
 static void
-- 
2.21.0

