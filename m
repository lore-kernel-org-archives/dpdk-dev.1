Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7C9F9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:12:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3380540E19;
	Tue, 14 Apr 2026 18:10:44 +0200 (CEST)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48]) by mails.dpdk.org (Postfix) with ESMTP id 3E01940B9C
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:41 +0200 (CEST)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-41c0aae84e5so2718414fac.3
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183040;
 x=1776787840; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6zaqu8EiWxLt+dbCgJRVQKPIU9P81CGFClQy6P74U4=;
 b=sQlmRVeiW44O9awzOQHG7Dy/yK8DPalMIXPvM1+KkqYwBJE+yKblqQX97aLBcpDWJa
 6aOe8Cc2PXX5FWyTut+0gmVwCGt2wBgxa8EZPUOwoWXFRhEzJMg2gX/jFiZFSliI/VPP
 5zPQYo7yWFmoXcC+4pULlYG+OCrACfLTWV1zKy3jM7GMNKXIcEsIAdWda90JEMKYIAwe
 C02BHWDjJ9uYwdRB+Cv+jdKcdAt43iCJ5jQseLBEZnkBeajJFXX5T9jQ4FFGEucSEEKt
 JZI2Z2xedSK/SavSpcEEaXla9FWD1zkasamFraVtK28U+jfb70B+61Qp5KPhZOSX4Ryx
 L0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183040; x=1776787840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N6zaqu8EiWxLt+dbCgJRVQKPIU9P81CGFClQy6P74U4=;
 b=IYL0yU9t3JWYpRii1pHu3oFvqPIUku/SwJKo6b1tdy2zkcpWnLNHo52ds/Gx0sD/9t
 AXMLE+GTLYoN58cE3TMq7fyvhgih3QIsKUqgjYW3fFoGOJvnjR8v/oVOmwbGJtlztf6H
 LFDfL1jg9CmedHbKmA3PElvbPMHxLvJ/+KKcWWbjkvFpZR52ivoyCJfz4edfIOh3pks4
 k3FCy0pqAp6MLK92KDa3HqkCn2QZoGx7ruHZxB4t8EHbYn27Pm0KxxdNvW4pQCAT0rqi
 0/iNnwp6K5YydBPHw3ZuMi/QM9o05GTqNMXFzcJgHyafFjYnqJirRHKw8uSt3oTa/WgK
 smBQ==
X-Gm-Message-State: AOJu0Yw5CLPtNmY/2jmMPgOv8jTKuamdVyCyjnoRFWm8Dfae3O69GyIb
 elRJRsdZzfadWv6fhvxUbHpcwFkXtJU9Fv582+NUlke9pCHpWUQxXBccHZj/QESE6UfAngv2ypq
 phwFN
X-Gm-Gg: AeBDiesbjNXN133o3fiJtjVXME3me8gvVpd1/EXX7soy/h7sZy3XSacz6bHdLN31pQS
 p7DIsAzSlWi2Md9HMuWKuf8KRnIcR/veQ8DTyN/HXSU/vrMBbD31i0BPn7kRQTIlnCt6rfO3Gyj
 2w/e09qh/psaF9Hey6m7vWgo/W/TXY2v/uXBunK/t05WVa6yfSiFFBI6uK88wEOkS1LjI8+jfIR
 DGUmz3Kqqx79GfszRfJ8/1pGKLsqq4HwpbsrZA2vnyWJx0+EgUOxzTv4ptUXBq1GSjBt0WgCG44
 32hLHDY4H0qIqvINfZIfZNZ6NvH/t/m7LacXx55aVsh84Bt9QyL36ceYM3m9y9Qi0GlfUODpzzB
 Z8va94F54OeWXrN+jWmRJDmJUS3bEsE3jB5l8fqfkAdK0GcLaRWj4rcnRzfXXZwZmqqWoQH9o9J
 P+3LIfobBjN7FHXCwAow+/W49iJAKxlePtBqQJkjJl4Ds=
X-Received: by 2002:a05:6808:d4e:b0:467:13b5:8ae6 with SMTP id
 5614622812f47-4789c847f10mr9157964b6e.4.1776183040258; 
 Tue, 14 Apr 2026 09:10:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v22 23/24] net/pcap: add EOF notification via link status
 change
