Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D99C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 00:09:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E5CC40608;
	Thu,  6 Feb 2025 01:09:14 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by mails.dpdk.org (Postfix) with ESMTP id AD7324042C;
 Thu,  6 Feb 2025 01:09:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eftduWwKRAmJLIO6FqFIojgZKTqpr2UHCDxMJdfHHoNdFDs1rfZ0x3HhAXBppqr3eZn6ocE3iezjajF3HqA1ugg3ANRGWVem9DyBPXXsWnU/bx3CFjSYWSOKCL0V1QlkT8xJgt8KRzEj5xBnbFcKAXqiIYub+T1uAu3mkdmK30+fK1ahyK1aV0C+iLxIHPGEv18ds1HWwRbugJtfOXNMj1BquAJdKL6ia8J0YLwKKd8fe9RkblybeuqZpHHq2+2fT9n1sQ9Z4G28DD8vsptD1TjHG/RM9QKELzdhfgl7In/FoNPueEay0o9t6ZVp58/cp8j2RrzRjfc43pvttxbsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRkOmjXY62KhiNlrMy273Nr803nhri+0TQwaxHpgQRQ=;
 b=T/yyuX4htt6P9gQF0Dtj2b9kc12GxByQL1qrUPPicGI2+8UNbu5bulrdwKd5f8h/AHvJ106zu7sWhgJ9ixtnb0tUnaSmZRrcZhjJbPTW72u2EpI98LCfOn0DHL/aaqgun0UKMROED07yE2JNobPqgghRSwdcieLCy0UObyUTPpST2LvwxG4SjgiQ+k/xZGIwK1Te1wnHFayOiHgdXGQvBXhgwEkJiON5uEC+yDjYjB2yLCfjeo50zXnqNDSdJ12dNSoiGkekZ9nAOc7O+jVSrBXl17AcbbQm3lsEl9OIiZgRTCmcCg5RdKsC/SkPemoHvMQ1vYIaqXu7CypqY2EH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRkOmjXY62KhiNlrMy273Nr803nhri+0TQwaxHpgQRQ=;
 b=FvRXIYfXjqP9Nj4ATqVo+8d67Dw+rz4OWSL9bOPb7jx7SJpfiv4VryJ6lPuaicLsTkjSEK9JN9TpggT//2Kzw/NzGsi8/Va2myjGMG7M9ImwbI5Om4P/2o2sX9VQpwCOGmSjyY3PXHBdoBy5KpHQuvKP1jzOkyitBQEVQi+sLc3nda80fQCGaIqd1RGtYf5ponahFGPOFRnr9EYyzlycqe7pCqlz9gR+eYh8QoW3yo/g8Je1+55X5FnlInyJkrFnYnrNB8yve0SPumPhxTvARsdJtmBZcVdpe4rXh6xjzGrsZFwBzB8RkiDFWPJpjJoG1b0H6DLaUTD125/X1Xl2jQ==
