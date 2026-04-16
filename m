Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B598FF8808E
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 07:06:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A19C402A3;
	Thu, 16 Apr 2026 09:06:07 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62]) by mails.dpdk.org (Postfix) with ESMTP id 838A74025D
 for <dev@dpdk.org>; Thu, 16 Apr 2026 09:06:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZ92V58FCLt0VWeSQdfU2c53pCBZMs2dpw02Y1vt7AxCy0qwn2AExpGdzcAptbRVWVV6UHmLCUaBNN/Ez+i1l56FezHI+jelKII4aX7/6xWH7OniBFL44imSXYPs3LtEpmS43/fFDSuXwl6Pdak3wROy1SUhmwGNv71e1zJzf0Cctxvsni/S+W+9VlnpVn/YcbLLEqCuMqbkUCc5Ep4m+emamL0bkS1hnNndJ4rsb7bwIUGVW5bhp18teSs0AI9L/TmYLMDbczeZqFQLJ5eV/WGAyTjCCKJKxv6+s8nQx9eWDXD9YI4iOf7DCqy8SXkgkTbhOtqs99YzKdOO4X2W0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppg92CChytczelT/Hr8QHeWnFc2R9rCjmrnEZx9SYxY=;
 b=rmWMHtAxMOXPm+SHnt81UGirqilPNVgsUTHCWTHJt+0qCX6tuA4nGCsMxnP7u0/qe/RgR8gr9ZYs3ly42fQ8RbAWWW/zS1SIdWpYiCPTPgCNRAB0VMxT3FXaU7j1N7ZgJ5oIL3jLpT8tdRvwimxmEA9wAUY04qdI+gS6RuAWQdxaeERq92//mF6anUfw1lO9c5EuKjUuoIRk9m8umXoA57GKoOanOv9S3OgMjzJBLG+AxhQDSSuJZi1Orhbe7W+i6N0Dpir4Ji07qRhBnM9/Ox5D31L5umtkvKFp0PmTo4zeUSL1JnvJdaUCSRrkBrgEajQn9cmGlwgQ+9+fvz7ThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppg92CChytczelT/Hr8QHeWnFc2R9rCjmrnEZx9SYxY=;
 b=sZYu5rZKIgpEs8JnzMspbPlTXNMflT4p6l9RlHPhg5aYk139nlYCpKB8sW2ScHU2tYQNV+BZmpq0p2jKE8XtIArHtLMJa9oqpuL/bTzgvh7+RZB/zIvX4Ac0okUhjGILNC7vZlymOo9CdjDPuXtEKxltt8IDARvKQwTZWelh9pw=
