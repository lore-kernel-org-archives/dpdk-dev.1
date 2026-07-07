Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A518C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 13:31:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1E384067B;
	Tue,  7 Jul 2026 15:31:04 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
 by mails.dpdk.org (Postfix) with ESMTP id D16624025F;
 Tue,  7 Jul 2026 15:31:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9q7BGPHJeYSrcR9FZigsAtWoHo2K4HMv0yFotR/Q5a/U9IbAJq2NynIdFOwIHrHIES23NsuC/l9i6GLRAvj3tspq4SbAdsnaUMKeYoLftbHst79w19XL2jvXzJZVCSI7/lOl/faaq/6lWwH21m93w6h+zN7kaK33hV5FDTayr/KfHPzh/Uzx25TEdj9RfJgH0Wdq9SFWo+SaECyb83iBV8G7ijiiF1lu2I0qRXv+LtZkKx8AIn/AiJ7M8kcTU7HyVSvtigiy50xHZ1h2UefF1t02jONQbn+GAlJ7EOvwscK5zAvEsdmecK/oaoWfL3J8IL8qWzT2G/Rm36JRlkNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oRBHl6JazleSasNmAB4Efm+YPxoG5VDKDUgDuT+AnU=;
 b=l9Y7rimX767CPPXvcJyMM9+RyOcb+fF90mwkAKmBFnR9O3t52PZI2NDhx2LNzsobBcj4EVCUWvptG6cu7M1J6XuBPZBrYyAy6k1CF3w1UIXg6v3z0jZssDs0uTcNc5eeHnjosan0rsefUC3ucfeD5pxcnuffDi/b6qjFgAfZb3+HkpYmMZv9U2etFAZ+QHOIUMe4fWSOsz3cbZm+7GmB2Niv7BUc2u2pa9on941Ad+fEHylvLgBSCzIK3TMqOGGhp+6ZlMR46egSBDtlOsm9G3hq8bBednloJotA1eh86j17FNI0CcOfeitZHE6SMIMQDFDlfbLgk22AtWHBBuygzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oRBHl6JazleSasNmAB4Efm+YPxoG5VDKDUgDuT+AnU=;
 b=f/XEGsWEnuFFUa+XhAeDvEpFOMNKi5YgmX5lPrgIs/46w1obmYvarLGGU4ljW2fiW8Z1Uk0S6EHjEZOT5xMqyyJsBRFplVfnSwAp4kqNaoubtlZPaiuiZ0s8xkFLjSvMNp5KUaL8G5eMeVZOWENl2nlGUV9wCTdCN55y8kpaq1rGLdVwyRQTdFR7gUMHs3vvubw6kSU14IQVBFzpe2ePFGCIDGow7aY28p2z7WvEB3Wv1Bt3t6xRQW6F45QREwUjRSRt102YGGsnCD+7LMZZcv1Ryt2e2lGeEcYt33hTijqzfYT9x2r+k8xT76iW0LtWRlh22c5fmD061o2ORh+7hQ==
Received: from MN0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::33)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:30:58 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::1e) by MN0P221CA0019.outlook.office365.com
 (2603:10b6:208:52a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 13:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:30:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 06:30:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 06:30:33 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 06:30:31 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>, David Marchand
 <david.marchand@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] build: fix libpcap detection with unusable header
