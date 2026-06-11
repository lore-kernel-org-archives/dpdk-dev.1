Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE61CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:51:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 026C243360;
	Thu, 11 Jun 2026 17:50:32 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id ABABB43360
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:50:30 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso69954685e9.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781193030; x=1781797830; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNYuaEQqZF6Puibf7+bYXbOk+UUHiGb1wCneZqoqsXw=;
 b=aYqqWnQ8oiLqlqBn7KkCWAkBgVYpnwZ4bGdDW6AULRMXpWH99hR0HPqk75DF0ekfSP
 re1ykTLFUL5TYxcElMn9c7Hqxm/AaeElghv97wUu75F+I5Maz0VC/VorOUbQ02KBrJws
 iEEFhPIK4/VsTKQNKIclzFX9Peb3KBUTk8cGKLFCKo0X9ykvVSiXNTAzOBdvfC9/gwCt
 4HDzaEoenClAgKNqFsrTF6WYBnVuOZ8z7VfrCMSuKaPDR6oYJ6qkus1gMkqGQjTx77T1
 bTZyAollQbIzxguob9WBs9Ht1+uz9gIC5F6V+lZ6tGRJV/vnOT8N9JoHSkDiG687mbW5
 ZdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193030; x=1781797830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RNYuaEQqZF6Puibf7+bYXbOk+UUHiGb1wCneZqoqsXw=;
 b=hUNNmrdqZJAVXKZl/Ny9ghWRU6GbbpuTDXXeqrx2xzs6HjO2lWWRKmv+xSB2uKNNkj
 0xGWynEfNv3ALkPf+Aab6viqKUEIhbppiOnc4iz1X4637LrBlsP49KLWxp9leYVjNPV2
 gzseldBsIvO4T0BLJIu4DbYkMcnCP6u1qvxsXY1ElP+66/YbgEjaIyOVsSNuBduGg+Si
 WPwDByLTksXg3cziDXxMwGuokf8IMKtoautSPaMo+kEnRQe0PyBvZ4bNkay6u7UbP81C
 +8ajSutqThOMkmNeSuCrXVL0u2yV0OC8OzlKWsGI6ILYzyvdkl6CH/XhZnqUjwun5+Mk
 XxFg==
X-Gm-Message-State: AOJu0YwsqAaLz+qGPiNi+D7oj9ircdWLBnzjyDZfkPXMHEp2dDJbkHWl
 /vjMRzeXWYElC1ZGRHW2aWuOnT0inLGLbgovhucKCjkR+gzlExPBFHI1
X-Gm-Gg: Acq92OEm9gjw1uuHxClKjFpiH42N8Icfo32MfYebNVipBGkqsc2kp7BeXsBIcoUKx3G
 GqCH1frvPfjUc23W4Y/by16WhSU60cdCM9x2ejTzsAjd8dCoX2yA7V+4+i9reYEzjl1D2+0rJYE
 4CKFlNfM+FHlK5K5grwKWP9UZ8pTViS5zNlRRFBLknoPIA4DGDXjlrhuD+E7RKVqboBRTs9BQOQ
 /eatsTSfWz/U46DQDqULUWJG+D4GsO0VVxawBmG+qQUq1cv8aYT+djGtjxfDkI93mrhvODt+vCM
 XteBVM6L0psPgtqJXOsdyS1nA1cGOOXrDd4sg3uFjJMui2y8vBakKgu0XVJHijI8VMbZPe8IwyE
 gVnhCZp6vXUu+wJ8bVyj/yRrnIRfLQypLXI2G0Clj7D/5U/3imAUe45nKbNC+HI0rqKWO94tqEn
 p0/QkdDOMvBq2k/HQ4vgl5qPrz+Q5NN0t1o7ppLVcD3kAOWei8w1BSymRbfiEaJSk=
X-Received: by 2002:a05:600c:1f90:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-490e5619fe2mr43511575e9.28.1781193030196; 
 Thu, 11 Jun 2026 08:50:30 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e47a8246sm39998775e9.2.2026.06.11.08.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:50:29 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com,
	sachin.saxena@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 9/9] net/dpaa2: drop the fake software VLAN strip offload
Date: Thu, 11 Jun 2026 17:49:24 +0200
Message-ID: <20260611154926.392670-10-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611154926.392670-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
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
index 87c7c57bcc..9d01099dad 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -130,6 +130,9 @@ New Features
 
   * Added RSS RETA query and update support.
   * Added Rx queue interrupt support.
+  * Removed the software VLAN strip offload: ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP``
+    is no longer advertised, as no hardware strip backs it. An application
+    that needs the tag removed must now strip it itself.
 
 * **Updated PCAP ethernet driver.**
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index fb117e761f..b3ea826db9 100644
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

