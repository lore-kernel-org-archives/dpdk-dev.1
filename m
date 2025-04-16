Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43378C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:06:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27B06427E5;
	Wed, 16 Apr 2025 16:01:15 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id BFC91427B7
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:01:04 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 1839AE11BF;
 Wed, 16 Apr 2025 18:01:04 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 1839AE11BF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812064;
 bh=rv9C/tSlKRNf3pbHlNiHlSeLVLlSQYZIuVzjAlwabow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pfrAyG5acrn0FZllBLU5Dssq4a1Dq+bLL3C63UjZfCXZjSMURJGywkl2zYz0CiCYQ
 9wGboVcapQxKD9UY+9F2QrwbH4aO1pbC+I//R9Kpm4BU4GtNejr25tjCO6DSuUdVhD
 ps/WPDjsHxnLiJqkAbZd87qfInGf4XLafsyEfYtSO21hLjSI0/k8uPt8SXeOMbkMr4
 Z6U3Bng3SJ28MmGrHJ+F5JN9uGIotzzuSFUrzYfnaI/Fk6TrB56rS2R8uiyveMwNv9
 ePnMAZtI9GztIUrs2gA9jSDpt6TFTJWBZhmqFUPKu1dRIfToqAuj7uoMnb221U1+yD
 B05Kf6RhFh2lw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 41/46] net/sfc: query link status on link change events on new
 NICs
Date: Wed, 16 Apr 2025 18:00:11 +0400
Message-Id: <20250416140016.36127-42-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

Link events signaled on new adaptors (Medford4 and later) do
not carry any specifics, so query the link status separately.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/sfc/sfc.h        |  2 ++
 drivers/net/sfc/sfc_ethdev.c |  2 ++
 drivers/net/sfc/sfc_ev.c     | 51 +++++++++++++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sfc/sfc.h b/drivers/net/sfc/sfc.h
index 2432a2307e..819ce52529 100644
--- a/drivers/net/sfc/sfc.h
+++ b/drivers/net/sfc/sfc.h
@@ -309,6 +309,8 @@ struct sfc_adapter {
 	uint32_t			rxd_wait_timeout_ns;
 
 	bool				switchdev;
+
+	bool				link_ev_need_poll;
 };
 
 static inline struct sfc_adapter_shared *
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index bd0061f557..05933b1d39 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -3252,6 +3252,8 @@ sfc_eth_dev_init(struct rte_eth_dev *dev, void *init_params)
 	if (rc != 0)
 		goto fail_nic_dma_attach;
 
+	sa->link_ev_need_poll = encp->enc_link_ev_need_poll;
+
 	sfc_adapter_unlock(sa);
 
 	sfc_log_init(sa, "done");
diff --git a/drivers/net/sfc/sfc_ev.c b/drivers/net/sfc/sfc_ev.c
index c0d58c9554..1d1ee0671f 100644
--- a/drivers/net/sfc/sfc_ev.c
+++ b/drivers/net/sfc/sfc_ev.c
@@ -467,9 +467,58 @@ sfc_ev_link_change(void *arg, efx_link_mode_t link_mode)
 {
 	struct sfc_evq *evq = arg;
 	struct sfc_adapter *sa = evq->sa;
-	struct rte_eth_link new_link;
+	struct rte_eth_link new_link = {0};
 
+	if (sa->link_ev_need_poll) {
+		efx_link_mode_t new_mode;
+		bool poll_done = false;
+
+		/*
+		 * The event provides only the general status. When the link is
+		 * up, poll the port to get the speed, but it is not compulsory.
+		 */
+		if (link_mode != EFX_LINK_DOWN) {
+			int ret = 0;
+
+			if (sfc_adapter_trylock(sa)) {
+				/* Never poll when the adaptor is going down. */
+				if (sa->state == SFC_ETHDEV_STARTED) {
+					ret = efx_port_poll(sa->nic, &new_mode);
+					poll_done = true;
+				}
+
+				sfc_adapter_unlock(sa);
+			}
+
+			if (ret != 0) {
+				sfc_warn(sa, "port poll failed on link event");
+				poll_done = false;
+			}
+		}
+
+		if (poll_done) {
+			link_mode = new_mode;
+			goto decode_comprehensive;
+		}
+
+		new_link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		new_link.link_autoneg = RTE_ETH_LINK_AUTONEG;
+
+		if (link_mode == EFX_LINK_DOWN) {
+			new_link.link_speed  = RTE_ETH_SPEED_NUM_NONE;
+			new_link.link_status = RTE_ETH_LINK_DOWN;
+		} else {
+			new_link.link_speed  = RTE_ETH_SPEED_NUM_UNKNOWN;
+			new_link.link_status = RTE_ETH_LINK_UP;
+		}
+
+		goto set;
+	}
+
+decode_comprehensive:
 	sfc_port_link_mode_to_info(link_mode, &new_link);
+
+set:
 	if (rte_eth_linkstatus_set(sa->eth_dev, &new_link) == 0)
 		evq->sa->port.lsc_seq++;
 
-- 
2.39.5

