Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4261CC6B03
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 06:55:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B35184028B;
	Thu,  2 Apr 2026 08:55:20 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4E62E40275
 for <dev@dpdk.org>; Thu,  2 Apr 2026 08:55:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAI2e61qgAy6jfF/6PQH6ceXxjcJzwrqugjDk8/5r8E9jh0Yj2XXMIGl3bzHsfbyIsXIimOqEvwdsUi4r3GYFxs2kROfprUbS2B+Z8iZFOGsfrCR3GOS3vQFj6BaFdPzgi/f2DgEfEP3KlHTGcsrNCQu8eKPWSPaAVH6dr6mNsG9fWaTqkF/PR+HOaiHIk7ww7He8qxgldLQTPwL98ez5ScCRWgKm+z2TeduYAX9Z525ktzVdzIxXeY6AMvYt2HDsE7RV53ImUDLuxeNBq//4oWImLELL2KjiHMSf5IH+5w5B6rbw/DxN16mVdjbUlzdmEzZXHU45IKg/qRgQDT45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgMEY982I9jkVqD2tmjIhrVJF0DPW+ZxJiaxmR655Zk=;
 b=enHHD89pSb1/7m8ei9fOKH/OEHyFqhzbZG7c6dOYC0Psm5x5HDpTb5ZR3NwWZR7sr66hVVxz/jtt5KDNhylY1c+ltzviw6OPJeLDhBWp4aDF+FYdybKFOL0GUhd/wUscpclEiJpxvsdkOCUGHxjhZ9FGwq2VskiXpWqK8iG0w7YE3Wi8bOGOxr8/R4PTYCNH8dFIN0ktTrgcaWKtHTZ0Hcv+7EjABZyAdxX6Z5qAkb0OyOKjAMoqo4fa7AVw5G4f7gD7b4mNRu/x2RWG5XR6y/rr/M2K21cVGWy+8HS0TecFnAjDqYLrSr+lpuIZupqYebz5W6SsuwvJ3TJIXmlMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgMEY982I9jkVqD2tmjIhrVJF0DPW+ZxJiaxmR655Zk=;
 b=dVdZ1m4RjogWvoL5Fg92NHN95dfXnsxmt1aevygiKKmhUTLasTvt24Z8+1rlm5u7iahs1Snhmd5AuuaIlyck6rmy8dnk3f8ARehEdpm7aWvxedmQDl51zLUHLf+vrIiajrL5h3GdUFr344TK/Dfto3uOIC3vCXh7OOfXjr9dNdE=
