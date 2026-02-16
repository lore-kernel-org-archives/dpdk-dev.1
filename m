Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F3EF48C9
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 08:56:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A864640289;
	Mon, 16 Feb 2026 09:56:44 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34]) by mails.dpdk.org (Postfix) with ESMTP id 4E5DF40269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 09:56:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0NmeV20SCfPvFMXrDpEKPUvMWOG6BPrQih3aGPw0osNk4VpqOHzQTQfpJLmOY8xVqDqea+b3VN+ovwcyylba7kXOnlEdsmYh4763v+Q33LurQ/uCK7DZSMon3XpmbcCkhhe/a4Ra5LcIfsBDtq+qm5Sqa1sqqcBbQs40DADbtb90vQWvlURNQKZSEu4QWglJsmaHBNYF74R8YQR3uXKua0Gs2jKlg93GQ1giEQ9VxrFcZKlzmVLqyE6Ht6Ny+pcYsKyxHs9r094397typCAO0GjwbsR1EYyYRgwOhQPWfHioxOzX/WGXzRcoPsIDhDfweVPMjWG5fY/vc4Qfd837A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtKvN8FNArYooIic8/2MTPKVm66ykzvrzZPordrnl94=;
 b=LPQmP7ISm2IpYK8oLV3RW9orxvzJciBNkDy6FfXDKi6Wt+zojkAbvXdldM67nxcRp2GfIDUg1j9VenFXzUklY02Dw0QbUcSLuu/1NbJkq1gn7XRF+iMF0KulgMlf0tic8C/X4Ay9FVCL5CrJR0ICzKdzFfsnMa9xBmdXup0ieh9xsxr72Zj2HaAzh+dxQ/cSKDeUXGbYtemGOuK/pc4CaqmqDzHO4/eHKsQmqTowhVR3C/9nzHBRwalXtyivbvK5wTPWKdMEZSKLJpf98nY3A0O0ny4rHvIO5qn+M5K6sGJ7QXbiC8N//JZyfeSYV5T/Ye7l+gp6J2HgZIx14ftfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtKvN8FNArYooIic8/2MTPKVm66ykzvrzZPordrnl94=;
 b=mA1buZBCfaCmxlPp3/vtqpvY2Rb1RAyjvhZo1S1xWib6GPh54MIbftRocZ6Kn/SiB3sck4lrGMWbwjcQeoIQM627XHTT60uYEXdnUzsqXB5vQaILxA/wIYivh3zNKtQByc/kAFfPuwRVQJnLqYBDkjOdTzYb2HQnmeJcAhllsVs=
Received: from DS7PR03CA0288.namprd03.prod.outlook.com (2603:10b6:5:3ad::23)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:56:37 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::47) by DS7PR03CA0288.outlook.office365.com
 (2603:10b6:5:3ad::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Mon,
 16 Feb 2026 08:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 08:56:37 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 02:56:35 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH] net/axgbe: added marvel m88e1512 PHY support