Received: from BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 07:06:01 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::ea) by BLAPR03CA0090.outlook.office365.com
 (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Thu,
 16 Apr 2026 07:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 07:06:01 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 02:05:57 -0500
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH v4] net/axgbe: mask unsupported PHY half-duplex modes
Date: Thu, 16 Apr 2026 12:35:24 +0530
Message-ID: <20260416070526.1504-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260402065450.1074-1-ashokkumar.natarajan@amd.com>
References: <20260402065450.1074-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c11824-49f4-4c10-0213-08de9b869e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: I27L7ve7iKVaevx8nNr5StIVh4XmJMQWwmdyByOzveWBx9BFwtJ3o37x07jRiCsaV5aI6eRubJ8cQapBKnq0bCMkpNixqBdad3dxQv3s93nr/dhPqkkf1bwu4kF7WjSXWOXdiBkA9c44vKpBedM6/VYCXyQlyLBYMlgDvj5j80k1D5m+tODEQYIYHfTPxM4WMK+5wo1x9PNjkD8HnQsBy7MWq9LMCm0O1sg9VF0xuq3Mt/VBGxoaDYoN/ZiX9GzrdlxnLg0KPmjft6X0xukejtsDEAS57YBX0F1p34F8g7If82mX8JXT6Gzhm0hiItMtZXIS7J4iLM7E11cY1oUbd+sOTKFgmdERMYIX6zqT9DuAhn0m971Ld9D7SA5W59uN/hmQCf2P9h7KmzWRCa5+xEZ/dpaOBy1WLBlatKjIUrC0FwkmoF4FD5P56VsQfsa8TF3mgRZ4oLjwfEKZ+ZvRPwyDkoaKjqjz8scpE8IZOTefI7cIgOvLauFtGqtOyhewpfrXsswyA4/CT6xPPIsZx3eOZhNWHjCy3kGu/ByRDpLF+hnGKqr4VW4/eoJBkV+lrRU7xRUn/Dy/3lN6XUsqa5u/6BLcRFxTRwxhFT7ipvw1wszO6QVXTEhm6CE8SnUdkTdbl12bKGqHxtzFsJpzsxx9yE6w/q7yhJZ9sO8lh4Ed1lSbTxDVjosMheJIlDI434wOaIF0FX2zVHiGdfdiCUh9Jaj4nq2guk+5CJWfvMz8HsgUrRjY2GU8daBcM1ddGmniI699aXCn9/KbS7YqgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qMFCPLQbDZP4XnPkEeRSDzc3uieUQrqPw9kUNlm503e4mvtObONS8OpnEFYYFuNeaasKH8X4n/WBuVHbWX92gD67/HTMDk7YMm1PM3TBk5vcKHly1EVH3Wq2LRsvV0cOdMTAfSwoQ6MNtRQGJF+Hy72fCWW1nqu+0rOMDoAyalylnbz2QsUHhJyBZyjbRL8i1bq23O2z5E3B1E7BX+3BpNQoSsoudQLDU5yfKkQ1fXbiy32FBi51tHUTG+Xqdrj32kMbj3YSQ8R1s9HmiPOOql+seBmwOBB3P1qyzouIoPeNSWpp95LcmynTwyvup5KWFMV6cj0ElmrFEXsfS9jDCMcnHoohPHeNxb0NQCAJeqBqOJGwRFYDQ7fJPFztduq003WMhtAq6bfYXpGGY+l3LW4qEmaHVxQWliFrnw2xEYSCf/iT0fFEh+fTRylHWJqf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:06:01.2129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c11824-49f4-4c10-0213-08de9b869e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A
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

The AXGBE MAC supports only full-duplex operation at all speeds.
However, the PHY auto-negotiation configuration could advertise
half-duplex modes, including 10BASE-T, 100BASE-TX, and 1000BASE-T,
which are not supported by the MAC.

Update the Clause 22 and Clause 40 PHY advertisement handling to mask
all half-duplex modes while preserving existing PHY, strap, and
vendor-specific configuration using read-modify-write.

To maintain backward compatibility, full-duplex advertisement for
10/100 and 1000BASE-T is preserved by default when no explicit PHY
advertising mask is provided.

This ensures IEEE 802.3 compliant PHY advertisement while avoiding
regressions on platforms relying on PHY default configuration.

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_phy.h      |   4 ++
 drivers/net/axgbe/axgbe_phy_impl.c | 103 +++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_phy.h b/drivers/net/axgbe/axgbe_phy.h
index e5568cce5f..9d6496c3cf 100644
--- a/drivers/net/axgbe/axgbe_phy.h
+++ b/drivers/net/axgbe/axgbe_phy.h
@@ -82,6 +82,10 @@
 #define ADVERTISE_LPACK         0x4000  /* Ack link partners response  */
 #define ADVERTISE_NPAGE         0x8000  /* Next page bit               */
 
