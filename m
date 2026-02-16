Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DE3E7BDB8
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 12:52:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 932624042E;
	Mon, 16 Feb 2026 13:52:50 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
 by mails.dpdk.org (Postfix) with ESMTP id 383864042C
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:52:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFD+b25kkN/lbAFlVvVWBgHWw/B7pR5eCDJah5BOAznm7XaDr1rc2H2nkpphPEZJqfm4d7qRA+Mblf6Z7qE4GJ3PCjeL2gn79OzB16lP8KUTO01Y2MA7V4s8Y4761t0wG3gE2ExOA6Tav1Z5a6IbU0Fv8ln9zAoI12PMa8WvRfkPlOZyh5UbMtretDjdiDqVafp3zw/NWaaPK9hwVSut/b18XO5mvLBXPx1CVi6JytoRqxFV/IRw3yVANl+vf5KXZmRcFaNufxx7/9Y9GIB18SxnDgLf4yQiStyfHyeW978gvAyowLJSl6/VmfTzYTiF9TMjUdfI1SVjopnJIbUpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxTDcAE/XEHMTHUCD4vYuRm88pV+xpXJHgQwFrCReQQ=;
 b=Xuq41MvMChkHNSxbvXk8zVlp1Lr1E7RObjIyU6hpZWZ1/TcMaMpIKEP6SQ9wGHqwuFNf6odRB6v73TQS3rJxINfmOkbXrcKOKIM+XMkYC1vyLSYpirpHTCh2Qen+/MRHWmTniSINuqJbFDQqhX9A12Xc8W2kRsNlDa6aShLQYbZVU/POsPmtFdXDk1cNY16b65RsStQJzuNhMKavbPf0oVef3VILOtnjbnY7oJ9rsX24TkAVShRLwk+gIuMy8oHrbjwDPN45oMvmXCQ4f+m5mUjUnhFVu2dpq+6zM4J4yjFXKwgYVP3GP3nD5fsyBE9GNbWOTDLdyvxGn0dePiigWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxTDcAE/XEHMTHUCD4vYuRm88pV+xpXJHgQwFrCReQQ=;
 b=DNAHE9AgMaiO1ht2eNp952iuA7RT27Jkd5Du39Js7t3TvbjsEfcOWHbyVwmhAPl350eiD1bXqJo5qCQvO24Swd34/ybI1QB5NxgpS1CO/hko6IKW0aZZeGHODUAMP1gaL+TPX9FGbvFe9res3UAAD6e2bmRbOAADV1TQt9p+sw0=
Received: from DS7PR05CA0043.namprd05.prod.outlook.com (2603:10b6:8:2f::22) by
 LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 12:52:42 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::99) by DS7PR05CA0043.outlook.office365.com
 (2603:10b6:8:2f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 12:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 12:52:42 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 06:52:40 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH 2/3] net/axgbe: Add support for Marvell M88E1512 PHY