Date: Mon, 16 Feb 2026 14:24:31 +0530
Message-ID: <20260216085431.972-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 03508111-17f4-40c3-8091-08de6d394afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zzf3wMjYZLvj7DvQFce50936F6by9zjSrf/OqKXrTPqcrjZy7Ehyie4ea+pk?=
 =?us-ascii?Q?X+lqL7pZetu6kWHdwSOZjo0YV37F21mtbhC51yiX3NOIcatxuAMpXr0X9Vca?=
 =?us-ascii?Q?n1Uvj1QnaTlwnhzRbdneWKXfj/N1wxgYBwNdlpla3pxh0vZMOWyGPtpP23Dk?=
 =?us-ascii?Q?x4AW7qD004Hrjqs24+5f+4N+krJjKzwuuz5SoVLY1zd+BizRGkzRFD78gmBW?=
 =?us-ascii?Q?XIZn3hNChxvDLBfZDBEyAg4vstFigg4A1/WV0WQQireaYGawdqxNAAxWtfA1?=
 =?us-ascii?Q?JzIyfwPckKNX5D1NrHjja0E2kUKI7xVk4JUzfHysxtzRG7/Dh+ReXcDT7fgO?=
 =?us-ascii?Q?5jRZGokim4KCSNws5xtrRZ6ixJHji6WzHjd3+zhDBQFixrfJv6LiU58UFxkQ?=
 =?us-ascii?Q?kGwrqRNEYcxnC/DRAMbwC4hZ4X04MF3jo9hpRboldVOYMXKN+xNxc7iibkHW?=
 =?us-ascii?Q?bCQJLss+d7e5nvvavQPHPFYTRoCRBwqKoTyEsJPeraH/nT7+0YEnUO6Bx/R8?=
 =?us-ascii?Q?uBBdGvCX/aPVCAQvCEuyLx/wX8eFDHqAqdTFjIslkMfXJAZS/pW1PoUoXcnb?=
 =?us-ascii?Q?2tvYCaZCn+1vRdiF1pu1H3I10V+e7Dwr1howEcfRGRO6PBgmu+uP1XPLSHF5?=
 =?us-ascii?Q?+ccLTN5noGTYWtKkCsz7eaxyFN3+XvzMBx3Dn817sa2Umv1WxYhUgVk+2k34?=
 =?us-ascii?Q?hl70B0Lp3KksfhrIDRsv33k7L2HwiMEsaMwfcRmYolbiT5YY7eoIh9cHn9dK?=
 =?us-ascii?Q?y2aw6w7K6AwQe+aoY1Z7/TVV+JidJjJ60yaSJyGwfbh7FZ7wmuwJasfTuDif?=
 =?us-ascii?Q?Ax3d5fvAlGACE23/EmwKl7kD/nnGmXCdW1Dye2kKMZ+wkNJVEUMNd/QwG2Pn?=
 =?us-ascii?Q?Ngxm/8c+efdekZI3Hz49EMnJI1HitjHy0MREWD27EThARF94xQitzJbGDHzo?=
 =?us-ascii?Q?RTrD25WWVjSuGe/pHW3wkwnvHN58uFg8AfMLtMZZL5uFDYjlgJWEu1eqbs1I?=
 =?us-ascii?Q?6Bnt1/7CUD/WcFmtK6uBj3a+cheHrB8nuOxlUbfS5QYp9NvcDhc0FU1PYuR6?=
 =?us-ascii?Q?f8BhP/jSMIGQoAbH1ZaGN33JiYvwwIDNqQKN+PvPjMEQJrraFl1cXW7+tdfG?=
 =?us-ascii?Q?jISPhHiYmxRQLUS0jp3Dl4W+KqLkMoTfn+EOlBjQej3g9tyDMPxz3umrFfmq?=
 =?us-ascii?Q?HGPRksWtg5WOxIo68QcT/75MmbKEwJGJ21a1QvzxxY0jyl964PJ2rps1nOh7?=
 =?us-ascii?Q?vdoyOeeerRSHi/D/vM2uWKZWRoF8LwthHUXaq+Aeoj/gnXtQhglQAQa6a8mt?=
 =?us-ascii?Q?P+u5XAdrAuXqjK+cyGgfUzUnV2/m1cO0Vtfm2yWc6ThNBYDmanPzJH7LhN7w?=
 =?us-ascii?Q?E3vSwpMECVYuWxhW1VZffDD1kbaTORnSJiRI2C5doFcxQUdbrXDm/LdIZJBb?=
 =?us-ascii?Q?SvtTTvi7M9X85RK8NjRx/L6mKUZMtFDX4MKsT51kX7SCdMX0ugcvnPFulM+p?=
 =?us-ascii?Q?ZEbgTuQBqf1l5qNOYXuwH8T1tPFkQgcjICf6J47v3kOEFslN13Sqa+OxgHrU?=
 =?us-ascii?Q?1a7IhKtEhpI/CkigAnMI0pyiM4UzGvh86+xKb0NdGFUw3BuA4Z1zFtiLmRMz?=
 =?us-ascii?Q?ms3AFPGcd/9zk7ViIkz8VcF+c9GWR+Yyg1OQQQDIalJhU7RlMRIVKmEFC3Rj?=
 =?us-ascii?Q?wCaKTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8uXpYR6j2/tQ9DR0OKSCTkcxHkgQllQAeeYwpHP7ZGb6+cC5v5Y/bB1HqyOCjbIiGTBg5FpMEa7bC8EfspSHOV3QCoFsyJEj1DCeVIKm9AvfuxWcUwlTRsUyZ/iSDDJIuKRWxL6fOYEhzMwQp7JLf29Biitqtz2YEWV6rr3REcxK6an0uV6zIBij8uLNPxiyrJCblkaotWgRMYYFSdKrQ6+U29wCYXy+2JqJAdDRZRPdGDfGpCWmLkyhXfRMhhCk8zyibzbo1bMLULVA9KZZ1XOWVZR3CKwZQNtKDYFXU/h2Mf2pW1c0V1HpSFdhj0XutLojj9hWg+t2F8M1xgjp7kz/doqJCzJtCxSTvc+Z/pdQBdX0Pt1MhXpfxJdafSU9zVHkyXuZD9EkCKDokIGkGCskPOg311njYqTglU+gC3wiKxLRD1rUtQUmMuDGXizL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:56:37.1077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03508111-17f4-40c3-8091-08de6d394afd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
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

