Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A473DFD530E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 08:44:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C00D34027F;
	Fri, 27 Feb 2026 09:43:59 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40]) by mails.dpdk.org (Postfix) with ESMTP id 763EA4003C
 for <dev@dpdk.org>; Fri, 27 Feb 2026 09:43:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+PL2MSTw6q8+4oHAaJ3P+mlIY8CaG0Cq3+SUlnZRABvxGsBifE0UospsuQFXibznTApEVka04QjEmlt5oP8IkpxEVZMdGoMFMMVGyokSIuZJuGb5Budew+f5gN5YXm8cGgT+F/5ub1esXEW+bLbb7S2065qCGok5pEONnONavkshL0bl7DhbwFvz8Plv5HzWUq56QY4f2QzLD7FV4y501bQfXZUfy1exBgllZy3ShMhL2zeeYcNuYAfzmZEapVO1tWy+J0D6iG6e6ulWEpi3Dqw1TOMoRGwPRKiuWJfw8p+ei7A8JrEmuU2aWW2oXyWPIyeemRZwPxdRvugZtsCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojZ1Gc7yIOQCgCH4ofwGageNhj3BgV1OeYAxqA2FXYQ=;
 b=Pxo2B7wMdmqDO4HjZJJB8dPiVk2isBaZoCDhMNLtj/rqLfB0ohkqgx9uaUzlkUv4r2Zx5rx0wKuWJHisAG014AuF51mnhGhECJlAi1YWAFzlzO9HHEYrsEewq8J2lVOqa8uFPOWYj8eGiKJPG1d8LtBGjjjm+5shqGxkiOfkU9WEdJh72GXxZ0ZwHRA0Xex+JVR3qBk+n4yQFGJBM9D2GsH5mhoDDKyg12TPaQWYg2S7Dwj3JhaU5WhJj8FdxLzyeo2I5+lFzabGzVlISpAuXdUjPRv8W2BwM4dg/Z3GtWwTMvkKqADJ+cmhB2f1umwe+QVhndRqZFz42Sq9uQD45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojZ1Gc7yIOQCgCH4ofwGageNhj3BgV1OeYAxqA2FXYQ=;
 b=IUT3ilgKzM2GdvqNk7VL6g/r8j6zhNSeOuDH7yGtsjpN0qTNHTGkq4mp0c6imPRcOHZkSNC5+vzIVe06h3bt6mNFUC2c5odD1xFZi/A8I25HzXGtbhzPVsXmAASVUoj2K/8N7JGb98nHuwD3xuwxfmiBTMWicoCfqKxuDJzJveU=
Received: from BL1PR13CA0278.namprd13.prod.outlook.com (2603:10b6:208:2bc::13)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 27 Feb
 2026 08:43:53 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::c5) by BL1PR13CA0278.outlook.office365.com
 (2603:10b6:208:2bc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.15 via Frontend Transport; Fri,
 27 Feb 2026 08:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 08:43:52 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Feb
 2026 02:43:51 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH v4 1/3] net/axgbe: add external PHY read/write functions
Date: Fri, 27 Feb 2026 14:13:21 +0530
Message-ID: <20260227084323.689-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260226164638.1381-1-ashokkumar.natarajan@amd.com>
References: <20260226164638.1381-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b80f4b9-61d0-426f-ba25-08de75dc55f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: gTo9/Twy7l7iIcMiP+D9cbCpagclU+djOXr9qEQr4/JVRnA0oJNLNekw13UZwn/Fz4jkAtboXpOlo9M17cXgxI/GSAQb4ID6MGjwZSfFjqmG3T83zUfsvtI7ur8VYlRoHFhLlG/jKSfC8N1rm4JjGRpMleYOn67hri0Az8xQ1KX8TXrh7yxNah10nHinPuBK08rk+zI9gIQRoA0hbls/okd5mroJQ6DQdEMN7aBtakbaZbRfAyokOcK7sWU6jkbQVIdACXbSxMKadFT/UpybSTzRQszJ1bIRLjg+ifSFzSsV6jsEmpg3yWvNK163HSSpLztzoz7NX+J3ipl7jFP3oQdcVfDwmITH2Vi2qtZaIxelxN1vmlq68kGNabOuJUTGk+J+EUWl6XtVNDS24GJYP73j13zTfKyyHDagtw7o0TUgAn+YNUMLW5zJsNoZ2/b8I5pA2SGEEUicO0ZI95dbm17x8FiqumiAI/SysqHg/dzWBNKm4vFsKcZHi3F7UnqRbnupvfYT7WAmSRTeQOPdZLHL2LH6ZR45PjJKo91QSAfoCLxTLW9o4hlcaZJRo39MCJF0wprSAir/ITkpk+KpBIkeFyl86WqCHBZZJwOshyPgZzdJ2FmuHtUFxrZjdGm7ju11zKTFySmK0onLQLKOTXKVd3lax4HpJod4U8UBly9NLz0s44rRkKqyVuG07opQNuOdL7xmXMDqCSE6VUbBOI17DichM51sxsv9LjPgq+m/kkGS57CtC0OR2Bm/Y15Pu8ZWtcFQdQtpAXaGnWqAiXjsDg4c4phrRdnEG/2AR3JY+r+esR2tXLxhiA9M7SkYrMop2aJmqf8ush4Nzxhwnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 64Vb+SxK46MC8+c0EOfKDQ+QBOvIm7EhM4SUXGpf5mPGZH0Ll5ikPP+3B5+CrZDsfkSSQ/3xdpC3rOE0iTyqVN7S4dafJ2yTX+Dgqs4TQYc3pAhr69hgjUJjsPoCADnpTpPUgS2Bq0byEh6/Noj3QH6CG0Ib/m/DCENi961Bx+o/fLGbzMUVUaT9VBMf9Fszk3DX3KWn3FDZJO/NwN3fUcLER7duS+ieG8Gyf6GcjnlT3WbooV/o+C8MxKWJZqQsS4iGjJBmKVBEXhhmk6wFwqSmQd31Xbt4V5apyZxKhkIcDhmuxdp8CeVxqd/Tyhgngw9CcbHtyVUnz0ec5cV7lUNGgo9QW8tCo2TVHXMJJUE++XcirlH6BKjnhxIuzeat1EQm5IgQZGQQh+7PpKVPmLWWHZjfKiXbAMO3qwokPImsaej+M6OQNz5BTD1zqiAw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:43:52.8184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b80f4b9-61d0-426f-ba25-08de75dc55f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8
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

