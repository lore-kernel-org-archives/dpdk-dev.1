Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B36BC369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:06:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FAC740EF0;
	Wed, 23 Apr 2025 18:01:03 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 0728F40E1C
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:48 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 596E4E0329;
 Wed, 23 Apr 2025 20:00:47 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 596E4E0329
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424047;
 bh=g6Axklf/+aBXYu0CTI1OdkVtD/7EvPvbvSyIajG019c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=4JhhmJkTetRJatFFcVl2XvfdMTcPxJyiFwY1LDD6rTpwf8o1SMMD6v27zQQKFdFIt
 vtCkXbFJpoaojwMc0cjKVUREg3qzUosyLYp6W/7seE6Evl0OdLM2cojyDBpNoWY6Hj
 FDp5y+MTw+mQdlRYMXJFKKhOxC4p7qCud5zuwW4W/yl5Q1Muj0NayEVN0Cvt1BJFxu
 e/OP2U4IGA65CkIMshwnUrmZPb0q3LqEp8OyaumL5PbOtti/mD7CcYSrhbVdCwJbut
 COmobVifo2uAxpSse9UEa8dmLkL0/UULqHVZkTSjvoUrz2Hn1yU7JNcrk4Xwbq3Jpk
 RuDhWFZi+jA3g==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 44/45] net/sfc: add support for control of physical port
 lane count
Date: Wed, 23 Apr 2025 20:00:01 +0400
Message-Id: <20250423160002.35706-45-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Since 24.11, DPDK has supported APIs to control lane count of the
physical link. Provide driver-level support for that on adaptors that
are netport MCDI capabale (Medford4, for instance).

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/sfc/sfc.h        |   2 +
 drivers/net/sfc/sfc_ethdev.c | 147 +++++++++++++++++++++++++++++++++++
 drivers/net/sfc/sfc_port.c   |  19 +++++
 3 files changed, 168 insertions(+)

diff --git a/drivers/net/sfc/sfc.h b/drivers/net/sfc/sfc.h
index 819ce52529..af32ccfaa3 100644
--- a/drivers/net/sfc/sfc.h
+++ b/drivers/net/sfc/sfc.h
@@ -67,6 +67,8 @@ struct sfc_dp_rx;
 struct sfc_port {
 	unsigned int			lsc_seq;
 
+	efx_phy_lane_count_t		phy_lane_count_active;
+	efx_phy_lane_count_t		phy_lane_count_req;
 	uint32_t			phy_adv_cap_mask;
 	uint32_t			phy_adv_cap;
 	uint32_t			fec_cfg;
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 80eb39e58d..2122d42847 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -291,6 +291,150 @@ sfc_dev_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 	return ret;
 }
 
