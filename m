Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F56606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E9N2677E
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79BBA4042F;
	Tue,  3 Nov 2026 14:02:46 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by mails.dpdk.org (Postfix) with ESMTPS id E159C402DE
 for <dev@dpdk.org>; Tue,  3 Nov 2026 14:02:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCwjORn/O4+EfbqFu77WHSYxpkpBw1fP9wAlmUbiqg2msbch1/UnS4h9WGEjLV4L2enIs7ece7J9y8cB66Y36SwVyjcfdrIxwa/ljJfmDHKjHVfytBS81J4lNjxvp88O/D3FT02/Cty+2dF7Xg2D2wbMiifWFKQ9wdAVjzCEefbhvx3TlC3e3vokoPXnPyG1C0mYlieu8luhAC+BMivLIOxW+j30qbKqjVRzo3mawbgDtijcDQ6HWuvajkJoEeQhr0SrzNnaB1ozuj3vu1DrpUOFIwB3Lt7W9EX/RCOkFqS04jeF+hp5AELhS8R1rENsh7CL4wdrLBbt3AGgnANXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4UwY1PpJxGFTuUEEbnIuiGa30s2KGtqYrKACo89x90=;
 b=i7ndAou4nxJdMTIBV7NfcS5gYDsqUf5lhbAOezx2tPj0JqfrgSpZld+5fI/w36uixOqi3u1YTw+rd2C7FD+wtMI2yRp2IQsQyqDA9qZw8jh6KF6MpZ017Tic/K+w9acjSZsR0tc8uG2K0Eox1jFaOhkAtMY7qfh2X0upQJB1iTUXP7d5RASR/nJcygVkc/iq0XD1zZR1BcvOxPTPxtNGo8Hlwji2pJTOrWhDKPVvda18HTawhE9GcDxZ9lpSI6oLWM3JTA/aVKwmoIdg4ko0a4CGgViR9SNu0kPRpZsLWyEqyUpuMnSotHrmm2/PPmHqRS4SMpYxFyT1y16amGsk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4UwY1PpJxGFTuUEEbnIuiGa30s2KGtqYrKACo89x90=;
 b=E9N2677EAEGMu3ohbEXtlO1Ah85DJ+HLkD0sNoyEAgqfvvESQxUL/cOGSlMWmDQr1NjZ6cJKmfztABkbV5V5e3AKWl7CdFGDsXKLyCTDq5a48qAoaH3mEweT9kcMwIdqHuYkf3e8FI+rCplKeXBrnkrZw+ooY0DsObW2RP+KPOQdx/16GL4GxkRNxDz3N5I0CrBYGLkBnGrhNhGz0ABh+tIN2Mn8cUhZJ1gggZrCEno2A8/I2H4scj4TuxsA0rZqwHhzP68LAHpAxSPFtl4wdXN0Z8Nq8bU2lztigSftcwt9JtuQkG4RKG6W0zpFq3hD+wNtJzGoYLgEMM16ydiyQQ==