Date: Tue, 14 Apr 2026 09:08:14 -0700
Message-ID: <20260414161011.756101-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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
 doc/guides/nics/pcap.rst               | 12 ++++
 doc/guides/rel_notes/release_26_07.rst |  2 +
 drivers/net/pcap/pcap_ethdev.c         | 80 +++++++++++++++++++++++++-
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index 91763c27c0..df7a54ae1f 100644
--- a/doc/guides/nics/pcap.rst
+++ b/doc/guides/nics/pcap.rst
@@ -161,6 +161,18 @@ Runtime Config Options
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
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 38c2a67749..730d8fdd39 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -62,6 +62,8 @@ New Features
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
   * Added support for Link State interrupt in ``iface`` mode.
+  * Added ``eof`` devarg to use link state to signal end of receive
+    file input.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 2276aaf513..08d3ab9e91 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -42,6 +42,7 @@
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
+	RTE_ATOMIC(bool) eof_signaled;
 	bool vlan_strip;
 	bool rx_scatter;
 	bool timestamp_offloading;
@@ -150,6 +153,7 @@ struct pmd_devargs_all {
 	bool is_rx_pcap;
 	bool is_rx_iface;
 	bool infinite_rx;
+	bool eof;
 };
 
 static const char *valid_arguments[] = {
@@ -161,6 +165,7 @@ static const char *valid_arguments[] = {
 	ETH_PCAP_IFACE_ARG,
 	ETH_PCAP_PHY_MAC_ARG,
 	ETH_PCAP_INFINITE_RX_ARG,
+	ETH_PCAP_EOF_ARG,
 	ETH_PCAP_SNAPSHOT_LEN_ARG,
 	NULL
 };
@@ -308,15 +313,33 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -337,6 +360,23 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			if (ret == PCAP_ERROR)
 				pcap_q->rx_stat.err_pkts++;
 
+			/*
+			 * EOF: if eof mode is enabled, set link down and
+			 * defer notification via alarm to avoid calling
+			 * rte_eth_dev_callback_process() from the datapath.
+			 */
+			else if (ret == PCAP_ERROR_BREAK) {
+				bool expected = false;
+
+				if (internals->eof &&
+				    rte_atomic_compare_exchange_strong_explicit(
+					    &internals->eof_signaled, &expected, true,
+					    rte_memory_order_relaxed, rte_memory_order_relaxed)) {
+					eth_link_update(dev, 0);
+					rte_eal_alarm_set(1, eth_pcap_eof_alarm, dev);
+				}
+			}
+
 			break;
 		}
 
@@ -894,6 +934,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 
+	rte_atomic_store_explicit(&internals->eof_signaled, false, rte_memory_order_relaxed);
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 
 	/* Start LSC polling for iface mode if application requested it */
@@ -917,6 +958,7 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	unsigned int i;
 	struct pmd_internals *internals = dev->data->dev_private;
 	struct pmd_process_private *pp = dev->process_private;
+	bool expected;
 
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
@@ -956,6 +998,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	}
 
 status_down:
+	/* Cancel any pending EOF alarm */
+	expected = true;
+	if (rte_atomic_compare_exchange_strong_explicit(
+		    &internals->eof_signaled, &expected, false,
+		    rte_memory_order_relaxed, rte_memory_order_relaxed))
+		rte_eal_alarm_cancel(eth_pcap_eof_alarm, dev);
+
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -1152,9 +1201,10 @@ eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	if (internals->single_iface) {
 		link.link_status = (osdep_iface_link_status(internals->rx_queue[0].name) > 0) ?
 			RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+	} else if (rte_atomic_load_explicit(&internals->eof_signaled, rte_memory_order_relaxed)) {
+		link.link_status = RTE_ETH_LINK_DOWN;
 	} else {
-		link.link_status = dev->data->dev_started ?
-			RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+		link.link_status = dev->data->dev_started ? RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
 	}
 
 	return rte_eth_linkstatus_set(dev, &link);
@@ -1745,8 +1795,13 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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
@@ -1934,6 +1989,24 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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
@@ -2072,4 +2145,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_EOF_ARG "=<0|1> "
 	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.53.0

