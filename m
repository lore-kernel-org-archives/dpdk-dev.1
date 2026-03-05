Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB7F30937
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 10:52:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59C494029D;
	Thu,  5 Mar 2026 11:52:11 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45]) by mails.dpdk.org (Postfix) with ESMTP id 752F84027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 11:52:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5QuUbgn/nFkZOCU1cvARJzZFPjezmPnUZ5QGJkUjYVSZpKqybBFSx7Bpu4zP3Ls4V2qinBLp/e1KAQFOQB97VTD+s+SxzY7aVcvWOLXvIsFna1jJITaPpk1yqlWeHk7yhpK+A04JHdpLL1TFV0Gw7oVgD1AGr6yZ9hWX4z09NJ5j8jw0clRb62ndQdPn1Hwnojq8C+35S55mF1heHWDSoaKQCkliVsxTSmJMCx1gH3lrZhzf6ML2ZQOUvs1ouY0R5RPWDOvEuqXcJSQWvRXPJLzcqJ8TOrdGS29boZqkcf3HZv+faCiwxH7qwe2XRKl9Hbs1wpVJaxdBW9RF5hypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh8TZNVF6VSmyqwGkM/zVx/rQs9j0E9EfJd9RVYquuc=;
 b=wvMtCYJaL2FB6qVdAwgOi/iMN34xwH2XFrHmRfgLi5kv51WJEnRiaMt11iDomnsGFngkEeELkpLjXvtrk1XDln3PsHARMcJ6txCRlRjnNupVWkcTypjPZpWnufiam5dAGpRfWXjF03cD+PtCGFh4D2g6WI7/SG4QFBeUHjPjJgdjvirKm+ypkh4InnqnvUsl0UO7fghh+Lul+stpO46QOFdoD31c9dpL5sUGXMpxBHhhhXnf0rWw/tHZucGRFHWlpqIethdDv/jZJJBdjR7vbWT7yvCS5ew3dysQdYfBP+ApGwdzfJ2MPLujJ90k4cLi9PABvwoMSUjnSOpdkIul+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh8TZNVF6VSmyqwGkM/zVx/rQs9j0E9EfJd9RVYquuc=;
 b=DagpOyQFfR8pB2n/bAQgpLKlNoOdib3t42g1ZVTDiv5HbhLhL+9/SLfVsQBDFaepYaliEFB4CeEBgr/r3o+I6nzo5QJFB04fDaH4SFVM88onyAxPIrBYW4Kt4Erw3z69IRV6jBDl41r/WO5HqoGIUGFrAPjKaAQraIgOi9dWAP8wNY33OatcO+FiaiGQyKBFk6jQgkKhvrJRJN3mhCZ/XS3DfkVq/qEIPMh0iMtTL5qQplVGJNskXUJQ/Pqf39LtBTI548dyNXPaFTKfyXKH9erFV2jLNHVC4zBIv6Atq5mm1X5oNhrW2tC7dvPEurTDOlkPIzTK7sqzHo40tAuxCg==