Date: Tue, 7 Jul 2026 16:30:28 +0300
Message-ID: <20260707133028.236546-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 36413051-27a8-426d-e3ba-08dedc2bfa45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|5023799004|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: H05GnU7rpkMpFtPOWOZpNcX/RuH7RNL/QMumJDFkvJQpZnp9jHZ9gsWYzqnSIuwScwMCXlDB1Cr6t8BmIihAupP6hvm8d4cof33GjFcEYNhlXVKlW8uAVMDXDn9dsS6h/1zH+lKw39myH9mnaSLyXUW37fWXrwYGImGTvgGIjZG4XkA+aHazW/fAo4mlXOULHwn/bOCyWC/LxUVhWm33sO1sm/BAi/CDX6m+aTzldKVyoToPmBhJvhQn1kfYFZ2PXDBL5kSphWZVGCKDqF5CnDJyeKZckoidK8xyGzniIDTVYJHmh/zgYV0YFsKH3MePHSZl3gn3N4A/2uX/ubMK8xDMHxEHKKinWl7NfVGqNQsJOSoN4Erzc0wvy+3/XBnDfpqjtCr+Y2xHH7aii2jNBBU9IzqaOeQqmne1pxmyl5UW/XJdHxMUDj+4nY3oT5QkqTnzRkvJFOpVMGV7BoY1SHO4TKDO2OLJzjfqCETkFlqw3YE1RzNbsGNQ6XXKEw2DpqvgStpQuE6aInmgAVWaRKlgRWBgYmNSq1kSXmWgosiPySZV8sXnww2p9QcmAh2WnWxYZdSYaiI1kjGODy7PEx81t7HhbUkTRBwNGoXZGDO7XfqXySPVZPBVjCTtEfauJOGpMsOdAnFS11HYzZKTStV5LGMEfNtW8Gm0/pr6fRqfKr/fDy9tbsS45gSjtdNI9/aeCujkeLV5ZErXqgwrTA==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(5023799004)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z9AjRN9cue5kDLCCYcMO2xD3H0UR4KnjJtRxjlCpGffuQdNqaovk4O5+ZTmntBUflnIZKAzVgqAHb8DQ+4quBc5fn49L1HxjfPa/yqQxbwXmI+UsVEq/RDc0CWvEr83UPpN8FccWpuhesZkfTdXZ7Y3toGVDDUR9U/MnESGJz1JlqhNfuEiDRgtFDS1B2L70S4Iy3K8N1JloEyZjavBnCQ5WH9mKk5/LRi7QMq9M0QGA6YAa12Wf8GbByyoAH96BiFwrHBp5sSbs4g0NFkcB1AvR68BdfuH+AgCf4YNXlC8CXrqJlOQW3OmWr9pRemNbXyWB3rY17T0x+Ek0UkjtbQFidXdo3W9/q49o5j2opbQd7r5KGyjEV5xPjFSCSeDDvfUMMU6LDyjOLl0nu+vX3Qz4TusI909iILxmpCyVcXzjdVtmR3Se365UEBokZ6h1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:30:57.2456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36413051-27a8-426d-e3ba-08dedc2bfa45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
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

The libpcap detection only checked that the library was present, that
<pcap.h> could be included, and that a trivial program links. None of
these fail when a distribution ships a libpcap-devel package whose
<pcap.h> is empty (present but declaring nothing) while libpcap.so is
installed: has_header() passes on an empty file and the link test does
not reference any pcap symbol. RTE_HAS_LIBPCAP was then set and the
pcap-dependent code (bpf_convert.c, port source/sink, dumpcap) failed
to build with errors such as:

  bpf_convert.c: error: invalid use of undefined type
                 'const struct bpf_insn'

Require an actual pcap declaration (pcap_create) to be visible in the
header before enabling libpcap support, so a broken or empty header
disables the optional pcap features instead of breaking the build.

Fixes: d6024c0a6757 ("build: cleanup libpcap dependent components")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 config/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/config/meson.build b/config/meson.build
index d7f5e55c18f..4bfb8535781 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -290,7 +290,10 @@ if not pcap_dep.found()
     # pcap got a pkg-config file only in 1.9.0
     pcap_dep = cc.find_library(pcap_lib, required: false)
 endif
-if (pcap_dep.found() and cc.has_header('pcap.h', dependencies: pcap_dep)
+# has_header() passes even when pcap.h is empty; require a real declaration.
+if (pcap_dep.found()
+        and cc.has_header_symbol('pcap.h', 'pcap_create', dependencies: pcap_dep,
+                args: '-D_GNU_SOURCE')
         and cc.links(min_c_code, dependencies: pcap_dep))
     dpdk_conf.set('RTE_HAS_LIBPCAP', 1)
     dpdk_extra_ldflags += '-l@0@'.format(pcap_lib)
-- 
2.21.0

