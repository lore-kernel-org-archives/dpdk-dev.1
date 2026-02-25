Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581C6FD374E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:47:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F7224027F;
	Wed, 25 Feb 2026 13:47:53 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62]) by mails.dpdk.org (Postfix) with ESMTP id 9A0C7400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:47:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iop4sAJCoEvdkv4xaLimKSBiOv638xGA9FumwsdxljAm9NhG39uK0nDIAVmGlqD+vl2MVbP46pdppurtwsER4l/Qjay/FfqRGnt5Vudc5N9HuJVpJfo8MstUS4y1Pb3LLZCOgKsU5AgYOgs9EC/NnF9Fd4eM55LuxZF76zWkjArsE5HC1wO/mCj+D+yzly8uNJ3wb71HLO+EFD7Ko5GW587qQVXblmNSdQIihKgdOS86M6A9zvol27BiLPSHvMpBh0GCerLT4aCz2/XmuPHE5qB662W/LqhOyVplyv/LUMQXnOSd/UMaU4UycCXkw7hXq9lCwTEjVvSD/+/a1b6mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddA9Zkudl8WgUJ8so5PJHgyPZK6pOg7nAAvk3dgy1NA=;
 b=to7eD2CG1o9e6tQYwkDVYMaBpD8WlQAOabcdy/cYY+Xqxw9V8Opoek1J/mN4Frnk3zmRDX4zJAc0Af9IiKMsEAqoOqEt4CGJZZDVPG5KLOQ1SPbODrTmCUUkq4BsL09ZzOYBQHQgLjL8D0P/YvyEtf9LZNWgFC5XSG2rOOAVP2awRbEbt0E/T1Sb8mGMKqPhKsNXijoxb8/0BpIJcZtnk50Z2522f5Pa5ClXU3C8V+UlRPSrRg1qHOTLB/TlgjW4PQY5ANwDTGzeHW3r1CmFy0FfCa+sWcrbEHC3wZ2EIMOJAaSgasnRQy8qxWxr8p5JsFOUSik5OQ/9vzMhCyO2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddA9Zkudl8WgUJ8so5PJHgyPZK6pOg7nAAvk3dgy1NA=;
 b=PWWWz0KDb0ARKkTqTSa0HzNRbo+McriIh1LOi+N40tmG2xRe2/424bNYyGRy2WHp/1KUweNr4eT3ArS495mlDpyq2f2YOIcUVLf4XZLLAlHN2q0kfwV5JGqLBaFVb0gBIjLAfdjsrFV62NACOluSPbof527wMWJjuXa5mOM9NEI=
Received: from SJ0PR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:33f::35)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:47:46 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1a) by SJ0PR05CA0060.outlook.office365.com
 (2603:10b6:a03:33f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 12:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Wed, 25 Feb 2026 12:47:45 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:47:41 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH v2 2/3] net/axgbe: add support for marvell m88e1512 PHY