Added marvel m88e1512 1G PHY support in amd axgbe driver

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 .mailmap                           |   1 +
 drivers/net/axgbe/axgbe_ethdev.h   |   4 +
 drivers/net/axgbe/axgbe_mdio.c     |   4 +-
 drivers/net/axgbe/axgbe_phy.h      |  32 +++
 drivers/net/axgbe/axgbe_phy_impl.c | 309 ++++++++++++++++++++++++++++-
 5 files changed, 343 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 8bbfcc1703..6f951bcd92 100644
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
diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_ethdev.h
index b94a7f3562..3a9dc81691 100644
--- a/drivers/net/axgbe/axgbe_ethdev.h
+++ b/drivers/net/axgbe/axgbe_ethdev.h
@@ -276,6 +276,7 @@ struct axgbe_phy {
 	int pause_autoneg;
 	int tx_pause;
 	int rx_pause;
+	int id;
 };
 
 enum axgbe_i2c_cmd {
@@ -398,6 +399,9 @@ struct axgbe_phy_impl_if {
 	/* Pre/Post KR training enablement support */
 	void (*kr_training_pre)(struct axgbe_port *);
 	void (*kr_training_post)(struct axgbe_port *);
+
+	int (*read)(struct axgbe_port *port, int addr, int reg);
+	int (*write)(struct axgbe_port *port, int addr, int reg, u16 val);
 };
 
 struct axgbe_phy_if {
diff --git a/drivers/net/axgbe/axgbe_mdio.c b/drivers/net/axgbe/axgbe_mdio.c
index 952a0add62..a37cd8b80d 100644
--- a/drivers/net/axgbe/axgbe_mdio.c
+++ b/drivers/net/axgbe/axgbe_mdio.c
@@ -155,8 +155,8 @@ static void axgbe_sgmii_10_mode(struct axgbe_port *pdata)
 static void axgbe_sgmii_100_mode(struct axgbe_port *pdata)
 {
 
-	/* Set MAC to 1G speed */
-	pdata->hw_if.set_speed(pdata, SPEED_1000);
+	/* Set MAC to 100M speed */
+	pdata->hw_if.set_speed(pdata, SPEED_100);
 
 	/* Call PHY implementation support to complete rate change */
 	pdata->phy_if.phy_impl.set_mode(pdata, AXGBE_MODE_SGMII_100);
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
index 9249e11335..96773dd722 100644
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
@@ -250,7 +252,11 @@ static enum axgbe_an_mode axgbe_phy_an_mode(struct axgbe_port *pdata);
 static void axgbe_phy_perform_ratechange(struct axgbe_port *pdata,
 		enum axgbe_mb_cmd cmd, enum axgbe_mb_subcmd sub_cmd);
 static void axgbe_phy_rrc(struct axgbe_port *pdata);
+static int axgbe_get_ext_phy_link_status(struct axgbe_port *pdata);
 
+static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata);
+static void axgbe_phy_put_comm_ownership(struct axgbe_port *pdata);
+static int axgbe_m88e1512_config_aneg(struct axgbe_port *pdata);
 
 static int axgbe_phy_i2c_xfer(struct axgbe_port *pdata,
 			      struct axgbe_i2c_op *i2c_op)
@@ -258,6 +264,29 @@ static int axgbe_phy_i2c_xfer(struct axgbe_port *pdata,
 	return pdata->i2c_if.i2c_xfer(pdata, i2c_op);
 }
 
+static int axgbe_phy_mii_read_c22(struct axgbe_port *pdata, int addr, int reg)
+{
+	int ret, regval;
+	ret = axgbe_phy_get_comm_ownership(pdata);
+	if (ret)
+		return -1;
+	regval = pdata->hw_if.read_ext_mii_regs_c22(pdata, addr, reg);
+	axgbe_phy_put_comm_ownership(pdata);
+	return regval;
+}
+
+static int axgbe_phy_mii_write_c22(struct axgbe_port *pdata, int addr,
+		int reg, u16 val)
+{
+	int ret, regval;
+	ret = axgbe_phy_get_comm_ownership(pdata);
+	if (ret)
+		return -1;
+	regval = pdata->hw_if.write_ext_mii_regs_c22(pdata, addr, reg, val);
+	axgbe_phy_put_comm_ownership(pdata);
+	return regval;
+}
+
 static int axgbe_phy_redrv_write(struct axgbe_port *pdata, unsigned int reg,
 				 unsigned int val)
 {
@@ -1090,12 +1119,17 @@ static unsigned int axgbe_phy_an_advertising(struct axgbe_port *pdata)
 	return advertising;
 }
 
-static int axgbe_phy_an_config(struct axgbe_port *pdata __rte_unused)
+static int axgbe_phy_an_config(struct axgbe_port *pdata)
 {
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+
+	if (phy_data->port_mode != AXGBE_PORT_MODE_1000BASE_T)
+		return 0;
+
+	if (pdata->phy.id == M88E1512_E_PHY_ID)
+		axgbe_m88e1512_config_aneg(pdata);
+
 	return 0;
-	/* Dummy API since there is no case to support
-	 * external phy devices registered through kernel APIs
-	 */
 }
 
 static enum axgbe_an_mode axgbe_phy_an_sfp_mode(struct axgbe_phy_data *phy_data)
@@ -1207,6 +1241,7 @@ static void axgbe_set_rx_adap_mode(struct axgbe_port *pdata,
 {
 	if (pdata->rx_adapt_retries++ >= MAX_RX_ADAPT_RETRIES) {
 		pdata->rx_adapt_retries = 0;
+		pdata->mode_set = false;
 		return;
 	}
 
@@ -1497,6 +1532,18 @@ static void axgbe_phy_sgmii_1000_mode(struct axgbe_port *pdata)
 	phy_data->cur_mode = AXGBE_MODE_SGMII_1000;
 }
 
+static void axgbe_phy_sgmii_100_mode(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+
+	axgbe_phy_set_redrv_mode(pdata);
+
+	/* 100M/SGMII */
+	axgbe_phy_perform_ratechange(pdata, AXGBE_MB_CMD_SET_1G, AXGBE_MB_SUBCMD_100MBITS);
+
+	phy_data->cur_mode = AXGBE_MODE_SGMII_100;
+}
+
 static void axgbe_phy_sgmii_10_mode(struct axgbe_port *pdata)
 {
 	struct axgbe_phy_data *phy_data = pdata->phy_data;
@@ -1694,6 +1741,9 @@ static void axgbe_phy_set_mode(struct axgbe_port *pdata, enum axgbe_mode mode)
 	case AXGBE_MODE_SGMII_1000:
 		axgbe_phy_sgmii_1000_mode(pdata);
 		break;
+	case AXGBE_MODE_SGMII_100:
+		axgbe_phy_sgmii_100_mode(pdata);
+		break;
 	case AXGBE_MODE_SGMII_10:
 		axgbe_phy_sgmii_10_mode(pdata);
 		break;
@@ -1863,6 +1913,17 @@ static int axgbe_phy_link_status(struct axgbe_port *pdata, int *an_restart)
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
@@ -1905,7 +1966,8 @@ static int axgbe_phy_link_status(struct axgbe_port *pdata, int *an_restart)
 		phy_data->rrc_count = 0;
 		axgbe_phy_rrc(pdata);
 	}
-
+out:
+	pdata->rx_adapt_done = false;
 	return 0;
 }
 
@@ -2263,6 +2325,226 @@ static int axgbe_phy_reset(struct axgbe_port *pdata)
 	return 0;
 }
 
+static int axgbe_m88e5112_set_page(struct axgbe_port *pdata, int page)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned int mdio_addr = phy_data->mdio_addr;
+	return pdata->phy_if.phy_impl.write(pdata, mdio_addr,
+			AXGBE_M88E1512_PAGE_ADDR, page);
+}
+
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
+static int axgbe_m88e1512_soft_reset(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned int mdio_addr = phy_data->mdio_addr;
+	int bmcr;
+	int ret;
+
+	bmcr = pdata->phy_if.phy_impl.read(pdata, mdio_addr, MII_BMCR);
+	if (bmcr == -1)
+		goto out;
+	bmcr |= BMCR_RESET;
+	ret = pdata->phy_if.phy_impl.write(pdata, mdio_addr, MII_BMCR, bmcr);
+	if (ret)
+		return ret;
+
+	rte_delay_us_sleep(1);
+out:
+	return ret;
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
+	ret = axgbe_m88e1512_soft_reset(pdata);
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
+	ret = axgbe_m88e1512_soft_reset(pdata);
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
@@ -2292,6 +2574,12 @@ static int axgbe_phy_init(struct axgbe_port *pdata)
 	phy_data->conn_type = XP_GET_BITS(pdata->pp0, XP_PROP_0, CONN_TYPE);
 	phy_data->mdio_addr = XP_GET_BITS(pdata->pp0, XP_PROP_0, MDIO_ADDR);
 
+	PMD_DRV_LOG_LINE(DEBUG, "port mode  : %d", phy_data->port_mode);
+	PMD_DRV_LOG_LINE(DEBUG, "port id    : %d", phy_data->port_id);
+	PMD_DRV_LOG_LINE(DEBUG, "port speed : %d", phy_data->port_speeds);
+	PMD_DRV_LOG_LINE(DEBUG, "conn type  : %d", phy_data->conn_type);
+	PMD_DRV_LOG_LINE(DEBUG, "mdio addr  : %d", phy_data->mdio_addr);
+
 	phy_data->redrv = XP_GET_BITS(pdata->pp4, XP_PROP_4, REDRV_PRESENT);
 	phy_data->redrv_if = XP_GET_BITS(pdata->pp4, XP_PROP_4, REDRV_IF);
 	phy_data->redrv_addr = XP_GET_BITS(pdata->pp4, XP_PROP_4, REDRV_ADDR);
@@ -2516,8 +2804,16 @@ static int axgbe_phy_init(struct axgbe_port *pdata)
 	}
 
 	phy_data->phy_cdr_delay = AXGBE_CDR_DELAY_INIT;
+
+	pdata->phy.id = axgbe_get_phy_id(pdata);
+	PMD_DRV_LOG_LINE(DEBUG, "PHY ID = 0x%x", pdata->phy.id);
+
+	if (pdata->phy.id == M88E1512_E_PHY_ID)
+		axgbe_m88e1512_init(pdata);
+
 	return 0;
 }
+
 void axgbe_init_function_ptrs_phy_v2(struct axgbe_phy_if *phy_if)
 {
 	struct axgbe_phy_impl_if *phy_impl = &phy_if->phy_impl;
@@ -2542,4 +2838,7 @@ void axgbe_init_function_ptrs_phy_v2(struct axgbe_phy_if *phy_if)
 
 	phy_impl->kr_training_pre	= axgbe_phy_kr_training_pre;
 	phy_impl->kr_training_post	= axgbe_phy_kr_training_post;
+
+	phy_impl->read			= axgbe_phy_mii_read_c22;
+	phy_impl->write			= axgbe_phy_mii_write_c22;
 }
-- 
2.34.1

