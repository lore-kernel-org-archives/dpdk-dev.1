Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A2C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 10:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E45840287;
	Mon,  7 Jul 2025 12:07:29 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by mails.dpdk.org (Postfix) with ESMTP id B10294025D;
 Mon,  7 Jul 2025 12:07:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWuK/PqRQ1jBHMqc35UqnnLcE/6Gw66KIH+i3eYc/mkiCZQF8lfcjb1ZqRlQIfFQ6NhNSXvgglNcXvjDKHCKUyrJtcfevEgvyltsnzQ+svSHvdm3XfW7AINhuSFxBjWIlFn3IiTGC255zbqfNcq++rn2JRtwA5FkcumdGtA7RkhFeAB+iBesfew/j9sw5BPQvsc0viBfdZuYjEbHWJuE2voqW0csLi0TSNfcvqZ0QArdYjGxutjSoP9y9nCHiJ9IL8OAKY73yUGvHBccQBvgCt0Lz1Uz3qZjhcFm087XrkjOazxgEsZL3TS74rsCSW4VYsmYZGWYOrWk5at1UR0/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGG0eDJHOgpkG0/6Y+l5h+NfY1XFPBwBNPCNVtjBR/k=;
 b=FtOTJ4y+W3izE5/Sw1YVDZflk4MXe+zeyRYBsPbmtbHS+lF3qjYwrtQVEHi8231EXoE6VpooflWh4+3BtEqfiKbTLCD22bKWHBKQLSr1pkHg4pCfof4CTPAzwM0dnTYd27BUS2GbARZGrJBy2Tz3en/B/HUS1MasBvDHH8zewgUZahOTpmflOAG6E7dQpBLYo2h8Jk+r7qyGmO+I9pvr5RexNjhdqc56impCOxvt6DQFA/2KMH4N0T003pxF+67aIpk57zV9q3TVcPX53a/NIm/w3Go4at2zteRBPETwE8zqpyb/dUYg8RIJB24tjad3BWWRnvsTkGOdbu+2nyGtAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGG0eDJHOgpkG0/6Y+l5h+NfY1XFPBwBNPCNVtjBR/k=;
 b=aV/sIM0CEv51EIxDa4hAcwDtMxm9sFUjisVyWbGt7lni1M1wfR5bPSvDrL1facjynOZ7L9/Kjtdlw8KRTMmy8n0sZv6AnMBEnAD8uKPZdafuTGqfgaHWIdvCJ/B8qiYvtTUeYGOIIsj4bE+GEfq0bU0xaW+9T1Dw5Zew0XAoaJhII+Pmuc5pYSnT5zYHxXrLpPPq1elzn51oTMBuzNupBpR1+sZnWCV/+irnK7Yrsx0UC7p8bJwyQyncijuFMKhojuyhptRoY4nyZej64ph+tP3gpLmBbpxrtmotwjoW7DHNWttH64Q3YE92IkKRhfItOyQx6UzNOlnLZPdxoUzoQA==
Received: from SA0PR11CA0166.namprd11.prod.outlook.com (2603:10b6:806:1bb::21)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 10:07:23 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::de) by SA0PR11CA0166.outlook.office365.com
 (2603:10b6:806:1bb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 10:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 10:07:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Jul 2025
 03:07:11 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 7 Jul
 2025 03:07:07 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH] bus/auxiliary: fix auxiliary device port destruction