Date: Wed, 25 Feb 2026 18:17:05 +0530
Message-ID: <20260225124706.1891-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260216125205.1032-2-ashokkumar.natarajan@amd.com>
References: <20260216125205.1032-2-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b775393-cf69-4f7b-9a24-08de746c130c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: jmL5f+iaLyKbUEmV8Ny8uXTTb8bn5H2lNpCSnfVv+y9ijKOnX3oTRb5rCKVbnfq4Ra0KDBvMb/T/O5Vo4hwDaWnT46S9UVGmA/cOPe2st3UZnOz9CVV24UHihTT9GxDnVoek+AR4VTqkQ/FXxSnFdQ6EXEO8/IfOHRaiFzO0v3HVxulOyHgZ4gx2gQmOdZ5626QfD8rJ+/OvJF5m3P00v2LHM2E389k2UFNR9pJS8JDMdFXVJPCpieUU8BtdMmrL7ErbKyYUUVnU5vxoJUTgXziRcIFXGpS1vFCRABEhzupi/8RD+chdwL6VuQ0z8sJUtod/2nkJbgsySiXur1iVdWUCsELHEcPgQ6VjBR4VECzfnuyNPeQhpIJJLX1v8HsDxnCGtfEYO/BxBCtors6bSOEil62sr8cFcJObQwqs1Ha9lPU+B6Py++nniPEdAabVBnfCmKF8/nUjFRHd9yN/EOdQwdd3M2Kgsuazr2uY6swiXYc8bZOjHoPaQqMKWgfL5PEA5bjU9L0FNGPmS2fC4VpOHmOd5ZtMO1ZHnG6QuB+0BSX1+qZTUcwB1S07CZ1W1KvIiP/0ZVOj/hV01Sxdss92TuXTT9pLh7Oxcd3HQY+i7cea/XLPBuiOi/7QF7BGpvB5V7qz2zMh3CwfW3SkixJP21PI4s6S+Kw0dIX0Swdxs/QlvsVzhgUK9ngjDPp41gEYAXScIKdMoE+vuODaIuwD9ZM+6aiJU3XJXT4T4HEFcBJHz9VX5z/bklGY/519GfaPxG7sdltMqQ5xJmbqeS/szWfsewuj4WxsZrFsy6ovyS3w3WYeq/bBFZP950YLmk/YNE4qvdiBA8O/wVA8CQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MP6y9SAdXd/A+6Vnxp20fPMvnRZoy0kFRHAvqWqzgCodsQlg5QWcnd1bg4UTiBcANhmyGTsU1x4925xb4dH8cDorrVgFwsOckxY/BRjqpm9FNAc/Cp6Xdw58rlyCI7UweHTyRL4YT0WoNBrkvbyGF0nLomU7k/OVF8IhSjBKNXY5JztN/xrCBLwxzOWa4z8Ig+6MGVJDqopYaYTRjNVb5YrOnkaymeGIJdvDJHZK486ckhDqZwGCAwoGRII7wxwUnd7AIbJi4d86jhgv2hx+g46phUf90OiJO9i5XCIxy82RFnQUDJarXUCtKK9kTZtM9smMr3EgS+84Ot+Udupw0W8KeD22Njcfo6MrPdQBoL5ebXI/O7N6u6XuCQD70zrUo3IT+fiW5ZeERrux0GW8Sez+tY0UZMeNeiNSZdBQK/r1TdTPogoDY2mdvQG2koB6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:47:45.6725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b775393-cf69-4f7b-9a24-08de746c130c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
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

Add support for the Marvell M88E1512 PHY in the axgbe driver. This patch
implements device identification and basic initialization required to
operate with this PHY. Only the M88E1512 model is supported in this
update.

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_phy.h      |  44 ++++
 drivers/net/axgbe/axgbe_phy_impl.c | 387 ++++++++++++++++++++++++++++-
 2 files changed, 427 insertions(+), 4 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_phy.h b/drivers/net/axgbe/axgbe_phy.h
index eee3afc370..1bedd8e132 100644
--- a/drivers/net/axgbe/axgbe_phy.h
+++ b/drivers/net/axgbe/axgbe_phy.h
@@ -63,6 +63,29 @@
 #define BMCR_RESET		0x8000	/* Reset to default state      */
 #define BMCR_SPEED10		0x0000	/* Select 10Mbps               */
 
+/* Advertisement control register. */
+#define ADVERTISE_SLCT          0x001f  /* Selector bits               */
+#define ADVERTISE_CSMA          0x0001  /* Only selector supported     */
+#define ADVERTISE_10HALF        0x0020  /* Try for 10mbps half-duplex  */
+#define ADVERTISE_1000XFULL     0x0020  /* Try for 1000BASE-X full-duplex */
+#define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  */
+#define ADVERTISE_1000XHALF     0x0040  /* Try for 1000BASE-X half-duplex */
+#define ADVERTISE_100HALF       0x0080  /* Try for 100mbps half-duplex */
+#define ADVERTISE_1000XPAUSE    0x0080  /* Try for 1000BASE-X pause    */
+#define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex */
+#define ADVERTISE_1000XPSE_ASYM 0x0100  /* Try for 1000BASE-X asym pause */
+#define ADVERTISE_100BASE4      0x0200  /* Try for 100mbps 4k packets  */
+#define ADVERTISE_PAUSE_CAP     0x0400  /* Try for pause               */
+#define ADVERTISE_PAUSE_ASYM    0x0800  /* Try for asymmetric pause     */
+#define ADVERTISE_RESV          0x1000  /* Unused...                   */
+#define ADVERTISE_RFAULT        0x2000  /* Say we can detect faults    */
+#define ADVERTISE_LPACK         0x4000  /* Ack link partners response  */
+#define ADVERTISE_NPAGE         0x8000  /* Next page bit               */
+
+#define ADVERTISE_FULL          (ADVERTISE_100FULL | ADVERTISE_10FULL | \
+		ADVERTISE_CSMA)
+#define ADVERTISE_ALL           (ADVERTISE_10HALF | ADVERTISE_10FULL | \
+		ADVERTISE_100HALF | ADVERTISE_100FULL)
 
 /* MDIO Manageable Devices (MMDs). */
 #define MDIO_MMD_PMAPMD		1	/* Physical Medium Attachment