Date: Mon, 16 Feb 2026 18:22:04 +0530
Message-ID: <20260216125205.1032-2-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
References: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 54528e23-fc62-4b23-c04a-08de6d5a4602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rLcDXf8wNV3qepQdtY6pnuvR//PAzis8C8jhx2vQiPWFUtQH0P73naUQ7eiM?=
 =?us-ascii?Q?XwEuQBBj5VSO2Um4ZZBkdmI26krmpUZFnzb3X4y748foiSK62wmB1DIhRvMv?=
 =?us-ascii?Q?THcNv7xLH9EOsxeGOzxnce+QKR8S2aerBwL9wHu3VxY7GFiHy4JvjDRB7Wek?=
 =?us-ascii?Q?SvA2MqFP0b4wEi8AhEd1G185i+p6zSaB6g7GaDCpoIa5PBCuQFrGZC3IqtfM?=
 =?us-ascii?Q?wecU7soDZ+wbOt3mB9NoShjE20Spji7PvJ7t96Qm/tllrzVEXT2BIdHQV3ut?=
 =?us-ascii?Q?7f0XGWXpEgn9bB1zQqrjHxrjqq5Ew550jGf4iATvG+rMezRSoh4LMrANxwV/?=
 =?us-ascii?Q?bRyNZQOyJ2EMs8NvduZ99/QWZeOByt4uxYsOOfY2Pm5d6XPCScjR/rQH7+UP?=
 =?us-ascii?Q?EAiaaLg41ONfzGXGMjKYLsqz9IX+hD14++tlP157x9P3Otya9pQe8ErxPLXG?=
 =?us-ascii?Q?UpOYZjaWCJujg4d0iFtU1uhryvYjMotfXwUVCwC7Reaxw8q5uts7HLlpQoFQ?=
 =?us-ascii?Q?vxTbrtR739OlDjS/aTrLuRmrcHrnQW6LKLUCE0DK82go+h7Kn2MgLkZ+tAlR?=
 =?us-ascii?Q?Ju+ltO7qQYgcCrhpYgWXBWDqw2hbQ5ERDz82NuhjAiYyDIx5xd7qhlKFPBmP?=
 =?us-ascii?Q?wTqh6fWp+ORC5EtBO5e+fDLa3paXOFXzVGxIZfCNCige5ld2In0QX0JUDwlg?=
 =?us-ascii?Q?r/czBAdjHL5Dq6gL0dDYidgpFqpbw2EiRwbcmNCHYyQeHT5YLSBjulTUlW/s?=
 =?us-ascii?Q?uuihYtzGukXXXNRY0pHtVi4UbyXCJmzsJJg9VMHcl4WXYLTZdWSoszh2O2jh?=
 =?us-ascii?Q?esFm02TQ242wVs5l7S5b883cO08Hnj2cPEbz3yWpiRTdsEw/Q8YAYdiCkXrb?=
 =?us-ascii?Q?UhDmTphWrxelzSo/XEoiyFd6JW5sCjNVW2VGLxIYueZjaVTjo2BbP9lMuhfT?=
 =?us-ascii?Q?EA3GH2NLmhatfH7JoaISQ66467goTZxiRFwg6VeCVp+Vim/KQJU2OMa0Xxlm?=
 =?us-ascii?Q?q3AJpvIDdpJeGQDSrKv9VuWOSD+TLCx1i8iKODyt0MH+mgkCy98K02L6cEVq?=
 =?us-ascii?Q?/VyNG2DBBR3O0blPc7KDOei9gDzaMKroaTA/gozJLkN0I6nXucEkdW7P6rFG?=
 =?us-ascii?Q?ViJvIFvVMjSvK5+d27eHdc3IAcxDmBQ5Nc3cZjRMYzubqjYKP9edXK1GvGul?=
 =?us-ascii?Q?kolGdDw522Sr7nSVC2e11mPTtGpOGn41Uo5l4Myi48TEI3E66NxJfEvAQZMo?=
 =?us-ascii?Q?qwIZLOfbWb9pmrB1KgmGT2UkNPmQdbSoWVovEa9DuNbuirpcTRQi3lJZic5q?=
 =?us-ascii?Q?cufEtAo+53QGxVg8eFLgE5//XuscQ4HNH71dQAqo3IZX9+NonnmdV++RLOTD?=
 =?us-ascii?Q?UGEbTTfMa04CxH6PvW8Gmjx2qg0ubymY2Ai8SfaQXdtCdw1uinpf0YD8gNcn?=
 =?us-ascii?Q?leDSlFQHdIPjL3+9Id9cE5xIbcr4vH7KjJTS5rv134KZWwSeaGM7NTDDk/1C?=
 =?us-ascii?Q?QdmtTbh2I7xDTDxyhV3cCWLr3TUW4WjWJQO5JINVwvB+JcSmVn2DPyrIaM2P?=
 =?us-ascii?Q?UAL7Y5AHSqyDSn/gR0aYpFBOQxRd+ntw1a7q2qfxmZFWmONelddAB2Q4WRUc?=
 =?us-ascii?Q?6Dk2qDV1Fp4O+nKUVqeoRrUScyO6zNdrxm8RiovumDu43StT+tt3cMYi848V?=
 =?us-ascii?Q?rynwTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UXaeqJ8NpC5HABFeKbEQdPQtX8xHhqV9lcx8b2+sbhRmvmDtVYvEgXak68UbxlWEaMODjeXcnB+2UO/6P7kNhPI2yKo1Zfk1oMdAluwR97SP/J6nu62UtI6v/w/2WyYgahUHd80cyp0j4bOA2b+kFJ/XIQ1+pR20lE4YBRIx2fkYImV9fIuLYlVmpsbwBOETAQJPJ4AeS9UrNSOSzmmqSxnXNwIIilkU5o5YbymPKx8e4OXCsRsTKtv5zKss147eW39BS2o7WMRuKp6OQQLJTtXsRlcDat1j69QYNdUp6+tYAC41/wGHZiLkKlnPjoSogfzK2zEzYyZRdbHLF3tKQAuB3KuM6mb3j3smjD5heK+5YAIR+olRpPH8S518F8SSc+U3IqhpsDmRhJnYiUqlnDxAI5cu9LjawV8tqWBb4JRHCB2XrqvMU4SSp6VVhTRm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:52:42.1767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54528e23-fc62-4b23-c04a-08de6d5a4602
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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
 drivers/net/axgbe/axgbe_ethdev.h   |   1 +
 drivers/net/axgbe/axgbe_phy.h      |  32 ++++
 drivers/net/axgbe/axgbe_phy_impl.c | 261 ++++++++++++++++++++++++++++-
 3 files changed, 290 insertions(+), 4 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_ethdev.h