Received: from CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::19)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:01:57 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::2) by CH5P220CA0021.outlook.office365.com
 (2603:10b6:610:1ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 13:01:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 13:01:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 05:01:31 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 05:01:30 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Tue, 3 Nov 2026 05:01:28 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <aman.deep.singh@intel.com>, <thomas@monjalon.net>,
 <andrew.rybchenko@oktetlabs.ru>, <maxime.coquelin@redhat.com>,
 <chenbox@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
Subject: [PATCH] ethdev: add 1.6T link speed
Date: Tue, 3 Nov 2026 15:01:27 +0200
Message-ID: <20261103130127.3466533-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: e4623202-a1cf-4b92-d26e-08df39aaa385
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|260925022911599003|260925021311599003|18002099003|260925021911599003|10067099003|56012099006|261102123227099003|3023799007|261009223027099003|261022113327099003|261021123027099003|261022105027099003|261022115727099003|261028144727099003|261021121427099003|261021130227099003|261022075727099003|11063799006|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Np7bnDlEEsdrm0DLdSQ/GLFbFYCFAkedjK9GGA7f+QCI5Cpck60mG8jBhYrNqU8EW07rDXiNd7wwDcdBFwUWEY8HdoXn9rybRbbzqXQHLtUByiUXvREGy9Ek0Sa2vfQldVMqEfDZjsckkluLuDX1yGb7+YGguTwxhO3gMRVwUtg3etrvsqQGXITDOn7ZypR+xHbjIPCy9eO/TYRNSBkynHXNssc3flt8DZ8y7dLvYNJSTcymepai62k20+ENKzeuEVR91GFPAWIJd3Vx68Cz80BswuRVAPkCBBf7lXmdXKuvv38LvpQQtklArz6aklAhDfv50e7sRq+h6YXbZMbxmT7AylU7yBiW2bXVLWOd9pu2vRoE+G89cfvKMo1+kmrTArPD0jMJYBezrP9qY5u/hghcMcE7cHyR6pcOQ7VgWovO1tjufuKwBLnGLYms0HSK7fYG5VgUKLdjEjZouD9pWq0kzfoda9UeKmO3eUteEkCMDdsAdifNUnANmUje7zYgLrYToVIDQfQ3apyOVfDmUpJJsewrEtL9Hcg2V9QIgcCCOpT9udC5o+oqD2a313Dw0lze1O9N8XUXxpYqyA+CjLDXXRTQFoDelKSBQAud5Y7lFpTiU8UJ0do+3fM2IUF63rOhwcEhFmmppb0Lrnv2boWrkEE9KQ1rBcypWCu59wAy6NVrUxvZB8wUM4npKymsLIjgtw/5X1fSb6cjDXbhvw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(260925022911599003)(260925021311599003)(18002099003)(260925021911599003)(10067099003)(56012099006)(261102123227099003)(3023799007)(261009223027099003)(261022113327099003)(261021123027099003)(261022105027099003)(261022115727099003)(261028144727099003)(261021121427099003)(261021130227099003)(261022075727099003)(11063799006)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G+DWFUxhCrsa+CVmj+QTjMOYEQrL3l7JZ8fd19bKZ0C11nJvCqT9lJZZLEIgKCBbuHTnw2aPmPT6Z2ysV1psn8ypI2bTm9SroEnSjqsQUsPVq5N0Y7HEiKORLHDbeso72trwYoeT9svYqiQC+0mNeeeyZi224xrXqwKxxVqdX4hKFwPDDQFH0ubELecqFzd4e58z86DESESegm3f7uoEoKjD2L6wFw5Wzxu9A5OQ9oOdqvnQdmdr4TToqPY2zwMuA8++OdUHcg7JCKcGejUXpZfgVnnRlGGqZMRn54drBiClOxdLIWYMTq1y4/QhRxiYz1qTXh3D3mGwBnLb0ayj3zTvRoKGzcSUXM/UVgYpWv2Tydy8S53WWUpNgfdwrr9DeyRgjBwJzMRieTpdX4yRP/muW0ZkzQbrCtY2HR3ojvk9P7wymtJXQ9DdBdyEYuIg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 13:01:55.8885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4623202-a1cf-4b92-d26e-08df39aaa385
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Current ethdev speed definitions stop at 800 Gbps, preventing
applications such as bonding from reporting a 1.6 Tbps negotiated link
speed.

IEEE 802.3df standardizes 800 Gbps, and IEEE P802.3dj is standardizing
1.6 Tbps as the next Ethernet MAC rate, with no intermediate rate.

Add the 1.6 Tbps speed definition and update testpmd, telemetry, virtio,
tests and documentation to recognize it.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 app/test-pmd/cmdline.c                      | 12 +++++++-----
 app/test-pmd/config.c                       |  2 ++
 app/test-pmd/parameters.c                   |  3 +++
 app/test/test_ethdev_link.c                 |  3 ++-
 doc/guides/rel_notes/release_26_11.rst      |  5 +++++
 doc/guides/testpmd_app_ug/run_app.rst       |  1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  2 +-
 drivers/net/virtio/virtio_ethdev.c          |  2 ++
 lib/ethdev/rte_ethdev.c                     |  6 ++++++
 lib/ethdev/rte_ethdev.h                     |  6 ++++++
 10 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 51078a2a73a..620be4038d8 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -725,7 +725,7 @@ static void cmd_help_long_parsed(void *parsed_result,
 
 			"port config (port_id|all)"
 			" speed (10|100|1000|2500|5000|10000|25000|40000|50000|"
-			"100000|200000|400000|800000|auto)"
+			"100000|200000|400000|800000|1600000|auto)"
 			" duplex (half|full|auto)\n"
 			"    Set speed and duplex for all ports or port_id\n\n"
 
@@ -1447,6 +1447,8 @@ parse_and_check_speed_duplex(char *speedstr, char *duplexstr, uint32_t *speed)
 			*speed = RTE_ETH_LINK_SPEED_400G;
 		} else if (!strcmp(speedstr, "800000")) {
 			*speed = RTE_ETH_LINK_SPEED_800G;
+		} else if (!strcmp(speedstr, "1600000")) {
+			*speed = RTE_ETH_LINK_SPEED_1600G;
 		} else if (!strcmp(speedstr, "auto")) {
 			*speed = RTE_ETH_LINK_SPEED_AUTONEG;
 		} else {
@@ -1498,7 +1500,7 @@ static cmdline_parse_token_string_t cmd_config_speed_all_item1 =
 static cmdline_parse_token_string_t cmd_config_speed_all_value1 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, value1,
 		"10#100#1000#2500#5000#10000#25000#40000#50000#"
-		"100000#200000#400000#800000#auto");
+		"100000#200000#400000#800000#1600000#auto");
 static cmdline_parse_token_string_t cmd_config_speed_all_item2 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, item2, "duplex");
 static cmdline_parse_token_string_t cmd_config_speed_all_value2 =