@@ -114,6 +137,26 @@
 #define MDIO_AN_10GBT_CTRL	32	/* 10GBASE-T auto-negotiation control */
 #define MDIO_AN_10GBT_STAT	33	/* 10GBASE-T auto-negotiation status */
 
+#define M88E1512_E_PHY_ID		0x01410DD0
+#define AXGBE_M88E1512_PAGE_ADDR	0x0016
+#define AXGBE_M88E1512_CFG_REG_1	0x0010
+#define AXGBE_M88E1512_CFG_REG_2	0x0011
+#define AXGBE_M88E1512_CFG_REG_3	0x0007
+#define AXGBE_M88E1512_MODE		0x0014
+
+#define AXGBE_M88E1512_PHY_PAGE		22
+#define AXGBE_M88E1512_COPPER_PAGE	0x00
+#define AXGBE_M88E1512_LED_PAGE		0x03
+#define AXGBE_M88E1512_MODE_PAGE	0x12
+
+#define AXGBE_M88E1512_MODE_RGMII_COPPER	0
+#define AXGBE_M88E1512_MODE_SGMII_COPPER	1
+#define AXGBE_M88E1512_MODE_RGMII_1000BX	2
+#define AXGBE_M88E1512_MODE_RGMII_100BFX	3
+#define AXGBE_M88E1512_MODE_RGMII_SGMII		4
+#define AXGBE_M88E1512_MODE_SW_RESET		0x8000
+
+
 /* Control register 1. */
 /* Enable extended speed selection */
 #define MDIO_CTRL1_SPEEDSELEXT		(BMCR_SPEED1000 | BMCR_SPEED100)
@@ -190,5 +233,6 @@
 #define DUPLEX_FULL             0x01
 #define DUPLEX_UNKNOWN          0xff
 
+#define AXGBE_PHY_REVISION_MASK 0xfffffff0
 #endif
 /* PHY */
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 5bee7fec7a..0c23feaea3 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -3,6 +3,7 @@
  *   Copyright(c) 2018 Synopsys, Inc. All rights reserved.
  */
 
+#include <rte_cycles.h>
 #include "axgbe_ethdev.h"
 #include "axgbe_common.h"
 #include "axgbe_phy.h"
@@ -204,6 +205,7 @@ struct axgbe_phy_data {
 	unsigned int rrc_count;
 
 	uint8_t mdio_addr;
+	uint32_t phy_id;
 
 	/* SFP Support */
 	enum axgbe_sfp_comm sfp_comm;
@@ -253,6 +255,8 @@ static void axgbe_phy_rrc(struct axgbe_port *pdata);
 
 static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata);
 static void axgbe_phy_put_comm_ownership(struct axgbe_port *pdata);
+static int axgbe_get_ext_phy_link_status(struct axgbe_port *pdata,
+		bool *linkup);
 
 static int axgbe_phy_i2c_xfer(struct axgbe_port *pdata,
 			      struct axgbe_i2c_op *i2c_op)
@@ -297,6 +301,83 @@ static int axgbe_phy_write(struct axgbe_port *pdata, u16 reg, u16 value)
 	return ret;
 }
 