index 12d77cd520..3a9dc81691 100644
--- a/drivers/net/axgbe/axgbe_ethdev.h
+++ b/drivers/net/axgbe/axgbe_ethdev.h
@@ -276,6 +276,7 @@ struct axgbe_phy {
 	int pause_autoneg;
 	int tx_pause;
 	int rx_pause;
+	int id;
 };
 
 enum axgbe_i2c_cmd {
diff --git a/drivers/net/axgbe/axgbe_phy.h b/drivers/net/axgbe/axgbe_phy.h
index eee3afc370..ef02488adf 100644
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
@@ -114,6 +137,15 @@
 #define MDIO_AN_10GBT_CTRL	32	/* 10GBASE-T auto-negotiation control */
 #define MDIO_AN_10GBT_STAT	33	/* 10GBASE-T auto-negotiation status */
 
+#define AXGBE_M88E1512_PAGE_ADDR	0x0016
+#define AXGBE_M88E1512_CFG_REG_1	0x0010
+#define AXGBE_M88E1512_CFG_REG_2	0x0011
+#define AXGBE_M88E1512_CFG_REG_3	0x0007
+#define AXGBE_M88E1512_MODE		0x0014
+
+#define AXGBE_M88E1512_SCR		0x10
+
+
 /* Control register 1. */
 /* Enable extended speed selection */
 #define MDIO_CTRL1_SPEEDSELEXT		(BMCR_SPEED1000 | BMCR_SPEED100)
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 4f3cc63836..20cfdcc796 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -37,6 +37,8 @@
 #define AXGBE_CDR_DELAY_INC		10000
 #define AXGBE_CDR_DELAY_MAX		100000
 
+#define M88E1512_E_PHY_ID		0x01410DD0
+
 enum axgbe_port_mode {
 	AXGBE_PORT_MODE_RSVD = 0,
 	AXGBE_PORT_MODE_BACKPLANE,
@@ -250,9 +252,11 @@ static enum axgbe_an_mode axgbe_phy_an_mode(struct axgbe_port *pdata);
 static void axgbe_phy_perform_ratechange(struct axgbe_port *pdata,
 		enum axgbe_mb_cmd cmd, enum axgbe_mb_subcmd sub_cmd);
 static void axgbe_phy_rrc(struct axgbe_port *pdata);
+static int axgbe_get_ext_phy_link_status(struct axgbe_port *pdata);
 
 static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata);
 static void axgbe_phy_put_comm_ownership(struct axgbe_port *pdata);
+static int axgbe_m88e1512_config_aneg(struct axgbe_port *pdata);
 
 static int axgbe_phy_i2c_xfer(struct axgbe_port *pdata,
 			      struct axgbe_i2c_op *i2c_op)
@@ -1116,12 +1120,19 @@ static unsigned int axgbe_phy_an_advertising(struct axgbe_port *pdata)
 	return advertising;
 }
 
-static int axgbe_phy_an_config(struct axgbe_port *pdata __rte_unused)
+static int axgbe_phy_an_config(struct axgbe_port *pdata)
 {
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+
+	/* Auto-negotiation config is implemented only for 1000BASE-T */
+	if (phy_data->port_mode != AXGBE_PORT_MODE_1000BASE_T)
+		return 0;
+
+	/* Supports only Marvell M88E1512 */
+	if (pdata->phy.id == M88E1512_E_PHY_ID)
+		axgbe_m88e1512_config_aneg(pdata);
+
 	return 0;
-	/* Dummy API since there is no case to support
-	 * external phy devices registered through kernel APIs
-	 */
 }
 
 static enum axgbe_an_mode axgbe_phy_an_sfp_mode(struct axgbe_phy_data *phy_data)