@@ -1510,7 +1512,7 @@ static cmdline_parse_inst_t cmd_config_speed_all = {
 	.data = NULL,
 	.help_str = "port config all speed "
 		"10|100|1000|2500|5000|10000|25000|40000|50000|"
-		"100000|200000|400000|800000|auto "
+		"100000|200000|400000|800000|1600000|auto "
 		"duplex half|full|auto",
 	.tokens = {
 		(void *)&cmd_config_speed_all_port,
@@ -1575,7 +1577,7 @@ static cmdline_parse_token_string_t cmd_config_speed_specific_item1 =
 static cmdline_parse_token_string_t cmd_config_speed_specific_value1 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_specific, value1,
 		"10#100#1000#2500#5000#10000#25000#40000#50000#"
-		"100000#200000#400000#800000#auto");
+		"100000#200000#400000#800000#1600000#auto");
 static cmdline_parse_token_string_t cmd_config_speed_specific_item2 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_specific, item2,
 								"duplex");
@@ -1588,7 +1590,7 @@ static cmdline_parse_inst_t cmd_config_speed_specific = {
 	.data = NULL,
 	.help_str = "port config <port_id> speed "
 		"10|100|1000|2500|5000|10000|25000|40000|50000|"
-		"100000|200000|400000|800000|auto "
+		"100000|200000|400000|800000|1600000|auto "
 		"duplex half|full|auto",
 	.tokens = {
 		(void *)&cmd_config_speed_specific_port,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index ec348cf854b..6bd52928364 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -638,6 +638,8 @@ device_infos_display_speeds(uint32_t speed_capa)
 		printf(" 400 Gbps  ");
 	if (speed_capa & RTE_ETH_LINK_SPEED_800G)
 		printf(" 800 Gbps  ");
+	if (speed_capa & RTE_ETH_LINK_SPEED_1600G)
+		printf(" 1.6 Tbps  ");
 }
 
 void
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 833b14eda48..34a4f74e636 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -934,6 +934,9 @@ parse_link_speed(int n)
 	case 800000:
 		speed |= RTE_ETH_LINK_SPEED_800G;
 		break;
+	case 1600000:
+		speed |= RTE_ETH_LINK_SPEED_1600G;
+		break;
 	case 100:
 	case 10:
 	default:
diff --git a/app/test/test_ethdev_link.c b/app/test/test_ethdev_link.c
index 22fbae9c967..3321b3111b2 100644
--- a/app/test/test_ethdev_link.c
+++ b/app/test/test_ethdev_link.c
@@ -56,7 +56,7 @@ test_link_status_up_default(void)
 		"string with HDX");
 
 	/* test max str len */
-	link_status.link_speed = RTE_ETH_SPEED_NUM_800G;
+	link_status.link_speed = RTE_ETH_SPEED_NUM_1600G;
 	link_status.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 	link_status.link_autoneg = RTE_ETH_LINK_AUTONEG;
 	link_status.link_connector = RTE_ETH_LINK_CONNECTOR_GAUI;
@@ -136,6 +136,7 @@ test_link_speed_all_values(void)
 		{ "200 Gbps", RTE_ETH_SPEED_NUM_200G },
 		{ "400 Gbps", RTE_ETH_SPEED_NUM_400G },
 		{ "800 Gbps", RTE_ETH_SPEED_NUM_800G },
