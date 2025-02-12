Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5911CC021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:39:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49B7A427E8;
	Wed, 12 Feb 2025 17:39:00 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by mails.dpdk.org (Postfix) with ESMTP id 3F3EF42707;
 Wed, 12 Feb 2025 17:38:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP63qsz0dh4O18/WIgus3anDUTMysB1mrL4TFABQsGqXo3HM/u1ICU/ozfjN1svopAWpMx8G6diVMVLUqTYRIox9qg2s1LQi/OqToZhTML9pJNoXCD81qQInrPiLObulJzGsJ90jKDGDjDjY6GRDfdZlSaygt0Ws3uLsKnYbCU9ggCFxakkayB1lYWuBd0EZyB2MOWqugLpxUc5cAsYw/AuMkkfoQgtqx+sDvpT8xksT/Wc4atcBvYfX6JKnk3niIpnX1XaUxbNv8LbZ2bL1t5XIkAXZ8LqorH8PfFi2maBoU14WY2yVbP0QKYmfoP3LNFN1bWiBVwmgKvTWOCBhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRkOmjXY62KhiNlrMy273Nr803nhri+0TQwaxHpgQRQ=;
 b=BG4GIYk4Q9q3bjmdpFEWn0di67bVYSIm2cO1lJq4nMw03TyZLtKElh0oUNn6xJpilTnhV6aX1vZK/9A4eNZ9BG1Tu3mokjnofUqiFi58IV5eyyq9yKPYZpb8A3+85cGBLTA+i+x746SqaUm7yJP9VHENlYMdJJBt2s+0MOL0dd+fxZR2ftkg0iiWKLNmVM3LTBaNw2U22TVfIQLEJ9zggDH/PK9oRCJxRgqlMElhyTXS7SV0nbGLzSJWah2kvZPW0nB3qReOOV/dl/KivM5a/QfhQcz8iPJU/rlPH65Aw+PcPE3Jp13lznWKhQqXmHeJY6ZNwPuwhwjZ5yG0JIoizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRkOmjXY62KhiNlrMy273Nr803nhri+0TQwaxHpgQRQ=;
 b=TXx/wnpdYnK4ANfGf5/KEGiEMLBDV/pchV4aZln1sqFyL2IXXwXZAJjSvSSb7X3mUY8chZwInmqrI9vBqIlWsLbLnTczHYl4PBeFljphtTBmjkTIOmwBaHGwDC4TuT5M0LYY+zE9RoYPeAnN60JTE8ZWD9fDVkxSpOTINhWJe8lmc9MayH7A1s0lhU8Zl77jWvljWPQentdgzMIMW86m1rJ9DXa7yfVR2viA3ob3QJ8gh7t12O2+q6Kym3zGjBSIzu/2I75mRmkhwjxDRjF2ICZYDiM61geKghkhAFDUS6ybYtfe551spqIxwpGFzVL/iGLRfRNdlDx3OcBPmrTplw==
