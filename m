Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC6AECD6F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:23:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5E5D40B9A;
	Wed, 11 Feb 2026 23:22:13 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 662D840B95
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:22:10 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43591b55727so5215612f8f.3
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848530;
 x=1771453330; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpCB4EJ21FX59S3H9DwFgauAnL7vGV6/XC1t+l+0eOc=;
 b=tON3mW7jJIs0GTvVN0T5pkB5BFX4SIkt/blvZ5pzyPl/1I8WJ09fObr7JM4m2kiQDQ
 8SVyvd8ExOUnhmrInbN29nIGawQ6mGvi4jZPsZejopduqS9qgQrIOBaaj+1uZF8BcmIq
 wajSmYOHlMU1FBSJNjTaqTqiZNU9y2JnhMcnAXcIf70mQ8pL0zegwaC4vJynkYPQY79v
 kTrryMv95W1TxlOBQ95cVFpAxTSyoeQQtYRLz4AaRdAIoJp3DUYeYIdrW8KqOUKVTKcc
 BnZ1o0X+Db5wRcOSd4KUjysyj1ZJf8wlyD/U2jHr0azWwhl7dwc01Z1FUqsFwe6LHAAI
 F70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848530; x=1771453330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rpCB4EJ21FX59S3H9DwFgauAnL7vGV6/XC1t+l+0eOc=;
 b=Ey2ZgL0UJcTd7Qy7Rtsxh1P6VOeEHh7nK4L0jWVi1iQvvR6lBUX7kMzrlNCSbIcjV4
 CuvJLCwxFl6IELlt6Gh0sBXl5LYmpLaCS4diOY/IrhyM5Wd+QSXGOTJKApaL9o/qwaMN
 fhuWmAbvOzDctQn7a7vFADr9wrMh+ZsUZAiXLPAsLkIfNGwXbitA8OhuiAi22VXdhLBf
 vxUnVA5p3cez57dRf/Se4Z5vTsYMnUj5uMMYQ8r/xdEflEpnRaQ5N6OoRtZQUNa2A0BB
 juU+ppEN9aLuSBYpGjyX+IXITsbu4CB3cNBlEEPTzutB4JJdSauVWsLv8FTV459SDAjS
 z7xw==
X-Gm-Message-State: AOJu0YzhIgjbiY1Qjf16ECqsffGvknX0zh8GuJrwJrquV6kX1GPG4rdg
 mT8A3eNpHHcMmrpX0IWM+9FN+WC30m24tp4gC1vgYoY18Ndag4JMKm9o4HdNcfduJDgX2jrqxfS
 GGtqq
X-Gm-Gg: AZuq6aJ1Nw+FQk/9qfFIkKgKCbIuVhZ8pRft3oEVmVd/gtIfABRejIxCRJ9w1ERI69q
 /9YZk8bSnPnDRif90wTbrm4XpJuMuulnVjf/CgUdpSSdwztwVowlte8dEtJDZUwa9Rj4qnbHiGc
 XCSD27JORWXqluuLCO7ZHVnsSuB12WOZGUFHOv0v0oHJxscDhBY/B3Mpe6e0FEv7NCGniArchLN
 hHrd/c5lpRC9Qqzb/4/gBlBfSfkvfQhMrSRwV9wuNyH6pTBB7StYGVCWFqlGVywWclqxiFRf3SP
 dJ8UHsXRYV5XSQiT1J9WbJPYHkkx9nDqvjE9S7JAXR5BQSiE5rwnEpkDp+cL5kDApN6pGrlYa7+
 MBpwnvYU9/CuwKVMmPC0s6D8Pv/15pC9OP8yHhSyn+SBgjMUm8kD529K50qZ/Z8fdK+yei5N/gS
 /03eXLAnS/ng75siksHq4nRVLZ3LiJzOs1YBtsOx3kunXcuwPnYUlsCoveH+8KwL0OE/+EdDAv
X-Received: by 2002:a05:6000:2486:b0:430:ff0c:3612 with SMTP id
 ffacd0b85a97d-4378ac7e294mr1457013f8f.41.1770848529962; 
 Wed, 11 Feb 2026 14:22:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:22:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 16/18] net/pcap: add link status change support for iface
 mode
Date: Wed, 11 Feb 2026 13:09:49 -0800
Message-ID: <20260211222130.338797-17-stephen@networkplumber.org>
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

Add LSC interrupt support for pass-through (iface=) mode so
applications can receive link state change notifications via
the standard ethdev callback mechanism.

