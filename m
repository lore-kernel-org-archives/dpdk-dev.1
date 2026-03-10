Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33479FCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:52:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87AE640E25;
	Tue, 10 Mar 2026 03:49:59 +0100 (CET)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45]) by mails.dpdk.org (Postfix) with ESMTP id 778B440E16
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:54 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d75d698ee6so98873a34.3
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110994;
 x=1773715794; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SVIQ5TlEfCpY35XxO2WPYndaKvb2NlJNAe8f7Ij/nc=;
 b=TYB9Hs99kCuCAZtUvnpFiGGjHZCDEUMXbLvS/g6hcDCMABQDtnnPyCY0ueU6PQSJGS
 38egPBenrE3hGSmGVgK/XGjRb54WW2ENVTpZvNlho29Z4X96CZtoP7Go/sy7DLMC0E9T
 XOIbTyK35IGfH+1KMC+o6Ug/9T/DevzQfPZaD0iFTwx4EjRVG36p1eyjuSMX4hXvVLOu
 dUrAtAnb+sgFGMainDOfH1PNCFIuAfYWMo1o6jkqoWzA5QbZOs1hMJxFgp5U6nMTMvW8
 iytZR1Ahap6GDe1pzB31TLUoD9wyzL2UPErOHXtfWJ6THJRDSIRIRMUCLmrTT9hnEmuG
 kzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110994; x=1773715794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0SVIQ5TlEfCpY35XxO2WPYndaKvb2NlJNAe8f7Ij/nc=;
 b=xHYZXKSLk3qSleFwxYcG+FY2tbVHc8rvkURn6M3iypqV2tzTzwJ70ccGce5nh1f4wN
 Lh1dv5Q26FOC84pMbzn09g0FZZsKc2hTll+JgBuwn3IS4N+SOm365rH+BdowSP4c/me+
 jUOgwD9WOQ0175EVKHpKBLgvHkDDA5x1H++JttqYqS+/Zl5lTKA5IrWOwoFEddu60LuL
 CBgVid/3Rh+J9yV+ayYw0V7aYUukZrmXHKgPW+JHDyTfJCjpAehGcn0CTyDHWEFBWakm
 xpSbboUjud0xx1R4CLYaS0mLLY3RfJm3yaPw27Dojbl/gQ9XOq+rdcczF6TSjpN1IVRs
 DGIw==
X-Gm-Message-State: AOJu0YyL6az3tfuN4xDrU/Vkr/jEYeCmos2Zm8WoxSezT7sdrFbdQ2oT
 QQA4k8Fr0H8aSoIxrFWjRxJ5CREtr7Z5JUJAutvAcV2GXLObYqcY+0Cy4ffLd2Ia0i/rrIfUSLm
 UsOyZeIQ=
X-Gm-Gg: ATEYQzy24SwJevylxsH/G2F6DXGvHvzqVAi1IDkIFVn6ubqSKYXIViuAAly0/8JmF7j
 qZDIawxrewpP9w8i8GCh11dLa087q5LPnb3XaQDZemFAzgwYsFIz6iIl8mXHjWQaa35qgsYOl9f
 YhU0Z50a3dL3mkY1hvnvXzXMpDKMHgP4lWf42hDYhXm9tuyCRzIEyOsBCYHI6b6GX9W8AoqanYS
 Q5BP+ShRO0ku1yCvZuQPtxg7Drq7PHQVaxFKbRyWq7wEqQRIqQ6AU+BEni/QTBGeRkiOcxIzpzu
 VZWey4g0tC0ool/wUot2JesOUpd5NLe69vab+FPc1xQ4bhWIaqxBppHHFgQGYjHe9v++ka0O62/
 Y/6O8SCPQo1bNXyOT+Lgx36zlPKCN3yv9UywXB4BGpwM2PpfSKFtSiJJFXG2u7Gvs6v8OvRc67C
 UE0pc8R44hF3Q9wI9O2onKAhdM+sA69jtu
X-Received: by 2002:a05:6830:3691:b0:7d7:40c1:ef57 with SMTP id
 46e09a7af769-7d740c1f9dfmr5078426a34.30.1773110993661; 
 Mon, 09 Mar 2026 19:49:53 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 23/25] net/pcap: add EOF notification via link status
 change
Date: Mon,  9 Mar 2026 19:47:58 -0700
Message-ID: <20260310024925.476543-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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
index 2d64032474..feefcf922d 100644
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
 
@@ -875,6 +915,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 
+	rte_atomic_store_explicit(&internals->eof_signaled, false, rte_memory_order_relaxed);
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 
 	/* Start LSC polling for iface mode if application requested it */
@@ -898,6 +939,7 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	unsigned int i;
 	struct pmd_internals *internals = dev->data->dev_private;
 	struct pmd_process_private *pp = dev->process_private;
+	bool expected;
 
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
@@ -937,6 +979,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -1121,9 +1170,10 @@ eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
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
@@ -1715,8 +1765,13 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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
@@ -1912,6 +1967,24 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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
@@ -2051,4 +2124,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_EOF_ARG "=<0|1> "
 	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.51.0

