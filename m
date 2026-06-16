Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3B0CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:28:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A39A840E12;
	Tue, 16 Jun 2026 12:27:53 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 1AB4640E16
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:27:52 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so34212545e9.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781605672; x=1782210472; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u44vEJYu7tuedv80Slv+baV9FU2L23y0C6dtQuVEblM=;
 b=fW+7VLGr+onzmn8MWr3Lc8zNaq4f3JgLNwDkoBPvbhZoK5sqjApmiPK8QVVXKPadsM
 aGtHC9us+eVJ6fttipIu2WhGtNay3Q4Zwfc4i6u2CrbPEzNs6lvUwPEVkhPgRZjmUDce
 OiDb9/YtAGBgF6tQWvmzjSZ2QSZGA/yGFcX74l3R6pQn592W9UP+nK+doSLcUgD8w/hV
 Tx7lifgt+DWd1E6BV71+bVPc3LzNNYyifiJF42w4cJPntNZFWqFCFDR1X4thhMrHJHAh
 0dfWdTtEhYVFZ0/Zs4E0oo9bpqw5Ud8MxQWIvura7TBA9v/6uhmp9i8m0esKpPJxR4Tg
 2xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605672; x=1782210472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u44vEJYu7tuedv80Slv+baV9FU2L23y0C6dtQuVEblM=;
 b=aIbIh1NRQDshmZEAHveKw7Ua8bepT8OzwU4AalYgodc1rRq2AVzjVXgLWj+vFWYhar
 n8lg9HVIOPeRZ53uyoxbsvitT9x5FBfVgxmTOEIIe3kpnn4MMPPgyULgpZoulz8BStUJ
 lNcF9D1ahRXoRoYPuf7CJVFP8+fc4k5GFWo0ImJu883Rrfd3+p/TOMl2ILmcxUQw2Z/I
 /MYj4w7JnRyRhZe5GRW/VBPNQxpb9MadZzRo30px/tY5mXvAOnPbHJFGi8l/nZfrWk3f
 VHa1gljMm6/uYU5mXOJTrlc0lE6dJVzYFSs+IOhfyjKixt+4IAviZRmgiNpfab3xrjRD
 fScQ==
X-Gm-Message-State: AOJu0Yy9gjkEXmhlBXpMRaV7iqoWbN4RTaK11dUl5Z0eXm85oMq3xo5A
 rKIjmIYyzNW8H1A03zlhiNRUv/UOVPzf0cmv8+tCE7lFPNvnP5rcj6WDBLouqTDy
X-Gm-Gg: Acq92OHj1nInUPaucSddMycYs3yQjriPa6nfTRuNmwlc6tWxhlYWk3GJC9r+78Q9G3F
 V/+dzFlVErd5wZQ2PgUEuZb0cbdrh39qAWfRqI321ypXqjqzx0UXCVSTGfwWpO6ieKmyaN/LaA0
 6VJ3yMx3NcPqrohxHCSMUsCDJUGExWnix32QJ1lcnX6A3l1B5t/xewXyEnMgmzt/F6h/wb8k9hR
 dUGs/I6W8MDLi406Khu2T+WD6uRxAxqnV+IkoNZbK1aqn2h6gLNR6bHsylfaqHg5IowcFCQEofc
 +nfFXghlPOFlzWkhW9Lswt+Zc0LW88GfyEoFMGDk2tTBjB3NDQKYgC2kH9Zm5AXHhD1ze+dD+FN
 7YuEQED8oUq1KhtF43ToxJhb5D16MpAZO45A4CN9N1+iEfAVvDa4zY9j0WR81/Yzn3cxflAYj4Z
 HQQEbqtf2y+Gx1wsH/7lAgW3FHFT7CcOcdR+oGxUQtwpc0277avJ7V3j3sKjZAeaU=
X-Received: by 2002:a05:600c:4fc9:b0:490:b446:fb8 with SMTP id
 5b1f17b1804b1-4922ff938e3mr48629515e9.11.1781605671275; 
 Tue, 16 Jun 2026 03:27:51 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a399fsm286781655e9.0.2026.06.16.03.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:27:50 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 6/6] net/dpaa2: drop the fake software VLAN strip offload
Date: Tue, 16 Jun 2026 12:27:26 +0200
Message-ID: <20260616102727.708948-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616102727.708948-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
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

