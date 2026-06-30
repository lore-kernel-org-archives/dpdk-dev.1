Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E45C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 12:49:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AC2540655;
	Tue, 30 Jun 2026 14:49:50 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 0E8A840652
 for <dev@dpdk.org>; Tue, 30 Jun 2026 14:49:49 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so11184785e9.1
 for <dev@dpdk.org>; Tue, 30 Jun 2026 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782823788; x=1783428588; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=FQZc6+6YbekLA3XioTpzEC1wVu+qdKdS92WC9o/heY4=;
 b=kXbwMqh1jCNIuOzHNa7/tKNMxrb3wxkbVecyhOB1A4gegCB6L65D/kESOucLpmEa63
 gunctPA6ByWkGoXyY0yC0I14GiHo3hF0g+GiBsPYGIO8SyP5Po+aumNit7VhKM7FNULh
 ZLNwydkXforI9YSXaK2xDXN8fWU9R0MWVQzaUwEf2PJd3Yny0kK4ln3ALWQUy64zFmU1
 nO7xcu/vygiiH/eeO+9dsky/o4DQ1UsRoRfagbSrL+mdk/S9IwwPeJcNDCKkXQwQeL+S
 kwMVdOZjMND2Hgpfg0g0sQkw+4oS0wmPM0+6pmvpDjnae3G23NGqY76EP84HPvrzCtsI
 rjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823788; x=1783428588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQZc6+6YbekLA3XioTpzEC1wVu+qdKdS92WC9o/heY4=;
 b=OWxMLNRfbt2f+KQiiKrtTDNmat7dWAMJF6m/37G/J/9rjZXSahVNgiDc7/iZbZLA+Q
 aReLbavuLu2BSolRxXR+J3WQQ+kxIOCt6M1fSWuAEl4Tpdm9J6SZbQQpBDblqaXWvH64
 d8uYXZrSOQK7BXUooThHTmV5daqVNIMy1pKGRa9e01fb/CWT3keYYtzZq7eLWUyIDU0a
 XtqujKgzVWOXuntyVGlll8joZH14Gff+YFHXRs3B5QqmM6katvuJzQ+nOEvp8WRafsWU
 4hSypUXTpRCu7r3ClwhZ6U8uFPWxVA6F4hVIarwwUAbkE23ejvERdrYJ1AQzeyAtvaLn
 Magw==
X-Gm-Message-State: AOJu0YwM3DRQvteQ7Yoob9cTnE0JbPauEqJt3ZbWqdHNAdapA4M1w5WP
 EWB6oBp9VKmLUm8+nScBNmheqSeeJii95TorfVObV2Mzp7gH4zuY/uUSaQ4yyuWh
X-Gm-Gg: AfdE7clevggqgH1FFXnOH8d9Z5Zel+vDAgoz/huSdniVkLWxumOnGIBSp+jV4aBf+Si
 NKawykd/2fUtrYUGlQ0gD0qoZHuSrYx2z2gwxITHMW0SzceSdfscfZPXoPNW5iI/qMTaAaD4OfY
 o0YlwMVHT5YI+QwABujBNPUIYTVqdav62b1l1vOGNSE9A6JnaGf6GT5jnjZbIoG/FvzEzbgyjsk
 7JUWxoVfUqKl+avRqdNC3n8O/154NmM/OmA9PYV8pTEyvkbNON5mX9MWqe/ao33Sph1+voCiRMh
 Rii4XoaqSp3PcmI4bqq0GUXKZsrsDrez9/luam7l464u1wfZ66fGOL27//2XsKy2dR16wZi1Z5F
 +7Ao+WI+fyQwsVMBmA6DO3ReM3x9cexicVwmAxgP9jrpDsJNbPRWpBxPQu8bvQQWgVFPk71eUse
 teWAxAzjRe0x4Na5GTRrWLi2tYnXZhNa8eohSr/0I+kg==
X-Received: by 2002:a05:600c:1f88:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-493b82afc23mr53571275e9.20.1782823788463; 
 Tue, 30 Jun 2026 05:49:48 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8cd2a3esm73460255e9.4.2026.06.30.05.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:49:48 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, stephen@networkplumber.org,
 mb@smartsharesystems.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH] net/dpaa2: drop the fake software VLAN strip offload
Date: Tue, 30 Jun 2026 14:49:45 +0200
Message-ID: <20260630124945.399268-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/rel_notes/release_26_07.rst | 3 +++
 drivers/net/dpaa2/dpaa2_ethdev.c       | 1 -
 drivers/net/dpaa2/dpaa2_rxtx.c         | 9 ---------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 9c724e7cc5..c40d3d73a2 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -152,6 +152,9 @@ New Features
 
   * Added inner RSS level support for tunnelled traffic.
   * Added RSS RETA query and update support.
+  * Removed the software VLAN strip offload: ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP``
+    is no longer advertised, as no hardware strip backs it. An application
+    that needs the tag removed must now strip it itself.
 
 * **Updated PCAP ethernet driver.**
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 56682717cf..a68404ee5e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -45,7 +45,6 @@ static uint64_t dev_rx_offloads_sup =
 		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |
-		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index b316e23e87..884cea43c9 100644
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
@@ -1100,11 +1096,6 @@ dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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