+static int
+sfc_dev_speed_lanes_get(struct rte_eth_dev *dev, uint32_t *lane_countp)
+{
+	struct sfc_adapter *sa = sfc_adapter_by_eth_dev(dev);
+	struct sfc_port *port;
+	int rc = 0;
+
+	if (lane_countp == NULL)
+		return -EINVAL;
+
+	sfc_adapter_lock(sa);
+	port = &sa->port;
+
+	if (sa->state != SFC_ETHDEV_STARTED) {
+		/* The API wants 'active' lanes, so it is safe to indicate 0. */
+		*lane_countp = 0;
+		goto unlock;
+	}
+
+	if (port->phy_lane_count_active == EFX_PHY_LANE_COUNT_DEFAULT) {
+		rc = ENOTSUP;
+		goto unlock;
+	}
+
+	*lane_countp = port->phy_lane_count_active;
+
+unlock:
+	sfc_adapter_unlock(sa);
+	return -rc;
+}
+
+static int
+sfc_dev_speed_lanes_set(struct rte_eth_dev *dev, uint32_t lane_count)
+{
+	struct sfc_adapter *sa = sfc_adapter_by_eth_dev(dev);
+	int rc = 0;
+
+	sfc_adapter_lock(sa);
+
+	if (sa->state == SFC_ETHDEV_STARTED) {
+		rc = EBUSY;
+		goto unlock;
+	}
+
+	if (lane_count == 0) {
+		rc = EINVAL;
+		goto unlock;
+	}
+
+	sa->port.phy_lane_count_req = lane_count;
+
+unlock:
+	sfc_adapter_unlock(sa);
+	return -rc;
+}
+
+static int
+sfc_dev_speed_lane_cap_handle(const efx_nic_cfg_t *encp,
+			      efx_link_mode_t link_mode,
+			      unsigned int *nb_caps_to_fillp,
+			      struct rte_eth_speed_lanes_capa **capp)
+{
+	uint32_t lane_counts = encp->enc_phy_lane_counts[link_mode].ed_u32[0];
+	struct rte_eth_speed_lanes_capa *cap = *capp;
+	uint32_t speed;
+
+	if (lane_counts == 0) {
+		/*
+		 * The mask of supported lane counts for this link mode is
+		 * empty. Do not waste output entries for such link modes.
+		 */
+		return 0;
+	}
+
+	switch (link_mode) {
+	case EFX_LINK_1000FDX:
+		speed = RTE_ETH_SPEED_NUM_1G;
+		break;
+	case EFX_LINK_10000FDX:
+		speed = RTE_ETH_SPEED_NUM_10G;
+		break;
+	case EFX_LINK_25000FDX:
+		speed = RTE_ETH_SPEED_NUM_25G;
+		break;
+	case EFX_LINK_40000FDX:
+		speed = RTE_ETH_SPEED_NUM_40G;
+		break;
+	case EFX_LINK_50000FDX:
+		speed = RTE_ETH_SPEED_NUM_50G;
+		break;
+	case EFX_LINK_100000FDX:
+		speed = RTE_ETH_SPEED_NUM_100G;
+		break;
+	case EFX_LINK_200000FDX:
+		speed = RTE_ETH_SPEED_NUM_200G;
+		break;
+	default:
+		/* No lane counts for this link mode. */
+		return 0;
+	}
+
+	if (*nb_caps_to_fillp == 0) {
+		if (cap == NULL) {
+			/* Dry run. Indicate that an entry is available. */
+			return 1;
+		}
+
+		/* We have run out of space in the user output buffer. */
+		return 0;
+	}
+
+	cap->capa = lane_counts;
+	cap->speed = speed;
+
+	--(*nb_caps_to_fillp);
+	++(*capp);
+	return 1;
+}
+
+static int
+sfc_dev_speed_lanes_get_capa(struct rte_eth_dev *dev,
+			     struct rte_eth_speed_lanes_capa *caps,
+			     unsigned int nb_caps)
+{
+	struct sfc_adapter *sa = sfc_adapter_by_eth_dev(dev);
+	const efx_nic_cfg_t *encp = efx_nic_cfg_get(sa->nic);
+	efx_link_mode_t i;
+	int ret = 0;
+
+	sfc_adapter_lock(sa);
+
+	if (sa->state < SFC_ETHDEV_INITIALIZED) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	for (i = 0; i < EFX_LINK_NMODES; ++i)
+		ret += sfc_dev_speed_lane_cap_handle(encp, i, &nb_caps, &caps);
+
+unlock:
+	sfc_adapter_unlock(sa);
+	return ret;
+}
+
 static int
 sfc_dev_stop(struct rte_eth_dev *dev)
 {
@@ -2759,6 +2903,9 @@ static const struct eth_dev_ops sfc_eth_dev_ops = {
 	.allmulticast_enable		= sfc_dev_allmulti_enable,
 	.allmulticast_disable		= sfc_dev_allmulti_disable,
 	.link_update			= sfc_dev_link_update,
+	.speed_lanes_get		= sfc_dev_speed_lanes_get,
+	.speed_lanes_set		= sfc_dev_speed_lanes_set,
+	.speed_lanes_get_capa		= sfc_dev_speed_lanes_get_capa,
 	.stats_get			= sfc_stats_get,
 	.stats_reset			= sfc_stats_reset,
 	.xstats_get			= sfc_xstats_get,
diff --git a/drivers/net/sfc/sfc_port.c b/drivers/net/sfc/sfc_port.c
index 0a31a394d5..e5a7b8358d 100644
--- a/drivers/net/sfc/sfc_port.c
+++ b/drivers/net/sfc/sfc_port.c
@@ -187,6 +187,7 @@ sfc_port_fill_mac_stats_info(struct sfc_adapter *sa)
 int
 sfc_port_start(struct sfc_adapter *sa)
 {
+	efx_phy_link_state_t link_state = {0};
 	struct sfc_port *port = &sa->port;
 	int rc;
 	uint32_t phy_adv_cap;
@@ -243,6 +244,20 @@ sfc_port_start(struct sfc_adapter *sa)
 	if (rc != 0)
 		goto fail_phy_adv_cap_set;
 
+	sfc_log_init(sa, "set phy lane count -- %s",
+		     (port->phy_lane_count_req == EFX_PHY_LANE_COUNT_DEFAULT) ?
+		     "let EFX pick default value" : "use custom value");
+	rc = efx_phy_lane_count_set(sa->nic, port->phy_lane_count_req);
+	if (rc != 0)
+		goto fail_phy_lane_count_set;
+
+	sfc_log_init(sa, "get phy lane count");
+	rc = efx_phy_link_state_get(sa->nic, &link_state);
+	if (rc != 0)
+		goto fail_phy_lane_count_get;
+
+	port->phy_lane_count_active = link_state.epls_lane_count;
+
 	sfc_log_init(sa, "set MAC PDU %u", (unsigned int)port->pdu);
 	rc = efx_mac_pdu_set(sa->nic, port->pdu);
 	if (rc != 0)
@@ -350,6 +365,8 @@ sfc_port_start(struct sfc_adapter *sa)
 fail_mac_filter_set:
 fail_mac_addr_set:
 fail_mac_pdu_set:
+fail_phy_lane_count_get:
+fail_phy_lane_count_set:
 fail_phy_adv_cap_set:
 fail_mac_fcntl_set:
 fail_mac_vlan_strip_set:
@@ -427,6 +444,8 @@ sfc_port_attach(struct sfc_adapter *sa)
 
 	sfc_log_init(sa, "entry");
 
+	port->phy_lane_count_req = EFX_PHY_LANE_COUNT_DEFAULT;
+
 	efx_phy_adv_cap_get(sa->nic, EFX_PHY_CAP_PERM, &port->phy_adv_cap_mask);
 
 	/* Enable flow control by default */
-- 
2.39.5