+static int axgbe_phy_config_advert(struct axgbe_port *pdata)
+{
+	u16 advert;
+	int ret;
+
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_ADVERTISE, &advert);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to read ADVERTISE register");
+		return ret;
+	}
+
+	advert |= ADVERTISE_FULL;
+	advert |= ADVERTISE_PAUSE_CAP;
+
+	ret = pdata->phy_if.phy_impl.write(pdata, MII_ADVERTISE, advert);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to write ADVERTISE register");
+		return ret;
+	}
+	return 0;
+}
+
+static int axgbe_phy_set_speed(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	u16 bmcr;
+	int ret;
+
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_BMCR, &bmcr);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to read BMCR register");
+		return ret;
+	}
+
+	bmcr &= ~(MDIO_CTRL1_SPEEDSELEXT);
+	switch (phy_data->cur_mode) {
+	case AXGBE_MODE_SGMII_1000:
+		bmcr |= BMCR_SPEED1000;
+		break;
+	case AXGBE_MODE_SGMII_100:
+		bmcr |= BMCR_SPEED100;
+		break;
+	default:
+		break;
+	}
+
+	ret = pdata->phy_if.phy_impl.write(pdata, MII_BMCR, bmcr);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to write BMCR register");
+		return ret;
+	}
+	return 0;
+}
+
+static int axgbe_phy_config_aneg(struct axgbe_port *pdata)
+{
+	u16 bmcr;
+	int ret;
+
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_BMCR, &bmcr);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to read BMCR register");
+		return ret;
+	}
+
+	bmcr &= ~(BMCR_ANENABLE);
+	if (pdata->phy.autoneg == AUTONEG_ENABLE)
+		bmcr |=  BMCR_ANENABLE | BMCR_ANRESTART;
+
+	ret = pdata->phy_if.phy_impl.write(pdata, MII_BMCR, bmcr);
+
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to write BMCR register");
+		return ret;
+	}
+	return 0;
+}
 
 static int axgbe_phy_redrv_write(struct axgbe_port *pdata, unsigned int reg,
 				 unsigned int val)
@@ -1132,10 +1213,35 @@ static unsigned int axgbe_phy_an_advertising(struct axgbe_port *pdata)
 
 static int axgbe_phy_an_config(struct axgbe_port *pdata __rte_unused)
 {
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	int ret;
+
+	/* Auto-negotiation config is implemented only for 1000BASE-T */
+	if (phy_data->port_mode != AXGBE_PORT_MODE_1000BASE_T)
+		return 0;
+
+	/* Supports only Marvell M88E1512 PHY for now*/
+	if (phy_data->phy_id == M88E1512_E_PHY_ID) {
+		ret = axgbe_phy_config_advert(pdata);
+		if (ret) {
+			PMD_DRV_LOG_LINE(ERR, "PHY ADVERTISE config failed");
+			return ret;
+		}
+
+		ret = axgbe_phy_set_speed(pdata);
+		if (ret) {
+			PMD_DRV_LOG_LINE(ERR, "PHY set speed failed");
+			return ret;
+		}
+
+		ret = axgbe_phy_config_aneg(pdata);
+		if (ret) {
+			PMD_DRV_LOG_LINE(ERR, "PHY AN config failed");
+			return ret;
+		}
+		PMD_DRV_LOG_LINE(DEBUG, "M88E1512 PHY AN config done");
+	}
 	return 0;
-	/* Dummy API since there is no case to support
-	 * external phy devices registered through kernel APIs
-	 */
 }
 
 static enum axgbe_an_mode axgbe_phy_an_sfp_mode(struct axgbe_phy_data *phy_data)
@@ -1883,7 +1989,8 @@ static bool axgbe_phy_use_mode(struct axgbe_port *pdata, enum axgbe_mode mode)
 static int axgbe_phy_link_status(struct axgbe_port *pdata, int *an_restart)
 {
 	struct axgbe_phy_data *phy_data = pdata->phy_data;
-	unsigned int reg;
+	uint32_t reg;
+	bool ext_phy_link_up = false;
 
 	*an_restart = 0;
 
@@ -1903,6 +2010,26 @@ static int axgbe_phy_link_status(struct axgbe_port *pdata, int *an_restart)
 		}
 	}
 
+	if (phy_data->port_mode == AXGBE_PORT_MODE_1000BASE_T) {
+		if (phy_data->phy_id == M88E1512_E_PHY_ID) {
+			if (axgbe_get_ext_phy_link_status(pdata,
+						&ext_phy_link_up)) {
+				PMD_DRV_LOG_LINE(ERR,
+						"Get link status failed");
+				goto out;
+			}
+
+			if (ext_phy_link_up) {
+				PMD_DRV_LOG_LINE(DEBUG,
+						"M88E1512 PHY link is up");
+			} else {
+				PMD_DRV_LOG_LINE(DEBUG,
+						"M88E1512 PHY link is not up");
+				goto out;
+			}
+		}
+	}
+
 	/* Link status is latched low, so read once to clear
 	 * and then read again to get current state
 	 */