Received: from MN0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:52d::9)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Wed, 12 Feb
 2025 16:38:53 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::21) by MN0PR04CA0005.outlook.office365.com
 (2603:10b6:208:52d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Wed,
 12 Feb 2025 16:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 16:38:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 08:38:42 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 08:38:42 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 12 Feb 2025 08:38:40 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Gaetan Rivet <grive@u256.net>
Subject: [PATCH v7 1/4] bus/pci: fix registration of PCI device
Date: Wed, 12 Feb 2025 18:38:32 +0200
Message-ID: <20250212163836.178976-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206105428.237346-1-shperetz@nvidia.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 0527dec8-9215-405c-2239-08dd4b83bc89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M7uxWzwU6hWXaPjJFDVcXB5kcHo22sOh8u6pwcblzHN+f7RvlnoXaQpHLVi2?=
 =?us-ascii?Q?DmGTzfWYwbUMOsMqiiPWdHyzlmSeKhOjSjhLm5A6sACMm8Pw21p6hkUnDdCK?=
 =?us-ascii?Q?boaHJbvZwY4It0GvmBgk7Gs8enCufzKZYaDTrqKg2XDpocb17Lflkq6HgOAS?=
 =?us-ascii?Q?dNevJP4XVCREzsKP4q8qEkMeyLxMPK3pY9j+/PGuUAVCYh0VeODb/DcmKAzC?=
 =?us-ascii?Q?AQ2yldVBczAVIVeKziaZfgh4/hg2xGzfpundv1iMWqgYI717f2zsHl0dkXfr?=
 =?us-ascii?Q?k6SNC/5Rrly/9Y7RmIPQr9gTGVLt1r0+FiUn1fBOj/y1bVM2WRGmo46EViSL?=
 =?us-ascii?Q?dcKlTlZl4gSasjkFi+oenr28LTIDd7qcD26BEgiUcqTkUfHWYDl3NOcLxYEv?=
 =?us-ascii?Q?s8q6AW2htuD5rfNLVPGaeC2+Q+fHyfgYgW382i4gYARPmPbOKWutDG1BlKSL?=
 =?us-ascii?Q?y9wwCIqPNCenpwvhKhRzIyn9tIVwIjqtQGLLbbMDj7eDdPwE2h3nUxtFhAe0?=
 =?us-ascii?Q?5YAb+UDcB9KOwH5kHvmnaYiDJVqYM4JkSoOqK4JbIYzzjuJTHYfA4z0ZKydP?=
 =?us-ascii?Q?y4p2ddpNYPNDg58K2xgudKEwb1U/iSnFn6/gLBicK9AvPE2V+Y01t6jcn9Jw?=
 =?us-ascii?Q?EhT5SqvdPqDEgtkssmR8ohXSVf+5d4wTnLc3iYvyrobNCauLCTbffr3LXX1d?=
 =?us-ascii?Q?uTmwMqCZyoF1Kq/bK2MG+sOWas0+xWSeYdjN6TZ2iM3TGlZHFqnj/5qkOu95?=
 =?us-ascii?Q?q8p/uS77/tjFaCMbI//hIQtB2rIUMo3O60dekfnmpOpMzfpYd7uNRAIBzC/0?=
 =?us-ascii?Q?I9Az1yd3yvHjBu4gJtpesDPbY50oeIccpzVgtRMLN117nWWsi1EsemI0OGwA?=
 =?us-ascii?Q?WvUwa/frD0sFocGQlsK3MBIAb93u19P0mHu6M4YL9C7P0ezsoE3Jf3ogmHL2?=
 =?us-ascii?Q?HG1FGSuPs+ITjIbkG5hZAVhw8aND8uSeeYx8CLR8gfyHYus9fBzezuSJtXgF?=
 =?us-ascii?Q?2sNmrYZwp4d+u4zrh3OIh55+NMo/82o6+5vMCQhh67ys6gPmkzVb5mT9gU8U?=
 =?us-ascii?Q?hgaQxb6i7L4jUov6ssV8v7diV9YtQZVrECEuAjAQjI7QxVCzhIGM6ZmoX8BD?=
 =?us-ascii?Q?IjaL83mkHVkExMdZ4wSXGs71//6E68ZZtE7ptmeyLchL4eVbFhRYwReIZ+Qt?=
 =?us-ascii?Q?Ue3j/8MHMe0ob6/VNzo/UUmTSNCdBgQd+iFMMc2JhneKuU8SSHllV2fEWeq8?=
 =?us-ascii?Q?kt7R5OoAC1OM1CUxIdQw/Zv5Rww3Oc8Rj4DimbPRR8TQuCM8r1WfQWal22sS?=
 =?us-ascii?Q?si7TMqv6Ism8O/ydCyegCtXWxc3zOc2Z1ScpqDI79VlKJVZlNR7cpXOazG0g?=
 =?us-ascii?Q?j56X86fSzqfYXhR98Vn0i+jxEVjDryAc2as9p/7LdgO99QPhuQU3bWRCupXX?=
 =?us-ascii?Q?NWk3FHSVYu4ZYwi/rPLS9SOSN2ak2Ir9pM4awbcGcgN4Khx8JTeXYCFJLdCA?=
 =?us-ascii?Q?diMbMOWi3+07BLY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:38:53.0349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0527dec8-9215-405c-2239-08dd4b83bc89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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

