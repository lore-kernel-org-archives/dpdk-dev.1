Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027C1FD8FD7
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37140402BB;
	Thu, 26 Feb 2026 17:47:15 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by mails.dpdk.org (Postfix) with ESMTP id 57C3E402BB
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:47:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyf2eDi5ZrwEEUYvOmmODr2d/adDSU59EYVWXg13YGgKo6EElhGTkdPP6kGw1P8V5vp4uh9d6YpAXeS1qQAXepwz3rGoFuu5+toS9qU9tCFvYbb9oFfac9m9GDy3WLT/zi9j/mOSX8uabWjc5rDGXk0/Sf/bfG+kR5P/BWi3xk7/R8Xxe/L8nwzfyq7eKSYQsI8/Enr3WJhbzn9qFcfG0DuVfnuYcrFGYQx8db2j9GYaCmhxowmFUQ7KI83o/77UNC+DplBeBLZCYKvfP6IuU1+5GCnd9CZK1SShHcYxwre/cFWV6l9RTx9WfJv2VyfoEKMXXJJv06soknYbDK1Dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGGaoz0dRcrgnkoopH/0ciQbGg5jP/2B2YFFxRDggpY=;
 b=O/QxsIKG4Wnatqk9h9q1faQg+S593v0LPkULWDD8gLsEoIDJ9aVpYoyl6pwQv9F21OJ0g+9kTZGeoQhaWnUxXDAMIv/5bkJxqImCSziUfRU0LMoyQMgfg0dix2Mfft+8vS4D/pVQbWU1P5/sfDZpdVE+VPff1Y7U9xLqPmFRNEkub9V50VRQ0rFavu5g8azBxriE05Gvty4CbipqTGoTh/ghlInCiSMCtDNx9EA0b9UQ8S8PyuOAoTjr767rQV7pEp3Q2wjaZkXDcqDJLEqu7+2ksXsQvHvA/bCf8+uRA+Yb7VqIJfkYO3Vzw5YKwSFEihUwWIHD6o8yWEWarR3NsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGGaoz0dRcrgnkoopH/0ciQbGg5jP/2B2YFFxRDggpY=;
 b=ujq5DdKNjtDitEHwj3wY47ockujAyk73vG+zM1VoEUkAMQn+a79+GRpxZHdTYOrRTBHGnLdMVR7UTEOWG4b2h/miAK311gup43XbOngBUVcGkqKHFVW1i81b/VZm6Nwkc/O9zeiG/o1CS4vFJBt32dTaYL4towCnjhxzTtrl9+8=
Received: from BYAPR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:74::23)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 16:47:10 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:74:cafe::dc) by BYAPR05CA0046.outlook.office365.com
 (2603:10b6:a03:74::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 16:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 16:47:10 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 10:47:04 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH v3 1/3] net/axgbe: add external PHY read/write functions
Date: Thu, 26 Feb 2026 22:16:36 +0530
Message-ID: <20260226164638.1381-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260225124456.1871-1-ashokkumar.natarajan@amd.com>
References: <20260225124456.1871-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 321b4501-0353-4127-24d8-08de7556af4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: ztgxHYSU57dVXsn25GsTOA+d8B8Pw0N9nv2fXKLiS/ZUmouPAcjxBbCVbNJ9vaU5TUa3DCYLc9n+3iP1Y8kQM95vk4JJ4sq2D20gdG93dK5ACq/pm3utrTKz4JxGcx+q0Su2zYGjJtuO3Kd2G/KqA/TnbCGT7yAsTtfkTuO5TH+px/RzKbywlFa11gGTtK2Q292ktOgF+D/ZYCI7/bZRx548MtQ+QTRP4NZYlMjFoz8H80x3Qspjds1baoQW3cs84J/aOF+rc/f1PtddWDb4Un5ZHBT4mkjrjcDGtx8Bk/bTrQife6w7SxTv/h/aYoOhjhCfElEeST323GGKno2vLV3qslaCBXc2wO1Mytsm9F78kj8JrdM3HtC/9JowKF5oYAO/5EPAJkFy3JyiTmI9KMHg66yNDaxbGP2KM3vOPhftVgvNAp8QBjGjzDcjtD+vNwIjM08Tm5lEaXRO/7S8IdsGt6YkxSPc3RWHtbjhzUvpFbBwPYJP39A4fF93VZEz/8y7SG2zoiSh/WtD7r+A/Q8011AFNHFQVLPd/YUo9SpyWZwJM4y6pzsH/QmxJixKicUtFeBXRPfOXhSBaqydyhfBqwxvKVLYo11SacieibZ7xaRGgmmzE0LjiUocC/hQWhFLYFIj5WEEmMlbdTZ3vinNh3t6HcweHpqTlSZ5G1hDaKCE4CbEdWWW2W4vxSrOfN8DEB0xEx++jjrl9pJAlDi4zFyNUYF/zj1/XkLskXRE1PWUbJZiyJ9H2K3OopKhOgVw7aJ/tvH1El9T91orHxY/PZVIsvM0Mp7V6fb7+82wNOyA8/a7VlNY9mYcQ41sSveafgAkhG5/6HtIzvZCwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4lkxjuKJ04v0VkSmJXYiMF3bJvOfbYMjidJ7wfFNFFsCTi6TZJmgyFNCNl4rUIQ3Rd1n7qQK28fCM97JM7fDUX9jsw/zCu1ncG0L73MBHdZHiuFs5yB5j/th7zDWvyYYPlOPpxQzu6UFoPyhSJdHpKl6US9g/m7sU1anKBCnN9UUYfRZEeCdRyLcr25A4+wGhRpG/YTDRoV7KyWCVcTC+ognuiiS1cI9r3x0sm3n1jANPu0I+UBJRqnxKnGqZkqXRVFBtGCPFp6SYS93+/AN3kW4j7S1BCCV8/N5sJUU78QiqN3X/k/L5sM0zmslW0iTqLDnp/AkFToQANz5lq1N3MVggpW5aLzRMJO/RWvm8tUGGTbSKTh0QtXcVY/XMB2puVdI3foMrfwjHOeFiWBLXeT6eynjwbWET9k0q1AUPBN3SzOiapEufcTA4liG7d1p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:47:10.0680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321b4501-0353-4127-24d8-08de7556af4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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
index 9249e11335..5bee7fec7a 100644
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
+				strerror(ret));
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
+				strerror(ret));
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