Received: from BL1PR13CA0359.namprd13.prod.outlook.com (2603:10b6:208:2c6::34)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 10:52:06 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::d9) by BL1PR13CA0359.outlook.office365.com
 (2603:10b6:208:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 10:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 10:52:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 02:51:49 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 02:51:47 -0800
From: Ali Alnubani <alialnu@nvidia.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>
Subject: [PATCH v2] devtools: fix symbol change check for non-lib patches
Date: Thu, 5 Mar 2026 12:50:16 +0200
Message-ID: <20260305105016.1093351-1-alialnu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305091039.1057276-1-alialnu@nvidia.com>
References: <20260305091039.1057276-1-alialnu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: c059fe43-81d5-48da-149a-08de7aa53e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: c0Bs1wUWxRR17YTTVEwQox0trcQQNpfzmqAWLNvS4PNBYG5/2+nEo7/4k7749536SJMlie4ztmaft+k9d5W5jC20nR3ayULvQlrXr/7afn22ou5PAvDCdhUrQvZT+GRYvP2xp5b33pH5sGj7uF8VRHG1AMC/WllZcHe1aNXVP9VAnu29nldgCXVu2wRRl8BppmiO7N+JzI22H8ER1JDkf732O7VlgmBvLowi0xAF0vGn6aNuYSm3ne0KByarqZDj7MHVVLdH08kXlPN4FTBaFi/oMaWxy211PGUsEmH8aIctlfoJZIuZIO7mrHK360dcsAthlGrS7492+WYbrKpplqexv8TSZTfKOO395cdIK8GONi8F7Uhq2wQUuhEGCes7shwerrOVW1RiY/egfjxDoWsbxFzNIgUkZVRrxfbuiJBH5KTZceKspxPjVm5S576Jr1OA+bmp79e4G0M90f9JiBgw+VerwyihKqv/4abCKXdJOsGx+6zleJ5afjCs0XJjP6Cz43yCCCXhfJ4flsYkD1sWuTYa9uqYzRcpZHUfev8ZZu19TFD7lzJQt/AoC+E5vxVXCQ5jBXxhiz7PYU9oyhGSrLSQBo5cNj0jWK3TsH7V1OHHDBimxrZhswfzoBkHvSeEN0qQSeMtPM5qK4nBlGc0FithNNqgSrHt/VloDzYuyJVlur1t3vR1yTMTvKqznkxp+Lq9f5b7qe9I/x0paJeNpyjUfwt+xtFgAJyHLXgjgVyQ1qd63AC3Cx/OKh55Zb0XSxyvGuOkFJOYPyOzOg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YK+fENiyf0cCxUzY7yx34jjJ0Oc6KRwiOtcJVtpx6a6+2gSUJyO2PzD2mtz1BxFayFHHIINcOidhHdJqkQNcsWDcqueC5btKecwSVUXg0/0eaq9QG6jljHtziyRG4r/jCBc4XyJ3CeFKkZNMweu8dhndPhZ3FMevq2qIfAz7HuxqCpRNFX3FjajynmXtGR/339vgT4o3TzdKIcdpDgQ2PGjCTAwlAFy0qak9OZ9iaAqMZ5qBLVJcYXtUHqZ8P34DtFmifoLWDp2GxZL7pdin9nnuVtpxA6qw7NnIah6IPHP0njW9xCQJRNwE8joz4/igxXrpQk6GCcyib/l7wdW3EN3OSXvT45MFhhZZDPUWkb7ohe33DLCcJ3SmMo5w0BnNGw30dohcBGsMjXFtxGpeunfmTTRqsLe340rCevPZchPIUXTmCAue9jXw+xRd+yUY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:52:06.2410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c059fe43-81d5-48da-149a-08de7aa53e2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

Handle patches that do not touch lib/drivers (e.g. doc-only) without
crashing. Treat every '--- a/' line as the start of a new file: if the
path is under lib/ or drivers/, set lib and process symbol lines;
otherwise set lib to None and ignore lines until the next file. This
avoids both NameError exceptions and misattributing export-like lines
from doc (or other) files to the previous lib when file order varies.

Fixes: 1a0c104a7fa9 ("build: generate symbol maps")
Cc: david.marchand@redhat.com

Suggested-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Ali Alnubani <alialnu@nvidia.com>
---

v2:
Treat every '--- a/' as a new file: set lib only for paths under lib/
or drivers/, otherwise set lib to None and skip lines until the next
file, so behavior no longer depends on patch file order.

 devtools/check-symbol-change.py | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-change.py
index 1efeb82fcd..a476ceae5e 100755
--- a/devtools/check-symbol-change.py
+++ b/devtools/check-symbol-change.py
@@ -29,17 +29,21 @@
 symbols = {}
 
 for file in args.patch:
+    lib = None
     for ln in file.readlines():
-        if file_header_regexp.match(ln):
-            if file_header_regexp.match(ln).group(2) == "lib":
-                lib = "/".join(file_header_regexp.match(ln).group(2, 3))
-            elif file_header_regexp.match(ln).group(3) == "intel":
-                lib = "/".join(file_header_regexp.match(ln).group(2, 3, 4))
+        if ln.startswith("--- a/"):
+            if file_header_regexp.match(ln):
+                m = file_header_regexp.match(ln)
+                if m.group(2) == "lib":
+                    lib = "/".join(m.group(2, 3))
+                elif m.group(3) == "intel":
+                    lib = "/".join(m.group(2, 3, 4))
+                else:
+                    lib = "/".join(m.group(2, 3))
+                if lib not in symbols:
+                    symbols[lib] = {}
             else:
-                lib = "/".join(file_header_regexp.match(ln).group(2, 3))
-
-            if lib not in symbols:
-                symbols[lib] = {}
+                lib = None
             continue
 
         if export_exp_sym_regexp.match(ln):
@@ -54,6 +58,8 @@
         else:
             continue
 
+        if lib is None:
+            continue
         if symbol not in symbols[lib]:
             symbols[lib][symbol] = {}
         added = ln[0] == "+"
-- 
2.53.0