@@ -1946,6 +2073,8 @@ static int axgbe_phy_link_status(struct axgbe_port *pdata, int *an_restart)
 		axgbe_phy_rrc(pdata);
 	}
 
+out:
+	pdata->rx_adapt_done = false;
 	return 0;
 }
 
@@ -2303,6 +2432,241 @@ static int axgbe_phy_reset(struct axgbe_port *pdata)
 	return 0;
 }
 
+static int axgbe_get_phy_id(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	u16 phy_id_1;
+	u16 phy_id_2;
+	int ret;
+
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_PHYSID1,
+			&phy_id_1);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to read PHYSID1 register");
+		return ret;
+	}
+
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_PHYSID2,
+			&phy_id_2);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to read PHYSID2 register");
+		return ret;
+	}
+
+	phy_data->phy_id = (u32)(phy_id_1 << 16);
+	phy_data->phy_id |= phy_id_2;
+	phy_data->phy_id &= AXGBE_PHY_REVISION_MASK;
+
+	if (phy_data->phy_id == AXGBE_PHY_REVISION_MASK) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid PHY id (0x%x)",
+				phy_data->phy_id);
+		return -EINVAL;
+	}
+	PMD_DRV_LOG_LINE(DEBUG, "PHY id (0x%x)", phy_data->phy_id);
+	return 0;
+}
+
+static int axgbe_phy_poll_reset(struct axgbe_port *pdata)
+{
+	const uint64_t timeout_ms  = 2000;
+	const uint64_t interval_ms = 1;
+	const uint64_t hz          = rte_get_timer_hz();
+	const uint64_t start       = rte_get_timer_cycles();
+
+	u16 bmcr = 0;
+	int ret;
+
+	for (;;) {
+		ret = pdata->phy_if.phy_impl.read(pdata, MII_BMCR, &bmcr);
+		if (ret) {
+			PMD_DRV_LOG_LINE(ERR, "PHY read BMCR failed");
+			return ret;
+		}
+		if (!(bmcr & BMCR_RESET))
+			return 0;
+
+		uint64_t elapsed_ms =
+			((rte_get_timer_cycles() - start) * 1000) / hz;
+		if (elapsed_ms >= timeout_ms)
+			break;
+
+		rte_delay_us_block(interval_ms * 1000);
+	}
+	return -ETIMEDOUT;
+}
+
+
+static int axgbe_phy_soft_reset(struct axgbe_port *pdata)
+{
+	int ret;
+	u16 bmcr;
+
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_BMCR, &bmcr);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to read BMCR register");
+		return ret;
+	}
+
+	bmcr |= BMCR_RESET;
+
+	ret = pdata->phy_if.phy_impl.write(pdata, MII_BMCR, bmcr);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to write BMCR register");
+		return ret;
+	}
+
+	ret = axgbe_phy_poll_reset(pdata);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Poll for PHY reset done failed");
+		return ret;
+	}
+	return 0;
+}
+
+static int axgbe_m88e1512_set_page(struct axgbe_port *pdata, u16 page)
+{
+	int ret;
+
+	ret = pdata->phy_if.phy_impl.write(pdata,
+			AXGBE_M88E1512_PAGE_ADDR, page);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR,
+				"PHY set page failed for page 0x%x", page);
+	}
+	return ret;
+}
+
+static const struct {
+	u16 reg17, reg16;
+} errata_vals[] = {
+	{ 0x214b, 0x2144 },
+	{ 0x0c28, 0x2146 },
+	{ 0xb233, 0x214d },
+	{ 0xcc0c, 0x2159 },
+};
+
+static int axgbe_m88e1512_init(struct axgbe_port *pdata)
+{
+	int ret;
+	u8 i;
+
+	PMD_DRV_LOG_LINE(DEBUG, "Initialize M88E1512 phy");
+
+	/* Switch to PHY page 0xFF */
+	ret = axgbe_m88e1512_set_page(pdata, 0xff);
+	if (ret)
+		goto err_out;
+
+	/* Configure M88E1512 errata registers */
+	for (i = 0; i < ARRAY_SIZE(errata_vals); i++) {
+		ret = pdata->phy_if.phy_impl.write(pdata,
+				AXGBE_M88E1512_CFG_REG_2,
+				errata_vals[i].reg17);
+		if (ret) {
+			PMD_DRV_LOG_LINE(ERR, "Config M88E1512 errata failed");
+			goto err_set_copper_page;
+		}
+
+		ret = pdata->phy_if.phy_impl.write(pdata,
+				AXGBE_M88E1512_CFG_REG_1,
+				errata_vals[i].reg16);
+		if (ret) {
+			PMD_DRV_LOG_LINE(ERR, "Config M88E1512 errata failed");
+			goto err_set_copper_page;
+		}
+	}
+
+	/* Switch to PHY page 0xFB */
+	ret = axgbe_m88e1512_set_page(pdata, 0xfb);
+	if (ret)
+		goto err_set_copper_page;
+
+	ret = pdata->phy_if.phy_impl.write(pdata,
+			AXGBE_M88E1512_CFG_REG_3, 0xC00D);
+	if (ret)
+		goto err_set_copper_page;
+
+	/* Switch to PHY copper page */
+	ret = axgbe_m88e1512_set_page(pdata, AXGBE_M88E1512_COPPER_PAGE);
+	if (ret)
+		goto err_out;
+
+	/* SGMII-to-Copper mode initialization */
+
+	/* Switch to PHY mode page */
+	ret = axgbe_m88e1512_set_page(pdata, AXGBE_M88E1512_MODE_PAGE);
+	if (ret)
+		goto err_set_copper_page;
+
+	ret = pdata->phy_if.phy_impl.write(pdata,
+			AXGBE_M88E1512_MODE,
+			(AXGBE_M88E1512_MODE_SW_RESET |
+			 AXGBE_M88E1512_MODE_SGMII_COPPER));
+	if (ret)
+		goto err_set_copper_page;
+
+	/* Switch to PHY copper page */
+	ret = axgbe_m88e1512_set_page(pdata, AXGBE_M88E1512_COPPER_PAGE);
+	if (ret)
+		goto err_out;
+
+	ret = axgbe_phy_soft_reset(pdata);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "M88E1512 PHY soft reset failed");
+		goto err_out;
+	}
+
+	PMD_DRV_LOG_LINE(DEBUG, "M88E1512 phy init done");
+	return 0;
+
+err_set_copper_page:
+	/* Switch to PHY page 0 */
+	axgbe_m88e1512_set_page(pdata, AXGBE_M88E1512_COPPER_PAGE);
+err_out:
+	PMD_DRV_LOG_LINE(ERR, "M88E1512 PHY initialization failed");
+	return ret;
+}
+
+
+static int axgbe_get_ext_phy_link_status(struct axgbe_port *pdata, bool *linkup)
+{
+	int ret;
+	u16 bmcr;
+	u16 bmsr;
+
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_BMCR, &bmcr);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "PHY read failed for BMCR register");
+		return ret;
+	}
+
+	/* Autoneg is being started, therefore disregard BMSR value and
+	 * report link as down.
+	 */
+	if (bmcr & BMCR_ANRESTART)
+		return 0;
+
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_BMSR, &bmsr);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "PHY read failed for BMSR register");
+		return ret;
+	}
+
+	if (bmsr & BMSR_LSTATUS)
+		goto done;
+
+	/* Read link status */
+	ret = pdata->phy_if.phy_impl.read(pdata, MII_BMSR, &bmsr);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "PHY read failed for BMSR register");
+		return ret;
+	}
+done:
+	*linkup = (bmsr & BMSR_LSTATUS) ? true : false;
+	return 0;
+}
+
+
 static int axgbe_phy_init(struct axgbe_port *pdata)
 {
 	struct axgbe_phy_data *phy_data;
@@ -2556,6 +2920,21 @@ static int axgbe_phy_init(struct axgbe_port *pdata)
 	}
 
 	phy_data->phy_cdr_delay = AXGBE_CDR_DELAY_INIT;
+
+	ret = axgbe_get_phy_id(pdata);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "failed to get PHY id");
+		return ret;
+	}
+
+	PMD_DRV_LOG_LINE(DEBUG, "PHY ID = 0x%x", phy_data->phy_id);
+
+	if (phy_data->phy_id == M88E1512_E_PHY_ID) {
+		ret = axgbe_m88e1512_init(pdata);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 void axgbe_init_function_ptrs_phy_v2(struct axgbe_phy_if *phy_if)
-- 
2.34.1

