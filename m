Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D2CF9C7E
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 18:40:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EFD340285;
	Thu, 20 Nov 2025 19:40:12 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013047.outbound.protection.outlook.com
 [40.93.196.47]) by mails.dpdk.org (Postfix) with ESMTP id E15FD40267;
 Thu, 20 Nov 2025 19:40:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+pIqUyObxnfQBD3Zwxl6iTmsbNZatB9Glp48nF9L6JrG1IGYg3KUyIxvPWQn3J6ACa7kc35kqsRENFcT0PjTMWDqtaNr9T+V9fGXmR45TNcF1zF5Zd9bQFq/4TKh4CHgYrhUFW3oKTsSf7VuMWB0EwvsSywN5lxFv19fDa2o+9sY7p+jDz+Z9Zd2lAjLHQ6QzkpKXmc/KxKIMg2I3K+yC53uLazyBDjkoVDcBSBntA1yJwWRcvpV2VpTwVuwuxRmGZmsKOCR5oWZv8wfzpYhcIcEgtYhYSm5utP4R70j1jkd9ptb69f2ijI1MVu+/HsbMqG4h9YOKqOqkSxag5C9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTppm4++0xBa1X9XkSTZpQKXqd62IIaWZ1CLUtM0Ou4=;
 b=feGtWMAyDj/Vf5r0m/TCbajMLQpGX67vwW/u8zP/LZzLp/rbTbVgI10V7GnVO55WjuEMQBs0KRnagzN2pWMlhWARMww+mC4y/IS0kaUem9bx1Iq+5j0ihZisDtGm3CIj/yt2rcma35u6N1jYg2P8gi8uKXm6rdSP/D1zmuGKknJ8UZDT52yK0b9OoyJ0I7N0yRv1Le8wnrCZ2Ep5tRdVgULTz6jOnaDHcjjOH6JQ4XsqzFPX37nKtiJQtCo28fcNKTrOWaIM848gHIVlJ2B6RMEPKKQV1yx9Ay/EBR0D4iVgkwl6oF2spb97FLVEPtpX6iRLY/YzfhF93DrDl3NU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTppm4++0xBa1X9XkSTZpQKXqd62IIaWZ1CLUtM0Ou4=;
 b=nt5I5xRwndzQ0ARaWBcLp8S1fYVbbBJitCGYs+c3i9Rr7zxe6uSPfgf3a3XBQfAvueAR91smxe07Kkt253jDvfidbz7JPdaQaFwexBRzlPxceuRP6Cf5MHZgFBORNdM78hYhPhVOSG56fxAfb25PAaj9o8co1Kiwjiia/b605rg=
