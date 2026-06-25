Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A3CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:08:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26BA340DCF;
	Thu, 25 Jun 2026 18:08:19 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010069.outbound.protection.outlook.com
 [52.101.193.69]) by mails.dpdk.org (Postfix) with ESMTP id 33C1540B9D
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:08:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0IibbVAfO8CfjEY3N2IIOjMOdgHIHrpk0A7EaH+JN+OEChxtKkqk2hSGXIZ29cj5ogEYjd5H12cWLV7aRjrj9sxsci4z5eWX/7q71SPUKp3sGNJS38BnAzpNT7Lb76V3RHRF+Mg7BT+zs1EZzrYyzMtDzkCb3QyVJ70a3hB+b87IbdBi//ZnLHYy+YRxZFJyR8/tSbwEbKSUGZpiBE6PGe+qTFtTPMShGKTakfaNRG/7pcCWOCjfr8Q7N2QDSlfl69geEgEqjG6CEgM5TyU+r+nRNBOqLOU0WZ4NlGMm4aZg7I8YySnCPWhEAWUHaQOYp3CDJ0kNqJ001dbGLNBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1AGb9yFQobsTQhj5bOLjwE4CuSzyIWI6d3T+BhqBdg=;
 b=x+8Fq2ac0XV+XsL7GZnuL3Kkgo+iCd5jgye1tArZq4Y53Vr4POguN7YdRG+aWco5yKat6RrhIykvtchL7b180M6Uy3toXArDhtUjQWdPIfg5AumxrYvD86Ocg2Rn0fEWKK8ex3ILzCIVJ2Fum75R8/7ZOwC8LaVigu2Ah84StoMNnriPXNMFRG9AWXxXtwe1qQHIz+up1E2dD0nkw0VxbLx1vy0sPFEjz9H1KHUU6IbpntDiMFJYFwUGCOjlH+TQjiCY8lzObqzD6jWQ0765A40grxQ8NMiZqBl0XRZVtpFkIW9ASfvv1TAZHbbRloR2/bngildw0aO4NtEUNWFJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1AGb9yFQobsTQhj5bOLjwE4CuSzyIWI6d3T+BhqBdg=;
 b=b0aLj5geBs4XN8WWEBAe779Azz28B9kI4NJ3ltHmIpZtCb7DGB7o+MRiYhVv9Mlr/glQAaIDgJX2EeaaJsz+jAA+9yTX9tFBxnz5BYuJtDyP31XIx8tiHE2tyRq1pMHFBo+QXzNhQB4H4piRvMvypIzl/Sr+OJf8YiTfCplr9ONv9AM0nnFCi6k6bx6XHKmCG1P0BDEG/dqvyx9XrFvfPFekI6VA9Dhk90OxmUmqc0U0i4VGWInscB8kc0zlAfAJrAvJo50xqeBX84B4oSo2AT9RI85enI2r3e84B9z2WRQTbGNhgkQHY2WpEsQ89LInxu9G6BJhqSoNymT6HyuDpA==
Received: from DS0PR17CA0014.namprd17.prod.outlook.com (2603:10b6:8:191::10)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 16:08:06 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::5d) by DS0PR17CA0014.outlook.office365.com
 (2603:10b6:8:191::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 16:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:08:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:43 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:41 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v4 2/4] build: support function versioning for drivers
