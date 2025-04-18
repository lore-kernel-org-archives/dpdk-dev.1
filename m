Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D6CC369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 03:26:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99A30400D6;
	Fri, 18 Apr 2025 05:26:24 +0200 (CEST)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by mails.dpdk.org (Postfix) with ESMTP id 97532400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 05:26:22 +0200 (CEST)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn7GhcxgFod2I_Fw--.12606S2;
 Fri, 18 Apr 2025 11:26:20 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwA3hSRUxgFoRUcBAA--.1716S3;
 Fri, 18 Apr 2025 11:26:12 +0800 (CST)
From: Wencheng Li <liwencheng@phytium.com.cn>
To: dev@dpdk.org
Subject: [PATCH v7 1/3] net/macb: add new poll mode driver
Date: Fri, 18 Apr 2025 03:25:30 +0000
Message-Id: <1744946730-31821-1-git-send-email-liwencheng@phytium.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1744093201-313699-1-git-send-email-liwencheng@phytium.com.cn>
References: <1744093201-313699-1-git-send-email-liwencheng@phytium.com.cn>
X-CM-TRANSID: AQAAfwA3hSRUxgFoRUcBAA--.1716S3
X-CM-SenderInfo: polzv0xfkh0wo6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=liwencheng
 @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWDtw1DuFW8tFy7AFy7ZF1fZwb_yoWDWry5Wo
 WxJF13J348uwn7Cr4vgw13X3WDua1DZw1UA3ykXrW8Za47tr909r4fJrWFqry5KryjgF1r
 G3W8K3sxA34Fvrn8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
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

add MACB PMD driver for Phytium NIC.

v7:
* Use a legal name instead of an email alias.
* Do not use additional __rte_cold.
* Replace unsigned long with standard uint64_t.

Signed-off-by: Wencheng Li <liwencheng@phytium.com.cn>
---
 .mailmap                            |    1 +
 drivers/net/macb/base/generic_phy.c |  271 +++++
 drivers/net/macb/base/generic_phy.h |  202 ++++
 drivers/net/macb/base/macb_common.c |  670 +++++++++++++
 drivers/net/macb/base/macb_common.h |  253 +++++
 drivers/net/macb/base/macb_errno.h  |   58 ++
 drivers/net/macb/base/macb_hw.h     | 1138 +++++++++++++++++++++
 drivers/net/macb/base/macb_type.h   |   23 +
 drivers/net/macb/base/macb_uio.c    |  351 +++++++
 drivers/net/macb/base/macb_uio.h    |   50 +
 drivers/net/macb/base/meson.build   |   25 +
 drivers/net/macb/macb_ethdev.c      | 1861 +++++++++++++++++++++++++++++++++++
 drivers/net/macb/macb_ethdev.h      |   91 ++
 drivers/net/macb/macb_log.h         |   19 +
 drivers/net/macb/macb_rxtx.c        | 1391 ++++++++++++++++++++++++++
 drivers/net/macb/macb_rxtx.h        |  325 ++++++
 drivers/net/macb/meson.build        |   18 +
 drivers/net/meson.build             |    1 +
 18 files changed, 6748 insertions(+)
 create mode 100644 drivers/net/macb/base/generic_phy.c
 create mode 100644 drivers/net/macb/base/generic_phy.h
 create mode 100644 drivers/net/macb/base/macb_common.c
 create mode 100644 drivers/net/macb/base/macb_common.h
 create mode 100644 drivers/net/macb/base/macb_errno.h
 create mode 100644 drivers/net/macb/base/macb_hw.h
 create mode 100644 drivers/net/macb/base/macb_type.h
 create mode 100644 drivers/net/macb/base/macb_uio.c
 create mode 100644 drivers/net/macb/base/macb_uio.h
 create mode 100644 drivers/net/macb/base/meson.build
 create mode 100644 drivers/net/macb/macb_ethdev.c
 create mode 100644 drivers/net/macb/macb_ethdev.h
 create mode 100644 drivers/net/macb/macb_log.h
 create mode 100644 drivers/net/macb/macb_rxtx.c
 create mode 100644 drivers/net/macb/macb_rxtx.h
 create mode 100644 drivers/net/macb/meson.build

diff --git a/.mailmap b/.mailmap
index d8439b7..8ca89c9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1676,6 +1676,7 @@ Wen-Chi Yang <wolkayang@gmail.com>
 Wenfeng Liu <liuwf@arraynetworks.com.cn>
 Wenjie Li <wenjiex.a.li@intel.com>
 Wenjie Sun <findtheonlyway@gmail.com>
+Wencheng Li <liwencheng@phytium.com.cn>
 Wenjing Qiao <wenjing.qiao@intel.com>
 Wenjun Wu <wenjun1.wu@intel.com>
 Wentao Cui <wentaoc@mellanox.com>
