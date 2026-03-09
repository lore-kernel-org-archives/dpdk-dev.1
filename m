Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26680F4180B
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 15:10:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28423402BE;
	Mon,  9 Mar 2026 16:10:04 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010020.outbound.protection.outlook.com
 [52.101.193.20]) by mails.dpdk.org (Postfix) with ESMTP id 1121140261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 16:10:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmxQJLf05RwF6SzEUfeks0SwmNPKGxznqcspHbAhHZ7yk6gjCTsskfMlE8efNrf1mdgv3ZwN7xyS/EBpFTTrXcg+xuH2usHDQS1jOZu1UbCxSTpwuUUxFTFJj5ld2Kya1GniGDAa2HR8cayXPc49dFsr3BEI7n3/5zXpIuVFgrU4ScgfmetBbj0w6pXTtqC1GR44vR7zXIMIrcG7NiovJfmz2nRorhdkuGLskiaUab2EcIzoMv+HiabaUq5LI+LcIf9eyWmNPfhGnMZCjfNR6n9l7Wlr1TJw15qPv5wM3J+G/dMvG7XB07MAmm/Al7TX9fffnHitw4BbOtZu2ILD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMKaeHzTpK1UWmIOZz8hrEE3YmGj6I6QouPz5eHvmtc=;
 b=zFAB/hRiCGkngAJ15ezlUiwuOruPHuoFmegyCshd+LA223n7a11BiBFcV9qsGKot7kceVreXtEynpfGpIpDhu1vFt1QvVldgN9snohsAA0lBYOaOV/RZbWYZwDZtRGkGgji+LHC4pGaBklvDZWOqscTVK4qnuhisk8TaG9c88xFLShtka1ELPvqOl3OKnmSZTekiDlWjccYhfrgyGaVn6o7W6NPjr9Vap6tWwExQphQ62jO1ApMTf6O+RH1DAj1Li1/1LrLSQLIgeW7M+D1Ee7eQ3ee+F6gGtMsw9G3B094uU+ssgRjDCkvRtZJowAciCsGGyj++3qL5SP8dIVbwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMKaeHzTpK1UWmIOZz8hrEE3YmGj6I6QouPz5eHvmtc=;
 b=HwWW5K0B4Gbb+oc/vJHU466ewo28wiQB8i1EvD6l/mzmlhGwLXK5MtPKTZ/A3mFVIRnUI8tTpNI5UPbInROnTRvDom1/YA/tdFNR+a6QujRZobGHRJFJZr/A75QWJCOeSo57P4N5IcKo5saQdu6OWr/DZTHgwdsX8P4R81AYKnRFDqCoiwYEBh9S9lvSdLBfqNOFJyVN0xkF0eSa7S5NIk5QERR0RdWZ+SaBAInRSKJhG6xAq7lCxyyxT1ZgkXxYo8JS3+ptoqNpSSfLHEMbQDmgTpCS1Cx5sbZDLepROUqIlNtjRTrA9Sn9LuV4WuzUv1AroFnHCTACXpZ9u9CpHw==