@@ -1889,6 +1900,17 @@ static int axgbe_phy_link_status(struct axgbe_port *pdata, int *an_restart)
 		}
 	}
 
+	if (phy_data->port_mode == AXGBE_PORT_MODE_1000BASE_T) {
+		if (pdata->phy.id == M88E1512_E_PHY_ID) {
+			if (axgbe_get_ext_phy_link_status(pdata) == 1) {
+				PMD_DRV_LOG_LINE(DEBUG, "M88E1512 PHY link is up");
+			} else {
+				PMD_DRV_LOG_LINE(DEBUG, "M88E1512 PHY link is not up");
+				goto out;
+			}
+		}
+	}
+
 	/* Link status is latched low, so read once to clear
 	 * and then read again to get current state
 	 */
@@ -1932,6 +1954,8 @@ static int axgbe_phy_link_status(struct axgbe_port *pdata, int *an_restart)
 		axgbe_phy_rrc(pdata);
 	}
 
+out:
+	pdata->rx_adapt_done = false;
 	return 0;
 }
 
@@ -2289,6 +2313,225 @@ static int axgbe_phy_reset(struct axgbe_port *pdata)
 	return 0;
 }
 
+static int axgbe_get_phy_id(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned int mdio_addr = phy_data->mdio_addr;
+	int phy_id, ret_val;
+	ret_val = pdata->phy_if.phy_impl.read(pdata, mdio_addr, MII_PHYSID1);
+
+	phy_id = ret_val << 16;
+
+	ret_val = pdata->phy_if.phy_impl.read(pdata, mdio_addr, MII_PHYSID2);
+	phy_id |= ret_val & 0xfff0;
+
+	return phy_id;
+}
+
+static int axgbe_phy_soft_reset(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned int mdio_addr = phy_data->mdio_addr;
+	int ret, bmcr;
+
+	bmcr = pdata->phy_if.phy_impl.read(pdata, mdio_addr, MII_BMCR);
+	if (bmcr < 0)
+		return bmcr;
+
+	bmcr |= BMCR_RESET;
+	ret = pdata->phy_if.phy_impl.write(pdata, mdio_addr, MII_BMCR, bmcr);
+	if (ret)
+		return ret;
+
+	rte_delay_us_sleep(1);
+	return 0;
+}
+
+static int axgbe_m88e1512_config_aneg(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned int mdio_addr = phy_data->mdio_addr;
+	int an_advert, bmcr;
+	int ret;
+
+	an_advert = ADVERTISE_10FULL |
+		ADVERTISE_100FULL |
+		ADVERTISE_PAUSE_CAP |
+		ADVERTISE_PAUSE_ASYM;
+
+	ret = pdata->phy_if.phy_impl.write(pdata, mdio_addr,
+			MII_ADVERTISE, an_advert);
+	if (ret)
+		return ret;
+
+	bmcr = pdata->phy_if.phy_impl.read(pdata, mdio_addr, MII_BMCR);
+	if (bmcr < 0)
+		return bmcr;
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
+	if (pdata->phy.autoneg == AUTONEG_ENABLE)
+		bmcr |=  BMCR_ANENABLE | BMCR_ANRESTART;
+
+	ret = pdata->phy_if.phy_impl.write(pdata, mdio_addr,
+			MII_BMCR, bmcr);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int axgbe_m88e5112_set_page(struct axgbe_port *pdata, int page)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned int mdio_addr = phy_data->mdio_addr;
+	return pdata->phy_if.phy_impl.write(pdata, mdio_addr,
+			AXGBE_M88E1512_PAGE_ADDR, page);
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
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned int mdio_addr = phy_data->mdio_addr;
+	int ret;
+	unsigned int i;
+
+	PMD_DRV_LOG_LINE(DEBUG, "Initialize M88E1512 phy");
+
+	/* Switch to PHY page 0xFF */
+	ret = axgbe_m88e5112_set_page(pdata, 0xff);
+	if (ret)
+		return ret;
+	/* Configure M88E1512 errata registers */
+	for (i = 0; i < ARRAY_SIZE(errata_vals); i++) {
+		ret = pdata->phy_if.phy_impl.write(pdata, mdio_addr,
+				AXGBE_M88E1512_CFG_REG_2,
+				errata_vals[i].reg17);
+		if (ret)
+			return ret;
+
+		ret = pdata->phy_if.phy_impl.write(pdata, mdio_addr,
+				AXGBE_M88E1512_CFG_REG_1,
+				errata_vals[i].reg16);
+		if (ret)
+			return ret;
+	}
+
+	/* Switch to PHY page 0xFB */
+	ret = axgbe_m88e5112_set_page(pdata, 0xfb);
+	if (ret)
+		return ret;
+
+	ret = pdata->phy_if.phy_impl.write(pdata, mdio_addr,
+			AXGBE_M88E1512_CFG_REG_3, 0xC00D);
+	if (ret)
+		return ret;
+
+	/* Switch to PHY page 0 */
+	ret = axgbe_m88e5112_set_page(pdata, 0);
+	if (ret)
+		return ret;
+
+	/* SGMII-to-Copper mode initialization */
+
+	/* Switch to PHY page 0x12 */
+	ret = axgbe_m88e5112_set_page(pdata, 0x12);
+	if (ret)
+		return ret;
+
+	ret = pdata->phy_if.phy_impl.write(pdata, mdio_addr,
+			AXGBE_M88E1512_MODE, 0x8001);
+	if (ret)
+		return ret;
+
+	/* Switch to PHY page 0 */
+	ret = axgbe_m88e5112_set_page(pdata, 0);
+	if (ret)
+		return ret;
+
+	ret = axgbe_phy_soft_reset(pdata);
+	if (ret)
+		return ret;
+
+	rte_delay_ms(1000);
+
+
+	/* Switch to PHY page 3 */
+	ret = axgbe_m88e5112_set_page(pdata, 3);
+	if (ret)
+		return ret;
+
+	/* enable downshift */
+	ret = pdata->phy_if.phy_impl.write(pdata, mdio_addr,
+			AXGBE_M88E1512_SCR, 0x1177);
+	if (ret)
+		return ret;
+
+
+	/* Switch to PHY page 0 */
+	ret = axgbe_m88e5112_set_page(pdata, 0);
+	if (ret)
+		return ret;
+
+	ret = axgbe_phy_soft_reset(pdata);
+	if (ret)
+		return ret;
+
+	rte_delay_ms(1000);
+
+	PMD_DRV_LOG_LINE(DEBUG, "M88E1512 phy init done");
+	return 0;
+}
+
+
+static int axgbe_get_ext_phy_link_status(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned int mdio_addr = phy_data->mdio_addr;
+	int status = 0, bmcr;
+
+	bmcr = pdata->phy_if.phy_impl.read(pdata, mdio_addr, MII_BMCR);
+	if (bmcr < 0)
+		return bmcr;
+
+	/* Autoneg is being started, therefore disregard BMSR value and
+	 * report link as down.
+	 */
+	if (bmcr & BMCR_ANRESTART)
+		return 0;
+
+	status = pdata->phy_if.phy_impl.read(pdata, mdio_addr, MII_BMSR);
+	if (status < 0)
+		return status;
+	else if (status & BMSR_LSTATUS)
+		goto done;
+
+	/* Read link and autonegotiation status */
+	status = pdata->phy_if.phy_impl.read(pdata, mdio_addr, MII_BMSR);
+	if (status < 0)
+		return status;
+done:
+	return (status & BMSR_LSTATUS) ? 1 : 0;
+}
+
 static int axgbe_phy_init(struct axgbe_port *pdata)
 {
 	struct axgbe_phy_data *phy_data;
@@ -2542,6 +2785,16 @@ static int axgbe_phy_init(struct axgbe_port *pdata)
 	}
 
 	phy_data->phy_cdr_delay = AXGBE_CDR_DELAY_INIT;
+
+	pdata->phy.id = axgbe_get_phy_id(pdata);
+	PMD_DRV_LOG_LINE(DEBUG, "PHY ID = 0x%x", pdata->phy.id);
+
+	if (pdata->phy.id == M88E1512_E_PHY_ID) {
+		ret = axgbe_m88e1512_init(pdata);
+		if(ret)
+			return ret;
+	}
+
 	return 0;
 }
 void axgbe_init_function_ptrs_phy_v2(struct axgbe_phy_if *phy_if)
-- 
2.34.1