Received: from BN9PR03CA0143.namprd03.prod.outlook.com (2603:10b6:408:fe::28)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 00:09:10 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::b4) by BN9PR03CA0143.outlook.office365.com
 (2603:10b6:408:fe::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 00:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 00:09:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 16:08:48 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Feb
 2025 16:08:48 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Feb 2025 16:08:46 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Gaetan Rivet <grive@u256.net>
Subject: [PATCH v5 1/4] bus/pci: fix registration of PCI device
Date: Thu, 6 Feb 2025 02:08:35 +0200
Message-ID: <20250206000838.23428-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206000838.23428-1-shperetz@nvidia.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f52b96-6c86-4868-c445-08dd46427ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?imen4rOjNG3aHttODRl5kpa54P8ADOmvpTtwZO4yDuSZN34YswuuqqGcU/0G?=
 =?us-ascii?Q?nu7NmYg1pAdPLewyFf0ipdGUZaOzyrmN/CJwjtNY7F2wHpEX+K2xin3juXgE?=
 =?us-ascii?Q?aQsFTbf7UfbrO3n0bGKRBQ6T6AfHR3uq03GUyP0pzHffX0dgMM5LziUSbY4r?=
 =?us-ascii?Q?/phDRg0Ro7KF8QN4TftkQpLvG+TJwcAONsnDiwp/UcLk6dIuhmWBkZqblITc?=
 =?us-ascii?Q?2h/U0aBDk10xQKe6LoRVAN/j8qbwIN4d6SL3vCgZkAfV8VYy5b/whEkG675H?=
 =?us-ascii?Q?bev8SBilyhfYF2+bF/MZlVNspbHlgwlm73EoCLO4BB+ObuerSkbD3VEogdM7?=
 =?us-ascii?Q?DTNHvY7gocUekQdMmLu+vhnAMFhpGweKh56It04HFsGkM+BTLR86Qnlz1bzC?=
 =?us-ascii?Q?4fCjv4babdqBYL+7+qkJbXh4CIh//gAqQ/K5a9TXbLupnjJB01OCTFi4SCkL?=
 =?us-ascii?Q?U5UQ9i6BM+qXN/jc+oXtOrmc4rxe2HDzfEd5z/zdWTdOO3Pl9YGL9uXLufMc?=
 =?us-ascii?Q?tRfET7h4jgNlCVLGu5Dl9Yl+oEqgLrwQ5RC2EnrMW9rAVcbc0ubGlfg5s/0Z?=
 =?us-ascii?Q?5TiCfwxyD+QGR96VtjciXW7cosoEkOq4DvfYvQUrMscuEEs7vvCKdmunsLDl?=
 =?us-ascii?Q?oOymGGBKchWwYy6VlG+SwdEgIIFPIATqOuubcGZaCrZc/zTrcf+VQ6FwGM4e?=
 =?us-ascii?Q?6AYcH41rDpubaD7EdX98osWh7xz9HSM2xJhBnxjg+5XlUZGc/bkGpriMnnAr?=
 =?us-ascii?Q?G8sSQ6UiXJdJkvU9DyoLoGtq2VEPXce3kaj2KCkk8nQiMp9zZLW5pdGOIIei?=
 =?us-ascii?Q?X4Wa6IVW3A/zHrXxDMOKzd0mr/bx4dWeENxOH2LrWLoB4QLK3PfSY4XSULeQ?=
 =?us-ascii?Q?BHY+XuG4/b1DB+V32UfsJ/WV813abaLLTk1msMQdJynJWueIYTLCfwu/vSah?=
 =?us-ascii?Q?0zo0RLkBkdoH1nC0l0Mq1vDTVPihllnORt5PKcAKzeYW4LgPmUeBqr0RQKO7?=
 =?us-ascii?Q?5NXjJnWXCMeUX6N6s+GrpL4BDqe7bvn9FglxUzdPzUEaeni592whHysHP7eO?=
 =?us-ascii?Q?cqmtMbxmA/mpFjGAMbdNLqUnnTaIsVVm/zkN3F4K9nCJY5jDgxzT9kocmz6Q?=
 =?us-ascii?Q?RyayCnn95QwlytZAlErTIfXtx9OAL6tmHBfQSYgnwpzNDncpQ3/GUDV8IYcY?=
 =?us-ascii?Q?fobCjj/xy4UImBARpn9KLpYcw4EdivZBuiC88XIEePJajbMikdcFfa+A/gu2?=
 =?us-ascii?Q?PhWJ1xcsHGbSm6/MziXNw/QDunU6HuWyYuQ7uAPbZydeA7OGNQV8Xb7M7p+r?=
 =?us-ascii?Q?lAm4tUOQ6zTUguFoXUjpZGxsh4tRsehMcpUOKXaYFBO8roy2Ltaus27xAIEV?=
 =?us-ascii?Q?KNwUEcuCBa4WfWEmjzI8C1/tJP89A3hw/Gu/4qdtD2+HRiUei0NAbcpuNL07?=
 =?us-ascii?Q?jKOjB5uaiAqlJJlTDcvx2wPtHOQiyhZWxLfw8j/mlqkOByejALbn6NBg9P1P?=
 =?us-ascii?Q?sR+PBO6pKGuWylc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 00:09:09.4703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f52b96-6c86-4868-c445-08dd46427ab1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856
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

When registering a new PCI device, the device->name field stored
the user-provided string from devargs (e.g., "08:00.0" or "0000:08:00.0").
This approach led to inconsistencies when registering new devices.

This patch fix this issue by saving the parsed PCI in device->name,
so when a new PCI device is registering the name displayed in the device
list will be the parsed version.

Fixes: 23eaa9059ec2 ("bus/pci: use given name as generic name")

Cc: stable@dpdk.org
Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 drivers/bus/pci/pci_common.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 1173f0887c..70faae4e44 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -99,21 +99,11 @@ pci_common_set(struct rte_pci_device *dev)
 	/* Each device has its internal, canonical name set. */
 	rte_pci_device_name(&dev->addr,
 			dev->name, sizeof(dev->name));
+	dev->device.name = dev->name;
+
 	devargs = pci_devargs_lookup(&dev->addr);
 	dev->device.devargs = devargs;
 
-	/* When using a blocklist, only blocked devices will have
-	 * an rte_devargs. Allowed devices won't have one.
-	 */
-	if (devargs != NULL)
-		/* If an rte_devargs exists, the generic rte_device uses the
-		 * given name as its name.
-		 */
-		dev->device.name = dev->device.devargs->name;
-	else
-		/* Otherwise, it uses the internal, canonical form. */
-		dev->device.name = dev->name;
-
 	if (dev->bus_info != NULL ||
 			asprintf(&dev->bus_info, "vendor_id=%"PRIx16", device_id=%"PRIx16,
 				dev->id.vendor_id, dev->id.device_id) != -1)
-- 
2.34.1

