Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD7DFEE4ED
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 14:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 201E940A80;
	Sat, 28 Feb 2026 15:38:24 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5]) by mails.dpdk.org (Postfix) with ESMTP id 4663F4013F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 15:38:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Prmjttl4nnzETC6hp4VCgDB32pCIDvT5Ws7j1s95k63ZSdhRQncjTpWJqW7Bz4/ElBiO2BQcetYb3gh+U0We+kYZxk7gvFx0N8K0QWKxD5cVYkSSGL9z9MrmEAOQN8YacjnOHaVwoKlQZaWhq8g8xznRrvXdorxORgq0UhBmd5L13vzkK+B1YgVNO+cQix1LkWkUM5SIhEWnmJtRiloWHGiUWBPJBXgZmbfHD/cG0qj09gXVMWQw2BMMLlf8/I/E6hy2tcaThWIPlc30XXBl1jQPQ1i1oAn7DmKMx5Fdvpqr53uVmcmGGL48NRF0kWxtdWTAR2nO6soznOjxFBaqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojZ1Gc7yIOQCgCH4ofwGageNhj3BgV1OeYAxqA2FXYQ=;
 b=G1tRM7/9PeCezW4A+2XiyChpILBz9/AgTaoXAmXeFAJKI9+IDx4swMnHM3QrLoj4mOXmgZOtaGzbQrgxqomaPU4V/NEgP6g2jyTon6bxBP40RV6KtDjoDF/j/Kt7Sxk4CZTXslM7umwgwaXq8vXyvQ3L7PZhNE7C7k/elABhC2wHBB7LiI9Um7/KHaNZKFY3GI1ivJxQXAgz8ATS4HoElaaRjmWO0XQdqdLdyNcAyuyzYxhYs4dWbMOfTykV/hmyTjcLleOSqdcU1KPjWp88NyYEzyVJ9tNMBzZKTYuAiOAbfCdfOlLCEmD7+4jRS2k3ZFDUpWPlqf7PznLkRN8Yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojZ1Gc7yIOQCgCH4ofwGageNhj3BgV1OeYAxqA2FXYQ=;
 b=Eoa/acUNWNK+VJOELOqMkLokh+L88nkpgOD1hKLfep0aK2h3HBK9M7zaZHxTpAaSn/sWuEQl4Hd/lKGetix0Ui6ss5VLqtxF2jWZJ1LKqp3+6HeQ+OZuFL7qmRniJMvmQapis3XQSuCMx+XbAw148wUuH2Pf6KFIZvZH9lcpPMs=
Received: from BL1PR13CA0095.namprd13.prod.outlook.com (2603:10b6:208:2b9::10)
 by LV0PR12MB999068.namprd12.prod.outlook.com (2603:10b6:408:32d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 14:38:18 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::4c) by BL1PR13CA0095.outlook.office365.com
 (2603:10b6:208:2b9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.15 via Frontend Transport; Sat,
 28 Feb 2026 14:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 14:38:18 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 08:38:16 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH v5 1/3] net/axgbe: add external PHY read/write functions
