Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A4DEA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:13:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3C5840BA4;
	Sun, 19 Apr 2026 18:11:39 +0200 (CEST)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43]) by mails.dpdk.org (Postfix) with ESMTP id 3724B4065F
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:38 +0200 (CEST)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso1924480fac.2
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615097;
 x=1777219897; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0N/VQmY+9wlxj/i2Pt8c+ObP90OWk48ihoSb9B/7ikY=;
 b=tYL/8fqARJeK0fz7cxjnblgMbatmG+p/GzAjYqgb8/RCKWOshCToLM+Tzu/iA1z1+d
 bbc4kObVzcxbt+HPvE3OUry2o8a/uIsXUmpUqpeutpoVJvvCQ+mUR6Hy3G3OO9mN0qve
 H6RsmVOpUiHEmsdpUVMaCGxbIb7WyAzsPn9M7S88Sl1XHLJtNTyNr9ujDM3El5C/sraT
 xnj3eN8yHCTUQZ17SQkRnOpnCebQnZlqGyrAuyDgZ1wDADk/S8tgQB7zlzOv6OysjlgM
 TYavcxeXCWplInJUmjZ4kEF1uPhgO26x2ocpRtH6anN0agmDJbuVvaAkMc2hHWaPtq66
 i4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615097; x=1777219897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0N/VQmY+9wlxj/i2Pt8c+ObP90OWk48ihoSb9B/7ikY=;
 b=Exxv2xS67F1nWWNypF3UAgU4qsQ7nX4ugFHsRu9q8XAUUdflA8y+K7BfGWfBLdRoJn
 NjT08aDLKID9SrvM0NrhM4DT/v930nyLj4n2MD+V8TiQH/RIz9LY2UPQyWTP/vCXovA8
 daYpNbm43dfjO889NkipdBxwLCuArYY/TEe5AeG/7rP+MZ/yzkE2EjDnOi2z0j9M/z0Q
 TOTzj4A7uC7z2Jwe/MizIhai1RlY0UEv84jDiTPZLr0+r9rs8qcWa9eIUkOuBxNynLqV
 6VFZeDG4OgpuGgZenhy+eP5e6N0D76ouMO3rkjEUMuIRpUn7kODa5JL2CqmEKbLC+pAO
 oHqg==
X-Gm-Message-State: AOJu0Yxn5/XrF/XhVtphlje3LWXa+k5N8dbNVGo97lYhDuRfzlmVDv9J
 +FQP3UQIe1BPoQ1IqOcOoz0q65avBAQ64QEG1QQEAw7L3JohbdBcQCZfeIWAP0ccrOQvFL84xXk
 Fq1pD
X-Gm-Gg: AeBDievseEj+5N7o10gvYjK/nGyIqssuX4QOXDDWjzRL3iJKvC6q+7etiR4i5ENObGk
 23z+0c0BE1tT1eTatjkrU7B139KWL2LwnA4ORvHipcd64da+y0ReNG2r7Qs8eKTivM9fxvRtVpO
 lDbEN17D92kAaDNqNHfXBLEP095TmwALGUZE+FslumZOCEe7+eoYhel5XTgo2uTVEm38jIhwiaP
 MZAcu6Xq9eLqr4e/jJDstRasdrzqK20G5MMXhU8s2kpy0b6Kuzq50wu3fWV0BbLBT6bklDx4Ioa
 QBO/gKFSODNwC1CFhm6VBXHKGSr9kuOKtFvGjS5IQdpm5NU7ddwUu1QncRkTqqPjHBg1ppEfdyi
 iTG0Px1lSKcdtw11PK+qXf9nfH1H0Ieg2ptq0h6+nWC/oZkhNOG3RyOfyxwPjgslMcOuqbIm3F+
 OvGccOFNZ6FojBVaadEGZ0z/8h7m/mPE9Te7YXPpGBCjc=
X-Received: by 2002:a05:6870:2045:b0:417:6237:cf7e with SMTP id
 586e51a60fabf-42abf22a080mr6221865fac.8.1776615097449; 
 Sun, 19 Apr 2026 09:11:37 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v25 23/24] net/pcap: add EOF notification via link status
 change
Date: Sun, 19 Apr 2026 09:09:56 -0700
Message-ID: <20260419161059.205954-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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
index 741b987977..4f1ab1b113 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -70,6 +70,8 @@ New Features
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
   * Added support for Link State interrupt in ``iface`` mode.
+  * Added ``eof`` devarg to use link state to signal end of receive
+    file input.
 
 
 
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

