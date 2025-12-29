Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861B3E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53CAB406A2;
	Mon, 29 Dec 2025 22:35:48 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 51EF540659;
 Mon, 29 Dec 2025 22:35:42 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A5526E1BA0;
 Tue, 30 Dec 2025 01:35:41 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A5526E1BA0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044142;
 bh=dN1hicQfPyb2t3JGT2US+JkS1lmLSA7CzVDwqmr7EH0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zXlcrP1ueIfhQHgResax/PfKCnJo/v5tSIq84QTpcBFGHPX1QiMjV5C8MZHTpSoYm
 zLjhx9RNh0O1t3nyi7yrsakFggiI83SBa8oStu/MWwYdpDvKKaiIjTOe0yXa62f4fk
 XIODsQLXf65ke4byIANTc9B0b2YgFFxSSjpVYsfjzMbKEsncaSvl9HXGVb5IE1Hzpd
 645HdN1MzV46rN37SwNGS4cj0GZqSTDq9R7NFYruGIQh524A267ISEn69Azoxbf/sw
 +usjduW/Mj0zTs835vXHf0bXggVI0fntj4pBkEyK8kZ5+fBeGPGLMUalwbM6y9wQAg
 NszKpLeZIUY5A==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 9/9] net/sfc: fix reporting status of autonegotiation to the
 user
Date: Tue, 30 Dec 2025 01:35:27 +0400
Message-ID: <20251229213527.37907-10-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229213527.37907-1-ivan.malov@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
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

Currently, the driver always indicates speed autonegotiation to be enabled,
even when the user has disabled it. Fix the code to report the true status.

Fixes: 886f8d8a05bf ("net/sfc: retrieve link info")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/net/sfc/sfc.h        | 2 +-
 drivers/net/sfc/sfc_ethdev.c | 5 +++--
 drivers/net/sfc/sfc_ev.c     | 7 ++++++-
 drivers/net/sfc/sfc_port.c   | 8 +++++---
 drivers/net/sfc/sfc_repr.c   | 2 +-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sfc/sfc.h b/drivers/net/sfc/sfc.h
index af32ccfaa3..629578549f 100644
--- a/drivers/net/sfc/sfc.h
+++ b/drivers/net/sfc/sfc.h
@@ -417,7 +417,7 @@ int sfc_port_configure(struct sfc_adapter *sa);
 void sfc_port_close(struct sfc_adapter *sa);
 int sfc_port_start(struct sfc_adapter *sa);
 void sfc_port_stop(struct sfc_adapter *sa);
-void sfc_port_link_mode_to_info(efx_link_mode_t link_mode,
+void sfc_port_link_mode_to_info(efx_link_mode_t link_mode, uint32_t phy_cap_req,
 				struct rte_eth_link *link_info);
 int sfc_port_update_mac_stats(struct sfc_adapter *sa, boolean_t manual_update);
 int sfc_port_get_mac_stats(struct sfc_adapter *sa, struct rte_eth_xstat *xstats,
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 7c2abaab6b..6be98c49d0 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -262,13 +262,14 @@ sfc_dev_get_rte_link(struct rte_eth_dev *dev, int wait_to_complete,
 	SFC_ASSERT(link != NULL);
 
 	if (sa->state != SFC_ETHDEV_STARTED) {
-		sfc_port_link_mode_to_info(EFX_LINK_UNKNOWN, link);
+		sfc_port_link_mode_to_info(EFX_LINK_UNKNOWN, 0, link);
 	} else if (wait_to_complete) {
 		efx_link_mode_t link_mode;
 
 		if (efx_port_poll(sa->nic, &link_mode) != 0)
 			link_mode = EFX_LINK_UNKNOWN;
-		sfc_port_link_mode_to_info(link_mode, link);
+		sfc_port_link_mode_to_info(link_mode, sa->port.phy_adv_cap,
+					   link);
 	} else {
 		sfc_ev_mgmt_qpoll(sa);
 		rte_eth_linkstatus_get(dev, link);
diff --git a/drivers/net/sfc/sfc_ev.c b/drivers/net/sfc/sfc_ev.c
index 1d1ee0671f..f058b3cb9b 100644
--- a/drivers/net/sfc/sfc_ev.c
+++ b/drivers/net/sfc/sfc_ev.c
@@ -516,7 +516,12 @@ sfc_ev_link_change(void *arg, efx_link_mode_t link_mode)
 	}
 
 decode_comprehensive:
-	sfc_port_link_mode_to_info(link_mode, &new_link);
+	/*
+	 * Reading 'sa->port.phy_adv_cap' without acquiring adaptor lock may
+	 * render autonegotiation status inaccurate, but that's not critical,
+	 * as it's unlikely to happen often and may be a practical trade-off.
+	 */
+	sfc_port_link_mode_to_info(link_mode, sa->port.phy_adv_cap, &new_link);
 
 set:
 	if (rte_eth_linkstatus_set(sa->eth_dev, &new_link) == 0)
diff --git a/drivers/net/sfc/sfc_port.c b/drivers/net/sfc/sfc_port.c
index e5a7b8358d..33b53f7ac8 100644
--- a/drivers/net/sfc/sfc_port.c
+++ b/drivers/net/sfc/sfc_port.c
@@ -130,7 +130,8 @@ sfc_port_init_dev_link(struct sfc_adapter *sa)
 	if (rc != 0)
 		return rc;
 
-	sfc_port_link_mode_to_info(link_mode, &current_link);
+	sfc_port_link_mode_to_info(link_mode, sa->port.phy_adv_cap,
+				   &current_link);
 
 	EFX_STATIC_ASSERT(sizeof(*dev_link) == sizeof(rte_atomic64_t));
 	rte_atomic64_set((rte_atomic64_t *)dev_link,
@@ -614,7 +615,7 @@ sfc_set_rx_mode(struct sfc_adapter *sa)
 }
 
 void
-sfc_port_link_mode_to_info(efx_link_mode_t link_mode,
+sfc_port_link_mode_to_info(efx_link_mode_t link_mode, uint32_t phy_cap_req,
 			   struct rte_eth_link *link_info)
 {
 	SFC_ASSERT(link_mode < EFX_LINK_NMODES);
@@ -684,7 +685,8 @@ sfc_port_link_mode_to_info(efx_link_mode_t link_mode,
 		break;
 	}
 
-	link_info->link_autoneg = RTE_ETH_LINK_AUTONEG;
+	if ((phy_cap_req & (1U << EFX_PHY_CAP_AN)) != 0)
+		link_info->link_autoneg = RTE_ETH_LINK_AUTONEG;
 }
 
 int
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c
index 93da97387c..fbb5f58a8e 100644
--- a/drivers/net/sfc/sfc_repr.c
+++ b/drivers/net/sfc/sfc_repr.c
@@ -533,7 +533,7 @@ sfc_repr_dev_link_update(struct rte_eth_dev *dev,
 	struct rte_eth_link link;
 
 	if (sr->state != SFC_ETHDEV_STARTED) {
-		sfc_port_link_mode_to_info(EFX_LINK_UNKNOWN, &link);
+		sfc_port_link_mode_to_info(EFX_LINK_UNKNOWN, 0, &link);
 	} else {
 		memset(&link, 0, sizeof(link));
 		link.link_status = RTE_ETH_LINK_UP;
-- 
2.47.3