diff --git a/drivers/net/macb/base/generic_phy.c b/drivers/net/macb/base/generic_phy.c
new file mode 100644
index 0000000..8349963
--- /dev/null
+++ b/drivers/net/macb/base/generic_phy.c
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#include "generic_phy.h"
+#include "macb_hw.h"
+
+static uint32_t genphy_get_an(struct macb *bp, uint16_t phyad, u16 addr)
+{
+	int advert;
+
+	advert = macb_mdio_read(bp, phyad, addr);
+
+	return genphy_lpa_to_ethtool_lpa_t(advert);
+}
+
+static int phy_poll_reset(struct phy_device *phydev)
+{
+	struct macb *bp = phydev->bp;
+	uint32_t retries = 12;
+	int32_t ret;
+	uint16_t phyad = phydev->phyad;
+
+	do {
+		rte_delay_ms(50);
+		ret = macb_mdio_read(bp, phyad, GENERIC_PHY_BMCR);
+		if (ret < 0)
+			return ret;
+	} while (ret & BMCR_RESET && --retries);
+	if (ret & BMCR_RESET)
+		return -ETIMEDOUT;
+
+	rte_delay_ms(1);
+	return 0;
+}
+
+int genphy_soft_reset(struct phy_device *phydev)
+{
+	struct macb *bp = phydev->bp;
+	uint32_t ctrl;
+	uint16_t phyad = phydev->phyad;
+
+	/* soft reset phy */
+	ctrl = macb_mdio_read(bp, phyad, GENERIC_PHY_BMCR);
+	ctrl |= BMCR_RESET;
+	macb_mdio_write(bp, phyad, GENERIC_PHY_BMCR, ctrl);
+
+	return phy_poll_reset(phydev);
+}
+
+int genphy_resume(struct phy_device *phydev)
+{
+	struct macb *bp = phydev->bp;
+	uint32_t ctrl;
+	uint16_t phyad = phydev->phyad;
+
+	/* phy power up */
+	ctrl = macb_mdio_read(bp, phyad, GENERIC_PHY_BMCR);
+	ctrl &= ~BMCR_PDOWN;
+	macb_mdio_write(bp, phyad, GENERIC_PHY_BMCR, ctrl);
+	rte_delay_ms(100);
+	return 0;
+}
+
+void genphy_suspend(struct phy_device *phydev)
+{
+	struct macb *bp = phydev->bp;
+	uint32_t ctrl;
+	uint16_t phyad = phydev->phyad;
+
+	/* phy power down */
+	ctrl = macb_mdio_read(bp, phyad, GENERIC_PHY_BMCR);
+	ctrl |= BMCR_PDOWN;
+	macb_mdio_write(bp, phyad, GENERIC_PHY_BMCR, ctrl);
+}
+
+int genphy_force_speed_duplex(struct phy_device *phydev)
+{
+	struct macb *bp = phydev->bp;
+	uint32_t ctrl;
+	uint16_t phyad = phydev->phyad;
+
+	if (bp->autoneg) {
+		ctrl = macb_mdio_read(bp, phyad, GENERIC_PHY_BMCR);
+		ctrl |= BMCR_ANENABLE;
+		macb_mdio_write(bp, phyad, GENERIC_PHY_BMCR, ctrl);
+		rte_delay_ms(10);
+	} else {
+		/* disable autoneg first */
+		ctrl = macb_mdio_read(bp, phyad, GENERIC_PHY_BMCR);
+		ctrl &= ~BMCR_ANENABLE;
+
+		if (bp->duplex == DUPLEX_FULL)
+			ctrl |= BMCR_FULLDPLX;
+		else
+			ctrl &= ~BMCR_FULLDPLX;
+
+		switch (bp->speed) {
+		case SPEED_10:
+			ctrl &= ~BMCR_SPEED1000;
+			ctrl &= ~BMCR_SPEED100;
+			break;
+		case SPEED_100:
+			ctrl |= BMCR_SPEED100;
+			ctrl &= ~BMCR_SPEED1000;
+			break;
+		case SPEED_1000:
+			ctrl |= BMCR_ANENABLE;
+			bp->autoneg = AUTONEG_ENABLE;
+			break;
+		case SPEED_2500:
+			ctrl |= BMCR_ANENABLE;
+			bp->autoneg = AUTONEG_ENABLE;
+			break;
+		}
+		macb_mdio_write(bp, phyad, GENERIC_PHY_BMCR, ctrl);
+		phydev->autoneg = bp->autoneg;
+		rte_delay_ms(10);
+	}
+
+	return 0;
+}
+
+int genphy_check_for_link(struct phy_device *phydev)
+{
+	struct macb *bp = phydev->bp;
+	int bmsr;
+
+	/* Do a fake read */
+	bmsr = macb_mdio_read(bp, bp->phyad, GENERIC_PHY_BMSR);
+	if (bmsr < 0)
+		return bmsr;
+
+	bmsr = macb_mdio_read(bp, bp->phyad, GENERIC_PHY_BMSR);
+	phydev->link = bmsr & BMSR_LSTATUS;
+
+	return phydev->link;
+}
+
+int genphy_read_status(struct phy_device *phydev)
+{
+	struct macb *bp = phydev->bp;
+	uint16_t bmcr, bmsr, ctrl1000 = 0, stat1000 = 0;
+	uint32_t advertising, lp_advertising;
+	uint32_t nego;
+	uint16_t phyad = phydev->phyad;
+
+	/* Do a fake read */
+	bmsr = macb_mdio_read(bp, phyad, GENERIC_PHY_BMSR);
+
+	bmsr = macb_mdio_read(bp, phyad, GENERIC_PHY_BMSR);
+	bmcr = macb_mdio_read(bp, phyad, GENERIC_PHY_BMCR);
+
+	if (bmcr & BMCR_ANENABLE) {
+		ctrl1000 = macb_mdio_read(bp, phyad, GENERIC_PHY_CTRL1000);
+		stat1000 = macb_mdio_read(bp, phyad, GENERIC_PHY_STAT1000);
+
+		advertising = ADVERTISED_Autoneg;
+		advertising |= genphy_get_an(bp, phyad, GENERIC_PHY_ADVERISE);
+		advertising |= genphy_ctrl1000_to_ethtool_adv_t(ctrl1000);
+
+		if (bmsr & BMSR_ANEGCOMPLETE) {
+			lp_advertising = genphy_get_an(bp, phyad, GENERIC_PHY_LPA);
+			lp_advertising |= genphy_stat1000_to_ethtool_lpa_t(stat1000);
+		} else {
+			lp_advertising = 0;
+		}
+
+		nego = advertising & lp_advertising;
+		if (nego & (ADVERTISED_1000baseT_Full | ADVERTISED_1000baseT_Half)) {
+			phydev->speed = SPEED_1000;
+			phydev->duplex = !!(nego & ADVERTISED_1000baseT_Full);
+		} else if (nego &
+				(ADVERTISED_100baseT_Full | ADVERTISED_100baseT_Half)) {
+			phydev->speed = SPEED_100;
+			phydev->duplex = !!(nego & ADVERTISED_100baseT_Full);
+		} else {
+			phydev->speed = SPEED_10;
+			phydev->duplex = !!(nego & ADVERTISED_10baseT_Full);
+		}
+	} else {
+		phydev->speed = ((bmcr & BMCR_SPEED1000 && (bmcr & BMCR_SPEED100) == 0)
+						 ? SPEED_1000
+						 : ((bmcr & BMCR_SPEED100) ? SPEED_100 : SPEED_10));
+		phydev->duplex = (bmcr & BMCR_FULLDPLX) ? DUPLEX_FULL : DUPLEX_HALF;
+	}
+
+	return 0;
+}
+
+int macb_usxgmii_pcs_resume(struct phy_device *phydev)
+{
+	u32 config;
+	struct macb *bp = phydev->bp;
+
+	config = gem_readl(bp, USX_CONTROL);
+
+	/* enable signal */
+	config &= ~(GEM_BIT(RX_SYNC_RESET));
+	config |= GEM_BIT(SIGNAL_OK) | GEM_BIT(TX_EN);
+	gem_writel(bp, USX_CONTROL, config);
+
+	return 0;
+}
+
+void macb_usxgmii_pcs_suspend(struct phy_device *phydev)
+{
+	uint32_t config;
+	struct macb *bp = phydev->bp;
+
+	config = gem_readl(bp, USX_CONTROL);
+	config |= GEM_BIT(RX_SYNC_RESET);
+	/* disable signal */
+	config &= ~(GEM_BIT(SIGNAL_OK) | GEM_BIT(TX_EN));
+	gem_writel(bp, USX_CONTROL, config);
+	rte_delay_ms(1);
+}
+
+int macb_usxgmii_pcs_check_for_link(struct phy_device *phydev)
+{
+	int link;
+	struct macb *bp = phydev->bp;
+
+	link = (int)GEM_BFEXT(BLOCK_LOCK, gem_readl(bp, USX_STATUS));
+	return link;
+}
+
+int macb_gbe_pcs_check_for_link(struct phy_device *phydev)
+{
+	int link;
+	struct macb *bp = phydev->bp;
+
+	link = (int)MACB_BFEXT(NSR_LINK, macb_readl(bp, NSR));
+	return link;
+}
+
+const struct phy_driver genphy_driver = {
+	.phy_id		= 0xffffffff,
+	.phy_id_mask	= 0xffffffff,
+	.name		= "Generic PHY",
+	.soft_reset	= genphy_soft_reset,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
+	.check_for_link		= genphy_check_for_link,
+	.read_status		= genphy_read_status,
+	.force_speed_duplex = genphy_force_speed_duplex,
+};
+
+const struct phy_driver macb_gbe_pcs_driver = {
+	.phy_id		= 0xffffffff,
+	.phy_id_mask	= 0xffffffff,
+	.name		= "Macb gbe pcs PHY",
+	.soft_reset	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+	.check_for_link		= macb_gbe_pcs_check_for_link,
+	.read_status		= NULL,
+	.force_speed_duplex = NULL,
+};
+
+const struct phy_driver macb_usxgmii_pcs_driver = {
+	.phy_id		= 0xffffffff,
+	.phy_id_mask	= 0xffffffff,
+	.name		= "Macb usxgmii pcs PHY",
+	.soft_reset	= NULL,
+	.suspend	= macb_usxgmii_pcs_suspend,
+	.resume		= macb_usxgmii_pcs_resume,
+	.check_for_link		= macb_usxgmii_pcs_check_for_link,
+	.read_status		= NULL,
+	.force_speed_duplex = NULL,
+};
diff --git a/drivers/net/macb/base/generic_phy.h b/drivers/net/macb/base/generic_phy.h
new file mode 100644
index 0000000..481d83d
--- /dev/null
+++ b/drivers/net/macb/base/generic_phy.h
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#ifndef _GENERIC_PHY_H
+#define _GENERIC_PHY_H
+
+#include "macb_common.h"
+
+/* Or MII_ADDR_C45 into regnum for read/write on mii_bus to enable the 21 bit
+ * IEEE 802.3ae clause 45 addressing mode used by 10GIGE phy chips.
+ */
+#define MII_ADDR_C45		(1 << 30)
+#define MII_DEVADDR_C45_SHIFT	16
+#define MII_REGADDR_C45_MASK	0xffff
+
+/* Generic MII registers. */
+#define GENERIC_PHY_BMCR            0x0
+#define GENERIC_PHY_BMSR            0x1
+#define GENERIC_PHY_PHYSID1         0x2
+#define GENERIC_PHY_PHYSID2         0x3
+#define GENERIC_PHY_ADVERISE        0x4
+#define GENERIC_PHY_LPA				0x5
+#define GENERIC_PHY_CTRL1000        0x9
+#define GENERIC_PHY_STAT1000		0xa
+
+/* Basic mode control register. */
+#define BMCR_RESV		0x003f	/* Unused...                   */
+#define BMCR_SPEED1000		0x0040	/* MSB of Speed (1000)         */
+#define BMCR_CTST		0x0080	/* Collision test              */
+#define BMCR_FULLDPLX		0x0100	/* Full duplex                 */
+#define BMCR_ANRESTART		0x0200	/* Auto negotiation restart    */
+#define BMCR_ISOLATE		0x0400	/* Isolate data paths from MII */
+#define BMCR_PDOWN		0x0800	/* Enable low power state      */
+#define BMCR_ANENABLE		0x1000	/* Enable auto negotiation     */
+#define BMCR_SPEED100		0x2000	/* Select 100Mbps              */
+#define BMCR_LOOPBACK		0x4000	/* TXD loopback bits           */
+#define BMCR_RESET		0x8000	/* Reset to default state      */
+#define BMCR_SPEED10		0x0000	/* Select 10Mbps               */
+
+/* Basic mode status register. */
+#define BMSR_ERCAP		0x0001	/* Ext-reg capability          */
+#define BMSR_JCD		0x0002	/* Jabber detected             */
+#define BMSR_LSTATUS		0x0004	/* Link status                 */
+#define BMSR_ANEGCAPABLE	0x0008	/* Able to do auto-negotiation */
+#define BMSR_RFAULT		0x0010	/* Remote fault detected       */
+#define BMSR_ANEGCOMPLETE	0x0020	/* Auto-negotiation complete   */
+#define BMSR_RESV		0x00c0	/* Unused...                   */
+#define BMSR_ESTATEN		0x0100	/* Extended Status in R15      */
+#define BMSR_100HALF2		0x0200	/* Can do 100BASE-T2 HDX       */
+#define BMSR_100FULL2		0x0400	/* Can do 100BASE-T2 FDX       */
+#define BMSR_10HALF		0x0800	/* Can do 10mbps, half-duplex  */
+#define BMSR_10FULL		0x1000	/* Can do 10mbps, full-duplex  */
+#define BMSR_100HALF		0x2000	/* Can do 100mbps, half-duplex */
+#define BMSR_100FULL		0x4000	/* Can do 100mbps, full-duplex */
+#define BMSR_100BASE4		0x8000	/* Can do 100mbps, 4k packets  */
+
+/* Advertisement control register. */
+#define ADVERTISE_SLCT		0x001f	/* Selector bits               */
+#define ADVERTISE_CSMA		0x0001	/* Only selector supported     */
+#define ADVERTISE_10HALF	0x0020	/* Try for 10mbps half-duplex  */
+#define ADVERTISE_1000XFULL	0x0020	/* Try for 1000BASE-X full-duplex */
+#define ADVERTISE_10FULL	0x0040	/* Try for 10mbps full-duplex  */
+#define ADVERTISE_1000XHALF	0x0040	/* Try for 1000BASE-X half-duplex */
+#define ADVERTISE_100HALF	0x0080	/* Try for 100mbps half-duplex */
+#define ADVERTISE_1000XPAUSE	0x0080	/* Try for 1000BASE-X pause    */
+#define ADVERTISE_100FULL	0x0100	/* Try for 100mbps full-duplex */
+#define ADVERTISE_1000XPSE_ASYM	0x0100	/* Try for 1000BASE-X asym pause */
+#define ADVERTISE_100BASE4	0x0200	/* Try for 100mbps 4k packets  */
+#define ADVERTISE_PAUSE_CAP	0x0400	/* Try for pause               */
+#define ADVERTISE_PAUSE_ASYM	0x0800	/* Try for asymmetric pause     */
+#define ADVERTISE_RESV		0x1000	/* Unused...                   */
+#define ADVERTISE_RFAULT	0x2000	/* Say we can detect faults    */
+#define ADVERTISE_LPACK		0x4000	/* Ack link partners response  */
+#define ADVERTISE_NPAGE		0x8000	/* Next page bit               */
+
+/* Link partner ability register. */
+#define LPA_SLCT		0x001f	/* Same as advertise selector  */
+#define LPA_10HALF		0x0020	/* Can do 10mbps half-duplex   */
+#define LPA_1000XFULL		0x0020	/* Can do 1000BASE-X full-duplex */
+#define LPA_10FULL		0x0040	/* Can do 10mbps full-duplex   */
+#define LPA_1000XHALF		0x0040	/* Can do 1000BASE-X half-duplex */
+#define LPA_100HALF		0x0080	/* Can do 100mbps half-duplex  */
+#define LPA_1000XPAUSE		0x0080	/* Can do 1000BASE-X pause     */
+#define LPA_100FULL		0x0100	/* Can do 100mbps full-duplex  */
+#define LPA_1000XPAUSE_ASYM	0x0100	/* Can do 1000BASE-X pause asym*/
+#define LPA_100BASE4		0x0200	/* Can do 100mbps 4k packets   */
+#define LPA_PAUSE_CAP		0x0400	/* Can pause                   */
+#define LPA_PAUSE_ASYM		0x0800	/* Can pause asymmetrically     */
+#define LPA_RESV		0x1000	/* Unused...                   */
+#define LPA_RFAULT		0x2000	/* Link partner faulted        */
+#define LPA_LPACK		0x4000	/* Link partner acked us       */
+#define LPA_NPAGE		0x8000	/* Next page bit               */
+
+/* 1000BASE-T Control register */
+#define ADVERTISE_1000FULL	0x0200  /* Advertise 1000BASE-T full duplex */
+#define ADVERTISE_1000HALF	0x0100  /* Advertise 1000BASE-T half duplex */
+#define CTL1000_AS_MASTER	0x0800
+#define CTL1000_ENABLE_MASTER	0x1000
+
+/* 1000BASE-T Status register */
+#define LPA_1000MSFAIL		0x8000	/* Primary/Secondary resolution failure */
+#define LPA_1000LOCALRXOK	0x2000	/* Link partner local receiver status */
+#define LPA_1000REMRXOK		0x1000	/* Link partner remote receiver status */
+#define LPA_1000FULL		0x0800	/* Link partner 1000BASE-T full duplex */
+#define LPA_1000HALF		0x0400	/* Link partner 1000BASE-T half duplex */
+
+struct phy_device {
+	struct macb *bp;
+	struct phy_driver *drv;
+	uint32_t phy_id;
+	uint16_t phyad;
+	uint32_t speed;
+	uint16_t link;
+	uint16_t duplex;
+	uint16_t autoneg;
+	void *priv;
+};
+
+struct phy_driver {
+	const char *name;
+	uint32_t phy_id;
+	uint32_t phy_id_mask;
+
+	int (*config_init)(struct phy_device *phydev);
+	int (*soft_reset)(struct phy_device *phydev);
+	int (*probe)(struct phy_device *phydev);
+	int (*resume)(struct phy_device *phydev);
+	void (*suspend)(struct phy_device *phydev);
+	int (*check_for_link)(struct phy_device *phydev);
+	int (*read_status)(struct phy_device *phydev);
+	int (*force_speed_duplex)(struct phy_device *phydev);
+};
+
+static inline uint32_t genphy_adv_to_ethtool_adv_t(uint32_t adv)
+{
+	uint32_t result = 0;
+
+	if (adv & ADVERTISE_10HALF)
+		result |= ADVERTISED_10baseT_Half;
+	if (adv & ADVERTISE_10FULL)
+		result |= ADVERTISED_10baseT_Full;
+	if (adv & ADVERTISE_100HALF)
+		result |= ADVERTISED_100baseT_Half;
+	if (adv & ADVERTISE_100FULL)
+		result |= ADVERTISED_100baseT_Full;
+	if (adv & ADVERTISE_PAUSE_CAP)
+		result |= ADVERTISED_Pause;
+	if (adv & ADVERTISE_PAUSE_ASYM)
+		result |= ADVERTISED_Asym_Pause;
+
+	return result;
+}
+
+static inline uint32_t genphy_ctrl1000_to_ethtool_adv_t(uint32_t adv)
+{
+	uint32_t result = 0;
+
+	if (adv & ADVERTISE_1000HALF)
+		result |= ADVERTISED_1000baseT_Half;
+	if (adv & ADVERTISE_1000FULL)
+		result |= ADVERTISED_1000baseT_Full;
+
+	return result;
+}
+
+static inline uint32_t genphy_lpa_to_ethtool_lpa_t(uint32_t lpa)
+{
+	uint32_t result = 0;
+
+	if (lpa & LPA_LPACK)
+		result |= ADVERTISED_Autoneg;
+
+	return result | genphy_adv_to_ethtool_adv_t(lpa);
+}
+
+static inline uint32_t genphy_stat1000_to_ethtool_lpa_t(uint32_t lpa)
+{
+	uint32_t result = 0;
+
+	if (lpa & LPA_1000HALF)
+		result |= ADVERTISED_1000baseT_Half;
+	if (lpa & LPA_1000FULL)
+		result |= ADVERTISED_1000baseT_Full;
+
+	return result;
+}
+
+int genphy_soft_reset(struct phy_device *phydev);
+int genphy_resume(struct phy_device *phydev);
+void genphy_suspend(struct phy_device *phydev);
+int genphy_force_speed_duplex(struct phy_device *phydev);
+int genphy_check_for_link(struct phy_device *phydev);
+int genphy_read_status(struct phy_device *phydev);
+
+/* for usxgmii interface */
+int macb_usxgmii_pcs_resume(struct phy_device *phydev);
+void macb_usxgmii_pcs_suspend(struct phy_device *phydev);
+int macb_usxgmii_pcs_check_for_link(struct phy_device *phydev);
+int macb_gbe_pcs_check_for_link(struct phy_device *phydev);
+
+#endif /* _GENERIC_PHY_H */
diff --git a/drivers/net/macb/base/macb_common.c b/drivers/net/macb/base/macb_common.c
new file mode 100644
index 0000000..69b7a74
--- /dev/null
+++ b/drivers/net/macb/base/macb_common.c
@@ -0,0 +1,670 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#include <linux/mii.h>
+#include <ctype.h>
+#include "macb_uio.h"
+
+#define MACB_MDIO_TIMEOUT 1000000 /* in usecs */
+
+bool macb_is_gem(struct macb *bp)
+{
+	return !!(bp->caps & MACB_CAPS_MACB_IS_GEM);
+}
+
+static bool hw_is_gem(struct macb *bp, bool native_io)
+{
+	u32 id;
+	id = macb_readl(bp, MID);
+	return MACB_BFEXT(IDNUM, id) >= 0x2;
+}
+
+bool hw_is_native_io(struct macb *bp)
+{
+	u32 value = MACB_BIT(LLB);
+
+	macb_writel(bp, NCR, value);
+	value = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, 0);
+
+	return value == MACB_BIT(LLB);
+}
+
+u32 macb_dbw(struct macb *bp)
+{
+	switch (GEM_BFEXT(DBWDEF, gem_readl(bp, DCFG1))) {
+	case 4:
+		bp->data_bus_width = 128;
+		return GEM_BF(DBW, GEM_DBW128);
+	case 2:
+		bp->data_bus_width = 64;
+		return GEM_BF(DBW, GEM_DBW64);
+	case 1:
+	default:
+		bp->data_bus_width = 32;
+		return GEM_BF(DBW, GEM_DBW32);
+	}
+}
+
+void macb_probe_queues(uintptr_t base, bool native_io, unsigned int *queue_mask,
+					   unsigned int *num_queues)
+{
+	unsigned int hw_q;
+
+	*queue_mask = 0x1;
+	*num_queues = 1;
+
+	/* bit 0 is never set but queue 0 always exists */
+	*queue_mask =
+		(rte_le_to_cpu_32(rte_read32((void *)(base + GEM_DCFG6)))) & 0xff;
+
+	*queue_mask |= 0x1;
+
+	for (hw_q = 1; hw_q < MACB_MAX_QUEUES; ++hw_q)
+		if (*queue_mask & (1 << hw_q))
+			(*num_queues)++;
+}
+
+void macb_configure_caps(struct macb *bp, const struct macb_config *dt_conf)
+{
+	u32 dcfg;
+
+	if (dt_conf)
+		bp->caps = dt_conf->caps;
+
+	if (hw_is_gem(bp, bp->native_io)) {
+		bp->caps |= MACB_CAPS_MACB_IS_GEM;
+
+		dcfg = gem_readl(bp, DCFG1);
+		if (GEM_BFEXT(IRQCOR, dcfg) == 0)
+			bp->caps |= MACB_CAPS_ISR_CLEAR_ON_WRITE;
+
+		dcfg = gem_readl(bp, DCFG2);
+		if ((dcfg & (GEM_BIT(RX_PKT_BUFF) | GEM_BIT(TX_PKT_BUFF))) == 0)
+			bp->caps |= MACB_CAPS_FIFO_MODE;
+	}
+}
+
+int get_last_num_from_string(char *buf, int *id)
+{
+	int len = strlen(buf);
+	int i, found = 0;
+
+	for (i = len - 1; (i >= 0); i--) {
+		if (isdigit(buf[i]))
+			found++;
+		else if (found)
+			break;
+	}
+
+	if (found) {
+		*id = atoi(&buf[i + 1]);
+		return 0;
+	}
+
+	return -1;
+}
+
+int macb_iomem_init(const char *name, struct macb *bp, phys_addr_t paddr)
+{
+	int ret;
+
+	if (macb_uio_exist(name)) {
+		ret = macb_uio_init(name, &bp->iomem);
+		if (ret) {
+			MACB_LOG(ERR, "failed to init uio device.");
+			return -EFAULT;
+		}
+	} else {
+		MACB_LOG(ERR, "uio device %s not exist.", name);
+		return -EFAULT;
+	}
+
+	ret = macb_uio_map(bp->iomem, &bp->paddr, (void **)(&bp->base), paddr);
+	if (ret) {
+		MACB_LOG(ERR, "Failed to remap macb uio device.");
+		macb_uio_deinit(bp->iomem);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int macb_iomem_deinit(struct macb *bp)
+{
+	macb_uio_unmap(bp->iomem);
+	macb_uio_deinit(bp->iomem);
+	return 0;
+}
+
+void macb_get_stats(struct macb *bp)
+{
+	struct macb_queue *queue;
+	unsigned int i, q, idx;
+	unsigned long *stat;
+
+	u64 *p = &bp->hw_stats.gem.tx_octets_31_0;
+
+	for (i = 0; i < GEM_STATS_LEN; ++i, ++p) {
+		u32 offset = gem_statistics[i].offset;
+		u64 val = macb_reg_readl(bp, offset);
+
+		*p += val;
+
+		if (offset == GEM_OCTTXL || offset == GEM_OCTRXL) {
+			/* Add GEM_OCTTXH, GEM_OCTRXH */
+			val = macb_reg_readl(bp, offset + 4);
+			*(++p) += val;
+		}
+	}
+}
+
+static int macb_mdio_wait_for_idle(struct macb *bp)
+{
+	uint32_t val;
+	uint64_t timeout = 0;
+	for (;;) {
+		val = macb_readl(bp, NSR);
+		if (val & MACB_BIT(IDLE))
+			break;
+		if (timeout >= MACB_MDIO_TIMEOUT)
+			break;
+		timeout++;
+		usleep(1);
+	}
+	return (val & MACB_BIT(IDLE)) ? 0 : -ETIMEDOUT;
+}
+
+int macb_mdio_read(struct macb *bp, uint16_t phy_id, uint32_t regnum)
+{
+	int32_t status;
+
+	status = macb_mdio_wait_for_idle(bp);
+	if (status < 0)
+		return status;
+
+	if (regnum & MII_ADDR_C45) {
+		macb_writel(bp, MAN,
+					(MACB_BF(SOF, MACB_MAN_C45_SOF) |
+					 MACB_BF(RW, MACB_MAN_C45_ADDR) | MACB_BF(PHYA, phy_id) |
+					 MACB_BF(REGA, (regnum >> 16) & 0x1F) |
+					 MACB_BF(DATA, regnum & 0xFFFF) |
+					 MACB_BF(CODE, MACB_MAN_C45_CODE)));
+
+		status = macb_mdio_wait_for_idle(bp);
+		if (status < 0)
+			return status;
+
+		macb_writel(bp, MAN,
+					(MACB_BF(SOF, MACB_MAN_C45_SOF) |
+					 MACB_BF(RW, MACB_MAN_C45_READ) | MACB_BF(PHYA, phy_id) |
+					 MACB_BF(REGA, (regnum >> 16) & 0x1F) |
+					 MACB_BF(CODE, MACB_MAN_C45_CODE)));
+	} else {
+		macb_writel(bp, MAN,
+					(MACB_BF(SOF, MACB_MAN_C22_SOF) |
+					 MACB_BF(RW, MACB_MAN_C22_READ) | MACB_BF(PHYA, phy_id) |
+					 MACB_BF(REGA, regnum) | MACB_BF(CODE, MACB_MAN_C22_CODE)));
+	}
+
+	/* wait for end of transfer */
+	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+		;
+
+	status = MACB_BFEXT(DATA, macb_readl(bp, MAN));
+
+	return status;
+}
+
+int macb_mdio_write(struct macb *bp, uint16_t phy_id, uint32_t regnum,
+					uint16_t value)
+{
+	int32_t status;
+	status = macb_mdio_wait_for_idle(bp);
+	if (status < 0)
+		return status;
+
+	if (regnum & MII_ADDR_C45) {
+		macb_writel(bp, MAN,
+					(MACB_BF(SOF, MACB_MAN_C45_SOF) |
+					 MACB_BF(RW, MACB_MAN_C45_ADDR) | MACB_BF(PHYA, phy_id) |
+					 MACB_BF(REGA, (regnum >> 16) & 0x1F) |
+					 MACB_BF(DATA, regnum & 0xFFFF) |
+					 MACB_BF(CODE, MACB_MAN_C45_CODE)));
+
+		status = macb_mdio_wait_for_idle(bp);
+		if (status < 0)
+			return status;
+
+		macb_writel(bp, MAN,
+					(MACB_BF(SOF, MACB_MAN_C45_SOF) |
+					 MACB_BF(RW, MACB_MAN_C45_WRITE) | MACB_BF(PHYA, phy_id) |
+					 MACB_BF(REGA, (regnum >> 16) & 0x1F) |
+					 MACB_BF(CODE, MACB_MAN_C45_CODE) | MACB_BF(DATA, value)));
+
+	} else {
+		macb_writel(bp, MAN,
+					(MACB_BF(SOF, MACB_MAN_C22_SOF) |
+					 MACB_BF(RW, MACB_MAN_C22_WRITE) | MACB_BF(PHYA, phy_id) |
+					 MACB_BF(REGA, regnum) | MACB_BF(CODE, MACB_MAN_C22_CODE) |
+					 MACB_BF(DATA, value)));
+	}
+
+	/* wait for end of transfer */
+	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+		;
+
+	return 0;
+}
+
+void macb_gem1p0_sel_clk(struct macb *bp)
+{
+	int speed = 0;
+
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_SGMII) {
+		if (bp->speed == SPEED_2500) {
+			gem_writel(bp, DIV_SEL0_LN, 0x1);		/*0x1c08*/
+			gem_writel(bp, DIV_SEL1_LN, 0x2);		/*0x1c0c*/
+			gem_writel(bp, PMA_XCVR_POWER_STATE, 0x1);	/*0x1c10*/
+			gem_writel(bp, TX_CLK_SEL0, 0x0);		/*0x1c20*/
+			gem_writel(bp, TX_CLK_SEL1, 0x1);		/*0x1c24*/
+			gem_writel(bp, TX_CLK_SEL2, 0x1);		/*0x1c28*/
+			gem_writel(bp, TX_CLK_SEL3, 0x1);		/*0x1c2c*/
+			gem_writel(bp, RX_CLK_SEL0, 0x1);		/*0x1c30*/
+			gem_writel(bp, RX_CLK_SEL1, 0x0);		/*0x1c34*/
+			gem_writel(bp, TX_CLK_SEL3_0, 0x0);		/*0x1c70*/
+			gem_writel(bp, TX_CLK_SEL4_0, 0x0);		/*0x1c74*/
+			gem_writel(bp, RX_CLK_SEL3_0, 0x0);		/*0x1c78*/
+			gem_writel(bp, RX_CLK_SEL4_0, 0x0);		/*0x1c7c*/
+			speed = GEM_SPEED_2500;
+		} else if (bp->speed == SPEED_1000) {
+			gem_writel(bp, DIV_SEL0_LN, 0x4);		/*0x1c08*/
+			gem_writel(bp, DIV_SEL1_LN, 0x8);		/*0x1c0c*/
+			gem_writel(bp, PMA_XCVR_POWER_STATE, 0x1);	/*0x1c10*/
+			gem_writel(bp, TX_CLK_SEL0, 0x0);		/*0x1c20*/
+			gem_writel(bp, TX_CLK_SEL1, 0x0);		/*0x1c24*/
+			gem_writel(bp, TX_CLK_SEL2, 0x0);		/*0x1c28*/
+			gem_writel(bp, TX_CLK_SEL3, 0x1);		/*0x1c2c*/
+			gem_writel(bp, RX_CLK_SEL0, 0x1);		/*0x1c30*/
+			gem_writel(bp, RX_CLK_SEL1, 0x0);		/*0x1c34*/
+			gem_writel(bp, TX_CLK_SEL3_0, 0x0);		/*0x1c70*/
+			gem_writel(bp, TX_CLK_SEL4_0, 0x0);		/*0x1c74*/
+			gem_writel(bp, RX_CLK_SEL3_0, 0x0);		/*0x1c78*/
+			gem_writel(bp, RX_CLK_SEL4_0, 0x0);		/*0x1c7c*/
+			speed = GEM_SPEED_1000;
+		} else if (bp->speed == SPEED_100 || bp->speed == SPEED_10) {
+			gem_writel(bp, DIV_SEL0_LN, 0x4);		/*0x1c08*/
+			gem_writel(bp, DIV_SEL1_LN, 0x8);		/*0x1c0c*/
+			gem_writel(bp, PMA_XCVR_POWER_STATE, 0x1);	/*0x1c10*/
+			gem_writel(bp, TX_CLK_SEL0, 0x0);		/*0x1c20*/
+			gem_writel(bp, TX_CLK_SEL1, 0x0);		/*0x1c24*/
+			gem_writel(bp, TX_CLK_SEL2, 0x1);		/*0x1c28*/
+			gem_writel(bp, TX_CLK_SEL3, 0x1);		/*0x1c2c*/
+			gem_writel(bp, RX_CLK_SEL0, 0x1);		/*0x1c30*/
+			gem_writel(bp, RX_CLK_SEL1, 0x0);		/*0x1c34*/
+			gem_writel(bp, TX_CLK_SEL3_0, 0x1);		/*0x1c70*/
+			gem_writel(bp, TX_CLK_SEL4_0, 0x0);		/*0x1c74*/
+			gem_writel(bp, RX_CLK_SEL3_0, 0x0);		/*0x1c78*/
+			gem_writel(bp, RX_CLK_SEL4_0, 0x1);		/*0x1c7c*/
+			speed = GEM_SPEED_100;
+		}
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_RGMII) {
+		if (bp->speed == SPEED_1000) {
+			gem_writel(bp, MII_SELECT, 0x1);		/*0x1c18*/
+			gem_writel(bp, SEL_MII_ON_RGMII, 0x0);		/*0x1c1c*/
+			gem_writel(bp, TX_CLK_SEL0, 0x0);		/*0x1c20*/
+			gem_writel(bp, TX_CLK_SEL1, 0x1);		/*0x1c24*/
+			gem_writel(bp, TX_CLK_SEL2, 0x0);		/*0x1c28*/
+			gem_writel(bp, TX_CLK_SEL3, 0x0);		/*0x1c2c*/
+			gem_writel(bp, RX_CLK_SEL0, 0x0);		/*0x1c30*/
+			gem_writel(bp, RX_CLK_SEL1, 0x1);		/*0x1c34*/
+			gem_writel(bp, CLK_250M_DIV10_DIV100_SEL, 0x0); /*0x1c38*/
+			gem_writel(bp, RX_CLK_SEL5, 0x1);		/*0x1c48*/
+			gem_writel(bp, RGMII_TX_CLK_SEL0, 0x1);		/*0x1c80*/
+			gem_writel(bp, RGMII_TX_CLK_SEL1, 0x0);		/*0x1c84*/
+			speed = GEM_SPEED_1000;
+		} else if (bp->speed == SPEED_100) {
+			gem_writel(bp, MII_SELECT, 0x1);		/*0x1c18*/
+			gem_writel(bp, SEL_MII_ON_RGMII, 0x0);		/*0x1c1c*/
+			gem_writel(bp, TX_CLK_SEL0, 0x0);		/*0x1c20*/
+			gem_writel(bp, TX_CLK_SEL1, 0x1);		/*0x1c24*/
+			gem_writel(bp, TX_CLK_SEL2, 0x0);		/*0x1c28*/
+			gem_writel(bp, TX_CLK_SEL3, 0x0);		/*0x1c2c*/
+			gem_writel(bp, RX_CLK_SEL0, 0x0);		/*0x1c30*/
+			gem_writel(bp, RX_CLK_SEL1, 0x1);		/*0x1c34*/
+			gem_writel(bp, CLK_250M_DIV10_DIV100_SEL, 0x0); /*0x1c38*/
+			gem_writel(bp, RX_CLK_SEL5, 0x1);		/*0x1c48*/
+			gem_writel(bp, RGMII_TX_CLK_SEL0, 0x0);		/*0x1c80*/
+			gem_writel(bp, RGMII_TX_CLK_SEL1, 0x0);		/*0x1c84*/
+			speed = GEM_SPEED_100;
+		} else {
+			gem_writel(bp, MII_SELECT, 0x1);		/*0x1c18*/
+			gem_writel(bp, SEL_MII_ON_RGMII, 0x0);		/*0x1c1c*/
+			gem_writel(bp, TX_CLK_SEL0, 0x0);		/*0x1c20*/
+			gem_writel(bp, TX_CLK_SEL1, 0x1);		/*0x1c24*/
+			gem_writel(bp, TX_CLK_SEL2, 0x0);		/*0x1c28*/
+			gem_writel(bp, TX_CLK_SEL3, 0x0);		/*0x1c2c*/
+			gem_writel(bp, RX_CLK_SEL0, 0x0);		/*0x1c30*/
+			gem_writel(bp, RX_CLK_SEL1, 0x1);		/*0x1c34*/
+			gem_writel(bp, CLK_250M_DIV10_DIV100_SEL, 0x1);	/*0x1c38*/
+			gem_writel(bp, RX_CLK_SEL5, 0x1);		/*0x1c48*/
+			gem_writel(bp, RGMII_TX_CLK_SEL0, 0x0);		/*0x1c80*/
+			gem_writel(bp, RGMII_TX_CLK_SEL1, 0x0);		/*0x1c84*/
+			speed = GEM_SPEED_100;
+		}
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_RMII) {
+		speed = GEM_SPEED_100;
+		gem_writel(bp, RX_CLK_SEL5, 0x1);			/*0x1c48*/
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX) {
+		gem_writel(bp, DIV_SEL0_LN, 0x4);			/*0x1c08*/
+		gem_writel(bp, DIV_SEL1_LN, 0x8);			/*0x1c0c*/
+		gem_writel(bp, PMA_XCVR_POWER_STATE, 0x1);		/*0x1c10*/
+		gem_writel(bp, TX_CLK_SEL0, 0x0);			/*0x1c20*/
+		gem_writel(bp, TX_CLK_SEL1, 0x0);			/*0x1c24*/
+		gem_writel(bp, TX_CLK_SEL2, 0x1);			/*0x1c28*/
+		gem_writel(bp, TX_CLK_SEL3, 0x1);			/*0x1c2c*/
+		gem_writel(bp, RX_CLK_SEL0, 0x1);			/*0x1c30*/
+		gem_writel(bp, RX_CLK_SEL1, 0x0);			/*0x1c34*/
+		gem_writel(bp, TX_CLK_SEL3_0, 0x1);			/*0x1c70*/
+		gem_writel(bp, TX_CLK_SEL4_0, 0x0);			/*0x1c74*/
+		gem_writel(bp, RX_CLK_SEL3_0, 0x0);			/*0x1c78*/
+		gem_writel(bp, RX_CLK_SEL4_0, 0x1);			/*0x1c7c*/
+		speed = GEM_SPEED_100;
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_1000BASEX) {
+		gem_writel(bp, DIV_SEL0_LN, 0x4);			/*0x1c08*/
+		gem_writel(bp, DIV_SEL1_LN, 0x8);			/*0x1c0c*/
+		gem_writel(bp, PMA_XCVR_POWER_STATE, 0x1);		/*0x1c10*/
+		gem_writel(bp, TX_CLK_SEL0, 0x0);			/*0x1c20*/
+		gem_writel(bp, TX_CLK_SEL1, 0x0);			/*0x1c24*/
+		gem_writel(bp, TX_CLK_SEL2, 0x0);			/*0x1c28*/
+		gem_writel(bp, TX_CLK_SEL3, 0x1);			/*0x1c2c*/
+		gem_writel(bp, RX_CLK_SEL0, 0x1);			/*0x1c30*/
+		gem_writel(bp, RX_CLK_SEL1, 0x0);			/*0x1c34*/
+		gem_writel(bp, TX_CLK_SEL3_0, 0x0);			/*0x1c70*/
+		gem_writel(bp, TX_CLK_SEL4_0, 0x0);			/*0x1c74*/
+		gem_writel(bp, RX_CLK_SEL3_0, 0x0);			/*0x1c78*/
+		gem_writel(bp, RX_CLK_SEL4_0, 0x0);			/*0x1c7c*/
+		speed = GEM_SPEED_1000;
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_2500BASEX) {
+		gem_writel(bp, DIV_SEL0_LN, 0x1);			/*0x1c08*/
+		gem_writel(bp, DIV_SEL1_LN, 0x2);			/*0x1c0c*/
+		gem_writel(bp, PMA_XCVR_POWER_STATE, 0x1);		/*0x1c10*/
+		gem_writel(bp, TX_CLK_SEL0, 0x0);			/*0x1c20*/
+		gem_writel(bp, TX_CLK_SEL1, 0x1);			/*0x1c24*/
+		gem_writel(bp, TX_CLK_SEL2, 0x1);			/*0x1c28*/
+		gem_writel(bp, TX_CLK_SEL3, 0x1);			/*0x1c2c*/
+		gem_writel(bp, RX_CLK_SEL0, 0x1);			/*0x1c30*/
+		gem_writel(bp, RX_CLK_SEL1, 0x0);			/*0x1c34*/
+		gem_writel(bp, TX_CLK_SEL3_0, 0x0);			/*0x1c70*/
+		gem_writel(bp, TX_CLK_SEL4_0, 0x0);			/*0x1c74*/
+		gem_writel(bp, RX_CLK_SEL3_0, 0x0);			/*0x1c78*/
+		gem_writel(bp, RX_CLK_SEL4_0, 0x0);			/*0x1c7c*/
+		speed = GEM_SPEED_2500;
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII) {
+		gem_writel(bp, SRC_SEL_LN, 0x1);			/*0x1c04*/
+		if (bp->speed == SPEED_5000) {
+			gem_writel(bp, DIV_SEL0_LN, 0x8);		/*0x1c08*/
+			gem_writel(bp, DIV_SEL1_LN, 0x2);		/*0x1cc*/
+			speed = GEM_SPEED_5000;
+		} else {
+			gem_writel(bp, DIV_SEL0_LN, 0x4);		/*0x1c08*/
+			gem_writel(bp, DIV_SEL1_LN, 0x1);		/*0x1c0c*/
+			gem_writel(bp, TX_CLK_SEL3_0, 0x0);		/*0x1c70*/
+			gem_writel(bp, RX_CLK_SEL4_0, 0x0);		/*0x1c7c*/
+			speed = GEM_SPEED_10000;
+		}
+		gem_writel(bp, PMA_XCVR_POWER_STATE, 0x1);		/*0x1c10*/
+	}
+
+	/*HS_MAC_CONFIG(0x0050) provide rate to the external*/
+	gem_writel(bp, HS_MAC_CONFIG, GEM_BFINS(HS_MAC_SPEED, speed, gem_readl(bp, HS_MAC_CONFIG)));
+}
+
+void macb_gem2p0_sel_clk(struct macb *bp)
+{
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_SGMII) {
+		if (bp->speed == SPEED_100 || bp->speed == SPEED_10) {
+			gem_writel(bp, DIV_SEL0_LN, 0x4); /*0x1c08*/
+			gem_writel(bp, DIV_SEL1_LN, 0x8); /*0x1c0c*/
+		}
+	}
+
+	if (bp->speed == SPEED_100 || bp->speed == SPEED_10)
+		gem_writel(bp, HS_MAC_CONFIG, GEM_BFINS(HS_MAC_SPEED, GEM_SPEED_100,
+							gem_readl(bp, HS_MAC_CONFIG)));
+	else if (bp->speed == SPEED_1000)
+		gem_writel(bp, HS_MAC_CONFIG, GEM_BFINS(HS_MAC_SPEED, GEM_SPEED_1000,
+							gem_readl(bp, HS_MAC_CONFIG)));
+	else if (bp->speed == SPEED_2500)
+		gem_writel(bp, HS_MAC_CONFIG, GEM_BFINS(HS_MAC_SPEED, GEM_SPEED_2500,
+							gem_readl(bp, HS_MAC_CONFIG)));
+	else if (bp->speed == SPEED_5000)
+		gem_writel(bp, HS_MAC_CONFIG, GEM_BFINS(HS_MAC_SPEED, GEM_SPEED_5000,
+							gem_readl(bp, HS_MAC_CONFIG)));
+	else if (bp->speed == SPEED_10000)
+		gem_writel(bp, HS_MAC_CONFIG, GEM_BFINS(HS_MAC_SPEED, GEM_SPEED_10000,
+							gem_readl(bp, HS_MAC_CONFIG)));
+}
+
+/* When PCSSEL is set to 1, PCS will be in a soft reset state,
+ * The auto negotiation configuration must be done after
+ * pcs soft reset is completed.
+ */
+static int macb_mac_pcssel_config(struct macb *bp)
+{
+	u32 old_ctrl, ctrl;
+
+	ctrl = macb_or_gem_readl(bp, NCFGR);
+	old_ctrl = ctrl;
+
+	ctrl |= GEM_BIT(PCSSEL);
+
+	if (old_ctrl ^ ctrl)
+		macb_or_gem_writel(bp, NCFGR, ctrl);
+
+	rte_delay_ms(1);
+	return 0;
+}
+
+int macb_mac_with_pcs_config(struct macb *bp)
+{
+	u32 old_ctrl, ctrl;
+	u32 old_ncr, ncr;
+	u32 config;
+	u32 pcsctrl;
+
+	macb_mac_pcssel_config(bp);
+
+	ncr = macb_readl(bp, NCR);
+	old_ncr = ncr;
+	ctrl = macb_or_gem_readl(bp, NCFGR);
+	old_ctrl = ctrl;
+
+	ncr &= ~(GEM_BIT(ENABLE_HS_MAC) | MACB_BIT(2PT5G));
+	ctrl &= ~(GEM_BIT(SGMIIEN) | MACB_BIT(SPD) | MACB_BIT(FD));
+	if (macb_is_gem(bp))
+		ctrl &= ~GEM_BIT(GBE);
+
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_2500BASEX) {
+		ctrl |= GEM_BIT(GBE);
+		ncr |= MACB_BIT(2PT5G);
+		pcsctrl = gem_readl(bp, PCSCTRL);
+		pcsctrl &= ~GEM_BIT(PCS_AUTO_NEG_ENB);
+		gem_writel(bp, PCSCTRL, pcsctrl);
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII) {
+		ncr |= GEM_BIT(ENABLE_HS_MAC);
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_1000BASEX) {
+		ctrl |= GEM_BIT(GBE);
+		pcsctrl = gem_readl(bp, PCSCTRL);
+		pcsctrl |= GEM_BIT(PCS_AUTO_NEG_ENB);
+		gem_writel(bp, PCSCTRL, pcsctrl);
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX) {
+		ctrl |= MACB_BIT(SPD);
+		pcsctrl = gem_readl(bp, PCSCTRL);
+		pcsctrl |= GEM_BIT(PCS_AUTO_NEG_ENB);
+		gem_writel(bp, PCSCTRL, pcsctrl);
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_SGMII && bp->fixed_link) {
+		ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(GBE);
+		pcsctrl = gem_readl(bp, PCSCTRL);
+		pcsctrl |= GEM_BIT(PCS_AUTO_NEG_ENB);
+		gem_writel(bp, PCSCTRL, pcsctrl);
+	}
+
+	if (bp->duplex)
+		ctrl |= MACB_BIT(FD);
+
+	/* Apply the new configuration, if any */
+	if (old_ctrl ^ ctrl)
+		macb_or_gem_writel(bp, NCFGR, ctrl);
+
+	if (old_ncr ^ ncr)
+		macb_or_gem_writel(bp, NCR, ncr);
+
+	/*config usx control*/
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII) {
+		config = gem_readl(bp, USX_CONTROL);
+		if (bp->speed == SPEED_10000) {
+			config = GEM_BFINS(SERDES_RATE, MACB_SERDES_RATE_10G, config);
+			config = GEM_BFINS(USX_CTRL_SPEED, GEM_SPEED_10000, config);
+		} else if (bp->speed == SPEED_5000) {
+			config = GEM_BFINS(SERDES_RATE, MACB_SERDES_RATE_5G, config);
+			config = GEM_BFINS(USX_CTRL_SPEED, GEM_SPEED_5000, config);
+		}
+
+		config &= ~(GEM_BIT(TX_SCR_BYPASS) | GEM_BIT(RX_SCR_BYPASS));
+		/* enable rx and tx */
+		config &= ~(GEM_BIT(RX_SYNC_RESET));
+		config |= GEM_BIT(SIGNAL_OK) | GEM_BIT(TX_EN);
+		gem_writel(bp, USX_CONTROL, config);
+	}
+
+	return 0;
+}
+
+int macb_link_change(struct macb *bp)
+{
+	struct phy_device *phydev = bp->phydev;
+	uint32_t config, ncr, pcsctrl;
+	bool sync_link_info = true;
+
+	if (!bp->link)
+		return 0;
+
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII ||
+		bp->phy_interface == MACB_PHY_INTERFACE_MODE_2500BASEX ||
+		bp->phy_interface == MACB_PHY_INTERFACE_MODE_1000BASEX ||
+		bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX ||
+		bp->fixed_link)
+		sync_link_info = false;
+
+	if (sync_link_info) {
+		/* sync phy link info to mac */
+		if (bp->phydrv_used) {
+			bp->duplex = phydev->duplex;
+			bp->speed = phydev->speed;
+		}
+
+		config = macb_readl(bp, NCFGR);
+		config &= ~(MACB_BIT(FD) | MACB_BIT(SPD) | GEM_BIT(GBE));
+
+		if (bp->duplex)
+			config |= MACB_BIT(FD);
+
+		if (bp->speed == SPEED_100)
+			config |= MACB_BIT(SPD);
+		else if (bp->speed == SPEED_1000 || bp->speed == SPEED_2500)
+			config |= GEM_BIT(GBE);
+
+		macb_writel(bp, NCFGR, config);
+
+		if (bp->speed == SPEED_2500) {
+			ncr = macb_readl(bp, NCR);
+			ncr |= MACB_BIT(2PT5G);
+			macb_writel(bp, NCR, ncr);
+			pcsctrl = gem_readl(bp, PCSCTRL);
+			pcsctrl &= ~GEM_BIT(PCS_AUTO_NEG_ENB);
+			gem_writel(bp, PCSCTRL, pcsctrl);
+		}
+	}
+
+	if ((bp->caps & MACB_CAPS_SEL_CLK_HW) && bp->sel_clk_hw)
+		bp->sel_clk_hw(bp);
+
+	return 0;
+}
+
+void macb_check_for_link(struct macb *bp)
+{
+	int link_flag;
+	struct phy_device *phydev = bp->phydev;
+
+	if (phydev->drv && phydev->drv->check_for_link) {
+		link_flag = phydev->drv->check_for_link(phydev);
+		if (link_flag > 0)
+			bp->link = (uint16_t)link_flag;
+		else
+			bp->link = 0;
+	}
+}
+
+void macb_setup_link(struct macb *bp)
+{
+	struct phy_device *phydev = bp->phydev;
+
+	/* phy setup link */
+	if (phydev->drv && phydev->drv->force_speed_duplex)
+		phydev->drv->force_speed_duplex(phydev);
+}
+
+void macb_reset_hw(struct macb *bp)
+{
+	u32 i;
+	u32 ISR;
+	u32 IDR;
+	u32 TBQP;
+	u32 TBQPH;
+	u32 RBQP;
+	u32 RBQPH;
+
+	u32 ctrl = macb_readl(bp, NCR);
+
+	/* Disable RX and TX (XXX: Should we halt the transmission
+	 * more gracefully?)
+	 */
+	ctrl &= ~(MACB_BIT(RE) | MACB_BIT(TE));
+
+	/* Clear the stats registers (XXX: Update stats first?) */
+	ctrl |= MACB_BIT(CLRSTAT);
+
+	macb_writel(bp, NCR, ctrl);
+	rte_delay_ms(1);
+
+	/* Clear all status flags */
+	macb_writel(bp, TSR, -1);
+	macb_writel(bp, RSR, -1);
+
+	/* queue0 uses legacy registers */
+	macb_queue_flush(bp, MACB_TBQP, 1);
+	macb_queue_flush(bp, MACB_TBQPH, 0);
+	macb_queue_flush(bp, MACB_RBQP, 1);
+	macb_queue_flush(bp, MACB_RBQPH, 0);
+
+	/* clear all queue register */
+	for (i = 1; i < bp->num_queues; i++) {
+		ISR = GEM_ISR(i - 1);
+		IDR = GEM_IDR(i - 1);
+		TBQP = GEM_TBQP(i - 1);
+		TBQPH = GEM_TBQPH(i - 1);
+		RBQP = GEM_RBQP(i - 1);
+		RBQPH = GEM_RBQPH(i - 1);
+
+		macb_queue_flush(bp, IDR, -1);
+		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			macb_queue_flush(bp, ISR, -1);
+		macb_queue_flush(bp, TBQP, 1);
+		macb_queue_flush(bp, TBQPH, 0);
+		macb_queue_flush(bp, RBQP, 1);
+		macb_queue_flush(bp, RBQPH, 0);
+	}
+}
diff --git a/drivers/net/macb/base/macb_common.h b/drivers/net/macb/base/macb_common.h
new file mode 100644
index 0000000..abcf283
--- /dev/null
+++ b/drivers/net/macb/base/macb_common.h
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#ifndef _MACB_COMMON_H_
+#define _MACB_COMMON_H_
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
+#include <net/if.h>
+#include <net/if_arp.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+
+#include <rte_common.h>
+#include <rte_memcpy.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+#include <rte_byteorder.h>
+#include <rte_cycles.h>
+#include <rte_spinlock.h>
+#include <rte_log.h>
+#include <rte_random.h>
+#include <rte_io.h>
+
+#include "macb_type.h"
+#include "macb_hw.h"
+#include "generic_phy.h"
+#include "macb_errno.h"
+#include "../macb_log.h"
+#include "macb_uio.h"
+
+#define BIT(nr)	(1UL << (nr))
+
+#define MACB_MAX_PORT_NUM 4
+#define	MACB_MIN_RING_DESC	64
+#define	MACB_MAX_RING_DESC	4096
+#define MACB_RXD_ALIGN	64
+#define MACB_TXD_ALIGN	64
+
+#define TX_RING_BYTES(bp)	(macb_dma_desc_get_size(bp)	\
+				 * (bp)->tx_ring_size)
+#define RX_RING_BYTES(bp)	(macb_dma_desc_get_size(bp)	\
+				 * (bp)->rx_ring_size)
+#define MACB_TX_LEN_ALIGN	8
+#define MACB_RX_LEN_ALIGN	8
+
+
+#define MACB_RX_RING_SIZE	256
+#define MACB_TX_RING_SIZE	256
+#define MAX_JUMBO_FRAME_SIZE	10240
+#define MIN_JUMBO_FRAME_SIZE	16
+
+#define RX_BUFFER_MULTIPLE	64  /* bytes */
+#define PCLK_HZ_2 20000000
+#define PCLK_HZ_4 40000000
+#define PCLK_HZ_8 80000000
+#define PCLK_HZ_12 120000000
+#define PCLK_HZ_16 160000000
+
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+#define lower_32_bits(n) ((u32)(n))
+#define cpu_to_le16(x)  (x)
+#define cpu_to_le32(x)  (x)
+
+#define MACB_MII_CLK_ENABLE 0x1
+#define MACB_MII_CLK_DISABLE 0x0
+
+/* dtb for Phytium MAC */
+#define OF_PHYTIUM_GEM1P0_MAC	"cdns,phytium-gem-1.0"	/* Phytium 1.0 MAC */
+#define OF_PHYTIUM_GEM2P0_MAC	"cdns,phytium-gem-2.0"	/* Phytium 2.0 MAC */
+
+/* acpi for Phytium MAC */
+#define ACPI_PHYTIUM_GEM1P0_MAC	"PHYT0036"	/* Phytium 1.0  MAC */
+
+typedef u64 netdev_features_t;
+
+/**
+ * Interface Mode definitions.
+ * Warning: must be consistent with dpdk definition !
+ */
+typedef enum {
+	MACB_PHY_INTERFACE_MODE_NA,
+	MACB_PHY_INTERFACE_MODE_INTERNAL,
+	MACB_PHY_INTERFACE_MODE_MII,
+	MACB_PHY_INTERFACE_MODE_GMII,
+	MACB_PHY_INTERFACE_MODE_SGMII,
+	MACB_PHY_INTERFACE_MODE_TBI,
+	MACB_PHY_INTERFACE_MODE_REVMII,
+	MACB_PHY_INTERFACE_MODE_RMII,
+	MACB_PHY_INTERFACE_MODE_RGMII,
+	MACB_PHY_INTERFACE_MODE_RGMII_ID,
+	MACB_PHY_INTERFACE_MODE_RGMII_RXID,
+	MACB_PHY_INTERFACE_MODE_RGMII_TXID,
+	MACB_PHY_INTERFACE_MODE_RTBI,
+	MACB_PHY_INTERFACE_MODE_SMII,
+	MACB_PHY_INTERFACE_MODE_XGMII,
+	MACB_PHY_INTERFACE_MODE_MOCA,
+	MACB_PHY_INTERFACE_MODE_QSGMII,
+	MACB_PHY_INTERFACE_MODE_TRGMII,
+	MACB_PHY_INTERFACE_MODE_100BASEX,
+	MACB_PHY_INTERFACE_MODE_1000BASEX,
+	MACB_PHY_INTERFACE_MODE_2500BASEX,
+	MACB_PHY_INTERFACE_MODE_5GBASER,
+	MACB_PHY_INTERFACE_MODE_RXAUI,
+	MACB_PHY_INTERFACE_MODE_XAUI,
+	/* 10GBASE-R, XFI, SFI - single lane 10G Serdes */
+	MACB_PHY_INTERFACE_MODE_10GBASER,
+	MACB_PHY_INTERFACE_MODE_USXGMII,
+	/* 10GBASE-KR - with Clause 73 AN */
+	MACB_PHY_INTERFACE_MODE_10GKR,
+	MACB_PHY_INTERFACE_MODE_MAX,
+} phy_interface_t;
+
+typedef enum {
+	DEV_TYPE_PHYTIUM_GEM1P0_MAC,
+	DEV_TYPE_PHYTIUM_GEM2P0_MAC,
+	DEV_TYPE_DEFAULT,
+} dev_type_t;
+
+struct macb_dma_desc {
+	u32	addr;
+	u32	ctrl;
+};
+
+struct macb_dma_desc_64 {
+	u32 addrh;
+	u32 resvd;
+};
+
+struct macb_dma_desc_ptp {
+	u32	ts_1;
+	u32	ts_2;
+};
+
+struct macb;
+struct macb_rx_queue;
+struct macb_tx_queue;
+
+struct macb_config {
+	u32			caps;
+	unsigned int		dma_burst_length;
+	int	jumbo_max_len;
+	void (*sel_clk_hw)(struct macb *bp);
+};
+
+struct macb {
+	struct macb_iomem		*iomem;
+	uintptr_t		base;
+	phys_addr_t		paddr;
+	bool			native_io;
+	bool			rx_bulk_alloc_allowed;
+	bool			rx_vec_allowed;
+
+	size_t			rx_buffer_size;
+
+	unsigned int		rx_ring_size;
+	unsigned int		tx_ring_size;
+
+	unsigned int		num_queues;
+	unsigned int		queue_mask;
+
+	rte_spinlock_t		lock;
+	struct rte_eth_dev	*dev;
+	union {
+		struct macb_stats	macb;
+		struct gem_stats	gem;
+	} hw_stats;
+
+	uint16_t phyad;
+	uint32_t speed;
+	uint16_t link;
+	uint16_t duplex;
+	uint16_t autoneg;
+	uint16_t fixed_link;
+	u32			caps;
+	unsigned int		dma_burst_length;
+
+	unsigned int		rx_frm_len_mask;
+	unsigned int		jumbo_max_len;
+
+	uint8_t hw_dma_cap;
+
+	bool phydrv_used;
+	struct phy_device *phydev;
+
+	int	rx_bd_rd_prefetch;
+	int	tx_bd_rd_prefetch;
+
+	u32 max_tuples;
+	phy_interface_t		phy_interface;
+	u32 dev_type;
+	u32 data_bus_width;
+	/* PHYTIUM  sel clk */
+	void (*sel_clk_hw)(struct macb *bp);
+};
+
+static inline u32 macb_reg_readl(struct macb *bp, int offset)
+{
+	return rte_le_to_cpu_32(rte_read32((void *)(bp->base + offset)));
+}
+
+static inline void macb_reg_writel(struct macb *bp, int offset, u32 value)
+{
+	rte_write32(rte_cpu_to_le_32(value), (void *)(bp->base + offset));
+}
+
+#define macb_readl(port, reg)		macb_reg_readl((port), MACB_##reg)
+#define macb_writel(port, reg, value)	macb_reg_writel((port), MACB_##reg, (value))
+#define gem_readl(port, reg)		macb_reg_readl((port), GEM_##reg)
+#define gem_writel(port, reg, value)	macb_reg_writel((port), GEM_##reg, (value))
+#define queue_readl(queue, reg)		macb_reg_readl((queue)->bp, (queue)->reg)
+#define queue_writel(queue, reg, value)	macb_reg_writel((queue)->bp, (queue)->reg, (value))
+#define macb_queue_flush(port, reg, value)	macb_reg_writel((port), (reg), (value))
+#define gem_readl_n(port, reg, idx)		macb_reg_readl((port), GEM_##reg + idx * 4)
+#define gem_writel_n(port, reg, idx, value) \
+	macb_reg_writel((port), GEM_##reg + idx * 4, (value))
+
+bool macb_is_gem(struct macb *bp);
+bool hw_is_native_io(struct macb *bp);
+u32 macb_dbw(struct macb *bp);
+void macb_probe_queues(uintptr_t base, bool native_io,
+		       unsigned int *queue_mask, unsigned int *num_queues);
+void macb_configure_caps(struct macb *bp, const struct macb_config *dt_conf);
+
+int get_last_num_from_string(char *buf, int *id);
+int macb_iomem_init(const char *name, struct macb *bp, phys_addr_t paddr);
+int macb_iomem_deinit(struct macb *bp);
+
+void macb_get_stats(struct macb *bp);
+int macb_mdio_read(struct macb *bp, uint16_t phy_id, uint32_t regnum);
+int macb_mdio_write(struct macb *bp, uint16_t phy_id, uint32_t regnum, uint16_t value);
+
+void macb_gem1p0_sel_clk(struct macb *bp);
+void macb_gem2p0_sel_clk(struct macb *bp);
+
+int macb_mac_with_pcs_config(struct macb *bp);
+
+int macb_link_change(struct macb *bp);
+void macb_check_for_link(struct macb *bp);
+void macb_setup_link(struct macb *bp);
+void macb_reset_hw(struct macb *bp);
+
+#endif /* _MACB_COMMON_H_ */
diff --git a/drivers/net/macb/base/macb_errno.h b/drivers/net/macb/base/macb_errno.h
new file mode 100644
index 0000000..5c0bce6
--- /dev/null
+++ b/drivers/net/macb/base/macb_errno.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#ifndef _MACB_ERRNO_H_
+#define _MACB_ERRNO_H_
+
+#include <errno.h>
+
+#ifndef EPERM
+#define EPERM		1
+#endif /* EPERM */
+#ifndef ENOENT
+#define ENOENT		2
+#endif /* ENOENT */
+#ifndef EIO
+#define EIO		5
+#endif /* EIO */
+#ifndef ENXIO
+#define ENXIO		6
+#endif /* ENXIO */
+#ifndef ENOMEM
+#define ENOMEM		12
+#endif /* ENOMEM */
+#ifndef EACCES
+#define EACCES		13
+#endif /* EACCES */
+#ifndef EFAULT
+#define EFAULT		14
+#endif /* EFAULT */
+#ifndef EBUSY
+#define EBUSY		16
+#endif /* EBUSY */
+#ifndef EEXIST
+#define EEXIST		17
+#endif /* EEXIST */
+#ifndef ENODEV
+#define ENODEV		19
+#endif /* ENODEV */
+#ifndef EINVAL
+#define EINVAL		22
+#endif /* EINVAL */
+#ifndef ENOSPC
+#define ENOSPC		28
+#endif /* ENOSPC */
+#ifndef ENOMSG
+#define ENOMSG		42
+#endif /* ENOMSG */
+
+#ifndef ENOBUFS
+#define ENOBUFS		105
+#endif /* ENOBUFS */
+
+#ifndef ENOTSUP
+#define ENOTSUP		252
+#endif /* ENOTSUP */
+
+#endif /* _MACB_ERRNO_H_ */
diff --git a/drivers/net/macb/base/macb_hw.h b/drivers/net/macb/base/macb_hw.h
new file mode 100644
index 0000000..c831ecf
--- /dev/null
+++ b/drivers/net/macb/base/macb_hw.h
@@ -0,0 +1,1138 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+ * Atmel MACB Ethernet Controller driver
+ * Copyright (C) 2004-2006 Atmel Corporation
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _MACB_H
+#define _MACB_H
+
+
+#define MACB_EXT_DESC
+
+#define MACB_GREGS_NBR 16
+#define MACB_GREGS_VERSION 2
+#define MACB_MAX_QUEUES 8
+#define MACB_MAX_JUMBO_FRAME 0x2800
+
+/* MACB register offsets */
+#define MACB_NCR		0x0000 /* Network Control */
+#define MACB_NCFGR		0x0004 /* Network Config */
+#define MACB_NSR		0x0008 /* Network Status */
+#define MACB_TAR		0x000c /* AT91RM9200 only */
+#define MACB_TCR		0x0010 /* AT91RM9200 only */
+#define MACB_TSR		0x0014 /* Transmit Status */
+#define MACB_RBQP		0x0018 /* RX Q Base Address */
+#define MACB_TBQP		0x001c /* TX Q Base Address */
+#define MACB_RSR		0x0020 /* Receive Status */
+#define MACB_ISR		0x0024 /* Interrupt Status */
+#define MACB_IER		0x0028 /* Interrupt Enable */
+#define MACB_IDR		0x002c /* Interrupt Disable */
+#define MACB_IMR		0x0030 /* Interrupt Mask */
+#define MACB_MAN		0x0034 /* PHY Maintenance */
+#define MACB_PTR		0x0038
+#define MACB_PFR		0x003c
+#define MACB_FTO		0x0040
+#define MACB_SCF		0x0044
+#define MACB_MCF		0x0048
+#define MACB_FRO		0x004c
+#define MACB_FCSE		0x0050
+#define MACB_ALE		0x0054
+#define MACB_DTF		0x0058
+#define MACB_LCOL		0x005c
+#define MACB_EXCOL		0x0060
+#define MACB_TUND		0x0064
+#define MACB_CSE		0x0068
+#define MACB_RRE		0x006c
+#define MACB_ROVR		0x0070
+#define MACB_RSE		0x0074
+#define MACB_ELE		0x0078
+#define MACB_RJA		0x007c
+#define MACB_USF		0x0080
+#define MACB_STE		0x0084
+#define MACB_RLE		0x0088
+#define MACB_TPF		0x008c
+#define MACB_HRB		0x0090
+#define MACB_HRT		0x0094
+#define MACB_SA1B		0x0098
+#define MACB_SA1T		0x009c
+#define MACB_SA2B		0x00a0
+#define MACB_SA2T		0x00a4
+#define MACB_SA3B		0x00a8
+#define MACB_SA3T		0x00ac
+#define MACB_SA4B		0x00b0
+#define MACB_SA4T		0x00b4
+#define MACB_TID		0x00b8
+#define MACB_TPQ		0x00bc
+#define MACB_USRIO		0x00c0
+#define MACB_WOL		0x00c4
+#define MACB_MID		0x00fc
+#define MACB_TBQPH		0x04C8
+#define MACB_RBQPH		0x04D4
+
+/* GEM register offsets. */
+#define GEM_NCR			0x0000 /* Network Config */
+#define GEM_NCFGR		0x0004 /* Network Config */
+#define GEM_USRIO		0x000c /* User IO */
+#define GEM_DMACFG		0x0010 /* DMA Configuration */
+#define GEM_JML			0x0048 /* Jumbo Max Length */
+#define GEM_HS_MAC_CONFIG       0x0050 /* Hs mac config register*/
+#define GEM_AXI_PIPE    0x0054 /* Axi max pipeline register*/
+#define GEM_HRB			0x0080 /* Hash Bottom */
+#define GEM_HRT			0x0084 /* Hash Top */
+#define GEM_SA1B		0x0088 /* Specific1 Bottom */
+#define GEM_SA1T		0x008C /* Specific1 Top */
+#define GEM_SA2B		0x0090 /* Specific2 Bottom */
+#define GEM_SA2T		0x0094 /* Specific2 Top */
+#define GEM_SA3B		0x0098 /* Specific3 Bottom */
+#define GEM_SA3T		0x009C /* Specific3 Top */
+#define GEM_SA4B		0x00A0 /* Specific4 Bottom */
+#define GEM_SA4T		0x00A4 /* Specific4 Top */
+#define GEM_EFTSH		0x00e8 /* PTP Event Frame Transmitted Seconds Register 47:32 */
+#define GEM_EFRSH		0x00ec /* PTP Event Frame Received Seconds Register 47:32 */
+#define GEM_PEFTSH		0x00f0 /* PTP Peer Event Frame Transmitted Seconds Register 47:32 */
+#define GEM_PEFRSH		0x00f4 /* PTP Peer Event Frame Received Seconds Register 47:32 */
+#define GEM_OTX			0x0100 /* Octets transmitted */
+#define GEM_OCTTXL		0x0100 /* Octets transmitted [31:0] */
+#define GEM_OCTTXH		0x0104 /* Octets transmitted [47:32] */
+#define GEM_TXCNT		0x0108 /* Frames Transmitted counter */
+#define GEM_TXBCCNT		0x010c /* Broadcast Frames counter */
+#define GEM_TXMCCNT		0x0110 /* Multicast Frames counter */
+#define GEM_TXPAUSECNT		0x0114 /* Pause Frames Transmitted Counter */
+#define GEM_TX64CNT		0x0118 /* 64 byte Frames TX counter */
+#define GEM_TX65CNT		0x011c /* 65-127 byte Frames TX counter */
+#define GEM_TX128CNT		0x0120 /* 128-255 byte Frames TX counter */
+#define GEM_TX256CNT		0x0124 /* 256-511 byte Frames TX counter */
+#define GEM_TX512CNT		0x0128 /* 512-1023 byte Frames TX counter */
+#define GEM_TX1024CNT		0x012c /* 1024-1518 byte Frames TX counter */
+#define GEM_TX1519CNT		0x0130 /* 1519+ byte Frames TX counter */
+#define GEM_TXURUNCNT		0x0134 /* TX under run error counter */
+#define GEM_SNGLCOLLCNT		0x0138 /* Single Collision Frame Counter */
+#define GEM_MULTICOLLCNT	0x013c /* Multiple Collision Frame Counter */
+#define GEM_EXCESSCOLLCNT	0x0140 /* Excessive Collision Frame Counter */
+#define GEM_LATECOLLCNT		0x0144 /* Late Collision Frame Counter */
+#define GEM_TXDEFERCNT		0x0148 /* Deferred Transmission Frame Counter */
+#define GEM_TXCSENSECNT		0x014c /* Carrier Sense Error Counter */
+#define GEM_ORX			0x0150 /* Octets received */
+#define GEM_OCTRXL		0x0150 /* Octets received [31:0] */
+#define GEM_OCTRXH		0x0154 /* Octets received [47:32] */
+#define GEM_RXCNT		0x0158 /* Frames Received Counter */
+#define GEM_RXBROADCNT		0x015c /* Broadcast Frames Received Counter */
+#define GEM_RXMULTICNT		0x0160 /* Multicast Frames Received Counter */
+#define GEM_RXPAUSECNT		0x0164 /* Pause Frames Received Counter */
+#define GEM_RX64CNT		0x0168 /* 64 byte Frames RX Counter */
+#define GEM_RX65CNT		0x016c /* 65-127 byte Frames RX Counter */
+#define GEM_RX128CNT		0x0170 /* 128-255 byte Frames RX Counter */
+#define GEM_RX256CNT		0x0174 /* 256-511 byte Frames RX Counter */
+#define GEM_RX512CNT		0x0178 /* 512-1023 byte Frames RX Counter */
+#define GEM_RX1024CNT		0x017c /* 1024-1518 byte Frames RX Counter */
+#define GEM_RX1519CNT		0x0180 /* 1519+ byte Frames RX Counter */
+#define GEM_RXUNDRCNT		0x0184 /* Undersize Frames Received Counter */
+#define GEM_RXOVRCNT		0x0188 /* Oversize Frames Received Counter */
+#define GEM_RXJABCNT		0x018c /* Jabbers Received Counter */
+#define GEM_RXFCSCNT		0x0190 /* Frame Check Sequence Error Counter */
+#define GEM_RXLENGTHCNT		0x0194 /* Length Field Error Counter */
+#define GEM_RXSYMBCNT		0x0198 /* Symbol Error Counter */
+#define GEM_RXALIGNCNT		0x019c /* Alignment Error Counter */
+#define GEM_RXRESERRCNT		0x01a0 /* Receive Resource Error Counter */
+#define GEM_RXORCNT		0x01a4 /* Receive Overrun Counter */
+#define GEM_RXIPCCNT		0x01a8 /* IP header Checksum Error Counter */
+#define GEM_RXTCPCCNT		0x01ac /* TCP Checksum Error Counter */
+#define GEM_RXUDPCCNT		0x01b0 /* UDP Checksum Error Counter */
+#define GEM_TISUBN		0x01bc /* 1588 Timer Increment Sub-ns */
+#define GEM_TSH			0x01c0 /* 1588 Timer Seconds High */
+#define GEM_TSL			0x01d0 /* 1588 Timer Seconds Low */
+#define GEM_TN			0x01d4 /* 1588 Timer Nanoseconds */
+#define GEM_TA			0x01d8 /* 1588 Timer Adjust */
+#define GEM_TI			0x01dc /* 1588 Timer Increment */
+#define GEM_EFTSL		0x01e0 /* PTP Event Frame Tx Seconds Low */
+#define GEM_EFTN		0x01e4 /* PTP Event Frame Tx Nanoseconds */
+#define GEM_EFRSL		0x01e8 /* PTP Event Frame Rx Seconds Low */
+#define GEM_EFRN		0x01ec /* PTP Event Frame Rx Nanoseconds */
+#define GEM_PEFTSL		0x01f0 /* PTP Peer Event Frame Tx Secs Low */
+#define GEM_PEFTN		0x01f4 /* PTP Peer Event Frame Tx Ns */
+#define GEM_PEFRSL		0x01f8 /* PTP Peer Event Frame Rx Sec Low */
+#define GEM_PEFRN		0x01fc /* PTP Peer Event Frame Rx Ns */
+#define GEM_PCSCTRL     0x0200 /* PCS control register*/
+#define GEM_PCSSTATUS   0x0204 /* PCS Status*/
+#define GEM_PCSANLPBASE 0x0214 /* PCS an lp base */
+#define GEM_PFCSTATUS   0x026c /* PFC status*/
+#define GEM_DCFG1		0x0280 /* Design Config 1 */
+#define GEM_DCFG2		0x0284 /* Design Config 2 */
+#define GEM_DCFG3		0x0288 /* Design Config 3 */
+#define GEM_DCFG4		0x028c /* Design Config 4 */
+#define GEM_DCFG5		0x0290 /* Design Config 5 */
+#define GEM_DCFG6		0x0294 /* Design Config 6 */
+#define GEM_DCFG7		0x0298 /* Design Config 7 */
+#define GEM_DCFG8		0x029C /* Design Config 8 */
+#define GEM_DCFG10		0x02A4 /* Design Config 10 */
+
+
+#define GEM_TXBDCTRL	0x04cc /* TX Buffer Descriptor control register */
+#define GEM_RXBDCTRL	0x04d0 /* RX Buffer Descriptor control register */
+
+/* Screener Type 2 match registers */
+#define GEM_SCRT2		0x540
+
+/* EtherType registers */
+#define GEM_ETHT		0x06E0
+
+/* Type 2 compare registers */
+#define GEM_T2CMPW0		0x0700
+#define GEM_T2CMPW1		0x0704
+#define T2CMP_OFST(t2idx)	((t2idx) * 2)
+
+/* type 2 compare registers
+ * each location requires 3 compare regs
+ */
+#define GEM_IP4SRC_CMP(idx)		((idx) * 3)
+#define GEM_IP4DST_CMP(idx)		((idx) * 3 + 1)
+#define GEM_PORT_CMP(idx)		((idx) * 3 + 2)
+
+/* Which screening type 2 EtherType register will be used (0 - 7) */
+#define SCRT2_ETHT		0
+
+#define GEM_ISR(hw_q)		(0x0400 + ((hw_q) << 2))
+#define GEM_TBQP(hw_q)		(0x0440 + ((hw_q) << 2))
+#define GEM_TBQPH(hw_q)		(0x04C8)
+#define GEM_RBQP(hw_q)		(0x0480 + ((hw_q) << 2))
+#define GEM_RBQS(hw_q)		(0x04A0 + ((hw_q) << 2))
+#define GEM_RBQPH(hw_q)		(0x04D4)
+#define GEM_IER(hw_q)		(0x0600 + ((hw_q) << 2))
+#define GEM_IDR(hw_q)		(0x0620 + ((hw_q) << 2))
+#define GEM_IMR(hw_q)		(0x0640 + ((hw_q) << 2))
+#define GEM_TXTAIL_ADDR(hw_q)		(0x0e80 + ((hw_q) << 2))
+
+#define GEM_USX_CONTROL         0x0A80  /* High speed PCS control register */
+#define GEM_USX_STATUS          0x0A88 /* High speed PCS status register */
+#define GEM_USX_FECERRCNT       0x0AD0 /* usx fec error counter */
+
+#define GEM_SRC_SEL_LN          0x1C04
+#define GEM_DIV_SEL0_LN         0x1C08
+#define GEM_DIV_SEL1_LN         0x1C0C
+#define GEM_PMA_XCVR_POWER_STATE  0x1C10
+#define GEM_SPEED_MODE          0x1C14
+#define GEM_MII_SELECT          0x1C18
+#define GEM_SEL_MII_ON_RGMII    0x1C1C
+#define GEM_TX_CLK_SEL0         0x1C20
+#define GEM_TX_CLK_SEL1         0x1C24
+#define GEM_TX_CLK_SEL2         0x1C28
+#define GEM_TX_CLK_SEL3         0x1C2C
+#define GEM_RX_CLK_SEL0         0x1C30
+#define GEM_RX_CLK_SEL1         0x1C34
+#define GEM_CLK_250M_DIV10_DIV100_SEL 0x1C38
+#define GEM_TX_CLK_SEL5         0x1C3C
+#define GEM_TX_CLK_SEL6         0x1C40
+#define GEM_RX_CLK_SEL4         0x1C44
+#define GEM_RX_CLK_SEL5         0x1C48
+#define GEM_TX_CLK_SEL3_0       0x1C70
+#define GEM_TX_CLK_SEL4_0         0x1C74
+#define GEM_RX_CLK_SEL3_0         0x1C78
+#define GEM_RX_CLK_SEL4_0         0x1C7C
+#define GEM_RGMII_TX_CLK_SEL0     0x1C80
+#define GEM_RGMII_TX_CLK_SEL1     0x1C84
+
+#define GEM_PHY_INT_ENABLE        0x1C88
+#define GEM_PHY_INT_CLEAR         0x1C8C
+#define GEM_PHY_INT_STATE         0x1C90
+
+#define GEM_INTX_IRQ_MASK         0x1C14
+
+/* Bitfields in NCR */
+#define MACB_LB_OFFSET		0 /* reserved */
+#define MACB_LB_SIZE		1
+#define MACB_LLB_OFFSET		1 /* Loop back local */
+#define MACB_LLB_SIZE		1
+#define MACB_RE_OFFSET		2 /* Receive enable */
+#define MACB_RE_SIZE		1
+#define MACB_TE_OFFSET		3 /* Transmit enable */
+#define MACB_TE_SIZE		1
+#define MACB_MPE_OFFSET		4 /* Management port enable */
+#define MACB_MPE_SIZE		1
+#define MACB_CLRSTAT_OFFSET	5 /* Clear stats regs */
+#define MACB_CLRSTAT_SIZE	1
+#define MACB_INCSTAT_OFFSET	6 /* Incremental stats regs */
+#define MACB_INCSTAT_SIZE	1
+#define MACB_WESTAT_OFFSET	7 /* Write enable stats regs */
+#define MACB_WESTAT_SIZE	1
+#define MACB_BP_OFFSET		8 /* Back pressure */
+#define MACB_BP_SIZE		1
+#define MACB_TSTART_OFFSET	9 /* Start transmission */
+#define MACB_TSTART_SIZE	1
+#define MACB_THALT_OFFSET	10 /* Transmit halt */
+#define MACB_THALT_SIZE		1
+#define MACB_NCR_TPF_OFFSET	11 /* Transmit pause frame */
+#define MACB_NCR_TPF_SIZE	1
+#define MACB_TZQ_OFFSET		12 /* Transmit zero quantum pause frame */
+#define MACB_TZQ_SIZE		1
+#define MACB_SRTSM_OFFSET	15
+#define MACB_OSSMODE_OFFSET 24 /* Enable One Step Synchro Mode */
+#define MACB_OSSMODE_SIZE	1
+#define MACB_PFC_OFFSET     25 /* Enable PFC */
+#define MACB_PFC_SIZE       1
+#define MACB_RGMII_OFFSET   28
+#define MACB_RGMII_SIZE     1
+#define MACB_2PT5G_OFFSET   29
+#define MACB_2PT5G_SIZE     1
+#define MACB_HSMAC_OFFSET   31 /* Use high speed MAC */
+#define MACB_HSMAC_SIZE     1
+
+/* GEM specific NCR bitfields. */
+#define GEM_ENABLE_HS_MAC_OFFSET 31 /* Use high speed MAC */
+#define GEM_ENABLE_HS_MAC_SIZE	1
+
+
+/* Bitfields in NCFGR */
+#define MACB_SPD_OFFSET		0 /* Speed */
+#define MACB_SPD_SIZE		1
+#define MACB_FD_OFFSET		1 /* Full duplex */
+#define MACB_FD_SIZE		1
+#define MACB_BIT_RATE_OFFSET	2 /* Discard non-VLAN frames */
+#define MACB_BIT_RATE_SIZE	1
+#define MACB_JFRAME_OFFSET	3 /* reserved */
+#define MACB_JFRAME_SIZE	1
+#define MACB_CAF_OFFSET		4 /* Copy all frames */
+#define MACB_CAF_SIZE		1
+#define MACB_NBC_OFFSET		5 /* No broadcast */
+#define MACB_NBC_SIZE		1
+#define MACB_NCFGR_MTI_OFFSET	6 /* Multicast hash enable */
+#define MACB_NCFGR_MTI_SIZE	1
+#define MACB_UNI_OFFSET		7 /* Unicast hash enable */
+#define MACB_UNI_SIZE		1
+#define MACB_BIG_OFFSET		8 /* Receive 1536 byte frames */
+#define MACB_BIG_SIZE		1
+#define MACB_EAE_OFFSET		9 /* External address match enable */
+#define MACB_EAE_SIZE		1
+#define MACB_CLK_OFFSET		10
+#define MACB_CLK_SIZE		2
+#define MACB_RTY_OFFSET		12 /* Retry test */
+#define MACB_RTY_SIZE		1
+#define MACB_PAE_OFFSET		13 /* Pause enable */
+#define MACB_PAE_SIZE		1
+#define MACB_RM9200_RMII_OFFSET	13 /* AT91RM9200 only */
+#define MACB_RM9200_RMII_SIZE	1  /* AT91RM9200 only */
+#define MACB_RBOF_OFFSET	14 /* Receive buffer offset */
+#define MACB_RBOF_SIZE		2
+#define MACB_RLCE_OFFSET	16 /* Length field error frame discard */
+#define MACB_RLCE_SIZE		1
+#define MACB_DRFCS_OFFSET	17 /* FCS remove */
+#define MACB_DRFCS_SIZE		1
+#define MACB_EFRHD_OFFSET	18
+#define MACB_EFRHD_SIZE		1
+#define MACB_IRXFCS_OFFSET	19
+#define MACB_IRXFCS_SIZE	1
+
+/* GEM specific NCFGR bitfields. */
+#define GEM_GBE_OFFSET		10 /* Gigabit mode enable */
+#define GEM_GBE_SIZE		1
+#define GEM_PCSSEL_OFFSET	11
+#define GEM_PCSSEL_SIZE		1
+#define GEM_CLK_OFFSET		18 /* MDC clock division */
+#define GEM_CLK_SIZE		3
+#define GEM_DBW_OFFSET		21 /* Data bus width */
+#define GEM_DBW_SIZE		2
+#define GEM_RXCOEN_OFFSET	24
+#define GEM_RXCOEN_SIZE		1
+#define GEM_SGMIIEN_OFFSET	27
+#define GEM_SGMIIEN_SIZE	1
+
+
+/* Constants for data bus width. */
+#define GEM_DBW32		0 /* 32 bit AMBA AHB data bus width */
+#define GEM_DBW64		1 /* 64 bit AMBA AHB data bus width */
+#define GEM_DBW128		2 /* 128 bit AMBA AHB data bus width */
+
+/* Bitfields in DMACFG. */
+#define GEM_FBLDO_OFFSET	0 /* fixed burst length for DMA */
+#define GEM_FBLDO_SIZE		5
+#define GEM_ENDIA_DESC_OFFSET	6 /* endian swap mode for management descriptor access */
+#define GEM_ENDIA_DESC_SIZE	1
+#define GEM_ENDIA_PKT_OFFSET	7 /* endian swap mode for packet data access */
+#define GEM_ENDIA_PKT_SIZE	1
+#define GEM_RXBMS_OFFSET	8 /* RX packet buffer memory size select */
+#define GEM_RXBMS_SIZE		2
+#define GEM_TXPBMS_OFFSET	10 /* TX packet buffer memory size select */
+#define GEM_TXPBMS_SIZE		1
+#define GEM_TXCOEN_OFFSET	11 /* TX IP/TCP/UDP checksum gen offload */
+#define GEM_TXCOEN_SIZE		1
+#define GEM_RXBS_OFFSET		16 /* DMA receive buffer size */
+#define GEM_RXBS_SIZE		8
+#define GEM_DDRP_OFFSET		24 /* disc_when_no_ahb */
+#define GEM_DDRP_SIZE		1
+#define GEM_RXEXT_OFFSET	28 /* RX extended Buffer Descriptor mode */
+#define GEM_RXEXT_SIZE		1
+#define GEM_TXEXT_OFFSET	29 /* TX extended Buffer Descriptor mode */
+#define GEM_TXEXT_SIZE		1
+#define GEM_ADDR64_OFFSET	30 /* Address bus width - 64b or 32b */
+#define GEM_ADDR64_SIZE		1
+
+
+/* Bitfields in NSR */
+#define MACB_NSR_LINK_OFFSET	0 /* pcs_link_state */
+#define MACB_NSR_LINK_SIZE	1
+#define MACB_MDIO_OFFSET	1 /* status of the mdio_in pin */
+#define MACB_MDIO_SIZE		1
+#define MACB_IDLE_OFFSET	2 /* The PHY management logic is idle */
+#define MACB_IDLE_SIZE		1
+
+/* Bitfields in TSR */
+#define MACB_UBR_OFFSET		0 /* Used bit read */
+#define MACB_UBR_SIZE		1
+#define MACB_COL_OFFSET		1 /* Collision occurred */
+#define MACB_COL_SIZE		1
+#define MACB_TSR_RLE_OFFSET	2 /* Retry limit exceeded */
+#define MACB_TSR_RLE_SIZE	1
+#define MACB_TGO_OFFSET		3 /* Transmit go */
+#define MACB_TGO_SIZE		1
+#define MACB_BEX_OFFSET		4 /* TX frame corruption due to AHB error */
+#define MACB_BEX_SIZE		1
+#define MACB_RM9200_BNQ_OFFSET	4 /* AT91RM9200 only */
+#define MACB_RM9200_BNQ_SIZE	1 /* AT91RM9200 only */
+#define MACB_COMP_OFFSET	5 /* Transmit complete */
+#define MACB_COMP_SIZE		1
+#define MACB_UND_OFFSET		6 /* Transmit under run */
+#define MACB_UND_SIZE		1
+
+/* Bitfields in RSR */
+#define MACB_BNA_OFFSET		0 /* Buffer not available */
+#define MACB_BNA_SIZE		1
+#define MACB_REC_OFFSET		1 /* Frame received */
+#define MACB_REC_SIZE		1
+#define MACB_OVR_OFFSET		2 /* Receive overrun */
+#define MACB_OVR_SIZE		1
+
+/* Bitfields in ISR/IER/IDR/IMR */
+#define MACB_MFD_OFFSET		0 /* Management frame sent */
+#define MACB_MFD_SIZE		1
+#define MACB_RCOMP_OFFSET	1 /* Receive complete */
+#define MACB_RCOMP_SIZE		1
+#define MACB_RXUBR_OFFSET	2 /* RX used bit read */
+#define MACB_RXUBR_SIZE		1
+#define MACB_TXUBR_OFFSET	3 /* TX used bit read */
+#define MACB_TXUBR_SIZE		1
+#define MACB_ISR_TUND_OFFSET	4 /* Enable TX buffer under run interrupt */
+#define MACB_ISR_TUND_SIZE	1
+#define MACB_ISR_RLE_OFFSET	5 /* EN retry exceeded/late coll interrupt */
+#define MACB_ISR_RLE_SIZE	1
+#define MACB_TXERR_OFFSET	6 /* EN TX frame corrupt from error interrupt */
+#define MACB_TXERR_SIZE		1
+#define MACB_TCOMP_OFFSET	7 /* Enable transmit complete interrupt */
+#define MACB_TCOMP_SIZE		1
+#define MACB_ISR_LINK_OFFSET	9 /* Enable link change interrupt */
+#define MACB_ISR_LINK_SIZE	1
+#define MACB_ISR_ROVR_OFFSET	10 /* Enable receive overrun interrupt */
+#define MACB_ISR_ROVR_SIZE	1
+#define MACB_HRESP_OFFSET	11 /* Enable hrsep not OK interrupt */
+#define MACB_HRESP_SIZE		1
+#define MACB_PFR_OFFSET		12 /* Enable pause frame w/ quantum interrupt */
+#define MACB_PFR_SIZE		1
+#define MACB_PTZ_OFFSET		13 /* Enable pause time zero interrupt */
+#define MACB_PTZ_SIZE		1
+#define MACB_WOL_OFFSET		14 /* Enable wake-on-lan interrupt */
+#define MACB_WOL_SIZE		1
+#define MACB_DRQFR_OFFSET	18 /* PTP Delay Request Frame Received */
+#define MACB_DRQFR_SIZE		1
+#define MACB_SFR_OFFSET		19 /* PTP Sync Frame Received */
+#define MACB_SFR_SIZE		1
+#define MACB_DRQFT_OFFSET	20 /* PTP Delay Request Frame Transmitted */
+#define MACB_DRQFT_SIZE		1
+#define MACB_SFT_OFFSET		21 /* PTP Sync Frame Transmitted */
+#define MACB_SFT_SIZE		1
+#define MACB_PDRQFR_OFFSET	22 /* PDelay Request Frame Received */
+#define MACB_PDRQFR_SIZE	1
+#define MACB_PDRSFR_OFFSET	23 /* PDelay Response Frame Received */
+#define MACB_PDRSFR_SIZE	1
+#define MACB_PDRQFT_OFFSET	24 /* PDelay Request Frame Transmitted */
+#define MACB_PDRQFT_SIZE	1
+#define MACB_PDRSFT_OFFSET	25 /* PDelay Response Frame Transmitted */
+#define MACB_PDRSFT_SIZE	1
+#define MACB_SRI_OFFSET		26 /* TSU Seconds Register Increment */
+#define MACB_SRI_SIZE		1
+
+/* Timer increment fields */
+#define MACB_TI_CNS_OFFSET	0
+#define MACB_TI_CNS_SIZE	8
+#define MACB_TI_ACNS_OFFSET	8
+#define MACB_TI_ACNS_SIZE	8
+#define MACB_TI_NIT_OFFSET	16
+#define MACB_TI_NIT_SIZE	8
+
+/* Bitfields in MAN */
+#define MACB_DATA_OFFSET	0 /* data */
+#define MACB_DATA_SIZE		16
+#define MACB_CODE_OFFSET	16 /* Must be written to 10 */
+#define MACB_CODE_SIZE		2
+#define MACB_REGA_OFFSET	18 /* Register address */
+#define MACB_REGA_SIZE		5
+#define MACB_PHYA_OFFSET	23 /* PHY address */
+#define MACB_PHYA_SIZE		5
+#define MACB_RW_OFFSET		28 /* Operation. 10 is read. 01 is write. */
+#define MACB_RW_SIZE		2
+#define MACB_SOF_OFFSET		30 /* Must be written to 1 for Clause 22 */
+#define MACB_SOF_SIZE		2
+
+/* Bitfields in USRIO (AVR32) */
+#define MACB_MII_OFFSET				0
+#define MACB_MII_SIZE				1
+#define MACB_EAM_OFFSET				1
+#define MACB_EAM_SIZE				1
+#define MACB_TX_PAUSE_OFFSET			2
+#define MACB_TX_PAUSE_SIZE			1
+#define MACB_TX_PAUSE_ZERO_OFFSET		3
+#define MACB_TX_PAUSE_ZERO_SIZE			1
+
+/* Bitfields in USRIO (AT91) */
+#define MACB_RMII_OFFSET			0
+#define MACB_RMII_SIZE				1
+#define GEM_RGMII_OFFSET			0 /* GEM gigabit mode */
+#define GEM_RGMII_SIZE				1
+#define MACB_CLKEN_OFFSET			1
+#define MACB_CLKEN_SIZE				1
+
+/* Bitfields in WOL */
+#define MACB_IP_OFFSET				0
+#define MACB_IP_SIZE				16
+#define MACB_MAG_OFFSET				16
+#define MACB_MAG_SIZE				1
+#define MACB_ARP_OFFSET				17
+#define MACB_ARP_SIZE				1
+#define MACB_SA1_OFFSET				18
+#define MACB_SA1_SIZE				1
+#define MACB_WOL_MTI_OFFSET			19
+#define MACB_WOL_MTI_SIZE			1
+
+/* Bitfields in MID */
+#define MACB_IDNUM_OFFSET			16
+#define MACB_IDNUM_SIZE				12
+#define MACB_REV_OFFSET				0
+#define MACB_REV_SIZE				16
+
+/* Bitfields in DCFG1. */
+#define GEM_IRQCOR_OFFSET			23
+#define GEM_IRQCOR_SIZE				1
+#define GEM_DBWDEF_OFFSET			25
+#define GEM_DBWDEF_SIZE				3
+
+/* Bitfields in DCFG2. */
+#define GEM_RX_PKT_BUFF_OFFSET			20
+#define GEM_RX_PKT_BUFF_SIZE			1
+#define GEM_TX_PKT_BUFF_OFFSET			21
+#define GEM_TX_PKT_BUFF_SIZE			1
+
+
+/* Bitfields in DCFG5. */
+#define GEM_TSU_OFFSET				8
+#define GEM_TSU_SIZE				1
+
+/* Bitfields in DCFG6. */
+#define GEM_PBUF_LSO_OFFSET			27
+#define GEM_PBUF_LSO_SIZE			1
+#define GEM_DAW64_OFFSET			23
+#define GEM_DAW64_SIZE				1
+
+/* Bitfields in DCFG8. */
+#define GEM_T1SCR_OFFSET			24
+#define GEM_T1SCR_SIZE				8
+#define GEM_T2SCR_OFFSET			16
+#define GEM_T2SCR_SIZE				8
+#define GEM_SCR2ETH_OFFSET			8
+#define GEM_SCR2ETH_SIZE			8
+#define GEM_SCR2CMP_OFFSET			0
+#define GEM_SCR2CMP_SIZE			8
+
+/* Bitfields in DCFG10 */
+#define GEM_TXBD_RDBUFF_OFFSET			12
+#define GEM_TXBD_RDBUFF_SIZE			4
+#define GEM_RXBD_RDBUFF_OFFSET			8
+#define GEM_RXBD_RDBUFF_SIZE			4
+
+/* Bitfields in TISUBN */
+#define GEM_SUBNSINCR_OFFSET			0
+#define GEM_SUBNSINCR_SIZE			24
+#define GEM_SUBNSINCRL_OFFSET			24
+#define GEM_SUBNSINCRL_SIZE			8
+#define GEM_SUBNSINCRH_OFFSET			0
+#define GEM_SUBNSINCRH_SIZE			16
+
+/* Bitfields in TI */
+#define GEM_NSINCR_OFFSET			0
+#define GEM_NSINCR_SIZE				8
+
+/* Bitfields in TSH */
+/* TSU timer value (s). MSB [47:32] of seconds timer count */
+#define GEM_TSH_OFFSET				0
+#define GEM_TSH_SIZE				16
+
+/* Bitfields in TSL */
+/* TSU timer value (s). LSB [31:0] of seconds timer count */
+#define GEM_TSL_OFFSET				0
+#define GEM_TSL_SIZE				32
+
+/* Bitfields in TN */
+#define GEM_TN_OFFSET				0 /* TSU timer value (ns) */
+#define GEM_TN_SIZE				30
+
+/* Bitfields in TXBDCTRL */
+#define GEM_TXTSMODE_OFFSET			4 /* TX Descriptor Timestamp Insertion mode */
+#define GEM_TXTSMODE_SIZE			2
+
+/* Bitfields in RXBDCTRL */
+#define GEM_RXTSMODE_OFFSET			4 /* RX Descriptor Timestamp Insertion mode */
+#define GEM_RXTSMODE_SIZE			2
+
+/* Bitfields in SCRT2 */
+#define GEM_QUEUE_OFFSET			0 /* Queue Number */
+#define GEM_QUEUE_SIZE				4
+#define GEM_VLANPR_OFFSET			4 /* VLAN Priority */
+#define GEM_VLANPR_SIZE				3
+#define GEM_VLANEN_OFFSET			8 /* VLAN Enable */
+#define GEM_VLANEN_SIZE				1
+#define GEM_ETHT2IDX_OFFSET			9 /* Index to screener type 2 EtherType register */
+#define GEM_ETHT2IDX_SIZE			3
+#define GEM_ETHTEN_OFFSET			12 /* EtherType Enable */
+#define GEM_ETHTEN_SIZE				1
+/* Compare A - Index to screener type 2 Compare register */
+#define GEM_CMPA_OFFSET				13
+#define GEM_CMPA_SIZE				5
+#define GEM_CMPAEN_OFFSET			18 /* Compare A Enable */
+#define GEM_CMPAEN_SIZE				1
+/* Compare B - Index to screener type 2 Compare register */
+#define GEM_CMPB_OFFSET				19
+#define GEM_CMPB_SIZE				5
+#define GEM_CMPBEN_OFFSET			24 /* Compare B Enable */
+#define GEM_CMPBEN_SIZE				1
+/* Compare C - Index to screener type 2 Compare register */
+#define GEM_CMPC_OFFSET				25
+#define GEM_CMPC_SIZE				5
+#define GEM_CMPCEN_OFFSET			30 /* Compare C Enable */
+#define GEM_CMPCEN_SIZE				1
+
+/* Bitfields in ETHT */
+#define GEM_ETHTCMP_OFFSET			0 /* EtherType compare value */
+#define GEM_ETHTCMP_SIZE			16
+
+/* Bitfields in T2CMPW0 */
+#define GEM_T2CMP_OFFSET			16 /* 0xFFFF0000 compare value */
+#define GEM_T2CMP_SIZE				16
+#define GEM_T2MASK_OFFSET			0 /* 0x0000FFFF compare value or mask */
+#define GEM_T2MASK_SIZE				16
+
+/* Bitfields in T2CMPW1 */
+#define GEM_T2DISMSK_OFFSET			9 /* disable mask */
+#define GEM_T2DISMSK_SIZE			1
+#define GEM_T2CMPOFST_OFFSET			7 /* compare offset */
+#define GEM_T2CMPOFST_SIZE			2
+#define GEM_T2OFST_OFFSET			0 /* offset value */
+#define GEM_T2OFST_SIZE				7
+
+/* Offset for screener type 2 compare values (T2CMPOFST).
+ * Note the offset is applied after the specified point,
+ * e.g. GEM_T2COMPOFST_ETYPE denotes the EtherType field, so an offset
+ * of 12 bytes from this would be the source IP address in an IP header
+ */
+#define GEM_T2COMPOFST_SOF	0
+#define GEM_T2COMPOFST_ETYPE	1
+#define GEM_T2COMPOFST_IPHDR	2
+#define GEM_T2COMPOFST_TCPUDP	3
+
+/* offset from EtherType to IP address */
+#define ETYPE_SRCIP_OFFSET			12
+#define ETYPE_DSTIP_OFFSET			16
+
+/* offset from IP header to port */
+#define IPHDR_SRCPORT_OFFSET		0
+#define IPHDR_DSTPORT_OFFSET		2
+
+/* Transmit DMA buffer descriptor Word 1 */
+/* timestamp has been captured in the Buffer Descriptor */
+#define GEM_DMA_TXVALID_OFFSET		23
+#define GEM_DMA_TXVALID_SIZE		1
+
+/* Receive DMA buffer descriptor Word 0 */
+#define GEM_DMA_RXVALID_OFFSET		2 /* indicates a valid timestamp in the Buffer Descriptor */
+#define GEM_DMA_RXVALID_SIZE		1
+
+/* DMA buffer descriptor Word 2 (32 bit addressing) or Word 4 (64 bit addressing) */
+#define GEM_DMA_SECL_OFFSET			30 /* Timestamp seconds[1:0]  */
+#define GEM_DMA_SECL_SIZE			2
+#define GEM_DMA_NSEC_OFFSET			0 /* Timestamp nanosecs [29:0] */
+#define GEM_DMA_NSEC_SIZE			30
+
+/* DMA buffer descriptor Word 3 (32 bit addressing) or Word 5 (64 bit addressing) */
+
+/* New hardware supports 12 bit precision of timestamp in DMA buffer descriptor.
+ * Old hardware supports only 6 bit precision but it is enough for PTP.
+ * Less accuracy is used always instead of checking hardware version.
+ */
+#define GEM_DMA_SECH_OFFSET			0 /* Timestamp seconds[5:2] */
+#define GEM_DMA_SECH_SIZE			4
+#define GEM_DMA_SEC_WIDTH			(GEM_DMA_SECH_SIZE + GEM_DMA_SECL_SIZE)
+#define GEM_DMA_SEC_TOP				(1 << GEM_DMA_SEC_WIDTH)
+#define GEM_DMA_SEC_MASK			(GEM_DMA_SEC_TOP - 1)
+
+/* Bitfields in ADJ */
+#define GEM_ADDSUB_OFFSET			31
+#define GEM_ADDSUB_SIZE				1
+/* Constants for CLK */
+#define MACB_CLK_DIV8				0
+#define MACB_CLK_DIV16				1
+#define MACB_CLK_DIV32				2
+#define MACB_CLK_DIV64				3
+
+/* GEM specific constants for CLK. */
+#define GEM_CLK_DIV8				0
+#define GEM_CLK_DIV16				1
+#define GEM_CLK_DIV32				2
+#define GEM_CLK_DIV48				3
+#define GEM_CLK_DIV64				4
+#define GEM_CLK_DIV96				5
+#define GEM_CLK_DIV128              6
+#define GEM_CLK_DIV224              7
+
+/* Constants for MAN register */
+#define MACB_MAN_C22_SOF            1
+#define MACB_MAN_C22_WRITE          1
+#define MACB_MAN_C22_READ           2
+#define MACB_MAN_C22_CODE           2
+
+#define MACB_MAN_C45_SOF            0
+#define MACB_MAN_C45_ADDR           0
+#define MACB_MAN_C45_WRITE          1
+#define MACB_MAN_C45_POST_READ_INCR     2
+#define MACB_MAN_C45_READ           3
+#define MACB_MAN_C45_CODE           2
+
+/* Capability mask bits */
+#define MACB_CAPS_ISR_CLEAR_ON_WRITE        0x00000001
+#define MACB_CAPS_USRIO_HAS_CLKEN           0x00000002
+#define MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII 0x00000004
+#define MACB_CAPS_NO_GIGABIT_HALF           0x00000008
+#define MACB_CAPS_USRIO_DISABLED            0x00000010
+#define MACB_CAPS_JUMBO                     0x00000020
+#define MACB_CAPS_GEM_HAS_PTP               0x00000040
+#define MACB_CAPS_BD_RD_PREFETCH            0x00000080
+#define MACB_CAPS_NEEDS_RSTONUBR            0x00000100
+#define MACB_CAPS_SEL_CLK                   0x00000200
+#define MACB_CAPS_PERFORMANCE_OPTIMIZING    0x00000400
+#define MACB_CAPS_FIFO_MODE                 0x10000000
+#define MACB_CAPS_GIGABIT_MODE_AVAILABLE    0x20000000
+#define MACB_CAPS_SG_DISABLED               0x40000000
+#define MACB_CAPS_MACB_IS_GEM               0x80000000
+#define MACB_CAPS_SEL_CLK_HW                0x00001000
+
+
+/*GEM PCS status register bitfields*/
+#define GEM_LINKSTATUS_OFFSET    2
+#define GEM_LINKSTATUS_SIZE      1
+
+/*GEM usx status register bitfields*/
+#define GEM_BLOCK_LOCK_OFFSET    0
+#define GEM_BLOCK_LOCK_SIZE      1
+
+
+/*GEM hs mac config register bitfields*/
+#define GEM_HSMACSPEED_OFFSET    0
+#define GEM_HSMACSPEED_SIZE      3
+/*GEM pcs_an_lp_base register bitfields*/
+#define GEM_SGMIISPEED_OFFSET   10
+#define GEM_SGMIISPEED_SIZE     2
+#define GEM_SGMIIDUPLEX_OFFSET  12
+#define GEM_SGMIIDUPLEX_SIZE    1
+
+/*GEM pcs control register bitfields*/
+#define GEM_AUTONEG_OFFSET    12
+#define GEM_AUTONEG_SIZE      1
+/*pcs_an_lp_base register bitfields*/
+#define GEM_SPEEDR_OFFSET 10
+#define GEM_SPEEDR_SIZE   2
+#define GEM_DUPLEX_OFFSET 12
+#define GEM_DUPLEX_SIZE   1
+
+/* Bitfields in USX_CONTROL. */
+#define GEM_SIGNAL_OK_OFFSET            0
+#define GEM_SIGNAL_OK_SIZE              1
+#define GEM_TX_EN_OFFSET                1
+#define GEM_TX_EN_SIZE                  1
+#define GEM_RX_SYNC_RESET_OFFSET        2
+#define GEM_RX_SYNC_RESET_SIZE          1
+#define GEM_FEC_ENABLE_OFFSET           4
+#define GEM_FEC_ENABLE_SIZE             1
+#define GEM_FEC_ENA_ERR_IND_OFFSET      5
+#define GEM_FEC_ENA_ERR_IND_SIZE        1
+#define GEM_TX_SCR_BYPASS_OFFSET        8
+#define GEM_TX_SCR_BYPASS_SIZE          1
+#define GEM_RX_SCR_BYPASS_OFFSET        9
+#define GEM_RX_SCR_BYPASS_SIZE          1
+#define GEM_SERDES_RATE_OFFSET          12
+#define GEM_SERDES_RATE_SIZE            2
+#define GEM_USX_CTRL_SPEED_OFFSET       14
+#define GEM_USX_CTRL_SPEED_SIZE         3
+
+/* LSO settings */
+#define MACB_LSO_UFO_ENABLE			0x01
+#define MACB_LSO_TSO_ENABLE			0x02
+
+/* Bitfield in HS_MAC_CONFIG */
+#define GEM_HS_MAC_SPEED_OFFSET			0
+#define GEM_HS_MAC_SPEED_SIZE			3
+
+/* Bitfield in pcs control */
+#define GEM_PCS_AUTO_NEG_ENB_OFFSET			12
+#define GEM_PCS_AUTO_NEG_ENB_SIZE			1
+
+
+/* USXGMII/SGMII/RGMII speed */
+#define GEM_SPEED_100   0
+#define GEM_SPEED_1000  1
+#define GEM_SPEED_2500  2
+#define GEM_SPEED_5000  3
+#define GEM_SPEED_10000 4
+#define GEM_SPEED_25000 5
+#define MACB_SERDES_RATE_5G		0
+#define MACB_SERDES_RATE_10G	1
+
+
+/* Bit manipulation macros */
+#define MACB_BIT(name)					\
+	(1 << MACB_##name##_OFFSET)
+#define MACB_BF(name, value)				\
+	(((value) & ((1 << MACB_##name##_SIZE) - 1))	\
+	 << MACB_##name##_OFFSET)
+#define MACB_BFEXT(name, value)\
+	(((value) >> MACB_##name##_OFFSET)		\
+	 & ((1 << MACB_##name##_SIZE) - 1))
+#define MACB_BFINS(name, value, old)			\
+	(((old) & ~(((1 << MACB_##name##_SIZE) - 1)	\
+		    << MACB_##name##_OFFSET))		\
+	 | MACB_BF(name, value))
+
+#define GEM_BIT(name)					\
+	(1 << GEM_##name##_OFFSET)
+#define GEM_BF(name, value)				\
+	(((value) & ((1 << GEM_##name##_SIZE) - 1))	\
+	 << GEM_##name##_OFFSET)
+#define GEM_BFEXT(name, value)\
+	(((value) >> GEM_##name##_OFFSET)		\
+	 & ((1 << GEM_##name##_SIZE) - 1))
+#define GEM_BFINS(name, value, old)			\
+	(((old) & ~(((1 << GEM_##name##_SIZE) - 1)	\
+		    << GEM_##name##_OFFSET))		\
+	 | GEM_BF(name, value))
+
+#define PTP_TS_BUFFER_SIZE		128 /* must be power of 2 */
+
+/* Conditional GEM/MACB macros.  These perform the operation to the correct
+ * register dependent on whether the device is a GEM or a MACB.  For registers
+ * and bitfields that are common across both devices, use macb_{read,write}l
+ * to avoid the cost of the conditional.
+ */
+#define macb_or_gem_writel(__bp, __reg, __value) \
+	({ \
+		if (macb_is_gem((__bp))) \
+			gem_writel((__bp), __reg, __value); \
+		else \
+			macb_writel((__bp), __reg, __value); \
+	})
+
+#define macb_or_gem_readl(__bp, __reg) \
+	({ \
+		u32 __v; \
+		if (macb_is_gem((__bp))) \
+			__v = gem_readl((__bp), __reg); \
+		else \
+			__v = macb_readl((__bp), __reg); \
+		__v; \
+	})
+
+#ifdef MACB_EXT_DESC
+#define HW_DMA_CAP_32B		0
+#define HW_DMA_CAP_64B		(1 << 0)
+#define HW_DMA_CAP_PTP		(1 << 1)
+#define HW_DMA_CAP_64B_PTP	(HW_DMA_CAP_64B | HW_DMA_CAP_PTP)
+#endif
+
+/* DMA descriptor bitfields */
+#define MACB_RX_USED_OFFSET			0
+#define MACB_RX_USED_SIZE			1
+#define MACB_RX_WRAP_OFFSET			1
+#define MACB_RX_WRAP_SIZE			1
+#define MACB_RX_WADDR_OFFSET			2
+#define MACB_RX_WADDR_SIZE			30
+
+#define MACB_RX_FRMLEN_OFFSET			0
+#define MACB_RX_FRMLEN_SIZE			12
+#define MACB_RX_OFFSET_OFFSET			12
+#define MACB_RX_SOF_OFFSET			14
+#define MACB_RX_OFFSET_SIZE			2
+#define MACB_RX_SOF_SIZE			1
+#define MACB_RX_EOF_OFFSET			15
+#define MACB_RX_EOF_SIZE			1
+#define MACB_RX_CFI_OFFSET			16
+#define MACB_RX_CFI_SIZE			1
+#define MACB_RX_VLAN_PRI_OFFSET			17
+#define MACB_RX_VLAN_PRI_SIZE			3
+#define MACB_RX_PRI_TAG_OFFSET			20
+#define MACB_RX_PRI_TAG_SIZE			1
+#define MACB_RX_VLAN_TAG_OFFSET			21
+#define MACB_RX_VLAN_TAG_SIZE			1
+#define MACB_RX_TYPEID_MATCH_OFFSET		22
+#define MACB_RX_TYPEID_MATCH_SIZE		1
+#define MACB_RX_SA4_MATCH_OFFSET		23
+#define MACB_RX_SA4_MATCH_SIZE			1
+#define MACB_RX_SA3_MATCH_OFFSET		24
+#define MACB_RX_SA3_MATCH_SIZE			1
+#define MACB_RX_SA2_MATCH_OFFSET		25
+#define MACB_RX_SA2_MATCH_SIZE			1
+#define MACB_RX_SA1_MATCH_OFFSET		26
+#define MACB_RX_SA1_MATCH_SIZE			1
+#define MACB_RX_EXT_MATCH_OFFSET		28
+#define MACB_RX_EXT_MATCH_SIZE			1
+#define MACB_RX_UHASH_MATCH_OFFSET		29
+#define MACB_RX_UHASH_MATCH_SIZE		1
+#define MACB_RX_MHASH_MATCH_OFFSET		30
+#define MACB_RX_MHASH_MATCH_SIZE		1
+#define MACB_RX_BROADCAST_OFFSET		31
+#define MACB_RX_BROADCAST_SIZE			1
+
+#define MACB_RX_FRMLEN_MASK			0xFFF
+#define MACB_RX_JFRMLEN_MASK			0x3FFF
+
+/* RX checksum offload disabled: bit 24 clear in NCFGR */
+#define GEM_RX_TYPEID_MATCH_OFFSET		22
+#define GEM_RX_TYPEID_MATCH_SIZE		2
+
+/* RX checksum offload enabled: bit 24 set in NCFGR */
+#define GEM_RX_CSUM_OFFSET			22
+#define GEM_RX_CSUM_SIZE			2
+
+#define MACB_TX_FRMLEN_OFFSET			0
+#define MACB_TX_FRMLEN_SIZE			11
+#define MACB_TX_LAST_OFFSET			15
+#define MACB_TX_LAST_SIZE			1
+#define MACB_TX_NOCRC_OFFSET			16
+#define MACB_TX_NOCRC_SIZE			1
+#define MACB_MSS_MFS_OFFSET			16
+#define MACB_MSS_MFS_SIZE			14
+#define MACB_TX_LSO_OFFSET			17
+#define MACB_TX_LSO_SIZE			2
+#define MACB_TX_TCP_SEQ_SRC_OFFSET		19
+#define MACB_TX_TCP_SEQ_SRC_SIZE		1
+#define MACB_TX_BUF_EXHAUSTED_OFFSET		27
+#define MACB_TX_BUF_EXHAUSTED_SIZE		1
+#define MACB_TX_UNDERRUN_OFFSET			28
+#define MACB_TX_UNDERRUN_SIZE			1
+#define MACB_TX_ERROR_OFFSET			29
+#define MACB_TX_ERROR_SIZE			1
+#define MACB_TX_WRAP_OFFSET			30
+#define MACB_TX_WRAP_SIZE			1
+#define MACB_TX_USED_OFFSET			31
+#define MACB_TX_USED_SIZE			1
+
+#define GEM_TX_FRMLEN_OFFSET			0
+#define GEM_TX_FRMLEN_SIZE			14
+
+/* Buffer descriptor constants */
+#define GEM_RX_CSUM_NONE			0
+#define GEM_RX_CSUM_IP_ONLY			1
+#define GEM_RX_CSUM_IP_TCP			2
+#define GEM_RX_CSUM_IP_UDP			3
+
+/* limit RX checksum offload to TCP and UDP packets */
+#define GEM_RX_CSUM_CHECKED_MASK		2
+
+/* Hardware-collected statistics. Used when updating the network
+ * device stats by a periodic timer.
+ */
+struct macb_stats {
+	u64 rx_pause_frames;
+	u64 tx_ok;
+	u64 tx_single_cols;
+	u64 tx_multiple_cols;
+	u64 rx_ok;
+	u64 rx_fcs_errors;
+	u64 rx_align_errors;
+	u64 tx_deferred;
+	u64 tx_late_cols;
+	u64 tx_excessive_cols;
+	u64 tx_underruns;
+	u64 tx_carrier_errors;
+	u64 rx_resource_errors;
+	u64 rx_overruns;
+	u64 rx_symbol_errors;
+	u64 rx_oversize_pkts;
+	u64 rx_jabbers;
+	u64 rx_undersize_pkts;
+	u64 sqe_test_errors;
+	u64 rx_length_mismatch;
+	u64 tx_pause_frames;
+};
+
+struct gem_stats {
+	u64 tx_octets_31_0;
+	u64 tx_octets_47_32;
+	u64 tx_frames;
+	u64 tx_broadcast_frames;
+	u64 tx_multicast_frames;
+	u64 tx_pause_frames;
+	u64 tx_64_byte_frames;
+	u64 tx_65_127_byte_frames;
+	u64 tx_128_255_byte_frames;
+	u64 tx_256_511_byte_frames;
+	u64 tx_512_1023_byte_frames;
+	u64 tx_1024_1518_byte_frames;
+	u64 tx_greater_than_1518_bytes;
+	u64 tx_underrun;
+	u64 tx_single_collision_frames;
+	u64 tx_multiple_collision_frames;
+	u64 tx_excessive_collisions;
+	u64 tx_late_collisions;
+	u64 tx_deferred_frames;
+	u64 tx_carrier_sense_errors;
+	u64 rx_octets_31_0;
+	u64 rx_octets_47_32;
+	u64 rx_frames;
+	u64 rx_broadcast_frames;
+	u64 rx_multicast_frames;
+	u64 rx_pause_frames;
+	u64 rx_64_byte_frames;
+	u64 rx_65_127_byte_frames;
+	u64 rx_128_255_byte_frames;
+	u64 rx_256_511_byte_frames;
+	u64 rx_512_1023_byte_frames;
+	u64 rx_1024_1518_byte_frames;
+	u64 rx_greater_than_1518_bytes;
+	u64 rx_undersized_frames;
+	u64 rx_oversize_frames;
+	u64 rx_jabbers;
+	u64 rx_frame_check_sequence_errors;
+	u64 rx_length_field_frame_errors;
+	u64 rx_symbol_errors;
+	u64 rx_alignment_errors;
+	u64 rx_resource_drops;
+	u64 rx_overruns;
+	u64 rx_ip_header_checksum_errors;
+	u64 rx_tcp_checksum_errors;
+	u64 rx_udp_checksum_errors;
+};
+
+/* Describes the name and offset of an individual statistic register, as
+ * returned by `ethtool -S`. Also describes which net_device_stats statistics
+ * this register should contribute to.
+ */
+struct gem_statistic {
+	char stat_string[ETH_GSTRING_LEN];
+	int offset;
+	u32 stat_bits;
+};
+
+/* Bitfield defs for net_device_stat statistics */
+#define GEM_NDS_RXERR_OFFSET		0
+#define GEM_NDS_RXLENERR_OFFSET		1
+#define GEM_NDS_RXOVERERR_OFFSET	2
+#define GEM_NDS_RXCRCERR_OFFSET		3
+#define GEM_NDS_RXFRAMEERR_OFFSET	4
+#define GEM_NDS_RXFIFOERR_OFFSET	5
+#define GEM_NDS_TXERR_OFFSET		6
+#define GEM_NDS_TXABORTEDERR_OFFSET	7
+#define GEM_NDS_TXCARRIERERR_OFFSET	8
+#define GEM_NDS_TXFIFOERR_OFFSET	9
+#define GEM_NDS_COLLISIONS_OFFSET	10
+
+#define GEM_STAT_TITLE(name, title) GEM_STAT_TITLE_BITS(name, title, 0)
+#define GEM_STAT_TITLE_BITS(name, title, bits) {	\
+	.stat_string = title,				\
+	.offset = GEM_##name,				\
+	.stat_bits = bits				\
+}
+
+/* list of gem statistic registers. The names MUST match the
+ * corresponding GEM_* definitions.
+ */
+static const struct gem_statistic gem_statistics[] = {
+	GEM_STAT_TITLE(OCTTXL, "tx_octets"), /* OCTTXH combined with OCTTXL */
+	GEM_STAT_TITLE(TXCNT, "tx_frames"),
+	GEM_STAT_TITLE(TXBCCNT, "tx_broadcast_frames"),
+	GEM_STAT_TITLE(TXMCCNT, "tx_multicast_frames"),
+	GEM_STAT_TITLE(TXPAUSECNT, "tx_pause_frames"),
+	GEM_STAT_TITLE(TX64CNT, "tx_64_byte_frames"),
+	GEM_STAT_TITLE(TX65CNT, "tx_65_127_byte_frames"),
+	GEM_STAT_TITLE(TX128CNT, "tx_128_255_byte_frames"),
+	GEM_STAT_TITLE(TX256CNT, "tx_256_511_byte_frames"),
+	GEM_STAT_TITLE(TX512CNT, "tx_512_1023_byte_frames"),
+	GEM_STAT_TITLE(TX1024CNT, "tx_1024_1518_byte_frames"),
+	GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_bytes"),
+	GEM_STAT_TITLE_BITS(TXURUNCNT, "tx_underrun",
+			    GEM_BIT(NDS_TXERR) | GEM_BIT(NDS_TXFIFOERR)),
+	GEM_STAT_TITLE_BITS(SNGLCOLLCNT, "tx_single_collision_frames",
+			    GEM_BIT(NDS_TXERR) | GEM_BIT(NDS_COLLISIONS)),
+	GEM_STAT_TITLE_BITS(MULTICOLLCNT, "tx_multiple_collision_frames",
+			    GEM_BIT(NDS_TXERR) | GEM_BIT(NDS_COLLISIONS)),
+	GEM_STAT_TITLE_BITS(EXCESSCOLLCNT, "tx_excessive_collisions", GEM_BIT(NDS_TXERR) |
+			    GEM_BIT(NDS_TXABORTEDERR) | GEM_BIT(NDS_COLLISIONS)),
+	GEM_STAT_TITLE_BITS(LATECOLLCNT, "tx_late_collisions",
+			    GEM_BIT(NDS_TXERR) | GEM_BIT(NDS_COLLISIONS)),
+	GEM_STAT_TITLE(TXDEFERCNT, "tx_deferred_frames"),
+	GEM_STAT_TITLE_BITS(TXCSENSECNT, "tx_carrier_sense_errors",
+			    GEM_BIT(NDS_TXERR) | GEM_BIT(NDS_COLLISIONS)),
+	GEM_STAT_TITLE(OCTRXL, "rx_octets"), /* OCTRXH combined with OCTRXL */
+	GEM_STAT_TITLE(RXCNT, "rx_frames"),
+	GEM_STAT_TITLE(RXBROADCNT, "rx_broadcast_frames"),
+	GEM_STAT_TITLE(RXMULTICNT, "rx_multicast_frames"),
+	GEM_STAT_TITLE(RXPAUSECNT, "rx_pause_frames"),
+	GEM_STAT_TITLE(RX64CNT, "rx_64_byte_frames"),
+	GEM_STAT_TITLE(RX65CNT, "rx_65_127_byte_frames"),
+	GEM_STAT_TITLE(RX128CNT, "rx_128_255_byte_frames"),
+	GEM_STAT_TITLE(RX256CNT, "rx_256_511_byte_frames"),
+	GEM_STAT_TITLE(RX512CNT, "rx_512_1023_byte_frames"),
+	GEM_STAT_TITLE(RX1024CNT, "rx_1024_1518_byte_frames"),
+	GEM_STAT_TITLE(RX1519CNT, "rx_greater_than_1518_bytes"),
+	GEM_STAT_TITLE_BITS(RXUNDRCNT, "rx_undersized_frames",
+			    GEM_BIT(NDS_RXERR) | GEM_BIT(NDS_RXLENERR)),
+	GEM_STAT_TITLE_BITS(RXOVRCNT, "rx_oversize_frames",
+			    GEM_BIT(NDS_RXERR) | GEM_BIT(NDS_RXLENERR)),
+	GEM_STAT_TITLE_BITS(RXJABCNT, "rx_jabbers", GEM_BIT(NDS_RXERR) | GEM_BIT(NDS_RXLENERR)),
+	GEM_STAT_TITLE_BITS(RXFCSCNT, "rx_frame_check_sequence_errors",
+			    GEM_BIT(NDS_RXERR) | GEM_BIT(NDS_RXCRCERR)),
+	GEM_STAT_TITLE_BITS(RXLENGTHCNT, "rx_length_field_frame_errors", GEM_BIT(NDS_RXERR)),
+	GEM_STAT_TITLE_BITS(RXSYMBCNT, "rx_symbol_errors",
+			    GEM_BIT(NDS_RXERR) | GEM_BIT(NDS_RXFRAMEERR)),
+	GEM_STAT_TITLE_BITS(RXALIGNCNT, "rx_alignment_errors",
+			    GEM_BIT(NDS_RXERR) | GEM_BIT(NDS_RXOVERERR)),
+	GEM_STAT_TITLE_BITS(RXRESERRCNT, "rx_resource_errors",
+			    GEM_BIT(NDS_RXERR) | GEM_BIT(NDS_RXOVERERR)),
+	GEM_STAT_TITLE_BITS(RXORCNT, "rx_overruns", GEM_BIT(NDS_RXERR) | GEM_BIT(NDS_RXFIFOERR)),
+	GEM_STAT_TITLE_BITS(RXIPCCNT, "rx_ip_header_checksum_errors", GEM_BIT(NDS_RXERR)),
+	GEM_STAT_TITLE_BITS(RXTCPCCNT, "rx_tcp_checksum_errors", GEM_BIT(NDS_RXERR)),
+	GEM_STAT_TITLE_BITS(RXUDPCCNT, "rx_udp_checksum_errors", GEM_BIT(NDS_RXERR)),
+};
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+#define GEM_STATS_LEN ARRAY_SIZE(gem_statistics)
+
+#define QUEUE_STAT_TITLE(title) {	\
+	.stat_string = title,			\
+}
+
+#define QUEUE_STATS_LEN ARRAY_SIZE(queue_statistics)
+
+#ifdef CONFIG_MACB_USE_HWSTAMP
+#define GEM_TSEC_SIZE  (GEM_TSH_SIZE + GEM_TSL_SIZE)
+#define TSU_SEC_MAX_VAL (((u64)1 << GEM_TSEC_SIZE) - 1)
+#define TSU_NSEC_MAX_VAL ((1 << GEM_TN_SIZE) - 1)
+
+enum macb_bd_control {
+	TSTAMP_DISABLED,
+	TSTAMP_FRAME_PTP_EVENT_ONLY,
+	TSTAMP_ALL_PTP_FRAMES,
+	TSTAMP_ALL_FRAMES,
+};
+
+/* Register access macros */
+#define readl_relaxed(c)	({ u32 __r = le32_tc_cpu((__force __le32)__raw_readl(c)); __r; })
+
+#endif /* CONFIG_MACB_USE_HWSTAMP */
+
+#endif /* _MACB_H */
diff --git a/drivers/net/macb/base/macb_type.h b/drivers/net/macb/base/macb_type.h
new file mode 100644
index 0000000..326c614
--- /dev/null
+++ b/drivers/net/macb/base/macb_type.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#ifndef _MACB_TYPE_H_
+#define _MACB_TYPE_H_
+
+#include <stdint.h>
+#include <inttypes.h>
+
+typedef uint8_t     u8;
+typedef uint16_t    u16;
+typedef uint32_t    u32;
+typedef uint64_t    u64;
+typedef int8_t      s8;
+typedef int16_t     s16;
+typedef int32_t     s32;
+typedef int64_t     s64;
+
+typedef u64 dma_addr_t;
+typedef u64 phys_addr_t;
+
+#endif /* _MACB_TYPE_H */
diff --git a/drivers/net/macb/base/macb_uio.c b/drivers/net/macb/base/macb_uio.c
new file mode 100644
index 0000000..19b757d
--- /dev/null
+++ b/drivers/net/macb/base/macb_uio.c
@@ -0,0 +1,351 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+#include <dirent.h>
+
+#include "macb_uio.h"
+
+#define MACB_UIO_DRV_DIR "/sys/bus/platform/drivers/macb_uio"
+#define UIO_DEV_DIR "/sys/class/uio"
+
+static int udev_id_from_filename(char *name)
+{
+	enum scan_states { ss_u, ss_i, ss_o, ss_num, ss_err };
+	enum scan_states state = ss_u;
+	int i = 0, num = -1;
+	char ch = name[0];
+	while (ch && (state != ss_err)) {
+		switch (ch) {
+		case 'u':
+			if (state == ss_u)
+				state = ss_i;
+			else
+				state = ss_err;
+			break;
+		case 'i':
+			if (state == ss_i)
+				state = ss_o;
+			else
+				state = ss_err;
+			break;
+		case 'o':
+			if (state == ss_o)
+				state = ss_num;
+			else
+				state = ss_err;
+			break;
+		default:
+			if ((ch >= '0') && (ch <= '9') && state == ss_num) {
+				if (num < 0)
+					num = (ch - '0');
+				else
+					num = (num * 10) + (ch - '0');
+			} else {
+				state = ss_err;
+			}
+		}
+		i++;
+		ch = name[i];
+	}
+	if (state == ss_err)
+		num = -1;
+	return num;
+}
+
+static int line_buf_from_filename(char *filename, char *linebuf)
+{
+	char *s;
+	int i;
+	FILE *file = fopen(filename, "r");
+
+	if (!file)
+		return -1;
+
+	memset(linebuf, 0, UIO_MAX_NAME_SIZE);
+	s = fgets(linebuf, UIO_MAX_NAME_SIZE, file);
+	if (!s) {
+		fclose(file);
+		return -2;
+	}
+	for (i = 0; (*s) && (i < UIO_MAX_NAME_SIZE); i++) {
+		if (*s == '\n')
+			*s = '\0';
+		s++;
+	}
+	fclose(file);
+	return 0;
+}
+
+static int uio_get_map_size(const int udev_id, uint64_t *map_size)
+{
+	int ret;
+	char filename[64];
+
+	*map_size = UIO_INVALID_SIZE;
+	snprintf(filename, sizeof(filename), "%s/uio%d/maps/map0/size",
+			 UIO_DEV_DIR, udev_id);
+
+	FILE *file = fopen(filename, "r");
+	if (!file)
+		return -1;
+
+	ret = fscanf(file, "0x%" PRIx64, map_size);
+	fclose(file);
+	if (ret < 0)
+		return -2;
+
+	return 0;
+}
+
+static int uio_get_map_addr(const int udev_id, uint64_t *map_addr)
+{
+	int ret;
+	char filename[64];
+
+	*map_addr = UIO_INVALID_ADDR;
+	snprintf(filename, sizeof(filename), "%s/uio%d/maps/map0/addr",
+			 UIO_DEV_DIR, udev_id);
+
+	FILE *file = fopen(filename, "r");
+	if (!file)
+		return -1;
+
+	ret = fscanf(file, "0x%" PRIx64, map_addr);
+	fclose(file);
+	if (ret < 0)
+		return -2;
+
+	return 0;
+}
+
+static int uio_get_map_name(const int udev_id, char *map_name)
+{
+	char filename[64];
+
+	snprintf(filename, sizeof(filename), "%s/uio%d/maps/map0/name",
+			 UIO_DEV_DIR, udev_id);
+
+	return line_buf_from_filename(filename, map_name);
+}
+
+static int uio_get_info_name(const int udev_id, char *info_name)
+{
+	char filename[64];
+
+	snprintf(filename, sizeof(filename), "%s/uio%d/name",
+			 UIO_DEV_DIR, udev_id);
+
+	return line_buf_from_filename(filename, info_name);
+}
+
+static int uio_get_info_version(const int udev_id, char *info_ver)
+{
+	char filename[64];
+
+	snprintf(filename, sizeof(filename), "%s/uio%d/version",
+			 UIO_DEV_DIR, udev_id);
+
+	return line_buf_from_filename(filename, info_ver);
+}
+
+static int uio_get_info_event_count(const int udev_id, unsigned long *event_count)
+{
+	int ret;
+	char filename[64];
+
+	*event_count = 0;
+	snprintf(filename, sizeof(filename), "%s/uio%d/event",
+			 UIO_DEV_DIR, udev_id);
+
+	FILE *file = fopen(filename, "r");
+	if (!file)
+		return -1;
+
+	ret = fscanf(file, "%d", (int *)event_count);
+	fclose(file);
+	if (ret < 0)
+		return -2;
+
+	return 0;
+}
+
+static int uio_get_udev_id(const char *name, int *udev_id)
+{
+	struct dirent **namelist;
+	int n, len;
+	char filename[64];
+	char buf[256];
+
+	n = scandir(UIO_DEV_DIR, &namelist, 0, alphasort);
+	if (n <= 0) {
+		MACB_LOG(ERR,
+				 "scandir for %s "
+				 "failed, errno = %d (%s)",
+				 UIO_DEV_DIR, errno, strerror(errno));
+		return 0;
+	}
+
+	while (n--) {
+		snprintf(filename, sizeof(filename), "%s/%s", UIO_DEV_DIR,
+				 namelist[n]->d_name);
+		len = readlink(filename, buf, sizeof(buf) - 1);
+		if (len != -1)
+			buf[len] = '\0';
+		if (strstr(buf, name)) {
+			*udev_id = udev_id_from_filename(namelist[n]->d_name);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int uio_get_all_info(struct macb_iomem *iomem)
+{
+	struct uio_info *info = iomem->info;
+	struct uio_map *map = &info->map;
+	char *name = iomem->name;
+
+	if (!info)
+		return -EINVAL;
+
+	uio_get_udev_id(name, &iomem->udev_id);
+
+	uio_get_info_name(iomem->udev_id, info->name);
+	uio_get_info_version(iomem->udev_id, info->version);
+	uio_get_info_event_count(iomem->udev_id, &info->event_count);
+	uio_get_map_name(iomem->udev_id, map->name);
+	uio_get_map_addr(iomem->udev_id, &map->addr);
+	uio_get_map_size(iomem->udev_id, &map->size);
+
+	return 0;
+}
+
+int macb_uio_exist(const char *name)
+{
+	struct dirent **namelist;
+	int n, ret = 0;
+
+	n = scandir(MACB_UIO_DRV_DIR, &namelist,
+				0, alphasort);
+	if (n <= 0) {
+		MACB_LOG(ERR,
+				 "scandir for %s "
+				 "failed, errno = %d (%s)",
+				 MACB_UIO_DRV_DIR, errno, strerror(errno));
+		return 0;
+	}
+
+	while (n--) {
+		if (!strncmp(namelist[n]->d_name, name, strlen(name)))
+			ret = 1;
+	}
+
+	return ret;
+}
+
+int macb_uio_init(const char *name, struct macb_iomem **iomem)
+{
+	struct macb_iomem *new;
+	int ret;
+
+	new = malloc(sizeof(struct macb_iomem));
+	if (!new) {
+		MACB_LOG(ERR, "No memory for IOMEM obj.");
+		return -ENOMEM;
+	}
+	memset(new, 0, sizeof(struct macb_iomem));
+
+	new->name = strdup(name);
+	if (!new->name) {
+		MACB_LOG(ERR, "No memory for IOMEM-name obj.");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	new->info = malloc(sizeof(struct uio_info));
+	if (!new->info) {
+		ret = -ENOSPC;
+		goto out_free_name;
+	}
+
+	uio_get_all_info(new);
+
+	*iomem = new;
+
+	return 0;
+
+out_free_name:
+	free(new->name);
+out_free:
+	free(new);
+
+	return ret;
+}
+
+void macb_uio_deinit(struct macb_iomem *iomem)
+{
+	free(iomem->info);
+	free(iomem->name);
+	free(iomem);
+}
+
+static void *uio_single_mmap(struct uio_info *info, int fd, phys_addr_t paddr)
+{
+	unsigned long pagesize;
+	size_t offset;
+
+	if (!fd)
+		return NULL;
+
+	if (info->map.size == UIO_INVALID_SIZE)
+		return NULL;
+
+	pagesize = getpagesize();
+	offset = paddr - (paddr & ~((unsigned long)pagesize - 1));
+	info->map.internal_addr =
+		mmap(NULL, info->map.size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+	if (info->map.internal_addr != MAP_FAILED) {
+		info->map.internal_addr = (void *)((unsigned long)info->map.internal_addr + offset);
+		return info->map.internal_addr;
+	}
+
+	return NULL;
+}
+
+static void uio_single_munmap(struct uio_info *info)
+{
+	munmap(info->map.internal_addr, info->map.size);
+}
+
+int macb_uio_map(struct macb_iomem *iomem, phys_addr_t *pa, void **va, phys_addr_t paddr)
+{
+	if (iomem->fd <= 0) {
+		char dev_name[16];
+		snprintf(dev_name, sizeof(dev_name), "/dev/uio%d",
+				 iomem->udev_id);
+		iomem->fd = open(dev_name, O_RDWR);
+	}
+
+	if (iomem->fd > 0) {
+		*va = uio_single_mmap(iomem->info, iomem->fd, paddr);
+		if (!*va)
+			return -EINVAL;
+
+		if (pa)
+			*pa = paddr;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int macb_uio_unmap(struct macb_iomem *iomem)
+{
+	uio_single_munmap(iomem->info);
+	if (iomem->fd > 0)
+		close(iomem->fd);
+	return 0;
+}
diff --git a/drivers/net/macb/base/macb_uio.h b/drivers/net/macb/base/macb_uio.h
new file mode 100644
index 0000000..7fb8298
--- /dev/null
+++ b/drivers/net/macb/base/macb_uio.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+#include "macb_common.h"
+
+#ifndef _MACB_UIO_H_
+#define _MACB_UIO_H_
+
+#define UIO_HDR_STR		"uio_%s"
+#define UIO_HDR_SZ		sizeof(UIO_HDR_STR)
+
+#define UIO_MAX_NAME_SIZE	64
+#define UIO_MAX_NUM		255
+
+#define UIO_INVALID_SIZE	0
+#define UIO_INVALID_ADDR	(~0)
+#define UIO_INVALID_FD		-1
+
+#define UIO_MMAP_NOT_DONE	0
+#define UIO_MMAP_OK		1
+#define UIO_MMAP_FAILED		2
+
+struct uio_map {
+	uint64_t addr;
+	uint64_t size;
+	char name[UIO_MAX_NAME_SIZE];
+	void *internal_addr;
+};
+
+struct uio_info {
+	struct uio_map map;
+	unsigned long event_count;
+	char name[UIO_MAX_NAME_SIZE];
+	char version[UIO_MAX_NAME_SIZE];
+};
+
+struct macb_iomem {
+	char *name;
+	int udev_id;
+	int fd;
+	struct uio_info *info;
+};
+
+int macb_uio_exist(const char *name);
+int macb_uio_init(const char *name, struct macb_iomem **iomem);
+void macb_uio_deinit(struct macb_iomem *iomem);
+int macb_uio_map(struct macb_iomem *iomem, phys_addr_t *pa, void **va, phys_addr_t paddr);
+int macb_uio_unmap(struct macb_iomem *iomem);
+
+#endif /* _MACB_UIO_H_ */
diff --git a/drivers/net/macb/base/meson.build b/drivers/net/macb/base/meson.build
new file mode 100644
index 0000000..888ac92
--- /dev/null
+++ b/drivers/net/macb/base/meson.build
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2022 Phytium Technology Co., Ltd.
+
+sources = [
+        'macb_common.c',
+        'macb_uio.c',
+        'generic_phy.c',
+]
+
+error_cflags = ['-Wno-unused-value',
+        '-Wno-unused-but-set-variable',
+        '-Wno-unused-variable',
+        '-Wno-unused-parameter',
+        ]
+c_args = cflags
+foreach flag: error_cflags
+    if cc.has_argument(flag)
+        c_args += flag
+    endif
+endforeach
+
+base_lib = static_library('macb_base', sources,
+    dependencies: static_rte_eal,
+    c_args: c_args)
+base_objs = base_lib.extract_all_objects()
diff --git a/drivers/net/macb/macb_ethdev.c b/drivers/net/macb/macb_ethdev.c
new file mode 100644
index 0000000..6469952
--- /dev/null
+++ b/drivers/net/macb/macb_ethdev.c
@@ -0,0 +1,1861 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022~2023 Phytium Technology Co., Ltd.
+ */
+
+#include <rte_bus_vdev.h>
+#include <ethdev_driver.h>
+#include <ethdev_vdev.h>
+#include <rte_kvargs.h>
+#include <rte_string_fns.h>
+
+#include "macb_rxtx.h"
+
+#define MACB_DRIVER_VERSION "5.8"
+#define MACB_DEVICE_NAME_ARG "device"
+#define MACB_USE_PHYDRV_ARG "usephydrv"
+#define MACB_MAC_ADDRS_MAX 256
+#define MAX_BUF_STR_LEN 256
+#define MACB_PDEV_PATH "/sys/bus/platform/devices"
+#define MACB_LINK_UPDATE_CHECK_TIMEOUT 90	/* 9s */
+#define MACB_LINK_UPDATE_CHECK_INTERVAL 100 /* ms */
+
+#define MACB_DEFAULT_TX_FREE_THRESH 32
+#define MACB_DEFAULT_TX_RSBIT_THRESH 16
+
+#define MACB_DEFAULT_RX_FREE_THRESH 16
+
+#if MACB_PORT_MODE_SWITCH
+void *macb_phy_dl_handle;
+int (*macb_phy_init)(uint16_t port_id, uint32_t speed);
+#endif
+
+int macb_logtype;
+static int macb_log_initialized;
+
+static const char *const valid_args[] = {
+	MACB_DEVICE_NAME_ARG,
+	MACB_USE_PHYDRV_ARG,
+	NULL};
+
+struct macb_devices {
+	const char *names[MACB_MAX_PORT_NUM];
+	uint32_t idx;
+};
+
+static int macb_dev_num;
+
+static int macb_phy_auto_detect(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	uint16_t phyad;
+	uint32_t phyid, phyid1, phyid2;
+	struct phy_device *phydev = bp->phydev;
+	struct phy_driver **phydrv;
+
+	/*
+	 * Custom external phy driver need to be added to phydrv_list.
+	 */
+	struct phy_driver *phydrv_list[] = {
+		&genphy_driver,
+		NULL
+	};
+
+	/*internal phy */
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII) {
+		phydev->drv = &macb_usxgmii_pcs_driver;
+		return 0;
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_2500BASEX ||
+		bp->phy_interface == MACB_PHY_INTERFACE_MODE_1000BASEX ||
+		bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX ||
+		(bp->phy_interface == MACB_PHY_INTERFACE_MODE_SGMII && bp->fixed_link)) {
+		phydev->drv = &macb_gbe_pcs_driver;
+		return 0;
+	}
+
+	/*external phy use no driver*/
+	if (!bp->phydrv_used) {
+		phydev->drv = NULL;
+		return 0;
+	}
+
+	for (phyad = 0; phyad < MAX_PHY_AD_NUM; phyad++) {
+		phyid2 = macb_mdio_read(bp, phyad, GENERIC_PHY_PHYSID2);
+		phyid1 = macb_mdio_read(bp, phyad, GENERIC_PHY_PHYSID1);
+		phyid = phyid2 | (phyid1 << PHY_ID_OFFSET);
+		/* If the phy_id is mostly Fs, there is no device there */
+		if (phyid && ((phyid & 0x1fffffff) != 0x1fffffff)) {
+			phydev->phy_id = phyid;
+			phydev->phyad = phyad;
+			break;
+		}
+	}
+
+	/* check if already registered */
+	for (phydrv = phydrv_list; *phydrv; phydrv++) {
+		if ((phydev->phy_id & (*phydrv)->phy_id_mask) == (*phydrv)->phy_id)
+			break;
+	}
+
+	if (*phydrv != NULL) {
+		phydev->drv = *phydrv;
+		MACB_INFO("Phy driver %s used", phydev->drv->name);
+	} else {
+		phydev->drv = &genphy_driver;
+		MACB_INFO("Unknown phyid: 0x%x, general phy driver used", phyid);
+	}
+
+	/* phy probe */
+	if (phydev->drv && phydev->drv->probe)
+		phydev->drv->probe(phydev);
+
+	return 0;
+}
+
+/**
+ * DPDK callback to enable promiscuous mode.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return 0
+ *
+ *
+ */
+static int eth_macb_promiscuous_enable(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	uint32_t cfg;
+
+	if (!bp) {
+		MACB_LOG(DEBUG, "Failed to get private data!");
+		return -EPERM;
+	}
+
+	cfg = macb_readl(bp, NCFGR);
+	cfg |= MACB_BIT(CAF);
+
+	macb_writel(bp, NCFGR, cfg);
+
+	return 0;
+}
+
+/**
+ * DPDK callback to disable promiscuous mode.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return 0
+ *
+ *
+ */
+static int eth_macb_promiscuous_disable(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	uint32_t cfg;
+
+	if (!bp) {
+		MACB_LOG(DEBUG, "Failed to get private data!");
+		return -EPERM;
+	}
+
+	cfg = macb_readl(bp, NCFGR);
+	cfg &= ~MACB_BIT(CAF);
+
+	macb_writel(bp, NCFGR, cfg);
+
+	return 0;
+}
+
+static int eth_macb_allmulticast_enable(struct rte_eth_dev *dev)
+{
+	unsigned long cfg;
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+
+	cfg = macb_readl(bp, NCFGR);
+	/* Enable all multicast mode */
+	macb_or_gem_writel(bp, HRB, -1);
+	macb_or_gem_writel(bp, HRT, -1);
+	cfg |= MACB_BIT(NCFGR_MTI);
+
+	macb_writel(bp, NCFGR, cfg);
+	return 0;
+}
+
+static int eth_macb_allmulticast_disable(struct rte_eth_dev *dev)
+{
+	unsigned long cfg;
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+
+	if (dev->data->promiscuous == 1)
+		return 0; /* must remain in all_multicast mode */
+
+	cfg = macb_readl(bp, NCFGR);
+	/* Disable all multicast mode */
+	macb_or_gem_writel(bp, HRB, 0);
+	macb_or_gem_writel(bp, HRT, 0);
+	cfg &= ~MACB_BIT(NCFGR_MTI);
+
+	macb_writel(bp, NCFGR, cfg);
+	return 0;
+}
+
+static int eth_macb_link_update(struct rte_eth_dev *dev, int wait_to_complete)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	struct phy_device *phydev = bp->phydev;
+	struct rte_eth_link link;
+	int count, link_check;
+
+	if (!priv->bp) {
+		MACB_LOG(ERR, "Failed to get private data!");
+		return -EPERM;
+	}
+
+	for (count = 0; count < MACB_LINK_UPDATE_CHECK_TIMEOUT; count++) {
+		macb_check_for_link(bp);
+		link_check = bp->link;
+		if (link_check || wait_to_complete == 0)
+			break;
+		rte_delay_ms(MACB_LINK_UPDATE_CHECK_INTERVAL);
+	}
+	memset(&link, 0, sizeof(link));
+
+	if (link_check) {
+		if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII ||
+			bp->phy_interface == MACB_PHY_INTERFACE_MODE_2500BASEX ||
+			bp->phy_interface == MACB_PHY_INTERFACE_MODE_1000BASEX ||
+			bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX ||
+			(bp->phy_interface == MACB_PHY_INTERFACE_MODE_SGMII && bp->fixed_link) ||
+			!bp->phydrv_used) {
+			link.link_speed = bp->speed;
+			link.link_duplex =
+				bp->duplex ? RTE_ETH_LINK_FULL_DUPLEX : RTE_ETH_LINK_HALF_DUPLEX;
+		} else {
+			/* get phy link info */
+			if (phydev->drv && phydev->drv->read_status)
+				phydev->drv->read_status(phydev);
+
+			link.link_speed = phydev->speed;
+			link.link_duplex = phydev->duplex ? RTE_ETH_LINK_FULL_DUPLEX :
+					   RTE_ETH_LINK_HALF_DUPLEX;
+		}
+		link.link_status = RTE_ETH_LINK_UP;
+		link.link_autoneg =
+			!(dev->data->dev_conf.link_speeds & RTE_ETH_LINK_SPEED_FIXED);
+	} else if (!link_check) {
+		link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+		link.link_status = RTE_ETH_LINK_DOWN;
+		link.link_autoneg = RTE_ETH_LINK_FIXED;
+	}
+
+	return rte_eth_linkstatus_set(dev, &link);
+}
+
+static void macb_interrupt_handler(void *param)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct macb_priv *priv = dev->data->dev_private;
+	struct rte_eth_link link;
+	char status[128];
+
+	if (priv->stopped)
+		return;
+
+	if (eth_macb_link_update(dev, 0) < 0)
+		return;
+
+	rte_eth_linkstatus_get(dev, &link);
+	rte_eth_link_to_str(status, sizeof(status), &link);
+	MACB_INFO("Port %u: %s", dev->data->port_id, status);
+
+	macb_link_change(priv->bp);
+	rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+}
+
+static int eth_macb_dev_set_link_up(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	struct phy_device *phydev = bp->phydev;
+
+	if (!bp) {
+		MACB_LOG(ERR, "Failed to get private data!");
+		return -EPERM;
+	}
+
+	/* phy link up */
+	if (phydev->drv && phydev->drv->resume)
+		phydev->drv->resume(phydev);
+
+	return 0;
+}
+
+static int eth_macb_dev_set_link_down(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	struct phy_device *phydev = bp->phydev;
+
+	if (!bp) {
+		MACB_LOG(ERR, "Failed to get private data!");
+		return -EPERM;
+	}
+
+	/* phy link down */
+	if (phydev->drv && phydev->drv->suspend)
+		phydev->drv->suspend(phydev);
+
+	return 0;
+}
+
+/**
+ * DPDK callback to get device statistics.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ * @param stats
+ *   Stats structure output buffer.
+ *
+ * @return
+ *   0 on success, negative error value otherwise.
+ */
+static int eth_macb_stats_get(struct rte_eth_dev *dev,
+							  struct rte_eth_stats *stats)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct gem_stats *hwstat = &priv->bp->hw_stats.gem;
+
+	if (!priv->bp) {
+		MACB_LOG(ERR, "Failed to get private data!");
+		return -EPERM;
+	}
+
+	macb_get_stats(priv->bp);
+
+	stats->ipackets = hwstat->rx_frames - priv->prev_stats.ipackets;
+	stats->opackets = hwstat->tx_frames - priv->prev_stats.opackets;
+	stats->ibytes = hwstat->rx_octets_31_0 + (hwstat->rx_octets_47_32 << 32) -
+					priv->prev_stats.ibytes;
+	stats->obytes = hwstat->tx_octets_31_0 + (hwstat->tx_octets_47_32 << 32) -
+					priv->prev_stats.obytes;
+	stats->imissed = hwstat->rx_resource_drops + hwstat->rx_overruns -
+					priv->prev_stats.imissed;
+	stats->ierrors =
+		(hwstat->rx_frame_check_sequence_errors + hwstat->rx_alignment_errors +
+		 hwstat->rx_oversize_frames + hwstat->rx_jabbers +
+		 hwstat->rx_undersized_frames + hwstat->rx_length_field_frame_errors +
+		 hwstat->rx_ip_header_checksum_errors + hwstat->rx_tcp_checksum_errors +
+		 hwstat->rx_udp_checksum_errors) -
+		priv->prev_stats.ierrors;
+	stats->oerrors =
+		(hwstat->tx_late_collisions + hwstat->tx_excessive_collisions +
+		 hwstat->tx_underrun + hwstat->tx_carrier_sense_errors) -
+		priv->prev_stats.oerrors;
+
+	return 0;
+}
+
+static int eth_macb_stats_reset(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (!priv->bp) {
+		MACB_LOG(ERR, "Failed to get private data!");
+		return -EPERM;
+	}
+
+	memset(&priv->prev_stats, 0, sizeof(struct rte_eth_stats));
+	ret = eth_macb_stats_get(dev, &priv->prev_stats);
+	if (unlikely(ret)) {
+		MACB_LOG(ERR, "Failed to reset port statistics.");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int eth_macb_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
+								  struct rte_eth_dev_info *dev_info)
+{
+	dev_info->max_mac_addrs = 1;
+	dev_info->max_rx_queues = MACB_MAX_QUEUES;
+	dev_info->max_tx_queues = MACB_MAX_QUEUES;
+	dev_info->max_rx_pktlen = MAX_JUMBO_FRAME_SIZE;
+
+	/* MAX JUMBO FRAME */
+	dev_info->max_rx_pktlen = MACB_MAX_JUMBO_FRAME;
+
+	dev_info->max_mtu = dev_info->max_rx_pktlen - MACB_ETH_OVERHEAD;
+	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
+
+	dev_info->speed_capa = RTE_ETH_LINK_SPEED_10M | RTE_ETH_LINK_SPEED_100M |
+						   RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_10G;
+
+	dev_info->rx_queue_offload_capa = macb_get_rx_queue_offloads_capa(dev);
+	dev_info->rx_offload_capa =
+		macb_get_rx_port_offloads_capa(dev) | dev_info->rx_queue_offload_capa;
+	dev_info->tx_queue_offload_capa = RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+					RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+				RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM;
+	dev_info->default_rxconf = (struct rte_eth_rxconf) {
+		.rx_free_thresh = MACB_DEFAULT_RX_FREE_THRESH,
+		.offloads = 0,
+	};
+
+	dev_info->default_txconf = (struct rte_eth_txconf) {
+		.tx_free_thresh = MACB_DEFAULT_TX_FREE_THRESH,
+		.tx_rs_thresh = MACB_DEFAULT_TX_RSBIT_THRESH,
+		.offloads = 0,
+	};
+
+	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = MACB_MAX_RING_DESC,
+		.nb_min = MACB_MIN_RING_DESC,
+		.nb_align = MACB_RXD_ALIGN,
+	};
+
+	dev_info->tx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = MACB_MAX_RING_DESC,
+		.nb_min = MACB_MIN_RING_DESC,
+		.nb_align = MACB_TXD_ALIGN,
+	};
+
+	dev_info->max_rx_queues = MACB_MAX_QUEUES;
+	dev_info->max_tx_queues = MACB_MAX_QUEUES;
+
+
+	return 0;
+}
+
+static const uint32_t *
+eth_macb_dev_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
+				  size_t *num_ptypes __rte_unused)
+{
+	static const uint32_t ptypes[] = {RTE_PTYPE_L3_IPV4, RTE_PTYPE_L3_IPV6,
+					  RTE_PTYPE_L4_TCP, RTE_PTYPE_L4_UDP};
+
+	return ptypes;
+}
+
+/**
+ * DPDK callback to set mtu.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ * @param mtu
+ *   The value of Maximum Transmission Unit (MTU) to set
+ */
+static int eth_macb_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	u32 frame_size = mtu + MACB_ETH_OVERHEAD;
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	u32 config;
+
+	config = macb_readl(bp, NCFGR);
+
+	/* refuse mtu that requires the support of scattered packets when this
+	 * feature has not been enabled before.
+	 */
+	if (!dev->data->scattered_rx &&
+		frame_size > dev->data->min_rx_buf_size - RTE_PKTMBUF_HEADROOM) {
+		MACB_LOG(ERR, "mtu setting rejected.");
+		return -EINVAL;
+	}
+
+	/* switch to jumbo mode if needed */
+	if (mtu > RTE_ETHER_MAX_LEN)
+		config |= MACB_BIT(JFRAME);
+	else
+		config &= ~MACB_BIT(JFRAME);
+	macb_writel(bp, NCFGR, config);
+	gem_writel(bp, JML, frame_size);
+
+	return 0;
+}
+
+/* macb_set_hwaddr
+ * set mac address.
+ *
+ * This function complete mac addr set.
+ *
+ * @param dev
+ *   A pointer to the macb.
+ *
+ * @modify author
+ *   Mengxiangbo
+ * @modify time
+ *   2021-02-07
+ * @modify reason
+ *   build
+ **/
+static void eth_macb_set_hwaddr(struct macb *bp)
+{
+	u32 bottom;
+	u16 top;
+
+	bottom = cpu_to_le32(*((u32 *)bp->dev->data->mac_addrs->addr_bytes));
+	macb_or_gem_writel(bp, SA1B, bottom);
+	top = cpu_to_le16(*((u16 *)(bp->dev->data->mac_addrs->addr_bytes + 4)));
+	macb_or_gem_writel(bp, SA1T, top);
+
+	/* Clear unused address register sets */
+	macb_or_gem_writel(bp, SA2B, 0);
+	macb_or_gem_writel(bp, SA2T, 0);
+	macb_or_gem_writel(bp, SA3B, 0);
+	macb_or_gem_writel(bp, SA3T, 0);
+	macb_or_gem_writel(bp, SA4B, 0);
+	macb_or_gem_writel(bp, SA4T, 0);
+}
+
+static void macb_get_hwaddr(struct macb *bp)
+{
+	struct rte_ether_addr mac_addr;
+	u32 bottom;
+	u16 top;
+	u8 addr[6];
+
+	bottom = macb_or_gem_readl(bp, SA1B);
+	top = macb_or_gem_readl(bp, SA1T);
+
+	addr[0] = bottom & 0xff;
+	addr[1] = (bottom >> 8) & 0xff;
+	addr[2] = (bottom >> 16) & 0xff;
+	addr[3] = (bottom >> 24) & 0xff;
+	addr[4] = top & 0xff;
+	addr[5] = (top >> 8) & 0xff;
+
+	memcpy(mac_addr.addr_bytes, addr, RTE_ETHER_ADDR_LEN);
+	if (!rte_is_valid_assigned_ether_addr(&mac_addr)) {
+		MACB_LOG(INFO, "Invalid MAC address, using random.");
+		rte_eth_random_addr(addr);
+	}
+	memcpy(bp->dev->data->mac_addrs->addr_bytes, addr, sizeof(addr));
+}
+
+const struct macb_config macb_gem1p0_mac_config = {
+	.caps = MACB_CAPS_MACB_IS_GEM | MACB_CAPS_GIGABIT_MODE_AVAILABLE |
+			MACB_CAPS_JUMBO | MACB_CAPS_BD_RD_PREFETCH |
+			MACB_CAPS_ISR_CLEAR_ON_WRITE | MACB_CAPS_PERFORMANCE_OPTIMIZING |
+			MACB_CAPS_SEL_CLK_HW,
+	.dma_burst_length = 16,
+	.jumbo_max_len = 10240,
+	.sel_clk_hw = macb_gem1p0_sel_clk,
+};
+
+static const struct macb_config macb_gem2p0_mac_config = {
+	.caps = MACB_CAPS_MACB_IS_GEM | MACB_CAPS_GIGABIT_MODE_AVAILABLE |
+				MACB_CAPS_JUMBO | MACB_CAPS_BD_RD_PREFETCH |
+				MACB_CAPS_ISR_CLEAR_ON_WRITE | MACB_CAPS_PERFORMANCE_OPTIMIZING |
+				MACB_CAPS_SEL_CLK_HW,
+	.dma_burst_length = 16,
+	.jumbo_max_len = 10240,
+	.sel_clk_hw = macb_gem2p0_sel_clk,
+};
+
+static int eth_macb_set_default_mac_addr(struct rte_eth_dev *dev,
+				     struct rte_ether_addr *mac_addr)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+
+	if (!rte_is_valid_assigned_ether_addr(mac_addr)) {
+		MACB_LOG(ERR, "Tried to set invalid MAC address.");
+		return -EINVAL;
+	}
+
+	memcpy(bp->dev->data->mac_addrs, mac_addr, RTE_ETHER_ADDR_LEN);
+
+	eth_macb_set_hwaddr(bp);
+
+	return 0;
+}
+
+/* macb_dev_configure
+ * Macb dev init and hw init   include some register init and some
+ * Nic operation func appoint .
+ *
+ * This function complete hw initialization.
+ *
+ * @param dev
+ *   A pointer to the dev.
+ *
+ **/
+static int eth_macb_dev_configure(struct rte_eth_dev *dev)
+{
+	u32 reg, val = 0;
+	bool native_io;
+	unsigned int queue_mask, num_queues;
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	const struct macb_config *macb_config = NULL;
+
+	bp->dev_type = priv->dev_type;
+	if (bp->dev_type == DEV_TYPE_PHYTIUM_GEM1P0_MAC) {
+		macb_config = &macb_gem1p0_mac_config;
+	} else if (bp->dev_type == DEV_TYPE_PHYTIUM_GEM2P0_MAC) {
+		macb_config = &macb_gem2p0_mac_config;
+	} else {
+		MACB_LOG(ERR, "unsupportted device.");
+		return -ENODEV;
+	}
+
+	native_io = hw_is_native_io(bp);
+	macb_probe_queues(bp->base, native_io, &queue_mask, &num_queues);
+
+	bp->native_io = native_io;
+	bp->num_queues = num_queues;
+	bp->tx_ring_size = MACB_TX_RING_SIZE;
+	bp->rx_ring_size = MACB_RX_RING_SIZE;
+	bp->queue_mask = queue_mask;
+
+	if (macb_config) {
+		bp->dma_burst_length = macb_config->dma_burst_length;
+		bp->jumbo_max_len = macb_config->jumbo_max_len;
+		bp->sel_clk_hw = macb_config->sel_clk_hw;
+	}
+
+	/* setup capabilities */
+	macb_configure_caps(bp, macb_config);
+	bp->hw_dma_cap = HW_DMA_CAP_64B;
+
+	/* set MTU */
+	dev->data->mtu = RTE_ETHER_MTU;
+
+	/* enable lsc interrupt */
+	dev->data->dev_conf.intr_conf.lsc = true;
+
+	/* prefetch init */
+	if (bp->caps & MACB_CAPS_BD_RD_PREFETCH) {
+		val = GEM_BFEXT(RXBD_RDBUFF, gem_readl(bp, DCFG10));
+		if (val)
+			bp->rx_bd_rd_prefetch =
+				(4 << (val - 1)) * macb_dma_desc_get_size(bp);
+
+		val = GEM_BFEXT(TXBD_RDBUFF, gem_readl(bp, DCFG10));
+		if (val)
+			bp->tx_bd_rd_prefetch =
+				(4 << (val - 1)) * macb_dma_desc_get_size(bp);
+	}
+
+	/* Enable management port */
+	macb_writel(bp, NCR, MACB_BIT(MPE));
+
+	/* get mac address */
+	macb_get_hwaddr(bp);
+
+	/* Checksum offload is only available on gem with packet buffer */
+	if (macb_is_gem(bp) && !(bp->caps & MACB_CAPS_FIFO_MODE))
+		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_CHECKSUM;
+	/* Scatter gather disable */
+	if (bp->caps & MACB_CAPS_SG_DISABLED)
+		dev->data->dev_conf.rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_SCATTER;
+
+	/* Check RX Flow Filters support.
+	 * Max Rx flows set by availability of screeners & compare regs:
+	 * each 4-tuple define requires 1 T2 screener reg + 3 compare regs
+	 */
+	reg = gem_readl(bp, DCFG8);
+	bp->max_tuples = min((GEM_BFEXT(SCR2CMP, reg) / 3), GEM_BFEXT(T2SCR, reg));
+	if (bp->max_tuples > 0) {
+		if (GEM_BFEXT(SCR2ETH, reg) > 0) {
+			reg = 0;
+			reg = GEM_BFINS(ETHTCMP, (uint16_t)ETH_P_IP, reg);
+			gem_writel_n(bp, ETHT, SCRT2_ETHT, reg);
+			priv->hw_features |= RTE_5TUPLE_FLAGS;
+		} else {
+			bp->max_tuples = 0;
+		}
+	}
+	/*
+	 * Initialize to TRUE. If any of Rx queues doesn't meet the bulk
+	 * allocation or vector Rx preconditions we will reset it.
+	 */
+	bp->rx_bulk_alloc_allowed = true;
+	bp->rx_vec_allowed = true;
+
+	return 0;
+}
+
+static u32 macb_mdc_clk_div(struct macb *bp)
+{
+	u32 config;
+	unsigned long pclk_hz;
+	struct macb_priv *priv = bp->dev->data->dev_private;
+
+	pclk_hz = priv->pclk_hz;
+	if (pclk_hz <= 20000000)
+		config = GEM_BF(CLK, GEM_CLK_DIV8);
+	else if (pclk_hz <= 40000000)
+		config = GEM_BF(CLK, GEM_CLK_DIV16);
+	else if (pclk_hz <= 80000000)
+		config = GEM_BF(CLK, GEM_CLK_DIV32);
+	else if (pclk_hz <= 120000000)
+		config = GEM_BF(CLK, GEM_CLK_DIV48);
+	else if (pclk_hz <= 160000000)
+		config = GEM_BF(CLK, GEM_CLK_DIV64);
+	else
+		config = GEM_BF(CLK, GEM_CLK_DIV96);
+
+	return config;
+}
+
+#if MACB_PORT_MODE_SWITCH
+static void macb_switch_port_mode(struct rte_eth_dev *dev, uint32_t speed)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	phys_addr_t physical_addr = priv->physical_addr;
+	struct macb *bp = priv->bp;
+	struct phy_device *phydev = bp->phydev;
+
+	if (physical_addr == MAC0_ADDR_BASE || physical_addr == MAC1_ADDR_BASE) {
+		if (speed == RTE_ETH_LINK_SPEED_100M) {
+			bp->phy_interface = MACB_PHY_INTERFACE_MODE_100BASEX;
+			bp->speed = SPEED_100;
+			bp->duplex = DUPLEX_FULL;
+		} else if (speed == RTE_ETH_LINK_SPEED_1G) {
+			bp->phy_interface = MACB_PHY_INTERFACE_MODE_1000BASEX;
+			bp->speed = SPEED_1000;
+			bp->duplex = DUPLEX_FULL;
+		} else if (speed == RTE_ETH_LINK_SPEED_2_5G) {
+			bp->phy_interface = MACB_PHY_INTERFACE_MODE_2500BASEX;
+			bp->speed = SPEED_2500;
+			bp->duplex = DUPLEX_FULL;
+		} else if (speed == RTE_ETH_LINK_SPEED_10G) {
+			bp->phy_interface = MACB_PHY_INTERFACE_MODE_USXGMII;
+			bp->speed = SPEED_10000;
+			bp->duplex = DUPLEX_FULL;
+		}
+	}
+	/* switch phy driver */
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX ||
+	    bp->phy_interface == MACB_PHY_INTERFACE_MODE_1000BASEX ||
+	    bp->phy_interface == MACB_PHY_INTERFACE_MODE_2500BASEX)
+		phydev->drv = &macb_gbe_pcs_driver;
+	else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII)
+		phydev->drv = &macb_usxgmii_pcs_driver;
+}
+#endif
+
+static void macb_configure_dma(struct macb *bp)
+{
+	struct macb_rx_queue *rxq;
+	u32 buffer_size;
+	unsigned int i;
+	u32 dmacfg;
+
+	/* Dma rx  buffer size set */
+	buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
+	if (macb_is_gem(bp)) {
+		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
+		for (i = 0; i < bp->dev->data->nb_rx_queues; i++) {
+			rxq = bp->dev->data->rx_queues[i];
+			if (i != 0)
+				queue_writel(rxq, RBQS, buffer_size);
+			else
+				dmacfg |= GEM_BF(RXBS, buffer_size);
+		}
+
+		/* Disable PTP */
+		dmacfg &= ~GEM_BIT(RXEXT);
+		dmacfg &= ~GEM_BIT(TXEXT);
+
+		/* Fixed burst length for DMA set */
+		if (bp->dma_burst_length)
+			dmacfg = GEM_BFINS(FBLDO, bp->dma_burst_length, dmacfg);
+
+		/* TX RX packet buffer memory size select */
+		dmacfg |= GEM_BIT(TXPBMS) | GEM_BF(RXBMS, -1L);
+		dmacfg &= ~GEM_BIT(ENDIA_PKT);
+
+		/* Big little endian set */
+		if (bp->native_io)
+			dmacfg &= ~GEM_BIT(ENDIA_DESC);
+		else
+			dmacfg |= GEM_BIT(ENDIA_DESC); /* CPU in big endian */
+
+		/* Dma addr bit width set */
+		dmacfg &= ~GEM_BIT(ADDR64);
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			dmacfg |= GEM_BIT(ADDR64);
+
+		/* TX IP/TCP/UDP checksum gen offload set */
+		if (bp->dev->data->dev_conf.txmode.offloads & (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+		    RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM))
+			dmacfg |= GEM_BIT(TXCOEN);
+		else
+			dmacfg &= ~GEM_BIT(TXCOEN);
+
+		gem_writel(bp, DMACFG, dmacfg);
+	}
+}
+
+static void macb_init_hw(struct macb *bp)
+{
+	u32 config;
+	u32 max_len;
+
+#if MACB_PORT_MODE_SWITCH
+	enum macb_port_id port_id = PORT_MAX;
+#endif
+
+	/* Config NCFGR register*/
+	config = macb_mdc_clk_div(bp);
+
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_SGMII)
+		config |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
+	config |= MACB_BF(RBOF, MACB_RX_DATA_OFFSET);
+	config |= MACB_BIT(PAE);
+	if (bp->dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
+		config &= ~MACB_BIT(DRFCS);
+	else
+		config |= MACB_BIT(DRFCS);
+
+	/* Enable jumbo frames */
+	if (bp->dev->data->mtu > RTE_ETHER_MTU)
+		config |= MACB_BIT(JFRAME);
+	else
+		/* Receive oversized frames */
+		config |= MACB_BIT(BIG);
+
+	/* Copy All Frames */
+	if (bp->dev->data->promiscuous == 1)
+		config |= MACB_BIT(CAF);
+	else if (macb_is_gem(bp) && (bp->dev->data->dev_conf.rxmode.offloads &
+								 RTE_ETH_RX_OFFLOAD_CHECKSUM))
+		config |= GEM_BIT(RXCOEN);
+
+	config |= macb_dbw(bp);
+
+	/* RX IP/TCP/UDP checksum gen offload set */
+	if (macb_is_gem(bp) &&
+		(bp->dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM))
+		config |= GEM_BIT(RXCOEN);
+	macb_writel(bp, NCFGR, config);
+
+	if ((bp->caps & MACB_CAPS_SEL_CLK_HW) && bp->sel_clk_hw)
+		bp->sel_clk_hw(bp);
+
+#if MACB_PORT_MODE_SWITCH
+	if (bp->paddr == MAC0_ADDR_BASE)
+		port_id = PORT0;
+	else if (bp->paddr == MAC1_ADDR_BASE)
+		port_id = PORT1;
+
+	if (port_id != PORT_MAX && macb_phy_init != NULL)
+		if (macb_phy_init(port_id, bp->speed))
+			MACB_LOG(ERR, "Failed to init macb phy!");
+#endif
+
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII ||
+		bp->phy_interface == MACB_PHY_INTERFACE_MODE_2500BASEX ||
+		bp->phy_interface == MACB_PHY_INTERFACE_MODE_1000BASEX ||
+		bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX ||
+		(bp->phy_interface == MACB_PHY_INTERFACE_MODE_SGMII && bp->fixed_link)) {
+		macb_mac_with_pcs_config(bp);
+	}
+
+	/* JUMBO value set */
+	if (bp->dev->data->mtu > RTE_ETHER_MTU) {
+		max_len = bp->dev->data->mtu + MACB_ETH_OVERHEAD;
+		gem_writel(bp, JML, max_len);
+	}
+	bp->rx_frm_len_mask = MACB_RX_JFRMLEN_MASK;
+
+	/* Set axi_pipe */
+	if (bp->caps & MACB_CAPS_PERFORMANCE_OPTIMIZING)
+		gem_writel(bp, AXI_PIPE, 0x1010);
+}
+
+
+static inline void macb_enable_rxtx(struct macb *bp)
+{
+	u32 ctrl = macb_readl(bp, NCR);
+	ctrl |= MACB_BIT(RE) | MACB_BIT(TE);
+	macb_writel(bp, NCR, ctrl);
+}
+
+/* macb_dev_start
+ * start dev Complete hardware initialization .
+ *
+ * This function complete hw initialization.
+ *
+ * @param dev
+ *   A pointer to the dev.
+ *
+ **/
+static int eth_macb_dev_start(struct rte_eth_dev *dev)
+{
+	int err;
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	struct phy_device *phydev = bp->phydev;
+	uint32_t *speeds;
+	int num_speeds;
+	bool setup_link = true;
+#if MACB_PORT_MODE_SWITCH
+	uint32_t speed;
+#endif
+
+	/* Make sure the phy device is disabled */
+	eth_macb_dev_set_link_down(dev);
+
+#if MACB_PORT_MODE_SWITCH
+	/* switch port mode */
+	speed = dev->data->dev_conf.link_speeds;
+	if (speed & RTE_ETH_LINK_SPEED_FIXED)
+		speed &= ~RTE_ETH_LINK_SPEED_FIXED;
+
+	if ((bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX &&
+	    speed != RTE_ETH_LINK_SPEED_100M) || (bp->phy_interface ==
+	    MACB_PHY_INTERFACE_MODE_1000BASEX && speed != RTE_ETH_LINK_SPEED_1G) ||
+	    (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII &&
+	    speed != RTE_ETH_LINK_SPEED_10G) || (bp->phy_interface ==
+	    MACB_PHY_INTERFACE_MODE_2500BASEX && speed != RTE_ETH_LINK_SPEED_2_5G)) {
+		macb_switch_port_mode(dev, speed);
+	}
+#endif
+
+	/* phydev soft reset */
+	if (phydev->drv && phydev->drv->soft_reset)
+		phydev->drv->soft_reset(phydev);
+
+	if (phydev->drv && phydev->drv->config_init)
+		phydev->drv->config_init(phydev);
+
+	/* hw reset */
+	macb_reset_hw(bp);
+
+	/* set mac addr */
+	eth_macb_set_hwaddr(bp);
+
+	/* hw init */
+	macb_init_hw(bp);
+
+	/* tx queue phyaddr check */
+	err = macb_tx_phyaddr_check(dev);
+	if (err) {
+		MACB_LOG(ERR, "Tx phyaddr check failed.");
+		goto out;
+	}
+
+	/* Init tx queue include mbuf mem alloc */
+	eth_macb_tx_init(dev);
+
+	/* rx queue phyaddr check */
+	err = macb_rx_phyaddr_check(dev);
+	if (err) {
+		MACB_LOG(ERR, "Rx phyaddr check failed.");
+		goto out;
+	}
+
+	/* Init rx queue include mbuf mem alloc */
+	err = eth_macb_rx_init(dev);
+	if (err) {
+		MACB_LOG(ERR, "Rx init failed.");
+		goto out;
+	}
+
+	macb_configure_dma(bp);
+
+	/* Enable receive and transmit. */
+	macb_enable_rxtx(bp);
+
+	/* Make interface link up */
+	err = eth_macb_dev_set_link_up(dev);
+	if (err) {
+		MACB_LOG(ERR, "Failed to set link up");
+		goto out;
+	}
+
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII ||
+	    bp->phy_interface == MACB_PHY_INTERFACE_MODE_2500BASEX ||
+	    bp->phy_interface == MACB_PHY_INTERFACE_MODE_1000BASEX ||
+	    bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX ||
+	    (bp->phy_interface == MACB_PHY_INTERFACE_MODE_SGMII && bp->fixed_link))
+		setup_link = false;
+
+	/* Setup link speed and duplex */
+	if (setup_link) {
+		speeds = &dev->data->dev_conf.link_speeds;
+		if (*speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
+			bp->autoneg = RTE_ETH_LINK_AUTONEG;
+		} else {
+			num_speeds = 0;
+			bp->autoneg = RTE_ETH_LINK_FIXED;
+
+			if (*speeds &
+			    ~(RTE_ETH_LINK_SPEED_10M_HD | RTE_ETH_LINK_SPEED_10M |
+			    RTE_ETH_LINK_SPEED_100M_HD | RTE_ETH_LINK_SPEED_100M |
+			    RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_FIXED |
+			    RTE_ETH_LINK_SPEED_2_5G)) {
+				num_speeds = -1;
+				goto error_invalid_config;
+			}
+			if (*speeds & RTE_ETH_LINK_SPEED_10M_HD) {
+				bp->speed = RTE_ETH_SPEED_NUM_10M;
+				bp->duplex = RTE_ETH_LINK_HALF_DUPLEX;
+				num_speeds++;
+			} else if (*speeds & RTE_ETH_LINK_SPEED_10M) {
+				bp->speed = RTE_ETH_SPEED_NUM_10M;
+				bp->duplex = RTE_ETH_LINK_FULL_DUPLEX;
+				num_speeds++;
+			} else if (*speeds & RTE_ETH_LINK_SPEED_100M_HD) {
+				bp->speed = RTE_ETH_SPEED_NUM_100M;
+				bp->duplex = RTE_ETH_LINK_HALF_DUPLEX;
+				num_speeds++;
+			} else if (*speeds & RTE_ETH_LINK_SPEED_100M) {
+				bp->speed = RTE_ETH_SPEED_NUM_100M;
+				bp->duplex = RTE_ETH_LINK_FULL_DUPLEX;
+				num_speeds++;
+			} else if (*speeds & RTE_ETH_LINK_SPEED_1G) {
+				bp->speed = RTE_ETH_SPEED_NUM_1G;
+				bp->duplex = RTE_ETH_LINK_FULL_DUPLEX;
+				num_speeds++;
+			} else if (*speeds & RTE_ETH_LINK_SPEED_2_5G) {
+				bp->speed = RTE_ETH_SPEED_NUM_2_5G;
+				bp->duplex = RTE_ETH_LINK_FULL_DUPLEX;
+				num_speeds++;
+			}
+			if (num_speeds == 0) {
+				err = -EINVAL;
+				goto error_invalid_config;
+			}
+		}
+		macb_setup_link(bp);
+	}
+
+	eth_macb_stats_reset(dev);
+	if (!bp->phydrv_used)
+		bp->link = true;
+
+	priv->stopped = false;
+	return 0;
+error_invalid_config:
+	MACB_LOG(ERR, "Invalid advertised speeds (%u) for port %u",
+			 dev->data->dev_conf.link_speeds, dev->data->port_id);
+out:
+	MACB_LOG(ERR, "Failed to start device");
+	return err;
+}
+
+static int eth_macb_dev_stop(struct rte_eth_dev *dev)
+{
+	u32 i;
+	struct rte_eth_link link;
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+
+	if (priv->stopped)
+		return 0;
+
+	/* link down the interface */
+	eth_macb_dev_set_link_down(dev);
+
+	/* reset hw reg */
+	macb_reset_hw(bp);
+
+	/* release rx queue mbuf free mem */
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct macb_rx_queue *rx_queue;
+		if (!dev->data->rx_queues[i])
+			continue;
+		rx_queue = dev->data->rx_queues[i];
+		macb_rx_queue_release_mbufs(rx_queue);
+		macb_reset_rx_queue(rx_queue);
+	}
+
+	/* release tx queue mbuf free mem */
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct macb_tx_queue *tx_queue;
+		if (!dev->data->tx_queues[i])
+			continue;
+		tx_queue = dev->data->tx_queues[i];
+		macb_tx_queue_release_mbufs(tx_queue);
+		macb_reset_tx_queue(tx_queue, dev);
+	}
+
+	/* clear the recorded link status */
+	memset(&link, 0, sizeof(link));
+	rte_eth_linkstatus_set(dev, &link);
+
+	if (!bp->phydrv_used)
+		bp->link = false;
+	dev->data->dev_started = 0;
+	priv->stopped = true;
+	return 0;
+}
+
+/**
+ * DPDK callback to close the device.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ */
+static int eth_macb_dev_close(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	int ret = 0, loop = 10;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	ret = eth_macb_dev_stop(dev);
+
+	do {
+		loop--;
+		int err;
+		err = rte_intr_callback_unregister(priv->intr_handle,
+						   macb_interrupt_handler, dev);
+		if (err > 0)
+			break;
+		if (err != -EAGAIN || !loop) {
+			MACB_LOG(WARNING, "Failed to unregister lsc callback.");
+			break;
+		}
+		rte_delay_ms(10);
+	} while (true);
+
+	macb_dev_free_queues(dev);
+
+	/* Ensure that register operations are completed before unmap. */
+	rte_delay_ms(100);
+	macb_iomem_deinit(priv->bp);
+	rte_free(priv->bp->phydev);
+	rte_free(priv->bp);
+
+	macb_dev_num--;
+
+	return ret;
+}
+
+static const struct eth_dev_ops macb_ops = {
+	.dev_set_link_up = eth_macb_dev_set_link_up,
+	.dev_set_link_down = eth_macb_dev_set_link_down,
+	.link_update = eth_macb_link_update,
+	.dev_configure = eth_macb_dev_configure,
+	.rx_queue_setup = eth_macb_rx_queue_setup,
+	.tx_queue_setup = eth_macb_tx_queue_setup,
+	.rx_queue_release = eth_macb_rx_queue_release,
+	.tx_queue_release = eth_macb_tx_queue_release,
+	.dev_start = eth_macb_dev_start,
+	.dev_stop = eth_macb_dev_stop,
+	.dev_close = eth_macb_dev_close,
+	.stats_get = eth_macb_stats_get,
+	.stats_reset = eth_macb_stats_reset,
+	.rxq_info_get = macb_rxq_info_get,
+	.txq_info_get = macb_txq_info_get,
+	.dev_infos_get = eth_macb_dev_infos_get,
+	.mtu_set = eth_macb_mtu_set,
+	.dev_supported_ptypes_get = eth_macb_dev_supported_ptypes_get,
+	.promiscuous_enable = eth_macb_promiscuous_enable,
+	.promiscuous_disable = eth_macb_promiscuous_disable,
+	.allmulticast_enable = eth_macb_allmulticast_enable,
+	.allmulticast_disable = eth_macb_allmulticast_disable,
+	.mac_addr_set = eth_macb_set_default_mac_addr,
+};
+
+/**
+ * Callback used by rte_kvargs_process() during argument parsing.
+ *
+ * @param key
+ *   Pointer to the parsed key (unused).
+ * @param value
+ *   Pointer to the parsed value.
+ * @param extra_args
+ *   Pointer to the extra arguments which contains address of the
+ *   table of pointers to parsed interface names.
+ *
+ * @return
+ *   Always 0.
+ */
+static int macb_devices_get(const char *key __rte_unused, const char *value,
+							void *extra_args)
+{
+	struct macb_devices *devices = extra_args;
+
+	devices->names[devices->idx++] = value;
+
+	return 0;
+}
+
+static int macb_phydrv_used_get(const char *key __rte_unused, const char *value,
+							void *extra_args)
+{
+	bool *phydrv_used = extra_args;
+
+	*phydrv_used = (bool)atoi(value);
+
+	return 0;
+}
+
+/**
+ * Init device.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   0 on success, negative errno value on failure.
+ */
+static int macb_dev_init(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	int ret;
+
+	dev->data->mac_addrs =
+		rte_zmalloc("mac_addrs", RTE_ETHER_ADDR_LEN * MACB_MAC_ADDRS_MAX, 0);
+	if (!dev->data->mac_addrs) {
+		MACB_LOG(ERR, "Failed to allocate space for eth addrs");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	/* Initialize local interrupt handle for current port. */
+	priv->intr_handle =
+		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_SHARED);
+	if (priv->intr_handle == NULL) {
+		MACB_LOG(ERR, "Fail to allocate intr_handle");
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	dev->rx_pkt_burst = eth_macb_recv_pkts;
+	dev->tx_pkt_burst = eth_macb_xmit_pkts;
+	dev->dev_ops = &macb_ops;
+	dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS | RTE_ETH_DEV_INTR_LSC;
+
+	/* for secondary processes, we don't initialise any further as primary
+	 * has already done this work. Only check we don't need a different
+	 * RX function
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		if (dev->data->scattered_rx)
+			dev->rx_pkt_burst = &eth_macb_recv_scattered_pkts;
+		return 0;
+	}
+
+	bp->dev = dev;
+
+	if (!bp->iomem) {
+		ret = macb_iomem_init(priv->name, bp, priv->physical_addr);
+		if (ret) {
+			MACB_LOG(ERR, "Failed to init device's iomem.");
+			ret = -EFAULT;
+			goto out_free;
+		}
+	}
+
+	if (rte_intr_fd_set(priv->intr_handle, bp->iomem->fd))
+		return -rte_errno;
+
+	if (rte_intr_type_set(priv->intr_handle, RTE_INTR_HANDLE_UIO))
+		return -rte_errno;
+
+	return 0;
+out_free:
+	return ret;
+}
+
+static int macb_get_dev_pclk(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	char pclk_hz[CLK_STR_LEN];
+	char *s;
+	char filename[PATH_MAX];
+
+	snprintf(filename, PATH_MAX, "%s/%s/pclk_hz", MACB_PDEV_PATH, priv->name);
+
+	FILE *file = fopen(filename, "r");
+	if (!file) {
+		MACB_LOG(ERR, "There is no macb_uio_pclk file!");
+		return -ENFILE;
+	}
+
+	memset(pclk_hz, 0, CLK_STR_LEN);
+
+	s = fgets(pclk_hz, CLK_STR_LEN, file);
+	if (!s) {
+		fclose(file);
+		MACB_LOG(ERR, "get phy pclk error!");
+		return -EINVAL;
+	}
+
+	priv->pclk_hz = atol(pclk_hz);
+	fclose(file);
+	return 0;
+}
+
+static const char *macb_phy_modes(phy_interface_t interface)
+{
+	switch (interface) {
+	case MACB_PHY_INTERFACE_MODE_NA:
+		return "";
+	case MACB_PHY_INTERFACE_MODE_INTERNAL:
+		return "internal";
+	case MACB_PHY_INTERFACE_MODE_MII:
+		return "mii";
+	case MACB_PHY_INTERFACE_MODE_GMII:
+		return "gmii";
+	case MACB_PHY_INTERFACE_MODE_SGMII:
+		return "sgmii";
+	case MACB_PHY_INTERFACE_MODE_TBI:
+		return "tbi";
+	case MACB_PHY_INTERFACE_MODE_REVMII:
+		return "rev-mii";
+	case MACB_PHY_INTERFACE_MODE_RMII:
+		return "rmii";
+	case MACB_PHY_INTERFACE_MODE_RGMII:
+		return "rgmii";
+	case MACB_PHY_INTERFACE_MODE_RGMII_ID:
+		return "rgmii-id";
+	case MACB_PHY_INTERFACE_MODE_RGMII_RXID:
+		return "rgmii-rxid";
+	case MACB_PHY_INTERFACE_MODE_RGMII_TXID:
+		return "rgmii-txid";
+	case MACB_PHY_INTERFACE_MODE_RTBI:
+		return "rtbi";
+	case MACB_PHY_INTERFACE_MODE_SMII:
+		return "smii";
+	case MACB_PHY_INTERFACE_MODE_XGMII:
+		return "xgmii";
+	case MACB_PHY_INTERFACE_MODE_MOCA:
+		return "moca";
+	case MACB_PHY_INTERFACE_MODE_QSGMII:
+		return "qsgmii";
+	case MACB_PHY_INTERFACE_MODE_TRGMII:
+		return "trgmii";
+	case MACB_PHY_INTERFACE_MODE_100BASEX:
+		return "100base-x";
+	case MACB_PHY_INTERFACE_MODE_1000BASEX:
+		return "1000base-x";
+	case MACB_PHY_INTERFACE_MODE_2500BASEX:
+		return "2500base-x";
+	case MACB_PHY_INTERFACE_MODE_5GBASER:
+		return "5gbase-r";
+	case MACB_PHY_INTERFACE_MODE_RXAUI:
+		return "rxaui";
+	case MACB_PHY_INTERFACE_MODE_XAUI:
+		return "xaui";
+	case MACB_PHY_INTERFACE_MODE_10GBASER:
+		return "10gbase-r";
+	case MACB_PHY_INTERFACE_MODE_USXGMII:
+		return "usxgmii";
+	case MACB_PHY_INTERFACE_MODE_10GKR:
+		return "10gbase-kr";
+	default:
+		return "unknown";
+	}
+}
+
+static int macb_get_phy_mode(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	char phy_mode[PHY_MODE_LEN];
+	char *s;
+	int i;
+	char filename[PATH_MAX];
+
+	snprintf(filename, PATH_MAX, "%s/%s/phy_mode", MACB_PDEV_PATH, priv->name);
+
+	FILE *file = fopen(filename, "r");
+	if (!file) {
+		MACB_LOG(ERR, "There is no phy_mode file!");
+		return -ENFILE;
+	}
+
+	memset(phy_mode, 0, PHY_MODE_LEN);
+
+	s = fgets(phy_mode, PHY_MODE_LEN, file);
+	if (!s) {
+		fclose(file);
+		MACB_LOG(ERR, "get phy mode error!");
+		return -EINVAL;
+	}
+
+	priv->phy_interface = MACB_PHY_INTERFACE_MODE_MAX + 1;
+	for (i = 0; i < MACB_PHY_INTERFACE_MODE_MAX; i++) {
+		if (!strcasecmp(phy_mode, macb_phy_modes(i))) {
+			priv->phy_interface = i;
+			break;
+		}
+	}
+
+	if (priv->phy_interface > MACB_PHY_INTERFACE_MODE_MAX) {
+		MACB_LOG(ERR, "Invalid phy_mode value: %s!", phy_mode);
+		return -EINVAL;
+	}
+
+	fclose(file);
+	return 0;
+}
+
+static int macb_get_physical_addr(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	char physical_addr[PHY_ADDR_LEN];
+	char *s;
+	char *stopstr;
+	char filename[PATH_MAX];
+
+	snprintf(filename, PATH_MAX, "%s/%s/physical_addr", MACB_PDEV_PATH, priv->name);
+
+	FILE *file = fopen(filename, "r");
+	if (!file) {
+		MACB_LOG(ERR, "There is no physical_addr file!");
+		return -ENFILE;
+	}
+
+	memset(physical_addr, 0, PHY_ADDR_LEN);
+
+	s = fgets(physical_addr, PHY_ADDR_LEN, file);
+	if (!s) {
+		fclose(file);
+		MACB_LOG(ERR, "get physical address error!");
+		return -EINVAL;
+	}
+
+	priv->physical_addr = strtoul(physical_addr, &stopstr, 16);
+	fclose(file);
+	return 0;
+}
+
+static int macb_get_dev_type(struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	char dev_type[DEV_TYPE_LEN];
+	char *s;
+	char filename[PATH_MAX];
+	priv->dev_type = DEV_TYPE_DEFAULT;
+
+	snprintf(filename, PATH_MAX, "%s/%s/dev_type", MACB_PDEV_PATH, priv->name);
+
+	FILE *file = fopen(filename, "r");
+	if (!file) {
+		MACB_LOG(ERR, "There is no macb_dev_type file!");
+		return -ENFILE;
+	}
+
+	memset(dev_type, 0, DEV_TYPE_LEN);
+
+	s = fgets(dev_type, DEV_TYPE_LEN, file);
+	if (!s) {
+		fclose(file);
+		MACB_LOG(ERR, "get dev type error!");
+		return -EINVAL;
+	}
+	if (!strcmp(dev_type, OF_PHYTIUM_GEM1P0_MAC) ||
+	    !strcmp(dev_type, ACPI_PHYTIUM_GEM1P0_MAC)) {
+		priv->dev_type = DEV_TYPE_PHYTIUM_GEM1P0_MAC;
+	} else if (!strcmp(dev_type, OF_PHYTIUM_GEM2P0_MAC)) {
+		priv->dev_type = DEV_TYPE_PHYTIUM_GEM2P0_MAC;
+	} else {
+		MACB_LOG(ERR, "Unsupported device type: %s.", dev_type);
+		return -EINVAL;
+	}
+
+	fclose(file);
+	return 0;
+}
+
+static int macb_get_speed_info(struct rte_eth_dev *dev, char *speed_info)
+{
+	char filename[PATH_MAX];
+	char *s;
+	struct macb_priv *priv = dev->data->dev_private;
+
+	if (!speed_info) {
+		MACB_LOG(ERR, "speed info is NULL.");
+		return -ENOMEM;
+	}
+
+	snprintf(filename, PATH_MAX, "%s/%s/speed_info", MACB_PDEV_PATH, priv->name);
+	FILE *file = fopen(filename, "r");
+	if (!file) {
+		MACB_LOG(ERR, "There is no speed_info file!");
+		return -ENFILE;
+	}
+
+	s = fgets(speed_info, SPEED_INFO_LEN, file);
+	if (!s) {
+		fclose(file);
+		MACB_LOG(ERR, "get speed info error!");
+		return -EINVAL;
+	}
+
+	fclose(file);
+	return 0;
+}
+
+static int macb_get_fixed_link_speed_info(struct rte_eth_dev *dev, struct macb *bp)
+{
+	char speed_info[SPEED_INFO_LEN];
+	char *duplex = NULL;
+	int ret = 0;
+
+	memset(speed_info, 0, SPEED_INFO_LEN);
+
+	ret = macb_get_speed_info(dev, speed_info);
+	if (ret)
+		return ret;
+
+	if (!strcmp(speed_info, "unknown")) {
+		MACB_LOG(ERR, "speed info is unknown.");
+		return -EINVAL;
+	} else if (!strncmp(speed_info, "fixed-link", 10)) {
+		bp->speed = atoi(speed_info + 11);
+		duplex = strstr(speed_info, "full-duplex");
+		if (duplex) {
+			bp->duplex = DUPLEX_FULL;
+			return 0;
+		}
+		duplex = strstr(speed_info, "half-duplex");
+		if (duplex) {
+			bp->duplex = DUPLEX_HALF;
+			return 0;
+		}
+	} else {
+		MACB_LOG(ERR, "Unsupported speed_info : %s.", speed_info);
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int macb_update_fixed_link(struct rte_eth_dev *dev, struct macb *bp)
+{
+	int ret = 0;
+	char speed_info[SPEED_INFO_LEN] = {0};
+
+	ret = macb_get_speed_info(dev, speed_info);
+	if (ret)
+		return ret;
+
+	if (!strncmp(speed_info, "fixed-link", 10))
+		bp->fixed_link = true;
+	return ret;
+}
+
+/**
+ * Create device representing Ethernet port.
+ *
+ * @param ethdev_name
+ *   Pointer to the ethdev's name. example: net_macb0
+ *
+ * @param dev_name
+ *   Pointer to the port's name. example: 3200c000.ethernet
+ *
+ * @return
+ *   0 on success, negative error value otherwise.
+ */
+static int macb_dev_create(struct rte_vdev_device *vdev, const char *ethdev_name,
+			   const char *dev_name, bool phydrv_used)
+{
+	int ret;
+	struct rte_eth_dev *eth_dev;
+	struct macb_priv *priv;
+	struct macb *bp;
+	struct phy_device *phydev;
+
+	eth_dev = rte_eth_dev_allocate(ethdev_name);
+	if (!eth_dev) {
+		MACB_LOG(ERR, "failed to allocate eth_dev.");
+		return -ENOMEM;
+	}
+
+	if (eth_dev->data->dev_private)
+		goto create_done;
+
+	priv = rte_zmalloc_socket(ethdev_name, sizeof(*priv), 0, rte_socket_id());
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	bp = rte_zmalloc_socket(ethdev_name, sizeof(*bp), 0, rte_socket_id());
+	if (!bp) {
+		ret = -EPERM;
+		goto out_free;
+	}
+
+	phydev = rte_zmalloc_socket(ethdev_name, sizeof(*phydev), 0, rte_socket_id());
+	if (!phydev) {
+		ret = -EPERM;
+		goto out_free_bp;
+	}
+
+	eth_dev->device = &vdev->device;
+	eth_dev->data->dev_private = priv;
+	priv->bp = bp;
+	strlcpy(priv->name, dev_name, sizeof(priv->name));
+	bp->link = false;
+	bp->fixed_link = false;
+	bp->phydrv_used = phydrv_used;
+	bp->phydev = phydev;
+	phydev->bp = bp;
+	priv->stopped = true;
+
+	ret = macb_get_dev_pclk(eth_dev);
+	if (ret)
+		goto out_free_phydev;
+
+	ret = macb_get_phy_mode(eth_dev);
+	if (ret)
+		goto out_free_phydev;
+	bp->phy_interface = priv->phy_interface;
+
+	ret = macb_get_physical_addr(eth_dev);
+	if (ret)
+		goto out_free_phydev;
+
+	ret = macb_dev_init(eth_dev);
+	if (ret)
+		goto out_free_phydev;
+
+	ret = macb_get_dev_type(eth_dev);
+	if (ret)
+		goto out_free_phydev;
+
+	ret = macb_update_fixed_link(eth_dev, bp);
+	if (ret)
+		goto out_free_phydev;
+
+	if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_USXGMII) {
+		ret = macb_get_fixed_link_speed_info(eth_dev, bp);
+		if (ret < 0) {
+			bp->speed = SPEED_10000;
+			bp->duplex = DUPLEX_FULL;
+		}
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_2500BASEX) {
+		bp->speed = SPEED_2500;
+		bp->duplex = DUPLEX_FULL;
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_1000BASEX) {
+		bp->speed = SPEED_1000;
+		bp->duplex = DUPLEX_FULL;
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_100BASEX) {
+		bp->speed = SPEED_100;
+		bp->duplex = DUPLEX_FULL;
+	} else if (bp->phy_interface == MACB_PHY_INTERFACE_MODE_SGMII && bp->fixed_link) {
+		ret = macb_get_fixed_link_speed_info(eth_dev, bp);
+		if (ret < 0) {
+			bp->speed = SPEED_1000;
+			bp->duplex = DUPLEX_FULL;
+		}
+	} else {
+		bp->speed = SPEED_UNKNOWN;
+		bp->duplex = DUPLEX_UNKNOWN;
+	}
+
+	macb_phy_auto_detect(eth_dev);
+
+	ret = rte_intr_callback_register(priv->intr_handle, macb_interrupt_handler,
+									 (void *)eth_dev);
+	if (ret) {
+		MACB_LOG(ERR, "register callback failed.");
+		goto out_free_phydev;
+	}
+
+	rte_eth_dev_probing_finish(eth_dev);
+create_done:
+	return 0;
+
+out_free_phydev:
+	rte_free(phydev);
+out_free_bp:
+	rte_free(bp);
+
+out_free:
+	rte_eth_dev_release_port(eth_dev);
+
+	return ret;
+}
+
+/**
+ * DPDK callback to remove virtual device.
+ *
+ * @param vdev
+ *   Pointer to the removed virtual device.
+ *
+ * @return
+ *   0 on success, negative error value otherwise.
+ */
+static int rte_pmd_macb_remove(struct rte_vdev_device *vdev)
+{
+	uint16_t dev_id;
+	int ret = 0;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	RTE_ETH_FOREACH_DEV(dev_id)
+	{
+		if (rte_eth_devices[dev_id].device != &vdev->device)
+			continue;
+		ret |= rte_eth_dev_close(dev_id);
+	}
+
+#if MACB_PORT_MODE_SWITCH
+	dlclose(macb_phy_dl_handle);
+#endif
+
+	return ret == 0 ? 0 : -EIO;
+}
+
+/**
+ * DPDK callback to register the virtual device.
+ *
+ * @param vdev
+ *   Pointer to the virtual device.
+ *
+ * @return
+ *   0 on success, negative error value otherwise.
+ */
+static int rte_pmd_macb_probe(struct rte_vdev_device *vdev)
+{
+	struct rte_kvargs *kvlist;
+	struct macb_devices devices;
+	bool phydrv_used = true;
+	int ret = -EINVAL;
+	uint32_t i, dev_num;
+	const char *params;
+	enum rte_iova_mode iova_mode;
+	char ethdev_name[RTE_DEV_NAME_MAX_LEN] = "";
+	const char *vdev_name;
+	struct rte_eth_dev *eth_dev;
+
+#if MACB_PORT_MODE_SWITCH
+	macb_phy_dl_handle = dlopen(LIB_PHY_NAME, RTLD_LAZY);
+	if (!macb_phy_dl_handle) {
+		MACB_LOG(ERR, "Failed load library: %s", dlerror());
+		return -1;
+	}
+	macb_phy_init = dlsym(macb_phy_dl_handle, "phytium_serdes_phy_init");
+	if (!macb_phy_init) {
+		MACB_LOG(ERR, "Failed to resolve symbol: %s", dlerror());
+		return -1;
+	}
+#endif
+
+	vdev_name = rte_vdev_device_name(vdev);
+
+	/* secondary process probe */
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		eth_dev = rte_eth_dev_attach_secondary(vdev_name);
+		if (!eth_dev) {
+			MACB_LOG(ERR, "Secondary failed to probe eth_dev.");
+			return -1;
+		}
+
+		if (vdev->device.numa_node == SOCKET_ID_ANY)
+			vdev->device.numa_node = rte_socket_id();
+		eth_dev->device = &vdev->device;
+		rte_eth_dev_probing_finish(eth_dev);
+
+		return 0;
+	}
+
+	iova_mode = rte_eal_iova_mode();
+	if (iova_mode != RTE_IOVA_PA) {
+		MACB_LOG(ERR, "Expecting 'PA' IOVA mode but current mode is 'VA', not "
+					  "initializing");
+		return -EINVAL;
+	}
+
+	rte_log_set_level(macb_logtype, rte_log_get_global_level());
+
+	params = rte_vdev_device_args(vdev);
+	if (!params) {
+		MACB_LOG(ERR, "failed to get the args.");
+		return -EINVAL;
+	}
+
+	kvlist = rte_kvargs_parse(params, valid_args);
+	if (!kvlist) {
+		MACB_LOG(ERR, "failed to parse the kvargs.");
+		return -EINVAL;
+	}
+
+	rte_kvargs_process(kvlist, MACB_USE_PHYDRV_ARG, macb_phydrv_used_get, &phydrv_used);
+
+	dev_num = rte_kvargs_count(kvlist, MACB_DEVICE_NAME_ARG);
+
+	/* compatibility support */
+	if (!strcmp(vdev_name, "net_macb")) {
+		if (dev_num > MACB_MAX_PORT_NUM) {
+			ret = -EINVAL;
+			MACB_LOG(ERR, "number of devices exceeded. Maximum value: %d.",
+				 MACB_MAX_PORT_NUM);
+			goto out_free_kvlist;
+		}
+	} else {
+		if (dev_num != 1) {
+			ret = -EINVAL;
+			MACB_LOG(ERR, "Error args: one vdev to one device.");
+			goto out_free_kvlist;
+		}
+	}
+
+	devices.idx = 0;
+	rte_kvargs_process(kvlist, MACB_DEVICE_NAME_ARG, macb_devices_get, &devices);
+
+	MACB_INFO("Phytium mac driver v%s", MACB_DRIVER_VERSION);
+
+	for (i = 0; i < dev_num; i++) {
+		if (dev_num > 1)
+			snprintf(ethdev_name, RTE_DEV_NAME_MAX_LEN, "%s%d", vdev_name, i);
+		else
+			snprintf(ethdev_name, RTE_DEV_NAME_MAX_LEN, "%s", vdev_name);
+
+		ret = macb_dev_create(vdev, ethdev_name, devices.names[i], phydrv_used);
+		if (ret) {
+			MACB_LOG(ERR, "failed to create device.");
+			goto out_cleanup;
+		}
+
+		macb_dev_num++;
+	}
+
+	rte_kvargs_free(kvlist);
+	return 0;
+
+out_cleanup:
+	rte_pmd_macb_remove(vdev);
+
+out_free_kvlist:
+	rte_kvargs_free(kvlist);
+
+	return ret;
+}
+
+static struct rte_vdev_driver pmd_macb_drv = {
+	.probe = rte_pmd_macb_probe,
+	.remove = rte_pmd_macb_remove,
+};
+
+RTE_PMD_REGISTER_VDEV(net_macb, pmd_macb_drv);
+RTE_PMD_REGISTER_PARAM_STRING(net_macb,
+					MACB_DEVICE_NAME_ARG "=<string> "
+					MACB_USE_PHYDRV_ARG "=<int>");
+
+RTE_INIT(macb_init_log)
+{
+	if (macb_log_initialized)
+		return;
+
+	macb_logtype = rte_log_register("pmd.net.macb");
+	if (macb_logtype >= 0)
+		rte_log_set_level(macb_logtype, RTE_LOG_NOTICE);
+
+	macb_log_initialized = 1;
+}
diff --git a/drivers/net/macb/macb_ethdev.h b/drivers/net/macb/macb_ethdev.h
new file mode 100644
index 0000000..d9dba6b
--- /dev/null
+++ b/drivers/net/macb/macb_ethdev.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#ifndef _MACB_ETHDEV_H_
+#define _MACB_ETHDEV_H_
+
+#include <rte_interrupts.h>
+#include <dlfcn.h>
+#include "base/macb_common.h"
+#include "macb_log.h"
+
+#define ETH_P_IP	0x0800		/* Internet Protocol packet	*/
+#define ETH_MIN_MTU	68		/* Min IPv4 MTU per RFC791	*/
+
+#define CLK_STR_LEN 64
+#define PHY_MODE_LEN 64
+#define PHY_ADDR_LEN 64
+#define DEV_TYPE_LEN 64
+#define SPEED_INFO_LEN 64
+#define MAX_PHY_AD_NUM 32
+#define PHY_ID_OFFSET 16
+
+#define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
+
+#ifndef min
+#define min(x, y) ({ \
+		typeof(x) _x = (x); \
+		typeof(y) _y = (y); \
+		(_x < _y) ? _x : _y; \
+		})
+#endif
+
+/*
+ * Custom phy driver need to be stated here.
+ */
+extern struct phy_driver genphy_driver;
+
+/*internal macb 10G PHY*/
+extern struct phy_driver macb_usxgmii_pcs_driver;
+/*internal macb gbe PHY*/
+extern struct phy_driver macb_gbe_pcs_driver;
+
+#ifndef MACB_PORT_MODE_SWITCH
+#define MACB_PORT_MODE_SWITCH 0
+#endif
+
+#define VLAN_TAG_SIZE    4
+#define RTE_ETHER_CRC_LEN   4 /**< Length of Ethernet CRC. */
+#define RTE_ETHER_TYPE_LEN 2
+#define RTE_ETHER_ADDR_LEN 6
+#define RTE_ETHER_HDR_LEN   \
+	(RTE_ETHER_ADDR_LEN * 2 + \
+	 RTE_ETHER_TYPE_LEN) /**< Length of Ethernet header. */
+#define MACB_ETH_OVERHEAD (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + \
+				VLAN_TAG_SIZE)
+
+#define MACB_RX_INT_FLAGS	(MACB_BIT(RCOMP) | MACB_BIT(ISR_ROVR))
+#define MACB_TX_ERR_FLAGS	(MACB_BIT(ISR_TUND)			\
+					| MACB_BIT(ISR_RLE)		\
+					| MACB_BIT(TXERR))
+#define MACB_TX_INT_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(TCOMP)	\
+					| MACB_BIT(TXUBR))
+
+#if MACB_PORT_MODE_SWITCH
+#define LIB_PHY_NAME "libpe2204phy.so"
+#define MAC0_ADDR_BASE 0x3200c000
+#define MAC1_ADDR_BASE 0x3200e000
+
+enum macb_port_id {
+	PORT0,
+	PORT1,
+	PORT_MAX
+};
+#endif
+
+struct macb_priv {
+	struct macb *bp;
+	uint32_t port_id;
+	uint64_t pclk_hz;
+	phys_addr_t physical_addr;
+	uint32_t dev_type;
+	bool stopped;
+	netdev_features_t hw_features;
+	netdev_features_t phy_interface;
+	struct rte_eth_stats prev_stats;
+	struct rte_intr_handle *intr_handle;
+	char name[RTE_ETH_NAME_MAX_LEN];
+};
+
+#endif /* _MACB_ETHDEV_H_ */
diff --git a/drivers/net/macb/macb_log.h b/drivers/net/macb/macb_log.h
new file mode 100644
index 0000000..b13d73a
--- /dev/null
+++ b/drivers/net/macb/macb_log.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#ifndef _MACB_LOG_H_
+#define _MACB_LOG_H_
+
+/* Current log type. */
+extern int macb_logtype;
+
+#define RTE_LOGTYPE_MACB macb_logtype
+#define MACB_LOG(level, fmt, ...) \
+	RTE_LOG_LINE(level, MACB, "%s(): " fmt, \
+		__func__, ##__VA_ARGS__)
+
+#define MACB_INFO(fmt, ...) \
+	RTE_LOG_LINE(INFO, MACB, fmt, ##__VA_ARGS__)
+
+#endif /*_MACB_LOG_H_ */
diff --git a/drivers/net/macb/macb_rxtx.c b/drivers/net/macb/macb_rxtx.c
new file mode 100644
index 0000000..40157a4
--- /dev/null
+++ b/drivers/net/macb/macb_rxtx.c
@@ -0,0 +1,1391 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#include <rte_bus_vdev.h>
+#include <ethdev_driver.h>
+#include <rte_kvargs.h>
+#include <rte_string_fns.h>
+#include <rte_vect.h>
+
+#include <fcntl.h>
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
+#include <net/if.h>
+#include <net/if_arp.h>
+#include <rte_ether.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <sys/param.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include "macb_rxtx.h"
+
+#define MACB_MAX_TX_BURST    32
+#define MACB_TX_MAX_FREE_BUF_SZ 64
+
+/* Default RS bit threshold values */
+#ifndef MACB_DEFAULT_TX_RS_THRESH
+#define MACB_DEFAULT_TX_RS_THRESH   32
+#endif
+#ifndef MACB_DEFAULT_TX_FREE_THRESH
+#define MACB_DEFAULT_TX_FREE_THRESH 32
+#endif
+
+uint16_t eth_macb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
+							uint16_t nb_pkts)
+{
+	struct macb_tx_queue *queue;
+	struct macb *bp;
+	struct macb_tx_entry *macb_txe;
+	uint32_t tx_head, tx_tail;
+	struct rte_mbuf *tx_pkt;
+	struct rte_mbuf *m_seg;
+	uint16_t nb_tx;
+	uint32_t tx_first;
+	uint32_t tx_last;
+	uint64_t buf_dma_addr;
+	uint16_t free_txds;
+	u32 ctrl;
+	struct macb_dma_desc *txdesc;
+
+	queue = (struct macb_tx_queue *)tx_queue;
+	bp = queue->bp;
+
+	macb_reclaim_txd(queue);
+	tx_head = queue->tx_head;
+	tx_tail = queue->tx_tail;
+	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		tx_pkt = *tx_pkts++;
+		tx_first = tx_tail;
+		tx_last = tx_tail + tx_pkt->nb_segs - 1;
+		tx_last = macb_tx_ring_wrap(bp, tx_last);
+
+		/* Make hw descriptor updates visible to CPU */
+		rte_rmb();
+
+		if (unlikely(tx_head == tx_tail))
+			free_txds = bp->tx_ring_size - 1;
+		else if (tx_head > tx_tail)
+			free_txds = tx_head - tx_tail - 1;
+		else
+			free_txds = bp->tx_ring_size - (tx_tail - tx_head) - 1;
+
+		if (free_txds < tx_pkt->nb_segs) {
+			if (nb_tx == 0)
+				return 0;
+			goto end_of_tx;
+		}
+
+		m_seg = tx_pkt;
+		do {
+			txdesc = macb_tx_desc(queue, tx_tail);
+			macb_txe = macb_tx_entry(queue, tx_tail);
+			if (likely(macb_txe->mbuf != NULL))
+				rte_pktmbuf_free_seg(macb_txe->mbuf);
+			macb_txe->mbuf = m_seg;
+
+			queue->stats.tx_bytes += m_seg->data_len;
+			ctrl = (u32)m_seg->data_len | MACB_BIT(TX_USED);
+			if (unlikely(tx_tail == (queue->nb_tx_desc - 1)))
+				ctrl |= MACB_BIT(TX_WRAP);
+
+			if (likely(tx_tail == tx_last))
+				ctrl |= MACB_BIT(TX_LAST);
+
+			buf_dma_addr = rte_mbuf_data_iova(m_seg);
+			/* Set TX buffer descriptor */
+			macb_set_addr(bp, txdesc, buf_dma_addr);
+			txdesc->ctrl = ctrl;
+			m_seg = m_seg->next;
+
+			tx_tail = macb_tx_ring_wrap(bp, ++tx_tail);
+		} while (unlikely(m_seg != NULL));
+
+		while (unlikely(tx_last != tx_first)) {
+			txdesc = macb_tx_desc(queue, tx_last);
+			txdesc->ctrl &= ~MACB_BIT(TX_USED);
+			tx_last = macb_tx_ring_wrap(bp, --tx_last);
+		}
+
+		txdesc = macb_tx_desc(queue, tx_last);
+		rte_wmb();
+		txdesc->ctrl &= ~MACB_BIT(TX_USED);
+
+		queue->stats.tx_packets++;
+	}
+
+end_of_tx:
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+	queue->tx_tail = tx_tail;
+
+	return nb_tx;
+}
+
+uint16_t eth_macb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
+							uint16_t nb_pkts)
+{
+	struct macb_rx_queue *rxq;
+	unsigned int len;
+	unsigned int entry, next_entry;
+	struct macb_dma_desc *desc, *ndesc;
+	uint16_t nb_rx;
+	struct macb *bp;
+	struct rte_mbuf *rxm;
+	struct rte_mbuf *nmb;
+	struct macb_rx_entry *rxe, *rxn;
+	uint64_t dma_addr;
+	uint8_t rxused_v[MACB_LOOK_AHEAD];
+	uint8_t nb_rxused;
+	int i;
+
+	nb_rx = 0;
+	rxq = rx_queue;
+	bp = rxq->bp;
+
+	while (nb_rx < nb_pkts) {
+		u32 ctrl;
+		bool rxused;
+		struct rte_ether_hdr *eth_hdr;
+		uint16_t ether_type;
+
+		entry = macb_rx_ring_wrap(bp, rxq->rx_tail);
+		desc = macb_rx_desc(rxq, entry);
+
+		/* Make hw descriptor updates visible to CPU */
+		rte_rmb();
+
+		rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
+		if (!rxused)
+			break;
+
+		for (i = 0; i < MACB_LOOK_AHEAD; i++) {
+			desc = macb_rx_desc(rxq, (entry + i));
+			rxused_v[i] = (desc->addr & MACB_BIT(RX_USED)) ? 1 : 0;
+		}
+
+		/* Ensure ctrl is at least as up-to-date as rxused */
+		rte_rmb();
+
+		/* Compute how many status bits were set */
+		for (i = 0, nb_rxused = 0; i < MACB_LOOK_AHEAD; i++) {
+			if (unlikely(rxused_v[i] == 0))
+				break;
+			nb_rxused += rxused_v[i];
+		}
+
+		/* Translate descriptor info to mbuf parameters */
+		for (i = 0; i < nb_rxused; i++) {
+			rxe = macb_rx_entry(rxq, (entry + i));
+			desc = macb_rx_desc(rxq, (entry + i));
+			ctrl = desc->ctrl;
+			rxq->rx_tail++;
+			rte_prefetch0(macb_rx_entry(rxq, rxq->rx_tail)->mbuf);
+
+			if (unlikely((ctrl & (MACB_BIT(RX_SOF) | MACB_BIT(RX_EOF)))
+				!= (MACB_BIT(RX_SOF) | MACB_BIT(RX_EOF)))) {
+				MACB_LOG(ERR, "not whole frame pointed by descriptor");
+				rxq->rx_tail = macb_rx_ring_wrap(bp, rxq->rx_tail);
+				rxq->stats.rx_dropped++;
+
+				desc->ctrl = 0;
+				rte_wmb();
+				desc->addr &= ~MACB_BIT(RX_USED);
+				continue;
+			}
+
+			nmb = rte_mbuf_raw_alloc(rxq->mb_pool);
+			if (unlikely(!nmb)) {
+				MACB_LOG(ERR, "RX mbuf alloc failed port_id=%u queue_id=%u",
+					 (unsigned int)rxq->port_id, (unsigned int)rxq->queue_id);
+				rxq->rx_tail = macb_rx_ring_wrap(bp, rxq->rx_tail);
+				rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed++;
+				rxq->stats.rx_dropped++;
+
+				desc->ctrl = 0;
+				rte_wmb();
+				desc->addr &= ~MACB_BIT(RX_USED);
+				goto out;
+			}
+			nmb->data_off = RTE_PKTMBUF_HEADROOM + MACB_RX_DATA_OFFSET;
+
+			next_entry = macb_rx_ring_wrap(bp, (rxq->rx_tail + MACB_NEXT_FETCH));
+			rxn = macb_rx_entry(rxq, next_entry);
+			rte_prefetch0((char *)rxn->mbuf->buf_addr + rxn->mbuf->data_off);
+			ndesc = macb_rx_desc(rxq, next_entry);
+
+			/*
+			 * When next RX descriptor is on a cache-line boundary,
+			 * prefetch the next 2 RX descriptors.
+			 */
+			if ((next_entry & 0x3) == 0)
+				rte_prefetch0(ndesc);
+
+			rxm = rxe->mbuf;
+			rxe->mbuf = nmb;
+
+			len = (ctrl & bp->rx_frm_len_mask) - rxq->crc_len;
+			rxq->stats.rx_packets++;
+			rxq->stats.rx_bytes += len;
+
+			dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
+			rxm->nb_segs = 1;
+			rxm->next = NULL;
+			rxm->pkt_len = len;
+			rxm->data_len = len;
+			rxm->port = rxq->port_id;
+			rxm->ol_flags = RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD;
+
+			eth_hdr = rte_pktmbuf_mtod(rxm, struct rte_ether_hdr *);
+			ether_type = eth_hdr->ether_type;
+
+			if (ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
+				rxm->packet_type = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4;
+			else if (ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6))
+				rxm->packet_type = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6;
+			else
+				rxm->packet_type = RTE_PTYPE_UNKNOWN;
+
+			/*
+			 * Store the mbuf address into the next entry of the array
+			 * of returned packets.
+			 */
+			rx_pkts[nb_rx++] = rxm;
+
+			if (unlikely(rxq->rx_tail == rxq->nb_rx_desc)) {
+				dma_addr |= MACB_BIT(RX_WRAP);
+				rxq->rx_tail = 0;
+			}
+
+			desc->ctrl = 0;
+			/* Setting addr clears RX_USED and allows reception,
+			 * make sure ctrl is cleared first to avoid a race.
+			 */
+			rte_wmb();
+			macb_set_addr(bp, desc, dma_addr);
+		}
+
+		if (nb_rxused != MACB_LOOK_AHEAD)
+			break;
+	}
+
+out:
+	return nb_rx;
+}
+
+uint16_t eth_macb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
+									  uint16_t nb_pkts)
+{
+	struct macb_rx_queue *rxq;
+	unsigned int len;
+	unsigned int entry, next_entry;
+	struct macb_dma_desc *desc, *ndesc;
+	uint16_t nb_rx;
+	struct macb *bp;
+	struct rte_mbuf *first_seg;
+	struct rte_mbuf *last_seg;
+	struct rte_mbuf *rxm;
+	struct rte_mbuf *nmb;
+	struct macb_rx_entry *rxe, *rxn;
+	uint64_t dma_addr;
+	uint8_t rxused_v[MACB_LOOK_AHEAD];
+	uint8_t nb_rxused;
+	uint16_t data_bus_width_mask;
+	int i;
+
+	nb_rx = 0;
+	rxq = rx_queue;
+	bp = rxq->bp;
+
+	/*
+	 * Retrieve RX context of current packet, if any.
+	 */
+	first_seg = rxq->pkt_first_seg;
+	last_seg = rxq->pkt_last_seg;
+	data_bus_width_mask = MACB_DATA_BUS_WIDTH_MASK(bp->data_bus_width);
+
+	while (nb_rx < nb_pkts) {
+		u32 ctrl;
+		bool rxused;
+		struct rte_ether_hdr *eth_hdr;
+		uint16_t ether_type;
+
+		entry = macb_rx_ring_wrap(bp, rxq->rx_tail);
+		desc = macb_rx_desc(rxq, entry);
+
+		/* Make hw descriptor updates visible to CPU */
+		rte_rmb();
+
+		rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
+		if (!rxused)
+			break;
+
+		for (i = 0; i < MACB_LOOK_AHEAD; i++) {
+			desc = macb_rx_desc(rxq, (entry + i));
+			rxused_v[i] = (desc->addr & MACB_BIT(RX_USED)) ? 1 : 0;
+		}
+
+		/* Ensure ctrl is at least as up-to-date as rxused */
+		rte_rmb();
+
+		/* Compute how many status bits were set */
+		for (i = 0, nb_rxused = 0; i < MACB_LOOK_AHEAD; i++) {
+			if (unlikely(rxused_v[i] == 0))
+				break;
+			nb_rxused += rxused_v[i];
+		}
+
+		/* Translate descriptor info to mbuf parameters */
+		for (i = 0; i < nb_rxused; i++) {
+			rxe = macb_rx_entry(rxq, (entry + i));
+			desc = macb_rx_desc(rxq, (entry + i));
+			ctrl = desc->ctrl;
+			rxq->rx_tail++;
+			rte_prefetch0(macb_rx_entry(rxq, rxq->rx_tail)->mbuf);
+
+			nmb = rte_mbuf_raw_alloc(rxq->mb_pool);
+			if (unlikely(!nmb)) {
+				MACB_LOG(ERR, "RX mbuf alloc failed port_id=%u queue_id=%u",
+					 (unsigned int)rxq->port_id, (unsigned int)rxq->queue_id);
+				rxq->rx_tail = macb_rx_ring_wrap(bp, rxq->rx_tail);
+				rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed++;
+				rxq->stats.rx_dropped++;
+
+				desc->ctrl = 0;
+				rte_wmb();
+				desc->addr &= ~MACB_BIT(RX_USED);
+				goto out;
+			}
+			nmb->data_off = RTE_PKTMBUF_HEADROOM + MACB_RX_DATA_OFFSET;
+
+			next_entry = macb_rx_ring_wrap(bp, (rxq->rx_tail + MACB_NEXT_FETCH));
+			rxn = macb_rx_entry(rxq, next_entry);
+			rte_prefetch0((char *)rxn->mbuf->buf_addr + rxn->mbuf->data_off);
+			ndesc = macb_rx_desc(rxq, next_entry);
+
+			/*
+			 * When next RX descriptor is on a cache-line boundary,
+			 * prefetch the next 2 RX descriptors.
+			 */
+			if ((next_entry & 0x3) == 0)
+				rte_prefetch0(ndesc);
+
+			rxm = rxe->mbuf;
+			rxe->mbuf = nmb;
+
+			dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
+			if (unlikely(rxq->rx_tail == rxq->nb_rx_desc)) {
+				dma_addr |= MACB_BIT(RX_WRAP);
+				rxq->rx_tail = 0;
+			}
+			desc->ctrl = 0;
+			/* Setting addr clears RX_USED and allows reception,
+			 * make sure ctrl is cleared first to avoid a race.
+			 */
+			rte_wmb();
+			macb_set_addr(bp, desc, dma_addr);
+
+			len = ctrl & bp->rx_frm_len_mask;
+			rxq->stats.rx_bytes += len;
+
+			/*
+			 * If this is the first buffer of the received packet,
+			 * set the pointer to the first mbuf of the packet and
+			 * initialize its context.
+			 * Otherwise, update the total length and the number of segments
+			 * of the current scattered packet, and update the pointer to
+			 * the last mbuf of the current packet.
+			 */
+			if (!first_seg) {
+				first_seg = rxm;
+				first_seg->nb_segs = 1;
+				first_seg->pkt_len =
+					len ? len : (bp->rx_buffer_size - MACB_RX_DATA_OFFSET -
+					(RTE_PKTMBUF_HEADROOM & data_bus_width_mask));
+				rxm->data_len = first_seg->pkt_len;
+
+				eth_hdr = rte_pktmbuf_mtod(rxm, struct rte_ether_hdr *);
+				ether_type = eth_hdr->ether_type;
+
+				if (ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
+					rxm->packet_type = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4;
+				else if (ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6))
+					rxm->packet_type = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6;
+				else
+					rxm->packet_type = RTE_PTYPE_UNKNOWN;
+			} else {
+				rxm->data_len =
+					len ? (len - first_seg->pkt_len) : bp->rx_buffer_size;
+				rxm->data_off = RTE_PKTMBUF_HEADROOM & ~data_bus_width_mask;
+				if (likely(rxm->data_len > 0)) {
+					first_seg->pkt_len += rxm->data_len;
+					first_seg->nb_segs++;
+					last_seg->next = rxm;
+				}
+			}
+
+			/*
+			 * If this is not the last buffer of the received packet,
+			 * update the pointer to the last mbuf of the current scattered
+			 * packet and continue to parse the RX ring.
+			 */
+			if (!(ctrl & MACB_BIT(RX_EOF))) {
+				last_seg = rxm;
+				continue;
+			}
+
+			/*
+			 * This is the last buffer of the received packet.
+			 * If the CRC is not stripped by the hardware:
+			 *   - Subtract the CRC	length from the total packet length.
+			 *   - If the last buffer only contains the whole CRC or a part
+			 *     of it, free the mbuf associated to the last buffer.
+			 *     If part of the CRC is also contained in the previous
+			 *     mbuf, subtract the length of that CRC part from the
+			 *     data length of the previous mbuf.
+			 */
+			rxm->next = NULL;
+			if (unlikely(rxq->crc_len > 0)) {
+				first_seg->pkt_len -= RTE_ETHER_CRC_LEN;
+				if (rxm->data_len <= RTE_ETHER_CRC_LEN) {
+					rte_pktmbuf_free_seg(rxm);
+					first_seg->nb_segs--;
+					last_seg->data_len = (uint16_t)(last_seg->data_len -
+									(RTE_ETHER_CRC_LEN - len));
+					last_seg->next = NULL;
+				} else {
+					rxm->data_len = rxm->data_len - RTE_ETHER_CRC_LEN;
+				}
+			}
+
+			first_seg->port = rxq->port_id;
+			first_seg->ol_flags = RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+					      RTE_MBUF_F_RX_L4_CKSUM_GOOD;
+			/*
+			 * Store the mbuf address into the next entry of the array
+			 * of returned packets.
+			 */
+			rx_pkts[nb_rx++] = first_seg;
+			rxq->stats.rx_packets++;
+			/*
+			 * Setup receipt context for a new packet.
+			 */
+			first_seg = NULL;
+			last_seg = NULL;
+		}
+
+		if (nb_rxused != MACB_LOOK_AHEAD)
+			break;
+	}
+
+out:
+	/*
+	 * Save receive context.
+	 */
+	rxq->pkt_first_seg = first_seg;
+	rxq->pkt_last_seg = last_seg;
+
+	return nb_rx;
+}
+
+void __rte_cold macb_tx_queue_release_mbufs(struct macb_tx_queue *txq)
+{
+	unsigned int i;
+
+	if (txq->tx_sw_ring != NULL) {
+		for (i = 0; i < txq->nb_tx_desc; i++) {
+			if (txq->tx_sw_ring[i].mbuf != NULL) {
+				rte_pktmbuf_free_seg(txq->tx_sw_ring[i].mbuf);
+				txq->tx_sw_ring[i].mbuf = NULL;
+			}
+		}
+	}
+}
+
+static void __rte_cold macb_tx_queue_release(struct macb_tx_queue *txq)
+{
+	if (txq != NULL) {
+		macb_tx_queue_release_mbufs(txq);
+		rte_free(txq->tx_sw_ring);
+		rte_free(txq);
+	}
+}
+
+void __rte_cold eth_macb_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	macb_tx_queue_release(dev->data->tx_queues[qid]);
+}
+
+void __rte_cold macb_reset_tx_queue(struct macb_tx_queue *txq, struct rte_eth_dev *dev)
+{
+	struct macb_tx_entry *txe = txq->tx_sw_ring;
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	uint16_t i;
+	struct macb_dma_desc *desc = NULL;
+
+	/* Zero out HW ring memory */
+	for (i = 0; i < txq->nb_tx_desc; i++) {
+		desc = macb_tx_desc(txq, i);
+		macb_set_addr(bp, desc, 0);
+		desc->ctrl = MACB_BIT(TX_USED);
+	}
+
+	desc->ctrl |= MACB_BIT(TX_WRAP);
+	txq->tx_head = 0;
+	txq->tx_tail = 0;
+	memset((void *)&txq->stats, 0, sizeof(struct macb_tx_queue_stats));
+
+	/* Initialize ring entries */
+	for (i = 0; i < txq->nb_tx_desc; i++)
+		txe[i].mbuf = NULL;
+}
+
+static void __rte_cold
+macb_set_tx_function(struct macb_tx_queue *txq, struct rte_eth_dev *dev)
+{
+	if (txq->tx_rs_thresh >= MACB_MAX_TX_BURST) {
+		if (txq->tx_rs_thresh <= MACB_TX_MAX_FREE_BUF_SZ &&
+		    (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128)) {
+			MACB_LOG(DEBUG, "Vector tx enabled.");
+			dev->tx_pkt_burst = eth_macb_xmit_pkts_vec;
+		}
+	} else {
+		dev->tx_pkt_burst = eth_macb_xmit_pkts;
+	}
+}
+
+int __rte_cold eth_macb_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
+							uint16_t nb_desc, unsigned int socket_id,
+							const struct rte_eth_txconf *tx_conf)
+{
+	const struct rte_memzone *tz;
+	struct macb_tx_queue *txq;
+	uint32_t size;
+	struct macb_priv *priv;
+	struct macb *bp;
+	uint16_t tx_free_thresh, tx_rs_thresh;
+
+	priv = dev->data->dev_private;
+	bp = priv->bp;
+	/*
+	 * The following two parameters control the setting of the RS bit on
+	 * transmit descriptors.
+	 * TX descriptors will have their RS bit set after txq->tx_rs_thresh
+	 * descriptors have been used.
+	 * The TX descriptor ring will be cleaned after txq->tx_free_thresh
+	 * descriptors are used or if the number of descriptors required
+	 * to transmit a packet is greater than the number of free TX
+	 * descriptors.
+	 * The following constraints must be satisfied:
+	 *  tx_rs_thresh must be greater than 0.
+	 *  tx_rs_thresh must be less than the size of the ring minus 2.
+	 *  tx_rs_thresh must be less than or equal to tx_free_thresh.
+	 *  tx_rs_thresh must be a divisor of the ring size.
+	 *  tx_free_thresh must be greater than 0.
+	 *  tx_free_thresh must be less than the size of the ring minus 3.
+	 *  tx_free_thresh + tx_rs_thresh must not exceed nb_desc.
+	 * One descriptor in the TX ring is used as a sentinel to avoid a
+	 * H/W race condition, hence the maximum threshold constraints.
+	 * When set to zero use default values.
+	 */
+	tx_free_thresh = (uint16_t)((tx_conf->tx_free_thresh) ?
+			tx_conf->tx_free_thresh : MACB_DEFAULT_TX_FREE_THRESH);
+	/* force tx_rs_thresh to adapt an aggressive tx_free_thresh */
+	tx_rs_thresh = (MACB_DEFAULT_TX_RS_THRESH + tx_free_thresh > nb_desc) ?
+			nb_desc - tx_free_thresh : MACB_DEFAULT_TX_RS_THRESH;
+	if (tx_conf->tx_rs_thresh > 0)
+		tx_rs_thresh = tx_conf->tx_rs_thresh;
+	if (tx_rs_thresh + tx_free_thresh > nb_desc) {
+		MACB_LOG(ERR, "tx_rs_thresh + tx_free_thresh must not "
+			     "exceed nb_desc. (tx_rs_thresh=%u "
+			     "tx_free_thresh=%u nb_desc=%u port = %d queue=%d)",
+			     (unsigned int)tx_rs_thresh,
+			     (unsigned int)tx_free_thresh,
+			     (unsigned int)nb_desc,
+			     (int)dev->data->port_id,
+			     (int)queue_idx);
+		return -(EINVAL);
+	}
+	if (tx_rs_thresh >= (nb_desc - 2)) {
+		MACB_LOG(ERR, "tx_rs_thresh must be less than the number "
+			"of TX descriptors minus 2. (tx_rs_thresh=%u "
+			"port=%d queue=%d)", (unsigned int)tx_rs_thresh,
+			(int)dev->data->port_id, (int)queue_idx);
+		return -(EINVAL);
+	}
+	if (tx_rs_thresh > MACB_DEFAULT_TX_RS_THRESH) {
+		MACB_LOG(ERR, "tx_rs_thresh must be less or equal than %u. "
+			"(tx_rs_thresh=%u port=%d queue=%d)",
+			MACB_DEFAULT_TX_RS_THRESH, (unsigned int)tx_rs_thresh,
+			(int)dev->data->port_id, (int)queue_idx);
+		return -(EINVAL);
+	}
+	if (tx_free_thresh >= (nb_desc - 3)) {
+		MACB_LOG(ERR, "tx_rs_thresh must be less than the "
+			     "tx_free_thresh must be less than the number of "
+			     "TX descriptors minus 3. (tx_free_thresh=%u "
+			     "port=%d queue=%d)",
+			     (unsigned int)tx_free_thresh,
+			     (int)dev->data->port_id, (int)queue_idx);
+		return -(EINVAL);
+	}
+	if (tx_rs_thresh > tx_free_thresh) {
+		MACB_LOG(ERR, "tx_rs_thresh must be less than or equal to "
+			     "tx_free_thresh. (tx_free_thresh=%u "
+			     "tx_rs_thresh=%u port=%d queue=%d)",
+			     (unsigned int)tx_free_thresh,
+			     (unsigned int)tx_rs_thresh,
+			     (int)dev->data->port_id,
+			     (int)queue_idx);
+		return -(EINVAL);
+	}
+	if ((nb_desc % tx_rs_thresh) != 0) {
+		MACB_LOG(ERR, "tx_rs_thresh must be a divisor of the "
+			     "number of TX descriptors. (tx_rs_thresh=%u "
+			     "port=%d queue=%d)", (unsigned int)tx_rs_thresh,
+			     (int)dev->data->port_id, (int)queue_idx);
+		return -(EINVAL);
+	}
+
+	/*
+	 * If rs_bit_thresh is greater than 1, then TX WTHRESH should be
+	 * set to 0. If WTHRESH is greater than zero, the RS bit is ignored
+	 * by the NIC and all descriptors are written back after the NIC
+	 * accumulates WTHRESH descriptors.
+	 */
+	if (tx_rs_thresh > 1 && tx_conf->tx_thresh.wthresh != 0) {
+		MACB_LOG(ERR, "TX WTHRESH must be set to 0 if "
+			     "tx_rs_thresh is greater than 1. (tx_rs_thresh=%u "
+			     "port=%d queue=%d)", (unsigned int)tx_rs_thresh,
+			     (int)dev->data->port_id, (int)queue_idx);
+		return -(EINVAL);
+	}
+
+	/*
+	 * Validate number of transmit descriptors.
+	 * It must not exceed hardware maximum.
+	 */
+	if ((nb_desc % MACB_TX_LEN_ALIGN) != 0 || nb_desc > MACB_MAX_RING_DESC ||
+		nb_desc < MACB_MIN_RING_DESC) {
+		MACB_LOG(ERR, "number of descriptors exceeded.");
+		return -EINVAL;
+	}
+
+	bp->tx_ring_size = nb_desc;
+
+	/* Free memory prior to re-allocation if needed */
+	if (dev->data->tx_queues[queue_idx] != NULL) {
+		macb_tx_queue_release(dev->data->tx_queues[queue_idx]);
+		dev->data->tx_queues[queue_idx] = NULL;
+	}
+
+	/* First allocate the tx queue data structure */
+	txq = rte_zmalloc("ethdev TX queue", sizeof(struct macb_tx_queue),
+					  RTE_CACHE_LINE_SIZE);
+	if (txq == NULL) {
+		MACB_LOG(ERR, "failed to alloc txq.");
+		return -ENOMEM;
+	}
+
+	if (queue_idx) {
+		txq->ISR = GEM_ISR(queue_idx - 1);
+		txq->IER = GEM_IER(queue_idx - 1);
+		txq->IDR = GEM_IDR(queue_idx - 1);
+		txq->IMR = GEM_IMR(queue_idx - 1);
+		txq->TBQP = GEM_TBQP(queue_idx - 1);
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			txq->TBQPH = GEM_TBQPH(queue_idx - 1);
+	} else {
+		/* queue0 uses legacy registers */
+		txq->ISR = MACB_ISR;
+		txq->IER = MACB_IER;
+		txq->IDR = MACB_IDR;
+		txq->IMR = MACB_IMR;
+		txq->TBQP = MACB_TBQP;
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			txq->TBQPH = MACB_TBQPH;
+	}
+
+	size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
+
+	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx, size,
+								  RTE_CACHE_LINE_SIZE, socket_id);
+	if (tz == NULL) {
+		macb_tx_queue_release(txq);
+		MACB_LOG(ERR, "failed to alloc tx_ring.");
+		return -ENOMEM;
+	}
+
+	txq->bp = bp;
+	txq->nb_tx_desc = nb_desc;
+	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->tx_free_thresh = tx_free_thresh;
+	txq->queue_id = queue_idx;
+	txq->port_id = dev->data->port_id;
+	txq->tx_ring_dma = tz->iova;
+
+	txq->tx_ring = (struct macb_dma_desc *)tz->addr;
+	/* Allocate software ring */
+	txq->tx_sw_ring =
+		rte_zmalloc("txq->sw_ring", sizeof(struct macb_tx_entry) * nb_desc,
+					RTE_CACHE_LINE_SIZE);
+
+	if (txq->tx_sw_ring == NULL) {
+		macb_tx_queue_release(txq);
+		MACB_LOG(ERR, "failed to alloc tx_sw_ring.");
+		return -ENOMEM;
+	}
+
+	macb_set_tx_function(txq, dev);
+	macb_reset_tx_queue(txq, dev);
+	dev->data->tx_queues[queue_idx] = txq;
+
+	return 0;
+}
+
+int macb_tx_phyaddr_check(struct rte_eth_dev *dev)
+{
+	uint16_t i;
+	uint32_t bus_addr_high;
+	struct macb_tx_queue *txq;
+
+	if (dev->data->tx_queues == NULL) {
+		MACB_LOG(ERR, "tx queue is null.");
+		return -ENOMEM;
+	}
+	txq = dev->data->tx_queues[0];
+	bus_addr_high = upper_32_bits(txq->tx_ring_dma);
+
+	/* Check the high address of the tx queue. */
+	for (i = 1; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (bus_addr_high != upper_32_bits(txq->tx_ring_dma))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*********************************************************************
+ *
+ *  Enable transmit unit.
+ *
+ **********************************************************************/
+void __rte_cold eth_macb_tx_init(struct rte_eth_dev *dev)
+{
+	struct macb_tx_queue *txq;
+	uint16_t i;
+	struct macb_priv *priv;
+	struct macb *bp;
+
+	priv = dev->data->dev_private;
+	bp = priv->bp;
+
+	/* Setup the Base of the Tx Descriptor Rings. */
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		uint64_t bus_addr;
+		txq = dev->data->tx_queues[i];
+		bus_addr = txq->tx_ring_dma;
+
+		/* Disable tx interrupts */
+		queue_writel(txq, IDR, -1);
+		queue_readl(txq, ISR);
+		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			queue_writel(txq, ISR, -1);
+		queue_writel(txq, IDR, MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
+
+		queue_writel(txq, TBQP, lower_32_bits(bus_addr));
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			queue_writel(txq, TBQPH, upper_32_bits(bus_addr));
+	}
+
+	/* Start tx queues */
+	for (i = 0; i < dev->data->nb_tx_queues; i++)
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+}
+
+void __rte_cold macb_rx_queue_release_mbufs_vec(struct macb_rx_queue *rxq)
+{
+	const unsigned int mask = rxq->nb_rx_desc - 1;
+	unsigned int i;
+
+	if (rxq->rx_sw_ring == NULL || rxq->rxrearm_nb >= rxq->nb_rx_desc)
+		return;
+
+	/* free all mbufs that are valid in the ring */
+	if (rxq->rxrearm_nb == 0) {
+		for (i = 0; i < rxq->nb_rx_desc; i++) {
+			if (rxq->rx_sw_ring[i].mbuf != NULL)
+				rte_pktmbuf_free_seg(rxq->rx_sw_ring[i].mbuf);
+		}
+	} else {
+		for (i = rxq->rx_tail;
+		     i != rxq->rxrearm_start;
+		     i = (i + 1) & mask) {
+			if (rxq->rx_sw_ring[i].mbuf != NULL)
+				rte_pktmbuf_free_seg(rxq->rx_sw_ring[i].mbuf);
+		}
+	}
+
+	rxq->rxrearm_nb = rxq->nb_rx_desc;
+
+	/* set all entries to NULL */
+	memset(rxq->rx_sw_ring, 0, sizeof(rxq->rx_sw_ring[0]) * rxq->nb_rx_desc);
+}
+
+void __rte_cold macb_rx_queue_release_mbufs(struct macb_rx_queue *rxq)
+{
+	unsigned int i;
+	struct macb *bp = rxq->bp;
+
+	if (rxq->pkt_first_seg != NULL) {
+		rte_pktmbuf_free(rxq->pkt_first_seg);
+		rxq->pkt_first_seg = NULL;
+	}
+
+	if (bp->rx_vec_allowed) {
+		macb_rx_queue_release_mbufs_vec(rxq);
+		return;
+	}
+
+	if (rxq->rx_sw_ring != NULL) {
+		for (i = 0; i < rxq->nb_rx_desc; i++) {
+			if (rxq->rx_sw_ring[i].mbuf != NULL) {
+				rte_pktmbuf_free_seg(rxq->rx_sw_ring[i].mbuf);
+				rxq->rx_sw_ring[i].mbuf = NULL;
+			}
+		}
+	}
+}
+
+static void __rte_cold macb_rx_queue_release(struct macb_rx_queue *rxq)
+{
+	if (rxq != NULL) {
+		macb_rx_queue_release_mbufs(rxq);
+		rte_free(rxq->rx_sw_ring);
+		rte_free(rxq);
+	}
+}
+
+void __rte_cold eth_macb_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	macb_rx_queue_release(dev->data->rx_queues[qid]);
+}
+
+void __rte_cold macb_dev_free_queues(struct rte_eth_dev *dev)
+{
+	uint16_t i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		eth_macb_rx_queue_release(dev, i);
+		dev->data->rx_queues[i] = NULL;
+		rte_eth_dma_zone_free(dev, "rx_ring", i);
+	}
+
+	dev->data->nb_rx_queues = 0;
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		eth_macb_tx_queue_release(dev, i);
+		dev->data->tx_queues[i] = NULL;
+		rte_eth_dma_zone_free(dev, "tx_ring", i);
+	}
+	dev->data->nb_tx_queues = 0;
+}
+
+void __rte_cold macb_reset_rx_queue(struct macb_rx_queue *rxq)
+{
+	unsigned int i;
+	struct macb_dma_desc *rxdesc;
+
+	uint16_t len = rxq->nb_rx_desc;
+
+	if (rxq->bp->rx_bulk_alloc_allowed)
+		len += MACB_MAX_RX_BURST;
+
+	/* Zero out HW ring memory */
+	for (i = 0; i < rxq->nb_rx_desc; i++) {
+		rxdesc = macb_rx_desc(rxq, i);
+		rxdesc->ctrl = 0;
+		macb_set_addr(rxq->bp, rxdesc, 0);
+	}
+
+	if (rxq->bp->rx_bulk_alloc_allowed) {
+		rxdesc = macb_rx_desc(rxq, rxq->nb_rx_desc - 1);
+
+		for (i = 0; i < MACB_MAX_RX_BURST; i++) {
+			rxdesc += MACB_DESC_ADDR_INTERVAL;
+			rxdesc->ctrl = 0;
+			macb_set_addr(rxq->bp, rxdesc, 0);
+		}
+	}
+
+	/*
+	 * initialize extra software ring entries. Space for these extra
+	 * entries is always allocated
+	 */
+	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
+	for (i = rxq->nb_rx_desc; i < len; ++i) {
+		if (rxq->rx_sw_ring[i].mbuf == NULL)
+			rxq->rx_sw_ring[i].mbuf = &rxq->fake_mbuf;
+	}
+
+	rxq->rx_tail = 0;
+	rxq->pkt_first_seg = NULL;
+	rxq->pkt_last_seg = NULL;
+
+	rxq->rxrearm_start = 0;
+	rxq->rxrearm_nb = 0;
+}
+
+uint64_t __rte_cold macb_get_rx_port_offloads_capa(struct rte_eth_dev *dev __rte_unused)
+{
+	uint64_t rx_offload_capa;
+
+	rx_offload_capa = RTE_ETH_RX_OFFLOAD_IPV4_CKSUM | RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+			  RTE_ETH_RX_OFFLOAD_TCP_CKSUM | RTE_ETH_RX_OFFLOAD_SCATTER |
+			  RTE_ETH_RX_OFFLOAD_KEEP_CRC;
+
+	return rx_offload_capa;
+}
+
+uint64_t __rte_cold macb_get_rx_queue_offloads_capa(struct rte_eth_dev *dev)
+{
+	uint64_t rx_queue_offload_capa;
+
+	/*
+	 * As only one Rx queue can be used, let per queue offloading
+	 * capability be same to per port queue offloading capability
+	 * for better convenience.
+	 */
+	rx_queue_offload_capa = macb_get_rx_port_offloads_capa(dev);
+
+	return rx_queue_offload_capa;
+}
+
+/*
+ * Check if Rx Burst Bulk Alloc function can be used.
+ * Return
+ *        0: the preconditions are satisfied and the bulk allocation function
+ *           can be used.
+ *  -EINVAL: the preconditions are NOT satisfied and the default Rx burst
+ *           function must be used.
+ */
+static inline int __rte_cold
+macb_rx_burst_bulk_alloc_preconditions(struct macb_rx_queue *rxq)
+{
+	int ret = 0;
+
+	/*
+	 * Make sure the following pre-conditions are satisfied:
+	 *   rxq->rx_free_thresh >= MACB_MAX_RX_BURST
+	 *   rxq->rx_free_thresh < rxq->nb_rx_desc
+	 *   (rxq->nb_rx_desc % rxq->rx_free_thresh) == 0
+	 */
+	if (!(rxq->rx_free_thresh >= MACB_MAX_RX_BURST)) {
+		MACB_INFO("Rx Burst Bulk Alloc Preconditions: "
+				"rxq->rx_free_thresh=%d, "
+				"MACB_MAX_RX_BURST=%d",
+				rxq->rx_free_thresh, MACB_MAX_RX_BURST);
+		ret = -EINVAL;
+	} else if (!(rxq->rx_free_thresh < rxq->nb_rx_desc)) {
+		MACB_INFO("Rx Burst Bulk Alloc Preconditions: "
+				"rxq->rx_free_thresh=%d, "
+				"rxq->nb_rx_desc=%d",
+				rxq->rx_free_thresh, rxq->nb_rx_desc);
+		ret = -EINVAL;
+	} else if (!((rxq->nb_rx_desc % rxq->rx_free_thresh) == 0)) {
+		MACB_INFO("Rx Burst Bulk Alloc Preconditions: "
+				"rxq->nb_rx_desc=%d, "
+				"rxq->rx_free_thresh=%d",
+				rxq->nb_rx_desc, rxq->rx_free_thresh);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+int __rte_cold eth_macb_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
+							uint16_t nb_desc, unsigned int socket_id,
+							const struct rte_eth_rxconf *rx_conf,
+							struct rte_mempool *mp)
+{
+	const struct rte_memzone *rz;
+	struct macb_rx_queue *rxq;
+	unsigned int size;
+	struct macb_priv *priv;
+	struct macb *bp;
+	uint64_t offloads;
+	uint16_t len = nb_desc;
+
+	offloads = rx_conf->offloads | dev->data->dev_conf.rxmode.offloads;
+
+	priv = dev->data->dev_private;
+	bp = priv->bp;
+
+	/*
+	 * Validate number of receive descriptors.
+	 * It must not exceed hardware maximum, and must be multiple
+	 * of MACB_RX_LEN_ALIGN.
+	 */
+	if (nb_desc % MACB_RX_LEN_ALIGN != 0 || nb_desc > MACB_MAX_RING_DESC ||
+		nb_desc < MACB_MIN_RING_DESC) {
+		return -EINVAL;
+	}
+
+	bp->rx_ring_size = nb_desc;
+
+	/* Free memory prior to re-allocation if needed */
+	if (dev->data->rx_queues[queue_idx] != NULL) {
+		macb_rx_queue_release(dev->data->rx_queues[queue_idx]);
+		dev->data->rx_queues[queue_idx] = NULL;
+	}
+
+	/* First allocate the RX queue data structure. */
+	rxq = rte_zmalloc("ethdev RX queue", sizeof(struct macb_rx_queue),
+					  RTE_CACHE_LINE_SIZE);
+	if (rxq == NULL) {
+		MACB_LOG(ERR, "failed to alloc rxq.");
+		return -ENOMEM;
+	}
+
+	if (queue_idx) {
+		rxq->ISR = GEM_ISR(queue_idx - 1);
+		rxq->IER = GEM_IER(queue_idx - 1);
+		rxq->IDR = GEM_IDR(queue_idx - 1);
+		rxq->IMR = GEM_IMR(queue_idx - 1);
+		rxq->RBQP = GEM_RBQP(queue_idx - 1);
+		rxq->RBQS = GEM_RBQS(queue_idx - 1);
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			rxq->RBQPH = GEM_RBQPH(queue_idx - 1);
+	} else {
+		/* queue0 uses legacy registers */
+		rxq->ISR = MACB_ISR;
+		rxq->IER = MACB_IER;
+		rxq->IDR = MACB_IDR;
+		rxq->IMR = MACB_IMR;
+		rxq->RBQP = MACB_RBQP;
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			rxq->RBQPH = MACB_RBQPH;
+	}
+
+	rxq->bp = bp;
+	rxq->offloads = offloads;
+	rxq->mb_pool = mp;
+	rxq->nb_rx_desc = nb_desc;
+	rxq->rx_free_thresh = rx_conf->rx_free_thresh;
+	rxq->queue_id = queue_idx;
+	rxq->port_id = dev->data->port_id;
+	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
+		rxq->crc_len = RTE_ETHER_CRC_LEN;
+	else
+		rxq->crc_len = 0;
+
+	/*
+	 * Certain constraints must be met in order to use the bulk buffer
+	 * allocation Rx burst function. If any of Rx queues doesn't meet them
+	 * the feature should be disabled for the whole port.
+	 */
+	if (macb_rx_burst_bulk_alloc_preconditions(rxq)) {
+		MACB_INFO("queue[%d] doesn't meet Rx Bulk Alloc "
+				    "preconditions - canceling the feature for "
+				    "port[%d]",
+			     rxq->queue_id, rxq->port_id);
+		bp->rx_bulk_alloc_allowed = false;
+	}
+
+	/*
+	 *  Allocate RX ring hardware descriptors. A memzone large enough to
+	 *  handle the maximum ring size is allocated in order to allow for
+	 *  resizing in later calls to the queue setup function.
+	 */
+	size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
+
+	if (rxq->bp->rx_bulk_alloc_allowed)
+		size += macb_dma_desc_get_size(bp) * MACB_MAX_RX_BURST;
+
+	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx, size,
+								  RTE_CACHE_LINE_SIZE, socket_id);
+
+	if (rz == NULL) {
+		macb_rx_queue_release(rxq);
+		MACB_LOG(ERR, "failed to alloc rx_ring.");
+		return -ENOMEM;
+	}
+
+	rxq->rx_ring_dma = rz->iova;
+	rxq->rx_ring = (struct macb_dma_desc *)rz->addr;
+
+	if (rxq->bp->rx_bulk_alloc_allowed)
+		len += MACB_MAX_RX_BURST;
+
+	/* Allocate software ring. */
+	rxq->rx_sw_ring =
+		rte_zmalloc("rxq->sw_ring", sizeof(struct macb_rx_entry) * len,
+					RTE_CACHE_LINE_SIZE);
+	if (rxq->rx_sw_ring == NULL) {
+		macb_rx_queue_release(rxq);
+		MACB_LOG(ERR, "failed to alloc rx_sw_ring.");
+		return -ENOMEM;
+	}
+	/* MACB_LOG(DEBUG, "sw_ring=%p hw_ring=%p dma_addr=0x%"PRIx64,
+	 * rxq->rx_sw_ring, rxq->rx_ring, rxq->rx_ring_dma);
+	 */
+
+	dev->data->rx_queues[queue_idx] = rxq;
+	macb_reset_rx_queue(rxq);
+
+	return 0;
+}
+
+void __rte_cold macb_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+					   struct rte_eth_rxq_info *qinfo)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	struct macb_rx_queue *rxq;
+
+	rxq = dev->data->rx_queues[queue_id];
+
+	qinfo->mp = rxq->mb_pool;
+	qinfo->scattered_rx = dev->data->scattered_rx;
+	qinfo->rx_buf_size = bp->rx_buffer_size;
+	qinfo->nb_desc = rxq->nb_rx_desc;
+	qinfo->conf.rx_free_thresh = rxq->rx_free_thresh;
+	qinfo->conf.offloads = rxq->offloads;
+}
+
+void __rte_cold macb_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+					   struct rte_eth_txq_info *qinfo)
+{
+	struct macb_tx_queue *txq;
+
+	txq = dev->data->tx_queues[queue_id];
+	qinfo->nb_desc = txq->nb_tx_desc;
+	qinfo->conf.tx_free_thresh = txq->tx_free_thresh;
+}
+
+static int __rte_cold macb_alloc_rx_queue_mbufs(struct macb_rx_queue *rxq)
+{
+	struct macb_rx_entry *rxe = rxq->rx_sw_ring;
+	uint64_t dma_addr;
+	unsigned int i;
+	struct macb *bp;
+
+	bp = rxq->bp;
+
+	/* Initialize software ring entries. */
+	for (i = 0; i < rxq->nb_rx_desc; i++) {
+		struct macb_dma_desc *rxd;
+		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
+
+		if (mbuf == NULL) {
+			MACB_LOG(ERR, "RX mbuf alloc failed "
+				     "queue_id=%hu", rxq->queue_id);
+			return -ENOMEM;
+		}
+		mbuf->data_off = RTE_PKTMBUF_HEADROOM + MACB_RX_DATA_OFFSET;
+		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
+		rxd = macb_rx_desc(rxq, i);
+		if (i == rxq->nb_rx_desc - 1)
+			dma_addr |= MACB_BIT(RX_WRAP);
+		rxd->ctrl = 0;
+		/* Setting addr clears RX_USED and allows reception,
+		 * make sure ctrl is cleared first to avoid a race.
+		 */
+		rte_wmb();
+		macb_set_addr(bp, rxd, dma_addr);
+		rxe[i].mbuf = mbuf;
+	}
+
+	rte_wmb();
+	return 0;
+}
+
+void __rte_cold macb_init_rx_buffer_size(struct macb *bp, size_t size)
+{
+	if (!macb_is_gem(bp)) {
+		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
+	} else {
+		bp->rx_buffer_size = size;
+
+		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
+			bp->rx_buffer_size =
+				roundup(bp->rx_buffer_size, RX_BUFFER_MULTIPLE);
+		}
+	}
+}
+
+static void __rte_cold
+macb_set_rx_function(struct macb_rx_queue *rxq, struct rte_eth_dev *dev)
+{
+	struct macb_priv *priv = dev->data->dev_private;
+	struct macb *bp = priv->bp;
+	u32	max_len;
+	uint16_t buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
+							RTE_PKTMBUF_HEADROOM);
+
+	max_len = dev->data->mtu + MACB_ETH_OVERHEAD;
+	if (max_len > buf_size ||
+	    dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER) {
+		if (!dev->data->scattered_rx)
+			MACB_INFO("forcing scatter mode");
+		dev->data->scattered_rx = 1;
+	}
+
+	/*
+	 * In order to allow Vector Rx there are a few configuration
+	 * conditions to be met and Rx Bulk Allocation should be allowed.
+	 */
+	if (!bp->rx_bulk_alloc_allowed ||
+			rte_vect_get_max_simd_bitwidth() < RTE_VECT_SIMD_128) {
+		MACB_INFO("Port[%d] doesn't meet Vector Rx "
+				    "preconditions",
+			     dev->data->port_id);
+		bp->rx_vec_allowed = false;
+	}
+
+	if (dev->data->scattered_rx) {
+		if (bp->rx_vec_allowed) {
+			MACB_INFO("Using Vector Scattered Rx "
+						"callback (port=%d).",
+						dev->data->port_id);
+			dev->rx_pkt_burst = eth_macb_recv_scattered_pkts_vec;
+		} else {
+			MACB_INFO("Using Regular (non-vector) "
+					    "Scattered Rx callback "
+					    "(port=%d).",
+				     dev->data->port_id);
+			dev->rx_pkt_burst = eth_macb_recv_scattered_pkts;
+		}
+	} else {
+		if (bp->rx_vec_allowed) {
+			MACB_INFO("Vector rx enabled");
+			dev->rx_pkt_burst = eth_macb_recv_pkts_vec;
+		} else {
+			dev->rx_pkt_burst = eth_macb_recv_pkts;
+		}
+	}
+}
+
+int macb_rx_phyaddr_check(struct rte_eth_dev *dev)
+{
+	uint16_t i;
+	uint32_t bus_addr_high;
+	struct macb_rx_queue *rxq;
+
+	if (dev->data->rx_queues == NULL) {
+		MACB_LOG(ERR, "rx queue is null.");
+		return -ENOMEM;
+	}
+	rxq = dev->data->rx_queues[0];
+	bus_addr_high = upper_32_bits(rxq->rx_ring_dma);
+
+	/* Check the high address of the rx queue. */
+	for (i = 1; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+		if (bus_addr_high != upper_32_bits(rxq->rx_ring_dma))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+int __rte_cold eth_macb_rx_init(struct rte_eth_dev *dev)
+{
+	int ret;
+	uint16_t i;
+	uint32_t rxcsum;
+	struct macb_rx_queue *rxq;
+	struct rte_eth_rxmode *rxmode;
+
+	struct macb_priv *priv;
+	struct macb *bp;
+	uint16_t buf_size;
+
+	priv = dev->data->dev_private;
+	bp = priv->bp;
+
+	rxcsum = gem_readl(bp, NCFGR);
+	/* Enable both L3/L4 rx checksum offload */
+	rxmode = &dev->data->dev_conf.rxmode;
+	if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM)
+		rxcsum |= GEM_BIT(RXCOEN);
+	else
+		rxcsum &= ~GEM_BIT(RXCOEN);
+	gem_writel(bp, NCFGR, rxcsum);
+
+	/* Configure and enable each RX queue. */
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		uint64_t bus_addr;
+
+		rxq = dev->data->rx_queues[i];
+		rxq->flags = 0;
+
+		/* Disable rx interrupts */
+		queue_writel(rxq, IDR, -1);
+		queue_readl(rxq, ISR);
+		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			queue_writel(rxq, ISR, -1);
+		queue_writel(rxq, IDR, MACB_RX_INT_FLAGS | MACB_BIT(HRESP));
+
+		/* Allocate buffers for descriptor rings and set up queue */
+		ret = macb_alloc_rx_queue_mbufs(rxq);
+		if (ret)
+			return ret;
+
+		/*
+		 * Reset crc_len in case it was changed after queue setup by a
+		 *  call to configure
+		 */
+		if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
+			rxq->crc_len = RTE_ETHER_CRC_LEN;
+		else
+			rxq->crc_len = 0;
+
+		bus_addr = rxq->rx_ring_dma;
+		queue_writel(rxq, RBQP, lower_32_bits(bus_addr));
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			queue_writel(rxq, RBQPH, upper_32_bits(bus_addr));
+
+		/*
+		 * Configure RX buffer size.
+		 */
+		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
+							  RTE_PKTMBUF_HEADROOM);
+
+		macb_init_rx_buffer_size(bp, buf_size);
+		macb_set_rx_function(rxq, dev);
+	}
+
+	/* Start rx queues */
+	for (i = 0; i < dev->data->nb_rx_queues; i++)
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+
+	return 0;
+}
+
+uint16_t
+eth_macb_recv_pkts_vec(void *rx_queue __rte_unused,
+		       struct rte_mbuf **rx_pkts __rte_unused,
+		       uint16_t nb_pkts __rte_unused)
+{
+	return 0;
+}
+
+uint16_t
+eth_macb_recv_scattered_pkts_vec(void *rx_queue __rte_unused,
+				  struct rte_mbuf **rx_pkts __rte_unused,
+				  uint16_t nb_pkts __rte_unused)
+{
+	return 0;
+}
+
+uint16_t
+eth_macb_xmit_pkts_vec(void *tx_queue __rte_unused,
+				struct rte_mbuf **tx_pkts __rte_unused,
+				uint16_t nb_pkts __rte_unused)
+{
+	return 0;
+}
diff --git a/drivers/net/macb/macb_rxtx.h b/drivers/net/macb/macb_rxtx.h
new file mode 100644
index 0000000..50c542a
--- /dev/null
+++ b/drivers/net/macb/macb_rxtx.h
@@ -0,0 +1,325 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2022 Phytium Technology Co., Ltd.
+ */
+
+#ifndef _MACB_RXTX_H_
+#define _MACB_RXTX_H_
+
+#include "macb_ethdev.h"
+
+#define MACB_RX_BUFFER_SIZE 128
+#define MACB_MAX_RECLAIM_NUM 64
+#define MACB_RX_DATA_OFFSET   0
+
+#define MACB_DESCS_PER_LOOP    4
+#define MACB_MAX_RX_BURST    32
+#define MACB_RXQ_REARM_THRESH      32
+#define MACB_DESC_ADDR_INTERVAL 2
+#define MACB_LOOK_AHEAD	8
+#define MACB_NEXT_FETCH	7
+#define MACB_NEON_PREFETCH_ENTRY	4
+
+#define BIT_TO_BYTE_SHIFT 3
+#define MACB_DATA_BUS_WIDTH_MASK(x) (((x) >> BIT_TO_BYTE_SHIFT) - 1)
+
+struct gem_tx_ts {
+	struct rte_mbuf *mbuf;
+	struct macb_dma_desc_ptp desc_ptp;
+};
+
+struct __rte_cache_aligned macb_rx_queue_stats {
+	union {
+		uint64_t first;
+		uint64_t rx_packets;
+	};
+	uint64_t rx_bytes;
+	uint64_t rx_dropped;
+};
+
+struct __rte_cache_aligned macb_tx_queue_stats {
+	uint64_t tx_packets;
+	uint64_t tx_bytes;
+	uint64_t tx_dropped;
+	uint64_t tx_start_packets;
+	uint64_t tx_start_bytes;
+};
+
+struct macb_tx_entry {
+	struct rte_mbuf *mbuf;
+};
+
+struct macb_rx_entry {
+	struct rte_mbuf *mbuf;
+};
+
+struct macb_rx_queue {
+	struct macb		*bp;
+	struct rte_mempool	*mb_pool;   /**< mbuf pool to populate RX ring. */
+
+	unsigned int		ISR;
+	unsigned int		IER;
+	unsigned int		IDR;
+	unsigned int		IMR;
+	unsigned int		RBQS;
+	unsigned int		RBQP;
+	unsigned int		RBQPH;
+
+	rte_iova_t		rx_ring_dma;
+	unsigned int		rx_tail;
+	unsigned int		nb_rx_desc;    /**< number of TX descriptors. */
+	uint16_t		rx_free_thresh;/**< max free RX desc to hold. */
+	uint16_t		queue_id; /**< TX queue index. */
+	uint16_t		port_id;  /**< Device port identifier. */
+	uint32_t		crc_len;    /**< 0 if CRC stripped, 4 otherwise. */
+	uint32_t		flags;      /**< RX flags. */
+	uint64_t		offloads;   /**< offloads of DEV_RX_OFFLOAD_* */
+	unsigned int		rx_prepared_head;
+	struct macb_dma_desc	*rx_ring;
+	struct macb_rx_entry	*rx_sw_ring;
+
+	struct macb_rx_queue_stats	stats;
+	struct rte_mbuf		*pkt_first_seg; /**< First segment of current packet. */
+	struct rte_mbuf		*pkt_last_seg;  /**< Last segment of current packet. */
+
+	uint16_t		rxrearm_nb;     /**< number of remaining to be re-armed */
+	unsigned int		rxrearm_start;  /**< the idx we start the re-arming from */
+
+	/** need to alloc dummy mbuf, for wraparound when scanning hw ring */
+	struct rte_mbuf		fake_mbuf;
+};
+
+struct macb_tx_queue {
+	struct macb		*bp;
+
+	unsigned int		ISR;
+	unsigned int		IER;
+	unsigned int		IDR;
+	unsigned int		IMR;
+	unsigned int		TBQP;
+	unsigned int		TBQPH;
+
+	unsigned int		tx_head, tx_tail;
+	unsigned int		nb_tx_desc;    /**< number of TX descriptors. */
+	uint16_t		tx_free_thresh;/**< max free TX desc to hold. */
+	uint16_t		tx_rs_thresh;
+	uint16_t		queue_id; /**< TX queue index. */
+	uint16_t		port_id;  /**< Device port identifier. */
+
+	struct macb_dma_desc	*tx_ring;
+	struct macb_tx_entry	*tx_sw_ring;
+	rte_iova_t		tx_ring_dma;
+
+	struct macb_tx_queue_stats	stats;
+};
+
+void macb_rxq_info_get(struct rte_eth_dev *dev, uint16_t rx_queue_id,
+		       struct rte_eth_rxq_info *qinfo);
+void macb_txq_info_get(struct rte_eth_dev *dev, uint16_t tx_queue_id,
+		       struct rte_eth_txq_info *qinfo);
+uint64_t macb_get_rx_port_offloads_capa(struct rte_eth_dev *dev);
+uint64_t macb_get_rx_queue_offloads_capa(struct rte_eth_dev *dev);
+int eth_macb_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
+			    unsigned int socket, const struct rte_eth_rxconf *conf __rte_unused,
+			    struct rte_mempool *mp);
+int eth_macb_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
+			    unsigned int socket, const struct rte_eth_txconf *conf);
+void eth_macb_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+void eth_macb_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+void macb_dev_free_queues(struct rte_eth_dev *dev);
+uint16_t eth_macb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t eth_macb_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t eth_macb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+uint16_t eth_macb_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+uint16_t eth_macb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+uint16_t eth_macb_recv_scattered_pkts_vec(void *rx_queue,
+					  struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+uint16_t eth_macb_prep_pkts(__rte_unused void *tx_queue,
+			    struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+void __rte_cold macb_rx_queue_release_mbufs_vec(struct macb_rx_queue *rxq);
+void macb_rx_queue_release_mbufs(struct macb_rx_queue *rxq);
+void macb_tx_queue_release_mbufs(struct macb_tx_queue *txq);
+int macb_rx_phyaddr_check(struct rte_eth_dev *dev);
+int macb_tx_phyaddr_check(struct rte_eth_dev *dev);
+int eth_macb_rx_init(struct rte_eth_dev *dev);
+void eth_macb_tx_init(struct rte_eth_dev *dev);
+void macb_reset_rx_queue(struct macb_rx_queue *rxq);
+void macb_reset_tx_queue(struct macb_tx_queue *txq, struct rte_eth_dev *dev);
+void macb_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id, struct rte_eth_rxq_info *qinfo);
+void macb_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id, struct rte_eth_txq_info *qinfo);
+
+void macb_init_rx_buffer_size(struct macb *bp, size_t size);
+
+
+/* DMA buffer descriptor might be different size
+ * depends on hardware configuration:
+ *
+ * 1. dma address width 32 bits:
+ *    word 1: 32 bit address of Data Buffer
+ *    word 2: control
+ *
+ * 2. dma address width 64 bits:
+ *    word 1: 32 bit address of Data Buffer
+ *    word 2: control
+ *    word 3: upper 32 bit address of Data Buffer
+ *    word 4: unused
+ *
+ * 3. dma address width 32 bits with hardware timestamping:
+ *    word 1: 32 bit address of Data Buffer
+ *    word 2: control
+ *    word 3: timestamp word 1
+ *    word 4: timestamp word 2
+ *
+ * 4. dma address width 64 bits with hardware timestamping:
+ *    word 1: 32 bit address of Data Buffer
+ *    word 2: control
+ *    word 3: upper 32 bit address of Data Buffer
+ *    word 4: unused
+ *    word 5: timestamp word 1
+ *    word 6: timestamp word 2
+ */
+static inline unsigned int macb_dma_desc_get_size(struct macb *bp)
+{
+	unsigned int desc_size;
+
+	switch (bp->hw_dma_cap) {
+	case HW_DMA_CAP_64B:
+		desc_size =
+			sizeof(struct macb_dma_desc) + sizeof(struct macb_dma_desc_64);
+		break;
+	case HW_DMA_CAP_PTP:
+		desc_size =
+			sizeof(struct macb_dma_desc) + sizeof(struct macb_dma_desc_ptp);
+		break;
+	case HW_DMA_CAP_64B_PTP:
+		desc_size = sizeof(struct macb_dma_desc) +
+					sizeof(struct macb_dma_desc_64) +
+					sizeof(struct macb_dma_desc_ptp);
+		break;
+	default:
+		desc_size = sizeof(struct macb_dma_desc);
+	}
+	return desc_size;
+
+	return sizeof(struct macb_dma_desc);
+}
+
+/* Ring buffer accessors */
+static inline unsigned int macb_tx_ring_wrap(struct macb *bp, unsigned int index)
+{
+	return index & (bp->tx_ring_size - 1);
+}
+
+static inline unsigned int macb_adj_dma_desc_idx(struct macb *bp,
+						unsigned int desc_idx)
+{
+#ifdef MACB_EXT_DESC
+	switch (bp->hw_dma_cap) {
+	case HW_DMA_CAP_64B:
+	case HW_DMA_CAP_PTP:
+		desc_idx <<= 1;
+		break;
+	case HW_DMA_CAP_64B_PTP:
+		desc_idx *= 3;
+		break;
+	default:
+		break;
+	}
+#endif
+	return desc_idx;
+}
+
+static inline struct macb_tx_entry *macb_tx_entry(struct macb_tx_queue *queue,
+						unsigned int index)
+{
+	return &queue->tx_sw_ring[macb_tx_ring_wrap(queue->bp, index)];
+}
+
+static inline struct macb_dma_desc *macb_tx_desc(struct macb_tx_queue *queue,
+						 unsigned int index)
+{
+	index = macb_tx_ring_wrap(queue->bp, index);
+	index = macb_adj_dma_desc_idx(queue->bp, index);
+	return &queue->tx_ring[index];
+}
+
+static inline struct macb_dma_desc_64 *macb_64b_desc(struct macb *bp,
+						 struct macb_dma_desc *desc)
+{
+	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+		return (struct macb_dma_desc_64 *)((uint8_t *)desc
+						   + sizeof(struct macb_dma_desc));
+	return NULL;
+}
+
+static inline void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc,
+							dma_addr_t addr)
+{
+	struct macb_dma_desc_64 *desc_64;
+
+	if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
+		desc_64 = macb_64b_desc(bp, desc);
+		desc_64->addrh = upper_32_bits(addr);
+		/* The low bits of RX address contain the RX_USED bit, clearing
+		 * of which allows packet RX. Make sure the high bits are also
+		 * visible to HW at that point.
+		 */
+		rte_wmb();
+	}
+
+	desc->addr = lower_32_bits(addr);
+}
+
+static inline unsigned int macb_rx_ring_wrap(struct macb *bp, unsigned int index)
+{
+	return index & (bp->rx_ring_size - 1);
+}
+
+static inline struct macb_dma_desc *macb_rx_desc(struct macb_rx_queue *queue,
+						unsigned int index)
+{
+	index = macb_rx_ring_wrap(queue->bp, index);
+	index = macb_adj_dma_desc_idx(queue->bp, index);
+	return &queue->rx_ring[index];
+}
+
+static inline struct macb_rx_entry *macb_rx_entry(struct macb_rx_queue *queue,
+						unsigned int index)
+{
+	return &queue->rx_sw_ring[macb_rx_ring_wrap(queue->bp, index)];
+}
+
+static inline uint16_t macb_reclaim_txd(struct macb_tx_queue *queue)
+{
+	struct macb_dma_desc *curr_desc;
+	uint32_t tx_head, tx_tail;
+	uint16_t reclaim = 0;
+
+	tx_head = queue->tx_head;
+	tx_tail = queue->tx_tail;
+	while (likely(tx_head != tx_tail && reclaim < MACB_MAX_RECLAIM_NUM)) {
+		curr_desc = macb_tx_desc(queue, tx_head);
+		if (unlikely(!(curr_desc->ctrl & MACB_BIT(TX_USED)))) {
+			goto out;
+		} else {
+			if (likely(curr_desc->ctrl & MACB_BIT(TX_LAST))) {
+				tx_head = macb_tx_ring_wrap(queue->bp, ++tx_head);
+				reclaim++;
+			} else {
+				reclaim++;
+				do {
+					tx_head = macb_tx_ring_wrap(queue->bp, ++tx_head);
+					curr_desc = macb_tx_desc(queue, tx_head);
+					curr_desc->ctrl |= MACB_BIT(TX_USED);
+					reclaim++;
+				} while (unlikely(!(curr_desc->ctrl & MACB_BIT(TX_LAST))));
+				tx_head = macb_tx_ring_wrap(queue->bp, ++tx_head);
+			}
+		}
+	}
+
+out:
+	queue->tx_head = tx_head;
+	return reclaim;
+}
+
+#endif /* _MACB_RXTX_H_ */
diff --git a/drivers/net/macb/meson.build b/drivers/net/macb/meson.build
new file mode 100644
index 0000000..fe0dc99
--- /dev/null
+++ b/drivers/net/macb/meson.build
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2022 Phytium Technology Co., Ltd.
+
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
+    subdir_done()
+endif
+
+subdir('base')
+objs = [base_objs]
+
+sources = files(
+        'macb_ethdev.c',
+        'macb_rxtx.c',
+)
+
+includes += include_directories('base')
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 460eb69..3cce18f 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -34,6 +34,7 @@ drivers = [
         'intel/ixgbe',
         'intel/cpfl',  # depends on idpf, so must come after it
         'ionic',
+        'macb',
         'mana',
         'memif',
         'mlx4',
-- 
2.7.4