RTE_ETH_RX_OFFLOAD_VLAN_STRIP is advertised, but no hardware VLAN strip
backs it: when enabled, the Rx burst calls rte_vlan_strip() on every
frame, a software op masquerading as a hardware offload.

It saves a forwarding application nothing: the datapath reads the L2
header anyway to classify or strip. The offload does not remove that
read, it relocates it into the driver Rx burst, where it is far more
expensive.

The cost is a matter of timing. rte_vlan_strip() reaches the L2 header
through rte_pktmbuf_mtod(), which dereferences mbuf->buf_addr. On a
freshly recycled buffer that mbuf cacheline is cold. eth_fd_to_mbuf()
has just written other fields of it (data_off, ol_flags), but buf_addr
is a persistent field it does not rewrite. A write does not stall: it
posts to the store buffer while the line fills in the background, and
the rewritten fields are forwarded straight from there. buf_addr has
nothing to forward, so it must be read from the line, whose fill is
still in flight, and the read stalls. The ethertype read that follows,
on the cold payload line, stalls again. Read later by the application,
when the fill has completed, the same read hits. The offload just
performs it at the worst possible moment.

Measured on a single-core port-to-port forwarding test over two 10G
ports (one core at 2 GHz, 64-byte untagged frames):

  - throughput 4.22 -> 5.00 Mpps (+18 percent)
  - IPC 0.93 -> 1.25: the cost was memory stall, not compute
  - L3/DRAM-bound L2 refills 319M -> 200M over 10s (-37 percent)

perf confirms it: with the offload, the buf_addr load (the cold mbuf
field) and the payload load account for about 84 percent of the Rx
burst's L2 refills; removing it, those vanish and only the inherent DQRR
dequeue misses remain.

Stop advertising VLAN_STRIP and remove the rte_vlan_strip() calls from
every Rx path. This is a behavioural change: the tag is left in the
frame, so an application must strip it itself, on the L2 header it
already reads.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/rel_notes/release_26_07.rst |  3 +++
 drivers/net/dpaa2/dpaa2_ethdev.c       |  1 -
 drivers/net/dpaa2/dpaa2_rxtx.c         | 23 +++--------------------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 3bc49c3910..1da1d7b729 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -143,6 +143,9 @@ New Features
 * **Updated NXP dpaa2 driver.**
 
   * Added Rx queue interrupt support.
+  * Removed the software VLAN strip offload: ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP``
+    is no longer advertised, as no hardware strip backs it. An application
+    that needs the tag removed must now strip it itself.
 
 * **Updated PCAP ethernet driver.**
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index ac7303c116..e0451d4ac6 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -48,7 +48,6 @@ static uint64_t dev_rx_offloads_sup =
 		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |
-		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 189accc1de..d16e4f8f35 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -890,10 +890,6 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 #endif
 
-		if (eth_data->dev_conf.rxmode.offloads &
-				RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
-			rte_vlan_strip(bufs[num_rx]);
-
 		dq_storage++;
 		num_rx++;
 	} while (pending);
@@ -922,22 +918,14 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	return num_rx;
 }
 
-/* Convert a DQRR'd FD (single or scatter-gather) to an mbuf and apply software
- * VLAN strip, like the poll path.
- */
+/* Convert a DQRR'd FD (single or scatter-gather) to an mbuf. */
 static inline struct rte_mbuf *
 dpaa2_dqrr_fd_to_mbuf(const struct qbman_fd *fd,
 		      struct rte_eth_dev_data *eth_data)
 {
-	struct rte_mbuf *m;
-
 	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
-		m = eth_sg_fd_to_mbuf(fd, eth_data->port_id);
-	else
-		m = eth_fd_to_mbuf(fd, eth_data->port_id);
-	if (eth_data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
-		rte_vlan_strip(m);
-	return m;
+		return eth_sg_fd_to_mbuf(fd, eth_data->port_id);
+	return eth_fd_to_mbuf(fd, eth_data->port_id);
 }
 
 /* prefetch a DQRR'd FD's HW annotation (parse area) ahead of conversion */
@@ -1222,11 +1210,6 @@ dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 #endif
 
-		if (eth_data->dev_conf.rxmode.offloads &
-				RTE_ETH_RX_OFFLOAD_VLAN_STRIP) {
-			rte_vlan_strip(bufs[num_rx]);
-		}
-
 			dq_storage++;
 			num_rx++;
 			num_pulled++;
-- 
2.43.0

