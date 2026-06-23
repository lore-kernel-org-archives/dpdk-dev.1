Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6308CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:39:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACD5E40650;
	Tue, 23 Jun 2026 13:38:53 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5761240668
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:38:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GosqGIE3vYP4/+hddXhcCQmI7IWdTyGyv/bDCcBaqpEMNLFJELt1n9DsIvWJTbTx2dYrmYm3sb1MyXLv76lpol55luwLZ+SHw/d1dY1yxmOuPp2twCIZwZBu6ii5dBzzWVRqOKwX8quG0tw6GOlTbyeq1pb8nEn/gmIRb3gWfPMtUdSPqXytYg/JjyHz7wOIY/mXMe/yFQTT0N6wP7oyDmDBaXrfqPt/EbJZDZlGFdoS4pgnCzHwx/kLSWPPZhlPvjZY7qFkqbHdPlKQYAZUwa/8/NzqbKMcwCUHUryGGNEDGi5ZRezlmEjMVqHs8/eDcIvfOOmz504LgmTkSjn6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRbV+Cw1KIqEt+/YjW4xu7w/XjjuDC+PBJMkkR986Ik=;
 b=UDy9rP3UIC/CPt1FUrEiL438lwtLrpJP92BcvdYCwy7tF6dLn9zN7EkUhkI6RRtJy4IlhemT9GmMNv/ahBvc/ybo9iMRalOtnmO6Kgp9CITQK7jpldTZZ7uM09Aw72NKJvIvZq84EYgTlZ85VMY9Gg/gvUAqA51fiOGRv9vzl0ChE/m6ihgfuZXf3N98+sH9ouFCfGH5JCyZAlq8uPbj/wuuLQJIk+RcKUmpacLq06jgtF9QQc9DP+795I5CH4UxTveCbXQUsYUxYZkGFothy/YikoBot52gPL5gODD+VeYewr3FXoNK60w1AsUGbhF26LAOCERuRnwiq0foZmWisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRbV+Cw1KIqEt+/YjW4xu7w/XjjuDC+PBJMkkR986Ik=;
 b=GYuE7JJoJ7J3PICkjM+E1PGF1hh0PcZRCAj1XMETOhr+V6SPvmVmy1LQATxdLSlpOVDXef9EswiP6CTCiBce/Szx7fl4vQzenu41O/OGuRqLVpbUXWl6052RSYOSXQXKnol55AUN86xicjLyYfb8xmc+GTiZ7FZzd+FLmqzNy4PHC1EDCphKfj59OouWAzAeKVwBxA/frvTTk1ixFEJP7is4uW3BRcq88uKWdjsfG2x2DvX5Hez9n4SXnn08whDxvKRWY7DuMDfWxE2cMoWInaOABydf4jhchja+DAgitM8MCSZi1UJtU7Qty7kTpCICTHe6sHzCJBEasynTAyCkkg==