Date: Thu, 25 Jun 2026 18:06:41 +0200
Message-ID: <20260625160645.1341914-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625160645.1341914-1-dsosnowski@nvidia.com>
References: <20260625133311.1299705-1-dsosnowski@nvidia.com>
 <20260625160645.1341914-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 70100907-2fc9-43e9-b3a9-08ded2d3f114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|10062099007|11063799006|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: iTZm3tTtHj38TqoUIHra6uUNLAb0x59EstdvAmlzz0l7x3kNVbhjRYD/3eNM2WNJLZo8yFxXbV4zQwLD1vq2BVCb7t2KtwB8+60ZsVH7UrHilVXf+Sn293QupUJxBfNteCQ0saHtGNnxer8cEfApnfrYJp3LvLfjKsIvZAtn985V17KykfOd4IH4MPGYusYOalzqaEbpmKdrt6tf+SxaN9frgE0kTPU2cwewi6TBlztFYHbSiUgio+RCuxMbuDiBXoQs3joeT1MW6l5xntHro8/qjgeENqnoOG0cxkk34RDu84qWCeL41D4COIW5AuszV0rAicum4jXGZMKfd1UogwFPgCr1b7y1aIdTCipE11ckQ9ingzgr+XWa0OS4tEG0UDfEbzcVYJweFA/0KMnCbZ7EjclN2U+t5e/ikk21fWmWmfOqnvtleA8P5AedYu3i5UHFG/EcUVSQniUhv9Th4B7vJP129ecfsOeI/qtgnDaZ95tE4CMEH6W3VSRJpG5I4CJy8keX4El7eiHAHpg1QOauivilouEpCWhZ0EedoiIjiQ0/R+QJY1Kwv3bXloXYOte0rybZ41mgj3bwGo9f8LBJ+i8GW8lUqdeR/lRZbVohtLXq7fGRdwFZp9uTc8LtHEuubZvtVGg+tDbu0CHfk8gRCKQ2VhhTcq84eqObcTAswpBgTfpqSvZ/k8nVKtN3AE8yIqFuqyFGdF+ubgM14w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(10062099007)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ggIRljKQa6bB/m6dsPSlYWGe5WKlIkIQhkhTyMhOgnj8JTyHJsL3PEJhVI4xlMcU0wKj+dv7HkX/T237mCYlX16NZThm3u21fGaRfR6tv4kvUEQvaLx12BcPfoqkDu+utkZjTSkEmBOxKuzc1wFVSKEBMOV0vc8JIPhedS6J3/MFYE1FW4YtwD/TuF/0kaRbM/Z+tTddB2rGM4xg9HSZLUERocxa148yU6mcDWiolGZ/5Ojzg0jzLWz0e2dgo26Rvc4BkWHlfd3neYkJaKNH0YpRMys1okC5CSVAYSzoZ3LNI6CdJv9ubHtiT5MRyZU7R2V1F89JT5E0mg68YJU3sF7MDTgZPq9OMtPdyZkaKZPhH4xQwXXFzttUBC+uDKBzBZNUbyo5iiged2z8vByYUF5BpGyKIwMZ2UPVesZ6qC0gmOtfBN/hKiNL4aIy7Tn5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:08:05.6326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70100907-2fc9-43e9-b3a9-08ded2d3f114
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
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

Add support for enabling function versioning
(through use_function_versioning meson variable) for drivers,
similar to libraries.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/meson.build | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/meson.build b/drivers/meson.build
index 4d95604ecd..79c215a7c8 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -171,6 +171,7 @@ foreach subpath:subdirs
         pkgconfig_extra_libs = []
         testpmd_sources = []
         require_iova_in_mbuf = true
+        use_function_versioning = false
         # for handling base code files which may need extra cflags
         base_sources = []
         base_cflags = []
@@ -273,6 +274,13 @@ foreach subpath:subdirs
         endif
         dpdk_conf.set(lib_name.to_upper(), 1)
 
+        if developer_mode and is_windows and use_function_versioning
+            message('@0@: Function versioning is not supported by Windows.'.format(name))
+        endif
+        if use_function_versioning
+            cflags += '-DRTE_USE_FUNCTION_VERSIONING'
+        endif
+
         dpdk_extra_ldflags += pkgconfig_extra_libs
 
         dpdk_headers += headers
@@ -363,7 +371,18 @@ foreach subpath:subdirs
                     depends: [version_map])
         endif
 
-        shared_lib = shared_library(lib_name, sources_pmd_info,
+        if not use_function_versioning or is_windows
+            # Use pre-built objects and pmdinfo sources to build shared library.
+            shared_sources = [sources_pmd_info]
+        else
+            # For compat we need to rebuild with RTE_BUILD_SHARED_LIB defined.
+            # Use original sources and pmdinfo sources.
+            cflags += '-DRTE_BUILD_SHARED_LIB'
+            shared_sources = sources + [sources_pmd_info]
+            objs = []
+        endif
+
+        shared_lib = shared_library(lib_name, shared_sources,
                 objects: objs,
                 include_directories: includes,
                 dependencies: shared_deps,
-- 
2.47.3