Date: Sat, 28 Feb 2026 20:07:48 +0530
Message-ID: <20260228143750.626-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260227084323.689-1-ashokkumar.natarajan@amd.com>
References: <20260227084323.689-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|LV0PR12MB999068:EE_
X-MS-Office365-Filtering-Correlation-Id: 28394290-98d0-4adc-0259-08de76d70383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: heNH6CCUW2Pl7CdAB3DuQR/myUmD25ZxXb1l/r58XHJXhUv+5X4r4gxSHUjqG346CST7jDNpcc01xw9DaY3rayQfw6HU20ewWz/NaN/5jp/5pQBvzEupa72GHLOm8/uAVbo2A5ePtFQbZLYMtxrnebrusPxginnossebZ1vS92saJ+4JO9rhSRbk6pKx/l9IsbHCUk4r5SWQUpWrZUhacNecB0nzMKv1D2yNMPq8h10dK/UghK3Jp/lUjTl4EjAEeOaz8amilniMS92GtuFRf4pmAcXIguVdr0SN7I2d2+fWVzi/hKU0hegTQ1Dh2MfdjPoEnr8LHpHM7XROLfKN3v0sLFULNkbr80qXtPfgFwPfsQQlwD61OOABXNy1W10U8a+WBPYDLtyxLMdfYmNe9ptRlxh9Sc75I4owbWCtktnycOAy6BrCuFfL8a+/Qg7QO9hKEwBEOFsHAnktYUqreyeVyX8ThJF1uuLKThQaWF5aTAAyznWHpfVQFDuIsR6F7JATrEzFlswMWUxC+rbq8oW0bHHDEAOBQHRnlu+/JPhQi5CYT3UZHKLZ86Tzfx1FVXGFhnrlfeSkyXnBe6zfNEzfhZRAhP6owJK1YEdGktlIhgvHP8/xoE+5jwLd3occxHYzx5A0C4IDf/YRBv+2u12tZsmCH8qTfpnbH44ss+ZPLi7LIPJly4Z725ehRVo7luCO/AdJYS2A0JClGBszEDLYfUSMRYWAHH2lsQr5DsFSTDGdVOQBUP7XlsMVuA93h2YmkOLxQlPA+ed35dUsJHMHDcIRA7lQHHuBrSpQGiyovE1YywcXLYBLIn9KNUjUXZOVyHQfeRWoVSROheMpkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lWSJFYuZV59/dXs/AA1mVO7pki2GX07g3VLs5tOxEgO6c0OepZ27KC1lmO059CCYEtm0YvDN2rvmCQo2g7EYgrOAD/po0vKyCqjotgsFGZqJgSR2NA9SCJbTi+DkPXGTp/XrALN3qy0JkC4/4dvCJM0511avwT7A/CvVI/CShFSgntnfX2/IHBhc24X//PxEQHnSkv/E8/3++j3Uas39hoUKEUn0xbDeAfpgboKDD0x40ktayGJZhjIGvgpc63TVSEEAtwLUdV83w/+4GeecscEzK4aGvMUW+AYyKf7WQd1RmhFM4d5rksFhhDA7sAMS5klh+ywST8c+Wk+fGMY0pVaLGYvjG5eAi8LqO5xQO8b9dcfFMF+4GRkZoI8ahJo5Spe2szsjuuP+JvVja0bb7TjglM77J2lxpUh9eFWioyTgjITzLLJA6CtjvI6YJKGN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 14:38:18.1692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28394290-98d0-4adc-0259-08de76d70383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999068
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

Introduce helper functions to perform external PHY register read and
write operations. These helpers currently support only IEEE Clause 22
PHY access, providing a simple and consistent API for accessing
standard 16‑bit MII registers on external PHY devices.

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 .mailmap                           |  1 +
 drivers/net/axgbe/axgbe_dev.c      | 56 ++++++++++++++++--------------
 drivers/net/axgbe/axgbe_ethdev.h   | 16 ++++++---
 drivers/net/axgbe/axgbe_phy_impl.c | 45 +++++++++++++++++++++++-
 4 files changed, 85 insertions(+), 33 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6c4c977dde..5c8b47f1a9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -165,6 +165,7 @@ Ashish Paul <apaul@juniper.net>
 Ashish Sadanandan <ashish.sadanandan@gmail.com>
 Ashish Shah <ashish.n.shah@intel.com>
 Ashok Kaladi <ashok.k.kaladi@intel.com>
+Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
 Ashwin Sekhar T K <asekhar@marvell.com> <ashwin.sekhar@caviumnetworks.com>
 Asim Jamshed <asim.jamshed@gmail.com>
 Atul Patel <atul.patel@intel.com>
diff --git a/drivers/net/axgbe/axgbe_dev.c b/drivers/net/axgbe/axgbe_dev.c
index 634d4ee4a5..10a99aeac2 100644
--- a/drivers/net/axgbe/axgbe_dev.c
+++ b/drivers/net/axgbe/axgbe_dev.c
@@ -63,9 +63,9 @@ static int mdio_complete(struct axgbe_port *pdata)
 	return 0;
 }
 
-static unsigned int axgbe_create_mdio_sca_c22(int port, int reg)
+static unsigned int axgbe_create_mdio_sca_c22(u8 port, u16 reg)
 {
-	unsigned int mdio_sca;
+	u32 mdio_sca;
 
 	mdio_sca = 0;
 	AXGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, RA, reg);
@@ -74,20 +74,20 @@ static unsigned int axgbe_create_mdio_sca_c22(int port, int reg)
 	return mdio_sca;
 }
 
-static unsigned int axgbe_create_mdio_sca_c45(int port, unsigned int da, int reg)
+static unsigned int axgbe_create_mdio_sca_c45(u8 port, u8 dev_addr, u16 reg)
 {
-	unsigned int mdio_sca;
+	u32 mdio_sca;
 
 	mdio_sca = 0;
 	AXGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, RA, reg);
 	AXGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, PA, port);