Received: from MN0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::32)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 11:38:43 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::40) by MN0P223CA0011.outlook.office365.com
 (2603:10b6:208:52b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 11:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:38:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:28 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:27 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>
Subject: [PATCH 4/5] eal: support aliases for versioned variable symbols
Date: Tue, 23 Jun 2026 13:37:50 +0200
Message-ID: <20260623113752.1100072-5-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623113752.1100072-1-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bcd217-df8a-48ad-c207-08ded11bfa63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MhPP3w0pwqQQyxkjQe/tp4Uxi2q1z9SiVtmk1PU2e6dYIQM7ydnTN3TTfJ+K8wXzzrLUaxPePjVOxIXXBi71WSY+/qe/r/OHc4eLOSLW+/BZp3MwE7K9YFJnnKsn6MSRmc+oswck7R7fbSYiiXIRmSh9UOUH64F4EGmIf8oU0HTwnxQ9bbqMcw7RmrBfXg4abm6yHh/IRxIVkxJIbpBYz3tk5xj53sQ3hIz0kkGhl1XQjBSAbfAiCfcNhXZOCkFbJ9e25+KZudy2n/0Exf47of7QUFnI4sk7LJZ5vXh1OOrW9/LUnMcYPbGDvdkc5MqI6/VwZfmoucfsTwXIQ7vPIsEpa+nqOSYtmXIY2btIKxFQgZMLdFDQPH3WuNSgjbY4t7Sh5C4uRw7qWLd696plFoODkzF22A0JnQlmqJHQ3btVZ4bKyNvI4B03Hnfjc8wHuaMSPsrycc/Zt4J7YijMZkoeaTLm8rchLKuKov8AI1Bq9IXEdJ6z9HBEk66OCTsmR9BIYPXV0oCJ8kh+YW8/KoM9JeWEBuXuJlP0ynT5Y2HNvRaPmB3dnJLDaaU3huHeUXYzNdwkHeHmt4y+K9jEBgLb8U8gw070TECQ0R4RZKdTmIpcTR214i1YOOlGiMiSyZkjGhlOd9sxYVpytBuzVaoWVxPzprdfB82k7v0khf4jIf68iYEewL5wWYzSqV4in2z1R8OXcZfzQaA92s45IA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c0GIghM8u7EwF2evxOpkgC0LYe4+gxPgE8GH9hKzGlRJfb2XMGddG2fFd8mcOUf8sKiEpdULoFVVHLqpkeCHGmu2xUv/qFx8dTN1LVCWURkzOnrr/MQ3AtYJIbFHlIrMGhfYA3r0A4C6LvQ4mPm0XFsqkbbod9QzlRKGlffYEkkVE3PBxM/WTIZzTNJ+npjLMBrNFgS7BdoGjPGSuQq35UgqDJs5ETE9JOBCs12pRxP98VPfYDxvdWUjjq3Vu57fUNUQupqa8FdHt0d47rt3lsKipv5/biM6uTqBJPsuL7iyX4lT2ZOC+J0v4msnuB6Z88uP0NICNyNWDEAOWxYwP96CGKOPQWByfCmt2dg4v17tczI5FghuI6I543OGlqbBdLYzKiylqVlezyBzJ+i8yIDUsIU/lF1WgvexfQPxQz1HXOMxTqsKzEV/xVKzmVen
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:38:42.6435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bcd217-df8a-48ad-c207-08ded11bfa63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
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

Existing symbol versioning macros are not suitable for versioning
exported global variables.

Specifically, if existing macros are used for versioning
global variable symbol promoted from experimental to stable,
result would be multiple variables with separate storage defined.
If an application was linked against older DPDK and had copy
relocations, this would yield an inconsistent behavior:

- Application would use experimental symbol version,
  with storage set up in BSS section in application.
- Library would use latest symbol version,
  with storage set up in BSS section of shared object.

This patch adds versioning macros which utilize symbol aliasing.
Specifically, a new variable (with version suffix) is defined
as an alias to private (static) variable inside the library.
Variable symbol versions are attached to these alias variables.

Following macros are added:

- RTE_VERSION_EXPERIMENTAL_SYMBOL_ALIAS
- RTE_DEFAULT_SYMBOL_ALIAS

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 buildtools/gen-version-map.py | 11 +++++++++++
 lib/eal/common/eal_export.h   | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/buildtools/gen-version-map.py b/buildtools/gen-version-map.py
index 57e08a8c0f..aa88e69179 100755
--- a/buildtools/gen-version-map.py
+++ b/buildtools/gen-version-map.py
@@ -14,8 +14,12 @@
 export_int_sym_regexp = re.compile(r"^RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
 export_sym_regexp = re.compile(r"^RTE_EXPORT_SYMBOL\(([^)]+)\)")
 ver_sym_regexp = re.compile(r"^RTE_VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+
 ver_exp_sym_regexp = re.compile(r"^RTE_VERSION_EXPERIMENTAL_SYMBOL\([^,]+, ([^,]+),")
+ver_exp_sym_alias_regexp = re.compile(r"^RTE_VERSION_EXPERIMENTAL_SYMBOL_ALIAS\([^,]+, ([^,]+),")
+
 default_sym_regexp = re.compile(r"^RTE_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+default_sym_alias_regexp = re.compile(r"^RTE_DEFAULT_SYMBOL_ALIAS\(([^,]+), [^,]+, ([^,]+),")
 
 parser = argparse.ArgumentParser(
     description=__doc__,
@@ -73,10 +77,17 @@
         elif ver_exp_sym_regexp.match(ln):
             node = "EXPERIMENTAL"
             symbol = ver_exp_sym_regexp.match(ln).group(1)
+        elif ver_exp_sym_alias_regexp.match(ln):
+            node = "EXPERIMENTAL"
+            symbol = ver_exp_sym_alias_regexp.match(ln).group(1)
         elif default_sym_regexp.match(ln):
             abi = default_sym_regexp.match(ln).group(1)
             node = f"DPDK_{abi}"
             symbol = default_sym_regexp.match(ln).group(2)
+        elif default_sym_alias_regexp.match(ln):
+            abi = default_sym_alias_regexp.match(ln).group(1)
+            node = f"DPDK_{abi}"
+            symbol = default_sym_alias_regexp.match(ln).group(2)
 
         if not symbol:
             continue
diff --git a/lib/eal/common/eal_export.h b/lib/eal/common/eal_export.h
index 7971bf8d7a..5b458f81c6 100644
--- a/lib/eal/common/eal_export.h
+++ b/lib/eal/common/eal_export.h
@@ -63,6 +63,14 @@ __attribute__((__symver__(RTE_STR(name) "@@DPDK_" RTE_STR(ver)))) \
 type name ## _v ## ver args; \
 type name ## _v ## ver args
 
+#define RTE_VERSION_EXPERIMENTAL_SYMBOL_ALIAS(type, name, orig) VERSIONING_WARN \
+extern type name ## _exp __attribute((alias(RTE_STR(orig)), \
+				      __symver__(RTE_STR(name) "@EXPERIMENTAL")))
+
+#define RTE_DEFAULT_SYMBOL_ALIAS(ver, type, name, orig) VERSIONING_WARN \
+extern type name ## _v ## ver __attribute((alias(RTE_STR(orig)), \
+					   __symver__(RTE_STR(name) "@@DPDK_" RTE_STR(ver))))
+
 #else /* !__has_attribute(symver) */
 
 /* Use asm tag to create symbol table entry */
@@ -81,6 +89,14 @@ __asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@@DPDK_"
 __rte_used type name ## _v ## ver args; \
 type name ## _v ## ver args
 
+#define RTE_DEFAULT_SYMBOL_ALIAS(ver, type, name, orig) VERSIONING_WARN \
+extern type name ## _v ## ver __attribute__((alias(RTE_STR(orig)))); \
+__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@@DPDK_" RTE_STR(ver));
+
+#define RTE_VERSION_EXPERIMENTAL_SYMBOL_ALIAS(type, name, orig) VERSIONING_WARN \
+extern type name ## _exp __attribute__((alias(RTE_STR(orig)))); \
+__asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL");
+
 #endif /* __has_attribute(symver) */
 
 #else /* !RTE_BUILD_SHARED_LIB */
@@ -97,6 +113,12 @@ type name ## _exp args
 #define RTE_DEFAULT_SYMBOL(ver, type, name, args) VERSIONING_WARN \
 type name args
 
+#define RTE_VERSION_EXPERIMENTAL_SYMBOL_ALIAS(type, name, orig) VERSIONING_WARN \
+extern type name ## _exp __attribute__((alias(RTE_STR(orig))));
+
+#define RTE_DEFAULT_SYMBOL_ALIAS(ver, type, name, orig) VERSIONING_WARN \
+extern type name __attribute__((alias(RTE_STR(orig))));
+
 #endif /* RTE_BUILD_SHARED_LIB */
 
 #endif /* EAL_EXPORT_H */
-- 
2.47.3