Date: Mon, 7 Jul 2025 13:06:48 +0300
Message-ID: <20250707100648.354190-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5982fe-8e92-4020-09a3-08ddbd3e1108
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LMeCN5g9zfF3qMZKW8lC7ZvwH2exykmJB5Grx7gTVepE2MhVdV04CFfRUq5A?=
 =?us-ascii?Q?kpLBkOW1DLf5JTe1vZabDadF63LwdppChRNlxQ8WV+cV+Jcxkg6QSVhUKol0?=
 =?us-ascii?Q?Hawud6kahdT/5rdENQ3eqZBHECJLupNS88m9rKzUQkyM96cpvpgCu4ubehC3?=
 =?us-ascii?Q?6bImuDR+9HAYSh7apKRyUg4bfYKBu8jR0Mqvcdn/zRuQkNO23O8mVz+YOHbS?=
 =?us-ascii?Q?+NtOg7AXgC0T54CGM/nHXReiz7qOlSXJeUU0WB7QIhRsuxMtzHnrBEXYipWN?=
 =?us-ascii?Q?Igzs4AdsSPYnzh0IeskVlRrLsZSAxScfl/6ry3oseA1r9yFovOz58SlWv/Pq?=
 =?us-ascii?Q?9JwONw5XsG19w1R5+yMoN4go2HtFSGRw+h7CYLosacEwsij8VtiYFZWFfEey?=
 =?us-ascii?Q?XMM+Wz9+DqY8FK4mpUu8Zh9/t+wQKOqY/Al1wWCyTDPkjrlYhrA5q1YWlkDg?=
 =?us-ascii?Q?TGKquqNnyxHGZPM1tZuDhMecT92pyn6SPEfWsZ/YohqOewSaRdu3AeQPepwq?=
 =?us-ascii?Q?GAt1y5Q+CFvBVbMoGBHHreTzsQHk/iaBp/2TinWjBudbFfbDBX1py8qeJ1wf?=
 =?us-ascii?Q?PlCCrttx4Th3k0h0yfhN0+lo4DwwJG+iPDmioI6IJfuI7/AWpgx0YfFTWe73?=
 =?us-ascii?Q?MCkNJng6VEwEfMuH4MMZhIdrwU4EJCg4j+hBNN+wDWjQBTO0pmiUjiR9SHq4?=
 =?us-ascii?Q?o7+lks9EVhBNl0uvLJMv61cSnTq5hqjJruu9HPvNn/tZoPxsiaZxNGvNvd7Q?=
 =?us-ascii?Q?QYEClazqaCgClo3hDRFwmckXRUdeQgzWbUc+57jy/T5CEjc6gF9IP1KHNDJg?=
 =?us-ascii?Q?RcPpv35dhj0XKR+L9ZAUlCT2pOl/Kzo7XlVbqvpn9bp7TH3yyhGk3QHkZ0nB?=
 =?us-ascii?Q?UlI32ZkNelSRAt+jr+LZpDntKeuEW24ypZ9YdAGZhmt2oZi3gE7KdiVCy4yW?=
 =?us-ascii?Q?H1UbzBGzT1oUKOjNK1a7M82ESS76sJtSWNnMpTKpbH/pU0KV3SdGLoRKhVbd?=
 =?us-ascii?Q?oollsunk619Gc2zV27+H4jtlea/eGELt5Era9xq2/BzeNt2wGfeTroL1V5iF?=
 =?us-ascii?Q?NJL9MOnYUt+ke/vOiypau1djN373XAOkhIhSmTgp5zpGipRF0R77t5tEOA3o?=
 =?us-ascii?Q?iSFH09c0iomwzaARN/a/BgNGLStOQuBTiTjETx5WGCyZaDuM7mO5GayFUXts?=
 =?us-ascii?Q?+LruL3580fZUR4OFEyXB/GoyTg3K96e99KF8jW8QFE6PWR/IxxGnpstGTSVm?=
 =?us-ascii?Q?kk+ekV7a+yA05mO7TmdqOnJSjvP1ijRNqyO3lA29I1LSuLa6Dwz3jd1poCDs?=
 =?us-ascii?Q?nPxBLUE2h6A6Fvi0f63n7wgMwTdBtALnugh+7uGEbMQuNhPPK0N+ly6fMyCP?=
 =?us-ascii?Q?s78pAw11IVAzXYYP+ib53t3Gh7Vqo1rAM8lRq/3xR49QxLkQJjYQZnqAY0kc?=
 =?us-ascii?Q?iSWkMSZ8fB/uMglWiIhnkAQF+EqWMhTewkBS3i1FEBe4pNejFjdx2P3miYAh?=
 =?us-ascii?Q?5bZSjK7CtYq+nemm2K01uGMAs+uG32+KjTnD?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:07:22.6296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5982fe-8e92-4020-09a3-08ddbd3e1108
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692
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

DPDK auxiliary bus first creates a list of known devices in the
`auxiliary_bus.device_list` and then tries to attach a driver to each
device on that list.

If the driver attachment has failed, a device will remain on the list.

The device destruction did not validate driver existence and
crashed.

The patch validates auxiliary device driver before accessing
driver related resources.

Fixes: 1afce3086cf4 ("bus/auxiliary: introduce auxiliary bus")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 5c6c6b0ef2..ac766e283e 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -163,6 +163,8 @@ rte_auxiliary_driver_remove_dev(struct rte_auxiliary_device *dev)
 		return -EINVAL;
 
 	drv = dev->driver;
+	if (drv == NULL)
+		return 0;
 
 	AUXILIARY_LOG(DEBUG, "Driver %s remove auxiliary device %s on NUMA node %i",
 		      drv->driver.name, dev->name, dev->device.numa_node);
-- 
2.48.1