Received: from CH5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:1f1::16)
 by LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 06:55:16 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::4) by CH5PR03CA0014.outlook.office365.com
 (2603:10b6:610:1f1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Thu,
 2 Apr 2026 06:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 06:55:15 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 01:55:14 -0500
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH v3] net/axgbe: mask unsupported PHY half-duplex modes
Date: Thu, 2 Apr 2026 12:24:49 +0530
Message-ID: <20260402065450.1074-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260401075831.568-1-ashokkumar.natarajan@amd.com>
References: <20260401075831.568-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c98620-0952-4bca-7d08-08de9084cb92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cHQWmgf8B52axNuwoVbplemHB/W6Zu2UfrUOX1dASs5Ok+NAnEHMS4lMxMXNdq4QnRVI5DVMlj7IiB1/i2RDX2NeYDl3amz7cXrv83tieEicTqTtShOpxmNFtuHyD57FBHk9ZRvF4M7qaND2+2El9iDyJO0Z0GXZtr4pfvqGgHNNDc+7o6rTH6hZvwCtMQMp5OL1cU6XfEkpngqzM2Riks/KNQX45wxlTauJkFtQAjPa11A2SzpSkcJrR0uCI01aAnjcFv9RgmjEXp8bwxzbAcOW1LZo46d2LWbPovvwZCfF1bYjBSk14hlIvFrSUDBS3U60l4ld+4SytuZO3KUJhRFepU91awqPRcyn//XiS7djk9V0KLPio0OxBMote2wCI9reXFJIzkPNRB5MT7I/KTieXZj0dIX8LGqig7RiD26A4gEZCeN+55khd1gkIBnMRGodGLpF2qJ9RYGUHOXoBmxo+ppf0pEqF+bsqICybaUAdxuvlab4aj2qLtGS1GwKJ51knHGvv4C+AOHQ0EZq+aBcuAquoehMRaz6QKdo9Ue7kWC/EaYikRLpaDr2/QyojJmxZ8Kf0ah6Nu4GWfhoqnlTD5AvdwGvJLpApnwBLb0e11FiDg6DVC+HHq6TlM8A2pRwWYRWyoPt3zHnJZCWkbeT2Hieg2vImhFJu82XwBlTZ6BY99RU/KYfhQIX6eEgBjZmg9xIz9nJ0OfJyWDnuio9rzZQa7o30NO8fI6mUlx+GBQUgHIWjS0cLKo+F5KPc96BmCRGgC8WfDST26+acA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z6wP4SW8oKHKh7MXdFhjv+ZX4Po2MhOSxf1m7bpU1imRPhEMPcv69fA2OC0NJo3AuEuqO/Pj1WlX3+dmW6n0jhbi69k4z4Ahs3PKQsmmVGjV3JNCzMvsZG2aubIqdAciZHfuIWfSudIjJJyjn68jTC/DjlVh4yYMsAzQXmPEEmWEXBLffg+nd2oZaLngvfyCwGkpEt9QQIiN5GQKcIgXxt4afyoagjvafXgtCcwKZo+Mz0k7AjS59xp7f1WCmQStZ8fncylvC4bTyZ9brY8+xVdkeLK1HtVpfgbArJon+XS72oFkXtdw/REbvToJqQvoO/M5tnDxhsApubu2f9uOMbWRwXIV9e3yMCuoqq8iJRrVIgEqtQynrLrZxiMb8E4S2r7Ty4tVtLrtLHauj6VwVW3cL4gIPeDt7Fzlwfj3t0VM7zDOBTMRbcK2i97b4eom
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 06:55:15.8194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c98620-0952-4bca-7d08-08de9084cb92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783
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
 drivers/net/axgbe/axgbe_phy.h      |   3 +
 drivers/net/axgbe/axgbe_phy_impl.c | 102 +++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_phy.h b/drivers/net/axgbe/axgbe_phy.h
index e5568cce5f..3c00adfebc 100644
--- a/drivers/net/axgbe/axgbe_phy.h
+++ b/drivers/net/axgbe/axgbe_phy.h
@@ -156,6 +156,9 @@
 #define AXGBE_M88E1512_MODE_RGMII_SGMII		4
 #define AXGBE_M88E1512_MODE_SW_RESET		0x8000
 
+/* IEEE 802.3 Clause 40: 1000BASE-T Advertisement Control */
+#define AXGBE_PHY_MII_CTRL1000_1000T_FULL	0x0200
+#define AXGBE_PHY_MII_CTRL1000_1000T_HALF	0x0100
 
 /* Control register 1. */
 /* Enable extended speed selection */
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 369d766884..0f0c80f127 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -303,23 +303,113 @@ static int axgbe_phy_write(struct axgbe_port *pdata, u16 reg, u16 value)
 
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
+	ctrl1000 &= ~AXGBE_PHY_MII_CTRL1000_1000T_HALF;
+
+	/*
+	 * As with Clause 22 advertisement, adv == 0 indicates that no explicit
+	 * advertising policy was requested. In this case, preserve the legacy
+	 * behaviour of advertising 1000BASE-T full-duplex by default.
+	 */
+	if (!adv || (adv & ADVERTISED_1000baseT_Full))
+		ctrl1000 |= AXGBE_PHY_MII_CTRL1000_1000T_FULL;
+	else
+		ctrl1000 &= ~AXGBE_PHY_MII_CTRL1000_1000T_FULL;
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

