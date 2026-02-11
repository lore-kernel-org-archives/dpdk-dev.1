Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B75DECD6F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:23:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2376940DDA;
	Wed, 11 Feb 2026 23:22:15 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 5FDBB40B9A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:22:12 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43626796202so2152240f8f.3
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848532;
 x=1771453332; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79rNXSJRBaKG4NvxMGmEJubRGDI4ioJT+Zb2b63hl4o=;
 b=dxblbEVCBFJRWHHdgi7cl5jUncMGzMH1tSZZEVeKEb8Rj5mL6q5ykCEJlZPvRkuLuW
 ECW9BNi8xbxpnX4nRDDmiuWH5UBf4pFvpfLYuMGeIlbQY14PmDYAoPTo+IEI9LeMGcK1
 RQkVCuKj7F5RCVIVM0/ExF7fW6J0vWjkC6D/gyhvSCqEmQO/WFqeyriK9PXDAUXqWCxx
 g4t/VRyx6S5Yk36rx5LgsZa5eI6Q3iQcNUJfDyg2US0/lV/q5dN2CzcYCLsmjJMuOyNP
 nZ71rT0/dG/g/qK/fPwAmIqjvjg2+GA/p7SKRst3fP+e9F2Uxw1IcVGNMBDMB/58SScG
 WIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848532; x=1771453332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79rNXSJRBaKG4NvxMGmEJubRGDI4ioJT+Zb2b63hl4o=;
 b=Crc3OiNEP00MTY6ky5UBYLJ2nhTJWN6ErAJe5aAEifu8r9kZzk7prKbkUqKtfaLDi7
 pXwgaQudcRzvgXmrCA+i5K+muzVPH/fhvExiUJrJHT5zOdw0cK1+p0y1CZ/xXC4eXN8N
 CN41OO8kGytvJ3UKhAxrkjdkUVOAJLHMYWQe+S31sJ7OtQafmkGDj1BA/am+a5us86Sa
 3SDfN1VleyLb0KXmTebJTL5XfnRYZlI1dbLJBOFWIds8rLprRHLFIBI2QwFnv73ok936
 fJEKunwIS8JDS+VQcOpPkMIaK/d3lTIvm/ix94htVZVZtxgaaFiWOxhkzFasV66k9o1k
 WluQ==
X-Gm-Message-State: AOJu0Yw4FSOTLuGafRNfUSGrXr+jFvPf7NVDhQA5IhsXDeyV0SzLlYey
 oxu1lSc3KYs/BsXtvSSBUWH6+cAcX+Mdv56vD6b1rgXLEuAsIHm+7D+iKOty7huz/OkceXupnUy
 1fp4F
X-Gm-Gg: AZuq6aKHMAk5C8yc2Qd6jtQj0Rbqo+a47VsFIP527FwEWuqOkdlk1+TuOX3nsKwAK1B
 fyR17VMLRAkXhlniTzrKZ6QdInPOFAzeyxUfELHcZx7HnbKFQ9UzK2pSFm2DxpFdk/oHr7+CC/e
 QGx/PVQ9+Uh5gW7u9uwWQVxmT1KD5+4YR84d+G54MovMtGPx9VH0klplIucIXktCz9EKwOPKRt1
 GIv5ZjqUu82dZ+h+xkQNOxhs5xNEQseMabZj5gcELKfOO+1kFea6urM0YxdxqBMgmw8u96oIuXT
 lnS0INkMZQKvQnMPGunQrLEiuC5GXYEoNInI7LEoLBL2K+aHLXiNaKmZWo/DO+b3n6ij60z/y8c
 S7SBfjOTtr7vAXsMVoJ3fJ8tLTYl2tLTltka98rQHLa9VHMjOwOoEoQQvKP00XcvSNLMUrPYfAA
 N5diG37h1+ArdKgpN4W4XwYVSGK1yzPNZRtYHdqYSstUlENeN6yeeIRfI7Gz6joA==
X-Received: by 2002:a5d:5442:0:b0:437:8fc0:87e1 with SMTP id
 ffacd0b85a97d-4378fc09865mr16132f8f.62.1770848531821; 
 Wed, 11 Feb 2026 14:22:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:22:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 17/18] net/pcap: add EOF notification via link status
 change
Date: Wed, 11 Feb 2026 13:09:50 -0800
Message-ID: <20260211222130.338797-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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
index e614d8a8ac..acd6450a59 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -90,6 +90,8 @@ New Features
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
   * Added support for Link State interrupt in ``iface`` mode.
+  * Added ``eof`` devarg to use link state to signal end of receive
+    file input.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index afb68998e7..8b091af6ee 100644
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
+					dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
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
@@ -936,6 +973,10 @@ eth_dev_stop(struct rte_eth_dev *dev)
 	}
 
 status_down:
+	/* Cancel any pending EOF alarm */
+	if (internals->eof_signaled)
+		rte_eal_alarm_cancel(eth_pcap_eof_alarm, dev);
+
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -1173,9 +1214,13 @@ eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
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
@@ -1755,8 +1800,13 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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
@@ -1943,6 +1993,24 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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
@@ -2082,4 +2150,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_EOF_ARG "=<0|1> "
 	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.51.0

