Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A9CE83821
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88C93406BC;
	Mon, 16 Feb 2026 19:14:44 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 3C54040666
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:42 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4376acce52eso2248895f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265682;
 x=1771870482; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cu57hkKAvQ4Yr6HRucGq7kfEky4DkWVITAcag7djEyI=;
 b=TQKkEe3MJ1Mq/PUkbWlaRsejeSuSWiG36S3hEPUbK6L0tFmIJfcaeAOLbzhUUTMRda
 qRPs6/rpUid5ZgXPr2flKCDsP6II5hgyIwqATAjWs0f1b86ff4hUIKlFDoIdogm7a8yi
 WKqoAtnLTw+Wt4zQeyKChljfskeN2hhj6W8rP3GjbLqQPjHS+1QgPUlydy2L1hEmtWsA
 7sIbNbpuczHnM0W/kermfLM1ZRuX5VnT2D0IhL74p84rEUBEvs2J/Fqo4Sr1clgyqBbe
 8tnv1xNNlbsleX/o3Ns8Yk+ZuwtrBiGFZZqDgTfAIxHbt+P3W4QPPhyytA+h+CA8exHl
 vXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265682; x=1771870482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cu57hkKAvQ4Yr6HRucGq7kfEky4DkWVITAcag7djEyI=;
 b=p2hQnR3GiSx5OKOG39lec6Z0dVoSvsnh/zpuI1zEWR8qC9mweZr+Jmcm6h1bEYO0aK
 2icYp12SrAXKh6nvjgrojN62blyMJYqYbkb8CJVbKNCRZhyGhSABDMfIFuLcjpid5Zhh
 /jspPk8rsH2KkWC1hhrafGsYxU11tS1wB331yYJm5RvngZdZrvXtefUzD1KT2pGkbCxa
 amE7hG58WoPe+01x3ifuvLYICsVKktkAfr1JJkfz0YWmXdGPAzjQeTERz9cCQGADGGtZ
 bTiuR6oY0KI9m1tKkg7YEXtJC6Ypgv9WeNeqOPYmceUruyKmT4vGwgnEqAngF+2ntjjG
 ITXw==
X-Gm-Message-State: AOJu0YzwUlxr6U3V8nEAL5jgbFmz40Tzh+X9Pbct8MqmJ0O9lIWbL3Gx
 1+Ne1l27b4IfT9HHN+0C3El7H4jkTQSLdbGivyTUSB0K/Yb0oLsZ2W/tko9RK5AJKwN3/nhx530
 rFt8TmMA=
X-Gm-Gg: AZuq6aKkC1WdINWSXHZfQrhg2V8eGR/tyT6Ejr4z9uMGGiaPi8gqOn4V0aEgk+NSMAv
 lFIP7PLV4tbdJaG0sKew/69I3FPYvH7YBkPJr197vbKFFYfPOOGiPUSrZwTRaqiKLzQov7uXELe
 NEMbTnj4RWsM14mwadp6y6RUQAY/ffQn70ME2AzkUN64MATAd2HwA/JLV/ebNKc5ELZoQCFc7II
 YZF+eAmAMVfTRNCynSE1vYrRKxknoiqaY7/kRUN1pdg9q9pZPVafo7O+YJGEo5ATk0WIcA4kcfa
 UtzN/QRcD1by+FDx/q02sNi/AA+sTuN92y1xzGFXEJHIYnh9k5g9bZ2wGQ+UCYM9IJ4iD8FL6HQ
 eSt+QcVCOiCVulHXpNjXIm1OqysaY6AyHaqaIQ1nq63PnJO/86v6VJpde81BK8ZqIH7A4K7AbSn
 hAR3qqTpiQsTGMzlVMiyzZmjeVziCkRlN4rsZH4emBmnwNGxLwwgS32nFfXU/5lw==
X-Received: by 2002:a05:6000:2307:b0:436:1a4b:de36 with SMTP id
 ffacd0b85a97d-437978cd6f0mr18843123f8f.22.1771265681664; 
 Mon, 16 Feb 2026 10:14:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 20/21] net/pcap: add EOF notification via link status
 change
Date: Mon, 16 Feb 2026 10:12:15 -0800
Message-ID: <20260216181407.428877-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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

Add an "eof" devarg for rx_pcap mode that signals end-of-file by
setting link down and generating an LSC event. This allows
applications to detect when a pcap file has been fully consumed
using the standard ethdev callback mechanism.

The eof and infinite_rx options are mutually exclusive. On device
restart, the EOF state is reset so the file can be replayed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/pcap.rst               | 12 +++++
 doc/guides/rel_notes/release_26_03.rst |  2 +
 drivers/net/pcap/pcap_ethdev.c         | 75 ++++++++++++++++++++++++--
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index f241069ebb..6f3a4fc887 100644
--- a/doc/guides/nics/pcap.rst
+++ b/doc/guides/nics/pcap.rst
@@ -144,6 +144,18 @@ Runtime Config Options
   so all queues on a device will either have this enabled or disabled.
   This option should only be provided once per device.
 
+* Signal end-of-file via link status change
+
+  In case ``rx_pcap=`` configuration is set, the user may want to be notified when
+  all packets in the pcap file have been read.  This can be done with the ``eof``
+  devarg, for example::
+
+     --vdev 'net_pcap0,rx_pcap=file_rx.pcap,eof=1'
+
+  When enabled, the driver sets link down and generates an LSC event at end of file.
+  If the device is stopped and restarted, the EOF state is reset.
+  This option cannot be combined with ``infinite_rx``.
+
 * Drop all packets on transmit
 
   To drop all packets on transmit for a device,
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 314f6d615b..1e30256f36 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -100,6 +100,8 @@ New Features
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
   * Added support for Link State interrupt in ``iface`` mode.
