Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D08CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 13:34:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32FB240A89;
	Thu, 25 Jun 2026 15:34:44 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
 by mails.dpdk.org (Postfix) with ESMTP id 7571640DDB
 for <dev@dpdk.org>; Thu, 25 Jun 2026 15:34:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNmu1UyprSnVrEGUTAe/RXENhdCdIYQuYkFsv/vfKldSL8MssBlGdE1xGA+Hp5v7MoZYhzhfboOw599m5yiQ/dAFxuNQzgbHp+Oh6PbnbD1c0iAbpglLvpNfeEW5CsB3g+Wr+AFOPOwiimve9yUiFB3ugc8PUwg8OQVf1Vw5sEBFFWphPBi/Z6+IGAxyTAd/koWVtIS2bEW2DLpLlxnwoXud2TrWE72mBDqRqmVbLq6wJSuVjrMTskKhuQ3XWy0MlU6ASZznnLluwWzih5KgcZYnQb6YG5QXshzgWR7lubYuOVIArzfNjX525tACwujxsw0F5EjiNjf87uX2dl6jUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00j758b9pncH/45zpE47fS96obYuPhca9bxpq5VdpAI=;
 b=hm/Wpx06HgETBdi7s3TEJ0pkRcqY/rbE4wj1rsOhRzTe7GAl7WaIwtUoojbtWFtUX/pf/ERST+d5uUozTn8BHfk9J0hO5pqMmuWl6wpEUSIMYqYe0301/8EV72Zlspp7tjTSfInXOkEpjiKzjnY0QKiX1nsFLkmhjXVgrA/HtdWXvFxcd1sB+Mgx6Q68eG2T6SHItQe8HyU24ClDUDe3ODQlGpCDyX0iWlBINuT7JllWrKGep5S9w42gaJB5SDc3cdv4qDuRt+3iLD0v5AmlrPo9tQKnA4Z6PPW39w5BU2g6fG1cKEkIi1V4ui46ABxmfQAUeL8pjOktfhaEfJumNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00j758b9pncH/45zpE47fS96obYuPhca9bxpq5VdpAI=;
 b=c5nQembJFA51n5ZM6qiF4gKQt6lK15cX4kYK+5qZm+QhVPeetXgMQ9kP6f010jIkXQ1GN6NK8mcQMKwU39hfdPHCkIyRTHxJvU5nmbxTgVf5JU4bnJfm809xXYnUm16uM+o6hNRWm0SHPCYw1KRlLoFBMX7mS6YMKsx+VCKotyWK2a8w+hv9EIq1/mOMMC4e1p3+nISU0AF2OhGdTsjM3MPKKKmFKdYkhRd50aTh9MDMuG3KNcBCzXFk+TEDrXcjV3/NaDo8FA5UkLSZ3D1BlqoikxEaNG49ExSDuOsBfuHju4IXbgez9Vvvk4gjDLka5Brjglkpp9RwwR01RJitlA==
Received: from BN0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:e8::24)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 13:34:37 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::56) by BN0PR04CA0049.outlook.office365.com
 (2603:10b6:408:e8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 13:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 13:34:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:10 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:34:09 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v3 2/4] build: support function versioning for drivers
Date: Thu, 25 Jun 2026 15:33:08 +0200
Message-ID: <20260625133311.1299705-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625133311.1299705-1-dsosnowski@nvidia.com>
References: <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260625133311.1299705-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eeff3e4-8747-4a79-8fcd-08ded2be7f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|18002099003|22082099003|10062099007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ettJZwwRXKZmf7ILprFGg1fAuoK3ej2xGh86BHOH4lXAYkhxyQSK+8mBDZoAnmx9AVPCqhTIsuUMIfSJFt76qHV+9i7tA9Ukwq7Qs/8QjTVIpsad7zOvKUrYx7WYc4dfM4B42k5xz8aTCsKc8CRtzqsOGhSp4H7wm8nC67q94026XvCU1I2C2EegmVQ6xeVMny4pzIMYuLqws2oNSmI6hwlqL4NRarUCley5FYWmngfzJm/qhyhkJQkETiIMz1PK8oREZIvBvZMOFRXEfB5EoV6Rz9IoGnpMGKtt84Fm0D8k37U0vPJMmj2v8eMvfCvG4lFlh38WylMUDPS7ifD1kYJzv9dSz487by/00/ZsgoUCdLu6U122bgs8tz9754uLRl2OVpbDnF2GyzR2UwoULawd8pRuTUje0m7xR9XHoQM1tJNHHlXmrnIZ4P5IDuPOh0X0ruLRNbsAFDvmK+Q2ku0P35PniCgPHiYUT8lUfNo0MElzB93rMSHnIAWzHZjUzZxYQREw0LeKaEKxnpYg6RlhKTnK+PBqvfrbs4Do2iR2VMr1V4L3TD2pzpMUFDZHBaxRHPFqPh1CtHSS+X6KJ8zWKv5PZbsZoWda11OJvws6idYT3GmEVQX7QFacjtjXJ2xBWsPt10Zt2j+to7UkT1BcLyNm3Fe4are89fLRSFSFU96yLWbsYPQi/fIZewBZskreUvQw3pah+Lbjif0wUQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(10062099007)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i90/Mkhzoce9iB/VmNpnFS60G0+ybeTapBCItDNm89YDiz8yY+ozaPzpGyEAgrdhJWXHPdF5zDdi+1Bo1q0nbwsoCi4dH/bFOYRforUW8hNUBy+9o+lOhH2nq3NUVlMGU1xjqS+zQQ4N+LrousxlnyG1GhbTK6FMMy+HxSConxTRMwK30+ECKk9LtZoeKF5NR36dCoLjk5VZFYBEegGabcfPCUZJKIStYPPh9xYa9PkepoZ//bvQXyObcYBcBIAbysK4d2Cghz36tNzuejirUsqtwnSCnLnC0pSCljP9qZ1gZL3JDY5/2ZrW02J8oj62VU8Y8W/xBzkA68Aiz6UmClnDh5wG93cpGaoEAifLlQZBfbPQyKT59pEvMaQrqeMzlDf1rNaba3kNB2Ad9UasGN5AyMhLiy0I80UlAU0Lkw2/GP1d2BhHWOUUT4SB/q/e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:34:35.3280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eeff3e4-8747-4a79-8fcd-08ded2be7f54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
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
index 4d95604ecd..8f3ab490ee 100644
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
+            shared_sources = sources_pmd_info
+        else
+            # For compat we need to rebuild with RTE_BUILD_SHARED_LIB defined.
+            # Use original sources and pmdinfo sources.
+            cflags += '-DRTE_BUILD_SHARED_LIB'
+            shared_sources = sources + sources_pmd_info
+            objs = []
+        endif
+
+        shared_lib = shared_library(lib_name, shared_sources,
                 objects: objs,
                 include_directories: includes,
                 dependencies: shared_deps,
-- 
2.47.3

