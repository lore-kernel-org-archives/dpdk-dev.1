Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58817EEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:05:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B15240B94;
	Fri, 13 Feb 2026 18:04:12 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 042B640666
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:04:11 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4806e0f6b69so9282255e9.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002250;
 x=1771607050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJSiAN0aDlDWd8i4sYfSsuMcFFuJ6wwfBMvQdQD9P/8=;
 b=IJ1zz6VdDcdMfTEJwbo1noWh9cTkRcSxt/ntY7CCCEt4A0KfTVzVzFmBq8e4cITBAm
 /DsgTrjZ61xpGJ8kGxS6m8lirCEKO63taYG46i9p5q5yi6lOQmG+weDRZlMeqoJZnjTJ
 blchqTpdqRcNlvUS6Kfr7zxNJAd2LisSRks9M5SyknPAiRYwFAnaHOH+QBlJE9MpaTnP
 L6bd6qOCCNvTk91PB8fzxnVhFS6U7uQS7uwafYI5mi92kaqhjOVmNnOf2hJk6IVpy2+P
 XbgShsymHAiWN9xMAbRiufmTyXyDsw7P8txfNFdg6DtChdZlKXPTl7HRica+m7oanSYr
 k/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002250; x=1771607050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJSiAN0aDlDWd8i4sYfSsuMcFFuJ6wwfBMvQdQD9P/8=;
 b=OpZjIS7XsR8N0rK5SuJF+FHnhVjHmpxL0ajZWVQdQjQzcYLhc43c9M56Pvx27av2vf
 kYLsuPHK+YEA5Yc/v5ARhs1Yr4fYb5ndZ3Wa3JIr/pkvzqD0d2qLYgBobxIxNroZXKVq
 0cnzsd4xKLKdNuIJ8FFofWriIArYvxfc1O3Y7YTOyeKVyW3brRyngbUrDFa3+8JGbHfl
 QWlHRMV0wo58skfTt8T5jA8qv+hu7MDMoN1rvNi3k+0y4mDnMurMCFVkSAYxFZyzRJ0q
 bv+c0wDU2wuFmY3iQit3B+apoSRdqyb58CFViFLNtZ38JAyR9NsLLOnAWDPYHSDDlSZo
 t/rQ==
X-Gm-Message-State: AOJu0YwUfPeBRm+jNV+2Md+2JpnmhK81Zk4N+baqgo1Dtn6Z7xwLiEa5
 XseT6R3V6Rb0UG+HsM/mnlhcaz72m1oJNYTaziT0Cnnm8oSw1+TsJ/FjjASp3cldLgOliO9qD8n
 2fXLA
X-Gm-Gg: AZuq6aIDAGx1FwKRNz4EW0NZXDqjUMYlawDVN67B8dgKjlbjETTeWg3vHfBeFZgmJxF
 CThjqxeZewMzOkCgxoV8zRxUlhLBpiqY7+GjcUhlpGEY8WAalnAD13V65G1iYWFv/5vdDVTarnR
 6smLcjcwyiQeLYHe63C2RizKtyKxpBAYkss+kjaKpMkK4CGRervAuDcHPEYkvoWrMwBq3kWsNWq
 CNiSE2C4f0G6C+d/ZZKY0wogVhnOKyxLVcbNJMxmztIkYLdiPkbgYAWeSfRvtp+YonBUgou6zSN
 +UbNoDPvdAInYv7pM5VWJQqrYskGoWGvdk6Jz10Lcf6pcqiVLRLTlxpbDzbnoUiUUB/yAx2dfw/
 ntYqK3wNUwlmDWVUoHXh2pnfNPrRZfVcMJWkusSxyXzIEoyXPhrahflt+a0j2b1psxODr8gqiuu
 IfZLCjDqetVC8NDd+fYFeV2xGsXVgvHLFyW0gyGkyN01TeMNtkTn1xMq+CELeb8qDekX4JlaLu
X-Received: by 2002:a05:600c:4687:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-48371061414mr54525795e9.15.1771002250419; 
 Fri, 13 Feb 2026 09:04:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:04:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 17/18] net/pcap: add EOF notification via link status
 change
Date: Fri, 13 Feb 2026 09:01:40 -0800
Message-ID: <20260213170333.40089-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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
index 1db54a005a..7959b97c10 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -95,6 +95,8 @@ New Features
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
   * Added support for Link State interrupt in ``iface`` mode.
+  * Added ``eof`` devarg to use link state to signal end of receive
+    file input.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 00f6e4e33d..c995a3bf25 100644
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
+	bool eof_signaled;
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
@@ -335,6 +358,19 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
 
@@ -875,6 +911,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 
+	internals->eof_signaled = false;
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 
 	/* Start LSC polling for iface mode if application requested it */
@@ -937,6 +974,10 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	}
 
 status_down:
+	/* Cancel any pending EOF alarm */
+	if (internals->eof_signaled)
+		rte_eal_alarm_cancel(eth_pcap_eof_alarm, dev);
+
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -1174,9 +1215,13 @@ eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
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
@@ -1756,8 +1801,13 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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
@@ -1944,6 +1994,24 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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
@@ -2083,4 +2151,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_EOF_ARG "=<0|1> "
 	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.51.0