Uses alarm-based polling to periodically check the underlying
interface state via osdep_iface_link_get(). The LSC flag is
advertised only for iface mode devices, and polling is gated
on the application enabling intr_conf.lsc in port configuration.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini      |  1 +
 doc/guides/rel_notes/release_26_03.rst |  1 +
 drivers/net/pcap/pcap_ethdev.c         | 44 +++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 814bc2119f..084fefbbbb 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Link status          = Y
+Link status event    = Y
 Queue start/stop     = Y
 Scattered Rx         = Y
 Timestamp offload    = Y
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 4d9303ca3a..e614d8a8ac 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -89,6 +89,7 @@ New Features
   * Receive timestamp offload is only done if offload flag set.
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
+  * Added support for Link State interrupt in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 6863b78b49..afb68998e7 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -17,6 +17,7 @@
 #include <net/if.h>
 #include <pcap.h>
 
+#include <rte_alarm.h>
 #include <rte_cycles.h>
 #include <rte_ring.h>
 #include <rte_ethdev.h>
@@ -48,6 +49,8 @@
 /* This is defined in libpcap but not exposed in headers */
 #define ETH_PCAP_MAXIMUM_SNAPLEN      262144
 
+#define ETH_PCAP_LSC_POLL_INTERVAL_US (1000 * 1000) /* 1 second */
+
 #define ETH_PCAP_ARG_MAXLEN	64
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
@@ -113,6 +116,7 @@ struct pmd_internals {
 	bool infinite_rx;
 	bool vlan_strip;
 	bool timestamp_offloading;
+	bool lsc_active;
 };
 
 struct pmd_process_private {
@@ -159,9 +163,10 @@ static const char *valid_arguments[] = {
 
 RTE_LOG_REGISTER_DEFAULT(eth_pcap_logtype, NOTICE);
 
-/* Forward declaration */
+/* Forward declarations */
 static inline int set_iface_direction(const char *iface, pcap_t *pcap,
 				      pcap_direction_t direction);
+static int eth_link_update(struct rte_eth_dev *dev, int wait_to_complete);
 
 static struct queue_missed_stat*
 queue_missed_stat_update(struct rte_eth_dev *dev, unsigned int qid)
@@ -783,6 +788,28 @@ count_packets_in_pcap(pcap_t **pcap, struct pcap_rx_queue *pcap_q)
 	return pcap_pkt_count;
 }
 
+/*
+ * Perodic alarm to poll link state.
+ * Enabled when link state interrupt is enabled in single_iface mode.
+ */
+static void
+eth_pcap_lsc_alarm(void *arg)
+{
+	struct rte_eth_dev *dev = arg;
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct rte_eth_link old_link, new_link;
+
+	rte_eth_linkstatus_get(dev, &old_link);
+	eth_link_update(dev, 0);
+	rte_eth_linkstatus_get(dev, &new_link);
+
+	if (old_link.link_status != new_link.link_status)
+		rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+
+	if (internals->lsc_active)
+		rte_eal_alarm_set(ETH_PCAP_LSC_POLL_INTERVAL_US, eth_pcap_lsc_alarm, dev);
+}
+
 static int
 eth_dev_start(struct rte_eth_dev *dev)
 {
@@ -850,6 +877,12 @@ eth_dev_start(struct rte_eth_dev *dev)
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 
+	/* Start LSC polling for iface mode if application requested it */
+	if (internals->single_iface && dev->data->dev_conf.intr_conf.lsc) {
+		internals->lsc_active = true;
+		rte_eal_alarm_set(ETH_PCAP_LSC_POLL_INTERVAL_US,eth_pcap_lsc_alarm, dev);
+	}
+
 	return 0;
 }
 
@@ -867,6 +900,12 @@ eth_dev_stop(struct rte_eth_dev *dev)
 
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
+		/* Cancel LSC polling before closing pcap handles */
+		if (internals->lsc_active) {
+			internals->lsc_active = false;
+			rte_eal_alarm_cancel(eth_pcap_lsc_alarm, dev);
+		}
+
 		queue_missed_stat_on_stop_update(dev, 0);
 		if (pp->tx_pcap[0] != NULL) {
 			pcap_close(pp->tx_pcap[0]);
@@ -1704,6 +1743,9 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 		internals->if_index =
 			osdep_iface_index_get(rx_queues->queue[0].name);
 
+		/* Enable LSC interrupt support for iface mode */
+		eth_dev->data->dev_flags |= RTE_ETH_DEV_INTR_LSC;
+
 		/* phy_mac arg is applied only if "iface" devarg is provided */
 		if (rx_queues->phy_mac) {
 			if (eth_pcap_update_mac(rx_queues->queue[0].name,
-- 
2.51.0

