Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5D3EEF33D
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 09:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27C7C4029D;
	Thu,  5 Mar 2026 10:11:44 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by mails.dpdk.org (Postfix) with ESMTP id D7D194027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 10:11:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rl6UurLPK1rvi8ckuvwQl8uC0AzhopCuilgo4IME5okethy59m6hX2c7PHs0sQ349eFMgjqIJacTgh6UhFC0XFd7LG14VA0mRfFyuN/jqxK+BnAZbiHVr0P6N01LS42UnnG3Y1TGJPOfPfudRQZ/L4gxYHTSFrLhGeh1n2kFARlE7Yeztp3LqalrzDXgMQpM12RYSZ3Eh4rkVjCBhyEFsiOu7GVS4g81lMklUVOZVWJTNyLaoRF1MfohjEHWhJlyaD7tradQCcRZeSt0XAGFa93diovCBu6K3roOCftCKoAY1XyNKA44B5jsKOtXygUBe/w4EqFFLi9o4/7REF2cUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9dz3kZClT5NgN9hsI8HwAGEDbxzp6pC+G08pHw74X8=;
 b=xcgD59zhyN4Onl0RVu67UIeiLeMmWfwAXU2rgqe0mWbKAPnLo602/hmagy2Dq1h8WOA1lZXPqW9Jry+gGzr7GxPUBfL7SJ9BNlkauuN4NrY/IAChZRKUhLhRXGUYPDsYzCGisnb5scttDzAsCDxpHzVQM7kvb0cHi1D9nzR0gFtHDJ1WBtrfZeefWXCdhgLa4U1VQPzfSLheQoUxuBzvVql7mphJg0phFJMtnejWaVaUGoof2hyClwc6k1TdS+WtXBh4GXOmxdlcz6R2ivd8amhqapJz+CyMlTbQy9YOO3mM1PgykWnPYz5EdJB8PSMGhGEVifKd3MMnNuEgw1Sysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9dz3kZClT5NgN9hsI8HwAGEDbxzp6pC+G08pHw74X8=;
 b=hl8ZjXjJHSEHwOnGsztsVQBGrZbbd+UiDD/nd6WwLXSyaqrGROxbJGuzZKV4/iFY2B0SZ2dEQpvz5Vmim39VSjU5NnMGP8DFQtaEZkxkiAErLcaNq/3fHLjGeWamkj2cTdGkSm3YRclIzkAWencFJpV0s8BkXP7UoEQTg2qu6inEIjx/NLTm1NOCROmv2L5EiPdqtZwLpfqw96jirhW4DIRkqnL4aSP1Yawuymi+XQIhe061HHzV4W8kVhapiYvZIAR0A/KJoe1iy/wI+NOJ2sjF8KhWd3aA5PXNUH8QIay++lP64/9DLaNaSEplzbflqTn3FToXi1ajHwqXdscVHA==
Received: from DS7PR03CA0249.namprd03.prod.outlook.com (2603:10b6:5:3b3::14)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 09:11:39 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::19) by DS7PR03CA0249.outlook.office365.com
 (2603:10b6:5:3b3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 09:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 09:11:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 01:11:23 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 01:11:20 -0800
From: Ali Alnubani <alialnu@nvidia.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>
Subject: [PATCH] devtools: fix symbol change check for non-lib patches
Date: Thu, 5 Mar 2026 11:10:39 +0200
Message-ID: <20260305091039.1057276-1-alialnu@nvidia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: cce13faa-0ee5-4c94-cbab-08de7a973588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: hayJEW0m5Rkayz7/miZiQUrQ4+olBSmvuoFLqOcXOTa80OSb/ji1bqrmlvaC6eHtqSaplsZFC4KDGGmR9j9BVYF/NUD//Z/ANC5CJ8MlqAAi/n49ipWxfizDyOKbHRvI/aeR+xHwrAKTIsLErIIwgdPiI7DRtDTu3gPtz728H/M178/yOSxKB/7jZTF1XPdQSt3oF+jXK1OhMzbqm6g698kGcTIeClQK11EIUzPnI5urYIRAkXn1xzgWF++JXACTidrOzV/yYJX7du7qXj3qLb/WIN9Rl3VgZP2ENJnv6UxYLWRTDe89/7zEbTJ2RmT75L1altn3UngTRZRDDo+qB4cxOjoRCOSQ7DQUCbJ8KZPqJjTrYfIiNFazXrUTYS+iDEXda1lAo2uIn4CAHIify7ZFIultlE1eM649MlUboXVBb9UOgFQce4Ag34mWIzjH2PVuGlSkVNyjJsRavAiaavqsGzZdmMirG/VuH2ZxskK40FhdiReaLTKgL9IxWlZ41oZUyHCagXmMw4vq423Z3YvHXY6XL74lwaClHRmISuPe8vBpKhPnkBwqCgjBvypEk3YXYEmcHW80dOduWEflqXpTTBWuNcwh4rOfUqMR8j6uVJfkmKx1KtMz4jT0hDEkmIQ4iK+dX3wkUhgygUOzIIe7GcGrc1Fp5Ub7dWV6CY09JXEbHOFbnjOiP9ehUPwnIMcze1CjHK/FsnibSpbz5AkvmQloi87fGtExu0W++3u3ljhOYFMATdfToymAyDaxtmbMZY6CFCxVCBpCChL77w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i656Cw14mlhnPnsjUgUyEyrDjQM35WjuspqF8+C6GLq6wTuc5jlxMSjO3U+zP90YoJzZmahVE83lvnSdCXbIsuFlf4Zwxizk7hXw41duMd/Xjb0GMZY2KgmPVEXCckD+GrrgipPGBpCY/sXLRLJV5IoLi6md0yKvRZFwlzjZVZ+h8XyZ5Urq6bN85hKP40etW4htcu4WYeODOSlsgnuB4WMeQTmh5wTZhKdoEFknnCaA+2QM2BGbQkX4OfuG+WGJuypVU4u1D3BB9Y1y5j0dBJ7p9u9UyZSR8qXUNjWLWEMkof+ZcOIMze8CakEvp7FUSZGNZRY8c58sGNrbuhHjntsImwZ+XkLe+GpljtYcCyGxbkq6+NRGNeGQ0LEqwS9Y+Rp+WPDSguui9JLmZ7tfjioGzcXXG4b84UcJQmv1Jc0s2wqnEk/LvibGMN8UZcf5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 09:11:38.8776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce13faa-0ee5-4c94-cbab-08de7a973588
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

Initialize lib var per patch file and skip symbol handling when no
lib/drivers file header was seen. Avoids NameError exception when
processing patches that only touch docs or other paths.

Fixes: 1a0c104a7fa9 ("build: generate symbol maps")
Cc: david.marchand@redhat.com

Signed-off-by: Ali Alnubani <alialnu@nvidia.com>
---
 devtools/check-symbol-change.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-change.py
index 1efeb82fcd..4cee4c765c 100755
--- a/devtools/check-symbol-change.py
+++ b/devtools/check-symbol-change.py
@@ -29,6 +29,7 @@
 symbols = {}
 
 for file in args.patch:
+    lib = None
     for ln in file.readlines():
         if file_header_regexp.match(ln):
             if file_header_regexp.match(ln).group(2) == "lib":
@@ -54,6 +55,8 @@
         else:
             continue
 
+        if lib is None:
+            continue
         if symbol not in symbols[lib]:
             symbols[lib][symbol] = {}
         added = ln[0] == "+"
-- 
2.53.0