+/* IEEE 802.3 Clause 40: 1000BASE-T Advertisement Control */
+#define ADVERTISE_1000FULL	0x0200
+#define ADVERTISE_1000HALF	0x0100
+
 #define ADVERTISE_FULL          (ADVERTISE_100FULL | ADVERTISE_10FULL | \
 		ADVERTISE_CSMA)
 #define ADVERTISE_ALL           (ADVERTISE_10HALF | ADVERTISE_10FULL | \
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 369d766884..4abf5fdea9 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -303,23 +303,114 @@ static int axgbe_phy_write(struct axgbe_port *pdata, u16 reg, u16 value)
 
 static int axgbe_phy_config_advert(struct axgbe_port *pdata)
 {
-	u16 advert;
+	u32 adv = pdata->phy.advertising;
+	u16 advert, orig_advert;
+	u16 ctrl1000, orig_ctrl1000;
 	int ret;
 
+	/*
+	 * Clause 22 (10/100) advertisement configuration.
+	 *
+	 * AXGBE MAC supports only full-duplex operation.
+	 * Half-duplex modes are masked while preserving any
+	 * PHY-specific or reserved bits.
+	 */
 	ret = pdata->phy_if.phy_impl.read(pdata, MII_ADVERTISE, &advert);
 	if (ret) {
-		PMD_DRV_LOG_LINE(ERR, "Failed to read ADVERTISE register");
+		PMD_DRV_LOG_LINE(ERR,
+				"PHY read failed: MII_ADVERTISE");
 		return ret;
 	}
 
-	advert |= ADVERTISE_FULL;
-	advert |= ADVERTISE_PAUSE_CAP;
+	orig_advert = advert;
+
+	/* Always advertise IEEE 802.3 CSMA/CD selector */
+	advert |= ADVERTISE_CSMA;
+
+	/* AXGBE does not support 10/100 half-duplex */
+	advert &= ~(ADVERTISE_10HALF | ADVERTISE_100HALF);
+
+	/*
+	 * Treat adv == 0 as a legacy/default configuration where the driver
+	 * does not impose an explicit policy and preserves the historical
+	 * behavior of advertising all supported full-duplex speeds.
+	 */
+	if (!adv) {
+		advert |= ADVERTISE_10FULL | ADVERTISE_100FULL;
+		advert |= ADVERTISE_PAUSE_CAP;
+	} else {
+		if (adv & ADVERTISED_10baseT_Full)
+			advert |= ADVERTISE_10FULL;
+		else
+			advert &= ~ADVERTISE_10FULL;
+
+		if (adv & ADVERTISED_100baseT_Full)
+			advert |= ADVERTISE_100FULL;
+		else
+			advert &= ~ADVERTISE_100FULL;
+
+		if (adv & ADVERTISED_Pause)
+			advert |= ADVERTISE_PAUSE_CAP;
+		else
+			advert &= ~ADVERTISE_PAUSE_CAP;
 
-	ret = pdata->phy_if.phy_impl.write(pdata, MII_ADVERTISE, advert);
+		if (adv & ADVERTISED_Asym_Pause)
+			advert |= ADVERTISE_PAUSE_ASYM;
+		else
+			advert &= ~ADVERTISE_PAUSE_ASYM;
+	}
+
+	if (advert != orig_advert) {
+		ret = pdata->phy_if.phy_impl.write(pdata,
+				MII_ADVERTISE,
+				advert);
+		if (ret) {
+			PMD_DRV_LOG_LINE(ERR,
+					"PHY write failed: MII_ADVERTISE");
+			return ret;
+		}
+	}
+
+	/*
+	 * Clause 40 (1000BASE-T) advertisement configuration.
+	 *
+	 * AXGBE MAC supports only full-duplex operation at 1Gbps.
+	 * Half-duplex advertisement is always cleared.
+	 * Existing PHY or vendor-specific bits are preserved.
+	 */
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_CTRL1000, &ctrl1000);
 	if (ret) {
-		PMD_DRV_LOG_LINE(ERR, "Failed to write ADVERTISE register");
+		PMD_DRV_LOG_LINE(ERR,
+				"PHY read failed: MII_CTRL1000");
 		return ret;
 	}
+
+	orig_ctrl1000 = ctrl1000;
+
+	/* Clear unsupported 1000BASE-T half-duplex */
+	ctrl1000 &= ~ADVERTISE_1000HALF;
+
+	/*
+	 * As with Clause 22 advertisement, adv == 0 indicates that no explicit
+	 * advertising policy was requested. In this case, preserve the legacy
+	 * behaviour of advertising 1000BASE-T full-duplex by default.
+	 */
+	if (!adv || (adv & ADVERTISED_1000baseT_Full))
+		ctrl1000 |= ADVERTISE_1000FULL;
+	else
+		ctrl1000 &= ~ADVERTISE_1000FULL;
+
+	if (ctrl1000 != orig_ctrl1000) {
+		ret = pdata->phy_if.phy_impl.write(pdata,
+				MII_CTRL1000,
+				ctrl1000);
+		if (ret) {
+			PMD_DRV_LOG_LINE(ERR,
+					"PHY write failed: MII_CTRL1000");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0