+  * Added ``eof`` devarg to use link state to signal end of receive
+    file input.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 5fc534014e..80c6f15cb4 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -43,6 +43,7 @@
 #define ETH_PCAP_IFACE_ARG    "iface"
 #define ETH_PCAP_PHY_MAC_ARG  "phy_mac"
 #define ETH_PCAP_INFINITE_RX_ARG  "infinite_rx"
+#define ETH_PCAP_EOF_ARG          "eof"
 #define ETH_PCAP_SNAPSHOT_LEN_ARG "snaplen"
 
 #define ETH_PCAP_SNAPSHOT_LEN_DEFAULT 65535
@@ -115,6 +116,8 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool eof;
+	bool eof_signaled;
 	bool vlan_strip;
 	bool timestamp_offloading;
 	bool lsc_active;
@@ -147,6 +150,7 @@ struct pmd_devargs_all {
 	bool is_rx_pcap;
 	bool is_rx_iface;
 	bool infinite_rx;
+	bool eof;
 };
 
 static const char *valid_arguments[] = {
@@ -158,6 +162,7 @@ static const char *valid_arguments[] = {
 	ETH_PCAP_IFACE_ARG,
 	ETH_PCAP_PHY_MAC_ARG,
 	ETH_PCAP_INFINITE_RX_ARG,
+	ETH_PCAP_EOF_ARG,
 	ETH_PCAP_SNAPSHOT_LEN_ARG,
 	NULL
 };
@@ -307,15 +312,33 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	return i;
 }
 
+/*
+ * Deferred EOF alarm callback.
+ *
+ * Scheduled from the RX burst path when end-of-file is reached,
+ * so that rte_eth_dev_callback_process() runs outside the datapath.
+ * This avoids holding any locks that the application callback
+ * might also need, preventing potential deadlocks.
+ */
+static void
+eth_pcap_eof_alarm(void *arg)
+{
+	struct rte_eth_dev *dev = arg;
+
+	rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+}
+
 static uint16_t
 eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
+	struct pcap_rx_queue *pcap_q = queue;
+	struct rte_eth_dev *dev = &rte_eth_devices[pcap_q->port_id];
+	struct pmd_internals *internals = dev->data->dev_private;
 	unsigned int i;
 	struct pcap_pkthdr *header;
 	struct pmd_process_private *pp;
 	const u_char *packet;
 	struct rte_mbuf *mbuf;
-	struct pcap_rx_queue *pcap_q = queue;
 	uint16_t num_rx = 0;
 	uint32_t rx_bytes = 0;
 	pcap_t *pcap;
@@ -336,6 +359,19 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			if (ret == PCAP_ERROR)
 				pcap_q->rx_stat.err_pkts++;
 
+			/*
+			 * EOF: if eof mode is enabled, set link down and
+			 * defer notification via alarm to avoid calling
+			 * rte_eth_dev_callback_process() from the datapath.
+			 */
+			else if (ret == PCAP_ERROR_BREAK) {
+				if (internals->eof && !internals->eof_signaled) {
+					internals->eof_signaled = true;
+					eth_link_update(dev, 0);
+					rte_eal_alarm_set(1, eth_pcap_eof_alarm, dev);
+				}
+			}
+
 			break;
 		}
 
@@ -879,6 +915,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 
+	internals->eof_signaled = false;
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 
 	/* Start LSC polling for iface mode if application requested it */
@@ -941,6 +978,10 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	}
 
 status_down:
+	/* Cancel any pending EOF alarm */
+	if (internals->eof_signaled)
+		rte_eal_alarm_cancel(eth_pcap_eof_alarm, dev);
+
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -1178,9 +1219,13 @@ eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 		 */
 		link.link_speed = RTE_ETH_SPEED_NUM_10G;
 		link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-		link.link_status = dev->data->dev_started ?
-			RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
 		link.link_autoneg = RTE_ETH_LINK_FIXED;
+
+		if (internals->eof_signaled)
+			link.link_status = RTE_ETH_LINK_DOWN;
+		else
+			link.link_status = dev->data->dev_started ?
+				RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
 	}
 
 	return rte_eth_linkstatus_set(dev, &link);
@@ -1760,8 +1805,13 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 	}
 
 	internals->infinite_rx = infinite_rx;
+	internals->eof = devargs_all->eof;
 	internals->snapshot_len = devargs_all->snapshot_len;
 
+	/* Enable LSC for eof mode (already set above for single_iface) */
+	if (internals->eof)
+		eth_dev->data->dev_flags |= RTE_ETH_DEV_INTR_LSC;
+
 	/* Assign rx ops. */
 	if (infinite_rx)
 		eth_dev->rx_pkt_burst = eth_pcap_rx_infinite;
@@ -1948,6 +1998,24 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 					"for %s", name);
 		}
 
+		/*
+		 * Check whether to signal EOF via link status change.
+		 */
+		if (rte_kvargs_count(kvlist, ETH_PCAP_EOF_ARG) == 1) {
+			ret = rte_kvargs_process(kvlist, ETH_PCAP_EOF_ARG,
+						 &process_bool_flag,
+						 &devargs_all.eof);
+			if (ret < 0)
+				goto free_kvlist;
+		}
+
+		if (devargs_all.infinite_rx && devargs_all.eof) {
+			PMD_LOG(ERR, "Cannot use both infinite_rx and eof for %s",
+				name);
+			ret = -EINVAL;
+			goto free_kvlist;
+		}
+
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_RX_PCAP_ARG,
 				&open_rx_pcap, &pcaps);
 	} else if (devargs_all.is_rx_iface) {
@@ -2087,4 +2155,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_EOF_ARG "=<0|1> "
 	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.51.0