Received: from CH2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:610:59::35)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 18:40:06 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::73) by CH2PR03CA0025.outlook.office365.com
 (2603:10b6:610:59::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:40:06 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:40:06 -0800
From: Andrew Boyer <andrew.boyer@amd.com>
To: <dev@dpdk.org>
CC: Andrew Boyer <andrew.boyer@amd.com>, <stable@dpdk.org>
Subject: [PATCH] doc: update supported ionic devices
Date: Thu, 20 Nov 2025 10:39:36 -0800
Message-ID: <20251120183936.8699-1-andrew.boyer@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 2503b273-c918-4b40-112f-08de286439ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bRkqrKtzXp9OH01BRmjZoOgM0MMLioVJhJqRBMJnvjUi3BLtNE4DrxsDcxDj?=
 =?us-ascii?Q?oDI8uIfeABe9V8l9eK70aZEV+/x11upfaqLKW9RrXagbaGOOzJ+p9J6nahRL?=
 =?us-ascii?Q?ThvW5YV/h+h12J4+zySLFhM7vLPro8Lp1YQhVv3I+Ke4Psu9trvmQy7xF3lJ?=
 =?us-ascii?Q?LF5HwpSfJwiGVPMPvq0QMbi5U1vcSzGbVI64ypEd0P3v1ABb9m0CljESAXtL?=
 =?us-ascii?Q?80G+UNk91tI9AcyPxzg05Ku89p+O9UeDQmZNHq9uS0HWtM862d2VTVjVPwC7?=
 =?us-ascii?Q?nGBmqh0VUmzFkGn42akgQ6cj4gKRiQJXqJ89BssiZoIGs1NU47mPuR4jqatW?=
 =?us-ascii?Q?lXBgck9pvnXrj4reX8wBqEaCSmYQy8gopzZVe4yf5LOj2nAeeGMfUfuRmFzk?=
 =?us-ascii?Q?+4k9B/cWQvw5szgbZzsoFeT5zQb2jnX2YCJm4lNWC94knwkE85JdgP+vXBBf?=
 =?us-ascii?Q?NMdqXbamF8YrVZYdxr8rtY131yTLbkdB776Jdfg01dorig1iT2YtKHEghz3c?=
 =?us-ascii?Q?UhuYnFsGbXAvOuBav53sHly6l7f9w45If1YmYVYlT2pYkOoeVAgXVexi4c3H?=
 =?us-ascii?Q?4H9r/2ERyXmu54hScyynOXTXKHNiIDSTAZcPzVy1XyG0VvSm3eCfMVIu7klH?=
 =?us-ascii?Q?zpA/qCaFLgvtMSb+icGkcY0xfZ6gmDvd9tWsiRqu9ywmnIm7/eoC6mtK5lpF?=
 =?us-ascii?Q?AqNq1awUnk7xL/oHXg1g5jThmnXl1rLos+afiOGolje+oeq+ZXnho9TTlCBX?=
 =?us-ascii?Q?DuCWYx1Fo7Vc5L5h34n7nr2WPGHPvvK//lnHAucVSLELffwmBHYqszbmnSTN?=
 =?us-ascii?Q?yeaK9hdHlvaZpLshsN55KPS1NnFZO3fP0nccLeTT8DjEQe172CtGtM+bvA04?=
 =?us-ascii?Q?ccEFz6y+TwZgY8bb75cYJ50MWNzwtD/9+fzAgXgzFjPWyOlx/aka8SVfSQMQ?=
 =?us-ascii?Q?4x8ruf5q762qBFSCSG7o6EiIRlJYM9qGuRhP+HIf4AQobpCxhs3Nxo1ocHtb?=
 =?us-ascii?Q?+dTJDanm/9t6niEEk7Wfb+kDwPtx6N/sgzAz1BK2InZ+6x0lxpiN17Qc2fpX?=
 =?us-ascii?Q?TqXbNyK1Ux6GvAW/0WtYM0YOXHKTqSFp2BzC7kYgIgGvFftqeMYAQonsp9Ct?=
 =?us-ascii?Q?3aScE8wfwIW69u0M2O1XwRzrqz7jx/zFkcF/ZWD48HhO+iw0sCilCohjPJiS?=
 =?us-ascii?Q?+hSIzIs2s7gQxCnUUBvLE+MiKC3Sc4JlIW1cqaJFKV9lCb1V8ToCRSnCW5br?=
 =?us-ascii?Q?UjilYO+Wvlck0CyovkujYu59hZ5R3bg7jlEPYrhVCIImzxj/EsXGWHxOwGbC?=
 =?us-ascii?Q?xMug7LW5X6TNJj/sirwZosmcbRZfjredKmjrPkQ0Ih3QPbFUTqyOpkbBT2JR?=
 =?us-ascii?Q?l9+AZzwPfcBtyY3SgLEdM/d0QSlnEqz48tvAkLXsxEwZydZQagvO2LJXdxgy?=
 =?us-ascii?Q?IW/r6Zr0x8cOJ85iJQT71V7TBReE0vpzyn2mAk0eRVBM3L6+bwkFvFVi3O02?=
 =?us-ascii?Q?z7KUeJKSl2rgxKmKYdDwAKnt8C1H2nd2IolYm6Oqvp6P1Q3nAt4mAasOPmbz?=
 =?us-ascii?Q?hQVvneRC82OULDsvECfeVw9HuOzrMCYkuDh+ZFCP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:40:06.6710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2503b273-c918-4b40-112f-08de286439ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
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

The Pollara 400 AI NIC is supported without any PMD changes.
Add a link to the product brief.

CC: stable@dpdk.org
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
---
 doc/guides/cryptodevs/ionic.rst | 4 +++-
 doc/guides/nics/ionic.rst       | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/guides/cryptodevs/ionic.rst b/doc/guides/cryptodevs/ionic.rst
index d563602ebe..7c9d2ebd04 100644
--- a/doc/guides/cryptodevs/ionic.rst
+++ b/doc/guides/cryptodevs/ionic.rst
@@ -1,5 +1,5 @@
 .. SPDX-License-Identifier: BSD-3-Clause
-   Copyright 2021-2024 Advanced Micro Devices, Inc.
+   Copyright 2021-2025 Advanced Micro Devices, Inc.
 
 IONIC Crypto Driver
 ===================
@@ -16,6 +16,8 @@ It currently supports the below models:
   `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pensando-elba-product-brief.pdf>`__
 - DSC3-400 dual-port 400G Distributed Services Card
   `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pensando-dsc3-product-brief.pdf>`__
+- Pollara 400 single-port 400G AI NIC
+  `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pollara-product-brief.pdf>`__
 
 Please visit the
 `AMD Pensando Networking
diff --git a/doc/guides/nics/ionic.rst b/doc/guides/nics/ionic.rst
index a991a2cf3f..2709a888fb 100644
--- a/doc/guides/nics/ionic.rst
+++ b/doc/guides/nics/ionic.rst
@@ -1,5 +1,5 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright 2018-2022 Advanced Micro Devices, Inc.
+    Copyright 2018-2025 Advanced Micro Devices, Inc.
 
 IONIC Driver
 ============
@@ -15,6 +15,8 @@ It currently supports the below models:
   `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pensando-elba-product-brief.pdf>`__
 - DSC3-400 dual-port 400G Distributed Services Card
   `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pensando-dsc3-product-brief.pdf>`__
+- Pollara 400 single-port 400G AI NIC
+  `(pdf) <https://www.amd.com/content/dam/amd/en/documents/pensando-technical-docs/product-briefs/pollara-product-brief.pdf>`__
 
 Please visit the
 `AMD Pensando Networking
-- 
2.17.1

