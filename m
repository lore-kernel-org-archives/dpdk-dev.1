Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66522C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:51:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6CBF40DD6;
	Fri, 20 Feb 2026 06:49:07 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 2A25940B9C
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:49:02 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8946e0884afso29567766d6.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566541;
 x=1772171341; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSYP3oixjWYjMBQo0/dzKuflKKz91kL1MqZUbQgmhF4=;
 b=xrk3aeV1jIvrZoNdxaPWKP5i1Q4IyImTV9w8OsPMJFuj2hPCtSW4gflwwd9JG4WygL
 6WwJOPGrVIcf5SJnY0nZoQW4qXmLy7HxKdrXpa2dgYg7ObSj0W+tXO0RZ+hrwAymynbs
 0gtM5laGPkHCTVsf6oVk4D1rqrf2MZKKRNh25d3aRxKQqPWoj+ME2ivOXy65icbhUF21
 2b+WmiHTJLvCcIk6yzVoTrvPk4UdW7F9A41Py2U11IgGxEyauEbDP5icwm0Go7OZ+sHC
 ugMkVwYUJAsMp2trRoPMX/DKNmoGK0HIq3cgu+LO1KwHlM7p+sZvuEfwtiYKXOa8MAMl
 W5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566541; x=1772171341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QSYP3oixjWYjMBQo0/dzKuflKKz91kL1MqZUbQgmhF4=;
 b=XkmBITIfdcGShoU+qUTFJ/0DTuibLgLXQu6nAKA4od+BmHreZUfWoFj5yISXWNub3c
 Miirwc4yPX3xX6apqyNJzZNFwt/X8uxCiA9r2cQD2RIU2wFyPQ6O46aLPOrk9lQSuqYL
 i/z8PW66UGCWlZ3DxfJjETEFsZVVSXgicMmaXcKqBoiBIHSBsgARli4xbTkWDUZLw38K
 hXj3cupIzmxbDGHkx2lf5T3mqT6M1+8vRLNSiINhPyqy5YUwRG3v2m3BFp4KGiNhWIhm
 /j143Mak1u/MsqEodR53azj4ahSZ16B24V4wPQF00ypyuMQJamktclJzE0ep1Bloc+YS
 4XBQ==
X-Gm-Message-State: AOJu0Yw7Ave/qemEfcV0brtxjfNUq85SeMRtvguNlf9EZ68Ptq/Mvas5
 hdt0LgUiBjystL81U5C88gIVmp70EnTxjIZ8jRi66AXh7rWKWk/EPRSYYAAi4N0O0MZ7OYzOvkh
 iVZby
X-Gm-Gg: AZuq6aIFD1XoggO6EtjrSBooqvXKK49RSAe7ni3H2Pa63pkco1jQ6x6IKQllOIyjbCF
 3Yxr16X2ls+IICk3VreoCuz1vjBsj0EWFmHX/Z35Fk6GOwfrE+CnpNT2VOPtxzDRvTOQdkLQO4S
 FahNDTSYjb/pBqjGofbqGFQumonLT/D6IWLoPZwBKBpPJKdPONhYf90Xy+VbVNCfJB6LaFDT1DF
 HP5r5ULsAE8BNr1gKRcAIdMrsaBhXA+fbB6GDaPHGiY6DOuQo0FJI8EuK9mqziOYU3ki0JxM9+6
 xyQJ+T5rZhdFSqdZn4pOE64RPGOkfDVd9sS6pins47pVSaxkWqzL1IzQsZqBQ5JmSLSxX0uKEfS
 KuU+TnErzKbcBgKvAnmI4EvZiYN1Bl8L1nN79YMBLSqDSjkckmNr/kghyTifyQ5RJ0nT4GIomDv
 DYonjPbU8t7GPf9nSlrv7f79s7V+HEgC/uzqRxS9VWGGeuwB4xIaeHniYNOUggeEZhfh7y7t8r
X-Received: by 2002:a05:6214:27c9:b0:890:6331:7e88 with SMTP id
 6a1803df08f44-897404842fcmr313876766d6.44.1771566541443; 
 Thu, 19 Feb 2026 21:49:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:49:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 22/23] net/pcap: add EOF notification via link status
 change
Date: Thu, 19 Feb 2026 21:45:57 -0800
Message-ID: <20260220054834.1632201-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c         | 83 +++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 3 deletions(-)

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
index 39ce14ffe7..d8a8f2dfa5 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -114,6 +114,8 @@ New Features
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
   * Added support for Link State interrupt in ``iface`` mode.
+  * Added ``eof`` devarg to use link state to signal end of receive
+    file input.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 00659764dc..4fc617c7fc 100644
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
@@ -146,6 +149,7 @@ struct pmd_devargs_all {
 	bool is_rx_pcap;
 	bool is_rx_iface;
 	bool infinite_rx;
+	bool eof;
 };
 
 static const char *valid_arguments[] = {
@@ -157,6 +161,7 @@ static const char *valid_arguments[] = {
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
 
@@ -881,6 +921,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 
+	rte_atomic_store_explicit(&internals->eof_signaled, false, rte_memory_order_relaxed);
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 
 	/* Start LSC polling for iface mode if application requested it */
@@ -904,6 +945,7 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	unsigned int i;
 	struct pmd_internals *internals = dev->data->dev_private;
 	struct pmd_process_private *pp = dev->process_private;
+	bool expected;
 
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
@@ -943,6 +985,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -1180,9 +1229,13 @@ eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 		 */
 		link.link_speed = RTE_ETH_SPEED_NUM_10G;
 		link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-		link.link_status = dev->data->dev_started ?
-			RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
 		link.link_autoneg = RTE_ETH_LINK_FIXED;
+
+		if (rte_atomic_load_explicit(&internals->eof_signaled, rte_memory_order_relaxed))
+			link.link_status = RTE_ETH_LINK_DOWN;
+		else
+			link.link_status = dev->data->dev_started ?
+				RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
 	}
 
 	return rte_eth_linkstatus_set(dev, &link);
@@ -1760,8 +1813,13 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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
@@ -1948,6 +2006,24 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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
@@ -2087,4 +2163,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_EOF_ARG "=<0|1> "
 	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.51.0