+		{ "1.6 Tbps", RTE_ETH_SPEED_NUM_1600G },
 		{ "Unknown",  RTE_ETH_SPEED_NUM_UNKNOWN },
 		{ "Invalid",   50505 }
 	};
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c021..9be6a308730 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -100,6 +100,11 @@ New Features
   the kernel driver is the generic ``vfio-platform``,
   which carries no device identity in its name.
 
+* **Added link speed 1.6T to ethdev.**
+
+  Added the 1.6 Tb/s Ethernet link speed,
+  allowing aggregate links such as two 800 Gb/s members to be represented.
+
 * **Added module EEPROM decoding API to ethdev.**
 
   Added the experimental ``rte_eth_module_eeprom_parse()`` function
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index bcfbf33f921..e34e414ce24 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -441,6 +441,7 @@ The command line options are:
        200000 - 200Gbps
        400000 - 400Gbps
        800000 - 800Gbps
+       1600000 - 1.6Tbps
        ...
 
 *   ``--disable-link-check``
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index a967bbef764..aafd146cb91 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2166,7 +2166,7 @@ port config - speed
 
 Set the speed and duplex mode for all ports or a specific port::
 
-   testpmd> port config (port_id|all) speed (10|100|1000|2500|5000|10000|25000|40000|50000|100000|200000|400000|800000|auto) \
+   testpmd> port config (port_id|all) speed (10|100|1000|2500|5000|10000|25000|40000|50000|100000|200000|400000|800000|1600000|auto) \
             duplex (half|full|auto)
 
 port config - queues/descriptors
diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index a6fe4f30234..1862f0f17b1 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -2123,6 +2123,8 @@ virtio_dev_speed_capa_get(uint32_t speed)
 		return RTE_ETH_LINK_SPEED_400G;
 	case RTE_ETH_SPEED_NUM_800G:
 		return RTE_ETH_LINK_SPEED_800G;
+	case RTE_ETH_SPEED_NUM_1600G:
+		return RTE_ETH_LINK_SPEED_1600G;
 	default:
 		return 0;
 	}
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f843e8808a5..31e4b43dabe 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1073,6 +1073,9 @@ rte_eth_speed_bitflag(uint32_t speed, int duplex)
 	case RTE_ETH_SPEED_NUM_800G:
 		ret = RTE_ETH_LINK_SPEED_800G;
 		break;
+	case RTE_ETH_SPEED_NUM_1600G:
+		ret = RTE_ETH_LINK_SPEED_1600G;
+		break;
 	default:
 		ret = 0;
 	}
@@ -3277,6 +3280,9 @@ rte_eth_link_speed_to_str(uint32_t link_speed)
 	case RTE_ETH_SPEED_NUM_800G:
 		ret = "800 Gbps";
 		break;
+	case RTE_ETH_SPEED_NUM_1600G:
+		ret = "1.6 Tbps";
+		break;
 	case RTE_ETH_SPEED_NUM_UNKNOWN:
 		ret = "Unknown";
 		break;
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 19244836899..16a1ef0a64c 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -296,6 +296,11 @@ struct rte_eth_stats {
 #define RTE_ETH_LINK_SPEED_200G    RTE_BIT32(15) /**< 200 Gbps */
 #define RTE_ETH_LINK_SPEED_400G    RTE_BIT32(16) /**< 400 Gbps */
 #define RTE_ETH_LINK_SPEED_800G    RTE_BIT32(17) /**< 800 Gbps */
+/*
+ * 800 Gbps is standardized in IEEE 802.3df; IEEE P802.3dj is
+ * standardizing 1.6 Tbps as the next rate.
+ */
+#define RTE_ETH_LINK_SPEED_1600G   RTE_BIT32(18) /**< 1.6 Tbps */
 /**@}*/
 
 /**@{@name Link speed
@@ -317,6 +322,7 @@ struct rte_eth_stats {
 #define RTE_ETH_SPEED_NUM_200G    200000 /**< 200 Gbps */
 #define RTE_ETH_SPEED_NUM_400G    400000 /**< 400 Gbps */
 #define RTE_ETH_SPEED_NUM_800G    800000 /**< 800 Gbps */
+#define RTE_ETH_SPEED_NUM_1600G  1600000 /**< 1.6 Tbps */
 #define RTE_ETH_SPEED_NUM_UNKNOWN UINT32_MAX /**< Unknown */
 /**@}*/
 
-- 
2.25.1