Received: from BY5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:a03:1a0::38)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 15:09:58 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::f7) by BY5PR16CA0025.outlook.office365.com
 (2603:10b6:a03:1a0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 15:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 15:09:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 08:09:33 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 08:09:31 -0700
From: Ali Alnubani <alialnu@nvidia.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>
Subject: [PATCH v3] devtools: fix symbol change check for non-lib patches
Date: Mon, 9 Mar 2026 17:08:56 +0200
Message-ID: <20260309150856.521907-1-alialnu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305105016.1093351-1-alialnu@nvidia.com>
References: <20260305105016.1093351-1-alialnu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd26631-a7b2-482b-1fb8-08de7dededd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: FDH5V17IBvKwWcsJ8rWjJbEY3oATEO/bQAwvHJsskSrhrYOVNm7gjilBnhkVRs4s6E7DEZ61Xh+1Dn9krZ+wkUYB+q8LEZ9H0h62gReUCzfccVGh32oPDaURCrBMc0aoEJCDcWclpy5N5oSTnTbViqiqxvXt8GH1XozK4+M0BNJyPVXgo1xK6ijDtTzaAbJfvIuwcsZRxjIMlSyXMt1dl+IQGKzYwr9cqaDLglcE4ZdO3hIENnTZCq0YaMvlNWjN3ppUKHLbZrqAt0NTvR4A8XWv76st97OSVerU8kr0i1etZ53Rbb8cE6aXZSHVF3e5lrHPqacV2h4EenkEK6XCziAC6RFYTHdSU6NDf6XZfcjq40UQzb8xLt97oIYnJiLZNDMUMtYaQUn8hxSz+rq2F47Pu6WFeya/UXRsc9d3MUimKYvEmWfFn7G4IvmuKL2oWez5GW0K6CeALpJn33t8jcNZcY+2G99aprbJkfQskDjc1WTYvnfX64/vm0Ry4aI1/H2xDRQTJiWT2TLEjqQEYVoDNg0EEaA24ugVv4l9CJRsWdeF5UmPylmCzQT07nN1vCokmxRPhLJr2zL/un8k7HAcyeqhICrzrnR3mEKoUUZ86ymAQYlryolfgU2vPAttf8nKVlV8DIhJPcOr4hoGxDzx3FM0ZwpF9szjDlf5IAe393H0PQpfxzH03W6OENijHJTTjYzy3g3L43DTIp6MsNWphojYEy2xnB1USSAC5r7A7NnkdTm37bZh/e0oh2uM3LGCYKchC0sFEGTYaL2fQw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XA9Na/lYHCUzzG6WaRabZLmr1mFmby9gXYIDEZZr8/gbzb4xk62u+DdBbb/1fmXpIhiS1Im90LRwwpBpZTh0yU7WXIniBhHTu/BNzjpC4KowCdPC1l6OBo3oDnzClL1gjIVuN/8XS2T9+GBcip69/5iAPCGpizgn9dlMiq+R1L3+vaM//uPnTK4s8hx5KChy+7HObju9SY0a62iL3PWj1+oDDgDmuesFFhMe6k0+9nYiYVpaQp5vdxroWrb/ygpfxBhRi8f/oXBnYnwaW8EYlHTIDbipvMmTWEo+Mw69enLVt7Sxvz0ktY1wqgRqT37N2sVQWidcexkoWITnUY0GatAL/L8KFTeb3WTGNyg3NVhKmeKAJtkQc31wHJh2RHUAH8CcFHpnJ7OjOWvniSjGyTPpo/ttwTKSQZ8sHg6vLsQmxK5Jjzvq2K1ChRVswNMr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 15:09:58.2041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd26631-a7b2-482b-1fb8-08de7dededd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
crashing. Treat every file header (--- a/ or +++ b/) as the start of a
new file: if the path is under lib/ or drivers/, set lib and process
symbol lines; otherwise set lib to None and ignore lines until the next
file. This avoids both NameError exceptions and misattributing
export-like lines from doc (or other) files to the previous lib when
file order varies.

Fixes: 1a0c104a7fa9 ("build: generate symbol maps")
Cc: david.marchand@redhat.com

Suggested-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Ali Alnubani <alialnu@nvidia.com>
---

v2:
Treat every '--- a/' as a new file: set lib only for paths under lib/
or drivers/, otherwise set lib to None and skip lines until the next
file, so behavior no longer depends on patch file order.

v3:
Use a regex so both '--- a/' and '+++ b/' start a new file, and run 'if lib
is None: continue; right after the file-header block so non-lib lines are
skipped before any export regex is run.

 devtools/check-symbol-change.py | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-change.py
index 1efeb82fcd..b1daa2934a 100755
--- a/devtools/check-symbol-change.py
+++ b/devtools/check-symbol-change.py
@@ -7,6 +7,7 @@
 import argparse
 import re
 
+new_file_regexp = re.compile(r"^(\-\-\-|\+\+\+) [ab]/")
 file_header_regexp = re.compile(r"^(\-\-\-|\+\+\+) [ab]/(lib|drivers)/([^/]+)/([^/]+)")
 # From eal_exports.h
 export_exp_sym_regexp = re.compile(r"^.RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+),")
@@ -29,17 +30,24 @@
 symbols = {}
 
 for file in args.patch:
+    lib = None
     for ln in file.readlines():
-        if file_header_regexp.match(ln):
-            if file_header_regexp.match(ln).group(2) == "lib":
-                lib = "/".join(file_header_regexp.match(ln).group(2, 3))
-            elif file_header_regexp.match(ln).group(3) == "intel":
-                lib = "/".join(file_header_regexp.match(ln).group(2, 3, 4))
+        if new_file_regexp.match(ln):
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
+                lib = None
+            continue
 
-            if lib not in symbols:
-                symbols[lib] = {}
+        if lib is None:
             continue
 
         if export_exp_sym_regexp.match(ln):
-- 
2.53.0

