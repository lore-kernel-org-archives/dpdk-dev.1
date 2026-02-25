Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F7DFD374E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:46:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 611E54027F;
	Wed, 25 Feb 2026 13:46:14 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12]) by mails.dpdk.org (Postfix) with ESMTP id 9007A400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:46:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYGBudp2GJt+2WdVB6ATn3ZyE7DaEJYDxoNOIZVUg+dZh+a2NG8LG+7Aq057wvmA4Cj74i4oxDEYqlkmYrN1C9rfTz3oiCD3qn6LC0TaxbF9X27vqfJWPew3LkTBHB4RYDsTyZ5MOQvrcPEYVMJlM7gBecpfJnGeuFU4ZB8LQCdyxDeJw2XEMREoa/F+xNWYCNnnFnD1lfsccFtU+WVsbO6/mx/whhmlsyaV06H3DRgLKwu9avZTGaJ3JnVn6niY1HuslqN1PIBZwLqth4084rXP1QzJVbOc/cnmBKYmsMzqeuTFQDrzfhs4hpRk0InqZAn2U35VjLnWLegwpf3XCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzf8FYThGMG8n+zeLnWAQdnYT2J+FwokOQwTHo6Rrkg=;
 b=MpMvMLjSARFCCCDxgiPUtZO1eEBr0/M3PZYL8XbsPqfATSQ6K6jedYbysCV5V+VrfroHSzU5nN6agefYqpnliOEjtoQFeFQVw4Kug/uMdkgWM8CKXgojcfZcxYJPr8K1S8FzUzjCsbC2vGBZUSvca+LWRMRV1OinedFlfQlwdvQKeWPVjs1+c0aYKv9JjkmnTMG+lr3TVKSiVIhMesQf919+VBpJRfTcUmu4RNBO7VUCre+0KLyPfYTZPv5XuCNcMEbxzznUxS1YSTgMAi4VKIenDlX952xLeTvfwpzwcx2FggjDVIh5qMgJn9Vr1roZ0CAj0JrmxvGyuaz5Leq/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzf8FYThGMG8n+zeLnWAQdnYT2J+FwokOQwTHo6Rrkg=;
 b=O5ZUrBAaHS84G960Hzgr+Hn5eRaCX4zCw6YpBCs4zpV1G/9+ZRs2j9unjOUbXUzHI8L+lFtUWqMl8Tses70+DIXg6kqtLnWp2IGoy3DOpGL9DUF6pp8C1QrsHX4R6SeOrHqFjvrCE2WcUX5D3i5O3tF4P8u7ZsmXZ3htr7Bra8w=
Received: from BYAPR02CA0011.namprd02.prod.outlook.com (2603:10b6:a02:ee::24)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 12:46:07 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a02:ee:cafe::d9) by BYAPR02CA0011.outlook.office365.com
 (2603:10b6:a02:ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 12:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Wed, 25 Feb 2026 12:46:07 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:46:04 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH v2 1/3] net/axgbe: add external PHY read/write functions
Date: Wed, 25 Feb 2026 18:14:54 +0530
Message-ID: <20260225124456.1871-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
References: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f7bdef-5066-45db-8584-08de746bd84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: WFlL7mnJv7U+P+0pzGTfkSkneJG+YjGGQdp99+U7zlKaczZvT5B/79/s8TnujaM49PGDQRw9hE1u7An4do1pXUKCBFPA8gRBiWtgGi9gWVtqG9Lxu/Y9l6HqiSoiUAnHL/AMHvjdT91CyrEhLK/T4BK91o20Xgmlsw17SwIkpk5h14b1G4zVqt67e4KGGKy2OaHq6cWm+ARrWLkgRoZhcAopMDLAnZRJcPwga52sMnOImUoak0TT5caE5i/HVTbA99XQT0RhqWaewv95GBi6fiqJAQ6UrnJ//SfUGqf7lNv9MyqFnU9wLFTIS5HfAsD1su4TO7VS6vtC/KLypRfMq7lFYvA3UmzcT04G5eTsgpcPvhBc7I+klVrxJQ2KCYSWUHA1QcAApgnEDn2y1/e3LZIBemlW1o5prU5HsOPS9FbIEvoKoyHRDIaqRlfG/458SpmROBdDezaDjWpGm+NR5oiVFxOEmoGbv4jQheGLGGBs0nCtlcDQz7af+jyEUCP0ggla2FiXJ2YBkpPrFWIGdAsiFjnmyi2o14ct7Zq3LrRnk65hCP4PSzr+N3k4AZhYzud6zw5iu1CtW6M2+RubvLTk4I29PoYDmJDWoFLZot51lqQfgdzKPX/RO1Mdo0fUsrh7bgQ1in0Q8bvFfkRaTBm5J753hSfunm8eJpRd2EZ5NCPvaV912Pi0AlFnh5t2vuPiD7w0uI2ybQBbXXwGBhpgVCtPoyx/qo9jz+NyCVyRJfAL8E/FC5tZyWfYnmxLlQmlcR4UbOC+ZHHHJeYDK1oAK4X72Gi1AgEQCB39jgeyIGpl/8gCZH5n332pqH9OMGOdriot68N1Uf+sCfbBJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qo+KrdlpkyeOI1G0lrwT+M1I2nseFtbOeOeAIjZJSfhuenT63k6hHPu5mfEIeakE8nT1yOJho8IC3BNnHLZ5K2VzhV9TGGH7yosiClvXYz6W15u9KrFGwD79mIWMMOpy8uzKs/sa8RoEz79TsglQ8U6arEVH14dT7CZWRGwN33MaJSCtS3VAHOPkGCraMwEqMx6q111rlcjBffv0/QSOkvEsW7BGxYG7s0pmdGhUqZZIxFi2rygo+xPgyr81uO0i4/s3RelIQgvd+TJjkgZeToRJmYXzroEgXWiKUK/4HCFw0X4wyoSXtM/KMi28Vb9AzOc28+8ure54gaOjL5fzio3fwcjaBRSxTF0zv0bMkjUh3hBDci7/Whkp0VOa9r2DbTui59yFFuB4dtqYwsSkR28sihaAwgXhzNzZ6J1jpoI/rOlu9HX1OFO2QeEEIUTj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:46:07.1246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f7bdef-5066-45db-8584-08de746bd84f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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
index b94a7f3562..f8f58460c4 100644
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
+	int (*read)(struct axgbe_port *port, u16 reg, u16 *value);
+	int (*write)(struct axgbe_port *port, u16 reg, u16 value);
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