-	AXGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, DA, da);
+	AXGMAC_SET_BITS(mdio_sca, MAC_MDIOSCAR, DA, dev_addr);
 
 	return mdio_sca;
 }
 
 static int axgbe_write_ext_mii_regs(struct axgbe_port *pdata,
-						unsigned int mdio_sca, u16 val)
+		u32 mdio_sca, u16 value)
 {
 	unsigned int mdio_sccd;
 	uint64_t timeout;
@@ -95,7 +95,7 @@ static int axgbe_write_ext_mii_regs(struct axgbe_port *pdata,
 	AXGMAC_IOWRITE(pdata, MAC_MDIOSCAR, mdio_sca);
 
 	mdio_sccd = 0;
-	AXGMAC_SET_BITS(mdio_sccd, MAC_MDIOSCCDR, DATA, val);
+	AXGMAC_SET_BITS(mdio_sccd, MAC_MDIOSCCDR, DATA, value);
 	AXGMAC_SET_BITS(mdio_sccd, MAC_MDIOSCCDR, CMD, 1);
 	AXGMAC_SET_BITS(mdio_sccd, MAC_MDIOSCCDR, BUSY, 1);
 	AXGMAC_IOWRITE(pdata, MAC_MDIOSCCDR, mdio_sccd);
@@ -113,28 +113,28 @@ static int axgbe_write_ext_mii_regs(struct axgbe_port *pdata,
 
 
 static int axgbe_write_ext_mii_regs_c22(struct axgbe_port *pdata,
-							int addr, int reg, u16 val)
+		u8 phy_addr, u16 reg, u16 value)
 {
-	unsigned int mdio_sca;
+	u32 mdio_sca;
 
-	mdio_sca = axgbe_create_mdio_sca_c22(addr, reg);
+	mdio_sca = axgbe_create_mdio_sca_c22(phy_addr, reg);
 
-	return axgbe_write_ext_mii_regs(pdata, mdio_sca, val);
+	return axgbe_write_ext_mii_regs(pdata, mdio_sca, value);
 }
 
 static int axgbe_write_ext_mii_regs_c45(struct axgbe_port *pdata,
-					int addr, int devad, int reg, u16 val)
+	       u8 phy_addr, u8 dev_addr, u16 reg, u16 value)
 {
-	unsigned int mdio_sca;
+	u32 mdio_sca;
 
-	mdio_sca = axgbe_create_mdio_sca_c45(addr, devad, reg);
+	mdio_sca = axgbe_create_mdio_sca_c45(phy_addr, dev_addr, reg);
 
-	return axgbe_write_ext_mii_regs(pdata, mdio_sca, val);
+	return axgbe_write_ext_mii_regs(pdata, mdio_sca, value);
 }
 
 
-static int axgbe_read_ext_mii_regs(struct axgbe_port *pdata,
-							unsigned int mdio_sca)
+static int axgbe_read_ext_mii_regs(struct axgbe_port *pdata, u32 mdio_sca,
+		u16 *value)
 {
 	unsigned int mdio_sccd;
 	uint64_t timeout;
@@ -158,26 +158,28 @@ static int axgbe_read_ext_mii_regs(struct axgbe_port *pdata,
 	return -ETIMEDOUT;
 
 success:
-	return AXGMAC_IOREAD_BITS(pdata, MAC_MDIOSCCDR, DATA);
+	*value = AXGMAC_IOREAD_BITS(pdata, MAC_MDIOSCCDR, DATA);
+	return 0;
 }
 
-static int axgbe_read_ext_mii_regs_c22(struct axgbe_port *pdata, int addr, int reg)
+static int axgbe_read_ext_mii_regs_c22(struct axgbe_port *pdata, u8 phy_addr,
+		u16 reg, u16 *value)
 {
-	unsigned int mdio_sca;
+	u32 mdio_sca;
 
-	mdio_sca = axgbe_create_mdio_sca_c22(addr, reg);
+	mdio_sca = axgbe_create_mdio_sca_c22(phy_addr, reg);
 
-	return axgbe_read_ext_mii_regs(pdata, mdio_sca);
+	return axgbe_read_ext_mii_regs(pdata, mdio_sca, value);
 }
 
-static int axgbe_read_ext_mii_regs_c45(struct axgbe_port *pdata, int addr,
-								int devad, int reg)
+static int axgbe_read_ext_mii_regs_c45(struct axgbe_port *pdata, u8 phy_addr,
+		u8 dev_addr, u16 reg, u16 *value)
 {
-	unsigned int mdio_sca;
+	u32 mdio_sca;
 
-	mdio_sca = axgbe_create_mdio_sca_c45(addr, devad, reg);
+	mdio_sca = axgbe_create_mdio_sca_c45(phy_addr, dev_addr, reg);
 
-	return axgbe_read_ext_mii_regs(pdata, mdio_sca);
+	return axgbe_read_ext_mii_regs(pdata, mdio_sca, value);
 }
 
 static int axgbe_set_ext_mii_mode(struct axgbe_port *pdata, unsigned int port,
diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_ethdev.h
index b94a7f3562..24336f31f6 100644
--- a/drivers/net/axgbe/axgbe_ethdev.h
+++ b/drivers/net/axgbe/axgbe_ethdev.h
@@ -327,11 +327,14 @@ struct axgbe_hw_if {
 
 	int (*set_ext_mii_mode)(struct axgbe_port *, unsigned int,
 				enum axgbe_mdio_mode);
-	int (*read_ext_mii_regs_c22)(struct axgbe_port *pdata, int addr, int reg);
-	int (*write_ext_mii_regs_c22)(struct axgbe_port *pdata, int addr, int reg, uint16_t val);
-	int (*read_ext_mii_regs_c45)(struct axgbe_port *pdata, int addr, int devad, int reg);
-	int (*write_ext_mii_regs_c45)(struct axgbe_port *pdata, int addr, int devad,
-									int reg, uint16_t val);
+	int (*read_ext_mii_regs_c22)(struct axgbe_port *pdata, u8 phy_addr,
+			u16 reg, u16 *value);
+	int (*write_ext_mii_regs_c22)(struct axgbe_port *pdata, u8 phy_addr,
+			u16 reg, u16 value);
+	int (*read_ext_mii_regs_c45)(struct axgbe_port *pdata, u8 phy_addr,
+			u8 dev_addr, u16 reg, u16 *value);
+	int (*write_ext_mii_regs_c45)(struct axgbe_port *pdata, u8 phy_addr,
+			u8 dev_addr, u16 reg, u16 value);
 
 	/* For FLOW ctrl */
 	int (*config_tx_flow_control)(struct axgbe_port *);
@@ -398,6 +401,9 @@ struct axgbe_phy_impl_if {
 	/* Pre/Post KR training enablement support */
 	void (*kr_training_pre)(struct axgbe_port *);
 	void (*kr_training_post)(struct axgbe_port *);
+
+	int (*read)(struct axgbe_port *pdata, u16 reg, u16 *value);
+	int (*write)(struct axgbe_port *pdata, u16 reg, u16 value);
 };
 
 struct axgbe_phy_if {
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 9249e11335..cbab2908b4 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -203,7 +203,7 @@ struct axgbe_phy_data {
 
 	unsigned int rrc_count;
 
-	unsigned int mdio_addr;
+	uint8_t mdio_addr;
 
 	/* SFP Support */
 	enum axgbe_sfp_comm sfp_comm;
@@ -251,6 +251,8 @@ static void axgbe_phy_perform_ratechange(struct axgbe_port *pdata,
 		enum axgbe_mb_cmd cmd, enum axgbe_mb_subcmd sub_cmd);
 static void axgbe_phy_rrc(struct axgbe_port *pdata);
 
+static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata);
+static void axgbe_phy_put_comm_ownership(struct axgbe_port *pdata);
 
 static int axgbe_phy_i2c_xfer(struct axgbe_port *pdata,
 			      struct axgbe_i2c_op *i2c_op)
@@ -258,6 +260,44 @@ static int axgbe_phy_i2c_xfer(struct axgbe_port *pdata,
 	return pdata->i2c_if.i2c_xfer(pdata, i2c_op);
 }
 
+static int axgbe_phy_read(struct axgbe_port *pdata, u16 reg, u16 *value)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	int ret;
+
+	ret = axgbe_phy_get_comm_ownership(pdata);
+	if (ret)
+		return ret;
+
+	ret = pdata->hw_if.read_ext_mii_regs_c22(pdata,
+			phy_data->mdio_addr, reg, value);
+	if (ret)
+		PMD_DRV_LOG_LINE(ERR, "mdio read failed %s",
+				strerror(-ret));
+
+	axgbe_phy_put_comm_ownership(pdata);
+	return ret;
+}
+
+static int axgbe_phy_write(struct axgbe_port *pdata, u16 reg, u16 value)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	int ret;
+	ret = axgbe_phy_get_comm_ownership(pdata);
+	if (ret)
+		return ret;
+
+	ret = pdata->hw_if.write_ext_mii_regs_c22(pdata,
+			phy_data->mdio_addr, reg, value);
+	if (ret)
+		PMD_DRV_LOG_LINE(ERR, "mdio write failed %s",
+				strerror(-ret));
+
+	axgbe_phy_put_comm_ownership(pdata);
+	return ret;
+}
+
+
 static int axgbe_phy_redrv_write(struct axgbe_port *pdata, unsigned int reg,
 				 unsigned int val)
 {
@@ -2542,4 +2582,7 @@ void axgbe_init_function_ptrs_phy_v2(struct axgbe_phy_if *phy_if)
 
 	phy_impl->kr_training_pre	= axgbe_phy_kr_training_pre;
 	phy_impl->kr_training_post	= axgbe_phy_kr_training_post;
+
+	phy_impl->read			= axgbe_phy_read;
+	phy_impl->write			= axgbe_phy_write;
 }
-- 
2.34.1

