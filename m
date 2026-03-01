Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF9FD0048
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:10:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3E1B40FB5;
	Sun,  1 Mar 2026 03:08:03 +0100 (CET)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 2FE4C40E09
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:59 +0100 (CET)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8cb420fbb5dso187609885a.3
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330878;
 x=1772935678; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkZiXfAYZFgbUTbqIO9oAdyc0JyG4T6P+9rD4sAd/wc=;
 b=OtvtTSyPwHW8jrtWY9yC+wPZmgGmC8ktNApVF/zKpGBWJReFoXLBwJs0VHGVqumSxA
 Fgw6U4PP4PPPZ1QT1ctERmDjGCpC1AJIW/gZ8Rsll3kBT89UoLnplV32thG77xYkMJzy
 ycVi9+6/CbRaZziBJ/Y3OB3zH6XOO2Jwqxc3mvHttWXfofiMBdC7EuYpWZvCMb5psPLf
 AeZto+PenPGTgeYkGVgY5q/7Mf/kWGzm/R3diTo+VO3aAxqw9RKjE1e5QBhVpZFTJXxy
 haJxRaogtrid7m9Z4H7Hu/VgTaIXv2EG2CdfdzVQWgci9y4f+jshuEbeUjIqtf1M3sPG
 I1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330878; x=1772935678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fkZiXfAYZFgbUTbqIO9oAdyc0JyG4T6P+9rD4sAd/wc=;
 b=ppDUWharL4wN4Rcdi7p6G3wOnnkbgiI15XKAbw1Xwrns1UukVgA9rGlC7XtiHe3Ftp
 Aah5qhVSLZr0eju+WqoPhQr+Tt3GBA2YGg+R15ncSSzK/IWRhhFMxmcZHXKwkw+z1yPa
 85GDjhv84aejNV4GoLlJMMmIlkXnPy28EmlRW8qTWba0EplfzeODiwSAtIRV5kRm0no/
 cw3gGM/6lXu1OHePbjXYVU3dts0jIENmbH9ZDPYW4C5ynn+8a5cHMFgxDwDqUX2GYv9U
 79fLoPpGNVNYZSPY+64cXHNOndUb3ZgWFz0TQGl6ekBNEiqaO2UtziFKoRg+dwl7hy/Z
 paoQ==
X-Gm-Message-State: AOJu0YwpRTBbx9mUN/6HHdyw+CAHY2qiUMc2Oaku7cirw1DnHvq9K7lC
 P/+WoX749Ds3mz6pEm/p8f60I91+YTTC/wFu6qmuZ+oldrigCQ639A/015KgU/hQJRqULC3dJS/
 mQvw7
X-Gm-Gg: ATEYQzzMEC3/jM4u44raKgfTiZKrC1AUevlpzjCCHQGwkQyjKs21QEyFrQo0uHgHE3S
 p3RIvl4gT6ALxPuQwxvEWY3A+h8uP9l1d7BcH9+Gr8EutxtMhznijHCTRhl3wwXoKRcjqKz3U5o
 yjafdJQZ+8zt6e3yLpokHgahZ2+ys15zaOZNLda+sDbZejanFX0JNgC3/0U5MxdcjAFDR6bcgVL
 H60eCpB3SNqhEpNkeR/KQU0KEehknyT1yoIKTdwsDz9h5iiqLpGU8qzwM8W4IfbpppqdubRXcPj
 4crpneO03HPdYUm24aMrMfzZm8ragfLz2XkkRV5zjUr85S9pFYMx8Ve/wT+QZ3p/TxuJ4t6wijc
 wMaLFvzkVFCl25XlwjveMGmTXVVo/uTXD8BU6l8cnTFY4QVbrMgICvxVWKjIIVf+tCJ8w5Cdba8
 U6qO/XfsT+GfVFrg318x+wcMiGIekPGJ10q6EW2ZyF5mrhdRGalE++LEGKm79BhQ==
X-Received: by 2002:a05:620a:3193:b0:8cb:4fa5:d47a with SMTP id
 af79cd13be357-8cbc8f62936mr937957785a.77.1772330878356; 
 Sat, 28 Feb 2026 18:07:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 22/23] net/pcap: add EOF notification via link status
 change
Date: Sat, 28 Feb 2026 18:05:55 -0800
Message-ID: <20260301020726.852401-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_03.rst |  2 +
 drivers/net/pcap/pcap_ethdev.c         | 80 +++++++++++++++++++++++++-
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index 72f2250790..18a9a04652 100644
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
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index c1bb808195..aa95b5885c 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -113,6 +113,8 @@ New Features
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
   * Added support for Link State interrupt in ``iface`` mode.
+  * Added ``eof`` devarg to use link state to signal end of receive
+    file input.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index de28eb1dec..70e0604db4 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -42,6 +42,7 @@
 #define ETH_PCAP_IFACE_ARG    "iface"
 #define ETH_PCAP_PHY_MAC_ARG  "phy_mac"
 #define ETH_PCAP_INFINITE_RX_ARG  "infinite_rx"
+#define ETH_PCAP_EOF_ARG          "eof"
 #define ETH_PCAP_SNAPSHOT_LEN_ARG "snaplen"
 
 #define ETH_PCAP_SNAPSHOT_LEN_DEFAULT 65535
@@ -114,6 +115,8 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool eof;
+	RTE_ATOMIC(bool) eof_signaled;
 	bool vlan_strip;
 	bool timestamp_offloading;
 	bool lsc_active;
@@ -148,6 +151,7 @@ struct pmd_devargs_all {
 	bool is_rx_pcap;
 	bool is_rx_iface;
 	bool infinite_rx;
+	bool eof;
 };
 
 static const char *valid_arguments[] = {
@@ -159,6 +163,7 @@ static const char *valid_arguments[] = {
 	ETH_PCAP_IFACE_ARG,
 	ETH_PCAP_PHY_MAC_ARG,
 	ETH_PCAP_INFINITE_RX_ARG,
+	ETH_PCAP_EOF_ARG,
 	ETH_PCAP_SNAPSHOT_LEN_ARG,
 	NULL
 };
@@ -306,15 +311,33 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -335,6 +358,23 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
 
@@ -869,6 +909,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 
+	rte_atomic_store_explicit(&internals->eof_signaled, false, rte_memory_order_relaxed);
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 
 	/* Start LSC polling for iface mode if application requested it */
@@ -892,6 +933,7 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	unsigned int i;
 	struct pmd_internals *internals = dev->data->dev_private;
 	struct pmd_process_private *pp = dev->process_private;
+	bool expected;
 
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
@@ -931,6 +973,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -1113,9 +1162,10 @@ eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
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
@@ -1675,8 +1725,13 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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
@@ -1872,6 +1927,24 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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
@@ -2011,4 +2084,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_EOF_ARG "=<0|1> "
 	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.51.0

